Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709635CB6F;
	Wed,  2 Sep 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334782; cv=none; b=ZTI/AIYRRiKs2BKjudEV11FGo7iWtrCo8UFX/IQfK9kXMn9Ylx1aRTfOWBzlG5D6C5ZMCa6PgyOuU2NeDjC8YCxAgGg2UB8+cbcXN4diBlX3xmE61GF1V5APBwzv9sVhAJtdOG8ruCvD4Nv66sKsm72u6ZBEdpiN90agtVkQ6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334782; c=relaxed/simple;
	bh=sI2I4okyxDQ1HgkFwksdivRgzckLgjuRUcbgD8P11/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgSIEqMseg/1YbbRZy5nhUqVUGovLDYFDbSsHcZSuo+uGd0hfXMTajit46J5GhGRde4gSrrIQTiiKVxDIy8ckg57SOb19k6e85rLwlRcMxSpj8VRGQWmGmdbVxudHTkDFNfP7vgXHNZiLrwjF9hrNCBD2iz/7plxT1Ey1rZiaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVevXqP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVevXqP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CDF1F000E9;
	Wed,  2 Sep 2026 07:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334780;
	bh=Zmj6Pl4DI8aaARUoVXtREi8xmgkB7kHiiAcvl0t361M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVevXqP8uk4G2qfUr4fRwo9Xv9i/jYjJ+Hift6ITqhh0R31kK+7v5WOiOo9/0ie7j
	 4sOXgFXmks/B/0h/21DcWitUMKDWxZYTLiyRsIbbyZZZpO+nouiDx+4eAKL3bch964
	 Z0ITjST2BqJve2jB5bjPfpMiqhwbV+7s5F4A2fofmPN494nOQZjDhr0n7HKxZeRvBB
	 yfEtheDm5PrO5mtXXpRM3Bx6CPq/6gY14VOKrtpn77K0Fbgi6LM5j3nbK0pUgMpnnU
	 2tbzJBXwpgQ2gxvoVNI2PhV6fP7prCxJ05MvzwtMjBEiZwd+CPTJ5WYN4VsnP3/wkq
	 UWLcYuhjXx0uQ==
Date: Wed, 2 Sep 2026 10:39:36 +0300
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
Message-ID: <20260902073936.GR24140@unreal>
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>

On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
> On 9/1/26 19:08, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
> > 
> > This series address two related issues in scatter-gather mapping,
> > specifically for the MMIO based dma-buf mapping. The fixes ensure
> > sgt mapping is correct, and proper for large MMIO regions.
> > 
> > Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
> > (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
> > phys vec to sgt)
> > https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
> > 
> > Patch 2 Splits sgl by largest page aligned chunk
> > (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
> > https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
> 
> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.

And this is why so many in the kernel community want to get rid of SG
lists. It would be great if DMA-BUF could also eliminate the need to
convert to an SGL, like Jason proposed.

The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
which is the one that depends on it.

Thanks
