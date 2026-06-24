Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB9935F60A;
	Wed, 24 Jun 2026 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782275408; cv=none; b=ah6FlxvpD+vJBPlPH7nG1f0TdxAIpZOwTOQeUiHBK1+PviEemSf6mXaJc+8IcOXiF3JULRxz5Yamxi4txRIi8hjNyLvrDV6CYxhkHeadAGwla8l0ulmFDK8eEgMMvzKzdJ3F1jlyZOgPwv0/5V2e7c3MglCc8dN7nCCkL3gEpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782275408; c=relaxed/simple;
	bh=86594oqAW4bjChUCgQ0O0qIkElTpoA6UwgqWdpnoEEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSJCgPvENq0cm64cLpxSLL1Kl9x5WCb6pF0/xMiMgWXpP+5VWUJV0kqCqUTeP9LX33IH8VIieqjuTpvIgDJfFOUd7SwYIFeq+zQ21n9YoelCIYzl+02j3lCjeKZBZkr4VI0eT8OTJ+n13e0cUeHrbzRAxNUscvYOaPWOjmY72aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVZbVwtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVZbVwtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6E41F000E9;
	Wed, 24 Jun 2026 04:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782275406;
	bh=Bx/kebHPPgs2d60g6aifmIll7j/E5MvaYrxUaKwgJoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CVZbVwttm33JAE2R5U+7rIIovPr+pcOzHmnUiYpLBy+hKo+eomEmEpVRViqMBUftD
	 DquBiOLUzumiPCVhuOEw/HomSr+u+fomZqF7Nii8DBIyXxSO1ivA2HmrO4QHSDKYtm
	 5fErW3qpg9A18UgVUnqQQbsOTSrX3+5OX26PG9Lm6GWmL1AVxrDmGz4lKYwU3O/1Bz
	 Byb0EebmigTmmE+M3bDrccOMB71XVXQ5cAazxOn91qxuvrVRQ4pRU2iiEHDSh22d0X
	 NX65MrUsL3EY8aphU06Qguv+oesGp5b1LVe0KCQdX7i1y9FKV0pw2cMoBipVAwQzpH
	 bHR+8sGjQLpoA==
Message-ID: <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
Date: Wed, 24 Jun 2026 13:29:57 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uturwecWcQieFOXdAi39JCaI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uturwecWcQieFOXdAi39JCaI
Content-Type: multipart/mixed; boundary="------------6zyhzDgflNVOdEnJMoPRLwzN";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Message-ID: <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
In-Reply-To: <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>

--------------6zyhzDgflNVOdEnJMoPRLwzN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/23/26 6:14 PM, Qi Zheng wrote:
> Hi Harry,
>=20
> On 6/23/26 4:18 PM, Harry Yoo wrote:
>> On 6/23/26 4:16 PM, Qi Zheng wrote:
>>> Hi Harry,
>>
>> Hi Qi!
>>
>>> On 6/23/26 2:17 PM, Harry Yoo wrote:
>>>> On 6/23/26 11:42 AM, Qi Zheng wrote:
>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>
>>>>> The mglru page table walker batches per-generation size deltas in
>>>>> walk->nr_pages while walking page tables without holding the lruvec=

>>>>> lock.
>>>>> The reset_batch_size() later folds those deltas into walk->lruvec
>>>>> under
>>>>> the lruvec lock.
>>>>
>>>> Ouch.
>>>>
>>>> IIRC the user-visible impact of underestimated nr_pages in MGLRU
>>>> was premature OOMs because MGLRU does not try to reclaim memory when=

