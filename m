Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE663DF003
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691486; cv=none; b=FrZVpgig0RDf128dKX684i3tokjKstQSPv+3PB2/Td6UbKdcMevd70ERRCAJ3mEOMncTJ/sO27jLhyOsINstJFbCK6UzEHULY/o6ZUxD1hX2uDpa4m8k3Bre9WssAO6aULqc2a+cCw4XJ7dr72W5rDzZq2B1y/UJZXSgLpyPexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691486; c=relaxed/simple;
	bh=mRUEgaLLRZs3XA6JhpKmVeHN70ytznFWnbmy5/ri8Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aeef02RVA+NelKj4yZ4AxYWMEYp7M5haAb50g5tFUbkPtIWkEZT1yfRJd/m/aV3WOYYfSWhIc/GiNgA78XbyKoqrfvQers2zPNqjX9iUaTx3hUPedgrIqgntKhDJVSmnELCQ8JCmt0DCvxitY2VdVDitHNDszlOq/W4hCoqWG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XDhsE7mR; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XDhsE7mR"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260814071116euoutp01922855b38d458c1c9db5381f1694ef46~Lmm5o09OC0390103901euoutp01C
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 07:11:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260814071116euoutp01922855b38d458c1c9db5381f1694ef46~Lmm5o09OC0390103901euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1786691476;
	bh=Bp3R4P4Rp9frlKNA97goT2EzSLN1Lba9YEqq1yzXTJg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XDhsE7mRdfj0K0zRAAwoNu04t/ESc1R18IJwxZofSMSSEWRz9eoSBJMOZx43aYhqd
	 NJlZkM7JQDPetJIrygAtOfUaKeGrybhGGd5vciTRXTYFaSsEZRjxh0VonawLVQJ5IH
	 rsV43EunDd0YEawVg6VT5NABCQ/GlYdnDVMZeHsM=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260814071115eucas1p12172796c7a61c7d31843b25fc7bff469~Lmm5MSMRb2328123281eucas1p1Z;
	Fri, 14 Aug 2026 07:11:15 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260814071115eusmtip2f5da583e8a94dacb5c9912ded282f82d~Lmm4kD1vm1291712917eusmtip2h;
	Fri, 14 Aug 2026 07:11:14 +0000 (GMT)
Message-ID: <22a4aa19-39c8-4f3d-9542-b2dce50125d1@samsung.com>
Date: Fri, 14 Aug 2026 09:11:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: fix type mismatch in dma_direct_alloc_pages
To: yangge1116@126.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, robin.murphy@arm.com, hch@lst.de, liuzixing@hygon.cn
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1786689000-14677-1-git-send-email-yangge1116@126.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260814071115eucas1p12172796c7a61c7d31843b25fc7bff469
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260814063037eucas1p13a146c907bec7280bb28d9e8ef009eae
X-EPHeader: CA
X-CMS-RootMailID: 20260814063037eucas1p13a146c907bec7280bb28d9e8ef009eae
References: <CGME20260814063037eucas1p13a146c907bec7280bb28d9e8ef009eae@eucas1p1.samsung.com>
	<1786689000-14677-1-git-send-email-yangge1116@126.com>

On 14.08.2026 08:30, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
>
> The pool allocation path directly returned the void* cpu virtual
> address from dma_direct_alloc_from_pool(), which is type‑mismatched
> against struct page *. Convert the dma_handle to page via
> dma_direct_to_page() instead.
>
> Fixes: 5b138c534fda ("dma-direct: factor out a dma_direct_alloc_from_pool helper")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: stable@vger.kernel.org

This is a duplicate of the patch already applied to dma-mapping-for-next, see

https://lore.kernel.org/r/20260717180442.110954-2-aneesh.kumar@kernel.org

> ---
>  kernel/dma/direct.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4391b79..f496568 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -356,8 +356,12 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	struct page *page;
>  	void *ret;
>  
> -	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
> -		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp)) {
> +		ret = dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
> +		if (!ret)
> +			return NULL;
> +		return dma_direct_to_page(dev, *dma_handle);
> +	}
>  
>  	page = __dma_direct_alloc_pages(dev, size, gfp, false);
>  	if (!page)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

