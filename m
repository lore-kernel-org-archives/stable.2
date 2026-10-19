Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA7363C73;
	Mon, 19 Oct 2026 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377923; cv=none; b=XqeGAUGcENnl434iHnjTi+ZB0qb6EL1PrfKZKcIU1cevqk6oWosDeVWte2vp3Bp4qETWPNXB7cT3nxeuZarLprEDGDAUtC4ZfhvPY+raZ0GmvhBxUP1EZduntfkijkHht1II3rrQDhWQGqZG3jjm2o3+bs+HbpPvq3G/1QR09l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377923; c=relaxed/simple;
	bh=+QevNQc2XjSyp2Px1Mfr/fXMXEunlC/FL37MnyaKstk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh0Pn/YSDikEbJJjOYYX79fcrYxpooTzGz3Y6G5TMmFU/64aqErPhTHcfb8phLZTxybMjC48Uo5NGHGWtQFApQSksdCEkPY7s7pJBsPx+XeT9sHNdN6whAfv3ixQYF6Lae7m5IuvQ9UIQlzfewhEft2ynCIngitKkbtEmL5pmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 69J2YKTK024951
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 18 Oct 2026 19:34:21 -0700
Received: from murgatroid.com (unknown [10.0.1.185])
	by fred.murgatroid.com (Postfix) with SMTP id A64A72A604C6;
	Sun, 18 Oct 2026 19:34:20 -0700 (PDT)
Received: (nullmailer pid 83998 invoked by uid 1000);
	Mon, 19 Oct 2026 02:34:20 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Lixu Zhang <lixu.zhang@intel.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] HID: hid-sensor-hub: Synchronize callback removal with raw events
Date: Sun, 18 Oct 2026 19:34:18 -0700
Message-ID: <20261019023420.83976-2-ch@murgatroid.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019023420.83976-1-ch@murgatroid.com>
References: <20261019023420.83976-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVZK6/MTUZCX/g0qVrLt1G4E/lwde0b3q5NYLf8lKThdWJAeqW7sp9ZhB9qMI6RJ+Uxd+MEdd7iMtTYV6h7Gh7fmSfFN+wxu99w=
X-Sonic-ID: C;EtnWlmXL8RGmtrCPAMRQ2g== M;7Mf5lmXL8RGmtrCPAMRQ2g==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

sensor_hub_raw_event() holds pdata->lock while it looks a callback up
in dyn_callback_list and calls its capture_sample() and send_event().
sensor_hub_remove_callback() takes only dyn_callback_lock, so it can
unlink a callback and return while another CPU is between the lookup
and the call.  The sensor drivers remove their callback in .remove()
and keep the struct hid_sensor_hub_callbacks in memory that devres
frees right after, so a report racing an unbind can call through
freed function pointers.

Take pdata->lock in sensor_hub_remove_callback() too, outside
dyn_callback_lock as in sensor_hub_raw_event(), so the removal waits
for a report in flight.  pdata->lock is otherwise only taken in
sensor_hub_raw_event(), and callbacks are removed from process
context.

Fixes: 401ca24fb34a ("HID: sensors: introduce sensor framework")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 6470a290ebfc..7cf9f398592e 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -173,7 +173,14 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 	struct sensor_hub_data *pdata = hid_get_drvdata(hsdev->hdev);
 	unsigned long flags;
 
-	spin_lock_irqsave(&pdata->dyn_callback_lock, flags);
+	/*
+	 * sensor_hub_raw_event() holds pdata->lock while it looks up a
+	 * callback and calls it.  Taking it here too means no report is
+	 * still using the callback once it is unlinked, so its owner may
+	 * free it as soon as this returns.
+	 */
+	spin_lock_irqsave(&pdata->lock, flags);
+	spin_lock(&pdata->dyn_callback_lock);
 	list_for_each_entry(callback, &pdata->dyn_callback_list, list)
 		if (callback->usage_id == usage_id &&
 						callback->hsdev == hsdev) {
@@ -181,7 +188,8 @@ int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
 			kfree(callback);
 			break;
 		}
-	spin_unlock_irqrestore(&pdata->dyn_callback_lock, flags);
+	spin_unlock(&pdata->dyn_callback_lock);
+	spin_unlock_irqrestore(&pdata->lock, flags);
 
 	return 0;
 }
-- 
2.53.0

