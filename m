Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781899;
	b=PcLEq8Ir2XZkdivxsf/2OIUFGi93vrKyx3TNCG/OgB3kIo/Fj57mVeyIfpXLsIEu7bKu
	 tuS8r2SUMAyi8/uwrRaR2zA/0RDtKn1HljTMaeIArCtoK2Wtds82Jrn2p4lKlVcyBKG+8
	 EEyFybeP8O1NNp9kguU6dnUTu9Jokv7p9aRiQa8iI5w9E9FoPpQC4zn+en3q/z54VFMbV
	 v5fZm7Wd3jdvocoj7e5xzq4N/Os0k2C91xCGG24R1QV7d63CJxx665K6Wq8rzalaKhWts
	 5EVodlXHpeSATtF2geEUglDbMLQuWKgevP2R62mcsjxCeQ2QQoD/q0V3l9ixCdMrM7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781899;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y+nXEJvDmQRLtktcGEUgDhO//MtKvpMfTKbfNHNXHjk=;
	b=w7czXaPijLKUe+um1+xtPIKA6wv7+flAqQq9vX0O+9mtl2zB+nUZRtdZa9AMafybYxwD
	 KzMkAevbnz6jkM4lalsIsd+FTykenpU3viedX61z7h2STasWXeuNOCuU4r5gkcqyDDXLg
	 oYsRSUZAdrPZOmhVGOKbZAZupByKiYzBLNbcAGiiP0DEf20CXW4T1UpOHwSXFD/KRS0uc
	 AOaBaL4LmGVnGLWAP1LCLZJVfOqMkz8cBB1JhvjglVjSTL3gEMnzUQStXIsW9NBAQHh5l
	 cy5jAaYMXzWzt2CAT9JmiZQcaqkeBnGZeiNmOzCUiPlMeR5jotzXSh8PV0hpeBgTOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VSNP6+y9;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A4606A323;
	Fri, 27 Nov 2026 12:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB3A4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VSNP6+y9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781899; x=1827317899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cfbjMCgIN9eiO/Mp80p1f5HnMA3+H/d+QPhHZlPq98=;
  b=VSNP6+y9p2Xt/2LdvxL2GIFcCyR6YNkAzOxS067oT2JiP9SLNGFQqC/9
   l/oWS7s4F5/qJpILRAAuIzfoXObNKkYgogoHVPE7E7UMs0ZBIFnDTStMY
   oS5EyM1kFB9Jz8FPbFQCMjbI8EHZGCZ/rkrUQOz575IhxD6soD/QLz8G5
   8d0MvL3iaTxq6n/oajD88ZTXoA+pemEAY+a8s8P/Nq/9gcOeLJRG6Au/O
   H95kAX0KtJCPuIWHEQrxT4j9TVaUn8LXj8u3sydzjrl8tTftn78p/Uvx6
   k9dM+5XTl9/iMX9/J6DM9zGALuxwd+bxVCCnz7DsnaIPsPFW/n0jPf2xs
   g==;
X-CSE-ConnectionGUID: 8HidCqIzRmiakmNP5jcaIw==
X-CSE-MsgGUID: n6c+bJRXTgSgHosUBPn9aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577866"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577866"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:19 -0800
X-CSE-ConnectionGUID: fpRjhjfUSuGJKdKnrzkcng==
X-CSE-MsgGUID: lQDVXupoSWS6JajxwdbNSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270675"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:17 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Akash M <akash.m5@samsung.com>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 06/10] xhci: sideband: check virt device under xhci lock when stopping endpoints
Date: Fri, 27 Nov 2026 14:17:51 +0200
Message-ID: <20261127121755.281420-7-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127121755.281420-1-mathias.nyman@linux.intel.com>
References: <20261127121755.281420-1-mathias.nyman@linux.intel.com>
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

Start work to protect sideband API functions against the xhci driver
freeing or reallocating the virt device (vdev) in the middle of an API
call.

Make the following sideband API calls hold xhci->lock while validating
the vdev and its endpoint, and while queueing the stop endpoint command:

xhci_sideband_unregister()
xhci_sideband_stop_endpoint()
xhci_sideband_remove_endpoint()

Locking changes are still needed in several xhci 'core' driver vdev free
paths before the above calls are fully serialized against vdev free.
Cases involve xHC reset in resume, enumeration retry, and reset-resume.

Move the stop endpoint code from xhci_stop_endpoint_sync() in xhci.c to
a new sideband_stop_endpoint_sync() helper in xhci-sideband.c.

xhci_stop_endpoint_sync() has no other users, so remove it.

