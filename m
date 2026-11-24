Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557468;
	b=eLikwDFsa1TMA55HmiAy2g5VWRlJWwKbHhHyzmdMMWZiVVW/hHOz3I0XCtJbcBSTsXWN
	 pPu9ON0n4zj1DaCvepjln6bUc3bEcUTaUZAtZ9mzs93O421iZfxuuZDE/0Pvv1fa8jGJs
	 mPV1N5X12jjjKBTgpYyhAomUhvYVzlkaUlCZYBHGpseS8QEAkco/qvMoJyMDKgh0BvS2q
	 0/NrIco4Aix/0l1/qEAkE/oLi0ZBK6ri/m/PZ4AhNzRSCvwKtw3emwfdrEzOBlxzuHRrp
	 v2X0ME7xKkD7Rxz3AVGRvbEn0NnV3t9wHHKO1wtMOX2wWTBJ+MdWAWitLmewVJQ5WnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557468;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9Yv7ZAdiUHDpW81//zWyyNLibVyhv0xcmjQ86w+dwHI=;
	b=Mog944A2fuo7aifyOmA5Sw2tImm1hXsWd/BITUmNYDVS5VOB9CgMW5KEFiA9PY1YCvx3
	 Zk7T+2OphATXMjDLGd/DuyiACBG5Tt5lHwdSzv5G58bFvLZjZ+N5RpPh7/voBsXEOzfdM
	 cLnUQd5S24+cVjNSsY25WZZUwpkXQSSFdWAF1dJm+vsClAMtmxcgve/l1cgxIzYcceYqK
	 pG7Ty2SaVBUQCNAAZphelMDePEXA8GutWyapjY+iJ9EsCetq6AlBACAmbQGko2FgMcTNC
	 IKJ3Onnng8AdtT0SIV+qf6vdH9u4dgcjZO14MENuadS9ervuLaMvH48Pp0XknhqX/iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=q+ncxwGB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y+SsJFBU;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CE606A333
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE3CE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=q+ncxwGB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=y+SsJFBU
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32D227A05F3
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 16:57:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Nov 2026 16:57:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795557465;
	 x=1795643865; bh=9Yv7ZAdiUHDpW81//zWyyNLibVyhv0xcmjQ86w+dwHI=; b=
	q+ncxwGB2eC2X8922FtbouccjPHt98aXJie1SKJXZ9+OSbbcSEZ9wZVzeNGqj3z/
	ps0UCCtahJuAg1nSWyrNpgFH4nomwUCMnMW2wv2lgo1Y76V+34jHSW/onmqvTHzk
	ZDDS1ZB6II73GtMaU0aL0dusMwSZ0iNAGUYn+7FwDURNMwpEPaY/KqlOR8L1pfp+
	yw1ybER66YYvTs7EZ1XhOGDETfmbpLolBfBAs7H8b8p1dnlA4lpRIss4a4TeJ0VN
	i24MiI0LqqMk87zvlekOJ37/HyN6MA88zdC3j/iz/u7zlmX3pfDhV5My/2iIDbH0
	lZ85HHEu5hTTLLVpr9GJRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795557465; x=
	1795643865; bh=9Yv7ZAdiUHDpW81//zWyyNLibVyhv0xcmjQ86w+dwHI=; b=y
	+SsJFBUnH3zMjMim8abO+u/YXXBtXLtF64p3fQG6DzYX11LTLZLmr2Qlrgo0yd2r
	DB9p/GC6bBoFObgI8wQCDYCX2PaobJPoPOMBRwmnytJnOnc7F4eYT/Z6x50Qg5fS
	vWk43A5INm6bPWmjRNfU7Va1frRGVqNP8fTWZQKDkTmGEX6U5fnxbNJc7OTStbaB
	YopCDE6bnjkt0qOqc9nSaH59C07BSY7tnMWqjAw6O69cnPLVVYHDsF7NPixbyDxB
	VdZVwsVc7I5iYWxg/ggm1pGDgBhq33MOdp3fcdsbqo4nmKK8NLbC88ZOmPVuLqXv
	kJQtCs0iUV3JIWotWUfMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795557465; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Olg2e6MFPMkoc1TNgQXPCa0o9Wct+KTt8VtbrAYrrxvRGXO
	DGllT2iu2/xx2KIYQEt9ha61Npiv+9HdgB5Lvpt1hRuJtDP922a357Kom2SN2Rbb
	RT0S10aK9A6irPJJQs668HR7QvZxHmGzdwhmHdqdHkD+g8dG3dCevYOh7axxNwTr
	QR/4QLurKWfZVziWauWtRurytJypBvzuHbmU+LscQUBP++03pMtQP8CGLj0wqx9P
	UimFr+41U4O8z7fRqnbwkM6OYvWiG0pdaHTVSQSfDOJ0INZIhTyfdguv3WLx7h0Z
	wBCThGZufq+/sFkrnCXsOtatTSBd90R/dppGVOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:r0gyNebnJU3UYgucvnT7f/jFp2fby4QNwszEbkpKrnE=:cKsT+oAcYb7z5Bpv3lzNYNeRW+zt7bHiR0+cduq9CFg=;
