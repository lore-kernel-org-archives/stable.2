Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A730B521
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 11:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261576; cv=none; b=fZJJwD2SmhvTAPVM4MA5PHnF1WfRXGXHDeVMHJCsGXv5JwdNAviYv9zBujOHanEt3Nr6G97qruU8J4ePzl+hMN0F5D66YAn5le7MIvoMfJJHYpCYDCBsLfjEPYJah8+Z8NJzmMVlX1AzLyr6riub/i3yeKQxFTGSrVwukaUlIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261576; c=relaxed/simple;
	bh=NAJ34+j/FZPdh5cm8G/e7AeopyVJWvaeFOSryX3jWXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6g76u61Kzu3lkM3Kv1uuoCBIa7KcJo7f5Fw8TJj4EZiSpME7nbtTApWzBqTM/kzm5F8O8DMEAV4z9kSCJIikI6ek+163aE25yhFVtDapFC2grS8i9o7/HHPKVO7hbbO1L6TWU4XzgE7ZIcwRnEg4yz3k211A4wZGiQig2/S4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpKbQ1z5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpKbQ1z5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD8B1F000E9;
	Tue,  1 Sep 2026 11:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261574;
	bh=EpoHnA4gYhjRkBUidovYXn2tGz6LRxQEQlle+xuQEgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UpKbQ1z57phPzH8MBFPC2iVn/hhxTUMR4ni2YyzPlq2fAOhSkIqtllm1YsLdpE61R
	 qmEWa6Dc2HO/BdGs0l9rZH59X/dFCnLE6cl8xfM25d3+R0HeDfz5xGiwWE2skEdfZW
	 eAYBYuB1AtSpJdG4Mu6oagxnsiB05jQSUx3SEm9MjvzAeLfViLaNsrE3llJitA2/dc
	 OukLI63ejD0fxCT+3aOcVLIgS5eyocLG/ADZwjIoCulysv0nzbvqFeZDDtBf4FZpfR
	 clQyJQzviNBZMX5+zESONL4Z6zLUw5doI1i5uVyo+GQ5/mMgvAAwZZZIsalZvkCUSb
	 jTcPbpYyJSdKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: xhci: bail out of setup if the controller is inaccessible
Date: Tue,  1 Sep 2026 07:19:31 -0400
Message-ID: <20260901111932.42246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083123-overbuilt-setback-14b9@gregkh>
References: <2026083123-overbuilt-setback-14b9@gregkh>
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
[ adapted the double hc_capbase register read via hcc_params/hci_version to use a single new local hc_capbase variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 2cc27dba08e2d..81b1fb22dc932 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5243,6 +5243,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	struct device		*dev = hcd->self.sysdev;
 	unsigned int		minor_rev;
 	int			retval;
+	u32			hc_capbase;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5309,16 +5310,19 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 
 	mutex_init(&xhci->mutex);
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
 	xhci->hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
 	xhci->hcs_params2 = readl(&xhci->cap_regs->hcs_params2);
 	xhci->hcs_params3 = readl(&xhci->cap_regs->hcs_params3);
-	xhci->hcc_params = readl(&xhci->cap_regs->hc_capbase);
-	xhci->hci_version = HC_VERSION(xhci->hcc_params);
+	xhci->hci_version = HC_VERSION(hc_capbase);
 	xhci->hcc_params = readl(&xhci->cap_regs->hcc_params);
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
-- 
2.53.0

