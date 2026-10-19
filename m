Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDAC35E1AC;
	Mon, 19 Oct 2026 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.142.111.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377889; cv=none; b=hLzRgRzOCf7jUYr9Fb7XRJmUtJOYm9N+u4vbm+wePPScHdWd2vX4IAKys1ljHZI0VKm15QhLB4Ltgu+Z1Y5EydGb2v5o9hQtwno3W8XRsw7pIJArE5WZKoQGIFdJhRmOuGKajr5H4Pw28Aa14HJv40ShWCPLCTdkej3ULkEDMS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377889; c=relaxed/simple;
	bh=PZCWgfU3xBSDm6h/grCHW6Y5UnDHaHXsQgaFCJEkrpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIeLGDEHZeTl7xNJtAIxsXxtJovaz9/oalfcRR2OYPCSM57Rnxs8wDkWgQ1VrYLlSfiQzdJ/cEivuXst3PpOCCMeyLCckXBZEtJLHZs1VnVKbgeX7JwtuOoDLOnkoimzlJtv1/NXGWmEs2AXxLdtLBNQlG39q54tz5WAzfMg9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com; spf=pass smtp.mailfrom=murgatroid.com; arc=none smtp.client-ip=64.142.111.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=murgatroid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=murgatroid.com
Received: from fred.murgatroid.com ([70.134.61.105])
	(authenticated bits=0)
	by c.mail.sonic.net (8.16.1/8.16.1) with ESMTPSA id 69J2YKQs005969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 18 Oct 2026 19:34:21 -0700
Received: from murgatroid.com (unknown [10.0.1.185])
	by fred.murgatroid.com (Postfix) with SMTP id 949E82A603B0;
	Sun, 18 Oct 2026 19:34:20 -0700 (PDT)
Received: (nullmailer pid 84004 invoked by uid 1000);
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
Subject: [PATCH v3 3/3] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Sun, 18 Oct 2026 19:34:20 -0700
Message-ID: <20261019023420.83976-4-ch@murgatroid.com>
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
X-Sonic-CAuth: UmFuZG9tSVadRcsoGuumIkYqrsyWTybaCxtMVyE6E4q3EjYNf1GGEN+AH0rQ/FCa1udsRnEUgwSLyOnXxhAMuJyb38DyTca4FgQ3WhpLvAo=
X-Sonic-ID: C;3LnMlmXL8RGa6uXouUKo1g== M;MOz1lmXL8RGa6uXouUKo1g==
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
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 7cec81ff5685..644c82719447 100644
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
@@ -240,9 +236,13 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	humidity_callbacks.pdev = pdev;
+	humid_st->callbacks = (struct hid_sensor_hub_callbacks) {
+		.send_event = humidity_proc_event,
+		.capture_sample = humidity_capture_sample,
+		.pdev = pdev,
+	};
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
-					   &humidity_callbacks);
+					   &humid_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.53.0

