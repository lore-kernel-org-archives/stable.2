Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318558;
	b=Mb2jBF2TxDXFgcpThjW118Q4YBRPuuFwN18kLnCDrixa0UyZ2tupV0UWwpWuUq4/HU0z
	 KetWO8J7+YIwROyYFBD5aZe5YHS+6t+7mw0ox1bpHagnxFmYN2qVSH+fodG5/7dcDyobz
	 RyjbfWHRO1UpoVd4pFCl5YP23J5uwLgEcl4jId2TEFfTHBT+ZYNVeZ8jYlP2H0W5YsfNA
	 ZtHLIhkvRVVLD0BtOT0FFij0WmPPHZ08ExW6beBmf1zreJOZOEv+3Gb0QjEvFhS8TbPyq
	 4K4XUelRIYyVTsDXWwrifDY4cpQFSd3fy+5BNqwcTgD2medfr/K/yVL058N2OFEPCCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gPVjBySQqLdvhDBooXYdK5NYJHmV5kc7LijnvmgyC9s=;
	b=GOMsh1RF/vVJWFPMOSdU1m1Ha4C3iclGJPFVgm8if2Nr30emJBIxyjeO0D5QDVe0k8UZ
	 XhYoBfY9RQHbLQYv4mKYK5RDJyD7qxcr1T/MCScI38qHhitrnYE/5tCf57xAAJ5t/iIGW
	 DQodK5XpOx57/sPRgg4vnFWGAmjrtkxAKIpFc1UAxK+ZD9OoF8NH0tBNU49UKo13lsCo1
	 1BxBav9XvviSfsEB5KHG6JfvqxM5D8an8jXjN1VO04HxgnwOOzdAaWSisrKp0NKS0qTuG
	 xWbU/l97w5YXMjlOwrV71SEn/4gKppIeULgfqtdvX6fmLc8lxMwYppASaGooQMic8IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DM39CM/w";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF71606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DM39CM/w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9CB1F0089F;
	Tue, 10 Nov 2026 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318557;
	bh=gPVjBySQqLdvhDBooXYdK5NYJHmV5kc7LijnvmgyC9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DM39CM/wOvhGLMGX1NY2wBUGYVv5A4G2dTK4r1Wk1VwPcrP3aVAtm739gyob7ptep
	 x72aNSnOYVeIuNXBWZodphvRqSfH4CQhMc2DKfYpE/8Oqp+b0Fde7op5W6XseG37Iv
	 x3ip75bFJF8G84HCpOeRN0yaFHVPM7MrnYYq9pD/Cwi56EsyxRQeLmoLJVq+22PQBl
	 9kb8avKfrf0fYzrW0Hy/mV0YsixZVteaMazD7VoSrASb0tumUvK8/sCUEDRbEnPQbB
	 RWHFP+v0E3+thFlIeeocGAgzadC9H2QMT4sDP0lx7safxTlKTE1Eg8n0su5NYQ+us1
	 i1pZ5jdWukwYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] ASoC: stm32: i2s: remove irqf_oneshot flag
Date: Tue, 10 Nov 2026 08:49:14 -0500
Message-ID: <20261110134908.1790593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060220-failed-5.15-1b207c85551f@kernel.org>
References: <20261107060220-failed-5.15-1b207c85551f@kernel.org>
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

From: Olivier Moysan <olivier.moysan@foss.st.com>

[ Upstream commit 7c0f8f1462c9edeaa202a2cbea1bde0960434b09 ]

The IRQF_ONESHOT flag allows to ensure that the interrupt is not
unmasked after the hard interrupt context handler has been executed
and the thread has been woken. The interrupt line is unmasked after
the thread handler function has been executed.

The STM32 I2S driver does not implement a threaded IRQ handler.
So, the IRQF_ONESHOT flag is not useful in I2S driver.
Remove this flag to allow the interrupt routine to be managed
as a thread in RT mode.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Link: https://lore.kernel.org/r/20221110084406.287117-1-olivier.moysan@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1b207c85551f ("ASoC: stm: stm32_i2s: request IRQ after regmap initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 08db73c2ed782..cd91d59ce227a 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1075,7 +1075,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
+	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request returned %d\n", ret);
-- 
2.53.0

