import os

from trainer import Trainer, TrainerArgs

from TTS.config.shared_configs import BaseDatasetConfig
from TTS.tts.configs.glow_tts_config import GlowTTSConfig
from TTS.tts.datasets import load_tts_samples
from TTS.tts.models.glow_tts import GlowTTS
from TTS.tts.utils.text.tokenizer import TTSTokenizer
from TTS.utils.audio import AudioProcessor


def formatter(root_path, manifest_file, **kwargs):
    """Assumes each line as <filename>|<transcription>"""
    txt_file = os.path.join(root_path, manifest_file)
    items = []

    with open(txt_file, "r", encoding="utf-8") as ttf:
        for line in ttf:
            cols = line.split("|")
            wav_file = os.path.join(root_path, "wavs", f"{cols[0]}.wav")
            text = cols[1]
            speaker_name = cols[0].split("_")[0]
            if speaker_name not in ["F2", "M1", "F1", "M2", "F3"]:
                print(f"Achtung! {line} has speaker_name {speaker_name}")
            items.append(
                {
                    "text": text,
                    "audio_file": wav_file,
                    "speaker_name": speaker_name,
                    "root_path": root_path,
                }
            )
    return items


def main():
    output_path = os.path.dirname(os.path.abspath(__file__))
    dataset_config = BaseDatasetConfig(
        # formatter=formatter,
        meta_file_train="metadata.txt",
        language="en-us",
        path="/raid/kirill_kirillov/coqui-tts-kaz",
    )

    config = GlowTTSConfig(
        batch_size=32,
        eval_batch_size=32,
        num_loader_workers=4,
        num_eval_loader_workers=4,
        run_eval=True,
        test_delay_epochs=-1,
        epochs=20,
        text_cleaner="phoneme_cleaners",
        use_phonemes=True,
        phoneme_language="en",
        phoneme_cache_path=os.path.join(output_path, "phoneme_cache"),
        print_step=50,
        print_eval=False,
        mixed_precision=False,
        output_path=output_path,
        datasets=[dataset_config],
        lr_scheduler=None,
    )

    train_samples, eval_samples = load_tts_samples(
        dataset_config,
        eval_split=True,
        eval_split_max_size=config.eval_split_max_size,
        eval_split_size=config.eval_split_size,
        formatter=formatter,
    )

    ap = AudioProcessor.init_from_config(config)
    tokenizer, config = TTSTokenizer.init_from_config(config)

    model = GlowTTS(config, ap, tokenizer, speaker_manager=None)

    trainer = Trainer(
        TrainerArgs(),
        config,
        output_path,
        model=model,
        train_samples=train_samples,
        eval_samples=eval_samples,
    )

    trainer.fit()


if __name__ == "__main__":
    main()
