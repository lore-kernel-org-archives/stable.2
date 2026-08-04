Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D033376BC1
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840436; cv=none; b=FFWv7yFc8dUeQeLz3bLEp2JvqylGk/jZ1GIyMr60qR2iRm2vG5HYXVeVjjKE7U0Zq2cfz/QfOCO8lQGaBaVuELnCyxfZTjSvA9R4YYs19g8Wi5Bf4yJKb/Pc7jK4+OYvh+ZijcjuAHRugG5txSB2VouulYHosZm6piqV6kuXYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840436; c=relaxed/simple;
	bh=UqqPSTNTjbWq2wVKqrrWr2auX5+XScnWMaJfGFTbSDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYVDD6yE6RIZ5wRlJ/vynas0YiLgz8v2CHb1wgux2/HDHsd5Ei2VU48eEDQ3U4vLk/j4FXP6h9UHU1uOR9F9prv85nwh1dP/DWL3CHKAYqm/PV5ihpGUDr8VwrGcYHyjvw+V1VPGl5wlrevuzooymjpXm5FdmGEJtutBztfXeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJcdc75O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJcdc75O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C8A1F000E9;
	Tue,  4 Aug 2026 10:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840434;
	bh=vOds2zItoQS0ehfXOIaAdjTc7h1B29y2nKyHgGv1LLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJcdc75OKDLWTY+XPtyDALPowyjwwVdqKKsJT+ER622igmE+s7ItXqnOxLHVMtS/o
	 +dmeHBvQ1hT0Em55nQxv5jGVXBIs6aZUQR3CO1XIS1iH7hRUDLiQnUeOv1XsRLisJb
	 Hq7eFqiiAUxAhKE0xYknhzu6rirZSkwja8EtbB9T/6ZGZHQBNvnDvhc7NzsJxPdcUb
	 S0gJQtVSBZgBxxRhbwxcnvSYFOrLfuzKWewZfsmxvWp0KZoG0Z52v4XeTzmDAEyySZ
	 XgQ+L45R4lr2gCfzsktNIF4oakwDuuA34YhssavjjdsHWQFUJk1jwKVVM8plmISMj8
	 ITiVG2cjssQiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackson Lee <jackson.lee@chipsnmedia.com>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Brandon Brnich <b-brnich@ti.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] media: chips-media: wave5: Support CBP profile
Date: Tue,  4 Aug 2026 06:47:12 -0400
Message-ID: <20260804104712.2825343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072917-aside-unpaved-8076@gregkh>
References: <2026072917-aside-unpaved-8076@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jackson Lee <jackson.lee@chipsnmedia.com>

[ Upstream commit f8505f9d6b223a26854003bfdba1a0772457886d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/chips-media/wave5/wave5-hw.c      | 3 +++
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 ++++-
 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h  | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index d94cf84c3ee5f..fd3c3c2168158 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1762,6 +1762,9 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 			(p_param->skip_intra_trans << 25) |
 			(p_param->strong_intra_smooth_enable << 27) |
 			(p_param->en_still_picture << 30);
+	else if (inst->std == W_AVC_ENC)
+		reg_val |= (p_param->constraint_set1_flag << 29);
+
 	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SPS_PARAM, reg_val);
 
 	reg_val = (p_param->lossless_enable) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index 50cba21fdcdce..03687a1e23c71 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -915,6 +915,8 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 		case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
 			inst->enc_param.profile = H264_PROFILE_BP;
 			inst->bit_depth = 8;
+			if (ctrl->val == V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE)
+				inst->enc_param.constraint_set1_flag = 1;
 			break;
 		case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
 			inst->enc_param.profile = H264_PROFILE_MP;
@@ -1190,6 +1192,7 @@ static int wave5_set_enc_openparam(struct enc_open_param *open_param,
 			open_param->wave_param.intra_period = input.avc_idr_period;
 		}
 	} else {
+		open_param->wave_param.constraint_set1_flag = input.constraint_set1_flag;
 		open_param->wave_param.avc_idr_period = input.avc_idr_period;
 	}
 	open_param->wave_param.entropy_coding_mode = input.entropy_coding_mode;
@@ -1662,7 +1665,7 @@ static int wave5_vpu_open_enc(struct file *filp)
 			  -6, 6, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM,
-			  0, 1, 1, 1);
+			  0, 1, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION,
 			  0, 1, 1, 0);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index bc101397204da..8112d4899ce46 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -570,6 +570,7 @@ struct enc_wave_param {
 	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
 	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
 	u32 forced_idr_header_enable: 1; /* enable header encoding before IDR frame */
+	u32 constraint_set1_flag: 1; /* enable CBP */
 };
 
 struct enc_open_param {
-- 
2.53.0

