Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318016;
	b=I/nhF5u9UZydMb6FmxWOqQxGeJrvFgiyrFk4Dy5j3ptVIToIUp+752tkSaQUIzfH3uFO
	 X9o6+q/qMoN+rr34qJkYw7IsY1DrxWJ5MqCCn6dFj0UEM04WA9NTWNiVvO6tNXj2shsgf
	 dhffrqqV186/0eGs/0XxBPbwRpNhNfawOz01TT01Hkwrg/q8HHCzfvrdgCx9FfRHGj21B
	 4z2ycw0vW/7st6k9A9SnkEsgeiD9YXffWxjHYgQOcfcO2xGyy1iGu5TMYxstfy8QKI6cY
	 KgavTWZAxO4MiZJrULx23IiCw9Lxe0E/DXbaD//9fHjBjQbGVgCf8FfGTxt9J1vNxKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lvkmn+D5iz66q9NK6qHSZ0GeV/JZwQmsaKa+rQua0h4=;
	b=ftMYOmpZBPy5paP20wy8JFBOnPcnuWN+RUglGVTyOl1DByNe9qSxolVHIL1GjY3eKYvV
	 lFbXN+mUMq+QnuyW6ahPciTQzCI7PZtgLfKYTQ5KIQ54AqpJXfVu0+1ExJUozZk3YZlI1
	 XuiBilpXodqk9Co3POxKtTb6ERC9/IOk4IOeYjVh7rpiKxZC45KJ7YytVBCjuvFYV8Cz8
	 kzkMEjjJEsWEWW1Y7ecpzz3pQpIIOEyVORKPB4f1bQccXio5MSxlFgMR3ic3dmixcjb8X
	 dG9qM+4jwC3eWft45rq+PGL0+sqFHba0XKOAWbi77EGsQaVd3+/ceGMspyprHWUvO1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQKVHB8G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159160A262C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQKVHB8G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C926B1F008BC;
	Tue, 10 Nov 2026 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318015;
	bh=lvkmn+D5iz66q9NK6qHSZ0GeV/JZwQmsaKa+rQua0h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQKVHB8G/F3NKhRTVuqZYisiPnusKzCJ6sEWnv88aI3LO72ja0lyHuY9d8umb4b0p
	 H7kTdRCrXEqRWKetDXAK5ybKQTXnP9W4LIOPu4+FBWgX0Izm75WAy9lqUzB8NcvBBN
	 h4616iYJe0/UsWkrGFOTJWoBMM16fSYHzUphTRkoUnGvqtl1pru2ClQnO0l85qPcau
	 Iq/0Q+qjNQx3AAWUaXnlaUCyQDL3ci5kBwXofTTgCD1Ctlrvj1BGFXDdCTrRaPuLId
	 xLojsZCOgLuZIaXQEc+3qEdTvBWlBXR0l6ap1gH5j+GpBRAfLOYUcAGFnJWeoCLiHg
	 n3ZpJNK2wWZEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Tue, 10 Nov 2026 08:40:12 -0500
Message-ID: <20261110134005.1774027-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134005.1774027-1-sashal@kernel.org>
References: <20261107053148-failed-6.6-1b207c85551f@kernel.org>
 <20261110134005.1774027-1-sashal@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 1b207c85551fd74854d632116849295b2305245f ]

The ISR accesses the managed regmap, but probe requests the IRQ before
creating it. An early interrupt can reach an uninitialized regmap.
Reverse-order cleanup can free the regmap while the IRQ remains active.

Request the IRQ after regmap initialization so probe unwind and
removal free and synchronize it before releasing the regmap.

The teardown ordering issue was found by static analysis.

Fixes: e4e6ec7b127c ("ASoC: stm32: Add I2S driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20261004043451.1138613-1-mhun512@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 4e4d8d0ed7bd7..2da8aeb256bcb 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1027,7 +1027,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	const struct of_device_id *of_id;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -1072,16 +1072,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 			return ret;
 	}
 
-	/* Get irqs */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
-			       dev_name(&pdev->dev), i2s);
-	if (ret)
-		return ret;
-
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rst))
@@ -1106,7 +1096,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1132,6 +1122,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->regmap),
 				     "Regmap init error\n");
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
+			       dev_name(&pdev->dev), i2s);
+	if (ret)
+		return ret;
+
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
 		return ret;
-- 
2.53.0

