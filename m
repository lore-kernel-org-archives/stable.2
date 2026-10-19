Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792442257;
	b=3wuzz+gdg/oEDU8mX/R3ccBXUswrAbUw57S1iBqJNoTF//rwp6A2fXnKQDPZy79m4y2Y
	 tuJVGIvbiA602b1JdOOJypEQ2WkgcJXAMHF46ZW1GQernV7KEK79AxMR5zK8locfVefZK
	 diY/zcISuK8jInbgyRyVO7aSSvygllIsNrSVmPOAZX4wF/WUbpuxHLoMi8N7gK4vB0KUx
	 H4udROvkC5bZuRtVa5M+ibTjXOuhnxHU/i5oUD0EaCgMRw/bPe7Y6gjb67fZ8LGqwaUKP
	 jOpzcDbmg0ccDeYQtZPh5N/tLvadPrRBukdcS+A7CQSGmjwG4VJT2cZJAFQ2QyvmHvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PO9p69nb6+vsNmUFhgfonclxpqAf2KqjRDuFhGInggw=;
	b=nwjYKRVnADTX2/3cXDYujB+K67h7wtUxehBh7Wksd+Sr/4jFdpkCOJrEFmz4RukgkMgd
	 jT0Uc8OCa55//zgtmO5LeSQ1Ce/zMbJRdTWTLEEUzhzD3GaX07FWzKh0R6I2EWfSAWve3
	 1Hd2Ko4xNAfnIo+OO8nRfuhiOQ0MuChUtjUfvAVomJkDndrAvjijv2r/R3YNE2I/qdObA
	 4Y2nAd+qFmgd2OsSd7R6+AhdCNicfHQUK1nFEvYe2ZS2xHE16Uw1hE2THv1wGGw/JfKgB
	 pCM0mTDjRcNKhoPlcTNGBUZ+jfa8DSibN33Y/+As9TUrZ5EfBI3gwoAbsvYNm7hIWvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UnAQs+Z/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A30606A31B
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09A30606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UnAQs+Z/
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ac8a2ac52bso836367b3.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792442256; cv=none;
        d=google.com; s=arc-20260327;
        b=eGZsFNbw7WT4HuSS0DCOncHDR5Z/93E645qvsauod6YWxGcUoMB9/XT3paFKK0+TD/
         f2CTHQYoN1qyCIx/VEaMFAYbtWXR+mB5CBKCiTV0kz8tC17X1IaAzPoCKIbv+xkjlUuK
         BlFoar1KYIeM9ti4ENp0BJpBjI3RIV6uqxpIey9bXwKh64nSAhrBz1d75+17O/odKyq0
         8Nb/jiHFYqiOIfOOprIKKndG8zV7mVE7DuCCUf59OOHGWKOasNXHqb3AdGuYrc1Sotyb
         rmVYxCIYBJ2Qw37tYSnRqIGm2m2lOuZZWb7pw+ofvIxe2cYh8nLVgHfJyTnJDD3FHM1G
         FVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PO9p69nb6+vsNmUFhgfonclxpqAf2KqjRDuFhGInggw=;
        fh=9gYx1qHk1qy5QG5EpaFuV7O+xr7gjwcJ8T9Cuok/2g4=;
        b=lJYBM2O9VriS1fKpSKdU4pyi+cp20NUhCmJQLsqsRnCcDYTwHrSv/2zw3NjyEsX3bK
         aY68s+5W6tRQNCkGhx/oBM6saOY3S5qgLfmQt3RSP/814n4Px6yAnNSZcpI/M23dMHev
         gpKag6N06tdJddoIEGJ6hm3yr4N33Enqu19iS+QRWTi9//wefrhbybx3Bd8GnBXLug/q
         VLVizbPn2Ihzn/Ufuhm8vUb0Hntq+TZ5cVLtGc9iH90dkLGpSVsE/fign2XvlIRuGSXQ
         S4+ZjQFIRPl5k9k+wRW9v1wvo76Z8JdMb9GHGjrrF2QtQuajucbBaTHYh33tgPYoDpfc
         otiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442256; x=1793047056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PO9p69nb6+vsNmUFhgfonclxpqAf2KqjRDuFhGInggw=;
        b=UnAQs+Z/rCSGX025saSqvENYaj5VmR5HpjCKVhhee/ym5jLqePz7qzcOqi9rdGJryn
         C8iJzsaZhjl00kwf3Jx5mBWyW+FXPH8PFomM2wBgrp/Kh5OQ4IUd+pY0oF/EF4B1jnFU
         mTeCYNw/bynGRtw/fi+sbRxYUSL937Bcdh2HyX2o9vRywolga7I5du2JtPHjkrF40Mm3
         8HqrYU4noZTaO6yxYa98Pn4Lxp+ghXGoryANp2UJpYinkLJnBZCbqGVz9zZPDKccdRVw
         g6xLzyqOHQKrXzpga99neiw5neTu6fvDU42IsIP/uTuNYYBvCFkHMkh1n+vt7ZTZH5T4
         c+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442256; x=1793047056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PO9p69nb6+vsNmUFhgfonclxpqAf2KqjRDuFhGInggw=;
        b=hn/kTFyTKL7tM/SqoeZkeWG2iw27vXxeBJL4YcWh9WpMHuTbqYgzmpoIV2USBHyRJ9
         q0OciRzVnB9/xCUVQm1PVlwJdwZS/neCYtHxyQEBR2M6FZnpficr0o2Klrsu+num7wV9
         U05Q+sohN+Ddv3OVQgIwsPmSbqx+7DrWMHm42ctP9eyiqIQ31xux+77gufwpa7RGXQbx
         f01jewtZq5kqWlySriFJB3jSynRn08pKZa1+t3Mou8eFLj6bLSg9kBrNihR+11zBpPHw
         syy1MHJBH6LLU0gKGEgdG04NQmC3QISOtYOyulOLT3pfoWYrDAgHRqPJW7HFpVj/3dyz
         G9BQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAMkIK2Em7tBmo5Qebupm47EjAH3CYaTnH9dmx6ErH19iR3lHOT7eKG4wUAvMXkwlvK5sIP1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLoRm5XOgwlygcm/nXPIwjnhlCvFGuG38LwaOHXew4552EPbCvf
	nQKNNANOtPr/WKlQ7wjyqQancbDXSfU8y3jeP1qTJI/LH4qempqtJBhwlwKEFS8Who69Ax4w/Ai
	/+1n1BOFjwI1yCM9deAMOsU50imh2xQQ=
