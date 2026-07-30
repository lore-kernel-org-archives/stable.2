Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272F399013
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430372; cv=none; b=j6dSVSS3WqVMpd1ckIJfirNrD6S8Y0ecW22OsNjjeMI6xLGQ5jFpdNvLQhVLsexHGJWwiu0cKISX6uQcmDyYcJ9kdLdfxOF3Os5EDd3HO7KBe1ZnktZFVbwGjo05sTjDyGUyQ88+VxWfFl8Qf21WUmTKgMgcMrPtz/3xmhHjBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430372; c=relaxed/simple;
	bh=wKovt6ieQ/kZlIdf3vhaUzCJzrw5nLCXMEKKVCNQr3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb9M21hnU7ZmAYL+12KS1nMJI3DYOqtovTK8fmbwRl4RSo2F8UzTk8xwhEIjzXr61ZBLlYnPfNVmVasi7fgvZG68Ynrn94m8cEbppeYRVCYHwe2Waa+S6Y+OOADcOHBdzQ0JISupruMFejtprV+HcCYh6KEEuulDcZU8A+lSLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSCYA78S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSCYA78S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA511F000E9
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430371;
	bh=hIPWuoCXtPq/jgTe42IUcZ06BVyrHgB+kF/1iTPh0+E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LSCYA78SYvAyoOTZjZDkiXV+tGoKEfjO3NVXLGdO45PpHtOjomixkOskw2L4BGb4Z
	 Nf+P83U9ZWy9Jdx/hSPWvkvgBIiRp4AeeshYePlea8N31W6UXxIcHBO5D1kA8ystl7
	 MpvY3t4uTzuqGbp2LfjH7y1xWoQLBaXl1oVZB+n50F8kUnu8qejNTbGMa4q3dAZeV9
	 uS6o74al/w0Ng1884BwL/WaYuK7r9QmdC/49rmBVCUohHY3Y0x0YvIHjuUGMcnOFkI
	 WmbFt2qdpfyairWXpFnfiVJgKkBPmxucp7zYvLyuWmbz/zN3BCn2yonfjZ9a0wOQoM
	 pPtMbHujc67iA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cd3fd760so286048166b.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:52:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoIWYd+mxDA525TJ8M5a5issnUXor3++LouM/xD5gujIYHUU5s1uuMnQy1Qls+9CYHk90KlgJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWkWp4N3yLPSDrrEXgzmoX2H/TTF47NgXmPUPynezbvZfu4zC
	0i71KPc7qT+7ZiKg4qr+f+xykfCwpua4cVd9QTsbFqp3nzWJA0z/Q+9A1wzDq1As7CxqXZ0JZJn
	sNyL80InG4bp1+qbahgFsi92Z+cALZa0=
X-Received: by 2002:a17:907:7241:b0:c12:528a:94f4 with SMTP id
 a640c23a62f3a-c1fa56a2780mr173355266b.60.1785430370347; Thu, 30 Jul 2026
 09:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
 <20260729084206.77793-2-jiahao.kernel@gmail.com> <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
 <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com> <20260729181756.a37e0cc7ea3f6013959d1d25@linux-foundation.org>
In-Reply-To: <20260729181756.a37e0cc7ea3f6013959d1d25@linux-foundation.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Jul 2026 09:52:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMPxdn=MOFD9mbrzed+C9HhOB5DpHG4QS0OJzqV_gLvsQ@mail.gmail.com>
X-Gm-Features: AUfX_mx1JShU4xIT5ANEqpzQMh3RRrHaBazoTKh-oN9MrjhE15twPkvX8ce_pog
Message-ID: <CAO9r8zMPxdn=MOFD9mbrzed+C9HhOB5DpHG4QS0OJzqV_gLvsQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 6:17=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 29 Jul 2026 17:30:56 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
>
> > On Wed, Jul 29, 2026 at 3:58=E2=80=AFPM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Wed, 29 Jul 2026 16:42:05 +0800 Hao Jia <jiahao.kernel@gmail.com> =
wrote:
> > >
> > > > Zswap writeback when the global pool limit is hit fails when memory
> > > > cgroup is disabled. The pool remains full until it is organically
> > > > drained by swapins or memory freeing, leading to zswap store failur=
es
> > > > and pages bypassing getting written directly to the backing swap de=
vice,
> > > > causing LRU inversion (hotter pages with higher fault latency).
> > > >
> > > > This happens because mem_cgroup_iter() always returns NULL when
> > > > memory cgroups are disabled. As a result, the global shrinker
> > > > shrink_worker() repeatedly takes empty walks. After MAX_RECLAIM_RET=
RIES
> > > > failed attempts, the worker gives up without writing back any pages=
.
> > > >
> > > > Therefore, when memory cgroup is disabled, fall through with the !m=
emcg
> > > > branch and shrink the root memcg directly.
> > > >
> > > > With memcg disabled, shrink_memcg() only returns -ENOENT when the r=
oot
> > > > LRU is empty, which means the total pages are already below thr. In=
 the
> > > > absence of heavy concurrent zswap stores, the loop then safely bail=
s out
> > > > via the zswap_total_pages() <=3D thr check; otherwise, it will resu=
me
> > > > shrinking the memcg after processing the reschedule check. For any =
other
> > > > return value from shrink_memcg(), the loop is guaranteed to termina=
te,
> > > > either after MAX_RECLAIM_RETRIES failures or once the threshold is =
met.
> > > >
> > > > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > > > Cc: stable@vger.kernel.org
> > >
> > > How does this affect users?  What behavior do they observe when it
> > > occurs?
> >
> > I think the first paragraph sums it up pretty well, especially the
> > last sentence "hotter pages with higher fault latency".
>
> How do users observe that?
>
> See, what I'm looking for here is an explanation for why we're
> proposing a backport.  How are our users harmed by the current code and
> how does this change benefit them?

It's a potential performance regression when using zswap with memcg
disabled. Sorry I just realized you were looking for a high level
description not detailed symptoms :)
