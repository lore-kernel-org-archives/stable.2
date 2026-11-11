Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364239;
	b=lrUDDrcdelgLHBecBA62sM7YUShstqODmkisEfJ4fbOYv3SdcR+JVJK29sx1X48ChVip
	 62jXOaDlYmgnM9sZIhOO5jFuzRdFv2i5NU/lUfMAQpYhkJ2IqLA2eBT0He+TWCnL3iKh9
	 eHfkaXvfEmgMcHDZoQB1iafJAAZRSi6vId+1Xl4YNAjWjfyTt4SAULDd9DxguGNex7Dz5
	 3TKb9GmbCfxMhRDKDaHQNtr29jitz17TFGQySyctjTTv8UtdZmhp2DOsdfpVTXB/2SW/E
	 JxUxXa9soUORVCT8iZMbnoLGgdEH0Tib+Btu5ErVbZwQcyCXugCpFi+Sm7GugpaS0tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YHFle+ut4/fOWhUw+MSAiCqmghksS/Fvo1I6wYon5l0=;
	b=ufPG4+spMJA3+U0f4Je2biRSNDls6C5ndoO0wkGWkOZpPtyNB1eUxrhNybJaAzVtfCci
	 wsI02jDMKlAVu9dLon9fjvz7BmH7QUHRYTawwUrVGzf1okT3WonBmG50Ts8/d4WlJLBHl
	 b2kVTVDnplFZC6h9GFGYkb2GHKfpq+gsT65+S7O70I7X819zUHsRdNFRq+OZBE5TUkxzy
	 rP0N9aCuvfnmWCRRJVtEj67S2J7D7chUUt6IC+a6hzdHj8FYqAwcMTh/PGqSnZO/KzlHx
	 kpv01LVaamiERznm67Ey2uj0PselaquctLCee7lDF9uCPni/WVMrwQYi/27WbkLw3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzAvUrB6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E848606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzAvUrB6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4061F0089F;
	Wed, 11 Nov 2026 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364238;
	bh=YHFle+ut4/fOWhUw+MSAiCqmghksS/Fvo1I6wYon5l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SzAvUrB6aTm5Q9057PXeZPC6CUV8xTlPFxxoWT3QLR6sFeypg2wYcBxQxNFik6LWI
	 zXqAzPfwK9Y2r9CPR+xATUCzi8ZTpY2HRfLBRCYtwlN8sy/GPF3/Bi9l4ZOYFqvaP9
	 yS073xyzZgeVivWRdMTQX9JbHGe2amf8RoCqLfgbBP1QrMLmqBmQle6+Mj2V9qLlg/
	 OPV1nPKlnBmPZ0jwgeE31M+eeSE+QDNhxx+rEaGI9lPNJsBhozkdTzErTqmt80j4rf
	 2P1UFPe+Yl5IHONoxQIXs67fvZf0z/JiSKM35IAREnTbtwL8+HztSlGW26fnCj92jK
	 1S23QVr1DIp/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] gpio: pca953x: Utilise temporary variable for struct gpio_chip
Date: Tue, 10 Nov 2026 21:30:36 -0500
Message-ID: <20261111023031.700313-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062623-failed-5.10-a0fe26929350@kernel.org>
References: <20261107062623-failed-5.10-a0fe26929350@kernel.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 9da0a75ea7ced4731b1f2c6c67dc409e40efb95a ]

We have a temporary variable to keep pointer to struct gpio_chip.
Utilise it where it makes sense.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: a0fe26929350 ("gpio: pca953x: Handle direction register read errors in IRQ paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index ef69b7a01b585..5d71e453dc1c2 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -600,9 +600,7 @@ static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 
 static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
-	struct gpio_chip *gc;
-
-	gc = &chip->gpio_chip;
+	struct gpio_chip *gc = &chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
@@ -802,6 +800,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	struct irq_chip *irq_chip = &chip->irq_chip;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
+	struct gpio_chip *gc = &chip->gpio_chip;
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -830,7 +829,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * this purpose.
 	 */
 	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
-	bitmap_and(chip->irq_stat, irq_stat, reg_direction, chip->gpio_chip.ngpio);
+	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
 	irq_chip->name = dev_name(&client->dev);
-- 
2.53.0

