Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414657;
	b=EqncN4Z1CMzCaUPsFWgn7kJRjSjqVr7pG1sua0I41W92yUIdOVYi+PaSSAzeOXoWyQue
	 Xp+YLw/CeSlH66VbVQFGqh9J9Mw3PGgPXcArhr+CGgk95V05k79cYSZ8OU14gMticf4Hw
	 LZty1lQBPpH5N+XulTsjOj3UWOwapgIvlfrUcMFcFVJKSOMTMyiPHyeCztRZQsEEeawWf
	 HSxu6yKlfe0kXLuqlI+AO32gl7ALjstXw2UFKFleQF5scLQPx0kBSB8oa6ooSBT79oWeT
	 PABag2CSwHa9JYBs+F0NO351/8WewWzgMCwYvDG1aoGR/h3Bt2zFWvw+RNKwiTlkI9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414657;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GOBYmPtzam1T+nLf6ejQStpL9HX+CL/GMBMiRQwuJ6c=;
	b=Uew/VJLpsC1GEA/HvavpUtRXSKPPT5sdeDZ1xQCdcHK4ExrAl7qaLAwkKaXUb1Wtx+ZN
	 DYZIJN5DuYYd851NkCjwIC30LW3zse2EUKpbXjgEVfhmAx+QRjlJ9MeShMUaHQJo6DmvV
	 OxfX0NVx2e9UTXhnq86FEaPaE4rLvJzmDrtk2XKQWoefSJYP5akJDk0m+rgtmYXgM4665
	 Pga/bxUhFl6440gjndf7XB1qHDo6YymCFXo2rHQAey3vsPX2LSm+JhlL+dXLVikXE4lo+
	 Vs5Fvp8XknpGxyAvoVRqunAVJ1AxxE6NtWLktJ7ca431rzlK4cpMnTrHN5a7bU1YRWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hUDhkCJR;
	arc=none smtp.remote-ip=95.215.58.247
Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACA606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02ACA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hUDhkCJR
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rT8PoeGFDS38g2QMBHWcyADCpxGK0iuLhNyiv06a55Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795414655; v=1; x=1796019455;
 b=hUDhkCJRJuq6GeK9Zq6uh6m/zJKtkdGuFCnx04R25XKiQCL5rCaV9TdCjE9O4YyqH5jQPyG6
 BVTlf03uMu+fI49r44TjKeRqNnnE0rqJeaTU04+25Y6ExypoKD7AF0avjsGnjNnLyF4dyrnDSSV
 kcL2eULvkj4+ZwXExaD5w7uA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7ae97a7f2b73cb9e;
	Mon, 23 Nov 2026 06:17:34 +0000
X-Mizu-Trace-ID: 7ae97a7f2b73cb9e
X-Migadu-Flow: FLOW_OUT
Message-ID: <cb8d8dc5-4ccc-408f-acaf-2f1faa0a1983@linux.dev>
Date: Mon, 23 Nov 2026 14:17:17 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] mm/vmalloc: skip cond_resched() in the vmap
 unmap paths when atomic
To: Suren Baghdasaryan <surenb@google.com>, Dev Jain <dev.jain@arm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-2-hao.ge@linux.dev>
 <1020e36e-83bb-407b-8a6b-7669f04c26c3@arm.com>
 <CAJuCfpHtWJvs4F2L+QCMe9gMJ-qmcj4Q1G4hqVqFe6Z6gPoQ1Q@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHtWJvs4F2L+QCMe9gMJ-qmcj4Q1G4hqVqFe6Z6gPoQ1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren and Dev

Thanks for the review.

