Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781890;
	b=2eGvAQO3yKGpNs6qudJFZgZ3wSZzghuglxq/GhSzdJHJVcCsV5n+CQCRqQAJeliRzEGz
	 wK+EMMymmEkL9bmKgZ56CLusv7TcnO8Hxzqw2zLhqjaUS27MzsgugOkKavYCQEkKaa9mF
	 OzuYD1XOz3VRdpgeDEO6yo7nddcES1SogaMBcExnFd/EHosxMvOhvIHD9sgvQkgcg68zh
	 B1WKEhQXVTTlvQkuWkCL6nh+OSrtWqrvKQ1xTLqqqbdB0tsRe/xle2dc6qfd+n2W7QRZ2
	 eAUqqkk7ELv9/htIfY1Auxv+Ee9qPMZU2imA6+b+/wLpJZfAqw0HJwnJAK08mfdhYRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781890;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XCV2byNVDE42uxEcvEQv85bV+oeba2a7pZNX1aOtOUs=;
	b=Q4W0o1hEbmYNxWVWiBGAW8IcRkC2A+EIrE8Mkhr/dLaqOzJIT4DewxFluNZ4uBluQOMz
	 11+aoX0mxuerpyN+hyxU9tQh+Das/x/xgLSqAwShhEJROp0gDmzfpckeTPD8qKGJpvO3t
	 XsDGNk3E6ZK6swvqr30FG/CGBEQQE7FyRpAK5ln4534Ldmt2E2XRllYKZwqenvn6iZkTw
	 n4Qc/u7kl35ORwFSTGnUw+AhHqrkKIFYQKEXalVSWDnpho4vd7FYvwYcKDiyDKxPiqLJf
	 Uo79KOrxqUr7kFBdI0ZTmZNWCWJ7+nZ23hZiXaAocwKla1vfS8BHVxsWBNG8ktUETYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nY2OvbWM;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C88606A324;
	Fri, 27 Nov 2026 12:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05C88606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nY2OvbWM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781890; x=1827317890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hk6fOM6BxJyh3LEbjPmYujbWO41/twlFB5pfL1kRfRo=;
  b=nY2OvbWMJi/uCUVo0qlNM89V/02ANxeh9Wkzb8yripA4VpickUBJbjVO
   Kq2lt0VjG/AMO9tXPd76SpL54NuRO3PjNy8zxLrgrl5TnKLgd1SzvUbdm
   Z6vbb5nzCPUAXKpOOUzy2EwZw8XJRr/9CsjkaaCsd1soefa2G5nkX9Gok
   gp9mFIMRIbhfzVR181QRnO2kQpVNpE8FbcYE8gbq62f1D/8dfWtOD5Y0u
   HZiequho0zdA10OiDrxVrFzPCm+zTD6l9O2D4oYIUylO+p6UpGz5FnEM0
   2isAfJ98ehOC5GDmb6OG1Tvsyomy1aHxAf3W5ZPwOAgpu2o0xlnk3BEsI
   A==;
X-CSE-ConnectionGUID: qELGuB5vS+qSOApQymTtZA==
X-CSE-MsgGUID: tTm2UdETR/GIJYMnsKQfgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577838"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577838"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:10 -0800
X-CSE-ConnectionGUID: ZQxHlworS8qBuGpzIyc9RQ==
X-CSE-MsgGUID: eT10PFBZTym3YwAAWISj8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270665"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:09 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 01/10] usb: xhci: Fix ep0 maxpacket update on enabled slots
Date: Fri, 27 Nov 2026 14:17:46 +0200
Message-ID: <20261127121755.281420-2-mathias.nyman@linux.intel.com>
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

From: Michal Pecio <michal.pecio@gmail.com>

A slot in Enabled state has uninitialized output contexts;
it doesn't need and cannot accept Evaluate Context command.
Attempting the command only results in a (harmless) warning,
observed when core uses "old scheme" on a full-speed device:

  WARN: invalid context state for evaluate context command.

This problem doesn't seem to have existed before ep0 update
was moved from urb_enqueue() to endpoint_reset(). USB core
doesn't use URBs before enable_device() or address_device(),
but it may call endpoint_reset() on ep0.

A more serious bug has been identified by Sashiko review bot.
Transaction Error of Address Device may cause the slot to be
reallocated and left in Enabled state, but the input context
is (needlessly) regenerated before actually being needed by
the next Address Device. xhci_check_ep0_maxpacket() corrupts
this context by copying uninitialized ep0 output context.

This matters when core resets a device and doesn't reallocate
udev after address_device() errors. Some HCs reject the next
Address Device with Parameter Error, some break. ASMedia HCs
write a Setup Stage TRB to the event ring and stop working:

  ERROR unknown event type 2
  INFO: task usbreset:4071 blocked for more than 122 seconds.

This exact case is a relatively recent regression, but even
if xhci_setup_device() didn't regenerate the input context
on Transaction Error, next iteration could regenerate it and
keep it there when command timeout leaves the slot Enabled.

We can kill both bugs with one stone by checking slot state.
If it's Enabled, do nothing and let next xhci_setup_device()
configure ep0 later. It will actually ignore the packet size
requested by core, but its defaults match core expectations
at the time of address_device() and enable_device() calls.

Fixes: e34900f46cd6 ("xhci: Reconfigure endpoint 0 max packet size only during endpoint reset")
Fixes: af8e119f52e9 ("xhci: Fix Panther point NULL pointer deref at full-speed re-enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fc1b0a6b0429..6e0729a07e5f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1554,6 +1554,11 @@ static int xhci_check_ep0_maxpacket(struct xhci_hcd *xhci, struct xhci_virt_devi
 	int hw_max_packet_size;
 	int ret = 0;
 
+	/* Only slots initialized by successful Address Device command need updating */
+	if (GET_SLOT_STATE(le32_to_cpu(xhci_get_slot_ctx(xhci, vdev->out_ctx)->dev_state))
+	    == SLOT_STATE_ENABLED)
+		return 0;
+
 	ep_ctx = xhci_get_ep_ctx(xhci, vdev->out_ctx, 0);
 	hw_max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
 	max_packet_size = usb_endpoint_maxp(&vdev->udev->ep0.desc);
-- 
2.43.0

