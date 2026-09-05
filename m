Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8978E38B7D8;
	Sat,  5 Sep 2026 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788624762; cv=none; b=noUhfn7SPh+9BRDGc1kyqfv9RBBN/rBQreeLF8yUGJEVyRIyg8BfA/Ffbppyb7FlGxbSQv13Zun/whe8Q4VOJ0eRFQfy+IxnZNb/bImRdStrfYp2Io6rnBMiyOgUYPOO0688wPqy1QSI9dRk1VoLY40E9qHLCNRa+ely3n8q84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788624762; c=relaxed/simple;
	bh=Dksa2TzLYi7otX+Dv8BbWJbWWet4j77JTnMB5+xrZ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yec0AA04wI8HRxMGhlIxEgYtZIDh/PUMQOglXarIaZ9QnYYW0TeFluptyx6uoONT3Se/AKs/iEh1rvwy5y7ulXyDY0Xo1L7f8WNsRo889rz71pVUuxwEK3jdDEBOY4Jftt1QnK6TVuSEYbd+5KmOkNXOjf6+1FAMcWvSrPubytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDyANSQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDyANSQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75741F00A3A;
	Sat,  5 Sep 2026 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788624761;
	bh=bXbXXrcCdtBT1TjZ6Vc2kGjnHoJ85kk8eETl4UzoqhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lDyANSQxzIBxflYlMpKX1pe0/t2OpjXWlI1ISNGTEY1ORvoezMa0w7l4YFUf6d10E
	 8oAEH/Z+bwG//ucJYE2fZ+8s8RnJkficEELpCf8BM1lli8Rnq5+h9iogHAHo1F6Sfa
	 RvxevkQF0RGDiEzTIgBVkqGlWpBQpWsjCWmvQAZEmwuB8ZHJbg0xHAc+ca2rOavBy+
	 eZ17Fo1JTfVs1mtQv/tK9oI1mupNK69xqjGWpVmuip8Q4jBOZptAKrRVts43wRHqcl
	 0PW9MsaACADQUbG8vnI9+OgZ5kUju9CuaQYi1CKP/6V5rrBHI5e0fMqeSe7MXBMOhi
	 Aud29j8TwCbxQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Sat,  5 Sep 2026 09:12:33 -0700
Message-ID: <20260905161233.81892-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905103935.4871-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  5 Sep 2026 18:36:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri, 04 Sep 2026 17:25:34 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Fri,  4 Sep 2026 23:35:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > That said, it's not important for me to add explanations to the
> > > document, but may I know why commit [2] changed the behavior which
> > > introduced by commit [1]?
> > > 
> > > Commit [1] Behavior:
> > > 
> > >     if (quota->esz && quota->changed_sz >= quota->esz)
> > >         s->stat.qt_exceeds++;
> > > 
> > > Commit [2] Behavior:
> > > 
> > >     if (damos_quota_is_full(quota, c->min_region_sz))
> > >         s->stat.qt_exceeds++;
> > > 
> > > Before commit [2], qt_exceeds will only increase when quota->esz is not
> > > zero, but after commit [2], qt_exceeds also increase even when
> > > quota->esz is zero.  I'd love to understand the rationale behind this
> > > change to better grasp the design evolution.
> > > 
> > > [1] 6268eac34ca30 ("mm/damon/schemes: account how many times quota limit has exceeded")
> > >     (Fri Jan 14 14:10:20 2022 -0800)
> > > [2] c7ec7d5f6b3d1 ("mm/damon/core: handle <min_region_sz remaining quota as empty")
> > >     (Mon Apr 27 18:33:50 2026 -0700)
> > 
> > Seems commit c7ec7d5f6b3d1 didn't make a behavior change that you are
> > describing.
> 
> I actually wanted to point out the behavior difference between commit [1]
> and [2], but I've understood and agreed with your point.
> 
> > 
> > '''
> > $ git show c7ec7d5f6b3d1
> > [...]
> > @@ -2601,8 +2613,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
> >         if (!time_in_range_open(jiffies, quota->charged_from,
> >                                 quota->charged_from +
> >                                 msecs_to_jiffies(quota->reset_interval))) {
> > -               if (damos_quota_is_set(quota) &&
> > -                               quota->charged_sz >= quota->esz)
> > +               if (damos_quota_is_full(quota, c->min_region_sz))
> >                         s->stat.qt_exceeds++;
> >                 quota->total_charged_sz += quota->charged_sz;
> >                 quota->charged_from = jiffies;
> > '''
> > 
> > And I don't think there was a behavior change.  Hopefully commit 54419bbd0ee3
> > ("mm/damon/core: allow quota goals set zero effective size quota") will give
> > you some clues.
> 
> Thank you very much for your clarifying :>
> 
> Now I completely understand why there is different behavior

I told you I don't think there was a behavior change.  I still think so.

> between
> commit [1] and [2].  Because in commit [1], esz==0 only means quota is
> unlimited.

No.  Commit 54419bbd0ee3 says "DAMON core assumes zero effective quota means
the user has set no quota."


> After commit 54419bbd0ee3, esz==0 also can means do not have
> quota at all.

That's what the commit is describing the before-commit status...

> But the qt_exceeds should just not increase when quota is
> unlimited, that's why the current implementation is completely correct.

There is no unlimited quota.  Hence I don't understand what you are saying
here.  Please carefully read the commit message again.

> 
> Best regards,
> Rui Yan


Thanks,
SJ
