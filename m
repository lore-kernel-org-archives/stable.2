Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB162D5A19;
	Mon, 13 Jul 2026 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915214; cv=none; b=S2KKX5NJe9sCTbllvolsoRguQalCr7cfiHTw7aXuWV/W0SE47aXlXIXF0ce/rmjzkcz/SOm8aew/6DJkBBcFPOarfoz6DuafYZ/jJ12Q/C2x+wqRJPkMZdMz8jCt+N0pFQZiP4xdrhSmy9WLNemLwipDT0xbyWEO3jlhEBxBzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915214; c=relaxed/simple;
	bh=IT4yBAUlbIHhJOiOpb3l6q1vgM1au/LT4N+jLJA+vDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi/KlzyT6O1TdeT2tiCiZwYQU8ITYJAJE/9lvH9v4jnDnUcgR48s58sUIh5RJlpDDEyl0nX2Y2ZKZ6eimbp4SAyDDxdIjP1DqpO1PUwCe5B4N/JAHZEYdY7j0Q/BU9OYllVkRGU/5A1gaY+4pjtmAXlZfWR06PE4E8wLWKUlNb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JKCK0sjq; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JKCK0sjq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783915203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ljwlEjAyEcgRK25Zkv2UU0+NoAlULoGnEZMopZiRIcU=;
	b=JKCK0sjq6RbbyX/DE11Li7nGowizchrK69kf42YjqhNx4iV5qc3Xhp1Y/7nUUQEWiDVYD/O2NJcNI0opuFTR77JmdN49elkGcaJKoiOYe4hAMC8okO7+E6DkYYW5iEOesa9MX3RDKqYjicsBx1o3DiDLHoy+/UaJaNBqoV2WM8g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X6tcPXS_1783915201;
Received: from 30.74.144.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6tcPXS_1783915201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Jul 2026 12:00:01 +0800
Message-ID: <368ddc3f-1206-4e2b-a45b-c67b0f54c58b@linux.alibaba.com>
Date: Mon, 13 Jul 2026 12:00:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: huge_memory: Fix kobject cleanup in thpsize_create
 error
To: Hongling Zeng <zenghongling@kylinos.cn>, akpm@linux-foundation.org,
 david@kernel.org, ljs@kernel.org, ziy@nvidia.com, liam@infradead.org,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, zhongling0719@126.com,
 stable@vger.kernel.org
References: <20260711084624.207777-1-zenghongling@kylinos.cn>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260711084624.207777-1-zenghongling@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/11/26 4:46 PM, Hongling Zeng wrote:
> When kobject_init_and_add() fails, the kobject API requires calling
> kobject_put() to properly clean up the memory, not direct kfree().
> 
> According to the kobject API documentation, kobject_init_and_add()
> calls kobject_init() internally. If the subsequent kobject_add()
> fails, the kobject has still been initialized and must be cleaned up
> via the reference count mechanism (kobject_put), not direct kfree().
> 
> Direct kfree() leaves the kobject's internal state (including the
> reference count and kset membership) uncleaned, which can cause:
>   - Memory leaks of kobject internal structures
>   - Potential use-after-free if there are pending references
>   - Inconsistent state with the rest of the error handling code
> 
> This fix matches the pattern used elsewhere in the kernel and in the
> same function (err_put label) which correctly uses kobject_put().
> 
> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
> Cc: stable@vger.kernel.org

I don't think this need to CC stable.

> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---

A related fix was already sent before[1]. As noted in the previous 
comments, just change it to 'goto err_put'.

[1] 
https://lore.kernel.org/all/20260412175428.2613383-1-lgs201920130244@gmail.com/

>   mm/huge_memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..7aeb17d60ac7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -819,7 +819,7 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
>   	ret = kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, parent,
>   				   "hugepages-%lukB", size);
>   	if (ret) {
> -		kfree(thpsize);
> +		kobject_put(&thpsize->kobj);
>   		goto err;
>   	}
>   

