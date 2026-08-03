Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422C4219E7
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781741; cv=none; b=suNXkbmsCmQAldkU1wO+P7AuyC+KL5wk4iT7Rziodg+hEiznvE2EkrFAgHkvUBkJeNkHtjDOBdvDcdLMeP7sv44bB5Ch9fzGF3O90KMDIpLi/wLmm+Og9ucRUZo60Q2Z/voGGh3IuSa3k1+3LShXkd7Coz/W3eX+WOD9lOKnLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781741; c=relaxed/simple;
	bh=5dAW2wmbtidI5gVpvg/cVrzbBBJdhnVmI6fLJTdKrrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmI64Bu4KR3i3TiObq7xwNXnwkJRPUTXU70wbbgxeXLPE4O3Vn2y/WFRWOPaaZ3khrBHG+MSI5v0bU+1vnh+5QiC0snWkFVFJuO2WZTjNQPNk6rdKTxWE2+1ERoeqkjEHxs5BkywT99LZKh9tRzRww0AG4ecWJMEraNRelqpv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSyFt5p2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSyFt5p2"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cede6375caso18375ad.0
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785781739; x=1786386539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YCj2r/JqY5u5nyX++s6hFCTol5l9mZg/fkApmxyULqA=;
        b=iSyFt5p2kaRZat/YaTCZ3s3maqt36oI9W4N4+KXf4BV30Oahsu/TnAVcgWJSdruPcX
         QWnYtb76Bg89o4jn3D9e06to6DS+obFkxmqhfaHfh2XN0NuyGzlJYmuJKgCB7eQ5xG1v
         Sj99EH4PhogTZLq5DSl9nRdVZQ2ntPqd5xKNyxUpZ2alwT6H/FiXnpyHlvGI+xR/ISkJ
         4dFv04bea7h9U6iYhbfEE/gPSqkD1iiBQYrH+GLCvUVDX6PukUAN0sucQlpMmUyCiAM9
         jV3hAk+KitZCZQKiIONsmz98Po8LWC3lbKL36rwbEs2sJSbrQ0CbX0VttJqEzWehLDf7
         ZDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785781739; x=1786386539;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCj2r/JqY5u5nyX++s6hFCTol5l9mZg/fkApmxyULqA=;
        b=LQ0Yitp6qX/+TiXKSXZ5Z/+gYTPSt3Qnn/d9s7RYqWLbSFtg52W3Jyf/AcGJjm4H3D
         8m1GqkuMcjrB8FD7n9wBDfFsdxh/jfwb1Yz0VcDLYsjPo9Gupi/rwhhniP/IN4uJJAfO
         1nKsi2XqCuckSzPXYDGgz96K40Dm/jd/dBh2SnWzTabKgkHs3hK0Aq6izNJxnV6lV527
         VczkvttYQA6OrKpydWf5iXaDviPAPt1i5xzAkoKH+Zj2L1KNEODj43yWpuTOT0XxgYd2
         KSObFMzlz5r0hvjs9k8zOeVfDSCS/OxlKmbPL4YqK9tJlKfRuBODgu40sQE8Cl7MBe/W
         n7EA==
X-Forwarded-Encrypted: i=1; AHgh+RqZ0fdC/e55WK7MgK3FnX7wN9zlAfC2NyUfDLQmFPw+aUCxmzyA/nhzsLMMV4e40OeT3Y6arWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1whB6klhFYzODFBSj6IyXA8Ze3kK79XzIZoLxosiSHlOzpGSu
	ozGHd7Du56MAuWpsAfP72167Z1ytkQfGCTT49FEM0aaSj0MSs8PjJEtcmxgqMiRBHQ==
X-Gm-Gg: AR+sD13JH2K7w/EQUaSm2C4mDjBd9K0bNkezFNWEOyflxD3OYyFylxGPmGQ+uugrFjx
	R6gzc8dGdoEYOF+En7YKEwSlfSSsCfkAeat9DMlkGd6ELyoBSZq8MJfScU6XIFIYc4rcIcsBmLW
	sR/BCUUFf4Pom9SywSADk7Sj10rGCV92nR1EMt6Dfy6r0VZpdqg9cwCietBNG9FcpJy+68sAlOQ
	G0GiHfEArj2iOovshmf1t4PCXPgz8NsDIpfiriAhDUyzXCx/eIpBQEBlLME5t/3mOAEPWL9EhNf
	kRDTwyIVW3gDJRveWaGOm8RrPui0YwOgzrhM+jH++gyEnvzgI1Z2QEwtyIk/WbDADJ7yXin0qz6
	XdouXqS8FLfVvzDRpCg4gZNWgw/0ZLWVsMePoL/ri649Y1fT6gnenrlU0ya5nHYAdkyTb0wXuiV
	gGAQIXje+zOeFveFTQ/lf2UbbSZrxDV5v1TOPj/XppPEi1mXL9eIATWnXusR+f59PYEAT+LFKo3
	aSF2IFCJqJIEm3zJswDMRKz3Oin5QpSMLWyTY8L0iVxXe/4sNs4IZ/dEPSsEr1LRupPAw==
