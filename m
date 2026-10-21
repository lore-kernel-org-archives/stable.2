Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595297;
	b=nl7e3yu++OFKwM/sXSk7DRdgAB9LvlZREazDCnf2/kfvjumOCq0AZPOFICr/2N2SDYSO
	 RtXAbpuJ+JcSoxaR6a6XK0UeAStT7RGemq/X3WZH/XSE9+22OQbDBsA1uZtrG5flo2rqn
	 jSmQthDHU45FsiEg9oouUMCDbflJl93WtVE8Tpx+I8aMhmiXvF3Oev1/lVb4rwaZg0udg
	 toG8Gj5zOpBI2cxqBdwVf+d1XYv+Sb+dmsBXgBiUSwuqIv017c+r4bae16ix6bHLiPSWB
	 Wasds4+S68e8UFFCIHay5xo2Ra53HIvNkWjYdKUkhJYVxOGPcYJumoQxXW5kqpX/1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nX+gP2drifdU2o+OF+ySLEpKlcNDTqHvU5zt6uKwARU=;
	b=Ww3UbFYqv89U5FGqaSl6U+0eumwNJwaEVAGtTnNsR6azz+CkQ4maafaj/lkvuPbTWuou
	 ufl+d3JwMErHaOi1tzrEtB/sF0hkLKqPVRnQN8HNI/pNG3UsEo31ipOYs+6WcwPS/TWwU
	 /SQKYdixA/lHfOib4hO2SuO3ix5suKKq9pdEXVPFGGrmCM1lh2UR0ijAJTx9FDXYhbgMP
	 O5hCGt6wxlCKznCaGC88n0YD60m20qP7DcHJvu7OaTRMinUzjRuvtbzV9pOThv3JH0Nbd
	 zFB9P818xkKfgR7bqSMMsaUUH33y8QggRXel22lc8ofSCJdvZh6aiUQ8S6vmfn+wltA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oVC2S4B7;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF6606A33F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BF6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oVC2S4B7
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b28d7c729fso427180b6e.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792595296; x=1793200096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nX+gP2drifdU2o+OF+ySLEpKlcNDTqHvU5zt6uKwARU=;
        b=oVC2S4B7NFJNQTrSito4yJfEumKFdCgmaWTW1R8xRymEe+S9WdzW5tinIY4IOobWb5
         NQxBC4YgeLe2VNjzyzR+jYDQN+hf0aOFqnAL5RroVOYue/nVYJXrCremCd9qZD8Af0M3
         p1iWgRi6XHyNYyirbChTYVvH3G5LthAyLYQng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595296; x=1793200096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nX+gP2drifdU2o+OF+ySLEpKlcNDTqHvU5zt6uKwARU=;
        b=Lu+vbbPALetAFjWhso+tZdZ4JwQORf8CdCszblsKCiua5VeOBzvj6SnGLWzv2OdOR7
         H0FbPnMf7tLVQYdoVKCSK+977mysf6f1d6BjtA8WAM2YN5IW7ggr3MVWT7VgYB20QUli
         TC66I5coily56jD/LB4mW2SUOKqViuOPF7wXGtZv6Z1zkTloNJ0RamE0mRml5tSgQEaD
         5KSvWIm4STOegtutVBXUc60Tf8WWfdeJS/r5UXH5C4ILdahMFe8OA/lwJGrstoMqpAAT
         QpTFSh+VXhi8yfs5Jk1gcfhwok65YjCHUxMNSkegAsp2K3x5v3nzTA9V4f7mL99lmke2
         nXgg==
X-Forwarded-Encrypted: i=1; AKwUvBy9AgMi5R130ZrBBOEnPnVsqCaeyo8SJhtpWgebZ2+vMcAceKlzJzWW9m72iey6q/eaHtr/aho=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYMTxnEgcBTBm13fMDsOx1cwVHGvCBC4rR0gjBlJm9NO2+1xXb
	CNbZ6UVMweLRiClyYfeP7qMyXrrwibN36ru8K9fzxHMzYanCq+V+uZ/xAcb9epgYBw==
X-Gm-Gg: AYBFou23YhtlJsjCrpMVOWP2LTb3F6ay/g57IlIuYcd37lUib+LI4HCz4PNtTAJ3TZ9
	Mcv9PGyZhVyw/kY26QuQkjc+rJmhveU6WvA5Tx/c+kDL5wvK3OcpeV8I7vhI2od79YjIMAzMYcU
	cPqO0/7t8NYDb5jGQ0W8nc6GO8SteS1T2ZkVjZdRjAWx4TfEcOaYGWpQ/b2uEFYFcO0jLV0Elkr
	fEAkHnjTbGMecd1tUCFKaZaTxSBFZnfKhaU8VV9O5PBKT1TuqnTitd2RYJYVac8IFEIDMKy7kyz
	ctPfzK0vAG9qYsD9gJaeaR9v+b567kdE6jfDBTdztDYqmQqI/xWhosaOClkvvWvKMn1C6LU3J/w
	WvNMFK3nAIe20A2ls5mtnhlL0LRB4D2we+4+Hkf5DO+0V8X1QWzCqCqNopjtzuUvqZnqs3Tlfc/
	xuYkOqls1RnaMfGjGUU3crHx4wlUAlpvuzBexyR27pfnqDgaTakRn1XYISVBA+muZPNQWD2tVXf
	aLxuVtJCXujQz6uhPNFIbwPHQ8ihUPiOx9uyvHeKbs+636LaIeZ/wzg+qOIbQHU3O1wHpM5BdCV
	tbthdG22MqYxh6US2G2kLgCKLbeFf7/F4z70Izsrdwje
