Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781906;
	b=J77VeZo37654EozJK9f9aFw4g2Byp/EpAi+y/EECN4eqx1I86m0DrT62g2uNVxaEADUV
	 5udpvY4CocWDDpS38a5CWNXwI6ITz58nd7zbvIMyOE6frRMtKsMp1nOABThpsfnceggoK
	 TKOVgS9PvTtrV+dV5cNqdyfn2byfE0kjrwxkYdvuTouyfnQzEROc9/FwGmyIpx/VkYyeo
	 co16d7+Hg670tReX7SoHDrNn69IBGiSHA8dasLqHYABRsFtwxfUQfxLqU5nLYDXbVTY8C
	 RwzKfQ31WKP3fxyOc4licHHmRScYTY3/1MOJyPmqytFS+Wrm/ZqsNndYpvV/0QOMtbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781906;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sqNEdtGk4hs/ZWDqsWosb23vxAOl654KOZRACdDrMEw=;
	b=k0mcVexqsmL0kjEx71mdDX/dd1WiKO47os8nd6mEbIE3rxuoI8yPUQDq9795EMRhaBhT
	 /CKJS4CqTWSySlACKMs01XD6FeegnPavJivA+Ucd3m37hDr3V+ga16QzXIFGruTAM8H9o
	 FqcAegURx6LXHG6IUHX5YmNR76DcPIsND+23FvVQeO9UdbdkIX03n5GEYWVDC0QoRsWtY
	 worbczWU+XJpKGxPA8iXScAQzZMxBz8RLKZvvQsnDGI03PCi2x8Q26E254VadAzPrC/9J
	 7yAg1y2Z8HLYA5qy8ZrHgBKcVHSdnAy+MMCu03gh1Y3GcRnT1GeaC8X8wPRPlCMBklA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1p89U9Z;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FB606A32E;
	Fri, 27 Nov 2026 12:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E0FB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K1p89U9Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781906; x=1827317906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUdslEdpzDLGIn4P+1J5p2YaN/A3zS7nJsir0enBc44=;
  b=K1p89U9ZEvfYjIUjZmC8IgaSi+bh16glyLZyw4eli1AnTnHDkyH2zc4o
   M5mKfl9CvaoHhmr6RyPekz0TsntAdrN2f1/9galStYXVN/7p/iWgWq8i0
   aBivHVvNUz3R1RwdsZ/fPLXP0Kue5mTzoCFMeKFck9KBle8DmZ8BPfYPi
   hSEpe5AoTJkh/aCSPwwZdhpsATh8Ku6dLEdNC/2f0vNLLoqTrvrmq9E2f
   OMVEwXqP/gMGe7/wAl3greZgKJuQH3KOAL5VlQUvThQJ8w/Qd4zn60fvN
   HyIVEARmb6ZQOR7kuV3+gB4FNBau9C6DTcSgrnMSLNiEZc+1SDgCbdWyk
   Q==;
X-CSE-ConnectionGUID: QAw9WkKEQfCoeFF/hbdJKg==
X-CSE-MsgGUID: SgcR5UJJSH+4MK2x7H5XNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577889"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577889"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:26 -0800
X-CSE-ConnectionGUID: ElTXBUZqRtCpoJySaqB7vA==
X-CSE-MsgGUID: mFsv6I08To2tHemaU9sA/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270687"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:25 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Olli Salenius <opsalenius@gmail.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 10/10] xhci: fix NULL pointer dereference of rhub_port in xhci_urb_enqueue()
Date: Fri, 27 Nov 2026 14:17:55 +0200
Message-ID: <20261127121755.281420-11-mathias.nyman@linux.intel.com>
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

xhci_urb_enqueue() checks vdev->rhub_port->link_inactive before queueing
a URB, but rhub_port is only set in xhci_setup_addressable_virt_dev()
when the device is enabled or addressed.

If the virt device is freed and reallocated for an existing usb device,
the new virt device has no rhub_port until usb core enables or addresses
the device again. This happens for example when the xHC is reset during
resume, and xhci_discover_or_reset_device() reallocates the virt device
during reset-resume.

usb core does not send URBs to the device in this window, but a driver
that keeps submitting I/O across system suspend does. This was reported
with hid-steelseries-arctis, whose status polling work sends a control
request during reset-resume after the xHC failed to restore its state:

 BUG: kernel NULL pointer dereference, address: 0000000000000020
 Workqueue: events steelseries_status_timer_work_handler [hid_steelseries_arctis]
 RIP: 0010:xhci_urb_enqueue+0x1c8/0x350
 Call Trace:
  usb_hcd_submit_urb+0x91/0x190
  usb_start_wait_urb+0x8f/0x1d0
  usb_control_msg+0xdd/0x150
  usbhid_raw_request+0x11e/0x140
  steelseries_arctis_9_request_status+0x63/0xb0 [hid_steelseries_arctis]

Refuse to queue URBs to a device that has no root hub port yet. This
also ensures no TDs are queued for a device without rhub_port, which the
transfer event and halted endpoint handling code dereference as well.

Reported-by: Olli Salenius <opsalenius@gmail.com>
Closes: https://lore.kernel.org/all/CACQx0bG4bvt4bHa+WG4u2UGmUc_YMUnhpWovz5+rzp76Jpb9ZA@mail.gmail.com/
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Fixes: e3d757dc9257 ("xhci: include all root port children in recovery prevention on link error")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fa6f8b879a18..7f0d34c465f8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1631,6 +1631,7 @@ static int xhci_check_ep0_maxpacket(struct xhci_hcd *xhci, struct xhci_virt_devi
 static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flags)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct xhci_virt_device *vdev;
 	unsigned long flags;
 	int ret = 0;
 	unsigned int slot_id, ep_index;
@@ -1683,9 +1684,11 @@ static int xhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 		goto free_priv;
 	}
 
-	ep_state = &xhci->devs[slot_id]->eps[ep_index].ep_state;
+	vdev = xhci->devs[slot_id];
+	ep_state = &vdev->eps[ep_index].ep_state;
 
-	if (xhci->devs[slot_id]->rhub_port->link_inactive ||
+	/* rhub_port is only set once the device is enabled or addressed */
+	if (!vdev->rhub_port || vdev->rhub_port->link_inactive ||
 	    *ep_state & EP_DROP_PENDING) {
 		xhci_dbg(xhci, "Can't queue urb, port disconnect or link inactive\n");
 		ret = -ENODEV;
-- 
2.43.0