X-Gm-Gg: AYBFou3awPARecvIiEShxUWor1EyGhVBjfY1HkUWWkxItVAbSKuxsxiymJsStL8hQyN
	bIpK1lrGw+gUWi5Up9LMLQ8jqOH8/wAI6Rv8a6uMFQDEAZDZQ+Whhm5Eh3e970gC0KYCPPDQB/0
	bA0uou3+VKVfzTSB5/nW2pTAemRc1lDTfUcwHxBBHFcQg2qLTTYCIp61VgW//sdYS9+ZiuY+DIf
	YDol2hi722fBNz6alZbKTewW39BAcecNOHybtBUh6O2p5Z2kWmQGs0y3vm/h2T2yfQmJJO71GEQ
	esAaqo7gxPudlB43IL7ed1z7wqFp9ZvSw+q06X6Ftcz+cczJ+mlQXQTUGeMMsRjTJCkYAD8zPHA
	5oEw+I+BeKg0OSeyS8TlpotAMyFo4CFk0g0un9Xmc9vJAlYtxdAF1b/BYweLJkTIq08iWyFurZq
	kUWJ+CYCqQHEjTSRuDe5KQof4=
X-Received: by 2002:a05:690c:fce:b0:8b0:e13c:2857 with SMTP id
 00721157ae682-8b1200efc87mr992317b3.13.1792442255969; Mon, 19 Oct 2026
 13:37:35 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017050928.128582-1-sidchintamaneni@gmail.com> <CAGsJ_4whqGRQ4JY5rLLJZU=f8u5T75qHkJYQFDoqZSx5c6EBHQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4whqGRQ4JY5rLLJZU=f8u5T75qHkJYQFDoqZSx5c6EBHQ@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 19 Oct 2026 13:37:23 -0700
X-Gm-Features: AclHuK9gI4T4O854Y6L1TXMVucW7npKKDzemjhJTunU2ylrUfYVjiEaTh7rHj_8
Message-ID: <CAE5sdEgR3C30xMayXJkWOECQTfADHgNE8Qf9=wjB5eGimjwLYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: multi-gen LRU: fix NULL lruvec->pgdat deref
 with memcg disabled on cmdline
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org, 
	kasong@tencent.com, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, 
	yuzhao@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	apais@microsoft.com, rlmenge@gmail.com, stable@vger.kernel.org, 
	Hardik Garg <hargar@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 18 Oct 2026 at 14:05, Barry Song <baohua@kernel.org> wrote:
