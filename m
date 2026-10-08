Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F63E9C11
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460636; cv=pass; b=blygVubv3hxGf5gKlkyXvwGjVH/mhYIlEsyCYPZtIk4qJwaKLpDqVory8J1DnXcvL/dz5nPWLR0qSUWJbxSFHRO+CKtaLHVpUfKnYQlPCHUrMlY+VP1Thtap/pr2RH6Jq0K9J2td0+GAe6vj76LxVD1//xDSOLc1S1DNG85sK1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460636; c=relaxed/simple;
	bh=DSNHKdAFSEgJ38k0txXrjiOfuOX+zqL8641WnyY8DNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNqu6K20Clud2LZ9Zh2wCJnYkDP3QkTZ3R7EnIY6kiEILmyT9vmFsUJ9CJBBqD+9yIuaCU6ColdK1VjBc8aF70z+CuVfyR0lJ3Ik+FI59O42WrtLhLAYXKllJac2oo2MM9riRCEB88eOgFtD/KJOvN/ygcXi3f4Bhh+V0SSIaUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dj1QElGR; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj1QElGR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2dc8cb0decso517347566b.2
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 04:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791460633; cv=none;
        d=google.com; s=arc-20260327;
        b=KZ3xvS96eseB+T3kP7QxwLSZkh9HSkkyduLJxDC9yfP+YbZC5W0n6HheeGQ0iKNmxH
         VAgusvzv1BUQhHnSM2v+l3X7cIzlSvVkb2kwwmUKkYljTJdccgZLr06m2zOBMy4DoG2F
         1YemTeHNhhxIXC/9OcoPQyMymP63JIdebiiXmpBbRnzvwH2Ap2l9+s4iagkZz4HP/k06
         GajHt2F9n/8s73qczL56t+zoaU5NFw8+fzcNeb+ULc5WjVI9+Z1zpcydzlIr/6hUSpR7
         2kpSRcx8RCjTk5kDjDEr7Ek5tVyPBAji8KcrU5+u4kbv3uTctdihySq1UFBUafKIN3o1
         Cl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+0i0Jq921Jsm4vHHGLuxvRSz4j2TVU7+5Bry6BxrlzE=;
        fh=wj4vCEsOINKxql2CwBSvZpgzLEgjYiXXCYOu/Z4mLJ0=;
        b=pwodgA7HePWLkt07ZaqNPyYLKK7qt+xm6nR8CUgYCyFOLxSRrpz1GY5J0p4hsVIpNe
         WDfGS1E9W+OJvxKxBfk2qoKYyZ09IDR9NJi1khvD/Xsa2zbelrQx6KztvO7wGtJPd8kX
         iyskaw+pNFVtMQkObreLwP2OkfZi3IaSi7AqJuASLXzxSVhg/HOYVjqPFxhV6zUfswUQ
         RiAELnv8YzMxymHUPj4BKUI2DFP5/jYT35tiEUDKIPRYvqbMNaQYqHVf0UjnCCy//QWA
         7U8KUmZ2J/LvM+GIoC4OoWz4ZyLNoPftgDPqo//ly63+WiEB4NwjO0cYAGzJe7E3olMV
         JSGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791460633; x=1792065433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+0i0Jq921Jsm4vHHGLuxvRSz4j2TVU7+5Bry6BxrlzE=;
        b=Dj1QElGRU5CBgAzm1lSWG2C0Yv4w42vzPTWmXAcrvhB8hD0aII1fwnDGu+av71d4M2
         a1P0aaP8YN86qwlIvps32ox6egtbnBvnCQoHAFtKQnFr7fE3JKSxAGsieaYihU4OsAdV
         TUA0ypuHK83rNUR5TluxBF8jSQg1GiXiprPQkcVTjDnBZYkygC02159BXl9V8ns8ul2e
         aQulQ3YFYTwKpr8p25DerAAo2yrscW23+VfNyRY6e7OqQHYSLY+qdUy/QnyaJ1GBI29c
         nfTBj2iZT2Cu/YrYr+pTz1heeMgnFwo5JPDCOIS9KYSM7NUXnH5lfryCITC6UguSbJfM
         3wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460633; x=1792065433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0i0Jq921Jsm4vHHGLuxvRSz4j2TVU7+5Bry6BxrlzE=;
        b=hCvVe+1qMjYBs6yRWTx6IdAMBwdZH4EMDYcpjkghH+y8zjnEhKjtOSbOIlXkMmBEci
         TrZ20UY0IA/YdW2UqC2MH5cgHMPUuBxiPO/AVO8bbCh+wAJTINbV1I9zdnFwyPdgO85R
         ryiZfDDKjdZ/f5I65PHIoC+ziCvZmpZyp5ogroKsqccoJCwd5Cz3dThCX9mz4V2mDk09
         rczJgZ56KcSTPYnmLxfTW9HWXoP3/W9S1VD2cmNGOgL9VDes4SC/h1FkT8Rw/b5868cz
         809FLaR4sHr1FXdQNEpoyV7hGtyjrT3/Bf89eH8FraOhFDac9UzfursXUMOJpbZ3XT7R
         Reog==
