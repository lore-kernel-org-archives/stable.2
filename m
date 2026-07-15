Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A73B14D2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784132017; cv=none; b=i2+AltkLkGgu2TThpGcUAGHntKK3YKP2iY1z9BN7kgedfi58TQGvRSdU1MrBMFGZs8uoQkcL7KafAIPJSWYaQATHaDJCNA6fEJhsgMkBLXA0zhRQVRWedsI7ff56ZedWLsHy5ZFu7LiKuhOh6FF24JWXY5T1Uf3hlQvvW6N7GKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784132017; c=relaxed/simple;
	bh=ojjtyyGeHoV9PKmc8XRvi9voDAm0az6gJPZeCHzJU1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avgDSt60Il5iVB3OmuEmno2bJ3ngpj6/z27/6GpaLX6x9IyKqO2Yuw26hmMhjAhhu/uTPYVNQE7/QUWmU1GsA3VcbTbKZbMzpPYDQoVGddWqC5jDUF3DqiEeSOrhvf6U+asqVTNTSG6WFLSnuHZixbVc/9ju4iVdDch+tG5j5xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olxKOGZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olxKOGZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C228A1F00ADE
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784132010;
	bh=lu5Q8dLhMuRIjKNUUM4Rh5PJ281PWU4rUxfHtkQFTB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=olxKOGZgyCmb6FPVTij4JCmNrk2owXUCIAWnWPKNseikRFdnhIYMoBd3d6tJHPyFz
	 SRHG3hcV2rKsXoZGdBNVz/z2NDcQX8SCg4BSWs0zoUAGzJWVFjMcdHFMAdWuiPInZC
	 R9M2DBPGzqaYEw2HholgDD81jEc2C7O5Zg4mRwOvv0BooWlAbj6Erj/oqa6jVb9m9S
	 6AC5O0S5o5XOPfB0G1ckSckYS1uNT3LaqE/ruy2iM1Nmk/ROA7DGkC/KkBTUHtBF1U
	 gT8iRpg13v/8l0K6YTJ6rPH7eQAGqsEMm3Ka6HX2o/WR+Oyx4KAXxR/B5sb5D+jPzw
	 hRqF3dNupGZ/w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69a50189d25so10056480a12.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:13:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RppIMDYbd4oBqXW7H1u/JvEVemowBjZOY3pJ66V8RbJ4c05at5P1nbU1kzPzm/ZBELPXfOU8PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUn/IT5T3YePIosVV1zicx81swQ+PHM0GPiEvsx9GutpbtLEO
	p27mlBr88Qc1/xTb3pTH9yGKG2wGivZAqn7vLriMucHWMyJgq6OkKYPnn/GWQA8KPwpKRLrHwt0
	ra5H5vcaem6cTFAf+MH38/mLZlGdIxeQ=
X-Received: by 2002:a17:907:6d04:b0:c12:8c41:3beb with SMTP id
 a640c23a62f3a-c16794a90e1mr255601966b.50.1784132009676; Wed, 15 Jul 2026
 09:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
 <20260714081510.16895-2-jiahao.kernel@gmail.com> <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
 <20260714193129.f81711f516504b659d544741@linux-foundation.org> <7a1fe347-7ca6-4768-9308-420bf1251f54@gmail.com>
In-Reply-To: <7a1fe347-7ca6-4768-9308-420bf1251f54@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 15 Jul 2026 09:13:17 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMDndmoxi_XvQv3rkkhCfb+aW3=8JdE3gAv2YOKiyiFSA@mail.gmail.com>
X-Gm-Features: AUfX_mwya7L56YQEsogBNZLgTsBSd6kz9fOgJ7y2xnvr3Ptih0l9NoLzTiD9lJs
Message-ID: <CAO9r8zMDndmoxi_XvQv3rkkhCfb+aW3=8JdE3gAv2YOKiyiFSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:31=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> On 2026/7/15 10:31, Andrew Morton wrote:
> > On Tue, 14 Jul 2026 09:52:59 -0700 Yosry Ahmed <yosry@kernel.org> wrote=
:
> >
> >>> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL=
.
> >>> Therefore, the global shrinker shrink_worker() always takes the !memc=
g
> >>> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply give=
s up,
> >>> so it fails to write back anything.
> >>>
> >>> Therefore, when memory cgroup is disabled, fall through with the !mem=
cg
> >>> branch and shrink the root memcg directly.
> >>>
> >>> With memcg disabled, shrink_memcg() only returns -ENOENT when the roo=
t
> >>> LRU is empty, which means the total pages are already below thr. The
> >>> loop then safely bails out via the zswap_total_pages() <=3D thr check=
.
> >>> For any other return value from shrink_memcg(), the loop is guarantee=
d
> >>> to terminate, either after MAX_RECLAIM_RETRIES failures or once the
> >>> threshold is met.
> >>>
> >>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> >>> Cc: stable@vger.kernel.org
> >>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> >>> Acked-by: Nhat Pham <nphamcs@gmail.com>
> >>> Acked-by: Yosry Ahmed <yosry@kernel.org>
> >>> Reported-by: Yosry Ahmed <yosry@kernel.org>
> >>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHi=
ZZeLc=3DeyTPKPVQgX4g@mail.gmail.com
> >>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> >>
> >> Patch 2 doesn't really depend on this one, right?
> >>
> >> If that's the case I think this can (and should be) picked up
> >> separately as a hotfix. Andrew, WDYT?
> >
> > Please update the changelog to clearly describe the userspace-visible
> > effects of the bug, thanks.
>
> I am not entirely sure if my understanding is correct here, but maybe I
> should add something like this to the commit message?
>
> When cgroup_disable=3Dmemory is used (or with CONFIG_MEMCG=3Dn), the glob=
al
> shrinker fails to write back any pages. Consequently, the zswap pool
> fills up to its limit and rejects further storage, preventing memory
> pressure from being offloaded to the backing swap device.

I think you can simply write that zswap writeback when the limit is
hit is broken when memcg is disabled.

>
> > Also, AI review has flagged several possible issues, all appear to be
> > serious:
> >       https://sashiko.dev/#/patchset/20260714081510.16895-1-jiahao.kern=
el@gmail.com
>
> For AI review comments on this patch:
> I suspect this scenario might only exist in theory. For zswap LRU to be
> empty while zswap_total_pages() > thr holds true, it would require a
> prolonged state where there are always more than thr zswap entries on
> the zswap LRU whenever zswap_total_pages() > thr is evaluated, yet the
> zswap LRU happens to be empty during shrink_memcg(root_memcg).
>
> If we want to fix this, perhaps we could do something like this?
>
> Yosry, Nhat, what are your thoughts on this?

Do we need to do this? The last paragraph in your changelog explains
why this can't happen because zswap_total_pages() should be 0 in this
case. Did I miss something?
