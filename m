Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555419;
	b=gAyljSxgH96qFyAsthTYz4B1ccoR4DpW0q2AI/QpvxeibTzf5GQsyknZxXQlrqtUCRCj
	 12IP/omTgGrX/6/NXqJsHtqdQbsAidvu4Tpg6UXSG3Y6HsLtEZFIl4VYjKjxW7h182frF
	 64yBQSRkaD2aTU4PiOBVLxTmts8TeTILADSCCWRZm2YNezfEQOdIM0yh7iOYZ8zQhYJEV
	 E7N4c7TyYOHW061TnNYmrxnuwq5tXVpjYaO95lDiSELCEhgAQ7CCTwO10DlcCKZ+U32S3
	 w2wIBheFeVsV8XCviavrAT33U3Yffden7Yc5HESV3ZADm4Z8Hg4z9wGDnTBMZE5aBtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555419;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NQZFryO10Nwl24stNk7sjkQ3d9LySI0OptJ1tpt1TVE=;
	b=T2sPejKUXVohwgW6GWILpbHKCIHwFp4TYiJ4MqJyINB4q6HwMp0GvQUT7jVl5AhC5PFu
	 uwh/BJjaxKBS47j0X+Cg09/WfTvylvAmVuNARk1vdBT45FTyDMmuYAw3x+pFNB42jm9NT
	 DYo48AC4DXonnQa6tRET8OpN3aebip65NA4eihlvvYa0iRLt7CebN09cirzK2f3pMkc90
	 wlVJ/ovMYXLk6MbTVuj0XKWyjS8o+J6FoSqc+S/vH00um63UiaCYsErI7+rWyec4Lg30B
	 taHqPGvKvswVpRkA3CA7gmu28hr79TKJF9fnJNO7+k42W2urphOBIpfoUC6w95NBzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D28606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86D28606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so1015474a91.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 23:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794555419; x=1795160219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQZFryO10Nwl24stNk7sjkQ3d9LySI0OptJ1tpt1TVE=;
        b=TBgXzRLG0nUVYLKYJKR8uGqjkJWju+heNEeyom+RGkhkPeWWfs/M78Ha5w5z4uygaq
         2hXDXAUsf5wl3jTyp/qfUzxjCVX4p6SyABNJ1XilFJsJbxmeSLXaUxYQstm3ZurALQm5
         ew2xnNtsyok/K82UokxdvbwRneAxOoSWnUdreohSURWAWEVy+1J1SPp3j2nfxyHsEGpI
         vJVbZEwTKaiwyi829Gr1S+p0z9Df3D8FuJhotJ0KE2KK9GRV4eXMGf3NKVAixuf7QR1r
         TVkA1pvlr3IEzbk1LCxO9jfiW4Nv0RweW4Bz1QK98UiDSIeOFoUwCkmkfc3bMKN1+JhR
         l7Ag==
X-Forwarded-Encrypted: i=1; AL+hErF9lsA69ixJaiSv5BOXGpglq/AQ/3+P8sTU/mUtXhFhyHaRCOjzpszRyijxNcBxOD8XSFyeXCs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kBo2tCCtXZV3s18MCUOn3563F1GQq0OTdEESxDbPOy79vrV3Y
	yD8X//j5d5I5WIZU943Gnx4JOXN6ve625l6AYC2NzvKchUgyvmprU8HC
X-Gm-Gg: AYBFou0yAW6W019fXnHrD60raZ+9GD2G8FQkulzdG3Q8s+hvIiM7Z+ksbkd7M4uhzxp
	8sSQ4XqTEPYZP/gMxYBrjYUZWMGmTb2bvghhhXrLHRqJkv3uoG6nPc0RjhXlAhYmt4sMcsH2A1l
	3dD5Z5dH4zy4QOAa4QNYTthQpXNbQ/XG+Y8nxMo6PRC3143MW7UHjV/hrrbmffwlkQhwd1oc6i1
	8psqvAnlqUU+lgedAXAO7FW8I/w8kZ9Yn5WLD2WyvBajsaxoYHf2eCrifZusEPzvbITc8fxYy/G
	Pgo2GpdydobVVUR0msNvjDqhIdqZm3pma3GrMVLTWnTPNkTGHZ/zLWJRUvHl9XEFymPOxJwH/pd
	5xHZoHJfRxA2YAplVyYyPP+VsEfDA51N4jXULgwIhu55xLB+d8oRON3DOsBrEa0lZYOCAVrzFUV
	EBTF79IXgnW+u6IoJkm1hsYtNeK74efSpcNV7+3+5xwpXq0agCfUfAmGqF192qBOa4WwpUNhJh3
	82qgbr+KhCjJkQRbmmuwcuNoDqIAmo/bC/GXRFgUkcWcAr+usB76FjskVV+QnygXX+dbRouO3c9
	BGPp0BsiFKeASYzGBnXswP2flBZRQyBZxnMPCnTpYduasA==
