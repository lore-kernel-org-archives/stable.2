Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630022;
	b=Dw1KEYOdSuVL4Fqgncvt2HYBqqiIPjvnQvn2YM9qHU8NpYhh380RgwaacLjb+E789QiZ
	 3gNBKsCVVyefVJuRWR2ASR5ymtTRJws54A/B37HN4vIH7OTDxzLS6oTUXGwWBwz5OCxHA
	 A7bFhRrAMxoX/tVNroxL/r5LvWGyshsKoTEbHl2Z399WiyDzXCMJejd8MPr4tExdj0c7P
	 2BUQNIGxpN03/dCmwyHhNZmYOKSbxvz4BOrpyDF+EQu8IseSm9dJGVsIWhzFjdn3ob2y2
	 51kI4lCfMTKQeXl4FzDEqRjn8drdVKshOXM1IXFTGovlOs6AQdWZvmdOvu8Yt5UUcZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630022;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+pugPSZq/s/fE9TPjrpmUwRipjTo1fomsqC0QeTx1NY=;
	b=t0tt7Kc9xQggSngBseFa4BhW0Cj1Hdqe0I/azJE23FyFJB/ulvgBvlx4yXfVfVm+T3gm
	 dZ0625dxMKCD0OLYUkm3MvUc/H8yyV+wh6fxGWLhouewty8eiusw/vmKbzXE2VlaaP6h2
	 vHmmBBRRfeq/1KtleIc3Cnai3dOi7+I1aukg8b53T+HJ3hKb9A+bBwXSLIMYym6SkAkex
	 AynOu3wKf2SuMURQDFOy3552s1XmfE/ZGKumxgencvFPAFgN54QznSe7RIhyDo2IaB/4y
	 Qty1hV15fTBJfAKqbUanCMdgO1aCDlDe+JGKA7b/FwKseXSTwe2VvHgN6MsuUOX7MwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEjX1Blp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D4606A6B6
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEjX1Blp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05241F000D3;
	Wed, 25 Nov 2026 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630022;
	bh=+pugPSZq/s/fE9TPjrpmUwRipjTo1fomsqC0QeTx1NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEjX1BlpGeTBMNvjug2guDa9mhs6aMBTDArYbbF/L9ftR+xUnFUnuvwTn4SgwPEkk
	 J3MusmO9ATe59c4cGkIAQh3E3+tRUBVqU87jKbMMaffYBnnJ+gkwz9m7aChCZ52uHd
	 Qh9dQJWQVwwoSpCQBvJyfFyeThtvJbL48HTFHqycaw5WUdTinAKtmltp11aFUxqSZt
	 nIdq4k8kFBzvj2Cj9cCWUgYmHYY9zi36WzOF8r4R8/lYMWlqHFaH2885gOmVoq65vH
	 Hcd1VQ8CpLRl2KglEbaprSEqB4JWLhge7A9ruomioDZBY5hEXVIN0q26xB4TMih8KV
	 gqkcZs483OAbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] s390/dasd: Use dev_err() over printk()
Date: Wed, 25 Nov 2026 13:06:54 -0500
Message-ID: <20261125180617.1129141-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180617.1129141-1-sashal@kernel.org>
References: <2026112516-sculpture-facial-ba8e@gregkh>
 <20261125180617.1129141-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Höppner <hoeppner@linux.ibm.com>

[ Upstream commit 0b3644b475e2564abe26a916af8447beb7c4966b ]

To reduce the information required for the string generation in the
sense dump functions, use the more concise dev_err() variant over
printk(KERN_ERR, ...) to improve code readability.

The dev_err() function provides the component and device name for free
and the separate dev_name() calls as well as the PRINTK_HEADER can be
dropped.

Dropping PRINTK_HEADER removes the "dasd(eckd):" for all lines. Only the
first line of a dev_err() call is prefixed with the component and device
(e.g. "dasd-eckd 0.0.95d0:").

