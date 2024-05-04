#!/bin/sh


CUDA_VISIBLE_DEVICES="14" python fine-tune.py \
    --restore_path glow-tts-finetune-April-27-2024_06+15AM-dbf1a08a/best_model.pth \
    --coqpit.run_name "glow-tts-finetune" \
    --coqpit.lr 0.00005