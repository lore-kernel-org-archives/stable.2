Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C43019C8;
	Sat,  3 Oct 2026 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791046411; cv=none; b=QYv/tVcBeHgtlLC9z719SvYJoiFv0r237OQf6eoNHUl0S/8Q7Gm6DhhDUklISe9avh4nwc22vpWy4CS22UAD9PozF+49pvAfNCMOoVEhjT0ysOk0Gw0cMZ/Dt+JdJErVwAB6a+k+bU73VRsVwx7wo25avEtltcIP1bkQ7ji4ZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791046411; c=relaxed/simple;
	bh=wabrq6iGjyiIkBvHbVUn/sX068T6DaC0Iy9UbHFYk4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ne/5itodRSkujBbQzZXatBlt5ZtHNSOdVuEqUeK7zTwozQbVZvxQYAiwoRLvf0/bYSBs0vBD6fSTQ5/bVW/KGaAI90I8ksOXdVghi4Bh3zjH4rW6Xv1EqRPA7NdFqA6Ho+uSwXCjjlnIOUBaFT5JiTXICjGKVIdAFgCZmUvIvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er7qI0jN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er7qI0jN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E591F0089B;
	Sat,  3 Oct 2026 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791046410;
	bh=lVjUfk0+G5eMRQR8Dnz9PhVxaAtrZ6x7rWGM6oOhuvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Er7qI0jN/wuvUETR8u7owrbQJx0KAKowg6nIAPpwkAmQtB2YIkK6bF+pYC/1N7Du2
	 c6mTAOFBPruMR5vsufAov2Hucia8RGgBYXBJ64jnuSM7/RtnqZR3aAlE8I0CbBh8gB
	 hPkrsUPv+h9qjnv04m5rsQi8cbIO89lSUkrsWRmL6KaqVpQFhUiWg2eGqldChnw8Zo
	 cs5YUoAi9iZbTThbpQoSUrUZxFYjuNkDAareEN47JlORSkHwoOLW5FfHfjhhrB8amN
	 /1zRJRvsvVBzub7T+qU+2VFtgJ/FjzvP8KsqjTP33vNybTHvhqzOktgy0mXJAsyomL
	 GtdIJ9aiPlv3w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: (sashiko review) [PATCH 6.18.y] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Sat,  3 Oct 2026 09:53:26 -0700
Message-ID: <20261003165326.32932-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261003163101.32739-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: This patch is wrong, please ignore.  I will send v2.

# sashiko review suggestions
#
# 1. Consider reducing recipients.  Maybe the author,
#    maintainers, reviewers, and mailing list of the
#    direct subsystem and parent susystem mailing lists
#    could be a starting point.
# 2. Add short summary of your opinion at the beginning.
#    For example:
#
#      TL;DR: sashiko found an issue.  I will respin.
#      TL;DR: sashiko found no issue on this patch.
#
# Please DON'T FORGET removing this comment block before
# sending this!

Somehow Sashiko stopped sending review as reply, so manually sharing it.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20261003163101.32739-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit 21f2d44a9b003b2e8d2502cbeb64ca223ff26e08
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
> 
> The commit replaces the safe region iterator damon_for_each_region_safe()
> with damon_for_each_region() in kdamond_apply_schemes(). It updates
> damos_skip_charged_region() to return true when a region is split, allowing
> the new fragment to be processed in the next iteration.
> 
> Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index c0dcb190b06e3..8217815de8982 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1770,9 +1772,7 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  				sz_to_skip = min_sz_region;
> >  			}
> >  			damon_split_region_at(t, r, sz_to_skip);
> > -			r = damon_next_region(r);
> > -			*rp = r;
> > -			skip = false;
> > +			return true;
> >  		}
> >  	}
> >  out:
> 
> [Severity: High]
> Does this early return bypass the cleanup block at the out label?
> 
> If damon_split_region_at() fails on the final region due to memory
> pressure, returning true here skips the out block that clears
> quota->charge_target_from.
> 
> Could this leaked cursor cause the scheme to permanently skip all
> subsequent memory targets in this and future evaluation intervals until
> an allocation succeeds?

Correct.  It is my mistake during porting.  I will fix this in the next
version.

> 
> [ ... ]
> 
> > @@ -2329,7 +2329,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
> >  
> >  	mutex_lock(&c->walk_control_lock);
> >  	damon_for_each_target(t, c) {
> > -		damon_for_each_region_safe(r, next_r, t)
> > +		damon_for_each_region(r, t)
> >  			damon_do_apply_schemes(c, t, r);
> >  	}
> >  
> 
> [Severity: High]
> Can changing this to a dynamic list iterator lead to regions being
> processed multiple times?
> 
> If a DAMON configuration has multiple schemes, and a later scheme splits
> a region, the newly inserted right-hand fragment will be visited by this
> outer loop in the next iteration.
> 
> Since damon_do_apply_schemes() evaluates all schemes sequentially,
> wouldn't schemes that already processed the original uncut region
> process the new fragment again, leading to duplicate memory operations
> and double-counting in quota tracking?

Good finding.  The bug exist in mainline too, and doesn't cause critical crash
or corruption.  Hence I don't think this is a blocker of this patch.  I will
separately work on it.  Please let me know if anyone has a different opinion.


> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20261003163101.32739-1-sj@kernel.org

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20261003163101.32739-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail


Thanks,
SJ
