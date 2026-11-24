Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535338;
	b=IqLFC0dE/1Ic4k259jIbg/PK9+vqGp7gyr/m8gBNTAeKP5r4RCPyM0rjNDlKgJW6WZG0
	 8zCJQOvVRghYwZn2J+QdWVWGRS6zWHnr9hYcIF8YkiuXvel3F73cuz0E2g0HZj1Bj3/kP
	 KsTXvra11ZQADvBhuSUQ74BYtk9+DSC8BPC4NvKNl4x2r+h2Qz40XBv2RSfsn48ZUBZzf
	 4iPng2xLkeLIz+qYLbykSYACtpN02I8dgkbMjthCdo5j4WlX1BCMa2q/dSE4FYXV8DXbm
	 WURZa3r2y9dUBe6gdjNy+pMB6NGG8/bua8KM7lQ2S8sdQe8zPn0nidjfZYNtrfsrDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535338;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8mynfBTXLTLRL08nBCH75GUqigjj9nkhtx3ZV0Dcgmc=;
	b=Bo5bJ9i8UiXbshME70viqWLeysaZLYj0E6JsU89K3znWIuVoJGJQZ8htnFkrGL4vmCAF
	 C/KMb8bB/XPendlrbFvA8O2ZgalVxC1uyJcQ4sswxdR0dCXE26Y5oILcUf4hobK8FFESJ
	 8a/dhElS4y1TO8LwkLlu2+hmeAL5Wj3B+HYfhy9VJ7zThHJ8rtsNtMzvZR/0aO7WQt1jH
	 wc9hC1FBGMqnn6ayf+2pusd/WyE7fafKytbvSGBKSAZni4St86Aldz36GiDw8wjb74WVJ
	 b3ChLvWQdZTS9HYJ0683OQjBytzzjCr1fpvbHs33LUYQK3UJLad0uv7akAwFYHyoi5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=vmabcQfE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TqKYbNy6;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFB2606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFB2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=vmabcQfE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TqKYbNy6
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 87DADEC097D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:48:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 10:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795535335;
	 x=1795621735; bh=8mynfBTXLTLRL08nBCH75GUqigjj9nkhtx3ZV0Dcgmc=; b=
	vmabcQfEeBSTqCtiQa3TgJOQYWTGwXQn0jhifjm94rlTqHi9MSJfIlluNp2IDaXn
	xpFqR06/eGsyym4w7slLy/YRueYPc3e+6wV0fwHEkZyQhbhNukyf0rR5IHT2HZW3
	Qsz+QF93rb28mosdW58zBKaTAQu0wbXcgwXF43e8oQNAb5KlfIMzArl9DGJJkzud
	qgoNSRZ/WAomTo4ijMw/nxMoyxAfF81t4xt1nEZ1pYYkqJGameCi87Ee7d5ZrdkK
	+C8+2HKUyqViLVuth1dfIgW6V+47LCDw4QtvA9xh0OdD9xb7MyellYS7+LJsrrJN
	E/ZyUMjVXnyQ4QMqo/JVww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795535335; x=
	1795621735; bh=8mynfBTXLTLRL08nBCH75GUqigjj9nkhtx3ZV0Dcgmc=; b=T
	qKYbNy6cQnnXUkLZyZby7hya+QwPh7RD4QutQNP/0zcgaXVx+W34n4bnN+WFSbpe
	E4cRXGIUj/k4+EGkA53n7O4M7sF9eiNKhODXm4xFB1Fgi8w6wn2YBdY1f5FYcmrH
	svaRUgWJGETEBajlNekdEt8+V73VA2WRjH32k0BRs0vCcm4zEE7xw5QEdlh17IHB
	a8KykxBnpVzKm8JKBiJ1s/zU0o0wKJZO77ZqWGMZeqr3hGEj46+VgsoKfBSKHbaQ
	7vquAQ6W30p4zJuBDCCo5L29R/6384/ThpK502SsfiKoYj6XCx15N7tAzltl4Enp
	AP4rar6tiorTwPgpSHaSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795535335; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ishv6Fwr+4J7t3o+rEuJ+zNIXNDuKq2DFYhuask7pmixtGn
	NMXVXb2kiPHspJVcK47TvgM2Hp6ehOMPQx/zvfK6r0T+jis1cIsp/ChYGjaR09Y9
	AQg7GfKN6F3SXPq8MjgK17uryT+tzt75eKEZrtpsu7/Dp85NkYdPmC81GIuas3vi
	WqgzD88Lx/Y0cugvAiJZ5wbvy0umvJQV2lbP3OrI1pX9rSDpQ4pbI3rCRks2Arhd
	Q706e1umbMc5HKDipoWTx7NmAHUT02uT56yyGvLwEIbq9OZykYyqeyWttKfmG1DF
	x3sYYOxv/cJtVOSSvYjkO+TJRV42oVl9c6yGMqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HVz3vmfsL2H6NQMvLHM+YGN1J2vDoLIcqITeDiwIIWQ=:ONVX5rzH48Ec8Y3m4PXq9ipVT3IfEVRmxwNxufszr1I=;
