Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33CC3FC5A5
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846138; cv=none; b=t9brEFSc8OFhZQBFigTVE8beMKZHxmEsIedLGBtw+6efSm+Zn2+EP27Z/yhoXvmObS1+UKsS/Hg29zUz1V8EjjOy8PoGxAdsWh4y7xLBatVFJM9fPRD6uylUOzVaHREiUWpgbiQJnm3sy4hpoEpAh15+lmbrAFMDQyfU7XCjRnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846138; c=relaxed/simple;
	bh=UQDkByNNC0KqSmVdnRRjC6l/UisWwlJtg7tDG1mnCS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pk6Wf9MZYbHQcDxtBvqjhVeJtV5+IHRwB7wSw66liIaHrrOEINTebEDp/+9NteZqUIq6ttAnrYjnfdOIVfMywk41BvO7k55PNSMQOVuVYLxQ5E+5tyw0LStrPcv25HSk3VkrXtgu97SJYHzCjr5S8R/7X7kKeAfStmbFxe9ZLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIIxnIDJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIIxnIDJ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so1918525a91.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790846132; x=1791450932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfonLXrH2MEaXVdolAoD3jNct3GqjVUeXnc0utQ1W1I=;
        b=ZIIxnIDJZlCOmxqrHJDJLxKu89WnR+JzpKitmnu9iaAifTDtzKiNSZeBswc5KEiGbu
         o1t6rHL4QKv/eWWZpY9FpWesWkaHPyQM06l5KCOp1NW0cbxMtya3jZPpfvz612IKy0ba
         eXmNU3mS1FZDeuAu90UNw7q5sy+fwfZsoAOjLzhTauWCwzMfMV9sla9Q9sPLiVw8EZCq
         bzKz/OAO17Ii6gXgZNBluKmgzx8VeACBFqlJX51s2JPO7Kxo16dPEiKatwf1lzcyFdsw
         Q7OkhyVmUutUih8yBTsCvl3tJ1W+N8tmv33MF0pVoVT1QxAmu7oxfxSanoa0BNqZdmHs
         94Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846132; x=1791450932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfonLXrH2MEaXVdolAoD3jNct3GqjVUeXnc0utQ1W1I=;
        b=LDzzJE5XH3K2opgaDkFyohE8YytdvDTwvzo3DL7kEKDALHFhKrTJVmWT7DMvXuQGqz
         EgdC7ul5hWcAqrZWzrpYb4dwn5ZjlP6L6rW916W5c8ih/gzM/JhDHX412jPp8yf/aW89
         v4gOh9ZTEfSZbOblNeISZQLkskh0dEZLl/31PTDP1O1ZFsFGlW2BnQEDrYQ6tBU5vQiF
         r71Jg2cXcjrd8CoMZgrVaZehNDIsYR9dXi5pj6aW0368D52iIaEg1Rvcd4yQ6wiC85r5
         jNjA9BR6bm3vftFevPLd6pPrnTOHRi5dpmMlG7beGIJ+r7EKlx7ojQNtWfEo7gI8ZX+s
         mTIA==
X-Forwarded-Encrypted: i=1; AKwUvBz5XM4EM2YBL3YvmK/khBMJkOmXeBfM+SLDSQo7vYYa9gS04ZnO1wso/YdGTsuXVQs0U6Fyq94=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY8x4zTISqYdctSSIwHGcKPzaG0JPCv3O6gb9g0nP6lKFaxEsQ
	MT35+IBG3ayvSPzc8gO+72L6r7VTaeQ86JQ8QcQL5Z8z75EfARqXrUOY
X-Gm-Gg: AYBFou0ZcOez2xGgStpfJc5O/nF1NpAmMq0AuOc5QL3CqrS5BUn39REdQtry9ZRIapW
	jsMYT6xcy3GT87c9TU1PuoGwkotETrUYOuDvLSdjfGTm5Uu0IdAGtSsBBjeZXJEgJaL5KBP06cE
	cue7sdWULtfBUXuiZxhRpUJNDdldS0+a3p6CUIrTwR/xrXoU8EJnw+KSHjOeo0Bc6kS5jBKjdrU
	WDwQ8zZiOxU8nHQGFi463tTn8i38rhBu1k1E5kmuUddJG9fLPPDIsMhSkHDujB3nMV7Fy+vHFOl
	0/W0I9CEOnZmP4eBWeKC77UOH7OZajo2jdTZakeC9TUtqM5dyrQgusLBUtnGeCh9oBy+O/7lDtX
	erGePF5FmpIo98TXJCcoPe85KLweUW4+DWp9ITR1l4vWLR2vovHp7SFFyUMfLz8U0gApe2HzqBq
	hsLHzRRStMFvCkAWnAyui9iMKSijl10ZOTs+Wn86MyiPRjT1mSd/KXLaAyEvzDU/KDH7ajmRUHF
	Vd3pXwgLyZeiAmYA68bPjctrn2fG3+p
