Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33130412294;
	Wed,  2 Sep 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342826; cv=none; b=PgzG8xOwEyKaS0xFeI7gMZ4GBPaCl7Aej7EnLE/+WRJbxrN1Er9YQnyd0NIT9y9mJOLtTELD9LgcmRrjrWOQVEK7BRKGYLvwWRwzbuj/2RurBxlLbZeURo0SIQRhuEHHiZ3l5+ZwG5vqK2+9a1kqecZfHQm2O6Y7cHGnkm2qO6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342826; c=relaxed/simple;
	bh=+yJ5tgOj3VCG5Eb9Z+EjeQ1yyrGurFNEE9P4mhlYBNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QifXahy9RgZM1f4TuNpLGtwwt63dVyZjpdjSWpkwcWI5tWPj/LWGhtJYTmKGpmTfGXkaSTzF7PBDncNsmPBiVDJEoN6MQ+9Lq3ULjYqyJfA0JgPieG++L/kyq0D+c7sbW2458+GA2SvfMtN3r0ih1uOyf7x+tPvTX3e8NIg6Mm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDO/E4ot; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDO/E4ot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349411F000E9;
	Wed,  2 Sep 2026 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342822;
	bh=aF/Kk+g5mXV8rPuEMfzI6XMNGLVQ9aLTLmy5wSXsqwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SDO/E4otLAYdA2G9JfptpWzIkyPnU/okkQE6y7+fCD0bH5mhWgvxm0KoD6u64lN37
	 q6DUrJbwr/YDn6hn/FEIG/Utjy8NU2kRmfLXbQZGaD6z7eU47RlEnZlLyG4X48FsVv
	 0rSyEFL7b6DWdwm4/cNVQ1wh22bwGg3n/Zr9RRmGDLS77ffYSGTYbub2sW0uJin5dX
	 0g9svPDUsfhWsEAmm5jo9uDJaq7jOOkALaWpX9lz334szFrK99859mo6IESO4jcwcD
	 EH0/dC11zvpDkwpd16t+pDSzO1RCGgNKpVKMit//wAS4lpqoFnm4V88KaBACOJ81ip
	 eWnPNFVRIQZJg==
Date: Wed, 2 Sep 2026 12:53:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
	ankita@nvidia.com, chriscli@google.com,
	david.laight.linux@gmail.com, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, jgg@ziepe.ca, jmoroni@google.com,
	kevin.tian@intel.com, kpberry@google.com,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	sashiko-bot@kernel.org, stable@vger.kernel.org,
	viursachi@google.com, xuehaohu@google.com
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
Message-ID: <20260902095338.GU24140@unreal>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
 <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>

On Wed, Sep 02, 2026 at 10:44:59AM +0200, Christian König wrote:
> On 9/2/26 10:32, Leon Romanovsky wrote:
> > On Wed, Sep 02, 2026 at 09:56:06AM +0200, Christian König wrote:
> >> On 9/2/26 09:39, Leon Romanovsky wrote:
> >>> On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> >>>> On 9/1/26 19:08, David Hu wrote:
> >>>>> From: David Hu <xuehaohu@google.com>
> >>>>>
> >>>>> This series address two related issues in scatter-gather mapping,
> >>>>> specifically for the MMIO based dma-buf mapping. The fixes ensure
> >>>>> sgt mapping is correct, and proper for large MMIO regions.
> >>>>>
> >>>>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> >>>>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> >>>>> phys vec to sgt)
> >>>>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> >>>>>
> >>>>> Patch 2 Splits sgl by largest page aligned chunk
> >>>>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> >>>>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> >>>>
> >>>> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
> >>>
> >>> And this is why so many in the kernel community want to get rid of SG
> >>> lists. It would be great if DMA-BUF could also eliminate the need to
> >>> convert to an SGL, like Jason proposed.
> >>>
> >>> The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
> >>> which is the one that depends on it.
> >>
> >> I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.
> > 
> > You are proposing the same thing as an SGL, just in a different format.
> 
> Yes, because that is the right thing todo as far as I can see.
> 
> > It does not address the issue that dma_addr_t is expected to hold a DMA
> > address, while that is not always the case. For example, in the P2P case,
> > the addresses are not DMA addresses.
> 
> Yes they are. They must be DMA addresses because that is the only thing the importer needs to do it's DMA.

They can perform DMA, but that still does not make them suitable for the
dma_addr_t type. For the PCI_P2PDMA_MAP_BUS_ADDR flow, these addresses
follow completely different rules: they are not unmapped, require no cache
synchronization, are valid only for peer access, and require separate error
handling.

All of this information is lost if only the dma_addr_t is stored.

> 
> It can be that those are DMA addresses on private interconnects between devices, but it should *never* be a phys_addr_t because that is limited to the address space the CPU can see.
> 
> > Jason's proposal:
> > https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/
> 
> Yeah, I have commented quite a bit on that.

Right, I posted it for reference.

Thanks

> 
> Regards,
> Christian.
> 
> > 
> > Thanks
> > 
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Thanks
> >>
> >>
> 
> 
