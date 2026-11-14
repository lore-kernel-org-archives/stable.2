Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794686413;
	b=s3Tb15gY5L7cwKtpGfUI7Gq9kdHHFKDYhHWJzkf2AA8TZmEosYuNzclwq0DYA4hH4kep
	 WGIdqrM1EHDIayPzShp3A4rimYjOOr7CJQF742nEjiIwrVcaCTqEkkZRLkaU6MWzJlGNj
	 +WgwM9UBG3xAjcGrb4WeNgE06Dkp5sSHk5HdP9SFbzd6vTELIw0oqO9n/yd0K6IG9wtnQ
	 1zqLm4J7A9ni4DhmJXt2nXMdJAfvhSYI/kj1YHgiYsUhrDPVfza3WWqSEANo6kXD2x1sN
	 Yj+wcFs8KO5eFcRoftrVzc91+oLNUqbcq2wcxSV19nmiIN0+mkcZwa15ZcsO0QJxLfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sOR+YhJV4utRWR4d1PAjqxQcUdv0HHDpc8pa5uwTO94=;
	b=Ywh41vCt8otBVvA0nBxFCzdBJX0jgm+VWCOX1mz5wvthut0jWw+6C1Ln7zlBNb1vmNxF
	 Me/JXhK6rHBGAvdhpGaIe+3aaLN01D1kA9oKgs/rzrlsrGDMGWcBylXZ7mJGSYKDmSUH6
	 UYIJzt8v6Q4WMLwLy2vYvImxiRHaLEL4JZJGVEJJg971pqO2gx7qLQCgwmsJqd2WS+kYK
	 Dxn0tU863aUkVJX4eQpIN03UWkf7+2BX4ctP7ki+NIArCzgn2OD+V0NxxrDnGdZVfZ2p6
	 NuL6L7FX51zXIqSxBAuoDWecxKxg1zEOpVbl52oqMv+3aYJhhk+xn8zqlbdBiqD81pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6bgDG8a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6D606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 20:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19D6D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6bgDG8a
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c50cc7540b7so15838266b.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 12:00:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794686411; cv=none;
        d=google.com; s=arc-20260327;
        b=jaymI7c+kb5/wKkt66SuA2khQcDZvnbNpbJ7/Ttn6KC6cG6eHaTlSowHhyck9/ClRK
         FKJUNxn624wyykJcPKuK3R0rHrSHjIc/4uXtgTZtr34i7qwQOoutxbLcR18P5q5J+o1R
         OYRvD43vpP4xYNZnGHUQ3fHpDtWPaP6qKA+FyHJtpRe0P4MhyptvyWxkds4GoZfAK0pC
         ZnQdtgtDr8Lh2+0RBDV7vZUIATIgB3PymYzFK9YiHsKW17jtl45a99IlZ8pek1u3RGWb
         dr9+xQEupAGGCekbnA3BlKtXQJ9Cu1UzbyHVANgiem6lDTx6Yq9oB2plWbhLRCoEDztG
         brOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sOR+YhJV4utRWR4d1PAjqxQcUdv0HHDpc8pa5uwTO94=;
        fh=iiQdd/Ni5oRXy0gf9Az2Dzrpdt9RnfX07N/uvzeae/g=;
        b=hEbu8QBeNqvMyMMMAB6a5rFg9Ejqt9rk1UdXys22PqYn0wc1D5dj+eGXkSNclgYG4q
         8VvJc5Y99asx++XWEf7aUync75/cuV371n5Vg4Mj5ni7cmLRex+Z9RZoCi0qHzqXyDVf
         3+0nNInGizvrJKB6X4R0xC7MdZ711dImLtyZ3DZo5u4a3AVclBgSi53z5P9XeBAeJrzo
         dttJRoAtpb9FWrjpwViEzDU/RJ6SjtI3M6FXCnYGRbYmV921gXg8q/VPAdy8utkCZqwv
         zKDaNGC8jI2JntljgsGpvvLUbKi2Mnsh5oWRDR5ftd2sNl2mcm+Dimc6PAmv7Vnefv8N
         RQJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794686411; x=1795291211; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sOR+YhJV4utRWR4d1PAjqxQcUdv0HHDpc8pa5uwTO94=;
        b=F6bgDG8aID4X8x/ig3Xrcn6e7ZClhGdyk6xdxWyySovPWsb9OO95LldK3X2rVNSLfi
         NgPWLaF0au4y9xeHqhieg1/tPr+Z1nurmaIwcCS+5UytlDBS+lWGUx31bVRMmRK6V82D
         GdR7g443JTr7wzFKk55B24f018pvWBdSzXHUFO31cVtn2CQg8Qw4BdzM5B9XsmDc7YDL
         NvpdUOc5qIF750U3EMqe1GpuwhR5ZFlhpHbQBC31IreeIpl+H0BVnsxJv4OxejFUOSPX
         n6VXJ4ARd8t4Sbu2XT75LkIdaH0Fhx1Yl9hJunP3+XBsql3Lh/hd6uurhFPmogOXanMK
         ql4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686411; x=1795291211;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOR+YhJV4utRWR4d1PAjqxQcUdv0HHDpc8pa5uwTO94=;
        b=E7eGtIiTkdw7CP3BgKvxP0iSdOOVcbigSbve+l7Ks10j1FdaaKZ5ab9+IrCIafny2O
         0AKgXyP6CCTTCcDUZRMdv/4bXotY97oqbyNQpGjEVsxBZCqK9omGv0Vkwv9vLzzrr8Y9
         +GCT1K/6nk84qwpofrZEcBscrvjtE34K4s4yXlF0+fQEVtHL61L52RMMv7/7vkxs+s8M
         IazOiqDJVVo1JzYkLkvwjvz8XRvFrKaTFu2dsnHo5Ys6uSnDcHlsuw1HTSun1ix52rCx
         1xFz0Uj8rxPbJNj5Yg5K85jnkMAGtLFEn6Nf3fkEck2Xb5GyZzM1+H0gKBT+JjEUSb+0
         LWOQ==
