Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0227456
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781601337; cv=none; b=ewqMfiLGhrngGjYKYs0cPzCOsrtlLd3rI7M+Ewhm1pVCVcBe/cdkfsdrXeovS8Tm4YFvqGEulLBVEZacsiHBX9w/bC36s4QI0ltCAZSonP/zoBYsc80mCNwgd1XVwm0C7xaM5OLnW99kbrI/2VMJip/NamNZQJLxWPBRMooUL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781601337; c=relaxed/simple;
	bh=9rOwkV9QgHXXFWQINk1wFiDvCLMF4fWHf7XAKv8LCdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ2je/orSbtPJLOYcmYOvjUXUZY4dcOwbg3wdpyMPjjW9exRD9WJ7n9n1M5zyqkOcV1j88BqFMB83kCIm7/8vaBXqJnJwMe4Z+miqgNYmtCnDXirSOjs1aGtD6aEqBheCk0HddAAR7kvvt9CgSxY9jN2MUJlvrgt1TAo1C/sLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mbhUY4X0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mbhUY4X0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781601333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWz7TCTy5BS+umTJteSAoLHr5Sx4WoMlxOW/yrqh7/E=;
	b=mbhUY4X0+dvUd/P+I4HklcbK2XloTs3O0XsQNEfyXzqirpxAIH5srCGFuZhwUm+urkYmJl
	SIt1RTZYCMnBaxCMx1kprVzNaP/bzSEEmxaPasE3XJ5BrAtF6ddxXz4sYrJginAwE8pQCM
	xTZ9nF+OlcX03ZQsB1lLpy59nVdgZDo=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org,
	richard.weiyang@gmail.com
Cc: balbirs@nvidia.com,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	sj@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Tue, 16 Jun 2026 17:15:22 +0800
Message-Id: <20260616091522.83765-1-lance.yang@linux.dev>
In-Reply-To: <2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org>
References: <2d48ef0d-1110-4a9d-adcb-f701a1ce2cfa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 15, 2026 at 01:58:15PM +0200, David Hildenbrand (Arm) wrote:
>On 6/12/26 04:48, Wei Yang wrote:
>> On Tue, May 12, 2026 at 08:55:47PM +0200, David Hildenbrand (Arm) wrote:
>>> On 5/12/26 16:35, Wei Yang wrote:
>>>>
>>>> I tried to compress above logic like this, hope it could look cleaner.

Emm ... spelling out the present/migration/device-private cases makes
this easier to review, and avoids hiding future softleaf types behind
pmd_is_valid_softleaf(), IMHO.

So I'd prefer David's explicit version[1].

>>>>
>>>> 	if (pmd_trans_huge(pmde) || pmd_is_valid_softleaf(pmde)) {
>>>> 		unsigned long pfn;
>>>> 		bool is_migration = pmd_is_migration_entry(pmde);
>>>> 		bool for_migration = !!(pvmw->flags & PVMW_MIGRATION);
>>>>
>>>> 		if (is_migration != for_migration)
>>>> 			return not_found(pvmw);
>>>>
>>>> 		if (pmd_trans_huge(pmde))
>>>> 			pfn = pmd_pfn(pmde);
>>>> 		else
>>>> 			pfn = softleaf_to_pfn(softleaf_from_pmd(pmde));
>>>>
>>>> 		if (!check_pmd(pfn, pvmw))
>>>> 			return not_found(pvmw);
>>>> 	} else if (!pmd_present(pmde)) {
>>>
>>> It's more compact, but not necessarily cleaner. In particular, I detest
>>> pmd_trans_huge(), we should phase it out.
>>>
>>> if (pmd_present(pmde) && !pmd_leaf(pmde)) {
>>> 	goto pte_table;
>>> } else if (pmd_present(pmde) || pmd_is_valid_softleaf(pmde))
>>>
>>> ...
>>>
>>> Might work as well. But once we add support for other softleaf types, we'll have
>>> to touch it again. So I'd rather just list what we actually expect.
>>>
>> 
>> Hi, David
>
>Hi,
>
>> 
>> I may not follow you. Just want to confirm whether you prefer this goes as a
>> fix first, or you prefer it goes as what you suggested here as a cleanup?
>
>I guess we should just do it properly when we're touching the code already.

+1 to that ;)

