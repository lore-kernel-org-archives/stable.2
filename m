Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98E33AD9C
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787743958; cv=none; b=rqqf0DFobt/ASdLVHznuySqM1Kb52KJdgM2sZwG8oUiakkDP3aE/XfUj6xDp57CZRe4NUBGKVPAs7ruif27GEpgDtzAETW/hD2/qApeSh7CQQeFHgyaLi4crX8dYBzyIlSYpCOyJfbzXPfeqv9r6RKLtjmDQ8DfpivUwJGfYlq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787743958; c=relaxed/simple;
	bh=k/XkxnhooZ7NkutzHcKCTjnZufRvQQHNGv39lUpSD2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWE5GD8MXZ79smD25N43SyMhjeA7ygnWkM3YpR8Um3yP/hZ8/K8gZKtjBoAE81KG0C3zBl3XMkqEWRAiUzpR7b/7oaq0Ml2DCE2biIk7SlRMNG8fYITeGzw37pJl2DHQXiumvchd/gd+VyjqO5c1fJfYXZVXuf6juwWExx1XpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCX8RYeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCX8RYeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84AB1F000E9;
	Wed, 26 Aug 2026 11:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787743957;
	bh=0Pd7MFVpfM2lNv3su6E2nOfibwGTW5FQ/LHdEb7BWZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCX8RYeAJU9YzwcBbgR7S8JFKTPa+WN+YHtHt2lLKF8Z5f21xCPlW01Rq68pqS4tt
	 p2sJPAlx5yJ9lcEopeSFHACXRqPc2g2D5CwhSI3KaXcjxAAwO+u/DmQk3+HAgsrjEu
	 wGdxo6AZb3+WGJFk6/js9DsbHljiIeK8OVFNT9xMI8Ci2VhRF/IePQzqibPWpemXBs
	 aOFilNq+rS+eE5DG31JnYXQ7KVCPyWhayyml8jN/ul2USU0dh3XaSvNkGQFR0F2A37
	 /Lqq7odTP21DEy8lJwdjerluXXrW6qaCymACbIinf8xavf4GW+/EGh1ZiDeL1tCvv4
	 FavrZVyaGHr7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] HID: magicmouse: Prevent out-of-bounds (OOB) read during DOUBLE_REPORT_ID
Date: Wed, 26 Aug 2026 07:32:34 -0400
Message-ID: <20260826113235.2856444-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082524-service-cricket-becc@gregkh>
References: <2026082524-service-cricket-becc@gregkh>
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
index c59cfab104928..6f0ed4256697c 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -387,6 +387,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	struct input_dev *input = msc->input;
 	int x = 0, y = 0, ii, clicks = 0, npoints;
 
+	/* Protect against zero sized recursive calls from DOUBLE_REPORT_ID */
+	if (size < 1)
+		return 0;
+
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
 	case TRACKPAD2_BT_REPORT_ID:
@@ -487,6 +491,18 @@ static int magicmouse_raw_event(struct hid_device *hdev,
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

