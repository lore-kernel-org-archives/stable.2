Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6249B443
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860343; cv=none; b=oCgSIoeCgpq6F4OIneyC1lwzLgG/pSJl3/z4OkHVZ5COmfp+1qLWSzzg8ioQdKWcYQHFzOuOZvawfL29XOH3y+buguUhDDCOrj6Nc5jq6v7U5UIkRotfKFuHpCwkD89mIII3QWUMd8Zefj+ow/EMiBDzaVz0PVsCYpzCx7LjgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860343; c=relaxed/simple;
	bh=B3W6XYkf8IMjck/j+Qo/yvSpEB83PGFnLWBsCyqgMlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKNCYZH9cUvZl8nMgumHOgGRA0kjDOsU0sC06A2G9SHqUnt6ka9JshLBnmokiQYpXhNey78r7Djv554LHbYbVfYrxXLuAodE6f7Mxfnzun9bMSMvg9slthD2sVFXNOL8b7agBCuw9cNXmO/CXvuAK0GrmXBxs55rRuvhuZaB6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=m/1hpsDn; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="m/1hpsDn"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20261001131210b136ca9a4600020786
        for <stable@vger.kernel.org>;
        Thu, 01 Oct 2026 15:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rpkFEDBN2jUtOhClmlTShroifOQyK+XV7k7p9c4dQTo=;
 b=m/1hpsDnYv+X1NXhbeodHEVTZNfK94Gg0KZTf0tPCdfRo/PMr9lK94NsXjk/31X8a5J4+T
 c0ZEaJ4XCILwQ37ykNEHs4zp+eWynimcq9OAOyYT4gUeqABPuRt0TburpftTG70JbH7pm48C
 etpvn82IFsXNPpx9VAzxpfdz3RD8KGh6mISyrdIRzDdgl3OMPZ0cY05ZiOVtht/c4l/GGkek
 hybzY2DaBs17npNjpAmiiZSmgFy2NGTy7sc4TW7MpV/fiRniuMNtxufbekDGKhK9NDx/+ePM
 KQHXmofHk9s2ZydNU/S9ETRi0Vo7r1AzhGCG4bBXmKK+i8NnAX1692QA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-leds@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 4/4] leds: trigger: netdev: Serialize mode/interval stores with trigger lock
Date: Thu,  1 Oct 2026 15:12:03 +0200
Message-ID: <20261001131206.2513248-5-alexander.sverdlin@siemens.com>
In-Reply-To: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
References: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

netdev_led_attr_store() and interval_store() update ->mode and run
set_baseline_state() without trigger_data->lock.  kernfs only serializes
writes to the same file, so two attribute writes race on the non-atomic
read-modify-write of ->mode:

  CPU0 (echo 1 > link_10)       CPU1 (echo 1 > link_100)
  -----------------------       ------------------------
  mode = trigger_data->mode;
                                mode = trigger_data->mode;
  set_bit(LINK_10, &mode);
                                set_bit(LINK_100, &mode);
  trigger_data->mode = mode;
                                trigger_data->mode = mode;  // LINK_10 lost

They also race the notifier's link-state and ->hw_control updates.

Take trigger_data->lock in both stores. netdev_trig_work() also holds it,
so use the async cancel_delayed_work().

The async cancel cannot stop a worker already blocked on the lock: it may
resume after a store enabled hw_control and keep software-blinking and
rescheduling itself. Gate the worker and its arming in set_baseline_state()
on a shared netdev_trig_sw_blink() helper, so it stops once offload is
active or RX/TX monitoring is off.

Cc: stable@vger.kernel.org
Fixes: d5e01266e7f5 ("leds: trigger: netdev: add additional specific link speed mode")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---