X-Received: by 2002:a17:902:ea0b:b0:2ce:b436:272a with SMTP id d9443c01a7336-2d08cdb06a7mr964365ad.3.1785781738650;
        Mon, 03 Aug 2026 11:28:58 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe396ea598sm4113578a12.19.2026.08.03.11.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 11:28:58 -0700 (PDT)
Date: Mon, 3 Aug 2026 18:28:55 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 1/5] iommu/vt-d: Fix shift overflow in
 qi_desc_dev_iotlb_pasid()
Message-ID: <anDd37AO0g0Budzu@google.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
 <20260731054329.2948252-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260731054329.2948252-2-baolu.lu@linux.intel.com>

On Fri, Jul 31, 2026 at 01:43:25PM +0800, Lu Baolu wrote:
>Callers request a full Device-TLB flush by passing MAX_AGAW_PFN_WIDTH
>(64 - VTD_PAGE_SHIFT == 52) as @size_order.  Two shifts in
>qi_desc_dev_iotlb_pasid() are not prepared for a value that large:
>
>  unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>  ...
>  if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
>
>The first evaluates to 1UL << 63.  On 32-bit builds this is undefined
>behaviour; in practice x86 masks the shift count to 5 bits, so the
>expression yields 1UL << 31 and ~mask becomes 0x7fffffff.  That value is
>zero-extended when it is applied to the 64-bit descriptor, so
>
>  desc->qw1 &= ~mask;
>
>clears qw1[63:32] as well as bit 31.  The ADDR field, which had just been
>filled with ones to request the widest possible range, collapses to
>0x7ffff000.  As the S bit remains set, hardware decodes the least
>significant zero bit of ADDR and invalidates only 2GiB instead of the
>entire address space.  Device-TLB entries above that boundary survive the
>unmap, leaving an ATS-capable device able to keep accessing memory that
>has already been freed.
>
>The second shift, VTD_PAGE_SIZE << size_order, is 1UL << 64 and is
>therefore undefined on 64-bit builds too.  On x86_64 the shift count
>masks to zero, IS_ALIGNED(addr, 1) is trivially true and the sanity check
>silently degrades into a no-op.
>
>Compute both quantities in 64-bit and clamp @size_order to the largest
>range the ADDR field can encode.  Capping at 63 - VTD_PAGE_SHIFT keeps
>the intended "flush everything" behaviour: qw1[62:12] is set, bit 62 is
>cleared as the size indicator and the S bit is set.  The non-PASID
>variant qi_desc_dev_iotlb() already uses 1ULL and is unaffected.
>
>Fixes: f701c9f36bcb7 ("iommu/vt-d: Factor out invalidation descriptor composition")
>Cc: stable@vger.kernel.org
>Reported-by: Sashiko <sashiko-bot@kernel.org>
>Closes: https://sashiko.dev/#/patchset/20260623060122.3796325-1-guanghuifeng%40linux.alibaba.com
>Assisted-by: Claude:claude-opus-5
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>---
> drivers/iommu/intel/iommu.h | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>index c00f44db0020..8a59c7c9d0a6 100644
>--- a/drivers/iommu/intel/iommu.h
>+++ b/drivers/iommu/intel/iommu.h
>@@ -1105,12 +1105,20 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
> 					   unsigned int size_order,
> 					   struct qi_desc *desc)
> {
>-	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
>-
> 	desc->qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
> 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> 		QI_DEV_IOTLB_PFSID(pfsid);
>
>+	/*
>+	 * The invalidation range is encoded in the ADDR field, which only
>+	 * covers bits 63:12.  Clamp @size_order so that callers asking for a
>+	 * full flush (e.g. with MAX_AGAW_PFN_WIDTH) do not overflow the
>+	 * shifts below.  The clamped value still spans the whole range that
>+	 * the descriptor is able to express.
>+	 */
>+	if (size_order > 63 - VTD_PAGE_SHIFT)
>+		size_order = 63 - VTD_PAGE_SHIFT;
>+
> 	/*
> 	 * If S bit is 0, we only flush a single page. If S bit is set,
> 	 * The least significant zero bit indicates the invalidation address
>@@ -1120,7 +1128,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
> 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
> 	 * ECAP.
> 	 */
>-	if (!IS_ALIGNED(addr, VTD_PAGE_SIZE << size_order))
>+	if (!IS_ALIGNED(addr, BIT_ULL(VTD_PAGE_SHIFT + size_order)))
> 		pr_warn_ratelimited("Invalidate non-aligned address %llx, order %d\n",
> 				    addr, size_order);
>
>@@ -1136,7 +1144,7 @@ static inline void qi_desc_dev_iotlb_pasid(u16 sid, u16 pfsid, u32 pasid,
> 		desc->qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT - 1,
> 					VTD_PAGE_SHIFT);
> 		/* Clear size_order bit to indicate size */
>-		desc->qw1 &= ~mask;
>+		desc->qw1 &= ~BIT_ULL(VTD_PAGE_SHIFT + size_order - 1);
> 		/* Set the S bit to indicate flushing more than 1 page */
> 		desc->qw1 |= QI_DEV_EIOTLB_SIZE;
> 	}
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
