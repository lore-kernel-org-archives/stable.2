Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318015;
	b=iyZLO+yY4CoiY7/s+nOo4UchY78352S39n4r33qx9er4VRSvHwyU1vsuVMZZCudN172s
	 6XlAIEcDk30D4QEZgZziWccA4hB782YwMwOtFGpwfo/TQ6nG0qMkvxA47VkgXuuJUPojt
	 iNqawSqmAux1907EZ8csSoMP3ME2WG8vRbQxCgQp/66MkFcQMxQaRFvvCib2lnYyTbNU5
	 l+Mw8ZdbqQWIr9oXT5PmBIHZepDRSddiA4XllVMJWLaQ2S2jseUBSnxT1SKU785/osZLd
	 3mU6E0Np6AjB1c3NwrskviWbNtoBeq9hWtOF1sIlxJ5ntrQxUWeKMBTZ5mXARMgxtEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318015;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5C1AnwLy1w6PDyIt4NYrCl95yE7SHMfoGS0jeF6OG3I=;
	b=xtPUDbyzX4zAVZuOIHB/4T6QfbomfW58P66MpW8aV71tQtvQQD4m6z1KbsayQbVuqIbA
	 ZZ6+4QPJ13HXNPj4Xbai+3pZgHvz0iJm0TCSiy7mPYEKdR06izT1rrgxCX9NZYS3Z2qWH
	 91G1qlZk5hTWL0ti2AVfueIAMXDtNTgQyeJOKnhB4l6VbLdcr4RzmtGyxty95gMtF/7Ie
	 eoUbc2n6/iyHhYqLN/25XhqH5aWautrdyZCxUJP0Skob+KCWivuenVVpTDu/i9lRgdjfr
	 MXODHIWuoEh+1V6JrlkJkojc1mhz4gvYq94J42WlBI0oFA/xU+KJRlzfjPpxZXpf6vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWHJ6eEN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14C606A337
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWHJ6eEN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBCB51F00922;
	Tue, 10 Nov 2026 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318014;
	bh=5C1AnwLy1w6PDyIt4NYrCl95yE7SHMfoGS0jeF6OG3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UWHJ6eENHjnnshxnVrWVwFq3GzrXl7L8weev/QpgzEqLDApOuDg+ZgblzCn1zRLx3
	 wPQT0Z9KIHDYfzzFUPII9fn1QT8lLMfxYPAH6u0xNGpAviTvBaTk4lWIFe4Fk/6UHJ
	 cu5JtgpRDSlbB6sWHN7SSQTVGK0hRPkSXb4wNqkfQBq0dKlKP0L9ej3HRtJY/uvquj
	 82nXDY/EK7TJ+0Ltg4+ZaFX0IRikVesBA6ABUWJLulcvFGm6Ps7V8eBClW5bDTt1dC
	 dBySglUeclr0BrOqpaDNhkaRpAHJLvg58zOukNTxDl3S4yvwd7f3uuv6imlNn4RSGS
	 t3t5tY38Ydo3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ASoC: stm: stm32_i2s: Drop redundant error messages
Date: Tue, 10 Nov 2026 08:40:11 -0500
Message-ID: <20261110134005.1774027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053148-failed-6.6-1b207c85551f@kernel.org>
References: <20261107053148-failed-6.6-1b207c85551f@kernel.org>
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

From: bui duc phuc <phucduc.bui@gmail.com>

[ Upstream commit a6cdfb6230944082e7be64f9166eed64656b1162 ]

Both devm_request_irq() and snd_dmaengine_pcm_register() already log
failures internally. Drop the redundant error messages and return the
original errors directly.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
Link: https://patch.msgid.link/20260720074044.87528-3-phucduc.bui@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1b207c85551f ("ASoC: stm: stm32_i2s: request IRQ after regmap initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 06a42130f5e48..4e4d8d0ed7bd7 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1079,10 +1079,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
-	if (ret) {
-		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
@@ -1136,7 +1134,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
+		return ret;
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
-- 
2.53.0

