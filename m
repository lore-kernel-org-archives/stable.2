Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595294;
	b=nJW1M2G5Eoa5wBah3O6TGBHQHsC1sEWYnDCP8XppKz/WHxg7nodTFDLnn+A3BvdDbWQM
	 syNiEIj8ym91OPZtFzqcEmxGsh0zXGTBlDsEGgzRNNxL0doNJrMIDm/DyLitQ6ERgoYTg
	 m3JPvUhErs2Jmqfoplmh1R0jJkwdErWrHT95QyMmCe68L+xku2z6n1VJCPqKxkYKw7zaj
	 zJH9PeyQB/sZLMQFvndtZ6XyQOSgNpXgNhaSKIcRqYfGqfQArko0WBELHDpTMzzKLZrlv
	 YB9pN3re/s4vlpXUfnb+IhxkR7+vTqisMdLdS8EBGWa+WkfXAZnS24YmEFWUwg7hpIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=84k5TBvs1A0y0i2ngDG+bcTK+NNF141yVhoDDZPV9pA=;
	b=vWSGm7DgPNUVVlHsRL9bZf4NKcUlXR4s5+LjoLsXNnxSN6a8KQ4glXU57hJq7gXznNyJ
	 D9qRpADmlAkpJqoA0tmVS7GXwbkyChj/FPIQRMxQUzgYgpEhdlT328LEFtzMe6YYGmgfM
	 hmV8VNHQUDqU+UPsZQSOpy2UUk3kyv48EmdNHtPqCiVmj4Nkc6bFN31Dsi2CVT776Mluy
	 /lLw92sgbFBTHDul3ujnpe9eC5sz3PXQkSvsU3CuSry88OVWzG/fClkEyokHaeFj4kmDt
	 YcU1qoUxoxT0vboOCVnvMah4p/AGRrwWiHZd9bb2lp6jKR5Mpme0rxRU2puAsjGsZYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D7ZQBy6v;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE260A2625
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CE260A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=D7ZQBy6v
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4af81963f35so515711b6e.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792595293; x=1793200093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=84k5TBvs1A0y0i2ngDG+bcTK+NNF141yVhoDDZPV9pA=;
        b=D7ZQBy6vufjuZJLFrTf5PozoHzgsUzww0smXTpTc0XwYv4UpsjtGaYjkUi0huzuLiH
         lmX427OaE3jzu89UCKYoWfqaVvetBzEF1n4O5YYHtsBCO99Bh+gDUfzAvr2KZ/KTfRDV
         0q3KRGm+JmQyEpyouoadjwNeAFwYtv+Th35qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595293; x=1793200093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=84k5TBvs1A0y0i2ngDG+bcTK+NNF141yVhoDDZPV9pA=;
        b=mvKQSo0e0i964rdd7rPFUuDvO7OjMuQmXIdt1c3wl2kCooJ2WFYdAeD3YPXA58ERIR
         QXVNJ1qRIE4Y3edrQsmiP4U90zmpyjodKScuUaOV/68g7EIX6Hsejt1Kn29e1327oNM2
         sjyucziLBfju/pcMFKJab1cFnARWoisJBteg4jysQjiPtKYeGvdzgJyDTq0u4ur7tU7z
         FyjSuYfMN6/rBy1pvcqkOQ3jXHU0K3kAsMAe6E3Ai4COO+mr2KjFDVfywbTAgfIO3f1c
         ovxvo5XgIwEde36m2mrkUS3BStUMF5VFVZdGbPz0nYu3qRbqYbqQdXG+9OxtEsmitvIQ
         mEog==
X-Forwarded-Encrypted: i=1; AKwUvBxtousawF/mFsBixyTvIj6xzogyWeUbPKfmOTo2XntMF+xRSQhVpiqxh1MOTUbWUYkNW1BLqSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv0eyoaohWgaRM28z56XjE9HVeZ/A/RcBRzilQSZWiNkepDobQ
	V1T9FXXZJT/6Nn1ynuu7ucNKE4TpogxwGRp+eH17aFTCd2zJSvvr9HfouayYEwYsQA==
