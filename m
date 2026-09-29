Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA53CBE69
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692624; cv=none; b=syWwZ6hHIJl6Spumd7ycD0GoKt81Es2zYdbVXXpDB6wP3mEmf1i7lVLFBTNZq701w9LvNacdYVeILIHCy+fpLCuFAGyhheaoH3WAR4aDcNPgbOh/iiipZVZh3WD2Q4l7V2DOlDHDv5bSMWRm8j02KjrBaMkPc92Ejcf3fAI8Q+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692624; c=relaxed/simple;
	bh=BTknYIxJARgy3GfU50QFZwe7VvSB2sra8BALvCRz9XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2f4/SFN6ewyDsKTzDbpAU7gWAQrsSJ0DF6rGvS9z0tYBji8W7s3zokQQhX9pt1zEqNrumetOTOtvdoqVln/2/jYjBF7MhIjVnaF2wcMrz7OTR01+KIv4sy1TfMqLAzthv69iCzu6sSWdwZkbGQSjbUajDKHMJ7KHfKLwaAIcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com; spf=pass smtp.mailfrom=wirenboard.com; dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b=hjQ79YAV; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wirenboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wirenboard.com header.i=@wirenboard.com header.b="hjQ79YAV"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e66390995so24137025e9.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1790692619; x=1791297419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2N63wpA9NiU09kIvlkMvSeIfrRNpryU66Kez4f8XLA=;
        b=hjQ79YAV+Q7sRCieorDfNKvajEL3jePReepvEFo9uRfzGH+NsYCrYigiiQ7migAhdN
         RvJ1+vVXkdM8WmUhHRCUcNcp+KynDfvW3zTDLWXRsdFGt2PNyxJG6qKZmzm1PClE5KxK
         jmqj4oCDu2zh6OQF7UIRsiS8gmuvwMnU4wOBxC/C+crOR9jT2ZC4CorzYK/fpZhPzl1g
         JEap8+QaKNuk73Sxe96Hl8z5bF60ZDTUxEPsl2G6UORcDVORGSNzYzQopgzecKXYYhd+
         4sz17qwgBAzLWLCIW+0UN5TKc4fWycbi9HixdXzOb/4C91wdmX/djbpB1H4yV8ZUzmed
         3iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692619; x=1791297419;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2N63wpA9NiU09kIvlkMvSeIfrRNpryU66Kez4f8XLA=;
        b=XVeO5Gx0+AfS4HwRoSDtfGoZftFdQuqO+eYxPaIlcx/2WQufaHQ0UzUIMMxQPK1OYd
         80tJsZsuVImlHbC1i/wJymcu4CtOUfATLYV5VFKLpQSHGyoey0UoYgOU6ArDfo/86hJX
         0cbY5ituQ8N0tKeXxBUIhnjcPXUBi1Xlhpyz3u1mn2HWANweWMzXSg91QFqLhdXqcb0l
         6rqUsPUJghmqiaEZKNv1PlLARj2ayK5mrn4pOZ6WbjM9RMLKGkgmZks2xYoTrZDkkjjV
         16oewNBu6ytDZw9lC+VwvarpF0BEapw8OQmmiQjYMyud+B6JtG+0OinKzmpdyGI0aOcO
         rf6g==
X-Gm-Message-State: AFuF++mO4PqvQt+NsspWb8Vsho5FnXvYgYlXlqvF7bHHwbe4oiHYfyp0
	PI7irU/vFvrYgEaxM6UJ8gHeOZAPqVVMCqzbX3C9XwxK62ple+mwqIk74beg1MQzpOH/rUxXJp8
	Bv/gs
