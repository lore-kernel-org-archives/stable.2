Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD56443A98;
	Thu, 27 Aug 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859520; cv=none; b=LlakZfGXvrMmYltFZ3nmTg8ua2kmYmiqfdNVJMtZenpYH0TT9Cw48CHO+a9AkgJ9ezAfWUABnNWo+fD/nydZTqUuZXKWMEZSzchbJa7cgAqGFc8G7Jx78eXy/ZVnj1fVAgn0Nw0H1dbrCb7c9gNFNnVcwe/Ht7+xkUiKJPwCw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859520; c=relaxed/simple;
	bh=eP/hk2DNSiSupAaKn6szi62QjYKLXlDV8zQagv49aiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OrukahlYovVVDHXZ3WVJjfvQNveeF3JRIiT7/LChtYRlEvm0/Vo2af+LWBDAG+CZlhYB3h+p8OyFRH3FOFbqDUJrBak3k3N/lADctI/OXDoy1kVVUf9h5atIxYtO97iGzdZjkH1djWzok5sYRhE2zLw2yFD4zonpWY2ZimRKAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qKBwYd22; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qKBwYd22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787859519; x=1819395519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oLAeOmZrtq36A1IcHxniw47pbRoh1qR6Um5nSXbPo1A=;
  b=qKBwYd22K1Ojz4OmfLVoLdQbkdN8XXtvzM9CgqsnFoJYs+hpRCEpDbCH
   Tc8bURvnevO8oOp3jn+iRccmRG9qDh3BLEQjqi1EnmirsCmn8YW8dsFhP
   BP9EKkqNuI7LKUaDmBy3qjYrJVBDWLMPkiQU0nSQJQWw9HKNPAi9/ShjH
   OguRXBDFISYhPpa9+g/u7pR/QboiMn4KQA+uOsHMKwRNA7kIhazJ3mA00
   pLctVM9unzLVX/h/cQMt2X7mcOGXayQLAf4xsROm4QDHsruN0GFsbgtfC
   oC0yuNSBOZf2BhgHucMleuYQL1SMTecM97Xd9oqpkk0jT6kPoVjybwth1
   w==;
X-CSE-ConnectionGUID: ZMdiy7luSDy5KUaN1uRScw==
X-CSE-MsgGUID: LWv9H5gNTwqEPlTS5WdLNQ==
X-IronPort-AV: E=Sophos;i="6.25,247,1779148800"; 
   d="scan'208";a="26951848"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 19:38:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:24810]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.27:2525] with esmtp (Farcaster)
 id 2c62c1b5-ce79-4e1b-b168-d99646deb830; Thu, 27 Aug 2026 19:38:39 +0000 (UTC)
X-Farcaster-Flow-ID: 2c62c1b5-ce79-4e1b-b168-d99646deb830
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Thu, 27 Aug 2026 19:38:38 +0000
Received: from 6c7e67c92ceb.amazon.com (10.187.170.26) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 27 Aug 2026 19:38:38 +0000
From: Nathan Gao <zcgao@amazon.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <baolin.wang@linux.alibaba.com>, Nathan Gao
	<zcgao@amazon.com>, <stable@vger.kernel.org>
Subject: [PATCH] mm/damon: use a page-aligned sampling address
Date: Thu, 27 Aug 2026 12:38:21 -0700
Message-ID: <20260827193821.46115-1-zcgao@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

__damon_va_prepare_access_check() picks a random byte address within the
region and stores it in r->sampling_addr. There are two users of
r->sampling_addr in vaddr.c that pass it into a page table walk, and
both use it as the address of a page.

  damon_va_mkold(mm, r->sampling_addr)
    damon_va_walk_page_range(mm, addr, addr + 1)
      damon_mkold_pmd_entry()
        damon_ptep_mkold(pte, vma, addr)
          ptep_test_and_clear_young(vma, addr, pte)
          mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)

  damon_va_young(mm, r->sampling_addr, &folio_sz)
    damon_va_walk_page_range(mm, addr, addr + 1)
      damon_young_pmd_entry()
        ptep_get(pte)
        mmu_notifier_test_young(walk->mm, addr)

test_and_clear_young_ptes(), which backs ptep_test_and_clear_young() on
arm64, documents @addr as "Address the first page is mapped at".

For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
clearing of the young flag for large folios"), the contpte helper walked
exactly CONT_PTES entries from the aligned-down page table pointer and
used @addr only to pass down to each entry, so an unaligned value was
harmless:

        ptep = contpte_align_down(ptep);
        addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
        for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)

Now the range to walk is derived from @addr instead: end = addr +
nr * PAGE_SIZE, rounded up to CONT_PTE_SIZE. For a sample in the last
page of a contpte block, the sub-page offset puts end just past the
block boundary, so the round-up lands a whole block further and the
walk clears PTE_AF in CONT_PTES entries beyond the sampled block. Seen
on an arm64 guest running the DAMON selftests as random slab and page
table corruption.

Align the sampled address down to a page boundary. It is the address of
the page to sample, so this matches its intended meaning and fixes both
users in vaddr.c.

Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Gao <zcgao@amazon.com>
---
 mm/damon/vaddr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2c1c1952c008d..e26e426a56af2 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -360,7 +360,8 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
 					struct damon_region *r,
 					struct damon_ctx *ctx)
 {
-	r->sampling_addr = damon_rand(ctx, r->ar.start, r->ar.end);
+	r->sampling_addr = PAGE_ALIGN_DOWN(damon_rand(ctx, r->ar.start,
+						      r->ar.end));
 
 	damon_va_mkold(mm, r->sampling_addr);
 }
-- 
2.50.1

