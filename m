Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642352;
	b=3IpZ0MNVRQ5xX9EYwj62kyv0OTffbQz2XMJxgKJGTrT1UEehTU7YiLIw52y5G8NxH66n
	 k2jOnbLEaW96ss8v9RIx8Fj0M7Ut2T/Vc9BX0hp6eNsNt+TxIG7wZ2SrsYC7MRZH8vfqM
	 oNrlslIDJqzD68qttfTxQKFq1P3KUnKaXJgak3ctdbG3q8Jl/UIUKlsR2EAES7uV6iKSP
	 OlBBL22TP3906heJ8vV0wyY6qFEfSf79Hrb7fHqgEozUTUF75KKyWBriK6IOouLktvp9e
	 KhG0eOBc/tt8erj6DoghN/8QAX7EVBlxWSZgY1WOyFH089FX4VBVCsCHAbsoq6XpIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642352;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sX205rk4wMcjvQs6LysjkJre/CBX3amrvAtEHo71h6A=;
	b=i9O3SmhpAxCedMdwPQSz/jmTRmD9k//kWIlhwjQZucgdJSifF/nyJEn2IDCCKoWK61AO
	 8XlUywmKoqFnZpl7oVChJmLtc2gt1rT9c/zygQeJzecWRHWAYVhO1DSW7pmeTrVKfBDUJ
	 GvXHO6qpV6fKWHCbqOP7SZArcx9QOuGJ18+/7kwcQtsBCPjpOZ4z77mZjnEqhQ2n+nSJU
	 hVBJP07uVhpanw7/jntgX657p7K4TtS8sVbd37MYXkUeD/bglTvqDEkVpiYMGEcfutBEI
	 zo0OxdvKVaQVBuBnf5dHWH3OzZgBclxX3u640AVD4qd9fTxxh0PRdAxj8d5tU5M4GSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6A+oATN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D5606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K6A+oATN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E931F000C6;
	Wed, 25 Nov 2026 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642352;
	bh=sX205rk4wMcjvQs6LysjkJre/CBX3amrvAtEHo71h6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K6A+oATNwDettQLwYI2OvgQQMfhsqe3FzkzIWDd1DEhc+IREmKNx1k6v2VH6LsKOB
	 Vz2ChYxDA9grt3J/pNF5X9KpwjssSjfJG/1Sc80fybNRC8Q4mQIDSijw09BfT+Kbdi
	 NH6/Uw9ywCZq3IN8vEMu00qLwJTStucn7eYCCbfrhyHJdgB0oIuGhnQhN9i6ZZWfVL
	 aZ92XjrdmUb2hN/M8JRvonjUegjxNJQ+B6x6DAI6HbCTyX1QQbfCuZl23q+INCq1z6
	 1CrGS2bBHk0D+blCBWr1vfaFwVqqrKCpf8TmsM4MENEBk45nMcdSu4H0r1MAJ5zctb
	 C5VmFt8ZDdLyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] gpio: mvebu: name regmaps to fix debugfs collisions
Date: Wed, 25 Nov 2026 16:32:29 -0500
Message-ID: <20261125213224.1556380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-hatchling-drastic-a78d@gregkh>
References: <2026112518-hatchling-drastic-a78d@gregkh>
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
index 0abf413170324..8e893aef83d56 100644
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

