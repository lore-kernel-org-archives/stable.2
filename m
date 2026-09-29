Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53755380FDD
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670472; cv=none; b=thcXBudDPJ4gAIxipUKXxUK1J2Iy9TF+Vz+gOzSF7vmMvwpjEX23clOvt31pzL1tuKpwOkmdlESLdd5sODWowoDiNARb00zfmp+eDT7uwqe5TExWvUIpCLFCJFSweGvkJkD7lbZEVpaeoRpJuVEor4sP/NgwmMXINFBXyoGLg3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670472; c=relaxed/simple;
	bh=hc4h/kvHWGvaNo1pJZ/tYxpgeXysmHfvzY1S7Hs/p0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYxAp0eQGMNs3eVWOa0NfIVjORBLhcPGBylZkhyiL/g/Rj2UYOynfh8qiq23YQ5E2iwm1ZAcKkU16PxH8LKhHN1elBpAWzkOHmZIbmb/gwfAIH5a573jVOKUCu3B4Ui/MfK+5r1Cbhgr/Ess0kZMRdS20CdplWLOzWMf5v2wssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eHqG7ZjU; arc=none smtp.client-ip=91.218.175.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eHqG7ZjU"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hc4h/kvHWGvaNo1pJZ/tYxpgeXysmHfvzY1S7Hs/p0I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790670468; v=1; x=1791275268;
 b=eHqG7ZjUFKbbCPFO+k/fPKhIWrJ6nqdscW0NL6AIy2EL9CIXp8tMAXk8hOrS8bAAbxBbUP9I
 EB0D8Zlz+pYRc/SLJJkfqD1dP8a8oKB9i+N6yRC2fmoinGolU4HhVh9z9gLYKViA4wi01iPh5WP
 egs/8g9+WD95Mu6zQiOnPSMY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f1ea05f0f1f24b17;
	Tue, 29 Sep 2026 08:27:47 +0000
X-Mizu-Trace-ID: f1ea05f0f1f24b17
X-Migadu-Flow: FLOW_OUT
Message-ID: <978154c0-d919-4e78-9ece-30f1739d6c51@linux.dev>
Date: Tue, 29 Sep 2026 16:28:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/6] alloc_tag: clean up the populate failure path
To: Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260915070001.113559-3-hao.ge@linux.dev>
 <CAJuCfpHJSwNhgotMVpmjVvdv=m52_7Kvzpztf0WcN0AaoSeGGw@mail.gmail.com>
 <60642a7f-2949-428a-8290-40d69c989a77@linux.dev>
 <CAJuCfpG3d7n=z5WnUQYZsqvrt1pemF8TFvGiGyZGLO7ykVvqAQ@mail.gmail.com>
 <CAJuCfpGeRdFY6UPF-vXxwHvP2+tN=BKgRkmLR3PMLuWhxgzPRA@mail.gmail.com>
 <1dff448c-9cbe-4276-bca1-d91283b0c7b4@linux.dev>
 <b8005c24-ecac-45c4-840a-fd282f9693b5@linux.dev> <arpK2bQrrUMvEvTP@milan>
 <arqDHnBFGKQZm7VU@milan>
 <CAJuCfpHuTzFBUm2uAbkFsKF85GxcqFATmKgT50AQgWkLjf7NMw@mail.gmail.com>
 <arqoPs4ZplfcGmLo@milan>
 <CAJuCfpFT=QKy_5G6GYQ1OHhvjXt807jn0pUq-eF9QonNKhx=aQ@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFT=QKy_5G6GYQ1OHhvjXt807jn0pUq-eF9QonNKhx=aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren and Uladzislau

