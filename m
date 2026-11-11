Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363215;
	b=E3nzn5mHg0pEnwaTUVqTHJxE9jE1fO87STDjFyXukeZgX1Ru/NMPj1MigehiunCZ7XBs
	 mwxbAzEBV21tEyEKNhKkuh9MM+JWOcMEeUUQBcWGMUPa9dxYzy/deILpXGX8x84+w9PKm
	 7SvA921bj15jYqnv1wjcszxEo3oyIc9kKPMhwyB3UledFdZgNaBbC2Fu1YUAat99vFvTr
	 T04VAKXHUUaFgQXvkJWPg83fiOm9PGm+NMrI6LzGoSvVPYh+P2nai9pYMErfkDRMGne4E
	 pZ1e1rfPM5hkcdlVPJ8ik7GTei0VMLm18kXZko+TAYP/e6WoxhdStq5mO3ZkEl1/jrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q6bhBzFp3UKxJuDCjBDOH2ZWShugxd6AomZxzbbqx1o=;
	b=VEd9jLHOz2daho1N9BMtZwNlS9OyJJF+LAAnJh1L7cL48NUzQStWANWuP8pq7Hgnh0LB
	 Nn2ENbRkDAEYgUuDljXESBmfv2yLxqMGIVwhwKZmIWdm4SmgQaEHCOYGtQIh6P7l98lch
	 o1G+UxS1r+EzPnEDY+k0ZR70OUVEnlLY0mQFYGDmrtlIKODdxqCXP8obDcircT5VFvqZS
	 QjKPFr4h3DXniNViImrV2NXWrc59/0NOFrxlQQWxxg6H868jG1jOcnFb1d+566vJLVWg3
	 G3190ttuztlbX5wdzmgHGvY7am+VNl0ZHDEVbAOenojanY/0bv4SJGFuJg5dizETE1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3RHQtIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A70606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O3RHQtIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3951F0089F;
	Wed, 11 Nov 2026 02:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363214;
	bh=q6bhBzFp3UKxJuDCjBDOH2ZWShugxd6AomZxzbbqx1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O3RHQtITUeb24g2SzC65anmEBOSmm2t271uXh3yAd2Xpa6Vbcxb23OjFSY44KPpXm
	 4R9JeBFexnqjYZdGPKXD2BH+jm8hKkSLlwfJxjWU+WxyReW+hThrLmGrHaOE6ehel3
	 Joi+ZtNzJlZk+89O7E5zFRvSS1CU6EylsU/gz45Cv8F3UYG0P0vTEiAA2rDTCIPt5n
	 JqETIpDkCbg1QCRXijF5irh0bOsAk6KbhKqKgsVwOF23VSa/yPynu5tNKUcedUBBMQ
	 lelEf3zrXdRPJhI33nQaBJ3fGbTKMlOOpLazD8IyTLRbpOfnCAMuY7IpauKAg7MiYR
	 5SW2on4j2pqxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] gpio: pca953x: Utilise temporary variable for struct gpio_chip
Date: Tue, 10 Nov 2026 21:13:32 -0500
Message-ID: <20261111021326.573042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053724-failed-6.6-a0fe26929350@kernel.org>
References: <20261107053724-failed-6.6-a0fe26929350@kernel.org>
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
index e13fac2132745..6384c0760e0ee 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -690,9 +690,7 @@ static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 
 static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
-	struct gpio_chip *gc;
-
-	gc = &chip->gpio_chip;
+	struct gpio_chip *gc = &chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
@@ -958,6 +956,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	struct device *dev = &client->dev;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
+	struct gpio_chip *gc = &chip->gpio_chip;
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -986,7 +985,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * this purpose.
 	 */
 	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
-	bitmap_and(chip->irq_stat, irq_stat, reg_direction, chip->gpio_chip.ngpio);
+	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
 	girq = &chip->gpio_chip.irq;
-- 
2.53.0

