Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643181;
	b=4c4MJmXiBQgqOGVKos9kMZRdNjHhGB0lI4V21DWOPaDzItOkK/DnDVolBu1xYAJk2tGB
	 zdmdrdIw1qGdtM50DSL3EmLP4wgs/md6qK+9ZVjRgIwBzbcrnqvg9kdJjykrPmwq2x7aJ
	 hIyfx5ZIxnUCcNLdSbGyWtEiyZnlPbPzDXlG4GK2J8XfEOCw/ecVurV3ht8Ef90NiqvHP
	 tg9i/EHxF6gJH6mNX3Q5GeFl7lgbuNzz/chL9KScBAERhH9rYuMzd+yPK0O6q9SlJ9X6c
	 ojjtH3So0E8f92mldwKkcwCLfOcts0NNYe7oTtdDxaTgS5gn6jFtfVWvJEHoaPVim8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643181;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5n4bbBfQgeLYAqIhpLtDpZ2DSuhzw3XaIz6mjt6KjkE=;
	b=4CccAMqvVd8D3niQxZswo8j1wny4WapGRCgXLMu+ueU4JVqBcipvnb0BA5QnkmRHGjaG
	 8GoOsBKRsIHNFd94KBXmQwh65C5u2GfBibqtffSbs1NKxSgL5tcMn62bZ/KBeC3g0Iiiy
	 4leCMLiXwLxYrYX67AGiEnIlg1351CDdJsymal8bzPI1YKZm0qsBAyuIM9RC7XmsUx2Uf
	 DgJZl40lbDi/4QXqNPC4EPwYzxqclxEiG2b7GkqBlinn7JBaqGktzKPpX5MpX1KcTqsKW
	 r95TYJkk0DCn+TjMP+ZGrhT8lc/y0sNz0Y9xS/f8wQfmvAsWx+6kcPRCVgW2uVDmQRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwDZbkzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94767606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwDZbkzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7091F000C0;
	Wed, 25 Nov 2026 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643181;
	bh=5n4bbBfQgeLYAqIhpLtDpZ2DSuhzw3XaIz6mjt6KjkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwDZbkzKO23ciqZAHtOsjHLIs4XAOfXI3Brop57dMt72r+TitSRAOxpBmZwaPJrui
	 FlR3IYcbuZIQBHOLwRaXHveUnQE8QedglyHGBbeOzdfJV79KWFFyXBUCj2IqnpYw2W
	 kODa9eXDe2yslVLtCC1IHK4QGy41S6Rb05H4FcuOVjlJihSwJMyv2bd2JikvSAR0jY
	 VNvETjaNmFO+KSNpj4Y7+hf6f0vkbDhbv6UKIbkQos8Rfp7I1nnxr8Sv9isgcLHLf3
	 pPVoWshhDIaxnPe+FJYQ8VcVdTpo2htixUJUQkmsPCCptec6RtmWU3giiuvm5dqoMs
	 6Z04kHdesOrpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] gpio: mvebu: name regmaps to fix debugfs collisions
Date: Wed, 25 Nov 2026 16:46:18 -0500
Message-ID: <20261125214614.1571817-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-hefty-profanity-1c49@gregkh>
References: <2026112518-hefty-profanity-1c49@gregkh>
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
index 68b0fa9f4d97a..8979e7358eedc 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -606,6 +606,21 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
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
@@ -843,7 +858,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
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