X-Gm-Gg: AYBFou2za0wiXIlideYEjEPhH8wtb7nZkEYVCHix6XgFJ0Vj7e0kzfivRw7t9WZk3DW
	Z+8X9dmSFu1d/wnOqBFNkusfLOO34ogCSs/EkjWLUchWOY9sc81X4AH+Dl6tss1gONng3cwFtF+
	JkjXDr2LcyjFB+s8lx3qaLqPQ0fbo/g5ukd4t+/w+mXvuCE/moNggydzvyvy/GYpqG7vytUGALE
	1wxFAGuNS2xnWetGV/IkPTUzqI6JK8JsvPfKqWVi6g190e8e3OEjLJFuMl8pCIP1ngNwe2JD8Na
	nrNbrUX43tf46rhjsIB58FmXqHH2YrP0ZApq+YAloDDtbf5QYmUR4jenphUQUcAQ9/gkZAGAZbY
	kI4wVxFthRaGUnh1Kgm56471IQxVg//6h/FhUes57Q6EF6iqwzhzN3reWqWC0B/YWfHDcFnExx6
	HISyZ2z+rwqbVDxK42HGBBbDc4uTcGAlGHYvYXJjqHqZDyDpYryiCHZiQBlgjcTQeQjeKFp5zq7
	YDscItKTzcZvLCSU/GiZrWn9/i3StaJcg==
X-Received: by 2002:a05:600c:4e90:b0:49f:bd0d:59f5 with SMTP id 5b1f17b1804b1-49ff06e506dmr217206665e9.18.1790692619140;
        Tue, 29 Sep 2026 07:36:59 -0700 (PDT)
Received: from localhost.localdomain ([85.137.25.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b150sm78034155e9.7.2026.09.29.07.36.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 29 Sep 2026 07:36:58 -0700 (PDT)
From: Ilya Titov <ilya.titov@wirenboard.com>
To: stable@vger.kernel.org
Cc: Ilya Titov <ilya.titov@wirenboard.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 6.1.y] pinctrl: sunxi: keep a shadow copy of the data register output latches
Date: Tue, 29 Sep 2026 17:36:57 +0300
Message-ID: <20260929143657.18855-1-ilya.titov@wirenboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026092930-ethics-jawless-929e@gregkh>
References: <2026092930-ethics-jawless-929e@gregkh>
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
Backport of a13f7f5d14af to 6.1.y.  The only conflict is in
sunxi_pinctrl_init_with_variant(): upstream had already converted the "apb"
clock to devm_clk_get_enabled() by the time this commit moved the request
ahead of devm_pinctrl_register(), while 6.1.y still does devm_clk_get() +
clk_prepare_enable() and unwinds through a clk_error label.  Resolved by
requesting the clock with devm_clk_get_enabled() at the new location --
present in 6.1.y -- so the manual unprepare goes away and the three former
clk_error gotos land on gpiochip_error instead.  The rest applies as-is,
and the resulting patch is identical to the one sent for 6.6.y.

Tested: the bug was found and the fix verified on a Wiren Board 8.5.1
(Allwinner T507) running a 6.18-based kernel, where a bit-banged I2C bus
on port E survives 200 probe rounds while another PE line toggles every
100 us in the background.  This backport itself is build tested only:
arm64 allmodconfig, all 26 PINCTRL_SUN* variants, W=1, no new warnings.

 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 88 +++++++++++++++++++--------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  7 +++
 2 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 508aa911c8d9..c7001f0eb676 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -793,6 +793,21 @@ static void sunxi_pmx_set(struct pinctrl_dev *pctldev,
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
 
@@ -946,21 +961,29 @@ static void sunxi_pinctrl_gpio_set(struct gpio_chip *chip,
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
@@ -1484,7 +1507,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct pinmux_ops *pmxops;
-	int i, ret, last_pin, pin_idx;
+	int i, ret, last_pin, pin_idx, nbanks;
 	struct clk *clk;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
@@ -1518,6 +1541,37 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
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
@@ -1572,7 +1626,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->chip)
 		return -ENOMEM;
 
-	last_pin = pctl->desc->pins[pctl->desc->npins - 1].pin.number;
 	pctl->chip->owner = THIS_MODULE;
 	pctl->chip->request = gpiochip_generic_request;
 	pctl->chip->free = gpiochip_generic_free;
@@ -1605,31 +1658,20 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
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
 
@@ -1640,7 +1682,7 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;
-		goto clk_error;
+		goto gpiochip_error;
 	}
 
 	for (i = 0; i < (pctl->desc->irq_banks * IRQ_PER_BANK); i++) {
@@ -1672,8 +1714,6 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
 
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

