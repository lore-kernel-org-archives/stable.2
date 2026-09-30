Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD6B3C9EE5;
	Wed, 30 Sep 2026 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795526; cv=none; b=iDspan/qMmdas4rH56XY83o0jmMSUJvVkBO01k+r+W8QXIEPDKrgcD4MtqiUO0AZgLDX1N3VZVI8PdfcHHCCiK40CwzUgz8tNDQGGzurUkpNRd944UobObRsxCGiTYO/NLth39TROd8wrKbhxskWs35tQUcEH8DYaw4PkusCh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795526; c=relaxed/simple;
	bh=RNB4HbdZyuHNpXfmq3aW6tpPtk4g68zZNHRgbGJOuOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZnbGLbkZRSLpixn7gNQZQPnlHrHS5bHORIBZ2UDLJ/SgtFJhTY0sxQpizR1TelYZdzhf53qsy3e028yfBWohV4BZzBqQy46Up+C3ANMHxxtSkscMpFZwJZOzg4vHsuACZDNUgmtLeVPRTOOKBvmUKQnKuQc1jcSP018c8dsLfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FialyL22; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FialyL22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2629B1F00898;
	Wed, 30 Sep 2026 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795524;
	bh=R7FY6iGEbdC8VvXJOzgQl4yOzwMqqjbySG58ASrbo5I=;
	h=From:To:Cc:Subject:Date;
	b=FialyL22oi+89WtzIxShkpjSWZea17beeTGoOXF7txeDUI8PzK6X57l0utGwoJOoE
	 mVvyw0p5QmSZveLiLKRFiHhq8oXOjIuYyR+akuQYN+AV59kUhkJirw0NUQdY5oz1qi
	 OecqxTegYR7xK8pHp7ccYF9B+yupIcUgCIvNItLblCgF0om9wZqMlUR+Glkfv1ZSLS
	 fXn0veO3IC/wVn5vpMw+puO0+G0o6xQ430jMQCVh651fbBR31wyI9Tlt9UEBZahHUx
	 otpHlxBefAs93/VqeBVz3NwHikomXNG+MeM7jW4JwVIAL6u6hRmDA+AwlnkrMXsLPt
	 l/G4CzaglDCFA==
From: Imre Kaloz <kaloz@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] PCI: Disable MSI for ULi M1575 EHCI controller
Date: Wed, 30 Sep 2026 21:10:58 +0200
Message-ID: <20260930191100.6127-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With MSI, the ULi M1575 EHCI controller (10b9:5239) intermittently stops
executing its asynchronous schedule. Control transfers time out ("device
not accepting address", "device descriptor read/64"), the port is handed
to the companion OHCI controller and the device ends up at full speed. On
a configured hub the stall shows up as hub descriptor and status read
failures. Only re-initializing the controller recovers it.

On a Sun Ultra 45, 65 of 800 controller initializations stalled with MSI
and none of 200 with INTx. Each initialization is an unbind and bind of
ehci-pci on the EHCI function, with MSI or INTx selected through its
msi_bus attribute; with this quirk, 0 of 100 cycles of the same loop
stalled. The stall reproduces on a kernel that already contains
commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
edge-triggered MSI").

The OHCI functions (10b9:5237) keep MSI. They showed no stall, and the
hub enumerated through them on MSI during the EHCI failures, so only the
EHCI function is quirked.

The illumos EHCI driver also disables MSI on this chip, in
ehci_register_intrs_and_init_mutex() in
usr/src/uts/common/io/usb/hcd/ehci/ehci_util.c.

Until USB HCDs started trying MSI first in v5.9, the controller always
used INTx. Disable MSI so it uses INTx again on this chipset.

Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
Cc: stable@vger.kernel.org
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---

Notes:
    lspci -nnv of the EHCI function on the Ultra 45, taken with this quirk
    active, so MSI shows Enable-:
    
    0000:05:1c.3 USB controller [0c03]: ULi Electronics Inc. USB 2.0 Controller [10b9:5239] (rev 01) (prog-if 20 [EHCI])
    	Subsystem: ULi Electronics Inc. Device [10b9:5238]
    	Device tree node: /sys/firmware/devicetree/base/pci@1e,600000/pci@0/pci@1/pci@0/usb@1c,3
    	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 00000006
    	Memory at 00206000 (32-bit, non-prefetchable) [size=8K]
    	Capabilities: [50] Power Management version 2
    	Capabilities: [58] Debug port: BAR=1 offset=0090
    	Capabilities: [78] MSI: Enable- Count=1/1 Maskable- 64bit-
    	Kernel driver in use: ehci-pci
    	Kernel modules: ehci_pci

 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..9fb530a08fda 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1941,6 +1941,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_no_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_no_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_no_msi);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_no_msi);
+/* ULi M1575 EHCI (10b9:5239): MSI stalls the async schedule */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5239, quirk_no_msi);
 
 static void quirk_pcie_mch(struct pci_dev *pdev)
 {

base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.47.3

