Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5438E8B4;
	Wed, 16 Sep 2026 01:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789523209; cv=none; b=tGX6KIpBO28eNwjB4o7MhD/aOEO+lE1pjV5u0is6+wwJlUqukI0raWUNwnQyfncq3CpelpGQNI7D/Km4g6gKLoxW5VSbhFtUs5MECeX12YdiMquxjiWASuqeiGqGWP8WwYXuUa07wtlt4JbTHW8NvFrpLs0tjl8tTmC7WppM4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789523209; c=relaxed/simple;
	bh=x9a30jip4yh7Vjrr6vGw0btm0TkV63ZMOQmsRTav8kA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nX7WBlBewxRfojk57+iqpp0s70LieY8yjbMb+hTbDcx5a+MT6Ftx6qPFQazUA1tFuaejuH8ayvI6DavE9+bW13D6bdTbsQYQftaWwaIUib2ROWaxvBuZp8tn+DBmzLhSEWKYoX3ejkFthxEQLApTSdTQY4du3Usnbq/hTgRzo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xe4wnLPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xe4wnLPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4978D1F000FF;
	Wed, 16 Sep 2026 01:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789523194;
	bh=yUYa/GvKq0t1HPLtH/seZWJgrC2GfmJGoFRdt2lTvSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=xe4wnLPMzAF02PpoBtQdWpAESwFpnQgwqHUHHMwArKEQ3kVC7isdYXV2pWRF8ZeQW
	 D8+bH/HFkmCtEHk2qeU9BcJuDhoUKKswmdshZhvxE/RT/Qinu2ONkvRa+8SO0iCfKZ
	 LhOCPmhz4FG8PZFU9nRsJ6OBYvPcr+vFVAaHf4H4=
Date: Tue, 15 Sep 2026 18:46:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 liam@infradead.org, ljs@kernel.org, david@kernel.org, vbabka@kernel.org,
 jannh@google.com, sashiko-bot <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [RESEND PATCH] mm/madvise: use folio_trylock() in the
 cold/pageout PMD split
Message-Id: <20260915184633.e2d8cf719e5eed186d087a8a@linux-foundation.org>
In-Reply-To: <20260912110540.3203010-1-gourry@gourry.net>
References: <20260912110540.3203010-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 07:05:40 -0400 Gregory Price <gourry@gourry.net> wrote:

> MADV_COLD or MADV_PAGEOUT over part of a PMD splits the THP in
> madvise_cold_or_pageout_pte_range().  Two threads doing that to
> the same THP create spurious failures.
> 
>   CPU0                          CPU1
>   ----                          ----
>   folio_get()
>   spin_unlock(ptl)
>   folio_lock()
>                                 folio_get()
>                                 spin_unlock(ptl)
>                                 folio_lock()  <- blocks, keeps its ref
>   split_folio()
>     folio_expected_ref_count(folio) != folio_ref_count(folio) - 1
>     -EAGAIN
> 
> CPU1 cannot drop its reference until it gets the lock CPU0 holds, so CPU0's
> split always fails.  folio_trylock() makes CPU1 leave without ever taking a
> reference.  The PTE branch of this same function already does this, as do
> madvise_free_pte_range() and madvise_free_huge_pmd().
> 
> Reproducer: 400 rounds of eight threads calling MADV_COLD on half of each
> of eight THPs, re-formed with MADV_COLLAPSE between rounds.  From
> /proc/vmstat:
> 
>                      thp_split_page   thp_split_page_failed
>     before                     3186                     860
>     after                      3200                       0
> 
> The short before count is rounds where every thread failed and the
> advice was dropped for that THP entirely.
> 
> On failure the walker returns 0 and nothing retries.  The PMD path becomes
> best effort when the folio lock is held elsewhere - same as the PTE path.

Can this result in more EAGAINs being returned to userspace?

> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -419,9 +419,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		if (next - addr != HPAGE_PMD_SIZE) {
>  			int err;
>  
> +			if (!folio_trylock(folio))
> +				goto huge_unlock;
>  			folio_get(folio);
>  			spin_unlock(ptl);
> -			folio_lock(folio);
>  			err = split_folio(folio);
>  			folio_unlock(folio);
>  			folio_put(folio);

Sashiko shares my reaction, "dear god, why does that function exist".

	https://sashiko.dev/#/patchset/20260912110540.3203010-1-gourry@gourry.net

Like the entire function, that random mix of "goto foo" with "return
whatever" needs to die.

Anyway, please check it out while you're on a roll.
