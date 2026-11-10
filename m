Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319271;
	b=kBBQxKrKFRAkHSZBTsr38h6Z6yLhm5GSs8yluW59oNoAw288emVJM4xiKAf7jHeRzzGn
	 KZPYkeBYGM1vgtuGCLoPWM/ygpmYYrsinzEERlDHNVKc0GHRa9VDwsNMmI2XyJ6xfsssH
	 QGv4VfUjPqrJ5Don+mv/RGEB2PRRfYwflcdpjOcewPiZ5METDXmKlM2lJvFXWggvi3PXB
	 1c3preu2FsD824tGU6pVywmMm9CTPmixgafzhsIrf+90bXBz3yIR6Ye19DOL6dK/sHFlQ
	 /11RQHKCMpLOKWRDTlvWBAc8yaJr7bJcIfQfm42Ubvac6VhdX5GxWpW0p/zNJOWQyZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/DaM+gZ2endZdQ3vtY1vBp5rwUEk32B7mR8EnGmi6Gw=;
	b=Z8/OdfE6ovhCs6r/un9z5T4yDpQiqPZi//eVjloNYsrrjTygXPR9iqJmK514TjF+BR0c
	 Z8sbO2J8xfGAPjCKTX2Qj+4+CDeJIXyNujh/EKvaOwIyck+FXEoMTTx+H3sA308KAs892
	 KXxmB1oMUPZBZygQDwKSyJ4qxGetLvho1v90HeKG831b//njdzKtCSs+49Om+AyNizAIE
	 0muIimzHJqNz67D6V7PDWCn/sqyFYYjMa3/0ESNssmWHM6QlI39ijhb4GZixN1o4jQh0g
	 CdTeyJ7Fjbje+NIOr9zLE2w2EMpKMIFvT/IaOOa90quruIGOYkqpz0rvp+odam74C9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvPfqPzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvPfqPzG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339541F008A4;
	Tue, 10 Nov 2026 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319270;
	bh=/DaM+gZ2endZdQ3vtY1vBp5rwUEk32B7mR8EnGmi6Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvPfqPzG6dESnEHpAEjsefIvWYxIZCRSHw8XjkteAC7jpTsFdOvRrL44FOlUDFEDE
	 pRP6bXOXT/k226sPKgTCRIZdHc0fFkD5J8r/YJbMp4tcZN4QVP1xbe+nfOviR/N+Bq
	 ILWvgEr45gAHgCBZUVGkBE4QQq0omqmlNmaY3BUKf0wekQRG0yXaWDSeAb6A86zKLQ
	 wjo5rmx/zpBO+zjp/NOf/AGutJcT6TwO+/QChgUa97D10gEAEMZqaPbQjScXHUWXBV
	 fsJMt0yFdOuRP+ZzHVjFSkVocrS+CqdtAVvFw1tyTe17A4bel4AYw/vJpoa58ZCg04
	 vcHSRgFIcUo0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Tue, 10 Nov 2026 09:01:07 -0500
Message-ID: <20261110140053.1802242-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110140053.1802242-1-sashal@kernel.org>
References: <20261107061902-failed-5.10-1b207c85551f@kernel.org>
 <20261110140053.1802242-1-sashal@kernel.org>
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
[ sashal: Removed the unused ret declaration from stm32_i2s_parse_dt() because the newer clock setup code is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 4a6869d535d4f..63fde986018c7 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -810,7 +810,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	const struct of_device_id *of_id;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
 
 	if (!np)
 		return -ENODEV;
@@ -849,16 +848,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->x11kclk),
 				     "Could not get x11k parent clock\n");
 
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
@@ -884,7 +873,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -910,6 +899,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
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

