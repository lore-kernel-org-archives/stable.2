Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428945;
	b=AkS75nEMOcdLTKNeOup+nV6FWWPJ9OECFwX4MXDP6WpntEZLcUJQDyMGbfjbw2cyrsOs
	 dV+TGXSn9iYljFzXsqAujxNz0+Pz+y4pdbbalP6NXd5vRE6862MqOFcEhLxA4OGmsLCB4
	 sR8y6xxP8+xGBtWLdNbLhCYiahLcJAl/hRMc9Uy8ZWYzv5bw54x1YxeOIkO6vj6viXpka
	 LO7SP0GVw006G2ZuP9T1WIZpCrnba4tqNNwTtjayAEzqE9NT7/ECtEdZ+YQ3b8xfqDLEb
	 cqsFiee2EhrN3qcqEKkmizNCllZZfAPtLlWpm3VcED1DVtYdcFXiC3EqKsN1dmnt53A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428945;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5VZam8o1y0qDbPb40lL86ri5OnzIJLEYJQ5jktXiFv0=;
	b=nW33asUr4uH4HE29mhqazF0c6zxNDtXHIKZpfnSzrn/gEtmigDpTbQZ3MXWMWIbwHFQ5
	 iPaJaUKw/ZEU3cr9/d+zRpz+6WhldKRKvuBYYf/sICNfqwuYYBtpZ/Wo5MBd6BhzE6YuE
	 syzZ1DTjRLiLHXLqn6A0XuemQgb8FcPbv2nYq80UuKAbsuo4uy1Mtf1CBRy9tLCK/d1rz
	 0TtM0kmYFesSe2WJNWtqgcWIka/2CeUt8ADZeFI0pOgReMgNRXm6zHMaOjcElHi8b4PcX
	 ZMlazVY+p0wGA1Kpd3KXUZcKTfunn72QIKYbmMw+jkDID4GCHNEStBx5blAZMX7OHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tp8Y+6DM;
	arc=none smtp.remote-ip=95.215.58.196
Received: from mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059A606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 10:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8059A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tp8Y+6DM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JunA8M01hnMz3RMuM3CcwD3rgeX5dq0GUnfQcSCgCqU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795428942; v=1; x=1796033742;
 b=Tp8Y+6DMuRHYwvurMY48qyDWbd0vw0TdktcTwlx10+Xqft7yl2FVn9qY0rDgNlLWbF0XNToB
 GBhGZchj5OMfOz2RTBBzVPpi9wsdgt9b4V7ZM4Q6v6ZhHgYUJg4+jYEmGnUrFy87utwC32ikWLn
 ZtgoR+mE8u5I1g4F9/UpnX4M=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8cf77738964f3f07;
	Mon, 23 Nov 2026 10:15:35 +0000
X-Mizu-Trace-ID: 8cf77738964f3f07
X-Migadu-Flow: FLOW_OUT
Message-ID: <81b05a10-1b20-4132-8cc6-c71b88f21414@linux.dev>
Date: Mon, 23 Nov 2026 18:15:29 +0800
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
Subject: Re: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the
 origin mapping fails
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
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
 kasan-dev@googlegroups.com, linux-mm@kvack.org, stable@vger.kernel.org
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-3-hao.ge@linux.dev>
 <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
 <CAJuCfpFv=sCeib+SDWJNW6oqbNnhT+m3YjnfKh8jNkquzuYORg@mail.gmail.com>
 <793d63ff-c48b-431d-8a2a-4044feb45721@linux.dev>
