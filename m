Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7594052BC
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835786; cv=none; b=lHE/TnGQKwYw3El8a+BBl+UnYSlvm4wE1/uoXd+Lu5mCyYzt9xqzXPNVG12g2slO4Av30RGRWSltOA1aTz7IUFGawbP9/ByjqxLRfLOKoXrjce2Puods00CnIn0uU28XMdnToYwvDZNUB0RF2Pq9ux6sX7TKZaB9h8+fYwfvnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835786; c=relaxed/simple;
	bh=2tELVQOM0CK42Zz4ZOp5mwX+JWahXNWh4CXc3OyMgWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bYqmnz8ccWsVLLigHDOvACwV3jbR25pjZT2lghJl/tfiUuNXjpbhbsdtnzhTMmivlauJ/lmyZgTGqk5Z4k8i96XNZg98VV3D8hKPwPiqoMMEuhy0qmiJIjZ9Sk7eqgTJIXkWipK+LdJRZ23VrPZtdM30Yliw7df1+zwsCu6r/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu+nzipY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu+nzipY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B101F000E9;
	Thu, 27 Aug 2026 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787835771;
	bh=Cy9T9MYMqALrxQ8TwuBgDggfTunymRUx9+7vxYq4THI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fu+nzipYlc4myEWijTq1TD2qcVLYVLSLlzxWPWZlLHIKLdYFxGRD+1upC3Dehv+q1
	 BQMVBURYe8V3d8jpxhgdQo35owMzned4iPhfBtw+EgYUD0HPG7c1TRjMaEUdTX9oyS
	 BFn/AicsOfKCi+kyt9/RFYkBMXdmfO3m4x7kxhmQTL/t2Zze7dezj6e889sqZTVupJ
	 kHtdqd9lSdgRMpHHZFeYEnRpOHmVHxZ3rdBDr2K4Pu+oGkNJRYgZVBIbLrFVpTBa1C
	 KUeSzjmmGVpWXGmEkxNyF8Dn/kBAubV43jiPv3c2P9DBgioOUtIG/B4EoHVTMyshxd
	 OPkjHrKqqwavA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] HID: input: read battery capacity from its actual report offset
Date: Thu, 27 Aug 2026 09:02:48 -0400
Message-ID: <20260827130248.615325-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082545-marlin-zealous-2533@gregkh>
References: <2026082545-marlin-zealous-2533@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jose Villaseñor Montfort <pepemontfort@gmail.com>

[ Upstream commit d07644524b6511b622ee7b0e2e68c9ee43d522a4 ]

hidinput_query_battery_capacity() assumes the state-of-charge value is
the first byte following the report ID (buf[1]) and ignores where the
battery field actually sits within the report.

An Apple Magic Trackpad 2 precedes the AbsoluteStateOfCharge byte with a
byte of status flags in its battery reports, so this query returns the
flags byte instead of the charge level.

The device happens to make that easy to observe, because it exposes the
same cell twice: its report descriptor declares AbsoluteStateOfCharge in
two reports (0x90 and 0x9b), so hidinput_setup_battery() registers two
power supplies. Only the first one is refreshed by hid-magicmouse -- it
uses hid_get_battery(), which returns the first battery of the list --
and that refresh goes through the report event path, which parses the
field correctly. Nothing ever reports the second one, so every read of
its capacity takes the query path above. On a USB-C Magic Trackpad over
USB, on an unpatched 7.1.5:

  hid-<serial>-battery-144 = 100%  (Charging)      <- report event path
  hid-<serial>-battery-155 =   3%  (Discharging)   <- query path

Both are the same physical battery. A raw HIDIOCGINPUT of the two
reports at that same moment:

  report 0x90 -> [90 03 64]
  report 0x9b -> [9b 03 64 64 00 00 10 00 00 00 00 00 00 00]
                     ^flags ^SoC = 0x64 = 100%

The device answers correctly in both cases; only the offset the kernel
reads the capacity from is wrong. 0x03 is the flags byte (present,
charging), reported as "3%".

Bluetooth takes the same query path for its capacity, where the trackpad
reported a bogus near-constant ~4% -- 0b100, the FullyCharged flag --
regardless of the real charge.

Store the battery field's offset within the report at setup time and use
it when querying, so the capacity is read from its real position. The
report event path already parses the field correctly through the HID
core; only the explicit GET_REPORT query was wrong.

Devices whose capacity field is the first field in the report have a
report_offset of 0 and are unaffected (buf[1 + 0] == buf[1]).

Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
Reviewed-by: Alec Hall <signshop.alec@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 17 +++++++++++++----
 include/linux/hid.h     |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 1c41a6297d3b9..8a48efe132d27 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -358,19 +358,27 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
 {
 	u8 *buf;
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + dev->battery_report_offset / 8;
+	int len = offset + 1;
 
-	buf = kmalloc(4, GFP_KERNEL);
+	buf = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
+	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, max(len, 4),
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret < 2) {
+	if (ret < len) {
 		kfree(buf);
 		return -ENODATA;
 	}
 
-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
+	ret = hidinput_scale_battery_capacity(dev, buf[offset]);
 	kfree(buf);
 	return ret;
 }
@@ -487,6 +495,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_max = max;
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
+	dev->battery_report_offset = field->report_offset;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8a105caf6bcb2..68fec22033a55 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -616,6 +616,7 @@ struct hid_device {							/* device report descriptor */
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	__s32 battery_report_offset;					/* bit offset of the capacity field within its report */
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
 #endif
-- 
2.53.0

