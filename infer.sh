#!/bin/sh


# tts --text "kel balalar okylyk" \
#     --model_path glow-tts-finetune-April-27-2024_03+57AM-dbf1a08a/best_model_334215.pth \
#     --config_path glow-tts-finetune-April-27-2024_03+57AM-dbf1a08a/config.json \
#     --out_path output-e-5.wav


# MODEL_PATH=/home/kirill_kirillov/.local/share/tts/tts_models--en--ljspeech--glow-tts

# tts --text "Hello, people! I am a text to speech model." \
#     --model_path $MODEL_PATH/model_file.pth \
#     --config_path $MODEL_PATH/config.json \
#     --out_path output-base.wav


# tts --text "kel balalar okylyk" \
#     --model_path glow-tts-April-27-2024_06+16AM-dbf1a08a/best_model.pth \
#     --config_path glow-tts-April-27-2024_06+16AM-dbf1a08a/config.json \
#     --out_path output-trained.wav

# tts --text "kel balalar okylyk" \
#     --model_path glow-tts-finetune-April-27-2024_01+15PM-dbf1a08a/best_model_380570.pth \
#     --config_path glow-tts-finetune-April-27-2024_01+15PM-dbf1a08a/config.json \
#     --out_path output-tuned-13epochs.wav

tts --text "kel balalar okylyk" \
    --model_path glow-tts-finetune-April-27-2024_09+00PM-dbf1a08a/best_model_435353.pth \
    --config_path glow-tts-finetune-April-27-2024_09+00PM-dbf1a08a/config.json \
    --vocoder_name vocoder_models/universal/libri-tts/wavegrad \
    --out_path outputs/output-tuned-435353-wavegrad.wav