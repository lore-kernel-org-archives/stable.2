Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776073;
	b=aPlck6fUkd8Qzfqj0O1H9GL4IxyeBtKPMLXGmJHNfo4zT16poHp7/RF6dqADFZIV8Xll
	 FJAr2YcTbQBIxEXJ+ZHO4ViKeHKwX5uf4woFQrFTS7Z2u24184mBGB0FgPTVycBXiBnG9
	 1kTH1JaW+v7Dp9+tbUzJRFL9fdjXGve/mDcxg1Fz1H/27dauySs9OJMR4V25gwpETYnZf
	 VohOJU+Q21hcxBBJaQI0/gyn0FN67WTAmHBVIZCfygArAD/PKLIRNBJpRQD0py/H4h9HH
	 NwgnAmKt2piazlPs/wn8B7DyPnrZVKYwEuPJsA6hlpGq3XDTX1sVxqRoC3QiKSMu6OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776073;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=LgFroUGFKpdEpsdgtkKaDpgGtTJdhJhgl9e77IsbomE=;
	b=2JS/N8Zmi0VWY7bRyCXU/TNaI2Mgi7XwdpCNcfM35qpqEX6rVYGDVqtff/TmpmcI2BeK
	 V59PSdmrvijbL5GAlHvHUZQAZPonZ3GJQNkmDHKrmPyW9yuTalPzgI/sx2hDaoN7GavNC
	 0rj5WM9C1w1GEu69n5NEUFYTZQ9v3uf6RzHG0esoqoq1cL6nxhFCD3OZcieSoDN4UL5VV
	 q0gYVG/zZ4gIatIJPjzoQ7tQbJBYUB1ygwlA2wizkI0hIVxwZW2Ozf1TtBGbTfOI43HvW
	 9FqUWJOSaHYw6871f0xHqlEFO0FymT3W5WM66cnzp9WgbyI6NLxrvuEn2zsw7xABkTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="t/rnVYY3";
	arc=none smtp.remote-ip=91.218.175.174
Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3B2606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F3B2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=t/rnVYY3
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2flBiNkjPpyfuO38KJqLh8zZK1p8JBEOfsDzZidYjyA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793776070; v=1; x=1794380870;
 b=t/rnVYY3owlF9B/6NtFckGgyA19CWUTTyL3pLVIOvGqUnGJ7tCi4XaPVtlcwIyaMDW+FPOjN
 pbPizGmJMRRX7D15+nJszteY5KsCV/DKFJvFaLVh97yAEU0fAycrNFIIbq4ikhJpcNZ8CUQ93h+
 gLcCCIEDi8GKMqxs4WsHoIvk=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e13f75cac8a9b814;
	Wed, 04 Nov 2026 07:07:50 +0000
X-Mizu-Trace-ID: e13f75cac8a9b814
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
Subject: Re: [PATCH 2/4] mm: hugetlb: skip CMA allocations under
 PF_MEMALLOC_PIN
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <8b7f6573-ed12-494f-9210-d6f6dbf01567@linux.dev>
Date: Wed, 4 Nov 2026 15:07:23 +0800
Cc: osalvador@suse.de,
 David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org,
 azpijr@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2DE679F1-C87F-4222-A710-C87CDE86D333@linux.dev>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
 <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
 <8b7f6573-ed12-494f-9210-d6f6dbf01567@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 4, 2026, at 11:27, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> Hi Muchun,

Hi,