>Does that answer your question? Will you send a proper patch?

Copied the diff from [1] below, with a couple of tiny nits inline. Feel
free to grab any of this if it looks sane :)

---8<---
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index a4d52fdb3056..de6a255cc847 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -242,40 +242,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
                 */
                pmde = pmdp_get_lockless(pvmw->pmd);
 
-               if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
-                       pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-                       pmde = *pvmw->pmd;
-                       if (!pmd_present(pmde)) {
-                               softleaf_t entry;
-
-                               if (!thp_migration_supported() ||
-                                   !(pvmw->flags & PVMW_MIGRATION))
-                                       return not_found(pvmw);
-                               entry = softleaf_from_pmd(pmde);
-
-                               if (!softleaf_is_migration(entry) ||
-                                   !check_pmd(softleaf_to_pfn(entry), pvmw))
-                                       return not_found(pvmw);
-                               return true;
-                       }
-                       if (likely(pmd_trans_huge(pmde))) {
-                               if (pvmw->flags & PVMW_MIGRATION)
-                                       return not_found(pvmw);
-                               if (!check_pmd(pmd_pfn(pmde), pvmw))
-                                       return not_found(pvmw);
-                               return true;
-                       }
-                       /* THP pmd was split under us: handle on pte level */
-                       spin_unlock(pvmw->ptl);
-                       pvmw->ptl = NULL;
-               } else if (!pmd_present(pmde)) {
-                       const softleaf_t entry = softleaf_from_pmd(pmde);
-
-                       if (softleaf_is_device_private(entry)) {
-                               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-                               return true;
-                       }
+               if (pmd_present(pmde)) {
+                       if (!pmd_leaf(pmde))
+                               goto pte_table;
+                       if (pvmw->flags & PVMW_MIGRATION)
+                               return not_found(pvmw);
+                       if (!check_pmd(pmd_pfn(pmde), pvmw))
+                               return not_found(pvmw);
+               } else if (pmd_is_migration_entry(pmde)) {
+                       softleaf_t entry = softleaf_from_pmd(pmde);

Could be const.

+
+                       if (!(pvmw->flags & PVMW_MIGRATION))
+                               return not_found(pvmw);
+                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+                               return not_found(pvmw);
+               } else if (pmd_is_device_private_entry(pmde)) {
+                       softleaf_t entry = softleaf_from_pmd(pmde);

Ditto.
 
+                       if (pvmw->flags & PVMW_MIGRATION)
+                               return not_found(pvmw);
+                       if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+                               return not_found(pvmw);
+               } else {
                        if ((pvmw->flags & PVMW_SYNC) &&
                            thp_vma_suitable_order(vma, pvmw->address,
                                                   PMD_ORDER) &&
@@ -285,6 +273,15 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
                        step_forward(pvmw, PMD_SIZE);
                        continue;
                }
+
+               /* Double-check under PTL that the PMD didn't change. */
+               pvmw->ptl = pmd_lock(mm, pvmw->pmd);
+               if (pmd_same(pmde, pmdp_get(pvmw->pmd)))

Maybe worth a likely() here? The PMD normally shouldn't change under us.

+                       return true;
+               spin_unlock(pvmw->ptl);
+               pvmw->ptl = NULL;
+               goto restart;
+pte_table:
                if (!map_pte(pvmw, &pmde, &ptl)) {
                        if (!pvmw->pte)
---

[1] https://lore.kernel.org/linux-mm/0aab59b8-71c5-4059-8281-5dd876946528@kernel.org/

Cheers, Lance
