Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BBF3AAF4E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434588; cv=none; b=VXNkOB0gwgO6JSwSXxp6xatQEcamApifVdDyQmFRoKLmzLPRvKcKbyOINtM35mK63Xx5ocJcV7Q0ZHqQWXbxvgbNDWbiCTFlV/+JOlohcTpl05ABgOEjKuALDy2+184mMiXa6tXUeSZdFLqEWa2d4E3cm9yQQAjAb3Vg3jf2GFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434588; c=relaxed/simple;
	bh=MfSrDP4F7xGzzDcw1jed0LK0YZ8vmCW2EbUeE4wDjiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiIuboRaWGvMHWJHm6letGE3x3ZpxtcL9hVSMlm5WOc9GqWZGgTW5Np6+7g9vhOGXALEtNj2CkXif3+1OnZMfhAO6sO7oddnxayb2OaYJbvPUMtHG6QxMaGQ7ppiVloH6RYglUvWITg+fNCtzz2Hmwq0osKFr1AfzB/qi2ne/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWH/7gUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWH/7gUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1791F00ADF
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785434586;
	bh=uaWtblCQv/4DCdhc7jyYsoeQO3+YXZnfBpK3Ly+PEEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QWH/7gUtPVc6Cpxv27UYhzK9tvJNy1J9q5VhrVickDBsl+DyXd1bwNIyqVtr4Alao
	 LH5jI61q4yx9+UxisS4H/Ksrr6Gaw4EITazQb6OcIStxO9u+92dsP1etCGPtTtzkT4
	 O4oROwpSP3x8GSvcdFDzS1X2TG/VOVjY1sYOe5NB0eQgm5uJUfWlP3p8IBl/s67InG
	 38LR23VoLNXKuhcECoI8Qbw1Nbn1+bas76izYy4iTtN2HJqyjq73UoANipDda3SVfr
	 /LI3L+oEpmm+y+aPHXDNgC8jpIC0FupaH4GgbDoGlkoYkMC1qsVNFcxB4cyblfTmDy
	 AgniaTilN3Suw==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed19f4d60so74971385a.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1DCs1b1NaYYBw6vd27rZ2Zh4FePL8ZTwoHMWXZqzukHgTVCOBlIWCYauGvB4J+XcXvgTSNY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WwyG9OJbAO3cFAGJo/1fudbVXjW9XvH+rgrrsxJGq5RkFRcQ
	svG99Iabz/0GU+OYJOX3jsgAez0OiEq/22SsZ5f8iiUZoYGK28rONZGEjpCOVPIEDaRrSfjz7mh
	z2tH3sJSTpGcPfIxD7b1vY72ggdxLJl8=
X-Received: by 2002:a05:620a:8081:b0:92e:65d0:1cc4 with SMTP id
 af79cd13be357-9348e91c56dmr170609485a.30.1785434586093; Thu, 30 Jul 2026
 11:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
 <20260729084206.77793-2-jiahao.kernel@gmail.com> <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
 <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
 <20260729181756.a37e0cc7ea3f6013959d1d25@linux-foundation.org>
 <CAO9r8zMPxdn=MOFD9mbrzed+C9HhOB5DpHG4QS0OJzqV_gLvsQ@mail.gmail.com> <20260730105952.7878a648c43c32b5e649d96d@linux-foundation.org>
In-Reply-To: <20260730105952.7878a648c43c32b5e649d96d@linux-foundation.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Jul 2026 11:02:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNnswXgnk6_1fXwvjyzdA3J7JNH4txau5y4AF1J8ODYkA@mail.gmail.com>
X-Gm-Features: AUfX_mzx67h0JEqZoctBWdcDXnKtJNhaTEhESBJ0YTmJdBBac9wda2yHtwtXuF4
Message-ID: <CAO9r8zNnswXgnk6_1fXwvjyzdA3J7JNH4txau5y4AF1J8ODYkA@mail.gmail.com>
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

On Thu, Jul 30, 2026 at 10:59=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 30 Jul 2026 09:52:38 -0700 Yosry Ahmed <yosry@kernel.org> wrote:
>
> > > > >
> > > > > How does this affect users?  What behavior do they observe when i=
t
> > > > > occurs?
> > > >
> > > > I think the first paragraph sums it up pretty well, especially the
> > > > last sentence "hotter pages with higher fault latency".
> > >
> > > How do users observe that?
> > >
> > > See, what I'm looking for here is an explanation for why we're
> > > proposing a backport.  How are our users harmed by the current code a=
nd
> > > how does this change benefit them?
> >
> > It's a potential performance regression when using zswap with memcg
> > disabled. Sorry I just realized you were looking for a high level
> > description not detailed symptoms :)
>
> Are we able to guess how significant this is?  It should have
> significant impact to justify a backport.

It depends on the workload. I think a lot of workloads may not notice
tbh, I don't think it's common to use zswap without cgroups.

> Sorry to push - I'm forever trying to train people to describe the
> userspace-visible effects so we can make these backporting decisions!
>
> And to justify those decisions to -stable maintainers
>
> And so that someone who is experiencing a slowdown in some private
> kernel branch can look at the changelog and decide whether this might
> fix it for them.

I don't think it's super important to backport, but it is also
something that we broke at some point and the fix is straightforward
and simple, so imo the risk/reward function is leaning toward
backporting it just in case. That being said, I don't feel strongly.
