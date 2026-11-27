Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792696;
	b=D7+/Z4kbRdJ9Ue0/tq7L95J10Pt1Wn91ik4Ezl6SPuBjTLBBr6qqdKN4ynAjK5hw/3nn
	 cjsRNQSVDN799jCg8Zu3hCWRcZycEdyxz5Qz/EtcqndRFNhXB6P1EDsiNY/fZyUzH5eQu
	 Dk3Zm7NcU9DcXy36oz6YCythRIVCGe/AXphlubPbGcv3XXiwVouz4Tc6k1BAcN5YnYa90
	 OX1qbyVnFv4OqRLwa+ZWlupQEUCiJULAHotP+QhkTwa2JCmOMzz3i2DTYouB2VIt2DpBF
	 WVoigyFJTJjINMWtzhpMQsDBKXI42sr722dDzSyjICWGRgpPMV3J0mHiX5JFd0/DAdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792696;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=4N5oFs5XGGfdpJJghwLFB6jh87JUfQpfrYkhGaeqDvk=;
	b=OYNn4oGcpizpWUuC7D50yydfYIa6/TSw59adJidw1QoFSD7Z8lzaAk8hmNXIZxUgLLPn
	 5EBP6BkzHnoqbvNGTku8lodpvpAtUryAnacCSvx53rrPzRZxdAlPJjMThpKs/sjt3Dns6
	 NsEqWNNwtm+ZhyR3oLUzf9BVCkz9C0r8/Z/nBtS1C0Zr7uzd/UXsvhuz+jKlguDsLTlZy
	 oDoaO03Ulz0kr9sCTW/FGZlG0wGr85YO3QejwkENKypAyYi9JpBR6bZYsynjfZ+Hekkry
	 /lGdZcHkbDeHCu8Lo01jj47LxdqxAul6QsXeLZX6IOu6wnMDSygH398wCaSzU0SZCqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpQ0YQxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5A606A31C;
	Fri, 27 Nov 2026 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HpQ0YQxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB59A1F00893;
	Fri, 27 Nov 2026 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792696;
	bh=4N5oFs5XGGfdpJJghwLFB6jh87JUfQpfrYkhGaeqDvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpQ0YQxAnusmuRaNs4tTcwEQ/b1d6koqApQDvRHKjYGaKhTnuPdhXDNDkBGXYB96s
	 EJUCRJdN7iHUTiKxIJ2+iDj/sTwBIJdsortJKvb2OccZLqYF4CIm9ZVB1UNTuxJ7Cg
	 bGFgEinKOfyEJaY/YsRoPj9Uk2fINqD/WWlgihUCxE9M9g/RZTcl9eKkb/CPrE82l3
	 mZfyOGubCvh+47ZOHO/b2Z72JWUDCTiIuo4EZNJrGSrRh3jNcx9iysHb2GEFltEdwj
	 rpHbLgO2WXeWHpaiadfvygOieEaGCE9vQ1lfe2O8Lvxj5r/oRVNLqSFvO8BRWGcX3W
	 a4yolim8zvXLw==
Date: Fri, 27 Nov 2026 17:18:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, will@kernel.org,
	robin.murphy@arm.com, honghuan@amd.com,
	Jason Gunthorpe <jgg@ziepe.ca>, joro@8bytes.org,
	prakash.gupta@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/dma: simplify dma_iova_destroy() and drop
 the free_iova helper"
Message-ID: <20261127151813.GZ774860@unreal>
References: <CGME20261125135138eucas1p141ba6b5e09623562e2033e290fba811c@eucas1p1.samsung.com>
 <20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
 <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>
 <20261125183419.GB774860@unreal>
 <c5e4fc4e-0e63-47cf-8b88-93ecfb3646de@samsung.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e4fc4e-0e63-47cf-8b88-93ecfb3646de@samsung.com>

On Fri, Nov 27, 2026 at 12:28:16PM +0100, Marek Szyprowski wrote:
> On 25.11.2026 19:34, Leon Romanovsky wrote:
> > On Wed, Nov 25, 2026 at 06:21:06PM +0100, Marek Szyprowski wrote:
> >> On 25.11.2026 14:51, Sibi Sankar wrote:
> >>> This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.
> >>>
> >>> Before this commit, dma_iova_destroy() unmapped through
> >>> __iommu_dma_iova_unlink(..., free_iova=true), which set
> >>> iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
> >>> and freed the IOVA with the queued gather, exactly like
> >>> __iommu_dma_unmap(). After it, dma_iova_destroy() calls
> >>> dma_iova_unlink() and then dma_iova_free():
> >>>
> >>>   - dma_iova_unlink() never marks its gather as queued and always calls
> >>>     iommu_iotlb_sync() after iommu_unmap_fast().
> >>>   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
> >>>     the IOVA goes straight back to the allocator through
> >>>     free_iova_fast() and never through queue_iova().
> >>>
> >>> DMA-FQ domains therefore get strict invalidation on this path. That
> >>> includes the block layer's blk_rq_dma_map() path, which NVMe uses for
> >>> all data transfers, so iommu.strict=0 has no effect on NVMe I/O.
> >>>
> >>> hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
> >>> 	       4K pages; NVMe SSD on PCIe Gen5 x4
> >>>
> >>> Fio sequential read/write numbers:
> >>>   Domain                          seq write    seq read
> >>>   DMA (strict)                    2694 MiB/s   2693 MiB/s
> >>>   DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
> >>>     bypassed (this regression)
> >>>   DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
> >>>     used by dma_iova_destroy()
> >>>
> >>> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> >>> Cc: stable@vger.kernel.org # v7.3+
> >>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> >>
> >> The performance data clearly shows that the flush queue was there for
> >> the reason. Together with this revert it would probably make sense to
> >> apply the v1 of the reverted patch:
> >>
> >> https://lore.kernel.org/all/20260701092033.422867-1-honghuan@amd.com/
> >>
> >> Leon, do You see any other option?
> > These numbers shows clearly that we had iotlb_gather.queued != 0
> > and never performed iommu_iotlb_sync(domain, &iotlb_gather); while
> > destroying mapped IOVA.
> >
> > I agree with you, v1 is the easiest solution, however my preferred one
> > is to cache gather when it is created and keep it in dma_iova_state 
> > structure for whole life cycle of that struct.
> 
> I've played with the code (using LLM ;) and there are some issues with this
> approach:
> 
> 1. tso_dma_map_completion_save() copies the struct dma_iova_state by value,
> what breaks internals of the struct iommu_iotlb_gather.
> 2. adding iommu_iotlb_gather to dma_iova_state increase the struct size
> from 16 to 64 bytes, what lands in every NVMe request, RDMA rw contexts,
> TSO maps and HMM.

I had that idea before AI era and before TSO was converted to use
dma_iova_state. :)

> 
> I've decided to put only the 'use_fq' bit in the __size entry and baked the
> fix. It looks quite nice. This approach solves both above issues, although
> it requires to also fix some drivers which already pokes __size directly
> instead of calling dma_iova_size().
> 
> I will post this in a few minutes.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