Changelog:
v4:
- introduced netdev_trig_sw_blink() and used it in netdev_trig_work()
v3:
- explicit mutex_lock()/mutex_unlock() instead of guard()
v2:
- reduced verbosity both in the comments and in commit message
- dropped sync from cancel_delayed_work() (worker now takes the lock)

 drivers/leds/trigger/ledtrig-netdev.c | 46 +++++++++++++++++++--------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index b27a453bbb859..8aef9991490fb 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -81,6 +81,16 @@ struct led_netdev_data {
 
 static const struct attribute_group netdev_trig_link_speed_attrs_group;
 
+/* True while the software activity worker should keep polling and blinking. */
+static bool netdev_trig_sw_blink(struct led_netdev_data *trigger_data)
+{
+	return trigger_data->net_dev && !trigger_data->hw_control &&
+	       (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ||
+		test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) ||
+		test_bit(TRIGGER_NETDEV_TX_ERR, &trigger_data->mode) ||
+		test_bit(TRIGGER_NETDEV_RX_ERR, &trigger_data->mode));
+}
+
 static void set_baseline_state(struct led_netdev_data *trigger_data)
 {
 	int current_brightness;
@@ -164,10 +174,7 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		/* If we are looking for RX/TX start periodically
 		 * checking stats
 		 */
-		if (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ||
-		    test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) ||
-		    test_bit(TRIGGER_NETDEV_TX_ERR, &trigger_data->mode) ||
-		    test_bit(TRIGGER_NETDEV_RX_ERR, &trigger_data->mode))
+		if (netdev_trig_sw_blink(trigger_data))
 			schedule_delayed_work(&trigger_data->work, 0);
 	}
 }
@@ -392,7 +399,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	struct led_classdev *led_cdev = trigger_data->led_cdev;
-	unsigned long state, mode = trigger_data->mode;
+	unsigned long state, mode;
 	int ret;
 	int bit;
 
@@ -424,6 +431,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 		return -EINVAL;
 	}
 
+	/* async cancel: the worker takes this lock */
+	mutex_lock(&trigger_data->lock);
+
+	mode = trigger_data->mode;
 	assign_bit(bit, &mode, state);
 
 	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
@@ -436,20 +447,26 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	     test_bit(TRIGGER_NETDEV_LINK_25000, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_40000, &mode) ||
 	     test_bit(TRIGGER_NETDEV_LINK_50000, &mode) ||
-	     test_bit(TRIGGER_NETDEV_LINK_100000, &mode)))
+	     test_bit(TRIGGER_NETDEV_LINK_100000, &mode))) {
+		mutex_unlock(&trigger_data->lock);
 		return -EINVAL;
+	}
 
-	cancel_delayed_work_sync(&trigger_data->work);
+	cancel_delayed_work(&trigger_data->work);
 
 	trigger_data->mode = mode;
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
 
@@ -510,10 +527,14 @@ static ssize_t interval_store(struct device *dev,
 
 	/* impose some basic bounds on the timer interval */
 	if (value >= 5 && value <= 10000) {
-		cancel_delayed_work_sync(&trigger_data->work);
+		mutex_lock(&trigger_data->lock);
+
+		cancel_delayed_work(&trigger_data->work);
 
 		atomic_set(&trigger_data->interval, msecs_to_jiffies(value));
 		set_baseline_state(trigger_data);	/* resets timer */
+
+		mutex_unlock(&trigger_data->lock);
 	}
 
 	return size;
@@ -697,11 +718,8 @@ static void netdev_trig_work(struct work_struct *work)
 		return;
 	}
 
-	/* If we are not looking for RX/TX then return  */
-	if (!test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) &&
-	    !test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) &&
-	    !test_bit(TRIGGER_NETDEV_TX_ERR, &trigger_data->mode) &&
-	    !test_bit(TRIGGER_NETDEV_RX_ERR, &trigger_data->mode)) {
+	/* Nothing to do under hw offload or without RX/TX monitoring */
+	if (!netdev_trig_sw_blink(trigger_data)) {
 		mutex_unlock(&trigger_data->lock);
 		return;
 	}
-- 
2.55.0

