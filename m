Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600FCA4E
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784246918; cv=none; b=f3twSSVuKN1+qxRrl+LIhxajs+JWZDURIyIFqBfqfwvVLzaeJQThvJ8tPfn7JRXEnB46ldJyNdCU0/VM72as8g4vG+VxBXphbLrwRUpmU7jrWmw2HmmkPCLoA5/hPBJ/dkIOSBENKqznld9rLJ8Seo9gZ6OgymewiwMH73qbJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784246918; c=relaxed/simple;
	bh=LnSf1ORs3iWpIN1we4xa/uvhWkh/NN2waYRc2HqRVUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzl8sa4tO3X7lK6CM/O4qjwgADp/8dXPKTpcRACFF/XUxquQfCDTB6XaKjJq7BiT3yHrpsWX2vA9W8QGlOYJSa9G4A0nzG4poYFvjUBSIGePSqzZfdmLT7lX3ZD6i5p8cWzTPPPP+35gQfaZ8aNVjyXF/Ke7bOMmc4fCm2ynbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtxZEJ2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtxZEJ2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1187E1F00ACA
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784246917;
	bh=uq8utKGOuKj3StoMy9xF5Px9hk95MjGuUSdIPctg7Ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XtxZEJ2rbkANbpw2gTBA6fUTgyuZMyjKrcgA3/t/qYtquXZbCqPS+MPXJEWbofm27
	 ZD9bMO7H8/fywdSCWuAtn4IG5NrZz06gLRcycpD61VcaioM0WXNWNqypRd+rIWmOYZ
	 ciDYPSbClvVj8dMsweoKbG6D0YJPGw2/7zdXI4B+vWm4kPyg1hL/f1Gf+zDZaAA4xw
	 iTl1xw3Nrj6t8CKGY0PgsYjB8WyATvaMVpDLNgEq+/De5ziu6gBAV9jNJzuOInwnXD
	 pPLjwBYC9RjC1U0gknhDSNo1MOsDlFeTvBYTz52vjan2zGdazi1yRKVavAUOlzkXKX
	 0QKmDvA09VAog==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so12025104a12.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:08:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro1o+BDx51vH2zKlxVhQSdqB29p3IGZ4nBQzjstimZMdCtqTXi76yjRpejBpT0PPz8MgLxGjco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHosVpjj3U8gKvw/bwtO0LZ5OHccjnlhZLfCeVs/EPo/O8C3Fs
	QcDryHpqW9L5jaSzp/f9vOmoEaCc29Xqn9MX2fwTtfLuCCCeHOc/RroOA9y4M3OC3NvYBQf+aaH
	tzQpEYa7/o7fU/87CVU0NYZLmL9YH3iU=
X-Received: by 2002:a17:907:9613:b0:c16:2f5d:614f with SMTP id
 a640c23a62f3a-c16b48075damr5109366b.50.1784246915847; Thu, 16 Jul 2026
 17:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
 <20260714081510.16895-2-jiahao.kernel@gmail.com> <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
 <20260714193129.f81711f516504b659d544741@linux-foundation.org>
 <7a1fe347-7ca6-4768-9308-420bf1251f54@gmail.com> <CAO9r8zMDndmoxi_XvQv3rkkhCfb+aW3=8JdE3gAv2YOKiyiFSA@mail.gmail.com>
 <7b35fd4e-7662-10ae-159b-303350e4e59c@gmail.com> <CAKEwX=Ob9shetuJK4y=NZods3KkT=U_3W4S_ALzxX3EDLomWEA@mail.gmail.com>
In-Reply-To: <CAKEwX=Ob9shetuJK4y=NZods3KkT=U_3W4S_ALzxX3EDLomWEA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 16 Jul 2026 17:08:24 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMy3C=tTLsyv_WkAS8Fd_Z3uSCmX4cekPLo8KkNb9bkCA@mail.gmail.com>
X-Gm-Features: AUfX_myGgssWMZxis9Xq0G95Yc2oVqpD1w4OyvXk9Wv0dDSPaEEVeWWsaCcrVLc
Message-ID: <CAO9r8zMy3C=tTLsyv_WkAS8Fd_Z3uSCmX4cekPLo8KkNb9bkCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, 
	hannes@cmpxchg.org, shakeel.butt@linux.dev, mhocko@kernel.org, 
	mkoutny@suse.com, chengming.zhou@linux.dev, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:19=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Wed, Jul 15, 2026 at 7:21=E2=80=AFPM Hao Jia <jiahao.kernel@gmail.com>=
 wrote:
