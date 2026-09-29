Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D01345725
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692615; cv=none; b=Wmg/jfQIom50eytO6wD3ZkMYZ7s8hpbnHK3Vrg42j9ftYffR0xOrsJikrOHFKSdBbUeUhl42UKlKAVLCpw3YAHfg7XZeXT5T83ygUdjvIWOcOTsSL77W6OnNlBoVJUu84FwJwY1dDFb07Q8YbXAeoIiE7Frt+jhLFUsUjKkLr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692615; c=relaxed/simple;
	bh=oJj5tRHxXa24x49eDQrlaCEEz5kNaJijRwulDQDl+So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfcV+5U/xvToWgQMbYXAuUwsFb55vDXZ1gJ+8+yyfngw7JD4DcE/b2xvr6bAw9iyiIPKR7tO/gNGhq25OErOlrrzjIotpO+HrQWVR2LbsOVLd9IbwVACkM1H0Tom7Tl1kcXmJewlx7aiomdq2lNThzpQpxG4Tz+in8ROao3I+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com; spf=pass smtp.mailfrom=wirenboard.com; dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b=Bj8mTEvt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b="Bj8mTEvt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a00d8bec5aso6268935e9.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1790692611; x=1791297411; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cQEi0ZMmNurxfNzMhWWpr+Ah8Bq4EEhV/XWBfJvQlkY=;
        b=Bj8mTEvtY0JsosAiiZwPd6XK7xY6UvnL8iWlwTu3pukom3R8tNBXRC7wU7aJsDjP4T
         aChuI+6drhm3jo76Y1+DN0gNBMPLlghfc06Mwy1ADRRjaZv0pD/xBC+quBrA8JFs6igf
         D8C6q4WGp46jSsgllJmIqUstuj9AHY15GVLon4AdGSatT68hTvhHukgAo34xcZ8FwnSr
         vfvNToT6pDR+9Oyu6ecxbNJ4g+tWPLehY1kBYUH0k6M76AYlnKqDafXYyt9B2sBk0I/d
         9QoamThvsWY1d9q6RXiqASWP9C5DBDtZENNmoLWSD6gHKsy0l0BvmghZYLSuUgr2C9yD
         xjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692611; x=1791297411;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQEi0ZMmNurxfNzMhWWpr+Ah8Bq4EEhV/XWBfJvQlkY=;
        b=NXinsjSRHG36/PIdYdy61U5VoeFOuNvmi/aLOjryz3e1pSUuzcBNIJ2gHwzTJFqzm8
         XW7pCRVTszWKPe9KaIdPkbLQ0U2s0V9AQ7YrwsTfaepL/ldiKIdSDs1wkI6mkDNYNlfi
         xILJHXcI/gYs7+4e4HF/lQN1I3+m26/BFHuLwSz74oHqwSGgUWoIP56RBLhax0ZZWfUu
         O6vChQulZH8fDq1G6xGYI2NnG11DShmY4zn3tqp92Izx259lkV0lJjQnpqieUNM138kU
         wa95IaEsextbZHC+KiJkbMDSNd5yKRmhe5Jd3h6fMUrHD0gGI4eKkFY66dTC0JlgJHmc
         OQNg==
X-Gm-Message-State: AFuF++kCA/H6A//P4DZbEtvVeBkaFdeqOaIZpdEwOiXlWFth4Yc48kNh
	IC9/JcZ1wKQpcU+tgW/bv0LlT/7QIfeKun0FV15Xc3hZdNGAblr690L7dFN4YZKcsXs+gkTXPTd
	qvwj2