Also take sb->mutex in xhci_sideband_stop_endpoint(), and keep holding
it in xhci_sideband_unregister() until the sideband is detached from the
vdev.

Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Cc: stable@vger.kernel.org
Reviewed-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Tested-by: Akash M <akash.m5@samsung.com>
Tested-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-sideband.c | 121 ++++++++++++++++++++++---------
 drivers/usb/host/xhci.c          |  55 --------------
 drivers/usb/host/xhci.h          |   2 -
 3 files changed, 87 insertions(+), 91 deletions(-)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index e4dd298b80f1..6f7712f95033 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -91,20 +91,78 @@ sideband_to_vdev(struct xhci_sideband *sb)
 	return NULL;
 }
 
-/* Caller must hold sb->mutex */
-static void
-__xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *ep)
+/*
+ * Synchronous xHCI stop endpoint helper. Issues a stop endpoint command and
+ * waits for the command completion before returning. This does not call
+ * xhci_handle_cmd_stop_ep(), which has additional handling for 'context error'
+ * cases, along with transfer ring cleanup.
+ *
+ * Caller must hold sb->mutex
+ */
+static int
+sideband_stop_endpoint_sync(struct xhci_sideband *sb, unsigned int ep_index,
+			    bool remove)
 {
+	struct xhci_virt_device *vdev;
+	struct xhci_command *cmd;
+	struct xhci_virt_ep *ep;
+	struct xhci_ep_ctx *ctx;
+	unsigned long flags;
+	int ret = -ENODEV;
+
 	lockdep_assert_held(&sb->mutex);
 
-	/*
-	 * Issue a stop endpoint command when an endpoint is removed.
-	 * The stop ep cmd handler will handle the ring cleanup.
-	 */
-	xhci_stop_endpoint_sync(sb->xhci, ep, 0, GFP_KERNEL);
+	cmd = xhci_alloc_command(sb->xhci, true, GFP_KERNEL);
+
+	spin_lock_irqsave(&sb->xhci->lock, flags);
+
+	vdev = sideband_to_vdev(sb);
+	ep = sb->eps[ep_index];
+
+	/* validate that xhci didn't reallocate vdev during reset or resume */
+	if (!vdev || !ep || ep->sideband != sb)
+		goto out_unlock;
+
+	if (remove) {
+		ep->sideband = NULL;
+		/* endpoint is removed, not running is not an error */
+		ret = 0;
+	}
+
+	if (!ep->ring)
+		goto out_unlock;
+
+	/* Stop the endpoint if it's running */
+	ctx = xhci_get_ep_ctx(sb->xhci, vdev->out_ctx, ep_index);
+	if (GET_EP_CTX_STATE(ctx) == EP_STATE_RUNNING) {
+		if (!cmd) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+		ret = xhci_queue_stop_endpoint(sb->xhci, cmd, vdev->slot_id,
+					       ep_index, 0);
+		if (ret)
+			goto out_unlock;
+
+		xhci_ring_cmd_db(sb->xhci);
+		spin_unlock_irqrestore(&sb->xhci->lock, flags);
+		wait_for_completion(cmd->completion);
+
+		if (cmd->status == COMP_COMMAND_ABORTED ||
+		    cmd->status == COMP_COMMAND_RING_STOPPED) {
+			xhci_warn(sb->xhci, "Timeout while waiting for stop endpoint command\n");
+			ret = -ETIME;
+		}
+		xhci_free_command(sb->xhci, cmd);
+		return ret;
+	}
 
-	ep->sideband = NULL;
-	sb->eps[ep->ep_index] = NULL;
+out_unlock:
+	spin_unlock_irqrestore(&sb->xhci->lock, flags);
+	if (cmd)
+		xhci_free_command(sb->xhci, cmd);
+
+	return ret;
 }
 
 /* Caller must hold sb->mutex */
@@ -212,21 +270,17 @@ int
 xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
 			      struct usb_host_endpoint *host_ep)
 {
-	struct xhci_virt_ep *ep;
 	unsigned int ep_index;
+	int ret;
 
 	guard(mutex)(&sb->mutex);
 
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
-	ep = sb->eps[ep_index];
 
-	if (!sideband_to_vdev(sb) || !ep || ep->sideband != sb) {
-		sb->eps[ep_index] = NULL;
-		return -ENODEV;
-	}
-	__xhci_sideband_remove_endpoint(sb, ep);
+	ret = sideband_stop_endpoint_sync(sb, ep_index, true);
+	sb->eps[ep_index] = NULL;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_remove_endpoint);
 
