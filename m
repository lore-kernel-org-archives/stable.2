Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7114534AD;
	Thu,  6 Aug 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026106; cv=none; b=kvMn5Q7OCZjCHvPOijoJD0twrGCH3SqmExWK65Ej3ha3wC997b4O4QpIOzFiUY8BOw8R4a7h7mo09QOArlBZH8RdZDaU4mGsEEik6tnDFprtqLY8S6O5C82BtvsGH0SI1cuobcgjIZlASWqfuLBMdxBRIPn5vi3bFP3YAzKsI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026106; c=relaxed/simple;
	bh=xTQTAurjpkiiPbSNbqNCSE7XlzF4/UMcxnFivqfIvog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1o575jVinXQdgnE6FtRxpOPoJr9pHovE6dD2MuS/TJU+EG6tQSPWjbhPP9cfsiLd1MJOxo66z3SScCFayuf7voUcTzZuT76MNli5rDFnUq40/vSgQ9V+WM8MKSeIQ2FaRvoOU9rGiuVcBsN6CRwrDM68xVKvXT3ErvSelpFwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ei4DAe6C; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ei4DAe6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786026104; x=1817562104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTQTAurjpkiiPbSNbqNCSE7XlzF4/UMcxnFivqfIvog=;
  b=Ei4DAe6C0BcfF8XqQtGghxwprq/5LKdiIJTDUxwT9bT0WvtF74pQRgnz
   m0FsHi5pRfjHW6z3sWKGEsPYN75Md6J/Yzia4AV+j6ReCJoVUGXMZOR9r
   TifE0TN54QY5Pd0lTeLummXjUKSf63U6D3GECEz8a4sOGY3GpRknik7/4
   wFKFjdEOLFEbLaM/d97P5O43nhGL/5Sq9ADYRxjWS+tXj1Yt8mAZrpuqy
   A0yf0yunJfcbuNrpA3tyroRc5TdHMclpAJELUw6R9Cl/gPKc2QlsL2LxB
   NIFb5abEQ5kqgvw3C55w4/m6g8/dM4Mw20WKE/r3jc3sH3a/OPau7T+yB
   w==;
X-CSE-ConnectionGUID: 11pJBTy7SxOAzb1SWWGxKw==
X-CSE-MsgGUID: GOyq5TohRFWiMZi9R1weGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97268177"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="97268177"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:42 -0700
X-CSE-ConnectionGUID: rstm8rqPRp+xOAIuNpSXUQ==
X-CSE-MsgGUID: CnOVQt7KQlKa/ogD4KW+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="285500456"
Received: from amilburn-desk.amilburn-desk (HELO mnyman-desk.home) ([10.245.244.235])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 07:21:41 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Breno Leitao <leitao@debian.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 10/17] usb: xhci: bail out of setup if the controller is inaccessible
Date: Thu,  6 Aug 2026 17:21:06 +0300
Message-ID: <20260806142113.2436238-11-mathias.nyman@linux.intel.com>
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

From: Breno Leitao <leitao@debian.org>

xhci_gen_setup() locates the operational registers using the capability
length read from the very first register:

	xhci->op_regs = hcd->regs +
		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));

If the controller is dead or has dropped off the bus, that read returns
~0, HC_LENGTH() truncates it to 0xff, and op_regs ends up 0xff bytes
past the page-aligned MMIO base, i.e. unaligned. The first access
through it, xhci_halt() -> xhci_handshake() reading op_regs->status, is
then an unaligned readl() on device memory. arm64 faults on unaligned
device accesses, so instead of xhci_handshake() catching the all-ones
value and returning -ENODEV, setup oopses:

  xhci-pci-renesas 0005:08:00.0: Unable to change power state from D3cold to D0, device inaccessible
  xhci-pci-renesas 0005:08:00.0: xHCI Host Controller
  xhci-pci-renesas 0005:08:00.0: new USB bus registered, assigned bus number 1
  Unable to handle kernel paging request at virtual address ffff80030a770103
    ESR = 0x0000000096000021
    FSC = 0x21: alignment fault
  Internal error: Oops: 0000000096000021 [#1]  SMP
  pc : xhci_halt [xhci_hcd]
  Call trace:
   xhci_halt
   xhci_gen_setup
   xhci_pci_setup
   usb_add_hcd
   usb_hcd_pci_probe
   xhci_pci_common_probe
   xhci_pci_renesas_probe

This was hit with a Renesas uPD720201 that failed to power up ("Unable
to change power state from D3cold to D0, device inaccessible") yet still
reached the HCD probe path.

Read the capability register once, and if it reads back the all-ones
value (as xhci_handshake() and xhci_reset() already test for), abort
setup with -ENODEV before op_regs is derived from it. Reading it once
also avoids re-reading a register that may change under a concurrent
hot-removal.

Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 71c25c2e71b9..4473b3cd1d36 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5434,6 +5434,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	struct device		*dev = hcd->self.sysdev;
 	int			retval;
 	u32			hcs_params1;
+	u32			hc_capbase;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5454,15 +5455,19 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	mutex_init(&xhci->mutex);
 	xhci->main_hcd = hcd;
 	xhci->cap_regs = hcd->regs;
-	xhci->op_regs = hcd->regs +
-		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
+	hc_capbase = readl(&xhci->cap_regs->hc_capbase);
+	if (hc_capbase == U32_MAX) {
+		xhci_warn(xhci, "Host controller not accessible, removed?\n");
+		return -ENODEV;
+	}
+	xhci->op_regs = hcd->regs + HC_LENGTH(hc_capbase);
 	xhci->run_regs = hcd->regs +
 		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);
 	/* Cache read-only capability registers */
 	hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
 	xhci->hcs_params2 = readl(&xhci->cap_regs->hcs_params2);
 	xhci->hcs_params3 = readl(&xhci->cap_regs->hcs_params3);
-	xhci->hci_version = HC_VERSION(readl(&xhci->cap_regs->hc_capbase));
+	xhci->hci_version = HC_VERSION(hc_capbase);
 	xhci->hcc_params = readl(&xhci->cap_regs->hcc_params);
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
-- 
2.43.0

