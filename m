Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9C339362;
	Tue, 11 Aug 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465440; cv=none; b=jS21vtczUbiH6mrMDq6YqTJUIDbbGd993ERB1QzOVEJqVZhlJDj+bn+RRlieKhkcvRDYOnoT5SfRyOWKgneQmqlH2qRplaOfKO1Wrun16rdmjOlCOXd2GWVc7K6kETMH8Qg0cCaOxOiK++bMzq1wA51M7GwpE2hny3lpPG3RFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465440; c=relaxed/simple;
	bh=5KSMq/x0C3KqtA7OYGLyL/4JMg0Qz438sgqQBadDKsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXd/J9zczxTTlwTNN44uSVDVX+mqLMIRQbCBYua1OKsXDOfp2GzehhfLuXAobJ24XoKQdphcHbOTSJU1heOgKF/u7YZewNsEWeW+HpFtMxlYTQW0ZbgFcwZA9lmAo461z+3zWSQOgjfwsNE1SAqGPh9d9UW26q+gWip548t6p14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afTVKARn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afTVKARn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584AD1F000E9;
	Tue, 11 Aug 2026 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786465439;
	bh=8lnFNRxNEuxRRD6qwiMyyus8GQcj7my2tN3yiVz05cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=afTVKARnHiFWaEXzsU4/sBOjrpH93UFBUPgRj0BZGyWL1VOmEplr5QaL/Q2uYLtQu
	 5jl8ulKd+ljnVQnFSAa9VmxepQiQwU21cZC8cdNTmMr1XiyNzyNoAR3c02bsHzkLfy
	 Y8dwiNS2mYggmNWKyTjLD8OaXW6KiYbD4AzVePL2/5WNxE5+J0PfmxG8nqAZ8oCl8l
	 hRk7QxwzU+T2URA8geCSKDd8/1BBrXih1qUkXhv/X6+mZMQTpszZl6pF7zfyBmXpIq
	 tEVJ3n3PrGFJArBV/mUDt/jZK4dAc8w0a422wcNlCsexd+Ed5s2LvSlLphyVy1XkxI
	 y2Oat7ktQokRw==
Date: Tue, 11 Aug 2026 17:23:55 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/pagewalk: fix stale walk->action escaping
 walk_pmd_range()
Message-ID: <antMR-ypJfB3urzQ@gremlin>
References: <20260811161949.3879321-1-imv4bel@gmail.com>
 <20260811161949.3879321-2-imv4bel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811161949.3879321-2-imv4bel@gmail.com>

On Wed, Aug 12, 2026 at 01:18:57AM +0900, Hyunwoo Kim wrote:
> If ->pmd_entry() sets walk->action = ACTION_AGAIN, the pmd_none()
> check is retried. The PMD entry may be cleared at the point of retry.
>
> In this case, if walk->ops->install_pte is not specified, the code
> continues to the next PMD entry in the range without resetting
> walk->action to ACTION_SUBTREE.
>
> This leaves walk->action erroneously set to ACTION_AGAIN, which is
> incorrect.
>
> This was incorrect but not problematic up until commit 3b89863c3fa4
> ("mm/pagewalk: fix race between concurrent split and refault")
> which updated walk_pud_range() to check for walk->action ==
> ACTION_AGAIN upon walk_pmd_range()'s return, causing the PUD walk
> to be retried.
>
> In this case this results in duplicate walk callbacks being
> invoked, which is erroneous and will break any caller that is not
> idempotent with respect to this (and waste time for those which
> are).
>
> A specific example of this breaking things is mincore which walks
> an internal cursor data structure a byte at a time on assumption
> that page table entry callbacks are called only once for each
> entry.
>
> Fix the problem by resetting walk->action to ACTION_SUBTREE prior
> to the none check.
>
> The pattern also exists in walk_pud_range() so fix it there too.
>
> This issue was found through AI-based fuzzing.
>
> Fixes: 3b89863c3fa4 ("mm/pagewalk: fix race between concurrent split and refault")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Thanks, LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/pagewalk.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 5d87c632a25507..d3bfece3193366 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -126,6 +126,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  	pmd = pmd_offset(pud, addr);
>  	do {
>  again:
> +		walk->action = ACTION_SUBTREE;
>  		next = pmd_addr_end(addr, end);
>  		if (pmd_none(*pmd)) {
>  			if (has_install)
> @@ -138,8 +139,6 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  				continue;
>  		}
>
> -		walk->action = ACTION_SUBTREE;
> -
>  		/*
>  		 * This implies that each ->pmd_entry() handler
>  		 * needs to know about pmd_trans_huge() pmds
> @@ -196,6 +195,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  	pud = pud_offset(p4d, addr);
>  	do {
>   again:
> +		walk->action = ACTION_SUBTREE;
>  		next = pud_addr_end(addr, end);
>  		if (pud_none(*pud)) {
>  			if (has_install)
> @@ -208,8 +208,6 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  				continue;
>  		}
>
> -		walk->action = ACTION_SUBTREE;
> -
>  		if (ops->pud_entry)
>  			err = ops->pud_entry(pud, addr, next, walk);
>  		if (err)
> --
> 2.43.0
>

--
Cheers, Lorenzo
