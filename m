Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364239;
	b=5NyNbodCqdNC0Z7b8FLygqhHNfrAsRD9WLf2542KuR3Q7WmBPDeg+0YwWmDiBh4SJfrd
	 yrJFSIkRQ04pWjQ3Qj6I1Jhhv9FfFLPWSIpjCJ5SzA40rW7OpYgreNPI39+TSQhOTYYt0
	 daQm/3WxWivbAxZmLOLfzRSgSOlub79y18btJHjsgA+vsuuO0I11c+cXy8QZz+wMfHvtr
	 4dzbPB8UHzfIbG99Ledq4akg6OhCmcEC6K+t7uhg7A052BKYkcCK6Ew0kUF/VtMMvS9wh
	 9Vv++5CzGU2q6cMFgUy3TMSIwq3MpJR6kA92Me+w54lrl4xZ+LmT0f9UcOwxEbMhJWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LRofUS2qk6zTd2IJZvwqw92Q3de+U9nz6lnk+Ab60z0=;
	b=a4omEGUuzzRU91eejUvoH1B6+xQog27pMutQHZBrhpPqULC+9Mbo5uJM6dyx86YVwfHT
	 LO5xk/rVaMdCiHwkC8L4WzczPcb2J0DINR/wjThI9s/5QVeK0xFJftioUWZ/Wue4CEjTJ
	 VuDS9XyMTQ0ngZ1ryiIipdjgBnhu2hcwhGlxx78Aw8jFJhPZfODzKLh5I7z8FwcXKIGhh
	 EBkECkqMVyQDeqTVzpD0znSNofoesrAvn6L6FzGRdmfWXicukqw2ufcj/9w1pUA0PLUJl
	 r2Z3u9cbeBKYEQwbx4cj9DNV1Yc36xzq3bM5bDQ4O8guQDyIk2g2U8/rZRhF1ahC3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QotzLdcX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF12606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QotzLdcX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3071F1F00A00;
	Wed, 11 Nov 2026 02:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364239;
	bh=LRofUS2qk6zTd2IJZvwqw92Q3de+U9nz6lnk+Ab60z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QotzLdcX6fZ6AA2KZxa/djUk6rTYMItBXPGu/hBeP7vJXao/r4D5l48HL6ktnkJ8M
	 7Q2W2xvjfaabM5P8qO1oakiZizUIkprB0gbGzhEtUh89E19KKdtq0xv4+ymh+ynLPZ
	 ESew/Gp/hM+GYVFiGlrcdjQjekt6VS0psDEWDftVIod8IHvh9YgVE1d/rxwvqg19+o
	 ukxNOx3WJl15Bb933txHn9fOsJOm9y3x8PpOkLMgSXjfxIkkTUI519jJwVaCyJE5G1
	 rDOZ771/7u6od0MY6jO8fQ7fj3pxn3GNxCS/9okRJZJ4dVLNx47n97QPcg4iL7So3R
	 OxMetzfsEXWkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sahaj Chaudhari <sahaj123.sc@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] gpio: pca953x: Handle direction register read errors in IRQ paths
Date: Tue, 10 Nov 2026 21:30:37 -0500
Message-ID: <20261111023031.700313-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111023031.700313-1-sashal@kernel.org>
References: <20261107062623-failed-5.10-a0fe26929350@kernel.org>
 <20261111023031.700313-1-sashal@kernel.org>
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

From: Sahaj Chaudhari <sahaj123.sc@gmail.com>

[ Upstream commit a0fe269293509acdd93b9cfb3f46636f7b91b33a ]

Three IRQ paths ignore the result of reading the direction registers
and then use the destination bitmap. pca953x_read_regs() does not populate
that bitmap when regmap_bulk_read() fails, leaving the callers to use
uninitialized stack data.

This can select incorrect GPIOs for direction changes during IRQ bus
synchronization, corrupt the saved input state during IRQ setup, or
produce incorrect pending interrupt decisions.

Check the read result at all three sites. Release irq_lock without
changing GPIO directions on failure, leave the IRQ history untouched
when pending detection fails, and propagate the error from IRQ setup.
The read helper already logs the error.

Fixes: 0f25fda840a9 ("gpio: pca953x: Zap ad-hoc reg_direction cache")
Cc: stable@vger.kernel.org
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Link: https://patch.msgid.link/20261018165003.3372368-1-sahaj123.sc@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 5d71e453dc1c2..7d0c6d7303aa0 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -672,6 +672,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(irq_mask, MAX_LINE);
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
+	int ret;
 
 	if (chip->driver_data & PCA_PCAL) {
 		/* Enable latch on interrupt-enabled inputs */
@@ -684,7 +685,9 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	}
 
 	/* Switch direction to input if needed */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		goto out;
 
 	bitmap_or(irq_mask, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
 	bitmap_complement(reg_direction, reg_direction, gc->ngpio);
@@ -694,6 +697,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	for_each_set_bit(level, irq_mask, gc->ngpio)
 		pca953x_gpio_direction_input(&chip->gpio_chip, level);
 
+out:
 	mutex_unlock(&chip->irq_lock);
 }
 
@@ -740,7 +744,9 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 		return false;
 
 	/* Remove output pins from the equation */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return false;
 
 	bitmap_copy(old_stat, chip->irq_stat, gc->ngpio);
 
@@ -828,7 +834,9 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * interrupt.  We have to rely on the previous read for
 	 * this purpose.
 	 */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return ret;
 	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
-- 
2.53.0

