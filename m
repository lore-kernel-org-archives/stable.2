Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B14A384D
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860340; cv=none; b=oJnQMWrjEzvdKwV5lLoVE+E0LUCyXbF66o9bDfpE7AWCShWOkoBKtBRUVdTGrhT4FwGO0tEy+f9olwsrClHede0GSL5YOJy/3etu9KuI+7uQ1vXZRQqP7QTuZLoVqVKBKrbxacsg/PZOXlFGpw/XUXHKTtemW3V7Qa1U4rCOpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860340; c=relaxed/simple;
	bh=6by20oj5Sm27uGqJktQWmBO+tebvgUpW1j8HXlv2amM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jj6u2WKENkJK9GkNVcb4t0FUYABrktZT1cslS1OYap87Qf13l+IX1/EIxjyFO2mOix/Zkk58ArLn8MgdiDHC7NjQLNCAWne6RhApVWWZEjkRncCyLp15YDn2SL0J9aBB3coEy7CwKJ8AD3SQPIgBoF9nm7VQ5mWZ25v4aHrNxfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=cQnsDEMy; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="cQnsDEMy"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261001131210a1e1d4840b0002072c
        for <stable@vger.kernel.org>;
        Thu, 01 Oct 2026 15:12:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vSa5iB3gEL2BxzPYUz6WJJhAlmEP7d4CNVX19nfmE84=;
 b=cQnsDEMyT8SgXQ4kay+ad8JKdy61o3Lggr8BekrxqT8Xg1UYV6+XJQ28JtHhfpWBGOsUxN
 eWcIEsamn6u1dWjjGemFKPpd2pzNqUqZAdZbqQaIeiwD23lYm419FBVBBe4JezFnA+q1lTJ3
 LizovGTJ5/s71DnbOW2VOzgQ52sIFjkY4b9fGQ13RI/1m2JXLGIjK/anP10ALr/5rKrsfETQ
 K6X60CHDHZKpym5n1xWO5Wi4bVxYAdkM+zOYeM05YOifji1yO51L3jZdPKx6eCFm/2E++KjP
 P4c7GHtt1OvQQ0TdL3UhIeo1bZyQ+Q0L6mU4gN0YFlIlmmKHcn2SWALg==;
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
Subject: [PATCH v4 2/4] leds: trigger: netdev: Access net_dev under trigger_data->lock in the worker
Date: Thu,  1 Oct 2026 15:12:01 +0200
Message-ID: <20261001131206.2513248-3-alexander.sverdlin@siemens.com>
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

netdev_trig_work() dereferences trigger_data->net_dev without the lock,
while set_device_name() and netdev_trig_notify() dev_put() and replace it
under trigger_data->lock.  On NETDEV_UNREGISTER the worker can run
dev_get_stats() on a netdev being freed (UAF).

Take trigger_data->lock in the worker.  cancel_delayed_work_sync() must
then never run under that lock.

Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/20260914142116.6DAC51F000FF@smtp.kernel.org/
Fixes: 06f502f57d0d ("leds: trigger: Introduce a NETDEV trigger")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
Changelog:
v3:
- explicit mutex_lock()/mutex_unlock() instead of guard()

 drivers/leds/trigger/ledtrig-netdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index e2a6c95a0dc97..d62a7b0168523 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -683,9 +683,12 @@ static void netdev_trig_work(struct work_struct *work)
 	unsigned long interval;
 	int invert;
 
+	mutex_lock(&trigger_data->lock);
+
 	/* If we dont have a device, insure we are off */
 	if (!trigger_data->net_dev) {
 		led_set_brightness(trigger_data->led_cdev, LED_OFF);
+		mutex_unlock(&trigger_data->lock);
 		return;
 	}
 
@@ -693,8 +696,10 @@ static void netdev_trig_work(struct work_struct *work)
 	if (!test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) &&
 	    !test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) &&
 	    !test_bit(TRIGGER_NETDEV_TX_ERR, &trigger_data->mode) &&
-	    !test_bit(TRIGGER_NETDEV_RX_ERR, &trigger_data->mode))
+	    !test_bit(TRIGGER_NETDEV_RX_ERR, &trigger_data->mode)) {
+		mutex_unlock(&trigger_data->lock);
 		return;
+	}
 
 	dev_stats = dev_get_stats(trigger_data->net_dev, &temp);
 	new_activity =
@@ -735,6 +740,8 @@ static void netdev_trig_work(struct work_struct *work)
 
 	schedule_delayed_work(&trigger_data->work,
 			(atomic_read(&trigger_data->interval)*2));
+
+	mutex_unlock(&trigger_data->lock);
 }
 
 static int netdev_trig_activate(struct led_classdev *led_cdev)
-- 
2.55.0

