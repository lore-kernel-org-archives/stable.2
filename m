Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E131E857;
	Fri, 26 Jun 2026 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458135; cv=none; b=tdcVmU/SoIcgcMLyjIBfmQj3bls+yyLl4ki3XtkGLJaG1knJtyDzI0hSXSlHcWwtO2uQeJ2Y6VzjcXueLQxVAK5oDHQuqtpcihg38TQ5RfQGVgmxVt4MVdkceOUrlVeMsvkCnj9qpM4kQeuqnq+ZJzsnCm0sOwATQtHL6Ba0Hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458135; c=relaxed/simple;
	bh=9RR1bBMY56xbcT+FAcSx+2o3Qwm6rpAKLhB42TGTEHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4qE7ljkwzaeRRRT3+VZ0t7E3NU6rM2dDCgMjrKuXrr4d1pDVBECG8wV0ehiccaLf1i8OWj+myC9TeEMsvzR7lmX3hJfRMTsWXmGJzZCAF34DcHzw60jUpc9QbpJPZxbceAQVEyWpYDYDQK0Zgj4DSRL+hFdTHFNQxNH14CKnI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxwOaYpa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxwOaYpa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B840A1F000E9;
	Fri, 26 Jun 2026 07:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782458133;
	bh=3lVxdm0Ep0/M2ZYIKTC77sSAb+8Ja64CITv1+WKNFCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OxwOaYpaqmr2aOcT0SoHP1REiLiNj80JROVsNPvrfmy/4xobxnTZ8DFNS8aLhzsG2
	 pc1JYInzhAEN2BaPLK5IIiAOHveUeNvdS1h9ZGykqqnp5ZGjRF3zukUH5/xWpDaG4a
	 RLnkTDu6Q+3/Z+sAuJ4XlXT4mNqSWDTTOVDsTtQi8inuy+EB/yIT2FcP2ihzw3bZqr
	 j+iVV5RthEeDUHnj51btEokTNkIRCnngT+INPOu+UcePKVCbVPX4EZKw+Tlt7lv3My
	 3mwPy1OWlmkE3FxK8W0FsHXg9gLrC5vSd88rLK6Wzytl3VcjKiIyKvITr5gkqr/kZ9
	 26sUDDbQD9wjA==
Message-ID: <dc5e47af-1434-4e43-8ca7-f90de3dc3f63@kernel.org>
Date: Fri, 26 Jun 2026 16:15:24 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260625151554.55105-1-qi.zheng@linux.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------m7QUOiwKcAfVY02vm0zfaXUG"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------m7QUOiwKcAfVY02vm0zfaXUG
Content-Type: multipart/mixed; boundary="------------5KW8ae2yJZ4W4qD8pteHlVMf";
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
Message-ID: <dc5e47af-1434-4e43-8ca7-f90de3dc3f63@kernel.org>
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
References: <20260625151554.55105-1-qi.zheng@linux.dev>
In-Reply-To: <20260625151554.55105-1-qi.zheng@linux.dev>

--------------5KW8ae2yJZ4W4qD8pteHlVMf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/26/26 12:15 AM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec loc=
k.
> The reset_batch_size() later folds those deltas into walk->lruvec under=

> the lruvec lock.
>=20
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
>=20
> This will trigger the following warning in lru_gen_exit_memcg():
>=20
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
>=20
> And the user-visible impact of underestimated nr_pages in MGLRU was
> premature OOMs because MGLRU does not try to reclaim memory when nr_pag=
es
> reaches zero, but there are still more pages.
>=20
> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> flushing the pending batch. A non-dying memcg keeps the original lruvec=

> stable against RCU-delayed offlining; a dying memcg redirects the delta=
s
> to the first non-dying ancestor.
>=20
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a=
-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios"=
)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

besides some nits mentioned elsewhere in the thread,
the approach looks good to me, so:

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------5KW8ae2yJZ4W4qD8pteHlVMf--

--------------m7QUOiwKcAfVY02vm0zfaXUG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4nDAAKCRCGXBN6rc5S
1vJdAP41DQ/Adn/NHl8DrlVUlhHpdYGNd+BlOc6FRwocVOTrGQEA/zSmKeZqWesI
TcJfcwrQQoZKB/v7BJGNTnJRLM7YEg0=
=xY2b
-----END PGP SIGNATURE-----

--------------m7QUOiwKcAfVY02vm0zfaXUG--