X-Received: by 2002:a17:90b:3d89:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3a4f2afaec5mr1214170a91.7.1790846131520;
        Thu, 01 Oct 2026 02:15:31 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f47cbd1dsm3721626a91.16.2026.10.01.02.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:15:31 -0700 (PDT)
From: xy521521@gmail.com
To: stern@rowland.harvard.edu
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] usb-storage: ene_ub6250: don't let the card-type probe hang forever
Date: Thu,  1 Oct 2026 17:15:23 +0800
Message-Id: <20261001091523.16934-1-xy521521@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260929144640.2028-1-xy521521@gmail.com>
References: <20260929144640.2028-1-xy521521@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Xie <xiehongyu1@kylinos.cn>

ene_ub6250_probe() queries the card type with ene_get_card_type() while
holding us->dev_mutex (the locking added by commit 445fc368c6bc
("usb-storage: ene_ub6250: fix race between scan work and probe")).
The query is a bulk-only transaction: CBW, 1-byte data-in and CSW, each
transferred by usb_stor_bulk_transfer_buf(), which waits for URB
completion with MAX_SCHEDULE_TIMEOUT.

That unbounded wait is safe only while a SCSI command is being handled,
because the command's abort machinery (usb_stor_stop_transport() via
US_FLIDX_ABORTING) is the only thing that can terminate it.  At probe
time no SCSI command exists, so a device that passes enumeration but
never services bulk transfers wedges the probe forever:

    hub_event:         usb_stor_msg_common() <- ene_send_scsi_cmd
                       <- ene_ub6250_probe  (holds us->dev_mutex)
    events_freezable:  usb_stor_scan_dwork  (blocked on us->dev_mutex)

syzbot reports the second worker as "INFO: task hung in
usb_stor_scan_dwork"; the hub_event worker is stuck in the same wait
but sleeps interruptibly, which the hung-task detector ignores.

Bound the three probe-time transfers with a 30 s timeout through a new
usb_stor_bulk_transfer_buf_timeout() helper, so a dead device fails the
probe cleanly and the existing error path unwinds via
usb_stor_disconnect().

Fixes: 445fc368c6bc ("usb-storage: ene_ub6250: fix race between scan work and probe")
Reported-by: syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30552b4cbe99d6d91306
Cc: stable@vger.kernel.org
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

Changes in v2 (formatting only, no functional change):
- fix checkpatch --strict "alignment should match open parenthesis"
  complaints on the newly added continuation lines
- rename the fDir parameter of ene_send_scsi_cmd[_timeout]() to fdir
  to silence the CamelCase check
 drivers/usb/storage/ene_ub6250.c | 59 ++++++++++++++++++++++++--------
 drivers/usb/storage/transport.c  | 32 +++++++++++++----
 drivers/usb/storage/transport.h  |  5 +++
 3 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 895f90c7a3fa..276764a66774 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -24,6 +24,13 @@
 
 #define DRV_NAME "ums_eneub6250"
 
+/*
+ * Bound for the probe-time card-type query.  It runs under us->dev_mutex
+ * with no SCSI command in flight, so nothing else would terminate the
+ * bulk transfer wait if the device stopped responding.
+ */
+#define ENE_PROBE_TIMEOUT (30 * HZ)
+
 MODULE_DESCRIPTION("Driver for ENE UB6250 reader");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("USB_STORAGE");
@@ -487,7 +494,8 @@ static void ene_ub6250_info_destructor(void *extra)
 	kfree(info->bbuf);
 }
 
