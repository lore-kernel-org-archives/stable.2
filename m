Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B54FD78F
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575536; cv=none; b=VSu6ZEu+0z+fPqKjNswGmPVqJzHd+P6COyxmHSVIyGB8xZdtMfuXuc67JqZnfxjs1gSWgXW22LVxzIiQhCUSeX23azPzRAG5jnshSefyM1D5indBLV/gYsPa76gc1EgtZEGdUkVUlYb6oWkZ+MSMqbDxcrnZvK4izCqind1IUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575536; c=relaxed/simple;
	bh=2dO3jhPiXoWuEJOubq3f0+uDHGWe68stZOsl++yRYnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDMnZFPvA19G7g6vXVKLprBTUDpJBD/mpi6r1dGgMG4eJFjQMsvAgEVEUbRM+q+Na4lg+nLbHQWv7Gu9eWT89plpj0At2sqrmZNSAtSbmDaLxXhr12enknLgkzSUHQ281wB/eCsoIz0pje5+G9qTMGxnmOsPDOZx9m1nfSiVvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=wdibMF1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNtiO8zd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="wdibMF1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNtiO8zd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FB3D140013F
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 15:52:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 09 Oct 2026 15:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791575528;
	 x=1791661928; bh=E7AWcJX7TLChvl9+qNbThRKCUMFRT4ZevpHDsMG4dTA=; b=
	wdibMF1qDeM0MOL8A1H3dKv+GPU3Vp63YWzxxnys1g9DTNu3A4a09sHsY2o1MuIR
	CuVOO7PYj6TIC8ehoPm6e87rroXgWilLFcROtLqraGcOcDSlz6JRMgNayhTSRn9g
	DgBcMhqs8uTYnmuhCpoKJFqsyJQzhnLm3wvePublwFCI8jMBnAjjR8R9vE19xfll
	9KEfMjedYi6hLHHv1PNmI9lYEJTq6uQhzb3q4IJAxEnwEWdtlFfsL60Au9TxgPc2
	73UocksW2GWvg8md3BWx5PMl+AhEDxLaB9N1oyZDKKc/XVXVeTbL7EbFsG9XGtdF
	jtvR1exkC8TBEvYtNrPKpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791575528; x=
	1791661928; bh=E7AWcJX7TLChvl9+qNbThRKCUMFRT4ZevpHDsMG4dTA=; b=d
	NtiO8zdgGLFJWhstPSMBSxCGHLcJZwGeND5lUD4CNhuIP1dN/2uZyjlrn3sjS6gE
	Z3JKiwsIgWYyVS4hPGxUJTMBiIrZ6ukVHkXtHDK6BZ8HoPxGJLbWqMl5nAkyovL6
	ncWwfG1Rd7KfUNkYjcdruK/d4eSeKOasR+x08mlaioCUPslOP8orlnO5SjMAF4Sx
	oqGoWGyiT1Xkt7Bww8tORKGRWEihmbM8ARrPzKjigpyMlTgW+H3mshH/eym1qnvM
	EURza6fKX5Pujlxgh4Agpem+pSqHhqlB3kIH8aEztjIQKvQzCrDdhjFiFuJQlie2
	qKz73AbVQi3zBJ/QF/XBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791575528; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FJ5oxcsREabeqCkyhM3856/88lkvDYDe2OFK0IgljCpQMwK
	KU4ufyuh0Cvz0mwOoTsvlg9wcLG3C9KDCS0FuWnXl1jFtjj0NkvVpD2JXNz7gdZH
	0SwGD4i0mCclXPGDGrBne8+2rdSzP4h/FaoFf031EV7M+2x8JbVDp/g5gG4s+FRf
	MYMZwa+F5jrMXerx7J/FfotGXKJSkW/gMX1IgDTGg4CIHyFxm2VPQOjxMWYypKPS
	/SodtTgkhtAzCmloHYBxNX862uK2s41F4cgcgX4WvRpBBRPrvTUxgGS2lRP45CSH
	wy+36iJeC8SWzABoVV/v5g/Xp2jCrs0Qx8OejQQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GagB7DSpORsm164V2HeSC1xqvVWZEehqRM9fYNyXmtY=:2dO3jhPiXoWuEJOubq3f0+uDHGWe68stZOsl++yRYnQ=;
