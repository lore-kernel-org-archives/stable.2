Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790724;
	b=QxvJJxxkcp0JLlYS64oSozATRQYj9nR+V4JG3FqEo9oW4fRjbLTgib0bxH1noiJrujkd
	 T4LbTQ9XK1V7t7mfQL1kTeV62Zvi6HW8/g8VL+KIh53D0A3YKRyQ9pakOgbVJu4lKTp6z
	 xfkii8pjvL1GuNFdOPV0EK2hna4eTl6T26226ZNnfyO47WUcINquxZ3rCuRpiQ4oBBDIV
	 hM7ZG25GAA/22z5WsRZ2ux9rZ++aVQ3kf3+Fil8XlRldYQ7iKuAUNGtsF4iquK6Wv3AW6
	 AcAfcR/P8BZ7BGx/JBz3oO1K6aCG/Tw6qCxTl2RXMyLBXCO4WnUvqKaJb7uifpsADbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790724;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=LO23VuR8oz1He3kunSDVbm/R/AJdXLqeSuquj/Un54I=;
	b=30DKjxDPIpaNCBVquBEgYtJc0bivEbXWEjIDKG6IxtCwKbXAAHZC6EJkHQahUmK81hJY
	 1vn7bcl4Qha64K0c00hYlmrPnMlUrS9Pjy7I5kqgBQKo0XEJyatsS6rqSsct+fdFowjew
	 mpArS2yOq8VX7eR8KAPd4lxyx1+HFWZslC3e9HCtwv4WJNg/R4CDRAcC6hEYwTKCqreRi
	 go0PUe+IJrE7AVqiT9rmDTVM5VG12mIjQdMIVKRzz1Pkcs9MN4PIEco4W9W207iTaO7cC
	 WiOFcU3aP4yZ5mQktXHOnntc0BgQEMBN1MdWhPWu6ucbjzzIBFE2uXjzNptoELwh5rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tH0WWuAW;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADC606A683
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FADC606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=tH0WWuAW
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261127144518euoutp02752562c22e6c63ed7a19ad9ac81e3c03~r7iTZrJBv0488604886euoutp02h
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:45:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261127144518euoutp02752562c22e6c63ed7a19ad9ac81e3c03~r7iTZrJBv0488604886euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795790718;
	bh=LO23VuR8oz1He3kunSDVbm/R/AJdXLqeSuquj/Un54I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=tH0WWuAWuzPYHQm+soNKBsCky89aAJhBeNMAl+NLBMauK5hFl+uh1UAcu8tbLdEG8
	 nfJHn+PQMz0l0380GnH9tpUphr2qR24lltrW+TLLa0SnHNNvRebMYggDeIzGPDKUTM
	 7619QSF/iwix+iDn0+A0kvV6ZYYjAB+a2KaAoYZs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261127144518eucas1p22cf8f824453316c6bfb1f0a0066453b3~r7iTA2KY93155031550eucas1p2D;
	Fri, 27 Nov 2026 14:45:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261127144515eusmtip242d75ac11ad94c4e4ca4316ca179bbe6~r7iQ-8K-m1223712237eusmtip2d;
	Fri, 27 Nov 2026 14:45:15 +0000 (GMT)
Message-ID: <feec2436-ad15-4aa6-a53f-800869bfac21@samsung.com>
Date: Fri, 27 Nov 2026 15:45:15 +0100
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
Subject: Re: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Joerg
	Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Honglei Huang
	<honghuan@amd.com>, prakash.gupta@oss.qualcomm.com, Alex Williamson
	<alex@shazbot.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar
	<abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho
	Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261127143740.GM114472@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127144518eucas1p22cf8f824453316c6bfb1f0a0066453b3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
X-EPHeader: CA
X-CMS-RootMailID: 20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
	<CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>
	<20261127115849.2780625-5-m.szyprowski@samsung.com>
	<20261127143740.GM114472@nvidia.com>

