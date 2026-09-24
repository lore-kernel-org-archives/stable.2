Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312338C421;
	Thu, 24 Sep 2026 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261086; cv=none; b=mLQZD8c9yi+AXVYc1UDyLIq4r1Y1LrfNNkbmto5hVUdTgtVNeuKA2TgRCZO0sF/s0S2Iegp9ptFYTtGp8BHZxjN3nbgISHF3F+bEZH/fvfYDIJIPLbF4V0TL+2OirnjrnytEBVvp5nmzuy9VlHdzv50kVHitN2IcnMqh37Wpd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261086; c=relaxed/simple;
	bh=HXm1yorfvdGtaMEBU6GpbVck/uABmJb16a14ZL/lNTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HInjlltYvX2U9Q/1sTlUZR/2xl+XXY9CgG5DFA2j8DfLoX0KiR5wR8eoAzhNK2QGaUylnmYWhjfA+braj1b7qY8dhhExhDOg36XfwZc0YSDNbMF0iqzZxn6riaRADrjbCz5zZ5Pom0QJ11sWtKkAIAvJ9AL8suuofUsOHAcDEUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HGOaoGOd; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HGOaoGOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=yJ
	vO0Bk4vmm7stk9qO/JlCSbCGgN6pBCu9S63MWOT60=; b=HGOaoGOdpyXRs6K+f1
	SZMmBZr+cxTO9wDdcwSQkYct3wYYZK1ibVKJec5fddEFoUgzUi4vb1ZUMpVg6vgS
	y+EcVyrDKOzCNaFlP7jc2V5Zm5kQ5wyoIOsyuYGUF96W6UBoi7W7roVyz/HbmA9w
	wYNGS6fZGQmvNDThJTWl0JtCE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD330ZHN7VqyTtKAg--.25624S3;
	Thu, 24 Sep 2026 22:44:27 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/10] HID: alps: reject short input reports
Date: Thu, 24 Sep 2026 22:44:04 +0800
Message-Id: <20260924144414.1192037-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924144414.1192037-1-yaojiale02@163.com>
References: <20260924144414.1192037-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330ZHN7VqyTtKAg--.25624S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFykJF47CF1UAr1fKryxuFg_yoW8ur1DpF
	Z5Gr95trW5tr1fZFWjqrn8Ca4ayryxXryxXFy7K34I9w15X34UuF109ryFvr4a9r48Krsx
	Kr4q9FnYk3WDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_eHqUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AvnImq1N0v2vQAA3W

The HID core invokes a driver's raw_event callback before validating the
report length.  Both ALPS input parsers therefore need to validate size
before accessing their fixed-format reports.

t4_raw_event() casts the buffer to struct t4_input_report and reads its
contacts and button.  u1_raw_event() reads five bytes per configured finger
starting at offset three, or six bytes for a stick report.  A short report
can make either parser read beyond the valid data.

Reject reports that do not contain all fields used by the selected parser.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Fixes: 73196ebe134d ("HID: alps: add support for Alps T4 Touchpad device")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-alps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 67179e3fe39b..b1950aff6ad4 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -322,7 +322,7 @@ static int t4_raw_event(struct alps_dev *hdata, u8 *data, int size)
 	int i;
 	struct t4_input_report *p_report = (struct t4_input_report *)data;
 
-	if (!data)
+	if (size < sizeof(*p_report))
 		return 0;
 	for (i = 0; i < hdata->max_fingers; i++) {
 		x = p_report->contact[i].x_hi << 8 | p_report->contact[i].x_lo;
@@ -370,6 +370,9 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 		break;
 	case U1_ABSOLUTE_REPORT_ID:
 	case U1_ABSOLUTE_REPORT_ID_SECD:
+		if (size < 3 + hdata->max_fingers * 5)
+			return 0;
+
 		for (i = 0; i < hdata->max_fingers; i++) {
 			u8 *contact = &data[i * 5];
 
@@ -407,6 +410,9 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 		return 1;
 
 	case U1_SP_ABSOLUTE_REPORT_ID:
+		if (size < 6)
+			return 0;
+
 		sp_x = get_unaligned_le16(data+2);
 		sp_y = get_unaligned_le16(data+4);
 
-- 
2.34.1

