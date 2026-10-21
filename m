Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595296;
	b=rQoYrxsR8pJudDfy7cEr7hKIIclIUlyyF2OU6xJPyPXCq8YeOrlKIR6RA0FYZQ0sTWTp
	 96yptiKm+Lyl2+JN7XmBE+18WE2T2/vAAunMlV+wBpfIjZaTzE9i81llXg/2s8rlUYF2s
	 WlMHfqFmjYIP7xc4h8laI4GL4A396DkWl9mFR3GtLBmv9zg4UhIMnyHPeUpn0nTZANoDN
	 mN5O7iAgP5imi8Im6Pvb17j0rsjy8eQrJbMa/irKRxbTbdxjtMa2hYgUb1bJuM92D8lma
	 RoXkCJ49bdOTDEnBVgIG/YTsxMWgAxbzp3I5eC5UWIIUPM2jY6nB5i4BIJ1//LUZnlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NWFTTPgr6a+7/Xni+URiPpkEFmXv3aUFnA25E/9kZnA=;
	b=FH6r3G3wUW4qjjcVEyCKvpuryG2TyUmSVvI40ZcRi1G5u4R3jD02gcg7gXKl/HYKfOKb
	 V8CxC9g+iloDJCjPn4CeLfv0+IQJ+iLS2YiwbdUSlouzjBC2eISNA6v5JZ9eFa39GNWxj
	 jcxgXAeLVOvSk5eH6DevWIeKxSdN8/XQbeEiPyDhtvqzMrAcz7fbuJWKctaD9atHe9GMv
	 MGQv4VgxzYg1lEnao2jbbkawN1Z4870HiR4Ug8MdfktTFGca/e0Jx5OTxZhWGeFAnsQEF
	 04QU7N6R/WvsJ9PhE7Jt8cOpmG1X3nxqcnt8ix2plmMa9M3CP8rAxXdDa24e2nC2kSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="VRw9ap/L";
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D89606A32E
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D89606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VRw9ap/L
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53a448f86e0so440717b6e.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792595294; x=1793200094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NWFTTPgr6a+7/Xni+URiPpkEFmXv3aUFnA25E/9kZnA=;
        b=VRw9ap/L2nzXSpfuVECaED5SiGKzFhRhiTN8tirM7SB1f0HWTYkpdgSAZPsJlITzBP
         s5TLr1myTR7vjGhRCcE7JrsVe4tZF0dOpUW8R0e9Aru3+qD7fNZsaj6G4A5Ne2e8Rv5+
         9D5qhSNtI5e5t8o1S8GmlkNuYZ+4S1SNUDSAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595294; x=1793200094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NWFTTPgr6a+7/Xni+URiPpkEFmXv3aUFnA25E/9kZnA=;
        b=bSviBxFzOVdeFdFrigtZd72c3pJCGpH42iT8/YGd+/8tVHL+ADH0ezUUB5IKBAhQ18
         gyj2Y8lO/QETkXbp9hCqxDCsgL8j8qNWQKuWDoYPJLXWyKRF9gyxutraFxVZkx1R+kNk
         U38ryelz/U/VESUvVK396vCxS+ohSsaVSYqEloZWmX6/3LngcQujmhmiOP/r/ECFVXit
         KZLIrnk3lxXrOGGYHOQ4KqfZI1GcQTPIoj7umwe4ldU2UOUyTcu+lEzhRMwXo18Mj6oY
         nh1vcPGFT4DmiJBa6jJ48Pdt5OwL4BTq+R1dnkX/5bn2ezQilEtgoXi6MksATOPtnF9v
         unEg==
X-Forwarded-Encrypted: i=1; AKwUvBx9hHqZg1+B8WN8bn1uGkf7T/YazfB2Ut1IdhOCMrnFXmWSygUZQTP63pQPuGCuugOwqGDg5C4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLds7cq+3B+4w4Kvb/rOzcw/k3VVSqdU0MAeqPB8VEaZsIyd1y6
	AUUy77kfL7e3xBkYzOVbspzxfkLxuW94ugzXoDfqoVHFQbvIi7pFjLcVFAwGtym7+w==
