Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA675418361
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748305; cv=none; b=ItrWI4YbFVe2IIuJqX6vm7wdPUr8m5rirxtWthG8xfCbDbxOSzM/jEbmh6A3l8X8LHV+//5yK3l8eK6put0klvgAMTp33Fk2qo7L0IxhQaDQKVvGnkyXB9OVEoLWttDKNpyhPj6b3Qq2tiAYt1qGtWUvMn2dy8hgBu6I5nmyLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748305; c=relaxed/simple;
	bh=ERGZNhMhm1ystwHRzoHfFg/CdmFzgCd9EU2JGdas+P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQlbqpA8hdeJWHQakEd8aDVpKTY43+xM+Fd3ABnKiraHVIiOxZhpe3XQ6qG6MGDktxLa/UsbP/lxP67ZovB///BlxbrazgmG+T7G48po9aCbhPs6Z3e6igphIw7LVgMQ/2TFXoQc7F1k0j+IWS/tDK1Wn63sVVSCkjqSLki26oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGNKC5bU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGNKC5bU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074AF1F00A3E;
	Wed, 26 Aug 2026 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787748304;
	bh=IkYIkK5MwFTEfGiLC728lzG+daC2WVWA1XY+wKtlZPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGNKC5bU0koPsHUSmbUIyFV20oyI18xHmDeiQf1SPJ/I7fs8k6uZIwkxfOqpAC5pw
	 OM3Q53kvM1YzInu/mClCD+1+cwsQLTtZT5x6+IS4kRJcz5sA6uqtt+UA49cVUsErG+
	 bvXPE+gHnTN37DcG/p5cwYyHk/z3F2xv7oxxd3730wVRpCeP6uYcUIORbau6aCyGeA
	 lasSP5g+u8D/JLChNUZEf12GC1cMVMd6oPISLuXWvCvZ13wGJVhYRsH+4OvWecVash
	 qW22ZLzGAkvawjqmXe8cai7VeWz330Fiks3OoQ6kB4nJuNP+rtdG/HUaHRlfB8HAdF
	 cFBpZViYdoUSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
Date: Wed, 26 Aug 2026 08:45:01 -0400
Message-ID: <20260826124501.2941338-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826124501.2941338-1-sashal@kernel.org>
References: <2026082525-parabola-duplicate-d396@gregkh>
 <20260826124501.2941338-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jose Villaseñor Montfort <pepemontfort@gmail.com>

[ Upstream commit db8d634128d2ba88d79c0b601e983ebe14bb0519 ]

magicmouse_raw_event() handles DOUBLE_REPORT_ID (0xf7) packets, which pack
two touch reports into one, by splitting the packet and calling itself on
each half. The only guard against runaway recursion is a "size < 1" check,
which stops zero-sized calls but does not bound the recursion depth.

A malicious HID device that matches this driver can send a report starting
with DOUBLE_REPORT_ID and filled with the sequence [0xf7, 0x00]. Each level
consumes two bytes and recurses on the remainder, so an incoming report of
up to HID_MAX_BUFFER_SIZE (16 KiB) drives roughly 8000 nested calls. That
easily exhausts the 16 KiB kernel stack, leading to a stack overflow: a
panic with CONFIG_VMAP_STACK, or memory corruption without it.

A double report only ever wraps two normal reports; it is never
legitimately nested. Refuse to re-enter the DOUBLE_REPORT_ID case from a
recursive call so the recursion depth is bounded to two, while all valid
packets keep being parsed exactly as before.

Fixes: a462230e16ac ("HID: magicmouse: enable Magic Trackpad support")
Link: https://lore.kernel.org/linux-input/20260706181347.700DB1F00A3F@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jose Villaseñor Montfort <pepemontfort@gmail.com>
Reviewed-by: Alec Hall <signshop.alec@gmail.com>
Tested-by: Alec Hall <signshop.alec@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index de13f4ec5dfd4..31cea46dee903 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -377,8 +377,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
-static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int __magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size, bool nested)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
@@ -489,6 +489,15 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		 * packet.
 		 */
 
+		/*
+		 * A double report only ever wraps two normal reports, so it is
+		 * never nested. Refuse to recurse a second time; otherwise a
+		 * malicious device could chain DOUBLE_REPORT_ID packets to drive
+		 * unbounded recursion and overflow the kernel stack.
+		 */
+		if (nested)
+			return 0;
+
 		/* Ensure that we have at least 2 elements (report type and size) */
 		if (size < 2)
 			return 0;
@@ -500,9 +509,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 			return 0;
 		}
 
-		magicmouse_raw_event(hdev, report, data + 2, data[1]);
-		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+		__magicmouse_raw_event(hdev, report, data + 2, data[1], true);
+		__magicmouse_raw_event(hdev, report, data + 2 + data[1],
+			size - 2 - data[1], true);
 		return 0;
 	default:
 		return 0;
@@ -527,6 +536,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+static int magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	return __magicmouse_raw_event(hdev, report, data, size, false);
+}
+
 static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-- 
2.53.0

