Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356884;
	b=OjnYtoDSxOVhk9X0V2PxOBCSsCj93I8ZXR88jmw/RNDrfUBvB9JEsQQ1nUzSEI07BBFj
	 U6v7LkEF7ZpW6lfZdVtrC2Hsp2nbzTiKRI3HDYjmJ1V6acrk1E/acPZlyU569nRbosiTb
	 WGbs9m+Zju79CZ4o6WQXDfqUKwF54H+4QJYIuu6D9u5+kvE8nJZ8RNAZbhw79vvuUoFIw
	 GWh7o0XaPr74bVCYPrDiVS8kO4p88VRpgtnNre7gpBSrKzvbAO6hY3vp/MPSmhMgTwtnG
	 A/zPUSQKLH631ZS2K00BGRUY/omRYilysNHoR/p2fOxmds1/WDXMqSPSGjd7PfBJJPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356884;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bbBaRo/7L6iOQrhDinfNIJ3r1kvuz8qfg44WFld2veY=;
	b=DHfX38CzZJVZaMogdqeLfkTntmn4QZUVhMna5uzfUC8CQf/Ok4PphEWi0Jo7JraY1o3W
	 q+rQhbd5EYKx3aGhPzZUbpU43ka6MEhXEXFkLOGUsUxb3KSKKoMkp357u+EeiNMQ9HWmd
	 BWA3vdOMVHqQVrs2qYR9WDVEaULIWWoJNGTINPVdJuywQEOyWvbe29pAzfE7n9+peoJH3
	 XMZaJ54hebAv5dO2pJs/jr/+ta024r/WK/HnuZNCtLXOYXwTxGGOm3xPJG5WiHvb+VcKH
	 CeHaZSICbIwFbmXqm6TP0r86PHBKn+Ai0HFK/eGNMyMCCqcBF5FxF/S/AmffR8urfRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwUM4nyk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDC606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwUM4nyk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37D31F00A08
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356883;
	bh=bbBaRo/7L6iOQrhDinfNIJ3r1kvuz8qfg44WFld2veY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nwUM4nykXPopNGTyscZh/s7QXJS/OKgc04ASib+wR47Y2WPuiWkNkx/dQzj5zR/fd
	 KdpC2qkBAGTl8LwWYm/rlheh54DOzdjT9vxQyhOeM5znZ4AXE+cnNUSX80gcPLdQiw
	 8PcPac/FGedKA40KsOEC8D+7UB8oe/mJzwNSMqCrGJ6iP3Cgrp90Ap3foEn3bo53d4
	 428fKlQ+5H1/ZDRfOKnvB2pQ+1zpjfbG2/1IQ9HbOisOOFYNfPGl6NIor4BwbtH0de
	 8kLiFMwAGC5gB9G07ADVCmQnbYydJJDpKjuhai2m6JfkEk86PW4JlcpMLgRUw4PlOm
	 QzbFUP7+5OY7g==
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eafb65e169so1418355e0c.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:28:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHcVMm1I6+/ouDc7JgZxZMUxG75QI416rdAkTH7lN0zN7AtD4421wDHENzPe9Ht5/XhiUBhmG8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wpYcACeuanNOx+cbwRnwXPFkTuCO8AvgPZKTUH7ISvAHYunic
	6lfZa8fXKgwl7K3j3LZAez4kiV3CzbgUcrCkrG4ALNOq5xRe0houdbo3kwJ7cVNMbMnLku5Qwf+
	l5zI+CJGat7lvvQAml6qHm9mDHJlrbo8=
X-Received: by 2002:a05:6123:64:b0:5ea:c98d:768 with SMTP id
 71dfb90a1353d-5ee1c3b55f5mr233673e0c.6.1794356883023; Tue, 10 Nov 2026
 16:28:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111000913.22943-1-shakeel.butt@linux.dev>
