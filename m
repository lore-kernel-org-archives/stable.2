Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363768;
	b=1XYBox+4jtwfOvbVMzWnUOj8BotMTE47SGzwGvoru30K0mYFYjWf0Rj0xHhhtSRUsJS1
	 yH91009n38YKxINWPY9BqpEz+OjXEcFx5ER6tvwayqyahwwxtoGvsIIUcyZrQwNSIq2Td
	 FgNXnJ3nl1uL5xElmTqR+EMU4YHFK8YIH/xSzTvsJEiPYTpufFfsU2+oEJSZjZ1ilNmEQ
	 X/JDCgzd8zpJqtq6hOt1HzjS7vIT7l3Z+i9qAlFfY30I/HnhEgXuKICouC6MTzqeBjN3I
	 xMKjcp0eNJ2gMJoS+OMeSU3gsn9GcebP1K64/DgVDN8t8RpNzyMvlFjkXNlAsdb+K2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vZjvrfoszQ0OXagykhafWYs7qu1Aw9k/x3lhN7FxNso=;
	b=RmXeoE/BHyXP7YCQdEl787PPN+rF1bK9cwpSWPh2rDlSqgfx0g0mV52SKwJTURP6e+ys
	 4Eb7/be+XqqydcVgS4cfffmz5HNjTklSp+fHbFZyjRjMtUxb/IcsMOpNL6bfEzGEmQbX3
	 VbRap2lAh6zC2jMnhizUXWPyGDbhrogssyFRkSewzVkZjZQjDkwdCP8vT35pUlaV03S1y
	 s1F4AW/x5AJbe8iuWGowrKl+BEs3iO1EY5cogdrl+CJoWJy/TlCC6MhbqEo7o4PCcXA51
	 g7bgFxtfNWFMcAjUrP99B7YLz8Mo7Rjx8KYGdPUASatNEk6GicNu8PmZKSWWwOQud1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/k/VOnr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B9606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/k/VOnr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A01F0093C;
	Wed, 11 Nov 2026 02:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363767;
	bh=vZjvrfoszQ0OXagykhafWYs7qu1Aw9k/x3lhN7FxNso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/k/VOnrt20d9WVqNljEKJKGQjAsDkIFANhBUAM7fWtUyRApXCz0HBw6hBedPvTVQ
	 c0/dnTa0fcaKjwjhdn4LPtssjxy6wJNcySjMDKMvQuZSjkj4a3ybRi21/0b48UsGgD
	 xr7yFWN0jr3iatc/X+EW1zgpps3KBjHE7eHnIZwmNVccynXC3bZldyLOknWQloF2rl
	 2H7JhI1T2Q6/AB/91noc08VfmEERPNA3noFX6gMqfVyrU0No24hm26gC7JJVIutmPE
	 Ckl7Avp7rJKeaHWPt3WO9OuJpxBRfK1z9rTr/bLsjFQEtBJ1ADQLycoRaEKivPMFsb
	 Ua5czWIqvgsYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] gpio: pca953x: Utilise temporary variable for struct gpio_chip
Date: Tue, 10 Nov 2026 21:22:44 -0500
Message-ID: <20261111022227.675763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060925-failed-5.15-a0fe26929350@kernel.org>
References: <20261107060925-failed-5.15-a0fe26929350@kernel.org>
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
index 95a09a8daa687..d6ee35492721d 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -601,9 +601,7 @@ static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 
 static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
-	struct gpio_chip *gc;
-
-	gc = &chip->gpio_chip;
+	struct gpio_chip *gc = &chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
@@ -803,6 +801,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	struct irq_chip *irq_chip = &chip->irq_chip;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
+	struct gpio_chip *gc = &chip->gpio_chip;
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -831,7 +830,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * this purpose.
 	 */
 	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
-	bitmap_and(chip->irq_stat, irq_stat, reg_direction, chip->gpio_chip.ngpio);
+	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
 	irq_chip->name = dev_name(&client->dev);
-- 
2.53.0