> >
> >
> >
> > On 2026/7/16 00:13, Yosry Ahmed wrote:
> > > On Wed, Jul 15, 2026 at 5:31=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.=
com> wrote:
> > >>
> > >>
> > >>
> > >> On 2026/7/15 10:31, Andrew Morton wrote:
> > >>> On Tue, 14 Jul 2026 09:52:59 -0700 Yosry Ahmed <yosry@kernel.org> w=
rote:
> > >>>
> > >>>>> When memory cgroup is disabled, mem_cgroup_iter() always returns =
NULL.
> > >>>>> Therefore, the global shrinker shrink_worker() always takes the !=
memcg
> > >>>>> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply =
gives up,
> > >>>>> so it fails to write back anything.
> > >>>>>
> > >>>>> Therefore, when memory cgroup is disabled, fall through with the =
!memcg
> > >>>>> branch and shrink the root memcg directly.
> > >>>>>
> > >>>>> With memcg disabled, shrink_memcg() only returns -ENOENT when the=
 root
> > >>>>> LRU is empty, which means the total pages are already below thr. =
The
> > >>>>> loop then safely bails out via the zswap_total_pages() <=3D thr c=
heck.
> > >>>>> For any other return value from shrink_memcg(), the loop is guara=
nteed
> > >>>>> to terminate, either after MAX_RECLAIM_RETRIES failures or once t=
he
> > >>>>> threshold is met.
> > >>>>>
> > >>>>> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > >>>>> Cc: stable@vger.kernel.org
> > >>>>> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > >>>>> Acked-by: Nhat Pham <nphamcs@gmail.com>
> > >>>>> Acked-by: Yosry Ahmed <yosry@kernel.org>
> > >>>>> Reported-by: Yosry Ahmed <yosry@kernel.org>
> > >>>>> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxW=
VrHiZZeLc=3DeyTPKPVQgX4g@mail.gmail.com
> > >>>>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> > >>>>
> > >>>> Patch 2 doesn't really depend on this one, right?
> > >>>>
> > >>>> If that's the case I think this can (and should be) picked up
> > >>>> separately as a hotfix. Andrew, WDYT?
> > >>>
> > >>> Please update the changelog to clearly describe the userspace-visib=
le
> > >>> effects of the bug, thanks.
> > >>
> > >> I am not entirely sure if my understanding is correct here, but mayb=
e I
> > >> should add something like this to the commit message?
> > >>
> > >> When cgroup_disable=3Dmemory is used (or with CONFIG_MEMCG=3Dn), the=
 global
> > >> shrinker fails to write back any pages. Consequently, the zswap pool
> > >> fills up to its limit and rejects further storage, preventing memory
> > >> pressure from being offloaded to the backing swap device.
> > >
> > > I think you can simply write that zswap writeback when the limit is
> > > hit is broken when memcg is disabled.
> > Will do. Thanks!
> >
> > >
> > >>
> > >>> Also, AI review has flagged several possible issues, all appear to =
be
> > >>> serious:
> > >>>        https://sashiko.dev/#/patchset/20260714081510.16895-1-jiahao=
.kernel@gmail.com
> > >>
> > >> For AI review comments on this patch:
> > >> I suspect this scenario might only exist in theory. For zswap LRU to=
 be
> > >> empty while zswap_total_pages() > thr holds true, it would require a
> > >> prolonged state where there are always more than thr zswap entries o=
n
> > >> the zswap LRU whenever zswap_total_pages() > thr is evaluated, yet t=
he
> > >> zswap LRU happens to be empty during shrink_memcg(root_memcg).
> > >>
> > >> If we want to fix this, perhaps we could do something like this?
> > >>
> > >> Yosry, Nhat, what are your thoughts on this?
> > >
> > > Do we need to do this? The last paragraph in your changelog explains
> > > why this can't happen because zswap_total_pages() should be 0 in this
> > > case. Did I miss something?
> >
> > The loop would require the following sequence to repeat indefinitely:
> >
> > 1=E3=80=81zswap_total_pages() > thr evaluates to true.
> > 2=E3=80=81During shrink_memcg(root_memcg), the zswap LRU is concurrentl=
y drained
> > to empty.
> > 3=E3=80=81Before zswap_total_pages() > thr is evaluated again, the zswa=
p LRU is
> > heavily refilled such that zswap_total_pages() > thr holds true once mo=
re.
> >
> > For our case to manifest, it would require zswap_total_pages() and the
> > zswap LRU state to repeatedly hit this exact window with perfect
> > alignment over a **prolonged period**. Therefore, I suspect this
> > scenario might only exist in theory.
>
> Yeah seems very artificial indeed.
>
> If we want to be extra careful here, maybe we can put a cond_resched()
> there or replace the continue with goto resched or sth?

I think it's also possible with the current code with memcg enabled.
It's still possible that the shrinker puts usage under the acceptance
threshold and then a new zswap stores puts it back above the
threshold, and so on.

Perhaps as Nhat said, just goto resched instead of continue if we're
really worried, but I think even that is not really necessary.

I think we generally want to clean up and simplify the shrinking loop
in zswap_shrinker(), but I don't have any great ideas.
