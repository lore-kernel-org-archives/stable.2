Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363519;
	b=stFlGelLU7gk0YcBPp450i7Iq1YsVqFy/0RsZCTNvxfTHeZyGffVQnlbgfn8OPFS015Z
	 IO362iVQFwtO2wPakAmF7RcFiajdxKw3YaqGecmRfSM8sf7VU3++obN0gK1E/3MDDDPcv
	 CdBUvaH9agobp5/aeOyF9z6i+GKwuE1zn88Jb8GdeZ9CG/CL8bbhQPCsxxMUdbzOk2wWE
	 3v6zx1E/rI/V02f7tUfKq1ZAHRrTf0WOkTphm0N8/g29tJZmgvICsLEiXW48ukpTBr1S5
	 CssV89MCu51//pZOx7oQAJdpN6sydH34YfzObVebinvfimgf+YKiH8YaRtpgWcByN+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363519;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=9c0/7PCLhecC2oy1paPDEkI4oUif8yn/Dj41/cLYobM=;
	b=xmqloddmzXo0Q3V+jrAw1XejqmM7IbFS9eefMNSecDErfkzrOGieh3s+jXDqSMIVDA+o
	 S7f+LCw42Q9W+RznUtVLscgR6hB7FKKz68DGkGVB3WynTZZtbWcJB6n46wAuDWmiR6hYN
	 aK4uZqFzT8VYrROICG3jbycgfWpDIr2TA3dmtzMTbcMvYYSWNRmQl5Qt9ZRRgq13WTn6s
	 /BtAtZJZJzX8+zD6l2aZH0PHhfSeOWOE3exdzzycx6pyKWbUTbDnftiO2RFCWDjYG0ugc
	 hInkuQri+tHWBNsxJsMGdM/eMtGSaxZrH30+8Nvpikmv3391LHYCAzdZgsEdPQNR9Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hNRLVe4Q;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B99606A32C;
	Sun, 22 Nov 2026 16:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11B99606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hNRLVe4Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9c
	0/7PCLhecC2oy1paPDEkI4oUif8yn/Dj41/cLYobM=; b=hNRLVe4Qx5Ot/Yx2kI
	g+/071bfY3aEVRyJf6ItSCBaZat962sey/INCt9M/Fva/F/vtsOchXy4/ID17Kaj
	c7yzBfEiAJAYjbfOu2jSdYi1DDeoW7j68UGvQgrshu2zrBNUVHBoPSko4qG22lIO
	386fHoWcNwIgPumDZbFvOZIG4=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3n9GiEgNrnpKqJA--.31936S2;
	Mon, 23 Nov 2026 00:04:50 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] EDAC: thunderx: avoid stack disclosure through debugfs
Date: Mon, 23 Nov 2026 00:04:50 +0800
Message-ID: <20261122160450.519905-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n9GiEgNrnpKqJA--.31936S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1DGF47Gr4rCw45WFWDtwb_yoW8uFykpF
	ZxKFyUArs5trn0yF1UuayUZF1Yyw17JFyj9rW0g3yqyF17Jr9IgayYg3y0qFyDJrn7Kr17
	tw4qg3yY9F1qqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jKbyAUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7QJImGsDEqKeswAA3K

The debugfs readers copy sizeof(buf) bytes instead of the formatted
length, exposing uninitialized stack bytes. DEBUGFS_FIELD_ATTR also uses
the read count as the snprintf() size, so short reads with lseek() can
expose additional bytes.

Format with sizeof(buf) and return only strlen(buf) bytes.

Found by LLM-assisted static analysis. Cross-compiled for arm64; no
runtime test on the affected hardware.

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 drivers/edac/thunderx_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 9c0a1e48f..d24d74fd2 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -227,9 +227,9 @@ static ssize_t thunderx_##_type##_##_field##_read(struct file *file,	    \
 	struct thunderx_##_type *pdata = file->private_data;		    \
 	char buf[20];							    \
 									    \
-	snprintf(buf, count, "0x%016llx", pdata->_field);		    \
+	snprintf(buf, sizeof(buf), "0x%016llx", pdata->_field);		    \
 	return simple_read_from_buffer(data, count, ppos,		    \
-				       buf, sizeof(buf));		    \
+				       buf, strlen(buf));		    \
 }									    \
 									    \
 static ssize_t thunderx_##_type##_##_field##_write(struct file *file,	    \
@@ -258,7 +258,7 @@ static ssize_t thunderx_##_type##_##_name##_read(struct file *file,	    \
 									    \
 	sprintf(buf, "0x%016llx", readq(pdata->regs + _reg));		    \
 	return simple_read_from_buffer(data, count, ppos,		    \
-				       buf, sizeof(buf));		    \
+				       buf, strlen(buf));		    \
 }									    \
 									    \
 static ssize_t thunderx_##_type##_##_name##_write(struct file *file,	    \
@@ -322,7 +322,7 @@ static ssize_t thunderx_lmc_int_read(struct file *file,
 	u64 lmc_int = readq(lmc->regs + LMC_INT);
 
 	snprintf(buf, sizeof(buf), "0x%016llx", lmc_int);
-	return simple_read_from_buffer(data, count, ppos, buf, sizeof(buf));
+	return simple_read_from_buffer(data, count, ppos, buf, strlen(buf));
 }
 
 #define TEST_PATTERN 0xa5

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

