Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319270;
	b=npaVbJUSyp1kW38dsfChNU8Z4IZDpM1a7ACSglxiatBcWmJCrbWoZdQx03DsDYlnLxq4
	 MncK1yVqMsgI7NO+/zo3hCa4mZubtnfi0n37j4XP4xrQbagY4YiiPwGILyiM0ocTGuxPm
	 sDAg88pq1+FZFkNKM+v/2qFXNESV02e+gVefKVMwYD0l9ndoI3i/PvFUwo8rQh492NDxb
	 K5OXbrC07Ic+gb3UNwlUsTjo8v32pkCslaSFfCmags+0vi3PrKOL+JSsOwH1eS3essojU
	 afU9u/7IaXBbkKl/r5fgwRfqXG2TilcYTslM7mcpSdrvaRiHVql5PY918UCswo/x0UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ivb1tM6ZCwV+cw0bpccyIW8mAICtvwmK1eEOr/OGf08=;
	b=doabVo3CDNHpW0D6/fLURQhU8RmaPr0W9ZFTtn+eDJZiqoujQginGq7cNknQ5QTrQSIa
	 NNLJX1IeZ0gnPBAWa0pAZWZAW0fh1MgT5aXU7GbcTFfZYdLTMqB34ppHD0sFoQuBFhdMN
	 9B8KHdnMtXyGwLWTCQ8TB3/7w2Dl6Civj3zR6mg2BQ16uwhEYyiiVnksNhVQ3O3tsAZNq
	 oAoDhyuG9Jrm4NG/vYC5//Dgm3rg9Y/oJqBxJ0OBRQkvcnsuUOqdC44BeUZD524G9ZzD2
	 R4LwsV3I6Y1Qse5lb+/ikjQaQQhZCGrQbhf/w3TowVWuaU4E3jFyBldzyMsZeQ2grGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a32KAsxd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF74606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a32KAsxd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601C11F008A1;
	Tue, 10 Nov 2026 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319269;
	bh=Ivb1tM6ZCwV+cw0bpccyIW8mAICtvwmK1eEOr/OGf08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a32KAsxdcKBKJlx/696jVtKg65QlvJHCg7T+BAVivhu/gYE+T8Is0OYMLv7MAwTfY
	 K/ISQAHRI0O6mGjbuKE3EvrPLSoR+uh6QuSn14TOlrZwDH4hq9YgsF56qu2Nk/ldfF
	 /s+eLS9cATToYU/ehkzbUTEUWFaLHn/lPmgKSTz87fyI3RrBUmlBNjYybCJr80UdsJ
	 FomwVuFz3tOJQRTetQqU/QytwoUrNRUwIxOXB6TB9YG2tjCRQcXiHVwGZZ1hd0VCPZ
	 CisWefIjLaaxqAES3ebkESsyXebioDLJVWcni6IArofwApUoxEQYVKnP3eUdp2MFiw
	 eF5HDbkNtWGjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] ASoC: stm: stm32_i2s: Drop redundant error messages
Date: Tue, 10 Nov 2026 09:01:06 -0500
Message-ID: <20261110140053.1802242-2-sashal@kernel.org>
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
index 7a2a0b6402528..4a6869d535d4f 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -856,10 +856,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
-	if (ret) {
-		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
@@ -914,7 +912,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
+		return ret;
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
-- 
2.53.0

