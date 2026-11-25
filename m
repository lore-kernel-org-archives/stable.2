Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631663;
	b=scTaPUQrZORJ+8FBxNpvKRsvRCMV2CkBz/iK81wR+Z4ub9yU0zm95lAZAy1ph4dEgWIT
	 nsOmtALQ8Pae5CnlXq8wf402PSpthg3kTjvTOnSmeGXbj1QKjHooIIVU+9TgHDTtY1KU3
	 A/d+byw7LyWsF58KwjV6KYkaNJiiJ7x8C2USs0qcQtR8p4O9swL8i+mVZOij35XA4u5NK
	 gVcCD97hCatJMDaXTxU9HV55mlmHJ3mQtGIy1Ozm13tWKbFrqxS+vyr8T+9Q9SamHcERB
	 k1z1RhByUzlrxqQFoxPmIUsHdg89q2rtryrQAu+KZPf01zLOyq/FpQFcYI6RTg8BOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631663;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lN6AbTnehn4JFc7e6Trjk6a/kJXaBSLWT91x39OVt+o=;
	b=kOqakygYKLkwoyDgRGAkYi1IyykoKA9bWdeXa8cj+NbTSbULIi9FZPuAjtFZALZ988aP
	 /gmPcAZM2xoCZrSnzyyDZk3lVgtJF+7ePhWzlD/LJugby/dI7Qf/M3oAO9reh/OTCffzM
	 1A63JnzDzXEJbj9+ZCCULyMLVkZBljahuUaPjViOqL2FYZwKtk4P/q68YhQGvTSGHdrxV
	 xX4S4SrDe7V6JFW+bdx84N5DczmEKuP0Q+ZCaKpc7QRgmNFPxZIO5RiIaobBnTUhPZ+57
	 hloN7Gwy8sY+tlXDqxhiQSO2KTcVi42itXIJ6VBSyPDZ9dDc4xVgS64ktBlGai4MEtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UupQtPIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9A606A32C;
	Wed, 25 Nov 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UupQtPIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF001F000D2;
	Wed, 25 Nov 2026 18:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631663;
	bh=lN6AbTnehn4JFc7e6Trjk6a/kJXaBSLWT91x39OVt+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UupQtPIP7l0f2ccBXBw6ZqF9NGaqeOTV+3R4Qvv2UcGP5x2P0JIFr0quccYJ6su4/
	 9IITwEmD4Lz0UcD9PpfaVjM/AuNwXK/8heRpbd1/ExhPx6Z566eIawQ8GK4sKsdL5u
	 20VKOo2rZCVTi2BW9ZgMJ/8edFSORrwXluT6U9BkA3Uxb5r8/kl5IsrJCT1180fF6O
	 BFHyisArXZ9qX0ejR+1RwNedOjg49nbtMy/0VXtqoIy4PNRc0kLaDvjEjOG9M/Pw7g
	 dOxVc/syxz7pn1pAzCRRuVradrWQh8GXRzU/GenDnkpcz/UZs3pcQBamNle8uD8kC4
	 gUdMfHkzkzzxA==
Date: Wed, 25 Nov 2026 20:34:19 +0200
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
Message-ID: <20261125183419.GB774860@unreal>
References: <CGME20261125135138eucas1p141ba6b5e09623562e2033e290fba811c@eucas1p1.samsung.com>
 <20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
 <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>
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
In-Reply-To: <a3722347-4b88-41ad-926b-455530020c6b@samsung.com>

On Wed, Nov 25, 2026 at 06:21:06PM +0100, Marek Szyprowski wrote:
> On 25.11.2026 14:51, Sibi Sankar wrote:
> > This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.
> >
> > Before this commit, dma_iova_destroy() unmapped through
> > __iommu_dma_iova_unlink(..., free_iova=true), which set
> > iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
> > and freed the IOVA with the queued gather, exactly like
> > __iommu_dma_unmap(). After it, dma_iova_destroy() calls
> > dma_iova_unlink() and then dma_iova_free():
> >
> >   - dma_iova_unlink() never marks its gather as queued and always calls
> >     iommu_iotlb_sync() after iommu_unmap_fast().
> >   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
> >     the IOVA goes straight back to the allocator through
> >     free_iova_fast() and never through queue_iova().
> >
> > DMA-FQ domains therefore get strict invalidation on this path. That
> > includes the block layer's blk_rq_dma_map() path, which NVMe uses for
> > all data transfers, so iommu.strict=0 has no effect on NVMe I/O.
> >
> > hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
> > 	       4K pages; NVMe SSD on PCIe Gen5 x4
> >
> > Fio sequential read/write numbers:
> >   Domain                          seq write    seq read
> >   DMA (strict)                    2694 MiB/s   2693 MiB/s
> >   DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
> >     bypassed (this regression)
> >   DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
> >     used by dma_iova_destroy()
> >
> > Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
> > Cc: stable@vger.kernel.org # v7.3+
> > Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> 
> 
> The performance data clearly shows that the flush queue was there for
> the reason. Together with this revert it would probably make sense to
> apply the v1 of the reverted patch:
> 
> https://lore.kernel.org/all/20260701092033.422867-1-honghuan@amd.com/
> 
> Leon, do You see any other option?

These numbers shows clearly that we had iotlb_gather.queued != 0
and never performed iommu_iotlb_sync(domain, &iotlb_gather); while
destroying mapped IOVA.

I agree with you, v1 is the easiest solution, however my preferred one
is to cache gather when it is created and keep it in dma_iova_state 
structure for whole life cycle of that struct.

Thanks

> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
> 