The format specifier for printed pointers is also changed to unhashed
(%px) as this can help with debugging and servicing.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20240208164248.540985-7-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 25cdc1f63227 ("s390/dasd: Re-initialize RCD buffer with "V1.0" before every start")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 139 +++++++++++++--------------------
 drivers/s390/block/dasd_fba.c  |  55 +++++--------
 2 files changed, 76 insertions(+), 118 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 986e1da023075..49901c4a2abf4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -38,11 +38,6 @@
 #include "dasd_int.h"
 #include "dasd_eckd.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
-#define PRINTK_HEADER "dasd(eckd):"
-
 /*
  * raw track access always map to 64k in memory
  * so it maps to 16 blocks of 4k per track
@@ -5559,15 +5554,15 @@ dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
  * and return number of printed chars.
  */
 static void
-dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
+dasd_eckd_dump_ccw_range(struct dasd_device *device, struct ccw1 *from,
+			 struct ccw1 *to, char *page)
 {
 	int len, count;
 	char *datap;
 
 	len = 0;
 	while (from <= to) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       from, ((int *) from)[0], ((int *) from)[1]);
 
 		/* get pointer to data (consider IDALs) */
@@ -5590,7 +5585,7 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 		from++;
 	}
 	if (len > 0)
-		printk(KERN_ERR "%s", page);
+		dev_err(&device->cdev->dev, "%s", page);
 }
 
 static void
@@ -5621,9 +5616,12 @@ dasd_eckd_dump_sense_dbf(struct dasd_device *device, struct irb *irb,
 static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 				 struct dasd_ccw_req *req, struct irb *irb)
 {
-	char *page;
 	struct ccw1 *first, *last, *fail, *from, *to;
+	struct device *dev;
 	int len, sl, sct;
+	char *page;
+
+	dev = &device->cdev->dev;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
@@ -5632,24 +5630,18 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		return;
 	}
 	/* dump the sense data */
