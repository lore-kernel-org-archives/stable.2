Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83121339395
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773753; cv=none; b=huAoCStKuO0DNAlBKvJRAJqPoepSQeR0ZQyTjRJ/P9Je37xQJpjfn2BJE5zAFCr7lGahOQ/jkyIVIY0rNQAFOc3+6UX6M/PAe6ykKyzqvcBS/9l5IA/1/6VzfO6O2GjFrLa0SrztrtcEzTgWnpYjTv1lSkVscH2/m/pXeCM/Vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773753; c=relaxed/simple;
	bh=SSN9m/ssVGDMdjaMsy2vgfuWjFkwayeWkvxUYEH8b2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmNVWadj7uJ/wcY/BP/hg9Fc09pFdWQmedm1FkLevVakf1nBPpX5xLwRVmNptbf9HfwTpzLNPCDhloHUGoEYtC/2lhLwE/1prgXtp7+xC3tqK6uRCsSDBYzkEk56TWZZ7C07LLce+WAZFdyWfzbYz5u7NO8QGndgW+oToyGDeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdcOsqrG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdcOsqrG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B0D1F00A3D;
	Thu, 23 Jul 2026 02:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784773752;
	bh=jN/0gSGh0HrvdE2zRZ9GTy5o+zkBxzipzceXQKfbJEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CdcOsqrGn8fmjrs9uFuWmsvNXUYFCrsIfVHLCUaAeJUM7KaaAWGLZ9E02/w8pSoLg
	 4lKULv17gVypSMvw1uvA+PpdUdvwoST4PP+Uap8WWh/lTiIGdE4k93aFQZY2uaPt3q
	 gUn58t70+WnbUmLKvwQdssGrPRt+ciXMpv4wBY7/Tdnxp5AxxXeVwwOahaXa2khW6g
	 5SgDQF/HoaABBOoBMMQToeg+h0eUITkdlJ0BaRkqY+RXvX5a3ze/rgeoO8iwKiAVMJ
	 Z7N6yxoN1rGYfJA0LloYwz4tmYXHA9pFqRtlJ99mYJeZLLz+wbU09b/gsCQ2LVgeYQ
	 BJBmY+jKv6C1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] ASoC: mediatek: mt8183-afe-pcm: Support >32 bit DMA addresses
Date: Wed, 22 Jul 2026 22:29:07 -0400
Message-ID: <20260723022909.2845199-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723022909.2845199-1-sashal@kernel.org>
References: <2026072039-ladies-ducking-f84d@gregkh>
 <20260723022909.2845199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 9e7bc5cb8d089d9799e17a9ac99c5da9b13b02e3 ]

The AFE DMA hardware supports up to 34 bits for DMA addresses. This is
missing from the driver and prevents reserved memory regions from
working properly when the allocated region is above the 4GB line.

Fill in the related register offsets for each DAI, and also set the
DMA mask. Also fill in the LSB end register offsets for completeness.

Fixes: a94aec035a12 ("ASoC: mediatek: mt8183: add platform driver")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Link: https://patch.msgid.link/20250612074901.4023253-8-wenst@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: f0334fbfd107 ("ASoC: mediatek: mt8183: Check runtime resume during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 9dfe3b5d11a9bf..5858ba274c2bc2 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -6,6 +6,7 @@
 // Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
 
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
@@ -432,6 +433,9 @@ static const struct snd_soc_component_driver mt8183_afe_pcm_dai_component = {
 		.reg_ofs_base = AFE_##_id##_BASE,	\
 		.reg_ofs_cur = AFE_##_id##_CUR,		\
 		.reg_ofs_end = AFE_##_id##_END,		\
+		.reg_ofs_base_msb = AFE_##_id##_BASE_MSB,	\
+		.reg_ofs_cur_msb = AFE_##_id##_CUR_MSB,		\
+		.reg_ofs_end_msb = AFE_##_id##_END_MSB,		\
 		.fs_reg = (_fs_reg),			\
 		.fs_shift = _id##_MODE_SFT,		\
 		.fs_maskbit = _id##_MODE_MASK,		\
@@ -463,11 +467,17 @@ static const struct snd_soc_component_driver mt8183_afe_pcm_dai_component = {
 #define AFE_VUL12_BASE		AFE_VUL_D2_BASE
 #define AFE_VUL12_CUR		AFE_VUL_D2_CUR
 #define AFE_VUL12_END		AFE_VUL_D2_END
+#define AFE_VUL12_BASE_MSB	AFE_VUL_D2_BASE_MSB
+#define AFE_VUL12_CUR_MSB	AFE_VUL_D2_CUR_MSB
+#define AFE_VUL12_END_MSB	AFE_VUL_D2_END_MSB
 #define AWB2_HD_ALIGN_SFT	AWB2_ALIGN_SFT
 #define VUL12_DATA_SFT		VUL12_MONO_SFT
 #define AFE_HDMI_BASE		AFE_HDMI_OUT_BASE
 #define AFE_HDMI_CUR		AFE_HDMI_OUT_CUR
 #define AFE_HDMI_END		AFE_HDMI_OUT_END
+#define AFE_HDMI_BASE_MSB	AFE_HDMI_OUT_BASE_MSB
+#define AFE_HDMI_CUR_MSB	AFE_HDMI_OUT_CUR_MSB
+#define AFE_HDMI_END_MSB	AFE_HDMI_OUT_END_MSB
 
 static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 	MT8183_MEMIF(DL1, AFE_DAC_CON1, AFE_DAC_CON1),
@@ -946,6 +956,10 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct reset_control *rstc;
 	int i, irq_id, ret;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
+	if (ret)
+		return ret;
+
 	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
 		return -ENOMEM;
-- 
2.53.0

