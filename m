Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482148424D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329561; cv=none; b=kVBXOSbLaio9NB0QB7FwswigZ2xgpneT0l2DXEQHukfqRt0j6PWfD7wcmWP/hOZBpNiPnNac7IkObjL3fjgcI6S1ZL9Lw7H0RgRTT9OXoNwH5j5Xy3VKzj3bkpI4BGwAt7ez7ZNcwcpG4nHLodHLdxHt81pZpUW9aAE3xgP4fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329561; c=relaxed/simple;
	bh=xIz7bEI6X8yeEa8h0XgTLoG9V+radaZVU/AZRQQS8w0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qlycrTZz7X74naCZDJtUwxrFSnoZRa3vQHR4TMAtWAxF45Lm0U20+kqjQ/74eNunRney7PZASiUcoDfu/0HHcMT4m+len7res43tpCI/MxQcmiBtJJkqA1BEz6B/GHBJ8/7lttMZLyW5XwB3JzGvCQ4Bk/nOew7ERgFf7rvz2zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gGuYJKB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGuYJKB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D311F000E9;
	Wed, 29 Jul 2026 12:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785329559;
	bh=zniarFLU0ltdcp4vYD7/zyOmeIxKzr8GoharM2pOlXc=;
	h=Subject:To:Cc:From:Date;
	b=gGuYJKB3Rtnah2BwResaD4WRNNNMsDRbaT9DsERHT7yLASFNg7IEIoXNilE1YVzVg
	 p7pJd6MVQFx3T4YLznQnza9oyRCS3mjRWrwEvXgEdRfo6FLoe+9F3riThwaWdFTCRD
	 o9l9pAyPB2rJCoW/jHtr4dPNf5ECYmAVY9UXOGXc=
Subject: FAILED: patch "[PATCH] media: chips-media: wave5: Support CBP profile" failed to apply to 6.18-stable tree
To: jackson.lee@chipsnmedia.com,b-brnich@ti.com,hverkuil+cisco@kernel.org,nas.chung@chipsnmedia.com,nicolas.dufresne@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 14:52:17 +0200
Message-ID: <2026072917-aside-unpaved-8076@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f8505f9d6b223a26854003bfdba1a0772457886d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072917-aside-unpaved-8076@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8505f9d6b223a26854003bfdba1a0772457886d Mon Sep 17 00:00:00 2001
From: Jackson Lee <jackson.lee@chipsnmedia.com>
Date: Tue, 24 Mar 2026 14:03:59 +0900
Subject: [PATCH] media: chips-media: wave5: Support CBP profile

Constrained Baseline Profile (CBP) and Baseline Profile (BP) have been
treated as the same.
Introduce the ability to differentiate between the two.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
Tested-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index c516d125f553..2392bce8d840 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1763,6 +1763,9 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 			(p_param->skip_intra_trans << 25) |
 			(p_param->strong_intra_smooth_enable << 27) |
 			(p_param->en_still_picture << 30);
+	else if (inst->std == W_AVC_ENC)
+		reg_val |= (p_param->constraint_set1_flag << 29);
+
 	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SPS_PARAM, reg_val);
 
 	reg_val = (p_param->lossless_enable) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index e806973305ce..e6ac76635178 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -918,6 +918,8 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 		case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
 			inst->enc_param.profile = H264_PROFILE_BP;
 			inst->bit_depth = 8;
+			if (ctrl->val == V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE)
+				inst->enc_param.constraint_set1_flag = 1;
 			break;
 		case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
 			inst->enc_param.profile = H264_PROFILE_MP;
@@ -1194,6 +1196,7 @@ static int wave5_set_enc_openparam(struct enc_open_param *open_param,
 			open_param->wave_param.intra_period = input.avc_idr_period;
 		}
 	} else {
+		open_param->wave_param.constraint_set1_flag = input.constraint_set1_flag;
 		open_param->wave_param.avc_idr_period = input.avc_idr_period;
 	}
 	open_param->wave_param.entropy_coding_mode = input.entropy_coding_mode;
@@ -1666,7 +1669,7 @@ static int wave5_vpu_open_enc(struct file *filp)
 			  -6, 6, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM,
-			  0, 1, 1, 1);
+			  0, 1, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION,
 			  0, 1, 1, 0);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index dc31689e0d27..7b08fef58217 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -570,6 +570,7 @@ struct enc_wave_param {
 	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
 	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
 	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR frame */
+	u32 constraint_set1_flag: 1; /* enable CBP */
 	u32 bg_detection: 1; /* enable background detection */
 };
 