X-Gm-Gg: AYBFou19xW5cYlkR7QXwKfpFkNL3XNa+xjleC9BuYPTzH9y4ilFeDXb76UeWM7DkxYt
	e2pGK9EG6yzhG/AZT0P0XRpsIFtAEcJCZ3MgbGhPii1qCJ95YtIRrJHSRNHuodZrm6k5U/gyTCV
	br5yLON4AubSVx74BNqM27IVeFRW7yJoxL//bPtlKu2HY4yV/e2Hcmtqktbkn6ZZkg3tt6VqnuG
	e7TNlas6TsRKrUTNOIRcHYpWc3GAPu0l5jst/kND/trrZMu/ILX2lM6pdjHkRtOC+ZBnS4oxYQs
	pp0WtZh+IyPTjaY5s53759VK8vSB7UvThuRAJE2TXzteunxVC9W0csont18e9UW4kIwBROTdj0w
	7PpsfAkQEs/z3mRrafd8zTA7B2uTNTOJvXuZj6yMqgEM4Wnk0IImhtBbXGSDzt80K51rNkCbbUw
	I332+sKrV1hANV4+M6KJKTfmJ8UpFx+PsJEspk6Akhn6ku//W/JeM/sENI5OGQruRAOW0qn3kfO
	+mkxU0ycYHQ8SWiaTkvGOq9rQB0VgbsN6Pbf98/pttCXkxmQYiyWi5F/azf4os77kPbv1oX2X/o
	yObSLdTYG7+zyTsLxwDt/otUGe9ad6BeMF5y/10VUQOMPvNPWQ5GG6te01eYNs57cg==
X-Received: by 2002:a05:6808:150a:b0:52b:7641:33a6 with SMTP id 5614622812f47-5535a66d1d5mr1600281b6e.14.1792595292926;
        Wed, 21 Oct 2026 08:08:12 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b400bd39sm2023922b6e.6.2026.10.21.08.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:08:12 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hongren Zheng <i@zenithal.me>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Raul E Rangel <rrangel@chromium.org>,
	stable@vger.kernel.org,
	Anirudh Rayabharam <mail@anirudhrb.com>,
	"Brian G. Merrell" <bgmerrell@novell.com>
Subject: [PATCH 3/6] usbip: vhci_hcd: stop enqueue and drain all pending URBs on disconnect
Date: Wed, 21 Oct 2026 09:06:58 -0600
Message-ID: <20261021150704.3129446-4-rrangel@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021150704.3129446-1-rrangel@chromium.org>
References: <20261021150704.3129446-1-rrangel@chromium.org>
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

Even with vhci_urb_dequeue() completing unsent URBs locally when
unlinked, several races in vhci_shutdown_connection() allow URBs to be
enqueued after shutdown begins or remain stranded on vdev->priv_tx and
vdev->priv_rx across disconnect and port reset:

1. vhci_urb_enqueue() only rejects URBs when vdev->ud.status is
   VDEV_ST_NULL or VDEV_ST_ERROR. Because ud.status remains VDEV_ST_USED
   after USBIP_EH_SHUTDOWN is set and until vhci_device_reset() runs
   after vhci_shutdown_connection(), vhci_urb_enqueue() continues
   accepting new URBs onto vdev->priv_tx even after tcp_tx has stopped.

2. vhci_shutdown_connection() clears vdev->ud.tcp_socket without holding
   vhci->lock or vdev->ud.lock, racing with vhci_urb_enqueue() and
   vhci_urb_dequeue().

3. vhci_device_unlink_cleanup() only processes vdev->unlink_tx and
   vdev->unlink_rx, leaving non-unlinked URBs on vdev->priv_tx and
   vdev->priv_rx until asynchronous rh_port_disconnect() work runs on
   usb_hub_wq. If a task holds udev->dev.mutex while waiting on an URB,
   usb_disconnect() blocks on udev->dev.mutex. Moreover, because
   vhci_device_reset() immediately sets ud.status to VDEV_ST_NULL, any
   entries left on vdev->priv_tx when the port is re-attached via
   attach_store() will be transmitted by the new connection's tcp_tx
   thread to the new server.

In a live deadlock captured with drgn on a hung host:
- rx thread logged "connection closed" and set USBIP_EH_SHUTDOWN, and
  vhci_shutdown_connection() stopped tcp_rx and tcp_tx (29.6519 s)
  before clearing tcp_socket (29.6716 s).
