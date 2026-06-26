Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF18149C6F;
	Fri, 26 Jun 2026 04:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782449982; cv=none; b=SHhJ+CdqqfuUWPBwtFegL/xmm5rAAJ2VC0yR/1z+88V37bqlTzT7GqfUe09A/ZQh2aEINqBZ2H69GS00UH1H9/Yf8X+LvgoCXvnBM/cvAqpDAm4BHYmwdUTXIUW8Api7GrggqQ99eca6PktpbY1bWvou0YIpR8d+JVeSFL8nN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782449982; c=relaxed/simple;
	bh=CvyYoi/hge3V7uBG1euhH9djxe5HjOJgSjtxhmmvqqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOJWKywNDYASm4ItG8J1atYzzhNeyKZ4/ZTbvxMlLvzVpLHumwWqX2T+N/6laAk7WLTATOvsIlSL0bomnogqBCFgUDljPJlZrLCBGZJiJ4uA0QxshBLzs9WXUNCKJmZ84TpaLkrXW/mdpGf3x7bOKOY7XTPEslc2ivUCtdBzRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DktboQ2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DktboQ2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A631F000E9;
	Fri, 26 Jun 2026 04:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782449980;
	bh=vQydTLN/cERJBZY6JZKP8VCAhgH15XKAESApLXzuoY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DktboQ2xA0hGMY8Fmh9f0+XpL6P9Zxer7PldlOtFQod5tZmJbgve1NMZVBn4e0J/E
	 5Owq1HCD0uYZi+FsD3U9FIR5IBme0Xi2HE+p/MmTzlpscizw/dBkyTFK9Iey+ldRq8
	 YIGP8uK03oodbO4g+D880HpITmhSovgGmTQ+UJMcm9zYtWUepbvU/ZHuiWokMSeuv1
	 yoqDBvjJs9NWUDeB2cmJn5l8tUiX4usoEJS9OXtrS54hCuAEOXFq80zUF/M/OZG6ci
	 Xh2uh9CanlkCg+LB3Qw8Znnq4tBpFRy1Dcx51+JsVeMoVS/AAZm2SSlWjPuSLfP+Ya
	 5aMCGjVmze7+g==
Message-ID: <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
Date: Fri, 26 Jun 2026 13:59:26 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5Zw0piV59P0tyDvSf9ksEESi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5Zw0piV59P0tyDvSf9ksEESi
Content-Type: multipart/mixed; boundary="------------ZRX0Bm9osqEOHrx8TlGs75oJ";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Message-ID: <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
In-Reply-To: <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>

--------------ZRX0Bm9osqEOHrx8TlGs75oJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/26/26 1:48 PM, Qi Zheng wrote:
>=20
>=20
> On 6/26/26 12:43 PM, Harry Yoo wrote:
>>
>>
>> On 6/26/26 11:27 AM, Qi Zheng wrote:
>>> Hi Johannes,
>>>
>>> On 6/26/26 2:41 AM, Johannes Weiner wrote:
>>>> On Thu, Jun 25, 2026 at 11:15:54PM +0800, Qi Zheng wrote:
>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>
>>>>> The mglru page table walker batches per-generation size deltas in
>>>>> walk->nr_pages while walking page tables without holding the lruvec=

>>>>> lock.
>>>>> The reset_batch_size() later folds those deltas into walk->lruvec
>>>>> under
>>>>> the lruvec lock.
>>>>>
>>>>> The page table walker can run concurrently with the memcg reparenti=
ng
>>>>> path
>>>>> as follows:
>>>>>
>>>>> CPU0                           CPU1
>>>>> =3D=3D=3D=3D                           =3D=3D=3D=3D
>>>>>
>>>>> walk_mm
>>>>> --> walk_page_range
>>>>>       --> update_batch_size
>>>>>           --> walk->nr_pages +=3D delta
>>>>>
>>>>>                                 mem_cgroup_css_offline
>>>>>                                 --> memcg_reparent_objcgs
>>>>>                                     --> lock lruvec
>>>>>                                         lru_gen_reparent_memcg
>>>>>                                         --> reparent child folios t=
o
>>>>> parent
>>>>>                                         unlock lruvec
>>>>>
>>>>>       lock lruvec
>>>>>       reset_batch_size
>>>>>       --> child lrugen->nr_pages +=3D delta
>>>>>
>>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>>
>>>>>      VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>>>                     sizeof(lruvec->lrugen.nr_pages)));
>>>>>
>>>>> And the user-visible impact of underestimated nr_pages in MGLRU was=

