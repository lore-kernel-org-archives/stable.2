Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A83033E8
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800460; cv=none; b=dCiXQybA+00M/uKR3uiNJOb2g/3EUOQVueWklVooVgTpA1mWgPtbECM1GegFjulRJU5it3Hw/9n1aPJL7f0AiXlyK5cWCd98Cm0ufK3bDL6mZPyZB4XGp4YZii5tA4oIQnm8CQfw3rndEUWQjnYcIdOMlmV3FaKa2EYcwUjkBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800460; c=relaxed/simple;
	bh=ME3ZcMKS/hWLtou4vdCJXrzxiRlawZIdnuFhqaSkM/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vkf/CzcY87FyXKquc+Q0txQdJbKT6wfUdcKawZjNLjUr5BzyBOrrk+nAKuKjqXHCd9cOVH8EGPdIns5t5jb1YMicr7VrukwXZLrdZdLRFK+IDjcr/jHMGWwl2W6yMY8uIXPwIlHP7qbXj2v24b8DGZF5OhdP6U8PtTPnd4NKYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=BU1XZ7FU; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="BU1XZ7FU"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gh5sP4YSzzt14;
	Thu, 18 Jun 2026 18:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781800457;
	bh=TkQ3lby2jZ3TWGL6H0BK6IVgs2BEGZiYajsHidsHN40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BU1XZ7FU7HEG61JK2fZ2/EvFTLUxOZqkMPoc1xq+AAgRvBDUYsFWpFtQ7kPzyliyG
	 rsx5FJeC6RywRA9N2l0aAL+UCDEQx/JOG/Ef3bDnQKKXbFuJjUyZNdgAoOq0PiDhfm
	 DH1FikikxfGxxazDO3WrVxANkiKJvQEKJ3NAd+Bnq2v5Qk+8yef6uH0Ovi1Kh3ltbN
	 cnnA3WJBO7l7Xnyqwniw09eCL9PaPsT2DEJxNv0gPp99bhdflP8ik3fqcQwgV99Oo5
	 sL/3OreNMzGlLlCy91WZanegT4wGGorKzqCxLG9MY/EVL7/tEAOR4uJRJj+CZU3zSO
	 eAH125VrWYtVQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gh5sN5l5czfv2;
	Thu, 18 Jun 2026 18:34:16 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Thu, 18 Jun 2026 18:34:02 +0200
Subject: [PATCH 6.12.y v2 2/3] gpiolib: Remove redundant assignment of
 return variable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-6-12-cve-2026-31732-v2-2-42cc54b7bf04@cherry.de>
References: <20260618-6-12-cve-2026-31732-v2-0-42cc54b7bf04@cherry.de>
In-Reply-To: <20260618-6-12-cve-2026-31732-v2-0-42cc54b7bf04@cherry.de>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 550300b9a295a591e0721a31f8c964a4bc08d51c ]

In some functions the returned variable is assigned to 0 and then
reassigned to the actual value. Remove redundant assignments.

In one case make it more clear that the assignment is not needed.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20250416095645.2027695-9-andriy.shevchenko@linux.intel.com
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Stable-dep-of: 16fdabe143fc ("gpio: Fix resource leaks on errors in gpiochip_add_data_with_key()")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/gpio/gpiolib.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d48a57b899f79..97a32e6f901fc 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -939,7 +939,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	struct gpio_device *gdev;
 	unsigned int desc_index;
 	int base = 0;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * First: allocate and populate the internal stat container, and
@@ -959,11 +959,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	device_set_node(&gdev->dev, gpiochip_choose_fwnode(gc));
 
-	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
-	if (gdev->id < 0) {
-		ret = gdev->id;
+	ret = ida_alloc(&gpio_ida, GFP_KERNEL);
+	if (ret < 0)
 		goto err_free_gdev;
-	}
+	gdev->id = ret;
 
 	ret = dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
 	if (ret)
@@ -2882,7 +2881,7 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
  */
 int gpiod_enable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
-	int ret = 0;
+	int ret;
 
 	VALIDATE_DESC(desc);
 
@@ -2915,7 +2914,7 @@ EXPORT_SYMBOL_GPL(gpiod_enable_hw_timestamp_ns);
  */
 int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc, unsigned long flags)
 {
-	int ret = 0;
+	int ret;
 
 	VALIDATE_DESC(desc);
 

-- 
2.54.0