>>>> nr_pages reaches zero, but there are still more pages.
>>>>
>>>> Perhaps worth mentioning in the changelog?
>>>
>>> Maybe this should be placed before "To fix it...".
>>
>> Thanks!
>>
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
>>>>
>>>> The problem here is that, while grabbing a reference to memcg
>>>> (via mem_cgroup_iter(), for example) makes sure that the memcg is no=
t
>>>> freed, it does not prevent offlining happening, and reset_batch_size=
()
>>>> doesn't check whether the lruvec has been reparented, or the lruvec
>>>> is going to be reparented.
>>>>
>>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>>
>>>>>      VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>>>                     sizeof(lruvec->lrugen.nr_pages)));
>>>>>
>>>>> To fix it, add lrugen->reparented to remember the new owner of a
>>>>> reparented lruvec, and make reset_batch_size() charge pending
>>>>> deltas to
>>>>> that owner.
>>>>
>>>> Could you please explain why it is unavoidable to introduce the new
>>>> field and why checking whether the cgroup is dying (and charging del=
tas
>>>> to non-dying parent) doesn't work?
>>>
>>> Peiyang tried doing this [1], but it doesn't work because
>>> ss->css_offline() is called before clearing the CSS_ONLINE flag.
>>
>> Right.
>>
>>> I also considered using mem_cgroup_tryget_online(), but that only
>>> prevent
>>> the memcg from being freed. It's doesn't prevent the offlining.
>>
>> Right.
>>
>> I think checking CSS_DYING under RCU and grabbing the lruvec
>> of the first non-dying memcg should work (this pattern is already
>> used where we use RCU to guarantee memcgs are not freed).
>>
>> If we do not observe CSS_DYING flag, it is safe to charge deltas
>> to the lruvec because RCU guarantees that reparenting cannot happen
>> under us.
>>
>> If we do observe CSS_DYING, we can walk up the hierarchy and charge
>> deltas to the first non-dying memcg.
>=20
> Checking CSS_DYING looks feasible, but the rcu lock alone cannot preven=
t
> reparenting. We should recheck CSS_DYING after acquiring the lruvec
> lock, otherwise we might run into the following race:

Haha, actually, I was thinking of checking CSS_DYING under both RCU and
lruvec lock. (because that's the pattern)

>   CPU0 reset_batch_size              CPU1 memcg teardown
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   read !CSS_DYING
>=20
>                                      set CSS_DYING

Oh, I thought the entire critical section is covered by RCU.
(I see lock_batch_lruvec() you suggested below doesn't do that)

Isn't RCU enough to prevent reparenting because RCU guarantees that
all readers who read !CSS_DYING complete before reparenting?

Now I'm confused. Is it strictly required to check CSS_DYING under
lruvec lock? CSS_DYING is updated outside the lruvec lock anyway?

>                                      memcg_reparent_objcgs()
>                                      lock child lruvec
>                                      move child to parent
>                                      zero child nr_pages
>                                      unlock child lruvec
>=20
>   lock child lruvec
>   charge stale delta to child
>=20
> So it seems lock_batch_lruvec() should be implemented like this:
>=20
> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> {
>     struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>=20
>     rcu_read_lock();
> retry:
>     while (memcg && css_is_dying(&memcg->css))
>         memcg =3D parent_mem_cgroup(memcg);

Isn't this loop unnecessary as spin_lock_irq() -> check CSS_DYING ->
goto retry does the same thing? (of course, we need to fetch the parent
memcg before retry then...)

>     lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>     spin_lock_irq(&lruvec->lru_lock);
>     if (memcg && unlikely(css_is_dying(&memcg->css))) {
>         spin_unlock_irq(&lruvec->lru_lock);
>         goto retry;
>     }
>=20
>     rcu_read_unlock();
>=20
>     return lruvec;
> }

Thanks!

--=20
Cheers,
Harry / Hyeonggon

--------------6zyhzDgflNVOdEnJMoPRLwzN--

--------------uturwecWcQieFOXdAi39JCaI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajtdRQAKCRCGXBN6rc5S
1mQJAQCZYifwIBTlnCeUcd03aopvWuwmzmAOsss6kYgehOkUVwD/ZlbG/Gvdr702
Qh5RSIeU+ZTGtg5iX6Bl3y1ErVbhfwQ=
=8thM
-----END PGP SIGNATURE-----

--------------uturwecWcQieFOXdAi39JCaI--
