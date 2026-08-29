Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A033BF682;
	Sat, 29 Aug 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020123; cv=none; b=TPLOtDw4pSm5zcCN7nn0aqqsywJODO+nq9cinBnIVUbtSdshhfdpb+zChpczsUnrAzL8tmwjCdGkX7mlCpodwXb4ZxquVHx5fIUsXz9sc6ntcQlSAS2sAc/8/kaT1VP8jjXQheibiTPPchHFHcrJ258IBV7k3RWTyn+tihHsovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020123; c=relaxed/simple;
	bh=3scNfc+eBX0pgTp4OdIPYF8CHtNuGXmO8m+bRduI/Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLzSYveJ3gay1q1PIXNrCcEsKyaRuY1X05BGPyGR7wimz/mRruFPcMWyuXivCjqG74gW353uqBb82tlflmoqnEj/RAR3HTV2ZH15YxcEDVRJSo58Wbm5VeVnHoJtn0vWCU83nSreC0lgRIjDx390iy31mqnvbocJDo6sDsvHwk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaLTpNLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaLTpNLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2737B1F00A3D;
	Sat, 29 Aug 2026 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788020116;
	bh=wZr1a/F+Sc8g5BvxIyPT8YsObTtkfsEdSZ4r6duieVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NaLTpNLqvu1UCGFvLYNYwktZI2PcU10lT9/bP/yj93FZ2wVvVLLfYeIbmwmeAGGzV
	 LzKmgSmNvxujHh7QJk9YlyN5PqI0U+zyl1SSVrEgledcqxAIO5lQEyZyG+Oq8c3Ojb
	 c26pIbWHR/prgcEsbMsC1ypIPQzaVCV7hsJb3qVpXaVYoWg1zjXa3hXCq3753Anoga
	 EyYQaCI9HWopdTZzkGF4pJrKfGMeVhOPFXnaIYLm/mSELk57B3Hh0D3ekS5nYGUJr1
	 PhZAHBJvQjUFB1RrwpEYUqj3JZPZ200SYjSp0Zhkg9H4adrNxvENn5eabw7I9Gx+Ct
	 FoWM8HLvrGphQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Sat, 29 Aug 2026 09:15:08 -0700
