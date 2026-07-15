Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257748C8DC
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138127; cv=none; b=febgSLfcoLy+l3VQYY3FlQ2EWoZ6z1Zx2mJKx9T9SJIbs0LPCrwIoHbSfesvf1Yv+DCF8pos0xVigpbeSMCKD1i8bt0+Bid9rVqTHaFZTo6rKD8gIqG6lF9fEx/wAs8gHtvcu5a2BZSOTu4cpiA0cH5zyDjDCrUSyTt1/0Fam+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138127; c=relaxed/simple;
	bh=MXR/EKVHWkrn5kd7w+sPLg/94Czt5eI2UFKwrEy16v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMCQ7myzHAPSSyYOoSx0V7IYjxUjGn+MZFHgGhyq3ZhaffmA1J3b5hdMs6bApXFUZjSaXvMbJ9pZcZECE9z6pamXmAJMhlWwR6DVd4oN+ERCLaOHEIXT+0XllRIVJxAOdONqU8sDqvLWL2VC7gZ0pHBbUjL66NJ4opR+5TfWYLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZZM/nn9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZZM/nn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF4A1F000E9;
	Wed, 15 Jul 2026 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138126;
	bh=HEdCRQcD2nQSd95a34e0ODd7e/wTE7R7oQnWLMEfAg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZZM/nn9bPgdlN4jusqaXTIyCUcfBNpwoWqINedbuyUx03TGAB4hXU/iBFtq0j9gs
	 DtaimnmCnJyBz3j9Y8Tt+auxdR+rDZF1NM9IVYYlrkG1epc+q0S42ERPz6oZelpCJp
	 FSS/bhcYEPiI+pO1mrsSqJ5sEWDH0ySJUDe5HBgOoXoqMjd/+cxKsuP8IJqNr2i7o2
	 4cfZIHszOXsyGHfo4xtjhsWWhn7dYxp4uDlDwoyrWs/my85TKh5gaI81gkhBf5tL2g
	 YRUvkaHWnIuP97ygTo0LitPfWxkHrR9gPDijg7cU46WV8+VU5+531fxdbRDz6ZIyt6
	 Y0pDhT8sP/U3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] gpio: sch: use new GPIO line value setter callbacks
Date: Wed, 15 Jul 2026 13:55:23 -0400
Message-ID: <20260715175524.1011791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071322-groom-bullring-9669@gregkh>
References: <2026071322-groom-bullring-9669@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 883c7eb2c4a9e143b2662ba754f9c16fb31adced ]

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250625-gpiochip-set-rv-gpio-round2-v1-3-bc110a3b52ff@linaro.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Stable-dep-of: 286533cb14a3 ("gpio: sch: use raw_spinlock_t in the irq startup path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-sch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
index 0600f71462b565..2b19e978c034d8 100644
--- a/drivers/gpio/gpio-sch.c
+++ b/drivers/gpio/gpio-sch.c
@@ -116,7 +116,7 @@ static int sch_gpio_get(struct gpio_chip *gc, unsigned int gpio_num)
 	return sch_gpio_reg_get(sch, gpio_num, GLV);
 }
 
-static void sch_gpio_set(struct gpio_chip *gc, unsigned int gpio_num, int val)
+static int sch_gpio_set(struct gpio_chip *gc, unsigned int gpio_num, int val)
 {
 	struct sch_gpio *sch = gpiochip_get_data(gc);
 	unsigned long flags;
@@ -124,6 +124,8 @@ static void sch_gpio_set(struct gpio_chip *gc, unsigned int gpio_num, int val)
 	spin_lock_irqsave(&sch->lock, flags);
 	sch_gpio_reg_set(sch, gpio_num, GLV, val);
 	spin_unlock_irqrestore(&sch->lock, flags);
+
+	return 0;
 }
 
 static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned int gpio_num,
@@ -145,8 +147,7 @@ static int sch_gpio_direction_out(struct gpio_chip *gc, unsigned int gpio_num,
 	 * But we cannot prevent a short low pulse if direction is set to high
 	 * and an external pull-up is connected.
 	 */
-	sch_gpio_set(gc, gpio_num, val);
-	return 0;
+	return sch_gpio_set(gc, gpio_num, val);
 }
 
 static int sch_gpio_get_direction(struct gpio_chip *gc, unsigned int gpio_num)
@@ -165,7 +166,7 @@ static const struct gpio_chip sch_gpio_chip = {
 	.direction_input	= sch_gpio_direction_in,
 	.get			= sch_gpio_get,
 	.direction_output	= sch_gpio_direction_out,
-	.set			= sch_gpio_set,
+	.set_rv			= sch_gpio_set,
 	.get_direction		= sch_gpio_get_direction,
 };
 
-- 
2.53.0

