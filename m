Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E13E5ED0;
	Wed,  2 Sep 2026 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337958; cv=none; b=Z+z3TEUVVV6H7ajT0KdEHwU4hMSZCvuJzkLcfR6V4i9peQDQhoKNRU7NQ1Shvzn8IvrF1mF6al19ZnU0gmSTIZX6Q3U1EAFn2Ym9zhIRJCCHVNnrbfDmHf6tZPjP4uKDpNoymanObJbT9KRQeKrWftCEi3O0hYFI6I/X9sb/SF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337958; c=relaxed/simple;
	bh=v8SX+7Xz1Vg96SIXVTeAC580QaT32ORmc9kJCxv3UHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R22IobqFSk+P43NrLMorRE1WiqOatWsHfy5EPfnHDiPIn3PxViNPhAxmU/vs3GXsnReQMyDzKseoFP1HpEcPOHNJrDSvWBeuVFCGSIGq6/Iiw0o4d4E0d7rvvsTmal0fyz3cRfsdl1wiWzUbqa888OaNQli3wICrofr+m+wwnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKBt61I5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKBt61I5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E51F000E9;
	Wed,  2 Sep 2026 08:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337957;
	bh=vWDDEcxiq+pbUWv2xdfE/x6aKmTVnkF0HDOEaUnPgXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gKBt61I5bi9P27zyhPIIrWp6N0m7CFr036R594pa7RGBi7ZlNGSVOr3n9nOZ5mUwN
	 akqqrf6CXbyO5WpiAu9yvzpKy53aSwBOO2RulejrbqfKcn3P299pw4leeH7CpGU7BG
	 5ugV99icLeYn/feBQSZrnmZmPK5DnwxJ9HGDsitlk5fgmrw7Hc6mNLdzzLFn8wmsE1
	 oeVteVH4FyMx3g5Bz7JAeTH9n0IrbVr6wHuPgJp3HvkLa75xEW6/qi0Z0FpzNJDh5o
	 tfur7kbFX6bf67gFD8J6VllKCpEPZh0a0MArFsaVCRah3lxU/CnBplGwVhekvJra82
	 LsHPul6ggtTog==
Date: Wed, 2 Sep 2026 11:32:32 +0300
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
Message-ID: <20260902083232.GT24140@unreal>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>

On Wed, Sep 02, 2026 at 09:56:06AM +0200, Christian König wrote:
> On 9/2/26 09:39, Leon Romanovsky wrote:
> > On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> >> On 9/1/26 19:08, David Hu wrote:
> >>> From: David Hu <xuehaohu@google.com>
> >>>
> >>> This series address two related issues in scatter-gather mapping,
> >>> specifically for the MMIO based dma-buf mapping. The fixes ensure
> >>> sgt mapping is correct, and proper for large MMIO regions.
> >>>
> >>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> >>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> >>> phys vec to sgt)
> >>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> >>>
> >>> Patch 2 Splits sgl by largest page aligned chunk
> >>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> >>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> >>
> >> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
> > 
> > And this is why so many in the kernel community want to get rid of SG
> > lists. It would be great if DMA-BUF could also eliminate the need to
> > convert to an SGL, like Jason proposed.
> > 
> > The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
> > which is the one that depends on it.
> 
> I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.

You are proposing the same thing as an SGL, just in a different format.
It does not address the issue that dma_addr_t is expected to hold a DMA
address, while that is not always the case. For example, in the P2P case,
the addresses are not DMA addresses.

Jason's proposal:
https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/

Thanks

> 
> Regards,
> Christian.
> 
> > 
> > Thanks
> 
> 
