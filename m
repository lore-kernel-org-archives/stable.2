Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E4E468C20
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150347; cv=none; b=KXbfuhv92S85vnL6bOqs9+HAwjY0nxhSLfdDopZex145DsR7+iqPe354+Z/FegLsWUlTFijZgqLqYPt+1NcvxIjslYuSJFTKgEPM7qmSwhIX/lnyzIdo8yNZvvxvEjtrMoYCDDJSci33jVVpHVZ3dfP1qnr+CZ+7bQ0jA85g+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150347; c=relaxed/simple;
	bh=GmCJYBbWM9KTGcJMPFVpHEJ+KrcM1iWznhbvX6v4yTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=reqGrNybcJ2kycVhLFmihPx9awduVBaOLSjO+bWWg/lrqhnhu77sS1DxhJ9QhG+3kyLdU3n9qToJDa5w2zkkvVNE+pILGbtnZQS3gxxGSRkVVgBdxftcluy1b4e3HoaiGCIWCBrrwgRmoB1i7ND6WEsFpCoAqMFqC7JEbm0r2Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANp1OX13; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANp1OX13"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86fa6b15ed3so811347b3a.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790150345; x=1790755145; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2pogbJ2sP8D91YksgSoEJ19QAvzZA3gwl/UMe/2M9Yc=;
        b=ANp1OX131OuG4/xqPReKOkwcPaiFy/KlYs4hBnWVE4ckN7zqrSyJhsACge+OiQDErI
         ByWOj5hg7guHU8g8yl4j+VoRt+FHKx46bxdLVxBOZygz/so5BkOse/myTBZEBe34ts7n
         1FXzrOj//+uDBL9pCeXWqCkzdNqHVU5aXykMS6vL9QhEQPoumImGpoddCqoA5qBecimo
         nPjV+i6r+aSGMn1kS9AagxY86VMmFg8BqSEvPgm5W+zt9ko+YTHUXkbUXrYhHk4rfwR4
         7eLTNBB6QJ/iE4F/bbzLUpkmDTX60uCck1Pe5QMOb0EZZGwoZfoIq2YYmgbpnAZPuIyn
         eeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790150345; x=1790755145;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2pogbJ2sP8D91YksgSoEJ19QAvzZA3gwl/UMe/2M9Yc=;
        b=hZi/rkyTnmdhqjm2H2ez5ImoMPS6T4WzLAU8Vf0Fxy1RC++pI+bQiDvbTLsEnnkg7Q
         dM17rN6PBRcAhtc77EBaU1yY+cNwmeQP5E6MoFBTyMwS7IoxJTphCcj3bQKAfeEIX6pY
         yL0actqXaZi7HVbHmWFPTDPLmOwB6rCAal8GyAq5RTcB5VhMPkSAb0sT2f5CTQpWmsBU
         CFdFmLSe6P+g6g/rBgqs/NKaZDSrrLUU1O40Y5GWit3W/jCInDaskHg5UhKbM0Z4AcEg
         Yq2/eIF2X+3LHt2oLKGUlqeci1geshs+fUt+nwZXgsI8WFwXkKcpTHqhIFAkUM4BMDJa
         LaOA==
X-Forwarded-Encrypted: i=1; AKwUvBx5ZUfXXcOCj/r5wg7JCdIXumHMPjctF+pWBv3u+0Fp8oLNa6EA99o6Bxv5qX0SgA3DcwhVviU=@vger.kernel.org
X-Gm-Message-State: AFuF++mkY2/lb0fEqeYdbSFRF2i+bVM5DTk59XArKXfMQK6Rt2Q1c6zr
	cJEANxuI66JYm89PYlQhpxDL63m4TryHyPFsrxL2zeoUX5FbnxhI5zqXKT4BXlxtJ1xUhhF0wSt
	lf44d/w==
X-Received: from pfbhu13.prod.google.com ([2002:a05:6a00:698d:b0:87d:7af8:2ad7])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1595:b0:87d:f8af:894a
 with SMTP id d2e1a72fcca58-87df8af8d85mr63628b3a.31.1790150344827; Wed, 23
 Sep 2026 00:59:04 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:58:35 +0800
