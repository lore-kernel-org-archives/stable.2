Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781897;
	b=qO90o5WLtr1aJ+QBSdIRgMtShl2wg4AFIV0DQJRiFHvQJrnWjR+SdvWj1iEMrt34tBdW
	 LwoNyH/jJoCrf9vQUWtLUsohmU02Q3cIYCxgzRH++rjdgSaw/fDAAC9vnaHseIlguGH7O
	 jfJMSXmU/vusqQofYKF/41GmZVvT/HMzp4xz7rSEUNlQU643Z3wWzfC/vnRoi4RwSbUis
	 eon+XuTycEWpFn6qz1vJU4Q3TAPzKo4WcFs2oG+UxeQIANH0SaT1QBztw3C7qfG4t34lK
	 hXRzE9KPOub2FXn/ehhSMX6egKfqujrMfuaAdYXrUWnMhkz4JcVMwCrcOlqAHkmO3sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781897;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=alv73PHzPjN9R3BPRvgraPXzUWUfh3yAulrNmW02BYk=;
	b=nMHwBJemfOHbIIv8TT6Uajtzk3fgjLcEgQQtT9xZ2CbDXyc3a6M8GB6uwK4nJaU5y6pL
	 ZafGR1j2QIYJH2hEpAEpejz085VcKwWyKHhbxFDK0mG7gT6kes052R7U7dM46chDMJUJZ
	 oRJnBx0NYmHE6uVN29zVjTIYjx/R4QZofu0I8lZq+2sv+B33B1L93NDINwbkO26XUJmqq
	 fYALIBUzek/DUpNzO5gvt7RPK/5RfmWfusy344Zh2IWmTtDqKT+oJUTH0ZRgtptFAqOt2
	 4cFoVcjsLbOTBefn5+v/z6VMC8prtdPxOkQFtckZYMTfhDh9mhdY6IaN3WyEBVBy2WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=esrUDLXf;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC793606A321;
	Fri, 27 Nov 2026 12:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC793606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=esrUDLXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781897; x=1827317897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=11tSxlTA21afnWKAE+S1nGedqV7jD0IkMOCLDV7PBRY=;
  b=esrUDLXfvqeo6VmGORQgkiXYm74mCanEfOPAswwSQBCPpEIuKRULT5aS
   YE1ZZwaxUVWih4lGcN9GgJzZjMBnhH/pspAlzEVFcTOyNZm6HqvqsbPi2
   cxCCMqNd5KXtMDEvqx2ZDFNm5Xnjta6vA6rKr29UqkGEV7zA6vZtDjwPU
   QHlAmahd9qYpjqRX2MkVibjkRUZvyYK+uCJGPnzfJuYotXNQxDb9XrkkT
   SgZCPl25Rl9DSeL6y+iIGZ2PXFfVdUqXFCoP/E3ufmXGX6MV2hK1vzMWW
   zmXOYBWhlxHYx8vjJXTv53n/tNmhKDkBZbW/ugTbPSJpXbaLjDqUCd3iM
   w==;
X-CSE-ConnectionGUID: 7ZSXERsqSgSax7A5YWNU1A==
X-CSE-MsgGUID: gL0uXp8TTK2eBIRztidr+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577860"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:17 -0800
X-CSE-ConnectionGUID: Pkawds7sR/aCOB8G9EAbHw==
X-CSE-MsgGUID: rOdVeQs7SCOcggrosSLqyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270674"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:15 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Akash M <akash.m5@samsung.com>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 05/10] xhci: sideband: avoid use-after-free of stale virt device pointer
Date: Fri, 27 Nov 2026 14:17:50 +0200
Message-ID: <20261127121755.281420-6-mathias.nyman@linux.intel.com>
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

The sideband structure caches vdev, an xhci_virt_device pointer that
the xhci driver may free and reallocate while the sideband is still
registered, leaving the sideband with a dangling sb->vdev pointer.

This can happen during resume, either when the xhci driver detects xHC
power loss and resets the xHC, freeing all virt devices without
informing class drivers, or during reset-resume when usb core
re-enumerates the device and xhci frees and allocates a new virt device.

Store the usb_device pointer (udev) instead. It stays valid across
reset-resume and xHC reset.
Look up the current virt device and ensure it still points to this
sideband before using and dereferencing it in sideband API calls.

Make sure xhci_sideband_unregister() works properly when called with
an invalid vdev. Don't dereference it, or ask the xHC to stop non-existing
endpoints, but make sure the sideband is properly freed.
Fail other relevant sideband API calls that would access an invalid
vdev.

This solution isn't airtight. It only validates vdev when entering
sideband API functions. It does not serialize the sideband API
functions against the code in the xhci driver that reallocates vdev,
so vdev may still be freed in the middle of a sideband call. It's still
a big improvement and a first step in resolving this.

The following patch starts working on the serialization.

Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Cc: stable@vger.kernel.org
Reviewed-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Tested-by: Akash M <akash.m5@samsung.com>
Tested-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-sideband.c  | 46 +++++++++++++++++++++----------
 include/linux/usb/xhci-sideband.h |  4 +--
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index a5deeee4d5dc..e4dd298b80f1 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -75,6 +75,22 @@ xhci_ring_to_sgtable(struct xhci_sideband *sb, struct xhci_ring *ring)
 	return NULL;
 }
 
