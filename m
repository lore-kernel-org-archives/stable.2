Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318270;
	b=ORdv7dWWLXkym45Dwv8iLxBrZdWApgwB1lSU92boqyMk6PUijfhM+4pgrvmLF9UZMdsK
	 Mn36ZUZulZ6rhCmeIIULA3mI3mBugn8RtgpRrtFFklK5CCwET6cKkOe8vWEbA7XhJkhYO
	 sGOiavi5Z7aqzmUTT0mrj5I36vcAvqXTBV1xEDgkDXdcUBE852SW/qx0pixYBCJ/R+1Da
	 JD8Q8LE4a2yR9L6JywBAqAvXoCdBgorIzxKrLXi93t7f7pfQa7LeaG5f1C3fAdUErJh54
	 chkjODyBMqndbVD+GHsNo+IuDszEgYzvCp65w4ZOLvhaoD/HKv6AbO5VuZAqzHLq5Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sN8ZKQ/6LXBUih5WchQjZV1CHtqMuvEFmK0xFfeWpmk=;
	b=Gi36+S3nAPvRVyo/lJO+T+4Nz+GMOQUtfixJ+m1bC3Cycj5+MaNejZ8MiDL5XO+V8CKa
	 lZqsD9BxFXkhm9OTnpsV+GsJxnoOoaXahJbE9ekcqjJ9gvIrVuhD9lfuYSbFtyK+Ude92
	 M2VzA+tkxfR/AjDc9VjGOZ4eFRO2yujLBLE7uKvJKZh/LD8MasTNhF2qcDL7ehc+NDNi+
	 BSF+qgOAmr4JKHNh+eseldUmHVr4oh3b/sj/ZlUbAIUmJ/kwaj/4eEhT/sCEtEm4HiQut
	 J8K7sKylC1qtdbXRS2ZkoeGo2KAxsTylqWXcvRodx4XyTUuzTa/V17bJloMjWV0b7Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2Gl9Hzr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FE606A332
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E2Gl9Hzr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090161F0089F;
	Tue, 10 Nov 2026 13:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318269;
	bh=sN8ZKQ/6LXBUih5WchQjZV1CHtqMuvEFmK0xFfeWpmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2Gl9Hzre1yAS+WRF5jFqaaTlA3zJJBpfEC6Eqn8w/ZFueA5kV8UsfugXkqkhwDUd
	 OpMYre2rOcjsO6gxNnTTqCnLsBS55SQE0Xe/XWBz23esMXTXB1LtVZ+Y6nmAWzB3qc
	 y50QG07yv5go3VZS80oaKy6Mdy1D2WnoblXgUs0vddoSQnaz09LgZHvm0nTwaZ8DwR
	 1eIEaRiiEfv/CJqtT38i5QN2ZxQJbyH+AATNnK/Gxai4EzgWZvhZiZGBpvu2T2jUS6
	 7pvoUACK8/ct6Op0Zv7cZKGDJ9usBrZ+q53DZ8xBW+KTThYsDZ0B/+JgX6mgaNnDen
	 sq/Knbi/7IR/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ASoC: stm: stm32_i2s: Drop redundant error messages
Date: Tue, 10 Nov 2026 08:44:26 -0500
Message-ID: <20261110134422.1782548-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054431-failed-6.1-1b207c85551f@kernel.org>
References: <20261107054431-failed-6.1-1b207c85551f@kernel.org>
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
index f3dd9f8e621cc..c52613365d679 100644
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
@@ -1138,7 +1136,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
+		return ret;
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
-- 
2.53.0