X-Gm-Gg: AYBFou02L5h4YBVLNlc/iK/7e6y/9w0M/1Zr+1JpOdvY2n/dCmy/AaYOgGfGCjuekNC
	+1YLfLRfY9VJfyiI7isNCHILAabWrqz0+yAgJb476LBnfqBOJLpST1FuZfROaLqCI1+ONs6b8q/
	j3Br+JMXfIUlcAlh6oMWo9RE5yfsvldyZ6Ylyg2/fLNG8JKu/M3EkxxLk567hd3yxtuHZv7/SLz
	vgHr5WSlTaDoEOoIgq1CXYozHG9N7XHONP29/S77Ar9KAfipkpc8w/tanZFxmOztiv4Ej4UIpYG
	vfqQlIl4uTF6FWrVRHDHgBRx2JXZFBcC/V5JH3OLbofBJ9gM3zdro4SJyzrp+40oz/1T9DpNr0+
	X4T1sgEGZs1AD5RNGibggyfS0LtzkcEFsg664mSiPh4t8Fv5aby3xImD4eOyHdaQrniFIvLetjx
	n9LQElPlk/jrzpLS7eemHtY+ZTw32aWmPihuBtUIdXVR4eWaEBNl/ci6GVIeGyW98dDNkGz+IR6
	9dVXVsWrewcbV4zMhOAqhNlnBzl7bYpuUyigGzNI709khCRDmvbgAGlp7BSSlQz6KXux1QxPNAH
	X1nShqCSAOa9xBXdlL83kFa1H0EBpyLIIJKtUaL2zF1A
X-Received: by 2002:a05:6808:1715:b0:4bb:ac05:9ebf with SMTP id 5614622812f47-5535d4e12bemr1568864b6e.14.1792595294486;
        Wed, 21 Oct 2026 08:08:14 -0700 (PDT)
Received: from rrangel.c.googlers.com.com (202.168.136.34.bc.googleusercontent.com. [34.136.168.202])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b400bd39sm2023922b6e.6.2026.10.21.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:08:13 -0700 (PDT)
From: Raul E Rangel <rrangel@chromium.org>
To: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hongren Zheng <i@zenithal.me>,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Raul E Rangel <rrangel@chromium.org>,
	stable@vger.kernel.org,
	Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH 4/6] usbip: vhci_hcd: clear URB_DMA_MAP_SG on all giveback paths
Date: Wed, 21 Oct 2026 09:06:59 -0600
Message-ID: <20261021150704.3129446-5-rrangel@chromium.org>
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

In vhci_send_cmd_submit(), URB_DMA_MAP_SG is set on urb->transfer_flags
when urb->num_sgs is non-zero so that setup_cmd_submit_pdu() packs
USBIP_URB_DMA_MAP_SG into the wire PDU, even though vhci_hcd never maps
the scatterlist with dma_map_sg().

Currently, only vhci_recv_ret_submit() clears URB_DMA_MAP_SG before
calling usb_hcd_giveback_urb(). If an URB with scatter-gather entries
is instead given back via vhci_recv_ret_unlink(),
vhci_cleanup_unlink_list(), vhci_cleanup_priv_list(), or
vhci_urb_dequeue(), __usb_hcd_giveback_urb() invokes
usb_hcd_unmap_urb_for_dma(), which sees URB_DMA_MAP_SG and calls
dma_unmap_sg() on an unmapped scatterlist.

Move the URB_DMA_MAP_SG clearing from vhci_recv_ret_submit() into
pickup_urb_and_free_priv() (covering vhci_recv_ret_submit(),
vhci_recv_ret_unlink(), and vhci_cleanup_unlink_list()), and also clear
URB_DMA_MAP_SG in vhci_urb_dequeue() and vhci_cleanup_priv_list() so all
URB giveback paths clear the flag.

Fixes: ea44d190764b ("usbip: Implement SG support to vhci-hcd and stub driver")
Cc: stable@vger.kernel.org
Assisted-by: Gemini
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/usb/usbip/vhci_hcd.c | 6 ++++++
 drivers/usb/usbip/vhci_rx.c  | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 78ea1fc7906e..522cbaa6eb0a 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -934,6 +934,9 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	 * CMD_UNLINK is needed.
 	 */
 	if (!vdev->ud.tcp_socket || !priv->submitted) {
+		if (urb->num_sgs)
+			urb->transfer_flags &= ~URB_DMA_MAP_SG;
+
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -1045,6 +1048,9 @@ static void vhci_cleanup_priv_list(struct vhci_device *vdev,
 		priv = list_first_entry(priv_list, struct vhci_priv, list);
 		urb = priv->urb;
 
+		if (urb->num_sgs)
+			urb->transfer_flags &= ~URB_DMA_MAP_SG;
+
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index a678e7c89837..7e69e4b1bace 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -42,6 +42,9 @@ struct urb *pickup_urb_and_free_priv(struct vhci_device *vdev, __u32 seqnum)
 				 seqnum, status);
 		}
 
+		if (urb->num_sgs)
+			urb->transfer_flags &= ~URB_DMA_MAP_SG;
+
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv = NULL;
@@ -95,9 +98,6 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
 
-	if (urb->num_sgs)
-		urb->transfer_flags &= ~URB_DMA_MAP_SG;
-
 	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
 
 	spin_lock_irqsave(&vhci->lock, flags);
-- 
2.56.0.212.g129ede20d9-goog

