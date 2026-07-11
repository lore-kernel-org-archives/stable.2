Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1019C2FD;
	Sat, 11 Jul 2026 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783728194; cv=none; b=Y1GCm2kPMd4m1z8sEsbnkpxDk5CLlJG2u/4Mz1Q4HYcKW91d+4n9UY0EVNlJkMlP3rFLPzdmABeG+PgztPt1u1vESmIi+2/lxkGJq7jx9aMha4ifsGRLZUgtEtq6TVEhdbmjW+vqcHJwymdj+wSBNTiS2SKC1TLJOKiPNWrrC2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783728194; c=relaxed/simple;
	bh=enp0NP5xaefs9vcbyeAYqjQEkQVaejslQaL03xbi5w8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h0XrDNFvRp2INDy0kcUKTfwvsCoRKHQSyCun1u65drNjdI0WqjxJnd3XMoLdG530hYFA00kS15xaTxnc5CErfrAiVAkE2mKVCznxInwDOQaQxI0ogvIupcJetUIlz6nsaxO/h/fG7KqKARFu8tk9cZ4QuZylbC5r3gPNuueNVvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ks717yvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ks717yvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A11F000E9;
	Sat, 11 Jul 2026 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783728192;
	bh=xuhLIGvoMzgdosMhkd0fNaNt5l4k3HBHBOpccxuxKL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ks717yvFqYIqA6WR+QY37XIQWgJADMKlFNW8jw3XJ2p3rnLamQ14UKrDDItXLbEl4
	 qMcKrFN9cPWw4pHi6vEKiLUVCcNSTKGHw5XWQFPyyn4tHd+4kR4/AfwoZFuob4diub
	 l93MdDD/tamKwNitPw3Y4n9eHiC14DinXg6/RRiE=
Date: Fri, 10 Jul 2026 17:03:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, Harry
 Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, sashiko-bot@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
Message-Id: <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
In-Reply-To: <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
	<20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> As noted in can_spin_trylock(), using this is unsafe in this context.
> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
> but missed the free side.
> 
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
> Cc: stable@vger.kernel.org
> Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")

Is this correct?  I'm not seeing anything in that commit which could
have caused this?

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
>  		migratetype = MIGRATE_MOVABLE;
>  	}
>  
> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
> -		     && (in_nmi() || in_hardirq()))) {
> +	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>  		add_page_to_zone_llist(zone, page, order);
>  		return;
>  	}

It would be nice to include a description of the userspace impact.  I'm
suspecting that's "none known", but some speculation on what might
happen to someone is appropriate.

Also, please let's not combine a cc:stable bugfix with a minor macro
renaming.  They're very different things and will take quite different
paths into mainline and -stable kernels.

Also, Sashiko might have found yet more pre-existing issues:
	https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com


