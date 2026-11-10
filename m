Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318559;
	b=P/KESyFXptns5GAb6Vce4cfdE1z7RgLs7eHs1KLexr62xWicbLn7HwHwXvbLicsoAFIj
	 s63UxRNANPhySjeuPzPsbjLuUENPGzF4WPRbYvr/ZmcwfL0Mj96VHyO9G1dnj5CKvTNh7
	 KCEfKWLvNZ0EAYS+6ShW+WVwWmqRTNCvU0l3dCVGsYsI00c/c3rTxGzrsWUn02CFxJkG9
	 Kkt4k+JTvDNgaxhXRE0vU9jXAsH8X8ALMaU82ul484+vc9cHyCEpCZvZuS/ui4NfFiVRO
	 yZcreoMK1xCvtmLG5L6mypXYmu4vacZORl5lJ3urHc05zHfFfTL1Ftjc9f6b/oFdpVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EHH5OGxpoVk6ds8PGQ+JRZl4y9QyMOHFhhVuIrySAJ8=;
	b=5LojbSdHzwu3PY0E1EsIPajFw/e4csECVjaDe8A5pQAlR1GsCZdx11yhgm6kwtplwbHM
	 5l0tOzEBYpyHjiEwjIT2sSKubvDXuC4zWd8ZYEubnWpRoN0W7t2XFyvhy8cmZqglZCXAn
	 ZQWqZVdEi75CZQ2OUoo6Zp/V0Vnf6Ue99zFHnpyRXg6P4xZf91UPThTgeL5QAcSapJ0ai
	 EL/CUeLq1HnsmEpHVbEUEImPOtelGWaB2PWXf5JhkV6IrLE6xdsPjgG/lZOCodnp7T0i5
	 uOdshwBrYLeCOFb0FUXgxkk4Bxk9dWpBTjSEgOVLiqczTj0ZPHrVeWOMFA4cLuXRYrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6VXl6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB960A2601
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pl6VXl6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242A41F008A4;
	Tue, 10 Nov 2026 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318558;
	bh=EHH5OGxpoVk6ds8PGQ+JRZl4y9QyMOHFhhVuIrySAJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pl6VXl6aPvqGI5AxSpFV8yLSu6AvmJ95L7777aN/KOpK2v3eBir32beC3SgJTxTMa
	 7EOgD5BdTQO06HEaZN6rE58k+jlFzuMVmygxEvShk51nqs6qZzAdom01t2FeHXoAO/
	 Y6BcwpLisKFgQm3zlUfYw5xwAY3TWAadeD6DxkIoD8NICkCPTcZQkKLIQvh3jj6rj4
	 +G5Rs959EatPOx7HRuZT7H+UC3Tvun7zExNzNEG9aa+Jt4bC1wAlA9Jqe42eELj568
	 kgkPNJDhBheE1hflA+s7ihoObykAAb03Ku3bss1LIUr3gciqwE3APS3GHWz7cnKC9b
	 FnUq1spOrrQog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] ASoC: stm: stm32_i2s: Drop redundant error messages
Date: Tue, 10 Nov 2026 08:49:15 -0500
Message-ID: <20261110134908.1790593-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110134908.1790593-1-sashal@kernel.org>
References: <20261107060220-failed-5.15-1b207c85551f@kernel.org>
 <20261110134908.1790593-1-sashal@kernel.org>
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
index cd91d59ce227a..2f277e5390ddd 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1077,10 +1077,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
-	if (ret) {
-		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
@@ -1135,7 +1133,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
+		return ret;
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
-- 
2.53.0

