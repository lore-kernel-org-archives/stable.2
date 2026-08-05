Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292522931D2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785898297; cv=none; b=JrHJEA3eukeixdSlWxQjBFzl5W+vvavzZKbmxwOFZ6ala9ohifOBoi3gS06ojFJjv//y4qqkdIej7HrTmFd4PwiVTfNj7mk/WPTUyCDEU39BOSQ4oLPY8+/NBQPgd0+l75QFsptXXMY9bWoJ9qJmQ2Y/PUknA2WZL6CIGDupt6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785898297; c=relaxed/simple;
	bh=nzqJxkEr/cqshiSJA208I6RNG2UCSd1Cgd0rlKNLiZY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jwvy7xb1+svjHbNIbPMpjeqxiB22Ayrx01CkWMhOo/BvY9URNY9/Ya5JPhMfnjxanb8wX7FjydTVkuNV8yzze6Ax2O/IK24nDtdXSz0GyHzxsxB8dK0tesaueHA/t2nFzAbn84NMWXVeRb6Ub1U1jeMRZM5fSqTYxM1XzkxYzSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g7uaV1pk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g7uaV1pk"
Message-ID: <b2684958-5c39-4a9f-ab83-2e665406c0c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785898282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw6b4Ud9QmLN26rSrpMEOzWnoOiUv/ZPRwVZ5pminvo=;
	b=g7uaV1pkzDfMhgrhziX3dxUuLUXbulybuyscS1M2Ap4htsEufpY/v7TbT7oYrep113eUS8
	DWBlHCqiZxBDe7TBxzyPYF8qz1U/u/LuNBkxxihC61zSwN9khhyn6QcM1GIKBlBpMDOf5c
	BPT1VqXjzwybh2e8WMqHWNa+QTLa2sg=
Date: Wed, 5 Aug 2026 10:51:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>,
 stable@vger.kernel.org
References: <20260804122038.190270-1-hao.ge@linux.dev>
 <CAJuCfpGit7zcNPGAB9D2A5+718NY-qdksxt7gUaN_eRcB_5+Ug@mail.gmail.com>
 <bd95f8c6-33e2-4fda-bd4b-ebc37ee7c0fb@linux.dev>
Content-Language: en-US
In-Reply-To: <bd95f8c6-33e2-4fda-bd4b-ebc37ee7c0fb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2026/8/5 10:26, Hao Ge wrote:
> Hi Suren
>
>
> Thanks a lot for your review.
>
>
> On 2026/8/5 04:08, Suren Baghdasaryan wrote:
>> On Tue, Aug 4, 2026 at 5:21 AM Hao Ge <hao.ge@linux.dev> wrote:
>>> In reserve_module_tags(), the tag overflow check is gated on
>>> mem_alloc_profiling_enabled():
>>>
>>>      if (mem_alloc_profiling_enabled() && !tags_addressable())
>>>
>>> If profiling is toggled off at runtime and a module is loaded whose
>>> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
>>> skipped. vm_module_tags_populate() still maps memory for the tags and
>>> the module loads successfully, but the total tag count now exceeds what
>>> NR_UNUSED_PAGEFLAG_BITS can address.
>>>
>>> Once profiling is re-enabled, ref_to_idx() computes each tag's index
>>> as its position in the alloc_tag array. update_page_tag_ref() masks
>>> it to alloc_tag_ref_mask before storing in page->flags. Indices
>>> beyond the mask are truncated and idx_to_ref() resolves them to wrong
>>> tags.
>>>
>>> mem_alloc_profiling_enabled() and mem_profiling_compressed are
>>> independent. Once compressed mode is established at boot, it stays
>>> active regardless of runtime toggles of mem_profiling.
>>>
>>> Remove the mem_alloc_profiling_enabled() guard. Also return an error
>>> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
>>> the mapped pages would never be reused - shutdown_mem_profiling() sets
>>> mem_profiling_support to false, so no future module load enters the
>>> codetag path.
>>>
>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag 
>>> compression")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> Thanks for the fix, Hao!
>>
>>> ---
>>> Changes in v2:
>>> - Return error after shutdown_mem_profiling() to skip unnecessary
>>>    vm_module_tags_populate()
>>>    v1 link: 
>>> https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@linux.dev/
>>> ---
>>>   mm/alloc_tag.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>>> index 52aece27b00e..d8c36430f1c0 100644
>>> --- a/mm/alloc_tag.c
>>> +++ b/mm/alloc_tag.c
>>> @@ -904,10 +904,11 @@ static void *reserve_module_tags(struct module 
>>> *mod, unsigned long size,
>>>                  int grow_res;
>>>
>>>                  module_tags.size = offset + size;
>>> -               if (mem_alloc_profiling_enabled() && 
>>> !tags_addressable()) {
>> Makes sense but how about replacing mem_alloc_profiling_enabled() with
>> mem_profiling_support? Otherwise this warning will be issued multiple
>> times if we are loading multiple modules.
>
>
> That's a really good point, this duplicate warning issue will indeed 
> happen.
>
> When I thought over your point, I realized using mem_profiling_support 
> creates a small race window.
>
>
> Thread A（insmod A）                      Thread B (insmod B)
>
> --------- ---------
>
> needs_section_mem() -> true
>
>     needs_section_mem() -> true
>
>     (profiling still supported)
>
> reserve_module_tags()
>
>     overflow -> shutdown
>
>     mem_profiling_support=false
>
>     return -ENOSPC
>
>     reserve_module_tags()
>
>         mem_profiling_support==false
>
>         -> overflow check skipped
>
>         -> vm_module_tags_populate()
>
>             maps unused tag pages


Sorry, my mail client messed up the race diagram, resend it.

Thread A (insmod A)                   Thread B (insmod B)
---------------------                 ---------------------
needs_section_mem() -> true
                                       needs_section_mem() -> true
                                       (profiling still supported)
reserve_module_tags()
   overflow -> shutdown_mem_profiling()
   mem_profiling_support = false
   return -ENOMEM
                                       reserve_module_tags()
                                         mem_profiling_support == false
                                         -> overflow check skipped
                                         -> vm_module_tags_populate()
                                            maps unused tag pages

>
> So I'd rather go with pr_warn_once here.
>
>
>>> +               if (!tags_addressable()) {
>>>                          shutdown_mem_profiling(true);
>>>                          pr_warn("With module %s there are too many 
>>> tags to fit in %d page flag bits. Memory allocation profiling is 
>>> disabled!\n",
>>>                                  mod->name, NR_UNUSED_PAGEFLAG_BITS);
>>> +                       return ERR_PTR(-ENOSPC);
>> This ENOSPC error will be propagated all the way up to the init_module
>> syscall and it's not among the error codes currently expected (see:
>> https://man7.org/linux/man-pages/man2/init_module.2.html). I suggest
>> returning ENOMEM instead.
>
>
> Agree, will change
>
>
> Thanks
>
> Best Regards
>
> Hao
>
>>>                  }
>>>
>>>                  grow_res = vm_module_tags_populate();
>>> -- 
>>> 2.25.1
>>>
