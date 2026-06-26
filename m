Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711F27FD51;
	Fri, 26 Jun 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457759; cv=none; b=ZqykRyS2+qspgh4I6SF7VVTKHV6xlN3JKPJGu4nw5lj7PtfJFpXZtjtC9GnpbNpoxIKwyAyTzDFeJNdsmXJeizELBJY6dd4vz90quKCSGGcT//QS1p6num9koiOm7jjpOupWMAHcfv3ZR0PGT+1IRPVjsOUNn2b2dG2ddr9xLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457759; c=relaxed/simple;
	bh=V4bnRQm9v4uovmxvqzkbHJLyzYgx8AlkWmk94JMK1yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQB8VwaY5R0fU3tkEK14w3e+lELK0YPtJBi24X6RvftadfXE+eSToMs8pJu129fOQXWpSjExyxhcdtinl4YsDLBR1txT+XeCmhkJejZZOA0AO2VjLXIPaPVeL1qkVY1qWt5GsoGRdbyihUtb7V4wx24/iSXs2BwqWFRVeC5/yIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT1d3M4U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT1d3M4U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BE61F000E9;
	Fri, 26 Jun 2026 07:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782457757;
	bh=qqBlcdRV2i1go9GKmpopie5fik3FLtofH/AmE7bi9jg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hT1d3M4UQb4Ned3clUpZ462ztJ/9kxePVvODhtD8S8vFXeINMJnbXP21x+Pudhbpr
	 5gaFB9x1cQxuIvVIjhW9Hkqv/pG8Wue4pOI3NN4InezVSUFyH595Gw4zPAP7JHuFG+
	 MeeSZAm5XukCvZ6WLuFLXD2+n3Jiq2zCd3MSrVApNI3c4YPawm5aAzGY5UPp0BzTF/
	 cL5oaPb4KY8qIQKX0X3xdpBe+gu9LcNGxrJkfIOcRgjPEGrqKOgO6VLZQ4ruPfbvzs
	 qGxS7Uz31U4MwAdxQA8JDGr/zH+valy4AphWBEiSfAZW5wW7lbUAwo2s6nJD0aSAMc
	 HdI1rpyMFQpEw==
Message-ID: <9e42c598-972e-4f66-a5be-e18b81274a6e@kernel.org>
Date: Fri, 26 Jun 2026 16:09:08 +0900
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
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Vt7pX0ay0nseJq7UGWnJriZK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Vt7pX0ay0nseJq7UGWnJriZK
Content-Type: multipart/mixed; boundary="------------nEc0mtnD69zDGI1M80H7UGcy";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Message-ID: <9e42c598-972e-4f66-a5be-e18b81274a6e@kernel.org>
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
In-Reply-To: <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>

--------------nEc0mtnD69zDGI1M80H7UGcy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/26/26 4:04 PM, Qi Zheng wrote:
> On 6/26/26 2:48 PM, Harry Yoo wrote:
>> On 6/26/26 3:24 PM, Qi Zheng wrote:
>>> On 6/26/26 12:59 PM, Harry Yoo wrote:
>>>> On 6/26/26 1:48 PM, Qi Zheng wrote:
>>>>> On 6/26/26 12:43 PM, Harry Yoo wrote:
>>>>>> On 6/26/26 11:27 AM, Qi Zheng wrote:
>>>>>>> On 6/26/26 2:41 AM, Johannes Weiner wrote:
>>>>>>>> On Thu, Jun 25, 2026 at 11:15:54PM +0800, Qi Zheng wrote:
>>>>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>>>>>>> index 35c3bb15ae96..1ec8c23c72b9 100644
>>>>>>>>> --- a/mm/vmscan.c
>>>>>>>>> +++ b/mm/vmscan.c
>>>>>>>>> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct
>>>>>>>>> lru_gen_mm_walk *walk, struct folio *folio,
>>>>>>>>>          walk->nr_pages[new_gen][type][zone] +=3D delta;
>>>>>>>>>      }
>>>>>>>>>      +#ifdef CONFIG_MEMCG
>>>>>>>>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)=

>>>>>>>>> +{
>>>>>>>>> +    struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>>>>>>>>> +    struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>>>>>>>>> +
>>>>>>>>> +    rcu_read_lock();
>>>>>>>>
>>>>>>>> Where is this unlocked?
>>>>>>>
>>>>>>> The lruvec_unlock_irq() in reset_batch_size() will handle the
>>>>>>> unlocking.
>>>>>>>
>>>>>>>>> +    /*
>>>>>>>>> +     * The memcg can be NULL when the memory controller is
>>>>>>>>> disabled.
>>>>>>>>> +     * Otherwise, the caller keeps the memcg owning @lruvec
>>>>>>>>> alive.
>>>>>>>>> +     */
>>>>>>>>> +    if (!memcg || !css_is_dying(&memcg->css))
>>>>>>>>> +        goto lock;
>>>>>>>>> +
>>>>>>>>> +    do {
>>>>>>>>> +        memcg =3D parent_mem_cgroup(memcg);
>>>>>>>>> +    } while (memcg && css_is_dying(&memcg->css));
>>>>>>>>> +    lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>>>>>>>>
>>>>>>>>        while (unlikely(memcg && css_is_dying(&memcg->css))) {
>>>>>>>>            memcg =3D parent_mem_cgroup(memcg);
>>>>>>>>            lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>>>>>>>
>>>>>>> There is no need to acquire the lruvec before finding the first
>>>>>>> non-dying memcg.
>>>>>>
>>>>>> struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>>>>>> struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
>>>>>>
>>>>>> rcu_read_lock()
>>>>>>
>>>>>> while (unlikely(memcg_is_dying(memcg)))
>>>>>>            memcg =3D parent_mem_cgroup(memcg);
>>>>>>
>>>>>> lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>>>>>
>>>>> If the first memcg is already non-dying, there's no need to re-acqu=
ire
>>>>> the lruvec. ;)
>>>>
>>>> Oh, right :)
>>>>
>>>> Hmm but I still think Johannes' suggestion makes the code cleaner.
>>>
>>> I don't have a strong preference on which of the two coding styles is=

>>> more readable. BTW, is there any kernel documentation I could refer t=
o
>>> for this?
>>
>> I don't think there's a coding style guide that specifically
>> mentions this. Just thought it's cleaner because it merges if (...) go=
to
>> lock; and do-while into a single while loop.
>>
>>>> Observing a dying cgroup should be rare anyway, it's worth focusing
>>>> more on readability?
>>>
>>> While it's rare to encounter consecutive dying memcgs, it can still
>>> happen, right?
>>
>> But is worth saving a few instruction in a basic block that is
>> unlikely() to be executed?
>=20
> I don't have a strong opinion here. Hi Johannes, I'll leave the decisio=
n
> up to you. If necessary, I can send out the v4.
>=20
>>
>> I'm not a memcg maintainer myself, though. just my 2 cents.
>=20
> I'd like to express my gratitude for your reviews, and especially
> for your invaluable help with the earlier dying memcg work!

No problem, likewise to you and Muchun for invaluable work ;)

--=20
Cheers,
Harry / Hyeonggon

--------------nEc0mtnD69zDGI1M80H7UGcy--

--------------Vt7pX0ay0nseJq7UGWnJriZK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4llAAKCRCGXBN6rc5S
1uTzAQC/4GFtaHGc7IlIYLUD17u7FA/tCggxzc848KvmYdxLhQD+PAZEqf4/fXS9
HMlcUHymSJ42Txrn7IAv81yrr7EjgQ0=
=YEci
-----END PGP SIGNATURE-----

--------------Vt7pX0ay0nseJq7UGWnJriZK--
