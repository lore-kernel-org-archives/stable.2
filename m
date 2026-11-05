Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793855655;
	b=0lY0NH02Mxqx4J0cZU7w+oBE+LkuiktO7+7LDQdtyA/YlWMK4fq4BUuqNWmX6I6JcXz/
	 yTzUtLpP1GSBcJ4lDd4CKRBz57ddnbn8u5Cd9dGpS/h0r/By0rYFzsMmUGwt8/w4zyk/5
	 xQWhlHHi2JyLFu93spcUfZ22WdzwDydEpUfqyknDyYU7l3uLMBH86rx90KY6ItSwFU8AO
	 pew8b1H4fDypoFOYDvKaMegX/8tQf2lEQnlfvqwpxt6jx8xu/zWLJsBicEJdjCY7RrQ51
	 HdSRCmcJKdWeB7kV3/l9eKl7wXx6E6wVknm4EXNKW+BWZIpAHM2G5MvUozOgguKNRDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793855655;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=XEqA3W+i3V3yHQk0EklCgzFHb8brEsF0K0ZpN1y8TEQ=;
	b=LBDNhcCj7zk/Q1c46lvFupcKOTUye3zumaas8tKd4+e/2HrOcxfd9rNWJMOcfsbusa+1
	 RJEl8pIT1idHMdNFCFhQhcaanT3RIZp6t/d7b+fz5RJRiSPXjWsRYObK4Kmf/QVsdH7JZ
	 4OUXancGTxncS8qlibajRpTp0QANYrDzGDNMPFRN7W+tX2EPJTdPYoyvlJqT2rOcHchrf
	 7VSBe2eXoa9dJyIeZeVU5OUx35FtIDWvim560pu2S58527AttZuH+NE5NAYlw7snJTOWm
	 74l5iYPZaJOA1pE6gjNpNMssnx58ihSygg06YNEKqMjymR64Txc5FmP1+nYsfeOEeCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jv2JoSDW;
	arc=none smtp.remote-ip=95.215.58.123
Received: from mta1.migadu.com (out-123.mta1.migadu.com [95.215.58.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B7606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 05:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 078B7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Jv2JoSDW
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xnhL49rU8Si9Gh8RiV1Fb+XbOATfd6SeIOCBPYd10uQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793855650; v=1; x=1794460450;
 b=Jv2JoSDWT8rRWOQPcqzFEkz0+ZUPr1snGqvUef4+jCsKVoJHOTVZo2HCYgK/Zy8xaFT4GN/i
 /cB/738Q14uaxOMvSUEIDrroWkDHCDcWwFyjDGJqNZZtdoTUnY8L2MjZwbUymCqjA6nXNXt9+Qk
 pAktt9j85Nu4FhP17wVMQfhQ=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f77242cba51ecc71;
	Thu, 05 Nov 2026 05:14:10 +0000
X-Mizu-Trace-ID: f77242cba51ecc71
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
Subject: Re: [PATCH v2 2/4] mm: gup: allow long-term pins of CMA-allocated
 HugeTLB folios
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>
Date: Thu, 5 Nov 2026 13:13:57 +0800
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
Message-Id: <8F5F930D-A05E-4255-8E70-2567921A92A0@linux.dev>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <818fb0b4bbb234e4a2bd0552d61634f1a8431616.1793850539.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 5, 2026, at 12:07, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> Long-term pinning treats explicitly CMA-allocated HugeTLB folios as
> unpinnable, causing unnecessary migration or pinning failures.
>=20
> These folios already own their CMA bitmap ranges, and memory blocks
> overlapping CMA areas cannot be offlined. Allow HugeTLB folios with
> HPG_cma to be pinned directly, including in ZONE_MOVABLE.
>=20
> Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic =
hugepages using cma")
> Cc: stable@vger.kernel.org
> Suggested-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

But a nit bellow.

> ---
> include/linux/mm.h | 29 +----------------------------
> mm/gup.c           | 31 +++++++++++++++++++++++++++++++
> 2 files changed, 32 insertions(+), 28 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2d0b8a4c9974f..75dd40265d3f4 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2975,35 +2975,8 @@ static inline bool is_zero_folio(const struct =
folio *folio)
> 	return is_zero_page(&folio->page);
> }
>=20
> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
> #ifdef CONFIG_MIGRATION
> -static inline bool folio_is_longterm_pinnable(struct folio *folio)
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
> index 2b405cce2ca5c..e8503141bb275 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2216,6 +2216,37 @@ struct page *get_dump_page(unsigned long addr, =
int *locked)
>=20
> #ifdef CONFIG_MIGRATION
>=20
> +bool folio_is_longterm_pinnable(struct folio *folio)
> +{
> +#ifdef CONFIG_CMA
> +	int mt =3D folio_migratetype(folio);
> +
> +	/* Explicit HugeTLB CMA allocations own their bitmap ranges. */

The description of "bitmap ranges" is weird, making me think what's the =
meaning of
bitmap. Please use more generic description here.

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

