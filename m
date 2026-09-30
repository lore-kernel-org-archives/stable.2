Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E53264C3
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766846; cv=none; b=alIXlzNLh/zgkc1PLsEMyZZ76VAIk6WSd2NVqltcagPRkwLJLvwBjwgsJTJuzP74AhIScXn8mJiXiQrabJVQmWFRqCA8NmdVJPRXNe6s6cSbvt/gVDN2F4yO/f2o7Fab3qBmH8LpVuLbCTQMoEuFftpAyJA/WrKvePC50g+7PEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766846; c=relaxed/simple;
	bh=J6+QqYCRGP7ZwIOpkIDuk7w1uDG/BCv++nkRorpS2t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7Q642EHdoDWcE1yim8u+8S16ipMaOpFi4REV/6lQYD/dj58hsMtQJ5UDKLKDtUj/CSI8BHjrr+2c1SW3MAjrqag3Tgtb54nTXoPbotuQrkpyEVmX1SIIyB23NdgwgMvM2AnR9WShsB3RbR42DlSeTMRlT9ZBSKoblBdbY9bdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBqiwqN0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBqiwqN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF2A1F000FF;
	Wed, 30 Sep 2026 11:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766845;
	bh=6IcYpK+2HIQCaIDGI42tAB3xrps9myGN3OTqVEugvtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBqiwqN02X+VeHZ1wXBd+774u+ylUZ16YpvKL00zmS7gdIes6PUDMWdtcMyft4UJP
	 aoNdNgZfx9Pkup8/Ac70OA6YQqy6c26uhmEA6dNSibxv2W43cte4o7Luwj9Ndv8RLb
	 BXBAWiuWhbBsKq78F/sCHm2HzoV77yhj2sVSFAv4dqeTGehuuwMx2Q5EuV6+SksSvi
	 ZwwQ1PXYZmbCo5PkeP5rqJTUh6uLj+JR1FjSsougi4qnb3vr2V1eu0yJQqGKSDN7co
	 I+DiWZSkjgsDVtNvlFe4bWv3rp6LMuYHJRvJrygkEk35No123lab5qjn7Yw/IqJ9C3
	 B0g0msD0FE3dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samuel Holland <samuel@sholland.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] pinctrl: sunxi: Refactor register/offset calculation
Date: Wed, 30 Sep 2026 07:14:00 -0400
Message-ID: <20260930111402.1206529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092930-embolism-unproven-18a9@gregkh>
References: <2026092930-embolism-unproven-18a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Holland <samuel@sholland.org>

[ Upstream commit 0bb95ae2672f9e00f471598a515bf4e9c2005046 ]

Starting with the D1/D1s/T113 SoC, Allwinner changed the layout of the
pinctrl registers. This new layout widens the drive level field, which
affects the pull register offset and the overall bank size.

As a first step to support this, combine the register and offset
calculation functions, and refactor the math to depend on one constant
for field widths instead of three. This minimizes the code size impact
of making some of the factors dynamic.

While rewriting these functions, move them to the implementation file,
since that is the only file where they are used. And make the comment
more generic, without mentioning specific offsets/sizes.

The callers are updated to expect a shifted mask, and to use consistent
terminology (reg/shift/mask/val).

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20220713025233.27248-5-samuel@sholland.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: a13f7f5d14af ("pinctrl: sunxi: keep a shadow copy of the data register output latches")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 119 ++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  93 +-------------------
 2 files changed, 89 insertions(+), 123 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 8c9dd9fbfe854..f384bfec6c393 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -46,6 +46,63 @@ static struct lock_class_key sunxi_pinctrl_irq_request_class;
 static struct irq_chip sunxi_pinctrl_edge_irq_chip;
 static struct irq_chip sunxi_pinctrl_level_irq_chip;
 
