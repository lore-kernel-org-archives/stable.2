Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BC3438B5;
	Fri,  5 Jun 2026 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672988; cv=none; b=uF6RBfViPBDY4Ahze8fOjieSwykHXbpsp0hwCODZfIjiAIe7fP9AxBa7vUegvd41c/vHHyJCsOG36nVVisF/4OyS9bJdcDqlHJVam+1IEsjM8s4+pSLQlw5jVLHa+R9k8res7WveXsCppHd+L/e4SOF1jtYeF4M6Trty6WXWWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672988; c=relaxed/simple;
	bh=nbRSvaat5VGspnNLU4aZRpu6SrqS62GVtLyLDSOGZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL3hA89+R4D/leqXE6MsmnDGKyawKVjiQpUw/iGR0IUxTMTxddvlALeno2uP1pvRvkR+fipuSIOdf8WoMIQA6t2Hl8dh1Xh5r7uVt01NE3RQtSQSMF7k/WS6lq2AvWnDn8KqMgyaEuRZoKV+bgHABiPJwG96Eyhmn/lkdwppRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lld5KT01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lld5KT01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21FF1F00893;
	Fri,  5 Jun 2026 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780672987;
	bh=4wOr+NvrPlKYULhjCbciaU+Y1LY+GHa/b5I1+X3BL6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lld5KT01regBZ465fs7NoQrwEnUy7oqvFb0aRZOf704ugy+VqdGshjAOPQ09DmJKQ
	 ov6rIEYAmxuAuDm9c9HQS6Z32Nqfp83V1tVOlSvyqckeh/uEy5sjFmcp5cf1sCYVoT
	 eKh0C9+h9dE1JPBCPP3Xl8bmCMdGA+HDveybSt+Earil/JVfMZbvSOFar/+pH4Q5tM
	 6Jip2iRfxXBPu3YNL6/SwsOW9f/aBN7ZWNqToEHT6o2UfBgwy0tfc9AoxLmFhTwN2H
	 cPcqttEbmx9ipsbilGaXHGycV5pf9l07+RqHrcsj1IXg2nqwPLse2mJaNsVk2Sedr3
	 XM3m/qmEs3xpw==
Message-ID: <92780fad-f0c3-4048-a89f-171c46cba212@kernel.org>
Date: Fri, 5 Jun 2026 17:23:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/compaction: guard move_freelist_head() against invalid
 freepage
Content-Language: en-US
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 akpm@linux-foundation.org
Cc: surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260601133941.111989-2-giorgitchankvetadze1997@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/1/26 15:39, Giorgi Tchankvetadze wrote:
> In fast_isolate_freepages(), freepage is declared uninitialized and
> is only assigned a valid page pointer if list_for_each_entry_reverse
> exits via break. If the loop runs to completion (all pages in the
> freelist have pfn < min_pfn), freepage holds the list head sentinel
> and high_pfn remains zero, so the high_pfn fallback does not update
> it either.
> 
> The subsequent unconditional call to move_freelist_head(freelist,
> freepage) then passes the sentinel as a page pointer, which is
> invalid.

I was wondering why we're not crashing horribly ever since the code was
written, as those condition have to happen a lot.

Looking at move_freelist_head() "if (!list_is_first(...))" will be true,
unless the freelist is empty.
Then luckily list_cut_before() has this very helpful comment:

 * If @entry == @head, all entries on @head are moved to
 * @list.

AFAICS that's what should be true here when freelist points to the sentinel.
I'll trust the comment and not try to reconstruct what the code is doing.

Back in move_freelist_head(), so we isolate all of freelist on the sublist,
then splice it back on the (temporarily empty) freelist.

I.e. I think it's harmless, but just accidentally, and it's useless pointer
churn. So very much worth a cleanup, but we don't need to rush a stable fix
here.

> Guard move_freelist_head() inside the existing 'if (page)' block
> where freepage is guaranteed to refer to a real page.
> 
> This issue was identified via Coccinelle (use_after_iter.cocci).
> 
> Fixes: 5a811889de10 ("mm, compaction: use free lists to quickly locate a migration target")
> Cc: stable@vger.kernel.org
> Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> ---
>  mm/compaction.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 8f664fb09f24..320c082420fd 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1611,11 +1611,10 @@ static void fast_isolate_freepages(struct compact_control *cc)
>  			freepage = page;
>  		}
>  
> -		/* Reorder to so a future search skips recent pages */
> -		move_freelist_head(freelist, freepage);
> -
> -		/* Isolate the page if available */
>  		if (page) {
> +			/* Reorder so a future search skips recent pages */
> +			move_freelist_head(freelist, freepage);
> +			/* Isolate the page if available */
>  			if (__isolate_free_page(page, order)) {
>  				set_page_private(page, order);
>  				nr_isolated = 1 << order;