On 27.11.2026 15:37, Jason Gunthorpe wrote:
> On Fri, Nov 27, 2026 at 12:58:48PM +0100, Marek Szyprowski wrote:
>> Commit 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop
>> the free_iova helper") turned dma_iova_destroy() into dma_iova_unlink()
>> followed by dma_iova_free(). Before it, the destroy path marked its
>> IOTLB gather as queued for DMA-FQ domains, skipped iommu_iotlb_sync()
>> and handed the IOVA over to the flush queue, exactly like
>> __iommu_dma_unmap(). After it:
>>
>>   - dma_iova_unlink() never queues its gather and always calls
>>     iommu_iotlb_sync() after iommu_unmap_fast(),
>>   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
>>     the IOVA goes straight back to the allocator via free_iova_fast().
>>
>> DMA-FQ domains therefore get strict invalidation on this path. This
>> includes blk_rq_dma_map(), which NVMe uses for all data transfers, so
>> iommu.strict=0 has no effect on NVMe I/O. On a Qualcomm Glymur CRD
>> (SMMUv3 without RANGE_INV, 4K pages, NVMe on PCIe Gen5 x4) sequential
>> fio throughput drops from 10.6/11.9 GiB/s (write/read) to the strict
>> mode level of ~2.7 GiB/s.
>>
>> Instead of reverting, decide once in dma_iova_try_alloc() whether the
>> IOVA space is going to be released through the flush queue and record
>> it in a new DMA_IOVA_USE_FQ flag in dma_iova_state::__size, next to
>> DMA_IOVA_USE_SWIOTLB, so struct dma_iova_state does not grow.
>> dma_iova_destroy() then unmaps with a gather queued according to that
>> flag, skipping the sync for flush queue domains, and passes the same
>> gather to the IOVA free, so the IOVA space (and any page table pages
>> released by the unmap) goes through queue_iova() again. dma_iova_free()
>> honours the flag as well. The whole reservation is still freed, keeping
>> the size fix of the reverted commit.
>>
>> A gather must always be retired, either by iommu_iotlb_sync() or by
>> handing it to the flush queue together with the IOVA, and the IOVA must
>> never be returned to the allocator while a queued invalidation for it is
>> still pending. To keep that obvious, the internal unlink helper only
>> unmaps into a gather supplied by its caller, and each caller retires it
>> right away: dma_iova_destroy() syncs or queues it together with the IOVA
>> free, exactly like __iommu_dma_unmap(), while dma_iova_unlink() always
>> uses a never queued gather and syncs it, as the unlinked range remains
>> owned by the caller and may be linked again immediately.
>>
>> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
>> Reported-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> Closes: https://lore.kernel.org/all/20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com/
>> Suggested-by: Leon Romanovsky <leon@kernel.org>
>> Cc: stable@vger.kernel.org # v7.3+
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/iommu/dma-iommu.c   | 103 ++++++++++++++++++++++++++----------
>>  include/linux/dma-mapping.h |   8 ++-
>>  2 files changed, 83 insertions(+), 28 deletions(-)
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!


What about the issue pointed by sashiko.dev? My LLM said that this will fix it:


diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0e329ecd7dfa..106da975bf0f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1892,11 +1892,12 @@ static void __dma_iova_free(struct device *dev, struct dma_iova_state *state,
  */
 void dma_iova_free(struct device *dev, struct dma_iova_state *state)
 {
-       struct iommu_iotlb_gather iotlb_gather;
-
-       iommu_iotlb_gather_init(&iotlb_gather);
-       iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;
-       __dma_iova_free(dev, state, &iotlb_gather);
+       /*
+        * Nothing is linked any more and every dma_iova_unlink() has already
+        * invalidated the IOTLB synchronously, so there is no deferred
+        * invalidation to wait for and the IOVA can be reused right away.
+        */
+       __dma_iova_free(dev, state, NULL);
 }
 EXPORT_SYMBOL_GPL(dma_iova_free);

@@ -2190,12 +2191,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
        struct iommu_iotlb_gather iotlb_gather;

        iommu_iotlb_gather_init(&iotlb_gather);
-       iotlb_gather.queued = state->__size & DMA_IOVA_USE_FQ;

        /*
         * We can be here if the first call to dma_iova_link() failed and
-        * there is nothing to unlink, so let's be more clear.
+        * there is nothing to unlink, so let's be more clear. Only queue the
+        * gather if there is an unmap whose invalidation can be deferred.
         */
+       iotlb_gather.queued = mapped_len && (state->__size & DMA_IOVA_USE_FQ);
        if (mapped_len)
                __dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
                                &iotlb_gather);



Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

