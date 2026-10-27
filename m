Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100843;
	b=RSd3RMWMkHUtm19JjDaoEm9h8XpHQ+PZ4dY+/shX5ZXwmM/XUos69Ox/4aMCA6dfLwvR
	 j4XheFtDrSIgbswqTtOsQtXitZfB4o3vup5nwwzxUy5sZxh8S89oIaaie118lK37sfCcH
	 e9+W7mhlHd4MDK3BPnDJbKyC8mwuqmoF7xboVYkjKZkWIRhfTn5fr9O4LnMOVFUa35I4x
	 l0dsazuReGDeoyZFnxByyHhiJHPKekSOGi7jAe50hsMLYRrTWa0skz/+b1JOGhbQIaPD7
	 OYfE65Xt0zo9ABNA3sCHa08Ak3n+dCBsgHJNVCQs0paJq36+DeXHKRek88w//kNbn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100843;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=vaMoJmfJf3ICrCzTXXV7OkiGmOs7c+I5K1e2fNuayAU=;
	b=sr23dxsQVbPQVTYg+XLMRTnbZRUDUuU31SWo5ZOXqbsFWJ/cdliFGr4X7D4oxNAPHLaY
	 K5hekmk9tRU1tSPBCtz2xE3DDNWnVOXOB6bmd7IvHDKwztVAMxr+kmbBfS2N8zSqVSTha
	 J1SSTIHao9H75g5T90gYoF9Vbw9jjgUVvRhMcCbr5Ro3iPdX3cmzVONe46lw3/AG/TNnh
	 PAVbdawdDDS0oTG/rqzdg7IZOhIykVYgJAI9eSwTTGSpncQzO5ezyVfpKxS9zXK5Kiru3
	 +D1X+KqiR2oPVu1gyaDPwhS6iEDQR/EfsWcN8GiHT3d/d0bQwvbULYuZmyB1X/0a5rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=llg7bW1D;
	arc=none smtp.remote-ip=185.136.65.227
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4A606B5AF
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66C4A606B5AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=llg7bW1D
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20261027113353db6a63f41000020727
        for <stable@vger.kernel.org>;
        Tue, 27 Oct 2026 12:33:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=vaMoJmfJf3ICrCzTXXV7OkiGmOs7c+I5K1e2fNuayAU=;
 b=llg7bW1D3+otd+NTPGiUTiwD0iDJpKQvPFnxTTZy7ZgbTxaK7+7Q7SniiMNPf15CKnpTsD
 qX6qRDsc+9xbG2PiMrkz72Q/2HZPTUv3KSOb3BjcADk7kK9IL806TR0LO2X0P17bEiCzqnS6
 Cawas+nAIdGnGmSSNsCH6fvftA/GsXuQZLZc2wz+l/rXemCawYlcVIHNCJ6HEHueeYkluPpS
 7hG/cqDWwNdmm4yfs3MnO/PTRCJ7bGWJFXTt8QC7DFCz21hlP91KDT55sCv38FzZIDTaIoff
 cyoAKojzJs24lcL5UVwRnmxHZu3jEpJZMAWFB3+nkl75uKyUSq/x26OQ==;
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
Subject: [PATCH v6 2/5] leds: trigger: netdev: Access net_dev under trigger_data->lock in the worker
Date: Tue, 27 Oct 2026 12:33:42 +0100
Message-ID: <20261027113349.383147-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
References: <20261027113349.383147-1-alexander.sverdlin@siemens.com>
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
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

netdev_trig_work() dereferences trigger_data->net_dev without the lock,
while set_device_name() and netdev_trig_notify() dev_put() and replace it
under trigger_data->lock. On NETDEV_UNREGISTER the worker can run
dev_get_stats() on a netdev being freed (UAF).

Take trigger_data->lock in the worker. cancel_delayed_work_sync() must then
never run under that lock.

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
index cfaf130157b3d..e72e850e0070f 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -676,9 +676,12 @@ static void netdev_trig_work(struct work_struct *work)
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
 
@@ -686,8 +689,10 @@ static void netdev_trig_work(struct work_struct *work)
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
@@ -728,6 +733,8 @@ static void netdev_trig_work(struct work_struct *work)
 
 	schedule_delayed_work(&trigger_data->work,
 			(atomic_read(&trigger_data->interval)*2));
+
+	mutex_unlock(&trigger_data->lock);
 }
 
 static int netdev_trig_activate(struct led_classdev *led_cdev)
-- 
2.56.0

