Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AA3B47D6;
	Tue, 23 Jun 2026 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195458; cv=none; b=JauqSLWZzl4+KjYP+rlsYZ0t0NU1pQtbOWFVqZ0plDRLiqIdWsURfmNGirIY53eioy/9829e8CULiTkzlq9EJpF3/No6/rE06gpCwnPOeKAIj1w97aMhw66JGNU+w2/SceTCZ8+8e14tkQxy2E93ucGKEg+n6x/T6txQVtndLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195458; c=relaxed/simple;
	bh=OlNkiUoAcYNO4SjyMJTT1xjKM/8Vo4VabBXs47K39GY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fDLYuv0xE+eHQC1nRJWSaPbYQTbLqLBqKjR3eyB9nVCmooqSCQ23f+bwpBShdkvmmEOnKc0podK9io25W0R8H2jmxmqe9Dt0SeD8OoB+6Ck//RppADWAUt0C8/LvU42xdrctgqO7YUGCZRWvzulg8dNnpRxz2lB3eHdyY6A4ePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRuB9r/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRuB9r/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF481F000E9;
	Tue, 23 Jun 2026 06:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782195450;
	bh=wURFcKatuG6Z9PR+jWQVTJNfeJ7Yg+VswIaJSJOM9QU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=HRuB9r/X5W4McSJjC38ySksYgMQnjNn0tmhZ9k01WwSqfu1rnnyyFx+/q5lhVnqXX
	 hJjTLEYVFjfj1JunJECgn1C+c/Pq4/lykMIUFKPRhrLBPW2YG3yvI/k16kSvheNJQo
	 9/idUGBSxH2rkcGJFKs4P+3FFcah/2qjFfRoEnD043nz5uZloeZSX68htRAsBVoWmu
	 x+kFibYc9sm3zhAqnO8jwX8IrCp6ttGi3qMxhYY6AOzgZ3QJi1cmuryNFincMbd3By
	 5XhRVKz1GUKh1JwbTa6Nqs5YXjOiHXWJMFQpaacJ0e9OmKZuK52Wjaf7drQ05xJ4dv
	 aWCUf6rA/TiUQ==
Message-ID: <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
Date: Tue, 23 Jun 2026 15:17:26 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harry Yoo <harry@kernel.org>
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
Content-Language: en-US
In-Reply-To: <20260623024237.45990-1-qi.zheng@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8YsZNEvf73Xski3Cmenrn9FR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8YsZNEvf73Xski3Cmenrn9FR
Content-Type: multipart/mixed; boundary="------------ER20SFcEhPfRwGGdTjKgmtqc";
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
Message-ID: <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260623024237.45990-1-qi.zheng@linux.dev>
In-Reply-To: <20260623024237.45990-1-qi.zheng@linux.dev>

--------------ER20SFcEhPfRwGGdTjKgmtqc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/23/26 11:42 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec loc=
k.
> The reset_batch_size() later folds those deltas into walk->lruvec under=

> the lruvec lock.

Ouch.

IIRC the user-visible impact of underestimated nr_pages in MGLRU
was premature OOMs because MGLRU does not try to reclaim memory when
nr_pages reaches zero, but there are still more pages.

Perhaps worth mentioning in the changelog?

> The page table walker can run concurrently with the memcg reparenting p=
ath
> as follows:
>=20
> CPU0                           CPU1
> =3D=3D=3D=3D                           =3D=3D=3D=3D
>=20
> walk_mm
> --> walk_page_range
>     --> update_batch_size
>         --> walk->nr_pages +=3D delta
>=20
>                               mem_cgroup_css_offline
>                               --> memcg_reparent_objcgs
>                                   --> lock lruvec
>                                       lru_gen_reparent_memcg
>                                       --> reparent child folios to pare=
nt
>                                       unlock lruvec
>=20
>     lock lruvec
>     reset_batch_size
>     --> child lrugen->nr_pages +=3D delta

The problem here is that, while grabbing a reference to memcg
(via mem_cgroup_iter(), for example) makes sure that the memcg is not
freed, it does not prevent offlining happening, and reset_batch_size()
doesn't check whether the lruvec has been reparented, or the lruvec
is going to be reparented.

> This will trigger the following warning in lru_gen_exit_memcg():
>=20
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
>=20
> To fix it, add lrugen->reparented to remember the new owner of a
> reparented lruvec, and make reset_batch_size() charge pending deltas to=

> that owner.

Could you please explain why it is unavoidable to introduce the new
field and why checking whether the cgroup is dying (and charging deltas
to non-dying parent) doesn't work?

> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a=
-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios"=
)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---

--=20
Cheers,
Harry / Hyeonggon

--------------ER20SFcEhPfRwGGdTjKgmtqc--

--------------8YsZNEvf73Xski3Cmenrn9FR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajok9gAKCRCGXBN6rc5S
1kURAQCrKB/rsq4mdWtdZZm4JU1WVSaM4LcbuV2X4quEVTJE4gD3XKbfFR+HrWSj
FKsjLyGg+8QuabxOWILmVsvWQ1DIDQ==
=j7cm
-----END PGP SIGNATURE-----

--------------8YsZNEvf73Xski3Cmenrn9FR--