- In kernel memory (drgn), vdev->priv_tx still held never-transmitted
  URB seqnum 17193284 with urb->unlinked = -ESHUTDOWN and
  use_count = 1, while vdev->priv_rx held unanswered URB
  seqnum 17193282 with urb->unlinked = 0 and vdev->unlink_tx/unlink_rx
  were empty.
- A concurrent USBDEVFS_RESET ioctl holding udev->dev.mutex called
  usb_hcd_flush_endpoint() -> usb_kill_urb(), blocking in D state on
  seqnum 17193284 while usb_hub_wq blocked in usb_disconnect() waiting
  for udev->dev.mutex, freezing the vhci root hub.

Fix this to guarantee all pending URBs are given back when the
connection is torn down (note that while a connection remains up,
usb_kill_urb() still waits for RET_UNLINK or connection teardown):
- Clear vdev->ud.tcp_socket under vhci->lock and vdev->ud.lock in
  vhci_shutdown_connection(), and reject vhci_urb_enqueue() (with a
  rate-limited error) when USBIP_EH_SHUTDOWN is set or tcp_socket is
  NULL.
- Drain and give back all remaining URBs on vdev->priv_tx and
  vdev->priv_rx in vhci_device_unlink_cleanup() via
  vhci_cleanup_priv_list(), using list_first_entry() loops across lock
  drops.

Fixes: 258c81b341c8 ("usbip: give back URBs for unsent unlink requests during cleanup")
Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
Cc: stable@vger.kernel.org
Assisted-by: Gemini
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/usb/usbip/vhci_hcd.c | 115 ++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 7fadb41c01fc..78ea1fc7906e 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -727,8 +727,11 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	/* refuse enqueue for dead connection */
 	spin_lock(&vdev->ud.lock);
 	if (vdev->ud.status == VDEV_ST_NULL ||
-	    vdev->ud.status == VDEV_ST_ERROR) {
-		dev_err(dev, "enqueue for inactive port %d\n", vdev->rhport);
+	    vdev->ud.status == VDEV_ST_ERROR ||
+	    (vdev->ud.event & USBIP_EH_SHUTDOWN) ||
+	    !vdev->ud.tcp_socket) {
+		dev_err_ratelimited(dev, "enqueue for inactive port %d\n",
+				    vdev->rhport);
 		spin_unlock(&vdev->ud.lock);
 		spin_unlock_irqrestore(&vhci->lock, flags);
 		return -ENODEV;
@@ -982,18 +985,20 @@ static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
 	struct vhci *vhci = vhci_hcd->vhci;
-	struct vhci_unlink *unlink, *tmp;
+	struct vhci_unlink *unlink;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vhci->lock, flags);
 	spin_lock(&vdev->priv_lock);
 
