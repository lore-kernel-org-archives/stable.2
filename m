Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F948F85F;
	Thu, 24 Sep 2026 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261095; cv=none; b=lwYj4Bg4wz/PJznLbseXls2z7/oLKVzROSAArESGRtSfg4fOtAr6wS0oCPZg25RmRezKdOuCRSVIi1K048bIv8ijSlt8m4tDg+Es8xUUgnUtPvcFX7hH5A3slj+pFm4hgin5ORBWNCM+JmoDbgXP6J4M23rzjbsGJAO22jRcNu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261095; c=relaxed/simple;
	bh=3V6zsaWZkV3AmfOkM4NDyGgnqhDAKaMMkVC3s8uT1Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDXfiaPyE36oF+2m50IFGCGZ3iMMXBFnjpPPUjunzeyWymQsvoahgW6G1SGTeOFAX1PP+qhpDmtV0xCfXAAhliWkG+UfubhnvDvj4KS0V0E+9ukvlIsOKYFNPEaQSX9pNcFZ/HXNaud509h6xbNYkDhS7gJAy+LtCesXm13JtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YokJHcp2; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YokJHcp2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2k
	1M6fx3ueANmn6GVVEI5evj18BpKqj4tThdWLwQKEA=; b=YokJHcp2lvJWwJ/Rps
	OCDpFCUGSnHI04px46fWYtUIhFf4CJX7VKmacd1m6sHF1wL5eBQI7HeTD4M6y08W
	6bR8CzZfB9QHil31mmOsh+/Ex6RinDCsJlPb5+hVhWPWj8uLY7ivgdusi0aOLRcO
	3ykPp857RQIlsPDqJQuMBS46c=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD330ZHN7VqyTtKAg--.25624S5;
	Thu, 24 Sep 2026 22:44:29 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	David Barksdale <dbarksdale@uplogix.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/10] HID: cp2112: validate response report lengths
Date: Thu, 24 Sep 2026 22:44:06 +0800
Message-Id: <20260924144414.1192037-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD330ZHN7VqyTtKAg--.25624S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF17uF48XF1fAF4kWrWrGrg_yoW8tFy8pa
	95tFs5Gr4DJw1Ivwn3Jrs8C345AF1xJF47ury8G3WY9r1rCF1UCF1jgry0q398JFZ2q3sr
	KrWqqw15GFWDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRpHqxUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7w3oI2q1N03xxQAA34

The HID core invokes raw_event callbacks before validating the report
length.  cp2112_raw_event() reads every field of a transfer status response
without checking size.  For a data response, it reads the length at offset
two and copies that many bytes from offset three, again without ensuring
that the input report contains them.

Require a complete transfer status structure.  For data responses, first
require the header and then ensure the clamped payload length fits in the
received report before copying it.

Commit 47669bec44fe ("HID: asus: refactor the two workqueues and init
sequence") added the same kind of raw_event length validation to hid-asus.

Fixes: e932d8178667 ("HID: add hid-cp2112 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-cp2112.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 04379db93571..6b938f75e72f 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1430,6 +1430,9 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	switch (data[0]) {
 	case CP2112_TRANSFER_STATUS_RESPONSE:
+		if (size < sizeof(*xfer))
+			return 0;
+
 		hid_dbg(hdev, "xfer status: %02x %02x %04x %04x\n",
 			xfer->status0, xfer->status1,
 			be16_to_cpu(xfer->retries), be16_to_cpu(xfer->length));
@@ -1463,11 +1466,16 @@ static int cp2112_raw_event(struct hid_device *hdev, struct hid_report *report,
 		atomic_set(&dev->xfer_avail, 1);
 		break;
 	case CP2112_DATA_READ_RESPONSE:
+		if (size < 3)
+			return 0;
+
 		hid_dbg(hdev, "read response: %02x %02x\n", data[1], data[2]);
 
 		dev->read_length = data[2];
 		if (dev->read_length > sizeof(dev->read_data))
 			dev->read_length = sizeof(dev->read_data);
+		if (dev->read_length > size - 3)
+			return 0;
 
 		memcpy(dev->read_data, &data[3], dev->read_length);
 		atomic_set(&dev->read_avail, 1);
@@ -1494,4 +1502,3 @@ module_hid_driver(cp2112_driver);
 MODULE_DESCRIPTION("Silicon Labs HID USB to SMBus master bridge");
 MODULE_AUTHOR("David Barksdale <dbarksdale@uplogix.com>");
 MODULE_LICENSE("GPL");
-
-- 
2.34.1