X-Received: by 2002:a17:90b:5347:b0:39e:6a80:b799 with SMTP id 98e67ed59e1d1-3b1b0a3ba60mr1625886a91.41.1794555418776;
        Thu, 12 Nov 2026 23:36:58 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm3205009a91.4.2026.11.12.23.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 23:36:58 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	Liu Qi <liuqi@longcheer.com>,
	stable@vger.kernel.org,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v5 2/2] usb-storage: ene_ub6250: don't let the card-type probe hang forever
Date: Fri, 13 Nov 2026 15:36:38 +0800
Message-Id: <20261113073638.1225998-3-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261113073638.1225998-1-xiehongyu1@kylinos.cn>
References: <b07b5f5b-4722-4f1c-84b9-205ba9b8943f@rowland.harvard.edu>
 <20261113073638.1225998-1-xiehongyu1@kylinos.cn>
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

ene_ub6250_probe() reads the card type with ene_get_card_type() right
after usb_stor_probe2() has added the SCSI host.  The query is a
bulk-only transaction (CBW, one-byte data-in, CSW) sent through
ene_send_scsi_cmd(), which uses usb_stor_bulk_transfer_buf() and
therefore waits for URB completion without any timeout.  That is safe
only for transfers belonging to a SCSI command, where the command's
timeout and abort handling terminate the wait.  A card-type query has
no SCSI command behind it, so a device which enumerates but never
services bulk transfers blocks the probe forever.

