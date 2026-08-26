Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24C40E8D7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749038; cv=none; b=MNtEOhPwTTJPU0BoEbnkiabGJAS7FHsgRNCerezdvnGEzLtBLUS7fbcgvriiH5W2c9SxTg/qFvIxOkOqVjb60d45NwuDLHk41a3trOpvfdVt3S1MuqAz2/yRPB5ndck1CAWVYwAhlReRi1/YzcKu+lLmJjXPOK53LGZ7SBX1Ncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749038; c=relaxed/simple;
	bh=UBEvDHoWgWQ51JlpjesbkcCDMWagN+X7Bg1T+z+xWsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbXbo2PwGYGHId/pSFzAi/2wZcUwaGZ53QuQGRrC4sRTN5anY8wvtcPVpPUNjJ8SRNQ0V8tZ4ekIreF32pYc/FsVBkfNygpoghvMW3/867WHN8q7i17fkBjrdcseUtVcsrA3ZUKpbtlunUt9PXgFKtOc3TUmgGv89c1nTJgtPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE9QmCO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE9QmCO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBDA1F000E9;
	Wed, 26 Aug 2026 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787749037;
	bh=9aNpnRbh30dMX6pX+q4U6IRpyhHthurv53woVAWv0DQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oE9QmCO9mmd6sLS9Tr0DdFnJl+Zfwq584bokTyqFlnlJ2d37w8AmHGZBdzU05nuYi
	 +AvWueowToX5BGiLwcYdqkq8tC/Duk7tvtgR5Ox5abVvpe1H+AK6NYAZcxgGlMX0dQ
	 HqWrkvooLqsuIY5etbKCOZOFZsdmoQzIafWa23JqkOVRdRlcdFjOaY8C14F5E6nj2l
	 ulYCd+NZOfb4923hYF31d6/cBdRBUVaEZCJy0Oi0wHCLe3T8KNQ8ARgFm0MYCseN7v
	 hqDDlSE3NES8o8UFwKgp07GQD2DZINdLK6zPvrL6u5xomKiqc9JuWzdW/KKMGYTwUn
	 ZsycDF02MsVIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID
Date: Wed, 26 Aug 2026 08:57:13 -0400
Message-ID: <20260826125714.2952673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082525-sculptor-tubeless-a928@gregkh>
References: <2026082525-sculptor-tubeless-a928@gregkh>
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
index d5df2745f3da4..de13f4ec5dfd4 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -384,6 +384,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -484,6 +488,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
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