X-ME-Sender: <xms:50XJajoLrT5UxQpvJzIRmL9vr_bCHR8ACmXDY0yplbfufiH-POOOoA>
    <xme:50XJapi2IMTVFxwiDIhKVXfgW3ID6SOISNiiRkQCBWzNv8jSR2IN5Z7L19DOAshDv
    1cEqc4rhENH42ddybrx7t8RCYt5XXfgJ2zy0GLjsb05GmldmoedzsE>
X-ME-Received: <xmr:50XJatNp5dkz5XByZU82sD9MvEiqEt7XV3Tto_xdcveEVa0HkFjAXLW9oK_GHg>
X-ME-Proxy-Cause: dmFkZTF3z8iCFEOwQ+sOPxZrCCdowTEVc6VTcM6Pq5NhWOiO27IhlwefIcXLgnfcSyr3rz
    DShoK3NdERzm40z9FoLGTl0/znQOuOVWzCgs0gfpDasu+Cnn0T1G5b1A5TvT2p5iK/s+dp
    49SOcbK6VgMr+w0FpEZBygAVjxzxAdpVsfUWlHquizAd2edm0kNqw39jAEt+vTYg+UjmSL
    5W5DocJ/bKkhJ/paQtzvBiPCi2ZNlQYX4/cVXNfBaabZJ16tW7CQpRiXY78hljxayGrBZo
    hlBxvBbFYif7rRpzTnBjzfvwd69O8qbUNm2gw887VZtYJruFlaZZBQdIQIZvbGXSI6H1pe
    dLu4RTVg+8/n30iexpjoHJKhQ6OPzmzcm6zs2fYdQQRf9YtMqKKrZKr7Ypz/Ozr7t52ZN7
    M4Stn6aF4xXHyTEJ6Vg6JXHLvCJ45ENsLO2PK5FgjytBIwLw7tWfSEeci0Ycsemp1X4yS7
    ne2IX2V5M0CBExJlSDeNwcPFjswHZ3eKyjZAGPrt3gwbw8IN/QITfKXkF6Eo8FGKyw9mOi
    ExkawsOqDbARw12K9oHuIcdctd4dVA6iR4p99Bb9BlXqafJ0RsHKElFP7sZCUis96jDFQJ
    4qWCSocsKosU5zF5BbrMoh6QkxsFVcJ3R7kvPGbWrWJI5DbxGzgp1UKdmqAQ
X-ME-Proxy: <xmx:50XJarwLdykLgCfYt4Jw_-Bzz1P4Thp2Eu7y1DZFCpETf-psf77t_Q>
    <xmx:50XJanog3D05b34OiUTsf2Qd55mUaXhGTuQj8pVIybz2aXiI5F5Gsw>
    <xmx:50XJajOtDQvnhvYVcsWN4UlCNujhJZh7eqMMI-aNmetWlF9EQ85tDQ>
    <xmx:50XJajcn_Sl9X9_DNirXDVXm8AujCmivU86pVypzMFPiiEXuINzhQQ>
    <xmx:6EXJaqz-t3MbO6VZig7-P7AAc0SDGhhtEQKQudUX-gNibfAm0Jw9lMDv>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 15:52:06 -0400 (EDT)
Date: Fri, 9 Oct 2026 13:52:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: Andrea Parri <parri.andrea@gmail.com>, Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Kevin Tian
 <kevin.tian@intel.com>, Jiaqi Yan <jiaqiyan@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 alex@shazbot.org
Subject: Re: [PATCH] vfio/nvgrace-gpu: Skip PFN registration for empty
 memory regions
Message-ID: <20261009135203.33f3806d@shazbot.org>
In-Reply-To: <20260925161024.189771-1-parri.andrea@gmail.com>
References: <20260925161024.189771-1-parri.andrea@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 18:10:16 +0200
Andrea Parri <parri.andrea@gmail.com> wrote:

