Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288350;
	b=umXOFI2UIEUkhoCAx8SU56WsZV1plUVTW/OvCrdPK/FAKeI3NNIQKd+JwYFI1YPXh+Sz
	 yRDjWigx09rpe1tGo6s0ST9CZMYGTvhi/yVX+1QdWpvE+9fwqqVItBtBLueBmPyg+8gaG
	 1yCbrquQG3+F1Asy6ZezB9hp8Z3FEXgnaph1bbSRLln1ydMLE/j/Mvpyfxm+7JsS9p5sd
	 LKaEF4HiwudzBuefgOo0+H6Llos6dcvD43eL2+Yn/ruSKyIh/macyTzou1LaMPV25w5vL
	 wMZMWvCjjb8SRgBNRRn3ktUhVbI60umMXW12rmaAEh+XU/9bq45skuIXqYW8tKvR1vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288350;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=+0yjXwf7zZ1/G1ToyAZvwzcg/8Wure4Qebgzn6jDw2o=;
	b=1D5+Ok40nvhXqmGOTY5mahQL8gqCRYD84M+TC5mtFP6StX/q7JM4Uuk8cM5a2fwZKufX
	 xIiPXREx/gN5PICe7efbdZNktoS9K2rPaCh/sKiwmoegZuqeazmlCTYtNcu9G6B7n2hpL
	 N1sBw++0BjJ53tzoQrsENDLdRofc4PblE2FxYBIoQOY9OpEHkjBZ1SSspwT3zH7G2RMN6
	 C0pBYSr5nUnuTpdbj49Gx9xKFyaaoVqlm/UM1Y8X/850g8maChI50SCGi+ligl89GHK5E
	 2QKdu7oPs0x2ezKuWzvIgOSEWbk8rtet+y17RdzjHpN3xqlePBsIaLcA6ilCMXFCbCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtNbvFH4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4A606A321
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtNbvFH4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BCC1F01824;
	Thu, 29 Oct 2026 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288350;
	bh=+0yjXwf7zZ1/G1ToyAZvwzcg/8Wure4Qebgzn6jDw2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KtNbvFH404X0mtuGoj7Vu5oAoA+/JglIBBuLwOsA38IKk/11U2UQxlO+VhuVDTvil
	 DwVIOuYSUE7qxQt2APGi69YO4D9H6gtXfM0vzIqiU4Mf2dXbPUJPpo5hjySjkuFCPc
	 /JuJy8ZSIFNcaS+Rs2K5yIGQ/9XytBXIb5MZ+JWgoxK/a4NGGquo8Fro5fEeGdBNuS
	 yn9dmocZDxQa93o9fgo4T2fcyY9s3j1iWVW/r+aifoWczxhfR3JSKM9qp/yUUIRKFs
	 ilLOQtctvujtimEXG9Y2hkfGqwOVgLfNOvrFuNYx+yUYb7xHy1tE+fpJbTmyTi0Uep
	 fAfrEPWbC8jGw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8558C198003A;
	Thu, 29 Oct 2026 11:39:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 29 Oct 2026 11:39:07 -0400
X-ME-Sender: <xms:mWjjavqZF8ILa7GFmJFT86blR7k_DlTz9ED8h5mfEBaM3GSziIQipQ>
    <xme:mWjjaqHyR7KyUAAkhd_S_blWhizqPE63kya9v5qMVUQbFVLEGAh07sK1B4LdqGAaz
    WLKUsSfmJtwCm6ND2EriXZUffFBQBwkL2rlJUHuBrJJ9RRrtl4hagH3>
X-ME-Received: <xmr:mWjjaho4yavLEyDGhcv1z7Mg95mxcXyE4Quo-NP5luhgau8BXtLJ-Y3TWEI>
X-ME-Proxy-Cause: dmFkZTFNlLI1IxnysmwtxDbPBbt2dqnvQhYipohEcx8dPwIJIrBgAtFUMCeSCRLUn7u/FW
    UJHxDkt0ROnXfFadeQtiCMM/RXRAtrrQVUGl5N58b1fgZRYRaTyROC31lQTfeZ8KbXzn3o
    1iblUPv5lQsPi35OYZrwn0KFWjWElIqjIL9Q3FpGeATyjJJCw3m52D4TW5EsY55qwO5bwQ
    L4tJ3d6vs/G6neLrJOfICTE6JsI3AzVh2GvhCHK2ltNKIxcjHCQEoOcYmbZqhhQ3GkH72f
    H2adk7ABosF30oW/TTEpL65vQG5ZxGrmyE0nmd55Y2l6qH+ynwtzmGxyCXtI0WrAcjz3an
    Q4xGGzYI/IoTBk/VX9AsQAiiMVBH0c+EfrLUzzx/Abe3/LQ4nGf0hfBf94strHo2SHnGDv
    AlOBnZXY5b2Qu2gRP73I3htQpOZ1IxTQ1ycrS11vSBwv5A782pALFSZYBhGeMc8g1ZjJYc
    9Svn6Dgwjqs6YNAmffDusdRny6sr54vrgPHIWYQMEp8V8oHexi7SJCCaJTltC9F0v1LdLg
    EaTsM0e7JVAMdOyh+f+bkRx4yvtjD6InTFZvLkcgMVymvw6BwaPpheLKCEntVPvCbMop2J
    hPmtr+CHw4FXrXFxZrPj/8MyZLBO2+D9DxeCxvFuzbQQ9Zcsvl5khQqZbDLw
