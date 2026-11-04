Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762889;
	b=LLzT2u4Bp2AZVJlCYl6uqLNLSVXoCejW1Lv2GGYKg4i25mDS3vinu6QWusB5BzCxDw2S
	 yGy8NGoA11s/oAIVymLSWkRkCZseA4s/3iMVyNMZ7+XOfmDSkVTfvkIlKKgwMWvjyViZ4
	 P6CZM4gaeIRF8CHvFXhox8n8WkGROqXXYW7rAvxZHifkxqieJOBGf7EnuLqU5APQdeKzU
	 iCVV2BbMZKKO8Wn2Sd8ndAYdNcB+c2rIr1HJBT74Q1w06z6y99NwzK0m6nPcyM6bCAFga
	 YV3pNgDFfL2oVIu9NmLiuDJE6jRNVqOjnzIX7nLs20RVGLca0MVuMW4LsAISX6yrHLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762889;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=j371QPGtCFPV+Osbl1SGKaUOxa6Nr78TllBqJLarcOY=;
	b=soLM0k6XsehdG3mdMsl0j15Fm5ddL1F/c6B4rbFHWl6+RqZnxJwezG8E7WmLwN8gZFEL
	 1Dmwy7rte3mMxIUl55veDx9xjSAGiy07Z1ls/6BfkodUNCZdwvxoXJmIaZQF5sQE6uh8i
	 7g76CTgbEP1Kvhwofn9wKaFXpvYiRuQw5B6MCkyCUXwX/TcVdF90U9In5PQH3x9ApTe3s
	 QkiP1zOxP7AR6WImkpOTfhemvE6/uF9yK4odqb3jsWk4K/Z7GhNXRo2FgC+SLr2wikS2I
	 WZMUMaij83PgRkGvW+wdEGk6Z+mkh7U3sjrv4EZXyddTbNxLBGU668r8TZrLXjjZKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="GH3/5Rdq";
	arc=none smtp.remote-ip=95.215.58.230
