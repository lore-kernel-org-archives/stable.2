Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B62D1907;
	Fri,  3 Jul 2026 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089652; cv=none; b=V0eMfZbI2XXfutI/zAFQE9AQVUQMgyLRZQHl0hDevAixjUI7X48HN/dEGwy7M7YXk9Mwmw1bPoaqWpiXCJeWcLBqVPgbx/s5cZuoy1L1k7VKCez/5e1eetfgl7ea4XDqsxB0XVu3djSkQxJeetPk1VpaXOpCF4sm9gBfJnZnV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089652; c=relaxed/simple;
	bh=Xt7iwaN9giBkTYqozXTifVqHbcD9rYw/AGaOQHCnANw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdZYer1Lsgc0pvDzMHZVMfCUd0D46HlOIKN5KBKkavP26RPl1W5PA1mNbvlJNjhGgKlJ4vNUrRVhcUs8y2WBgmsGsuEOg4XZdRleEzVLtvAfCxxrnIq1jIakUfnG1g5mBVJXszVVeN7+rqaFCrEe3QmeSd7ayDXTuHiHHYbh/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRwmyLb4; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRwmyLb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783089649; x=1814625649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xt7iwaN9giBkTYqozXTifVqHbcD9rYw/AGaOQHCnANw=;
  b=FRwmyLb4rGuyot435o5bG6XCcCgmNElJR1O3ZcSiuvfDMpQ0+QqcxAQ7
   Et9c118HSHhk1aOki0JgKmhW//fxRQsYzz70wjZq7s2YqASGpXgK6nNMN
   yFFW66tED2/DNeAjslAjBtQ3v3oocAYqA786Ko3fV+qQYtJau7u6abY6m
   9b0V0NHpaaBoeqVT1WeRAVrIlcji1dDrncrj5J9oZKYD6u+U226zvK0da
   CiOxNPlBfik38MesnJB65MUDEZagYA9IvzNOiqpwyXQoqQB0TALZWZUYL
   Ql+cNMi0sZTZxPiLcOLUjuHVxbGBxzjn9gFNCMKj5RCJxGxtPLeWuqvwb
   g==;
X-CSE-ConnectionGUID: k6X51gXbRj+5N8U5QryaDQ==
X-CSE-MsgGUID: XCM52f43QjK93VPL9STsDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="101388363"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="101388363"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 07:40:48 -0700
X-CSE-ConnectionGUID: ewbP/Hv5QVeqbVxRWbcP9g==
X-CSE-MsgGUID: YomxnCEcRbSCC/0I+QL1oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="252662617"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.154])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 07:40:47 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	=?UTF-8?q?=E8=83=A1=E8=BF=9E=E5=8B=A4?= <hulianqin@vivo.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/2] usb: xhci: Fix sleep in atomic context in xhci_free_streams()
Date: Fri,  3 Jul 2026 17:40:33 +0300
Message-ID: <20260703144033.483286-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703144033.483286-1-mathias.nyman@linux.intel.com>
References: <20260703144033.483286-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 胡连勤 <hulianqin@vivo.com>

When a USB device with active stream endpoints is disconnected,
xhci_free_streams() is called from the hub_event workqueue to
free the stream resources.  It calls xhci_free_stream_info()
while holding xhci->lock with irqs disabled.

xhci_free_stream_info() invokes xhci_free_stream_ctx(), which
calls dma_free_coherent() for large stream context arrays.

dma_free_coherent() can sleep (e.g. via vunmap), triggering
a BUG when called from atomic context.

Call trace:
 dma_free_attrs+0x174/0x220
 xhci_free_stream_info+0xd0/0x11c
 xhci_free_streams+0x278/0x37c
 usb_free_streams+0x98/0xc0
 usb_unbind_interface+0x1b8/0x2f8
 device_release_driver_internal+0x1d4/0x2cc
 device_release_driver+0x18/0x28
 bus_remove_device+0x160/0x1a4
 device_del+0x1ec/0x350
 usb_disable_device+0x98/0x214
 usb_disconnect+0xf0/0x35c
 hub_event+0xab4/0x19ec
 process_one_work+0x278/0x63c

Fix this by saving the stream_info pointers and clearing the
ep references under the lock, then calling xhci_free_stream_info()
outside the lock where sleeping is allowed.

Fixes: 8df75f42f8e6 ("USB: xhci: Add memory allocation for USB3 bulk streams.")
Cc: stable@vger.kernel.org
Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6922cc5496c1..f44ccee5fa07 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3785,6 +3785,7 @@ static int xhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	struct xhci_virt_device *vdev;
 	struct xhci_command *command;
 	struct xhci_input_control_ctx *ctrl_ctx;
+	struct xhci_stream_info *stream_info[EP_CTX_PER_DEV];
 	unsigned int ep_index;
 	unsigned long flags;
 	u32 changed_ep_bitmask;
@@ -3845,10 +3846,15 @@ static int xhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * dma_free_coherent() called by xhci_free_stream_info() may sleep,
+	 * so save stream_info pointers and clear references under lock,
+	 * then free the memory outside lock.
+	 */
 	spin_lock_irqsave(&xhci->lock, flags);
 	for (i = 0; i < num_eps; i++) {
 		ep_index = xhci_get_endpoint_index(&eps[i]->desc);
-		xhci_free_stream_info(xhci, vdev->eps[ep_index].stream_info);
+		stream_info[i] = vdev->eps[ep_index].stream_info;
 		vdev->eps[ep_index].stream_info = NULL;
 		/* FIXME Unset maxPstreams in endpoint context and
 		 * update deq ptr to point to normal string ring.
@@ -3858,6 +3864,9 @@ static int xhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
+	for (i = 0; i < num_eps; i++)
+		xhci_free_stream_info(xhci, stream_info[i]);
+
 	return 0;
 }
 
-- 
2.43.0

