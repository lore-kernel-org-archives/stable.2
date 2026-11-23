Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.181.117.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442954;
	b=F+DQU3c+1JCZDtewVtjwwK36q8sqkt7LXYMKu2aDmsTsMQTDyrctXH+9PliX0APSypfX
	 8yFD4Zk0GG2JFT84Mdf75kQYoVhhvg7qc8MQ7Z+rI+1TbcDoB/hX3R3vnGjwI8n1nj0uQ
	 s7gw8F7+Iwk/y73cxBjpJa3bTgdTJ0eASRY7M3xyBLntlw7PfOW0mf8i3WHAadgrBgqNy
	 RG/ijHkX8KqMYBBRuhZzA+hur2WESAX58P1u8tpnsqRsodYA3qV/BLvlZ7WoGCgm6qYhW
	 SJgoIwR3kJ3XgxZBfuz25zTRycWPW+7bFKDtldQLSa/PAT38wsarnDE2PeAHw4BnVmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442954;
	h=DMARC-Filter:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EsetResult:X-EsetId;
	bh=bkGKinORLdDqD03ZNmb2//VfBf9kk7ZJc5gEpink6DU=;
	b=kOidJOmzrshXUcSAE0CzucI0cgIuKV3RgM8aDF8yxzlbi2/65qjS3L13dZ7fauGxkSTa
	 FjkXcBVw5GJVzdeUrpsQuyBwSfxe5NbPGrF7wsPjGtC2hc3K70NAvG8CWhgm9/HCnFW0u
	 bxCCxZsCyzSAO9fisMSobGAmrGouIMf2ZNKwFtJu0oKclVsPDHAGTWnb4TPYkyWsX3u6I
	 AQ2EbfOHeLpA7q4v39X9m8tLXFS30aNhAgpQf/UPJ2kXvJopyTj1pLQ/WfxaCj9WJLbo/
	 UnSqyOhjIZfHFLcBo/3shWRxe9zj+qDzOb+0PZL4pSmAbUy92k5GsTsc8YUvj+GWawg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=actia.se;
	spf=pass smtp.mailfrom=actia.se;
	arc=none smtp.remote-ip=212.181.117.226
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324BD606A32D;
	Mon, 23 Nov 2026 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 324BD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from w705anl.ipa.actianordic.se (10.12.12.95) by
 S185ANL.actianordic.se (10.12.31.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 15:09:05 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
	<shuah@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Hongren Zheng <i@zenithal.me>, Nobuo Iwata <nobuo.iwata@fujixerox.co.jp>,
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Wiliam Puranen
	<wiliam.puranen@actia.se>, <stable@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>, Michael Grzeschik <grzeschik@puzzle.ch>
Subject: [PATCH v2] usbip: Stop tracking work context in event_handler()
Date: Mon, 23 Nov 2026 15:09:02 +0100
Message-ID: <20261123140902.2177108-1-john.ernberg@actia.se>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain
X-ClientProxiedBy: S185ANL.actianordic.se (10.12.31.116) To
 S185ANL.actianordic.se (10.12.31.116)
X-EsetResult: clean, is OK
X-EsetId: 37303A29379CA95B61726A

From: Wiliam Puranen <wiliam.puranen@actia.se>

The work queue used by usbip is not pinned to a specific context.

When usbip_in_eh() evaluates if the call comes from the event handler
it doesn't actually check if the call comes from the event handler but
if the call comes from the same context as the event handler was first
called from.

This can result in "sticky" devices on the client side, due to the
teardown path in stub_disconnect() being lied to, and thus skipping
the teardown when it shouldn't, or vice versa.

Fixes: bb7871ad99ea ("usbip: event handler as one thread")
Cc: stable@vger.kernel.org # v4.6+
Signed-off-by: Wiliam Puranen <wiliam.puranen@actia.se>
Signed-off-by: John Ernberg <john.ernberg@actia.se>
Reviewed-by: Michael Grzeschik <grzeschik@puzzle.ch>

---

Fixes an issue we've seen in our CI where USB devices remain in the client
after the server side has been suspended, even after the USB device having
been removed from the server.

AI was used to help us track down the issue and fix drafting. All testing,
verification, and final patch was done by humans.

v2:
 - Resent based on Shuah's request
 - Drop Assisted-by tag as those are not used anymore,
   shortly describe the parts AI was used for in the creation of the patch.
 - Pick up Michaels review tag
 - Rebased on latest usb-linus

v1: https://lore.kernel.org/linux-usb/20260803104342.2790105-1-john.ernberg@actia.se/
---
 drivers/usb/usbip/stub_dev.c     |  2 +-
 drivers/usb/usbip/usbip_common.h |  2 +-
 drivers/usb/usbip/usbip_event.c  | 10 ++--------
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index abfa11d6bde7..407ac55d85c5 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -474,7 +474,7 @@ static void stub_disconnect(struct usb_device *udev)
 	}
 
 	/* If usb reset is called from event handler */
-	if (usbip_in_eh(current))
+	if (usbip_in_eh())
 		return;
 
 	/* we already have busid_priv, just lock busid_lock */
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index be4c5e65a7f8..2c91187e6469 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -321,7 +321,7 @@ int usbip_start_eh(struct usbip_device *ud);
 void usbip_stop_eh(struct usbip_device *ud);
 void usbip_event_add(struct usbip_device *ud, unsigned long event);
 int usbip_event_happened(struct usbip_device *ud);
-int usbip_in_eh(struct task_struct *task);
+int usbip_in_eh(void);
 
 static inline int interface_to_busnum(struct usb_interface *interface)
 {
diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 0e00c2d000f8..695af652c512 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -57,16 +57,10 @@ static struct usbip_device *get_event(void)
 	return ud;
 }
 
-static struct task_struct *worker_context;
-
 static void event_handler(struct work_struct *work)
 {
 	struct usbip_device *ud;
 
-	if (worker_context == NULL) {
-		worker_context = current;
-	}
-
 	while ((ud = get_event()) != NULL) {
 		usbip_dbg_eh("pending event %lx\n", ud->event);
 
@@ -186,9 +180,9 @@ int usbip_event_happened(struct usbip_device *ud)
 }
 EXPORT_SYMBOL_GPL(usbip_event_happened);
 
-int usbip_in_eh(struct task_struct *task)
+int usbip_in_eh(void)
 {
-	if (task == worker_context)
+	if (current_work() == &usbip_work)
 		return 1;
 
 	return 0;
-- 
2.53.0

