Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795711461;
	b=YRiuH649oITCksSNlQm1C8d2bA0MmXDf+Tavru5Co7i+Jtq3Vpwrhy47JSJp23x0xlF7
	 wrVZfk4hohJErpzT8OK2jhrRca2IPbHo4umYukrB1UVK2SODiemuoRmR9K87sSz3VV62r
	 ORqgwfcNG8Kn+B8tG8MxJOnmA22dVeLV4QkjQrOUAxA3XkRcargnl5f5ZHMlIMIWuZEZZ
	 3b4buVUNj8w0xcDVWE/7R9FtTTwHS+f1NsBdYiPolSOP9CRhWGT1LRrZnRP42oauym9FX
	 RO3HBUEn3t36BRt5EkRzohD4XQb9lYKnlmqq9qi+8ayvorkNjoDJbllz6pcW2qziE8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795711461;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FYEYepUbep0eB3YmZBEUu/OodhOak8HlQ6r/oEbssZQ=;
	b=nDh/4K8JosgSYDN89vF48oeK0imyje7ftPDJb5lLHDE7+5RNw9bhEL966jeeEkui1m6g
	 FbwwYWwmAg0gt5D+j2fbz+KZAP1+ja8CY2Cki3XiM2TqewpVaGDmLlT7lcZ2OPJAp2UPB
	 PpVUVr/zosjA55zNz/TXkfYFk+5NN2nHqRT6m8gK4ChR9PeEe6koXlDbkM+96AWIx6MRh
	 3rNHld7wYjEJbvYWcJtOT2KNyAjQ+Uzkr/Sktso2eOiMDsk9sjXrvVJhdj5BYCjmco/X0
	 gFSbMkBifH3o06uq6Cnlx+0o7c9tqBRtpTUE7x87l8Lu4ltEmQRTAkwyvPzUBtBKjUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmY5Xgvv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A1606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmY5Xgvv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08A61F000C0;
	Thu, 26 Nov 2026 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795711460;
	bh=FYEYepUbep0eB3YmZBEUu/OodhOak8HlQ6r/oEbssZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VmY5XgvvN1OHvwz+bTC6WFjyyDCfaBY5GBsu7DGBsvIxazLiqnF1QQ9g1iZ2pIm2X
	 iOx+3NuHu8bay81ukGgU1UKRnm3t8ez5QKJkzyf4huZurG4iDgGLgcuJ/7YcOALF1v
	 cbn4iyePJBvBcG+kN1VVx8FRS8nh3/4xjNESAA6SXj+Y1O+UJJRDCZRpgzY4IwT6Vy
	 AshwjExoxC/bLy481akHnpAi+/2uP8t1eGT1h2toJZO7eURqajkGgOBI/jm4fuhLHk
	 CqTnTQlIfMQHxFrwnrT18+lDVLaAcTZqXFJN+DFG/MiaUJBNlYbjZl+sdsytqTFPbk
	 Ovur07TJY5Nag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iio: humidity: hid-sensor-humidity: Use per-instance callbacks
Date: Thu, 26 Nov 2026 11:44:18 -0500
Message-ID: <20261126164408.2632190-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112544-anemic-neon-4969@gregkh>
References: <2026112544-anemic-neon-4969@gregkh>
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
[ sashal: Context lines differed only in whitespace and offset, so the hunk was adjusted to match the existing continuation-line indentation; the change itself is otherwise identical to upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f4070..1286e6f5dba3f 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -16,6 +16,7 @@
 struct hid_humidity_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info humidity_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 humidity_data;
 		aligned_s64 timestamp;
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