X-Gm-Gg: AYBFou3AkM39/651wyUoHRzSTMqtsPGTv55ggZjIPz3xVJ5OzO8H59DZlkIRxVBisll
	NGZ0SusRBmOCKXUQcf2uDuFhHtp/wuMfLl1vWnIRkvtHX4GwZ0PRXW63SPIAdqqqv0AklAGhFnG
	lca2gDNWQ3VVf6nwh/4um9d4xvivIyjyLxhJ6C7rZODLnvikBa6od38yWxW4hi4Jo2+xgMvX5xC
	v+OzywOk1QdqyhzTCOWbqlSqHh36MYoYo2pAX+pg/vW6AtYVL+hGA1VsJAzl5I3Th8Hvf1gW0lt
	978WPoG9kpuybaiKxUYMN7oXIEG7Q7AXjNCQplERDADgvDEyjZ+OyPrhgzv07c3YqgN6Cxvx/nA
	sFWMFdgbWcDqWj7Hc+XOTGTGmyPp+Zzdqlk78edkrn/8I79gu6ICi8Gp6bq92Pjsn8lT1Noxu8P
	toFdVABsJ5uFBe/98NhZ+yuT0Ip4fQ3tTG4DGwq4pOa59pxu3v5jbxGpYhkwRoRdyAdJSnKSlsX
	eaw+dR+ERGFBkCbrmn3yijsnRclsOYf
X-Received: by 2002:a05:600c:8411:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-49fe66ef334mr275664035e9.25.1790692610504;
        Tue, 29 Sep 2026 07:36:50 -0700 (PDT)
