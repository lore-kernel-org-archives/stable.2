Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127566;
	b=mpKS9anvshOt+hpnNcEQO2WdOnAA7lBJOzMRhdwyQB+WfJGoz7DVlrH2Smy7G7k8pHem
	 pNYolRkFfgMhkZOu5n1myTy36I4vMabQcblrn9v3gv15RHWfohFe3m/AjzviZKDOMtinS
	 8PFySD2Chbxb7OY3ANFIuhaa3BGdrhH22dRb+T2sbNVyu5J5b92Qoex/69kd2PeE9i5UG
	 9L3uXJkL35vSgzdAwCKI6EpQobgJhgT3nOO4HnoPD+CpiIgx1iToJfzdFLVuahG93aVTk
	 nOyz4kOxv1tfx04/oAAHcvSwZU29xsYg6GGAXFFtMyST73c684JEllrWMRgfLSYutIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127566;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8diG5IpF+frcATzn1tCDRrk4aGE/jCsGXdXvNn/J5ck=;
	b=EJ3MAgqbI0kqPXkA1/VudUFfs0/m6yRQaeSzvdbC/pKTuo9a8AZmOmClEjzwHldDheqU
	 liyyQkZpEBfZMjwiEWjHsqrtMcx0dh+vQuVTrG03Y/K3qhBhzw9ZxDOAEL06VI/f0bn5v
	 KnsfuGiuIQDPzg+2SgtIQxljBtFc9rkfpVu8IPW1HVTnb2TwMOimVaQ74u6yRhareWNqr
	 wdVBzfR0vXCPlE5oHcnGSG5pW7kozJZEY3PCIUZI31T/t14RTyb9rmz4aaukFuIjF+vXE
	 LB3L/VbltERP5MkKhNxDNcfuKnNIu2T6BPood0LudPX+xiWxAy0AZLqNu6CcT4o4BGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=cSl4wkgK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="FS/aneqP";
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DE606A32A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 867DE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=cSl4wkgK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FS/aneqP
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1484B7A030B
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:32:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 19 Nov 2026 17:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795127562;
	 x=1795213962; bh=8diG5IpF+frcATzn1tCDRrk4aGE/jCsGXdXvNn/J5ck=; b=
	cSl4wkgKfjRP7WNr0a/cbQRv/zNmQSh5wdb/YjvF1FN7b1KL+aQFXzSJ98goWTPB
	uSY9KySBtziYR6nts/wkVbdMf6P0aiHG7LYSGVhzsW+z7bmfAeySqxq1QJhi/2+5
	NhUMAG+/6vZtyzToFbvJSO+SnXYPyiBQyNZ1cqiDIfrr6oSTmwZd6Qi7AZdD/l1f
	hYZrKNHn5JNypzTtYf4N7iTzF28vlBYOZnC0mXF+8H3u+jhhmYhxyR+qQawFe/0Y
	4AQdBuLF0SSKajxZUJn+9Vw4i/2GTk+MSBDC019O18V8HEXmzUO5TfIA+prxIits
	QTlgAu7fx5IxSipUFRBx3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795127562; x=
	1795213962; bh=8diG5IpF+frcATzn1tCDRrk4aGE/jCsGXdXvNn/J5ck=; b=F
	S/aneqPozRGzBrvFEQCufODXIgHQCEKW84Dt3KWjayayQMwzoCzpGC+khyeHYP4s
	vY796mGofLYA5D8Mr2xOYdRlmXzKs0k4kKfEiyn4GkcYSu/nah6Eg+1v6gAIrgR1
	cx7ySqPqP8r2wSsCGBS4D+nIUl1OAVydUrBD994UIphEhjIFl2g8YJRuV1t2HJbP
	4bhukU94Ye212LJmb+aWmpjDhYal+VB4Z+9irhY0i48/o3W0oTWo8HKoR7bzatNt
	Ta+AvLc9a8HlhsgsKosVPe3BM0kYS8lNOUZk0DhCz4zNk2sTmMeVTKgPdb9W+Tg+
	Q8LpnFG9mIFfnomKkJQjg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795127562; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:f99cfhqqudxSMI95+i8SIwrjiBRB6RSIsUUX5t2+gYmv7yA
	yrThgGG8IMh02ADlxJOCbSQ2TyDHX+to9otyIxW7PDajDGjoG8aES4rvW/mpzMzR
	SwgTaD991Yp8P4fJfojEvmyUclcYeCrE5lAKKcfRov/r8m8SDIo3iqeEUd9KcYQM
	R14fu6JHITtngNuvYKVXBOWZtQWxtxhl305iurmVpqfa3Tez1RV6sPB0fBcMi3lS
	fIXfggaIVUvCenJ6YVRQvqB7ywcgbkp9FDxcsx5JvXY+yrHHky/siiJFAb00ePih
	hjpsioVgNbio8wlz/V68yzd0sYkZ2vTQOzJCItw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AQNlEiex0ldxclYibpZOPfODfuT/zfuzD4Xg8gCmKWk=:bYeZfzXOr4Rhv4svyoyB+ZYS3EKLFU+K87x7maL3L00=;