> nvgrace_gpu_open_device() registers nvdev->resmem only when it has a
> length, but registers nvdev->usemem unconditionally.  In fallback mode,
> where the ACPI memory properties are missing or the C2C link is down,
> usemem.memlength is zero, so the empty region is still registered.
> 
> register_pfn_address_space() then inserts a node covering
> [0, ULONG_MAX].  Nothing removes it, because the fallback device table
> closes through vfio_pci_core_close_device() rather than
> nvgrace_gpu_close_device().  A second open fails with -EBUSY, and once
> the device is unbound the node outlives the nvdev that contains it, so a
> later registration or a memory-failure event walks freed memory.
> 
> The node also captures every memory-failure report for a PFN with no
> struct page.  The callback rejects every VMA of the fallback device, so
> no process is killed, but the failure is logged as MF_RECOVERED rather
> than MF_IGNORED.
> 
> Guard the usemem registration with its length, matching the resmem
> handling.  Fallback mode then registers nothing and the existing close
> path is correct.  Guard the unregistration the same way.
> 
> On the unfixed tree a second open after unbind reports:
> 
>   BUG: KASAN: slab-use-after-free in interval_tree_iter_first+0x209/0x310
>   ...
>    interval_tree_iter_first+0x209/0x310
>    register_pfn_address_space+0x97/0x100
>    nvgrace_gpu_open_device+0x21c/0x730
>    vfio_df_open+0x213/0x520
>   ...
>   Allocated by task 152:
>    _vfio_alloc_device+0x3a/0x500
>    nvgrace_gpu_probe+0xcb/0x660
> 
> The fix should be safe because memlength already decided whether the
> range was meaningful: full mode always has a nonzero usemem.memlength,
> and fallback mode never calls nvgrace_gpu_close_device().  The guard
> only skips a registration that could never have been unregistered.
> 
> Fixes: e5f19b619fa0 ("vfio/nvgrace-gpu: register device memory for poison handling")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> ---
> Tested on x86-64 under virtme-ng with KASAN, not on Grace hardware. The
> driver was bound through driver_override to a QEMU cxl-type3 function,
> whose CXL Device DVSEC reports the memory as valid and active, so probe
> takes the fallback path; the device was opened through a noiommu VFIO
> cdev. Without the patch the second open fails with -EBUSY and, after
> unbind and rebind, the next open hits the KASAN report quoted above.
> With the patch neither happens.
> 
>  drivers/vfio/pci/nvgrace-gpu/main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index 963fd8ded20d1..326b991732148 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -207,9 +207,12 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
>  			goto error_exit;
>  	}
>  
> -	ret = nvgrace_gpu_vfio_pci_register_pfn_range(core_vdev, &nvdev->usemem);
> -	if (ret && ret != -EOPNOTSUPP)
> -		goto register_mem_failed;
> +	if (nvdev->usemem.memlength) {
> +		ret = nvgrace_gpu_vfio_pci_register_pfn_range(core_vdev,
> +							      &nvdev->usemem);
> +		if (ret && ret != -EOPNOTSUPP)
> +			goto register_mem_failed;
> +	}
>  
>  	vfio_pci_core_finish_enable(vdev);
>  	nvdev->bar0_base = io;
> @@ -235,7 +238,8 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
>  	if (nvdev->resmem.memlength)
>  		unregister_pfn_address_space(&nvdev->resmem.pfn_address_space);
>  
> -	unregister_pfn_address_space(&nvdev->usemem.pfn_address_space);
> +	if (nvdev->usemem.memlength)
> +		unregister_pfn_address_space(&nvdev->usemem.pfn_address_space);
>  
>  	/* Unmap the mapping to the device memory cached region */
>  	if (nvdev->usemem.memaddr) {
> 
> base-commit: f49a343b305c0b6c19a3b50c0bbf10bcd0e2e8fd

Ankit, any comments?

It seems to me though that the reason this bug exists is because
nvgrace_gpu_pci_core_ops.open_device is trying to handle both real
nvgrace devices, where usemem.memlength cannot be zero, alongside
non-nvgrace devices where that can easily be forgotten.

The above patches the failure of that model, but maybe the better
approach is to split them such that the failures like this cannot
occur, ie. a core-only wrapper that just calls vfio_pci_core_enable()
and vfio_pci_core_finish_enable(), or some other refactor such that the
core-only path never handles the nvdev.  Thanks,

Alex
