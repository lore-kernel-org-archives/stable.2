Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CF734040B
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735924; cv=none; b=uOYt4qEwP6qYgrzP4qPMHNmtafS+Q204FYNhjv/IaBVHTHxeQHskgvoKSm7a1Uxn6oL38THavGFEDAJ0Ww5c3IoI7vK31xveSbKsZCsmnZefMw7gAqHbv6RdYYyd6bO8vh+INzebGTu6YSvgkuPJlCfKcvuV6HlwJECJY2oxVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735924; c=relaxed/simple;
	bh=Fi/q5XK3HgG+1q5uCS9ayYAJknU1b7xOM13LW/cAAJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLPhGeiUbdh+A2lEOHxBr2eL0QUbslPW7i92MLfCzrQJVbdzIOKlTRlb6/KICvyydMJ/ugE+SgQGJ7F2mORm3IVbDp04HhCGpAFsE8JlGmLT9EUtQpOK7Ch1MR+eRwNWF5faVBV7sCOtuD3iJM7KHW8oNCnbaScmhJqwVsgdWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjcneqV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjcneqV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BAC1F00893;
	Wed, 30 Sep 2026 02:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735923;
	bh=Bc9ndYrf5VpeMsjUIp326jMXrZOLvGZR9NXznWXoiwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjcneqV7roN/jSXWNzlQAm7Idmg3Vaa7r52BfOG5Sxv7zj4cCwUEwXM6f/C/QsrxI
	 3iTBgZkJsl1u1wf4xhStC3qveRnYclqoTw26u+sAQxf2WrO2D8zCPxZ4E3N5I5yfRT
	 qJQtE7LuDUisXzackAMor5CiG+cZs/jdtkMMTlvWvK60tE8uFd65p2P/4izQ7Ar083
	 eXMY9DIpROiPDqclgX0Ft3LE9wZ76cwycjwcfvUFGmBlS7DuT2A3l20BBZOC5WBDi6
	 r8WQtfeZnQ8ueKik95nSUrU00QAqeaeEr8Xa50NsvpiZF071mdxETUpIA1/oJVMggN
	 g20UAU5hViVuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] HID: hid-alps: use default remove for hid device
Date: Tue, 29 Sep 2026 22:38:39 -0400
Message-ID: <20260930023841.3438294-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092900-radar-unrushed-0fe1@gregkh>
References: <2026092900-radar-unrushed-0fe1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcus Folkesson <marcus.folkesson@gmail.com>

[ Upstream commit 989f7cc94f1174269282a4a46bb735c7f11527de ]

hid_device_remove() will call hid_hw_stop() as default .remove function
if no function is specified.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: aa9dde93e05a ("HID: alps: unregister DualPoint Stick input device on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 8302078fe5fa1..8bf3f21998bb2 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -823,11 +823,6 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return 0;
 }
 
-static void alps_remove(struct hid_device *hdev)
-{
-	hid_hw_stop(hdev);
-}
-
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
@@ -845,7 +840,6 @@ static struct hid_driver alps_driver = {
 	.name = "hid-alps",
 	.id_table		= alps_id,
 	.probe			= alps_probe,
-	.remove			= alps_remove,
 	.raw_event		= alps_raw_event,
 	.input_mapping		= alps_input_mapping,
 	.input_configured	= alps_input_configured,
-- 
2.53.0

