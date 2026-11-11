Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363474;
	b=W42fDfHF9U5XlfQ2OQtyCyyydnWT/c6OUkV0G0pTOO3J2gKOp84XmnZomr2y5tuHYPVy
	 w7+CT5WkP22Rf6aHu8xLMw23HNeJNH90JsvwXRFdcmudFAz/x+KVwe2AV0sDPNSuulRjy
	 wUl5qt3xJA/WbukvX4KBGbPGqHf6fiAToaDz8ScTxyLu9UwFR2T6JwdPhms9LzwPKYNhJ
	 uMgB3c3groDuiUo7pCcRlBlgJFoXEMh4/wIJc5HPSp0i8DYfco+wZxsU2Z7Ln1F0dtDHW
	 23M7EWBpdntVDDocEu5xF1FW2Z7xccpSPBHkZXnCImfnrvE6yK7ADKnFUmOh2TBq9kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ovXkkP4jQ7GIfXDOYru5WljKUUW4iCZAT10q/d1qJ18=;
	b=MBwLPNwLeU+JbrSOiVc/GH4rMjus6xLNkMn8gRpjOvUYGRYzZdOunDUQqFhrquJbih7G
	 tl/lS0vwW5725ALeOkoOvvwI4kndEjWWuoX8M6iZ74oNbkjFhT1pZRE8P3+NpHmpLBQYA
	 yEEZoqWzFcm4NmDpgPdQ5B+KYfbfFOQWGnN0AVh8/gL5V0jUpUOFHsPyuOPtHClNfknx0
	 A/oN/t5dwMo5rlqxa1rGvQTdOqfj9UKFOyzi/Ipyvwuu6u9LSAFoChKLt7DXeWaJGHbsa
	 XOVSfwZ6A4SNAFkJhbgMrNTRdKt1TYmLAd+vey/ZKhgKs4Cpqtg8ypJ3Q09abrrq1yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPWIrGz+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPWIrGz+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D711F0089F;
	Wed, 11 Nov 2026 02:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363474;
	bh=ovXkkP4jQ7GIfXDOYru5WljKUUW4iCZAT10q/d1qJ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPWIrGz+JFZg/KThQsDMlRyRoTRTDOf4YikKzE4xJ2hg7DpOutnFb5rYGxWlReClu
	 LFci12U/ms4maDCD3qSXKk7DDTzEb8vuFx1k5spYwyYneU9/MxaBll5PgL78FZ0T2i
	 GO/f776wzDQZptr6OuVBj9haKn1yV/O5gBDDZHnqzS2k89wKpPAubP2fbJSg5lBwc4
	 C358vh+mv3nq0Gq9aioRhwyMG6Ac7kYnajwz+p8JcQ60jEVPFnB8RAniKXULX8QDTP
	 Gnoz8TmRpy5UodzfhGFyH2E0yqXYI/r9DacI5DgDYOpg3ggY48xT/oanCkK45NnnOX
	 hJD5UfpJlPS9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] gpio: pca953x: Utilise temporary variable for struct gpio_chip
Date: Tue, 10 Nov 2026 21:17:51 -0500
Message-ID: <20261111021736.618882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055216-failed-6.1-a0fe26929350@kernel.org>
References: <20261107055216-failed-6.1-a0fe26929350@kernel.org>
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
index 4ea19500fa39d..3ad235cd740be 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -692,9 +692,7 @@ static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
 
 static void pca953x_setup_gpio(struct pca953x_chip *chip, int gpios)
 {
-	struct gpio_chip *gc;
-
-	gc = &chip->gpio_chip;
+	struct gpio_chip *gc = &chip->gpio_chip;
 
 	gc->direction_input  = pca953x_gpio_direction_input;
 	gc->direction_output = pca953x_gpio_direction_output;
@@ -915,6 +913,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	struct i2c_client *client = chip->client;
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	DECLARE_BITMAP(irq_stat, MAX_LINE);
+	struct gpio_chip *gc = &chip->gpio_chip;
 	struct gpio_irq_chip *girq;
 	int ret;
 
@@ -943,7 +942,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * this purpose.
 	 */
 	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
-	bitmap_and(chip->irq_stat, irq_stat, reg_direction, chip->gpio_chip.ngpio);
+	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
 	girq = &chip->gpio_chip.irq;
-- 
2.53.0

