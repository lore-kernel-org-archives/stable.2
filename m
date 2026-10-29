Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281031;
	b=xC6ltpA+Pqib0/ZVJBMIm9OiyACbhVqsc2+wZB/8us2D0kX9RMKJlbp8WAcZCijOX5IJ
	 8GQP0Co3ZfVDMblX2SpqM9fhu9blxS9kGfMdEz2uvPTQdhh/adAhx7WoJsWTYiWsOOpH6
	 AXSVCk9X1RqzCwAw4quywxNq/Y0woehEYERv6if7K2ie5M87gw5DxPA2bJs+DhY9MZu5i
	 VtW49UKY5MCsdHoGyKnJZXCO8xGZcXqAqSCmfgGRDE2It0j9KOl36EmCXh1WQiwB5fu1N
	 E/PWPJ9bHVt+u1mnd6DZ5b7Mmrg/gvk1lQ9LaWRPWePQJoswkfLuw+UJT3cGNUzABhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281031;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yusQ/gNp1al5ffFyiPFxovqkMkBkDvq1/V1A+G8KNP8=;
	b=tLdJAOrx50SwXPyaXfUlimDvpD/uxyU5zCFBt/onJNmK+Lhkl4cMSAAJWGokDMmARxm4
	 Fem5dE+im9awOvat4s1ooi4ay2eZmWhwxYY/fibccaiqpC0g1Hz0pguosmixT2ccl6xzG
	 SAfdCmRiyQdRCVBAagN3XnbIa5P8PPCkDHg+97sittPV8E3JAz8LodGMG5kuNmWendDNm
	 Nh0zVi7OogDmfK+8M77OwFcdzhLHsj+jGWiy0utAqXLkryjxXNmXnkndv4QMSIGQk334M
	 dOwk+iRyNcbMEdFAWjwR+IZTzKbOfSjBgIK0CZzevk7LkGqoHzOOp5AbAZHlFWDmKdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIXuH3oP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24960A382A;
	Thu, 29 Oct 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fIXuH3oP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2692A1F031EC;
	Thu, 29 Oct 2026 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793281030;
	bh=yusQ/gNp1al5ffFyiPFxovqkMkBkDvq1/V1A+G8KNP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fIXuH3oPbKOQqHa+sb82A1lqdGEE0KcOgjF+PatDaFm43q0tXh6aZfgHVTPVkzhK8
	 jR0yOowvlHMK1RAA3Gh8EHvmNFZ190IgWKCan6bh89OQ1KHejC1cxKJrwPjErgz80o
	 GtZ2nO9DmLB3ry90DZ0LhmjrKBrm9bdOrPRHbKa5tH3YviCk87S5bMVhZiS13bbaTE
	 diYUiyFFeavhUjIW73ix4dDOFSqJsVIrEM0rBfDWS9QMA8oCUgO6HMKrQk71Ol0HKC
	 t7wrO2vnOAMFY65gPgYkcD9GNDNEe1748kh2kCS7PeaNEk3VFGgZjLQKCOwc3IihDq
	 15/bp4/cVuzDg==
Message-ID: <68fd8182-cdfb-4f11-95de-1472e6c92d33@kernel.org>
Date: Thu, 29 Oct 2026 14:37:03 +0100
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
Subject: Re: [PATCH v4 1/8] mm/page_alloc: reset can_retry_reserves when the
 slowpath restarts
Content-Language: en-US
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
 akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, ljs@kernel.org,
 liam@infradead.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, mgorman@techsingularity.net,
 anshuman.khandual@arm.com, stable@vger.kernel.org
References: <20261028211930.3504634-1-gourry@gourry.net>
 <20261028211930.3504634-2-gourry@gourry.net>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261028211930.3504634-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 22:19, Gregory Price (Meta) wrote:
> Commit 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath()
> flow") retries an allocation once with reserve_flags when the caller
> becomes eligible for reserves, guarded by can_retry_reserves.  The flag
> is set at its declaration and never reset.
> 
> A restart after a cpuset update or a zonelist rebuild drops
> reserve_flags

I don't follow, nothing "drops reserve_flags"? after the restart,
there will still be a get_page_from_freelist() without them followed by
get_page_from_freelist() with them, right?

> and comes back with can_retry_reserves already false, so a
> caller that cannot reclaim, such as GFP_NOWAIT | __GFP_MEMALLOC, fails
> without trying the reserves again.

The "goto retry" triggered by can_retry_reserves actually drops nodemask and
recalculates preferred zones. Perhaps "can_retry_reserves" wasn't the best name.

> Reset can_retry_reserves at restart.  Only a cpuset or zonelist change
> restarts the slowpath, so the retry still runs at most once per change.
> 
> With kprobes failing every attempt without reserves and the first with
> them, and a memory block onlined during the walk, the allocation
> returned NULL in 3 of 3 runs, and a page in 3 of 3 with this change.

So IIUC the allocation was racing with a memory online in a way that it
would fail if the online happened fully after the allocation. So this just
turns part of the race window into the allocation's favor?

> Fixes: 2c4c3e29897d ("mm/page_alloc: simplify __alloc_pages_slowpath() flow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

I mean it's not wrong and if patch 5 depends on it (unless it also only
fixes a racy window in the same way I think is happening here) then so be
it. But the commit log would need correcting.

> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2daf358269ae..78569ac6f2d9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4783,7 +4783,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	unsigned int zonelist_iter_cookie;
>  	int reserve_flags;
>  	bool compact_first = false;
> -	bool can_retry_reserves = true;
> +	bool can_retry_reserves;
>  	unsigned long alloc_start_time = jiffies;
>  
>  	/*
> @@ -4817,6 +4817,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	no_progress_loops = 0;
>  	compact_result = COMPACT_SKIPPED;
>  	compact_priority = DEF_COMPACT_PRIORITY;
> +	can_retry_reserves = true;
>  	cpuset_mems_cookie = read_mems_allowed_begin();
>  	zonelist_iter_cookie = zonelist_iter_begin();
>  

