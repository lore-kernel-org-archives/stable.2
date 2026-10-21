Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586098;
	b=yjZ2vgPbunSdUUJEoI9ICyPchk76ynmPHT/rBVJ17BaVADSEkFQJU4LOkKoH+imrFlVd
	 I69pDeGoryhZdOk+QejvYHdbzM58HNpGI+zg19//tawE6G5+Y5+b2Oaadk/m1KxvJ8rEx
	 ZwdZcsZaW004mFlYXACdvkwNWbyrC8mVvM2bXdI6WcpuZQAUOd/zT7sibhzpIUHw4Ge9M
	 Vi2WTrvAAeVVQxcDnbpHrXk+whzZDtWs7V4Khbf33U9YEWzhRhWgP7PBNObd59VWUXyJF
	 gsGHExtv7CGu9KRCJgit6G0x1pKzZvnk0T9HNAOrDMHhsO8Rwr6wxHPTqB6MOslPxUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LpNJTSOvMtLLtZ7695vlyc9Z8uHqSLJQ+uBGS+day94=;
	b=5PPlgnXom5voNjT3buEVxxLKzr+njVSLgrdkdk3ZrUCpra09vkquYI9F4HohKGstLLdU
	 B9QRfQPzd450Z5yxQNFsnYCT+vqgZcc3mC3Jpr1F8fE3IH2oRGirYzetgzPWe/Ac6bYmh
	 2+iqZEW16yW4+QmCXN5nARfClhBIf+lyXRgpaAAFjBZ25XfjsOBpFiYVmHejrQvAMlQuK
	 TY9vdxeZ/3u8IFJt2pUpTV0H7M1VAGnl8BYVqSllYNK2b5eC/P6LkamPc0MRP9/RT3oP6
	 JoU5wF0CUkZA+DUivAL7+AI8sMP2AMTDfxdKcHeM3tt02lU7YyYpuE0weibEsC8qHsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G65XMEaj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36D60A2613;
	Wed, 21 Oct 2026 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G65XMEaj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696C91F000C4;
	Wed, 21 Oct 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586098;
	bh=LpNJTSOvMtLLtZ7695vlyc9Z8uHqSLJQ+uBGS+day94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G65XMEajKicms9TEsD6d8NacFfBhwfuf/e6yeIOta0kaI+cyU0RQr6nuUoM8Ni1yY
	 UPTyPkE4Xl+rEZsacPTzfbFLmOA9MllVhBXzrohr0DyrwRORo22HoL5F3v6J+avLRE
	 JTci4jkrpepqLALGhvtbtJ1767mP2EoZahNd2swNu3YsbkJ1d23fWtSlIBqqmsX3z8
	 9PEsIPaIkBv+Og4AwTCMy7JsfYyLtLS3ZYjaaz2zYTxmEjUz8/Ldgoprr/XPGyPjyB
	 JWx2qFLq1Djgcx/Ki7DQ3sXiew4zCFD9jLbGuXW5oYQA4exCKpIQ/+1qqgiQunYLSH
	 W9KlVV2EydpBg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Ben Whitten <ben.whitten@gmail.com>,
	Oliver Jowett <oliver@opencloud.com>,
	Richard Purdie <rpurdie@openedhand.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/21] leds: trigger: netdev: Serialise work cancellation and state updates
Date: Wed, 21 Oct 2026 12:32:16 +0000
Message-ID: <20261021123406.3163547-8-lee@kernel.org>
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

set_device_name() and netdev_trig_notify() cancel trigger_data->work
before acquiring trigger_data->lock, whilst netdev_led_attr_store() and
interval_store() cancel trigger_data->work, update trigger_data state,
and call set_baseline_state() without holding trigger_data->lock at all.

Because set_baseline_state() can re-arm trigger_data->work outside the
lock, a concurrent notifier or sysfs store can re-schedule
netdev_trig_work() after cancel_delayed_work_sync() has returned and
whilst set_device_name() or netdev_trig_notify() is replacing or
dropping trigger_data->net_dev, leading to a use-after-free in
netdev_trig_work().