Received: from mta1.migadu.com (out-230.mta1.migadu.com [95.215.58.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE3C606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 03:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAE3C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GH3/5Rdq
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GqvAQHYdWiYyT2aaCpv6yjKE3M/YhdWdm4Wb8nulwQ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793762885; v=1; x=1794367685;
 b=GH3/5Rdqw2twps5UKA5/nQBLEGOlXJwRbpFzL2sc0jprsLwog/p2LnuitbVMmOcF+CJxXoCS
 21SciKaEuno2FSI6O/BUzvSIU1T5RD4CPedSDelDDyxqA3taVK3prRVx3tI+E+s+T67bfxLJCnq
 61S11zOHNu1fsSMZCplZFCFQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aafce94ffd4739ab;
	Wed, 04 Nov 2026 03:28:04 +0000
X-Mizu-Trace-ID: aafce94ffd4739ab
X-Migadu-Flow: FLOW_OUT
Message-ID: <8b7f6573-ed12-494f-9210-d6f6dbf01567@linux.dev>
Date: Wed, 4 Nov 2026 11:27:59 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm: hugetlb: skip CMA allocations under
 PF_MEMALLOC_PIN
To: Muchun Song <muchun.song@linux.dev>
Cc: osalvador@suse.de, David Hildenbrand <david@kernel.org>,
 akpm@linux-foundation.org, azpijr@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
 <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <4EC5E593-7537-4659-879C-95ECC2224D2F@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Muchun,

On 11/3/26 6:56 PM, Muchun Song wrote:
> 
> 
>> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> With gigantic overcommit enabled, a fault during long-term pinning
>> can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.
>>
>> The folio must then be migrated before it can be pinned. However,
>> fresh gigantic migration targets are not supported, so pinning fails
>> when the HugeTLB pool has no suitable target, even if the original
>> fault could have allocated pinnable memory outside CMA.
>>
>> Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
>> try the non-CMA fallback, or fail when allocation is restricted to CMA.
> 
> Wait... I think my Acked-by got ahead of me here. :)
> 
> There seems to be a rather odd distinction that GUP is missing.
> 
> The usual reason long-term GUP must migrate a page out of a
> MIGRATE_CMA pageblock is that the page was only borrowed from CMA by the
> normal page allocator.  The corresponding CMA bitmap range is still
> available, so a future CMA allocation relies on being able to migrate
> that page away.  A long-term pin would prevent that.
> 
> However, a HugeTLB folio returned by
> hugetlb_cma_alloc_frozen_folio() is different.  It is the actual CMA
> allocation, not merely a movable page that happens to reside in a
> MIGRATE_CMA pageblock.  Its range has already been marked allocated in
> the hugetlb CMA bitmap.
> 
> Therefore, CMA cannot allocate that range again until the HugeTLB folio
> is freed anyway.  Long-term pinning the folio does not seem to make the
> CMA area any less available than keeping the HugeTLB folio mapped for
> the same amount of time.
> 
> folio_is_longterm_pinnable() currently only sees MIGRATE_CMA and does
> not distinguish these two cases.  In that light, rejecting
> PF_MEMALLOC_PIN in hugetlb_cma_alloc_frozen_folio() looks like working
> around an overly broad GUP classification.  It also means that
> hugetlb_cma_only users will fail the fault, while other users may consume
> a gigantic contiguous range outside the dedicated hugetlb CMA area even
> when that area has free space.
> 
> Would it make more sense to fix the long-term GUP check instead, so that
> an explicitly CMA-allocated HugeTLB folio is considered pinnable, while
> ordinary pages merely borrowed from MIGRATE_CMA pageblocks remain unpinnable?

Make sense!

I'll replace this patch with an exception for HPG_cma folios in the
MIGRATE_CMA check. This also lets the HugeTLB allocator select preallocated
CMA folios during long-term pinning. MIGRATE_ISOLATE and ZONE_MOVABLE
remain restricted.

Fresh CMA allocations under PF_MEMALLOC_PIN also need to skip ranges
in ZONE_MOVABLE. Returning -EBUSY here lets CMA try its remaining ranges.

The incremental diff against this patch is below.

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 8555d38a97b1..7fd1b6e65b58 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -21,11 +21,13 @@
  #define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)

  struct cma;
+struct folio;

  extern unsigned long totalcma_pages;
  extern phys_addr_t cma_get_base(const struct cma *cma);
  extern unsigned long cma_get_size(const struct cma *cma);
  extern const char *cma_get_name(const struct cma *cma);
+bool cma_folio_is_pinnable(struct folio *folio);

  extern int __init cma_declare_contiguous_nid(phys_addr_t base,
  			phys_addr_t size, phys_addr_t limit,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cb993a1d0728..d15810be7d96 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3,6 +3,7 @@
  #define _LINUX_MM_H

  #include <linux/args.h>
+#include <linux/cma.h>
  #include <linux/errno.h>
  #include <linux/mmdebug.h>
  #include <linux/gfp.h>
@@ -2975,14 +2976,16 @@ static inline bool is_zero_folio(const struct 
folio *folio)
  	return is_zero_page(&folio->page);
  }

-/* MIGRATE_CMA and ZONE_MOVABLE do not allow pin folios */
+/* Borrowed CMA pages and ZONE_MOVABLE folios cannot be pinned long 
term. */
  #ifdef CONFIG_MIGRATION
  static inline bool folio_is_longterm_pinnable(struct folio *folio)
  {
  #ifdef CONFIG_CMA
  	int mt = folio_migratetype(folio);

-	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+	if (mt == MIGRATE_ISOLATE)
+		return false;
+	if (mt == MIGRATE_CMA && !cma_folio_is_pinnable(folio))
  		return false;
  #endif
  	/* The zero page can be "pinned" but gets special handling. */
diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261d..c2814f54f86a 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -27,6 +27,7 @@
  #include <linux/log2.h>
  #include <linux/cma.h>
  #include <linux/highmem.h>
+#include <linux/hugetlb.h>
  #include <linux/io.h>
  #include <linux/kmemleak.h>
  #include <trace/events/cma.h>
@@ -55,6 +56,12 @@ const char *cma_get_name(const struct cma *cma)
  }
  EXPORT_SYMBOL_GPL(cma_get_name);

+bool cma_folio_is_pinnable(struct folio *folio)
+{
+	/* Explicit HugeTLB CMA allocations own their bitmap ranges. */
+	return folio_test_hugetlb(folio) && folio_test_hugetlb_cma(folio);
+}
+
  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
  					     unsigned int align_order)
  {
@@ -792,6 +799,11 @@ static int cma_range_alloc(struct cma *cma, struct 
cma_memrange *cmr,
  	int ret = -EBUSY;
  	struct page *page = NULL;

+	/* Each range lies within one zone; try other ranges if needed. */
+	if ((current->flags & PF_MEMALLOC_PIN) &&
+	    is_zone_movable_page(pfn_to_page(cmr->base_pfn)))
+		return -EBUSY;
+
  	mask = cma_bitmap_aligned_mask(cma, align);
  	offset = cma_bitmap_aligned_offset(cma, cmr, align);
  	bitmap_maxno = cma_bitmap_maxno(cma, cmr);
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index dde1c866406f..95fd2d190f0d 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -62,9 +62,6 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int 
order, gfp_t gfp_mask,
  	if (!hugetlb_cma_size)
  		return NULL;

-	if (current->flags & PF_MEMALLOC_PIN)
-		return NULL;
-
  retry_cpuset:
  	if (!nodemask) {
  		cpuset_mems_cookie = read_mems_allowed_begin();

Thanks,
Qi

> 
> Thanks,
> Muchun
> 
>>
>> Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> mm/hugetlb_cma.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
>> index 95fd2d190f0d2..dde1c866406fb 100644
>> --- a/mm/hugetlb_cma.c
>> +++ b/mm/hugetlb_cma.c
>> @@ -62,6 +62,9 @@ struct folio *hugetlb_cma_alloc_frozen_folio(int order, gfp_t gfp_mask,
>> 	if (!hugetlb_cma_size)
>> 		return NULL;
>>
>> +	if (current->flags & PF_MEMALLOC_PIN)
>> +		return NULL;
>> +
>> retry_cpuset:
>> 	if (!nodemask) {
>> 		cpuset_mems_cookie = read_mems_allowed_begin();
>> -- 
>> 2.54.0
>>
> 

