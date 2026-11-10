Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318271;
	b=rS/VHhDDPfJvKVyb/dQ7XUaMxhciqqFTqmVD1uk10PBCtxQnOqeUhOUjCCVV7IH4M3h2
	 PDhn6B7O+8RKoKLsWcX1J3x1/hGAirDbwSoiaZ267q4tRMs40N/M99hmLg20mYcq0pI5D
	 mBv27EX7MWUti1FiYRhy9/TliqfihJGZctxxpIX5vzWCyemsPkcOczLV5crhuDbZ/WmdA
	 ADpvjvyhYbp6wHBiTGKR1/mVkYjIiOro9JLKeLbby1frlmL1RfLE088yc8h+MHlKWSikk
	 gUto7iqcumBSNTyDUr68LyT20br8cZG5vBhFoG4r0TdupXW4vqKBbNIoWFTT7DDF7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/BQYZFZMsjDVmKk/WVSS4K8+J1BQ8qZeIa3VKGtwiUY=;
	b=RDqLgELFdXYH2lGdqfvX27V6YrH2kd0my6rIX1mwaJFaMrH/DcX7wdS62A74/odBG0H5
	 fqNyT4bQ7AO1xpogPxUaTbssCiMAKmkoG+gn+DWj6r+YlaLgcKpwqtEfzidsMuhhbMidy
	 pz0wOuSre3rCjrCJgkCIaCK1KHpRVXGZZ1bdcnRutFAaLQFW/PQT5Ma1QEGA0K8SMOpnC
	 NHIlASs1Yg0SrR9H43Nk9Hbm6CooYX4k9gHzJefDeCcO/vXGrTs38w0AMp0yMeTqRWwK5
	 urGM/LTwLyCSRy8LrWIocIJ1+9nDKtis1pgXue7+1J7I8CdECoWog/c2yYRJ5WkQoxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LO3oBJeM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177460A2604
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LO3oBJeM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F321F008A4;
	Tue, 10 Nov 2026 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318270;
	bh=/BQYZFZMsjDVmKk/WVSS4K8+J1BQ8qZeIa3VKGtwiUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LO3oBJeMjJuCmf4XwQqwaRU2SotjZcTwy/4gBnSdtB78npUjx1W2MBPBNd6vVIOia
	 c3sZkCkQlmfqM6sB2B1/z6xF6sBIf44CWOls4nNJd7btMiNU1DOM+opNKK3lBW71s9
	 +IdF2xJkJbcYhB3mHrMriR9fjDQ0y/azcqLotKeUfPGuK+Fl91tSemjEIM4r7JM9lv
	 i9HGhQ1khZTUPpP3p5OyQczUbNXnsr/t6DO9LJeDxXUOPHvPt45D6ui17bdEtyvvUG
	 99UtkEPxoPRyHn/aXTBF+XBFOh0ezhUWLN0kT9HFjOHaJm1MaGLWwoT5iYjpBpAIz9
	 1lPA/QxVS/RjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Tue, 10 Nov 2026 08:44:27 -0500
Message-ID: <20261110134422.1782548-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134422.1782548-1-sashal@kernel.org>
References: <20261107054431-failed-6.1-1b207c85551f@kernel.org>
 <20261110134422.1782548-1-sashal@kernel.org>
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
index c52613365d679..39161da5010fb 100644
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
@@ -1108,7 +1098,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1134,6 +1124,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
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

