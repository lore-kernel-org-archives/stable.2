Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214499;
	b=bv8Wrkz3UtozDifrGYmqShaajPhWCeODmg7A7frTkn/PWdi0R6dTArsiRYkEBqfQo7Er
	 2B/xto6DqePZhwI+OJZK8OSkaseuuVKiRQ3gwFsC4/QIcI1Ys1m52GGaoMOqXO20B5Qq8
	 AoWYqpWl9PIZXN2z5ozePFh6j4Fdq72EdrP+pEKtQoW3yvj5r+kSJdvn8iaDtZ6JHAekV
	 xcL/gZ61a1Zs0WA/mtFS9rpaPOsa5Z/mlYteyOXm2oSR8ac55K6x2yJ2DrXfhVgwcxdON
	 hHHRlq8uKsPWJWitWce7RkpbiU4DQg4285HAlU4Q54196o89gi+6hFTccZLv6uihkpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214499;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0Rhxsu2l8SKxK6ZPng9+7j8nAKxus/Gd71FEzth3lsQ=;
	b=QZAbFr7T7yXN3ZzKM//+rRw0ZCY2/LZZHrrbL0y4zxP/JlV5FAkYoPwnUgOKuwxvRD0O
	 C14hn0EiLq91KGLNplruCzwOJhciSyogfriWGTyxwlBAZ4xLAs2uPTNe2ZSOiD7juOOLV
	 FidDTdZrvSupyVcsZfNPizgYNNi/EnE4bJ3/XUmrShpdpTFNvACbbn8ZSngaQloVfDaEB
	 TZkG7KzPmQmdQ3tayzFm4GSgNMEZA7G8ptyo1uphEE+teE9e3TvQST1UJv17v1wj91vqD
	 7lBoV7dspRkNBQnUteRH1FUbSNnIUGS9XEFv89xcPMxZm74aZIO+1mOsOzw45o29o9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498E606A335
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3498E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cdb9d5c1c8eso283615a12.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 00:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214497; x=1794819297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Rhxsu2l8SKxK6ZPng9+7j8nAKxus/Gd71FEzth3lsQ=;
        b=wh+AOpmliN4AKkPYBgiPTi/+A5BgIi5IiAbmjMp5DpHTR4vwoShix6s8vyA1tlhdC0
         J0yA2cv4ackBSb5IpejjKqeWwRd49afuCi5HJGvQghq/LDmq9XX/whYgjUc9Rtx6TU+J
         2lDZahKbelNHJ/SFa2Iuanbvu1+TNZ4sGuFRtoJARRHUS+JvUByLiwv8UlHNpnUNlCKd
         04LmJH99MfKYAkrY3yMJZiGLmjE+FbhyIGe2kAAsrYS94A4KkAOmFrwu3FwziSInYzlA
         HYLnIoV/kQD+6mqqHjM1Y7eW8YHO0T0bsc+QWJCHzVjldExO/FpZ+KG3pEdPdckVm7Bd
         bR0A==
X-Forwarded-Encrypted: i=1; AL+hErHiUDEYvoZGGVjlRWhx1yVRNmf/4FUqegUESZAbjVUPQBM3VdVem7AZhVgPFRuxTyTdUmPXGXA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a2uRUcay9u/ZjTnXp2qpizx+BeV7A4KfSxc7LvaiTgVZenW0a
	gyde/7KkyXDOvyu1RjoMbdLQnddLEYMHrw/shjqToyDy7zn/cfPxKcf5
X-Gm-Gg: AYBFou3w7u5EF9v4cz+ywut4c5rBditQzWvTSznPwVERuqSeNxPgtm1bml1nYAd7A9h
	6VNX/QKSsvzzy3O4hZH4BCm7m1qDJ84FQaTikjlaxTBgDetQ3daf2GJneWYziuhv/o+y2n3PGRH
	eiikcKpXRdIxOe71mtTxLe9+c1dIeOudsgLUfGXOTZeQjUJDbqJO6Z4oJEb8VuJsLniFk7E7S2S
	9zMfgohasApDqhE2WkDXlo0Wz8Q/BZ9qDQquDTqQyjf1aWEJf7GmEoFBx5luvkZfaB3DjMQKpaB
	9De+31zt6IhfVUb9kv93ZxjwPBJU39Av1ruY5HLPJ59g9e60apJthqbuYRW1zZVzA3lZugHo3WC
	qjDVjQcxrWL1sLJmWyyIkzEXCTl9A0b1Is5qOL0aN15R8nWyxfEfv9xy3c8FqApts94Hu+OhqM6
	SGCqrgY8jFoIrvHsxUv2YSM6gs+Xko/uN7oNBxCt57EoWcZLWeUYqUP/WTPrVfaxgvWREOe1CRf
	3MmPdGKWWSnxvpr7f6J2QgFOV10NudUSp0h3XoS+KCYhSqeKBXudtZ/yKIHgQCKZ4M8V811eZ/2
	2IzwgK/72cZtCg3gv8PKyaTfhM4atmXJp9+HY45dRoxNqvk=