X-ME-Sender: <xms:WQgGa7cKfEYAtAsGtqKIn4KkcASCCT5cqkKihgija1m4U7gX5YgDUA>
    <xme:WQgGa3l4j1kTumDC7d8gSjmYtDoQqBur8Mk1rC9AG0g7WVf-dYO86QmopneKdA5pj
    f2V4NdvsczTYP2tE3_RVwJCTbeZ6TJrsYG7cIy5ru-VyymX2ffQFw>
X-ME-Received: <xmr:WQgGawwjz4L5qvuQWOfJJQrA6duBBo48xMYs1-RKXmEzPLIlWhIAdwfKkriEsw>
X-ME-Proxy-Cause: dmFkZTElwk6m6nbbF8uFMkjosXYbuLtxokx9cW6je6krn/5+EOP5V5lCgGfnrEKHccNsoE
    NgvX2qSuNcLlbhGbSz4MjXSC+gJwt/HDrrfkV+weSIT6TvDvvyMcKpdYdcwqKWCHaU7jQr
    3irHVChJiG/EpzAZG0XU/r8T8YOtVfGoH0yLbYbDEYC5NnG0kQv5nXW+1V5t9QpAZWHwTx
    RaqrGewtwOb+OKhC/UxSEzuFoKkarWNV4Jxv+QZLL+toPxQp4wDfY6ZTSa+jycdFy7KJ95
    mjxRLXAXb4bMBD0DOynd3RsHE2l+B3415/SabQ1oJzTx7mMk1JlRt9TKn5Pgs7DghJOPSc
    /J+/jPBTVHYeWELTdAJE0XnaE5kV3eEOV1W+n9jr1rNQfKrP7SXsItnkmy6a8JOajIOMYT
    pT3Q0PlrXKquyHIv8JtjvEVsF+y4embac3PE6nSD7uQy+Ceh4ajIloXQq/AhPetpCIqpcb
    5vp0+fKw+LZQhkuLW9sDz8nttYYnfq8MOjXMdt+k0kn6w7XW/V9ZfWbiA7Mh9Tk2bDV7cH
    kjczU+v18/6V78Kt2WKqXaSQw5ADVUzf8oZtX0wT8wVYiySz+51mSVJbtpmHCw68Id7zqc
    rCYj9cxZeKUFmkarzujzic7gJyXpbIo0Dy19o/PFdE4V7FKIhVG+GsVaFnJw
X-ME-Proxy: <xmx:WQgGa6xTLOhF2cDVq2sfBfAKMzFDhS-cuDHNglrjQVeFuKyMucI5IA>
    <xmx:WQgGawUzhpEbPfHpqJ7UZbJNy6e9WpIAdWjleI5OZi9Ez6czFncnSA>
    <xmx:WQgGaxSDQPSjsoIPftGqvmhrHFBt_oAm7p2Mi7_iAkgMEVgvob1jpw>
    <xmx:WQgGa4SqmZ1cdsLMUonpuITUSKh3fWhtNQggJQfo6h-NFvZOC24AQQ>
    <xmx:WQgGa5qOJsJv75S2miF4Gtag6lXLgGh1Uk8_L_KkC94n06H-nG2KAGRC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 16:57:44 -0500 (EST)
Date: Tue, 24 Nov 2026 14:57:43 -0700
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Message-ID: <20261124145743.6c253bd2@shazbot.org>
In-Reply-To: <awXedVCoT7M79Rk5@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
	<20261118163706.7138d246@shazbot.org>
	<20261119143237.4bf54796@shazbot.org>
	<awC5Ldqmue6DiO44@google.com>
	<20261124084852.661dd7c1@shazbot.org>
	<awXedVCoT7M79Rk5@google.com>
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

