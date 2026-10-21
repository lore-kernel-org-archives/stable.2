Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595293;
	b=1eAiLG02CZPeVg+EzgQ4ovqtuhPfjgYLUI3F01joerZJnt/h4W2BtK/gY/viRF5kRL21
	 HsE1hXcCmNmkBYpXE/5wIrDS5A8YOtGAiIIrJKi/eeTq0rj4OQazM+/EJlsnAOXQotder
	 BYbq8zlPLfVrApIv+IlN8NTA9iRcW/OHJQSI3OtmqQDXmB7DMDlWSGnssHXa6h5GCOlFz
	 Ijs3LFkZ2Y9GYXEkBe92tTvWCc/pCiYUXUiFW0mbHeTmmSn85hC2mLAoIrx1wgh9Yz22b
	 JJ+cqavNoPxYPLYX3Y6HyA0nOs/YZoigP7yRRGHkUlreT2ugSxoFgA16UTHlYAk/l9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8YHSxufeVVJ2VZoAF4/++z3L4gnMTb7J7dwMMqwcWA8=;
	b=nnnK1auGWxtaqvrvtSjRwkp6mwPCqhRtKxiANKa/hzEV/xo1OW2Mewr7F8rrvBDEVOgk
	 +B0UpgPljIgFgveqRy/02aTmTc6bvwhP/5uv+SzRxEcTT6KTlyXT3OfaMpXe1529YBiQK
	 WhwKLseoPkhC5OBzjN589Zb7diryBODzdsQT6lwsafuu4Ac0ZZGoo6TLyadpLGkiZ1ubq
	 9uPpktbdbsLQ+6y73r6ZJnyYZBHda57ZVs9A8NbhltzmospYsIcLLVcvKm/jeNz8/09mN
	 YYePj27S62aM1KWl6t6+FgFL8laHckR7Lh3JqpvXFGZjrbXfpj6H3pOQrw+TJmMFMCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XrGj+8cs;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54AC60A260E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A54AC60A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XrGj+8cs
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8198a3a54d7so1746893a34.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792595291; x=1793200091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8YHSxufeVVJ2VZoAF4/++z3L4gnMTb7J7dwMMqwcWA8=;
        b=XrGj+8csPaNTSeBqXQ046oZQPOTW7l+lwAvdn0gYkTa9Zh/pDDlA0C33O7StpRRY6t
         u3dhbKWDIY8M1i99LCEGQ60aa1M0pOJRMUxOwqlFDiaALeYKqTzFSTq2JFvRmVJ3Mi7Q
         aUIb3cz5zfMJzWMPHH6t2tyXgFQYjCP6G/aU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595291; x=1793200091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8YHSxufeVVJ2VZoAF4/++z3L4gnMTb7J7dwMMqwcWA8=;
        b=0tPQjAQuBBDipypV2aTjsbLb1VBDttDcTRAKapRHXhQw425rQ+7r3aiS6flkl+Sx2G
         9rBpv6t3GToHkDrw53m03sIZpy5TDvTnZNgGzH8y0CNt235g9F80f7JGWEht81iEaDW4
         P1+dkWs297oQdwLlfZAlt5fWznuuFP7xIam0LsYu8qilVNLH39tQwaJTe5X8fObxcFEW
         iYv0N48PgUQ5O2sjFRSj7WNYay+yv1dju4PCu6PmgWpazq8+sjmBezvumVjBI34yjMG5
         bqB1vn98IR3q/qPGuaqNF/XRwiAN0UsV9zIFAGnmFjI9NjK0EuEWF8ymozn1bI/Rir6+
         AypQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1uzTBHfHV0WaiBSZvTmBmJ7g+1p52PTuk/ZK8K6SKap6PLck4/Ze4M70fPHSOT/umulRppUg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNd3TrZYGqSLtyJWt0WS586Sr++0OrGgmPshqKAls6uIm8qhCW
	CFD8vQVFhMRbKj/lVLi7XjjLgt6Z9zoVDokZx0tIatu/13qoXa1pndK30EeoAggv1g==
X-Gm-Gg: AYBFou3ghlfLO0ocIoOob6YoIYdDFspqFmqWHTDdo3qC1YNNvcAW+1y0YUGlD7RTX6H
	YZYxcgBMvPKr3twNwYs6yMYWt7bMlYifUoJbcxP2pWjg9UIE93n91zV0FmaOtGBIejK0EaCHs6b
	KN4YuNHrH/2iIZdJMTp4zkEHMzWMAPyHK4AUVZVi3dznXtFZz5X171/kx0+nKZXFw+AxNxUqs+U
	HLANKrKfLvIRgLx8dkZNR97+UQeOOc7AM19mF+yX9aPXXtFH7axoHmlEbq8slxQuhgRg7aP9K5N
	6jKTo0TITuJKbxq8XXXll0i4ZThR4CGYFQrjmYNnRwEjBWE/aXRV8v2Upc7aFVP7yvvVdpqaLD+
	XGZQZg4YBdzGVhFUiP6tGZp6uAYWTMOTynze/slZJwkZpQ3jM03I5g5ykZr8Rvfy3gxKV5qjJM6
	LqVibgHwQpzNdmLwxL2CaHDLx8gtrVb+BHa+ZSf8UI+mRB9Q41Lvu+m74Q/EgLYk2rhl1WrgV7M
	mRRad/fow//Fu963/dN9HYwAROhEkl6P40dnwFR/JRHsdryf4FEuwRPVldM022kKA4FWkYZiDnE
	eEwT00YLK+CiMLn/n9XN86A9H3xvnEIZjurK/rUn4v0w
