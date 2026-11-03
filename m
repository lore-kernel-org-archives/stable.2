Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703417;
	b=CLGs1TdqjVXdiyOszMp6jjmBt3TK6K+EYwwIrQTwQcMojRFO7ElSrXCGEhIO3aTW8eUp
	 e8BaTLwjMpuN0Q77kv3pLytbkOiYdA6hfG3IPXGQ80RggB1K2BQHlAF9qU/91jBpLKKc3
	 V3JhCNn3nunF9lS5dtfabTwa1XmISAMcmFs+8QmcRdqOZazyWlsbsUGvRaUnoNKlvi0Gy
	 A4H6wzK/PsgIw7C60rMFvEkNzM8y4TZsbt9yYqaroeTCTpdcl9vb2GZt8ymUYzVxbzkBa
	 SB1r3AQhjguzts+A3ARj2AzCpKlRK7qA0FE4MUj3numSDcg6YAON/wYKPt2EE5Odkaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703417;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=GLCdQ7yyYZVSa1Z/8WV0HEWdcD0ZR8tpxoUJ6zf3iks=;
	b=u6/fGbZsew3w2W6c2je9AhHmSfY0m4DJNPVPKzkOY+F8HocdfuMVdtERxM/tT/wWvTTc
	 qvMzNjTEjWwcGg86tUFE7a5e01fO7lBOn6MCM4n4ArAKug/F0Cm8x6Dk+aLclm5J/fZoo
	 /v09nghsOdKSsc52CJ9O7xFl/20kul+pWIts2PFrXRceka5Ib6+RzATIfBznsRwqV2ucN
	 hoPx+qG603nWsKqv+j7eHB1GtDryVCbqzzH2CUvLJQ7aH2CQZ7lUn9DYJ7XLU3yoADIBB
	 H4GQasA1SqNcCq4mrORdQQLxz65veUdgiKzbJPpPNjkfoca+q7v6Mk2rSCOrykAIrUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aa6IZpZn;
	arc=none smtp.remote-ip=91.218.175.228
Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D441606BF94
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D441606BF94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aa6IZpZn
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xul2O4mVtDcfKlb1bMxbQAbRnQ4n0rOnY7nn3uF3ixE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793703412; v=1; x=1794308212;
 b=aa6IZpZnpwjfXx5YqcLcx/jmDShkIWTDUVK5gqxxFWM7R47qsYNwFc/ggSZEAuRul6ZudzED
 CAl5oZzmHsnQl1OWtn6xDLJWuVrhiLD8fv673/DqoybyJLrK+Lit8jrgB/KOcCtl076yre4ac1L
 Ft/5XqeALLMzBql+ozBSI5CU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 6423a6be375d5d61;
	Tue, 03 Nov 2026 10:56:51 +0000
X-Mizu-Trace-ID: 6423a6be375d5d61
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
In-Reply-To: <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
Date: Tue, 3 Nov 2026 18:56:23 +0800
Cc: osalvador@suse.de,
 David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org,
 azpijr@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> With gigantic overcommit enabled, a fault during long-term pinning
> can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.
>=20
> The folio must then be migrated before it can be pinned. However,
> fresh gigantic migration targets are not supported, so pinning fails
> when the HugeTLB pool has no suitable target, even if the original
> fault could have allocated pinnable memory outside CMA.
>=20
> Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
> try the non-CMA fallback, or fail when allocation is restricted to =
CMA.

Wait... I think my Acked-by got ahead of me here. :)

There seems to be a rather odd distinction that GUP is missing.

The usual reason long-term GUP must migrate a page out of a
MIGRATE_CMA pageblock is that the page was only borrowed from CMA by the
normal page allocator.  The corresponding CMA bitmap range is still
available, so a future CMA allocation relies on being able to migrate
that page away.  A long-term pin would prevent that.

However, a HugeTLB folio returned by
hugetlb_cma_alloc_frozen_folio() is different.  It is the actual CMA
allocation, not merely a movable page that happens to reside in a
MIGRATE_CMA pageblock.  Its range has already been marked allocated in
the hugetlb CMA bitmap.

Therefore, CMA cannot allocate that range again until the HugeTLB folio
is freed anyway.  Long-term pinning the folio does not seem to make the
CMA area any less available than keeping the HugeTLB folio mapped for
the same amount of time.

folio_is_longterm_pinnable() currently only sees MIGRATE_CMA and does
not distinguish these two cases.  In that light, rejecting
PF_MEMALLOC_PIN in hugetlb_cma_alloc_frozen_folio() looks like working
around an overly broad GUP classification.  It also means that
hugetlb_cma_only users will fail the fault, while other users may =
consume
a gigantic contiguous range outside the dedicated hugetlb CMA area even
when that area has free space.

Would it make more sense to fix the long-term GUP check instead, so that
an explicitly CMA-allocated HugeTLB folio is considered pinnable, while
ordinary pages merely borrowed from MIGRATE_CMA pageblocks remain =
unpinnable?

Thanks,
Muchun

>=20
> Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic =
hugepages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> mm/hugetlb_cma.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
> index 95fd2d190f0d2..dde1c866406fb 100644
> --- a/mm/hugetlb_cma.c
> +++ b/mm/hugetlb_cma.c
> @@ -62,6 +62,9 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int =
order, gfp_t gfp_mask,
> 	if (!hugetlb_cma_size)
> 		return NULL;
>=20
> +	if (current->flags & PF_MEMALLOC_PIN)
> +		return NULL;
> +
> retry_cpuset:
> 	if (!nodemask) {
> 		cpuset_mems_cookie =3D read_mems_allowed_begin();
> --=20
> 2.54.0
>=20

