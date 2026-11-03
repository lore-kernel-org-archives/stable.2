Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703423;
	b=yuNpSwjXskvGAN22fxb1sOcIdguZCRdhl+ydGyM9nb1GCKJjlaAGlqDMZhKLbKOnLU2h
	 aRcivtWIW12lbna/LG5OIYfDGtUgwqZzuF9+O6VCLPlmDHUZ+uwVUnYiGDFP/uHwCGDqq
	 LVJ4bmGbKMWnNLb1mZ4HCIdOYWNbqx19IDHlFa7VmVMJb2dkGt1Qmo6PtBSBTkg8PSDw0
	 bDOEuDchl3dgJd4Y6/sjC+bRb+SKZKz75Sgaf5AUiqzQ2EKREz8/CE89rgT7/uyl8ushl
	 ci4dTdRyWyFdAv6fwIFvXicgZNjieBKbxHxSiY1nepQpzD+wuRT4MrJbLyvz3agK9Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703423;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=cFdQ6prKPN0fVpDGNOM9j75u/A7Rwlpi6Mh1u9hdWiA=;
	b=OLLnB8nzUjbpwodclWq8VyrrGHGD5qRIbfW0rnJ7u7Cj6v1+vSt/CW8hw0rH4GKJ0MSZ
	 Bh2EkMbzKob5w6FX4aFlt5DoGdWvOUjz00RZwDdrnmrvvvIPNhLqz3A/mDCdqaR7iCRq3
	 7HYdD6tdqrmnZBAKIwSQDaEYkq/be59CjHL72NgvJwZeS8FVpILVFDon8TW2EEdju/Q2z
	 U9D0BMyisHamQReJOU8ZtFESFPTQ+g+cH5VotyoRRVzLPVMxySm/vR8TmrtVWneXgXAG2
	 60Xu2mFNAvoiQcxUo1EPWJV2IQl/1m0SQhUxd+ijaJbuT15Y3NYXyJS8M9WcTgomxkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Q8ECWup9;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FCE606F7D9
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2FCE606F7D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Q8ECWup9
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261103105659euoutp023e9ce14b42a42f724f7a67741d681bd1~kg8HLXzvM1201612016euoutp02c
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:56:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261103105659euoutp023e9ce14b42a42f724f7a67741d681bd1~kg8HLXzvM1201612016euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793703420;
	bh=cFdQ6prKPN0fVpDGNOM9j75u/A7Rwlpi6Mh1u9hdWiA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Q8ECWup97S5okpt4kL6bPj+NOo0s1VQyH/EJMhFDxWmwvXRrBatcsVRfF7oYB6QYs
	 87ODuVYfUrZINVPqQm1oEfUn3slXJscdhP27hASwexrlIgHCaAEau7oVGsZY+le3E6
	 jJYWWzACo7hsNd72IKiO+Q/scHe8TDjSCb+9wKPk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261103105659eucas1p13666e7692d2b66477f7226dbb9ff0714~kg8G8z4GM0743307433eucas1p10;
	Tue,  3 Nov 2026 10:56:59 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261103105659eusmtip2db0935c8ac86b48bb9ade39923c4d8e0~kg8Gm_qSB2162521625eusmtip27;
	Tue,  3 Nov 2026 10:56:59 +0000 (GMT)
Message-ID: <eaa6bd75-d81e-4432-a950-e38cf98e1d06@samsung.com>
Date: Tue, 3 Nov 2026 11:56:58 +0100
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
Subject: Re: [PATCH] dma/pool: eliminate CMA alloc warning in
 atomic_pool_expand
To: Maximilian Heyne <mheyne@amazon.de>, stable@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolas Saenz Julienne
	<nsaenz@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261030-ghent-tubes-5abba7d2@mheyne-amazon>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261103105659eucas1p13666e7692d2b66477f7226dbb9ff0714
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030100043eucas1p195785d2a92ca9ff72ce7dab2fc397f20
X-EPHeader: CA
X-CMS-RootMailID: 20261030100043eucas1p195785d2a92ca9ff72ce7dab2fc397f20
References: <CGME20261030100043eucas1p195785d2a92ca9ff72ce7dab2fc397f20@eucas1p1.samsung.com>
	<20261030-ghent-tubes-5abba7d2@mheyne-amazon>

On 30.10.2026 11:00, Maximilian Heyne wrote:
> atomic_pool_expand() allocates with decreasing page order first from the
> CMA and if that fails via alloc_pages(). If the cma allocation fails a
> warning, such as the following, is printed:
>
>   cma: __cma_alloc_frozen: reserved: alloc failed, req-size: 4096 pages, ret: -16
>   cma: number of available pages:
>   cma: range 0: 1024@0
>   cma:
>   => 1024 free of 1024 total pages
>   DMA: preallocated 262144 KiB GFP_KERNEL pool for atomic allocations
>
> In this case the allocation succeeded via alloc_pages and therefore,
> printing the warning is not necessary. Therefore, similar to commit
> 463d439becb8 ("dma/pool: eliminate alloc_pages warning in
> atomic_pool_expand") silence the warning also for the CMA attempt.
>
> Fixes: d7e673ec2c8e ("dma-pool: Only allocate from CMA when in same memory zone")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

