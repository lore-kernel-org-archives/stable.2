Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794382996;
	b=aALR++MvXOCUZl4mw7dV8caZHcz6M52bKN8hoPX4hMv1ThsNRoWcuZFi41rf4egU/KRW
	 NmBfE7P8cz/OLWYcBaO8aqtSqC7823AwVn7SEW7D+gTSthHG0+9hble0Vl0/iwVjdzTXs
	 sZzC5JE74Id+Sk4nrRrNNHsHzVWLfd/Xnpt3/hqYrVxkxLn4DyLFq0ERuSw/1fw3ie8dH
	 uoNSveHrA69DEYWBTi+kvAW9hiVKIMARa2t8AZs8U1gZJaMUsb4fNR69HZYvk4pVMIMg2
	 EkuYBpkwmfYnoTk6dz6VVR8gtJ8ktahJo/jg2+hewYuO+YuwKovNHXV/KG/UUZQxORQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794382996;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=EfxdzkdgDHIptdiFFicHU4j+CsK16rJHdQjUlG9Ac2o=;
	b=hAThczqMtw5WX6/iqH0eFKDCOz0eKpe9R1LEjP4VXoWS+l57ckS5+jHALeELiKpXQnaB
	 y/ASQDDqZUbSk35kNIIKnfB/dWHYgS2MTiCQ8YVeCgnPZIQLx72kFL2efplerCA/ukZSh
	 o763TmLV4AZZi2F6V+86bhHarUojkiBDhfLqio4FROOJixkoNVvpfGMUImkOV9MBcSpur
	 o/fU4ml4BN7EPhMxpVrzVNx4VUviNA/5Gfd0lQt5r79kkXWRFKZ7+JEawJjJQ/q0w04ie
	 cn/T/nTkv8/+LNvqUcrlQ0e7GOGbkRG6Oh3rU3CHZKyA6BiCWch5QhU2ex6AkNhanUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kcr8dbbk;
	arc=none smtp.remote-ip=91.218.175.233
Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 07:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB8C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Kcr8dbbk
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2ou7idqYN0vwf8nRLylpa5vOfvnrhR/VXDNnnd6BgTQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794382992; v=1; x=1794987792;
 b=Kcr8dbbk8h+TSq+Yyw2YDIeSvwq6yLwpn8tc9FoowpR6nJsm66vFNZV0q63S6RgLxmroBChc
 WecxsGdtXIm0yDJpOcwWcwvoeDE1fmBqgl2/rqwDO3dDRbmCq7NHYAHz0g9Pc24beyB4ykRUhPD
 IYs1LeyW5IqEBhh54uHO5AjM=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 12f4ebcce8353a82;
	Wed, 11 Nov 2026 07:43:12 +0000
X-Mizu-Trace-ID: 12f4ebcce8353a82
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v4 2/3] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <503c9f6d869e3206c6fd591de962c3d619b73825.1794379433.git.zhengqi.arch@bytedance.com>
Date: Wed, 11 Nov 2026 15:42:56 +0800
Cc: osalvador@suse.de,
 David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org,
 azpijr@gmail.com,
 Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <80FED512-77D2-4D49-BAE5-745CE1F711CA@linux.dev>
References: <cover.1794379433.git.zhengqi.arch@bytedance.com>
 <503c9f6d869e3206c6fd591de962c3d619b73825.1794379433.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 11, 2026, at 14:46, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
> unpinnable, causing unnecessary migration or pinning failures.
>=20
> These folios already own their CMA bitmap ranges, and memory blocks

Commit message needs updating to bitmap as well.

> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>=20
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic =
hugepages using cma")
> Cc: stable@vger.kernel.org
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
> include/linux/mm.h | 29 +----------------------------
> mm/gup.c           | 31 +++++++++++++++++++++++++++++++
> 2 files changed, 32 insertions(+), 28 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b0da9be413098..47d1d96bfc7fd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2954,35 +2954,8 @@ static inline bool is_zero_folio(const struct =
folio *folio)
> 	return is_zero_page(&folio->page);
> }
>=20
> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
> #ifdef CONFIG_MIGRATION
> -static inline bool folio_is_longterm_pinnable(struct folio *folio)

I think David prefer to move this function first, then fix it in a =
separate patch,
right?

Thanks,
Muchun

> -{
> -#ifdef CONFIG_CMA
> -	int mt =3D folio_migratetype(folio);
> -
> -	if (mt =3D=3D MIGRATE_CMA || mt =3D=3D MIGRATE_ISOLATE)
> -		return false;
> -#endif
> -	/* The zero page can be "pinned" but gets special handling. */
> -	if (is_zero_folio(folio))
> -		return true;
> -
> -	/* Coherent device memory must always allow eviction. */
> -	if (folio_is_device_coherent(folio))
> -		return false;
> -
> -	/*
> -	 * Filesystems can only tolerate transient delays to truncate =
and
> -	 * hole-punch operations
> -	 */
> -	if (folio_is_fsdax(folio))
> -		return false;
> -
> -	/* Otherwise, non-movable zone folios can be pinned. */
> -	return !folio_is_zone_movable(folio);
> -
> -}
> +bool folio_is_longterm_pinnable(struct folio *folio);
> #else
> static inline bool folio_is_longterm_pinnable(struct folio *folio)
> {
> diff --git a/mm/gup.c b/mm/gup.c
> index ebbfee09b7278..fdafc5a1b78ed 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2219,6 +2219,37 @@ struct page *get_dump_page(unsigned long addr, =
int *locked)
>=20
> #ifdef CONFIG_MIGRATION
>=20
> +bool folio_is_longterm_pinnable(struct folio *folio)
> +{
> +#ifdef CONFIG_CMA
> +	int mt =3D folio_migratetype(folio);
> +
> +	/* These HugeTLB folios own the CMA memory, so they can be =
long-term pinned. */
> +	if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
> +		return true;
> +
> +	if (mt =3D=3D MIGRATE_CMA || mt =3D=3D MIGRATE_ISOLATE)
> +		return false;
> +#endif
> +	/* The zero page can be "pinned" but gets special handling. */
> +	if (is_zero_folio(folio))
> +		return true;
> +
> +	/* Coherent device memory must always allow eviction. */
> +	if (folio_is_device_coherent(folio))
> +		return false;
> +
> +	/*
> +	 * Filesystems can only tolerate transient delays to truncate =
and
> +	 * hole-punch operations
> +	 */
> +	if (folio_is_fsdax(folio))
> +		return false;
> +
> +	/* Otherwise, non-movable zone folios can be pinned. */
> +	return !folio_is_zone_movable(folio);
> +}
> +
> /*
>  * An array of either pages or folios ("pofs"). Although it may seem =
tempting to
>  * avoid this complication, by simply interpreting a list of folios as =
a list of
> --=20
> 2.54.0
>=20