X-ME-Sender: <xms:Cnn_ajdaAd7I0UhnxHZNkBHR-b7UQBrjQss8APYopmC6qDKUMalUIg>
    <xme:Cnn_avlRv-yjXsvP0GxpkVhBWrsVCPBSUXhFWEARzrwA-wW_S5lLI_G1Mr6_7U1Yi
    Pj8w3EURxx0wQkCLGFEjvjhrhCqJOWYe5viQy-1szn47_ZpclWfhFU>
X-ME-Received: <xmr:Cnn_aoy-l62MGZh2uIp5wwaZnF41kCT93qK64VeVR0_85di9mN0PU4Sn4e3v9w>
X-ME-Proxy-Cause: dmFkZTFZJhTXKlYSH79FRKyJqfUU3CwaZRjJx1rze6Hqz9Rw4v/3eoVS9nbaIjU+j5QFld
    jBsDPeSxNksX4fiXerstFo/n5mijIA7DHyU2Uqr3+pYjuaMveGp808l+a7lQhBB/AwjpHx
    1eY1jdSeGNpmlVc5Bq0Ii/d4Ki81EvmKUhP32WPEZlBLvsGKkKaX7VczVbLLq8eh3yt7FY
    HEwOnFCqEtKK72PL463J653AeU8vp+btN45J3a0FNhSBw0wGTvJ/Fg5etepjTNW7GJVYUm
    tfHG3I2Pt7vxb67gpwhwUzt56IibJ/RvVkhfrhWw+HTZySLla2FNaknyNpleDyrlRlc9Iz
    IJSZYj8acqhZR6XE+s/dT4mDWp3YbgplxUl92lZkJg3OKWUOFVzGl4BNJC0maEv7DxofYY
    YyNKl0s8UcAjEKkkl4B3memcieFCGUPXbBCW4H5WC+btddQKN4rqootnwLkDHrR/HIibSj
    puh1Okq+i4fqSFiHggpms4XsGkQt+k7o8AqltkNWxaD4YyrJ2Djmep09pzHL+cpcXs/Md/
    S2Bmlm1oHKPphDzFOo/0jFnzU0xi4GIaZrCiMxFR0AotzDJ7eNXnuN8jckY4xrFmI1Pmh3
    bHtIEhxRMOicBNTCGKPbg5eyhUPvoQQuIEh5mG5iWshwSJ8qdQVNtu9JTsSQ
X-ME-Proxy: <xmx:Cnn_aiyJS7VSubvwd397BMsClbu4xRXLFm_2-I6dEiwqGvBNcYMQSg>
    <xmx:Cnn_aoX64ENNZD9xnM9tjpZbISmuHJKcpBaU9A5PU9IezSBWITRmhQ>
    <xmx:Cnn_apR0JF7nmNr_DTGOPA95r-JM_u8KaFd1dtfHlX1ZGo9xmop9vA>
    <xmx:Cnn_agR-oCCEj1zp3r4-ju0ZOyln0t0eoAg-2YY1MRHgPjG0RRahZQ>
    <xmx:Cnn_ahpKGAyTc_yDWUvhvR17sWsbeu7_78gsuqX-UoZK4FBb91TrB7bT>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 17:32:40 -0500 (EST)
