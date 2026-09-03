Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE26E3E6DF4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417028; cv=none; b=edmyHVui8lrVWElgCERdrjs71AsejFh6Ro0m6RutVKw2Eqoh6fa9IbAq9/9HX4otCBBuiCHbWQyPtf0Bn9kNNhzD/OUEZZRlad9uKpp4Zm/Tebcrf0IbkMn6imHU2cjcXgskjrGL9hl3sZeA7f2s4OD+k/FowVd8QaI51vixm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417028; c=relaxed/simple;
	bh=R2/gjhxWyyUZ0jBNMDGGTiujSGfQ32xuIupRnERfeRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZItUYFVNGrYXKWzTkksIZMWFIFEmtwNx14wg+/VfdS7X/FQBWeNmakjENKRZDBF/sLKv1jZsVx2aClIJbvrDWEUPDyZDsShqeQj9YsH2z+A+jX5xsA2XOEzrrrgrYVGIp+y1gWZ0fJ/tZ3kOoyUgMdEaV9d8BX08fr6YPek5hjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQEgvfbF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQEgvfbF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41021F00A3F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788417023;
	bh=z36InkbgZ5czLNoME51lvPgrfTTVurywTjIuByWup8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NQEgvfbFEiEVrwFSBb/9E5aGP1yluPqmMKNMROwPv43STzTUF6Nd7VzSo4LqIes+B
	 vS33elFpG3DqJVJp7oXlNn0Qz4hD8DvzMCc6Ht0jI36l0/gOETnGOukv7PX5NkJ1md
	 99z/lxcYVTCKfNPOOqTFJJMa/ChgMj9aL1If6GAvBJdjVlrHD6VnkGGwjX0v0EsM99
	 oQBnuE9Fzx82MuO4xrlTW0e+PZqHg2hT5cxPU4Ecc714jXMIednN6MjlIjyGDgf8o/
	 a0M1NZ9tBvErUImCCyjYSMPOu9PV2DglTKjiGBUaGwzaxISTriJLtM8lTnRyiCGWIW
	 dpnbekKaUUqFg==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-930c0f9c1b1so215945185a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 23:30:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw+F5dULcJpJrfW5bo7YbHTSQXLrlDUC+jkcsEExTNSoEIOMdS/zyvgwGt29CrZD0h1U1kH0gE=@vger.kernel.org
X-Gm-Message-State: AFuF++lsLZy5puObkJo8XnEQQmXqa/Cl2eMBr1u4AQbor7478tGh3Ud1
	X8r2nSmeRG44uFVNybXmXTf58laDMNYSUfjiklFsTfsiMLD2QZOZAd0M/0p65v8G7HXxu8ysg3c
	YfMBZcKyu91iz7/TpZI80p9d+lsDUqnA=
X-Received: by 2002:a05:620a:f13:b0:937:2ac8:bbda with SMTP id
 af79cd13be357-93960f52da3mr1075847085a.35.1788417022888; Wed, 02 Sep 2026
 23:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903031952.1120321-1-ridong.chen@linux.dev> <20260903031952.1120321-3-ridong.chen@linux.dev>
In-Reply-To: <20260903031952.1120321-3-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Thu, 3 Sep 2026 14:30:11 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wKaboESQfUJPi8y4BNJuxpEWG2Prjb44NvFKDV_aeVhw@mail.gmail.com>
X-Gm-Features: AcwNN1Xa9LjF9LvOPJz6jmGmZsvCdU3Ed2O2AMgXfYG7RHIlGiW-5e7M8Zr3wao
Message-ID: <CAGsJ_4wKaboESQfUJPi8y4BNJuxpEWG2Prjb44NvFKDV_aeVhw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/mglru: fix ineffective memory protection for
 non-kswapd reclaim
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:20=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev>=
 wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> For MGLRU, memory.min/low is not honored during global proactive reclaim
> (writing to the root memory.reclaim) and global direct reclaim, because
> these paths shrink memcgs using stale or effective protection (emin/elow)=
.

Are you sure it should be =E2=80=9Cstale or effective=E2=80=9D?
My gut feeling is that we don't need the =E2=80=9Cor=E2=80=9D here.

[...]
>
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

With a few nits:

Reviewed-by: Barry Song <baohua@kernel.org>

[...]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b4c9b8f3dfe9..500cc2051d13 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5111,7 +5111,13 @@ static int shrink_one(struct lruvec *lruvec, struc=
t scan_control *sc)
>         struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>
> -       /* lru_gen_age_node() called mem_cgroup_calculate_protection() */
> +       /*
> +        * For kswapd, lru_gen_age_node() has already called
> +        * mem_cgroup_calculate_protection()
> +        */

Could be clearer:

/*
 * For kswapd, mem_cgroup_calculate_protection() has already
 * been called during the top-down cgroup traversal.
 */

> +       if (!current_is_kswapd())
> +               mem_cgroup_calculate_protection_path(NULL, memcg);

Best Regards
Barry
