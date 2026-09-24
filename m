Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3F3C3F70;
	Thu, 24 Sep 2026 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260209; cv=none; b=tZ562z2NHFwV6VC4SCOTXpPqKdaLUGnak2rLN9kdfH97kFSSyzZVGrPH3Bdz8NOcJ5zxBj5xqiCDzI2X61YeNODNBO2RJGpQxvQufuCf22wBxSorSjENtH5rNHnQ3CfoUpHYRvL3AdnXu6Nh9k8dg914eaHu+SyHiDyGUTWgxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260209; c=relaxed/simple;
	bh=8rKO8WglxHyZuYmcva/JtMV3HCW1w5A612ov+YJZ7R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcsAPjTvQ0f35juJ7Ew+7+3zjiQylIMRipjVdqZsaWVDQOGi+H4H5TVdeVsH4o/VGzsblI9bMY0uvmpSxAhyZh8z9qV/U3gkEUfRaY8VGxNY0qT7BVie4Qc4heMiuFcBf1mbtIU4hpNhP26ZPFQkAors2A3iherrDGPRlWzbb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O+rPuKX5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O+rPuKX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ja
	dpd+6N+ODffekCXi2EbFGHR4RHmWy2yinTF38nacs=; b=O+rPuKX5dp40G+FsZt
	0I8UHr+pJqINKUQ176rNuu0Xfb4qb86WXZxw0ErXTFMO06xbkRkkDOo/7AK/CUOR
	UbtL+DVTahpxZ9RJL9BaKqYHacCEVGplF5iouNB7ieqn0iTFWVHL2hfhTyGdsR42
	mNl4BCSIzxSgMvB0xOpUH7HLA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3v7zAM7VqMhFPAg--.56297S6;
	Thu, 24 Sep 2026 22:29:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/7] HID: roccat: kovaplus: reject short button reports
Date: Thu, 24 Sep 2026 22:29:14 +0800
Message-Id: <20260924142918.1177952-5-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3v7zAM7VqMhFPAg--.56297S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7JryDury7ur4DJr4UZrykGrg_yoW8JrWkpF
	ZIkFs0krWUKr47Kw4UZF15Ca4Yvw1kXrW3ua4kG34jvw1ayryDAry0g34jgrs8Ars8KrZ7
	KF4vq3Z8uFWj9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMdgAbUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xkLRWq1M9mnsQAA3b

The raw event callback runs before HID core validates and zero-pads the
report.  It passes the buffer to helpers which inspect data[0] and read a
complete struct kovaplus_mouse_report_button for button reports.  A
truncated report can therefore cause an out-of-bounds read.

Require enough data for the button report before calling either helper.
Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw-event length validation to hid-asus.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-roccat-kovaplus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kovaplus.c
index 9ec42c218ef9..26832b279313 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -614,6 +614,9 @@ static int kovaplus_raw_event(struct hid_device *hdev,
 	if (kovaplus == NULL)
 		return 0;
 
+	if (size < sizeof(struct kovaplus_mouse_report_button))
+		return 0;
+
 	kovaplus_keep_values_up_to_date(kovaplus, data);
 
 	if (kovaplus->roccat_claimed)
-- 
2.34.1

