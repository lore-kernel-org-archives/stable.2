Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF1D422541
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979430; cv=none; b=GtgYhJmM/rNOM0r/OlRhbc5J2WDg5CpCPqRdXi/K3K3D/SZ71PIqtEQA9ehawfn+F6mWLLa/wYOmxukWPnvraRQ9nAOO5Jf0GWIyTJQzvouYh/J4oV7jDnp5jl8mgbhirhTve4PAvEC/TOPLMxF+YUW549ofTle4ktydVZPm/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979430; c=relaxed/simple;
	bh=KD9pntKicv6wGZwjlKMK4UFit6A6SElZVKcmmkZjLic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgbAEG2nj32616N2pPHRlGPyBNQqw5iMJ9aNC+oT5JI8bfnHFwj9afOyOtmZ8jSYWV0dhJSyasIPxWQxMBujxvixKBZmckCV/wHmNdqI1D0IZNQkwb8DpcFAD8+FkoPv+Ktxz21oJd7qPZUcwcP8ElB0RhEOy+Fpr17D98YHcm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWiF8Otr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWiF8Otr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389D21F00A3A;
	Mon, 17 Aug 2026 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786979428;
	bh=Eo2+YfxM63ujcSnJDyWIW/AYTNaxfj+sSZ6E63Xt7EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GWiF8OtrLKaPMx47NgR3aA3GaVU99i413uugrlObg9GGI18V21ou+/4eV3w3iTZw1
	 4lFs5PFA1CGnskE8zCwVI4ZMrcPtArjTFnJ+9S6Op1Iqy84C+Pxf3k2N53XxhiBjv+
	 8wKsvSTclRO8b8f7dwYurRMvm6er5Y5ihYa3p4JWBkBHPo0Vs0MuGG+YsJ4nq3aL+e
	 7eGiQvbTYB60h4aVqZkGX+tvI0Rp8fCK3ALtxYqtQ/tzI2S2htcgRwxdpMwRXKox2M
	 wQXeF0ItWWPom0dI9nopDOp4lqrJD6X21sTQREeOgcr6CapeNs3bWLgipb6Y4d347c
	 y3IQa7ICLOTkw==
Date: Mon, 17 Aug 2026 17:10:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rihyeon Kim <rihyeon8648@gmail.com>
Cc: justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	stable@vger.kernel.org,
	syzbot+f58e57380a6083c4041d@syzkaller.appspotmail.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when
 nvme_add_ctrl() fails
Message-ID: <aoMkX_davK7TWlaj@ryzen>
References: <20260814143833.1953415-2-cassel@kernel.org>
 <20260817061815.154794-1-rihyeon8648@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817061815.154794-1-rihyeon8648@gmail.com>

On Mon, Aug 17, 2026 at 03:18:15PM +0900, Rihyeon Kim wrote:
> Hello,
> 
> Thanks for the explanation, and for picking this up.
> 
> My testing of v1 and v2 never reached this case.  The syzbot config has
> "# CONFIG_NVME_HOST_AUTH is not set", and I was not aware that the
> dhchap option tokens are compiled out when it is disabled.  A connect
> string containing dhchap_secret= is simply rejected, so every run I did
> tore down with ctrl->dhchap_ctxs NULL, and there was no path that
> dereferenced ctrl->opts.
> 
> I rebuilt with CONFIG_NVME_HOST_AUTH=y and swept fail-nth 1..200 over a
> connect write containing dhchap_secret=.  You are right:
> 
>   clearing opts at out_put_ctrl:   dies at attempt 20
>   this patch                       200/200, with 35 of the injections
>                                    landing in nvme_add_ctrl()
> 
>   Oops: general protection fault, probably for non-canonical address
>         0xdffffc0000000008
>   KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
>   RIP: 0010:nvme_auth_free+0x99/0x450
>    nvme_free_ctrl+0x231/0x6c0
> 
> The injection for that attempt landed in kobj_map() under cdev_add(), so
> this is the nvme_add_ctrl() failure path.  ctrl_max_dhchaps() then
> dereferences ctrl->opts at offset 0x40.  Clearing the pointer really does
> just trade the double free for this NULL pointer dereference.  Good catch.

Thanks a lot for verifying that the Sashiko comment about the NULL pointer
dereference in nvme_auth_free() can actually happen, and was not only
theoretical.


> 
> Your version also addresses the two things I was unsure about in my
> earlier mail: fail_unlist: covers the two exit paths after
> list_add_tail(), and checking list_empty() while holding the lock keeps
> ida_free(), put_device(), and nvme_fc_rport_put() on the unlisted path.
> 
> Dropping my v2 in favour of this one.
> 
> Tested-by: Rihyeon Kim <rihyeon8648@gmail.com>

It seems like Keith did prefer your patch, but as you said, your patch does
not avoid a NULL pointer dereference in nvme_auth_free().


My patch should also avoid a potential sysfs NULL pointer dereference as
reported by Sashiko:
https://sashiko.dev/#/patchset/20260811125310.165487-1-rihyeon8648%40gmail.com

which is currently also only possible for fc.c, because of the
'ctrl->ctrl.opts = NULL;' hack.


Personally, I prefer this patch, since it makes fc.c more similar to rdma.c,
tcp.c, and loop.c, by checking if the controller is on the linked list or not,
rather than setting 'ctrl->ctrl.opts = NULL;' before the teardown is even done.


I agree that this patch adds more code than what we ideally would have wanted,
but I don't see any other way (other than completely refactoring the ownership
model of the controller options - which would require much bigger changes -
and would most likely require changes to both fabrics.c + all the different
transport drivers).


Kind regards,
Niklas