commit 445fc368c6bc ("usb-storage: ene_ub6250: fix race between scan
work and probe") added us->dev_mutex around the query to keep it from
racing with the scan work for us->current_urb.  usb_stor_probe2()
queues that work with a one-second delay, so it now waits for a
transfer which may never finish.  The query itself has been unbounded
since commit 41e568d14ec0 ("Staging: Merge ENE UB6250 SD card codes
from keucr to drivers/usb/storage"), but only the latter turns the
hang into the lockup reported here, hence the Fixes tag.
syzbot reports:

 INFO: task kworker/0:2:53 blocked for more than 143 seconds.
 Workqueue: events_freezable usb_stor_scan_dwork
 Call Trace:
  __mutex_lock+0x7c4/0x15a0
  usb_stor_scan_dwork+0xec/0x2c0
 ...
 INFO: task syz-executor339:5675 blocked for more than 143 seconds.
 Call Trace:
  __mutex_lock+0x7c4/0x15a0
  device_lock
  usbdev_open+0x151/0x760

with the hub worker holding both locks stalled in
ene_ub6250_probe() -> ene_get_card_type() -> usb_stor_msg_common().

Run the query from ->initFunction instead.  usb_stor_acquire_resources()
calls it before the control thread is started and before the scan work
is queued, so nothing else can be using us->current_urb and the
dev_mutex from that commit can go away.  A failed query now unwinds
through usb_stor_probe2() before the SCSI host is registered, instead
of going through usb_stor_disconnect() and cancel_delayed_work_sync()
on a scan work which is itself stuck on the dead device.

Also give each transfer of the query a 10-second timeout.  A timeout
at any stage fails the query immediately, so the probe cannot block
forever.  The retry chain can run five transfers at most (CBW, data,
CSW and the two CSW retries), which bounds the query to about 50
seconds without keeping a shared budget.

Reported-by: syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30552b4cbe99d6d91306
Fixes: 445fc368c6bc ("usb-storage: ene_ub6250: fix race between scan work and probe")
Cc: Liu Qi <liuqi@longcheer.com>
Cc: stable@vger.kernel.org # 7.3.x: e350e5b223e1: add usb_stor_bulk_transfer_buf_timeout()
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>

---

v5:
 - Split into a two-patch series: the transport helper first, the driver
   change second.
 - Replace the shared 10-second budget with a per-transfer timeout.  A
   timeout in any stage fails the query immediately and the total time
   stays bounded, so the remaining-time bookkeeping is not needed.
 - State the worst-case bound of that choice (about 50 seconds, at most
   five transfers) in the message; record the transport helper as a
   stable prerequisite so the dependency is available there as well.
 - Shorten the comment above ENE_PROBE_TIMEOUT, as the reasoning is in
   ene_ub6250_init().
 - Drop the unused initializer of the bulk pipe variable.
 - Keep the forward declaration of ene_ub6250_init(): the unusual-device
   table is built by including unusual_ene_ub6250.h before the function
   definition and takes its address, so removing the declaration fails to
   build; realtek_cr.c has the same declaration for init_realtek_cr().

v4: https://lore.kernel.org/all/20261109085449.83117-1-xiehongyu1@kylinos.cn/
v3: https://lore.kernel.org/r/20261001123135.38831-1-xy521521@gmail.com/
v2: https://lore.kernel.org/r/20261001091523.16934-1-xy521521@gmail.com/
v1: https://lore.kernel.org/r/20260929144640.2028-1-xy521521@gmail.com/
---
 drivers/usb/storage/ene_ub6250.c         | 110 +++++++++++++++--------
 drivers/usb/storage/unusual_ene_ub6250.h |   2 +-
 2 files changed, 73 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index fea2614e767c7..bf661d8e2c540 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -24,6 +24,9 @@
 
 #define DRV_NAME "ums_eneub6250"
 
+/* Timeout for each transfer of the probe-time card-type query, in jiffies. */
+#define ENE_PROBE_TIMEOUT (10 * HZ)
+
 MODULE_DESCRIPTION("Driver for ENE UB6250 reader");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("USB_STORAGE");
@@ -34,6 +37,8 @@ MODULE_FIRMWARE(MS_INIT_FIRMWARE);
 MODULE_FIRMWARE(MSP_RW_FIRMWARE);
 MODULE_FIRMWARE(MS_RW_FIRMWARE);
 
+static int ene_ub6250_init(struct us_data *us);
+
 /*
  * The table of devices
  */
@@ -487,7 +492,12 @@ static void ene_ub6250_info_destructor(void *extra)
 	kfree(info->bbuf);
 }
 
-static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
+/*
+ * Send an ENE SCSI command.  @timeout bounds the wait for each transfer of
+ * the transaction, in jiffies; zero means no limit.
+ */
+static int ene_send_scsi_cmd_timeout(struct us_data *us, u8 fdir, void *buf,
+				     int use_sg, unsigned int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	struct bulk_cs_wrap *bcs = (struct bulk_cs_wrap *) us->iobuf;
@@ -499,27 +509,33 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 
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
+		unsigned int pipe;
 
-		if (fDir  == FDIR_READ)
+		if (fdir == FDIR_READ)
 			pipe = us->recv_bulk_pipe;
 		else
 			pipe = us->send_bulk_pipe;
 
 		/* Bulk */
 		if (use_sg) {
+			/*
+			 * Scatter-gather transfers belong to SCSI commands,
+			 * whose timeout and abort machinery bound the wait.
+			 */
 			result = usb_stor_bulk_srb(us, pipe, us->srb);
 		} else {
-			result = usb_stor_bulk_transfer_sg(us, pipe, buf,
-						transfer_length, 0, &partial);
+			result = usb_stor_bulk_transfer_buf_timeout(us, pipe,
+								    buf, transfer_length,
+								    &partial, timeout);
 		}
 		if (result != USB_STOR_XFER_GOOD) {
 			usb_stor_dbg(us, "data transfer fail ---\n");
@@ -528,20 +544,25 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
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
+							    US_BULK_CS_WRAP_LEN,
+							    &cswlen, timeout);
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
@@ -567,6 +588,15 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 	return USB_STOR_TRANSPORT_GOOD;
 }
 
+/*
+ * Unbounded variant for the command path: a SCSI command's timeout and
+ * abort machinery terminate the transfer if the device stops responding.
+ */
+static int ene_send_scsi_cmd(struct us_data *us, u8 fdir, void *buf, int use_sg)
+{
+	return ene_send_scsi_cmd_timeout(us, fdir, buf, use_sg, 0);
+}
+
 static int do_scsi_request_sense(struct us_data *us, struct scsi_cmnd *srb)
 {
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
@@ -1824,7 +1854,8 @@ static int ms_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
  * ENE MS Card
  */
 
-static int ene_get_card_type(struct us_data *us, u16 index, void *buf)
+static int ene_get_card_type(struct us_data *us, u16 index, void *buf,
+			     unsigned int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	int result;
@@ -1837,7 +1868,7 @@ static int ene_get_card_type(struct us_data *us, u16 index, void *buf)
 	bcb->CDB[2]			= (unsigned char)(index>>8);
 	bcb->CDB[3]			= (unsigned char)index;
 
-	result = ene_send_scsi_cmd(us, FDIR_READ, buf, 0);
+	result = ene_send_scsi_cmd_timeout(us, FDIR_READ, buf, 0, timeout);
 	return result;
 }
 
@@ -2191,7 +2222,7 @@ static int ene_init(struct us_data *us)
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 	u8 *bbuf = info->bbuf;
 
-	result = ene_get_card_type(us, REG_CARD_STATUS, bbuf);
+	result = ene_get_card_type(us, REG_CARD_STATUS, bbuf, 0);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
 
@@ -2319,13 +2350,35 @@ static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 static struct scsi_host_template ene_ub6250_host_template;
 
+/*
+ * Probe-time card-type query.  It runs from usb_stor_acquire_resources(),
+ * before the usb-storage control thread and the SCSI scan work exist, so
+ * nothing else can be using us->current_urb.  Give every transfer a
+ * timeout: there is no SCSI command whose timeout or abort handling could
+ * end the wait, and a timeout at any stage fails the whole query.
+ */
+static int ene_ub6250_init(struct us_data *us)
+{
+	struct ene_ub6250_info *info = (struct ene_ub6250_info *)us->extra;
+	int result;
+
+	result = ene_get_card_type(us, REG_CARD_STATUS, info->bbuf,
+				   ENE_PROBE_TIMEOUT);
+	if (result != USB_STOR_XFER_GOOD)
+		return -EIO;
+
+	if (!(info->bbuf[0] & 0x01))
+		pr_info("ums_eneub6250: SM cards are not supported\n");
+
+	return 0;
+}
+
 static int ene_ub6250_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
-	int result;
-	u8  misc_reg03;
 	struct us_data *us;
 	struct ene_ub6250_info *info;
+	int result;
 
 	result = usb_stor_probe1(&us, intf, id,
 		   (id - ene_ub6250_usb_ids) + ene_ub6250_unusual_dev_list,
@@ -2352,26 +2405,7 @@ static int ene_ub6250_probe(struct usb_interface *intf,
 	us->transport_reset = usb_stor_Bulk_reset;
 	us->max_lun = 0;
 
-	result = usb_stor_probe2(us);
-	if (result)
-		return result;
-
-	/* probe card type */
-	mutex_lock(&us->dev_mutex);
-	result = ene_get_card_type(us, REG_CARD_STATUS, info->bbuf);
-	mutex_unlock(&us->dev_mutex);
-	if (result != USB_STOR_XFER_GOOD) {
-		usb_stor_disconnect(intf);
-		return USB_STOR_TRANSPORT_ERROR;
-	}
-
-	misc_reg03 = info->bbuf[0];
-	if (!(misc_reg03 & 0x01)) {
-		pr_info("ums_eneub6250: This driver only supports SD/MS cards. "
-			"It does not support SM cards.\n");
-	}
-
-	return result;
+	return usb_stor_probe2(us);
 }
 
 
diff --git a/drivers/usb/storage/unusual_ene_ub6250.h b/drivers/usb/storage/unusual_ene_ub6250.h
index a3b32abc2b2ff..bc9d7ea4e398b 100644
--- a/drivers/usb/storage/unusual_ene_ub6250.h
+++ b/drivers/usb/storage/unusual_ene_ub6250.h
@@ -5,6 +5,6 @@
 UNUSUAL_DEV(0x0cf2, 0x6250, 0x0000, 0x9999,
 		"ENE",
 		"ENE UB6250 reader",
-		USB_SC_DEVICE, USB_PR_DEVICE, NULL, 0),
+		USB_SC_DEVICE, USB_PR_DEVICE, ene_ub6250_init, 0),
 
 #endif /* defined(CONFIG_USB_STORAGE_ENE_UB6250) || ... */
-- 
2.25.1

