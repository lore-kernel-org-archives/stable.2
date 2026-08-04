Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316F37F315
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805593; cv=none; b=jtcRwZQa6tIkY9UYusqDu/XLn64VUfQjC9Kh6UAEOAy4OWM7D7DpWwI056qDLtJr5pIQdSJzD2mJfWcsuKpDEjyKKb0afGKkPHwgCoEy9xq0pTtmTIIV2EVQuHtFEqdt0C1q0CoRj3lgLrwVdgdF8cZeJpgG8hsGqlXmdREBV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805593; c=relaxed/simple;
	bh=3cxzMgKrtjfz35iL9h0Nidd1dSTR8V9Zm50SYVvigFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psx4oLQkVZVVw/T4Kq1NE4eIxGqOW9a7fnZeYSMQBxNNhCaItkz12TyGHbSiSAdbYCsx1fWmir3nuZVMyeajvi4qcJf/DIoV4HVLQrhvU/hutICYP0snH9aopoxc22Ms+YmC1v+GddUbLLxqm6iC0Vx/gEdyHgDNQXUqrJjYFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyr65wP0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyr65wP0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608811F000E9;
	Tue,  4 Aug 2026 01:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805592;
	bh=fXSVO9ice+2GuPQXh0GsOODOFK84AzFtJTrx10N5rqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyr65wP0XE1+ymQVMQX92REr0Xx96FrA09FgLBi4un33ElP04SMrkniO+qu3K144C
	 yqbM+onyjc4hkFNrDgxY6EHXD8pV6rUIxWXDdLL78JItEs3+6e/IdMZZNYqs8z+85/
	 C5kZVkPbIvNx53uyeK8vuPENxx96CHM/ozQLMVDbJtelQGi6DcIetXvOFZZPOydfGJ
	 gDZo+knUO95TCshu14EJhqtDDaNyEeEGIV5vXzVglZdmcn1XUJjCx8BDDz5Pix2UF4
	 y10FPqcyTQKwbfOkWNmiEIXCqV5515juJVsHyPkaIlvfvwOM26wgo9ysPux5a1TqWx
	 fLX7yclp1Zdhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackson Lee <jackson.lee@chipsnmedia.com>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Brandon Brnich <b-brnich@ti.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y] media: chips-media: wave5: Support CBP profile
Date: Mon,  3 Aug 2026 21:06:29 -0400
Message-ID: <20260804010629.2350099-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072917-haiku-scalping-5001@gregkh>
References: <2026072917-haiku-scalping-5001@gregkh>
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
index 687ce6ccf3ae2..4b85336e4b2c5 100644
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
index c605a91718d8b..97c7ead3e72a4 100644
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
index c641357698691..a77569a580c7b 100644
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

