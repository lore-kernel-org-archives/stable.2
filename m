Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43E531612
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693210; cv=none; b=QuFUH1D7g0ONhFNBeRarwXEBJeI4niHfpNxfd4j+csW2iy04GAnBf8DKa2QXBDwkZj/pJcWBAfdbZYZhcYU2t9Bqo8IQQfiGqCwbQJBraBc5LkXP2iKppkzWZ9dRRpg6JO3HwiyyG4cSv3FTmaZ7ox3E1A8fnQaleLdOW/20hNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693210; c=relaxed/simple;
	bh=b20H6OMD/mJhvs+PtOypDKp/Uq3Cp4/GFdIS+uB909c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CKxFoNfL0sfJdmll2idaLh28duowzeq2kym27+IxhvPT2D1me7sGmKdWFupT+yvu9D8fVh9pFRkR36pAuj+2awmnE9e+sqH2JWX8QklaTgbGZx0SQkdx+th9sOAdxqL9Cw7tmQs//gC5Oq46xakbztIUpHProi5NcwZqJb02DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TImB6qVz; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TImB6qVz"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-868cfc5c244so1397222b3a.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790693206; x=1791298006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4b5KTvylDtW2+5uJtb7CKuwRyrC+2b0oF+GIiDXxI/0=;
        b=TImB6qVzwysU7aUMstLbioWxs/i9cCjvXdPOA2gG6dahE7EPKrTt/8MUnlwf/OzzFT
         2+P0o5JBVcVMvdirsZ3qom76jvovH2kMv4SQNZvqzVW/f4cykGyfgBR50maNQw609G3e
         m0a7EMBJtYhCT8vFKTl6faMdkFotcGSuwQIQtHnRAfzNF1cSdJ2Dy6MVq2YVpsqMG2pq
         PMoM81bGyOgribcSTALQVg9flEFNX2BzsPFruzxpIepK1bBQ8/FNwkPBqIAtMo9k85Xz
         UFohlkwNFw40QWda/Go0z8Rosbxn1ldWO39mYk6coLM62tRcJRBZ1vto8rleZ4JQ2P2x
         uOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790693206; x=1791298006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4b5KTvylDtW2+5uJtb7CKuwRyrC+2b0oF+GIiDXxI/0=;
        b=Ix1VmzOatTqCYWCXLc9d5avzeHI86xZ6D16S3ogOQ+7PvkxF7+bMxHODiLeZuNCluY
         lXcNnsSQFUrLCIyfZOzTk9gLusPZgu3fSnhxCL1xdC7j8sU8BrTwDH6/dEobPIlkw9NI
         sOg2KHe++U3wRFxqj3pJTbwTw6d5H31rR9plTmaVJQ8dutRWKplnps/Hk2Eq6vsPanG6
         55TNT3kVXJdetZidNM2xc93sevauwimgDWxQ9UbdpR743LXK9FZQkIGautdhILqrtHtm
         Hvvcm8LvxTRXvlSVVWnLPTzDyob2mtQNWIRUAQ0inuejAeBQQDE0Sg5dqAEfM5gssSNW
         xPCA==
X-Forwarded-Encrypted: i=1; AKwUvBzFlqJFMwYtrnWrTifpT2gACh+UponRCQWtrdcAy/iHSWs9IWBk42km6z4I+fU238v3eItfnns=@vger.kernel.org
X-Gm-Message-State: AFuF++lc5L6jZ0ugqrQY1ddGLRy+EPcTYJE2czEisXP6SpXsXmRpXy6a
	W/6i49yeN16KbyMJGXb8FFcR+HZmLGK913zcSiTTpTx9XkGEErEoSIB0WdFOnqYaqnA=
X-Gm-Gg: AYBFou3CaHLF0hyGMQfj/+U9/qN1ddzpcsUyLLIFTHq4ejv7fZkOZFQx05uuEwOrqJv
	MuXf1Tamy6GjTfSU9t4BLhtmCWO1Eg1f8201OwWrCZBtfaSjbw5cdu9567D2Pv0VsI1igi0HHs4
	ztq2m136st0tOWv6kKC+1kZ7lo/P18GoG/xYV3O0ggL325De/KmLVAQ+TVvKgs5m5A34iODfOj2
	1oyhvQqJfDSchOj9N2u5julGaBXeFBLGRE9cMl3ovL70MCDNgQmJ06OSvBhVz/LWTYJaEvw8kf+
	+vFSdo1nFolS5LehuFUrpzeKqWBlwX8YHoQKwfxBvtidHfraK8PwzycDql5ZkK1OggC34Wfkaw6
	HGYkpKFlzPVgrC7v5CE/LzayFpZ4BRFKwJSndnFiz0CxUpK5VoA+s6cnawB9f68ihh+ASdBgXK+
	kLJpWlLqLsfF9T12fHxpDSqz93NsGTsVH1OoEEfNK7FbsNXMO4QiV636IrYl7d6v5zapBHzLHIr
	voN1X+pXt/8ASzIaE1MbyS/v5LyAsDNlg==
X-Received: by 2002:a05:6a21:6089:b0:3dd:ff70:1426 with SMTP id adf61e73a8af0-3de0e725d1emr15101045637.3.1790693206167;
        Tue, 29 Sep 2026 07:46:46 -0700 (PDT)
