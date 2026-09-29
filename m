Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5957F51B168
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683753; cv=none; b=CSwJyo1KyDM/DHe7O+KapxwL81L/ub8r6d+UsIbdxGdkOGZx3BGiFFsRxd+eHZ0Wwthu7f7PpHkLrMwt5lKejV855T6EHdqywkxvuXVbIUWZaeBUq/vtwDAa62fS5F0K7wLVwixA5ojeTXEKhqLUiS6irqWhynYeOPRPoe+UuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683753; c=relaxed/simple;
	bh=+33mg0zEJYZu2ipy1KTU/M20+BJPFfwVkAmLR+RRFP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrc7V9H9krMDhN6CGPUEpdsXadhmo29wzBCXGrWMfe4u/Qf6/sra01b4gBok6d3scI+IQ7BG8gcVsQOJwhNAjgt3aiKHuFjs6lfiY6wktXjn3IF5vJ9Coubp3okSiSHWfF88eaOZReWKx+06pHeWvSPwjpDvzCzzlSUwcPm7EEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=BBIq5g52; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="BBIq5g52"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260929120906466008e84700020760
        for <stable@vger.kernel.org>;
        Tue, 29 Sep 2026 14:09:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nfHq7PyuTHpyeGDqh02WFY9mtUyZrH+DPT48jvVLYbY=;
 b=BBIq5g522PN2IdzTIEb4R0RSbm2b8fQzh27Ebh93gg34rWanU+ggJDbKZDxTbUHVakgiYF
 iMT7gllJBC26ZO+LE/XmligYsnaRUi1T6J9AM6XGuhhl2JGmLXuHQXtZBpjn29uH4tfbAMBU
 4kv0iKwbSlPEDEF9SURWGrvzL3AzJhgtWb0sOozX7YJnZ20bG1Tk9KIIv+JpXyYsxY4RX1lK
 N+WEhlxlGR0WdSoAkZemksC8CK0qrQKd62JjF+cMBRBEThuFN1Z2XCEdmbJrTO0zsg/Tedkq
 9OqgEe2AouNrnOUlC1U4+uecvnxxCXSxuJYZZMgAcRE3EXmUScjURLxA==;
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
Subject: [PATCH v3 4/4] leds: trigger: netdev: Serialize mode/interval stores with trigger lock
Date: Tue, 29 Sep 2026 14:08:54 +0200
Message-ID: <20260929120902.2793138-5-alexander.sverdlin@siemens.com>
In-Reply-To: <20260929120902.2793138-1-alexander.sverdlin@siemens.com>
References: <20260929120902.2793138-1-alexander.sverdlin@siemens.com>
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

Take trigger_data->lock in both stores.  netdev_trig_work() also holds it,
so use the async cancel_delayed_work() (a sync cancel would deadlock).

Cc: stable@vger.kernel.org
Fixes: d5e01266e7f5 ("leds: trigger: netdev: add additional specific link speed mode")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- explicit mutex_lock()/mutex_unlock() instead of guard()
v2:
- reduced verbosity both in the comments and in commit message
- dropped sync from cancel_delayed_work() (worker now takes the lock)

 drivers/leds/trigger/ledtrig-netdev.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index b27a453bbb859..7ad61c4be282e 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -392,7 +392,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	struct led_classdev *led_cdev = trigger_data->led_cdev;
-	unsigned long state, mode = trigger_data->mode;
+	unsigned long state, mode;
 	int ret;
 	int bit;
 
@@ -424,6 +424,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 		return -EINVAL;
 	}
 
+	/* async cancel: the worker takes this lock */
+	mutex_lock(&trigger_data->lock);
+
+	mode = trigger_data->mode;
 	assign_bit(bit, &mode, state);
 
 	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
@@ -436,20 +440,26 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
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
 
@@ -510,10 +520,14 @@ static ssize_t interval_store(struct device *dev,
 
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
-- 
2.55.0

