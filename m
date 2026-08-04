Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F16440A3C
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842508; cv=none; b=IPRXc6HlUyfTIELFYOr/UrOTaxwvr5fWcQq5r3/QXjv9AwXjtwF1+0JRVijV9OecjGa2+Mjh58e9dXmMFoqDsIW+QFWR2CqxawhCd1QlvuiWx6DXHtKNjZcvJNsAiWSU75v0ikWVpsZWA3hklqoG4dpfRUuG1e04+LFlHrlXtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842508; c=relaxed/simple;
	bh=F6P0OzkbCP8wmgkwoS+5N37Ktna6alCJ0eZTpIrKcJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB27kqa+cwnaJiqiQ3FkItkG51kUFPY/RvehXrEaoQy7urb/arkfdmARKe0v2VXz6xsuzOSKsCJPI6g6C078CPriaKgfPwy8vcI2AfxDkl8Wws3NZPNGSAP2GdcWwEOFuEc0sCQHJV6+TMtB9mF906JV53KM4O6j/7JGFAZZevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMj9pvy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMj9pvy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA1D1F000E9;
	Tue,  4 Aug 2026 11:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842506;
	bh=hTbSzw1oCYbQD/Cx8gXluucG5tBP1kh1sw/9Iu2cdBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jMj9pvy66mPfbB8JsH9a3d/h6+D/dHFYaiDPMzx5DpgeHx0SpVyq1ks5jSyTD1V7Z
	 EuZ6LLTz3tRgtujb7rlUgIPr4yywwIAn/on2EoOrZS4h/238pNniFJIJtWQgMARX9v
	 xRDoktMUtLH+m8cJINa8OKAHfrbSjMZty01YKQu/zga+Rve/C2DVuHjUMAPgSaclzj
	 4I2N9A2DD10AWLJnPhAH6F59CwS2TXA0Iz5HPctIc331tuDhQsk1YkzbElcJqCaoN1
	 kUsTaQ0gE5lQydMLcRPK8mgBmFwMYLuqQLpUTOtv72mCUIOxYEdNcmDwATlWsPVduD
	 QMs6LmZATmuww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jackson Lee <jackson.lee@chipsnmedia.com>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Brandon Brnich <b-brnich@ti.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] media: chips-media: wave5: Support CBP profile
Date: Tue,  4 Aug 2026 07:21:44 -0400
Message-ID: <20260804112144.2939763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072917-agency-urban-6464@gregkh>
References: <2026072917-agency-urban-6464@gregkh>
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
index 710311d851138..1daac56dd1d44 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -1753,6 +1753,9 @@ int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
 			(p_param->skip_intra_trans << 25) |
 			(p_param->strong_intra_smooth_enable << 27) |
 			(p_param->en_still_picture << 30);
+	else if (inst->std == W_AVC_ENC)
+		reg_val |= (p_param->constraint_set1_flag << 29);
+
 	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SPS_PARAM, reg_val);
 
 	reg_val = (p_param->lossless_enable) |
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index b7761d8a7d0ac..0e92eca182365 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -906,6 +906,8 @@ static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
 		case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
 			inst->enc_param.profile = H264_PROFILE_BP;
 			inst->bit_depth = 8;
+			if (ctrl->val == V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE)
+				inst->enc_param.constraint_set1_flag = 1;
 			break;
 		case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
 			inst->enc_param.profile = H264_PROFILE_MP;
@@ -1168,6 +1170,7 @@ static void wave5_set_enc_openparam(struct enc_open_param *open_param,
 			open_param->wave_param.intra_period = input.avc_idr_period;
 		}
 	} else {
+		open_param->wave_param.constraint_set1_flag = input.constraint_set1_flag;
 		open_param->wave_param.avc_idr_period = input.avc_idr_period;
 	}
 	open_param->wave_param.entropy_coding_mode = input.entropy_coding_mode;
@@ -1631,7 +1634,7 @@ static int wave5_vpu_open_enc(struct file *filp)
 			  -6, 6, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM,
-			  0, 1, 1, 1);
+			  0, 1, 1, 0);
 	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION,
 			  0, 1, 1, 0);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index d2370511faf89..703b2413dafa1 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -568,6 +568,7 @@ struct enc_wave_param {
 	u32 lambda_scaling_enable: 1; /* enable lambda scaling using custom GOP */
 	u32 transform8x8_enable: 1; /* enable 8x8 intra prediction and 8x8 transform */
 	u32 mb_level_rc_enable: 1; /* enable MB-level rate control */
+	u32 constraint_set1_flag: 1; /* enable CBP */
 };
 
 struct enc_open_param {
-- 
2.53.0