>
> On Sat, Oct 17, 2026 at 1:09=E2=80=AFPM Siddharth Chintamaneni
> <sidchintamaneni@gmail.com> wrote:
> >
> > When CONFIG_MEMCG=3Dy, lruvec_pgdat() returns lruvec->pgdat, which for =
the
> > per-node pgdat->__lruvec is left NULL by lruvec_init() and only filled =
in
> > lazily by mem_cgroup_lruvec(). Normally that happens early, e.g. on the
> > first folio_add_lru().
> >
> > With cgroup_disable=3Dmemory, lru_gen_shrink_node() passes &pgdat->__lr=
uvec
> > directly to shrink_one(). If direct reclaim runs before anything has
> > called mem_cgroup_lruvec() for the node, which can happen during early
> > boot under memory pressure (e.g. a kdump kernel), get_swappiness() ends
> > up dereferencing a NULL pgdat:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000005040
> >   pc : get_swappiness+0x68/0xb0
> >   lr : try_to_shrink_lruvec+0x54/0x2c0
> >   Call trace:
> >    get_swappiness+0x68/0xb0 (P)
> >    try_to_shrink_lruvec+0x54/0x2c0
> >    shrink_one+0x8c/0x240
> >    shrink_node+0xc6c/0xe08
> >    do_try_to_free_pages+0xdc/0x570
> >    try_to_free_pages+0x124/0x278
> >    __alloc_frozen_pages_noprof+0x6e8/0xf78
> >    alloc_pages_mpol+0xc4/0x1c0
> >    alloc_frozen_pages_noprof+0x54/0xe8
> >    alloc_pages_noprof+0x1c/0x40
> >    atomic_pool_expand+0x98/0x300
> >    __dma_atomic_pool_init+0x58/0xd8
> >    dma_atomic_pool_init+0x154/0x170
> >    do_one_initcall+0x64/0x350
> >    kernel_init_freeable+0x214/0x430
> >    kernel_init+0x2c/0x208
> >    ret_from_fork+0x10/0x20
> >
> > The classic LRU path and MGLRU before per-node lru_gen_folio lists
> > obtained the lruvec through mem_cgroup_lruvec(), which sets
> > lruvec->pgdat.
> >
> > The above was hit on an arm64 kdump kernel (6.18-based) booted with
> > cgroup_disable=3Dmemory nr_cpus=3D4. It also reproduces on mainline on =
an
> > arm64 VM with CONFIG_ARM64_64K_PAGES=3Dy, CONFIG_MEMCG=3Dy,
> > CONFIG_LRU_GEN_ENABLED=3Dy and:
> >
> >   mem=3D160M nr_cpus=3D4 coherent_pool=3D512M cgroup_disable=3Dmemory
> >
> > These options only serve to force direct reclaim early in boot; with
> > 160M the boot eventually ends in OOM regardless. On mainline the first
> > LRU reclaim happens while unpacking the initramfs, and faults the same
> > way:
> >
> >   Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000005040
> >   pc : get_swappiness+0xd4/0x150
> >   Call trace:
> >    get_swappiness+0xd4/0x150 (P)
> >    try_to_shrink_lruvec+0x44/0x2b8
> >    shrink_one+0x80/0x1a0
> >    shrink_node+0xd98/0xea8
> >    do_try_to_free_pages+0xf4/0x4b0
> >    try_to_free_pages+0x110/0x360
> >    __alloc_frozen_pages_noprof+0x8b0/0x1718
> >    ...
> >    __filemap_get_folio_mpol+0x2ac/0x548
> >    simple_write_begin+0x44/0xf8
> >    page_symlink+0x178/0x198
> >    ...
> >    do_populate_rootfs+0x13c/0x200
> >
>
> So this happens before any folios are added to the LRU and before
> the userspace init process starts?
>

Yes!

> > Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> > Cc: stable@vger.kernel.org # 6.3+
> > Assisted-by: LLM
> > Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
> > Signed-off-by: Hardik Garg <hargar@linux.microsoft.com>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index f11491ee9ed5..0c57e4f1eb15 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -5253,7 +5253,7 @@ static void lru_gen_shrink_node(struct pglist_dat=
a *pgdat, struct scan_control *
> >                 sc->nr_reclaimed =3D 0;
> >
> >         if (mem_cgroup_disabled())
> > -               shrink_one(&pgdat->__lruvec, sc);
> > +               shrink_one(mem_cgroup_lruvec(NULL, pgdat), sc);
>
> What's a bit weird is that even if we fix this here, with an empty
> lruvec, we still won't be able to reclaim a single page. But it's
> hard to see where we could break out early, right?
>

I am not really sure about simple bailout logic. Please let me know if
anyone have any thoughts.

> >         else
> >                 shrink_many(pgdat, sc);
>
> Best Regards
> Barry
