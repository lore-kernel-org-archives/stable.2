Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640276;
	b=4js8PtHliKftdG2eOMlJtdp3xctdb2ult6RdSZbNi9LmY+fGEx/vHG51N4nmJTulEZ78
	 MAXGP6SfGyFKBVJSZ9SkHC9mO7ozm9llPxNxOHlqsPzHVddQFq4gwt9beqAnbuqPTrz1e
	 EfA5A7TiaxCYncxiqYXaVEKIaGas7rGODCAN0cPVsyi3mSjqqzCqOUOuSLF6ok/G3EH7K
	 XU+GBiVykaO3tkmJ8WdEiY0O2dky6DHs5fG3zThRrP2hymxo29teosNkBfCvwzYDuYftL
	 JgfbHS5iwOd8paJr4LdLu45wOFQQfbvqlRr47/+IWwOE6CCR9XRzwwtt1iy0b++Bjiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640276;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jXbdAxBRHEcxRyexxN8zsqVUO69/d4iYqd2ksEIyBBI=;
	b=ezjLNIJuAP2B2GeM72weKEEWLB3Z773xwbt6EeVXWsIZyruACTIBgRXXl3ZzVbZ/MfJw
	 Xv2Krpd6yoPnRK5Ev1wcDRR1KDpe4MfD0BB/1Ys1tEHM3LO1mmnVQ+LX/rqVe69mxbPwT
	 CoOQFSCF14mGKRzCNxzNk1Oi8WmUSkHwJTkktmtXjROje01m42O4gmxY3L2V1QgnuzOnf
	 lxdRdJJLrQhBMevGzJJNtqS3ZQzgj2lLWdTPexyUevj7WjVoAgIWsQLNJAPT7+0nkaG8x
	 Nt9EqBZW8GKU94m0szIcI1tiiMXMQEo2uhfrKIHo/gz6gNYgpe9mQENxXGQErlZoQOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omUyE+uq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0594606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omUyE+uq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020DA1F000C4;
	Wed, 25 Nov 2026 20:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795640276;
	bh=jXbdAxBRHEcxRyexxN8zsqVUO69/d4iYqd2ksEIyBBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omUyE+uqowFIvYsLvJ3TEJ4NhcmtUqw6BfsI5QQxce080TtTFl1f0Cv7MTxqBIBrp
	 ZVmG3dqatI5RbPFmOB39EDxD3K36zt7YNVLa0flNJ2eyEvVcM/3zXT6YPZQDdfz7p4
	 GmnyZjkYDfzV3Ziywte2Dp2du8h2HsEVUwBV4EkSai4Fa4KYYD2fAT5dvgqnjpjDyg
	 vcM4lnWuu8WExCNWy9HT8I6PPoQfwdaQRmG2E6p8VrtbG3ErfyV6apjE0+ydlQxqfo
	 DfzhaipAUkpthAhzYMaPoWQ2QHVXTdD8lwtUvPigT7gARKJXXIEZmG6l5DHzaqVHg7
	 RPX9YVeqEhHxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] gpio: mvebu: name regmaps to fix debugfs collisions
Date: Wed, 25 Nov 2026 15:57:53 -0500
Message-ID: <20261125205747.1491649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-rival-mantis-1c17@gregkh>
References: <2026112517-rival-mantis-1c17@gregkh>
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
index c613d74ed48d0..aa2484a8d8af4 100644
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
@@ -840,7 +855,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 			return PTR_ERR(base);
 
 		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
-						    &mvebu_gpio_regmap_config);
+						    &mvebu_pwm_regmap_config);
 		if (IS_ERR(mvpwm->regs))
 			return PTR_ERR(mvpwm->regs);
 
@@ -1107,7 +1122,7 @@ static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 
 		mvchip->percpu_regs =
 			devm_regmap_init_mmio(&pdev->dev, base,
-					      &mvebu_gpio_regmap_config);
+					      &mvebu_gpio_percpu_regmap_config);
 		if (IS_ERR(mvchip->percpu_regs))
 			return PTR_ERR(mvchip->percpu_regs);
 	}
-- 
2.53.0

