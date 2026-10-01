Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3495C36E466;
	Thu,  1 Oct 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880207; cv=none; b=kCBH0Vt+V7JNWu0R0pK7x1syJuNDKUSPUJjik9UC0qLGlD/R2OIaqOCG1tYFoLeXL03gWhUlh6X1KdRXR52nQZ7ZGMB4gFpc0Qls/1J9Qf7jESrfSVPOzc/ZREHZHnTWTQCrEveerwh4vWUu4xDmB91Bf0S9gBwlSdazSx+vbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880207; c=relaxed/simple;
	bh=aQT5kr5OpIPrNRiA4Ciri1pSzFK/ArwAb1wwoAcp6gI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=baD+JNJaoD0NekzQtBD8gOPUkNbjD+dPMwi06sNo04Dt9iHJ5aSpKMoqL1zLM2MaKZqn4xcLeaECULrSLZPvrggbjalJj9hNWtlQy6Joi3h4h9svNMiqcL3Zs0NyvGymu/4PQkcV495htK7dh4MygZ9djOFCB+vPvarsFDf7i6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGVueZdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGVueZdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C91F000FF;
	Thu,  1 Oct 2026 18:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880203;
	bh=+ZkKXhIWFfrPTejbxGVS4sr+xXF138d3U86G2Sd+jdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=RGVueZdVwS5NCHbj20qs/POyhViHxenDJCPkoZSRN8Zaz1GgnZ9k3jSVOS384808M
	 c0+kKyGGMfDyVgeNifd8InH7GnTzmPiYa6IsMx1pjomLSdapw9sblXsM909HtbezZI
	 6COvZezuz3KaI3Hcscjl+3Q5zkTT+OUbB0Nj3aytNfujdcVpvicXtgBFMVyvAbXGYK
	 nHGQkNAbAtDeDjhB5CYdmTLuuNK2+v8pM23qNklfUVx7rO0S3vvb+Lg0Id2dnXfIYA
	 Zb/+p5WgPTjPZ2Y/GlUvnQGSX3I4d0C037wmovuOeulMFSo7m2W4UG79KZs7OL3BAf
	 U7CKZrUm93kqA==
Date: Thu, 1 Oct 2026 13:43:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] PCI: Disable MSI for ULi M1575 EHCI controller
Message-ID: <20261001184322.GA2711157@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930191100.6127-1-kaloz@kernel.org>

On Wed, Sep 30, 2026 at 09:10:58PM +0200, Imre Kaloz wrote:
> With MSI, the ULi M1575 EHCI controller (10b9:5239) intermittently stops
> executing its asynchronous schedule. Control transfers time out ("device
> not accepting address", "device descriptor read/64"), the port is handed
> to the companion OHCI controller and the device ends up at full speed. On
> a configured hub the stall shows up as hub descriptor and status read
> failures. Only re-initializing the controller recovers it.
> 
> On a Sun Ultra 45, 65 of 800 controller initializations stalled with MSI
> and none of 200 with INTx. Each initialization is an unbind and bind of
> ehci-pci on the EHCI function, with MSI or INTx selected through its
> msi_bus attribute; with this quirk, 0 of 100 cycles of the same loop
> stalled. The stall reproduces on a kernel that already contains
> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
> edge-triggered MSI").
> 
> The OHCI functions (10b9:5237) keep MSI. They showed no stall, and the
> hub enumerated through them on MSI during the EHCI failures, so only the
> EHCI function is quirked.
> 
> The illumos EHCI driver also disables MSI on this chip, in
> ehci_register_intrs_and_init_mutex() in
> usr/src/uts/common/io/usb/hcd/ehci/ehci_util.c.
> 
> Until USB HCDs started trying MSI first in v5.9, the controller always
> used INTx. Disable MSI so it uses INTx again on this chipset.
> 
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Applied to pci/misc for v7.4, thanks!

> ---
> 
> Notes:
>     lspci -nnv of the EHCI function on the Ultra 45, taken with this quirk
>     active, so MSI shows Enable-:
>     
>     0000:05:1c.3 USB controller [0c03]: ULi Electronics Inc. USB 2.0 Controller [10b9:5239] (rev 01) (prog-if 20 [EHCI])
>     	Subsystem: ULi Electronics Inc. Device [10b9:5238]
>     	Device tree node: /sys/firmware/devicetree/base/pci@1e,600000/pci@0/pci@1/pci@0/usb@1c,3
>     	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 00000006
>     	Memory at 00206000 (32-bit, non-prefetchable) [size=8K]
>     	Capabilities: [50] Power Management version 2
>     	Capabilities: [58] Debug port: BAR=1 offset=0090
>     	Capabilities: [78] MSI: Enable- Count=1/1 Maskable- 64bit-
>     	Kernel driver in use: ehci-pci
>     	Kernel modules: ehci_pci
> 
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21f..9fb530a08fda 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1941,6 +1941,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4388, quirk_no_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x4389, quirk_no_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438a, quirk_no_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x438b, quirk_no_msi);
> +/* ULi M1575 EHCI (10b9:5239): MSI stalls the async schedule */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AL, 0x5239, quirk_no_msi);
>  
>  static void quirk_pcie_mch(struct pci_dev *pdev)
>  {
> 
> base-commit: fe2ec83746e501645709761605c2464a44fd2929
> -- 
> 2.47.3
> 
