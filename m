Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74347A0D8;
	Thu,  6 Aug 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026118; cv=none; b=VM7JE9MzuqGGaC2rRbiZTpuZYNIRh/SHrjF1zU7EK63T8tFYJS+MCFASyn8WzX2RIOfC4Yu+TmcHdkCjToEcwHPbWtmfDjnRaazZ9ArnvdidU2YLmcT/SdOlbP0QX09TjbE1MPhTxaqgkycxEb7uHZrwiL6teI5iqawAHUQ9kKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026118; c=relaxed/simple;
	bh=Q1VASIO5zSSEvFAhF2xH5XnFr0Wfl5tGD985rlSG9qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcrEYZYC5q3SPKuE/dJaEKowf93kv7zmbZjUPofAR3Qs47/1QkNJdAjtVYcLqoG8xC5YSiq4bZNtL6yYvKkWiQ0ywhinUMb5phv+vayz3G2xLZ8eUqqEIDiPoKSF5mL6ALlxxeDUBi0at+oEMQBjDTPrV9UnTNbIxlmPgcoCqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9sqY+OV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9sqY+OV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026114; x=1817562114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q1VASIO5zSSEvFAhF2xH5XnFr0Wfl5tGD985rlSG9qA=;
  b=f9sqY+OV8EPLrQ0pfMkBhZCpzIFVpeJd7hBV5LNidf214hXNwFA1lPf1
   xXF/TeSCvC56Ga9HDFgJ31nLStIDQ8J3WlN8tlo1X3FH6dAKvz55zSRJF
   /7zbnRJA+fiaN+HpyvDtTOJlWmQkjyNwW2ROkrVlsqkdV/YkAnCjch/2z
   pAV7nKCWiAfqS77yEq7WMAfyoGzQj+0vzrZJPKG1KK1pcB20qKKCIu5l0
   CbUC7vf6l9E6DqmjY/kBY+P0SVJkIQOJ57s9os3w1uZ24kPtVFjE9gmQV
   /ZTdr5NsAYnZbXbnD9qT2sC0AA3QGX+rhtOguOyO5R+AjylWINe3Dh3VB
   g==;
X-CSE-ConnectionGUID: 3LMDWBdHSrGNvrFR2/WA5g==
X-CSE-MsgGUID: 6qeTACHjQdyZMpagThcmcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97268216"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97268216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:54 -0700
X-CSE-ConnectionGUID: gL6DpXnvSYylDOon08B1gw==
X-CSE-MsgGUID: VB+GwbkIQU2oB6kOZbIdhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="285500530"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:52 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	Bart Nagel <bart@tremby.net>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 17/17] usb: xhci: Handle bogus TRB pointers in Missed Service Error events
Date: Thu,  6 Aug 2026 17:21:13 +0300
Message-ID: <20260806142113.2436238-18-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806142113.2436238-1-mathias.nyman@linux.intel.com>
References: <20260806142113.2436238-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

xHCI 1.0 allowed these pointers to be zero. Some Intel chipsets from the
era usually set it to zero, but sometimes (apparently) to the next TRB
after the one referenced by the previous transfer event on the endpoint.

Usually that's indeed the missed TD, but it may also be the last TRB of
a two-TRB TD already completed with Short Packet on its first TRB. Then
the driver skips all pending TDs, failing to find a match.

When handling Missed Service Error, scan TD list twice and only really
skip TDs in the second pass if the first pass found a match. This won't
catch bogus pointers to wrong TDs, but such a bug would be practically
impossible to detect automatically and isn't known to exist.

Reported-by: Bart Nagel <bart@tremby.net>
Closes: https://lore.kernel.org/linux-usb/al_hchyOdPoPWKEo@spiral/
Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Fixes: d0b619599e52 ("usb: xhci: Expedite skipping missed isoch TDs on modern HCs")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 69bd582c7e2b..97a1b53c18ef 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2597,6 +2597,17 @@ static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
 	}
 }
 
+static struct xhci_td *find_td_by_dma(struct xhci_ring *ep_ring, dma_addr_t dma)
+{
+	struct xhci_td *td;
+
+	if (dma)
+		list_for_each_entry(td, &ep_ring->td_list, td_list)
+			if (trb_in_td(td, dma))
+				return td;
+	return NULL;
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -2791,8 +2802,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dequeue_td(xhci, td, ep_ring, td->status);
 	}
 
-	/* If the TRB pointer is NULL, missed TDs will be skipped on the next event */
-	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb_dma)
+	/*
+	 * We don't know how many TDs were missed when ep_trb_dma is zero (as permitted by
+	 * xHCI 1.0) or bogus. Bail out leaving ep->skip set, next event will sort it out.
+	 */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !find_td_by_dma(ep_ring, ep_trb_dma))
 		return 0;
 
 	if (list_empty(&ep_ring->td_list)) {
-- 
2.43.0

