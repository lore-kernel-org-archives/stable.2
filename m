Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317530;
	b=Z//aZqu33TElRrKN45czQdUaXvy50u2sNjLkCcBGSoKJOQ0M0fN2xsBG+bzb/i0NHFw5
	 9yRRSTjxpYVpisBWfrXWHU9ORf4YpOMbOubMKm/3dFaeQqLbQRmpjC1vbzkOEVHhMjwuQ
	 x+soefG6y1ujWC3qKmvcRNI8+dMTGmfEBZaw3xnO0N65PQVcg5NMaSaDHUT4kZGl7KzZa
	 VD0MBBdvWWCDPQtfxuudyA6jXKqPTE+oaAEJ0cBiSaOKo14x/SvpkN7GHqbBtHBp01eqg
	 mc/I+K+YcLyJh5kxzcKld9n3fbD+1Fam6RyDlFeYqSTnF/JK3INmwh16v7xTbIb17pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jX94QfDKwO5RBx2lElkIblv1l9mjsPqUJogPd5TI0AY=;
	b=OwlXqPOve4p/BHS3KbUYmEqID6nFoiyozlRSnBNbNabGWi1TiORcVBFkeNO7XQtK524B
	 N8Yz3thNVdiyp5PQA1UVmwp0D1yba2vI172C3RRAwly8fnWzgtvVfsOoSnBDJf0M4H77U
	 U9IH1MiEjHC8D7pJaCNG9NuX8aE/WSox0Lok0VsCDZ5eoTl9e86EIj4xWum7ZK9BUDRv1
	 fHlmlNq8iEJBjRXFEftqJ10Wf90D7gUHDqDipw4HFsDiCmkyTY2jFoqa6RZQ7YZ8ddVke
	 DIKoIWW+Ja7dROJG1rzcJ6yHSwZkGJq5qugyXDcDXByj+0VWKP0hv5BSN3VslYEu2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igXpLCsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AF606ACDC
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igXpLCsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3CA1F0093E;
	Tue, 10 Nov 2026 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317530;
	bh=jX94QfDKwO5RBx2lElkIblv1l9mjsPqUJogPd5TI0AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=igXpLCsxthbor/k9wIkBPJtROenOufDV4pIBbEVwyjB+dbJnFs8zhCJWvm91MQpKM
	 GSJi8dDjcE6gcs/w2kQkuO5BXXhgeCxKzVYAPcJJAE+7D+27VRyfOe+6kdBjDR0xx3
	 /vgtGIDqG/bDwBJ9trIsO52eOU+wn7CaYtHiK1T1UDD3xew7yA6GKQJI824PzMycxl
	 5W8mN5R/27rvF7ecgDalkKIECzypMWrFJsWSDAN3kSjfE1slpRQJL/LfVoPWMZ/XW2
	 Pr1PzPnkyYUkcQ1DUnPyo9Coy6OGwbgktMJtSuk/QGPJ/4tV3nK+1HZefVgo04odDf
	 xmUdeZsh5BRbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Tue, 10 Nov 2026 08:32:07 -0500
Message-ID: <20261110133158.1746140-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110133158.1746140-1-sashal@kernel.org>
References: <20261107050833-failed-6.18-1b207c85551f@kernel.org>
 <20261110133158.1746140-1-sashal@kernel.org>
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
index 100a50a88d6d6..ab06d13a59b9f 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1192,7 +1192,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -1238,16 +1238,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
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
@@ -1272,7 +1262,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1298,6 +1288,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
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

