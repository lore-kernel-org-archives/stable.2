Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872733;
	b=TDZK9ZrPB6BOXveEUdkV9cgTSuwLQw3n/wybId76k09kV0tIAaO3MBpQ7h02DUog5Shp
	 VNf3xmVOXaCWwZ415S1cgnP1RopVSZ0lM3MHZ8j8WKUc/XGO9XQvlHUBVO23ARS79qb1N
	 H5NGe+99LinEqGGg+Aq4dIuTIhSTetGXyR3EAzfEUL2EasIIIz7aoE9R0IWq061mbIbak
	 czr5fEw/BVwWqXU09XIpBhI3QN1TT7A7RwJAOff7n+ZIZX97Ex8WLMc1/jPdv49hO6OGr
	 bMkO1iyMQ914eLvXZ+lNAaGi009zYO89YaGR2OOyD9pWR1uVxuijuBTQwuHsf/jG8rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872733;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=q/X+C1Y8TceHHEUuqIf1Y7YzjYQg0qCuJDWINnus5m0=;
	b=uBzRur8ehmlQAWHVvl6StS8WcYCciJVMGxphDfAqKk5nEn/YtLnZsVz1/IawZ3hy8vx2
	 Uu8PSXvpXI7moFmnwjGNhcxVsCGm+jvFLPFjVu9IVc8TzpDGMOds5ySS+4JjgaZOpIvzx
	 rGZIWUeMIXxrdUTRgd1ACIZj8pZnSFxkV8t3+PoEaf+QbxbcuQ2AeaNOtVyI+8Lbw5ni2
	 t7Fx8vIWCcT6oMvqKRlDxgH3p2D75cihPsyJxVBXRAlbUleBkwbb7/F0yw5KZHAdjnNJ0
	 N+jSFJOiE4ONZ3/LiK4P8FS9mMJtFDJjrgKBnRs2f22jugso/bSadqmux8wabsyWUyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7BZOv6y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F5606A32C;
	Thu,  5 Nov 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7BZOv6y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7802A1F000C1;
	Thu,  5 Nov 2026 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872733;
	bh=q/X+C1Y8TceHHEUuqIf1Y7YzjYQg0qCuJDWINnus5m0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d7BZOv6y47/RQ2Ml9iy4bi7L5V1/nD//V4d6VP/9soB5stou23M4Km74Szg3Nrm3p
	 wCdMVRys8gcsqkPoyJyNnyL1U0/e2hdmDU2HkeQ3y++ZKgCL6NIKS2g+Xn1qVYUCIg
	 /JOTkot7nWIHdNJmFwZ4NZYbrxBMA0spOxrsxhXtH4/7hCzWTyA9FMG0FQNRAqRlDC
	 S8+JrNV0DEVmot9dYaua6ajAf7G92UMTuXxCX6VowkUJYKFOPGS0mBCz7JpMALgdFe
	 ComZLv0SAKpc6/Opp4e7FLf0nsKozgFIVdJJK+EDJLejPETCTHHNJclf5I4qzf7mOg
	 xnE9UCMW3swNA==
Message-ID: <6c5f3ef1-188f-4a5d-8775-578dc2c84c59@kernel.org>
Date: Thu, 5 Nov 2026 10:58:42 +0100
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
Content-Language: en-US
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
 <489b668a-033c-4161-93e8-15d6b9b28b51@kernel.org>
 <DMLPC0D7EWRW.EVYWUONVO18A@nvidia.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DMLPC0D7EWRW.EVYWUONVO18A@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 17:04, Zi Yan wrote:
> On Tue Nov 3, 2026 at 9:57 AM EST, Vlastimil Babka (SUSE) wrote:
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index f1048168c90c..1850a41f24f7 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -6308,6 +6308,10 @@ void __meminit setup_zone_pageset(struct zone *zone)
>>>>  {
>>>>  	int cpu;
>>>>  
>>>> +	/* The zone has been populated before, see zone_pcp_reset(). */
>>>> +	if (zone->per_cpu_pageset != &boot_pageset)
>>>> +		return;
>>>> +
>>>>  	/* Size may be 0 on !SMP && !NUMA */
>>>>  	if (sizeof(struct per_cpu_zonestat) > 0)
>>>>  		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
>>>> @@ -6400,6 +6404,10 @@ void __init setup_per_cpu_pageset(void)
>>>>  
>>>>  __meminit void zone_pcp_init(struct zone *zone)
>>>>  {
>>>> +	/* A node which is added again, see zone_pcp_reset(). */
>>> 
>>> it might be better to explain zone->per_cpu_pageset can only be NULL at
>>> boot time and it needs an initialization.
>>
>> Hmm.
>>
>>>> +	if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
>>>> +		return;
>>
>> Shouldn't then the check be just:
>>
>> if (zone->per_cpu_pageset)
>> 	return;
>>
>> Because if it's == &boot_pageset, we are just setting the same values that
>> area already there?
>>
> 
> Right. And zone_pcp_init(), called by zone_init_internals(), becomes a nop for
> free_area_init_core_hotplug(). Then I wonder if zone_init_internals() is
> needed for hotplug, but that belongs to a later cleanup.

Yep, that's for later cleanup. Right now the minimum that's correct and not
unnecessarily misleading is enough. So I've done this:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1850a41f24f7..20bfd11c5851 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6404,8 +6404,8 @@ void __init setup_per_cpu_pageset(void)

 __meminit void zone_pcp_init(struct zone *zone)
 {
-       /* A node which is added again, see zone_pcp_reset(). */
-       if (zone->per_cpu_pageset && zone->per_cpu_pageset != &boot_pageset)
+       /* This initialization only needs to be done once */
+       if (zone->per_cpu_pageset)
                return;

        /*