>=20
> On 11/3/26 6:56 PM, Muchun Song wrote:
>>> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>>>=20
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>=20
>>> With gigantic overcommit enabled, a fault during long-term pinning
>>> can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.
>>>=20
>>> The folio must then be migrated before it can be pinned. However,
>>> fresh gigantic migration targets are not supported, so pinning fails
>>> when the HugeTLB pool has no suitable target, even if the original
>>> fault could have allocated pinnable memory outside CMA.
>>>=20
>>> Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
>>> try the non-CMA fallback, or fail when allocation is restricted to =
CMA.
>> Wait... I think my Acked-by got ahead of me here. :)
>> There seems to be a rather odd distinction that GUP is missing.
>> The usual reason long-term GUP must migrate a page out of a
>> MIGRATE_CMA pageblock is that the page was only borrowed from CMA by =
the
>> normal page allocator.  The corresponding CMA bitmap range is still
>> available, so a future CMA allocation relies on being able to migrate
>> that page away.  A long-term pin would prevent that.
>> However, a HugeTLB folio returned by
>> hugetlb_cma_alloc_frozen_folio() is different.  It is the actual CMA
>> allocation, not merely a movable page that happens to reside in a
>> MIGRATE_CMA pageblock.  Its range has already been marked allocated =
in
>> the hugetlb CMA bitmap.
>> Therefore, CMA cannot allocate that range again until the HugeTLB =
folio
>> is freed anyway.  Long-term pinning the folio does not seem to make =
the
>> CMA area any less available than keeping the HugeTLB folio mapped for
>> the same amount of time.
>> folio_is_longterm_pinnable() currently only sees MIGRATE_CMA and does
>> not distinguish these two cases.  In that light, rejecting
>> PF_MEMALLOC_PIN in hugetlb_cma_alloc_frozen_folio() looks like =
working
>> around an overly broad GUP classification.  It also means that
>> hugetlb_cma_only users will fail the fault, while other users may =
consume
>> a gigantic contiguous range outside the dedicated hugetlb CMA area =
even
>> when that area has free space.
>> Would it make more sense to fix the long-term GUP check instead, so =
that
>> an explicitly CMA-allocated HugeTLB folio is considered pinnable, =
while
>> ordinary pages merely borrowed from MIGRATE_CMA pageblocks remain =
unpinnable?
>=20
> Make sense!
>=20
> I'll replace this patch with an exception for HPG_cma folios in the
> MIGRATE_CMA check. This also lets the HugeTLB allocator select =
preallocated
> CMA folios during long-term pinning. MIGRATE_ISOLATE and ZONE_MOVABLE
> remain restricted.
>=20
> Fresh CMA allocations under PF_MEMALLOC_PIN also need to skip ranges
> in ZONE_MOVABLE. Returning -EBUSY here lets CMA try its remaining =
ranges.
>=20
> The incremental diff against this patch is below.
>=20
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 8555d38a97b1..7fd1b6e65b58 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -21,11 +21,13 @@
> #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
>=20
> struct cma;
> +struct folio;
>=20
> extern unsigned long totalcma_pages;
> extern phys_addr_t cma_get_base(const struct cma *cma);
> extern unsigned long cma_get_size(const struct cma *cma);
> extern const char *cma_get_name(const struct cma *cma);
> +bool cma_folio_is_pinnable(struct folio *folio);
>=20
> extern int __init cma_declare_contiguous_nid(phys_addr_t base,
> 			phys_addr_t size, phys_addr_t limit,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cb993a1d0728..d15810be7d96 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3,6 +3,7 @@
> #define _LINUX_MM_H
>=20
> #include <linux/args.h>
> +#include <linux/cma.h>
> #include <linux/errno.h>
> #include <linux/mmdebug.h>
> #include <linux/gfp.h>
> @@ -2975,14 +2976,16 @@ static inline bool is_zero_folio(const struct =
folio *folio)
> 	return is_zero_page(&folio->page);
> }
>=20
> -/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
> +/* Borrowed CMA pages and ZONE_MOVABLE folios cannot be pinned long =
term. */
> #ifdef CONFIG_MIGRATION
> static inline bool folio_is_longterm_pinnable(struct folio *folio)
> {
> #ifdef CONFIG_CMA
> 	int mt =3D folio_migratetype(folio);
>=20
> -	if (mt =3D=3D MIGRATE_CMA || mt =3D=3D MIGRATE_ISOLATE)
> +	if (mt =3D=3D MIGRATE_ISOLATE)
> +		return false;
> +	if (mt =3D=3D MIGRATE_CMA && !cma_folio_is_pinnable(folio))
> 		return false;

Actually, we do not need cma_folio_is_pinnable(), does the following =
work for you?

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2982,6 +2982,9 @@ static inline bool =
folio_is_longterm_pinnable(struct folio *folio)
 #ifdef CONFIG_CMA
        int mt =3D folio_migratetype(folio);

+       if (folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio))
+               return true;
+
        if (mt =3D=3D MIGRATE_CMA || mt =3D=3D MIGRATE_ISOLATE)
                return false;
 #endif