+/*
+ * The sunXi PIO registers are organized as a series of banks, with registers
+ * for each bank in the following order:
+ *  - Mux config
+ *  - Data value
+ *  - Drive level
+ *  - Pull direction
+ *
+ * Multiple consecutive registers are used for fields wider than one bit.
+ *
+ * The following functions calculate the register and the bit offset to access.
+ * They take a pin number which is relative to the start of the current device.
+ */
+static void sunxi_mux_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * MUX_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + MUX_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(MUX_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_data_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * DATA_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + DATA_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(DATA_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_dlevel_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * DLEVEL_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + DLEVEL_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(DLEVEL_FIELD_WIDTH) - 1) << *shift;
+}
+
+static void sunxi_pull_reg(u32 pin, u32 *reg, u32 *shift, u32 *mask)
+{
+	u32 bank   = pin / PINS_PER_BANK;
+	u32 offset = pin % PINS_PER_BANK * PULL_FIELD_WIDTH;
+
+	*reg   = bank * BANK_MEM_SIZE + PULL_REGS_OFFSET +
+		 offset / BITS_PER_TYPE(u32) * sizeof(u32);
+	*shift = offset % BITS_PER_TYPE(u32);
+	*mask  = (BIT(PULL_FIELD_WIDTH) - 1) << *shift;
+}
+
 static struct sunxi_pinctrl_group *
 sunxi_pinctrl_find_group_by_name(struct sunxi_pinctrl *pctl, const char *group)
 {
@@ -457,21 +514,17 @@ static const struct pinctrl_ops sunxi_pctrl_ops = {
 };
 
 static int sunxi_pconf_reg(unsigned pin, enum pin_config_param param,
-			   u32 *offset, u32 *shift, u32 *mask)
+			   u32 *reg, u32 *shift, u32 *mask)
 {
 	switch (param) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		*offset = sunxi_dlevel_reg(pin);
-		*shift = sunxi_dlevel_offset(pin);
-		*mask = DLEVEL_PINS_MASK;
+		sunxi_dlevel_reg(pin, reg, shift, mask);
 		break;
 
 	case PIN_CONFIG_BIAS_PULL_UP:
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_DISABLE:
-		*offset = sunxi_pull_reg(pin);
-		*shift = sunxi_pull_offset(pin);
-		*mask = PULL_PINS_MASK;
+		sunxi_pull_reg(pin, reg, shift, mask);
 		break;
 
 	default:
@@ -486,17 +539,17 @@ static int sunxi_pconf_get(struct pinctrl_dev *pctldev, unsigned pin,
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
-	u32 offset, shift, mask, val;
+	u32 reg, shift, mask, val;
 	u16 arg;
 	int ret;
 
 	pin -= pctl->desc->pin_base;
 
-	ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+	ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
 	if (ret < 0)
 		return ret;
 
-	val = (readl(pctl->membase + offset) >> shift) & mask;
+	val = (readl(pctl->membase + reg) & mask) >> shift;
 
 	switch (pinconf_to_config_param(*config)) {
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -552,16 +605,15 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 	pin -= pctl->desc->pin_base;
 
 	for (i = 0; i < num_configs; i++) {
+		u32 arg, reg, shift, mask, val;
 		enum pin_config_param param;
 		unsigned long flags;
-		u32 offset, shift, mask, reg;
-		u32 arg, val;
 		int ret;
 
 		param = pinconf_to_config_param(configs[i]);
 		arg = pinconf_to_config_argument(configs[i]);
 
-		ret = sunxi_pconf_reg(pin, param, &offset, &shift, &mask);
+		ret = sunxi_pconf_reg(pin, param, &reg, &shift, &mask);
 		if (ret < 0)
 			return ret;
 
@@ -598,9 +650,8 @@ static int sunxi_pconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 		}
 
 		raw_spin_lock_irqsave(&pctl->lock, flags);
-		reg = readl(pctl->membase + offset);
-		reg &= ~(mask << shift);
-		writel(reg | val << shift, pctl->membase + offset);
+		writel((readl(pctl->membase + reg) & ~mask) | val << shift,
+		       pctl->membase + reg);
 		raw_spin_unlock_irqrestore(&pctl->lock, flags);
 	} /* for each config */
 
@@ -716,16 +767,16 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 				 u8 config)
 {
 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	u32 reg, shift, mask;
 	unsigned long flags;
-	u32 val, mask;
+
+	pin -= pctl->desc->pin_base;
+	sunxi_mux_reg(pin, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
-	pin -= pctl->desc->pin_base;
-	val = readl(pctl->membase + sunxi_mux_reg(pin));
-	mask = MUX_PINS_MASK << sunxi_mux_offset(pin);
-	writel((val & ~mask) | config << sunxi_mux_offset(pin),
-		pctl->membase + sunxi_mux_reg(pin));
+	writel((readl(pctl->membase + reg) & ~mask) | config << shift,
+	       pctl->membase + reg);
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
@@ -856,43 +907,43 @@ static int sunxi_pinctrl_gpio_direction_input(struct gpio_chip *chip,
 static int sunxi_pinctrl_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg = sunxi_data_reg(offset);
-	u8 index = sunxi_data_offset(offset);
 	bool set_mux = pctl->desc->irq_read_needs_mux &&
 		gpiochip_line_is_irq(chip, offset);
 	u32 pin = offset + chip->base;
-	u32 val;
+	u32 reg, shift, mask, val;
+
+	sunxi_data_reg(offset, &reg, &shift, &mask);
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_INPUT);
 
-	val = (readl(pctl->membase + reg) >> index) & DATA_PINS_MASK;
+	val = (readl(pctl->membase + reg) & mask) >> shift;
 
 	if (set_mux)
 		sunxi_pmx_set(pctl->pctl_dev, pin, SUN4I_FUNC_IRQ);
 
-	return !!val;
+	return val;
 }
 
 static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg = sunxi_data_reg(offset);
-	u8 index = sunxi_data_offset(offset);
+	u32 reg, shift, mask, val;
 	unsigned long flags;
-	u32 regval;
+
+	sunxi_data_reg(offset, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
-	regval = readl(pctl->membase + reg);
+	val = readl(pctl->membase + reg);
 
 	if (value)
-		regval |= BIT(index);
+		val |= mask;
 	else
-		regval &= ~(BIT(index));
+		val &= ~mask;
 
-	writel(regval, pctl->membase + reg);
+	writel(val, pctl->membase + reg);
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a32bb5bcb7547..3f37e1fc05a79 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -36,23 +36,15 @@
 
 #define BANK_MEM_SIZE		0x24
 #define MUX_REGS_OFFSET		0x0
+#define MUX_FIELD_WIDTH		4
 #define DATA_REGS_OFFSET	0x10
+#define DATA_FIELD_WIDTH	1
 #define DLEVEL_REGS_OFFSET	0x14
+#define DLEVEL_FIELD_WIDTH	2
 #define PULL_REGS_OFFSET	0x1c
+#define PULL_FIELD_WIDTH	2
 
 #define PINS_PER_BANK		32
-#define MUX_PINS_PER_REG	8
-#define MUX_PINS_BITS		4
-#define MUX_PINS_MASK		0x0f
-#define DATA_PINS_PER_REG	32
-#define DATA_PINS_BITS		1
-#define DATA_PINS_MASK		0x01
-#define DLEVEL_PINS_PER_REG	16
-#define DLEVEL_PINS_BITS	2
-#define DLEVEL_PINS_MASK	0x03
-#define PULL_PINS_PER_REG	16
-#define PULL_PINS_BITS		2
-#define PULL_PINS_MASK		0x03
 
 #define IRQ_PER_BANK		32
 
@@ -215,83 +207,6 @@ struct sunxi_pinctrl {
 		.irqnum = _irq,					\
 	}
 
-/*
- * The sunXi PIO registers are organized as is:
- * 0x00 - 0x0c	Muxing values.
- *		8 pins per register, each pin having a 4bits value
- * 0x10		Pin values
- *		32 bits per register, each pin corresponding to one bit
- * 0x14 - 0x18	Drive level
- *		16 pins per register, each pin having a 2bits value
- * 0x1c - 0x20	Pull-Up values
- *		16 pins per register, each pin having a 2bits value
- *
- * This is for the first bank. Each bank will have the same layout,
- * with an offset being a multiple of 0x24.
- *
- * The following functions calculate from the pin number the register
- * and the bit offset that we should access.
- */
-static inline u32 sunxi_mux_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += MUX_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / MUX_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_mux_offset(u16 pin)
-{
-	u32 pin_num = pin % MUX_PINS_PER_REG;
-	return pin_num * MUX_PINS_BITS;
-}
-
-static inline u32 sunxi_data_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += DATA_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / DATA_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_data_offset(u16 pin)
-{
-	u32 pin_num = pin % DATA_PINS_PER_REG;
-	return pin_num * DATA_PINS_BITS;
-}
-
-static inline u32 sunxi_dlevel_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += DLEVEL_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / DLEVEL_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_dlevel_offset(u16 pin)
-{
-	u32 pin_num = pin % DLEVEL_PINS_PER_REG;
-	return pin_num * DLEVEL_PINS_BITS;
-}
-
-static inline u32 sunxi_pull_reg(u16 pin)
-{
-	u8 bank = pin / PINS_PER_BANK;
-	u32 offset = bank * BANK_MEM_SIZE;
-	offset += PULL_REGS_OFFSET;
-	offset += pin % PINS_PER_BANK / PULL_PINS_PER_REG * 0x04;
-	return round_down(offset, 4);
-}
-
-static inline u32 sunxi_pull_offset(u16 pin)
-{
-	u32 pin_num = pin % PULL_PINS_PER_REG;
-	return pin_num * PULL_PINS_BITS;
-}
-
 static inline u32 sunxi_irq_hw_bank_num(const struct sunxi_pinctrl_desc *desc, u8 bank)
 {
 	if (!desc->irq_bank_map)
-- 
2.53.0

