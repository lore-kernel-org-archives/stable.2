Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639767;
	b=LWkTLySYFdLhq7XoVJIY99h9Mec6J5Nu59AhpnsQdmTEoyfX85X8DraZ6eXhit91D7gU
	 f5DgPsi1d+Yydc6+S98W4i+/bh3iDrtFZxUc1yqhk6D3bc8WpnhmA/xxHwC4tLbOnWWgN
	 iqzEOGYYA0U6doN1gg3U+fh4sTyTbX/KQboeGjHRQlH4QbBdVnE+BddrNChVPe83fkZ7r
	 p+o/ls/k8bJ1pzJ66zQq9Q6/t/EvcIJh6XTn2LPheHT+e7a+DLCMqA0es/ZVnIKjurQu1
	 S9iw+WKdOo6jqPsw01ZUWfxBdDGpBurR2CfX8DODyM17wvvI2LzCxKuaZhJqRmx4R2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mO6Edzsv1AIggOhVyNTLnFToRyNjokMciseNI23TFbI=;
	b=n24x4YcHqVHgoB8+R/3ZxqtiwptcjARzp9WAMai7916aJTZxjQEvW9GHGXYJeTQAjXVE
	 ljiHXFqqj7DJH8BNchTg+TSgltVx+2rObcb7XvZ1Wrq+9YYr+i6/gb9cKr/y8d9UjYQ24
	 lHXQOQb1wG6DPypINDSn307XIu+nd+W1Ti1W6ctBVLlq344ANZDlihmtz+vY9h9XhW4ys
	 FhppPoPlktkuN4fAm7S0QlUMIsL+dBmJJF6HuM/k/wdRLvTjsJZS3I2hUWEfYBfL1nI3F
	 +fqHY+Guw/JmpVyg6qHRLGHCvPnscUL0nNXltBRHs5secMBug2fPvdJ7Bv5rhL+0uag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1I6JchX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F79606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g1I6JchX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B201F000C4;
	Wed, 25 Nov 2026 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639767;
	bh=mO6Edzsv1AIggOhVyNTLnFToRyNjokMciseNI23TFbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1I6JchX/tZpfRMOE/EX21/tWcdgB8JzGiirLISZ2dcMyaKqSRfyaDehQyN2C60hl
	 EwNJHwWtb24kuz4WsmBOFVNnHUkc3M1kzJ/RXgCJQLabPhdcyeJUBy4EVUy/S6+ALw
	 RqReElvMLcY80dlthKD3FcPPLc9lFLjigQtXgwLGhVYgHqtHvH5G1Kcql2yBPTgazK
	 Z80tUrzTJYPmYjLDRnj+GL/+45wtiVy8CNERhcSIT/NgPp5qrksAxcWX11Z1Gs6xil
	 n73QplYJ25+H17S2O95lMD6T7xwxjzkKZBgSpce8jN/Qccg5/8JFgfuP8wurpYkEqE
	 J6aavhMuUwqRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] gpio: mvebu: name regmaps to fix debugfs collisions
Date: Wed, 25 Nov 2026 15:49:24 -0500
Message-ID: <20261125204919.1453286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112516-citation-stage-72ea@gregkh>
References: <2026112516-citation-stage-72ea@gregkh>
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

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 4d305c2273123119c27d6e4c822215e650c451e3 ]

Each marvell,armada-370-gpio node provides both 'gpio' and 'pwm'
register windows, and the driver creates one regmap per window on the
same platform device.  The shared regmap_config was unnamed, so both
maps defaulted their debugfs directory to dev_name(), e.g.

  debugfs: 'f1018100.gpio' already exists in 'regmap'

because the PWM regmap (and on Armada XP the per-CPU regmap) claimed
the same directory as the GPIO regmap.

Give each regmap a distinct .name so the debugfs directories become
'<dev>.gpio', '<dev>.percpu' and '<dev>.pwm'.  This only affects
debugfs naming; register access is unchanged.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260905004334.177074-1-rosenp@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Stable-dep-of: 42269cdb3d3b ("gpio: mvebu: fix sleeping-while-atomic in mvebu_gpio_level_irq_mask()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a2796240fe14b..267e6d5bacd0d 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -599,6 +599,21 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 }
 
 static const struct regmap_config mvebu_gpio_regmap_config = {
+	.name = "gpio",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static const struct regmap_config mvebu_gpio_percpu_regmap_config = {
+	.name = "percpu",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static const struct regmap_config mvebu_pwm_regmap_config = {
+	.name = "pwm",
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -868,7 +883,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 			return PTR_ERR(base);
 
 		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
-						    &mvebu_gpio_regmap_config);
+						    &mvebu_pwm_regmap_config);
 		if (IS_ERR(mvpwm->regs))
 			return PTR_ERR(mvpwm->regs);
 
@@ -1135,7 +1150,7 @@ static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 
 		mvchip->percpu_regs =
 			devm_regmap_init_mmio(&pdev->dev, base,
-					      &mvebu_gpio_regmap_config);
+					      &mvebu_gpio_percpu_regmap_config);
 		if (IS_ERR(mvchip->percpu_regs))
 			return PTR_ERR(mvchip->percpu_regs);
 	}
-- 
2.53.0