-static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
+static int ene_send_scsi_cmd_timeout(struct us_data *us, u8 fdir, void *buf,
+				     int use_sg, int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	struct bulk_cs_wrap *bcs = (struct bulk_cs_wrap *) us->iobuf;
@@ -499,17 +507,18 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 
 	/* usb_stor_dbg(us, "transport --- ene_send_scsi_cmd\n"); */
 	/* send cmd to out endpoint */
-	result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
-					    bcb, US_BULK_CB_WRAP_LEN, NULL);
+	result = usb_stor_bulk_transfer_buf_timeout(us, us->send_bulk_pipe,
+						    bcb, US_BULK_CB_WRAP_LEN,
+						    NULL, timeout);
 	if (result != USB_STOR_XFER_GOOD) {
 		usb_stor_dbg(us, "send cmd to out endpoint fail ---\n");
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
 	if (buf) {
-		unsigned int pipe = fDir;
+		unsigned int pipe = fdir;
 
-		if (fDir  == FDIR_READ)
+		if (fdir == FDIR_READ)
 			pipe = us->recv_bulk_pipe;
 		else
 			pipe = us->send_bulk_pipe;
@@ -517,6 +526,10 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 		/* Bulk */
 		if (use_sg) {
 			result = usb_stor_bulk_srb(us, pipe, us->srb);
+		} else if (timeout) {
+			result = usb_stor_bulk_transfer_buf_timeout(us, pipe,
+								    buf, transfer_length, &partial,
+								    timeout);
 		} else {
 			result = usb_stor_bulk_transfer_sg(us, pipe, buf,
 						transfer_length, 0, &partial);
@@ -528,20 +541,25 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 	}
 
 	/* Get CSW for device status */
-	result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe, bcs,
-					    US_BULK_CS_WRAP_LEN, &cswlen);
+	result = usb_stor_bulk_transfer_buf_timeout(us, us->recv_bulk_pipe,
+						    bcs, US_BULK_CS_WRAP_LEN,
+						    &cswlen, timeout);
 
 	if (result == USB_STOR_XFER_SHORT && cswlen == 0) {
 		usb_stor_dbg(us, "Received 0-length CSW; retrying...\n");
-		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-					    bcs, US_BULK_CS_WRAP_LEN, &cswlen);
+		result = usb_stor_bulk_transfer_buf_timeout(us,
+							    us->recv_bulk_pipe, bcs,
+							    US_BULK_CS_WRAP_LEN, &cswlen,
+							    timeout);
 	}
 
 	if (result == USB_STOR_XFER_STALLED) {
 		/* get the status again */
 		usb_stor_dbg(us, "Attempting to get CSW (2nd try)...\n");
-		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-						bcs, US_BULK_CS_WRAP_LEN, NULL);
+		result = usb_stor_bulk_transfer_buf_timeout(us,
+							    us->recv_bulk_pipe, bcs,
+							    US_BULK_CS_WRAP_LEN, NULL,
+							    timeout);
 	}
 
 	if (result != USB_STOR_XFER_GOOD)
@@ -567,6 +585,15 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 	return USB_STOR_TRANSPORT_GOOD;
 }
 
