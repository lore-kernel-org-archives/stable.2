Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317757;
	b=XEtby4bLVNBUCaQgWZnBkfGZ2pWq/zc1R5WMy1qf1Vh0nwh64HEkGTadp3t6TthW7LIX
	 MPo7HBn4PpMUb773bYvYzUHB7PXwowZa6tow8hZwHLmX6AQ6VEBta4dOJWxgkwwNXCaYu
	 vUsPYXubCby0zIFxcefeJEYyIM8XudNS2JLx9meDvJXEuf+b1QZg4YWBq9NmSs38tiIKB
	 mhfY9xa41gdbl+G7IIaezYTCOkuQKGGEkXtEYbFe1fnNyZobl+wpQoynKLjQntPzwQfKW
	 rHONrueRrVqBpXvopVpp4XRgrOpp4ezXBy1dfC54LavrVcQVoVbc4Nnxe+3G7pCbxtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317757;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vingMQTK/f9EVawConj0seZl/9AciAnYGyyAscFFyss=;
	b=T5LMMnEcGhmDicgNSpuomzBSOg85YU37uW0t5Bpe8AWXOYT0PZ6OkuzH31EGOQYfBweN
	 QZA/D6vIoKUVOcLnQY451PBvXVPbtSpar/XkLicrg94dWIH+3uOja5/PqZk2RxUfo487W
	 PM9bEFT3WFlm9t4c4Eg5dMuWKYb7IuckynElUwWyUfWR2vynR2Obxb8P5g5h50HVtBhnT
	 QQX+8ROIfQ0X79y7U2kANtbUIYN4s9f8SXLJyDJWSnKbZJoH0JFV7jDbO1yKLBxbnCXhz
	 3YFAlXEEKMuejQ6N6q+9EkenZCgF58uqAEd4Ydqo3pRv4aMLykncXnjOodjTkq0VcRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOtVjrjV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830E606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOtVjrjV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65DD1F0089F;
	Tue, 10 Nov 2026 13:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317757;
	bh=vingMQTK/f9EVawConj0seZl/9AciAnYGyyAscFFyss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOtVjrjVWVImLNyvapH42BF54fzGbhwdBccusIL2a1GyVobGL9HUgGtVVo9ilHSPN
	 sjCTJmo//2v5OyGAwmFCg+zmZ6t2WEv92bNbzKcv4IJBznU2fZIGvvjm175EnAE0Rg
	 oUbTC9SdUdFsuU4VBZPF1cVs3sk0+znwyihPe3Xy8fsP94wHHIAcK8tGSyt2JWGqLe
	 EHs6cmYfaVPA9UDkUCOVV0APojUvq2trIUttCI8vxX0ySocW1BC1k4bpqpXskBuiM5
	 wEtPqMdYbrmeyCkP9slokKXBa96jrK6aj9ylfE9FkqQvWUi7S40iXaC+Ot9Dq4KJrA
	 9QhISJ9kkUeMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ASoC: stm: stm32_i2s: Drop redundant error messages
Date: Tue, 10 Nov 2026 08:35:54 -0500
Message-ID: <20261110133548.1755536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051915-failed-6.12-1b207c85551f@kernel.org>
References: <20261107051915-failed-6.12-1b207c85551f@kernel.org>
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
index faa00103ee7f1..5b15b8fb87c39 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1076,10 +1076,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
-	if (ret) {
-		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
@@ -1133,7 +1131,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
+		return ret;
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
-- 
2.53.0

