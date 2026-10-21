Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586117;
	b=QRaLxAHuG+4PQWujcbY/wQQiE2yhUqYQVrKDJisUqaJSen/b1DXkJNSz/9oqFy/D1EDs
	 Mze/wlqEaOPaU3A7pyxozHtdfVPLoHI8ofkWVnlhGLb4xXKkTAdRkAvd66Mhlq4UI0dfW
	 9yH9h5/68XYRbknjzGp42T6xvWDxx9wgf/ERBSr+edzWgKYCEBcYC2O/6CObaVrCd96/F
	 CWKHbJdpnVnZJUK/kwgzIKHlWez8nafyhwmYSp1OTiLHvP+IYiFagw0Jpyb2/7ECe3Wrw
	 BUWNBFow3jA9P/Xr8pRbKcNcp+y4DEiC32Qhof3Yq+77sVOCAFDjgb0s41L62gF4gAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pIfBysJ9mNVCf3WZtgwAoP3DRxG+9v9ZRLdimrDI5/4=;
	b=Tp2tLeq90V/yqlAW4aTTrTaKxa9t6ViQitdIRj2OnCrvVaQbu1Yu4ZqcD+lL2szz4uHl
	 nBe+9PJwXNLh1ZVDBVrHo2UOxeaxY8H8xedAl1OEWiah+5zfg5q6YlxhSkGB0JkiaZaIW
	 QI9yYoFQ66kQuAOIGdhCsTeDPZbfQg7gKEuuK1eC7Xi05ZzTpG3fJlip1ng7zmLLtWMMu
	 trNXNyzG8bWRNIDeI5+VI8MHRqOTein24j5Qf/bNPyTCEv+0aZuErLgwPOUp3e5jh7aBT
	 9Vxyt+lZJAsk2jYd8hHUV3p63QMwlKd0uBfPNwUSWgBUjIYTFXwf2SeIwONEw2O1CWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzW2ZADz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28E60A5BE2;
	Wed, 21 Oct 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzW2ZADz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9E1F000C9;
	Wed, 21 Oct 2026 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586116;
	bh=pIfBysJ9mNVCf3WZtgwAoP3DRxG+9v9ZRLdimrDI5/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzW2ZADzRf0Ic3ovXyc1C74B3U8YDpqZpkxGWtw59Xuu9oaoByZG0rBTOt/xWMzzS
	 cB0oSjKQyBfnyifvy8XJDdOs1UCZGRfQYq9JeNsvY7ZBIEmkrWyBHQDPRxOjxm1OCq
	 bUVpRLJZRer6lwxSCELSfkz1wl+/PXs25m9t7G9kHirFpIGDJAOyZHizitn11BgE6A
	 baMG/8UOoxf0RGKD6G6K3gRPfG7O3wrmlSUlXKZRLN6se2Gv+mApLXyzM+FvideX+b
	 8SCXTCWJoH1EhtBCz5MU6K3M/pLmvBtB0gelZgEstclhctOcdCItNPC/ovRoE+u8S2
	 TFHx1N5fM1PxA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	John Lenz <lenz@cs.wisc.edu>,
	Richard Purdie <rpurdie@openedhand.com>,
	Florian Fainelli <ffainelli@freebox.fr>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/21] leds: class: Initialise trigger_lock before exposing sysfs attributes
Date: Wed, 21 Oct 2026 12:32:19 +0000
Message-ID: <20261021123406.3163547-11-lee@kernel.org>
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

led_classdev_register_ext() calls device_create_with_groups(), which
creates the LED trigger sysfs attributes and emits the KOBJ_ADD uevent,
before initialising led_cdev->trigger_lock with init_rwsem().

Because trigger_read() and trigger_may_offload_to_hw_show() acquire
led_cdev->trigger_lock without holding led_cdev->led_access, a
concurrent sysfs read during registration can call down_read() on an
uninitialised rw_semaphore.

Initialise led_cdev->trigger_lock before calling
device_create_with_groups().

Fixes: 14b5d6dd40b3 ("leds: Fix race between LED device uevent and actual attributes creation")
Closes: https://sashiko.dev/#/bug/linux-376c7db5-ddc1-4faa-9f5b-43d2d3b7cb0d
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/led-class.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 00be3cb96c00..2a3040fa3c4b 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -532,6 +532,9 @@ int led_classdev_register_ext(struct device *parent,
 	if (led_cdev->color >= LED_COLOR_ID_MAX)
 		dev_warn(parent, "LED %s color identifier out of range\n", final_name);
 
+#ifdef CONFIG_LEDS_TRIGGERS
+	init_rwsem(&led_cdev->trigger_lock);
+#endif
 	mutex_init(&led_cdev->led_access);
 	mutex_lock(&led_cdev->led_access);
 	led_cdev->dev = device_create_with_groups(&leds_class, parent, 0,
@@ -554,9 +557,6 @@ int led_classdev_register_ext(struct device *parent,
 	}
 
 	led_cdev->work_flags = 0;
-#ifdef CONFIG_LEDS_TRIGGERS
-	init_rwsem(&led_cdev->trigger_lock);
-#endif
 #ifdef CONFIG_LEDS_BRIGHTNESS_HW_CHANGED
 	led_cdev->brightness_hw_changed = -1;
 #endif
-- 
2.56.0.218.g1ec904b173-goog

