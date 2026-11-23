Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795423452;
	b=sb25WolTkXzWlsNcS0+uNItrbrdjkIhbUCD2MjLSebPEbfJ/qa3YQlH10NWklvSQo6SX
	 Rscqynwv/wlq4kJF2IHZLhzkgd7NXHiLS+EDnOCBjmQyVU4eAhnpv+PbrenwM2TBxla1Y
	 +GJJfogbYDAvRbWjpg6dG6ZZZGIYC3S1lMEhBAKsE0kBMhB/kPZ2Txrw/3JcHT0MsYJ/V
	 evoydCHNH96fOPtgbsrp/gyhJgu1PQof/wEk2G2XjLShbDKfCnPBGSZyaCV3mvC7iIJON
	 DCyBOTR7yZctaSQEh/likJL8RnybReiIwqWHPYB4Rs6u2q/fEC8eF7iVxrIz2LWUoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795423452;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=x6963jPjsLUsPHA/uau2cLk42v2/DPcgtYcs1mokjyI=;
	b=r6dAeUnCfh/yQpChLbfsup9Ua59euTlIbnDcu55CZwU4sCFd6FtZIusv5U3x7+zS4YTH
	 8uIqZctCzKlIOwWDQQi42E94QblfoWlIJAcUEdL5WTNNOZBx7Cc9stPbwD8+GK1dJcsAe
	 IPfLx9ukO8A7MJaSKnasslcxxNrxCC48vL0XbeI2+ttttmzD9Jk6TifdMlSiXaVF0Sq88
	 nmnIGn6aY5u7d65sdMVFcUnZzC6KMEQNfIdwRLEIncQ8D1rPX0nLxtvBYUmnKRm9O5L70
	 thKXQ7UgZR9bwumLN+fhbokkap84Fe5iZUy6pNnKS5aHysRWn/TgyfDOMjBJpNzbR6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=WbgOac+f;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6073606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6073606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=WbgOac+f
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261123084403euoutp022a5999c78386c8c1aae6a5793d938691~qoBv3UsFX1365913659euoutp02e
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:44:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261123084403euoutp022a5999c78386c8c1aae6a5793d938691~qoBv3UsFX1365913659euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795423443;
	bh=x6963jPjsLUsPHA/uau2cLk42v2/DPcgtYcs1mokjyI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WbgOac+fCZL6QKPCNsr0Nr9wvQYLsYA9cz6F6laauqfDL7jjZr17WlSVagfsfyVcX
	 KpKkSt5U3nXpMvKrA0gJH6dopZ9dB84Bcq9RCDRjDHhgguJOXs3/sNNB9+CqwIHNGx
	 uE0OLKyyVaQ+dWoRy4zIkUgWHAEHPqTiPBPXCtYg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261123084403eucas1p2873829307f60e3216b22051a5b4f555b~qoBviu2GA1040310403eucas1p2F;
	Mon, 23 Nov 2026 08:44:03 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261123084402eusmtip23d76f4ec6d9091f4b97d7267f0d4b0c0~qoBvEjGjd0757907579eusmtip2r;
	Mon, 23 Nov 2026 08:44:02 +0000 (GMT)
Message-ID: <71e21389-3b73-48c0-b71f-5a852a0171c1@samsung.com>
Date: Mon, 23 Nov 2026 09:44:02 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2] dma: swiotlb: Allocate the restricted DMA pool slot
 array with kvzalloc()
To: yzddmr6@gmail.com
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261120-upstream2-swiotlb-rmem-kvzalloc-v2-1-cc5732dddb6b@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261123084403eucas1p2873829307f60e3216b22051a5b4f555b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261120153112eucas1p2346e8ecaa8f37920ca5cf05e0b6428cc
X-EPHeader: CA
X-CMS-RootMailID: 20261120153112eucas1p2346e8ecaa8f37920ca5cf05e0b6428cc
References: <CGME20261120153112eucas1p2346e8ecaa8f37920ca5cf05e0b6428cc@eucas1p2.samsung.com>
	<20261120-upstream2-swiotlb-rmem-kvzalloc-v2-1-cc5732dddb6b@gmail.com>

On 20.11.2026 16:30, Zhendong Liu via B4 Relay wrote:
> From: Zhendong Liu <yzddmr6@gmail.com>
>
> rmem_swiotlb_device_init() allocates one struct io_tlb_slot per 2 KiB
> slot of a restricted DMA pool with kzalloc(). The struct is 24 bytes on
> 64-bit, so with 4 KiB pages and the default MAX_PAGE_ORDER of 10 the
> array is larger than KMALLOC_MAX_SIZE (4 MiB) for any pool above about
> 341 MiB. For such a pool kzalloc() refuses the request with a
> WARN_ON_ONCE() in ___kmalloc_large_node(), the pool is not set up, and
> of_dma_set_restricted_buffer() warns that it failed to initialise the
> pool. The devices assigned to it then lose the restriction without
> their probe failing, and use the default DMA path.
>
> The slot array is only accessed by the CPU and does not need to be
> physically contiguous. Allocate it with kvzalloc_objs() and free it with
> kvfree(). The other pools are not affected: the slot array of the
> default pool comes from memblock, and the buffers of late and dynamic
> pools are limited to MAX_PAGE_ORDER, which keeps their slot arrays
> small.
>
> Pools of this size are needed when large buffers go through the pool
> for their whole lifetime: this was hit with an arm64 Gunyah protected
> VM whose virtio-gpu resources stay mapped in the pool, and a desktop at
> 3392x2400 needed more than 341 MiB.
>
> The problem was analysed and this change written with the help of an
> AI coding assistant.
>
> Fixes: 0b84e4f8b793 ("swiotlb: Add restricted DMA pool initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhendong Liu <yzddmr6@gmail.com>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

