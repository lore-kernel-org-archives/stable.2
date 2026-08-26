Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073243B6C19
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743308; cv=none; b=Bum79OqDN3klo9ccQUJHdq3qnGlMzZLKe9DHbCHvFFHOg4+lOWTdIDAAZpEQx4rUghWLww71t4OCGHX+ErEHSUiyiLFqodPj+rZNZTbCrLS42kKxj63gXnJjeLsHI3VrKi8yVr1G2iBgRWE5b5S4Ws+NJ6FR2liIn3h0lTAEafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743308; c=relaxed/simple;
	bh=bsmeZ+Ysgq3Aut55NhyyoFD9MV4atdlOUf7V6YbIeOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ERPFaBVjSh7IbCY5+NC74h/tgh15u2h+Ty0p1QK09HUUDuSfl3QZtRoJH0l0qzB89jtdvdwEVx3bRmaO/IoX1TgVsQH7lGnZZTZUml4XSz3kBs6q5s/ZB2j3dvBhSXGtGKQwAv/zR9q5tYo18hFLoRcXkm1HMy3YTJNCwuLjHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lut417t3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lut417t3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1865E1F000E9;
	Wed, 26 Aug 2026 11:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743306;
	bh=e+ZLZH55Jcm5dD48BYlzq/WnthBn5Tf0l/2NkDytbeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lut417t3Cd1MgXliSX9R3UeVzdjnwaOAN6ic3K1WtytNkHUqcVSU2Yw6oVdO/W0Pv
	 pBc4whab2AT12uKzKmtfU5LOhC2k5CjhvM4R3ckJPvJB5jzwqs1nDfxmpoE5RkYXsU
	 PSOZXNjTbBqfxfYfSb9GA2vLgGVZBsazs80XwXPQnd1PZvbYrI8g5MV9HueqtplHKR
	 4YGhflCPH7NBZSIpc+cVUFySypyTZJ+rDYKnIpxmItWSgcPdM+Qv59TVNfEBoRLe5c
	 Z54rdL723AjAftpAfFgeQzpBL7/XUPaIh8SM9feRmEpqZYvSgyDZjzfyT4O9XXhRcN
	 1rw6yFsfXsKyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID
Date: Wed, 26 Aug 2026 07:21:42 -0400
Message-ID: <20260826112144.2645671-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082523-agony-jeeringly-e4b9@gregkh>
References: <2026082523-agony-jeeringly-e4b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lee Jones <lee@kernel.org>

[ Upstream commit d93ba918a185aca2594da63e92fdc5495b559c0f ]

It is currently possible for a malicious or misconfigured USB device to
cause an out-of-bounds (OOB) read when submitting reports using
DOUBLE_REPORT_ID by specifying a large report length and providing a
smaller one.

Let's prevent that by comparing the specified report length with the
actual size of the data read in from userspace.  If the actual data
length ends up being smaller than specified, we'll politely warn the
user and prevent any further processing.

Signed-off-by: Lee Jones <lee@kernel.org>
Reviewed-by: Günther Noack <gnoack@google.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Stable-dep-of: db8d634128d2 ("HID: magicmouse: prevent unbounded recursion in magicmouse_raw_event()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-magicmouse.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 9eadf3252d0dc..f53839484c861 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -390,6 +390,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -490,6 +494,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		/* Sometimes the trackpad sends two touch reports in one
 		 * packet.
 		 */
+
+		/* Ensure that we have at least 2 elements (report type and size) */
+		if (size < 2)
+			return 0;
+
+		if (size < data[1] + 2) {
+			hid_warn(hdev,
+				 "received report length (%d) was smaller than specified (%d)",
+				 size, data[1] + 2);
+			return 0;
+		}
+
 		magicmouse_raw_event(hdev, report, data + 2, data[1]);
 		magicmouse_raw_event(hdev, report, data + 2 + data[1],
 			size - 2 - data[1]);
-- 
2.53.0

