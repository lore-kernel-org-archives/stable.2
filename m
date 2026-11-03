Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701390;
	b=r8/HS9vxkhIN1MypvJa1wXnBaeYa0E2qO0zU+k98atYgisA4AHMemGBBqcoMQeHnuwnH
	 HbJxIp1peJ85kPYTaB6KcajwGbt9uH+tUjLc4e5o4bhksjfnlmIKCl7WEYA5dhVYUVRGQ
	 m0d/MwdH9rDCkPchH0xcNWhhZoo/AygIvyjkyEJEC3Ps9Hl1Ui0t8XvEc+bHJGRavOtjm
	 pRFRK4FC2Ng39luinvw6muG08SkpEfp6o7brSDwcmLxP7h3o8cy0YFOXtksgJeQ9YS9yN
	 f8YaxQhcJvr9vlECf6UUCX27Q1NMuG98LwSuE/fFKNVGpG4dDHX0sP5V3zh/pQtzDqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701390;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=UYmSENSjXIqHkTii+FsN+sTED4hZ7gPUeMWF2Y6fbXw=;
	b=Xdy+ll4FZREPphEHvUFxulgf2vkxs2ZpCpfPO6wqeneATPHGDWbxxCSgAMKnkpQ4ihCr
	 mXSWNcE7iFMs0AuTeL4FTVWC8JKLaKj2MDyuiGTuH2nNXGYPDze3VBfy/GD3vnrW7m9fl
	 +DNlRHjexyRoSXCPhWDuxs7mUaXq0smPWqn9HbeSJM5ZdWndwMB4BpoMAkNY08ZMt4l1w
	 hHnUvXuw12NNuiIzzZAIRpdRoMrZ4kUZ8cq5Dvar7ozrv9JvCd0MpJjkc/ARyvkGqbm2w
	 +aBEisaK+trlnMriVbkkZJbv0a+zxvZmUyPHasa13LI0Yy8Rn170/AaiobXiampmUPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ISfpL6R+;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760360850B1;
	Tue,  3 Nov 2026 10:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4760360850B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ISfpL6R+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 920C14E413E2;
	Tue,  3 Nov 2026 10:23:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 644036046C;
	Tue,  3 Nov 2026 10:23:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0278103290E8;
	Tue,  3 Nov 2026 11:22:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793701384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=UYmSENSjXIqHkTii+FsN+sTED4hZ7gPUeMWF2Y6fbXw=;
	b=ISfpL6R+E6N4N6aVzNXRYGzz2AA/3NYgZ9IrB12pd7ROCn+nSHGcmS2yQNbfBvaYJjXkM6
	4E4KuHlXKDhwqeG+Nzs8Ivp/8+NWnGtQwJ3jMOCi/4ZDuMIB5MnPEvGMAa6XA031YwN6r2
	CnWe135b3ER1vbuKyGeGzb8nZ2aRyBHDoCyvGk6cVnYrAYRicyVq6gqgDji2+E1GLJuIyE
	ag7hb33JKof9rpoyT7gWmTcyzsfcLwYQkBEQTXTE7/9Xh7aBO+WC87J52sxT/v57kkSL7b
	tmfCho/klrGMJ+J7LQIhPGgriqMadPed5B+omHTyOI6GwopizI0OUF59FGh3iw==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Tue, 03 Nov 2026 11:21:38 +0100
Subject: [PATCH 5.10.y] gpio: dwapb: mask/unmask IRQ when disable/enale it
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-dwapb-fix-v1-1-c93ef2f20695@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMTQ6DIBQGr2K+dTGgARKvYroAfNbnQg1of2K8u
 2iXM5nMjkSRKaEpdkR6c+J5yqAeBcLgphcJ7jKjkpVRStai+7jFi56/wnltrdHa9iYg90ukrO9
 XC10qWf7w/Pu0+ZHCeo1wHCcO/xKydQAAAA==
X-Change-ID: 20261103-dwapb-fix-ab5776557f6c
To: stable@vger.kernel.org, Hoan Tran <hoan@os.amperecomputing.com>, 
 Serge Semin <fancer.lancer@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Alan Tull <atull@altera.com>, Jamie Iles <jamie@jamieiles.com>
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>, 
 xiongxin <xiongxin@kylinos.cn>, stable@kernel.org, 
 Riwen Lu <luriwen@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793701321; l=3286;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=raXdsmUXhUMXLoQv/+U2gS57CUX95PJSVR9MJSEhvXE=;
 b=n0J1NxaeWywnesRrmu6cgGjMdeym+G8ooueSX1IC1ePo9To5tg4tXa4WeBSEUhrdNiTz8Kznv
 uaWvKvCUNwgAB2zYIJ/sOtAFrXCyErtY/9iSsk+5e2BLAeZRdnzVki+
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: xiongxin <xiongxin@kylinos.cn>

commit 1cc3542c76acb5f59001e3e562eba672f1983355 upstream.

In the hardware implementation of the I2C HID driver based on DesignWare
GPIO IRQ chip, when the user continues to use the I2C HID device in the
suspend process, the I2C HID interrupt will be masked after the resume
process is finished.

This is because the disable_irq()/enable_irq() of the DesignWare GPIO
driver does not synchronize the IRQ mask register state. In normal use
of the I2C HID procedure, the GPIO IRQ irq_mask()/irq_unmask() functions
are called in pairs. In case of an exception, i2c_hid_core_suspend()
calls disable_irq() to disable the GPIO IRQ. With low probability, this
causes irq_unmask() to not be called, which causes the GPIO IRQ to be
masked and not unmasked in enable_irq(), raising an exception.

Add synchronization to the masked register state in the
dwapb_irq_enable()/dwapb_irq_disable() function. mask the GPIO IRQ
before disabling it. After enabling the GPIO IRQ, unmask the IRQ.

Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")
Cc: stable@kernel.org
Co-developed-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 drivers/gpio/gpio-dwapb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index d6240ae0f87ca..c2c9b42a60865 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -282,13 +282,15 @@ static void dwapb_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val |= BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTEN) | BIT(hwirq)
 	dwapb_write(gpio, GPIO_INTEN, val);
+	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
 	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
@@ -296,12 +298,14 @@ static void dwapb_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val &= ~BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(hwirq);
+	dwapb_write(gpio, GPIO_INTMASK, val);
+	val = dwapb_read(gpio, GPIO_INTEN) & ~BIT(hwirq);
 	dwapb_write(gpio, GPIO_INTEN, val);
 	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }

---
base-commit: f23b568f7597f98a241454018a34361ce2523c05
change-id: 20261103-dwapb-fix-ab5776557f6c

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

