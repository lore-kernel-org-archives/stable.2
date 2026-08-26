Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FF3BD651;
	Wed, 26 Aug 2026 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787736499; cv=none; b=hRse3eLiMa7YsRm/pTSGxLo6XfktgM4ugV2MMehiUtt0jiMwiCAD6Fe7MtIrzv5QGAPLm/C4+9bNO4+ZUzRJpK4MfskOmgxJPOTFimQJLveFLGwKXtTclzjXaMRlygm4jBWdZLIcsVLZ6gx2huoNiF2XXJeLa1PNwsQsVUfrHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787736499; c=relaxed/simple;
	bh=zOlZYyvRs9ChzGU73C832xzR4WXH1lB3xuJGvoCrFpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFjgfMzBgEUCJrtpPh7KO9sGuHfHu+AVtFxlaFJqIcoV4bdgMI5kNrnkqsC9pt79dIVtgRVF4M/vXgd5P08lpdl5dOA2qMJ4KlHIhw8aYqwOEdoDAkYIxlzGUwDvsey8M5Z11p584nX1z4QWXuVLVm/wom5qja55/z9CBxso1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkFXSijR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkFXSijR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751711F01561;
	Wed, 26 Aug 2026 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787736497;
	bh=VkPDzgtqpJZ+C+pFu3IpQfmXypArccQSfZj/VF6NMbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RkFXSijRbA6EM3ZrjDU8tSwuriXKTTOKjpopi5CErpNWTeCRYBX/qsSUpyn8Ggw/R
	 kPodnkEfLkODpYExzkYsht60y+Ht4NVpAtwCjHkGW071tyXfWzKONDRORVx0+2QE2h
	 zAUsNR84Y0VJkVKEYg+xwJ/PsQmf2mhC46R5H69eX6Rj0okfWJkL0JaWA24/a/ue6K
	 8S/3idW0QkFMKJ3nRlZj8zfw3V9bg3e/B1zBxkMQNBUagKF5Fq7fD2KGSvyp8gNOXB
	 7N8bQJJqeIvVJDE0sVvbKo0VkfJSliyfgJII+5KVQG+v9W2NAhWYpNB1mlsc33s3gV
	 W90ZgP8IBSMLQ==
Message-ID: <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
Date: Wed, 26 Aug 2026 11:28:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
To: Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org,
 syzbot+805630f1453e490427fa@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 22:40, Zi Yan wrote:
> kmalloc is used to allocate physically contiguous memory for kernel
> allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
> the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
> sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
> because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
> with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
> kmalloc size bigger than KMALLOC_MAX_SIZE.
> 
> Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
> Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
> Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
> It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
> requests excessively large memory from kmalloc. Instead of adding
> __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
> kmalloc to return NULL without a warning for this specific issue.
> 
> [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")

So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()

        /* Don't even allow crazy sizes */
        if (unlikely(size > INT_MAX)) {
                WARN_ON_ONCE(!(flags & __GFP_NOWARN));
                return NULL;
        }

This comes from Linus in commit 7661809d493b4. I'd do the same thing here
then. Thus there would be a useful warning for e.g. development mistakes
resulting in the size to be unexpectedly high.

Callers passing size that comes from userspace or similar untrusted source
can either pass __GFP_NOWARN or sanitize the size to what they expect to be
sane (which is context dependent and I assume actually way lower than
kmalloc limits in practice). Note that passing even sizes within but close
to/at the limit, trusting blindly some external source, can succeed the
allocations but effectively DoS the system with heavy reclaim/compaction. So
caller sanitization should still be preferred IMHO. Some of the recent
arguments from Linus [1] would apply to this too, I think.

[1]
https://lore.kernel.org/all/CAHk-=wiSmgwwLKCqJwGS-dVHnSLU8W+7q1UQq-G9=TBGGZbuhQ@mail.gmail.com/

> ---
>  mm/slub.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 0337e60db5ace..a3071f4ef1945 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5263,7 +5263,12 @@ static void *___kmalloc_large_node(size_t size, gfp_t flags, int node)
>  {
>  	struct page *page;
>  	void *ptr = NULL;
> -	unsigned int order = get_order(size);
> +	unsigned int order;
> +
> +	if (size > KMALLOC_MAX_SIZE)
> +		return NULL;
> +
> +	order = get_order(size);
>  
>  	if (unlikely(flags & GFP_SLAB_BUG_MASK))
>  		flags = kmalloc_fix_flags(flags);
> 
> ---
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> change-id: 20260817-limit_kmalloc_size-3a4a2c73beac
> 
> Best regards,
> --  
> Yan, Zi
> 

