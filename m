Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C32DCF46;
	Thu, 25 Jun 2026 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369161; cv=none; b=r9kb9U8GKdxqwe/TQxJojPAzMFOwgHdkyLoaiS02fwA6RkiW3p62ZMoJw7d61tOOVvPaXzxOsOLBVl6LqzqXj/ftobu/Hm3Diy9ACDWZ7cPXEAbeyQ/2emSfOSU9tbtGiLzTjj0vHOyyjgeRuv7YIYjdYuEjvQYBfvGOR3XtJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369161; c=relaxed/simple;
	bh=PA++kEo6Y4a1roRSn0w8MGq4LueGE2Q8Z1qFuXhLmFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3sSjbI4Sdz/fKF7a4xrbBgRAwKi7+9EPK7c2d7TWH/J5LwmXI0sltO7lU8xYQNIXxvNmBxGZf5Ho58oVbqttuByu1snIrjTi6OC2o/7HcEmTurUdEi9jbP6kQxSKH+Ib21lDP3grCJ39TKI11HTkpeh0IQcN/LYRgEV0j+eTRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUb9A7bf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUb9A7bf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0521F000E9;
	Thu, 25 Jun 2026 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782369159;
	bh=PA++kEo6Y4a1roRSn0w8MGq4LueGE2Q8Z1qFuXhLmFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EUb9A7bfT8o3xC2ShcbPTp3AtLHchbnUhfWwHdlOwyZsh3St007Q/Xs0YRAbPpKMY
	 quqEr/j0IjbouRsTm4EzGkODpqMQTtJIMICXpGO2ruBvW4jAmZTV9OQQmreCW6B/LL
	 2hjww5y4aG2w4n4zEJkJvE59uvTx1GZ+tQdMC0iuUPFE77eIsmlPuhnN3P5FLaikDK
	 CKpMhUfVTeOhWw1gKsN7DO48KZu5kwK0n6c8RyHM68a/nWcZZdTJKXzkatR9dUNk1S
	 Wcu+7PER42343ww7e8KP/ZMkfl7nTJUeHXjWOkZDSnaGx5KICtS9mw7NbNERuQrru0
	 LRMnEHeeSYw4g==
Message-ID: <1d78e1c1-0cdb-435e-b278-670bce9148b3@kernel.org>
Date: Thu, 25 Jun 2026 15:32:17 +0900
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
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
 <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
 <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------uktpT6dUCb9cs0xThB17O4X2"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------uktpT6dUCb9cs0xThB17O4X2
Content-Type: multipart/mixed; boundary="------------6ZIs0zsJlyzWHCa3l0yyOpja";
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
Message-ID: <1d78e1c1-0cdb-435e-b278-670bce9148b3@kernel.org>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
 <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
 <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
In-Reply-To: <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>

--------------6ZIs0zsJlyzWHCa3l0yyOpja
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/25/26 3:11 PM, Qi Zheng wrote:
> On 6/25/26 12:16 PM, Harry Yoo wrote:
>>
> [...]
>=20
>>
>>> So lock_batch_lruvec() can be implemented like this:
>>>
>>> #ifdef CONFIG_MEMCG
>>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct pglist_data *pgdat =3D lruvec_pgdat(l=
ruvec);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 struct mem_cgroup *memcg =3D lruvec_memcg(lr=
uvec);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The memcg can be NULL when the memor=
y controller is disabled.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise, the caller keeps the memc=
g owning @lruvec alive.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!memcg || !css_is_dying(&memcg->css))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto lock;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 do {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcg =3D parent_mem=
_cgroup(memcg);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 } while (memcg && css_is_dying(&memcg->css))=
;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
>>>
>>> lock:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irq(&lruvec->lru_lock);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return lruvec;
>>> }
>>> #else
>>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 lruvec_lock_irq(lruvec);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 return lruvec;
>>> }
>>> #endif
>>>
>>> Does this make sense?
>>
>> Yes, looks good to me!
>=20
> OK, this sync method makes more sense as it doesn't require adding a
> new lrugen->reparente. I'll go with this method and update v3.

Thanks!

Just one thing to clarify...

So, when we check something that's updated _before_ grace period
(CSS_DYING), RCU is sufficient.

But in folio_lruvec_lock*(), that is not the case because reparenting
is performed in the RCU work, under the lruvec lock. So the check needs
to be done under RCU and the lruvec lock.

This is quite subtle :D

> Hi Barry and Baolin, what do you think? Since the sync method has been
> changed, I will temporarily drop your previous Reviewed-by tags in v3. =
;)

And hopefully Peiyang would kindly double check v3 still not reproduced
on the machine :)

--=20
Cheers,
Harry / Hyeonggon


--------------6ZIs0zsJlyzWHCa3l0yyOpja--

--------------uktpT6dUCb9cs0xThB17O4X2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajzLcgAKCRCGXBN6rc5S
1iu7AP9alaQqS1MV8EMiCjRZYb/5uBiLKw0FD420qVXcokWGtAEA37LSbn5gKsxP
zjfUl7srE5vdhsoYShNZJGI60VhJLQ4=
=QuH5
-----END PGP SIGNATURE-----

--------------uktpT6dUCb9cs0xThB17O4X2--
