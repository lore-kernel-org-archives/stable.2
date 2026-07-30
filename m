Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95212446833
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433734; cv=none; b=MMVsDr+3STbNKJLhh2cWieVUwdGkK9WIhbf8d7pb8AnPObbb0zCsEBKR5XhlH2Qvf5louYKeoJKgajR9BHOSy4o5Fisa+2ZhKdAggal3seKYgc5hpfe7NIB68NLXcx8hwEhVHulEcmTJ8EU032Yi9QFUgSKTdfJjqoICaHtGVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433734; c=relaxed/simple;
	bh=NEetv2Pv9qENs4TZNRIOnLGIZv+zcjD9t0s5ULxaERI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkU3Otf1fX6cVEKnfP+fvRxhT2wgp+VRSSLpFPVcjicL1V2YAWqpyHBEqVsB9CSiyTgwmmWd0AhFIoCkg20CrYdTU42UicywIRBzhS+RsY7ITEE2ZQIyEsS/pI9akhdYqHaLqiIXQDuJZcDzPSnVCuSSq+q0u5PkHh0SQYhw5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7dLH5Db; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7dLH5Db"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509D81F00ADF
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785433731;
	bh=hYmo7tONz+VGeYe0ElvsPHUXuAXotmKlny3soYpHBOc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k7dLH5DbVxqWwLhAx4OLroBu8CXze3g/r36AxmzpPI+egB93RyFRBAHT3woRKV537
	 UtNwUpoiPK9BheIrwptTFlNZItz8Xhwa2o2kDsDovhdEH/qdK1s/JXRqX9T1inGmHP
	 nUY6dk7zLKvbFsXJ1OOcsi6DWCXmZ5l3Hm2uGYoD+RGVbOk4NoDWrIZ4r/jzcRP7ml
	 vL9YbHajbDEYVW4ydAa9ou8KfxDbIYRQl/txEIbayFpZuKLjKqrRf9NHhl6TTKmpeK
	 qlUiO4Uq/+tAY/g6/S9sWyk3HvyoUcpqotaVCTkUuQ1uDTZhvdjzqmPDudrTZSM2Gv
	 HUnsz7Ml8vWHg==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15f47e6297so3563666b.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 10:48:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrdf/re1DpHSALczwRwXUcaX7NY3J4yBkxTM7YRS2esBbFfo6UtC4q68HEs/01vVyltJOXTZIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AeHjaE2hahw/bx8JM6ns3MrM1FhS1BZbFmAdFlikLS1j+9kr
	tiPq+fuPlUyeCdtccS6W9lIVKL6gKEve20EHTo9ByctV/FIlaUbAc36FNJNlzk4j2OOx9NIerDV
	zf+5sbUn0JbK7YLmiLQSDu8gjr/w01tE=
X-Received: by 2002:a17:907:d78a:b0:c15:c257:9d54 with SMTP id
 a640c23a62f3a-c1fa5858583mr175709366b.62.1785433730181; Thu, 30 Jul 2026
 10:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
 <20260729084206.77793-2-jiahao.kernel@gmail.com> <20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
 <CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com> <c4c95102-72e2-a44f-f16e-4134ba6bb060@gmail.com>
In-Reply-To: <c4c95102-72e2-a44f-f16e-4134ba6bb060@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Jul 2026 10:48:38 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOSTYC3D_2CxapgvXGaZRUdnGetPGz2XgdUO8OygfuEiw@mail.gmail.com>
X-Gm-Features: AUfX_myEtCNdQrULfrezj6dXoutnBvSotAqAHE8SqHPmGyOxN3RP0QklBzi96nI
Message-ID: <CAO9r8zOSTYC3D_2CxapgvXGaZRUdnGetPGz2XgdUO8OygfuEiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
To: Hao Jia <jiahao.kernel@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tj@kernel.org, shakeel.butt@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Yeah, it isn't. Probably we should drop "Closes". I assume Hao added
> > it because checkpatch annoyingly complains if you add "Reported-by"
> > without "Closes", so Hao just linked to the thread where I pointed out
> > the bug.
>
> Yeah, checkpatch will complain if it's missing.

We often ignore checkpatch if it's unreasonable.

