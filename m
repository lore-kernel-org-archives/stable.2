Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318560;
	b=Aduiljgrb1ZrvSlY0hDkmuSMGhl+GVMI0APfzy296YxuntZspV8wFqJmaBG9zK43tlxg
	 tAQ/TOhqWG9yf7C1MU7cUZXRriRtUarJ8yRLvfYcd6Mgyffe6gjDsjOa/6ssKF0Y6Ypt+
	 O5yvgW3zi0HCsU1kjkdM6cLz1+Xf7/yRMoc61gDz/rNxl38Stp8jGvAXFb0StPpDMsUTD
	 ZjpsA8t2cRC3WSBgpShtw9CaMzghXOpLp5y4DyLmRCw34Izy9kZz9fHk0fDcZ7crGq2xb
	 X9fmImvHRbkt++/ymW9kMW4Ey9CQ6hDqRwVxCainEe09wJj6kcys4vZ3SNzXIlPpcJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B5LQed9u8pyYuw61vB/6ByXaKrufKI/IADQgHGIG0nA=;
	b=qif4lnOAORFJfR7G//ZyxDir5G93CBj5Fewu3afltqbyEWwhmA5tgoRdJa2k9ji8C3HR
	 eDbRrFj+avOLD7Gg0MOcykXK9C9GNMkfu3CArh/T6Q6Sx9mLHFyGtBICfttujKe8Lj089
	 fZDY7ELYCSDSd8YYa5HvhtwOxF38+gwCLocXeNOybP1Yv04jF/GMQ54mk5zrpwRN0vVJB
	 8mr4HCDHS6acrtJcs1+UWFnNYmjE7bhx4dwO1b+z6shrNRMJMpCX10CDvM5kMzHoCpqmQ
	 0Hw2HwgwUwHKBF1YB1OAplKxuV3PWBC+VGGXLOYIxtrEmOE1dv4LyKHjIuQfsOKo4JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3NBcnV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3809606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3NBcnV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DF01F008BE;
	Tue, 10 Nov 2026 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794318559;
	bh=B5LQed9u8pyYuw61vB/6ByXaKrufKI/IADQgHGIG0nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f3NBcnV+DHyOWBXPBCTi0tL3m/JhHUAkSHdWfUQ6xC8dFJ/H1W7UNzjiMZXf2uFxu
	 i8vvFqYzs3ZEHHqwpgsqK68TdZZT+yK6fragLyHSksxc1M4aLB9xdl0vxm8x7wExcz
	 8iBaoNVj+06b8/43o+5DIQeUt94iu3RbqV4D5yr9W9h0lm5Sp12z+1xmTuu7ty375D
	 DyrTk1Fme3D7WHwJ4eZ0/ZBgnRFmZpqcvo4+YX90/xzq+ZaI3iIx0OCZTy4sFNYO97
	 Le0UieqpsRk7faL6bgoAnX0bd5WEp3VuMkCIVdVHPBAzVgIrlKyxmdAro+cqY93QJk
	 Zm5Boq4s2gY1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ASoC: stm: stm32_i2s: request IRQ after regmap initialization
Date: Tue, 10 Nov 2026 08:49:16 -0500
Message-ID: <20261110134908.1790593-3-sashal@kernel.org>
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
index 2f277e5390ddd..d47f47f505acc 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1025,7 +1025,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	const struct of_device_id *of_id;
 	struct reset_control *rst;
 	struct resource *res;
-	int irq, ret;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -1070,16 +1070,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
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
@@ -1105,7 +1095,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 {
 	struct stm32_i2s_data *i2s;
 	u32 val;
-	int ret;
+	int irq, ret;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)
@@ -1131,6 +1121,15 @@ static int stm32_i2s_probe(struct platform_device *pdev)
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

