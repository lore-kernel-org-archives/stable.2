Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F05409298
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929947; cv=none; b=aMqqr4e33ukBw+BUGgPiHzG/DYYKS2raTpQ6d2aKgXr/gqHiNeocn6F/qgLXPjvrLbYXIMHqOc8uFTjoIDhnFML2WreR6FlLEHu5V/1gaZvdNGjjCNVHi5giefkovA0DqrVcDseJUawjpvln9f2QMjUsN+V0JJ8W7vYtr9iR1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929947; c=relaxed/simple;
	bh=Red6ruDg1ZuwL9jLknd5bv1PDBXQ+mANh1i6EWd+fiU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G4f0C28lypavkK0yC++OM8fL8hP0KwIDyHSefExR9/SM6kDNcjb7dhcHMtD+/kuob4nzJ41c7CW8CcRr+ef/wHWxGEHh2tRXg4GVN8lBKpKSGy6xDkykT6XRzV6HdCAH2Bh0hv/GcjL1deiI5gzmkpdoKogIv91o7oc/u5Rezkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+sMHDIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+sMHDIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80311F000E9;
	Wed,  5 Aug 2026 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929945;
	bh=42XjNP36QtvvMUEIAxI38DogagTG2IBXALMJHQrOI+g=;
	h=Subject:To:Cc:From:Date;
	b=u+sMHDIqF5AVkyuvZdv2qZrXDX9PeeRqu/VDFLZAHwdBbETrTMJwcI9JnUkK53ns1
	 YN88T5xxZyYtdcQ/If92mYp6xLA4eoB1FLZQY88ZssIFPE1QZDUwxTLqBR1OX9Jx3H
	 5bZm3yXhRSrgBp6EwhMkLn1HoreToO/lixXNmbAw=
Subject: FAILED: patch "[PATCH] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock" failed to apply to 6.12-stable tree
To: mark.tomlinson@alliedtelesis.co.nz,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:38:30 +0200
Message-ID: <2026080530-jailbird-pedicure-255b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9dc325327babe7f159e84cbe9380a45342da0585
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080530-jailbird-pedicure-255b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9dc325327babe7f159e84cbe9380a45342da0585 Mon Sep 17 00:00:00 2001
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Date: Thu, 9 Jul 2026 16:51:16 +1200
Subject: [PATCH] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

Locking is disabled in the regmap config as this driver uses its own
lock. This means that all calls to regmap functions (read or write) must
hold the i2c_lock. The function pca953x_irq_bus_sync_unlock() did not do
this, and it was therefore possible that multiple threads could cause an
incorrect register to be read/written.

A previous patch partly fixed this, but only protected the write to the
interrupt mask register, and not the read from the direction register.

Fixes: bfc6444b57dc ("gpio: pca953x: fix pca953x_irq_bus_sync_unlock race")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Link: https://patch.msgid.link/20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index f6b870b7b352..e03bf1b12091 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -604,20 +604,28 @@ static int pca953x_read_regs(struct pca953x_chip *chip, int reg, unsigned long *
 	return 0;
 }
 
-static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+static int pca953x_gpio_direction_input_unlocked(struct gpio_chip *gc,
+						 unsigned int off)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit = pca953x_get_bit_mask(chip, off);
 
-	guard(mutex)(&chip->i2c_lock);
-
 	if (PCA_CHIP_TYPE(chip->driver_data) == TCA6418_TYPE)
 		return regmap_update_bits(chip->regmap, dirreg, bit, 0);
 
 	return regmap_update_bits(chip->regmap, dirreg, bit, bit);
 }
 
+static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
+{
+	struct pca953x_chip *chip = gpiochip_get_data(gc);
+
+	guard(mutex)(&chip->i2c_lock);
+
+	return pca953x_gpio_direction_input_unlocked(gc, off);
+}
+
 static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 		unsigned off, int val)
 {
@@ -855,9 +863,10 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
 
+	guard(mutex)(&chip->i2c_lock);
+
 	if (chip->driver_data & PCA_PCAL) {
 		DECLARE_BITMAP(latched_inputs, MAX_LINE);
-		guard(mutex)(&chip->i2c_lock);
 
 		/* Enable latch on edge-triggered interrupt-enabled inputs */
 		bitmap_or(latched_inputs, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
@@ -879,7 +888,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 
 	/* Look for any newly setup interrupt */
 	for_each_andnot_bit(level, irq_mask, reg_direction, gc->ngpio)
-		pca953x_gpio_direction_input(&chip->gpio_chip, level);
+		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
 
 	mutex_unlock(&chip->irq_lock);
 }