+/*
+ * Unbounded variant for command-path callers: the command's abort
+ * machinery terminates usb_stor_msg_common()'s wait if the device dies.
+ */
+static int ene_send_scsi_cmd(struct us_data *us, u8 fdir, void *buf, int use_sg)
+{
+	return ene_send_scsi_cmd_timeout(us, fdir, buf, use_sg, 0);
+}
+
 static int do_scsi_request_sense(struct us_data *us, struct scsi_cmnd *srb)
 {
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
@@ -1826,7 +1853,8 @@ static int ms_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
  * ENE MS Card
  */
 
-static int ene_get_card_type(struct us_data *us, u16 index, void *buf)
+static int ene_get_card_type(struct us_data *us, u16 index, void *buf,
+			     int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	int result;
@@ -1839,7 +1867,7 @@ static int ene_get_card_type(struct us_data *us, u16 index, void *buf)
 	bcb->CDB[2]			= (unsigned char)(index>>8);
 	bcb->CDB[3]			= (unsigned char)index;
 
-	result = ene_send_scsi_cmd(us, FDIR_READ, buf, 0);
+	result = ene_send_scsi_cmd_timeout(us, FDIR_READ, buf, 0, timeout);
 	return result;
 }
 
@@ -2193,7 +2221,7 @@ static int ene_init(struct us_data *us)
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 	u8 *bbuf = info->bbuf;
 
-	result = ene_get_card_type(us, REG_CARD_STATUS, bbuf);
+	result = ene_get_card_type(us, REG_CARD_STATUS, bbuf, 0);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
 
@@ -2358,7 +2386,8 @@ static int ene_ub6250_probe(struct usb_interface *intf,
 
 	/* probe card type */
 	mutex_lock(&us->dev_mutex);
-	result = ene_get_card_type(us, REG_CARD_STATUS, info->bbuf);
+	result = ene_get_card_type(us, REG_CARD_STATUS, info->bbuf,
+				   ENE_PROBE_TIMEOUT);
 	mutex_unlock(&us->dev_mutex);
 	if (result != USB_STOR_XFER_GOOD) {
 		usb_stor_disconnect(intf);
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 9a4bf86e7b6a..89619010d665 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -378,12 +378,18 @@ static int usb_stor_intr_transfer(struct us_data *us, void *buf,
 }
 
 /*
- * Transfer one buffer via bulk pipe, without timeouts, but allowing early
- * termination.  Return codes are USB_STOR_XFER_xxx.  If the bulk pipe
- * stalls during the transfer, the halt is automatically cleared.
+ * Transfer one buffer via bulk pipe, allowing early termination.  Return
+ * codes are USB_STOR_XFER_xxx.  If the bulk pipe stalls during the
+ * transfer, the halt is automatically cleared.
+ *
+ * A nonzero timeout bounds the wait for URB completion.  It must be used
+ * only when no SCSI command is being handled: usb_stor_msg_common()
+ * otherwise waits indefinitely, relying on the active command's abort
+ * machinery to terminate the wait.
  */
-int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
-	void *buf, unsigned int length, unsigned int *act_len)
+int usb_stor_bulk_transfer_buf_timeout(struct us_data *us, unsigned int pipe,
+				       void *buf, unsigned int length,
+				       unsigned int *act_len, int timeout)
 {
 	int result;
 
@@ -392,14 +398,26 @@ int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
 	/* fill and submit the URB */
 	usb_fill_bulk_urb(us->current_urb, us->pusb_dev, pipe, buf, length,
 		      usb_stor_blocking_completion, NULL);
-	result = usb_stor_msg_common(us, 0);
+	result = usb_stor_msg_common(us, timeout);
 
 	/* store the actual length of the data transferred */
 	if (act_len)
 		*act_len = us->current_urb->actual_length;
-	return interpret_urb_result(us, pipe, length, result, 
+	return interpret_urb_result(us, pipe, length, result,
 			us->current_urb->actual_length);
 }
+EXPORT_SYMBOL_GPL(usb_stor_bulk_transfer_buf_timeout);
+
+/*
+ * Same as usb_stor_bulk_transfer_buf_timeout() with an unbounded wait.
+ */
+int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
+			       void *buf, unsigned int length,
+			       unsigned int *act_len)
+{
+	return usb_stor_bulk_transfer_buf_timeout(us, pipe, buf, length,
+						  act_len, 0);
+}
 EXPORT_SYMBOL_GPL(usb_stor_bulk_transfer_buf);
 
 /*
diff --git a/drivers/usb/storage/transport.h b/drivers/usb/storage/transport.h
index 74ffd0d7e7b6..361dbd77f15e 100644
--- a/drivers/usb/storage/transport.h
+++ b/drivers/usb/storage/transport.h
@@ -77,6 +77,11 @@ extern int usb_stor_clear_halt(struct us_data *us, unsigned int pipe);
 extern int usb_stor_ctrl_transfer(struct us_data *us, unsigned int pipe,
 		u8 request, u8 requesttype, u16 value, u16 index,
 		void *data, u16 size);
+extern int usb_stor_bulk_transfer_buf_timeout(struct us_data *us,
+					      unsigned int pipe, void *buf,
+					      unsigned int length,
+					      unsigned int *act_len,
+					      int timeout);
 extern int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
 		void *buf, unsigned int length, unsigned int *act_len);
 extern int usb_stor_bulk_transfer_sg(struct us_data *us, unsigned int pipe,
-- 
2.32.0

