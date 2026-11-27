Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793477;
	b=eoWXtrlWiz9XXIM9ZOl+kUpSzOqy0bb+J/e3AXquyqb/SXK8sHPTizJ/kAmV92A4nLDq
	 ae6Y1Zh4WOIiJhp57r+8PDBjDSmX7HT9p3ZEvBS0cGnQidsgGTZc5QYsvCsrWKL472bKU
	 f2w+kPETWUS2uqNTqwg1lvp/384L5vDZcUaByL7DVB4I2JLt3rsrNIo5ih6ejFXgBsabd
	 9zd5sPvI+H1vKPgI97eNT72MxAGqaiZH8I2/6c0EMF8u1EDjH7xV3NiSdjuVvTy9l2XmR
	 8ogcBm4+BXnYNEDCKQLAeGlN1TsU0LOWzQkLrScLsReoQGgcEsB5m8IgyJ415b3CPRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793477;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AiKgiR/T4qeQ5YDnuOshjx2CZduMAwFjjmKloTtaWZE=;
	b=exHRpXDAmDQNtCsMCfRVfyFI/KAN1jQNJkf5iDuzjP0a1SYlxTz/LdwrNwKrCgoS2IiA
	 iaIXZ6565/CLsgztoXRLrk0GZw8vfMiP3W+3AxuKEumF7KdZdTWlwMAfxRcIx3MH+yBlm
	 bEIPXklEur2uxWRGUVS2BQuqrt4zLC74ZzT/jPC9mxDRrNdXdqyqIYy86/dIMoI3Gp9Q6
	 HnXVcpZHm9zOlXOHKQiSeUNgjU7RmgsP63kWqikbSOJg0csWdI7cOrnFhnY8X9m7JRbMG
	 VYaWcBCbVLIbyKvKyQ9SoOKle/Wu5TmRqqXK2J4f4UN164wSBhZuJ4Wf+YaoNWz+iBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/bxmaPz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDF606A321;
	Fri, 27 Nov 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/bxmaPz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942CD1F0089F;
	Fri, 27 Nov 2026 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793477;
	bh=AiKgiR/T4qeQ5YDnuOshjx2CZduMAwFjjmKloTtaWZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b/bxmaPzPalF4fWgf3uVw3MTeg+rguOh01GZtKw7oI6ojWL6/CEY5l93aX1+7IQjO
	 iTNClzh1X/9MdlVCEF913BQ9Du/xnbvst6YmGtr+bPEuTuN3z8I37wQ9hfI3Ggd4Ry
	 khqlNXFbURegBYYm5rPprF5JHGyLffngpRuaeZ7a4g0R+h6khPN6XOlcYG0SiqA5cR
	 93gIU2oyYk/1XGtybQwV7NTXOavW1gPadA0NVS/2t7Vbz8gEb67l/M1gGM1pKFObOg
	 TmxxJyf1nbyB3nY3GwZNLb6gXNVxDI9IaH2W+GbQ3cN2I4xu/P1x54iin77ERkctdX
	 gvBy2GT9vwLRA==
Date: Fri, 27 Nov 2026 17:31:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
	Alex Williamson <alex@shazbot.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Message-ID: <20261127153113.GB774860@unreal>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>
 <20261127115849.2780625-5-m.szyprowski@samsung.com>
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
In-Reply-To: <20261127115849.2780625-5-m.szyprowski@samsung.com>

On Fri, Nov 27, 2026 at 12:58:48PM +0100, Marek Szyprowski wrote:
> Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
> the free_iova helper") turned dma_iova_destroy() into dma_iova_unlink()
> followed by dma_iova_free(). Before it, the destroy path marked its
> IOTLB gather as queued for DMA-FQ domains, skipped iommu_iotlb_sync()
> and handed the IOVA over to the flush queue, exactly like
> __iommu_dma_unmap(). After it:
> 
>   - dma_iova_unlink() never queues its gather and always calls
>     iommu_iotlb_sync() after iommu_unmap_fast(),
>   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
>     the IOVA goes straight back to the allocator via free_iova_fast().
> 
> DMA-FQ domains therefore get strict invalidation on this path. This
> includes blk_rq_dma_map(), which NVMe uses for all data transfers, so
> iommu.strict=0 has no effect on NVMe I/O. On a Qualcomm Glymur CRD
> (SMMUv3 without RANGE_INV, 4K pages, NVMe on PCIe Gen5 x4) sequential
> fio throughput drops from 10.6/11.9 GiB/s (write/read) to the strict
> mode level of ~2.7 GiB/s.
> 
> Instead of reverting, decide once in dma_iova_try_alloc() whether the
> IOVA space is going to be released through the flush queue and record
> it in a new DMA_IOVA_USE_FQ flag in dma_iova_state::__size, next to
> DMA_IOVA_USE_SWIOTLB, so struct dma_iova_state does not grow.
> dma_iova_destroy() then unmaps with a gather queued according to that
> flag, skipping the sync for flush queue domains, and passes the same
> gather to the IOVA free, so the IOVA space (and any page table pages
> released by the unmap) goes through queue_iova() again. dma_iova_free()
> honours the flag as well. The whole reservation is still freed, keeping
> the size fix of the reverted commit.
> 
> A gather must always be retired, either by iommu_iotlb_sync() or by
> handing it to the flush queue together with the IOVA, and the IOVA must
> never be returned to the allocator while a queued invalidation for it is
> still pending. To keep that obvious, the internal unlink helper only
> unmaps into a gather supplied by its caller, and each caller retires it
> right away: dma_iova_destroy() syncs or queues it together with the IOVA
> free, exactly like __iommu_dma_unmap(), while dma_iova_unlink() always
> uses a never queued gather and syncs it, as the unlinked range remains
> owned by the caller and may be linked again immediately.
> 
> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> Reported-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com/
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Cc: stable@vger.kernel.org # v7.3+
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/dma-iommu.c   | 103 ++++++++++++++++++++++++++----------
>  include/linux/dma-mapping.h |   8 ++-
>  2 files changed, 83 insertions(+), 28 deletions(-)

<...>

>  /*
>   * All flags stored in the upper bits of dma_iova_state::__size. Sizes passed
>   * to dma_iova_try_alloc() must not overlap with them.
>   */
> -#define DMA_IOVA_FLAGS			DMA_IOVA_USE_SWIOTLB
> +#define DMA_IOVA_FLAGS			(DMA_IOVA_USE_SWIOTLB | DMA_IOVA_USE_FQ)

We need to be careful here. Every bit reduces the IOVA space available to
everyone. It is only a matter of time before someone complains that __size
is too small for their use case. This extra bit is probably not an issue,
but that could change if we keep adding bits to DMA_IOVA_FLAGS.

Thanks

>  
>  static inline size_t dma_iova_size(struct dma_iova_state *state)
>  {
> -- 
> 2.43.0
> 
