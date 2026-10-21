Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586073;
	b=Dt28G3IpEQ+drb9jnkMNHSD+eVp8K4xdMxqoedcW4grU0bwkLc8Gl8L5OLL3vLEqI1lR
	 4HVRLLrl2Q+ugVYkE4Koc2Ef/SlrkMpz5j+yKUCVR1Q/UfUjbjgLN01MNXn5hE2qm0wzG
	 HqLbzTHCtmKh/5cFInEVxIOp8FuOW2Dm0+XrD8EhImkj3qzhKrQ2GtNn6JpUmFGIidwba
	 D8MhA8jgQOGUmWl6865UE3rPPzjpYMfmOIIJQMEH7eY3yZEddU9Gt14NZ1ULIRb+zeY4P
	 qa4jFctJ5G1iLDT7AAMYDPqP/G0N8Ps+HxEEbhUnqjZevf0ciI4PQpAhJiptRgqd87w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HoenyfuYG/Fzd7K0ktejvOFJ7xwOTPV0x5uHk8iV1OU=;
	b=UG8gtXx3QHn+5hLOZp7HxGbEOAIwBB9TBfavzS3J2wPPCTeY5wHt60zOLlXv98KQFLOx
	 oOhfwAYD7WtzEGffw0R/APWTMA+xE19Y/hj8F8D7tChHfqeuJizmFFvetCKjhhVN+Rh/8
	 /S3OqTi7Bm6dCRew7LtWOPljQ4aiQETE+Qk8/Y0ATGwFZgeAPrnpiI3de3XjVci5Y67pF
	 Po31R1bd/w/l8utopv/24SN9u12of/pw8PlmARXAl6dzAKVdHcDkXN0p1yqsczEi3Tnh2
	 m8uwY6AI/l49DsBZLRrCsyG3KLw8gpPrM0KDODLrZAA/JIeSidiHRWnQn2iotncpQWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+tlu9Uo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35393606A31E;
	Wed, 21 Oct 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X+tlu9Uo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C871E1F000C4;
	Wed, 21 Oct 2026 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586072;
	bh=HoenyfuYG/Fzd7K0ktejvOFJ7xwOTPV0x5uHk8iV1OU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X+tlu9UoJYTky3n1RAbnaT3bn81ij5E/yiQsympqDY7bZ5UVsOrug/bUBIYcliE4w
	 NEHZ4YaNPtlMe8Yfdu8+XVG1HII3aKBi/gutoO+lrf510YV5ACkpUz91GgHDEBFty1
	 CaBEvXbwY0C1qUw37D84H1O9NSB0QDzV3HD7Za2d09JyWEVl1N9GduaINZTWtQA1kD
	 EcgiTdhiyBcIC9CW0xp/vyA1HWrVfbfGxJxM4PFhCq5otvueyc35AKzxoNVBQDvHnJ
	 S8Lnnb5KV0CFe9f497Er2zQA5C0gCVAH2eFFW5I9kPUf7cXhFx6SiHZMv9rVWq8aXU
	 G8QdHxLpAbDTA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Ben Whitten <ben.whitten@gmail.com>,
	Oliver Jowett <oliver@opencloud.com>,
	Richard Purdie <rpurdie@openedhand.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/21] leds: trigger: netdev: Hold RTNL lock across hw_control_get_device() in activate
Date: Wed, 21 Oct 2026 12:32:12 +0000
Message-ID: <20261021123406.3163547-4-lee@kernel.org>
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

In netdev_trig_activate(), hw_control_get_device() is invoked without
holding rtnl_lock, and the returned struct device pointer is then
dereferenced via dev_name() and passed into set_device_name().

Because implementations such as phy_led_hw_control_get_device() and DSA
port LED callbacks return the embedded struct device of an attached
net_device without incrementing its reference count, a concurrent
network device unregistration or rename can detach and free the
net_device (or its kobject name) before set_device_name() copies the
name and acquires rtnl_lock, leading to a use-after-free.

Move rtnl_lock acquisition to the callers of set_device_name() so that
netdev_trig_activate() holds rtnl_lock across hw_control_get_device(),
dev_name(), and set_device_name().

Fixes: 0316cc5629d1 ("leds: trigger: netdev: init mode if hw control already active")
Closes: https://sashiko.dev/#/bug/linux-ef006cc6-9a69-46b2-ae9f-8de934d37aff
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 5b0132484594..d69031bbd2b8 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -279,6 +279,8 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	struct net_device *new_dev = NULL;
 	char device_name[IFNAMSIZ];
 
+	ASSERT_RTNL();
+
 	if (size >= IFNAMSIZ)
 		return -EINVAL;
 
@@ -292,7 +294,6 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	/*
 	 * Lock order: rtnl_lock -> netdev instance lock -> trigger_data lock.
 	 */
-	rtnl_lock();
 	if (device_name[0]) {
 		new_dev = dev_get_by_name(&init_net, device_name);
 		if (new_dev)
@@ -319,7 +320,6 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	mutex_unlock(&trigger_data->lock);
 	if (new_dev)
 		netdev_unlock_ops(new_dev);
-	rtnl_unlock();
 
 	return 0;
 }
@@ -331,7 +331,9 @@ static ssize_t device_name_store(struct device *dev,
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	int ret;
 
+	rtnl_lock();
 	ret = set_device_name(trigger_data, buf, size);
+	rtnl_unlock();
 
 	if (ret < 0)
 		return ret;
@@ -760,6 +762,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 	 * Init already enabled mode in hw control.
 	 */
 	if (supports_hw_control(led_cdev)) {
+		rtnl_lock();
 		dev = led_cdev->hw_control_get_device(led_cdev);
 		if (dev) {
 			const char *name = dev_name(dev);
@@ -771,6 +774,7 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
 			if (!rc)
 				trigger_data->mode = mode;
 		}
+		rtnl_unlock();
 	}
 
 	led_set_trigger_data(led_cdev, trigger_data);
-- 
2.56.0.218.g1ec904b173-goog

