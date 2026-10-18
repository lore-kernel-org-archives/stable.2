Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21C3B19D8
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357505; cv=none; b=jOkmZUihI2Vyj3VnvywoxzGMPwam3hfOjBH2Y+Q5Dy/WzCA6qTasoWS8AqoZYBBR+ZmcS/FtRgBUCZWjg0wE2lHQG7O2jHkPCf5VRjfemzNnlgtWSU25wJ7HjDbsqt0aHTeSe1QTol3nywCTPlTNiEPFIe1KoD2lAUEoH7QYyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357505; c=relaxed/simple;
	bh=OthJdEKOZyT5cyQthiIhZUkaQDgEaf8zEWxc3cak/oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab1ttc3N/pHVOX8kUL9IL+dbFLtsjwZ0d/s8xv867Rr8xMlDWUJamrouhXSt1cuNWvQRphkJOv2BzRDGAkvqsnIsgvm/+igve3X0EXygYXvvZRvjrLsX/qhq5Nb7MWFjAPxKqabRT45ytnx7oq43YJafWFqxk2oVboKEmZKwuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4lLs6eE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4lLs6eE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479E11F000CB
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792357504;
	bh=iQDTlvvwoXWqTgqUBdk+kEmh4xR3Lpqc+hC8biCo7vg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P4lLs6eEEnoVjUQJuctxKFBDuyiPaK3m6UuM2qgmkC16By/9aSfZIWgpmJuCHfJPH
	 AZ2cEGKtdOqRNMne4/juWp8RLzT7qlc2GWSSIOK/AUl3LAOwSSsXi2xDZ5ELgU/LuJ
	 HCCZ+rsUppmYKvwZkqtLKONFVSL0amezDpnaIKAMeBxriahtJGt5qCaMjPT6ZQoJkp
	 47LrDtFiOgVtj4qwixrez4zTggHJ8aPqPPZAgg8ShK7muCU8B7cAFCCEDvaxnImxhc
	 qbssp2b5F8TKOPmKrxEXScyhc2cd0A/XHK2v/f0JApCl90328xasjtDE3vVKolKoTP
	 Y6y42DguGoHsQ==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93a40a9a01aso353861585a.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:05:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwkA30KbU4WrYY1cpiqoHpSZygf3Gqrz44BJx0KIIclaQk2Rpi0+SPVCvwX6qrtM7kEhVMjE3s=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9+lwxMYeUyfXGdT1fO7vsN/OqV6xbcBdu0xZyP4Y+krTUAaZV
	fgMkgP6Iokxa4k5BQGV1oB05TFNKoX8Mko4sF1gKX9NnhFptatW0owmYpWCT3m5ZTeNHwwb5i4A
	/ly4liqQUxPXnrCkN6qjEfAirzBl7AqU=
X-Received: by 2002:a05:620a:280a:b0:93e:c12d:4ec9 with SMTP id
 af79cd13be357-93f17faaefdmr1523087585a.41.1792357503555; Sun, 18 Oct 2026
 14:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com>