X-ME-Sender: <xms:57EFa7TdtCNP8WeaCPIBToMrX0jM5bptjHZX2qQmkYbkumDWdqrVOA>
    <xme:57EFazKcjH-TbCrBqvJjBi7KJwhXnhWUwjlr0-f-EuvJR-1F_kG3xfYnDzQaQ7-hB
    n1KK4hutEWtjqm2Q-Mjk8oBcaU3FNbaxR6gyDhXki-VKcyQeIG_r6E>
X-ME-Received: <xmr:57EFa9GOO3qb3bSkF4M0Mg4bTomxgzP1M4sscGPCzQRveWM7Dvah8NJF1SXcmA>
X-ME-Proxy-Cause: dmFkZTEABe8AGurdNXDO/if1oYlc8MDAkW1gbQGMMfJXgZWY8W4a59MOzUpx7ds+yqFlGp
    U6BODVQeglpIHXyHQPXnFZ7bOEWFVHAkSwkxYDWQ+QDt5pBQ1j04sR0bEOF7YR2CQ2Do26
    b4r0chTt0q9dmm8Im1spKiygwe3W5B0P0V4IrNLsLdAHD9A36MZD+FLHAOvh48LrqLBHZF
    H941Nba3PikloQWW5gfWH0XB27bA1VVnzHA4VtVp5u7hJOaICtrbbLpCmLhF1uciQUkzOV
    oEHzZb6yfG6l0PI0lAEBa60sglPmq+gSYCekuKTAPOhdYmwzrtDw+e+gY+M3qKCouYUTFg
    pnDZOS4vYLHHWWOuw3jlFuykVriCFmbSoO+8Q+OdfsarNS9emuP5kDOdm/weBXKd4JNuOJ
    arw4sVEiXFjHDEEzvVhcQAL5nNsot94+ZYeRfuxC1Qk3wi7VR2dDefgMFmuAMvnlCUSv9p
    rXiYVP+Wyy5Rr+oTqfC5nCZNum80cOXfyyMceaF0kPLuECFe60u4LC9Kcxg1npXoFL+Rdc
    ov2wDHlLM4Z1mwz3Eicy5IVuz9Wz+unWgU0IRGbpERoP9H13Jko2zTZjRZmIkH8gGXSpkP
    /CCxHxL+BJgC4wAACNZH69v1b/+IsAAWguq5ROF4qZkQ00CNwuy22vn722ig
X-ME-Proxy: <xmx:57EFa400xdk1rBTpyDNG-UxLdYmT3DFClQDV0QLVApm5JiQ9L91UfA>
    <xmx:57EFa9IYFDeqk0B3LiGiJrAzvomN8vGgJUE7mK5BGIJGHBGcBne-xw>
    <xmx:57EFa12JHY1RFpfXtWT_BYt5OP5eRpcyJJyOnW_5Fx7l-WEUy3k-6Q>
    <xmx:57EFa5ntpmAkA1EEg39eU8-I7L-FFbvPqOUoJTAtaaYX0suYHeDu1Q>
    <xmx:57EFax_pqzL2OXK39fcIl5GKLNrhN2d7AykV9mcTtWNxhnhLg684VT2U>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 10:48:54 -0500 (EST)
Date: Tue, 24 Nov 2026 08:48:52 -0700
From: Alex Williamson <alex@shazbot.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset
 may need it
Message-ID: <20261124084852.661dd7c1@shazbot.org>
In-Reply-To: <awC5Ldqmue6DiO44@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
	<20261118163706.7138d246@shazbot.org>
	<20261119143237.4bf54796@shazbot.org>
	<awC5Ldqmue6DiO44@google.com>
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

