Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795713173;
	b=qkdApImQdKQ5MGWrVayVorco/8fHoW8bQtAeUbHx7cGx2nvaVLZeuEE9DNPgp0w9mnDQ
	 7GvAxwmFEZBrsacGTv6tAenQT3c+UKEiy8xfUpOW/TZdgHlndpPKaeIEqcUDZeIXwd+JA
	 PWYtEVOXHK+Obce/WQA00MuPe2MPUPTKfNzsV3NieZ0GMtYe0CrX0sq3nrhN8KyseCZPH
	 uVGbrsVgcvRP5/QvSMrBBCbSzM8m1uCTszbGZOtskHlU2mWgklirLfWD5RCOrfzdIJRly
	 ROLMTDEXGKDnkvPnGKYL0l9XLPDUs0poB4rCxXVSvRkTDdUCSzajmVJ63nPZg9Cw7pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713173;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jDIyQ4vP4xWOwyNd/2P1XXJSPGMmnwIjczRyK0fqZMQ=;
	b=RUn/rPUk+zRc8flxroVW6PASqfLNs+nQh8sBAuyU8Xu7OFd2iM/VFv9EALdb2wyYNWkB
	 8M2z5cjWmQiAa9jWzC6PSpOWiQDNvs994f9wuST8r0fOCslQIyCTQL2Uz/7iMrC5A6qec
	 KOT1P+oOy5yqLtR5Mr/ZVm/aHo9w5h5RYeR8YzNwB9B70FJuNXcuV/jH56lZRmAOjHwKq
	 oxICH4R2RQRqEKDjMZA9nWlP472+qdnWnTeTEK4mduB2L51mLwEaR9XqFS04on8st6qNn
	 ST8gMdfGQiEpjJmvssZTQDupZ5x1zcCIx57nyrsRhfRKvzSyVe9KrKQ0MhiCyBMh7aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4+InH1Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616D606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4+InH1Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC261F000C6;
	Thu, 26 Nov 2026 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795713172;
	bh=jDIyQ4vP4xWOwyNd/2P1XXJSPGMmnwIjczRyK0fqZMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F4+InH1Y8xArAg2ACCpWSSHthPqeP87yWaAEna9NfWWMAKYhV7gz1rWXgV68Ia78W
	 0evWLNFAPOeBHG2wKnXs0MbUlQ26qS9IIgNlKfTI67kn2oEdj/x3wFHJnSSEMDZ6QU
	 TaF3zJCDCZ7cnwZuGCKpSEbU5KsBQEa4B80jUIM3wFz/pvOAORfwUwtSbCEVuFinyh
	 wtzY+yZTPHPW+fQjxGWYKSf6EOhOKeI5yIpyq4/xzg+T7uAeoZlS4viL4SbIrp1s8M
	 raPpucG7lJxWQHt9/kKaLT/uSPL0NQACpGo6YMBM9U3OTWSt/yshl3OGTgGoGxZ+Su
	 dVMPIht2VdWAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:12:51 -0500
Message-ID: <20261126171239.2719947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112545-shining-retake-7d48@gregkh>
References: <2026112545-shining-retake-7d48@gregkh>
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

From: Christopher Hoover <ch@murgatroid.com>

[ Upstream commit bbe4f3f668babc9443fc1f075695e43e17ca7976 ]

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
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adapted the timestamp field to the older u64 timestamp __aligned(8) form and adjusted the sensor_hub_register_callback argument indentation to match the older context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index fa0fe404a70a2..b13b20a36ddfd 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -16,6 +16,7 @@
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info humidity_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 humidity_data;
 		u64 timestamp __aligned(8);
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
-					&humidity_callbacks);
+					&humid_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.53.0

