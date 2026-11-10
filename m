Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319269;
	b=r5zRWfUfPSzNI1p9T+MPiILPhNtJNWUh0exO7MOxItCqMdiszTsbNSpbQSn9MDliWKNI
	 J7OUT8jUtojwi/S2Wq+jITDE/cef5BxmDAZgv/zIDdRNi5Q2QkEeQzpeiUhvAMvu2mUU2
	 lzXAhr2/hCIP37eJkHo15caqkJnc3N1rVIbLHLTyWvqJyF6LSqykPm3KJq0RHucDmHi05
	 lgHhXM29quThKBfFC5LMnQ7U0MEBcqdg1zeBwevj1VqVoyfY8qLlLqi6dyCp689tO3BKW
	 R4Hj3yEGISNbe96ToaacDDyIl1R3ANWdrUkYbvxKH3T7Vy6kpFpuYUgoRmWqxu4gRWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d/2gAWlBQUpfayoVyk5lNK3DbIaurIPgr4GG4hsfiDM=;
	b=oP7HCwBlN/WvZi5lzYwh11jMldCNE0IPu3BpBrnKv4rZ+g7ZTV3032TR1NcmwpyXkv0p
	 Dp3LuNk66s8XC1Ll0LFvoN6rVWwWc/MjUFg7PQiP9kSXyLDjyntzyR9EcOJNK+7hXd1BW
	 6NGkA4lthFGtXrof7azNMBZomh3F42UxuqQE2shOC2ctU0nlGTLlOlP8h74FsJNQiOsRI
	 BvefF7GzSuejUGz3vIbaaQBJw2tkn/Inpwc+CALE/e3mTPU9THTlpM42Q9XYHStC9X1cn
	 lvMj4NEtVH4nG0iPipNgDkHiuDZq0oEG56bRLYHN3cRIjANmzA02nuN/wXrdc3ctxrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcyOqTd+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC3C606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lcyOqTd+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F9D1F0089F;
	Tue, 10 Nov 2026 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319269;
	bh=d/2gAWlBQUpfayoVyk5lNK3DbIaurIPgr4GG4hsfiDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lcyOqTd+YUTzGh0NYh25rOuDJwhOX9pOMMgIe8frjolL4eFe1BJUX6zj4IkEDM1vc
	 Vt/WMc+0kxH3aHNBDSnZymTka0d7GBIrtBwT++CE+X6Qw1wzjCxrv6/EQh9SeTbXHq
	 UMWxZAw0gx90/mQl7BCDgUS8xJrJhuUa9fhfKDD4lriWbcyknQUdcvZu/dSiweLUmj
	 JumP1Z0s5R4NI38f5IH1PoMm4g+4XB1iiFnY6LAubaSfrU4UGOO1onUKxGwIi3vS+l
	 UHBEu/W1VczTDAZA3z4jtya3XiwFzfQhKtdJU/U9ZHTsZtiyzmVcBOttK4sCbNzVA5
	 ywydUb/oZ/31w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] ASoC: stm32: i2s: remove irqf_oneshot flag
Date: Tue, 10 Nov 2026 09:01:05 -0500
Message-ID: <20261110140053.1802242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061902-failed-5.10-1b207c85551f@kernel.org>
References: <20261107061902-failed-5.10-1b207c85551f@kernel.org>
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
index bc369d064e48a..7a2a0b6402528 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -854,7 +854,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
+	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request returned %d\n", ret);
-- 
2.53.0

