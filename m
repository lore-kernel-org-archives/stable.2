Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717855;
	b=llKtmKpC818N1SNDKOtD6Q6An1A5Nkxumwd231wuX2KYQMH31a+iOjLZ2+8iDegKPPdi
	 rbkSifY4g1pT3EdMDLaMEAz57hWp7RyccagNjg3ruHwkTwLRU64G/iJ5E75kiePyVb6GI
	 zaf4kLExmOvb1EDFg3Rt1wwa2XtFFbiDhweHbWKyiIZzblZ8xf9B2+oQ/T2sAfs9YjypB
	 OkfPmaAH0ULEAlFmHlkAkd38sLIIL6i1vXVrwpSVNX9ap0toBCA0vJMkt04+IYy5lX+Av
	 liPzujExj5fSGhIwTh1RWuf74cR0eyEXBbCeJEprkWxlKoFlPfQN+cTrHkfs1Z36CvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717855;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wVPZHBHmTVqQc0Jh1TfnVqktWkBiefvtfViUxrs9XWI=;
	b=JPruHMCJy4RQ/8NfVnNcL9ttx+6Q4CS9mjsHTUwK90sc+wfwxrkDta3T2VurloekRSHb
	 VtxB5HvO2rAk+GbMO69RytMG7GweNXqdGIVoW205Ko9AUrxNYa3LvKKgffK4gQRroGUDl
	 dpNY+iDPA83z64zaMqubGzSIoe+KgAXYRsRyq4TdaqoS1WM4AqrWMrQ8cb2LzPP2aPqLn
	 ncFJ0MuIdqkePGNE6zJNDtrIz2j7H+pOMTKn6eMK5NTGY8XpD9izy7ROUrGpU+4xcfFtO
	 OVJUwJRjZq1UwXM7LNdjPKN+cgNm1W92ro8jX4B/d4VtGz2TJRRb3YwHOMd8cYjvZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFpNS6bE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11971606A789;
	Tue,  3 Nov 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFpNS6bE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7AB1F000C1;
	Tue,  3 Nov 2026 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717854;
	bh=wVPZHBHmTVqQc0Jh1TfnVqktWkBiefvtfViUxrs9XWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iFpNS6bEHhR8ebqCRAZfPuhOs7jQqMJg1MsO+wzz4LEUgwINXXdloo6S46CgitXEI
	 zYonEJHRlcZqRY6aThjvqxXrj3AX8jxOjgqX3bObrW9ObuduRggGNRmmO9KFYohsRl
	 MIc91meGUPijHpP/YqjnmEV5W7/FlzDSESbVcNFR5w4BzlHrg91Jk7W4tW4k5/eUZN
	 /NlyXJ+CwNd8BQ7ts0WIZmAItdKpGa82Z1OBMYyBw/7+EnfNYi+M8USFOpg3o+Y8+e
	 GE4/1hwkFqy6zr1LqI2w09Vg4hF6CilTyMvRd+OfcFrWHuSd23gfU6WTwlpTKwwRKN
	 sdsCQNQa0h1sA==
Message-ID: <489b668a-033c-4161-93e8-15d6b9b28b51@kernel.org>
Date: Tue, 3 Nov 2026 15:57:24 +0100
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
Subject: Re: [PATCH v5 02/12] mm/page_alloc: keep the pagesets of an empty
 zone
To: Zi Yan <ziy@nvidia.com>, "Gregory Price (Meta)" <gourry@gourry.net>,
 linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, kasong@tencent.com, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, rientjes@google.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, muchun.song@linux.dev,
 osalvador@suse.de, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 Bessel.Wang@huawei.com, jiang.liu@huawei.com, mgorman@techsingularity.net,
 anshuman.khandual@arm.com, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org
References: <20261101021340.2251928-1-gourry@gourry.net>
 <20261101021340.2251928-3-gourry@gourry.net>
 <DMK59DO8M3AP.3OTG2YR62D9WO@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DMK59DO8M3AP.3OTG2YR62D9WO@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/26 21:07, Zi Yan wrote:
> On Sat Oct 31, 2026 at 10:13 PM EDT, Gregory Price (Meta) wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> When the last memory of a zone goes offline, zone_pcp_reset() frees
>> zone->per_cpu_pageset and zone->per_cpu_zonestats. Nothing waits for those
>> who found the zone populated and still use the two pointers. They take
>> neither the memory hotplug lock nor any other lock which offline_pages()
>> holds, and some of them can sleep:
>>
>>   CPU0 vmstat_update()                CPU1 offline_pages()
>>   refresh_cpu_vm_stats()
>>     for_each_populated_zone(zone)
>>       pcp = zone->per_cpu_pageset
>>       cond_resched()
>>                                       adjust_present_page_count()
>>                                       zone_pcp_reset(zone)
>>                                         free_percpu(zone->per_cpu_pageset)
>>       decay_pcp_high(zone, pcp)
>>       __this_cpu_write(pcp->expire, 0)
>>
>> The same goes for drain_all_pages(NULL), which takes pcp->lock, for
>> zone_pcp_update(), show_free_areas() and the readers and writers of the
>> zonestats. If the per-cpu memory has got a new owner in the meantime, it
>> is corrupted.
>>
>> The pagesets are only freed because setup_zone_pageset() would otherwise
>> leak them when the zone gets memory again. Keep them instead and let
>> setup_zone_pageset() and zone_pcp_init() use them again, like it is done
>> with pgdat->per_cpu_nodestats. Their lists are empty, and their limits
>> have been calculated for a zone without memory by the
>> init_per_zone_wmark_min() of offline_pages(), which is what
>> setup_zone_pageset() would come up with as well.
>>
>> Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
>> Cc: <stable@vger.kernel.org>
>> Assisted-by: LLM
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
>> ---
>>  mm/page_alloc.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> LGTM. Just a nit below:
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f1048168c90c..1850a41f24f7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
>>  {
>>  	int cpu;
>>  
>> +	/* The zone has been populated before, see zone_pcp_reset(). */
>> +	if (zone->per_cpu_pageset != &boot_pageset)
>> +		return;
>> +
>>  	/* Size may be 0 on !SMP && !NUMA */
>>  	if (sizeof(struct per_cpu_zonestat) > 0)
>>  		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
>> @@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
>>  
>>  __meminit void zone_pcp_init(struct zone *zone)
>>  {
>> +	/* A node which is added again, see zone_pcp_reset(). */
> 
> it might be better to explain zone->per_cpu_pageset can only be NULL at
> boot time and it needs an initialization.

Hmm.

>> +	if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
>> +		return;

Shouldn't then the check be just:

if (zone->per_cpu_pageset)
	return;

Because if it's == &boot_pageset, we are just setting the same values that
area already there?

>>  	/*
>>  	 * per cpu subsystem is not up at this point. The following code
>>  	 * relies on the ability of the linker to provide the
> 
> 