In-Reply-To: <20260923-u-ether-gadget-npe-v1-0-ff466c55ecc0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923-u-ether-gadget-npe-v1-0-ff466c55ecc0@google.com>
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790150340; l=9602;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=GmCJYBbWM9KTGcJMPFVpHEJ+KrcM1iWznhbvX6v4yTE=; b=dJo718usBI56j7e1tPMtzTP1hr1SfyhUInLRP161ez993PBC+l4Y6hASGID/oxkwD/FWcxDoR
 qPpRknKkjI0DJ1QduYfiyYxxvFZ2k4mQ9vlyl0aCaokSOVI12wNzXhq
X-Mailer: b4 0.14.3
Message-ID: <20260923-u-ether-gadget-npe-v1-1-ff466c55ecc0@google.com>
Subject: [PATCH 1/2] usb: gadget: u_ether: Fix NULL pointer deref in debug logging
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Faqiang Zhu <faqiang.zhu@nxp.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Commit ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with
device_move") and its counterparts reparent the net_device to
/sys/devices/virtual during unbind and clear dev->gadget. However, the
DBG(), VDBG(), ERROR(), and INFO() macros from <linux/usb/composite.h>
dereference &dev->gadget->dev.

When dynamic debug or CONFIG_USB_GADGET_DEBUG is enabled, any logging on
the surviving net_device after unbind causes a NULL pointer dereference,
such as in eth_stop() during function instance teardown:

  Unable to handle kernel NULL pointer dereference
  Call trace:
   dev_driver_string from __dynamic_dev_dbg+0x8c/0x118
   __dynamic_dev_dbg from eth_stop+0x70/0x134 [u_ether]
   ...
   unregister_netdev from gether_cleanup+0x14/0x28 [u_ether]
   gether_cleanup [u_ether] from rndis_free_inst+0x2c/0x48 [usb_f_rndis]

Replace the composite.h logging macros in u_ether.c with the standard
netdev_*() helpers. Because dev->net remains valid for the entire
lifetime of struct eth_dev and netdev_printk() natively handles
unparented network devices, messages are logged safely both when
attached and when detached from the gadget.

Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Closes: https://lore.kernel.org/all/89e19e6e-7ee7-4bb0-abd6-60971b7fd601@gmail.com/
Fixes: ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with device_move")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/u_ether.c | 61 +++++++++++++++++------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 59d85d6a84a8..043b4ec80808 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -135,9 +135,9 @@ static void defer_kevent(struct eth_dev *dev, int flag)
 	if (test_and_set_bit(flag, &dev->todo))
 		return;
 	if (!schedule_work(&dev->work))
-		ERROR(dev, "kevent %d may have been dropped\n", flag);
+		netdev_err(dev->net, "kevent %d may have been dropped\n", flag);
 	else
-		DBG(dev, "kevent %d scheduled\n", flag);
+		netdev_dbg(dev->net, "kevent %d scheduled\n", flag);
 }
 
 static void rx_complete(struct usb_ep *ep, struct usb_request *req);
