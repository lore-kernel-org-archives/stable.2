Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630389;
	b=tgjLQDq9GsWReodq6ELkNP2BFPkSVScWmjcBjVxk66aV7RNbALYmB307wtDu3M2hmc+s
	 dDGpr8PN3XuAUu4obyvxIUuEEt+JlduBOh8iPzcNUY619jjnGA0LNrIHZ9Gt59T5gy4ZW
	 GMrLy5dvRWUDF10S6AcdGDRsx3GOVqHnUKedIorJjvhi/3rPjG6z8mAva6DoRyr5m/t4y
	 oRkpExWBM03ew2/2+y4WHaeADZiXJKtSm8zr7v2pns7DM0Bs1MOAamDUM+nWd1mEI3Nou
	 0h/WAIDn/mv9PTY+xtAakyNzsFFkrN2jCiesRzUMpeD4IfbzC+Z7qGl+kGMFwxH6utw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bVeQ+CLDB6WMQB37T5tbgvmToIUjC1/6HNjWwIHF1hE=;
	b=mRqnW2xWlNfrlhdTGAUe6X7PDJPyo0h/yktZl7JQaMW5oFiZhns/R9XW6CtF8FMr40Ss
	 qLfOwBk/2XIqppuaPdONRcJYPgiePxQrw2QDLalHllZzzlk5FrEXU13OgUg7WKeTRIVbw
	 4sVaZgfGtpNEsxwyVFKkDYNasQzBsT/UPVlRRIKeosP1XQtaRubIOFR9Jy+er70AwBJly
	 MeTr545v1L3GE0oebDnr00U7jHZX+ZsDKH95V2MWXb0vFz3dKdMX+H+0SCu9N4AXOAWBg
	 jUgQ+VhgAHJn7Hqf+V9xkolKfGdAGFazH1r/ikGbyVNt9ut05OBQOqbXUWnDA9tTyFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxeuMTG8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75292606A68E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxeuMTG8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6118E1F000E1;
	Wed, 25 Nov 2026 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630389;
	bh=bVeQ+CLDB6WMQB37T5tbgvmToIUjC1/6HNjWwIHF1hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LxeuMTG83wlleCCj0tA++y+sY4gyFqvTTkMu2B2/QbJRnl8GeEtdtu2qPQoxyHauw
	 lfBgmux1l9GhvOJRLyr3GrLZCagPdZBU6BwCruJk33fawBTFEPyvTY1HVFCm4M3VDR
	 4ftZcRhN2UcXmbanHHL6TtjfpGFBLDIiw1NS+nlhlQxJWfSyAj+26o0faqPekPzpVk
	 +fE1+f5n6M3w1jWaDylSeQMZsacv+OBnC8VRrrJJ7buiBjaUT/OVR/ik+SGHg9X+qU
	 TpKOapW2HvY2DXZM8AhpmH7JFvaCIuRwv60W/Iz8I0zebpfHLdhebRRQnxcBNKVR8i
	 jTdTQSu66oAWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/7] s390/dasd: Use dev_err() over printk()
Date: Wed, 25 Nov 2026 13:12:59 -0500
Message-ID: <20261125181227.1137399-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125181227.1137399-1-sashal@kernel.org>
References: <2026112516-snowbound-attentive-b141@gregkh>
 <20261125181227.1137399-1-sashal@kernel.org>
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
index 7e694ecca767a..e062d779be2b2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -37,11 +37,6 @@
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
@@ -5542,15 +5537,15 @@ dasd_eckd_ioctl(struct dasd_block *block, unsigned int cmd, void __user *argp)
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
@@ -5573,7 +5568,7 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 		from++;
 	}
 	if (len > 0)
-		printk(KERN_ERR "%s", page);
+		dev_err(&device->cdev->dev, "%s", page);
 }
 
 static void
@@ -5604,9 +5599,12 @@ dasd_eckd_dump_sense_dbf(struct dasd_device *device, struct irb *irb,
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
@@ -5615,24 +5613,18 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
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
@@ -5644,23 +5636,20 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 
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
@@ -5669,8 +5658,8 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		first = req->cpaddr;
 		for (last = first; last->flags & (CCW_FLAG_CC | CCW_FLAG_DC); last++);
 		to = min(first + 6, last);
-		printk(KERN_ERR PRINTK_HEADER " Related CP in req: %p\n", req);
-		dasd_eckd_dump_ccw_range(first, to, page);
+		dev_err(dev, "Related CP in req: %px\n", req);
+		dasd_eckd_dump_ccw_range(device, first, to, page);
 
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
@@ -5678,19 +5667,19 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
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
@@ -5714,11 +5703,9 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
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
@@ -5726,9 +5713,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		       irb->scsw.tm.fcxs,
 		       (irb->scsw.tm.ifob << 7) | irb->scsw.tm.sesq,
 		       req ? req->intrc : 0);
-	len += sprintf(page + len, PRINTK_HEADER
-		       " device %s: Failing TCW: %p\n",
-		       dev_name(&device->cdev->dev),
+	len += sprintf(page + len, "Failing TCW: %px\n",
 		       phys_to_virt(irb->scsw.tm.tcw));
 
 	tsb = NULL;
@@ -5737,47 +5722,37 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
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
@@ -5785,15 +5760,15 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
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
@@ -5804,27 +5779,23 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 
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
index 7b53244c56b32..e60c895f3293a 100644
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

