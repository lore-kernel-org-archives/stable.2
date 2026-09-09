Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A453815DD
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946254; cv=none; b=u4KfcxEs/wAhXuTPGCJsYh4NFSVeqA/e9/RgKak7cIHNnFO3WiF8t1dxTmXaIBk3PIr5N6rWIl63eQSRQ80KRsIqizIyKxt9Aei11Wy9wdskOtvGmVfb4edGd5hPo8OhzzJzNYy7W4MsDqf8BnE2Cuv00UG96FjIQxKQnnVfPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946254; c=relaxed/simple;
	bh=hUTAcpRgCYaUTSgvwJ+scRVUcaN8A6CzhAcgnLj65h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Zi1aZX7UEG7ehChrUm8VCRSoXKmhdrjDdYRCN9w230RcZiohSWthWMyPaKZ/0Y8i3lqQACzmXCUW+jTVq37RbDIBNB/MejPStmylxKQ5LL0vu3vVyejAySJ9ZNjN80c3OJqnP5MJ6NWHCwJXPYWle9YwppjBPSaMMztBXxAPrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zx9y6GeQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zx9y6GeQ"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260909093031euoutp0275b0be86074e258732dbd2ae6cd95392~TnR6cpV2B0891008910euoutp02e
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:30:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260909093031euoutp0275b0be86074e258732dbd2ae6cd95392~TnR6cpV2B0891008910euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1788946231;
	bh=eci5dm0dWMDE3VdtwMzRP2HfwdF24omEUntVuRPJ6YE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Zx9y6GeQRcLOiagAybY8GZNtu63FUUqbHwOb4f0kWswkYvLbu3FoAUO3TH37amsK9
	 qpK/hO/aiRKrUcv7oYpwl07RL0qiykVe46QlS88QsepuvUpXJ5Mw5YjTD/THujyr9Z
	 BdN0kTRGNoqLoGc6qYGdEgduf+T3We/OQo3R7nP4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260909093031eucas1p218efa0c7c2725dbff58b5d617ed7fd5a~TnR6NQ-gM0990809908eucas1p2e;
	Wed,  9 Sep 2026 09:30:31 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260909093030eusmtip1df22798227f621c24f518080f67a0c4f~TnR5ZjwfX1877718777eusmtip1A;
	Wed,  9 Sep 2026 09:30:30 +0000 (GMT)
Message-ID: <b4992b2b-ef81-4fd8-ab0b-a42d0fe06ef7@samsung.com>
Date: Wed, 9 Sep 2026 11:30:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] swiotlb: use the adjusted address for the highmem page
 lookup
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk
	<konrad.wilk@oracle.com>, Bumyong Lee <bumyong.lee@samsung.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260905084210.148255-1-donggeunyoo.kernel@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260909093031eucas1p218efa0c7c2725dbff58b5d617ed7fd5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260905084219eucas1p281d736780f5951d867a487e88f7d9709
X-EPHeader: CA
X-CMS-RootMailID: 20260905084219eucas1p281d736780f5951d867a487e88f7d9709
References: <CGME20260905084219eucas1p281d736780f5951d867a487e88f7d9709@eucas1p2.samsung.com>
	<20260905084210.148255-1-donggeunyoo.kernel@gmail.com>

On 05.09.2026 10:42, Donggeun Yoo wrote:
> swiotlb_bounce() reads the page frame number from the slot's recorded
> orig_addr, then advances orig_addr by tlb_offset to reach the address
> the caller asked about. The highmem branch mixes the two: the offset
> within the page comes from the adjusted address, the page from the value
> before it.
>
> Once the adjustment crosses a page boundary the pair no longer describes
> one location, and the whole copy lands one page below the intended one
> for a positive tlb_offset, one above for a negative one. DMA_FROM_DEVICE
> writes the device data over the wrong page and leaves the intended one
> stale, DMA_TO_DEVICE feeds the device from a page the mapping may not
> cover. Partial syncs through dma_sync_single_range_for_*() are what make
> tlb_offset non-zero.
>
> The branch test is picked the same way, so a slot recorded in lowmem can
> be adjusted into highmem and the lowmem path then hands a highmem
> address to phys_to_virt().
>
> Take both from orig_addr once it is final and keep pfn in the branch
> that uses it. PhysHighMem() asks the question straight from the address,
> as dma-debug already does.
>
> Fixes: 5f89468e2f06 ("swiotlb: manipulate orig_addr when tlb_addr has offset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Applied to dma-mapping-fixes, thanks!
> ---
> Reproduced under QEMU (qemu-system-arm -M virt, 2G) with a 32-bit ARM
> kernel built from multi_v7_defconfig plus CONFIG_ARM_LPAE=y and
> CONFIG_HIGHMEM=y, which brings in CONFIG_SWIOTLB, booted with
> swiotlb=force. A test module maps two highmem pages at page offset 3840,
> writes a pattern into the bounce buffer 500 bytes in and calls
> dma_sync_single_range_for_cpu() over that range, so that 3840 + 500
> crosses into the second page:
>
>   before: swbug: pages pfn=700d4 highmem=1
>           swbug: orig phys=700d4f00 (page off 3840)
>           swbug: RESULT page0_off=244 page1_off=-1
>   after:  swbug: RESULT page0_off=-1 page1_off=244
>
> The pattern lands one page below its intended location without the
> change and in the right place with it.
>
>  kernel/dma/swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ded7016a46a7..aa2f1c4588b9 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1019,7 +1019,6 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>  	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
>  	phys_addr_t orig_addr = mem->slots[index].orig_addr;
>  	size_t alloc_size = mem->slots[index].alloc_size;
> -	unsigned long pfn = PFN_DOWN(orig_addr);
>  	unsigned char *vaddr = mem->vaddr + tlb_addr - mem->start;
>  	int tlb_offset;
>  
> @@ -1052,7 +1051,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
>  		size = alloc_size;
>  	}
>  
> -	if (PageHighMem(pfn_to_page(pfn))) {
> +	if (PhysHighMem(orig_addr)) {
> +		unsigned long pfn = PFN_DOWN(orig_addr);
>  		unsigned int offset = orig_addr & ~PAGE_MASK;
>  		struct page *page;
>  		unsigned int sz = 0;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