+/* Return the current vdev of sb->udev, or NULL if it was freed or reallocated */
+static struct xhci_virt_device *
+sideband_to_vdev(struct xhci_sideband *sb)
+{
+	struct xhci_virt_device *vdev;
+
+	if (!sb->udev || !sb->udev->slot_id)
+		return NULL;
+
+	vdev = sb->xhci->devs[sb->udev->slot_id];
+	if (vdev && vdev->sideband == sb)
+		return vdev;
+
+	return NULL;
+}
+
 /* Caller must hold sb->mutex */
 static void
 __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *ep)
@@ -146,16 +162,18 @@ int
 xhci_sideband_add_endpoint(struct xhci_sideband *sb,
 			   struct usb_host_endpoint *host_ep)
 {
+	struct xhci_virt_device *vdev;
 	struct xhci_virt_ep *ep;
 	unsigned int ep_index;
 
 	guard(mutex)(&sb->mutex);
 
-	if (!sb->vdev)
+	vdev = sideband_to_vdev(sb);
+	if (!vdev)
 		return -ENODEV;
 
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
-	ep = &sb->vdev->eps[ep_index];
+	ep = &vdev->eps[ep_index];
 
 	if (ep->ep_state & EP_HAS_STREAMS)
 		return -EINVAL;
@@ -202,9 +220,10 @@ xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 	ep = sb->eps[ep_index];
 
-	if (!ep || !ep->sideband || ep->sideband != sb)
+	if (!sideband_to_vdev(sb) || !ep || ep->sideband != sb) {
+		sb->eps[ep_index] = NULL;
 		return -ENODEV;
-
+	}
 	__xhci_sideband_remove_endpoint(sb, ep);
 
 	return 0;
@@ -221,7 +240,7 @@ xhci_sideband_stop_endpoint(struct xhci_sideband *sb,
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 	ep = sb->eps[ep_index];
 
-	if (!ep || !ep->sideband || ep->sideband != sb)
+	if (!sideband_to_vdev(sb) || !ep || ep->sideband != sb)
 		return -EINVAL;
 
 	return xhci_stop_endpoint_sync(sb->xhci, ep, 0, GFP_KERNEL);
@@ -251,7 +270,7 @@ xhci_sideband_get_endpoint_buffer(struct xhci_sideband *sb,
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 	ep = sb->eps[ep_index];
 
-	if (!ep || !ep->ring || !ep->sideband || ep->sideband != sb)
+	if (!sideband_to_vdev(sb) || !ep || !ep->ring || ep->sideband != sb)
 		return NULL;
 
 	return xhci_ring_to_sgtable(sb, ep->ring);
@@ -329,7 +348,7 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 
 	guard(mutex)(&sb->mutex);
 
-	if (!sb->vdev)
+	if (!sideband_to_vdev(sb))
 		return -ENODEV;
 
 	if (sb->ir)
@@ -436,7 +455,7 @@ xhci_sideband_register(struct usb_interface *intf, enum xhci_sideband_type type,
 	}
 
 	sb->xhci = xhci;
-	sb->vdev = vdev;
+	sb->udev = udev;
 	sb->intf = intf;
 	sb->type = type;
 	sb->notify_client = notify_client;
@@ -471,22 +490,21 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
 	xhci = sb->xhci;
 
 	scoped_guard(mutex, &sb->mutex) {
-		vdev = sb->vdev;
-		if (!vdev)
-			return;
+		vdev = sideband_to_vdev(sb);
 
 		for (i = 0; i < EP_CTX_PER_DEV; i++)
-			if (sb->eps[i])
+			if (vdev && sb->eps[i])
 				__xhci_sideband_remove_endpoint(sb, sb->eps[i]);
 
 		__xhci_sideband_remove_interrupter(sb);
 
-		sb->vdev = NULL;
+		sb->udev = NULL;
 	}
 
 	spin_lock_irq(&xhci->lock);
 	sb->xhci = NULL;
-	vdev->sideband = NULL;
+	if (vdev)
+		vdev->sideband = NULL;
 	spin_unlock_irq(&xhci->lock);
 
 	kfree(sb);
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
index 005257085dcb..2d153cb57831 100644
--- a/include/linux/usb/xhci-sideband.h
+++ b/include/linux/usb/xhci-sideband.h
@@ -39,7 +39,7 @@ struct xhci_sideband_event {
 /**
  * struct xhci_sideband - representation of a sideband accessed usb device.
  * @xhci: The xhci host controller the usb device is connected to
- * @vdev: the usb device accessed via sideband
+ * @udev: the usb device accessed via sideband
  * @eps: array of endpoints controlled via sideband
  * @ir: event handling and buffer for sideband accessed device
  * @type: xHCI sideband type
@@ -51,7 +51,7 @@ struct xhci_sideband_event {
  */
 struct xhci_sideband {
 	struct xhci_hcd                 *xhci;
-	struct xhci_virt_device         *vdev;
+	struct usb_device		*udev;
 	struct xhci_virt_ep             *eps[EP_CTX_PER_DEV];
 	struct xhci_interrupter         *ir;
 	enum xhci_sideband_type		type;
-- 
2.43.0