Received: from localhost.localdomain ([85.137.25.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf868b5sm117975385e9.1.2026.09.29.07.36.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 07:36:50 -0700 (PDT)
From: Ilya Titov <ilya.titov@wirenboard.com>
To: stable@vger.kernel.org
Cc: Ilya Titov <ilya.titov@wirenboard.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 6.6.y] pinctrl: sunxi: keep a shadow copy of the data register output latches
Date: Tue, 29 Sep 2026 17:36:48 +0300
Message-ID: <20260929143648.18798-1-ilya.titov@wirenboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026092929-storage-cure-cb51@gregkh>
References: <2026092929-storage-cure-cb51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Allwinner SoCs, reading a bank's data register returns the pin level,
not the output latch, for pins that are muxed as inputs.  Writing a GPIO
therefore corrupts the output latches of all input-muxed pins in the
same bank: the read-modify-write in sunxi_pinctrl_gpio_set() reads back
their pin levels and writes those into their latches.

This breaks emulated open-drain lines (e.g. a bit-banged I2C bus from
i2c-gpio).  Such a line is released high by muxing it as input and
letting the pull-up raise it, so any concurrent GPIO write in the same
bank stores 1 into its latch.  Driving the line low afterwards is a
non-atomic data-then-mux sequence in sunxi_pinctrl_gpio_direction_output();
if the poisoning write lands between the two steps, the pin actively
drives high (push-pull) instead of low.

Observed in practice as sporadic glitches on a T507 board bit-banging
I2C on port E while other PE GPIOs are toggled.  On a scope the failure
is unmistakable: on a clock pulse where SCL should fall to GND, the line
instead steps *above* its idle high level for the whole low phase — the
pad drives a strong push-pull 3.3 V high, higher than the level the
pull-up sustains on the loaded bus — before the next transition recovers
it.  The same can hit SDA, corrupting data instead of clocks.

Steps to reproduce on any sunxi board with a bit-banged (i2c-gpio) bus:

  # background: toggle any other GPIO of the same bank, e.g. line 21
  gpioset -c <chip> --toggle 100us 21=0 &

  # foreground: keep the bit-banged bus busy
  while :; do i2cdetect -y <bus> 0x50 0x57; done

  # watch SCL/SDA with a scope or logic analyzer: sporadic clock-low
  # phases driven high (above the pull-up level) instead of low

The bank spinlock cannot help: the racing write is a perfectly valid
whole-register RMW that faithfully writes back what the hardware
returned.  There are no set/clear registers on this IP to write a single
bit atomically.

Fix it the same way gpio-mmio handles hardware whose data register read
does not return the output latch: keep a shadow copy of each bank's
latches, base the read-modify-write on the shadow, and only write the
register.  The shadow is seeded from the hardware at probe time so pins
left in output mode by the bootloader keep their state.  Pins that reach
output mode through the gpiolib paths write their value (and thereby
their shadow bit) before the mux switch in
sunxi_pinctrl_gpio_direction_output(); pins muxed to gpio_out directly
through a pinmux node bypass that path, so sunxi_pmx_set() refreshes
their shadow bit from the latch (readable once the pin is in output
mode) to keep them driving their pre-existing level.

Seeding the shadow reads the PIO registers at probe time, which requires
the bus clock to be enabled.  The clock was only requested at the very
end of probe, after devm_pinctrl_register() had already claimed the pin
hogs described in the device tree - which mux pins, and thus access
registers, with the clock still gated.  Move the request ahead of both.
Boards whose bootloader leaves the PIO clock running are unaffected,
which is why the pre-existing hog problem has gone unnoticed since
commit 950707c0eb5c ("pinctrl: sunxi: add clock support").

Fixes: df7b34f4c3d2 ("pinctrl: sunxi: Fix gpio_set behaviour")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Titov <ilya.titov@wirenboard.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
(cherry picked from commit a13f7f5d14af9baf34eb12c25962f8d3542b281d)
---
Backport of a13f7f5d14af to 6.6.y.  The only conflict is in
sunxi_pinctrl_init_with_variant(): upstream had already converted the "apb"
clock to devm_clk_get_enabled() by the time this commit moved the request
ahead of devm_pinctrl_register(), while 6.6.y still does devm_clk_get() +
clk_prepare_enable() and unwinds through a clk_error label.  Resolved by
requesting the clock with devm_clk_get_enabled() at the new location --
available since 6.4 -- so the manual unprepare goes away and the three
former clk_error gotos land on gpiochip_error instead.  The rest applies
as-is, and the resulting patch is identical to the one sent for 6.1.y.

Tested: the bug was found and the fix verified on a Wiren Board 8.5.1
(Allwinner T507) running a 6.18-based kernel, where a bit-banged I2C bus
on port E survives 200 probe rounds while another PE line toggles every
100 us in the background.  This backport itself is build tested only:
arm64 allmodconfig, all 26 PINCTRL_SUN* variants, W=1, no new warnings.

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 88 +++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  7 +++
 2 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index c5b954c9537d..e182812c66fa 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -792,6 +792,21 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
 	writel((readl(pctl->membase + reg) & ~mask) | config << shift,
 	       pctl->membase + reg);
 
+	/*
+	 * A pin muxed to gpio_out directly through a pinmux node bypasses
+	 * sunxi_pinctrl_gpio_set() and drives whatever its output latch
+	 * holds.  Now that the pin is in output mode the data register
+	 * reads back the latch, so refresh the shadow to keep such pins
+	 * driving their pre-existing level.
+	 */
+	if (config == SUN4I_FUNC_OUTPUT) {
+		u32 *shadow = &pctl->dat_shadow[pin / PINS_PER_BANK];
+
+		sunxi_data_reg(pctl, pin, &reg, &shift, &mask);
+		*shadow = (*shadow & ~mask) |
+			  (readl(pctl->membase + reg) & mask);
+	}
+
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
 
@@ -948,21 +963,29 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
 	struct sunxi_pinctrl *pctl = gpiochip_get_data(chip);
-	u32 reg, shift, mask, val;
+	u32 *shadow = &pctl->dat_shadow[offset / PINS_PER_BANK];
+	u32 reg, shift, mask;
 	unsigned long flags;
 
 	sunxi_data_reg(pctl, offset, &reg, &shift, &mask);
 
 	raw_spin_lock_irqsave(&pctl->lock, flags);
 
-	val = readl(pctl->membase + reg);
-
+	/*
+	 * Reading the data register returns the pin level, not the output
+	 * latch, for pins muxed as inputs.  A read-modify-write based on
+	 * the register would therefore corrupt the latches of input-muxed
+	 * pins in the same bank (e.g. an emulated open-drain I2C line
+	 * released high), making them drive the wrong level once switched
+	 * to output.  Base the read-modify-write on a shadow copy of the
+	 * latches instead.
+	 */
 	if (value)
-		val |= mask;
+		*shadow |= mask;
 	else
-		val &= ~mask;
+		*shadow &= ~mask;
 
-	writel(val, pctl->membase + reg);
+	writel(*shadow, pctl->membase + reg);
 
 	raw_spin_unlock_irqrestore(&pctl->lock, flags);
 }
