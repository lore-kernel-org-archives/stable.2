Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B248C40A;
	Thu, 23 Jul 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811551; cv=none; b=LRqdbPNsz+7xEx/VS3RENYP5WLcyQhI9gNlELiRzjxFYvsbo3DBxkhRzrViod+AxAsvSOH/VbSXNAgqbAWRst/ExQ6nJvzZrqWSW51uC9Eeua66c86y8RCwdVKLhaW9SG9qOZt/Nvyb6OYxUyhIz66mGOzIZcJI3b+Nd7QWDzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811551; c=relaxed/simple;
	bh=j01DrBsAX10eFCSQ+gf/S33kQdp9Zx7o/BHKU6AtZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTKgURBSsQr3s5ePgB5ZebOy0n+vBOto0J2k2LipKQvDs9Fqrgfk0+Ozg3BQu/cJE4b4tYtj280cRibi0Z0g5tJv7HXfKHO8WF44Eeg+vk/Om2v3JETeyzVwPnQaVhq8IbWIw3g1HML6CFTx60EjczaV0Jg8oFQiVfUaBgexytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Eo84dFXy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Eo84dFXy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LeplYwxZd6Lx+LNQMxScZLM52gIevsKFUjQL25XWSIg=; b=Eo84dFXyNbwU8rAVEb+pVoHRJq
	VtGqxNnXelwlHWqIruJjq96+oevTQCLdVRwWPHOJcaUIrff37cf8h//VWwg2VJNPPib7BuNfX4Aqo
	teqAtQMmzthFsT8y2lt7b+g3kSrVcE8eSc6PH6LMJkNJk6VivZm0vxAzOftpZHHfQj+/2amItWcaY
	/NnADHK5WA7k9Gp/0aYpgC37NJY84WQei35XKFGljfZmSYLzaoHyfZ2wfciNZd86dvgimybC8U5/b
	/Ak2x8/ppm/tQykI9yZT1gOQS+LqSAKD2LzdeeTFpctq8Rv8i7BrnS7A8SIIBypYKb04lrRp7w3iQ
	frjiAFDw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wmt0h-003nL8-1N;
	Thu, 23 Jul 2026 12:58:47 +0000
Date: Thu, 23 Jul 2026 05:58:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: bail out of setup if the controller is
 inaccessible
Message-ID: <amHasIXXBtxwD4jX@gmail.com>
References: <20260722-xhci_dead_hc-v1-1-78f55597524b@debian.org>
 <20260722230430.2256c8a4.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722230430.2256c8a4.michal.pecio@gmail.com>
X-Debian-User: leitao

On Wed, Jul 22, 2026 at 11:04:30PM +0200, Michal Pecio wrote:
> On Wed, 22 Jul 2026 04:27:36 -0700, Breno Leitao wrote:
> > xhci_gen_setup() locates the operational registers using the capability
> > length read from the very first register:
> > 
> > 	xhci->op_regs = hcd->regs +
> > 		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
> > 
> > If the controller is dead or has dropped off the bus, that read returns
> > ~0, as I saw in practice.
> > 
> > The first access through it, xhci_halt() -> xhci_handshake() reading
> > op_regs->status,  unaligned readl() on device memory. arm64
> > faults on unaligned device accesses, so instead of xhci_handshake()
> > catching the all-ones value and returning -ENODEV, setup oopses:
> 
> And if it didn't oops then it would read some other register, and later
> write it, and maybe do stupid things. At least HC_LENGTH macro
> truncates ~0 to 255, so the other register would most likely still
> belong to this xHCI.

Right. On x86 it doesn't fault, it just pokes the wrong offsets within
the same BAR; only a few arches/arm64 turns the unaligned access into
a fatal fault. Either way the value is garbage, so bailing out early is
the right thing to do.

> >   xhci-pci-renesas 0005:08:00.0: Unable to change power state from D3cold to D0, device inaccessible
> >   xhci-pci-renesas 0005:08:00.0: xHCI Host Controller
> >   xhci-pci-renesas 0005:08:00.0: new USB bus registered, assigned bus number 1
> >   Unable to handle kernel paging request at virtual address ffff80030a770103
> >     ESR = 0x0000000096000021
> >     FSC = 0x21: alignment fault
> >   Internal error: Oops: 0000000096000021 [#1]  SMP
> >   pc : xhci_halt [xhci_hcd]
> >   Call trace:
> >    xhci_halt
> >    xhci_gen_setup
> >    xhci_pci_setup
> >    usb_add_hcd
> >    usb_hcd_pci_probe
> >    xhci_pci_common_prob
> >    xhci_pci_renesas_probe
> > 
> > This was hit with a Renesas uPD720201 that failed to power up ("Unable
> > to change power state from D3cold to D0, device inaccessible") yet still
> > reached the HCD probe path.
> 
> Seems unproductive, I wonder if it's somehow intentional or a PCI bug.
> You would need to ask linux-pci about it.

Agreed, that's a separate question - arguably the device should not
reach probe at all once it is inaccessible. I'll follow up with
linux-pci.

This patch just keeps a broken/removed controller from taking the box
down regardless of how it got there.


> 
> > Detect the removed controller the way xhci_handshake() and xhci_reset()
> > already do, by testing the register for the all-ones value, and abort
> > setup with -ENODEV before op_regs is derived from it.
> > 
> > Fixes: 66d4eadd8d06 ("USB: xhci: BIOS handoff and HW initialization.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/usb/host/xhci.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 091c82ca8ee29..4e8a87df91d9d 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -5453,6 +5453,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
> >  	mutex_init(&xhci->mutex);
> >  	xhci->main_hcd = hcd;
> >  	xhci->cap_regs = hcd->regs;
> > +	if (readl(&xhci->cap_regs->hc_capbase) == U32_MAX) {
> > +		xhci_warn(xhci, "Host controller not accessible, removed?\n");
> > +		return -ENODEV;
> > +	}
> 
> Good idea, but there is one more case to potentially worry about: hot
> removal. In theory, you could read a valid value here and then U32_MAX
> below and crash the same as before.
> 
> It would be more robust (and efficient) to read the register once to
> some tmp variable, validate it and then use that to set xhci->op_regs.

Good point, thanks.  I will update it to reads hc_capbase once into
a local, validates it, and uses that for both op_regs and hci_version,
so the check and the use can no longer disagree (and it drops the
redundant reads).

> >  	xhci->op_regs = hcd->regs +
> >  		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
> >  	xhci->run_regs = hcd->regs +
> >  		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);
> 
> One may wonder if run_regs shouldn't have similar check. However, if
> the chip is hot removed here after successfully reading hc_capbase,
> xhci_halt() will not crash and return -ENODEV before anyone uses the
> bogus run_regs pointer. So there is no urgent problem here, I think.

Agreed. Computing run_regs is harmless on its own (run_regs_off lives in
cap_regs, so that read is aligned, and it's only stored as a pointer), and
the first dereference happens in xhci_mem_init(), well after xhci_halt() has
already returned -ENODEV in the hot-removal case. So no check needed there.

I'll send v2 with the read-once change shortly.

Thanks for the review,
--breno

