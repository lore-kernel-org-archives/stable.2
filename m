Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313304;
	b=YeI2qzsva1g2smGuTBwpBRs98TcIZhsjh2vLE06M0Ye8GPRFyjEaUTA7/wg3gd9kK/HR
	 K4NFEe/PKL0Sweu6GevirOPUOomhrFyVHG5r3d7fv6ma2Yw1fCq5mVazGowuIEQYHYnWS
	 qmNHfJP3H+LOcSNai2rgexvvPVmp4V7e/bHY6/0Cr9bQ5h8TctOl2sT1l3l0jzeOp4Db8
	 6Vm4MWkIB1L7HiSbY+dYcx4klrMe4xiVOp9b4z+QPKwhVLcZnPXpL/b5XKSlsGw3jIWFZ
	 F3KV9krAZXvSNsZ1nnL7xWqrAI9ByhFcmGZ4xx35PBosdXzsZm0tiJBFp/JWSZHFgGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313304;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2EC481Vv1Bxeob2YYspe1aqCf43SDS2FKyPskwhCtlU=;
	b=dHKudA1Enf6k9z+Y/9wsIYe7zhmzvAID4m3Rkm7XqP5VE+i9D8jEVj0M5SEUaA3WDlK5
	 IAEKDoDKEQq3HxV2gSx/sVuNdXi2vT/X/D87YNOwOpE2P9Yce2aH2hBPIwo4HyS9gnxfW
	 HRYd5qwGlk4Ne6ReIs7ViSF/qgFTSPakgoHiqbbYrwHEiB3wcfwBnD3pr/Evn1Rt47U+H
	 idBL0wWOJGtUQy1gypNq/y6kmNz2Bgjd4MK/vafV5W6XRVBXYt+jRUguCe+ltDA1RGh/G
	 4eUwr1vc7AZ1d6qzca7XbrLm+FMB03t7ia9LwViTsaycUwB4j6fXZFWBg3sy2ciad6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5KoCV+r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5KoCV+r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D121F008A1;
	Tue, 10 Nov 2026 12:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313303;
	bh=2EC481Vv1Bxeob2YYspe1aqCf43SDS2FKyPskwhCtlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f5KoCV+rDDWj0iq7FMWBuZlymfpo6CSmLPX70aupKB1XEY0LZGF4fijE+efxZPlO/
	 iLNykHesPXDpy3rMTcIs5wzrEt4EfzkzfDCx5f2GlUA4OpK3Ok5jZOjrWBDOP+3uuk
	 tp0+v8Bw0B3Sq8Gx0EQZGB1B6vDr71elgwfZ3lJ3Rj3hCwvnIDNE4jBIRnzlv2qUir
	 jrXbO1RADoDoDTU2HYL9GM1YP7JE+hv4erLqtH8tEW9OFblbTnDW2t9YI/UYlJ4XSM
	 N4PQUZQqoHx50RkUT4/UegflfhWpdbDPWsbTE+fhz5cQbuP6YE2s//56dSRfx8Da/+
	 D38f66h2wsmbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()
Date: Tue, 10 Nov 2026 07:21:40 -0500
Message-ID: <20261110122135.1110460-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110122135.1110460-1-sashal@kernel.org>
References: <20261107054310-failed-6.1-082723fee626@kernel.org>
 <20261110122135.1110460-1-sashal@kernel.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 082723fee626532f176727b6438b666a96d5246c ]

of_slim_get_device() returns a device with an elevated reference count,
and wcd->slim_ifc_dev is intentionally kept for the codec lifetime on
success. However, all the failure paths of wcd9335_slim_status() return
without dropping that reference, leaking the SLIM interface device
whenever the register maps cannot be created or the codec fails to come
up.

Put the device on each of those error paths.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917164853.2163184-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 4d7b9a8470fd2..a0f6b3aab2d4f 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5194,25 +5194,32 @@ static int wcd9335_slim_status(struct slim_device *sdev,
 	slim_get_logical_addr(wcd->slim_ifc_dev);
 
 	wcd->regmap = regmap_init_slimbus(sdev, &wcd9335_regmap_config);
-	if (IS_ERR(wcd->regmap))
+	if (IS_ERR(wcd->regmap)) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->regmap),
 				     "Failed to allocate slim register map\n");
+	}
 
 	wcd->if_regmap = regmap_init_slimbus(wcd->slim_ifc_dev,
 						  &wcd9335_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap))
+	if (IS_ERR(wcd->if_regmap)) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
 				     "Failed to allocate ifc register map\n");
+	}
 
 	ret = wcd9335_bring_up(wcd);
 	if (ret) {
 		dev_err(dev, "Failed to bringup WCD9335\n");
+		put_device(&wcd->slim_ifc_dev->dev);
 		return ret;
 	}
 
 	ret = wcd9335_irq_init(wcd);
-	if (ret)
+	if (ret) {
+		put_device(&wcd->slim_ifc_dev->dev);
 		return ret;
+	}
 
 	wcd9335_probe(wcd);
 
-- 
2.53.0