On Tue, 24 Nov 2026 21:04:57 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> On Tue, Nov 24, 2026 at 08:48:52AM -0700, Alex Williamson wrote:
> >On Fri, 20 Nov 2026 22:21:16 +0000
> >Samiullah Khawaja <skhawaja@google.com> wrote:
> >  
> >> On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:  
> >> >On Wed, 18 Nov 2026 16:37:06 -0800
> >> >Alex Williamson <alex@shazbot.org> wrote:
> >> >  
> >> >> On Thu, 12 Nov 2026 23:57:00 +0000
> >> >> Samiullah Khawaja <skhawaja@google.com> wrote:
> >> >>  
> >> >> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> >> >> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> >> >> > upstream bridge before resetting the device, and skips the reset if the
> >> >> > trylock fails.
> >> >> >
> >> >> > All VFs of a PF have the same upstream bridge. Take a device with two
> >> >> > VFs, both used by one process. When the process is killed, both VFs can
> >> >> > be released at the same time. The first one takes the bridge lock and
> >> >> > does its FLR, the second one fails the trylock and is never reset.
> >> >> >
> >> >> > The bridge lock is only needed for a bus reset, which is done through
> >> >> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
> >> >> > resets the bus for it because the PF and the other VFs are on the same
> >> >> > bus.
> >> >> >
> >> >> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
> >> >> > method enabled for the device is a bus reset, and only lock the bridge
> >> >> > in vfio_pci_core_disable() when it does.
> >> >> >
> >> >> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> >> >> > Cc: stable@vger.kernel.org
> >> >> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> >> >> > ---
> >> >> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
> >> >> > with two VFs. Both VFs are opened through VFIO and then closed from two
> >> >> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
> >> >> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
> >> >> > both VFs were reset in every round. I will send a VFIO selftest for this
> >> >> > separately.
> >> >> > ---
> >> >> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
> >> >> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
> >> >> >  include/linux/pci.h              |  1 +
> >> >> >  3 files changed, 31 insertions(+), 1 deletion(-)
> >> >> >  
> >>
> >> [snip]
> >>  
> >> >> > +
> >> >> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
> >> >> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)  
> >> >>
> >> >> This looks like a maintenance nightmare.  What if instead we did
> >> >> something like:
> >> >>
> >> >> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
> >> >> {
> >> >> 	struct pci_dev *pdev;
> >> >>
> >> >> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> >> >> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> >> >> 		return false;
> >> >>
> >> >> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> >> >> 		if (pdev != dev)
> >> >> 			return false;
> >> >>
> >> >> 	return true;
> >> >> }
> >> >> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
> >> >>
> >> >> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
> >> >> {
> >> >> 	if (!pci_parent_bus_reset_possible(dev))
> >> >> 		return -ENOTTY;
> >> >>
> >> >> 	if (probe)
> >> >> 		return 0;
> >> >>
> >> >> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
> >> >> }
> >> >>
> >> >> Where we'd then condition acquiring the bridge lock on whether it's
> >> >> even possible for a function scoped reset to perform a bus reset.
> >> >>
> >> >> It's a bit broader of a test than whether we actually have the necessary
> >> >> methods in our reset_fn list, but since we're not locking the reset_fn
> >> >> list between test and function-reset, it's also safer.  Thanks,  
> >> >
> >> >After exploring Ionut's patch[1], what I propose above is probably
> >> >wrong.  We don't have any guarantees that the sibling topology is
> >> >static and this bus-reset-possible function presents it as immutable.
> >> >The existing bus-reset function has the same race, but the gap is
> >> >smaller, let's not make it bigger.
> >> >
> >> >There are however immutable properties we can test that cover a fair
> >> >number of cases.  For example:
> >> >
> >> >bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
> >> >{
> >> >	return pci_upstream_bridge(dev) &&
> >> >		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
> >> >}
> >> >EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
> >> >
> >> >We should be able to use this as a condition on whether we acquire the
> >> >bridge device lock, in pci_reset_function() and in vfio-pci code.
> >> >Thanks,  
> >>
> >> This sounds good and it will also fix the bug that I am seeing.
> >>
> >> The only caveat is that pci_dev_wait() might fail during VF reset and
> >> then it might try to do a bus reset if the VF is behind a pciehp or CXL
> >> port. I would prefer to do it only for vfio-pci code as that is where
> >> the reset skip issue is. pci_reset_function() takes the lock and
> >> serializes the VF reset. Are you ok with doing it just for vfio-pci?  
> >
> >I think the test I'm proposing precludes a bus reset, ie. there is no
> >upstream bridge, the device flags prevent it, or we're provided with a
> >VF.  It's only those cases where we can't do a bus reset anyway, that
> >we can skip the bridge device lock.  I think that means it's useful in
> >PCI-core as well as vfio-pci.  Did I miss something?  
> 
> Yes, the slot reset probe doesn't account for the VFs and will allow
> reset of the slot when hotplug is enabled.
> 
> I think that is probably a fix that needs to be done orthogonal to this.
> I will send a v2 of this by doing the needs_bridge_lock() as you
> mentioned above.

Yes, there might be a latent bug in the slot reset path.  I know s390
has some weird per-VF slot reset, but they set the per_func_slot flag.
The test in pci_dev_reset_slot_function() probably needs to account for
both VFs and multifunction devices as:

	((dev->multifunction || dev->is_virtfn) &&
	 !dev->slot->per_func_slot)

As you suggest though, that's a separate fix.  Thanks,

Alex