X-Received: by 2002:a05:6808:148e:b0:4ea:5e0e:7dab with SMTP id 5614622812f47-5535818f4edmr1498560b6e.37.1792595295749;
        Wed, 21 Oct 2026 08:08:15 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b400bd39sm2023922b6e.6.2026.10.21.08.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:08:15 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hongren Zheng <i@zenithal.me>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Raul E Rangel <rrangel@chromium.org>,
	stable@vger.kernel.org,
	"Brian G. Merrell" <bgmerrell@novell.com>
Subject: [PATCH 5/6] usbip: vhci_hcd: allocate vhci_priv outside lock and handle ENOMEM
Date: Wed, 21 Oct 2026 09:07:00 -0600
Message-ID: <20261021150704.3129446-6-rrangel@chromium.org>
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

In vhci_urb_enqueue(), usb_hcd_link_urb_to_ep() links the URB onto the
endpoint before calling vhci_tx_urb(), which allocates struct vhci_priv
with GFP_ATOMIC while holding vhci->lock. If that allocation fails,
vhci_tx_urb() triggers VDEV_EVENT_ERROR_MALLOC and returns while
vhci_urb_enqueue() still returns 0, leaving urb->hcpriv NULL and the URB
linked on ep->urb_list where vhci_urb_dequeue() rejects it with -EIDRM.
Moreover, failing a single URB submission should return -ENOMEM to the
caller rather than tearing down the entire USB/IP connection.

Allocate struct vhci_priv in vhci_urb_enqueue() using the caller's
mem_flags before acquiring vhci->lock, pass it to vhci_tx_urb(), and
free it on early-exit and non-transmit paths.

In vhci_urb_dequeue(), if allocating struct vhci_unlink fails after
usb_hcd_check_unlink_urb() has already marked urb->unlinked, return 0
after triggering VDEV_EVENT_ERROR_MALLOC so callers know the unlink was
accepted and connection teardown will drain priv_rx and give back the
URB.

Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
Cc: stable@vger.kernel.org
Assisted-by: Gemini
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/usb/usbip/vhci_hcd.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 522cbaa6eb0a..27dba51392b7 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -665,18 +665,12 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	return retval;
 }
 
-static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev)
+static void vhci_tx_urb(struct urb *urb, struct vhci_device *vdev,
+			struct vhci_priv *priv)
 {
-	struct vhci_priv *priv;
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	unsigned long flags;
 
-	priv = kzalloc_obj(struct vhci_priv, GFP_ATOMIC);
-	if (!priv) {
-		usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
-		return;
-	}
-
 	spin_lock_irqsave(&vdev->priv_lock, flags);
 
 	priv->seqnum = (u32)atomic_inc_return(&vhci_hcd->seqnum);
@@ -702,6 +696,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	u8 portnum = urb->dev->portnum;
 	int ret = 0;
 	struct vhci_device *vdev;
+	struct vhci_priv *priv;
 	unsigned long flags;
 
 	if (!portnum || portnum > VHCI_HC_PORTS) {
@@ -716,11 +711,16 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		return -EINVAL;
 	}
 
+	priv = kzalloc_obj(struct vhci_priv, mem_flags);
+	if (!priv)
+		return -ENOMEM;
+
 	spin_lock_irqsave(&vhci->lock, flags);
 
 	if (urb->status != -EINPROGRESS) {
 		dev_err(dev, "URB already unlinked!, status %d\n", urb->status);
 		spin_unlock_irqrestore(&vhci->lock, flags);
+		kfree(priv);
 		return urb->status;
 	}
 
@@ -734,6 +734,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 				    vdev->rhport);
 		spin_unlock(&vdev->ud.lock);
 		spin_unlock_irqrestore(&vhci->lock, flags);
+		kfree(priv);
 		return -ENODEV;
 	}
 	spin_unlock(&vdev->ud.lock);
@@ -829,7 +830,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	}
 
 out:
-	vhci_tx_urb(urb, vdev);
+	vhci_tx_urb(urb, vdev, priv);
 	spin_unlock_irqrestore(&vhci->lock, flags);
 
 	return 0;
@@ -837,6 +838,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 no_need_xmit:
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
 no_need_unlink:
+	kfree(priv);
 	if (!ret) {
 		/* usb_hcd_giveback_urb() should be called with
 		 * irqs disabled
@@ -956,10 +958,18 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		/* setup CMD_UNLINK pdu */
 		unlink = kzalloc_obj(struct vhci_unlink, GFP_ATOMIC);
 		if (!unlink) {
+			/*
+			 * Leave urb->unlinked set and return 0 so callers know
+			 * the unlink was accepted and usb_hcd_flush_endpoint()
+			 * does not busy-spin retrying unlink1(); the shutdown
+			 * triggered below (assuming usbip_event_add() can
+			 * allocate its event node) will drain priv_rx and give
+			 * back the URB.
+			 */
 			spin_unlock(&vdev->priv_lock);
 			spin_unlock_irqrestore(&vhci->lock, flags);
 			usbip_event_add(&vdev->ud, VDEV_EVENT_ERROR_MALLOC);
-			return -ENOMEM;
+			return 0;
 		}
 
 		unlink->seqnum = atomic_inc_return(&vhci_hcd->seqnum);
-- 
2.56.0.212.g129ede20d9-goog

