Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE0439F7F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182840; cv=none; b=bc2nPJssMjAJnoozZs6qPrh1CCsDO/QI8kKb5hNkceytxDI2HQUEVaUp2P27Gs7MM5n1iA/C3GzkBVCUJVDUHaeF0Acxoarc3uHKXAjhF+qtLqTlcr4WSRr/xI6TUDpTvWcHpPVdrQT+T7oyV5j7r+vr3IB6MKjngKX6TucxOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182840; c=relaxed/simple;
	bh=A92yPj72YzPNkDNA+QQlmogmUP8xqvSUMfICjWKwnjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2GdyNCkilrDqHieCv9yDZCHwIYaMXFxO+ON+wz0z+xqzssN2Ia2QQjWSItwYA1sfOlUBJH7RgPYbzsXbDAeDx4Nr+5bUjZ64nZQ2nhdMtXf6McljXCyVyudkR0NZgM662hJ6Pq42i132/xG7BCyxdVdg5VaRsxWKaGuDce4uiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO+v5XKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO+v5XKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767EC1F00A3E;
	Mon, 31 Aug 2026 13:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788182839;
	bh=VQYChJAGGURhtJKL4V+3zJxeviwFQWxvxWNgogZSwA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SO+v5XKUkglBq6wY4bqR97CHBbvdLkGU28DISm2KTb/OxV28E3C/gDqtsHPQSK6YU
	 tnTdxCdl4TKhvKxDVY8XatsWnMjo1wGVPG3nNXi03SkaKbQxGtQ9oehhALG9yW5ZAU
	 SyYb8ryMDXRojYdWOG/gxHE+zgdoDUj+hnfeAS+J4oRXUtjhq9miewv65ZsqnVnkLx
	 46ItChFdgJDVAOCsupCRA9oXILDRXWvWXQLH/ZuSRj8MP/4nb/c9xJlWbbS6dWnNpB
	 qHt3fz5hl6cnIwdptVY0J1QtXDvuwvA6KPeQVzetaBMKlZtTXP5eCsauEBJ9nh91my
	 HsbVEKG+sNsIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 7/7] usb: xhci: bail out of setup if the controller is inaccessible
Date: Mon, 31 Aug 2026 09:27:09 -0400
Message-ID: <20260831132711.4043116-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831132711.4043116-1-sashal@kernel.org>
References: <2026083120-hatchling-fade-cf8e@gregkh>
 <20260831132711.4043116-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 78203d5b54a40f0e36196ebf31c9c7a380fc8811 ]

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
Link: https://patch.msgid.link/20260806142113.2436238-11-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 351550f21a67b..72f7da2ed5c47 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5435,6 +5435,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	struct device		*dev = hcd->self.sysdev;
 	int			retval;
 	u32			hcs_params1;
+	u32			hc_capbase;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5455,15 +5456,19 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
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
2.53.0

