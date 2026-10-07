Received: from d.mail.sonic.net (d.mail.sonic.net [64.142.111.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709837F01B;
	Wed,  7 Oct 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399331; cv=none; b=WrlrJLROPQsRmiqL2PbrC1q4iTeNF0gO191OaO7YWNAysaIzbgsb/tQT20GXhwnJ+p1/eFJWsYeXKGfJhIjevB3FIvBioktDNNsNqfg97qB4CloTvZ/S4jdBEgGmVT28djlZeLg8MJHvbK6FE2xFVgmxIqL5vjHu/3SgK+Zoqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399331; c=relaxed/simple;
	bh=XEezXEu9ssG1KukFPGMd2GvZ9t2vUkU5MggHS20dNDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ0ocgNxPSGImMplhXYt4nVyrLvMMP0cVd6B90OalWP/uBHVSbWy9K/CDe/VRuRqI3fYRWPUuKHtqCSsw9HEVMPZtgfgsjLI/65G5N/+cI1AvNz4mRd8MuilEEcnDpDzRaNjN77vNHmRmgafGAlf7beXQAeLPRDK0WBjYCpUr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by d.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 697IiV52012067
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Oct 2026 11:44:31 -0700
Received: from murgatroid.com (shack.murgatroid.com [10.0.0.31])
	by fred.murgatroid.com (Postfix) with SMTP id A3D552A6038E;
	Wed,  7 Oct 2026 11:44:31 -0700 (PDT)
Received: (nullmailer pid 622577 invoked by uid 1000);
	Wed, 07 Oct 2026 18:44:31 -0000
From: Christopher Hoover <ch@murgatroid.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christopher Hoover <ch@murgatroid.com>, stable@vger.kernel.org
Subject: [PATCH v2 3/3] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Wed,  7 Oct 2026 11:44:23 -0700
Message-ID: <20261007184423.622445-4-ch@murgatroid.com>
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
X-Sonic-CAuth: UmFuZG9tSVYk/k1YfRD/lo+ZaYtTjs5FhwTljGPYtwIqEAjgc0dJwJ263d3E4hgknaH9mZ1WNlESWb969dv1s6Crn8aHcqNnaFiEuE4QvrM=
X-Sonic-ID: C;THZKIn/C8RGNt5cllaD8vQ== M;qMJbIn/C8RGNt5cllaD8vQ==
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

