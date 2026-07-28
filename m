Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E93446C5
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248875; cv=none; b=qA/sbnzWdMRH0VUvmS7gOx+WZw7LyghKjmwn0TLakyMAhp4olj38tXDTwm2vKQNuvbAFYRp5Uiz5+e81YarOJJ2b2bWYMwfLN72GPn/+lA7Eqjavl/3btki6OYxYk28TehstDFH5Q3o+FozgI+znC2Fb6XDj5fPac0gqNPp3Nu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248875; c=relaxed/simple;
	bh=C/eZPrnoQSMKGDAQysLS/wxXqbo7paJC/mEnWr8S+WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RICQpynYBmH1+0CFRUZuSCGw5NwL5qG4Fieod6SAucs3PvRi6LRndIeSIvNhIb4qzN/DVWA9E4jCV/+5LRYe1u2AyM/gAapLPXOHB+KO56DFQyjxUggVSlrlBEudh2aZsGTFLxyNR9fW5yO4tXnegr1rJecbPEoSy++slIT2QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSgcyC2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSgcyC2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE981F000E9;
	Tue, 28 Jul 2026 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785248872;
	bh=PfYThwL9ux7t+RR9a5vdhe/QhIcSE0u1rs9w47AepBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZSgcyC2dKypd16TaaED8/pkDp2AHqtXfmSENIuI4mSVJSsnxudo2PK1UBPph4qCSf
	 AjTlcrS1r7hq2yt5anCswJE88FOPqOD5+GoULdTjcD/rNemII2tVy6CA2QIt63cKFP
	 69yrZwc+36vvYmLBYFp7o63mRlGhUlk/0kU0bExCuAyPJDkYjR6hM5pJFLMghZ9mgX
	 NjMrN6GVjUZS6jGVhg14WrrRomUFmfLURirjkfdLhX8Jekxpcmnnxh8hMhYMrf8qwC
	 SH36OrlC3N9khcTUdxIe+PoilGKFmfkk4YY5OWLQZlgMH1yiZrrIcVP70JwA/JL33V
	 7Cp39KaDysj5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] treewide: rename pinctrl_gpio_direction_input_new()
Date: Tue, 28 Jul 2026 10:27:49 -0400
Message-ID: <20260728142750.4096390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072048-oven-revivable-04e6@gregkh>
References: <2026072048-oven-revivable-04e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 315c46f9b696be82972290d50349c7824276b844 ]

