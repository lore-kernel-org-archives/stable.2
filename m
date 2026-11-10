Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317758;
	b=5VdUzA+J64MUOhnGLlfJKgX74FKZnWLUliK0s/jJXJPQiGUO9hUORhZZ7VhVl46n1ke3
	 YXJz+uXyfKLMtZvZSgYa2RPQn6Y916rMfspQ0Z1IM9mVXMLUpiyQ5ajdYTwyfBOXY8I7h
	 Un8QDBFj1WU7/xfz0nq9PrS7dDe1xaTpsUP2oCuKblUYbWAUmbAF0aOhTpD4eHiaQjvEQ
	 ngqNSmzDNXbB/K7qCzxPFdoaS5qFHoGEaIihyoKigJJvxbjDeyfH2JpSHjWOKv461JuOO
	 WvVZ4uTrMtu3Ypkb2XhOb0Da7ivFS32F+Zk00WRERCZSB+RMbXgZE0W2ru6m7hMRWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1JfeR9Q5ifFcYYZAOY+DayR58OVx+Lq0ayEY905+ztE=;
	b=MyMzEIPlGidn9fHYWux2EjvRTil49SgrSzyy0LF/fVJIX0t/5KeAKH56b/hNw0e7QyFp
	 HblPOqzGMk/GSAcEIqYIfe9hCJ+hqLrJgbH6lvcdwry0SIp4IuiMCVsSZYdZNJ8DfoUQZ
	 sToIZB8Bi0bgfz4TFQ1K++Vw8NX79/lmw0rKQ9nzgnWZcAf+xgi1r2MW1SBAm7KnbznKL
	 FHsdrJxpEGn6vAH1/pgfAtuqtHI6WrGG9dmec+2/8qNFEwnScWBfC0/JhnJ9SW4S/qeks
	 fJXCc1M+RtlG6IlGIr4qIWPiAv/Qv7oFxMjHw6HIUouHngoM8DQ7ruWzKpYlyJLk31Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmbCB2al;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABB606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FmbCB2al
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BDB1F008A2;
	Tue, 10 Nov 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317758;
	bh=1JfeR9Q5ifFcYYZAOY+DayR58OVx+Lq0ayEY905+ztE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FmbCB2alOgOVzS0WdtrsG0tSkggxs6ZGqBw8FlqXrMdaRl7hqIg152Gp5u/mpTNJR
	 V3h6tI0cFBioryFpdHZEGuVB3jyZJ7wJsxo6aIHUSMtu+y12ctWpUGAnfpLefpLv5d
	 Wf6lx6ge/dKoOAJKD3Vk03iEaHncKTTNDNnb3UmVK4v8iGTMVgQh6/b4cRVA66iLNP
	 exPMkec45E/8wAhS5IM/4lxzEAPURefET24TUZ+5L+8tWlP7VDXQjRiJDDp1HbUWxX
	 UvYRmYqF9lDxNA7eNo2CLgd3NDEpSG1sjJVScN/BEuABu2dL3+VaGbwsN/SITTrQ1L
	 Ik05NCUbZ4fBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Tue, 10 Nov 2026 08:35:55 -0500
Message-ID: <20261110133548.1755536-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110133548.1755536-1-sashal@kernel.org>
References: <20261107051915-failed-6.12-1b207c85551f@kernel.org>
 <20261110133548.1755536-1-sashal@kernel.org>
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
index 5b15b8fb87c39..d62802f4f12e3 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1026,7 +1026,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -1069,16 +1069,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
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
@@ -1103,7 +1093,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1129,6 +1119,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
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

