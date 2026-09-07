Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816203AE191;
	Mon,  7 Sep 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798833; cv=none; b=sdt5PIlo/tM39oyP3G0AtIDyZ7eO/UXVd6NEKtmU/br6BfTXjYxkiwUh0tk6UHbaikuqdLlw3mRpdvVVvGUCK9miJqBjeZBa0C0cNjdZrqPTQyvAP86W/h6gHCu/eNWCyq05tjGS3cQtwlF8Dj4pTpR9x0MyYJH3aISjTHk+gr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798833; c=relaxed/simple;
	bh=SXQS3GLuO0AH4tyO9ImfLK+DZ0Ip6pIdRyKdrgzqYyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGNS0YhIPK6t0RBFbQJg5b3wCdPjSjB5X1NIAhoEifdiMwuEnwihkqCYd6ycEcdSt+bwXOmVrExG7ciqjJExarWMAf79zciHAcfxXVBfk7VSkj0tBZXn/3kaIcE2a0CyNTIc8sIG7DFlM81+tdzEMoveH9uT4HWtqfWDvmA0Li8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5wYc8By; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5wYc8By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCF51F00A3A;
	Mon,  7 Sep 2026 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788798832;
	bh=cAuFkVwr+DWI2V4wrox0xZCJB/0hu3m74aTo0dee8I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5wYc8BysTLjWIl1VZMisAs6qq70fofF+8/cz4NAB0r9TF8ieAzpbP2DsOXRCdYPs
	 h/OAHgy169+b1CuJ8FoTJPYCFcuobmAA83xbEl5HsAtmh2DgNO1LaFmCflDfzD30hv
	 ZBKpii018dEnIpP6ts7o8tlPIs8xXjKxmZhUfRujTGOO3v7A6fIZb7xR/H1eU5wzhj
	 54x6CLqyDPNStPOVx9pj7VdSDCz5FeIJZA7TRfvq/M4GnVeN0mCsVuk4BehIK+nDPQ
	 v7aYdvHltnPnINFV6eQ9PkxGIW95GK6TA5BTBB+9fxbWdMc/r5ZQuG1CKQhZI1Qn2Y
	 /cpt8yAFkCgUA==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Mon,  7 Sep 2026 09:33:44 -0700
Message-ID: <20260907163344.87006-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906222633.4227-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 06:25:28 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat, 05 Sep 2026 09:12:33 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Sat,  5 Sep 2026 18:36:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > On Fri, 04 Sep 2026 17:25:34 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > On Fri,  4 Sep 2026 23:35:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > 
> > > > > That said, it's not important for me to add explanations to the
> > > > > document, but may I know why commit [2] changed the behavior which
> > > > > introduced by commit [1]?
> > > > > 
> > > > > Commit [1] Behavior:
> > > > > 
> > > > >     if (quota->esz && quota->changed_sz >= quota->esz)
> > > > >         s->stat.qt_exceeds++;
> > > > > 
> > > > > Commit [2] Behavior:
> > > > > 
> > > > >     if (damos_quota_is_full(quota, c->min_region_sz))
> > > > >         s->stat.qt_exceeds++;
> > > > > 
> > > > > Before commit [2], qt_exceeds will only increase when quota->esz is not
> > > > > zero, but after commit [2], qt_exceeds also increase even when
> > > > > quota->esz is zero.  I'd love to understand the rationale behind this
> > > > > change to better grasp the design evolution.
> > > > > 
> > > > > [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
> > > > >     (Fri Jan 14 14:10:20 2022 -0800)
> > > > > [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> > > > >     (Mon Apr 27 18:33:50 2026 -0700)
> > > > 
> > > > Seems commit c7ec7d5f6b3d1 didn't make a behavior change that you are
> > > > describing.
> > > 
> > > I actually wanted to point out the behavior difference between commit [1]
> > > and [2], but I've understood and agreed with your point.
> > > 
> > > > 
> > > > '''
> > > > $ git show c7ec7d5f6b3d1
> > > > [...]
> > > > @@ -2601,8 +2613,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> > > >         if (!time_in_range_open(jiffies, quota->charged_from,
> > > >                                 quota->charged_from +
> > > >                                 msecs_to_jiffies(quota->reset_interval))) {
> > > > -               if (damos_quota_is_set(quota) &&
> > > > -                               quota->charged_sz >= quota->esz)
> > > > +               if (damos_quota_is_full(quota, c->min_region_sz))
> > > >                         s->stat.qt_exceeds++;
> > > >                 quota->total_charged_sz += quota->charged_sz;
> > > >                 quota->charged_from = jiffies;
> > > > '''
> > > > 
> > > > And I don't think there was a behavior change.  Hopefully commit 54419bbd0ee3
> > > > ("mm/damon/core: allow quota goals set zero effective size quota") will give
> > > > you some clues.
> > > 
> > > Thank you very much for your clarifying :>
> > > 
> > > Now I completely understand why there is different behavior
> > 
> > I told you I don't think there was a behavior change.  I still think so.
> > 
> > > between
> > > commit [1] and [2].  Because in commit [1], esz==0 only means quota is
> > > unlimited.
> > 
> > No.  Commit 54419bbd0ee3 says "DAMON core assumes zero effective quota means
> > the user has set no quota."
> > 
> > 
> > > After commit 54419bbd0ee3, esz==0 also can means do not have
> > > quota at all.
> > 
> > That's what the commit is describing the before-commit status...
> > 
> > > But the qt_exceeds should just not increase when quota is
> > > unlimited, that's why the current implementation is completely correct.
> > 
> > There is no unlimited quota.  Hence I don't understand what you are saying
> > here.  Please carefully read the commit message again.
> 
> Thank you for the detailed explanation, and sorry for my confusing
> wording.  Let me confirm my corrected understanding:
> 
> Before commit 54419bbd0ee3, esz == 0 appeared only when the quota was
> unset, i.e., the user has set no quota.  DAMON core therefore assumed
> zero effective quota means the user has set no quota, and the code
> checked quota->esz to tell whether a quota is set.  Commit 54419bbd0ee3
> decoupled "quota is set" from "esz != 0" by introducing
> damos_quota_is_set().  After that, the temporal goal tuner
> (af738a6a00c1f) made it possible for a set quota to have esz == 0 as
> well, for example once its goal is over-achieved.  In that case the
> scheme is intentionally deactivated,

From user's perspective, it may look like it is deactivated.  Technically
speaking, however, it is not deactivated.  Everything keeps working in the
normal way.  Just one difference is that now it has very small (zero) quota.

> and counting qt_exceeds is intended,
> not a bug.
> 
> Commit c7ec7d5f6b3d1 did not change the behavior I asked about; it only
> refactored the check into damos_quota_is_full().

Seems you fully understand that now :)

> 
> I will send a documentation patch in the near future.  Thank you again
> for your patience.

Thank you for your patience, too.  Looking forward to the patch!


Thanks,
SJ

[...]
