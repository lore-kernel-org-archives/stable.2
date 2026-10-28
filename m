Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164075;
	b=K/hHFVZrGRVTNKEvQbkXW+2P8inGJdYCTtWDkHNplLlnWHAVS1IC6V8WTG9ewCcqa/yi
	 1qJM2zpK88qIPF9b/ROANxmsMAh4WxgJPycCN6p93XHOVBg5fTbykXX9n0AthF1/8fE4i
	 lwk7xUAh1LSISK4XTHo0m9POOydnymetG3pH+OrQFVB3oGA34qWCllgdiVuDC17QfNJUH
	 tLeShtNtPjpPDsIVk//j1s6X4lQX4+r+wwgUsjLAGTJttMB2P8CcPz0R/n3x30qO7Q7aM
	 fNoj9l+/DdaAbBS412k7t08zRqjm3ANOdmsBYxK58zk+EWnq9IMLg9V0auYyKEpnYtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164075;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bUXd6wCGkdy3sUL1jP3fBL2bNrVaPeuZ1kav6MQ03xQ=;
	b=G8O/asYTlvffd89jN9khDY4VMeh16mOcL7Ncbg2H/ek1WK22rI7+lpNL92k/PDJE+9/w
	 /oM71PGFI4T/nLCTVJU+PXYYGAFNjtWdZDinjko4+LyY57kCsA6J1MCaX8lEWHZcItvl+
	 MRhvZuJfPNb/5AiBegJpAlwwRnPZq7/qVeeWUYXVfru7AST1mC0/wwsCbvFgQPSlKJpa+
	 iPpAI60SQC1vu/5rf2a5b0MYcPGU4WUmdKluRrEt0QG4xEPmv4FiZdczUWj3UfyXG7AMp
	 SOc+29FRc9jfJrkQRHWKh5Uj0H8GQ8roN3sDAy+HJHWDGJGqyiX479l1xXpYiHy6lPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nOzYcQ4q;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09993606A32A;
	Wed, 28 Oct 2026 05:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09993606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nOzYcQ4q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bU
	Xd6wCGkdy3sUL1jP3fBL2bNrVaPeuZ1kav6MQ03xQ=; b=nOzYcQ4qMVtVeZi2Pt
	cReMe+ncj9l3Cnb8pfwXcxRBscn3+ASfglv3RjT9Y4wDGCp80brrZn44/1DTuEdn
	VPxlee0+VnZ0DFi1S3L3RLUaX8mVRav2mfcgDWGdsP8OozxxHdVtMh2PfuP4UZKN
	Sc05LEkm2MJ9x/MoM5J9xCdq8=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnt9XTguFq0hNpDQ--.19760S2;
	Wed, 28 Oct 2026 13:06:28 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Ban Tao <fengzheng923@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Joao Schim <joao@schimsalabim.eu>,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: sunxi: sun50i-dmic: resume device for control access
Date: Wed, 28 Oct 2026 13:06:26 +0800
Message-Id: <20261028050626.133421-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt9XTguFq0hNpDQ--.19760S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF43ur13Kr1DWF4DGF18AFb_yoWrGF45pF
	1fJF43tFs5Jw4F93ZFyr48Xr13CrZ3KF4kA3yIy3y7Cr1xGw1IgF9Fv34rCFZ0krZ0kFsr
	Ar1jv34Sg3Zaka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8AwsUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xToI2rhgtTr5QAA3j

The capture volume controls use regmap directly while runtime PM may
have suspended the DMIC and disabled its clocks. Since the regmap has no
cache, reading or writing a control while suspended accesses unpowered
hardware.

Use control callbacks which resume the device around the regmap access
and release the runtime PM reference afterwards.

Fixes: 9a8cadddd930 ("ASoC: sunxi: DMIC: Add controls for adjusting the mic gains")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 sound/soc/sunxi/sun50i-dmic.c | 59 +++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index 5c784b1f6846..a5f70db856b9 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -286,22 +286,55 @@ MODULE_DEVICE_TABLE(of, sun50i_dmic_of_match);
 
 static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(sun50i_dmic_vol_scale, -12000, 75, 1);
 
-static const struct snd_kcontrol_new sun50i_dmic_controls[] = {
+static int sun50i_dmic_get_volsw(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret;
 
-        SOC_DOUBLE_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
-                       SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_VOL_CTR_0R,
-                       0xFF, 0, sun50i_dmic_vol_scale),
-        SOC_DOUBLE_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
-                       SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_VOL_CTR_1R,
-                       0xFF, 0, sun50i_dmic_vol_scale),
-        SOC_DOUBLE_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
-                       SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_VOL_CTR_2R,
-                       0xFF, 0, sun50i_dmic_vol_scale),
-        SOC_DOUBLE_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
-                       SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_VOL_CTR_3R,
-                       0xFF, 0, sun50i_dmic_vol_scale),
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
+		return ret;
 
+	ret = snd_soc_get_volsw(kcontrol, ucontrol);
+	pm_runtime_put(component->dev);
 
+	return ret;
+}
+
+static int sun50i_dmic_put_volsw(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	pm_runtime_put(component->dev);
+
+	return ret;
+}
+
+static const struct snd_kcontrol_new sun50i_dmic_controls[] = {
+	SOC_DOUBLE_EXT_TLV("DMIC Channel 0 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
+			   SUN50I_DMIC_D0D1_VOL_CTR_0L, SUN50I_DMIC_D0D1_VOL_CTR_0R,
+			   0xFF, 0, sun50i_dmic_get_volsw, sun50i_dmic_put_volsw,
+			   sun50i_dmic_vol_scale),
+	SOC_DOUBLE_EXT_TLV("DMIC Channel 1 Capture Volume", SUN50I_DMIC_D0D1_VOL_CTR,
+			   SUN50I_DMIC_D0D1_VOL_CTR_1L, SUN50I_DMIC_D0D1_VOL_CTR_1R,
+			   0xFF, 0, sun50i_dmic_get_volsw, sun50i_dmic_put_volsw,
+			   sun50i_dmic_vol_scale),
+	SOC_DOUBLE_EXT_TLV("DMIC Channel 2 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
+			   SUN50I_DMIC_D2D3_VOL_CTR_2L, SUN50I_DMIC_D2D3_VOL_CTR_2R,
+			   0xFF, 0, sun50i_dmic_get_volsw, sun50i_dmic_put_volsw,
+			   sun50i_dmic_vol_scale),
+	SOC_DOUBLE_EXT_TLV("DMIC Channel 3 Capture Volume", SUN50I_DMIC_D2D3_VOL_CTR,
+			   SUN50I_DMIC_D2D3_VOL_CTR_3L, SUN50I_DMIC_D2D3_VOL_CTR_3R,
+			   0xFF, 0, sun50i_dmic_get_volsw, sun50i_dmic_put_volsw,
+			   sun50i_dmic_vol_scale),
 };
 
 static const struct snd_soc_component_driver sun50i_dmic_component = {
-- 
2.34.1

