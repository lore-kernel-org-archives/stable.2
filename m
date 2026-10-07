Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE236A341;
	Wed,  7 Oct 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399331; cv=none; b=LPYqYmBXmgy8cwBk4uTrobgiYLCJVGUfAXszgWAo7J1oHeu2hU12SqHjf2xn0D8pFlufXAsF6XGs8/e3/5mCC2Ay6seNSXDWs3HV18qqulR2+OjeFJErZLteCQlWgwO0lAbIdgk8AGFPBnclPX1yy9pOBVvBAVJy7iL5vZ3hPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399331; c=relaxed/simple;
	bh=f4g8RXMsy9ptnlkr2otHDoyMpzmwpVxk9489bwZTrGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kibyjsjOzNziOfSBdX0LTdYjcnQtVCyK0j4iWs4Ql5oDj7juJtrw5MIYJdCxXIpyhBdz9POHYedMTQ2upWJ21WMBQSCd6FAltpI8nEkclzVvarZoq90E1slIsUt2fGXDxtczaOJhk1Jx8hbJLcIHAhCcHmmK7b4cHEv/Bx9Zd3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 697IiR0F011931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 11:44:27 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id 8E4462A6038E;
	Wed,  7 Oct 2026 11:44:27 -0700 (PDT)
Received: (nullmailer pid 622516 invoked by uid 1000);
	Wed, 07 Oct 2026 18:44:27 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/3] HID: hid-sensor-hub: Synchronize callback removal with raw events
Date: Wed,  7 Oct 2026 11:44:21 -0700
Message-ID: <20261007184423.622445-2-ch@murgatroid.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007184423.622445-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
 <20261007184423.622445-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVa6boxfsnOUBU+5gF8vwW3xLEEWU6qemdoFlBhPEZTE9wrJy3e58d8GacIdKV4w/KDnWH5g3N9PG1WBxpHV79+RiQvKhHi4k2Q=
X-Sonic-ID: C;SOLaH3/C8RG3b5cllaD8vQ== M;bIrrH3/C8RG3b5cllaD8vQ==
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
2.43.0

