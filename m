Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794420857;
	b=T/0uKnuQXhP2hv3w2Cmrnkprkwlm4+Z3Yp9Ear9xbrxk1qvVWVGA8y0i1NPmygKBnPcm
	 kglOZnkifazafHV1q5fUD8BGkklYtZSGuFnVMRr/nh9heUUuMTRguiSPBEA0EPSI4FIMT
	 JVj/P8aN5DWNQil2GKAmH2jJIaQYrXo5tpCBOUKiAfmPg+iSjVmNgAAqOYvtfGGXHV/d4
	 S5aQVbxNuShGQuncmBZuOnGGeu30iC4Lar4YmgqEz/ehJRTLLkqAj+bB94GPrfw+eWoTg
	 BTzt5+EBI3jnBhoj+M9Oj96249ZLNRok8/kWAd0NbSwjSdJqNBwZh8uwjFP8J4wywZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u/plPOsLmxcLve8ez+d90RlH8s4a6+KgPsXYYRGMH+s=;
	b=N/VP+wL2XXk7lTJWYdO5XGvzhP4d0Q9SnmNg8hEqzaEQLu9d0QbnULRqDFZS80DcAa81
	 gb+0hngiPc5KPy6GJZrwpQXoP7u9vnF+qLhPxLRKHWx/KWFhYDGey3C+ER0elGNdO+nxq
	 br3OrJUNNxQcpTaLJjskCG/6xGln39ApUja4UNq60SAtoInrDB6kmpYx1dOZoElBQdCV3
	 Tj4mzByYctBcqHDTutGb+c7uJ2+ncHILyOc3Dw5O8bIhIy89dQBPOT6fo4BCaUvhK6Hxx
	 ph0x2SgXe5XwgT0KaNl2DO8uyUaRuC4lkumm4hRSDjRmiSydIyf0WTNOZvtEGVhG3uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gK3Ktt7u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E21606B789
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E21606B789
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gK3Ktt7u
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso7571006a12.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:14:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794420855; cv=none;
        d=google.com; s=arc-20260327;
        b=f36Ek1ekkpSaXMm1XM0n3UUgL0uheUMCoS34AH6CB4+GYJzZlPF8uZ3JtwZEZUY6l8
         QZETy4u41dWkhn7fFu/uu9rAXq8sTl4DVEbOe5h69bHQgWULfgYNa3Ku1wBTfETu+gM+
         WhRt+/dcOGgmtS5oK55HHm2P2VdXzgLj/O/RYdSCMS/k0hzaj3Sq9QNvdozO+9+hRxsH
         oPGnPsnpD67CBoPDZ3moq9s2RA/qShTUUG9crbT5tSxggz1qCSHQrd8KoB7fdeTtHT4D
         CL8cTdQXwkYz7CIRj3Z9Ormdf22uPUgSRf6p3kC1IBKs/KehS6hwEHwFlKMnZjDFoUkO
         yt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/plPOsLmxcLve8ez+d90RlH8s4a6+KgPsXYYRGMH+s=;
        fh=VS6RGsxmEAqQYzn8OmHnkA13eJRh/oPjOqHZsuF5dpc=;
        b=k1gMpzJ6zwd3IrqdqN5F2ro11+fMDfpRmXq8zupIER87Ij6TfMAmAm7fDzPO6Hcqxe
         XxTAfd4nm2HDXjxkloF1MrF9L2r8xiWiyOUI68GSzRk7n13yRHBMByggOI+jqbc9A9kW
         FCEfonnaazVhEy9BZQf44Wwrp4bnK7K4qGSepafn1Cuw8UgtRXWG557X6GOPl/KqMZpO
         R+WW4dGy0p5TivVaK32aPxO6pCekLY5zw8CeShRx/n/GJO4z1sUwLuB5qRoYO8VrDjqZ
         OH2wmOzwEVGkfPBEorylNto/5ya4FDYr6NsHWVGMnwwBmAUqGx+KkeTb3BVOtwnkWFSw
         +Z4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420855; x=1795025655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u/plPOsLmxcLve8ez+d90RlH8s4a6+KgPsXYYRGMH+s=;
        b=gK3Ktt7uO48sW2HgQ0sVF9ZavycJxcbvaivLmHcWQulOKR0K+srmmhX0wrZ7nRBmRa
         QoFZ8MoNmA2K+OPj7Vp/gk683cYhzgQhGkxGXWkIk9U5lxsLcrvcgbF16iKFYlJhtLUP
         EYagIys/GjeF/5rBRMry/hZGaW87hXgjPbZlgYQfMhr70TSnSll553qcRhgEo7JH9ITI
         HVNtK0HAl/YlKDhN+5Pb94TLqbEjvyimuxozA66PEoXg6IuhLOeKB3NjOAYRx1Pm3x0J
         kIuL8HfSuEoQgBdDFTJTIIFkx+ySUshUusQ2esQ0fjviccCV80pg0SJsrkbz4cCKqIFP
         5ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420855; x=1795025655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u/plPOsLmxcLve8ez+d90RlH8s4a6+KgPsXYYRGMH+s=;
        b=PyBii8x/KvajXsm91IAJqJ2ea8whq3AjKd+3cIaN0WMdlv6QvPFs25kQGkRSp3PaKO
         FsyOZ7cOWHUIuuamPI3UiQA6Q0pqog3mHZzludC8RGViRfkWDYVKpN3HUbX8AlJVZnGV
         ekD3qZXAlCJ53kQlEo7uz4NES75ypZrvM+wf2ySBk7pQ23mrXkzuFBqbQ8n2BOr7+VG7
         60clvMNdqXmoqKIDUKPkUrgNJ8mGBl7/ndOm1C3pLpSb6qSecv0ksPDWPPkdFY7fHgVO
         xt2jwPGhNO7mgAvAmGF0bAbmkQuRFx/lcn6N6//D5reOW67oNN4DrotNYBht8uMpQCyo
         yfSg==
