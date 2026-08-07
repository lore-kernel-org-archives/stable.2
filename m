Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C622579E
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070167; cv=none; b=GtNYBJjhMm0O/dOeIiLwcCeJhxC7PgR7f2iMevzOXMj//+08vwZADxHE2ZfCKqlX/n59zUL0emIBjo6LNqAMpzRq9G/hzMRiLeqwmEXeIQ1z4s2dtH2X8FjkFUs4C7c9CdqQET1XoVVQ7MtAWNAluhkGQ4j/4DvPTKpDtOFJ58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070167; c=relaxed/simple;
	bh=UbQZWoJEWFVXVBL6kN/DcZEMjtP5HLpyxX2KNdYAels=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOSaPo3b2ovSYEQpYjhcq2Aytli/4N6+adZmsmaBGJDNeKfmvmaRDUCHDl9kkQ4OfQl9OH6PqjasBjuOerkBIxMz6EFLPwtIyshMlPIlPjAGYtQywoPptHdgffhtbJ3cOqNH7KJBb3a4106SNiMUEO/EDl0kgFl5/2G2b6kWrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4jQV3dn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4jQV3dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2BA1F000E9;
	Fri,  7 Aug 2026 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070165;
	bh=Aj+QDVfsVp/orXTCYh2GqFYoQvifrrfa7qEwpYMX/EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z4jQV3dnFxZmAb8bMobx3KBXFoWq0d53RG5ktIlNl3ZxbTPjJ6+4MGL4Bh8xZz4pb
	 LaU5o47BbGQ6LJJjDGHaZ+XkGohi7M6A+wZ6hEZ8WdBnsttSyETNKx+GaMy9BZEUin
	 +GOBsn7jbhNl8BhApU2ijdnRyqewi4KUfQZUhciVnbi2Vf8l3kei/zlP3F4Z5ZOa43
	 obp0hTqsgI4MaQrVc2UMPYysMQnrr3UFCSWDiodRfkryh75uqNtZhyQjEx62iZsN7p
	 Kc6VOFnGM5GvX1VjpiSjSO1a+9nKIVvuZO7a6knyK0qCgUYQwm/u/vo9rOsMEEjS8+
	 6YZwxAqchqfvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] serial: sc16is7xx: fix regression with GPIO configuration
Date: Thu,  6 Aug 2026 22:36:00 -0400
Message-ID: <20260807023601.1683108-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807023601.1683108-1-sashal@kernel.org>
References: <2026072914-stainless-finishing-0e3c@gregkh>
 <20260807023601.1683108-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit 0499942928341d572a42199580433c2b0725211e ]

Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
changed the function of the GPIOs pins to act as modem control
lines without any possibility of selecting GPIO function.

As a consequence, applications that depends on GPIO lines configured
by default as GPIO pins no longer work as expected.

Also, the change to select modem control lines function was done only
for channel A of dual UART variants (752/762). This was not documented
in the log message.

Allow to specify GPIO or modem control line function in the device
tree, and for each of the ports (A or B).

Do so by using the new device-tree property named
"nxp,modem-control-line-ports" (property added in separate patch).