On 2026/9/29 01:54, Suren Baghdasaryan wrote:
> On Mon, Sep 28, 2026 at 10:47 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>>
>> On Mon, Sep 28, 2026 at 08:16:18AM -0700, Suren Baghdasaryan wrote:
>>> On Mon, Sep 28, 2026 at 8:09 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>>>>
>>>> On Mon, Sep 28, 2026 at 01:09:13PM +0200, Uladzislau Rezki wrote:
>>>>> On Thu, Sep 17, 2026 at 10:32:48AM +0800, Hao Ge wrote:
>>>>>> Hi Suren、David、Lorenzo
>>>>>>
>>>>>> On 2026/9/17 09:12, Hao Ge wrote:
>>>>>>> Hi Suren
>>>>>>>
>>>>>>> On 2026/9/17 03:07, Suren Baghdasaryan wrote:
>>>>>>>> On Wed, Sep 16, 2026 at 9:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, Sep 15, 2026 at 11:00 PM Hao Ge <hao.ge@linux.dev> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi Suren
>>>>>>>>>>
>>>>>>>>>> Thanks for you review.
>>>>>>>>>>
>>>>>>>>>> On 2026/9/16 05:09, Suren Baghdasaryan wrote:
>>>>>>>>>>> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> The reservation is already stored in the maple tree when
>>>>>>>>>>>> vm_module_tags_populate() fails. A failed load never unloads the
>>>>>>>>>>>> module, so nothing releases the entry. Release it and roll
>>>>>>>>>>>> module_tags.size back. Without the rollback a concurrent load that
>>>>>>>>>>>> already passed needs_section_mem() can reuse the freed gap, skip
>>>>>>>>>>>> vm_module_tags_populate() and write to unmapped memory.
>>>>>>>>>>>>
>>>>>>>>>>>> vmap_pages_range() may have installed some PTEs before failing. A
>>>>>>>>>>>> retry to populate the same range would BUG on them, so undo them,
>>>>>>>>>>>> but only if vmap actually ran.
>>>>>>>>>>>>
>>>>>>>>>>>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>>>>>>>>>>>> Fixes: 0f9b685626da ("alloc_tag: populate memory for module tags as needed")
>>>>>>>>>>>
>>>>>>>>>>> If a patch fixes two other patches, it likely needs to be split so
>>>>>>>>>>> that each part fixes one patch only. But read on please. I'm not sure
>>>>>>>>>>> if one of the fixes is correct.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Kept them in one patch because they only make sense together.
>>>>>>>>>>
>>>>>>>>>> After a failed populate the reservation is released and the
>>>>>>>>>> size rolled back, so the next load takes the same gap and calls
>>>>>>>>>> vm_module_tags_populate() again, and that retry would trip over
>>>>>>>>>> the PTEs the failed vmap left behind.
>>>>>>>>>>
>>>>>>>>>> Without the rollback a load that already passed needs_section_mem()
>>>>>>>>>> just reuses the gap, skips populate and writes to unmapped memory.
>>>>>>>>>> So splitting them leaves each half broken.
>>>>>>>>>
>>>>>>>>> Yeah, that's why I think vmap_pages_range() cleanup should be a
>>>>>>>>> completely separate patch with vmap_pages_range() doing cleanup
>>>>>>>>> itself.
>>>>>>>>>
>>>>>>>
>>>>>>> I think I get where you're coming from now.
>>>>>>> Thanks for taking the time to explain.
>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  mm/alloc_tag.c | 10 ++++++++++
>>>>>>>>>>>>  1 file changed, 10 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>>>>>>>>>>>> index 2070e682fe10..95ddf5b743d0 100644
>>>>>>>>>>>> --- a/mm/alloc_tag.c
>>>>>>>>>>>> +++ b/mm/alloc_tag.c
>>>>>>>>>>>> @@ -804,6 +804,13 @@ static int vm_module_tags_populate(void)
>>>>>>>>>>>>                                      next_page, PAGE_SHIFT) < 0) {
>>>>>>>>>>>>                         release_pages_arg arg = { .pages = next_page };
>>>>>>>>>>>>
>>>>>>>>>>>> +                       /*
>>>>>>>>>>>> +                        * vmap_pages_range() only runs once all pages were
>>>>>>>>>>>> +                        * allocated, and it may have installed some mappings
>>>>>>>>>>>> +                        * before failing. Undo them.
>>>>>>>>>>>
>>>>>>>>>>> If vmap_pages_range() failed to map the range, why should we need to
>>>>>>>>>>> undo it? If it indeed leaves some partial mapping when failing then I
>>>>>>>>>>> would argue that vmap_pages_range() should be undoing these partial
>>>>>>>>>>> mappings itself before returning the error.
>>>>>>>>>>>
>>>>>>>>>> Yeah it does - none of the paths under vmap_pages_range() undo themselves on error.
>>>>>>>>>
>>>>>>>>> Hmm. I wonder if this behavior is intentional or requires a fix. The
>>>>>>>>> only possible reason I can think of is performance but I can't imagine
>>>>>>>>> a failure to map is a performance-critical case.
>>>>>>>>>
>>>>>>>>> +David Hildenbrand (Red Hat), +Lorenzo Stoakes (Oracle) what do you
>>>>>>>>
>>>>>>>> Huh, my gmail thinks you are still at your previous companies :)
>>>>>>>>
>>>>>>>
>>>>>>> I manually fixed it on the mailing list for this thread.
>>>>>>>
>>>>>>>>> guys think? Shouldn't vmap_pages_range() undo its possible partial
>>>>>>>>> mapping when it fails?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> pcpu_map_pages does perform cleanup on its own as well. There may be other similar sites.
>>>>>>>>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/percpu-vm.c#L255
>>>>>>>>>> so I did the same here.
>>>>>>>>>>
>>>>>>>>>> If we really want vmap_pages_range() to handle this cleanup internally, I believe that would
>>>>>>>>>> be a relatively large change, and we would need to consider many more cases. So I think we keep
>>>>>>>>>> the current behaviour for now.
>>>>>>>>>
>>>>>>>>> Yeah, I understand it would require a deeper cut but if that's the
>>>>>>>>> right way to handle this we might as well do that. Let's see what MM
>>>>>>>>> folks think.
>>>>>>>>>
>>>>>>>
>>>>>>> Sounds good to me. Let's wait and hear what the MM folks say.
>>>>>>>
>>>>>>
>>>>>> I just looked into the call sites for __vmap_pages_range.
>>>>>> And I found there's a bug in one vmalloc caller [1].
>>>>>> When gfp_mask has __GFP_NOFAIL, the code keeps retrying
>>>>>> __vmap_pages_range. If there are leftover PTE mappings,
>>>>>> this can trigger a BUG(); [2]
>>>>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L3946 [1]
>>>>>> https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/vmalloc.c#L121  [2]
>>>>>>
>>>>> Indeed the below code is incomplete:
>>>>>
>>>>> <snip>
>>>>>       /*
>>>>>        * page tables allocations ignore external gfp mask, enforce it
>>>>>        * by the scope API
>>>>>        */
>>>>>       flags = memalloc_apply_gfp_scope(gfp_mask);
>>>>>       do {
>>>>>               ret = __vmap_pages_range(addr, addr + size, prot, area->pages,
>>>>>                               page_shift, nested_gfp);
>>>>>               if (nofail && (ret < 0))
>>>>>                       schedule_timeout_uninterruptible(1);
>>>>>       } while (nofail && (ret < 0));
>>>>>       memalloc_restore_scope(flags);
>>>>> <snip>
>>>>>
>>>>> and it should be fixed. As the __vmap_pages_range() can actually fail
>>>>> and leave some installed mappings, we have to perform some cleanups
>>>>> on failure or on repeat(if nofail is true).
>>>>>
>>>>> Below code:
>>>>>
>>>>> +                     /*
>>>>> +                      * vmap_pages_range() only runs once all pages were
>>>>> +                      * allocated, and it may have installed some mappings
>>>>> +                      * before failing. Undo them.
>>>>> +                      */
>>>>> +                     if (nr == more_pages)
>>>>> +                             vunmap_range(phys_end, phys_end + (nr << PAGE_SHIFT));
>>>>>
>>>>> we can use but we need to check if partially mapped space is not an
>>>>> issue for the vunmap_range(). And it looks like it is not.
>>>>>
>>>>> <snip>
>>>>> @@ -3953,8 +3990,15 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>>>>>         do {
>>>>>                 ret = __vmap_pages_range(addr, addr + size, prot, area->pages,
>>>>>                                 page_shift, nested_gfp);
>>>>> -               if (nofail && (ret < 0))
>>>>> -                       schedule_timeout_uninterruptible(1);
>>>>> +               if (ret < 0) {
>>>>> +                       /*
>>>>> +                        * __vmap_pages_range() may have installed some mappings
>>>>> +                        * before failing. Undo them before returning or retrying.
>>>>> +                        */
>>>>> +                       vunmap_range(addr, addr + size);
>>>>> +                       if (nofail)
>>>>> +                               schedule_timeout_uninterruptible(1);
>>>>> +               }
>>>>>         } while (nofail && (ret < 0));
>>>>>         memalloc_restore_scope(flags);
>>>>> <snip>
>>>>>
>>>> And looking further. If the __vmap_pages_range()/__vmap_pages_range_noflush()
>>>> and friends fail, a proper cleanups should be done inside, IMO.
>>>
>>> Sounds like we are in agreement.
>>>
>>>>
>>>> But i am checking callers and see that some do some not:
>>>>
>>>> <snip hooks.c>
>>>>         __vunmap_range_noflush(
>>>>                 vmalloc_shadow(start),
>>>>                 vmalloc_shadow(start + clean * PAGE_SIZE));
>>>>         __vunmap_range_noflush(
>>>>                 vmalloc_origin(start),
>>>>                 vmalloc_origin(start + clean * PAGE_SIZE));
>>>> <snip hooks.c>
>>>>
>>>> kmsan_ioremap_page_range() it does clean ups;
>>>> kmsan_vmap_pages_range_noflush() looks like does not care in shadow.c;
>>>> __vmalloc_area_node() as noted, it is broken as there is a BUG() on next try if nofail;
>>>> pcpu_map_pages() it does cleanups.
>>>> ...
>>>>
>>>> and so on.
>>>
>>> Yeah, the callers that do the cleanup should stop doing that once the
>>> vmap functions handle it themselves. I expect an overall reduction in
>>> code size.
>>>
>> Agree. If mapping API is called and it fails the caller should expect
>> the state as it was before calling that API function, IMO.
> 
> Thanks for confirmation!
> 
> Hao, do you need help with making the change in vmap functions to
> cleanup upon a failure?
>

Thanks everyone for your help. I think we have reached a consensus.
I spent a day sorting out the logic and generated the patches below:
https://lore.kernel.org/all/20260929082014.160587-3-hao.ge@linux.dev/
Some edge cases might still be missing, please kindly review.

Thanks
Best Regards
Hao

>>
>> --
>> Uladzislau Rezki
