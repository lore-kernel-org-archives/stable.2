Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F240801E;
	Wed, 14 Oct 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999447; cv=none; b=TEe+1K1ZQmRrlKjXLq6Uoi7rAmZqgYy7kdjjj7KHgiJBCeJBfIYfp2J0JUna0wI8PLLNa37a/wftfjFpfyh3kxFTm9cgBNoSUazArTLbWBW+f6P0/mH5ZwxW3e5a+YlPgfoL7bkz5El0CNQxU/o0OStiqKO9zji+9oUjgCBwhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999447; c=relaxed/simple;
	bh=Gicjb+KllxPdKCL/uuVBCT8yTXNgEhBb1968MG02A4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryTfB9N4BHf09hbKC82v6c5GNK/01uc3wOvn2zQ/nrqzGg9/nVZ3vfG116vAowend/vAQTLSQWcUztp8Il2/MvPqHzAPLVeAGHddntlmRTaKUYZlIgrdVwLAPO8Z4M8NeTYiVaRTsqPXYFyFB2TSlRQW/vWbyAIMJIhC4NvWuUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E12MS8Ai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E12MS8Ai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB261F000C4;
	Wed, 14 Oct 2026 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791999441;
	bh=ZWmhVhzlmIF+Rj1oqypGhYslt6dIJzfsU4ORR9YUvgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E12MS8AiMR8dRNc+UY0RqzdFVDz49lbTlV0q1h6OI9C3Xk4rbkwf8udPrksrM5J7y
	 HVKvxQ2ytS8SsXT7xRcd4TA8B7QCgJdZFfHQArbrqXppTST6+4SRp66ITsgnkKh5d9
	 VZD8hWWK0S+d2EUecaO1/Kcr6NOV60gCLjawRWxmtIf31ohvW72yhM93zWf06vhAFw
	 GWwnS/sex374D6IsrTwiayTS56Cc7VDk8nYc+MUd1kL5PpupANYBWrrEjJA3jsSpFk
	 uXgmK+bI1nKVH6Tti31bcQN8LCLZNcjyQuSH4DV+WMqir6mwmnFZL8QHS4q8ohOXtG
	 iuFnylLGz8yag==
Date: Wed, 14 Oct 2026 18:37:19 +0100
From: Harry Yoo <harry@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/percpu: account full object size for percpu memory
 allocations
Message-ID: <as-8PlmZFjB_d-kN@thinkstation>
References: <20261013-fix-alloc-percpu-accounting-v1-1-03e788a1e41f@kernel.org>
 <20261014164349.2332145-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014164349.2332145-1-joshua.hahnjy@gmail.com>

On Wed, Oct 14, 2026 at 09:43:48AM -0700, Joshua Hahn wrote:
> On Tue, 13 Oct 2026 20:34:39 +0100 "Harry Yoo (Meta)" <harry@kernel.org> wrote:
> Hi Harry,

Hi Joshua,

> This looks quite good to me. Thanks for finding this!
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Thanks for reviewing!

> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 3eff382e565a..d7883507dc15 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1696,14 +1696,15 @@ static void pcpu_alloc_tag_alloc_hook(struct pcpu_chunk *chunk, int off,
> >  {
> >  	if (mem_alloc_profiling_enabled() && likely(chunk->obj_exts)) {
> >  		alloc_tag_add(&chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].tag,
> > -			      current->alloc_tag, size);
> > +			      current->alloc_tag, pcpu_obj_full_size(size));
> >  	}
> >  }
> 
> So @size by itself isn't used, so I was looking to see if we could just
> pass pcpu_obj_full_size(size) to the function instead. Looking at the
> call site, pcpu_memcg_post_alloc_hook() also has the same oddity where
> pcpu_obj_full_size(size) is used for all calcualtions.

Agreed.

At first look I actually tried to clean up things, then realized
I need to backport this and so cleanup should be a follow-up :) 

> So I'm wondering if we can send a follow up to just unify all of these
> and pass pcpu_obj_full_size(size) where the caller never uses @size
> by itself, I think it would also help in demonstrating the intent to
> account the full size. Same idea for the free hook below as well,
> paired with pcpu_memcg_free_hook().

Makes perfect sense to me.

Perhaps mm/percpu.c should still distinguish 'full_size' (uh, naming
sucks) and 'size'.

> Happy to follow up on that myself too : -)

Sure, thanks!
Happy to review that from my side.

> Anyways, the change looks good. Just wanted to bring this up as a
> follow-up cleanup patch.

Thanks!

> Have a great day Harry!

Likewise, have a nice day, Joshua.

-- 
Cheers,
Harry / Hyeonggon
