Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EF4D98FA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047993; cv=none; b=QyzuLVfqYMXSX8yD0KaZRuohKMM7O/cVBjF1kcNCxlYO0Poxq0KFe7+IoYHcGHFtBl5pmLRCVIKE28XVLBD4yHISOX9BZxadkk7th8XlBBcaPb2R1QmQjpTaNKcwO0M3/1N7y9P14bHJdkDBTol8/Gvckp1Vxs5Qgj1oHTuLHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047993; c=relaxed/simple;
	bh=UynP7waHvnVv90IW7+Ff+tGm6Qvp6W0MRtKVTBQnnXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDOP2Z8vQ2h4e5U/qL3qRv7FgXOpbes/KfQpTYlyQFkqeiab91M3CtnJ2YR3iTNKFE6EDDnkPmU8YU9hk+lq6D5PUK1ivxISORQT7+TBjNJccrsyNHHy1iLll8wM471N8mEbl0uiYw3ggK1HE8pinWlKiEPmaydPNqyIEQUDExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8C2R35o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8C2R35o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A322C1F00AC4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784047992;
	bh=0GuTTRWvyCne6K/TMPuZlWhgMIx0adVHAqSG19V+XXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W8C2R35o/I1X5fPhJO9ImuwUaHrliG8WoQRrIrsHHP4d1xxjszyvgMZi2CiFMypDn
	 uoN3tI+ojAif5C21kFnBwncWcXpTiI7KPsUfIgW6T108T0FTvUlrkqToyUX1LH+q6m
	 Wbbt2qPDYd76RKnyIBH+ReHj+2xasBqZAkwiH1tBsHjEO3oysgzORSsjibaQJH4zGq
	 LxM8U53HTEsaopQ+3EIXviGDjsK6JFEHg+x/w/+24Tw2g68cYfSCabaVhWzhSzr0tQ
	 168cUo75DXafH+UqJ/UJdHSvxrCoNu+ToDYsf4RhSx2v+HLQu2zSJftwhhRfkP0CXB
	 hnajdki9ChO7w==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15e2dab83eso194393166b.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:53:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7JChjLixCYSk6ph4L6X+Hnz4oV+iKjLQS7HDWE+Wc3WmZQ2+0jDUZNJr4ge/7XLfl8SHqWqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx26wIwnakjXp02fE1d/YXGVgOAveT/cIsjlyojnQtS7j+8O4tK
	wPlyCb+sEpcdZ3zlbq6Q+j4plz4aF02hWBKw0Hgy//g0+dw8QhxGEtRT9UIQBqJBGja5QZtgUSe
	1RqZz5EDpZiA6Hr2JHzTDBAbNBOTrCMk=
X-Received: by 2002:a17:906:f5a1:b0:c16:12ff:dc8b with SMTP id
 a640c23a62f3a-c161f3b58ecmr712408966b.54.1784047991521; Tue, 14 Jul 2026
 09:53:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714081510.16895-1-jiahao.kernel@gmail.com> <20260714081510.16895-2-jiahao.kernel@gmail.com>
In-Reply-To: <20260714081510.16895-2-jiahao.kernel@gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 14 Jul 2026 09:52:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
X-Gm-Features: AUfX_myK2ScSuKb9Od0WSe9xHl83YPOH--7pRL1A1D1eWAOU3YMEEFq2p0-lNTY
Message-ID: <CAO9r8zM5nzDqNcx5UoDgGexvR6jf8MmJV9SomM4AS7n-rZ2o5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
To: Hao Jia <jiahao.kernel@gmail.com>, akpm@linux-foundation.org
Cc: tj@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	mhocko@kernel.org, mkoutny@suse.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:15=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
> Therefore, the global shrinker shrink_worker() always takes the !memcg
> branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up=
,
> so it fails to write back anything.
>
> Therefore, when memory cgroup is disabled, fall through with the !memcg
> branch and shrink the root memcg directly.
>
> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
> LRU is empty, which means the total pages are already below thr. The
> loop then safely bails out via the zswap_total_pages() <=3D thr check.
> For any other return value from shrink_memcg(), the loop is guaranteed
> to terminate, either after MAX_RECLAIM_RETRIES failures or once the
> threshold is met.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Cc: stable@vger.kernel.org
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Reported-by: Yosry Ahmed <yosry@kernel.org>
> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeL=
c=3DeyTPKPVQgX4g@mail.gmail.com
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Patch 2 doesn't really depend on this one, right?

If that's the case I think this can (and should be) picked up
separately as a hotfix. Andrew, WDYT?

> ---
>  mm/zswap.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b5a17ea20237..3d697a1a5365 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1356,11 +1356,12 @@ static void shrink_worker(struct work_struct *w)
>                 } while (memcg && !mem_cgroup_tryget_online(memcg));
>                 spin_unlock(&zswap_shrink_lock);
>
> -               if (!memcg) {
> -                       /*
> -                        * Continue shrinking without incrementing failur=
es if
> -                        * we found candidate memcgs in the last tree wal=
k.
> -                        */
> +               /*
> +                * A NULL memcg ends a full hierarchy pass (except when m=
emcg is
> +                * disabled, where it is always NULL: fall through to the=
 root LRU).
> +                * Count a failure only if the last pass found no candida=
tes.
> +                */
> +               if (!memcg && !mem_cgroup_disabled()) {
>                         if (!attempts && ++failures =3D=3D MAX_RECLAIM_RE=
TRIES)
>                                 break;
>
> --
> 2.34.1
>