@@ -1486,7 +1509,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct pinmux_ops *pmxops;
-	int i, ret, last_pin, pin_idx;
+	int i, ret, last_pin, pin_idx, nbanks;
 	struct clk *clk;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
@@ -1520,6 +1543,37 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->irq_array)
 		return -ENOMEM;
 
+	/*
+	 * The bus clock has to be enabled before the pinctrl device
+	 * registers, as the pin hogs claimed from there access registers.
+	 */
+	ret = of_clk_get_parent_count(node);
+	clk = devm_clk_get_enabled(&pdev->dev, ret == 1 ? NULL : "apb");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	/*
+	 * Seed the output latch shadow from the hardware so pins the
+	 * bootloader left in output mode keep their state; see
+	 * sunxi_pinctrl_gpio_set() for why a shadow is needed.  This must
+	 * happen before the pinctrl device registers, as pin hogs can mux
+	 * pins to gpio_out and thereby update the shadow.
+	 */
+	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
+	nbanks = DIV_ROUND_UP(last_pin + 1 - pctl->desc->pin_base,
+			      PINS_PER_BANK);
+	pctl->dat_shadow = devm_kcalloc(&pdev->dev, nbanks,
+					sizeof(*pctl->dat_shadow), GFP_KERNEL);
+	if (!pctl->dat_shadow)
+		return -ENOMEM;
+
+	for (i = 0; i < nbanks; i++) {
+		u32 reg, shift, mask;
+
+		sunxi_data_reg(pctl, i * PINS_PER_BANK, &reg, &shift, &mask);
+		pctl->dat_shadow[i] = readl(pctl->membase + reg);
+	}
+
 	ret = sunxi_pinctrl_build_state(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
@@ -1574,7 +1628,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->chip)
 		return -ENOMEM;
 
-	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
 	pctl->chip->owner = THIS_MODULE;
 	pctl->chip->request = gpiochip_generic_request;
 	pctl->chip->free = gpiochip_generic_free;
@@ -1607,31 +1660,20 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 			goto gpiochip_error;
 	}
 
-	ret = of_clk_get_parent_count(node);
-	clk = devm_clk_get(&pdev->dev, ret == 1 ? NULL : "apb");
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto gpiochip_error;
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (ret)
-		goto gpiochip_error;
-
 	pctl->irq = devm_kcalloc(&pdev->dev,
 				 pctl->desc->irq_banks,
 				 sizeof(*pctl->irq),
 				 GFP_KERNEL);
 	if (!pctl->irq) {
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < pctl->desc->irq_banks; i++) {
 		pctl->irq[i] = platform_get_irq(pdev, i);
 		if (pctl->irq[i] < 0) {
 			ret = pctl->irq[i];
-			goto clk_error;
+			goto gpiochip_error;
 		}
 	}
 
@@ -1642,7 +1684,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
@@ -1674,8 +1716,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 
 	return 0;
 
-clk_error:
-	clk_disable_unprepare(clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
 	return ret;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a87a2f944d60..244b0039480a 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -80,6 +80,7 @@
 #define IO_BIAS_MASK		GENMASK(3, 0)
 
 #define SUN4I_FUNC_INPUT	0
+#define SUN4I_FUNC_OUTPUT	1
 #define SUN4I_FUNC_IRQ		6
 
 #define PINCTRL_SUN5I_A10S	BIT(1)
@@ -173,6 +174,12 @@ struct sunxi_pinctrl {
 	int				*irq;
 	unsigned			*irq_array;
 	raw_spinlock_t			lock;
+	/*
+	 * Output latch shadow, one word per bank.  Seeded lockless at
+	 * probe before the pinctrl device registers, protected by @lock
+	 * afterwards.
+	 */
+	u32				*dat_shadow;
 	struct pinctrl_dev		*pctl_dev;
 	unsigned long			variant;
 	u32				bank_mem_size;
-- 
2.54.0 (Apple Git-157)