@@ -234,16 +288,13 @@ int
 xhci_sideband_stop_endpoint(struct xhci_sideband *sb,
 			    struct usb_host_endpoint *host_ep)
 {
-	struct xhci_virt_ep *ep;
 	unsigned int ep_index;
 
-	ep_index = xhci_get_endpoint_index(&host_ep->desc);
-	ep = sb->eps[ep_index];
+	guard(mutex)(&sb->mutex);
 
-	if (!sideband_to_vdev(sb) || !ep || ep->sideband != sb)
-		return -EINVAL;
+	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 
-	return xhci_stop_endpoint_sync(sb->xhci, ep, 0, GFP_KERNEL);
+	return sideband_stop_endpoint_sync(sb, ep_index, false);
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_stop_endpoint);
 
@@ -489,24 +540,26 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
 
 	xhci = sb->xhci;
 
-	scoped_guard(mutex, &sb->mutex) {
-		vdev = sideband_to_vdev(sb);
-
-		for (i = 0; i < EP_CTX_PER_DEV; i++)
-			if (vdev && sb->eps[i])
-				__xhci_sideband_remove_endpoint(sb, sb->eps[i]);
+	mutex_lock(&sb->mutex);
 
-		__xhci_sideband_remove_interrupter(sb);
-
-		sb->udev = NULL;
+	for (i = 0; i < EP_CTX_PER_DEV; i++) {
+		if (sb->eps[i]) {
+			sideband_stop_endpoint_sync(sb, i, true);
+			sb->eps[i] = NULL;
+		}
 	}
+	__xhci_sideband_remove_interrupter(sb);
 
 	spin_lock_irq(&xhci->lock);
-	sb->xhci = NULL;
+	vdev = sideband_to_vdev(sb);
 	if (vdev)
 		vdev->sideband = NULL;
+	sb->udev = NULL;
+	sb->xhci = NULL;
 	spin_unlock_irq(&xhci->lock);
 
+	mutex_unlock(&sb->mutex);
+
 	kfree(sb);
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_unregister);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index d55c8b7058ce..fa6f8b879a18 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -2895,61 +2895,6 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
 	return -ENOMEM;
 }
 
-/*
- * Synchronous XHCI stop endpoint helper.  Issues the stop endpoint command and
- * waits for the command completion before returning.  This does not call
- * xhci_handle_cmd_stop_ep(), which has additional handling for 'context error'
- * cases, along with transfer ring cleanup.
- *
- * xhci_stop_endpoint_sync() is intended to be utilized by clients that manage
- * their own transfer ring, such as offload situations.
- */
-int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep, int suspend,
-			    gfp_t gfp_flags)
-{
-	struct xhci_command *command;
-	struct xhci_ep_ctx *ep_ctx;
-	unsigned long flags;
-	int ret = -ENODEV;
-
-	command = xhci_alloc_command(xhci, true, gfp_flags);
-	if (!command)
-		return -ENOMEM;
-
-	spin_lock_irqsave(&xhci->lock, flags);
-
-	/* make sure endpoint exists and is running before stopping it */
-	if (ep->ring) {
-		ep_ctx = xhci_get_ep_ctx(xhci, ep->vdev->out_ctx, ep->ep_index);
-		if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_RUNNING)
-			ret = xhci_queue_stop_endpoint(xhci, command,
-						       ep->vdev->slot_id,
-						       ep->ep_index, suspend);
-	}
-
-	if (ret < 0) {
-		spin_unlock_irqrestore(&xhci->lock, flags);
-		goto out;
-	}
-
-	xhci_ring_cmd_db(xhci);
-	spin_unlock_irqrestore(&xhci->lock, flags);
-
-	wait_for_completion(command->completion);
-
-	/* No handling for COMP_CONTEXT_STATE_ERROR done at command completion*/
-	if (command->status == COMP_COMMAND_ABORTED ||
-	    command->status == COMP_COMMAND_RING_STOPPED) {
-		xhci_warn(xhci, "Timeout while waiting for stop endpoint command\n");
-		ret = -ETIME;
-	}
-out:
-	xhci_free_command(xhci, command);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(xhci_stop_endpoint_sync);
-
 /*
  * xhci_usb_endpoint_maxp - get endpoint max packet size
  * @host_ep: USB host endpoint to be checked
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ec4bfeb4887c..6201b6b24252 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1963,8 +1963,6 @@ void xhci_cleanup_command_queue(struct xhci_hcd *xhci);
 void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring);
 unsigned int count_trbs(u64 addr, u64 len);
 unsigned int xhci_num_trbs_free(struct xhci_ring *ring);
-int xhci_stop_endpoint_sync(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
-			    int suspend, gfp_t gfp_flags);
 void xhci_process_cancelled_tds(struct xhci_hcd *xhci, struct xhci_virt_ep *ep);
 void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 			      struct xhci_interrupter *ir,
-- 
2.43.0

