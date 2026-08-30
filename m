Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129A35C1A9
	for <stable@vger.kernel.org>; Sun, 30 Aug 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074691; cv=none; b=YYTT+Ogyt0hhAvXdVLBHZoqNZVQ42rkMi1oTAgDk0juztEh0ocBAKEOwSii/C2tJPlJinguguBhWiXHFx5jVWW0zK5iQq5ilooxeTf/pCWwFa9Tpxc2JI9oPu/A5S9LVoaE8JlLeGgoYkCwCHEuSu0AWOAAqEVuztGy+oIsU/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074691; c=relaxed/simple;
	bh=j2NQxGOyIEgujt7MVNsdN+ZkZXsac/MIFBAmPqCpIlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5ktiH1W50i9g82rBpO4+pRs4wsIauoJF/uqdvfE1bRlZCSChIrTECEOGPSDSKFzBOvG4aBtwly+nO5rlEpd6aUe6nDbu1xIUh/N55UAEF6/Z7eFC92MHvaHUn7gTEXuIfCim7luzBE+tgGI7ceywhA75hkf2aEYNuVrSPoo5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHzxqBdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHzxqBdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B611F000E9;
	Sun, 30 Aug 2026 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788074689;
	bh=Pa4OjT2/bCWmh55nSDPp7yDvIxE+7SneRGI4Gpi1YMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QHzxqBdpkvzqrr3X/4eqYLmGsG/PST6tkEsWaLhzGduN68YwuDEpUlg/g9WvFzzXK
	 3ggKq4p+IkaE0O0eyKozXukUfZwBaWq/lBte6edxwOQBIYmL+yikwKlHkzN+VIvBK2
	 PTDneFS4njhp77SXXoGjjOQqES4AsMBkESCTtAq0=
Date: Sun, 30 Aug 2026 09:23:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kanishka De Silva <kpskanna1915@gmail.com>
Cc: tom.leiming@gmail.com, security@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ublk: clear VM_MAYWRITE on read-only ublk char device
 mmap
Message-ID: <2026083059-next-process-bd8e@gregkh>
References: <2026083055-isotope-broiler-88e5@gregkh>
 <20260830070133.559-1-kpskanna1915@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830070133.559-1-kpskanna1915@gmail.com>

On Sun, Aug 30, 2026 at 12:31:33PM +0530, Kanishka De Silva wrote:
> ublk_ch_mmap() rejects mmap requests with VM_WRITE set, but never
> clears VM_MAYWRITE on the resulting read-only mapping. This allows
> a userspace daemon to mmap the per-queue command buffer PROT_READ,
> then upgrade it to PROT_WRITE via mprotect(), since VM_MAYWRITE was
> never cleared.
> 
> The command buffer holds struct ublksrv_io_desc entries that are
> kernel-written ABI; a writable mapping lets an unprivileged daemon
> process corrupt fields such as addr, op_flags, nr_sectors, and
> start_sector.
> 
> Same bug class as the drm/panthor and drm/vc4 VM_MAYWRITE fixes, and
> the 2026-08-13 ptp/vmclock fix (a5edadbae57e).
> 
> Verified via mprotect() PoC: before the fix, a PROT_READ mapping can
> be upgraded to PROT_READ|PROT_WRITE and a write into the command
> buffer corrupts io_desc fields (confirmed under KASAN). After the
> fix, mprotect() returns -EACCES.
> 
> Fixes: 3fee8d7599e1 ("ublk_drv: add io_uring based userspace block driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kanishka De Silva <kpskanna1915@gmail.com>
> ---
>  drivers/block/ublk_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)

You only sent this to the stable list in public, and didn't cc: any of
the relevant maintainers or the proper mailing list.  Please use
scripts/get_maintainer.pl on your patch to determine who to send stuff
to.

thanks,

greg k-h
