Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640849;
	b=GSA2cYGhE8RetQdK5CgOY6KfIACUMTB1WRAqi0YCwlFO0sKD+v75Ke+nKT04uaOqMMiM
	 e91jhj3UVdtfjnLnVT1lDvz8gkfRv0WfOFRjvR2OdLVr5VG05Ry61JKHJptsWtK+EIFdn
	 yAKFB/XJ1AGNRBl2UFlNbciinomfyhdK9WKObZ3u9QKGzaROLh0UnaaXowTcsX+CsU9Cb
	 Y/MoMXZ081oyN/FO2U+ENg/3Ek+1Ib9IM7XngwCkNBRVlB+ph1FaabDn4tSUy9rgMGxaB
	 CZmuZTdiFFyx5LsNOaB7NebIFY1w6rIPeGm6gJZhjaKqMCNTTabCOzZjLifumtDzaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U4ASaoXxhcE67eodzvw+DRWAZ/RX5bVFFB+cvw4v3H0=;
	b=pRBCFmkdtHMhluU2hGiFRBeHglvjFodIMM9nLd8NXcWkIyBfb9N5WQ3FExcS0M6znqlF
	 WV7Wn6VpgMzxp604KWrojx8VqHaUTlA8vQqAKB9CVrFO7nxx6DuImovwVghdEmqfO3AJQ
	 qyD0ZGD0zra21yk5K5BFpevwTJ7OW9zkHI21t4d3BAtmVWdNdMPOALhDbSzDxyy5gka9h
	 0zi/UZyy2jLSWgzma9kQCIGU1pn8qtCs4gWrMBlaXavgWbCUuue/h5yZU/8qy4bjcHzlj
	 0/BQPu5oNHlVW1JLcBAhNh2caTHI6oghSTKYLu/oeZwu2IscPolzN84MWegKtje6Ypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9tM1ARN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39447606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9tM1ARN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA65F1F000C4;
	Wed, 25 Nov 2026 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640848;
	bh=U4ASaoXxhcE67eodzvw+DRWAZ/RX5bVFFB+cvw4v3H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b9tM1ARNDWm4SY3xeT2KNRVc7IuEA3+MmXcXX0yir9yJ5lhKe+KWtVIWm+vrxea8H
	 +ug6eYzNcpMKW6YhZMKGucGy+0wBntsGEAWwgT3rRo3RMKB9gN/gnBlsL492WiF1Bw
	 LXbe0IopnvYZ7ZrPSTd/3zqU7OK51YBeldgwPUpsEWFe6tqe3qWJarsLKaRmIP+LlA
	 0kGpRJATCZaKZcirsHnGDpUlU8WbmEEMBjK1MsvOSOBSWpu9z4Lb9fnNRuUCtX9PoC
	 dKWYbyjqyy+LvVoi/FZSF1znKcX++PT9+9rliDgGTUsArj0I2Nm0vq0ANvXJcolr+m
	 jQuo3y+0mOFKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] gpio: mvebu: name regmaps to fix debugfs collisions
Date: Wed, 25 Nov 2026 16:07:25 -0500
Message-ID: <20261125210720.1518478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-afterlife-nuttiness-c75a@gregkh>
References: <2026112517-afterlife-nuttiness-c75a@gregkh>
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
index 933a335af8c5b..14023051eebe1 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -603,6 +603,21 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
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
@@ -845,7 +860,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 			return PTR_ERR(base);
 
 		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
-						    &mvebu_gpio_regmap_config);
+						    &mvebu_pwm_regmap_config);
 		if (IS_ERR(mvpwm->regs))
 			return PTR_ERR(mvpwm->regs);
 
@@ -1112,7 +1127,7 @@ static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 
 		mvchip->percpu_regs =
 			devm_regmap_init_mmio(&pdev->dev, base,
-					      &mvebu_gpio_regmap_config);
+					      &mvebu_gpio_percpu_regmap_config);
 		if (IS_ERR(mvchip->percpu_regs))
 			return PTR_ERR(mvchip->percpu_regs);
 	}
-- 
2.53.0

