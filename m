Received: from mta0.migadu.com (out-88.mta0.migadu.com [91.218.175.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAA3C65F4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161853; cv=none; b=pMCGlqzMTG+4l0az2pxbr3mn5F/+Te9SvaYv7/VO3H/LYi3r4RISGdh05KIpUNG/r3KPKefJSPHO8PpYCsV1BohvhJ42nu1aMwiP8lICYUHrnENWbSHOj2OgZQdTgAHAn06whMRrBP2Nhz6oxRASVOnHYnFaibIdg9W4QXl40Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161853; c=relaxed/simple;
	bh=uxdKX20I9JQ/4ZC9HWtiJ9xgZdL6bJ5oz1EYtGytCcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhljrgCpzkNvY5j4ZIV2QbwV0E2IsMs7jiJ2DC7Hnzq8u3PirQ9YSCt6eI8AgGaecbOcpsCdOnOc/z+meN6q9lqfSvM+s7vUUwoZsQMCZaAPkQeaMIC3NX6lenmBw0ZJOdahkalkBlIeFOGqYkOHShs93k4KD13wlt9errbZl6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NWoX0q+8; arc=none smtp.client-ip=91.218.175.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NWoX0q+8"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uxdKX20I9JQ/4ZC9HWtiJ9xgZdL6bJ5oz1EYtGytCcE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788161848; v=1; x=1788766648;
 b=NWoX0q+8y6x9sv2pt0nThFKzZM5elNJ4wVzcasiOO1US4c1DLhMAlS2nHjbPDLU6rGoDhFP0
 zIf242wtC2iV9CVJ0OHWzpN+btqOfbnO0SWX1r1O7CU9JkL7soQGXDWWZs5iwTW+tTIqpF7fFWU
 3UYpJcnR4U4/WNNridwn+vwU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id df6850f57dc2e572;
	Mon, 31 Aug 2026 07:37:28 +0000
X-Mizu-Trace-ID: df6850f57dc2e572
X-Migadu-Flow: FLOW_OUT
Message-ID: <556a5f2e-7ce1-4045-b935-9ba877254cd2@linux.dev>
Date: Mon, 31 Aug 2026 15:38:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
To: Petr Pavlu <petr.pavlu@suse.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
References: <20260812054105.102637-1-hao.ge@linux.dev>
 <20260812054105.102637-3-hao.ge@linux.dev>
 <CAJuCfpFvdNFdsKdK2CdF2fNp8gbNgFpoeAiaqp70mpbNGCvk3g@mail.gmail.com>
 <143a37b5-93a2-4038-8be9-29e13263e743@suse.com>
 <CAJuCfpF1pWqhc+P9zPg8FT_CcdQxRuEpJ2DtYja1BeMXhW7-8Q@mail.gmail.com>
 <499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Petr

On 2026/8/26 16:32, Petr Pavlu wrote:
> On 8/16/26 5:16 PM, Suren Baghdasaryan wrote:
>> On Sat, Aug 15, 2026 at 3:45 AM Petr Pavlu <petr.pavlu@suse.com> wrote:
>>> On 8/12/26 7:41 AM, Hao Ge wrote:
>>>> In reserve_module_tags(), the tag overflow check is gated on
>>>> mem_alloc_profiling_enabled():
>>>>
>>>>     if (mem_alloc_profiling_enabled() && !tags_addressable())
>>>>
>>>> If profiling is toggled off at runtime and a module is loaded whose
>>>> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
>>>> skipped. vm_module_tags_populate() still maps memory for the tags and
>>>> the module loads successfully, but the total tag count now exceeds what
>>>> NR_UNUSED_PAGEFLAG_BITS can address.
>>>>
>>>> Once profiling is re-enabled, ref_to_idx() computes each tag's index
>>>> as its position in the alloc_tag array. update_page_tag_ref() masks
>>>> it to alloc_tag_ref_mask before storing in page->flags. Indices
>>>> beyond the mask are truncated and idx_to_ref() resolves them to wrong
>>>> tags.
>>>>
>>>> This silently corrupts /proc/allocinfo: allocated pages get attributed
>>>> to the wrong call sites, so the statistics it reports are wrong.
>>>>
>>>> mem_alloc_profiling_enabled() and mem_profiling_compressed are
>>>> independent. Once compressed mode is established at boot, it stays
>>>> active regardless of runtime toggles of mem_profiling.
>>>>
>>>> Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
>>>> profiling, release the reservation, and return -EAGAIN so that
>>>> layout_and_allocate() retries with profiling disabled: codetag sections
>>>> are then placed as regular module data and the module loads without
>>>> profiling rather than being rejected entirely.
>>>
>>> When the described overflow occurs, why should codetag sections be
>>> placed as regular module data? Will the codetag support use them in any
>>> way, or do they simply waste space? Is the issue that alloc_hooks()
>>> creates relocations pointing into .codetag.alloc_tags?
>>
>> Correct, alloc_hooks() will have references into .codetag.alloc_tags.
>> With mem_profiling_support=false they should technically never be used
>> but I don't think it's a good idea to skip .codetag.alloc_tags section
>> allocation and to leave dangling pointers. Also the case described
>> here is an outlier, so optimizing it would not yield much benefit.
>>
> [...]
>>> I'm not sure this is the best approach. It's complex logic for what
>>> appears to be an edge case related to a debugging facility. It will have
>>> the usual problem of error paths not getting enough testing and breaking
>>> subtly over time.
>>>
>>> An alternative could be to reset SHF_ALLOC on the codetag section to
>>> remove it from further processing and have relocations that point to
>>> this section resolve to something else. It seems that alloc_hooks_tag()
>>> could tolerate this, since it only needs to reference the associated
>>> alloc_tag when mem_alloc_profiling_enabled() is true and that gets
>>> disabled by reserve_module_tags() on the overflow.
>>
>> Hmm, yeah if we redirect the references into .codetag.alloc_tags, that
>> would be much better.
>>
>>>
>>> It is also not an ideal approach, but I feel it could be less intrusive
>>> to the module loader. I can put together a prototype if needed.
>>
>> If your approach does not cause module loading to fail when we disable
>> profiling, then that sounds like a good idea. If it's not too much
>> trouble, could you please send an RFC?
> 
> The alternative approach I mentioned unfortunately doesn't work well,
> since redirecting all relocations against .codetag.alloc_tag to
> a different destination is nontrivial. It would require introducing
> something like frob_relocation() that is called from each
> architecture-specific apply_relocate()/apply_relocate_add() after the
> addend has been decoded.
> 
> Another option I realized is to change the order in which module
> sections are allocated. Rather than interleaving the allocation of
> codetag and regular sections, the module loader could first try to
> allocate codetag sections and then allocate regular sections. If
> allocation of a codetag section fails, it can naturally fall back to
> being treated as a regular section. This avoids retrying the allocation
> process, which I would prefer to avoid.
> 
> A prototype is below.
> 

Thanks a lot for your prototype. I have reworked it with some changes,
and here is the link to the patch:
https://lore.kernel.org/all/20260831072104.120197-3-hao.ge@linux.dev/
The differences against your version are listed in the patch.

I originally planned to put you as the patch author, yet I was
concerned my modifications on top of your prototype might not be
clean due to missed corner cases. I therefore added the
Based-on-a-patch-by: trailer. I realise this might not be perfect
given that most of the credit is yours, and this is my first‑time
dealing with this scenario. This is also one motivation for sending
it as RFC. Feel free to tell me if this attribution is incorrect,
I will fix it in the final release.

Thanks
Best Regards
Hao

