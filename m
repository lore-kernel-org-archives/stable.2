Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08773233929;
	Thu,  3 Sep 2026 00:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395640; cv=none; b=ijdhtJt0kInivt8TL+mC3Km74S8UVMFaQK3VRzE+CY/h7h5qdD8adVzB/TunLiPbEYh+ZAOcv9S9Zyc49vhSuxylGNgmI8P5KdSYixEd/N3OGlTKFOMJk0gi6F9EiG0UWjCmXugi+x7iTtNICxK1aZW4CK5oue7IWOoTTXxXCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395640; c=relaxed/simple;
	bh=raWI9I2fgeCUXuaU5qhGWkZMcFFcl1s1vlIfOiOyl2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX6P+wUTAZJQPCdt+U2ghk6fXz+GnON4QYgkSTUWpUHTxhi00pVHj9Sz6LlyMdS3uYlUANpuWM168BwktsDkSoclNUBMUAI0lvlhSJdBrCttNmZ2GPDjCkhUWnXzDdPb5JstwJno6wbHOcf3hGfDz2SxMQRIOSrnNu9RpdWUhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaZJQ5xz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaZJQ5xz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4451F000E9;
	Thu,  3 Sep 2026 00:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788395638;
	bh=jj8sMkrg0TmM2tvCwEudWj/A8COjYfR/MqX6qZVQG9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CaZJQ5xz8brzL/eyCE4GAKhBZ5wSIUamTyyw8qMXmFUmJhHs+eEK6HGU6isekeDQz
	 IqzxrYkyu66zQaOyxl465+7WD2YFmzh4sx6/TAIM04CNdKj2QsRC9kzo4NAMl9xtEg
	 BlRy9bPuuhy/zICGs+628Gg2xF/7ca4pUi/z20+DR9z1xAsKQ5JFtHcFkjeu4ZA0Kh
	 6Aupy6Oc01aIOQr3o3+RDEIIhPFFFLXO99eEQCR5bnnhUNUTXrHWAp+m9zs51bHTKJ
	 M6bM4tgbLmiHIoqPraQn4B/Ce+KY4XLcnAidkzh2pOnGXOBIpvzNHb9FTi4HCQAjqm
	 MDBXJvEOyydRg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 17:33:50 -0700
Message-ID: <20260903003351.91088-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902223203.14871-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  3 Sep 2026 06:31:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Wed, 02 Sep 2026 07:48:03 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed,  2 Sep 2026 22:22:31 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > On Wed, 02 Sep 2026 07:10:00 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > On Wed,  2 Sep 2026 16:44:45 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > 
> > > > > When setting goal_tuner to 'temporal', if the goal is achieved,
> > > > > quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
> > > > > will always return true, even if no regions have been tried to apply at
> > > > > all.  This causes qt_exceeds to increase unexpectedly.
> > > > 
> > > > To me, this looks logically correct.  Could this cause any user issue?
> > > 
> > > Yes, I think this might cause unnecessary confusion for users,
> > 
> > If it is _might_ kind thing, please ask questions first, or add RFC tag at
> > least.
> > 
> > > at least
> > > it did for me.
> > 
> > If it confused you, definitely we need to fix it.  But if it is just confusing,
> > let's try to clarify by adding documentation, rather than changing existing
> > behaviors.
> 
> I agree that we should avoid unnecessary code changes if the issue is
> merely a matter of confusion.
> 
> However, I believe a code change is necessary in this specific case,
> rather than just adding documentation, for the following reasons:
> 
> First, this distorts the semantics of qt_exceeds.  It is a statistic
> meant to track actual quota full/overflows.  Incrementing qt_exceeds
> when the quota is completely unused (because the temporal goal is
> already met) misleads users and could break user-space monitoring tools
> or scripts that rely on this metric's accuracy.

As I mentioned in the previous comment, this doesn't look wrong to me.  I
understand some people could think differently.  That's why I think this is a
matter of clarification, not a bug to fix.

> 
> Second, considering its original behavior when it was first introduced,
> the recent changes [2] have inadvertently altered this behavior.
> 
> When qt_exceeds was first introduced [1], the conditional check was:
> 
>     if (quota->esz && quota->charged_sz >= quota->esz)
>             s->stat.qt_exceeds++;
> 
> Later, to handle cases where 'remaining quota < min_region_sz',
> damos_quota_is_full() was added [2].  When this function was added,
> quota->esz was replaced with !damos_quota_is_set(quota).

I don't find what's wrong with this.

> 
>     static bool damos_quota_is_full(struct damos_quota *quota,
>             unsigned long min_region_sz)
>     {
>         if (!damos_quota_is_set(quota))
>             return false;
>         if (quota->charged_sz >= quota->esz)
>             return true;
>         /*
>          * DAMOS action is applied per region, so <min_region_sz remaining
>          * quota means the quota is effectively full.
>          */
>         return quota->esz - quota->charged_sz < min_region_sz;
>     }
> 
> With the introduction of DAMOS_QUOTA_GOAL_TUNER_TEMPORAL [3], quota->
> esz == 0 carries two meanings: "unlimited quota" and "should not
> be applied".

I don't find how you think this way.

> This overlap causes the damos_quota_is_full() check to
> return true incorrectly in the temporal goal scenario, leading to the
> false positive in the statistic.

That still sounds like just a matter of different interpretations.  Let me know
if I'm missing something.

> 
> > 
> > I feel like we also found similar case that people send patches to change some
> > behaviors that confusing them, but not really problematic.  That sometimes
> > waste unnecessary time for understanding the intention of the patch.  Please
> > feel free to ask question first, if you found some confusing behaviors and
> > don't know why it behaves in the way or if it is a real problem.
> 
> I will ask questions on the first in the future when I encounter
> ambiguous behaviors, to ensure we are aligned on whether it's a real
> problem before drafting a patch.

Thanks.

> 
> [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
>     (Fri Jan 14 14:10:202022 -0800)
> [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
>     (Mon Apr 27 18:33:50 2026 -0700)
> [3] af738a6a00c1f ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
>     (Mon Mar 9 18:05:19 2026 -0700)
> 
> Best regards,
> Rui Yan


Thanks,
SJ
