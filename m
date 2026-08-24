Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46E42E430
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579261; cv=none; b=LkOeKSnmhsAwe2KOOrDrJcTUZO0hCrgaaO9WoFHHLLlIV9KpV4honDBfoBLt9NKjVVvc9KyV427IWcAdOiS2HN1KBMbIvSwrycmylFBnawnUJ8MWp4RY5dl211VE+ap+oYQYg9n8uyyLzAR8fbiOhp7PpmL+L/npTT83wM0GgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579261; c=relaxed/simple;
	bh=OeCBjZq5N/oLXV9wNM3gAgzNWZ+9XiSLq4j8UNKYlg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=cMECbYuw9Mh1637RN0iPJtXCVmd/hPKJBM9RD7fyb6RKDiPYMDLtMQTtd9aISyfEjM9ADCn0IqymRs8N/LJ+kOrb2rBmRi2tvJ7KhI+S5Ct0voGmUXkOHXrZCCqLLA8Vsj5GQbqSJamxPP1IvXVPfqINzD/4MFKub3xmYjrm67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JaoaFiq+; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JaoaFiq+"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260824134734euoutp02d3004bb9dfe7613308d5f76d8726cc75~OwdxLYAhr0991809918euoutp02h
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:47:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260824134734euoutp02d3004bb9dfe7613308d5f76d8726cc75~OwdxLYAhr0991809918euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1787579254;
	bh=JR4DDH5PWZ/JMNU6Gi/68Pf6lEFV9F51DVbnN26bzKU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JaoaFiq+TkG2O13Qx1Rn+aUyTb5bEwX3yS/1dc4eT4u61KXhai+MbGsv6i5nd8bq8
	 ljvf0tAMXhHuYxILYfYl1EhDtExTgaGjf1/Q7fqSL2T+njbNQMTXvHZGumHDn4oZtw
	 K4v/fxkn31mhXmUkp75rhXUpC1vsh/0vgrZJwxYE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260824134733eucas1p1da2d16e50672648bbd4fef15c18c19d1~Owdw6NpQe0876408764eucas1p15;
	Mon, 24 Aug 2026 13:47:33 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260824134733eusmtip1448e529e85d58c56d5ceba3078b1e157~OwdwbRjmo3046430464eusmtip1o;
	Mon, 24 Aug 2026 13:47:33 +0000 (GMT)
Message-ID: <e2e039d1-5969-4325-8d9a-bd8e65dea916@samsung.com>
Date: Mon, 24 Aug 2026 15:47:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-contiguous: fix truncation of numa_cma /
 cma_pernuma sizes >= 2G
To: Alexander Graf <graf@amazon.com>, Robin Murphy <robin.murphy@arm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260821224252.70640-1-graf@amazon.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260824134733eucas1p1da2d16e50672648bbd4fef15c18c19d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260821224302eucas1p29945ae5d2aeabd37ec1463a74dfe9ffd
X-EPHeader: CA
X-CMS-RootMailID: 20260821224302eucas1p29945ae5d2aeabd37ec1463a74dfe9ffd
References: <CGME20260821224302eucas1p29945ae5d2aeabd37ec1463a74dfe9ffd@eucas1p2.samsung.com>
	<20260821224252.70640-1-graf@amazon.com>

On 22.08.2026 00:42, Alexander Graf wrote:
> numa_cma=0:4G reserves nothing at all. dma_numa_cma_reserve() copies the
> requested size into a local int before handing it to
> cma_declare_contiguous_nid(), so 0x100000000 truncates to zero and the
> loop skips the node silently. Both parameters are documented in
> kernel-parameters.txt as nn[MG], so that is the syntax the documentation
> invites.
>
> Which bits survive decides what a request turns into: 4G, 8G and 16G
> reserve nothing, 2G, 3G and 6G sign-extend into a size the allocator
> rejects with a warning, and 5G quietly reserves 1G.
>
> It reaches further than those parameters. On a CMA_SIZE_PERNUMA kernel
> with no per-node parameter, dma_numa_cma_reserve() takes the per-node
> size from the default area, so a plain cma=4G on a multi-node machine
> feeds that size through the same local and loses every per-node area.
>
> numa_cma_size[] and pernuma_size_bytes are both phys_addr_t, so use it
> for the local too, and give early_numa_cma() separate variables for the
> node id and the size while in there.
>
> Fixes: d5cae2261b86 ("dma-contiguous: simplify numa cma area handling")
> Cc: stable@vger.kernel.org
> Assisted-by: Kiro:claude-opus-5
> Signed-off-by: Alexander Graf <graf@amazon.com>

Applied to dma-mapping-for-next. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