>>>>> premature OOMs because MGLRU does not try to reclaim memory when
>>>>> nr_pages
>>>>> reaches zero, but there are still more pages.
>>>>>
>>>>> To fix it, make reset_batch_size() check CSS_DYING under RCU before=

>>>>> flushing the pending batch. A non-dying memcg keeps the original
>>>>> lruvec
>>>>> stable against RCU-delayed offlining; a dying memcg redirects the
>>>>> deltas
>>>>> to the first non-dying ancestor.
>>>>>
>>>>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>>>>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-
>>>>> efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>>>>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU
>>>>> folios")
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> ---
>>>>> Changes in v3:
>>>>>    - re-implement lock_batch_lruvec() by checking CSS_DYING under t=
he
>>>>> RCU lock
>>>>>      (suggested by Harry)
>>>>>    - update the commit message (suggested by Harry)
>>>>>    - temporarily drop the previous Reviewed-by tags
>>>>>      (since the sync method has changed)
>>>>>    - rebase onto the next-20260624
>>>>>
>>>>> Changes in v2:
>>>>>    - update the commit message (pointed by Barry)
>>>>>    - collect Reviewed-by
>>>>>
>>>>>    mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>>>>>    1 file changed, 38 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>> index 35c3bb15ae96..1ec8c23c72b9 100644
>>>>> --- a/mm/vmscan.c
>>>>> +++ b/mm/vmscan.c
>>>>> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct
>>>>> lru_gen_mm_walk *walk, struct folio *folio,
>>>>>        walk->nr_pages[new_gen][type][zone] +=3D delta;
>>>>>    }
>>>>>    +#ifdef CONFIG_MEMCG
>>>>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>>> +{
>>>>> +    struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>>>>> +    struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>>>>> +
>>>>> +    rcu_read_lock();
>>>>
>>>> Where is this unlocked?
>>>
>>> The lruvec_unlock_irq() in reset_batch_size() will handle the unlocki=
ng.
>>>
>>>>
>>>>> +    /*
>>>>> +     * The memcg can be NULL when the memory controller is disable=
d.
>>>>> +     * Otherwise, the caller keeps the memcg owning @lruvec alive.=

>>>>> +     */
>>>>> +    if (!memcg || !css_is_dying(&memcg->css))
>>>>> +        goto lock;
>>>>> +
>>>>> +    do {
>>>>> +        memcg =3D parent_mem_cgroup(memcg);
>>>>> +    } while (memcg && css_is_dying(&memcg->css));
>>>>> +    lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>>>>
>>>>      while (unlikely(memcg && css_is_dying(&memcg->css))) {
>>>>          memcg =3D parent_mem_cgroup(memcg);
>>>>          lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>>>
>>> There is no need to acquire the lruvec before finding the first
>>> non-dying memcg.
>>
>> struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>> struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>>
>> rcu_read_lock()
>>
>> while (unlikely(memcg_is_dying(memcg)))
>>          memcg =3D parent_mem_cgroup(memcg);
>>
>> lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>=20
> If the first memcg is already non-dying, there's no need to re-acquire
> the lruvec. ;)

Oh, right :)

Hmm but I still think Johannes' suggestion makes the code cleaner.
Observing a dying cgroup should be rare anyway, it's worth focusing
more on readability?

--=20
Cheers,
Harry / Hyeonggon

--------------ZRX0Bm9osqEOHrx8TlGs75oJ--

--------------5Zw0piV59P0tyDvSf9ksEESi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4HLgAKCRCGXBN6rc5S
1gGwAQDgsTIu64tG5UvWCyfrIv1RVZyVbf0RbKQAyfsnxC9KtwD/T20rBlrqpe+s
utP9zOBgC9FpdJDhK3gMwCVJCJvHsgc=
=ossq
-----END PGP SIGNATURE-----

--------------5Zw0piV59P0tyDvSf9ksEESi--
