Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393E397E66;
	Wed,  3 Jun 2026 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465481; cv=none; b=r+EeKUnWuazMlf7eD6XcYeJzII7q8QPeUhbUuXVQhm08suSmRN0fZhzHXjC/mlvmSW8YfzbQX+ajhngNAWdSV++DW4Dc1UYPn5VoyC+/EZyIrNqzCSSlxHabjfZh0uHUKQ8XVf4XpsqW5pPAQ0zm5yqzmRlqfrcxt4lCi5ZBfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465481; c=relaxed/simple;
	bh=vUPL9K3F2KOWZdXcbk6XWgfMCN5CXdC9BgspglKT3EM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PMKJglFDBAJWFD0YvtSOcL0Ocb/0Q4DaF4lv4HhkGVpe1edk2dtxrmk6naaV4+51bvIn0JlmY4Q9rSnb7F5qsLEI/5X+A5I+r73PH/zBIuPfaWMAMF7+qV8yLgoFl4igNxzAexSoMZpFMSsup+4+xYG9NCiS9m2BacRJg9nxCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g5CqnB5L; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g5CqnB5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=pi
	hnl6tV+07np2KM1vmM3V8vLITKZD8jA2XkqjVBMIU=; b=g5CqnB5LpCy7yqpFgy
	GWWCIHVRolVNf6fZhghsD4hvRt4cWtxvvI4h4UdK458ZI064lWAljvyKVrLG2zkt
	gNjkmaX2cyRG/Id4dy/QP1EklVNo0dQwlt8nQjP6iFxt1UTEaHCGDx5q6Fv7Kook
	W47zM0vVkMubRqrY11dRjpSdE=
Received: from China-163-team (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB3Mv8qvx9qObnJAA--.25958S2;
	Wed, 03 Jun 2026 13:44:13 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.12.y] HID: core: Mitigate potential OOB by removing bogus memset()
Date: Wed,  3 Jun 2026 13:43:44 +0800
Message-ID: <20260603054344.80160-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB3Mv8qvx9qObnJAA--.25958S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar17ZF43Wr13Xr17ur4xCrg_yoW8Ww13pF
	ZIyFs0kryqqa4kCw47GF4xZa45tas5JFy2gFW7Gw4rZw1Yka4UJr1Ivayavrs8urWIyr97
	CF4qyas8GF1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEeT59UUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxA1dJmofvy0YfgAA3z

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
[ Replace hid_warn_ratelimited() with hid_warn() in v6.12. ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/hid/hid-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 294a25330ed0..6d61bf20ec3f 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2029,9 +2029,10 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
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