> >> AI review asked a couple of questions:
> >>          https://sashiko.dev/#/patchset/20260729084206.77793-1-jiahao.=
kernel@gmail.com
> >
> > The review on patch #1 is something theoretical, we discussed it at
> > length in previous versions.
> >
> > For patch #2:
> >
> >> Does this batching logic break NUMA fairness?
> >>
> >> Because for_each_node_state() always starts from the lowest node
> >> ID and breaks when the scan budget is exhausted, subsequent
> >> calls to shrink_memcg() will restart at the lowest node ID again.
> >>
> >> If the lowest node (typically Node 0) consistently has enough
> >> items to exhaust the scan budget, wouldn't we exclusively evict
> >> pages from it while ignoring older pages on other nodes? Could
> >> this cause LRU inversion across nodes, keeping older pages in
> >> memory on Node 1 while hot pages on Node 0 are evicted?
> >
> > Yes, unfairness is possible.
> >
> > For global shrinking, it's probably not an issue. We reclaim until we
> > hit the acceptance threshold and it's very unlikely this will happen
> > before iterating all nodes (given that the batch size is 32 pages).
> > However, with the shrink_memcg() path, we only reclaim one batch, so
> > there's a chance we'll always reclaim it from node 0.
> >
> > Maybe we should just drop the early bailout and accept potentially
> > doing more writeback than needed. Hao, WDYT?
> >
> If we scan and attempt to write back SWAP_CLUSTER_MAX zswap entries per
> node, it might lead to excessive writeback on machines with many NUMA
> nodes. Furthermore, I'm concerned about introducing higher latency in
> synchronous shrink paths like zswap_store()=E2=80=94especially on systems=
 with a
> large number of NUMA nodes, where it could end up writing back hundreds
> of pages in a single call.
>
> Maybe we could do something like this instead? That way, in the
> worst-case scenario, it falls back to the baseline behavior without
> introducing any extra latency risks.

This basically errs on the side of honouring the batch size
(under-reclaim) instead of doing more writeback, right?

I think I prefer erring on the side of doing more writeback, as it
would ultimately result in less LRU inversion, and we are already
doing writeback proactively during reclaim through the shrinker.

The other option we can explore is keeping the existing logic with the
bailout, but start iterating the nodes at the folio's node in the
zswap_store() path. Basically pass an nid to shrink_memcg() and always
start there. This will avoid always reclaiming from node 0, and the
node of the folio being stored is more likely to be under pressure and
need the writeback. I am not sure how complex this would be and
whether it's worth doing.

Johannes, Nhats, any thoughts on this?

>
>   static int shrink_memcg(struct mem_cgroup *memcg)
>   {
> -       int nid, shrunk =3D 0, scanned =3D 0;
> +       unsigned long node_batch, scanned =3D 0;
> +       int nid, shrunk =3D 0;
>
>          if (!mem_cgroup_zswap_writeback_enabled(memcg))
>                  return -ENOENT;
> @@ -1289,14 +1313,26 @@ static int shrink_memcg(struct mem_cgroup *memcg)
>          if (memcg && !mem_cgroup_online(memcg))
>                  return -ENOENT;
>
> +       node_batch =3D max(1UL, SWAP_CLUSTER_MAX /
> num_node_state(N_NORMAL_MEMORY));
>          for_each_node_state(nid, N_NORMAL_MEMORY) {
> -               unsigned long nr_to_walk =3D 1;
> +               unsigned long nr_to_walk, budget;
> +
> +               /*
> +                * Cap the scan at the per-node LRU length so each entry =
is
> +                * scanned at most once per call.
> +                */
> +               budget =3D min(node_batch,
> +                            list_lru_count_one(&zswap_list_lru, nid,
> memcg));
> +               if (!budget)
> +                       continue;
>
> +               nr_to_walk =3D budget;
>                  shrunk +=3D list_lru_walk_one(&zswap_list_lru, nid, memc=
g,
>                                              &shrink_memcg_cb, NULL,
> &nr_to_walk);
> -               scanned +=3D 1 - nr_to_walk;
> +               scanned +=3D budget - nr_to_walk;
>          }
>
> +       /* Nothing was scanned: every LRU under @memcg was empty. */
>          if (!scanned)
>                  return -ENOENT;
>
> Thanks,
> Hao
> > If you respin, please also drop the batch size argument to
> > shrink_memcg() as it's now always SWAP_CLUSTER_MAX.
