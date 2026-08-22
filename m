Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7035200B;
	Sat, 22 Aug 2026 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787378632; cv=none; b=sehZiQ5TUclMjXONKGkUpXgTZVER2FCwqNUEwWqeuSl+nFzbpDiNvkmWd70vZLfAGwFydOkaV7Z8zHAUrgM+RQvIm40lVrOsLX6n586MMP7Q/KvR6bdpffjW/7xbQ2iheeirbVZOKf7phNYG8v2RHUiZurwXv3wEe8ZZyenCDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787378632; c=relaxed/simple;
	bh=2qmEY59LRUwjI2/5t1tiQmX7YSnHzdsxi6RTUHcpmZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsUkY/xKa65ox58LaBgzPsqZ+LwjXxYD8VCwOpH17nP7tTtpvJXSCzLkmMf3xWg7fBnbu4J2sQPOk7gtkTVVWlhxPsqwU7xp3/sMTuVlLoUUkrNhnNqaG5H2Pv/TwdGD4FujrlVE3F/aPPUacLX/h8Ieyeh8W6Z8W8rwAc0cJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o9qwVRBD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o9qwVRBD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787378619; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=CGPYWtWNVk4w8ymoPShejTUfkVVQR1DzwVOMfU0MGMM=;
	b=o9qwVRBDDGKFErkdIV4noGzWjeptNcm3P0RWSWDuMvtjEHSmo5rM8b4Ap73FPn95ZnIQ6aMRq2yX5J9RWj6YLXRg6Ik8thpVe5h55SQmOtaNHfC12lS38v8FntAyYh575kyAyW6mosK3eBF5+YofbfyEFC4INB4hl1eI4m4fV/k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X9NnF39_1787378618;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X9NnF39_1787378618 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 22 Aug 2026 14:03:39 +0800
Date: Sat, 22 Aug 2026 14:03:37 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Alexander Graf <graf@amazon.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-contiguous: fix truncation of numa_cma / cma_pernuma
 sizes >= 2G
Message-ID: <aok7ucUXfup4iXC_@U-2FWC9VHC-2323.local>
References: <20260821224252.70640-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821224252.70640-1-graf@amazon.com>

On Fri, Aug 21, 2026 at 10:42:52PM +0000, Alexander Graf wrote:
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
> ---
>  kernel/dma/contiguous.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index f754079a287d..66093460584e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -140,21 +140,22 @@ static bool numa_cma_configured __initdata;
>  static int __init early_numa_cma(char *p)
>  {
>  	int nid, count = 0;
> -	unsigned long tmp;
> +	unsigned long node;
> +	phys_addr_t size;
>  	char *s = p;
>  
>  	while (*s) {
> -		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
> +		if (sscanf(s, "%lu%n", &node, &count) != 1)
>  			break;
>  
>  		if (s[count] == ':') {
> -			if (tmp >= MAX_NUMNODES)
> +			if (node >= MAX_NUMNODES)
>  				break;
> -			nid = array_index_nospec(tmp, MAX_NUMNODES);
> +			nid = array_index_nospec(node, MAX_NUMNODES);
>  
>  			s += count + 1;
> -			tmp = memparse(s, &s);
> -			numa_cma_size[nid] = tmp;
> +			size = memparse(s, &s);
> +			numa_cma_size[nid] = size;
>  
>  			if (*s == ',')
>  				s++;
> @@ -207,9 +208,10 @@ static void __init dma_numa_cma_reserve(void)
>  		pernuma_size_bytes = cma_get_size(dma_contiguous_default_area);
>  
>  	for_each_node(nid) {
> -		int size, ret;
> +		phys_addr_t size;
>  		char name[CMA_MAX_NAME];
>  		struct cma **cma;
> +		int ret;

Looks good to me, and thanks for the fix!

Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