X-Received: by 2002:a05:6808:6614:b0:544:9281:a3a9 with SMTP id 5614622812f47-5535626991amr1261042b6e.19.1792595291615;
        Wed, 21 Oct 2026 08:08:11 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b400bd39sm2023922b6e.6.2026.10.21.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:08:10 -0700 (PDT)
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
Subject: [PATCH 2/6] usbip: vhci_hcd: complete unsent URBs locally in vhci_urb_dequeue()
Date: Wed, 21 Oct 2026 09:06:57 -0600
Message-ID: <20261021150704.3129446-3-rrangel@chromium.org>
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

When an URB is enqueued via vhci_urb_enqueue(), its vhci_priv entry is
placed on vdev->priv_tx until vhci_tx_loop() moves it to vdev->priv_rx
in dequeue_from_priv_tx() and sends USBIP_CMD_SUBMIT.

If vhci_urb_dequeue() is called while the URB is still on vdev->priv_tx
and vdev->ud.tcp_socket is non-NULL, vhci_urb_dequeue() currently sets
urb->unlinked and queues a vhci_unlink entry on vdev->unlink_tx without
removing the URB from vdev->priv_tx. This causes two bugs:

1. If vhci_tx_loop() has already exited after an earlier send error or
   been stopped during connection shutdown before tcp_socket is cleared,
   the URB remains on vdev->priv_tx. When vhci_device_unlink_cleanup()
   later runs pickup_urb_and_free_priv(), which only searches
   vdev->priv_rx, the vhci_unlink entry is freed while the URB remains
   linked on ep->urb_list with urb->unlinked set. Subsequent calls to
   vhci_urb_dequeue() from usb_hcd_flush_endpoint() fail with -EBUSY at
   usb_hcd_check_unlink_urb(), leaking the URB giveback and hanging
   usb_kill_urb() in D state forever. (Stopping new enqueues on shutdown
   and draining non-unlinked URBs are addressed in the next patch.)

2. On an active connection, if an URB is enqueued and immediately
   dequeued while vhci_tx_loop() is in vhci_send_cmd_unlink(),
   USBIP_CMD_UNLINK can be transmitted before USBIP_CMD_SUBMIT for the
   same seqnum. The server replies USBIP_RET_UNLINK for the unknown
   seqnum while vhci_tx_loop() is concurrently building or sending
   USBIP_CMD_SUBMIT, racing on urb->hcpriv or leaving an orphaned
   USBIP_RET_SUBMIT that tears down the connection with
   VDEV_EVENT_ERROR_TCP.

Record whether an URB has been dequeued from vdev->priv_tx into
vdev->priv_rx via priv->submitted under vdev->priv_lock, and complete
unsent (!priv->submitted) URBs locally in vhci_urb_dequeue() without
queuing a CMD_UNLINK request. Because vhci_tx_loop() drains
vdev->priv_tx in vhci_send_cmd_submit() before entering
vhci_send_cmd_unlink(), any URB with priv->submitted set is guaranteed
to have its CMD_SUBMIT sent before its CMD_UNLINK.

Fixes: 258c81b341c8 ("usbip: give back URBs for unsent unlink requests during cleanup")
Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
Cc: stable@vger.kernel.org
Assisted-by: Gemini
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/usb/usbip/vhci.h     |  1 +
 drivers/usb/usbip/vhci_hcd.c | 14 ++++++--------
 drivers/usb/usbip/vhci_tx.c  |  1 +
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
index 5659dce1526e..4a62f89b89c7 100644
--- a/drivers/usb/usbip/vhci.h
+++ b/drivers/usb/usbip/vhci.h
@@ -55,6 +55,7 @@ struct vhci_priv {
 
 	struct vhci_device *vdev;
 	struct urb *urb;
+	bool submitted;
 };
 
 struct vhci_unlink {
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 3196ea80e7c2..7fadb41c01fc 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -925,20 +925,18 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		return ret;
 	}
 
-	 /* send unlink request here? */
-	if (!vdev->ud.tcp_socket) {
-		/* tcp connection is closed */
+	/*
+	 * Give back the URB locally if the TCP connection is closed or the URB
+	 * is still on priv_tx (not yet picked up by vhci_tx_loop), so no
+	 * CMD_UNLINK is needed.
+	 */
+	if (!vdev->ud.tcp_socket || !priv->submitted) {
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
 
 		spin_unlock(&vdev->priv_lock);
 
-		/*
-		 * If tcp connection is alive, we have sent CMD_UNLINK.
-		 * vhci_rx will receive RET_UNLINK and give back the URB.
-		 * Otherwise, we give back it here.
-		 */
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
 
 		spin_unlock_irqrestore(&vhci->lock, flags);
diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index 32e6fabccf72..997db6cfa382 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -40,6 +40,7 @@ static struct vhci_priv *dequeue_from_priv_tx(struct vhci_device *vdev)
 
 	list_for_each_entry_safe(priv, tmp, &vdev->priv_tx, list) {
 		list_move_tail(&priv->list, &vdev->priv_rx);
+		priv->submitted = true;
 		spin_unlock_irqrestore(&vdev->priv_lock, flags);
 		return priv;
 	}
-- 
2.56.0.212.g129ede20d9-goog