@@ -190,7 +190,7 @@ rx_submit(struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
 
 	skb = __netdev_alloc_skb(dev->net, size + NET_IP_ALIGN, gfp_flags);
 	if (skb == NULL) {
-		DBG(dev, "no rx skb\n");
+		netdev_dbg(dev->net, "no rx skb\n");
 		goto enomem;
 	}
 
@@ -211,7 +211,7 @@ rx_submit(struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
 enomem:
 		defer_kevent(dev, WORK_RX_MEMORY);
 	if (retval) {
-		DBG(dev, "rx submit --> %d\n", retval);
+		netdev_dbg(dev->net, "rx submit --> %d\n", retval);
 		if (skb)
 			dev_kfree_skb_any(skb);
 		spin_lock_irqsave(&dev->req_lock, flags);
@@ -258,7 +258,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 					|| skb2->len > GETHER_MAX_ETH_FRAME_LEN) {
 				dev->net->stats.rx_errors++;
 				dev->net->stats.rx_length_errors++;
-				DBG(dev, "rx length %d\n", skb2->len);
+				netdev_dbg(dev->net, "rx length %d\n", skb2->len);
 				dev_kfree_skb_any(skb2);
 				goto next_frame;
 			}
@@ -278,12 +278,12 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 	/* software-driven interface shutdown */
 	case -ECONNRESET:		/* unlink */
 	case -ESHUTDOWN:		/* disconnect etc */
-		VDBG(dev, "rx shutdown, code %d\n", status);
+		netdev_vdbg(dev->net, "rx shutdown, code %d\n", status);
 		goto quiesce;
 
 	/* for hardware automagic (such as pxa) */
 	case -ECONNABORTED:		/* endpoint reset */
-		DBG(dev, "rx %s reset\n", ep->name);
+		netdev_dbg(dev->net, "rx %s reset\n", ep->name);
 		defer_kevent(dev, WORK_RX_MEMORY);
 quiesce:
 		dev_kfree_skb_any(skb);
@@ -296,7 +296,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 
 	default:
 		dev->net->stats.rx_errors++;
-		DBG(dev, "rx status %d\n", status);
+		netdev_dbg(dev->net, "rx status %d\n", status);
 		break;
 	}
 
@@ -365,7 +365,7 @@ static int alloc_requests(struct eth_dev *dev, struct gether *link, unsigned n)
 		goto fail;
 	goto done;
 fail:
-	DBG(dev, "can't alloc requests\n");
+	netdev_dbg(dev->net, "can't alloc requests\n");
 done:
 	spin_unlock(&dev->req_lock);
 	return status;
@@ -403,7 +403,7 @@ static void eth_work(struct work_struct *work)
 	}
 
 	if (dev->todo)
-		DBG(dev, "work done, flags = 0x%lx\n", dev->todo);
+		netdev_dbg(dev->net, "work done, flags = 0x%lx\n", dev->todo);
 }
 
 static void tx_complete(struct usb_ep *ep, struct usb_request *req)
