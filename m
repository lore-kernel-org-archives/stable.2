Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B014EC65D;
	Thu,  3 Sep 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453377; cv=none; b=D/7FLFM589UNwwy5L4urO2MZKIUJwes8H8enYqOYYyMfodNClwwHV871m8saNGv8f4wzgAR6l5f2OzXWnyFuIOZkM++NyoLsu/wloASEcJuJ/hTQ3qCkMpnzCUBLjeiesWKeTbS3wjUCcWhSxvLTT+Gg+qm2O34OCUFvunjEt1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453377; c=relaxed/simple;
	bh=gpmW+HyIEeTLjdRiH+3o2uIBKCjT3Tbs/vkL0DojWCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmZUF2V+6nkpmTkkyhG2v8IvIwN47UzbnHNI0Q9BTtzDZAf1vSgwrqwwIdDOw89pI2SBfRQlRYohCTn19zTFQrdV8kw9tVbBjkVMqA1uFNEV9pXSRycDCvOqi1t2Jgw67LYN+gfI7Q02DIliwNmogB/8EPlLMWRWI5RHcyU6Vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3eoz13k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3eoz13k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD81D1F000E9;
	Thu,  3 Sep 2026 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788453376;
	bh=+H+rYBzctxn3i+op7YWkFQodYaXTN0tMGbK1SZja320=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e3eoz13khe0EtmAwLz5TdAPFlgdaXJbp46ZLGW31ghMH32HrwIUZuGUJpKVFMKfSj
	 7lew5lpaB+QPYN3K/zonQCjyj5ub6+y1KU8hIz+Nbka0ALAuO+CC88ZGzCPLpTYiZz
	 rEpDGNaKDMMtbnmRZKAAOJWMCRRglyeRAGYr75FtY89gkXHAqYYJX46mPOuuaUlWCA
	 MoT5npZYXppLrpqmIQeowhAhK7L0Jm1v4beUI6TqsncOVxqqweA6uYOHtOQxumqc4Q
	 UyZypgPtdlHBoieGypjle1sjQyJUJX1DuEXP3Sv3mfahPWRyYkmaJH7uItNtspyGRs
	 RU4PQ2siQrDKw==
Date: Thu, 3 Sep 2026 19:36:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org,
	christian.koenig@amd.com, alex@shazbot.org, ankita@nvidia.com,
	chriscli@google.com, david.laight.linux@gmail.com,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
Message-ID: <20260903163612.GD24140@unreal>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <20260901170849.4052816-3-dhu@x6u.co>
 <20260902120832.GB2890729@ziepe.ca>
 <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
 <20260903134938.GI2890729@ziepe.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903134938.GI2890729@ziepe.ca>

On Thu, Sep 03, 2026 at 10:49:38AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2026 at 07:07:50PM -0400, David Hu wrote:
> > On Wed, Sep 2, 2026 at 8:08 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> > > > From: David Hu <xuehaohu@google.com>
> > > >
> > > > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > > > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > > > first entry, resulting in non-page-aligned DMA addresses for all
> > > > subsequent entries.
> > >
> > > This patch is fine, but pedenatically a scatterlist's entry limit
> > > should be bounded to dma_get_max_seg_size(), though I don't think it
> > > helps this. Operating scatterlists at the size limits has proven
> > > problematic in a number of places already...
> > >
> > > > In addition, a non-page-aligned sgl length will trigger an edge case
> > > > in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> > > > buffers, we will have a `va` with lowest bit set to 1. That will lead
> > > > to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> > > > to find best page size for the mapping on the NIC side.
> > >
> > > That's an IB side bug, the newer logic that joins adjacent SGLs should
> > > have avoided it?
> > 
> > Hi Jason,
> > 
> > Thank you for the review. I think you are right on both counts.
> > Regarding the IB side, the new SGL joining logic in
> > `ib_umem_find_best_pgsz()` indeed avoids the issue. `mask |= va` is
> > skipped for artifically split, contiguous SGLs. Since Christian has
> > already pulled v8 into drm-misc-next, I won't spin a v9 to avoid
> > creating unnecessary noise on the list. If you prefer a followup,
> > please let me know.
> 
> Nope, I'm fine, it just explains why it wasn't seen in other
> tested. You were backporting and mix&matched things. It confirms the
> upstream kernel was fine from the start.

All that time, I wondered why our testing didn't uncover any issues like
this, given that the requirement to support large BARs was raised almost
immediately during testing.

Thanks

> 
> There are other importers besides RDMA, so I still think that this is
> a good change regardless. Having each segment remain page aligned, and
> staying away from ULONG_MAX that might trigger overflows is a friendly
> and robust thing to do for less sophisticated importers.
> 
> Jason
> 
