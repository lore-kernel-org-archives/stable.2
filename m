Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363768;
	b=FVEdKjsfKcCNEZBMW5DGSCVIRjVvRCvHI2kboBhtx6/L33TOZWvLhBc5yWvw4+x6UCge
	 8/jho4n2uhyoqYpZijMDdgn5+FYpvZGJfyRUX5tMuu8YsGkWMG+6Rv15huTXdhPEQwhSY
	 wDIGMjFxSjZ1po1zX+tpL4ms3x157l1/oKiJKyWbcbE5tnducINcgemxPSqqp56DYn5lp
	 oxCO09AD4D3qNoESrup7VjuopjuKhvWctVKD32YTvD4o/zLnmBidAEFkEn1NykypWqbYm
	 3cNsym590Il5y2Bevxa6WgMxPugTW7lJ7ObvArl0vH9YqMouCi6nax7Fj10zHAXiwdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h52XGqeKAtMpGpA12XxagH49RUIwysiI5pHTAyyF9ug=;
	b=uxLbe4QqFYLspUfYXOoKizcM1UmrakNntBuXl/Etr4ulzQ6ZhMMAVkcbm7keF3Tq4mBf
	 hDmrWjcDM3I69yIZPnHyHxQ0Fzb/fuP+BLfbhI6s2mlomrPdW1KNjNssqKzyOnEUvWnd5
	 s7up6DIcJU91v9eLLNBxcqs1qk4lp+PgRIX7+gB1Y7Vmrq9fDEKNvGknzP6SIZprrUdqr
	 ahygyZBEoU4fkKEBhlO6ACkc7KUrTDAN7VIYIYsIoKTyRmul++AiFaezEAHAKNtEMRYQ3
	 1b99KCFr0velXvgAOe+F/36DhQDM10njubM9t8i5EpS2epQooeXO630V79YeDTIBqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anY7eKnd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2C606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anY7eKnd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E494B1F00A00;
	Wed, 11 Nov 2026 02:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363768;
	bh=h52XGqeKAtMpGpA12XxagH49RUIwysiI5pHTAyyF9ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=anY7eKndW1bYNyuwmZhEQeeEtCD0VEsYLX/CUCFSBkbP2XK4kX8yvH2e57l/PqxC+
	 P3mWI1oV4AwP3F/BqIvuqrsDKsM3b7gQ6Au1pha6G8m/SmnIHyzYEIBD61YPv97F3I
	 sFnBDyTgZVkPO4sT67ubSxntJFL2tOzh6C9n7UK/PqV0RlSTS3h8a3u4oEYoqZUduz
	 AjitSRz9d3imqayKm42oV/JIiESiPdizukBYCqCuF/x5MgVmb6OAZ5V0/OVEZ/X5Cs
	 K6vwCL3xMGTYql3VLJG9HsaU5Jjpsw/0mgXTUuWULtb9VTEupyn4hFwkOBbLDc8+mM
	 lFvAVfaecCM4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sahaj Chaudhari <sahaj123.sc@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] gpio: pca953x: Handle direction register read errors in IRQ paths
Date: Tue, 10 Nov 2026 21:22:45 -0500
Message-ID: <20261111022227.675763-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111022227.675763-1-sashal@kernel.org>
References: <20261107060925-failed-5.15-a0fe26929350@kernel.org>
 <20261111022227.675763-1-sashal@kernel.org>
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
index d6ee35492721d..f9fa898fc6e6a 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -673,6 +673,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(irq_mask, MAX_LINE);
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
+	int ret;
 
 	if (chip->driver_data & PCA_PCAL) {
 		/* Enable latch on interrupt-enabled inputs */
@@ -685,7 +686,9 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	}
 
 	/* Switch direction to input if needed */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		goto out;
 
 	bitmap_or(irq_mask, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
 	bitmap_complement(reg_direction, reg_direction, gc->ngpio);
@@ -695,6 +698,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	for_each_set_bit(level, irq_mask, gc->ngpio)
 		pca953x_gpio_direction_input(&chip->gpio_chip, level);
 
+out:
 	mutex_unlock(&chip->irq_lock);
 }
 
@@ -741,7 +745,9 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 		return false;
 
 	/* Remove output pins from the equation */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return false;
 
 	bitmap_copy(old_stat, chip->irq_stat, gc->ngpio);
 
@@ -829,7 +835,9 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
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