X-ME-Proxy: <xmx:mWjjag2WREewV6wSGyONMkVOEjaeWnca5tphcv-FngRdtmveuHhgzA>
    <xmx:mWjjaisKt4iSOJeJWqljwsoGFLdMnjx7vZlxan5So5qapDzh5jCqeA>
    <xmx:mWjjapH9fmjjz_dUmQsX_cShxLR_2BSYoF4NB_NvXOUlmeLOq_ZUsQ>
    <xmx:mWjjah0iUHxiDrcn1Cff4bYXPkduGpXLnqxdVbb_878uGhTIra3Leg>
    <xmx:mWjjajo7kks2AsRow9vTTyrBXgkIAA2JRqIYIl7zQ-Cl_CKIG0Q5mDQj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:39:04 -0400 (EDT)
Date: Thu, 29 Oct 2026 15:39:03 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/cma: accept memory of CMA areas reserved with
 memblock_reserve()
Message-ID: <auNoZgOgoFElHYUt@thinkstation>
References: <20261029-cma-multi-v1-0-2cbced8b5cb7@kernel.org>
 <auM6lKGAeUI26jCj@thinkstation>
 <auM-tYrdV4TJgJ6K@kernel.org>
 <auNE2XEGreHRKoPO@thinkstation>
 <auNgRT19droHmv3Y@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auNgRT19droHmv3Y@kernel.org>

On Thu, Oct 29, 2026 at 05:03:33PM +0200, Mike Rapoport wrote:
> On Thu, Oct 29, 2026 at 01:17:06PM +0000, Kiryl Shutsemau wrote:
> > On Thu, Oct 29, 2026 at 02:40:21PM +0200, Mike Rapoport wrote:
> > > On Thu, Oct 29, 2026 at 12:27:23PM +0000, Kiryl Shutsemau wrote:
> > > > On Thu, Oct 29, 2026 at 12:18:36PM +0200, Mike Rapoport (Microsoft) wrote:
> > > > > Pages of allocated CMA areas are released to the buddy allocator with
> > > > > __free_pages(), which does not check for unaccepted memory.
> > > > > 
> > > > > This usually works because memblock accepts the memory it allocates.
> > > > > 
> > > > > However, multi-range CMA areas, used by hugetlb_cma, and fixed CMA areas
> > > > > requested with cma=<size>@<base> are reserved with memblock_reserve() and
> > > > > their memory is never accepted.
> > > > 
> > > > It feels like memblock_reserve() abuse, no?
> > > > 
> > > > crashkernel=size@base already uses memblock_phys_alloc_range() for this.
> > > > Should the fixed and multi-range CMA paths go through the allocation API
> > > > as well.
> > > 
> > > Fixed path already has the range, why would it use allocation APIs?
> > 
> > Having the range doesn't make it a reservation. Both paths take free
> > memory for the kernel's use, which is an allocation, and an allocation
> > has to be accepted. memblock_reserve() is for memory that is already in
> > use: kernel image, initrd, firmware tables. Using it for allocations
> > leaves acceptance to every caller, and both CMA paths missed it.
> 
> memblock_reserve() predates any allocation APIs and it is used to say "I
> know this memory is free, I'm taking it". So memory acceptance should have
> take it into account.
> 
> > If memblock_phys_alloc_range() is the wrong tool, let's add a
> > memblock_*alloc*() helper that takes the exact range and does the reserve
> > plus memblock_prep_allocation(), the way memblock_alloc_hugetlb() finishes
> > its own search. There is no search, so the multi-range path doesn't get
> > slower, and accept_memory() stays inside memblock.
> 
> A new helper that does reserve and accept makes sense, but let's do it on
> top and also audit other callers of memblock_reserve().

Fair enough. Feel free to use for this patchset:

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
