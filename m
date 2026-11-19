Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795055803;
	b=lD3ppVpZlTLrJ2YtlhMDcRkTBqtQU8f8lhmqYCspOhsT27+/91kymCbURFDOmGy7yAug
	 aLjGlC3kpYQKV1/bw+dVPjwyqQky2IAiqGlShe83Fb1f2mz0y1v3p1QOzI7rqx/63Pi4a
	 ZDveUSSae74Ja8FtI+cpzy79PmorDxNredaspDc12TJwvEn9zu+Xvgz+IQaFFk0S6gqPW
	 tnISNlN6zKNhXTVFRQDFzYH3Rl5X991snV6nNhjMzVk27DYlbRLIR/cEBPfYi318Qe/v+
	 4W000MZVEymFF3JW36dLS/Dz/I/xyb2SJ+xTv9BY3KhsajcBh++o3s4Rt+oruwd2Qmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795055803;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ceVRFtgxIKCC/WRT4Ypmi06IQ8YmbqkNIxks5ThjQCs=;
	b=hngD3PWUblfgyIQ2kWIVttej7l71Pwf5bDHIoqzG1NePFOaBJ8gtakAcuL5ECZaQvAaF
	 pHHO3bTi+ekzILkHyO60Ux6tDvhUrHqpHTML1/SgPM11qNi7ntxFyTh2oCt7aSwCuclBJ
	 flnEaKKGty2fUgyqq2K79Q996+N82pNQSAP2SnWEoZDfqKRL2ohTlmU0eOwSzi5L7hp4D
	 ruYG+2Th0qnDmOgFfGM5tzVHn1LMk7lQfc3u1Ku6MENQYWzWFasCaAcON10VBFmW0k1Dp
	 54UpKkqMN139RAilPEV8JJsBxIXPEvJN/7opaQXUtxBHqrf0SR8Ed76jV1tSrN2nvvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44632606A331;
	Thu, 19 Nov 2026 02:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44632606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=ceVRFtgxIK
	CC/WRT4Ypmi06IQ8YmbqkNIxks5ThjQCs=; b=C+HS4YqoAV0MYmJmd/56rUiTE9
	AZfb/eP5TZe0ULkf1tjH+zT4V7qd8K0/tlY8sxlRQTaKig0THGMKiJWJ89sLOfGp
	Me0sA4nsd0GF3t3h8Fs0NEFr6mZOsUi5O6efHt1oOfEn/dU5XlmqFaTCcjk5OgCQ
	yhKGU4GBiDNpo8ZS4=
Received: from LAPTOP-ECE3GPS9 (unknown [2408:8670:ae1:0:414d:4d89:c146:115])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAmSgCpYP5qTgDeAQ--.22257S2;
	Thu, 19 Nov 2026 10:36:26 +0800 (CST)
From: Shuo Qin <23159100078@stu.xidian.edu.cn>
To: "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	XinCheng Wang <26031212453@stu.xidian.edu.cn>
Subject: [PATCH] misc: microchip: pci1xxxx: use a raw spinlock for GPIO IRQs
Date: Thu, 19 Nov 2026 10:36:23 +0800
Message-ID: <20261119023624.689-1-23159100078@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.56.0.windows.4
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
X-CM-TRANSID:BrQMCkAmSgCpYP5qTgDeAQ--.22257S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr48Zw4DJF4fKw15Zw48tFb_yoW3Kw4xpa
	yfAFySvay8Zr10gF4kC3WDXrs7WwsFga13AFs3Kws7JwsxZa43tr1FyFy09FW5tFWIkFsY
	gry5XFWFya1DAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK62v5MxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XeOPUUUUU==
X-CM-SenderInfo: ystrkmqrqqiluy6v33wo0lvxldqovvfxof0/

Lockdep reports "Invalid wait context" in pci1xxxx_gpio_irq_ack()
during GPIO IRQ mapping. The IRQ core calls mask_ack_irq() with the
raw descriptor lock held. The driver's ACK callback then takes
priv->lock, a spinlock_t that can block on PREEMPT_RT. The mask and
unmask callbacks also take this lock.

Convert priv->lock and all its users to the raw spinlock API. The
lock also protects register accesses in the GPIO callbacks, the
parent IRQ handler and suspend/resume. These critical sections
perform MMIO and bit operations. The parent IRQ handler releases
the register lock before dispatching child IRQs.