X-Received: by 2002:a05:6a20:cfa9:b0:3de:8ee8:8323 with SMTP id adf61e73a8af0-3eed43a478amr3356688637.29.1794214497217;
        Mon, 09 Nov 2026 00:54:57 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96814158sm1396221a12.8.2026.11.09.00.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:54:56 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net,
	Hongyu Xie <xiehongyu1@kylinos.cn>,
	syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com,
	Liu Qi <liuqi@longcheer.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] usb-storage: ene_ub6250: don't let the card-type probe hang forever
Date: Mon,  9 Nov 2026 16:54:49 +0800
Message-Id: <20261109085449.83117-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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
 ...
 __mutex_lock
 usb_stor_scan_dwork
 ...
 INFO: task syz-executor339:5675 blocked for more than 143 seconds.
 ...
 device_lock
 usbdev_open

with the hub worker holding both locks stalled in
ene_ub6250_probe() -> ene_get_card_type() -> usb_stor_msg_common().

Run the query from ->initFunction instead.  usb_stor_acquire_resources()
calls it before the control thread is started and before the scan work
is queued, so nothing else can be using us->current_urb and the
dev_mutex from that commit can go away.  A failed query now unwinds
through usb_stor_probe2() before the SCSI host is registered, instead
of going through usb_stor_disconnect() and cancel_delayed_work_sync()
on a scan work which is itself stuck on the dead device.

Also bound the whole query with a 10-second budget covering the CBW,
the data stage and the CSW.  Per-transfer timeouts would not be
enough, since a device can stretch the query over the data stage and
the two CSW retries; each transfer gets the time remaining in the
budget.

Reported-by: syzbot+30552b4cbe99d6d91306@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=30552b4cbe99d6d91306
Fixes: 445fc368c6bc ("usb-storage: ene_ub6250: fix race between scan work and probe")
Cc: Liu Qi <liuqi@longcheer.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v4:
 - Run the query from ->initFunction and drop the dev_mutex added by
   445fc368c6bc.  usb_stor_acquire_resources() calls it before the control
   thread is started and before the scan work is queued, so nothing else
   can be using us->current_urb, and a failed query unwinds before the
   SCSI host and the scan work exist.  The previous failure path went
   through usb_stor_disconnect() and cancel_delayed_work_sync() on a scan
   work stuck on the dead device.
 - Replace the 30-second per-transfer timeout with a single 10-second
   budget for the whole CBW/data/CSW sequence, including the CSW retries.
   Each transfer gets the time remaining in the budget, computed from one
   jiffies sample per step; the start time and the budget stay separate
   so that a wrapped deadline cannot be mistaken for the zero "no limit"
   value.
 - Return -EIO instead of -ENODEV when the query fails, like the other
   usb-storage initFunctions.  -ENODEV is only logged at dev_dbg as a
   rejected match, which would hide a real transfer failure at the
   default log level.
 - Keep Fixes: 445fc368c6bc, and spell out that the unbounded query
   predates it (41e568d14ec0); 445fc368c6bc is what turns the hang into
   the lockup reported here.
 - Fold the coding-style cleanup into this patch: the timeout code was
   rewritten and is checkpatch clean, so the separate 2/2 style patch is
   dropped.