Content-Language: en-US
In-Reply-To: <793d63ff-c48b-431d-8a2a-4044feb45721@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2026/11/23 16:12, Hao Ge wrote:
> Hi Suren
> 
> On 2026/11/21 05:49, Suren Baghdasaryan wrote:
>> On Fri, Nov 20, 2026 at 9:14 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>>
>>> On Mon, Nov 16, 2026 at 7:13 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>>
>>>> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
>>>> the origin pages. If the second mapping fails, the first one is left
>>>> mapped, and the callers do not roll it back. The next vmap of the
>>>> same metadata range hits the stale PTEs again and fails with a
>>>> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>>>>
>>>> Undo the shadow mapping on that error path, the same way
>>>> kmsan_ioremap_page_range() cleans up after a partial failure.
>>>> __vunmap_range_noflush() only clears the PTEs; nothing has touched
>>>> the shadow mapping, so no TLB flush is needed.
>>
>> After a second thought, kmsan_ioremap_page_range() does not skip TLB
>> flushing. __vunmap_range_noflush() comment at
>> https://elixir.bootlin.com/linux/v7.4-rc1/source/mm/vmalloc.c#L497
>> says:
>>
>> The caller is responsible for calling flush_cache_vmap() before
>> calling this function, and flush_tlb_kernel_range after it has
>> returned successfully ...". There are no mentions of guarantees that
>> mapped PTEs require explicit access to be cached. Please double-check
>> if this is safe.
> 
> That's a subtle detail. I've looked up the relevant documentation.
> You are right, and my "no TLB flush is needed" was wrong.
> 
> The Arm "Learn the architecture" AArch64 memory management guide says it
> in "TLBs and Changing translations":
> 
> https://support.arm.com/documentation/101811/0106/TLBs-and-Changing-translations
> 
> If you change a translation table entry, or the controls that affect how entries
> are interpreted, then you need to invalidate the affected entries in the TLB. If
> you do not invalidate those entries, then the processor might continue to use the
> old translation.
> 
> The undo changes the shadow PTEs, so the TLB has to be invalidated.
> 
> I also checked the Arm Architecture Reference Manual:
> https://support.arm.com/documentation/ddi0487/md/-Part-D-The-AArch64-System-Level-Architecture/-Chapter-D8-The-AArch64-Virtual-Memory-System-Architecture/-D8-16-Translation-Lookaside-Buffers
> rule R SQBCS:
> 
> If a stage of translation is enabled for a translation regime that is not out-of-context,
> any translation table entry for that stage that does not cause a Translation fault,
> an Address size fault, or an Access flag fault is permitted to be cached in a TLB or
> intermediate TLB caching structure as the result of an explicit or speculative access.
> 
> So it may already be cached by speculative access even if there was no explicit access.
> 
> For the kernel side,  Documentation/core-api/cachetlb.rst
> https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/core-api/cachetlb.rst
> says that The "TLB" is abstracted under Linux as something the cpu uses to cache
> virtual-->physical address translations obtained from the software page tables.
> Meaning that if the software page tables change, it is possible for stale translations
> to exist in this "TLB" cache. Therefore when software page table changes occur, the kernel will
> invoke one of the following flush methods _after_ the page table changes occur:
> 
> The condition there is the page table change, not whether the range was accessed.
> 
> Likewise, I believe flush_cache_vmap() is also required.
> The sequence in cachetlb.rst is
> flush_cache_range()
> change_range_of_page_tables()
> flush_tlb_range()
> so the cache flush has to happen before the unmap.
> This is exactly the contract that the __vunmap_range_noflush() comment you quoted spells out,
> the caller is responsible for calling flush_cache_vmap() before the call and flush_tlb_kernel_range()
> after it.
> 
> The code will do:
> 
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,13 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>                                             o_pages, page_shift);
>         kmsan_leave_runtime();
>         if (mapped) {
> +               /* Undo the shadow mapping set up above. */
> +               flush_cache_vmap(shadow_start, shadow_end);

Sorry, this should be flush_cache_vunmap.

> +               kmsan_enter_runtime();
> +               __vunmap_range_noflush(shadow_start, shadow_end,
> +                                      gfpflags_allow_blocking(gfp_mask));
> +               kmsan_leave_runtime();
> +               flush_tlb_kernel_range(shadow_start, shadow_end);
>                 err = mapped;
>                 goto ret;
>         }
>
> Thanks a lot for catching this, I learned quite a bit about the TLB
> along the way. 
> 
> Thanks
> Best Regards
> Hao
>>
>>>>
>>>> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()")
>>>> Cc: stable@vger.kernel.org
>>>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>
>>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>>>
>>>> ---
>>>>  mm/kmsan/shadow.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>>>> index 0c88d89bf0d6..212449db34a1 100644
>>>> --- a/mm/kmsan/shadow.c
>>>> +++ b/mm/kmsan/shadow.c
>>>> @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>>>                                             o_pages, page_shift);
>>>>         kmsan_leave_runtime();
>>>>         if (mapped) {
>>>> +               /* Undo the shadow mapping set up above. */
>>>> +               kmsan_enter_runtime();
>>>> +               __vunmap_range_noflush(shadow_start, shadow_end,
>>>> +                                      gfpflags_allow_blocking(gfp_mask));
>>>> +               kmsan_leave_runtime();
>>>>                 err = mapped;
>>>>                 goto ret;
>>>>         }
>>>> --
>>>> 2.25.1
>>>>
