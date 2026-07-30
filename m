Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE3382373;
	Thu, 30 Jul 2026 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785383752; cv=none; b=DHhT+aOpfGHodoxCqN/tiR6mrDeOwSpmDAWPvsCHM3UsZYuYRBdGeP1rQRbBYQKu3NxUFlT9GmUWENsu7FMBOPPIjKP5jz/zVzSbMyvhopv24hix9VSjmRo4QRpZn5xkLKZ7qmNyXVdelm5RLnRgzNGLkrS+y+/pG5QrSCyxH6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785383752; c=relaxed/simple;
	bh=1Wr5T+lyFZJTeHonA3ZzJ3K9dxEeMfksmls/++jN3V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/4zj9wZPYP60USXDNnJ+knTiJOU1+CjchVf91KOMLHy0azT/njTQnOk2KsjEvlVMdQFWnWsqvwHq34gHLvg59RyFqpF7qFP20DeSFjvq4fG1wB4K/2xJGcoLl4JJbfIlyGKOuOBWYHH4hSvzCsrTYutgppQe6FoYOs/ojfge2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwYmmaMu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwYmmaMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD9B1F000E9;
	Thu, 30 Jul 2026 03:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785383751;
	bh=jL29vjJ77VLrRPv/DZmmHHNOBf84TNgv+nTdSJjkQvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bwYmmaMutasiKGCW3lMAx/RWsUKidEdyk7bHcb+ezqybzVcbC1EZaV2wEqfA5w8E5
	 K5OEmEZ/FALpeYixasyUzvcH87KSuiNV/gvrvOkfqpKVazo6pxmu2GaFPLVBVBNG4w
	 gJpkY54hNabxZoY7LJaT96ImlO6le+E8q+gQcmhJLf07x8JQVA4J29Pg8/sDxCHF1Y
	 gft58FE7Sagc1oyYNrkhLHI1lsuwzkmkL5u7Ijii22xkZSswUqqgyzGo3td2mF70aX
	 2FJ6NU4b+Om+kA/oIJx/gEXyGiepkRKJ64qYzABV6LEWbeQBAr+t9LiKDRz1f3lmvU
	 eEb7x2s07bgGw==
Message-ID: <dd0b5122-896a-4513-9a93-e3fe04bc3f73@kernel.org>
Date: Thu, 30 Jul 2026 12:55:41 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/slub: fix missing debugfs entries for caches
 created before sysfs init
To: Li Xiasong <lixiasong1@huawei.com>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260729101849.3734287-1-lixiasong1@huawei.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260729101849.3734287-1-lixiasong1@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------U4bzCzUcpYSrc5aXCF3vg0O0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------U4bzCzUcpYSrc5aXCF3vg0O0
Content-Type: multipart/mixed; boundary="------------9udFvOgVqgbui5kv0H8J1YIY";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Li Xiasong <lixiasong1@huawei.com>, Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Message-ID: <dd0b5122-896a-4513-9a93-e3fe04bc3f73@kernel.org>
Subject: Re: [PATCH v3] mm/slub: fix missing debugfs entries for caches
 created before sysfs init
References: <20260729101849.3734287-1-lixiasong1@huawei.com>
In-Reply-To: <20260729101849.3734287-1-lixiasong1@huawei.com>

--------------9udFvOgVqgbui5kv0H8J1YIY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 7/29/26 7:18 PM, Li Xiasong wrote:
> slab_debugfs_init() creates the slab debugfs root at device initcall
> time, while slab_sysfs_init() moves slab_state to FULL at late initcall=

> time. SLAB_STORE_USER caches created in this window miss their debugfs
> entries because do_kmem_cache_create() skips debugfs_slab_add() when
> slab_state <=3D UP. This was observed with MPTCP's request_sock_subflow=
_v6
> cache, whose slab debugfs directory was missing.

Ouch, good catch!

> The affected window is:
>=20
>   slab_debugfs_init()
>     slab_debugfs_root =3D debugfs_create_dir(...)
>     list_for_each_entry(s, &slab_caches, list)
>       debugfs_slab_add(s)
>=20
>   kmem_cache_create(..., SLAB_STORE_USER, ...)
>     do_kmem_cache_create()
>       if (slab_state <=3D UP)
>         return without debugfs entries
>=20
>   slab_sysfs_init()
>     slab_state =3D FULL
>=20
> Initialize the debugfs root and add debugfs entries while holding
> slab_mutex, walking slab_caches exactly once and handling both sysfs
> and debugfs entries in the same pass. This gives the sysfs and debugfs
> initialization an explicit order and prevents caches from being
> created between the debugfs scan and slab_state reaching FULL.
>=20
> Gate the new slab_late_init() on either sysfs or debugfs being enabled,=

> with the slab_kset creation and alias_list processing factored into
> helpers that have empty no-sysfs variants, as suggested by Vlastimil
> Babka. On slab_kset_init() failure, slab_state stays below FULL so
> kmem_cache_create() keeps taking the early-boot path, matching prior
> behavior.
>=20
> Guard debugfs_slab_release() against an uninitialized debugfs root,
> since the root is now created later and a cache may be released before
> it exists.
>=20
> Fixes: 1a5ad30b89b4 ("mm: slub: make slab_sysfs_init() a late_initcall"=
)
> Cc: stable@vger.kernel.org
> Suggested-by: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------9udFvOgVqgbui5kv0H8J1YIY--

--------------U4bzCzUcpYSrc5aXCF3vg0O0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCamrLPQAKCRCGXBN6rc5S
1v+LAQCGTC8YVdB3hRg3AfCDHJVmxbhhis44MtfJ8l9+dz/lGgEAp/UqMuKJOrY9
bw+qmoUwrTnDKzuWN9moPkZ9nVc1aA0=
=DIZv
-----END PGP SIGNATURE-----

--------------U4bzCzUcpYSrc5aXCF3vg0O0--