Message-ID: <20260829161509.77406-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260829083744.73299-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Aug 2026 16:34:26 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri, 28 Aug 2026 11:29:09 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Fri, 28 Aug 2026 16:47:37 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Once quota set, the charge_{target,addr}_from unconditionally skips and
> > > resets at the last region of the tracked target, so the last region can
> > > be skipped even when it has not been processed.
> > > 
> > > Example:
> > > 
> > >     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> > >     2. Quota is configured to process only 50 bytes per window.
> > >     3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved
> > >        at (Target, 50).
> > 
> > Cursor means charge_{target,addr}_from, right?  Let's explain that, or just
> > keep using the terms (charge_{target,addr}_from).
> 
> Yes, thank you for pointing that out!  I changed cursor to
> charge_{target,addr}_from now.
> 
> > 
> > >     4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is
> > >        full. Cursor is saved at (Target, 100), which is exactly the
> > >        start of R2.
> > >     5. Window 3: The loop reaches R2.  Because R2 is
> > >        damon_last_region(t), the old code unconditionally returns true,
> > >        skipping R2 entirely and resetting the cursor.
> > > 
> > >     Result: R2 is permanently skipped even though it has never been
> > >     processed.
> > 
> > Let's make example simpler by setting R1 (0-50 bytes) and R2 (50-100 bytes) or
> > quota size 100 bytes per window.
> 
> This is the updated example:
> 
> '''
> Example:
> 
>     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
>     2. Quota is configured to process only 100 bytes per window.
>     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
>         addr}_from is saved at (Target, 100).
>     4. Window 2: The loop reaches R2.  Because R2 is
>         damon_last_region(t), the old code unconditionally returns true,
>         skipping R2 entirely and resetting the charge_{target,addr}_from.
> 
>     Result: R2 is permanently skipped even though it has never been
>     processed.
> '''
> 
> > 
> > Also, it continues being skipped only in a corner case that the region
> > addresses and the access patterns are kept.  So the user impact is mild.  Let's
> > clarify that to not make users unnecessarily afraid.
> 
> I will add this clarification in the next revision:
> 
> '''
> However, it is important to note that this is a very minor issue.  This
> is because it is triggered only when the previous window saved/kept
> charge_{target,addr}_from, and in the next window, all regions except
> the last region were skipped by damos_skip_charged_region().
> '''
> 
> > 
> > > 
> > > Fix this by only skipping the last region after it has been applied.
> > > 
> > > Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
> > > Cc: <stable@vger.kernel.org> # v5.16.x
> > > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > > ---
> > > 
> > > Changes from RFC v1:
> > > - Minimal fix, only fixes the issue where the last-region is skipped.
> > > - Add an example to the commit message to demonstrate that this error
> > >   occurs very rarely.
> > > - RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com
> > > 
> > > ---
> > >  mm/damon/core.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index 644daf5a1656..21dc6b086c42 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
> > >  	if (quota->charge_target_from) {
> > >  		if (t != quota->charge_target_from)
> > >  			return true;
> > > -		if (r == damon_last_region(t)) {
> > > -			quota->charge_target_from = NULL;
> > > -			quota->charge_addr_from = 0;
> > > -			return true;
> > > -		}
> > >  		if (quota->charge_addr_from &&
> > > -				r->ar.end <= quota->charge_addr_from)
> > > +				r->ar.end <= quota->charge_addr_from) {
> > > +			if (r->ar.end == quota->charge_addr_from ||
> > > +					damon_is_last_region(r, t)) {
> > > +				quota->charge_target_from = NULL;
> > > +				quota->charge_addr_from = 0;
> > > +			}
> > >  			return true;
> > > +		}
> > >  
> > >  		if (quota->charge_addr_from && r->ar.start <
> > >  				quota->charge_addr_from) {
> > 
> > As Sashiko pointed out, this doesn't work if the the last region's start
> > address is smaller than charge_addr_from and the end address is larger than
> > charge_addr_from, but the size to skip (charge_addr_from - r->ar.start) is
> > smaller than min_region_sz.
> > 
> > As you replied to Sashiko, let's do the last region handling in every case.
> > While doing that, let's do the charge_{target,addr}_from reset in only one
> > place, like below.
> > 
> > '''
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2688,36 +2688,40 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  {
> >         struct damos_quota *quota = &s->quota;
> >         unsigned long sz_to_skip;
> > +       bool skip = false;
> > 
> >         /* Skip previously charged regions */
> >         if (quota->charge_target_from) {
> >                 if (t != quota->charge_target_from)
> >                         return true;
> > -               if (r == damon_last_region(t)) {
> > -                       quota->charge_target_from = NULL;
> > -                       quota->charge_addr_from = 0;
> > -                       return true;
> > -               }
> >                 if (quota->charge_addr_from &&
> > -                               r->ar.end <= quota->charge_addr_from)
> > -                       return true;
> > +                               r->ar.end <= quota->charge_addr_from) {
> > +                       skip = true;
> > +                       goto out;
> > +               }
> > 
> >                 if (quota->charge_addr_from && r->ar.start <
> >                                 quota->charge_addr_from) {
> >                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
> >                                         r->ar.start, min_region_sz);
> >                         if (!sz_to_skip) {
> > -                               if (damon_sz_region(r) <= min_region_sz)
> > -                                       return true;
> > +                               if (damon_sz_region(r) <= min_region_sz) {
> > +                                       skip = true;
> > +                                       goto out;
> > +                               }
> >                                 sz_to_skip = min_region_sz;
> >                         }
> >                         damon_split_region_at(t, r, sz_to_skip);
> > -                       return true;
> > +                       skip = true;
> >                 }
> > +       }
> > +out:
> > +       if (r == damon_last_region(t)) {
> >                 quota->charge_target_from = NULL;
> >                 quota->charge_addr_from = 0;
> > +               return true;
> >         }
> > -       return false;
> > +       return skip;
> >  }
> > 
> >  static void damos_update_stat(struct damos *s,
> > '''
> 
> I noticed a potential subtle issue in the suggested fix above:
> 
> '''
> +out:
> +       if (r == damon_last_region(t)) {
>                 quota->charge_target_from = NULL;
>                 quota->charge_addr_from = 0;
> +               return true;
>         }
> '''
> 
> If 'skip' is false (region should be processed), but it happens to be
> the last region, the condition 'if (r == damon_last_region(t))' would
> still be met.  This would cause it to reset the state and 'return true'
> (skip it), which inadvertently re-introduces the original bug we are
> trying to fix.

Ah, good catch.  The 'return true' is a wrong copy-pasta.  Let's drop the line.

> 
> To ensure the reset logic is centralized and correct, I refined the fix
> as follows.  The comment is intended to help you and other reviewers
> quickly understand the rationale behind the compound condition.  I will
> remove this comment in the next revision.
> 
> '''
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 644daf5a1656..82c5aed8a417 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2342,36 +2342,48 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  {
>         struct damos_quota *quota = &s->quota;
>         unsigned long sz_to_skip;
> +       bool skip = false;
>  
>         /* Skip previously charged regions */
>         if (quota->charge_target_from) {
>                 if (t != quota->charge_target_from)
>                         return true;
> -               if (r == damon_last_region(t)) {
> -                       quota->charge_target_from = NULL;
> -                       quota->charge_addr_from = 0;
> -                       return true;
> -               }
>                 if (quota->charge_addr_from &&
> -                               r->ar.end <= quota->charge_addr_from)
> -                       return true;
> +                               r->ar.end <= quota->charge_addr_from) {
> +                       skip = true;
> +                       goto out;
> +               }
>  
>                 if (quota->charge_addr_from && r->ar.start <
>                                 quota->charge_addr_from) {
>                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
>                                         r->ar.start, min_region_sz);
>                         if (!sz_to_skip) {
> -                               if (damon_sz_region(r) <= min_region_sz)
> -                                       return true;
> +                               if (damon_sz_region(r) <= min_region_sz) {
> +                                       skip = true;
> +                                       goto out;
> +                               }
>                                 sz_to_skip = min_region_sz;
>                         }
>                         damon_split_region_at(t, r, sz_to_skip);
> -                       return true;
> +                       skip = true;
>                 }
> +       }
> +out:
> +       /*
> +        * The last region may remain unapplied for extended period due to
> +        * various regions (e.g., it is invalid or has been filtered out),
> +        * preventing other regions from being applied (those preceding the last
> +        * region and all regions with different targets).  Therefore, when
> +        * encountering a region that needs to be processed, reset
> +        * charge_{target,addr}_from.  If necessary, this parameters will be set
> +        * to the correct value in damos_do_apply() due to quota is full.
> +        */

Looks too verbose to me.  Let's drop this.

> +       if ((r == damon_last_region(t) && skip) || !skip) {

Why this becomes this complex?  We should reset charge_{target,addr}_from if it
is the last region, always.  Am I missing something?

>                 quota->charge_target_from = NULL;
>                 quota->charge_addr_from = 0;
>         }
> -       return false;
> +       return skip;
>  }
>  
>  static void damos_update_stat(struct damos *s,
> '''

> 
> > 
> > Btw, I think damos_skip_charged_region() may deserve a kunit test.
> 
> I agree that a kunit test would be valuable.  While I am still getting
> familiar with the kunit and it might take me a little time, I plan to
> work on it.

Nice.  Looking forward to your patch.

> 
> Should the tests include these scenarios?

Let's not add new topics.  We can discuss this on your kunit patch.  Please
ensure it covers at least the corner case this patch is trying to fix.


Thanks,
SJ

[...]
