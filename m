Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586123;
	b=HLfbJGEapbAkHngR34iG2JSJRN24RqaGAYRVnebjEG+mQYwshlkAoj+10RrGRcInYeY0
	 +8JcDop9x2VQb4ayAWLo2EHHHixcPfZBU3V9+SaWcEXeqVdgspkrM3SD3SngtiInR3ee7
	 +dNRrq+kUjVt2lnXZWoNkk15dmsS5UFKvWXz2CAt0Itfx2dwhqZEgSkVktlFOjqjTfBSq
	 P8W6qNaLH+ofMWEe7vss8pVBv1w9VZP+55eXMrRritXbsCWkIqEJsh/W/dqy2D2qKEXbR
	 mXtOdZSNix+O+3aMTiu3NHe9dhhXqIA2ZO0DaFqzzu3tNVpnpmex4VIa9783ZbQuw5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WejQTa8D5zu22SrrMjDzJCRXxWujqI9cH9X1J08TL08=;
	b=dKzXGMgvU0K9NSCJvQCAxzhf2dcg14PTOMzJ5dx/4RceRvDNdGOoBleE7pe6kIiNeKCd
	 eMMPgziCm8J+vvw9WPEeA60e1yaT/BFMEtTolklr+bCgm1Zdrjq/98eR88zN0dYY9AT1E
	 ovs51fpNB9T6Z6EDWQxaQY8a5EyUQjhHTugmm20Rze6bOpfAK2AK43XcpxUTSlCSrs+5Q
	 JOHZbIyj5k2cPPQkJ4hKq+aj/zXKlKGvDwd5r++D+/lPpxv5yEglhAid39BcB7bVRb0yr
	 zDXCpPrKobl6oRviPc1Ng4UCx5d3j7ewOC0bboA1hHvKCahsjpwfM4f6sErqwUSZXtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfxkWaM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBB360A3803;
	Wed, 21 Oct 2026 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfxkWaM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB671F000C4;
	Wed, 21 Oct 2026 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586123;
	bh=WejQTa8D5zu22SrrMjDzJCRXxWujqI9cH9X1J08TL08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NfxkWaM1m8qGerwuQBKdOzrO7kD9FvHVM0ZeSdK54rkdIHfsCDLMyWwVz59F73KG4
	 d0U9QfsZr+GXQu0GlFfJi9ikgF4Mgs9Xp1WstPYM0NnTpuOVfc6abH5S8UkKOOlQCP
	 6e3xYUr9hmRHEjPN5KUCVUbecVx8pXVkiKjO2bf8u1SVUA6F7LiwRNCk6+b57iw9S9
	 kkXHOx9I4laMUoyIQRX+5hkzOmg/6n6rzNw8B7tOTYXxilZdbhTOU4W5P97xMhULcr
	 YUf7eBPf0OnGsVuiLrDZOAVqp5/K7t+0hqdF1HoFBBc2NxeMwX7I4i3k+ctJdYYkWe
	 P/8QT/PplKg7A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	John Lenz <lenz@cs.wisc.edu>,
	Richard Purdie <rpurdie@openedhand.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Luis Henriques <lhenriques@suse.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 11/21] leds: class: Unlock led_access before unregistering device on error
Date: Wed, 21 Oct 2026 12:32:20 +0000
Message-ID: <20261021123406.3163547-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

In led_classdev_register_ext(), if led_add_brightness_hw_changed() fails
after device_create_with_groups() has exposed the LED sysfs attributes,
calling device_unregister() while holding led_cdev->led_access can
cause an AB-BA deadlock with a concurrent sysfs access that holds an
active kernfs reference and blocks on led_cdev->led_access.

Disable sysfs writes and release led_cdev->led_access before calling
device_unregister() on the error path.

Fixes: 6d71021ab3b0 ("leds: class: ensure workqueue is initialized before setting brightness")
Closes: https://sashiko.dev/#/bug/linux-400d8d29-9e78-4fb7-af37-b07c92bdf4df
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/led-class.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 2a3040fa3c4b..c8529003dbe1 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -549,9 +549,10 @@ int led_classdev_register_ext(struct device *parent,
 	if (led_cdev->flags & LED_BRIGHT_HW_CHANGED) {
 		ret = led_add_brightness_hw_changed(led_cdev);
 		if (ret) {
+			led_sysfs_disable(led_cdev);
+			mutex_unlock(&led_cdev->led_access);
 			device_unregister(led_cdev->dev);
 			led_cdev->dev = NULL;
-			mutex_unlock(&led_cdev->led_access);
 			return ret;
 		}
 	}
-- 
2.56.0.218.g1ec904b173-goog

