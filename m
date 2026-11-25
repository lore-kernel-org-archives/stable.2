Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629350;
	b=pRQkSoEVMvgBFoDf87NZ6MQciiRL3UegykytNg6XbL97yRK+ti/DDkmSzaifQXFHd0pI
	 YjXoxpzIJXPuQYrHukvx2rO8z5eA6E4iuu3WMhtXsdT/u7SIwGME4mq0GjaBJiU02I9/r
	 ZfvWhqkp8r+BBK0UgxvXC6IAzNu7BXalgT9rrH3tY/03cmsQcH1oCp3HTNv/7pzkvCJtn
	 pb+a0YesNkzYMBWVJgKu0x6x2isvWptcZOOYGUlsm9JXu3sxvmHSPfIONDCj4313a/G2S
	 8DXxh9zZjTcR1ykd3vGuNg7Ik7Qc+9MhncKcYIgxZByT1EwKywOsFfXkRFSRAcpsfqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZhgvvGhr19GJBCcJ3nyYAHYL8qsS8Qu8flUoaHfsv+4=;
	b=iPfdfPTb6fDd51uVQ1ZufeaJxrQCsLmjQ4QUQ8FTtCIV6bbROnia17kNuy/2wc1HSwk7
	 SAK8SwOk7pioUwjFPDLVtAHcYwr7+5VeqJXODYoz35hd4OkRMPUzGlikJCbTOqWOQrTnr
	 J6K8cBmF5lm9/fR2EqeNR0x3ktEvJwGNHr5ZVEW4kTurGRAiDbrVcb89o1lXjDZF/qF/b
	 YrywwjBY2Fz/yJU1DMya4DLUjvvtrD31AiBVPy42rRHK3PnWdwE3ATGb3Ut6aEPr1SXaz
	 a0WPv18hahNfjvT5VYVqLqgqzUngVC5l0OrLJFVLca4Zk5zRhQJ+/yF4D8wPlmZT6sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nM473gLh;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF3606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0EF3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nM473gLh
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5363316fa0cso63330121cf.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 09:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795629349; x=1796234149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZhgvvGhr19GJBCcJ3nyYAHYL8qsS8Qu8flUoaHfsv+4=;
        b=nM473gLhDt8L/AJd71rb7S0acFRmXcxuz14+e2lo8uQc+NdtG5xkQav60aRPMBb/MN
         gpXZdrYOiuIgSZDDd7rHOb4JNczuwWoUuTAycUVrhtyac1v4YoF6ULTz7x0hodXNenpT
         1iEgT+UaS2OxnKWIjAOcUo9wguQQi0DtexdJUIvU2cYDKsbfXNJiPJ2UJHHjg0AFUdl/
         lwtDRt9A6dtMUgTXS3ktbG1CYUYJ5ip+LCct/huS0rreCifzPVHnU/ZPNPA8hYkYzsOc
         5snmpulZ1L88WXu/rnUo3WoM6eTvor835r8zO+jxN5Nzh88vlPSiDzZVpYfH8veC4k2V
         R2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629349; x=1796234149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZhgvvGhr19GJBCcJ3nyYAHYL8qsS8Qu8flUoaHfsv+4=;
        b=rz89wOcJItQRYSkjnIUC+yyjbNEkaWQp0Ei3Hjo56VO6kyrzYunJBzUiXG5DORVaKc
         sGuj3tC7AYBlCQ42xrM94RDj8zGEnMDC9oYW7XIBmviy6ykl5kUiEldGJxGv0oY4jY3z
         LTOEaNlXxr6URTJDGClcHfXAqe0CPmpkmGqNhyNma5qpk6P3UGKkvBZ/+OQ/z+1BJRu4
         MeYv+kOGUOYf3Jn182DAp4ITGueliiK8RNmi3ib/uvjXzIFhjzicgUFimjAWHe9D0/vc
         J84KaVOS/jtxYVRaltZulz/5uuYtkFwIrU/2HZNSkjy9f3ASsRta/lNV4GB4M7jiFyjJ
         tDew==
X-Forwarded-Encrypted: i=1; AL+hErEpyM7QgxG1v8k/a4D6jqRoE7g2zFw4z28pPeFZOCxVJLUqWzDzTKRKjjDO3uTnXT7St3V8QlA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9InRKpi2nPNDaeV0BAwFnvmoi4KplOiVF/LV3j9KP64uvPS37V
	RLHJQY13qme6uz8teZdQKTkBKLpb72IPLMAgby6uImoZnYhyRHz6U6lvv+h5YZacpdo=
X-Gm-Gg: AZFdTZfOQCsYT8tEjv1yQ0HKA1rzqzkpxR3vH9W96oL3mSzWdINnOg4Ff1QucJui/mp
	58WT9rxE5Bj1LCVxf2wuWZqufxi4o7YN7EQdzPnTGkBBLJuRBj4u33mwR93qdr0EFeWmMyXUTjn
	+lcAWf5VkKmXbujSKCIMj7r/r0YC49JxfoHsNY1779XjX5hcgzdhoyE713QAFOEvK0jymYC3er4
	n836hcP1APV+DVq8kwp2oYS0wTjszFgqSr0RIJ0tQm9D1JWEH7aEjTCd9Qk+51psIKOpW5zKO+F
	8dmday6CJPgsji/7sGDV8Ej0AHH+aUpXL8tn1Zg+cqIeHbVHalcv3zrTqppeKxOJW+rbvL/Q9Mh
	OEQH3V+LAUyobm9flZZntEESPHx8sOjPMp3eWt95OVNIzp0mL8Opvlu5lvB4go4W090seFFpa8r
	u1Ps95EqTD1rGVTy+SfbQzAggOZul/XfciaCfY00zoVO/wRIQ04Tm1sMLq0dGUqTDxTeJEzB/Is
	VXjKIN9tbnoJXLpjkMN/1cUlaCSPtIsQufXyKl+wEKlwggZJGcpnm56/bSzDSl3F97Yw7YxqWT+
	ILxt/Q==
X-Received: by 2002:ac8:5706:0:b0:536:3760:e6cb with SMTP id d75a77b69052e-55d769e9387mr335085841cf.14.1795629348805;
        Wed, 25 Nov 2026 09:55:48 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dbb8546ecsm18274511cf.4.2026.11.25.09.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:55:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWHDf-0000000298s-0hJB;
	Wed, 25 Nov 2026 13:55:47 -0400
Date: Wed, 25 Nov 2026 13:55:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, will@kernel.org,
	robin.murphy@arm.com, honghuan@amd.com,
	Leon Romanovsky <leonro@nvidia.com>, joro@8bytes.org,
	prakash.gupta@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "iommu/dma: simplify dma_iova_destroy() and drop
 the free_iova helper"
Message-ID: <20261125175547.GM246011@ziepe.ca>
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

Oh, there are a couple of issues here too, and reverting isn't fixing
the main problem with this..

The issue is the assumption we can separate the sync from the free:

       if (!iotlb_gather.queued)
               iommu_iotlb_sync(domain, &iotlb_gather);
       if (free_iova)
                iommu_dma_free_iova(domain, addr, size, &iotlb_gather);

We cannot. The gather must always be retired, either be calling
iommu_iotlb_sync() or by calling iommu_dma_free_iova(). It can never
just be left dangling.

Further you can't call iommu_dma_free_iova() with a NULL gather once
unlink has been called. That risks things out of order where the
rbtree can show the freed iova before the associated queued flush has
happened. That is a correctness issue.

I suppose the resolution here is to feed the gather up the call chain
and allow it to be retired correctly instead of trying to short
circuit it inside the API.

Jason