X-Forwarded-Encrypted: i=1; AL+hErECusRAwhy5xbAj8xUKPrl0gQoDCzRfWu9FjQogYMlKOuKkh/SwgkLX1D0WnG8vFQD6QrmUGpQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BqvI4CNVcI5fjq46+1Txiwdw6nt5d8JJpGm1eEM9ak7WJ4rGr
	6jPr54GE3/KOQ7qx2wkUQeUNm6tRD7K4NTs1IUQDWgpCiKrFmyFFpCP5DxMhp/6dTUptVAIz5eG
	Pc5kOjXUUry33pKG0tTjk5Y1U9vjUQvI=
X-Gm-Gg: AYBFou0/DKRGmgkm3S855SgRNMYbxFGqfA3phGFsIBDtR5HsSZ7t9cyM0I8P5fv2Kja
	hRggFGU3KVvZUa1LQ1dyU3x7oLwRkhh747tSbbwBR0ekwND66IquC+uCc5r/pvoQTnRRspj/0Be
	6IdhNoUl1c41wImQi0g3VrQy+vE3w+sCO3Hi6jfTvLuapY5oZv6lXxJF0c3dnu3W+/QBfUCFyYM
	mPXVmYwq4fmXI/qFprT1MFJEZchF2q5BlA4JMadJgmBDooD/1i69uuAYrF+FEXFUDMQYGnLqMCr
	CJ/ktLpfk+qSPu9GWyB6xPPwAglUDcfHidUyBNtoGpgOwYCHYQFO7txMjbB8zVyf929FOWuYsHY
	gOIpxRhO5DsKBl6AVn0nF+eyTRj4/HWZ1iijvJomKnjAPA6lrBHugHZw/Dn8od7QncEgtWQ==
X-Received: by 2002:a05:6402:1247:b0:6b1:da03:d010 with SMTP id
 4fb4d7f45d1cf-6b7777178f4mr1942836a12.23.1794420855147; Wed, 11 Nov 2026
 10:14:15 -0800 (PST)
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
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 12 Nov 2026 02:13:38 +0800
X-Gm-Features: AclHuK8h0ELM0_haw4Gg_bsSdt3hCgaLBxy2Y7ejZe79euvCzbW_wpkEQNryCYE
Message-ID: <CAMgjq7B+PE-Tw_v3bKYzNOTaT6+0_fn8gW7sNpMwzP1tPGbDug@mail.gmail.com>
Subject: Re: [PATCH] mm: mglru: splice all generations when reparenting a memcg
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, Barry Song <baohua@kernel.org>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Noah Feldt <noah@feldt.systems>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 8:10=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
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

"sort_folio() puts the folio on the list for max_seq + 1" seems not
very accurate as MAX_NR_GENS - MIN_NR_GENS =3D=3D 2, could be any stale
gen outside [min_seq, max_seq], right?

The fix itself looks good.

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

As Barry mentioned this is basically the same code as a prepare commit
for MGLRU-FG, which is a fine and clean fix, I just didn't realize the
problem was already reproducible though.

Thanks!

Reviewed-by: Kairui Song <kasong@tencent.com>
