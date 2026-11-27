Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800683;
	b=XiV6qKjAYmexEVpp1qMwqT8677KsJG67ERFWGxlXmIkg2InEbQnwvRpzeNAxIg1flVVs
	 wPMYmNJVb9i1qx1x+haOD433eMJwMwoTSZRDiHH6BzjwbpgYbputi2U7hLc2FPwLn/wFN
	 uo8qQ9k1kUollVxw6sUE8Lq8gbpsgDbJphO4uLG43K0+rmb0sF0380rQ6OjCoXvoKUv/X
	 W0ebi0+myP6D2NtGu5SV/PLBc94qYc6YE0tp6UfxSMqEZGLIj66FUl8C2S8ydMRIOMLBn
	 Y7a/kDy94haiRPonXkOVf+AKXbyDVc3Ij+ncrCVEizWGikBn5e8MhadB+4JXbOGUchw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800683;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SxkB79JyZNOqq6boAXrI7iGSPmjXeTsVjygSTJZm0lY=;
	b=sax4a8QeaJCYGQH719ts8BD6JZz+aSm2asxecJnJLU2Whs8ngJg7dpTuxTKgDWew0JVj
	 vam/8hGzPz+wnBeftu+58TDXrLilhTTi+jmPe1A/HvGXPGCVaE4+9RHDyVGPYOfGY+m/d
	 fgiCVBGK55udlYTFS/8L9ZMNt7MJA5Y6u+/xglu1LPsfD4ojgt9kolM64f5v656cpT60a
	 sYzPNspH59C/95NY9Yvsvl+V2jcCjxaX5p7aMW8MRkwq8JoZRNPJrqvWJOBt4JqX9erN0
	 mszVoUbVeXG4NB7IvWcc1Kl2gjqHbF535gQKqrZ7Wl+r8DTwNGYMvX92O+ypih8zMFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=K9VyL0zE;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9333606A32A;
	Fri, 27 Nov 2026 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9333606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=K9VyL0zE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AEB21575;
	Fri, 27 Nov 2026 09:31:18 -0800 (PST)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F813F632;
	Fri, 27 Nov 2026 09:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795800681; bh=v/QQr5Xygwvu0X+fk+OheKspcIMS+nrdnWZiEPrhFKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K9VyL0zEaOqHsldNZIXPVjh1yqRkTaFcer7ctevcR0vW0TJJK4vuYx2M/dOFot1z5
	 eE75zKNBEaYQU4atk4gKR3Kfa9Ygj82Tni80JCSMEsqVoBokADhFCMVkg/aXoAcgxT
	 MSN3mv0rI43Z8+euwmgPQQwPyjd0mlDEF1gjDjeU=
Message-ID: <90e159b3-ef50-4d03-937a-ced5896b152a@arm.com>
Date: Fri, 27 Nov 2026 17:30:26 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/dma: restore flush queue use in
 dma_iova_destroy()
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
 <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com, stable@vger.kernel.org
References: <CGME20261127171534eucas1p1adc65490fcfb09b573d27aaa834f2912@eucas1p1.samsung.com>
 <20261127171529.2917893-1-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20261127171529.2917893-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2026 5:15 pm, Marek Szyprowski wrote:
> Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
> the free_iova helper") turned dma_iova_destroy() into dma_iova_unlink()
> followed by dma_iova_free(). Before it, the destroy path marked its
> IOTLB gather as queued for DMA-FQ domains, skipped iommu_iotlb_sync()
> and handed the IOVA over to the flush queue, exactly like
> __iommu_dma_unmap(). After it:
> 
>    - dma_iova_unlink() never queues its gather and always calls
>      iommu_iotlb_sync() after iommu_unmap_fast(),
>    - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
>      the IOVA goes straight back to the allocator via free_iova_fast().
> 
> DMA-FQ domains therefore get strict invalidation on this path. This
> includes blk_rq_dma_map(), which NVMe uses for all data transfers, so
> iommu.strict=0 has no effect on NVMe I/O. On a Qualcomm Glymur CRD
> (SMMUv3 without RANGE_INV, 4K pages, NVMe on PCIe Gen5 x4) sequential
> fio throughput drops from 10.6/11.9 GiB/s (write/read) to the strict
> mode level of ~2.7 GiB/s.
> 
> Fix this by letting dma_iova_destroy() unmap the linked range into its
> own gather, queued for flush queue domains like in __iommu_dma_unmap(),
> and retire that gather together with the IOVA free: either by
> iommu_iotlb_sync(), or by handing the IOVA space (and any page table
> pages released by the unmap) over to the flush queue via queue_iova().
> The whole reservation is still freed, keeping the size fix of the
> mentioned commit.
> 
> A gather must always be retired, either by iommu_iotlb_sync() or by
> handing it to the flush queue together with the IOVA, and the IOVA must
> never be returned to the allocator while a queued invalidation for it is
> still pending. To keep that obvious, the internal unlink helper only
> unmaps into a gather supplied by its caller, and each caller retires it
> right away: dma_iova_destroy() syncs or queues it together with the IOVA
> free, while dma_iova_unlink() always uses a never queued gather and
> syncs it, as the unlinked range remains owned by the caller and may be
> linked again immediately.
> 
> Consequently dma_iova_free(), and dma_iova_destroy() with nothing
> mapped, keep returning the IOVA directly to the allocator: no queued
> gather was ever created for it, so there is no deferred invalidation to
> wait for.

 From a quick skim, this looks about right to me. Note that a single 
gather in the dma_iova_state itself would never work anyway, as multiple 
threads are still free to unlink non-overlapping parts of the range 
simultaneously, so gathering always has to be per-call.

Acked-by: Robin Murphy <reobin.murphy@arm.com>

> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> Reported-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com/
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> The series has been developped with an aid of LLM, build tested on arm64
> and x86_64. Sibi, it would be great if you could rerun your fio test on
> top of it.
> 
> Best regards
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 
> Changelog:
> v2:
> - dma_iova_free() and dma_iova_destroy() with nothing mapped return the
>    IOVA directly to the allocator instead of the flush queue, as there is
>    no deferred invalidation to wait for (pointed out by Sashiko review)
> - dropped DMA_IOVA_USE_FQ flag and flags related rework (pointed out by
>    Jason)
> 
> v1: https://lore.kernel.org/all/20261127115849.2780625-1-m.szyprowski@samsung.com/
> ---
>   drivers/iommu/dma-iommu.c | 100 +++++++++++++++++++++++++++-----------
>   1 file changed, 72 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 78742aeba932..44fa02c35bad 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1857,6 +1857,19 @@ bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
>   }
>   EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
>   
> +static void __dma_iova_free(struct device *dev, struct dma_iova_state *state,
> +		struct iommu_iotlb_gather *gather)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +	struct iova_domain *iovad = &cookie->iovad;
> +	size_t iova_start_pad = iova_offset(iovad, state->addr);
> +	size_t size = dma_iova_size(state);
> +
> +	iommu_dma_free_iova(domain, state->addr - iova_start_pad,
> +			iova_align(iovad, size + iova_start_pad), gather);
> +}
> +
>   /**
>    * dma_iova_free - Free an IOVA space
>    * @dev: Device to free the IOVA space for
> @@ -1871,14 +1884,12 @@ EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
>    */
>   void dma_iova_free(struct device *dev, struct dma_iova_state *state)
>   {
> -	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> -	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> -	struct iova_domain *iovad = &cookie->iovad;
> -	size_t iova_start_pad = iova_offset(iovad, state->addr);
> -	size_t size = dma_iova_size(state);
> -
> -	iommu_dma_free_iova(domain, state->addr - iova_start_pad,
> -			iova_align(iovad, size + iova_start_pad), NULL);
> +	/*
> +	 * Nothing is linked anymore and every dma_iova_unlink() has already
> +	 * invalidated the IOTLB synchronously, so there is no deferred
> +	 * invalidation to wait for and the IOVA can be reused right away.
> +	 */
> +	__dma_iova_free(dev, state, NULL);
>   }
>   EXPORT_SYMBOL_GPL(dma_iova_free);
>   
> @@ -2097,27 +2108,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
>   		arch_sync_dma_flush();
>   }
>   
> -/**
> - * dma_iova_unlink - Unlink a range of IOVA space
> - * @dev: DMA device
> - * @state: IOVA state
> - * @offset: offset into the IOVA state to unlink
> - * @size: size of the buffer
> - * @dir: DMA direction
> - * @attrs: attributes of mapping properties
> - *
> - * Unlink a range of IOVA space for the given IOVA state.
> +/*
> + * Unmap a range of IOVA space into @gather. The caller owns @gather and must
> + * retire it, either by iommu_iotlb_sync() or, for a queued gather, by handing
> + * it over to the flush queue together with the IOVA via iommu_dma_free_iova().
>    */
> -void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
> +static void __dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
>   		size_t offset, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> +		unsigned long attrs, struct iommu_iotlb_gather *gather)
>   {
>   	struct iommu_domain *domain = iommu_get_dma_domain(dev);
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	struct iova_domain *iovad = &cookie->iovad;
>   	dma_addr_t addr = state->addr + offset;
>   	size_t iova_start_pad = iova_offset(iovad, addr);
> -	struct iommu_iotlb_gather iotlb_gather;
>   	size_t unmapped;
>   
>   	if ((state->__size & DMA_IOVA_USE_SWIOTLB) ||
> @@ -2125,14 +2129,38 @@ void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
>   	     !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))))
>   		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
>   
> -	iommu_iotlb_gather_init(&iotlb_gather);
> -
>   	size = iova_align(iovad, size + iova_start_pad);
>   	addr -= iova_start_pad;
> -	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
> +	unmapped = iommu_unmap_fast(domain, addr, size, gather);
>   	WARN_ON(unmapped != size);
> +}
>   
> -	iommu_iotlb_sync(domain, &iotlb_gather);
> +/**
> + * dma_iova_unlink - Unlink a range of IOVA space
> + * @dev: DMA device
> + * @state: IOVA state
> + * @offset: offset into the IOVA state to unlink
> + * @size: size of the buffer
> + * @dir: DMA direction
> + * @attrs: attributes of mapping properties
> + *
> + * Unlink a range of IOVA space for the given IOVA state.
> + */
> +void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
> +		size_t offset, size_t size, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	struct iommu_iotlb_gather iotlb_gather;
> +
> +	/*
> +	 * The IOVA range stays owned by the caller and may be linked again
> +	 * right away, so the IOTLB has to be invalidated synchronously even
> +	 * for flush queue domains. The gather is therefore never queued and
> +	 * is retired right here.
> +	 */
> +	iommu_iotlb_gather_init(&iotlb_gather);
> +	__dma_iova_unlink(dev, state, offset, size, dir, attrs, &iotlb_gather);
> +	iommu_iotlb_sync(iommu_get_dma_domain(dev), &iotlb_gather);
>   }
>   EXPORT_SYMBOL_GPL(dma_iova_unlink);
>   
> @@ -2152,14 +2180,30 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
>   		size_t mapped_len, enum dma_data_direction dir,
>   		unsigned long attrs)
>   {
> -	if (mapped_len)
> -		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +	struct iommu_iotlb_gather iotlb_gather;
> +
> +	iommu_iotlb_gather_init(&iotlb_gather);
>   
>   	/*
>   	 * We can be here if the first call to dma_iova_link() failed and
>   	 * there is nothing to unlink, so let's be more clear.
>   	 */
> -	dma_iova_free(dev, state);
> +	if (mapped_len) {
> +		iotlb_gather.queued = READ_ONCE(domain->iova_cookie->fq_domain);
> +		__dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
> +				&iotlb_gather);
> +	}
> +
> +	/*
> +	 * Retire the gather together with the IOVA, like __iommu_dma_unmap()
> +	 * does: either invalidate the IOTLB now, or hand the IOVA space and
> +	 * any page table pages released by the unmap over to the flush queue,
> +	 * so the IOVA cannot be reused before the deferred invalidation.
> +	 */
> +	if (!iotlb_gather.queued)
> +		iommu_iotlb_sync(domain, &iotlb_gather);
> +	__dma_iova_free(dev, state, &iotlb_gather);
>   }
>   EXPORT_SYMBOL_GPL(dma_iova_destroy);
>   