Received: from localhost.localdomain ([216.236.36.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7c5afb5c9sm1282397a12.3.2026.09.29.07.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:46:45 -0700 (PDT)
From: xy521521@gmail.com
To: stern@rowland.harvard.edu
Cc: Hongyu Xie <xiehongyu1@kylinos.cn>,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb-storage: ene_ub6250: don't let the card-type probe hang forever
Date: Tue, 29 Sep 2026 22:46:40 +0800
Message-Id: <20260929144640.2028-1-xy521521@gmail.com>
X-Mailer: git-send-email 2.32.0
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
 drivers/usb/storage/ene_ub6250.c | 55 ++++++++++++++++++++++++--------
 drivers/usb/storage/transport.c  | 31 ++++++++++++++----
 drivers/usb/storage/transport.h  |  3 ++
 3 files changed, 69 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index 895f90c7a3fa..109336bd7e30 100644
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
+static int ene_send_scsi_cmd_timeout(struct us_data *us, u8 fDir, void *buf,
+				     int use_sg, int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	struct bulk_cs_wrap *bcs = (struct bulk_cs_wrap *) us->iobuf;
@@ -499,8 +507,9 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 
 	/* usb_stor_dbg(us, "transport --- ene_send_scsi_cmd\n"); */
 	/* send cmd to out endpoint */
-	result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
-					    bcb, US_BULK_CB_WRAP_LEN, NULL);
+	result = usb_stor_bulk_transfer_buf_timeout(us, us->send_bulk_pipe,
+					    bcb, US_BULK_CB_WRAP_LEN, NULL,
+					    timeout);
 	if (result != USB_STOR_XFER_GOOD) {
 		usb_stor_dbg(us, "send cmd to out endpoint fail ---\n");
 		return USB_STOR_TRANSPORT_ERROR;
@@ -517,6 +526,10 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 		/* Bulk */
 		if (use_sg) {
 			result = usb_stor_bulk_srb(us, pipe, us->srb);
+		} else if (timeout) {
+			result = usb_stor_bulk_transfer_buf_timeout(us, pipe,
+					buf, transfer_length, &partial,
+					timeout);
 		} else {
 			result = usb_stor_bulk_transfer_sg(us, pipe, buf,
 						transfer_length, 0, &partial);
@@ -528,20 +541,25 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 	}
 
 	/* Get CSW for device status */
-	result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe, bcs,
-					    US_BULK_CS_WRAP_LEN, &cswlen);
+	result = usb_stor_bulk_transfer_buf_timeout(us, us->recv_bulk_pipe,
+					    bcs, US_BULK_CS_WRAP_LEN, &cswlen,
+					    timeout);
 
 	if (result == USB_STOR_XFER_SHORT && cswlen == 0) {
 		usb_stor_dbg(us, "Received 0-length CSW; retrying...\n");
-		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-					    bcs, US_BULK_CS_WRAP_LEN, &cswlen);
+		result = usb_stor_bulk_transfer_buf_timeout(us,
+					    us->recv_bulk_pipe, bcs,
+					    US_BULK_CS_WRAP_LEN, &cswlen,
+					    timeout);
 	}
 
 	if (result == USB_STOR_XFER_STALLED) {
 		/* get the status again */
 		usb_stor_dbg(us, "Attempting to get CSW (2nd try)...\n");
-		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-						bcs, US_BULK_CS_WRAP_LEN, NULL);
+		result = usb_stor_bulk_transfer_buf_timeout(us,
+						us->recv_bulk_pipe, bcs,
+						US_BULK_CS_WRAP_LEN, NULL,
+						timeout);
 	}
 
 	if (result != USB_STOR_XFER_GOOD)
@@ -567,6 +585,15 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 	return USB_STOR_TRANSPORT_GOOD;
 }
 
+/*
+ * Unbounded variant for command-path callers: the command's abort
+ * machinery terminates usb_stor_msg_common()'s wait if the device dies.
+ */
+static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
+{
+	return ene_send_scsi_cmd_timeout(us, fDir, buf, use_sg, 0);
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
index 9a4bf86e7b6a..c586d2021b7e 100644
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
+		void *buf, unsigned int length, unsigned int *act_len,
+		int timeout)
 {
 	int result;
 
@@ -392,14 +398,25 @@ int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
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
+		void *buf, unsigned int length, unsigned int *act_len)
+{
+	return usb_stor_bulk_transfer_buf_timeout(us, pipe, buf, length,
+			act_len, 0);
+}
 EXPORT_SYMBOL_GPL(usb_stor_bulk_transfer_buf);
 
 /*
diff --git a/drivers/usb/storage/transport.h b/drivers/usb/storage/transport.h
index 74ffd0d7e7b6..dc0442efc24d 100644
--- a/drivers/usb/storage/transport.h
+++ b/drivers/usb/storage/transport.h
@@ -77,6 +77,9 @@ extern int usb_stor_clear_halt(struct us_data *us, unsigned int pipe);
 extern int usb_stor_ctrl_transfer(struct us_data *us, unsigned int pipe,
 		u8 request, u8 requesttype, u16 value, u16 index,
 		void *data, u16 size);
+extern int usb_stor_bulk_transfer_buf_timeout(struct us_data *us,
+		unsigned int pipe, void *buf, unsigned int length,
+		unsigned int *act_len, int timeout);
 extern int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
 		void *buf, unsigned int length, unsigned int *act_len);
 extern int usb_stor_bulk_transfer_sg(struct us_data *us, unsigned int pipe,
-- 
2.32.0