@@ -414,7 +414,7 @@ static void tx_complete(struct usb_ep *ep, struct usb_request *req)
 	switch (req->status) {
 	default:
 		dev->net->stats.tx_errors++;
-		VDBG(dev, "tx err %d\n", req->status);
+		netdev_vdbg(dev->net, "tx err %d\n", req->status);
 		fallthrough;
 	case -ECONNRESET:		/* unlink */
 	case -ESHUTDOWN:		/* disconnect etc */
@@ -475,7 +475,7 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 	}
 
 	if (dev->port_usb && dev->port_usb->is_suspend) {
-		DBG(dev, "Port suspended. Triggering wakeup\n");
+		netdev_dbg(dev->net, "Port suspended. Triggering wakeup\n");
 		netif_stop_queue(net);
 		spin_unlock_irqrestore(&dev->lock, flags);
 		ether_wakeup_host(dev->port_usb);
@@ -579,7 +579,7 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 	retval = usb_ep_queue(in, req, GFP_ATOMIC);
 	switch (retval) {
 	default:
-		DBG(dev, "tx queue err %d\n", retval);
+		netdev_dbg(dev->net, "tx queue err %d\n", retval);
 		break;
 	case 0:
 		netif_trans_update(net);
@@ -604,7 +604,7 @@ static netdev_tx_t eth_start_xmit(struct sk_buff *skb,
 
 static void eth_start(struct eth_dev *dev, gfp_t gfp_flags)
 {
-	DBG(dev, "%s\n", __func__);
+	netdev_dbg(dev->net, "%s\n", __func__);
 
 	/* fill the rx queue */
 	rx_fill(dev, gfp_flags);
@@ -619,7 +619,7 @@ static int eth_open(struct net_device *net)
 	struct eth_dev	*dev = netdev_priv(net);
 	struct gether	*link;
 
-	DBG(dev, "%s\n", __func__);
+	netdev_dbg(dev->net, "%s\n", __func__);
 	if (netif_carrier_ok(dev->net))
 		eth_start(dev, GFP_KERNEL);
 
@@ -637,13 +637,12 @@ static int eth_stop(struct net_device *net)
 	struct eth_dev	*dev = netdev_priv(net);
 	unsigned long	flags;
 
-	VDBG(dev, "%s\n", __func__);
+	netdev_vdbg(dev->net, "%s\n", __func__);
 	netif_stop_queue(net);
 
-	DBG(dev, "stop stats: rx/tx %ld/%ld, errs %ld/%ld\n",
-		dev->net->stats.rx_packets, dev->net->stats.tx_packets,
-		dev->net->stats.rx_errors, dev->net->stats.tx_errors
-		);
+	netdev_dbg(dev->net, "stop stats: rx/tx %ld/%ld, errs %ld/%ld\n",
+		   dev->net->stats.rx_packets, dev->net->stats.tx_packets,
+		   dev->net->stats.rx_errors, dev->net->stats.tx_errors);
 
 	/* ensure there are no more active requests */
 	spin_lock_irqsave(&dev->lock, flags);
@@ -669,7 +668,7 @@ static int eth_stop(struct net_device *net)
 		usb_ep_disable(link->in_ep);
 		usb_ep_disable(link->out_ep);
 		if (netif_carrier_ok(net)) {
-			DBG(dev, "host still using in/out endpoints\n");
+			netdev_dbg(dev->net, "host still using in/out endpoints\n");
 			link->in_ep->desc = in;
 			link->out_ep->desc = out;
 			usb_ep_enable(link->in_ep);
@@ -799,8 +798,8 @@ struct eth_dev *gether_setup_name(struct usb_gadget *g,
 		free_netdev(net);
 		dev = ERR_PTR(status);
 	} else {
-		INFO(dev, "MAC %pM\n", net->dev_addr);
-		INFO(dev, "HOST MAC %pM\n", dev->host_mac);
+		netdev_info(net, "MAC %pM\n", net->dev_addr);
+		netdev_info(net, "HOST MAC %pM\n", dev->host_mac);
 
 		/*
 		 * two kinds of host-initiated state changes:
@@ -875,8 +874,8 @@ int gether_register_netdev(struct net_device *net)
 		dev_dbg(&g->dev, "register_netdev failed, %d\n", status);
 		return status;
 	} else {
-		INFO(dev, "HOST MAC %pM\n", dev->host_mac);
-		INFO(dev, "MAC %pM\n", dev->dev_mac);
+		netdev_info(net, "HOST MAC %pM\n", dev->host_mac);
+		netdev_info(net, "MAC %pM\n", dev->dev_mac);
 
 		/* two kinds of host-initiated state changes:
 		 *  - iff DATA transfer is active, carrier is "on"
@@ -1147,16 +1146,16 @@ struct net_device *gether_connect(struct gether *link)
 	link->in_ep->driver_data = dev;
 	result = usb_ep_enable(link->in_ep);
 	if (result != 0) {
-		DBG(dev, "enable %s --> %d\n",
-			link->in_ep->name, result);
+		netdev_dbg(dev->net, "enable %s --> %d\n",
+			   link->in_ep->name, result);
 		goto fail0;
 	}
 
 	link->out_ep->driver_data = dev;
 	result = usb_ep_enable(link->out_ep);
 	if (result != 0) {
-		DBG(dev, "enable %s --> %d\n",
-			link->out_ep->name, result);
+		netdev_dbg(dev->net, "enable %s --> %d\n",
+			   link->out_ep->name, result);
 		goto fail1;
 	}
 
@@ -1167,7 +1166,7 @@ struct net_device *gether_connect(struct gether *link)
 	if (result == 0) {
 		dev->zlp = link->is_zlp_ok;
 		dev->no_skb_reserve = gadget_avoids_skb_reserve(dev->gadget);
-		DBG(dev, "qlen %d\n", qlen(dev->gadget, dev->qmult));
+		netdev_dbg(dev->net, "qlen %d\n", qlen(dev->gadget, dev->qmult));
 
 		dev->header_len = link->header_len;
 		dev->unwrap = link->unwrap;
@@ -1223,7 +1222,7 @@ void gether_disconnect(struct gether *link)
 	if (!dev)
 		return;
 
-	DBG(dev, "%s\n", __func__);
+	netdev_dbg(dev->net, "%s\n", __func__);
 
 	spin_lock(&dev->lock);
 	dev->port_usb = NULL;

-- 
2.55.0.1082.g2b9226bbc0-goog

