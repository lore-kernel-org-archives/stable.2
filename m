Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715471;
	b=qwf/8AvT0ZCUvr9DsRxMDYmLAukWzfV05xZd0+UT6cwTyGOe7jalNQfqmMNJ5MK2fLo6
	 Gh4Jl4MLul8ZQwxyvdsWBeK5fXdSBg7cjRxYmCSxDyxnfJTy0H3k0EhbpYr0F36M5B3eW
	 eVItZYnP72doUweVB6p5jctF2g+nXAovWrWxyOT9KZMIcEqzGQIGWszirYanMrn7qvuQD
	 ZX46kKvrxEaCOUce2D7ayyw/XJh5B2P41T5ZN8k1/PPajGU4FzjryLnxR5o/lrfZGM7Z6
	 T3RIKpMyMnzPF48RuZK3HCYftsfUkNav5WRemFGYNV+Is4Yp4WWVhbT9axszb4L7/9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e6NIlKdHZpf6i5WxOE68askGCewEzIQZHvaFRNGMU/g=;
	b=EbPnCVVDA4l+WcAdqXPjIsHot8d2mwMbRW55b2/n37ldO2JVeyyy/u328X5bhMjA5xFO
	 6YuSkQaGtgFJfb3DA+mBgFogGrP8PiN3UPN9eQn2YnOrfObSTTR4aANhfwr7KIiTSpc6/
	 TMeaPRUe6gWJjALjllNayrc2hwZ00NWNo0JZ1hpvjh3jCmEbkEMBHuXwVpxYTa2qVQsUb
	 HVHna28fdm5AE4UWfUeVOTPoFd2poOs7u0zf0HFazc2So+kNye8BVxfhB/jRLXwaTFQPw
	 LONZr+f7yaK7hH7b2EQ9L0egCXmSJp3BoEikkcT1MvBDsqTMx9Bp6hz8oTodVaty3mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7bgKiIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C12606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m7bgKiIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D951F000CA;
	Thu, 26 Nov 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795715470;
	bh=e6NIlKdHZpf6i5WxOE68askGCewEzIQZHvaFRNGMU/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m7bgKiIy0MefGiZSYPDv9w3P7bM72q7daZx8ROZnl7gYBVeN0pGA8r+VHcWqGijA8
	 ID5CWSUAdXJwjUQdgt337vQcUQOkS4bZ/Osx8/Z40/I9xJq921/x/KvJTPp239Ho6e
	 qSvlgaIrCX2qam0qYXvlwui9OPajT5bYdWo3kEcNoAHvvif57QIU8AsQq4g7qVnT15
	 7pp5FlbDCbMegchJYoh85qYOPrWWzhUt6nPxeH2OG5L2X2piNUFQSXY8vmGfrB5H0o
	 RMlEBe7jvYXFYTzPRf/96j4Sj44RMSdHc+ESagd8EwgzQXwzQ3NsltE2NMfXOAQ/El
	 dy9wUJCQjkeVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christopher Hoover <ch@murgatroid.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: temperature: hid-sensor-temperature: Use per-instance callbacks
Date: Thu, 26 Nov 2026 12:51:08 -0500
Message-ID: <20261126175054.2854886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112552-salvation-spyglass-56fb@gregkh>
References: <2026112552-salvation-spyglass-56fb@gregkh>
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

[ Upstream commit 36eeb26031e90eeb81bbac3d3acad61d23fcbdf3 ]

hid-sensor-temperature keeps a single static struct
hid_sensor_hub_callbacks for all instances and overwrites its pdev in
every probe.  With two temperature sensors, input reports for one are
delivered with the other's platform device; once that device is
removed, platform_get_drvdata() returns NULL and
temperature_capture_sample() dereferences it:

  BUG: kernel NULL pointer dereference, address: 00000000000003a8
  RIP: 0010:temperature_capture_sample+0xd/0x50 [hid_sensor_temperature]

The oops happens in sensor_hub_raw_event() with the hub's spinlock
held, so the hub's removal then hangs.  It reproduces with two uhid
devices that each declare a temperature sensor, one destroyed while
the other still sends input reports.

Keep the callbacks in struct temperature_state, as the other HID
sensor drivers (accel, gyro, als, ...) do.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Cc: stable@vger.kernel.org
Signed-off-by: Christopher Hoover <ch@murgatroid.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adapted to older tree: timestamp field uses u64 __aligned(8) instead of aligned_s64, and adjusted the register_callback argument indentation context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index e440b7f692870..6bd18c95f4001 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -15,6 +15,7 @@
 struct temperature_state {
 	struct hid_sensor_common common_attributes;
 	struct hid_sensor_hub_attribute_info temperature_attr;
+	struct hid_sensor_hub_callbacks callbacks;
 	struct {
 		s32 temperature_data;
 		u64 timestamp __aligned(8);
@@ -184,11 +185,6 @@ static int temperature_parse_report(struct platform_device *pdev,
 	return ret;
 }
 
-static struct hid_sensor_hub_callbacks temperature_callbacks = {
-	.send_event = &temperature_proc_event,
-	.capture_sample = &temperature_capture_sample,
-};
-
 /* Function to initialize the processing for usage id */
 static int hid_temperature_probe(struct platform_device *pdev)
 {
@@ -238,9 +234,13 @@ static int hid_temperature_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	temperature_callbacks.pdev = pdev;
+	temp_st->callbacks = (struct hid_sensor_hub_callbacks) {
+		.send_event = temperature_proc_event,
+		.capture_sample = temperature_capture_sample,
+		.pdev = pdev,
+	};
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE,
-					&temperature_callbacks);
+					   &temp_st->callbacks);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
2.53.0

