Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD7C40B113;
	Wed,  7 Oct 2026 07:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358490; cv=none; b=BTeHRDPRKbVtFs4XpFbCFGNnAEVyxyOikjaFx5a6e7PwbkgsarQD8r71OVfRmgGgGSkfRl+VB8hFbKCtixn8FjyeEnVhxH/Lk2/OV3L2f/FX0P/1LYHJA28ZMEaDBiD4AC7rRw8usiOFoOj2wxNfDf0BbFJG4JH8UMPclOGcXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358490; c=relaxed/simple;
	bh=XEezXEu9ssG1KukFPGMd2GvZ9t2vUkU5MggHS20dNDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b35gTPTSSZbUXp7JcMt+q3CyqpojEBMZC185BUFF/JdfJNw/WivCoRRdar22D5aQtfDkgaiDzrIcQKQe5l0qfqi4yGp8XtY78fa5RNfKtqRK2RhH43/i4W1x5Ox/HC40WWAAg+a3LfgeELIv7aIJlR8FHQmtJ20/9MNrkFyaR/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 6977OAVm013510
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 00:24:10 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id 510A02A60489;
	Wed,  7 Oct 2026 00:24:10 -0700 (PDT)
Received: (nullmailer pid 28344 invoked by uid 1000);
	Wed, 07 Oct 2026 07:24:10 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Wed,  7 Oct 2026 00:23:29 -0700
Message-ID: <20261007072329.27806-3-ch@murgatroid.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007072329.27806-1-ch@murgatroid.com>
References: <20261007072329.27806-1-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sonic-CAuth: UmFuZG9tSVYA51ONRvev4M2JnL4db89Oc6xMyM+RgPN4Q9fMhaI1+Z9B2R3tMswrYPA4Lpc/SozTRklxFH9+SWl4WhLzMHx0A/cuAAhFn6k=
X-Sonic-ID: C;VjXiFiDC8RGrfPEWvTXIBA== M;NoXzFiDC8RGrfPEWvTXIBA==
X-Spam-Flag: Unknown
X-Sonic-Spam-Details: not scanned (too big) by cerberusd

hid-sensor-humidity keeps a single static struct
hid_sensor_hub_callbacks for all instances and overwrites its pdev in
every probe, so with two humidity sensors, input reports for one are
delivered with the other's platform device, and a NULL dereference
follows once that device is removed.  The same bug was found in
hid-sensor-temperature, which shares this code.

Keep the callbacks in struct hid_humidity_state, as the other HID
sensor drivers (accel, gyro, als, ...) do.

Fixes: d7ed89d5aadf ("iio: hid: Add humidity sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 7cec81ff5685..95ee1d71c1a7 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -14,6 +14,7 @@
 
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct hid_sensor_hub_attribute_info humidity_attr;
 	struct {
 		s32 humidity_data;
@@ -184,11 +185,6 @@ static int humidity_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
-static struct hid_sensor_hub_callbacks humidity_callbacks = {
-	.send_event = &humidity_proc_event,
-	.capture_sample = &humidity_capture_sample,
-};
-
 /* Function to initialize the processing for usage id */
 static int hid_humidity_probe(struct platform_device *pdev)
 {
@@ -240,9 +236,11 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	humidity_callbacks.pdev = pdev;
+	humid_st->callbacks.send_event = humidity_proc_event;
+	humid_st->callbacks.capture_sample = humidity_capture_sample;
+	humid_st->callbacks.pdev = pdev;
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					   &humidity_callbacks);
+					   &humid_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.43.0