-	list_for_each_entry_safe(unlink, tmp, unlink_list, list) {
+	while (!list_empty(unlink_list)) {
 		struct urb *urb;
 
+		unlink = list_first_entry(unlink_list, struct vhci_unlink, list);
+		list_del(&unlink->list);
+
 		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
 		if (!urb) {
-			list_del(&unlink->list);
 			kfree(unlink);
 			continue;
 		}
@@ -1002,8 +1007,6 @@ static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
 
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
-		list_del(&unlink->list);
-
 		spin_unlock(&vdev->priv_lock);
 		spin_unlock_irqrestore(&vhci->lock, flags);
 
@@ -1019,6 +1022,50 @@ static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
 	spin_unlock_irqrestore(&vhci->lock, flags);
 }
 
+/*
+ * Drain any remaining URBs still queued on priv_tx (e.g. enqueued before
+ * USBIP_EH_SHUTDOWN was set or after tcp_tx stopped) or waiting for a reply
+ * on priv_rx so no orphaned URBs remain after connection teardown.
+ */
+static void vhci_cleanup_priv_list(struct vhci_device *vdev,
+				   struct list_head *priv_list)
+{
+	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
+	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
+	struct vhci *vhci = vhci_hcd->vhci;
+	struct vhci_priv *priv;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vhci->lock, flags);
+	spin_lock(&vdev->priv_lock);
+
+	while (!list_empty(priv_list)) {
+		struct urb *urb;
+
+		priv = list_first_entry(priv_list, struct vhci_priv, list);
+		urb = priv->urb;
+
+		list_del(&priv->list);
+		kfree(priv);
+		urb->hcpriv = NULL;
+
+		urb->status = -ENODEV;
+
+		usb_hcd_unlink_urb_from_ep(hcd, urb);
+
+		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vhci->lock, flags);
+
+		usb_hcd_giveback_urb(hcd, urb, urb->status);
+
+		spin_lock_irqsave(&vhci->lock, flags);
+		spin_lock(&vdev->priv_lock);
+	}
+
+	spin_unlock(&vdev->priv_lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
+}
+
 static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 {
 	/* give back URB of unsent unlink request */
@@ -1026,17 +1073,26 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 
 	/* give back URB of unanswered unlink request */
 	vhci_cleanup_unlink_list(vdev, &vdev->unlink_rx);
+
+	/* give back remaining unsent and unanswered URBs */
+	vhci_cleanup_priv_list(vdev, &vdev->priv_tx);
+	vhci_cleanup_priv_list(vdev, &vdev->priv_rx);
 }
 
 /*
- * The important thing is that only one context begins cleanup.
- * This is why error handling and cleanup become simple.
- * We do not want to consider race condition as possible.
+ * Tear down an active virtual port connection. After stopping tcp_rx and
+ * tcp_tx, tcp_socket is cleared under vhci->lock and ud->lock so concurrent
+ * vhci_urb_enqueue() and vhci_urb_dequeue() calls are serialized before
+ * vhci_device_unlink_cleanup() drains all pending URBs.
  */
 static void vhci_shutdown_connection(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
-	struct usb_hcd *hcd = vhci_hcd_to_hcd(vdev_to_vhci_hcd(vdev));
+	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
+	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
+	struct vhci *vhci = vhci_hcd->vhci;
+	struct socket *socket;
+	unsigned long flags;
 
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
@@ -1056,34 +1112,25 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 	dev_info(hcd_dev(hcd), "stop threads\n");
 
 	/* active connection is closed */
-	if (vdev->ud.tcp_socket) {
-		sockfd_put(vdev->ud.tcp_socket);
-		vdev->ud.tcp_socket = NULL;
-		vdev->ud.sockfd = -1;
-	}
+	spin_lock_irqsave(&vhci->lock, flags);
+	spin_lock(&vdev->ud.lock);
+	socket = vdev->ud.tcp_socket;
+	vdev->ud.tcp_socket = NULL;
+	vdev->ud.sockfd = -1;
+	spin_unlock(&vdev->ud.lock);
+	spin_unlock_irqrestore(&vhci->lock, flags);
+
+	if (socket)
+		sockfd_put(socket);
 	dev_info(hcd_dev(hcd), "release socket\n");
 
 	vhci_device_unlink_cleanup(vdev);
 
 	/*
-	 * rh_port_disconnect() is a trigger of ...
-	 *   usb_disable_device():
-	 *	disable all the endpoints for a USB device.
-	 *   usb_disable_endpoint():
-	 *	disable endpoints. pending urbs are unlinked(dequeued).
-	 *
-	 * NOTE: After calling rh_port_disconnect(), the USB device drivers of a
-	 * detached device should release used urbs in a cleanup function (i.e.
-	 * xxx_disconnect()). Therefore, vhci_hcd does not need to release
-	 * pushed urbs and their private data in this function.
-	 *
-	 * NOTE: vhci_dequeue() must be considered carefully. When shutting down
-	 * a connection, vhci_shutdown_connection() expects vhci_dequeue()
-	 * gives back pushed urbs and frees their private data by request of
-	 * the cleanup function of a USB driver. When unlinking a urb with an
-	 * active connection, vhci_dequeue() does not give back the urb which
-	 * is actually given back by vhci_rx after receiving its return pdu.
-	 *
+	 * rh_port_disconnect() triggers asynchronous USB device disconnect on
+	 * usb_hub_wq (usb_disconnect() -> usb_disable_device()). All pending
+	 * URBs and unlink requests on vdev have already been unlinked and
+	 * given back synchronously by vhci_device_unlink_cleanup() above.
 	 */
 	rh_port_disconnect(vdev);
 
-- 
2.56.0.212.g129ede20d9-goog