-	len = sprintf(page, PRINTK_HEADER
-		      " I/O status report for device %s:\n",
-		      dev_name(&device->cdev->dev));
-	len += sprintf(page + len, PRINTK_HEADER
-		       " in req: %p CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X "
-		       "CS:%02X RC:%d\n",
+	len = sprintf(page, "I/O status report:\n");
+	len += sprintf(page + len,
+		       "in req: %px CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X CS:%02X RC:%d\n",
 		       req, scsw_cc(&irb->scsw), scsw_fctl(&irb->scsw),
 		       scsw_actl(&irb->scsw), scsw_stctl(&irb->scsw),
 		       scsw_dstat(&irb->scsw), scsw_cstat(&irb->scsw),
 		       req ? req->intrc : 0);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing CCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len += sprintf(page + len, "Failing CCW: %px\n",
 		       phys_to_virt(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
-			len += sprintf(page + len, PRINTK_HEADER
-				       " Sense(hex) %2d-%2d:",
+			len += sprintf(page + len, "Sense(hex) %2d-%2d:",
 				       (8 * sl), ((8 * sl) + 7));
 
 			for (sct = 0; sct < 8; sct++) {
@@ -5661,23 +5653,20 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 
 		if (irb->ecw[27] & DASD_SENSE_BIT_0) {
 			/* 24 Byte Sense Data */
-			sprintf(page + len, PRINTK_HEADER
-				" 24 Byte: %x MSG %x, "
-				"%s MSGb to SYSOP\n",
+			sprintf(page + len,
+				"24 Byte: %x MSG %x, %s MSGb to SYSOP\n",
 				irb->ecw[7] >> 4, irb->ecw[7] & 0x0f,
 				irb->ecw[1] & 0x10 ? "" : "no");
 		} else {
 			/* 32 Byte Sense Data */
-			sprintf(page + len, PRINTK_HEADER
-				" 32 Byte: Format: %x "
-				"Exception class %x\n",
+			sprintf(page + len,
+				"32 Byte: Format: %x Exception class %x\n",
 				irb->ecw[6] & 0x0f, irb->ecw[22] >> 4);
 		}
 	} else {
-		sprintf(page + len, PRINTK_HEADER
-			" SORRY - NO VALID SENSE AVAILABLE\n");
+		sprintf(page + len, "SORRY - NO VALID SENSE AVAILABLE\n");
 	}
-	printk(KERN_ERR "%s", page);
+	dev_err(dev, "%s", page);
 
 	if (req) {
 		/* req == NULL for unsolicited interrupts */
@@ -5686,8 +5675,8 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		first = req->cpaddr;
 		for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 		to = min(first + 6, last);
-		printk(KERN_ERR PRINTK_HEADER " Related CP in req: %p\n", req);
-		dasd_eckd_dump_ccw_range(first, to, page);
+		dev_err(dev, "Related CP in req: %px\n", req);
+		dasd_eckd_dump_ccw_range(device, first, to, page);
 
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
@@ -5695,19 +5684,19 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		fail = phys_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
-			printk(KERN_ERR PRINTK_HEADER "......\n");
+			dev_err(dev, "......\n");
 		}
 		to = min(fail + 1, last);
-		dasd_eckd_dump_ccw_range(from, to, page + len);
+		dasd_eckd_dump_ccw_range(device, from, to, page + len);
 
 		/* print last CCWs (maximum 2) */
 		len = 0;
 		from = max(from, ++to);
 		if (from < last - 1) {
 			from = last - 1;     /* there is a gap - print header */
-			printk(KERN_ERR PRINTK_HEADER "......\n");
+			dev_err(dev, "......\n");
 		}
-		dasd_eckd_dump_ccw_range(from, last, page + len);
+		dasd_eckd_dump_ccw_range(device, from, last, page + len);
 	}
 	free_page((unsigned long) page);
 }
@@ -5731,11 +5720,9 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		return;
 	}
 	/* dump the sense data */
-	len = sprintf(page, PRINTK_HEADER
-		      " I/O status report for device %s:\n",
-		      dev_name(&device->cdev->dev));
-	len += sprintf(page + len, PRINTK_HEADER
-		       " in req: %p CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X "
+	len = sprintf(page, "I/O status report:\n");
+	len += sprintf(page + len,
+		       "in req: %px CC:%02X FC:%02X AC:%02X SC:%02X DS:%02X "
 		       "CS:%02X fcxs:%02X schxs:%02X RC:%d\n",
 		       req, scsw_cc(&irb->scsw), scsw_fctl(&irb->scsw),
 		       scsw_actl(&irb->scsw), scsw_stctl(&irb->scsw),
@@ -5743,9 +5730,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		       irb->scsw.tm.fcxs,
 		       (irb->scsw.tm.ifob << 7) | irb->scsw.tm.sesq,
 		       req ? req->intrc : 0);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing TCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len += sprintf(page + len, "Failing TCW: %px\n",
 		       phys_to_virt(irb->scsw.tm.tcw));
 
 	tsb = NULL;
@@ -5754,47 +5739,37 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 
 	if (tsb) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->length %d\n", tsb->length);
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->flags %x\n", tsb->flags);
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->dcw_offset %d\n", tsb->dcw_offset);
-		len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->count %d\n", tsb->count);
+		len += sprintf(page + len, "tsb->length %d\n", tsb->length);
+		len += sprintf(page + len, "tsb->flags %x\n", tsb->flags);
+		len += sprintf(page + len, "tsb->dcw_offset %d\n", tsb->dcw_offset);
+		len += sprintf(page + len, "tsb->count %d\n", tsb->count);
 		residual = tsb->count - 28;
-		len += sprintf(page + len, PRINTK_HEADER
-			       " residual %d\n", residual);
+		len += sprintf(page + len, "residual %d\n", residual);
 
 		switch (tsb->flags & 0x07) {
 		case 1:	/* tsa_iostat */
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.dev_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.dev_time %d\n",
 				       tsb->tsa.iostat.dev_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.def_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.def_time %d\n",
 				       tsb->tsa.iostat.def_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.queue_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.queue_time %d\n",
 				       tsb->tsa.iostat.queue_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.dev_busy_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.dev_busy_time %d\n",
 				       tsb->tsa.iostat.dev_busy_time);
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.iostat.dev_act_time %d\n",
+			len += sprintf(page + len, "tsb->tsa.iostat.dev_act_time %d\n",
 				       tsb->tsa.iostat.dev_act_time);
 			sense = tsb->tsa.iostat.sense;
 			break;
 		case 2: /* ts_ddpc */
-			len += sprintf(page + len, PRINTK_HEADER
-			       " tsb->tsa.ddpc.rc %d\n", tsb->tsa.ddpc.rc);
+			len += sprintf(page + len, "tsb->tsa.ddpc.rc %d\n",
+				       tsb->tsa.ddpc.rc);
 			for (sl = 0; sl < 2; sl++) {
-				len += sprintf(page + len, PRINTK_HEADER
-					       " tsb->tsa.ddpc.rcq %2d-%2d: ",
+				len += sprintf(page + len,
+					       "tsb->tsa.ddpc.rcq %2d-%2d: ",
 					       (8 * sl), ((8 * sl) + 7));
 				rcq = tsb->tsa.ddpc.rcq;
 				for (sct = 0; sct < 8; sct++) {
-					len += sprintf(page + len, " %02x",
+					len += sprintf(page + len, "%02x",
 						       rcq[8 * sl + sct]);
 				}
 				len += sprintf(page + len, "\n");
@@ -5802,15 +5777,15 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 			sense = tsb->tsa.ddpc.sense;
 			break;
 		case 3: /* tsa_intrg */
-			len += sprintf(page + len, PRINTK_HEADER
-				      " tsb->tsa.intrg.: not supported yet\n");
+			len += sprintf(page + len,
+				      "tsb->tsa.intrg.: not supported yet\n");
 			break;
 		}
 
 		if (sense) {
 			for (sl = 0; sl < 4; sl++) {
-				len += sprintf(page + len, PRINTK_HEADER
-					       " Sense(hex) %2d-%2d:",
+				len += sprintf(page + len,
+					       "Sense(hex) %2d-%2d:",
 					       (8 * sl), ((8 * sl) + 7));
 				for (sct = 0; sct < 8; sct++) {
 					len += sprintf(page + len, " %02x",
@@ -5821,27 +5796,23 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 
 			if (sense[27] & DASD_SENSE_BIT_0) {
 				/* 24 Byte Sense Data */
-				sprintf(page + len, PRINTK_HEADER
-					" 24 Byte: %x MSG %x, "
-					"%s MSGb to SYSOP\n",
+				sprintf(page + len,
+					"24 Byte: %x MSG %x, %s MSGb to SYSOP\n",
 					sense[7] >> 4, sense[7] & 0x0f,
 					sense[1] & 0x10 ? "" : "no");
 			} else {
 				/* 32 Byte Sense Data */
-				sprintf(page + len, PRINTK_HEADER
-					" 32 Byte: Format: %x "
-					"Exception class %x\n",
+				sprintf(page + len,
+					"32 Byte: Format: %x Exception class %x\n",
 					sense[6] & 0x0f, sense[22] >> 4);
 			}
 		} else {
-			sprintf(page + len, PRINTK_HEADER
-				" SORRY - NO VALID SENSE AVAILABLE\n");
+			sprintf(page + len, "SORRY - NO VALID SENSE AVAILABLE\n");
 		}
 	} else {
-		sprintf(page + len, PRINTK_HEADER
-			" SORRY - NO TSB DATA AVAILABLE\n");
+		sprintf(page + len, "SORRY - NO TSB DATA AVAILABLE\n");
 	}
-	printk(KERN_ERR "%s", page);
+	dev_err(&device->cdev->dev, "%s", page);
 	free_page((unsigned long) page);
 }
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index c06fa2b271205..045e548630dfb 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -25,11 +25,6 @@
 #include "dasd_int.h"
 #include "dasd_fba.h"
 
-#ifdef PRINTK_HEADER
-#undef PRINTK_HEADER
-#endif				/* PRINTK_HEADER */
-#define PRINTK_HEADER "dasd(fba):"
-
 #define FBA_DEFAULT_RETRIES 32
 
 #define DASD_FBA_CCW_WRITE 0x41
@@ -660,30 +655,27 @@ static void
 dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		    struct irb *irb)
 {
-	char *page;
 	struct ccw1 *act, *end, *last;
 	int len, sl, sct, count;
+	struct device *dev;
+	char *page;
+
+	dev = &device->cdev->dev;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (page == NULL) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
-			    "No memory to dump sense data");
+			      "No memory to dump sense data");
 		return;
 	}
-	len = sprintf(page, PRINTK_HEADER
-		      " I/O status report for device %s:\n",
-		      dev_name(&device->cdev->dev));
-	len += sprintf(page + len, PRINTK_HEADER
-		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing CCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len = sprintf(page, "I/O status report:\n");
+	len += sprintf(page + len, "in req: %px CS: 0x%02X DS: 0x%02X\n",
+		       req, irb->scsw.cmd.cstat, irb->scsw.cmd.dstat);
+	len += sprintf(page + len, "Failing CCW: %px\n",
 		       (void *) (addr_t) irb->scsw.cmd.cpa);
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
-			len += sprintf(page + len, PRINTK_HEADER
-				       " Sense(hex) %2d-%2d:",
+			len += sprintf(page + len, "Sense(hex) %2d-%2d:",
 				       (8 * sl), ((8 * sl) + 7));
 
 			for (sct = 0; sct < 8; sct++) {
@@ -693,20 +685,18 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 			len += sprintf(page + len, "\n");
 		}
 	} else {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " SORRY - NO VALID SENSE AVAILABLE\n");
+		len += sprintf(page + len, "SORRY - NO VALID SENSE AVAILABLE\n");
 	}
-	printk(KERN_ERR "%s", page);
+	dev_err(dev, "%s", page);
 
 	/* dump the Channel Program */
 	/* print first CCWs (maximum 8) */
 	act = req->cpaddr;
-        for (last = act; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
+	for (last = act; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 	end = min(act + 8, last);
-	len = sprintf(page, PRINTK_HEADER " Related CP in req: %p\n", req);
+	len = sprintf(page, "Related CP in req: %px\n", req);
 	while (act <= end) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
@@ -716,19 +706,17 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		len += sprintf(page + len, "\n");
 		act++;
 	}
-	printk(KERN_ERR "%s", page);
-
+	dev_err(dev, "%s", page);
 
 	/* print failing CCW area */
 	len = 0;
 	if (act <  ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2) {
 		act = ((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa) - 2;
-		len += sprintf(page + len, PRINTK_HEADER "......\n");
+		len += sprintf(page + len, "......\n");
 	}
 	end = min((struct ccw1 *)(addr_t) irb->scsw.cmd.cpa + 2, last);
 	while (act <= end) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
@@ -742,11 +730,10 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 	/* print last CCWs */
 	if (act <  last - 2) {
 		act = last - 2;
-		len += sprintf(page + len, PRINTK_HEADER "......\n");
+		len += sprintf(page + len, "......\n");
 	}
 	while (act <= last) {
-		len += sprintf(page + len, PRINTK_HEADER
-			       " CCW %p: %08X %08X DAT:",
+		len += sprintf(page + len, "CCW %px: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
 		     count += sizeof(int))
@@ -757,7 +744,7 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 		act++;
 	}
 	if (len > 0)
-		printk(KERN_ERR "%s", page);
+		dev_err(dev, "%s", page);
 	free_page((unsigned long) page);
 }
 
-- 
2.53.0