v3: https://lore.kernel.org/r/20261001123135.38831-1-xy521521@gmail.com/
v2: https://lore.kernel.org/r/20261001091523.16934-1-xy521521@gmail.com/
v1: https://lore.kernel.org/r/20260929144640.2028-1-xy521521@gmail.com/
---
 drivers/usb/storage/ene_ub6250.c         | 153 +++++++++++++++++------
 drivers/usb/storage/transport.c          |  31 +++--
 drivers/usb/storage/transport.h          |   5 +
 drivers/usb/storage/unusual_ene_ub6250.h |   2 +-
 4 files changed, 143 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index fea2614e767c7..2b4fab31e900d 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -24,6 +24,15 @@
 
 #define DRV_NAME "ums_eneub6250"
 
+/*
+ * Time budget for the card-type query done while probing, in jiffies.  It
+ * is a bulk transfer with no SCSI command behind it, so nothing else would
+ * terminate the wait if the device stopped responding.
+ */
+#define ENE_PROBE_TIMEOUT (10 * HZ)
+
+static int ene_ub6250_init(struct us_data *us);
+
 MODULE_DESCRIPTION("Driver for ENE UB6250 reader");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("USB_STORAGE");
@@ -487,39 +496,76 @@ static void ene_ub6250_info_destructor(void *extra)
 	kfree(info->bbuf);
 }
 
-static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
+/*
+ * Return what is left of a budget of @timeout jiffies which started at
+ * @start, in jiffies, or -ETIMEDOUT if the budget has been used up.  A zero
+ * @timeout means no limit.
+ */
+static int ene_time_left(unsigned long start, unsigned int timeout)
+{
+	unsigned long elapsed;
+
+	if (!timeout)
+		return 0;
+
+	elapsed = jiffies - start;
+	if (elapsed >= timeout)
+		return -ETIMEDOUT;
+
+	return min_t(unsigned long, timeout - elapsed, INT_MAX);
+}
+
+/*
+ * Send an ENE SCSI command.  @timeout is the time budget for the whole
+ * transaction (CBW, data and CSW), in jiffies; zero means no limit.
+ */
+static int ene_send_scsi_cmd_timeout(struct us_data *us, u8 fdir, void *buf,
+				     int use_sg, unsigned int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	struct bulk_cs_wrap *bcs = (struct bulk_cs_wrap *) us->iobuf;
-
-	int result;
+	unsigned long start = jiffies;
+	int result, left;
 	unsigned int residue;
 	unsigned int cswlen = 0, partial = 0;
 	unsigned int transfer_length = bcb->DataTransferLength;
 
+	left = ene_time_left(start, timeout);
+	if (left < 0)
+		return USB_STOR_TRANSPORT_ERROR;
+
 	/* usb_stor_dbg(us, "transport --- ene_send_scsi_cmd\n"); */
 	/* send cmd to out endpoint */
-	result = usb_stor_bulk_transfer_buf(us, us->send_bulk_pipe,
-					    bcb, US_BULK_CB_WRAP_LEN, NULL);
+	result = usb_stor_bulk_transfer_buf_timeout(us, us->send_bulk_pipe,
+						    bcb, US_BULK_CB_WRAP_LEN,
+						    NULL, left);
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
+			left = ene_time_left(start, timeout);
+			if (left < 0)
+				return USB_STOR_TRANSPORT_ERROR;
+			result = usb_stor_bulk_transfer_buf_timeout(us, pipe,
+								    buf, transfer_length, &partial,
+								    left);
 		}
 		if (result != USB_STOR_XFER_GOOD) {
 			usb_stor_dbg(us, "data transfer fail ---\n");
@@ -527,21 +573,36 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
 		}
 	}
 
+	left = ene_time_left(start, timeout);
+	if (left < 0)
+		return USB_STOR_TRANSPORT_ERROR;
+
 	/* Get CSW for device status */
