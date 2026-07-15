Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8E308F23;
	Wed, 15 Jul 2026 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095482; cv=none; b=OwjezlouLvJ60bZtn6L2bq41skXS/LovegrjUlp52oxGj9bPLeLL90ghMxnZ5LgKTi6asL77mzrN/2aY2GDCziauUQcclOhx2wPHERopAAjoEhyYW+A2lTr/gkssTK8GFG3ejz2v1V/EFnt0qNFr6xgoDu+FBH6AhZ8+TAAqV6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095482; c=relaxed/simple;
	bh=p0z8OfcS1fdiYyedH2MZyLZY7VEHaJFdRELjOTQv8uA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bCG8MFdWVXDozIL1mmx2qZ7BJv2BKzR9f2M2eSM4ZFRhCfOM5pcWDs/yQ9rGBALLY33XVKwmVI33wjpzZ4cipdtLxOoeIVmBFkmAz4TzJlWaUBRndYahT0SuQjzCgkWXSPLRJcaYQ6+PjGP0Wt36sUeQoQ9Bv/M2GuQsz/ZuXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHY952wb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHY952wb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CBF7C2BCF5;
	Wed, 15 Jul 2026 06:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784095482;
	bh=p0z8OfcS1fdiYyedH2MZyLZY7VEHaJFdRELjOTQv8uA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LHY952wbD00sIWzXEIPNLNo/4741CiFQVMFH+yoka+ROGcdwwyOAdwBFxwMtH/Rg2
	 P1jEuWB7YUBHTg5gG5t11kTC379yR1GqjlUWHMTcMU3OJSIb5mfJZDJeM4J1GfLPPp
	 ebUeX8d0WPfJlxcSeeMXWFthZdOGi5lXKu6ZMa9JLkUHl67Mi2q6RmW/+JpaoGGmwp
	 j5m5uOOVu+LaVQ7HbabUvX3PqSUBoHot0aEsklwTzE7Bkme0tUIjGdMajsRlxjzHaG
	 /x8ARK7kdAsNWkvckmy6j5rXxjW8IVRtjArnNXEiGZ9OMpsM6PFn5Li6DZakMmt4C+
	 Vq/Kjvd1/L89A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46EC44508;
	Wed, 15 Jul 2026 06:04:42 +0000 (UTC)
From: Haidar Lee via B4 Relay <devnull+haidar.lee.adlinktech.com@kernel.org>
Date: Wed, 15 Jul 2026 14:04:40 +0800
Subject: [PATCH 1/2] ASoC: tas2562: fix DVC coefficient write order
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-tas2562-dvc-fix-v1-1-072b13901b20@adlinktech.com>
References: <20260715-tas2562-dvc-fix-v1-0-072b13901b20@adlinktech.com>
In-Reply-To: <20260715-tas2562-dvc-fix-v1-0-072b13901b20@adlinktech.com>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dan Murphy <dmurphy@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haidar Lee <haidar.lee@adlinktech.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784095481; l=2928;
 i=haidar.lee@adlinktech.com; s=20260715; h=from:subject:message-id;
 bh=NrDARQuuRTnNObQOb1pPNHaoWGmUellYTb5N5X9Elwo=;
 b=Jojabzbyv2lFEZ+hhb+FNhvvFy6aGlg1FWjgRUKsynbkhjiuLUXTy09CvpQAQFY8xgCKVnmSm
 Q2E7sIt6QfkC/9HXXYyFL1aXKW+yliFQZNA4kFu7bWAhrtCh+aSTr38
X-Developer-Key: i=haidar.lee@adlinktech.com; a=ed25519;
 pk=p37KzVgRl0a8om8VCM7iEwQvNuZz2fxL4lBCBp5qrno=
X-Endpoint-Received: by B4 Relay for haidar.lee@adlinktech.com/20260715
 with auth_id=872
X-Original-From: Haidar Lee <haidar.lee@adlinktech.com>
Reply-To: haidar.lee@adlinktech.com

From: Haidar Lee <haidar.lee@adlinktech.com>

The TAS2562 applies the 32-bit digital volume coefficient to the
playback path when the last byte, DVC_CFG4 (book 0 page 2 reg 0x0F), is
written. tas2562_volume_control_put() wrote DVC_CFG4 first and DVC_CFG1
(the MSB) last, so every volume change latched a value made of the
previous coefficient's upper three bytes combined with the new LSB; the
remaining bytes only took effect on the next volume change.

In practice the control was unusable: the first setting after power-on
always played at roughly 0 dB no matter what value was requested (the
chip's default upper bytes were still latched), and most subsequent
changes muted the output entirely or produced a distorted, over-unity
gain.

Verified on a TAS2562 (ADLINK OSM-520 / MT8189 board) by tracing the
I2C writes with ftrace and by writing the same coefficients manually in
both byte orders: written MSB-first the register block behaves exactly
as the driver expects, LSB-first reproduces the broken behaviour.

Write the bytes MSB first with DVC_CFG4 last so the complete new
coefficient is latched atomically.

Fixes: bf726b1c86f2 ("ASoC: tas2562: Add support for digital volume control")
Cc: stable@vger.kernel.org
Signed-off-by: Haidar Lee <haidar.lee@adlinktech.com>
---
 sound/soc/codecs/tas2562.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index e1d62f30418a..ec32ef0afd7e 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -475,20 +475,27 @@ static int tas2562_volume_control_put(struct snd_kcontrol *kcontrol,
 	u32 reg_val;
 
 	reg_val = float_vol_db_lookup[ucontrol->value.integer.value[0]/2];
-	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
-				      (reg_val & 0xff));
-	if (ret)
-		return ret;
-	ret = snd_soc_component_write(component, TAS2562_DVC_CFG3,
-				      ((reg_val >> 8) & 0xff));
+	/*
+	 * The device applies the 32-bit coefficient to the playback path on
+	 * the write to DVC_CFG4 (the LSB, book 0 page 2 reg 0x0F), so the
+	 * bytes must be written MSB first and DVC_CFG4 last. Writing CFG4
+	 * first latches a mix of the previous coefficient's upper bytes and
+	 * the new LSB instead of the requested value.
+	 */
+	ret = snd_soc_component_write(component, TAS2562_DVC_CFG1,
+				      ((reg_val >> 24) & 0xff));
 	if (ret)
 		return ret;
 	ret = snd_soc_component_write(component, TAS2562_DVC_CFG2,
 				      ((reg_val >> 16) & 0xff));
 	if (ret)
 		return ret;
-	ret = snd_soc_component_write(component, TAS2562_DVC_CFG1,
-				      ((reg_val >> 24) & 0xff));
+	ret = snd_soc_component_write(component, TAS2562_DVC_CFG3,
+				      ((reg_val >> 8) & 0xff));
+	if (ret)
+		return ret;
+	ret = snd_soc_component_write(component, TAS2562_DVC_CFG4,
+				      (reg_val & 0xff));
 	if (ret)
 		return ret;
 

-- 
2.34.1


