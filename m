Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781904;
	b=lPEY+teXIRhsN//bFip0pk6s69sv2IMIrnG3D6CaCKojGsuDvzwx6MEJb72N7RbhMPfQ
	 PVe5E8eI8IZDqeZ4RqdNwsrqg9n+8z5kcWm91L8h93Ddfj9Jl5qyl9rFMdUixNSJeDmZu
	 IInYefxfOLog3vgXBr/hEyY0NVNFZy4Lfd8t28trDTi+cDtk7IoXYpcMDx5rEx/YpW2+l
	 RQitq3ZULzP2B04/jfhGyMFP623uJvYpbXvLFqHhFUdTwI+VXuSp53cLr+2/ZpBowqSdk
	 8CfSD9odzPcSjYFV4fVCk+Z4rzKx1DiwKeyaAvbESEp2O+FRaSTRskoGt3fh9AwTzkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781904;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UtqY/9zVHUMCCKh1xrmLI8G31TkYZHW31SoN9MrcprI=;
	b=EtHS1dpk0dep7h0LFGazlFgDF2+XxBxJetIORCb4zwop9kgBJ+j36eBn0wCYNDpiEIcT
	 d50fybo7NT+5auBUDo4S3ryW4OAhjE1FQFC7HhRrqORtWfeNC13EV+thaxoqONRIDLVDs
	 cAXp86Z1f2C4TAKj5S5K5sopMqn3ZF7v6wjLFC0/ANrWOtUE90boITPXSkJMjuvpv9nH7
	 ZgHqi96+G83/HEkx7BXjc/h+4lX6JfW4K9/sTmVQ5DQFJ5QMfzJpYREeFTmGhbzNMPX9C
	 pJWPZHDV6AHcOQasQuTbmfiatN/SNAYKiPBJD1vCXBq3/Wir+vrQftxYVPm3Qcc04Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hjKFVk+C;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97D606A339;
	Fri, 27 Nov 2026 12:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E97D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hjKFVk+C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781904; x=1827317904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ASK0omJb/GGDGq7a7ZcgpXM0yl7qsh7GuwNcEiaeKkM=;
  b=hjKFVk+C+wFtYTH/YFyPbZ488P20Q0XkSMavs2N6EOKlG99Ko23iWhOT
   MbLLSrNbln+BMW9usaMNHoZcktfww5jaLHklayYu/AFDHGMiL71qqjPnd
   oAgpDMn3labxGTWsHUMDjPmejDaWQ2wpr6UHE3xvE1Wipnh02KSsIU42e
   3Tupc2cWeGCVUmCW6Va7m4EGUrqH0TDHomTE2Txqpft2C4PyaLzzGn7vY
   mrNTk5pbet2W5OTALNiBr6RXvyt8YSNL9nr4GOG9PZi3XDMTDDLKyvf5x
   28L+j3Rgaqp2p1uRDGXdz+NJi2Cawnj2KQwuLzVYiWVuNE9NEJsgiD1yK
   w==;
X-CSE-ConnectionGUID: Jamd2bkRTp6w02lbihUrwg==
X-CSE-MsgGUID: 6NUD5do9ThmE3FxVxieCZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4577877"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4577877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:24 -0800
X-CSE-ConnectionGUID: UWX7ao8ARi6/624aJBA2SQ==
X-CSE-MsgGUID: CGEw6GZBRkKMWWDrLLTLqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12270681"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.home) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:18:23 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 09/10] xhci: fix use-after-free for errors mid TD on empty halted rings
Date: Fri, 27 Nov 2026 14:17:54 +0200
Message-ID: <20261127121755.281420-10-mathias.nyman@linux.intel.com>
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

If a TD with an error mid TD is followed by an event that doesn't point
to that TD, handle_tx_event() gives back the TD with xhci_dequeue_td().
If this was the last TD of the URB, the URB is given back and the TD,
part of the freed urb_priv, is freed with it.

If the TD list is then empty and the endpoint is halted, handle_tx_event()
jumps to check_endpoint_halted and passes the now dangling td pointer to
xhci_handle_halted_endpoint(), which adds it to the endpoint's cancelled
TD list. This causes a use-after-free and corrupts the cancelled TD list.

Set td to NULL after giving it back. xhci_handle_halted_endpoint()
handles a NULL td, and td is reassigned if there are more TDs on the
ring.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-2b321b4d-f99f-4acd-9590-8dd98a82ebb5
Fixes: f42a36bae064 ("usb: xhci: Fix handling errors mid TD followed by other errors")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index fca23daf6add..7ccd89a4b995 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2891,6 +2891,7 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	if (td && td->error_mid_td && !trb_in_td(td, ep_trb_dma)) {
 		xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
 		xhci_dequeue_td(xhci, td, ep_ring, td->status);
+		td = NULL;
 	}
 
 	if (list_empty(&ep_ring->td_list)) {
-- 
2.43.0

