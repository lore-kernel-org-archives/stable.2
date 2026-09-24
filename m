Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600DD3C1F2B;
	Thu, 24 Sep 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260190; cv=none; b=qM7k+s5Vh3v4PnRnzvpp6LBJPuxGAbWJIzj+0263eem0DJesQgC5lxWUXScLh0n2dphXlBly/7Q75H08361mVqGZYQGX1h+stIkV+e1mIz3UfiRbMAwpjiQRfrGIg258tdqlgYz666D/bytFnEVgvSrPYKbgS7GbRJ0frOeTPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260190; c=relaxed/simple;
	bh=Ub+3/LjacvaUqdOxYYLSHvFyTLyuECjtpkx7iJQJUNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k17PzunFJ64wcoYEG8qZhPgcnJr7h17IJtHhq2KW4gL410tqGTQ73EPrGBO+J6F/5jPp+X5vmC5DeRhpMvWTbh1g/oHnleZxlp8hv0+lfO0y6nDHBdgNnACTBwSspU5p9/k3Zu11h8siO8GYXKV7ttrSElgGMMfmIPD3ueBF//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KAuHs8ea; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KAuHs8ea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qa
	HAH+1ZMTl/gD4fLztgyqc9+PNnhNHQlR0rToTOKmw=; b=KAuHs8eaTb6P06gjOx
	I3uwInj+g8r9NuOb69Q66YNgGkfMu07GTY1Bxd/GMnXMoLwz/VP1/ARyryxTF+Xo
	FwCvl1s7jlQLH6rFDtwfHpkrScpRsTto6Awp3HrCe6ySF6TtpzCUbZOnlE14aVdP
	yXpuz4lHHn/rwzKvG0fYEjHVM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S3;
	Thu, 24 Sep 2026 22:29:23 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] HID: roccat: isku: reject short button reports
Date: Thu, 24 Sep 2026 22:29:11 +0800
Message-Id: <20260924142918.1177952-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924142918.1177952-1-yaojiale02@163.com>
References: <20260924142918.1177952-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryDuryDGr18KFW5trWxtFb_yoWktrX_ua
	4xuwn7Wr1kGFyktr1rtr4avr9rtw45uF1fZ3yjqFnaqry5Z3W3urnaqrn5WryUWrs5ua4q
	kwn8Aa4xZrsI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRmD7zPUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQMFP2q1M8OSsQAA34

The raw event callback runs before HID core validates and zero-pads the
report.  It passes the buffer to helpers which inspect data[0] and, for a
button report, read the complete struct isku_report_button.  A truncated
report can therefore cause an out-of-bounds read.

Require enough data for the button report before calling either helper.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: d41c2a7011df ("HID: roccat: Add support for Isku keyboard")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-isku.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-isku.c b/drivers/hid/hid-roccat-isku.c
index 93a49c93ae8c..ef1ec9ccaa82 100644
--- a/drivers/hid/hid-roccat-isku.c
+++ b/drivers/hid/hid-roccat-isku.c
@@ -411,6 +411,9 @@ static int isku_raw_event(struct hid_device *hdev,
 	if (isku == NULL)
 		return 0;
 
+	if (size < sizeof(struct isku_report_button))
+		return 0;
+
 	isku_keep_values_up_to_date(isku, data);
 
 	if (isku->roccat_claimed)
-- 
2.34.1

