Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6D5424D76
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756049; cv=none; b=Cout4h8KRZ7sUpbmezb5V1kTRyH5GEFvzs7H7/eNxspGfqNzDqgvNPgBFMXH32c8Fit4go1i0R3QEzqAW5QRauUt3O/Oeg2MlwPgxMXoIur8SIGlxODgPgbWGEaACCXba2ZmbYgw3qUNmFtTObLjZR0iqUv0TQujtLRCL3jdoHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756049; c=relaxed/simple;
	bh=gaeLz9RY5PaLRZm6E/wQY592Onklt6PgRmfhN7nWLmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZIOrhwFRLhu/R4maPTLqfmtdpsaaPBu3oPmtIeDR+hRv/BZ/+EEyBs03QNqlhZYtvb1BSlt5e1C6vaT3u9zyy45RC2b+xk6g5skBMiKr6f3jzgajcTXr0cI92X5HTsBsS13pZt9rMflwCBXIrKt3ooLEQqjXYb0BePzAoG0b8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3cfWPXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3cfWPXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FD31F00A3D;
	Wed, 26 Aug 2026 14:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756047;
	bh=2Usof2gOpKWf4+ne/nB5QtgBVB+Rw2+I1s/5pHrlqCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3cfWPXtQBlgp2aMedRJwkFxkqfVjcKkylz87jRvdxIt/blX7KlYsvmI7Gt8X+7uD
	 grvo5C3Bv7dykY1BtzN1/O6l+QP3UvD6tY39PXEII6A8/U7iYnt6H+QyYHXcTbMf7g
	 1SkSJWvp6lsrY15zFOk3COGd3jDFoejNygpR30w6bCzZQUZO9R8kXXmtzNl1adlYB7
	 GLAQNb1eaNFukAUYFB8O8HIIpj2MQg36Go/SvJmk3UG1kuE5lnx6e8yZuNbrY9BaB+
	 8Lgz5KEX2VIurFbq0FkKVGK05FalxWeC2Fj97tDoWDR23WbU1ZzNWhH0f48tOjF7Eb
	 rYQ9/mmP6V1nQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
Date: Wed, 26 Aug 2026 10:54:04 -0400
Message-ID: <20260826145405.876122-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082526-tigress-premium-827c@gregkh>
References: <2026082526-tigress-premium-827c@gregkh>
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
 drivers/hid/hid-magicmouse.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index afde78319b996..93417e7572828 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -305,8 +305,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
-static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int __magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size, bool nested)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
@@ -384,9 +384,19 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		/* Sometimes the trackpad sends two touch reports in one
 		 * packet.
 		 */
-		magicmouse_raw_event(hdev, report, data + 2, data[1]);
-		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+
+		/*
+		 * A double report only ever wraps two normal reports, so it is
+		 * never nested. Refuse to recurse a second time; otherwise a
+		 * malicious device could chain DOUBLE_REPORT_ID packets to drive
+		 * unbounded recursion and overflow the kernel stack.
+		 */
+		if (nested)
+			return 0;
+
+		__magicmouse_raw_event(hdev, report, data + 2, data[1], true);
+		__magicmouse_raw_event(hdev, report, data + 2 + data[1],
+			size - 2 - data[1], true);
 		return 0;
 	default:
 		return 0;
@@ -408,6 +418,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+static int magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	return __magicmouse_raw_event(hdev, report, data, size, false);
+}
+
 static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
 {
 	int error;
-- 
2.53.0

