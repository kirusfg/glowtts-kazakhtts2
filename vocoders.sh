#!/bin/bash

# Define the base path for vocoder models
declare -a vocoders=(
    "vocoder_models/universal/libri-tts/wavegrad"
    "vocoder_models/universal/libri-tts/fullband-melgan"
    "vocoder_models/en/ek1/wavegrad"
    "vocoder_models/en/ljspeech/multiband-melgan"
    "vocoder_models/en/ljspeech/hifigan_v2"
    "vocoder_models/en/ljspeech/univnet"
    "vocoder_models/en/blizzard2013/hifigan_v2"
    "vocoder_models/en/vctk/hifigan_v2"
    "vocoder_models/en/sam/hifigan_v2"
    "vocoder_models/nl/mai/parallel-wavegan"
    "vocoder_models/de/thorsten/wavegrad"
    "vocoder_models/de/thorsten/fullband-melgan"
    "vocoder_models/de/thorsten/hifigan_v1"
    "vocoder_models/ja/kokoro/hifigan_v1"
    "vocoder_models/uk/mai/multiband-melgan"
    "vocoder_models/tr/common-voice/hifigan"
    "vocoder_models/be/common-voice/hifigan"
)

# Path to the TTS model and configuration
model_path="glow-tts-finetune-April-27-2024_09+00PM-dbf1a08a/best_model_435353.pth"
config_path="glow-tts-finetune-April-27-2024_09+00PM-dbf1a08a/config.json"

# Loop over each vocoder model
for i in ${!vocoders[@]}; do
    vocoder=${vocoders[$i]}
    id=$((i + 1))  # Adjust index to start from 1

    echo "Processing with vocoder $id: $vocoder"

    # Execute the TTS command
    tts --text "kel balalar okylyk" \
        --model_path $model_path \
        --config_path $config_path \
        --vocoder_name $vocoder \
        --out_path outputs/output-tuned-435353-$id.wav
done