Fixes: 1f4d8ae231f4 ("misc: microchip: pci1xxxx: Add gpio irq handler and irq helper functions irq_ack, irq_mask, irq_unmask and irq_set_type of irq_chip.")
Cc: stable@vger.kernel.org
Signed-off-by: Shuo Qin <23159100078@stu.xidian.edu.cn>
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 52 ++++++++++++-------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
index 82635db04dc534de5faf26d7413a7dc8faa911c0..f8724d5df97feb4af1ef2d61800841dd64bda813 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
@@ -41,7 +41,7 @@ struct pci1xxxx_gpio {
 	void __iomem *reg_base;
 	raw_spinlock_t wa_lock;
 	struct gpio_chip gpio;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	u32 gpio_wake_mask[3];
 	int irq_base;
 	u8 dev_rev;
@@ -99,10 +99,10 @@ static int pci1xxxx_gpio_direction_input(struct gpio_chip *gpio, unsigned int nr
 	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, INP_EN_OFFSET(nr), (nr % 32), true);
 	pci1xxx_assign_bit(priv->reg_base, OUT_EN_OFFSET(nr), (nr % 32), false);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
@@ -121,7 +121,7 @@ static int pci1xxxx_gpio_direction_output(struct gpio_chip *gpio,
 	unsigned long flags;
 	u32 data;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, INP_EN_OFFSET(nr), (nr % 32), false);
 	pci1xxx_assign_bit(priv->reg_base, OUT_EN_OFFSET(nr), (nr % 32), true);
 	data = readl(priv->reg_base + OUT_OFFSET(nr));
@@ -130,7 +130,7 @@ static int pci1xxxx_gpio_direction_output(struct gpio_chip *gpio,
 	else
 		data &= ~(1 << (nr % 32));
 	writel(data, priv->reg_base + OUT_OFFSET(nr));
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
@@ -140,9 +140,9 @@ static int pci1xxxx_gpio_set(struct gpio_chip *gpio, unsigned int nr, int val)
 	struct pci1xxxx_gpio *priv = gpiochip_get_data(gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, OUT_OFFSET(nr), (nr % 32), val);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
@@ -154,7 +154,7 @@ static int pci1xxxx_gpio_set_config(struct gpio_chip *gpio, unsigned int offset,
 	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	switch (pinconf_to_config_param(config)) {
 	case PIN_CONFIG_BIAS_PULL_UP:
 		pci1xxx_assign_bit(priv->reg_base, PULLUP_OFFSET(offset), (offset % 32), true);
@@ -176,7 +176,7 @@ static int pci1xxxx_gpio_set_config(struct gpio_chip *gpio, unsigned int offset,
 		ret = -ENOTSUPP;
 		break;
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	return ret;
 }
@@ -188,9 +188,9 @@ static void pci1xxxx_gpio_irq_ack(struct irq_data *data)
 	unsigned int gpio = irqd_to_hwirq(data);
 	unsigned long flags;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	writel(BIT(gpio % 32), priv->reg_base + INTR_STAT_OFFSET(gpio));
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static void pci1xxxx_gpio_irq_set_mask(struct irq_data *data, bool set)
@@ -202,9 +202,9 @@ static void pci1xxxx_gpio_irq_set_mask(struct irq_data *data, bool set)
 
 	if (!set)
 		gpiochip_enable_irq(chip, gpio);
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, INTR_MASK_OFFSET(gpio), (gpio % 32), set);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 	if (set)
 		gpiochip_disable_irq(chip, gpio);
 }
@@ -301,13 +301,13 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 	int bit;
 	u8 gpiobank;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET, 16, true);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 	for (gpiobank = 0; gpiobank < 3; gpiobank++) {
-		spin_lock_irqsave(&priv->lock, flags);
+		raw_spin_lock_irqsave(&priv->lock, flags);
 		int_status = readl(priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
-		spin_unlock_irqrestore(&priv->lock, flags);
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
 		if (gpiobank == 2)
 			pincount = 29;
 		else
@@ -315,18 +315,18 @@ static irqreturn_t pci1xxxx_gpio_irq_handler(int irq, void *dev_id)
 		for_each_set_bit(bit, &int_status, pincount) {
 			unsigned int irq;
 
-			spin_lock_irqsave(&priv->lock, flags);
+			raw_spin_lock_irqsave(&priv->lock, flags);
 			writel(BIT(bit), priv->reg_base + INTR_STATUS_OFFSET(gpiobank));
-			spin_unlock_irqrestore(&priv->lock, flags);
+			raw_spin_unlock_irqrestore(&priv->lock, flags);
 			irq = irq_find_mapping(gc->irq.domain, (bit + (gpiobank * 32)));
 			raw_spin_lock_irqsave(&priv->wa_lock, wa_flags);
 			generic_handle_irq(irq);
 			raw_spin_unlock_irqrestore(&priv->wa_lock, wa_flags);
 		}
 	}
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET, 16, false);
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -365,7 +365,7 @@ static int pci1xxxx_gpio_suspend(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
 			   16, true);
 	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
@@ -375,7 +375,7 @@ static int pci1xxxx_gpio_suspend(struct device *dev)
 	if (priv->dev_rev >= 0xC0)
 		pci1xxx_assign_bit(priv->reg_base, PERI_GEN_RESET, 17, true);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	device_set_wakeup_enable(&pcidev->dev, true);
 	pci_wake_from_d3(pcidev, true);
@@ -408,7 +408,7 @@ static int pci1xxxx_gpio_resume(struct device *dev)
 		}
 	}
 
-	spin_lock_irqsave(&priv->lock, flags);
+	raw_spin_lock_irqsave(&priv->lock, flags);
 	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
 			   17, true);
 	pci1xxx_assign_bit(priv->reg_base, PIO_GLOBAL_CONFIG_OFFSET,
@@ -418,7 +418,7 @@ static int pci1xxxx_gpio_resume(struct device *dev)
 	if (priv->dev_rev >= 0xC0)
 		pci1xxx_assign_bit(priv->reg_base, PERI_GEN_RESET, 17, false);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
 
 	pci_wake_from_d3(pcidev, false);
 
@@ -484,7 +484,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->lock);
+	raw_spin_lock_init(&priv->lock);
 	priv->aux_dev = aux_dev;
 
 	if (!devm_request_mem_region(&aux_dev->dev, pdata->region_start, 0x800, aux_dev->name))