On Fri, 20 Nov 2026 22:21:16 +0000
Samiullah Khawaja <skhawaja@google.com> wrote:

> On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
> >On Wed, 18 Nov 2026 16:37:06 -0800
> >Alex Williamson <alex@shazbot.org> wrote:
> >  
> >> On Thu, 12 Nov 2026 23:57:00 +0000
> >> Samiullah Khawaja <skhawaja@google.com> wrote:
> >>  
> >> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
> >> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
> >> > upstream bridge before resetting the device, and skips the reset if the
> >> > trylock fails.
> >> >
> >> > All VFs of a PF have the same upstream bridge. Take a device with two
> >> > VFs, both used by one process. When the process is killed, both VFs can
> >> > be released at the same time. The first one takes the bridge lock and
> >> > does its FLR, the second one fails the trylock and is never reset.
> >> >
> >> > The bridge lock is only needed for a bus reset, which is done through
> >> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
> >> > resets the bus for it because the PF and the other VFs are on the same
> >> > bus.
> >> >
> >> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
> >> > method enabled for the device is a bus reset, and only lock the bridge
> >> > in vfio_pci_core_disable() when it does.
> >> >
> >> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
> >> > Cc: stable@vger.kernel.org
> >> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> >> > ---
> >> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
> >> > with two VFs. Both VFs are opened through VFIO and then closed from two
> >> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
> >> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
> >> > both VFs were reset in every round. I will send a VFIO selftest for this
> >> > separately.
> >> > ---
> >> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
> >> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
> >> >  include/linux/pci.h              |  1 +
> >> >  3 files changed, 31 insertions(+), 1 deletion(-)
> >> >  
> 
> [snip]
> 
> >> > +
> >> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
> >> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)  
> >>
> >> This looks like a maintenance nightmare.  What if instead we did
> >> something like:
> >>
> >> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
> >> {
> >> 	struct pci_dev *pdev;
> >>
> >> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
> >> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> >> 		return false;
> >>
> >> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
> >> 		if (pdev != dev)
> >> 			return false;
> >>
> >> 	return true;
> >> }
> >> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
> >>
> >> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
> >> {
> >> 	if (!pci_parent_bus_reset_possible(dev))
> >> 		return -ENOTTY;
> >>
> >> 	if (probe)
> >> 		return 0;
> >>
> >> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
> >> }
> >>
> >> Where we'd then condition acquiring the bridge lock on whether it's
> >> even possible for a function scoped reset to perform a bus reset.
> >>
> >> It's a bit broader of a test than whether we actually have the necessary
> >> methods in our reset_fn list, but since we're not locking the reset_fn
> >> list between test and function-reset, it's also safer.  Thanks,  
> >
> >After exploring Ionut's patch[1], what I propose above is probably
> >wrong.  We don't have any guarantees that the sibling topology is
> >static and this bus-reset-possible function presents it as immutable.
> >The existing bus-reset function has the same race, but the gap is
> >smaller, let's not make it bigger.
> >
> >There are however immutable properties we can test that cover a fair
> >number of cases.  For example:
> >
> >bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
> >{
> >	return pci_upstream_bridge(dev) &&
> >		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
> >}
> >EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
> >
> >We should be able to use this as a condition on whether we acquire the
> >bridge device lock, in pci_reset_function() and in vfio-pci code.
> >Thanks,  
> 
> This sounds good and it will also fix the bug that I am seeing.
> 
> The only caveat is that pci_dev_wait() might fail during VF reset and
> then it might try to do a bus reset if the VF is behind a pciehp or CXL
> port. I would prefer to do it only for vfio-pci code as that is where
> the reset skip issue is. pci_reset_function() takes the lock and
> serializes the VF reset. Are you ok with doing it just for vfio-pci?

I think the test I'm proposing precludes a bus reset, ie. there is no
upstream bridge, the device flags prevent it, or we're provided with a
VF.  It's only those cases where we can't do a bus reset anyway, that
we can skip the bridge device lock.  I think that means it's useful in
PCI-core as well as vfio-pci.  Did I miss something?

I do see that cxl_reset_bus_function() only does a cursory test for
probe, but then calls pci_reset_bus_function() when it executes, which
is an inconsistency issue of its own.  Thanks,

Alex
