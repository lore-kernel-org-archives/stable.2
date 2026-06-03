Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AD3E1D1A;
	Wed,  3 Jun 2026 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465506; cv=none; b=OtC24iohSanQZezb2urd8TIZOMblt2GyOY+WjuBpWzzRGT6Krjk4FC3I37k90iwa3UevXZtg5gjSoTpOY88AjOH/HqDuLPRyBlmnMvVwvhA+n+rBjlSfrsDHrYtr71NM9PKupJNhGn5hhhx32hhJj3pm9Qh4XrXEY0mvtuomznI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465506; c=relaxed/simple;
	bh=elxPAkEAucgOKY7uEINE2mpPjgbA8EWVVY2c4V4UJ+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JBl41APoriLfJIZL/PJkNxN16uoUVKwIa/6R5ZdsGP1ExP/9ZJ//xuUryaWx2ctBw8ZCjHg8aHzOy02mWlWqCpbj6MmD/4cJCxJU1pYSk0pugEGK+hUOOcY7cDDq//XBhVGPT1pqYVqs7hbDwMo8nMze7Lmrm/oVl5HQ68P7yGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ls89ALDq; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ls89ALDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bt
	ByK7taRLISgmABeff3Vob+zVf3Tb++FM9bEwKnWHw=; b=Ls89ALDqsJIlJdHkUC
	N878XpXxcRLkfiWJu7hRonYNjR35TWfKEc0TWfGbgnBPF2elBAP2dof5m/OtQzYP
	2sdr0Dm+jYpPBdcN4kiFIE7EC98W1wPiOOhQsUWzW5opfk0t8Icova8j05cBAhFD
	gk1QVxtMvhTHklZy7bTDkAhoQ=
Received: from China-163-team (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBHHmFDvx9qNYWZBA--.35631S2;
	Wed, 03 Jun 2026 13:44:40 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Wed,  3 Jun 2026 13:44:31 +0800
Message-ID: <20260603054431.80206-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHHmFDvx9qNYWZBA--.35631S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17ZF43Wr13Xr17ur4xCrg_yoW8Ww1xpF
	Z0yFs0kryqqas7Ca17GF17Za45ta4kJF12grW7Ww1fZr1Yka4DJr1Iva9Ivrs8ZryIyF97
	CF4Dtwn8A3Wjv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEzuWJUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbC7AhkLWofv0gSPAAA3B

From: Lee Jones <lee@kernel.org>

[ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]

The memset() in hid_report_raw_event() has the good intention of
clearing out bogus data by zeroing the area from the end of the incoming
data string to the assumed end of the buffer.  However, as we have
previously seen, doing so can easily result in OOB reads and writes in
the subsequent thread of execution.

The current suggestion from one of the HID maintainers is to remove the
memset() and simply return if the incoming event buffer size is not
large enough to fill the associated report.

Suggested-by Benjamin Tissoires <bentiss@kernel.org>

Signed-off-by: Lee Jones <lee@kernel.org>
[bentiss: changed the return value]
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[ Replace hid_warn_ratelimited() with hid_warn() in v6.6. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e3d728d67b53..1f32aa933c9e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2017,9 +2017,10 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (csize < rsize) {
-		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
-				csize, rsize);
-		memset(cdata + csize, 0, rsize - csize);
+		hid_warn(hid, "Event data for report %d was too short (%d vs %d)\n",
+			 report->id, rsize, csize);
+		ret = -EINVAL;
+		goto out;
 	}
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
-- 
2.43.0

