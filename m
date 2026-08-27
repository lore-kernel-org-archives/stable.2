Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24338737B;
	Thu, 27 Aug 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816838; cv=none; b=RZVjKJh92uD1msLGin+utF0yEZK0mncKsNejUlnlbjJC1kSz+ncUuhyKnPZ+yss/NzgfFveeO2FsJl4VCw/kHg98+fYKYGx5JKt9upcW0pbU6bJOAJd/XVD4+sgf8zxJHVk04/bhpG/zZ2D+IiXjmmdIQIzFmZ5UxfLAMEwcN4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816838; c=relaxed/simple;
	bh=D9iRynStFiinHNFk3YUubpgCjzHKcAiB1h/04CNvTa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3zaHU+Ncb6Km0NDV/4uv+OcUVSS/sjnrQq0EAq4Ws44Y6tO4XTRUKh1bidpx9jnyaJ1ZUnKHpWmwQaakk7wSnAeO1CC3VsUH6HrKejLzXHXKNx+MQ3/SUbYUiNmomTmQYy/ZAUynkpXhlWAv0BkmQhf9q4rOWfH/IWLxILO8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXJQAfnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXJQAfnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4451F00A3A;
	Thu, 27 Aug 2026 07:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787816834;
	bh=HAx27bjYWIezR+l7iw/n59Tjpp+JZqYjQalST4GROaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jXJQAfnVvTVWEWNE4VPcqMrW72bz1eQ9s0q/9pxGB/zaGdI3wBRdVVIhDL5nvhCmY
	 lC3j0jOHD+sfzJqcAIE01FVPTZ5zMFBDKqvdCxB4RdEUGSVHfsxj9pAUyDem3DiiDc
	 Cs/0u+1y1bxBZ0NGH32qI+TEeFnu2EmwnR4ii55QrS9wtra/TlmA1P96dBkZ2ounLw
	 KWrarGBk+zvC9/3bFuYSbxLGuHNb/v8r0LAC3s1+v8nHQmhrn8SW4gcaOnq9pU2cJ/
	 y0Lk4h7yDpuPuQXAVg9pKeTOuPqRAwSr8o0SOA8bMx6ZPREh+zz8paYvSEhJSAIbRr
	 KJlwyQO2cFMPQ==
Message-ID: <c4684212-f44a-4aff-a02d-f3f26095ebc1@kernel.org>
Date: Thu, 27 Aug 2026 09:47:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
To: Zi Yan <ziy@nvidia.com>, Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 syzbot+805630f1453e490427fa@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
 <ao9dPUpHxP5uOOcw@MacBook-Air.tail10959e.ts.net>
 <DKZ7J9HNUDR6.BP9KG5Q7HYMJ@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <DKZ7J9HNUDR6.BP9KG5Q7HYMJ@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/26 11:52 PM, Zi Yan wrote:
> On Wed Aug 26, 2026 at 5:47 PM EDT, Harry Yoo wrote:
>> On Wed, Aug 26, 2026 at 11:28:12AM +0000, Vlastimil Babka (SUSE) wrote:
>>> On 8/17/26 22:40, Zi Yan wrote:
>>>> kmalloc is used to allocate physically contiguous memory for kernel
>>>> allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc uses
>>>> the page allocator and can only support up to KMALLOC_MAX_SIZE. For request
>>>> sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WARN
>>>> because kmalloc allocates an order greater than MAX_PAGE_ORDER. Systems
>>>> with panic_on_warn=1 crash because of this WARN. Fix it by rejecting any
>>>> kmalloc size bigger than KMALLOC_MAX_SIZE.
>>>>
>>>> Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or higher kmalloc requests")
>>>> Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>>>> Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE@google.com/
>>>> Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Cc: stable@vger.kernel.org
>>>> ---
>>>> It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadgetfs
>>>> requests excessively large memory from kmalloc. Instead of adding
>>>> __GFP_NOWARN to suppress the warning, as was done for usbfs[1], change
>>>> kmalloc to return NULL without a warning for this specific issue.
>>>>
>>>> [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively large memory allocations")
>>>
>>> So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()
>>>
>>>         /* Don't even allow crazy sizes */
>>>         if (unlikely(size > INT_MAX)) {
>>>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>>                 return NULL;
>>>         }
>>>
>>> This comes from Linus in commit 7661809d493b4. I'd do the same thing here
>>> then.
>>
>> But the purpose of this patch is to avoid the warning in the page
>> allocator. Should we fix this in the caller (gadgetfs) then? 
> 
> It is fixed by: https://lore.kernel.org/all/20260820223719.A4A3C1F000E9@smtp.kernel.org/
> 
> Please disregard this patch, but we can keep the discussion going.

I still think this patch has some value if done as proposed above. Yes
in practice it will just replace the page allocator's warning with a
different warning, but IMHO it's "nicer" if kmalloc() sanitizes its own
requests to the page allocator, using the KMALLOC_MAX_SIZE value.

>>
>>> Thus there would be a useful warning for e.g. development mistakes
>>> resulting in the size to be unexpectedly high.
>>>
>>> Callers passing size that comes from userspace or similar untrusted source
>>> can either pass __GFP_NOWARN or sanitize the size to what they expect to be
>>> sane (which is context dependent and I assume actually way lower than
>>> kmalloc limits in practice). Note that passing even sizes within but close
>>> to/at the limit, trusting blindly some external source, can succeed the
>>> allocations but effectively DoS the system with heavy reclaim/compaction. So
>>> caller sanitization should still be preferred IMHO. Some of the recent
>>> arguments from Linus [1] would apply to this too, I think.
>>>
>>> [1]
>>> https://lore.kernel.org/all/CAHk-=wiSmgwwLKCqJwGS-dVHnSLU8W+7q1UQq-G9=TBGGZbuhQ@mail.gmail.com/
> 
> 
> 
> 

