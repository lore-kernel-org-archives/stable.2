Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D882E7F2C;
	Thu, 10 Sep 2026 00:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000668; cv=none; b=N2lytWDzbS99YIrihR11dJBPqkABfPFuWfZJ17IDzCPaeArNGIDKcd3f0PvqeLl90qzOLlXGhqFS8B37/yL8j0hC3/P8XZaDcxbib88bvwnIMmfozajzVgw7zJT2+jw6YrfRlw3Dzx4n26OPMEFCUstxGezrynyCVwAYbeOk7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000668; c=relaxed/simple;
	bh=yHqi1edR8aA7bDb+xd1ZhznEKoX7szdGT34u1U0k2ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yqhp59Qy7uYE1CwiiktbGxEWhpnfsLvXunWjNMySRWUO2P7yA35zNXh6lw1csU6eyZZD1ufWSF5l29ebJtz6SYNGc4SKeU8bOqB9vnMEHw27tOgE7dWIbTJNpSZXKBNPGp0NzKiihCGV9wrlm3HK4j1k0/DqeLjJykSqiit/oRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3bhKCHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3bhKCHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B841F000FF;
	Thu, 10 Sep 2026 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789000667;
	bh=AuJvlKHeSaZqPSLspcfsddW5faqpBg2eD22pMELDkHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o3bhKCHBAiyUYUFvRM+tqDK5hjsSy6+iL7l9CQmWK8ztm0ea0l33yqeeET74fap1a
	 wLKIF/owFeOKH4rp70FbDr8s5uJmnhKvcwNds+bmyyhugh+ay2dHHT3H1NcnG1Bg93
	 9vFMm6Gv8XZdu4Jzr3l92rxjCmi/j1C2bUeZ4JbKyRoK6KclhpBlT5RISrtXeNNK7T
	 /cl95VaJ20kaccMKwslAz/hZoh90E+DPg1mRliueuDGV0GsJ0hl4UaafHPA79G+dT0
	 qLm9s+7kPySbcQEnHF63gYbEd7RI31cvTNoN6iqNgj58CqO1gxoP+/FRkOJGbz+pA/
	 tJXOCy6OMVG3A==
From: SJ Park <sj@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Wed,  9 Sep 2026 17:37:38 -0700
Message-ID: <20260910003739.113303-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090910-flypaper-elixir-5106@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 15:03:16 +0200 Greg KH <greg@kroah.com> wrote:

> On Tue, Sep 08, 2026 at 09:15:02PM -0700, SJ Park wrote:
> > Patch series "mm/damon: unurgent fixes for infinite loop, NULL de-ref and
> > races", v1.1.
> > 
> > Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> > dereference and monitoring results degradation.  The first two sounds
> > scary but the infinite loop happens only under unreasonable user setup.
> > The NULL dereference is only in a unit test.  Monitoring results
> > degradation is trivial since it is only best-effort, and those happens
> > from only unlikely races.  Still those are bugs that better to fix if
> > possible.  Fix those.
> > 
> > This patch (of 6):
> > 
> > Due to online parameter update like events, the number of DAMON regions
> > could be higher than the user-set upper limit.  kdamond_merge_regions()
> > repeats merge regions until the number meets the limit, while doubling the
> > merge threshold up to the theoretical maximum threshold.  It is tried only
> > up to the theoretical maximum threshold because even the aggressive
> > merging can fail from reducing the number of regions under the
> > user-defined upper limit.  For example, there could be many user-defined
> > non-contiguous regions that cannot be merged.
> > 
> > The threshold based loop break condition is evaluated by comparing the
> > threshold for the next merging try against the theoretical maximum
> > threshold.  If max_thres is larger than UINT_MAX / 2, doubling the
> > threshold could make it overflow, and bypass the loop break condition.  In
> > the case, if the number of regions cannot be reduced under the upper limit
> > like explained above, the loop will run infinitely.
> > 
> > Prevent the case by doing the break condition check before doubling the
> > threshold.  Also, prevent the threshold exceeding the maximum threshold,
> > as it could overflow and apply the wrong merge threshold.
> > 
> > This issue is unlikely to occur in real world, since having the max_thres
> > higher than UINT_MAX / 2 require unrealistically large aggregation
> > intervals compared to the sampling interval.  Also, it requires an
> > unrealistically large number of uncontiguous regions setup.  Nonetheless,
> > the consequence is bad and the fix is simple.
> > 
> > The issue was discovered [1] by Sashiko.
> > 
> > Link: https://lore.kernel.org/20260715031002.108504-1-sj@kernel.org
> > Link: https://lore.kernel.org/20260715031002.108504-2-sj@kernel.org
> > Link: https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org [1]
> > Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
> > Signed-off-by: SJ Park <sj@kernel.org>
> > Cc: <stable@vger.kernel.org> # 6.10.x
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit 123e4619ab6c8ab1c4cb1d7a58311a2af13929cd)
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  mm/damon/core.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 70ac1f08753d1..08e527efd6883 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2411,15 +2411,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
> >  
> >  	max_thres = c->attrs.aggr_interval /
> >  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
> > -	do {
> > +	while (true) {
> >  		nr_regions = 0;
> >  		damon_for_each_target(t, c) {
> >  			damon_merge_regions_of(t, threshold, sz_limit);
> >  			nr_regions += damon_nr_regions(t);
> >  		}
> > -		threshold = max(1, threshold * 2);
> > -	} while (nr_regions > c->attrs.max_nr_regions &&
> > -			threshold / 2 < max_thres);
> > +		if (nr_regions <= c->attrs.max_nr_regions ||
> > +				max_thres <= threshold)
> > +			break;
> > +		if (threshold < max_thres / 2)
> > +			threshold = max(1, threshold * 2);
> > +		else
> > +			threshold = max_thres;
> > +	}
> >  }
> >  
> >  /*
> > -- 
> > 2.47.3
> > 
> > 
> 
> Does not apply :(

Seems another patch in 6.18.51..6.18.51-rc1 is causing the conflict.  I just
confirmed the original commit can clealy cherry-picked on 6.18.51-rc1.  Could
you please add that?  Let me know if there is something that I can help :)


Thanks,
SJ

[...]
