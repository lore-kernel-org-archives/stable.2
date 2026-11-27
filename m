Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781903;
	b=tvMqVtWXyITDbphmNoCKoNbIB2Wjxbi8RhQj8J0RhDhMIpjfaoATpA4JzEQ4S2tEoHc5
	 NDyg4KCx1vVdNow3Puh+arRqJjC6MICui9Xd+uIZhexY8XJboFP5UD8v5mn7zTVJ4fhsx
	 TQbMVfXgYmPnIs7EJcERXWbktpgCO38eq0owVqSWa0E9IosJX9kAYV3srkMa2bNjCkOVZ
	 8HetusrziKp42ORB60hlKTsTV0MBna1OaRgJAMsbDkEcvd0YiYLfcqMbn4CehxsgonVmJ
	 u7FWSbqzvmP47qu4P7/C/pGG3TELUKncRr5UxYECs3feHKfmIblw8Ks93R2wUiXJGMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781903;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=djjM0e7UYUbpa8sbuu0XymIBZ0dR4SuAPBPn91vWU0s=;
	b=OLO3tcp9nz1QeEq4dD9D4eKQO0DSK1OjPdgMun6h9CTfbzUvi0opTf5VF/4niW0oIWna
	 LUlL/489QMdKD7DhuXhqMODaN95si75fwZOaLlVHmfr4iViprFZvM71MI8B8TDxUs23K2
	 PbrQwCQf1x8wLz9ehDjauEqGNCNo4Fj+GfhUuhVZcU9MeTXalBMLTzBeo4OvC6D16GR3p
	 6ASSI/hTzOmDGC3Z5/y7W95KCryMklvjwJGNvCFu9Q68rUGJh5ttL04cykxFOjt0Mkrc9
	 4g1CPa84Ltw1dQlKCtRP9R3X4y/dJzFt/loe9G+qdCsogV4Y746gFSfJUurh2meqp4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvNIoBfP;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66492606A323;
	Fri, 27 Nov 2026 12:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66492606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvNIoBfP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781903; x=1827317903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RapHwTkMePqMwUinvA9tRSskezJ18DxlHci7C9sGzOU=;
  b=kvNIoBfPnZegz3fmYyTErrGuaf9GSfpmNVi3Lq4VOIz9DGuUfiwpxupO
   XcI3ULE6ywbGloK5j1mi/Mh6OERasYyd5iirBvcWsSKX0e7ajKAWAiZfF
   ibzgqH7AES6cBBaO+0M8fQDHmcpHBbrLZ+p1iMxYhzlRzrbwAgjxvCJME
   pIUnt2MxwHpvY2zo1EgzRWXVULWKzQbM4/xXFb8GciwqdiSZs1SCneTZx
   y5DM5O8G2XzGA+QnUDdr/7shcQEYysbea/JAi/zoG0ZXEom0D5UvPxi7Y
   DWt/JW81OCEoa0zEeVbfwkOj5LtVvCisJfzvozYiRgcxnFbgayCvp/2oC
   A==;
X-CSE-ConnectionGUID: yn1A5iS3QyicCzacILnsaQ==
X-CSE-MsgGUID: XLSpLtrpSvKTgV9Hrg/WYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577873"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:22 -0800
X-CSE-ConnectionGUID: JFeUOcKaQ5ymBuYwv0M6Vw==
X-CSE-MsgGUID: 29IifB6yTF6ZGp6BuNJOzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270678"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:21 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Alex Kononov <alex@albefly.com>,
	stable@vger.kernel.org,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 08/10] usb: xhci: Demote isoch buffer overrun message to debug level
Date: Fri, 27 Nov 2026 14:17:53 +0200
Message-ID: <20261127121755.281420-9-mathias.nyman@linux.intel.com>
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

From: Alex Kononov <alex@albefly.com>

An isochronous Buffer Overrun event means the device sent more
data than the TD could hold.
This is triggered by the device, not by a driver bug, and the
error is already reported to the class driver as
-EOVERFLOW in iso_frame_desc[].status.

Logging it with xhci_warn() can flood the kernel log.
A USB S/PDIF adapter (262a:9123) whose S/PDIF input loses its
signal produces this event on nearly every microframe,
about 7,200 messages per second, keeping systemd-journald
busy at 100% of a CPU.

Use xhci_dbg() like the other device-triggerable completion codes.

[mn: remove the "WARN" part of the debug message as well]

Cc: stable@vger.kernel.org
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Alex Kononov <alex@albefly.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index a1fa188680f5..fca23daf6add 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2815,9 +2815,9 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 			  slot_id, ep_index);
 		break;
 	case COMP_ISOCH_BUFFER_OVERRUN:
-		xhci_warn(xhci,
-			  "WARN: buffer overrun event for slot %u ep %u on endpoint",
-			  slot_id, ep_index);
+		xhci_dbg(xhci,
+			 "buffer overrun event for slot %u ep %u on endpoint",
+			 slot_id, ep_index);
 		break;
 	case COMP_RING_UNDERRUN:
 		/*
-- 
2.43.0

