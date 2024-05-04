#!/bin/bash

declare -a vocoders=(
    "vocoder_models/en/blizzard2013/hifigan_v2" # 1 good
    "vocoder_models/en/vctk/hifigan_v2" # 2 best
    "vocoder_models/nl/mai/parallel-wavegan" # 3 good
    "vocoder_models/uk/mai/multiband-melgan" # 4 good
    "vocoder_models/tr/common-voice/hifigan" # 5 good
    "vocoder_models/be/common-voice/hifigan" # 6 good
)

declare -a texts=(
    "eki jarym apta ishinde mamandar juz nysandy tekserdi" # 1 - F1_10005
    "joba avtory - biznes-jattyktyrushy, almatylyk viktor maltchikov" # 2 - F2_10000
    "mundaida jastar men eriktiler unemi komektesuge azir" # 3 - F3_10008
    "azgana jurip, karsy kabaktan asty" # 4 - M1_10009
    "mine, ainadai etip asfalt salyp berdi" # 5 - M2_10
)

model_path="glow-tts-finetune-April-27-2024_09+00PM-dbf1a08a/best_model_435353.pth"
config_path="glow-tts-finetune-April-27-2024_09+00PM-dbf1a08a/config.json"

for j in ${!texts[@]}; do
    text=${texts[$j]}
    text_id=$(($j + 1))

    for i in ${!vocoders[@]}; do
        vocoder=${vocoders[$i]}
        vocoder_id=$((i + 1))

        echo "Processing text $text_id with vocoder $vocoder_id: $vocoder"

        tts --text "$text" \
            --model_path $model_path \
            --config_path $config_path \
            --vocoder_name $vocoder \
            --out_path "outputs/text-$text_id-vocoder-$vocoder_id.wav"
    done
done