X-Forwarded-Encrypted: i=1; AKwUvBz+hga/APNHp+tTySoqWX3PSWXZsaRS2MX6NhUWthq89DnpnElCcPCXrOlWdmiuF+RNI/seb70=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOg+LRnO1wh+YBW1cvbgefE8G4c51wjQ7NbTDgkyZ0WkKETcj6
	yfA0LPyqGPRcgboelH7MN7g8i0ChyJaNX39uE++pCkcp88TDdz2Cn88A6V22fRIHWFjojaH+SRw
	DlKAMW75z9gDZo5HX+Pe2qfEqFmIgkKo=
X-Gm-Gg: AYBFou33IsUbFqYfhYrXs4Y/PW0PBLaALpH5sliJn3QPzX0NDBPWX/XmNX7iLLPhRev
	aqM8LH4BnraYzm13nqfxBmeXkz/pcJwj1IGTIRka1D7z2zRK/8+jT4WDEWBMvSiNBPAhABpdvfp
	TR8JIe+x2oUWQrifC3ChYEcySiC74jmrXViNesxg61QoRf8i21vIB8CloXElynXOPRikJtxca09
	33r10O0WZf2lJsfoOyR3TwoFfwjmBdc+Hkl5kf5Q1PXThzhOeKwuoOXXHXSfNkHidC9yH+/1fWP
	hyAzicfEiQvpXjj1OUZqePwoIX9GyfJuPHLcC70M3/sKL9R1SVjo2PqxMhoKqOOxtHdTcSg47hr
	FPHqP9vzAyA4=
X-Received: by 2002:a17:906:dc8d:b0:c2e:317e:d711 with SMTP id
 a640c23a62f3a-c317bf5998emr545727966b.27.1791460632767; Thu, 08 Oct 2026
 04:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789096175.git.zhuhui@kylinos.cn> <2ed42f96aca124856ea30f774afb55cbe6d8ba58.1789096175.git.zhuhui@kylinos.cn>
In-Reply-To: <2ed42f96aca124856ea30f774afb55cbe6d8ba58.1789096175.git.zhuhui@kylinos.cn>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 8 Oct 2026 13:56:35 +0200
X-Gm-Features: AclHuK-BxqNrNonn8CRYTTdm5cPRpBrRGaffHfg8y4IMBYCVm_4XzkFHjExbKwY
Message-ID: <CAMgjq7A0FKTJuEKSmTvJGHMOiMz_uAwE=TD89JVvLPysinUVaA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm: workingset: use lruvec_page_state_local() to
 count lru pages
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:26=E2=80=AFAM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Commit 7404bd37cfbe ("mm: workingset: use lruvec_lru_size() to get the
> number of lru pages") switched count_shadow_nodes() to lruvec_lru_size().
> With CONFIG_MEMCG enabled, lruvec_lru_size() reads mz->lru_zone_size,
> which only the classic LRU paths maintain.  MGLRU accounts its pages
> through __update_lru_size(), which skips that array, so with MGLRU on the
> four evictable LRU lists are always seen as empty.  The shadow node budge=
t
> (pages >> 3) then collapses to slab plus unevictable pages, and the
> workingset shadow shrinker reclaims eviction tokens almost as fast as the=
y
> are created, losing thrashing protection.
>
> lruvec_page_state_local() reads lruvec_stats->state_local instead, which
> both classic LRU and MGLRU maintain.  Switch back to it.  The reparenting
> race this re-exposes on cgroup v2 is closed by the preceding patch that
> redirects dying-memcg stat updates for all hierarchies.

Looks nice! thanks.
>
> Fixes: 7404bd37cfbe ("mm: workingset: use lruvec_lru_size() to get the nu=
mber of lru pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/workingset.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 7ac2b88c80ae5..8412f4840ae35 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -688,10 +688,9 @@ static unsigned long count_shadow_nodes(struct shrin=
ker *shrinker,
>
>                 mem_cgroup_flush_stats_ratelimited(sc->memcg);
>                 lruvec =3D mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid=
));
> -

Blank line change is not necessary and I think it make the code a bit
more ugly...

>                 for (pages =3D 0, i =3D 0; i < NR_LRU_LISTS; i++)
> -                       pages +=3D lruvec_lru_size(lruvec, i, MAX_NR_ZONE=
S - 1);
> -
> +                       pages +=3D lruvec_page_state_local(lruvec,
> +                                                        NR_LRU_BASE + i)=
;
>                 pages +=3D lruvec_page_state_local(
>                         lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
>                 pages +=3D lruvec_page_state_local(

Just a nit pick.

Reviewed-by: Kairui Song <kasong@tencent.com>
