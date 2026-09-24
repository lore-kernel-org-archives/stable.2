Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176453932D1;
	Thu, 24 Sep 2026 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259240; cv=none; b=hPV7lQjDI1m8/6Gda5ea6MmZvPiWrpfaN166bQWJcp1MCfUprjK3rJ5/e5DuqJQR5eWxqyGKP05xRbFUxVEF/YXDx1haATXnnBHkgRf6jMR6ObC8Df2mqa4k4Y/+rVM0hStEPNo9Tbo4M7OCYCVno2FeazRMGrhxq8plKUSvOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259240; c=relaxed/simple;
	bh=/Uy7DAdU0mosHarlpyf9ytp/CWyo2kPyZX7E1zok3yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1lO5SWfR4TSAYpx3A7l+50al0wEzHfHmSRKUnT7gkMscERqHOArNih9sPqao9qse0cSMd4l566IrnhnUDxt5wcnLHWFrFw+o0GWAVmAosGB8tm+LEBHm1D0trqv+S+hpcChpFUB51PMzF9r81B+014ah90+qNWtWSD71oqWi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qYLzLY4w; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qYLzLY4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EO
	U1yQk9X2oC2BNnQBqt12AdJYjuCwcmAuQONkn1kYs=; b=qYLzLY4wkqd0sqTHss
	0daapivXnnVpWa8tXyWPwQUxTlxrfvMvwLql06VCIbpbMi6w1BESd8HKNzdhHn2b
	SeBfDf9Jer7i1acGIRPODRC+tXuWHf73XTtkS0yaooP62CMdHMR+WlOdsiplS8bS
	t0dFSuZJ6B92PL8e5HMBRDD44=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S8;
	Thu, 24 Sep 2026 22:13:37 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	"Daniel M. Lambea" <dmlambea@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 06/10] HID: mcp2200: validate READ_ALL response length
Date: Thu, 24 Sep 2026 22:13:21 +0800
Message-Id: <20260924141326.1154421-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924141326.1154421-1-yaojiale02@163.com>
References: <20260924141326.1154421-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1DAFWkWFy8CryrWFyDKFg_yoW8WF18pF
	Z8t398Cr45Jr4I9w4DJF1ruryrJr1kGrWxWF97C3W0vwnxXFya9FZa9Fyvgr13XFWqywn3
	GanYqwsrGa4qka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRm9a9UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhEYUmq1MBHFMAAA3e

The HID core invokes raw_event callbacks before validating the report
length.  mcp2200_raw_event() casts a READ_ALL response to struct
mcp_read_all_resp and reads fields through offset ten without checking that
the response contains the structure.

A one-byte READ_ALL response reproduced the issue under KASAN:

  BUG: KASAN: slab-out-of-bounds in mcp2200_raw_event+0x24b/0x3a0
  Read of size 1 by task hidtrigger/89
  Call Trace:
   mcp2200_raw_event+0x24b/0x3a0
   kasan_report+0x139/0x170

Reject an incomplete READ_ALL response with a protocol error before reading
its fields.  The common completion path then wakes the command waiter with
the error instead of leaving it to time out.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: 740329d7120f ("HID: mcp2200: added driver for GPIOs of MCP2200")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-mcp2200.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-mcp2200.c b/drivers/hid/hid-mcp2200.c
index dafdd5b4a079..c6fd5fb5d578 100644
--- a/drivers/hid/hid-mcp2200.c
+++ b/drivers/hid/hid-mcp2200.c
@@ -301,6 +301,11 @@ static int mcp2200_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case READ_ALL:
+		if (size < sizeof(*all_resp)) {
+			mcp->status = -EPROTO;
+			break;
+		}
+
 		all_resp = (struct mcp_read_all_resp *) data;
 		mcp->status = 0;
 		mcp->gpio_inval = all_resp->io_port_val_bmap;
-- 
2.34.1

