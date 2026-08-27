Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECD381AE7
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805615; cv=none; b=FitYQNJlpdRTb1rQg588FKFki9ZvYkAmJMDpiIt6SZVb01yrodqzJaWiUav89ZnwaoEkwOMKGUV7qdgq0Mui7M5u++Yp+YxKLBkwT8qiC1fmSpfJFf/UxhLziSY5+peg2cq3P/thKZxtZVmfawLIZkV7E54p8regNLphEKJKYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805615; c=relaxed/simple;
	bh=JR+BAavfGuIg39zVLKH2JKfTzMNGZ9I/JrpvjJkNa+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVyBfmvjsfrxENzCsUug0nwRplnPZzJZP28PZ+ElYnwPbS8i98iORrVVUEHnFSoIbiI5MTq+QETQApP6ckmaqj6BJGOWj8D1G0hNoTnLiiEGEexB6ydjXRWl27Ph69PBosF1R8N1bXkS7WcjNHFn+TDA0mjbNIKqZHsjdYUJ738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB+LdkMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB+LdkMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C961F00A3D;
	Thu, 27 Aug 2026 04:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805614;
	bh=XUepsNuHfUEmjlfYSvcYjGA0ZbSMJxxo36mPw4qXLo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kB+LdkMMn5YuMer14+4GDZR0CmccgNVU3bii9OpFBVSiwXUHqVEs+OdXkoaZNDA9u
	 c955cBbVbtXgS1aW+g4litKTyZmLhWYC03BwGFqp8kTxasXwVHtBiBnDjPtKHEGFsv
	 FUtXIxk2I2L88R1YdO0886Es3d+4NdT4MaeanLyVmjqBVPfliLIgE171e07M4ctgI+
	 2u1pZzOt+Jv4TdwoY47b8QM9uupU72ihAudlLv69e9rWhrs5aKeC4kJDLBwCZR58al
	 pC+LIqX+KPvQpAFaYCz6Nk/OEDkl8mv8kfl6QrqCdsVS9Acdo9gWv+mBzc7FydUPaI
	 GSBBcv1GRz9LA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] HID: input: read battery capacity from its actual report offset
Date: Thu, 27 Aug 2026 00:40:12 -0400
Message-ID: <20260827044012.3636019-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082544-profusely-glaucoma-4d1e@gregkh>
References: <2026082544-profusely-glaucoma-4d1e@gregkh>
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
[ Adapted `bat->report_offset` and other `struct hid_battery` accessors to the flat `dev->battery_*` fields on `struct hid_device` and replaced `__free(kfree)` with manual `kfree(buf)` calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 17 +++++++++++++----
 include/linux/hid.h     |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d03a447dbe6b8..12b94ea3b64df 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -367,19 +367,27 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
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
@@ -497,6 +505,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_max = max;
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
+	dev->battery_report_offset = field->report_offset;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a321d4c293a94..515b645f7abc8 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -620,6 +620,7 @@ struct hid_device {							/* device report descriptor */
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	__s32 battery_report_offset;					/* bit offset of the capacity field within its report */
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
 	ktime_t battery_ratelimit_time;
-- 
2.53.0

