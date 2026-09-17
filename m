Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFC3563D4
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607494; cv=none; b=LyihPA1Di/0lJga9zvjE6iUMy89aNzihchCYvFp5Ii+Eh7LctrV8NROltIm3nw/pDRcfkGNAFiV3NexgU794Mvhm4PHLfX7GcefO3vHXpUzRrPNTCtf1CYvb0F+5xjMrLd4uRu0S4hXMT8smPp94SKmiLLQTptCswoDLXYsqFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607494; c=relaxed/simple;
	bh=P9osztPS/w56p8S5ChVkJvqYNJdgBwmiJ78Pt9GIkFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gx4dzTYfTBA+m6PU6frePOLVXkreyf1xQJQoNKwdLn+Bcw3Dqs1Y5Jh/0LDLfWP7wjsf9SkozXCHghKckiO8ygS38JPPeH7B2ROQrRr+VyaTncA+YUMb5M1dmN06cD/txtuDKtx/dAx6YRYWUoU7OyVp13W2IPn/W4na/o87HnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tcgYrEyQ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tcgYrEyQ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P9osztPS/w56p8S5ChVkJvqYNJdgBwmiJ78Pt9GIkFw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789607489; v=1; x=1790212289;
 b=tcgYrEyQBicp8cfhe0A5aEsa8zlDiEOciMOZOaO6W2EGB+zhzvo5s8MPuP7lfta/DHBStWhV
 r4PT6ENfRG3WMesbwoF8kWhLgQiSKjihMAxqdezHGd4BHBveTMHVDO0LoZTjjMO3l4S2Xo62blB
 qTHzHm5pApIff0exspDOYh3w=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d5848c4447c400b0;
	Thu, 17 Sep 2026 01:11:29 +0000
X-Mizu-Trace-ID: d5848c4447c400b0
X-Migadu-Flow: FLOW_OUT
Message-ID: <1dff448c-9cbe-4276-bca1-d91283b0c7b4@linux.dev>
Date: Thu, 17 Sep 2026 09:12:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Suren Baghdasaryan <surenb@google.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
 <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
 <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

On 2026/9/17 03:07, Suren Baghdasaryan wrote:
> On Wed, Sep 16, 2026 at 9:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Tue, Sep 15, 2026 at 11:00 PM Hao Ge <hao.ge@linux.dev> wrote:
>>>
>>> Hi Suren
>>>
>>> Thanks for you review.
>>>
>>> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
>>>> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
>>>>>
>>>>> The reservation is already stored in the maple tree when
>>>>> vm_module_tags_populate() fails. A failed load never unloads the
>>>>> module, so nothing releases the entry. Release it and roll
>>>>> module_tags.size back. Without the rollback a concurrent load that
>>>>> already passed needs_section_mem() can reuse the freed gap, skip
>>>>> vm_module_tags_populate() and write to unmapped memory.
>>>>>
>>>>> vmap_pages_range() may have installed some PTEs before failing. A
>>>>> retry to populate the same range would BUG on them, so undo them,
>>>>> but only if vmap actually ran.
>>>>>
>>>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>>>>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
>>>>
>>>> If a patch fixes two other patches, it likely needs to be split so
>>>> that each part fixes one patch only. But read on please. I'm not sure
>>>> if one of the fixes is correct.
>>>>
>>>
>>> Kept them in one patch because they only make sense together.
>>>
>>> After a failed populate the reservation is released and the
>>> size rolled back, so the next load takes the same gap and calls
>>> vm_module_tags_populate() again, and that retry would trip over
>>> the PTEs the failed vmap left behind.
>>>
>>> Without the rollback a load that already passed needs_section_mem()
>>> just reuses the gap, skips populate and writes to unmapped memory.
>>> So splitting them leaves each half broken.
>>
>> Yeah, that's why I think vmap_pages_range() cleanup should be a
>> completely separate patch with vmap_pages_range() doing cleanup
>> itself.
>>

I think I get where you're coming from now.
Thanks for taking the time to explain.

>>>
>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>>> ---
>>>>>  mm/alloc_tag.c | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>>>>> index 2070e682fe10..95ddf5b743d0 100644
>>>>> --- a/mm/alloc_tag.c
>>>>> +++ b/mm/alloc_tag.c
>>>>> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
>>>>>                                      next_page, PAGE_SHIFT) < 0) {
>>>>>                         release_pages_arg arg = { .pages = next_page };
>>>>>
>>>>> +                       /*
>>>>> +                        * vmap_pages_range() only runs once all pages were
>>>>> +                        * allocated, and it may have installed some mappings
>>>>> +                        * before failing. Undo them.
>>>>
>>>> If vmap_pages_range() failed to map the range, why should we need to
>>>> undo it? If it indeed leaves some partial mapping when failing then I
>>>> would argue that vmap_pages_range() should be undoing these partial
>>>> mappings itself before returning the error.
>>>>
>>> Yeah it does - none of the paths under vmap_pages_range() undo themselves on error.
>>
>> Hmm. I wonder if this behavior is intentional or requires a fix. The
>> only possible reason I can think of is performance but I can't imagine
>> a failure to map is a performance-critical case.
>>
>> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you
> 
> Huh, my gmail thinks you are still at your previous companies :)
> 

I manually fixed it on the mailing list for this thread.

>> guys think? Shouldn't vmap_pages_range() undo its possible partial
>> mapping when it fails?
>>
>>
>>> pcpu_map_pages does perform cleanup on its own as well. There may be other similar sites.
>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
>>> so I did the same here.
>>>
>>> If we really want vmap_pages_range() to handle this cleanup internally, I believe that would
>>> be a relatively large change, and we would need to consider many more cases. So I think we keep
>>> the current behaviour for now.
>>
>> Yeah, I understand it would require a deeper cut but if that's the
>> right way to handle this we might as well do that. Let's see what MM
>> folks think.
>>

Sounds good to me. Let's wait and hear what the MM folks say.

Thanks
Best Regards
Hao

>>>
>>> Thanks
>>> Best Regards
>>> Hao
>>>
>>>>> +                        */
>>>>> +                       if (nr == more_pages)
>>>>> +                               vunmap_range(phys_end, phys_end + (nr << PAGE_SHIFT));
>>>>>                         /* Clean up and error out */
>>>>>                         release_pages(arg, nr);
>>>>>                         return -ENOMEM;
>>>>> @@ -947,6 +954,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>>>>                 return ret;
>>>>>
>>>>>         if (module_tags.size < offset + size) {
>>>>> +               unsigned long prev_size = module_tags.size;
>>>>>                 int grow_res;
>>>>>
>>>>>                 module_tags.size = offset + size;
>>>>> @@ -961,6 +969,8 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>>>>>                         shutdown_mem_profiling(true);
>>>>>                         pr_err("Failed to allocate memory for allocation tags in the module %s. Memory allocation profiling is disabled!\n",
>>>>>                                mod->name);
>>>>> +                       release_module_tags(mod, false);
>>>>> +                       module_tags.size = prev_size;
>>>>
>>>> Yes, this one is a valid fix. It fixes 0f9b685626da commit.
>>>>
>>>>>                         return ERR_PTR(grow_res);
>>>>>                 }
>>>>>         }
>>>>> --
>>>>> 2.25.1
>>>>>
