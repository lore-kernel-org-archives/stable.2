Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDE48F015
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983204; cv=none; b=uEhOV7RvHgjhyfxDZ7xalZ5zzdjDS+smYmzLYTfS68evTKha53XpPMoRW8QnRHFhYklqk2ospZ/uWTHabGknxbIMD98J1k4pdLD4zBUZfFxss24h8WzZxKt4SZq+vPOkv8enSej2Xm77KgWNbiSdpp6OQE+HS4s9CDtgCSr63/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983204; c=relaxed/simple;
	bh=MuMf7Nt+s1wt5XM/x5dCAotMQ/UPI0nOLZmXZ9W16/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIWjcZCLGyNyrA/euR1SHhJcs3eGn5JRd/9wEVOSKxHohuh6IEa2bqw4f1bDqYe15F4008Q4enUoEHqI109y4SXhV5eIRcGTL5xayB7OXBjfWkImnNe9m5MQVCzW0KJApwqq0ifau+FVK/yvy2sVPufWrvsZBlevz1GS79TCU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=pmggtXgw; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="pmggtXgw"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202609210933028236146121000207be
        for <stable@vger.kernel.org>;
        Mon, 21 Sep 2026 11:33:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=HuAhv2bofAntDDHM2/ps5bcWeGJaQ8lLCGnIoZQfawY=;
 b=pmggtXgwGfJzvH3Oe2QWGDnorcH6ETyg6Ei/K2vOos0R72ft72tC5+qghDLsHdeaYyDO01
 YkxgnD4LuefZMMmgshXPlfRXeazqCwoc13zNrFSFis5g/79UgVaeFAsGQCEEhwMaXXZfp/Nz
 OnbGFBZ+DFh2JCWpaS2gkBgnfyCWB7exU9VG2xfdMKp/LvA8DIRsQb3Kc3Nuzx5WIf5nNZlJ
 VQ8S/z12nnFY3lAckFbNPbHS4qTJCoEgoHR9MIghRW5REylXk5nYTH14zcljW7q+oiLDfQI7
 WtKPKCWTXuBaA5bgKEkZ71+wyEir1kfSVJ9VSQNH1CZRryCoPrgi3iaw==;
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
Subject: [PATCH v2 4/4] leds: trigger: netdev: Serialize mode/interval stores with trigger lock
Date: Mon, 21 Sep 2026 11:32:46 +0200
Message-ID: <20260921093249.3481413-5-alexander.sverdlin@siemens.com>
In-Reply-To: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
References: <20260921093249.3481413-1-alexander.sverdlin@siemens.com>
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
v2:
- reduced verbosity both in the comments and in commit message
- dropped sync from cancel_delayed_work() (worker now takes the lock)

 drivers/leds/trigger/ledtrig-netdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 54c6913f3afe3..92a6a456130c9 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -385,7 +385,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
 	struct led_classdev *led_cdev = trigger_data->led_cdev;
-	unsigned long state, mode = trigger_data->mode;
+	unsigned long state, mode;
 	int ret;
 	int bit;
 
@@ -417,6 +417,10 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 		return -EINVAL;
 	}
 
+	/* async cancel: the worker takes this lock */
+	guard(mutex)(&trigger_data->lock);
+
+	mode = trigger_data->mode;
 	if (state)
 		set_bit(bit, &mode);
 	else
@@ -435,7 +439,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	     test_bit(TRIGGER_NETDEV_LINK_100000, &mode)))
 		return -EINVAL;
 
-	cancel_delayed_work_sync(&trigger_data->work);
+	cancel_delayed_work(&trigger_data->work);
 
 	trigger_data->mode = mode;
 	trigger_data->hw_control = can_hw_control(trigger_data);
@@ -506,10 +510,14 @@ static ssize_t interval_store(struct device *dev,
 
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

