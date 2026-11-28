Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847037;
	b=h/rJhocWo+ijIj+PwWLSHt60O93eByQYDA8K8qP+rHJbn/SSXyvI53pet7t62FdixnBo
	 ZsIknDfmZGlRnlXzyxybv8E+ugSqqiFJh7FGn7j5uHIsdNCo2GfG/EbcqKd3PuJy1XF6f
	 QLH8SzZoOROXmf68Eqvd+0c4otsYPwpKIKLHVE3zPPD8Otu/k98eomjCrXAdUUOvhvCrf
	 Yt+DpAWOdyFUOrTY3C9J4EmtSCWEBdGdAWCjBNMeYZ24tJgF4skuWuFycehiNmh1bB557
	 Gyb72/CZXmXDOcDH6fr+OMJ/z6l/0fcGZG3lz9+ClV8ehwg4s1hkNAwZrOrJgLLhOeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847037;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8Qad8FBrWmSXpIHn7XB6n6a/R6xdfCdRWpV3iuJaBbU=;
	b=2TiIPL9PeJsHjZSuBm+75ek89V1yee72GBQNdBvQjOBvNXnaPQ65jVmvXNU4K7txETXR
	 ttFvZ5U5HCa2GcLZMOU98BGm9nZCUMdLcIyvOk1f/ldwkVXIuyR3sN4WUuDR44YJWVF03
	 Xapnrh15tZCBUgUTrYs2dX81Ar/MobWzB5SlB3klBpxbS329G7WotNkxrBREBHuDrHSm8
	 s6tLmAD8jmd1XxxdovP6RXfqO8zWBFf9ttlJKtWzD9h/gq8hZfbk1Ytl2boh2+9YMG/Fs
	 Rl9qqGjv83nvP2AXPLi2r5M/mYor6pB4AimRvBwnziFunjtga2X0dlL1qI1FfbwQn4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz97vZR6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70192606A31C;
	Sat, 28 Nov 2026 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yz97vZR6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB0F1F00897;
	Sat, 28 Nov 2026 06:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795847037;
	bh=8Qad8FBrWmSXpIHn7XB6n6a/R6xdfCdRWpV3iuJaBbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yz97vZR6AFMYEfOORuZLTjCNfBDdyDW0ZjCGakD9lLhVzzObv6RdEC1MBK1XGDIRG
	 W2NCADnFryfB9Lirn7seK6SW/Wp5E5gBclImK+hmHviZU4MCFZPQRk3GGySw1hMmBW
	 8fCTeHGjjj5GF59IU/sRhU3gk8oMKhq8agQDFPRRgSTnTA8P5ClIVJwwi8QThojTNj
	 zAUpjGDyYqepYo7f09sqyp53Lulvu/+BaUxT2NAuG7nvbhCFq4ZFlrBoDYANEBX/r7
	 rgvsGfVjFeFX1QyFrWs3tuFrWN7z3YCpXvtgNdLsGkrTFqrwaUQG8is/e/9ZNwfqOn
	 xZO6KD1FPwyFw==
Date: Sat, 28 Nov 2026 08:23:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Message-ID: <20261128062353.GG774860@unreal>
References: <CGME20261127171534eucas1p1adc65490fcfb09b573d27aaa834f2912@eucas1p1.samsung.com>
 <20261127171529.2917893-1-m.szyprowski@samsung.com>
 <90e159b3-ef50-4d03-937a-ced5896b152a@arm.com>
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
In-Reply-To: <90e159b3-ef50-4d03-937a-ced5896b152a@arm.com>

On Fri, Nov 27, 2026 at 05:30:26PM +0000, Robin Murphy wrote:
> On 27/11/2026 5:15 pm, Marek Szyprowski wrote:
> > Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
> > the free_iova helper") turned dma_iova_destroy() into dma_iova_unlink()
> > followed by dma_iova_free(). Before it, the destroy path marked its
> > IOTLB gather as queued for DMA-FQ domains, skipped iommu_iotlb_sync()
> > and handed the IOVA over to the flush queue, exactly like
> > __iommu_dma_unmap(). After it:
> > 
> >    - dma_iova_unlink() never queues its gather and always calls
> >      iommu_iotlb_sync() after iommu_unmap_fast(),
> >    - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
> >      the IOVA goes straight back to the allocator via free_iova_fast().
> > 
> > DMA-FQ domains therefore get strict invalidation on this path. This
> > includes blk_rq_dma_map(), which NVMe uses for all data transfers, so
> > iommu.strict=0 has no effect on NVMe I/O. On a Qualcomm Glymur CRD
> > (SMMUv3 without RANGE_INV, 4K pages, NVMe on PCIe Gen5 x4) sequential
> > fio throughput drops from 10.6/11.9 GiB/s (write/read) to the strict
> > mode level of ~2.7 GiB/s.
> > 
> > Fix this by letting dma_iova_destroy() unmap the linked range into its
> > own gather, queued for flush queue domains like in __iommu_dma_unmap(),
> > and retire that gather together with the IOVA free: either by
> > iommu_iotlb_sync(), or by handing the IOVA space (and any page table
> > pages released by the unmap) over to the flush queue via queue_iova().
> > The whole reservation is still freed, keeping the size fix of the
> > mentioned commit.
> > 
> > A gather must always be retired, either by iommu_iotlb_sync() or by
> > handing it to the flush queue together with the IOVA, and the IOVA must
> > never be returned to the allocator while a queued invalidation for it is
> > still pending. To keep that obvious, the internal unlink helper only
> > unmaps into a gather supplied by its caller, and each caller retires it
> > right away: dma_iova_destroy() syncs or queues it together with the IOVA
> > free, while dma_iova_unlink() always uses a never queued gather and
> > syncs it, as the unlinked range remains owned by the caller and may be
> > linked again immediately.
> > 
> > Consequently dma_iova_free(), and dma_iova_destroy() with nothing
> > mapped, keep returning the IOVA directly to the allocator: no queued
> > gather was ever created for it, so there is no deferred invalidation to
> > wait for.
> 
> From a quick skim, this looks about right to me. Note that a single gather
> in the dma_iova_state itself would never work anyway, as multiple threads
> are still free to unlink non-overlapping parts of the range simultaneously,
> so gathering always has to be per-call.

It is reasonable to expect such concurrent accesses to be protected by locks.

Thanks