In-Reply-To: <20261111000913.22943-1-shakeel.butt@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Wed, 11 Nov 2026 08:27:51 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zRycX9dcW6P1J2R6f+xyO4+z6_LXz1i+qbNbMEnYm9uA@mail.gmail.com>
X-Gm-Features: AclHuK8i5C1ziLIFv7nuGyug3gNnUasxxchiBj9TPgocQ0U6mI78FyGiazCDdjg
Message-ID: <CAGsJ_4zRycX9dcW6P1J2R6f+xyO4+z6_LXz1i+qbNbMEnYm9uA@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a memcg
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Noah Feldt <noah@feldt.systems>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 8:09=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Noah reported list_del corruption on single-node hosts running 7.2.11,
> which already has commit bf4ade7dbd76 ("memcg: keep folio's objcg same
> as its node"). The bad pointer is an MGLRU list head in a freed
> mem_cgroup_per_node:
>
>   slab mem_cgroup_per_node start ff31bfa36a3c9e00 pointer offset 528 size=
 1920
>   list_del corruption. next->prev should be ffacf881ccc70e08, but was ff3=
1bfa36a3ca010. (next=3Dff31bfa36a3ca010)
>
> When a memcg goes offline, __lru_gen_reparent_memcg() moves its MGLRU
> lists to the parent. It moves only the generations (gens) from min_seq
> to max_seq, and it puts each list at the same index in the parent.
>
> A folio's gen in folio->flags can be ahead of the list it is on. In the
> parent, the same index can stand for an older gen, so the folio's gen
> can end up older than its list. Once the parent's min_seq passes that
> gen, sort_folio() puts the folio on the list for max_seq + 1, where it
> stays until the next aging.
>
> If the parent goes offline before that aging, the folio is not moved to
> the grandparent. It stays on the parent's list after the parent is
> freed, and the next list_del() on it touches freed memory. This needs
> two cgroups on one branch to go offline one after the other, such as a
> container and then its pod.
>
> The parent always has MAX_NR_GENS gens at this point, so every index is
> valid in it. Move all MAX_NR_GENS lists, not only the gens from min_seq
> to max_seq.
>
> A reproducer that drives these steps through the lru_gen debugfs file
> gets a KASAN use-after-free on the freed mem_cgroup_per_node without
> this patch, and no report with it.
>
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Reported-by: Noah Feldt <noah@feldt.systems>
> Closes: https://lore.kernel.org/all/20261110132853.71228-1-noah@feldt.sys=
tems/
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org>

Thanks very much, Shakeel! I saw Kairui has exactly the same code here:

[PATCH v4 14/17] mm/mglru: reparent folios from all generations
https://lore.kernel.org/linux-mm/20261016-mglru-fg-v4-14-2106750c0bfa@tence=
nt.com/

somehow, Shakeel's patch makes us need the change earlier even before
mglru-fg lands?

> ---
>  mm/vmscan.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6a1af9b92349..902616a3b755 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4751,19 +4751,25 @@ void max_lru_gen_memcg(struct mem_cgroup *memcg, =
int nid)
>   * The same generation has different meanings in the parent and child me=
mcg,
>   * so this compromise method will cause the LRU inversion problem. But a=
s the
>   * system runs, this problem will be fixed automatically.
> + *
> + * Move all MAX_NR_GENS lists, not only the gens from min_seq to max_seq=
.
> + * An earlier reparenting can leave a folio whose gen is older than the =
list
> + * it is on. Once min_seq passes that gen, sort_folio() puts the folio o=
n the
> + * list for max_seq + 1, where it stays until the next aging. If that li=
st
> + * were skipped, the folio would stay behind on a memcg that is about to=
 be
> + * freed. The parent has MAX_NR_GENS gens here, so every index is valid =
in it.
>   */
>  static void __lru_gen_reparent_memcg(struct lruvec *child_lruvec, struct=
 lruvec *parent_lruvec,
>                                      int zone, int type)
>  {
>         struct lru_gen_folio *child_lrugen, *parent_lrugen;
>         enum lru_list lru =3D type * LRU_INACTIVE_FILE;
> -       int i;
> +       int gen;
>
>         child_lrugen =3D &child_lruvec->lrugen;
>         parent_lrugen =3D &parent_lruvec->lrugen;
>
> -       for (i =3D 0; i < get_nr_gens(child_lruvec, type); i++) {
> -               int gen =3D lru_gen_from_seq(child_lrugen->max_seq - i);
> +       for (gen =3D 0; gen < MAX_NR_GENS; gen++) {
>                 long nr_pages =3D child_lrugen->nr_pages[gen][type][zone]=
;
>                 int child_lru_active =3D lru_gen_is_active(child_lruvec, =
gen) ? LRU_ACTIVE : 0;
>                 int parent_lru_active =3D lru_gen_is_active(parent_lruvec=
, gen) ? LRU_ACTIVE : 0;
> --
> 2.51.0
>

Thanks,
Barry
