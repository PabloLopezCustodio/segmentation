#!/bin/bash
	
set -x
set -e

export PYTHONUNBUFFERED="True"
export CUDA_VISIBLE_DEVICES=$1

outdir="data/checkpoints"
cachedir="/root/.cache/torch/hub/checkpoints"

source /opt/ros/noetic/setup.bash

if [ ! -d "$cachedir" ]
then 
	mkdir -p $cachedir
fi

if [ ! -f $cachedir/resnet34-333f7ec4.pth ]
then 
	cp $outdir/resnet34-333f7ec4.pth $cachedir/resnet34-333f7ec4.pth
fi

./ros/test_images_segmentation.py --gpu $1 \
  --network seg_resnet34_8s_embedding \
  --pretrained $outdir/seg_resnet34_8s_embedding_cosine_rgbd_add_sampling_epoch_16.checkpoint.pth \
  --pretrained_crop $outdir/seg_resnet34_8s_embedding_cosine_rgbd_add_crop_sampling_epoch_16.checkpoint.pth \
  --cfg experiments/cfgs/seg_resnet34_8s_embedding_cosine_rgbd_add_tabletop.yml \
