Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6946F496
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663818; cv=none; b=ECgk793JWsaXvISeSoRKu6qdDO4A9+mDqRR3JTWYRlLtRsWDXrNbkjmWyAVcSgkWhBoDcNWxcr2P/skhonDgNqYfa69d3lYztBixMeeaGKkAMY+7uvW7QYF7/HvtKHp1IuDswX6Iy5UKkYQE8aa2lJlCcJpxAeMibqb520vxpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663818; c=relaxed/simple;
	bh=ZYP83MqdavSo1L1Fs/xDxVjWMZNe4wfWkh4glIJwY2E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tWytD7NTW+joCou3NtjkXr+/um7dIVFtIsu5AyW60BMeAm9oVaZd5Yd3wHu3wnoB+jgNtm5Sz/vqAvrSBKjr/p9q5z0VaaYC8rWjBs2UK9Tbay6tFzYZ5q0skd3cuAbbVMe2HtpG0n0F1RfhV6YXFkIM1wTqNFynFBHBzVJGYV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=foNYHx76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="foNYHx76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCA11F000E9;
	Tue, 25 Aug 2026 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787663816;
	bh=YOb8Kt6IlAbzKJXtsZuwQqwcTrML/QUzs/LyA1VbVBs=;
	h=Subject:To:Cc:From:Date;
	b=foNYHx76Cj0Mf2PYNhmcGAmIGTVP7wt7pcq2yVUsSF1Q8iGiYn5GcesQgKotxCWXF
	 ViD2EJy0zU+Q09wYBbOSoFjkrGFrAvXwE94bEpS8PXr3+uXBvvSp6M4600sI58AO+o
	 qo7wsZDV8xV3yH5gu1AqJ4JDNlj5pq5alDRy0o7k=
Subject: FAILED: patch "[PATCH] HID: input: read battery capacity from its actual report" failed to apply to 6.12-stable tree
To: pepemontfort@gmail.com,jkosina@suse.com,signshop.alec@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 25 Aug 2026 15:16:42 +0200
Message-ID: <2026082542-footpath-citation-4670@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d07644524b6511b622ee7b0e2e68c9ee43d522a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082542-footpath-citation-4670@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d07644524b6511b622ee7b0e2e68c9ee43d522a4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Date: Tue, 28 Jul 2026 14:13:09 -0600
Subject: [PATCH] HID: input: read battery capacity from its actual report
 offset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..b55cbe7f6e20 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -432,17 +432,25 @@ static int hidinput_scale_battery_capacity(struct hid_battery *bat,
 static int hidinput_query_battery_capacity(struct hid_battery *bat)
 {
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + bat->report_offset / 8;
+	int len = offset + 1;
 
-	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
+	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, max(len, 4),
 				 bat->report_type, HID_REQ_GET_REPORT);
-	if (ret < 2)
+	if (ret < len)
 		return -ENODATA;
 
-	return hidinput_scale_battery_capacity(bat, buf[1]);
+	return hidinput_scale_battery_capacity(bat, buf[offset]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -593,6 +601,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	bat->max = max;
 	bat->report_type = report_type;
 	bat->report_id = field->report->id;
+	bat->report_offset = field->report_offset;
 	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	bat->status = HID_BATTERY_UNKNOWN;
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 47dc0bc89fa4..51b21f98037b 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -642,6 +642,7 @@ enum hid_battery_status {
  * @max: maximum battery value from HID descriptor
  * @report_type: HID report type (input/feature)
  * @report_id: HID report ID for this battery
+ * @report_offset: bit offset of the capacity field within its report
  * @charge_status: current charging status
  * @status: battery reporting status
  * @capacity: current battery capacity (0-100)
@@ -657,6 +658,7 @@ struct hid_battery {
 	__s32 max;
 	__s32 report_type;
 	__s32 report_id;
+	__s32 report_offset;
 	__s32 charge_status;
 	enum hid_battery_status status;
 	__s32 capacity;

