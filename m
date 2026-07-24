Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE20441614;
	Fri, 24 Jul 2026 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908591; cv=none; b=Yigp/aqAsTL531bpFJVZSXZvP9AHUR9u+S+mNVL4Vscoy5vZ0Glb9t0lxpO/6dtiuKhXr1tBUY4fnttmka4DmOB0lak3CpFB5Z0gA5lwxoswNA1VT8c5NgbN5gD5p2NmRoafHG58jFADoI9+4SQyZGnH+OSOtbrdPB95aQuJ7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908591; c=relaxed/simple;
	bh=7yPQswfYrp6arMkV7kcJSF7gO5TtY1yimhDLcaR1kMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzODILuUHEivPTAsmZStt0ccTAHNiNPqEejTI6pYgCZzi+N3F80oazDpD+5K2bYmIg73hfKzbGJdclxu0vuvpAOI5TIVtUSL7UVrSHtYR+eXALj8ak067ehrxROBxDdTEBDuNSOTG+E6W11Eu28oBEfny2QaCYWwnvYoZIdb+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgCgo1+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgCgo1+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6601F000E9;
	Fri, 24 Jul 2026 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784908590;
	bh=j2zxJGtgfagroV+khp6LEYmzLz5B0imC6r6TA5mARIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YgCgo1+sQf/CYWlQEc72vKQJzzaMCshLdDrXo2v+qu3869/s8Q3xtkeXD0tU9OG+u
	 RJieMRIx+LJPephtuXb9OaRRDiIxFyEgSogH3qTZj6T3IFB7+J9JqIKMF3jxjCimzr
	 LNh696qm3ZbPmm3KCNDgNITzHgSafm1L6b8hI//jJeneGEEM5PajUufsQ3CHvaDY8L
	 3VFsANaCSpPmqbLq8h11/g9WL8LOQ13Qo5cF0tglgdMLvMeoHzIAbQNpCC8q7PGJ8g
	 tqjdjpXy5z5TOLFYglZwpy4R/aAZxn341bjpgdsWuOiRkpIpwDfpUqBZbU+Xm12iy0
	 BJvxWe1GQT6kQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: dayou5941@163.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Fri, 24 Jul 2026 08:56:20 -0700
Message-ID: <20260724155621.95333-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724144143.94526-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Jul 2026 07:41:46 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 24 Jul 2026 14:01:34 +0800 dayou5941@163.com wrote:
> 
> > From: liyouhong <liyouhong@kylinos.cn>
> > 
> > damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> > and then call damon_migrate_pages().  When target_nid is invalid (including
> > the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
> > without putting the folios back to the LRU.
> > 
> > Callers then discard the list head while those folios remain isolated with
> > an extra reference taken by folio_isolate_lru().  The pages stay off the
> > LRU for as long as the mapping exists (anon active+inactive counts drop
> > while RSS does not), and the leftover references can pin the pages after
> > the mapping is gone.
> > 
> > Put the folios back on the invalid-nid path so ignored migration requests
> > still return them to the LRU.
> > 
> > Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")
> > Cc: <stable@vger.kernel.org>
> > Assisted-by: Cursor:grok-4.5
> > Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> > 
> > ---
> > v2:
> > - Drop the putback helper for easier stable backport
> > - Open-code putback only on the invalid-nid path
> > - Keep the original indentation and Cc stable@
> > - Add a separate cleanup as 2/2 (factor out damon_putback_folio_list)
> > 
> > ---
> >  mm/damon/ops-common.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index d1842e2b00ef..f5ded45fabd1 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> > @@ -394,8 +394,15 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
> >  		return nr_migrated;
> >  
> >  	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> > -			!node_state(target_nid, N_MEMORY))
> > +			!node_state(target_nid, N_MEMORY)) {
> > +		while (!list_empty(folio_list)) {
> > +			struct folio *folio = lru_to_folio(folio_list);
> > +
> > +			list_del(&folio->lru);
> > +			folio_putback_lru(folio);
> > +		}
> >  		return nr_migrated;
> > +	}
> 
> As I replied to the second patch, I'd suggest doing putback just before
> returning.  Then this invalid target_nid handling can 'goto' there.

I now think that is a bad idea.  Sorry for confusing.  That will make readers
assume damon_migrate_folio_list() doesn't putback folios.  Please resend this
as-is, but without the second patch.


Thanks,
SJ

[...]