When registering GPIO chip controller, mask-out GPIO pins declared as
modem control lines according to this new DT property.

Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
Fixes: 21144bab4f11 ("sc16is7xx: Handle modem status lines")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230807214556.540627-5-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af071d9e07e5 ("serial: sc16is7xx: implement gpio get_direction() callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 124 ++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 177e9eec21725..bd377488af6d2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -237,7 +237,8 @@
 
 /* IOControl register bits (Only 750/760) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
-#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT	(1 << 1) /* Enable GPIO[7:4] as modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT	(1 << 2) /* Enable GPIO[3:0] as modem B pins */
 #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
 
 /* EFCR register bits */
@@ -294,6 +295,7 @@
 /* Misc definitions */
 #define SC16IS7XX_FIFO_SIZE		(64)
 #define SC16IS7XX_REG_SHIFT		2
+#define SC16IS7XX_GPIOS_PER_BANK	4
 
 struct sc16is7xx_devtype {
 	char	name[10];
@@ -326,7 +328,9 @@ struct sc16is7xx_port {
 	struct clk			*clk;
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
+	unsigned long			gpio_valid_mask;
 #endif
+	u8				mctrl_mask;
 	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
@@ -1237,8 +1241,98 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 
 	return 0;
 }
+
+static int sc16is7xx_gpio_init_valid_mask(struct gpio_chip *chip,
+					  unsigned long *valid_mask,
+					  unsigned int ngpios)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+
+	*valid_mask = s->gpio_valid_mask;
+
+	return 0;
+}
+
+static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
+{
+	struct device *dev = s->p[0].port.dev;
+
+	if (!s->devtype->nr_gpio)
+		return 0;
+
+	switch (s->mctrl_mask) {
+	case 0:
+		s->gpio_valid_mask = GENMASK(7, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_A_BIT:
+		s->gpio_valid_mask = GENMASK(3, 0);
+		break;
+	case SC16IS7XX_IOCONTROL_MODEM_B_BIT:
+		s->gpio_valid_mask = GENMASK(7, 4);
+		break;
+	default:
+		break;
+	}
+
+	if (s->gpio_valid_mask == 0)
+		return 0;
+
+	s->gpio.owner		 = THIS_MODULE;
+	s->gpio.parent		 = dev;
+	s->gpio.label		 = dev_name(dev);
+	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
+	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
+	s->gpio.get		 = sc16is7xx_gpio_get;
+	s->gpio.direction_output = sc16is7xx_gpio_direction_output;
+	s->gpio.set		 = sc16is7xx_gpio_set;
+	s->gpio.base		 = -1;
+	s->gpio.ngpio		 = s->devtype->nr_gpio;
+	s->gpio.can_sleep	 = 1;
+
+	return gpiochip_add_data(&s->gpio, s);
+}
 #endif
 
+/*
+ * Configure ports designated to operate as modem control lines.
+ */
+static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s)
+{
+	int i;
+	int ret;
+	int count;
+	u32 mctrl_port[2];
+	struct device *dev = s->p[0].port.dev;
+
+	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
+	if (count < 0 || count > ARRAY_SIZE(mctrl_port))
+		return 0;
+
+	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
+					     mctrl_port, count);
+	if (ret)
+		return ret;
+
+	s->mctrl_mask = 0;
+
+	for (i = 0; i < count; i++) {
+		/* Use GPIO lines as modem control lines */
+		if (mctrl_port[i] == 0)
+			s->mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_A_BIT;
+		else if (mctrl_port[i] == 1)
+			s->mctrl_mask |= SC16IS7XX_IOCONTROL_MODEM_B_BIT;
+	}
+
+	if (s->mctrl_mask)
+		regmap_update_bits(
+			s->regmap,
+			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
+			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
+			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
+
+	return 0;
+}
+
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
@@ -1348,6 +1442,7 @@ static int sc16is7xx_probe(struct device *dev,
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_EFCR_REG,
 				     SC16IS7XX_EFCR_RXDISABLE_BIT |
 				     SC16IS7XX_EFCR_TXDISABLE_BIT);
+
 		/* Initialize kthread work structs */
 		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
@@ -1384,23 +1479,14 @@ static int sc16is7xx_probe(struct device *dev,
 				s->p[u].irda_mode = true;
 	}
 
+	ret = sc16is7xx_setup_mctrl_ports(s);
+	if (ret)
+		goto out_ports;
+
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio) {
-		/* Setup GPIO cotroller */
-		s->gpio.owner		 = THIS_MODULE;
-		s->gpio.parent		 = dev;
-		s->gpio.label		 = dev_name(dev);
-		s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
-		s->gpio.get		 = sc16is7xx_gpio_get;
-		s->gpio.direction_output = sc16is7xx_gpio_direction_output;
-		s->gpio.set		 = sc16is7xx_gpio_set;
-		s->gpio.base		 = -1;
-		s->gpio.ngpio		 = devtype->nr_gpio;
-		s->gpio.can_sleep	 = 1;
-		ret = gpiochip_add_data(&s->gpio, s);
-		if (ret)
-			goto out_ports;
-	}
+	ret = sc16is7xx_setup_gpio_chip(s);
+	if (ret)
+		goto out_ports;
 #endif
 
 	/*
@@ -1423,7 +1509,7 @@ static int sc16is7xx_probe(struct device *dev,
 		return 0;
 
 #ifdef CONFIG_GPIOLIB
-	if (devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
 #endif
 
@@ -1447,7 +1533,7 @@ static int sc16is7xx_remove(struct device *dev)
 	int i;
 
 #ifdef CONFIG_GPIOLIB
-	if (s->devtype->nr_gpio)
+	if (s->gpio_valid_mask)
 		gpiochip_remove(&s->gpio);
 #endif
 
-- 
2.53.0