Move cancel_delayed_work_sync() inside trigger_data->lock in
set_device_name() and netdev_trig_notify(), and hold trigger_data->lock
across work cancellation, state updates, and set_baseline_state() in
netdev_led_attr_store() and interval_store().

Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Closes: https://sashiko.dev/#/bug/linux-b2b6c3bb-8017-4623-94d4-2999efa6a663
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/trigger/ledtrig-netdev.c | 35 +++++++++++++++++++--------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index d69031bbd2b8..9fa56ac523c7 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -284,8 +284,6 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	if (size >= IFNAMSIZ)
 		return -EINVAL;
 
-	cancel_delayed_work_sync(&trigger_data->work);
-
 	memcpy(device_name, name, size);
 	device_name[size] = 0;
 	if (size > 0 && device_name[size - 1] == '\n')
@@ -301,6 +299,8 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 	}
 	mutex_lock(&trigger_data->lock);
 
+	cancel_delayed_work_sync(&trigger_data->work);
+
 	dev_put(trigger_data->net_dev);
 	trigger_data->net_dev = new_dev;
 	strscpy(trigger_data->device_name, device_name);
@@ -384,7 +384,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	struct led_classdev *led_cdev = trigger_data->led_cdev;
-	unsigned long state, mode = trigger_data->mode;
+	unsigned long state, mode;
 	int ret;
 	int bit;
 
@@ -416,6 +416,9 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 		return -EINVAL;
 	}
 
+	mutex_lock(&trigger_data->lock);
+
+	mode = trigger_data->mode;
 	assign_bit(bit, &mode, state);
 
 	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
@@ -428,8 +431,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	     test_bit(TRIGGER_NETDEV_LINK_25000, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_40000, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_50000, &mode) ||
-	     test_bit(TRIGGER_NETDEV_LINK_100000, &mode)))
+	     test_bit(TRIGGER_NETDEV_LINK_100000, &mode))) {
+		mutex_unlock(&trigger_data->lock);
 		return -EINVAL;
+	}
 
 	cancel_delayed_work_sync(&trigger_data->work);
 
@@ -437,11 +442,15 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	trigger_data->hw_control = can_hw_control(trigger_data);
 
 	if (!led_cdev->brightness_set && !led_cdev->brightness_set_blocking &&
-	    !trigger_data->hw_control)
+	    !trigger_data->hw_control) {
+		mutex_unlock(&trigger_data->lock);
 		return -EOPNOTSUPP;
+	}
 
 	set_baseline_state(trigger_data);
 
+	mutex_unlock(&trigger_data->lock);
+
 	return size;
 }
 
@@ -493,13 +502,17 @@ static ssize_t interval_store(struct device *dev,
 	unsigned long value;
 	int ret;
 
-	if (trigger_data->hw_control)
-		return -EINVAL;
-
 	ret = kstrtoul(buf, 0, &value);
 	if (ret)
 		return ret;
 
+	mutex_lock(&trigger_data->lock);
+
+	if (trigger_data->hw_control) {
+		mutex_unlock(&trigger_data->lock);
+		return -EINVAL;
+	}
+
 	/* impose some basic bounds on the timer interval */
 	if (value >= 5 && value <= 10000) {
 		cancel_delayed_work_sync(&trigger_data->work);
@@ -508,6 +521,8 @@ static ssize_t interval_store(struct device *dev,
 		set_baseline_state(trigger_data);	/* resets timer */
 	}
 
+	mutex_unlock(&trigger_data->lock);
+
 	return size;
 }
 
@@ -628,10 +643,10 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	      (evt == NETDEV_REGISTER && !strcmp(dev->name, trigger_data->device_name))))
 		return NOTIFY_DONE;
 
-	cancel_delayed_work_sync(&trigger_data->work);
-
 	mutex_lock(&trigger_data->lock);
 
+	cancel_delayed_work_sync(&trigger_data->work);
+
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = SPEED_UNKNOWN;
 	trigger_data->duplex = DUPLEX_UNKNOWN;
-- 
2.56.0.218.g1ec904b173-goog

