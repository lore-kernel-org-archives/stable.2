Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D83D646E
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698995; cv=none; b=cmHx4LArQElPDbhGhc0me57Ic4DHm3JrluWePl1tbYipjTeot+3YLGaPxDD/Prw2lV1aguHl3KLfrclxpckpmf4NuTfIfv+MVEdAHapg3I79gEOtTTQOAukiRxZJk0ZLO8wNCaYD2F1T8LLaXmNgm6I0MTWJmlFGo8OhNqinS6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698995; c=relaxed/simple;
	bh=uokSLb5tIWKs9wmoZjlPpYDU82fxVQpNKwqAQMjHX7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqW7C1ZhJx6MZ2g9aVVcqNPf8WztV9qMhhUYm8/qM5AEUK9Uahm2B8sGJ+cSDVLnmNjeM8W1EOOkzw6gJqt1NjkpwlR+E7B4foe4pr05yO+owE0gYk6ANMQWs4AzVjxxT/O1QTrPGj8Q2CuQ8x6nC2U++Rdm9lhjunB4nrxdYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUZwkVhE; arc=none smtp.client-ip=91.218.175.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUZwkVhE"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uokSLb5tIWKs9wmoZjlPpYDU82fxVQpNKwqAQMjHX7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789698982; v=1; x=1790303782;
 b=QUZwkVhEiApuqFBO2Qf3Sr/p7fX6co8bMIR4oUgIrzHtMdkY9hrcU4Xwy6OgO5607RIDk/bB
 6qjBSzNIWGstCwnQKGTcu28ei6A/eIE/F631ACwqzzAqf9w6A04RsJQP1gpP6sBqu0PGdX8OIKs
 YhqyYcHEEz6kqXiD9SONN6ZM=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3b51e68b3c915898;
	Fri, 18 Sep 2026 02:36:22 +0000
X-Mizu-Trace-ID: 3b51e68b3c915898
X-Migadu-Flow: FLOW_OUT
Message-ID: <f16c55ba-3403-4721-9ff1-061d73e17fa5@linux.dev>
Date: Fri, 18 Sep 2026 10:37:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/6] alloc_tag: skip percpu counter allocation when
 profiling is disabled
To: Suren Baghdasaryan <surenb@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-modules@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20260915070001.113559-1-hao.ge@linux.dev>
 <20260915070001.113559-6-hao.ge@linux.dev>
 <CAJuCfpFKGxOy9W+ZY9KasU5YaDVG4kbGsV6AYb2NNRyW4gT0mw@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFKGxOy9W+ZY9KasU5YaDVG4kbGsV6AYb2NNRyW4gT0mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Suren

On 2026/9/18 08:53, Suren Baghdasaryan wrote:
> On Mon, Sep 14, 2026 at 11:59 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> After shutdown_mem_profiling() clears mem_profiling_support,
>> needs_section_mem() returns false, so later modules have their codetag
>> section placed as regular data and never enter the alloc_tag maple tree.
>> codetag_load_module() still called load_module(), which allocated a percpu
>> counter for every tag; release_module_tags() could not find these modules
>> on unload, so the counters leaked.
>>
>> Return -EOPNOTSUPP from load_module() when profiling is off:
>> codetag_module_init() drops the module's cmod, no counters are allocated
>> and the module loads without its tags. codetag_unload_module() now always
>> calls free_section_mem(), since a module whose module_load() returned
>> -EOPNOTSUPP is not in the idr but may still hold a reserved section.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>> Acked-by: Suren Baghdasaryan <surenb@google.com>
> 
> Yeah, I guess I didn't think about alternatives...
> 
> When mem_profiling_support=false, why can't load_module() skip
> allocating percpu counters, zero out the whole area between start_tag
> and stop_tag and return 0 as success (mem_profiling_support is not
> enabled, so we acted accordingly)?
> Module will be added into maple tree and later codetag_unload_module()
> will find the module, call release_module_tags() (which is a NOOP
> because tag->counter==NULL) and finally call free_section_mem(). This
> seems more natural than special-casing with EOPNOTSUPP. WDYT?
> 

I see, but the module would then sit in the idr with NULL-counter
tags that become visible to readers which today never expect that state.

alloc_tag_top_users calls codetag_next_ct() to find the next codetag
and alloc_tag_read() would do per_cpu_ptr(NULL) for each cpu - plain
pointer arithmetic onto a wild address, an oops straight out of the
OOM report. 

https://elixir.bootlin.com/linux/v7.3-rc3/source/mm/alloc_tag.c#L503

So if the codetag section within this codetag_type ends up meaningless,
is there a reason we still return success? We will still maintain cttype->count
and allocate a slot for this module inside mod_idr.

I'd rather keep the -EOPNOTSUPP version (your original suggestion),
also because the comments in load_module() and codetag_module_init()
already document this scenario.

WDYT?

Thanks
Best Regards
Hao

>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  lib/codetag.c  | 10 ++++++++--
>>  mm/alloc_tag.c |  4 ++++
>>  2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/codetag.c b/lib/codetag.c
>> index a9cda4c962a3..a0b600720afc 100644
>> --- a/lib/codetag.c
>> +++ b/lib/codetag.c
>> @@ -240,7 +240,9 @@ static int codetag_module_init(struct codetag_type *cttype, struct module *mod)
>>
>>         if (err < 0) {
>>                 kfree(cmod);
>> -               return err;
>> +               /* -EOPNOTSUPP means we can load the module without its tag. */
>> +               if (err != -EOPNOTSUPP)
>> +                       return err;
>>         }
>>
>>         return 0;
>> @@ -388,7 +390,11 @@ void codetag_unload_module(struct module *mod)
>>                         ++cttype->content_id;
>>                 }
>>                 up_write(&cttype->mod_lock);
>> -               if (found && cttype->desc.free_section_mem)
>> +               /*
>> +                * A module whose module_load() returned -EOPNOTSUPP is not
>> +                * in the idr but may still hold reserved section memory.
>> +                */
>> +               if (cttype->desc.free_section_mem)
>>                         cttype->desc.free_section_mem(mod, true);
>>         }
>>         mutex_unlock(&codetag_lock);
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index 5836803898ad..1ca0409b492b 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
>> @@ -988,6 +988,10 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
>>         struct alloc_tag *stop_tag;
>>         struct alloc_tag *tag;
>>
>> +       /* Profiling disabled: load the module without its tags. */
>> +       if (!mem_profiling_support)
>> +               return -EOPNOTSUPP;
>> +
>>         /* percpu counters for core allocations are already statically allocated */
>>         if (!mod)
>>                 return 0;
>> --
>> 2.25.1
>>