On 2026/11/21 05:07, Suren Baghdasaryan wrote:
> On Thu, Nov 19, 2026 at 5:02 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>>
>>
>> On 16/11/26 12:43 pm, Hao Ge wrote:
>>> The vmap failure paths can be reached with GFP_ATOMIC or GFP_NOWAIT
>>> since commit b186a94227b7 ("kmsan: remove hard-coded GFP_KERNEL
>>> flags") and commit 8da89ba18ed4 ("mm/vmalloc: handle non-blocking
>>> GFP in __vmalloc_area_node()"), so an undo of a partially installed
>>
>> You mention this commit too, implying that vunmap_range_noflush() can
>> be called in atomic context right now, but in this patch in
>> vunmap_range_noflush() you pass 'true' unconditionally to
>> __vunmap_range_noflush()?
>>
>> Can you give me the call chain existing in current kernel which makes
>> this bug trigger? In case it does not exist but is only triggered when
>> you add the rollback code later, then this patch is not fixing a bug.
> 
> Yeah, IIUC this is a prep patch for later changes and does not fix any
> existing issues, therefore should not have any Fixes tags and should
> not be CC'ed to stable.
> 
> Other than that LGTM.

Right, this is a prep patch for later changes. I will drop the
Fixes tag, this patch fixes nothing by itself. 

I would keep the stable Cc though. The next patch, "mm/kmsan: undo
the shadow mapping when the origin mapping fails", is the real fix
and it depends on this one. Per stable-kernel-rules.rst, patch1 in
a series should be marked for stable inclusion when patch2 depends
on it, otherwise the fix lands in stable without its prerequisite.

Or did I misread the rules?

Thanks
Best Regards
Hao

> 
>>
>>
>>> mapping may have to run in atomic context, where the cond_resched()
>>> in vunmap_pmd_range() cannot schedule.
>>>
>>> Give __vunmap_range_noflush() and kmsan_vunmap_range_noflush() a
>>> can_resched argument and skip the cond_resched() when it is false.
>>> The existing callers are on sleepable paths and pass true, so nothing
>>> changes for them.
>>>
>>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>>  include/linux/kmsan.h |  8 ++++++--
>>>  mm/kmsan/hooks.c      | 14 +++++++++-----
>>>  mm/vmalloc.c          | 24 ++++++++++++++----------
>>>  mm/vmalloc.h          |  3 ++-
>>>  4 files changed, 31 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
>>> index 7da9fd506b39..0016c032d1e7 100644
>>> --- a/include/linux/kmsan.h
>>> +++ b/include/linux/kmsan.h
>>> @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
>>>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
>>>   * @start: start of vunmapped range.
>>>   * @end:   end of vunmapped range.
>>> + * @can_resched: whether the unmap walk may call cond_resched(); pass
>>> + * false from atomic context.
>>>   *
>>>   * KMSAN unmaps the contiguous metadata ranges created by
>>>   * kmsan_map_kernel_range_noflush().
>>>   */
>>> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
>>> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
>>> +                             bool can_resched);
>>>
>>>  /**
>>>   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
>>> @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_range_noflush(
>>>  }
>>>
>>>  static inline void kmsan_vunmap_range_noflush(unsigned long start,
>>> -                                           unsigned long end)
>>> +                                           unsigned long end,
>>> +                                           bool can_resched)
>>>  {
>>>  }
>>>
>>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
>>> index a706666db097..69008b085658 100644
>>> --- a/mm/kmsan/hooks.c
>>> +++ b/mm/kmsan/hooks.c
>>> @@ -136,10 +136,13 @@ static unsigned long vmalloc_origin(unsigned long addr)
>>>                                                KMSAN_META_ORIGIN);
>>>  }
>>>
>>> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>>> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
>>> +                             bool can_resched)
>>>  {
>>> -     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>>> -     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>>> +     __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end),
>>> +                            can_resched);
>>> +     __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end),
>>> +                            can_resched);
>>>       flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
>>>       flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
>>>  }
>>> @@ -168,8 +171,9 @@ static void kmsan_iounmap_pages(unsigned long start, unsigned long end)
>>>               if (origin)
>>>                       __free_pages(origin, KMSAN_IOREMAP_META_ORDER);
>>>       }
>>> -     __vunmap_range_noflush(shadow_start, shadow_end);
>>> -     __vunmap_range_noflush(origin_start, origin_end);
>>> +     /* ioremap metadata mappings are always GFP_KERNEL, so resched is safe. */
>>> +     __vunmap_range_noflush(shadow_start, shadow_end, true);
>>> +     __vunmap_range_noflush(origin_start, origin_end, true);
>>>       flush_tlb_kernel_range(shadow_start, shadow_end);
>>>       flush_tlb_kernel_range(origin_start, origin_end);
>>>  }
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index ccaf158c5b7f..3c0d9e69b886 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -429,7 +429,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>>  }
>>>
>>>  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>>> -                          pgtbl_mod_mask *mask)
>>> +                          pgtbl_mod_mask *mask, bool can_resched)
>>>  {
>>>       pmd_t *pmd;
>>>       unsigned long next;
>>> @@ -451,12 +451,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>>>                       continue;
>>>               vunmap_pte_range(pmd, addr, next, mask);
>>>
>>> -             cond_resched();
>>> +             /* The undo path may run in atomic context. */
>>> +             if (can_resched)
>>> +                     cond_resched();
>>>       } while (pmd++, addr = next, addr != end);
>>>  }
>>>
>>>  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>>> -                          pgtbl_mod_mask *mask)
>>> +                          pgtbl_mod_mask *mask, bool can_resched)
>>>  {
>>>       pud_t *pud;
>>>       unsigned long next;
>>> @@ -476,12 +478,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>>>               }
>>>               if (pud_none_or_clear_bad(pud))
>>>                       continue;
>>> -             vunmap_pmd_range(pud, addr, next, mask);
>>> +             vunmap_pmd_range(pud, addr, next, mask, can_resched);
>>>       } while (pud++, addr = next, addr != end);
>>>  }
>>>
>>>  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>>> -                          pgtbl_mod_mask *mask)
>>> +                          pgtbl_mod_mask *mask, bool can_resched)
>>>  {
>>>       p4d_t *p4d;
>>>       unsigned long next;
>>> @@ -496,7 +498,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>>>
>>>               if (p4d_none_or_clear_bad(p4d))
>>>                       continue;
>>> -             vunmap_pud_range(p4d, addr, next, mask);
>>> +             vunmap_pud_range(p4d, addr, next, mask, can_resched);
>>>       } while (p4d++, addr = next, addr != end);
>>>  }
>>>
>>> @@ -512,7 +514,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>>>   *
>>>   * This is an internal function only. Do not use outside mm/.
>>>   */
>>> -void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
>>> +                         bool can_resched)
>>>  {
>>>       unsigned long next;
>>>       pgd_t *pgd;
>>> @@ -527,7 +530,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>>                       mask |= PGTBL_PGD_MODIFIED;
>>>               if (pgd_none_or_clear_bad(pgd))
>>>                       continue;
>>> -             vunmap_p4d_range(pgd, addr, next, &mask);
>>> +             vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
>>>       } while (pgd++, addr = next, addr != end);
>>>
>>>       if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>>> @@ -536,8 +539,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>>
>>>  void vunmap_range_noflush(unsigned long start, unsigned long end)
>>>  {
>>> -     kmsan_vunmap_range_noflush(start, end);
>>> -     __vunmap_range_noflush(start, end);
>>> +     /* The unmap paths are sleepable, keep the resched point. */
>>> +     kmsan_vunmap_range_noflush(start, end, true);
>>> +     __vunmap_range_noflush(start, end, true);
>>>  }
>>>
>>>  /**
>>> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
>>> index d8372a4f65c4..4ec114a75f04 100644
>>> --- a/mm/vmalloc.h
>>> +++ b/mm/vmalloc.h
>>> @@ -44,6 +44,7 @@ int __must_check __vmap_pages_range_noflush(unsigned long addr,
>>>
>>>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>>>
>>> -void __vunmap_range_noflush(unsigned long start, unsigned long end);
>>> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
>>> +                         bool can_resched);
>>>
>>>  #endif /* __MM_VMALLOC_H */
>>