X-Forwarded-Encrypted: i=1; AL+hErHSPM5ZRtigBJ/rxx/aChpZF+TMEjl0g7iajKygrtjHZhMTqfr8OnaZ/Z97iJrDH4p5yd0jvxw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zZzphP/vEYP5K+esWmwaxuNZlB07h+hELn3YvMZ3rFPGLK/lb
	+ikk1bH1pFCaVT/hA/xMqsWVC/nufEdDyWCZE2PY0n14B3XHa9AusQ26ce+z3appQM6KKfj/HGn
	v218IEowRpM4cZeeDBZYeLqIOmuEJIm4=
X-Gm-Gg: AYBFou1mmvXeS7geZ+n3EgETi/gjenVCKnQMjPhoc3CnXETdAZQEYvdGu8ECyWa51vy
	CyMeSAfQ1+SVL6gFh6Z1bczPlA6uFHlWhXOOI3QfuJYm9jce28vGIZK1J0ZYJzDCwgUUUumpbpK
	TIEYvSXrCaJpV/OWg+2HQYfCz+EWxzmCHFcLMFCK9QQupJmTTtkmsFlUnjXL02Zo4lmpCzxZIuQ
	EAKexnj2yPIN/0RFeVvzMygrX3BT0fZCWj+wMvPq+nqkUKtQQYaN1EscODjQHYpQk/l8thuP0Xt
	GCqbDeF/xmlxWmlrMyFH+gy9c0Q2fcyOsbDxr8Kfp1hC/Kf5FxkdITBgTs6XZ7VrsZ/eWyNnSli
	DVu24wqIUuWaHdhFfHQ/llvrv1ahSmD+ySXgptmRJL6pD0Ps2IEmZnaLTsA3IpLII3e574Q==
X-Received: by 2002:a17:907:3e13:b0:c2e:3ed7:7db4 with SMTP id
 a640c23a62f3a-c5096340feamr485567566b.23.1794686411138; Sat, 14 Nov 2026
 12:00:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110151407.789960-1-nphamcs@gmail.com> <20261110151407.789960-4-nphamcs@gmail.com>
In-Reply-To: <20261110151407.789960-4-nphamcs@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 15 Nov 2026 03:59:34 +0800
X-Gm-Features: AclHuK9LiJKo4q2X-ldOljDTJeh41yrOvsNPTDo5hFk09bG_rGCM5-ExnL2Puq8
Message-ID: <CAMgjq7Cwb-hTx=36CB_gYObgN+Jm4VihKrxzjxQ-YujvJEhKqA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/swap: skip relocation of tableless clusters
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@kernel.org, mhocko@kernel.org, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, ljs@kernel.org, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, willy@infradead.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, chrisl@kernel.org, 
	shikemeng@huaweicloud.com, youngjun.park@lge.com, sashiko-bot@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> A stale reclaimer can reach relocate_cluster() after another allocator
> re-isolates an emptied cluster and drops its locks to populate the table.
> The cluster has zero count, CLUSTER_FLAG_NONE and no table, so relocation
> can free it again and dereference NULL in the DEBUG_VM empty check.
>
>     CPU0                                    CPU1
>     Reclaimer                               Allocator
>     alloc_swap_scan_cluster()
>       cluster_reclaim_range()
>         spin_unlock(&ci->lock)
>         __try_to_reclaim_swap()
>           swap_cache_del_folio()
>             __swap_cache_del_folio()
>               __swap_cache_do_del_folio()
>                 __swap_cluster_free_entries()
>                   free_cluster()
>                     __free_cluster()
>                       swap_cluster_free_table()
>             swap_cluster_unlock(ci)
>                                             isolate_lock_cluster()
>                                               swap_cluster_populate()
>                                                 drop ci and outer locks
>                                                 swap_cluster_alloc_table(=
)
>         spin_lock(&ci->lock)
>       relocate_cluster()
>         free_cluster()
>           __free_cluster()
>             swap_cluster_assert_empty()
>               __swap_table_get()  /* NULL table */
>
> Leave tableless clusters to the allocator under ci->lock. This also stops
> a stale reclaimer from returning a cluster to the free list while table
> population is pending, avoiding the resulting FREE-to-NONE state cycle.
> The existing cluster lock serializes the table check and relocation with
> population.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/sashiko-outbox-203018@kernel.org/
> Fixes: 07adc4cf1ecd ("mm, swap: implement dynamic allocation of swap tabl=
e")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/swapfile.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 32639f65f13c..9fd62e4ca7a0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -815,6 +815,13 @@ static void relocate_cluster(struct swap_info_struct=
 *si,
>         if (cluster_is_discard(ci))
>                 return;
>
> +       /*
> +        * An allocator may still be preparing the table.
> +        * Leave the cluster to it.

It's more like the cluster is in an "isolated" state so we shouldn't
touch it, similar to the "discarding" status above, this comment also
looks to me. Huge thanks for fixing this!

> +        */
> +       if (!cluster_table_is_alloced(ci))
> +               return;
> +
>         if (!ci->count) {
>                 if (ci->flags !=3D CLUSTER_FLAG_FREE)
>                         free_cluster(si, ci);
> --
> 2.53.0-Meta
>

Acked-by: Kairui Song <kasong@tencent.com>