Now that pinctrl_gpio_direction_input() is no longer used, let's drop the
'_new' suffix from its improved variant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: d3e91a95b2b0 ("gpio: tegra: do not call pinctrl for GPIO direction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mvebu.c                     |  4 ++--
 drivers/gpio/gpio-pxa.c                       |  4 ++--
 drivers/gpio/gpio-tegra.c                     |  4 ++--
 drivers/gpio/gpio-vf610.c                     |  4 ++--
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c    |  2 +-
 drivers/pinctrl/core.c                        | 15 +++++++++------
 drivers/pinctrl/intel/pinctrl-cherryview.c    |  4 ++--
 drivers/pinctrl/intel/pinctrl-intel.c         |  4 ++--
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |  4 ++--
 drivers/pinctrl/mediatek/pinctrl-moore.c      |  4 ++--
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  4 ++--
 drivers/pinctrl/mediatek/pinctrl-paris.c      |  4 ++--
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     |  4 ++--
 drivers/pinctrl/pinctrl-as3722.c              |  4 ++--
 drivers/pinctrl/pinctrl-axp209.c              |  2 +-
 drivers/pinctrl/pinctrl-ingenic.c             | 11 ++++++++---
 drivers/pinctrl/pinctrl-ocelot.c              |  4 ++--
 drivers/pinctrl/pinctrl-rk805.c               |  4 ++--
 drivers/pinctrl/pinctrl-st.c                  |  4 ++--
 drivers/pinctrl/renesas/gpio.c                |  4 ++--
 drivers/pinctrl/stm32/pinctrl-stm32.c         |  4 ++--
 drivers/pinctrl/vt8500/pinctrl-wmt.c          |  4 ++--
 include/linux/pinctrl/consumer.h              | 13 +++++++++----
 23 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 53c678ba6c51d8..3ead4c95fa3d0a 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -345,7 +345,7 @@ static int mvebu_gpio_direction_input(struct gpio_chip *chip, unsigned int pin)
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an input GPIO
 	 */
-	ret = pinctrl_gpio_direction_input(chip->base + pin);
+	ret = pinctrl_gpio_direction_input(chip, pin);
 	if (ret)
 		return ret;
 
@@ -365,7 +365,7 @@ static int mvebu_gpio_direction_output(struct gpio_chip *chip, unsigned int pin,
 	 * Check with the pinctrl driver whether this pin is usable as
 	 * an output GPIO
 	 */
-	ret = pinctrl_gpio_direction_output(chip->base + pin);
+	ret = pinctrl_gpio_direction_output(chip, pin);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index b90357774dc04e..15eb2f83d28390 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -266,7 +266,7 @@ static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	int ret;
 
 	if (pxa_gpio_has_pinctrl()) {
-		ret = pinctrl_gpio_direction_input(chip->base + offset);
+		ret = pinctrl_gpio_direction_input(chip, offset);
 		if (ret)
 			return ret;
 	}
@@ -295,7 +295,7 @@ static int pxa_gpio_direction_output(struct gpio_chip *chip,
 	writel_relaxed(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
 
 	if (pxa_gpio_has_pinctrl()) {
-		ret = pinctrl_gpio_direction_output(chip->base + offset);
+		ret = pinctrl_gpio_direction_output(chip, offset);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 49ff77c3ad198a..4ad71df6e59a85 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -179,7 +179,7 @@ static int tegra_gpio_direction_input(struct gpio_chip *chip,
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 0);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_input(chip->base + offset);
+	ret = pinctrl_gpio_direction_input(chip, offset);
 	if (ret < 0)
 		dev_err(tgi->dev,
 			"Failed to set pinctrl input direction of GPIO %d: %d",
@@ -199,7 +199,7 @@ static int tegra_gpio_direction_output(struct gpio_chip *chip,
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OE(tgi, offset), offset, 1);
 	tegra_gpio_enable(tgi, offset);
 
-	ret = pinctrl_gpio_direction_output(chip->base + offset);
+	ret = pinctrl_gpio_direction_output(chip, offset);
 	if (ret < 0)
 		dev_err(tgi->dev,
 			"Failed to set pinctrl output direction of GPIO %d: %d",
diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 314dfaa6338574..b23f30a5440c77 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -117,7 +117,7 @@ static int vf610_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
@@ -135,7 +135,7 @@ static int vf610_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
 		vf610_gpio_writel(val, port->gpio_base + GPIO_PDDR);
 	}
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static void vf610_gpio_irq_handler(struct irq_desc *desc)
diff --git a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
index 3fda4446d70ba7..a54bbed4490254 100644
--- a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+++ b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
@@ -1096,7 +1096,7 @@ static int lochnagar_gpio_direction_out(struct gpio_chip *chip,
 {
 	lochnagar_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int lochnagar_fill_func_groups(struct lochnagar_pin_priv *priv)
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 3b6051d6321811..03bfdcbc3325d7 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/gpio/driver.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/machine.h>
@@ -864,29 +865,31 @@ static int pinctrl_gpio_direction(unsigned gpio, bool input)
 
 /**
  * pinctrl_gpio_direction_input() - request a GPIO pin to go into input mode
- * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
  * as part of their gpio_direction_input() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
-int pinctrl_gpio_direction_input(unsigned gpio)
+int pinctrl_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction(gpio, true);
+	return pinctrl_gpio_direction(gc->base + offset, true);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_input);
 
 /**
  * pinctrl_gpio_direction_output() - request a GPIO pin to go into output mode
- * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * @gc: GPIO chip structure from the GPIO subsystem
+ * @offset: hardware offset of the GPIO relative to the controller
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
  * as part of their gpio_direction_output() semantics, platforms and individual
  * drivers shall *NOT* touch pin control GPIO calls.
  */
-int pinctrl_gpio_direction_output(unsigned gpio)
+int pinctrl_gpio_direction_output(struct gpio_chip *gc, unsigned int offset)
 {
-	return pinctrl_gpio_direction(gpio, false);
+	return pinctrl_gpio_direction(gc->base + offset, false);
 }
 EXPORT_SYMBOL_GPL(pinctrl_gpio_direction_output);
 
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index de07b0837a04f4..205236a7efaeb3 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1222,14 +1222,14 @@ static int chv_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int chv_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int chv_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				     int value)
 {
 	chv_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip chv_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 2c357a69e03452..ca99a5d46a0d21 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1005,14 +1005,14 @@ static int intel_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int intel_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int intel_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				       int value)
 {
 	intel_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip intel_gpio_chip = {
diff --git a/drivers/pinctrl/intel/pinctrl-lynxpoint.c b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
index 5d1abee30f8f15..712f3ede193722 100644
--- a/drivers/pinctrl/intel/pinctrl-lynxpoint.c
+++ b/drivers/pinctrl/intel/pinctrl-lynxpoint.c
@@ -614,7 +614,7 @@ static void lp_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 
 static int lp_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -622,7 +622,7 @@ static int lp_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 {
 	lp_gpio_set(chip, offset, value);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int lp_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 526faaebaf77c0..319da66d4f3293 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -471,7 +471,7 @@ static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
 
 static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 {
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
@@ -479,7 +479,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 {
 	mtk_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 096213d6188393..6f09ace0db424e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -798,14 +798,14 @@ static const struct pinmux_ops mtk_pmx_ops = {
 static int mtk_gpio_direction_input(struct gpio_chip *chip,
 					unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
 	mtk_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int mtk_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index ee72c6894a5d7e..ab1c34e5a582eb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -899,7 +899,7 @@ static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
 	if (gpio >= hw->soc->npins)
 		return -EINVAL;
 
-	return pinctrl_gpio_direction_input(chip->base + gpio);
+	return pinctrl_gpio_direction_input(chip, gpio);
 }
 
 static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
@@ -912,7 +912,7 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 
 	mtk_gpio_set(chip, gpio, value);
 
-	return pinctrl_gpio_direction_output(chip->base + gpio);
+	return pinctrl_gpio_direction_output(chip, gpio);
 }
 
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
index ac4c69132fa035..10687b07f20ebf 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -169,7 +169,7 @@ static int npcmgpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 	struct npcm7xx_gpio *bank = gpiochip_get_data(chip);
 	int ret;
 
-	ret = pinctrl_gpio_direction_input(offset + chip->base);
+	ret = pinctrl_gpio_direction_input(chip, offset);
 	if (ret)
 		return ret;
 
@@ -186,7 +186,7 @@ static int npcmgpio_direction_output(struct gpio_chip *chip,
 	dev_dbg(chip->parent, "gpio_direction_output: offset%d = %x\n", offset,
 		value);
 
-	ret = pinctrl_gpio_direction_output(offset + chip->base);
+	ret = pinctrl_gpio_direction_output(chip, offset);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pinctrl/pinctrl-as3722.c b/drivers/pinctrl/pinctrl-as3722.c
index f0e5d87ac50b92..4151656f6245f5 100644
--- a/drivers/pinctrl/pinctrl-as3722.c
+++ b/drivers/pinctrl/pinctrl-as3722.c
@@ -502,14 +502,14 @@ static void as3722_gpio_set(struct gpio_chip *chip, unsigned offset,
 
 static int as3722_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int as3722_gpio_direction_output(struct gpio_chip *chip,
 		unsigned offset, int value)
 {
 	as3722_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int as3722_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 7ab20ac15391e8..a646b24a8bcb37 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -119,7 +119,7 @@ static int axp20x_gpio_get_reg(unsigned int offset)
 
 static int axp20x_gpio_input(struct gpio_chip *chip, unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 9e46d83e5138c0..7eba78a549b55e 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -131,6 +131,8 @@ struct ingenic_pinctrl {
 	struct pinctrl_pin_desc *pdesc;
 
 	const struct ingenic_chip_info *info;
+
+	struct gpio_chip *gc;
 };
 
 struct ingenic_gpio_chip {
@@ -3559,14 +3561,14 @@ static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
 static int ingenic_gpio_direction_input(struct gpio_chip *gc,
 		unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(gc->base + offset);
+	return pinctrl_gpio_direction_input(gc, offset);
 }
 
 static int ingenic_gpio_direction_output(struct gpio_chip *gc,
 		unsigned int offset, int value)
 {
 	ingenic_gpio_set(gc, offset, value);
-	return pinctrl_gpio_direction_output(gc->base + offset);
+	return pinctrl_gpio_direction_output(gc, offset);
 }
 
 static inline void ingenic_config_pin(struct ingenic_pinctrl *jzpc,
@@ -4050,7 +4052,8 @@ static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			break;
 
 		case PIN_CONFIG_OUTPUT:
-			ret = pinctrl_gpio_direction_output(pin);
+			ret = pinctrl_gpio_direction_output(jzpc->gc,
+							pin - jzpc->gc->base);
 			if (ret)
 				return ret;
 
@@ -4170,6 +4173,8 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	if (!jzgc)
 		return -ENOMEM;
 
+	jzpc->gc = &jzgc->gc;
+
 	jzgc->jzpc = jzpc;
 	jzgc->reg_base = bank * jzpc->info->reg_offset;
 
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 83b415e1cec164..1152a83b765417 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1779,7 +1779,7 @@ static int ocelot_gpio_get_direction(struct gpio_chip *chip,
 static int ocelot_gpio_direction_input(struct gpio_chip *chip,
 				       unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int ocelot_gpio_direction_output(struct gpio_chip *chip,
@@ -1795,7 +1795,7 @@ static int ocelot_gpio_direction_output(struct gpio_chip *chip,
 		regmap_write(info->map, REG(OCELOT_GPIO_OUT_CLR, info, offset),
 			     pin);
 
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip ocelot_gpiolib_chip = {
diff --git a/drivers/pinctrl/pinctrl-rk805.c b/drivers/pinctrl/pinctrl-rk805.c
index 7c1f7408fb9af9..65f8743c6cc36b 100644
--- a/drivers/pinctrl/pinctrl-rk805.c
+++ b/drivers/pinctrl/pinctrl-rk805.c
@@ -166,14 +166,14 @@ static void rk805_gpio_set(struct gpio_chip *chip,
 static int rk805_gpio_direction_input(struct gpio_chip *chip,
 				      unsigned int offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int rk805_gpio_direction_output(struct gpio_chip *chip,
 				       unsigned int offset, int value)
 {
 	rk805_gpio_set(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static int rk805_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index cf7f9cbe604400..507985f7ba212c 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -714,7 +714,7 @@ static void st_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int st_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	pinctrl_gpio_direction_input(chip->base + offset);
+	pinctrl_gpio_direction_input(chip, offset);
 
 	return 0;
 }
@@ -725,7 +725,7 @@ static int st_gpio_direction_output(struct gpio_chip *chip,
 	struct st_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__st_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output(chip->base + offset);
+	pinctrl_gpio_direction_output(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index ea3d38b4af8da4..4e9183be5f7eaf 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -164,7 +164,7 @@ static void gpio_pin_set_value(struct sh_pfc_chip *chip, unsigned offset,
 
 static int gpio_pin_direction_input(struct gpio_chip *gc, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(offset);
+	return pinctrl_gpio_direction_input(gc, offset);
 }
 
 static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
@@ -172,7 +172,7 @@ static int gpio_pin_direction_output(struct gpio_chip *gc, unsigned offset,
 {
 	gpio_pin_set_value(gpiochip_get_data(gc), offset, value);
 
-	return pinctrl_gpio_direction_output(offset);
+	return pinctrl_gpio_direction_output(gc, offset);
 }
 
 static int gpio_pin_get(struct gpio_chip *gc, unsigned offset)
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 2b8b7d3eec9b1d..988db6fe1174cd 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -240,7 +240,7 @@ static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int stm32_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int stm32_gpio_direction_output(struct gpio_chip *chip,
@@ -249,7 +249,7 @@ static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
 
 	__stm32_gpio_set(bank, offset, value);
-	pinctrl_gpio_direction_output(chip->base + offset);
+	pinctrl_gpio_direction_output(chip, offset);
 
 	return 0;
 }
diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 6fac30de1c6a88..639446bba37360 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -528,14 +528,14 @@ static void wmt_gpio_set_value(struct gpio_chip *chip, unsigned offset,
 
 static int wmt_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 {
-	return pinctrl_gpio_direction_input(chip->base + offset);
+	return pinctrl_gpio_direction_input(chip, offset);
 }
 
 static int wmt_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 				     int value)
 {
 	wmt_gpio_set_value(chip, offset, value);
-	return pinctrl_gpio_direction_output(chip->base + offset);
+	return pinctrl_gpio_direction_output(chip, offset);
 }
 
 static const struct gpio_chip wmt_gpio_chip = {
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 019fecd75d0cfb..143995980a70ec 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -20,6 +20,7 @@
 struct pinctrl;
 struct pinctrl_state;
 struct device;
+struct gpio_chip;
 
 #ifdef CONFIG_PINCTRL
 
@@ -27,8 +28,10 @@ struct device;
 extern bool pinctrl_gpio_can_use_line(unsigned gpio);
 extern int pinctrl_gpio_request(unsigned gpio);
 extern void pinctrl_gpio_free(unsigned gpio);
-extern int pinctrl_gpio_direction_input(unsigned gpio);
-extern int pinctrl_gpio_direction_output(unsigned gpio);
+extern int pinctrl_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset);
+extern int pinctrl_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset);
 extern int pinctrl_gpio_set_config(unsigned gpio, unsigned long config);
 
 extern struct pinctrl * __must_check pinctrl_get(struct device *dev);
@@ -77,12 +80,14 @@ static inline void pinctrl_gpio_free(unsigned gpio)
 {
 }
 
-static inline int pinctrl_gpio_direction_input(unsigned gpio)
+static inline int pinctrl_gpio_direction_input(struct gpio_chip *gc,
+					       unsigned int offset)
 {
 	return 0;
 }
 
-static inline int pinctrl_gpio_direction_output(unsigned gpio)
+static inline int pinctrl_gpio_direction_output(struct gpio_chip *gc,
+						unsigned int offset)
 {
 	return 0;
 }
-- 
2.53.0

