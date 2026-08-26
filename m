Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF93C2BA4
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749884; cv=none; b=GJdafXpAT9P+GjRHebfK5WSeAq+ymZ1D/C4vIM1m73VPTgg/0wZnTq+2YhLZvXDEvNUlBMkuRPw0BdZhGU25rV5/YMd/8nXC9HxfKsIMM33NQ13t3F37DQUqaldEhJa7wlJsZRI++dAVAFhcCjZuHn5MKb0+o2tjjvgj72oTlog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749884; c=relaxed/simple;
	bh=hDJ5utMxynrQhpxEw04mx/UVUa5b22tXo2jjob7Q5u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTJ5scfkjYdtQP/2RB+BDhkZSkTzcQ9cCnKp8CxJ+aFl6x+huk7NEfOgKIu/opRo/z9KcLdddNetDo7t2mfsVxKohcrAKPBRd2qzGiFruRTv+1AXG90/WdeBe1o0CFX+3/3KE3gFB2/vK8csoaRPZP6ofdwHlK5NN7LvBRbPigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1BzLy0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1BzLy0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E441F00A3D;
	Wed, 26 Aug 2026 13:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749882;
	bh=ZhSAsh08zX2PgmKorY1o2j2OnxAggYmFvaVkBJLwUv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1BzLy0Ux4/2p4CW4bF86Y2tiO8F8o3OW6iQJxyMarUF2eH1g/IdKJoHORpTa4z/K
	 Pgnz/meXj3cPCSl2h9cXYOL8z7IaMOg5/e4TP/vhyNWt/b9IPltAYO9nHFfc82OmRq
	 5gvKs6TNNWJI+vAy+zotixahLIx1SNn2MtMtR0RoTEHMHsi9QYfQ2ojb1YJ0whUK4p
	 vX/xelHWptU0ZZwoIpmGlGDAiTrIKEYsJbFYB0xIqXDp9fvdhtySD3tAFqscGwFVCc
	 VISqKsjdvLvqNs3NvzC46Iqlftjn2uqpiwuacQrYID3rXjGKgm54v71pnn2IiOSOfr
	 0LlM9t52X/RIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()
Date: Wed, 26 Aug 2026 09:11:19 -0400
Message-ID: <20260826131119.3036540-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826131119.3036540-1-sashal@kernel.org>
References: <2026082526-status-turbine-ec0a@gregkh>
 <20260826131119.3036540-1-sashal@kernel.org>
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
index a459fc62cb739..cf8a10752f4c8 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -368,8 +368,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
-static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int __magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size, bool nested)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
@@ -480,6 +480,15 @@ static int magicmouse_raw_event(struct hid_device *hdev,
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
@@ -491,9 +500,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
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
@@ -516,6 +525,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
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