> #endif
> /* The zero page can be "pinned" but gets special handling. */
> diff --git a/mm/cma.c b/mm/cma.c
> index a10ea37a261d..c2814f54f86a 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -27,6 +27,7 @@
> #include <linux/log2.h>
> #include <linux/cma.h>
> #include <linux/highmem.h>
> +#include <linux/hugetlb.h>
> #include <linux/io.h>
> #include <linux/kmemleak.h>
> #include <trace/events/cma.h>
> @@ -55,6 +56,12 @@ const char *cma_get_name(const struct cma *cma)
> }
> EXPORT_SYMBOL_GPL(cma_get_name);
>=20
> +bool cma_folio_is_pinnable(struct folio *folio)
> +{
> +	/* Explicit HugeTLB CMA allocations own their bitmap ranges. */
> +	return folio_test_hugetlb(folio) && =
folio_test_hugetlb_cma(folio);
> +}
> +
> static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
> 					     unsigned int align_order)
> {
> @@ -792,6 +799,11 @@ static int cma_range_alloc(struct cma *cma, =
struct cma_memrange *cmr,
> 	int ret =3D -EBUSY;
> 	struct page *page =3D NULL;
>=20
> + 	/* Each range lies within one zone; try other ranges if needed. =
*/
> +	if ((current->flags & PF_MEMALLOC_PIN) &&
> + 	    is_zone_movable_page(pfn_to_page(cmr->base_pfn)))
> +		return -EBUSY;

I don't know why we need this.

Thanks,
Muchun

> +
> 	mask =3D cma_bitmap_aligned_mask(cma, align);
> 	offset =3D cma_bitmap_aligned_offset(cma, cmr, align);
> 	bitmap_maxno =3D cma_bitmap_maxno(cma, cmr);
> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
> index dde1c866406f..95fd2d190f0d 100644
> --- a/mm/hugetlb_cma.c
> +++ b/mm/hugetlb_cma.c
> @@ -62,9 +62,6 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int =
order, gfp_t gfp_mask,
> 	if (!hugetlb_cma_size)
> 		return NULL;
>=20
> -	if (current->flags & PF_MEMALLOC_PIN)
> -		return NULL;
> -
> retry_cpuset:
> 	if (!nodemask) {
> 		cpuset_mems_cookie =3D read_mems_allowed_begin();
>=20
> Thanks,
> Qi
>=20
>> Thanks,
>> Muchun
>>>=20
>>> Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic =
hugepages")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>> mm/hugetlb_cma.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>=20
>>> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
>>> index 95fd2d190f0d2..dde1c866406fb 100644
>>> --- a/mm/hugetlb_cma.c
>>> +++ b/mm/hugetlb_cma.c
>>> @@ -62,6 +62,9 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int =
order, gfp_t gfp_mask,
>>> 	if (!hugetlb_cma_size)
>>> 		return NULL;
>>>=20
>>> +	if (current->flags & PF_MEMALLOC_PIN)
>>> +		return NULL;
>>> +
>>> retry_cpuset:
>>> 	if (!nodemask) {
>>> 		cpuset_mems_cookie =3D read_mems_allowed_begin();
>>> --=20
>>> 2.54.0