Date: Thu, 19 Nov 2026 14:32:37 -0800
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Message-ID: <20261119143237.4bf54796@shazbot.org>
In-Reply-To: <20261118163706.7138d246@shazbot.org>
References: <20261112235700.2029562-1-skhawaja@google.com>
	<20261118163706.7138d246@shazbot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Nov 2026 16:37:06 -0800
Alex Williamson <alex@shazbot.org> wrote:

> On Thu, 12 Nov 2026 23:57:00 +0000
> Samiullah Khawaja <skhawaja@google.com> wrote:
> 
> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> > upstream bridge before resetting the device, and skips the reset if the
> > trylock fails.
> > 
> > All VFs of a PF have the same upstream bridge. Take a device with two
> > VFs, both used by one process. When the process is killed, both VFs can
> > be released at the same time. The first one takes the bridge lock and
> > does its FLR, the second one fails the trylock and is never reset.
> > 
> > The bridge lock is only needed for a bus reset, which is done through
> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
> > resets the bus for it because the PF and the other VFs are on the same
> > bus.
> > 
> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
> > method enabled for the device is a bus reset, and only lock the bridge
> > in vfio_pci_core_disable() when it does.
> > 
> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
> > with two VFs. Both VFs are opened through VFIO and then closed from two
> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
> > both VFs were reset in every round. I will send a VFIO selftest for this
> > separately.
> > ---
> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
> >  include/linux/pci.h              |  1 +
> >  3 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7c6f2aba8144..c44e4d4d8774 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5256,6 +5256,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
> >  
> > +/**
> > + * pci_reset_needs_bridge_lock - check whether a reset of @dev may need the
> > + * upstream bridge to be locked
> > + * @dev: PCI device to check
> > + *
> > + * A bus reset of @dev is done through its upstream bridge, so the caller must
> > + * hold the bridge lock. The other reset methods only access @dev itself.
> > + *
> > + * Return: true if any of the reset methods enabled for @dev is a bus reset.
> > + */
> > +bool pci_reset_needs_bridge_lock(struct pci_dev *dev)
> > +{
> > +	int i, m;
> > +
> > +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
> > +		m = dev->reset_methods[i];
> > +		if (!m)
> > +			break;
> > +
> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)  
> 
> This looks like a maintenance nightmare.  What if instead we did
> something like:
> 
> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
> {
> 	struct pci_dev *pdev;
>    
> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> 		return false;
> 
> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> 		if (pdev != dev)
> 			return false;
> 
> 	return true;
> }
> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
>   
> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
> {
> 	if (!pci_parent_bus_reset_possible(dev))
> 		return -ENOTTY;
> 
> 	if (probe)
> 		return 0;
> 
> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
> }
> 
> Where we'd then condition acquiring the bridge lock on whether it's
> even possible for a function scoped reset to perform a bus reset.
> 
> It's a bit broader of a test than whether we actually have the necessary
> methods in our reset_fn list, but since we're not locking the reset_fn
> list between test and function-reset, it's also safer.  Thanks,

After exploring Ionut's patch[1], what I propose above is probably
wrong.  We don't have any guarantees that the sibling topology is
static and this bus-reset-possible function presents it as immutable.
The existing bus-reset function has the same race, but the gap is
smaller, let's not make it bigger.

There are however immutable properties we can test that cover a fair
number of cases.  For example:

bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
{
	return pci_upstream_bridge(dev) &&
		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
}
EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);

We should be able to use this as a condition on whether we acquire the
bridge device lock, in pci_reset_function() and in vfio-pci code.
Thanks,

Alex

[1]https://lore.kernel.org/all/20261119123504.25906-2-ionut.nechita@windriver.com/