In-Reply-To: <20261017050928.128582-1-sidchintamaneni@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 19 Oct 2026 05:04:51 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4whqGRQ4JY5rLLJZU=f8u5T75qHkJYQFDoqZSx5c6EBHQ@mail.gmail.com>
X-Gm-Features: AclHuK--x7DVGO_dcw8j_MNytrS7YLiy9sMauVU8tR1EJZ2OhP3EMm1WXJm10Fc
Message-ID: <CAGsJ_4whqGRQ4JY5rLLJZU=f8u5T75qHkJYQFDoqZSx5c6EBHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref
 with memcg disabled on cmdline
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
<sidchintamaneni@gmail.com> wrote:
>
> When CONFIG_MEMCG=3Dy, lruvec_pgdat() returns lruvec->pgdat, which for th=
e
> per-node pgdat->__lruvec is left NULL by lruvec_init() and only filled in
> lazily by mem_cgroup_lruvec(). Normally that happens early, e.g. on the
> first folio_add_lru().
>
> With cgroup_disable=3Dmemory, lru_gen_shrink_node() passes &pgdat->__lruv=
ec
> directly to shrink_one(). If direct reclaim runs before anything has
> called mem_cgroup_lruvec() for the node, which can happen during early
> boot under memory pressure (e.g. a kdump kernel), get_swappiness() ends
> up dereferencing a NULL pgdat:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000005040
>   pc : get_swappiness+0x68/0xb0
>   lr : try_to_shrink_lruvec+0x54/0x2c0
>   Call trace:
>    get_swappiness+0x68/0xb0 (P)
>    try_to_shrink_lruvec+0x54/0x2c0
>    shrink_one+0x8c/0x240
>    shrink_node+0xc6c/0xe08
>    do_try_to_free_pages+0xdc/0x570
>    try_to_free_pages+0x124/0x278
>    __alloc_frozen_pages_noprof+0x6e8/0xf78
>    alloc_pages_mpol+0xc4/0x1c0
>    alloc_frozen_pages_noprof+0x54/0xe8
>    alloc_pages_noprof+0x1c/0x40
>    atomic_pool_expand+0x98/0x300
>    __dma_atomic_pool_init+0x58/0xd8
>    dma_atomic_pool_init+0x154/0x170
>    do_one_initcall+0x64/0x350
>    kernel_init_freeable+0x214/0x430
>    kernel_init+0x2c/0x208
>    ret_from_fork+0x10/0x20
>
> The classic LRU path and MGLRU before per-node lru_gen_folio lists
> obtained the lruvec through mem_cgroup_lruvec(), which sets
> lruvec->pgdat.
>
> The above was hit on an arm64 kdump kernel (6.18-based) booted with
> cgroup_disable=3Dmemory nr_cpus=3D4. It also reproduces on mainline on an
> arm64 VM with CONFIG_ARM64_64K_PAGES=3Dy, CONFIG_MEMCG=3Dy,
> CONFIG_LRU_GEN_ENABLED=3Dy and:
>
>   mem=3D160M nr_cpus=3D4 coherent_pool=3D512M cgroup_disable=3Dmemory
>
> These options only serve to force direct reclaim early in boot; with
> 160M the boot eventually ends in OOM regardless. On mainline the first
> LRU reclaim happens while unpacking the initramfs, and faults the same
> way:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
0000000005040
>   pc : get_swappiness+0xd4/0x150
>   Call trace:
>    get_swappiness+0xd4/0x150 (P)
>    try_to_shrink_lruvec+0x44/0x2b8
>    shrink_one+0x80/0x1a0
>    shrink_node+0xd98/0xea8
>    do_try_to_free_pages+0xf4/0x4b0
>    try_to_free_pages+0x110/0x360
>    __alloc_frozen_pages_noprof+0x8b0/0x1718
>    ...
>    __filemap_get_folio_mpol+0x2ac/0x548
>    simple_write_begin+0x44/0xf8
>    page_symlink+0x178/0x198
>    ...
>    do_populate_rootfs+0x13c/0x200
>

So this happens before any folios are added to the LRU and before
the userspace init process starts?

> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Cc: stable@vger.kernel.org # 6.3+
> Assisted-by: LLM
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f11491ee9ed5..0c57e4f1eb15 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5253,7 +5253,7 @@ static void lru_gen_shrink_node(struct pglist_data =
*pgdat, struct scan_control *
>                 sc->nr_reclaimed =3D 0;
>
>         if (mem_cgroup_disabled())
> -               shrink_one(&pgdat->__lruvec, sc);
> +               shrink_one(mem_cgroup_lruvec(NULL, pgdat), sc);

What's a bit weird is that even if we fix this here, with an empty
lruvec, we still won't be able to reclaim a single page. But it's
hard to see where we could break out early, right?

>         else
>                 shrink_many(pgdat, sc);

Best Regards
Barry
