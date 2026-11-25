Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639769;
	b=y4qj2205piQ9fRaTsJEzmG6ukWYue/V2HsiG0tYbO0YihnZdRavjlwJOLZp0N41bUeKN
	 2sDSQoIFkRYT4y0lVVtDLISuKmlHDtwc6xeUd7tJoJe0J6/PcinEykohpZiJk4UZ9m6Rt
	 APH1+77gxEjIJEAAb0C8rvaAbxhUTG/Q3FjJgDHsdOl7dvIk0UC8+ZRYa2PybzXTxwwnV
	 8UODO2+Kp8t8U2WpjV8k1By7BhvuUFx5MdEjpG2TFe62F88YV2LCBXO3KL54kRYeNDXEb
	 cVfvRgSBLJD2GzWAW14oIMPlXbBek3sgDdBuDGB5npVA+tVCPpwex+ErHUCi2oBd4FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639769;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yiP5h21LwvDzlC2NAkyHzG1v3Gl5+k48WkncEFjv2s8=;
	b=lGk9bITXVHRLTNkyeCRREeM4Q7HMgBLkqxTJp1puiVR5c2SwlbzsnczGxTITBUhwGhZh
	 4iXzK0qU5DjNQugaXbErGMYd9YEfS1KsNNB2ieIFUj40Snl9NZ2y3PWw/thIOQIQIn34O
	 SIv13RqsiNHla8Dz7z40tUK7B1O/gWl8K8/8f/ETejyKgC64QHdPfqS14pCEWvtTxpM4h
	 s7TKfIajYX9KlwtB8gPS+fu13Dt7sVJvtXMtHVl9rkod6BqDrTg/LjgXkRRzh/KCTV7Cr
	 t3AoPPoWuUB5saTEbto8fbm5cZzBMsJOwVBe6zDiWxjbqzG0zSg6GvmY6G6aYqwZIlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDCyIcs1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B57606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDCyIcs1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5B81F000D4;
	Wed, 25 Nov 2026 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639769;
	bh=yiP5h21LwvDzlC2NAkyHzG1v3Gl5+k48WkncEFjv2s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDCyIcs1kC0P0/x2mz7DnbROicPtST/OGj0zTWyKwc1qlbvit/5WOySAAxx16Jfb+
	 PyulaDu1YPkIeHhVdH489OT8Svc3ikRbiSU5sLn2Qp3xVr5YXmwNyHC/p+tXyu+t1G
	 XOJaOAgHN1pxof+GXvs4ZZWE/eG20kH/+tK22dGXUfAdQQ3uvGE1idHURSEpg8kAEF
	 MXMSTJo7eAgljhAvyyYyJrj4s4oCGWwXmjScVP0hqD8wTmE2eVQw6w0hNv1rIm8BT5
	 PvTeYW5lWvtfKvyYEJgK3Ih4Oq9zyLkHNUMnfuleKlWt5okvp91nE6z1FDYl3effCe
	 uG6RqNlygeA4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] gpio: sysfs: Remove redundant check for struct gpio_chip
Date: Wed, 25 Nov 2026 15:49:25 -0500
Message-ID: <20261125204921.1452840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-smasher-paralysis-af0a@gregkh>
References: <2026112507-smasher-paralysis-af0a@gregkh>
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

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 395b8e555dfcbab6b28f360e39bd048b2f3e362b ]

gpiochip_sysfs_unregister() is only called by gpiochip_remove() where
the struct gpio_chip is ensured.

Remove the redundant check.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://patch.msgid.link/20260223061726.82161-4-tzungbi@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Stable-dep-of: 7e899fe007d2 ("gpio: keep the chip reference when deferred setup fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-sysfs.c | 11 +++--------
 drivers/gpio/gpiolib-sysfs.h |  4 ++--
 drivers/gpio/gpiolib.c       |  2 +-
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index d4a46a0a37d8f..c5aa79fac40c2 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -1053,11 +1053,11 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
-void gpiochip_sysfs_unregister(struct gpio_device *gdev)
+void gpiochip_sysfs_unregister(struct gpio_chip *gc)
 {
+	struct gpio_device *gdev = gc->gpiodev;
 	struct gpiodev_data *data;
 	struct gpio_desc *desc;
-	struct gpio_chip *chip;
 
 	guard(mutex)(&sysfs_lock);
 
@@ -1065,13 +1065,8 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 	if (!data)
 		return;
 
-	guard(srcu)(&gdev->srcu);
-	chip = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!chip)
-		return;
-
 	/* unregister gpiod class devices owned by sysfs */
-	for_each_gpio_desc_with_flag(chip, desc, GPIOD_FLAG_SYSFS) {
+	for_each_gpio_desc_with_flag(gc, desc, GPIOD_FLAG_SYSFS) {
 		gpiod_unexport_unlocked(desc);
 		gpiod_free(desc);
 	}
diff --git a/drivers/gpio/gpiolib-sysfs.h b/drivers/gpio/gpiolib-sysfs.h
index b794b396d6a52..fd5db5384681a 100644
--- a/drivers/gpio/gpiolib-sysfs.h
+++ b/drivers/gpio/gpiolib-sysfs.h
@@ -8,7 +8,7 @@ struct gpio_device;
 #ifdef CONFIG_GPIO_SYSFS
 
 int gpiochip_sysfs_register(struct gpio_device *gdev);
-void gpiochip_sysfs_unregister(struct gpio_device *gdev);
+void gpiochip_sysfs_unregister(struct gpio_chip *gc);
 
 #else
 
@@ -17,7 +17,7 @@ static inline int gpiochip_sysfs_register(struct gpio_device *gdev)
 	return 0;
 }
 
-static inline void gpiochip_sysfs_unregister(struct gpio_device *gdev)
+static inline void gpiochip_sysfs_unregister(struct gpio_chip *gc)
 {
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a41219961778d..ccdf4feadc619 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1267,7 +1267,7 @@ void gpiochip_remove(struct gpio_chip *gc)
 	struct gpio_device *gdev = gc->gpiodev;
 
 	/* FIXME: should the legacy sysfs handling be moved to gpio_device? */
-	gpiochip_sysfs_unregister(gdev);
+	gpiochip_sysfs_unregister(gc);
 	gpiochip_free_hogs(gc);
 	gpiochip_free_remaining_irqs(gc);
 
-- 
2.53.0

