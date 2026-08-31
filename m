Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7359E1EEA3C
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178885; cv=none; b=FOREvidoIKjD/mYGlwlZbPzL3SErrLBxgM1ZyH4z2Ox7o/r3v0J6ys3zDQRMDpxZFIKXAvUW7QmTpvofdZ53cx38wOfDmhh/fq9sy/MHS9bnTn/8Ah+lGjXvHcaBV02o/y02r5R9l5obTdi1uyFoYlHoqk3uHEnjOwwSRaPZSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178885; c=relaxed/simple;
	bh=f//7ZLhndjowS2rCPENQ9b9+xwzI1R9BRGmWCzFNrLI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lXqSevF/C2nVNzp1z9IxpLHWsPritFL7xymA5KF+fYjj1LfRnEZzS1AyE8+ga7cwTFnStYGhVSjqkPBiQjAbfeaRdS2TGeDoX3vex71hOoN4JzJDslx3Ix3p5amS+ROPJ9KlRSqkv3dBUBHGzdimz9WbhIoBoZiEmL1soDO90gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RM9oJ6Sy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RM9oJ6Sy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6993F1F000E9;
	Mon, 31 Aug 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788178884;
	bh=vUcMtaUeUGCctUaEhSaJ/KVWakWiJFQ9GDYat47IrU8=;
	h=Subject:To:Cc:From:Date;
	b=RM9oJ6SyCjVSJWyGOa1AbTO6GB9DwVT+w1GVhf8qnAK9Wbk7eh9zYSabanw7Dlqmh
	 eAKIl3X2FInbn8+m+VuohnJu/9qBNNQq3X23U1Jbbx2+XwCBpytE91NUtcNJajbrML
	 0xPu49nAPEEHeO5ZDE9lRFUrf4dYSC2dhfYOHxwg=
Subject: FAILED: patch "[PATCH] usb: xhci: bail out of setup if the controller is" failed to apply to 6.18-stable tree
To: leitao@debian.org,gregkh@linuxfoundation.org,mathias.nyman@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:21:20 +0200
Message-ID: <2026083120-hatchling-fade-cf8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 78203d5b54a40f0e36196ebf31c9c7a380fc8811
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083120-hatchling-fade-cf8e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78203d5b54a40f0e36196ebf31c9c7a380fc8811 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Thu, 6 Aug 2026 17:21:06 +0300
Subject: [PATCH] usb: xhci: bail out of setup if the controller is
 inaccessible

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

