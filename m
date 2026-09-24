Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7A3396B9A;
	Thu, 24 Sep 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259248; cv=none; b=QsVLyq5MbGEfPjDFe3CkWrwYf9moIYts7J+zRGr7ZzQ89HUfcu4hNQaT/KO9vzhxOZy4cSBPdKmGebGpl1fe/vRlfWKmsIsfPzw2TsuboJjmrW8Nuq+mi3msPYO2xvMupF5YTut6BsZuDnwSUA3j0mc1Ioa32+ecjG8axU7Ymk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259248; c=relaxed/simple;
	bh=v4HnElppdkTTpGF5YsiZmpQYv9wwlkRxdY/XfeU1KGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpwmLKYVPcKdRnAGeqMERm5PO8+2+wzpZcFCdiAffu1AyIEJIL6za4SlcZbk148v7U/+TtybTHwfSsy00skSHWBUwvdwHLPJBWF+8iY/hbFMy3FKu87bZ0vqrEROKUZ4smh3pdlNSVK6/ea1S/T0M1QsTdBuwvQbCak3crR6eL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f/yJUAwz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f/yJUAwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8X
	smbpeUSmHxHlokK/RMK/RB2b9+QB57A5De1YNTHJk=; b=f/yJUAwzfrggUeg24d
	ZMoWFFHqy834fq06U0i3+Mthb3qqmDfEB/PmfGshCCDQ/4xPR6u3JXe7gYmyjB2X
	PSP72go3t6HeRQZXcUbZ68MiVic841zj0SnbgkVT10BD9bgeJ6aKlq1wE5XQaSRU
	ZEmGCZJOQ0fqvOmi2SX9rqGMA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXN8sIMLVqBMA4Ag--.5098S12;
	Thu, 24 Sep 2026 22:13:42 +0800 (CST)
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
Subject: [PATCH 10/10] HID: zydacron: validate key report length
Date: Thu, 24 Sep 2026 22:13:25 +0800
Message-Id: <20260924141326.1154421-11-yaojiale02@163.com>
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
X-CM-TRANSID:_____wDXN8sIMLVqBMA4Ag--.5098S12
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw47tF43Aw4fJr18KF1rJFb_yoW8GFWkpF
	ZxKrZ0yFW5trWfuw15GF4rJa4jkF1vqw12qasxKw109w15ZFyUGrW29F90qr1rXFsYyr9x
	KF4qqwnxCry0va7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pij-eOUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRYZU2q1MBZFqAAA3F

The HID core invokes raw_event callbacks before validating the report
length.  zc_raw_event() verifies the report ID in byte zero and then reads
the key code from byte one for report IDs 0x02 and 0x03 without checking
that the second byte is present.

A one-byte report reproduced the issue under KASAN:

  BUG: KASAN: slab-out-of-bounds in zc_raw_event+0x54c/0x580
  Read of size 1 by task hidtrigger/93
  Call Trace:
   zc_raw_event+0x54c/0x580
   __hid_input_report+0x2ef/0x3a0
   inject_store+0x479/0x490 [faketrans]

Require both the report ID and key code before processing the report.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: d0742abaa1c3 ("HID: add omitted hid-zydacron.c file")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-zydacron.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-zydacron.c b/drivers/hid/hid-zydacron.c
index 1aae80f848f5..02de153d5628 100644
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -114,6 +114,9 @@ static int zc_raw_event(struct hid_device *hdev, struct hid_report *report,
 	unsigned key;
 	unsigned short index;
 
+	if (size < 2)
+		return 0;
+
 	if (report->id == data[0] && (hdev->claimed & HID_CLAIMED_INPUT)) {
 
 		/* break keys */
-- 
2.34.1

