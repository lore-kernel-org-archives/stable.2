Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF433DA5C7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749883; cv=none; b=MwbgcENSZhNV9N/O3FM+6E2AOutHmy5Gvy8civWYZ3edwZKxLy6g1+sbG16ye0cAgZAhFHUiZQBgNvtxy042Nfniqt8GmT2MJfQl6j4B3d4afTqB19A0I6pDakeaebr6rTnSHTUHizFWyAuJ+W28f34CDEgQViwEbH4zVXtThAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749883; c=relaxed/simple;
	bh=/Y2PNEcTl2hj7R7unQcZkQ+LnZs3yY4zzw1O+eXOf7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCk16d0vosdo8d3ToLCJ7eFtnfZroaR3ViaINfZOSkBs+jiUxqvpDESCsPIKLt2zB2oGBTKg0XviaoJKhYxOJP6s8xFYKQU6aL+YYBdOiYVM6wuEMNCGEhMwP1eRCdYuoOakfvZY0rdBX9VTvEUTAaUZV7/FBVO4Z7ksNxN/v8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRyjZYA2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRyjZYA2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B0F1F000E9;
	Wed, 26 Aug 2026 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749881;
	bh=j1ROSwsEkUqm3JUxTA5Fpc1ka2WcK/umF5QPlMn5gLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRyjZYA2DjuF3sPlRGt4XAdNn5liKNJKUHizigKBtYkuBQXOUdq54+rjVCMvjjil4
	 nHvuy51mTmO01MpTb0CeN0bgeXK7uN9Ows5f7m+NkbRopNKSkDX1omxs1cypIp6ZNQ
	 cxEda73YrKYkJZRmNK6V78vnQMvKOomBImJT/T7DQWWGXFO3b79XBIssYb1nmDqvkx
	 FUzPpINBM6qTk7NfZkLCdssvYhZgTDYPU3q7f03+Il3XVFIttsccT6SvH/MOxcwMwS
	 EhNL7dJwbPVsLfTU21RukpYmqCSgy0NTXZ1vhY5AzdG1FQojz5pwHOx7pNEkKEjJTD
	 11DhDwBBycwaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID
Date: Wed, 26 Aug 2026 09:11:18 -0400
Message-ID: <20260826131119.3036540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082526-status-turbine-ec0a@gregkh>
References: <2026082526-status-turbine-ec0a@gregkh>
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
index 2eda56779b4c4..a459fc62cb739 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -375,6 +375,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -475,6 +479,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
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

