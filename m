Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02247F2D5
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156262; cv=none; b=s2roLMmz1DejktLZz+US7XwqWciPw/FcMKiOOK5qWKuu6d4z0D3gyHEcq1yh94Y0soU31EiMxKROBv2NP6M3thwWopo9LUhDx1Kc7ByAX9TQ9b4MinKZ+8vJMPl5Xp8SDmPNODVJ3CTec5M3w9CmmYnqHG1+GrEh/zQITRODW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156262; c=relaxed/simple;
	bh=H6/QcdUixULjBgiKCgDUKmcum30yTmAeKK5QKuZnZjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXKkh2svIr34fUo95JKshtAI4iLOyms9YuIlcd3pAnnMMot86g/X2xlyOH2ldtoE0J1De1isJTVnjtNmhRf2wbsdPKAslmYPD9qJAFDjlzG+LXTtQSZ0fHyfPa2J2I3QG+FnG5HFhoYspmJhRoMym4e/OTGC8wFdxeqRLpk3/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1I4H6MB; arc=none smtp.client-ip=91.218.175.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1I4H6MB"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H6/QcdUixULjBgiKCgDUKmcum30yTmAeKK5QKuZnZjk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787156257; v=1; x=1787761057;
 b=I1I4H6MBoI0g8XkFslMDaKEaar9a/p3/A5H5wxyIOHqXwe103FiAXA9IamAvHwQIkvBDPgIc
 zdR3UQvtnG63/r/dsyWiKlMSiY3BugxVpQRKdrIHTPuUJFy5rEXLXE6P8NiF8/EA+3x5A5uDWz+
 rjtlavwV/QwCVbzbLn8wYCAQ=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost (2602:fce1:44f:115e::)
	by smtp.migadu.com with ESMTPS id 9b2cb0d49dfecef4;
	Wed, 19 Aug 2026 16:17:37 +0000
X-Mizu-Trace-ID: 9b2cb0d49dfecef4
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: kas@kernel.org
Cc: usama.arif@linux.dev,
	hughd@google.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@kernel.org,
	dev.jain@arm.com,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	nphamcs@gmail.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio on zap
Date: Thu, 20 Aug 2026 00:17:28 +0800
Message-Id: <20260819161728.70270-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <aoWw_iKEDLjKL2jr@thinkstation>
References: <aoWw_iKEDLjKL2jr@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Wed, Aug 19, 2026 at 03:31:40PM +0100, Kiryl Shutsemau wrote:
>On Wed, Aug 19, 2026 at 03:12:22AM -0700, Usama Arif wrote:
[...]
>> ---
>>  mm/huge_memory.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ced400f72d43a..afbb5974bd225 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2449,6 +2449,8 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		add_mm_counter(mm, mm_counter_file(folio),
>>  			       -HPAGE_PMD_NR);
>>  
>> +		if (is_present && pmd_dirty(pmdval))
>> +			folio_mark_dirty(folio);
>
>Unrelated to your patch, but noticed while looking at it: we drop the rmap
>here under the pmd lock, while the TLB flush is deferred to
>tlb_finish_mmu(). The pte path handles this with
>tlb_delay_rmap()/force_flush (5df397dec7c4), but there's no pmd equivalent:
>tlb_flush_rmap_batch() only knows folio_remove_rmap_ptes(), and
>zap_huge_pmd() uses tlb_remove_page_size(), which takes no delay_rmap.

Well spotted!

>Doesn't matter for shmem, but xfs & friends do get PMD-order folios, and

Right. pageout() cannot pass its refcount check while PMD mapping still
holds an extra folio ref, and mmu_gather drops that ref only after TLB
flush.

>do_set_pmd() makes the pmd dirty+writable once page_mkwrite() has run. So
>folio_mkclean() can clean the folio while another CPU still stores through a
>stale TLB entry -- silently lost write, no PG_dirty left behind.

Yep. Writeback can run folio_mkclean() while that ref is still held,
though, and with rmap already gone it misses the PMD ...

>I think we need to fix this too.

+1

>Wanna give it a try?

zap_huge_pmd() only handles one PMD under PTL anyway ... how about just
flushing before folio_remove_rmap_pmd()?

---8<---
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index afbb5974bd22..6fb34924ef66 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2531,6 +2531,14 @@ bool zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	is_present = pmd_present(orig_pmd);
 	folio = normal_or_softleaf_folio_pmd(vma, addr, orig_pmd, is_present);
 	has_deposit = has_deposited_pgtable(vma, orig_pmd, folio);
+	/*
+	 * folio_mkclean() relies on the rmap to find writable mappings.
+	 * Flush stale TLB entries before removing it below.
+	 */
+	if (folio && is_present && !folio_test_anon(folio) &&
+	    pmd_dirty(orig_pmd))
+		tlb_flush_mmu_tlbonly(tlb);
+
 	if (folio)
 		zap_huge_pmd_folio(mm, vma, orig_pmd, folio, is_present);
 	if (has_deposit)
---

Cheers, Lance

>
>>  		if (is_present && pmd_young(pmdval) &&
>>  		    likely(vma_has_recency(vma)))
>>  			folio_mark_accessed(folio);
>> -- 
>> 2.53.0-Meta
>> 
>
>-- 
>  Kiryl Shutsemau / Kirill A. Shutemov
>
