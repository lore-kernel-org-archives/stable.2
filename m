Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC513281503;
	Sat,  5 Sep 2026 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788567943; cv=none; b=cDyBS6odztIEvGYXM2zPw7Odozge8jaIYn82lrevZkSIRbljQAc5npTrt4ufaYeqgoMcHsCcFYnDy5/4k5m4MLIzstZsrJsIi6huT7kKbn5sfXZbIxl1e+4xK1vKOhELUZ0ReTq0L1qFPrgNvyU/ZRXjv/UkD9FXPjP1p8s4JXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788567943; c=relaxed/simple;
	bh=LKYSMSVEk3LsRPDHUu1chd4Sld5ih0PA2qJ9/Q9dzlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNCB5j9DnJWCVplW628MngcGEvVBDUbpw/e7QQcVjlcsXOd5PBQIk8CZVOBC2mR5H1g8QWQmf0f8nZl2Rryioms4o2qkTin+PBccb94PYtN2523Ylr9r5+ZpfHfYv7K2RAb+pMYiLVhQeJLDTVPcxkWAxnoETlaJj0GrTOXjuuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GISoGbW9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GISoGbW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1029F1F00A3D;
	Sat,  5 Sep 2026 00:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788567942;
	bh=LQYnje899FKvd4OwbogGnsKo81eCP3MOvqztWDAn5BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GISoGbW9NnWYZnRkQqafWHNK1B8tC2pPYpwMvEoaRsnLNrbDyBTFxMHqhpasMVYUL
	 dxgk7l2yUNPr8waN3UmVf77YS9sthi/GR7930So69JfvSCXHT3RftGgtG3E8BzOY2w
	 VB/Q1Srmigvct/Bi5qSBecTmhgXsqSHtJ+Kzi4eyY4dMk2m9etNt++r7CuzQQ9EM6W
	 OqstIa8Dpi6y6VIf7EkN7Sc++ykIHjXxGiPDrEhjkfiWJK7pAl4F1TSIFS2X8vEddx
	 Ty3b3PBiGh+RePCBwwNDSiMRITtEKzHJ4bdLeC55/5R7MPPPM2lsridRMsIleB8q1g
	 8Vbgr1ksAAzLA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Fri,  4 Sep 2026 17:25:34 -0700
Message-ID: <20260905002534.67885-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904153637.9670-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  4 Sep 2026 23:35:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri, 04 Sep 2026 07:05:35 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Fri,  4 Sep 2026 16:07:41 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > First, I'd like to clarify that this isn't a problem encountered by a
> > > real user, it's just a scenario I came up with.
> > 
> > Thank you for clarifying this.
> > 
> > > 
> > > 1. Users sample qt_exceeds periodically (e.g., every 10 minutes).
> > 
> > What's the purpose of this sampling?
> > 
> > > 
> > > 2. Within this 10 minute sampling interval, the counter aggregates both
> > >    the real quota exhaustions and the increments caused by esz==0.
> > > 
> > > 3. When users notice a high qt_exceeds value, they eventually realize
> > >    (perhaps by reading the code or documentation) that it includes the
> > >    counts from the esz==0 state.
> > > 
> > > 4. To get the actual quota exhaustion statistics, the user is now forced
> > >    to perform additional testing and implement external filtering to
> > >    separate the esz==0 increments from the real exceeds.
> > > 
> > > Even if we explicitly state in the documentation that qt_exceeds
> > > includes the esz==0 counts, it still burdens the user.  The user still
> > > has to figure out how to filter out the esz==0 increments externally to
> > > get the signal they actually care about.
> > 
> > Users set the temporal goal.  They can know when the goal is achieved since
> > most of the goal metrics are already exposed to user space.  Users can also
> > show the current effective quotas.  I agree that can be cumbersome, but how
> > problematic it is?  Also, as I asked above, why they want to do this after all?
> > 
> > > 
> > > Honestly, I struggle to imagine any valid use case where a user would
> > > actually rely on the qt_exceeds increments caused by esz==0 to make
> > > decisions.
> > > 
> > > If the only purpose of qt_exceeds is to let users "easily notice" if the
> > > quota is too small,
> > 
> > I agree it could be a signal to show if the quota is too small.  But the real
> > purpose of qt_exceeds is, in my opinion, letting users understand how DAMOS is
> > internally working now.  After all, how much quota means if it is too small or
> > not?  That all depends on the real use case and complicated things including
> > their SLO etc.
> 
> Thank you for your clarify.
> 
> > 
> > If documentation is saying the purpose of qt_exceeds is to show if the quota is
> > too small, that is what need to be updated.
> 
> I completely agree your perspective.
> 
> This is the current documentation of qt_exceeds:
> 
>     - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
> 
> Although it state the purpose of this statistic, I think adding a
> note to clarify that this stat also increase when the quota is zero (but
> not unlimited) would be helpful for users.  For example:
> 
>     Usually, a quota of zero means the DAMOS scheme has an unlimited
>     quota, so qt_exceeds will not increase.  However, if user sets a
>     temporal quota goal, the quota is set to zero once the goal is
>     [over]-achieved.  In this situation, qt_exceeds will still increase.
> 
> I can prepare a formal documentation patch based on this if you agree.

Yes, I believe this is the right direction.  We can discuss further details on
the patch.  Looking forward to the patch.

> 
> [...]
> 
> That said, it's not important for me to add explanations to the
> document, but may I know why commit [2] changed the behavior which
> introduced by commit [1]?
> 
> Commit [1] Behavior:
> 
>     if (quota->esz && quota->changed_sz >= quota->esz)
>         s->stat.qt_exceeds++;
> 
> Commit [2] Behavior:
> 
>     if (damos_quota_is_full(quota, c->min_region_sz))
>         s->stat.qt_exceeds++;
> 
> Before commit [2], qt_exceeds will only increase when quota->esz is not
> zero, but after commit [2], qt_exceeds also increase even when
> quota->esz is zero.  I'd love to understand the rationale behind this
> change to better grasp the design evolution.
> 
> [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
>     (Fri Jan 14 14:10:20 2022 -0800)
> [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
>     (Mon Apr 27 18:33:50 2026 -0700)

Seems commit c7ec7d5f6b3d1 didn't make a behavior change that you are
describing.

'''
$ git show c7ec7d5f6b3d1
[...]
@@ -2601,8 +2613,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
        if (!time_in_range_open(jiffies, quota->charged_from,
                                quota->charged_from +
                                msecs_to_jiffies(quota->reset_interval))) {
-               if (damos_quota_is_set(quota) &&
-                               quota->charged_sz >= quota->esz)
+               if (damos_quota_is_full(quota, c->min_region_sz))
                        s->stat.qt_exceeds++;
                quota->total_charged_sz += quota->charged_sz;
                quota->charged_from = jiffies;
'''

And I don't think there was a behavior change.  Hopefully commit 54419bbd0ee3
("mm/damon/core: allow quota goals set zero effective size quota") will give
you some clues.


Thanks,
SJ

[...]
