Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641793;
	b=rBHlr5RMHRYyb2c8X0VfQTc6hdqqcZnR+loIO3ReWJfHXcOsviziEbl1WCNbZwWAAiks
	 p5toXaWkwC7OSWMQYz/Os1S4CUvKUKFTn2CUWcngcMXKXIvf6aImUq4u09OME/3Z449jq
	 oYdJjDEsQojuun5DelVeGfDA7ZnwWaRL9eiOKX5g23133cwSo9nJatOOXo/MNFfNapQzj
	 XwA3ei57+J8JkugLv4K9GxmrUkgaVu0RgmnpMjo0PySc+3SiobkElzGQb7eEXsyeVn1KF
	 1hwQdGWM4sbmay2EP9C9lEfxZxXmRKf2TZcYw5vezw4GsSilhuedc5Ayd4y8keOCOOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641793;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eb9RopIYT+ljVTiKWZHX7HLN8fV6BBqL99DL0urTTQI=;
	b=rAc/r/xk7JUcMelO4GVI/HJ21HRibYQjPVK0rZqf33KclCfMZ+M5cjt4JJfceNxiYkcH
	 6fzl9EulDcPrdFYZs+Y2vsksWknDm7djHei8pqznYthFCp6UtImbP+Vr6vJlHG8YabvEI
	 WUoPWvGn+9HpjVOIpDUSe3+hapMDNaaCIpQ/YpDV5pKblk8wkqtNW785Kx5h0W7rXn3tC
	 p3LiBvshJuc330S1AzvR30ni7PQsn7zl5T6exH33mBm7dJdrAAIqDHzQAVLxRsBsy4YJ4
	 mc9wN/3DT+0n8OGKcEaWwFD7dOPgn9sOT6uZ6tjo6S5EjC2udp5fBStWuvrlu26SCFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FezV9WyR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF5606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FezV9WyR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C469B1F000C4;
	Wed, 25 Nov 2026 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795641792;
	bh=eb9RopIYT+ljVTiKWZHX7HLN8fV6BBqL99DL0urTTQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FezV9WyRH0Dun5qxz0/a2oI4id4sGbp+ZtnjjmA8726n2W8wTAVPgfP1f/Nft6qJ2
	 yktJ4ANPDvLrgFACwTk1XVhCp0eTz57F/T5KKMaAc6ui0MhgQWLKw30uPHNmccLMAs
	 4GeWQiMO4L5SXlKboEEWiNVZ2il1a2ta9urtmZgHaMrXrIUHMDH1QJBAIePHJnykKh
	 VIxFQwCjkfLrO6ZKK6+mhy27UCt+lYhDYNVTEmjiWbjDICpLBA+NxvqNFQQ5+9Q+y+
	 3KuBFJ/1xxJghxKAwxLbwUT2EeOkTfI0ONCPJRjR9cNmrwqPLfY8mky2cW/GQXwDqX
	 k8XJOOHaedx4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] gpio: mvebu: name regmaps to fix debugfs collisions
Date: Wed, 25 Nov 2026 16:23:09 -0500
Message-ID: <20261125212303.1542971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-octagon-dullness-c22c@gregkh>
References: <2026112517-octagon-dullness-c22c@gregkh>
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
index b2e13b13bfbfb..af60639e69b25 100644
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

