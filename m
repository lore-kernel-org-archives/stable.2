Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F0497B8C;
	Thu, 24 Sep 2026 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262712; cv=none; b=KDFkJnI4qRskGTl5Pn3QhnEB/3XNOJLFoE9m5/P74KC1btjFrZrB6vcS+AqBbpBuws8CcAGk5fNB7vUAjbTjzWARNokjozGt64mmzbKAgRzPhhaEwroVD5Dbw8gigw4TjXOQqJQpSxuRW9hGLQi5w1TjAVWsMeFs45X4ZrU51Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262712; c=relaxed/simple;
	bh=j39WfOlerybCaemEI5vtqJivsP06dN9pf2kJ9hEByqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DhT6GUzdxDwGbXJ414e1OTm71gn3pydKc4Hy7GD+kFpGqrC3EcZijIh0ANHd6wK+F0buFDeiqUAHy4xM8YvF7gvoQuNhE9ksRy+Jjg5kQ0y5U+L2RnzkxU+glEvl8CIqPegNjR4GprmUSyBK7qbEEpz1khbW2c5RAU3E4upPEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UjXVECVf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UjXVECVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fe
	EP+Qc8nAtZ0/5DmDwDO/5CJBC+s/g6U6kVKOi2h/A=; b=UjXVECVf5LGx+Ahrad
	+RvHN7L2jK2/l8JGxiBV40cwv5tx+gOpUQSWv3NDYoFbHT7zGQ24QzfoHGGPsXcQ
	NVk4KdRzy9rkL7NOXwveBg6uoKhlGBl4wNOfg4e6HbiVphdEGbb8xIPbvOtQLxBW
	7XbyfNYfTmmySCR38ldXsoqZA=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHT9aaPbVqibnJBA--.10596S2;
	Thu, 24 Sep 2026 23:11:23 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) reject short status reports
Date: Thu, 24 Sep 2026 23:11:21 +0800
Message-Id: <20260924151121.1233666-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCHT9aaPbVqibnJBA--.10596S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFykZryrWFWfAF1xWw4kJFb_yoW8GF4rpF
	Z2yF98Cr15trWIvF4DGr18WFyFy3W8XFW2vr9Yy3WF9F4Yk3Wj9Fy2gF90vr45ZFWrtr9x
	KrWvqas3CFyjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_nYFDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRt9t2q1PZtoyQAA3E

The HID driver raw_event callback runs before HID core validates the
received report length.  aqc_raw_event() reads device-specific status
fields at fixed offsets, including multi-byte values, without checking
that the received buffer contains the complete report.  A truncated status
report can therefore cause out-of-bounds reads and update hwmon state with
data beyond the received report.

Reject status reports shorter than the length derived from their report
descriptor before accessing any fields.  Commit 47669bec44fe ("HID: asus:
refactor the two workqueues and init sequence") added equivalent raw-event
length validation to hid-asus.

Fixes: 0e35f63f7f4e ("hwmon: add driver for Aquacomputer D5 Next")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 1ca70e726298..1ebc8bc4c090 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -1331,6 +1331,8 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 
 	if (report->id != STATUS_REPORT_ID)
 		return 0;
+	if (size < hid_report_len(report))
+		return 0;
 
 	priv = hid_get_drvdata(hdev);
 
-- 
2.34.1