-	result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe, bcs,
-					    US_BULK_CS_WRAP_LEN, &cswlen);
+	result = usb_stor_bulk_transfer_buf_timeout(us, us->recv_bulk_pipe,
+						    bcs, US_BULK_CS_WRAP_LEN,
+						    &cswlen, left);
 
 	if (result == USB_STOR_XFER_SHORT && cswlen == 0) {
 		usb_stor_dbg(us, "Received 0-length CSW; retrying...\n");
-		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-					    bcs, US_BULK_CS_WRAP_LEN, &cswlen);
+		left = ene_time_left(start, timeout);
+		if (left < 0)
+			return USB_STOR_TRANSPORT_ERROR;
+		result = usb_stor_bulk_transfer_buf_timeout(us,
+							    us->recv_bulk_pipe, bcs,
+							    US_BULK_CS_WRAP_LEN, &cswlen,
+							    left);
 	}
 
 	if (result == USB_STOR_XFER_STALLED) {
 		/* get the status again */
 		usb_stor_dbg(us, "Attempting to get CSW (2nd try)...\n");
-		result = usb_stor_bulk_transfer_buf(us, us->recv_bulk_pipe,
-						bcs, US_BULK_CS_WRAP_LEN, NULL);
+		left = ene_time_left(start, timeout);
+		if (left < 0)
+			return USB_STOR_TRANSPORT_ERROR;
+		result = usb_stor_bulk_transfer_buf_timeout(us,
+							    us->recv_bulk_pipe, bcs,
+							    US_BULK_CS_WRAP_LEN, NULL,
+							    left);
 	}
 
 	if (result != USB_STOR_XFER_GOOD)
@@ -567,6 +628,15 @@ static int ene_send_scsi_cmd(struct us_data *us, u8 fDir, void *buf, int use_sg)
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
@@ -1824,7 +1894,8 @@ static int ms_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
  * ENE MS Card
  */
 
-static int ene_get_card_type(struct us_data *us, u16 index, void *buf)
+static int ene_get_card_type(struct us_data *us, u16 index, void *buf,
+			     unsigned int timeout)
 {
 	struct bulk_cb_wrap *bcb = (struct bulk_cb_wrap *) us->iobuf;
 	int result;
@@ -1837,7 +1908,7 @@ static int ene_get_card_type(struct us_data *us, u16 index, void *buf)
 	bcb->CDB[2]			= (unsigned char)(index>>8);
 	bcb->CDB[3]			= (unsigned char)index;
 
-	result = ene_send_scsi_cmd(us, FDIR_READ, buf, 0);
+	result = ene_send_scsi_cmd_timeout(us, FDIR_READ, buf, 0, timeout);
 	return result;
 }
 
@@ -2191,7 +2262,7 @@ static int ene_init(struct us_data *us)
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 	u8 *bbuf = info->bbuf;
 
-	result = ene_get_card_type(us, REG_CARD_STATUS, bbuf);
+	result = ene_get_card_type(us, REG_CARD_STATUS, bbuf, 0);
 	if (result != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
 
@@ -2319,13 +2390,34 @@ static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 
 static struct scsi_host_template ene_ub6250_host_template;
 
+/*
+ * Probe-time card-type query.  It runs from usb_stor_acquire_resources(),
+ * before the usb-storage control thread and the SCSI scan work exist, so
+ * nothing else can be using us->current_urb.  Bound it explicitly: there
+ * is no SCSI command whose timeout or abort handling could end the wait.
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
@@ -2352,26 +2444,7 @@ static int ene_ub6250_probe(struct usb_interface *intf,
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
 
 
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 8de3015bce050..424293658918a 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -378,12 +378,17 @@ static int usb_stor_intr_transfer(struct us_data *us, void *buf,
 }
 
 /*
- * Transfer one buffer via bulk pipe, without timeouts, but allowing early
- * termination.  Return codes are USB_STOR_XFER_xxx.  If the bulk pipe
- * stalls during the transfer, the halt is automatically cleared.
+ * Transfer one buffer via bulk pipe, allowing early termination.  Return
+ * codes are USB_STOR_XFER_xxx.  If the bulk pipe stalls during the
+ * transfer, the halt is automatically cleared.
+ *
+ * A nonzero @timeout bounds the wait for URB completion, in jiffies.  It
+ * must only be used for transfers which are not part of a SCSI command:
+ * those rely on the command's timeout and abort handling.
  */
-int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
-	void *buf, unsigned int length, unsigned int *act_len)
+int usb_stor_bulk_transfer_buf_timeout(struct us_data *us, unsigned int pipe,
+				       void *buf, unsigned int length,
+				       unsigned int *act_len, int timeout)
 {
 	int result;
 
@@ -392,14 +397,26 @@ int usb_stor_bulk_transfer_buf(struct us_data *us, unsigned int pipe,
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
+			act_len, 0);
+}
 EXPORT_SYMBOL_GPL(usb_stor_bulk_transfer_buf);
 
 /*
diff --git a/drivers/usb/storage/transport.h b/drivers/usb/storage/transport.h
index 74ffd0d7e7b6c..361dbd77f15e3 100644
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

