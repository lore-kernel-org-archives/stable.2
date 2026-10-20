Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480035;
	b=I3ai221e1eBaCVWfPsGE2kEiimKrGlY904OYzpewykbHGglaBiWHYsPnWVRWW/cjBgWb
	 DLPjLEXKfQoLP5zAPcY6oSUH/HDQl/uQFHdWUtjmOqM1Zbnxkh0+BdYcJBvp2EV2NfiSN
	 vPbnJLQxob5d1XEbYdHjqALM99KtgZVoiCMoQzmTztRoci9Kk2x6Tj/6ZHFnysINFrSqj
	 etfMQH+Q7XNMOqj06JmiP8w1mdeIlPUSdc5NneKV1RdRfpmgkXnl9NP7kIkOsTxeV7ehp
	 xzcXvMqMqOyxR1IYdSDS6RlRMVI1n5246CrwVJ3i+wBYjeD8RiXuKiGHrU3llfflgYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480035;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=va85dGP8bTh3iNH3G4o59YOyEfW8Q3pdlTpaj4aMI0M=;
	b=GtgfUTWwxp6KaG55z+8CNhp0Uu7+pm70rKJ8XrCF4SEJBSXIp1F3K5dAonQoiFQQuEcy
	 xgd/d/SrvFI0AHIA4p2eVQd5rIjQuOxAIverO2nhKzXP1THGwl7Eda0qBIoaAFpJsbdZQ
	 32jHQEGWOmnlltmirTktyWglJ42ukqCerrAz2J18r+TDCTyiL8nziGNORF53N6dKH8qNq
	 cdIC5cSMNG0Viw6w3U9/e3jOhyEnNjzoISLyG45NO9/0DtVqRS3bz3E5YqBKJzNaRNU6W
	 8SxuSlWjN5gBbqwyK+LjdGTFhYR4u9RAY350fr1MtH/OVTDLRHN7kGt2iiGrw1+zygw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCRPp85g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7B606A319;
	Tue, 20 Oct 2026 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCRPp85g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD69C1F000C4;
	Tue, 20 Oct 2026 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480035;
	bh=va85dGP8bTh3iNH3G4o59YOyEfW8Q3pdlTpaj4aMI0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lCRPp85gkA1330RWMyZ5bKiPPbXB4EYR3YGrg15qB9Mcsofye16ZLE8LLiHti+J2b
	 Gk6uOrQuPqqE0Hi4sVFa72ObcJj97rZGClMsR3H5ZY0HtAc5alLIKDH+EmDeDd6Lw1
	 u+tljg+1TG6lDCMUQpxFY9RCsIcYJzgoCqzT+7rLGZCeKF7GMNXfhAt/1DttrMxapN
	 mPBQrxOfz//7uxZsGlBTy2X2ROhTyHFMgIScEfxqEmC/nGcqCXp0kaXveTzkU0fFeV
	 YnCKW6TKLJQnVOuPImnfnSSBtG1qow5vv/LxjvM8g8FPWzqFqN2mvRrjqCr3QVaUTL
	 qrNdjxKDECKFg==
Message-ID: <0ec17401-556d-4a85-9657-23a21aed09a2@kernel.org>
Date: Tue, 20 Oct 2026 09:07:09 +0200
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
Subject: Re: [PATCH] mm/page_alloc: count guard pages as free again when their
 buddy merges
To: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, fvdl@google.com,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 Baoquan He <baoquan.he@linux.dev>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
 stable@vger.kernel.org
References: <20261016122304.5b1eba8e@fangorn>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20261016122304.5b1eba8e@fangorn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 18:23, Rik van Riel wrote:
> With debug_guardpage_minorder set, expand() turns the unused halves of a
> split into guard pages, which page_del_and_expand() leaves out of the free
> counts. Freeing the allocated half credits only that half, and
> __free_one_page() then merges the guard buddy with clear_page_guard(),
> which no longer touches the counters.
> 
> The merged block goes on a free list with the guard pages never counted,
> so NR_FREE_PAGES falls behind the free lists by every guard that merges.
> Before commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting"), __set_page_guard() and __clear_page_guard() adjusted the
> counts themselves; that commit dropped both adjustments but kept the
> subtraction implicit in expand().
> 
> Count the guard pages under the merged block's migratetype when the
> buddy is cleared. account_freepages() skips an isolated block as it does
> for every other free page, and moving the block off the isolated list
> counts it then.
> 
> Booting a 16GB VM with debug_pagealloc=on debug_guardpage_minorder=1,
> check the difference in free pages reported between /proc/vmstat
> and /proc/buddyinfo.
> 
> At three points (idle, after a read and file-creation load, after
> a second load), check the difference between nr_free_pages and the
> buddyinfo numbers in the normal zone, as a number of pages:
> 
>                 idle   after load   after second load
>     unpatched   -130        79205               99121
>     patched      -16           45                   0
> 
> The small remaining difference seems to be due to the numbers
> not being read at exactly the same time, and is also seen
> without guard pages.
> 
> Fixes: e0932b6c1f94 ("mm: page_alloc: consolidate free page accounting")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 12fac9084c483..4658af97be010 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -988,10 +988,12 @@ static inline void __free_one_page(struct page *page,
>  		 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
>  		 * merge with it and move up one order.
>  		 */
> -		if (page_is_guard(buddy))
> +		if (page_is_guard(buddy)) {
>  			clear_page_guard(zone, buddy, order);
> -		else
> +			account_freepages(zone, 1 << order, migratetype);
> +		} else {
>  			__del_page_from_free_list(buddy, zone, order, buddy_mt);
> +		}
> 
>  		if (unlikely(buddy_mt != migratetype)) {
>  			/*
> 

