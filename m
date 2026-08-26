Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8935C6B9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764823; cv=none; b=WacYCao/FgaoG0xeUGLWU8/UAF0GABcBWDY64Cymvlh0tHup2M0JR54ovffb9oR6zufaHCMK29qK5XLcYVfReCaaN1t+QorB5ZlOQmSftyFxuAp3McnHjZ4KbOA1xlmhExrMCSqu4LSv4dKyt93EWYGSgiePht3Ql9aUzqjWUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764823; c=relaxed/simple;
	bh=TSQirgzf9thvAFSdOo0jIaXAmKOqw3n4K7GuA9TzubA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLfIRnwYeS5N1+i2ByHJ6Fr/yjWF6BCLfRZpfuR8XcDGGPHWRPSuzOHaIUESIPvjuUITHNHzao2mde5d/TxCIzSZaMCY90a8H27rgUJtwPiXFVlzXhv7HIq1yz8bvqmN5NrCf1EQDoCyNX9Yhpuh5DK5EpVQXEP+BkSZzro7O4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUZzy5dU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUZzy5dU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0CE1F00A3A;
	Wed, 26 Aug 2026 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764798;
	bh=uCt+LJftkTGaWvtS0KhF7zhoRv03uEFImsHb8K0fP1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TUZzy5dUbIkCCG/I9hTWXsl0e+A/VEhhccHXpxUxr1/L/9aPLAo9exyUUFIZXqXg4
	 7ccjk+T7+lhIpbAGeUX3pVb2vzB8+uECuOLmPxnouHPI/Wa8qyF/SoAXZhI3lYX6ft
	 8Ee2j1px4a+3nge5JCPD3TNYUUgtgdAEaVz6nKGQiTRGEyM17E26gL/XoI5VAP6xZU
	 jWZlXaYuY77UHjT4RUOS7dgsU8D8XPw+jkXEIcxRn45o3OiX4D7t5yqSEF+lIMBbuU
	 126EphgOTW+TSA2hDslNWqC0cBYy1HDDvu2z9Kggf6QGVET9si6DB6fBff8IKyUwmF
	 ybqnZiPG4NSVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] HID: input: use __free(kfree) to clean up temporary buffers
Date: Wed, 26 Aug 2026 13:19:52 -0400
Message-ID: <20260826171955.2266521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082542-footpath-citation-4670@gregkh>
References: <2026082542-footpath-citation-4670@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 142068281f5138a9888d488e6911e8d9f7923c15 ]

The __free() cleanup automatically releases given resource when leaving
the scope, so use it to make the code less cluttered with error
handling.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: d07644524b65 ("HID: input: read battery capacity from its actual report offset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c1708caa6b6cc..74d04e5c7f0b7 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -419,23 +419,18 @@ static int hidinput_scale_battery_capacity(struct hid_device *dev,
 
 static int hidinput_query_battery_capacity(struct hid_device *dev)
 {
-	u8 *buf;
 	int ret;
 
-	buf = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret < 2) {
-		kfree(buf);
+	if (ret < 2)
 		return -ENODATA;
-	}
 
-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
-	kfree(buf);
-	return ret;
+	return hidinput_scale_battery_capacity(dev, buf[1]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -1818,7 +1813,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	struct hid_report *report;
 	int ret;
 	u32 len;
-	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
 	if (!field)
@@ -1845,7 +1839,7 @@ static void hidinput_led_worker(struct work_struct *work)
 
 	/* fall back to generic raw-output-report */
 	len = hid_report_len(report);
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -1855,7 +1849,6 @@ static void hidinput_led_worker(struct work_struct *work)
 	if (ret == -ENOSYS)
 		hid_hw_raw_request(hid, report->id, buf, len, HID_OUTPUT_REPORT,
 				HID_REQ_SET_REPORT);
-	kfree(buf);
 }
 
 static int hidinput_input_event(struct input_dev *dev, unsigned int type,
-- 
2.53.0

