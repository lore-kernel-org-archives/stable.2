Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFA17DFFA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085742; cv=none; b=KJFyH9Y0GmtzpF+1RcuKtXO4rz/dM/vSczixRKSGGEaR4OgpZAn9BTJkIOcX6PDVAkG5Ll06VdhoGKNnXpSo28wEYBcdXAwetxuddezLZXUstUYmzp+V5SNtNyfopC3blo3ZIflUFJgBkfYC0FF8ywVRXl72HmAOXnplUs8G60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085742; c=relaxed/simple;
	bh=qGU+x6ESzLI+BUcd1/Jdw4/hxSJnwlJWuuLAP0OgO3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wno0fQ2h9vmhSiR4BB6IQSaLvLPORN9U1x5bnS4rbtxtrOeY8BbCPOzkFKLK+GDsmbnqKaIwf/YkqwL/2MFYMgNsjF0wA2TvZ5UH1Yuk/emSt4B5JIirrdAj400UKynGSbGyq16VqbsUhNYhMsXbUyAaOJq1zBMSxuJOcOdCc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ9QuQWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ9QuQWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23161F000FF;
	Fri, 11 Sep 2026 00:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085740;
	bh=FOo/jaHM9eZa9ewG3h/QGbbnBxR5i+VxiW/ks94Fyjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJ9QuQWqd6518IC3k6EPzpW6feIvADyQRs21AW5GYwBOpLOuAPZMVGeGNjlB3mY8m
	 A5ZHeqkIaGREE4UmQtpKKO1Pxpd0wdJB77uqnB3RNxYsYkRmNTwvy136uFwPWNdpew
	 pNJwIKMbdNbvyYkGABS9NZ0m49e6zt4YMxxA3PEUXjQdzDpFvtLRv1gMWiXLFulc2V
	 pRXmvtM7w9K72Ol5CU9azcCTvxfjdxcfN45l3jrGBYVdOIowRmE4u/7RogfAVrj95P
	 D7fMSAyvQ7dDdFPEph/cQu5vkRNSvQ9Ctf3r+chR1ldKQMwmNipHrvHX5lldVpIFlT
	 3Cyiq7pSJqQsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] arm64: mm: Fix the lockless page-table walk in show_pte()
Date: Thu, 10 Sep 2026 20:15:38 -0400
Message-ID: <20260911001538.3303072-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090941-sustainer-talisman-a5d7@gregkh>
References: <2026090941-sustainer-talisman-a5d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit a77644d009dece1104b6fcc6e322b0e4503db0d6 ]

show_pte() walks page tables locklessly and can run with interrupts
enabled. A concurrent teardown can free a table page while it is being
walked. It can also clear a parent entry after show_pte() checked it; the
regular pXd_offset() helpers then reread the cleared entry and can derive a
bogus lower-level pointer and fault again.

Use the lockless offset helpers with the saved parent entries, as
gup_fast() does, and pass the saved PMD to pte_offset_map().

For task page tables, arm64 selects MMU_GATHER_RCU_TABLE_FREE. Disable
local interrupts around the walk to hold off RCU-deferred table frees and
block the tlb_remove_table_sync_one() IPI until the walk is finished.

Place the IRQ guard after the header print. This does not make the output a
consistent snapshot, but prevents the task page-table walk from
dereferencing a released table page or deriving a pointer from a different
parent value.

Fixes: 1d18c47c735e ("arm64: MMU fault handling and page table management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Will Deacon <will@kernel.org>
[ replaced guard(irqsave)() with explicit local_irq_save()/local_irq_restore() to avoid declaration-after-statement warnings. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d8baedd160de0..edf82cced64dd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/page-flags.h>
@@ -116,6 +117,7 @@ static inline unsigned long mm_to_pgd_phys(struct mm_struct *mm)
 static void show_pte(unsigned long addr)
 {
 	struct mm_struct *mm;
+	unsigned long flags;
 	pgd_t *pgdp;
 	pgd_t pgd;
 
@@ -139,6 +141,9 @@ static void show_pte(unsigned long addr)
 	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp=%016lx\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
 		 vabits_actual, mm_to_pgd_phys(mm));
+
+	local_irq_save(flags);
+
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
@@ -152,31 +157,32 @@ static void show_pte(unsigned long addr)
 		if (pgd_none(pgd) || pgd_bad(pgd))
 			break;
 
-		p4dp = p4d_offset(pgdp, addr);
+		p4dp = p4d_offset_lockless(pgdp, pgd, addr);
 		p4d = READ_ONCE(*p4dp);
 		pr_cont(", p4d=%016llx", p4d_val(p4d));
 		if (p4d_none(p4d) || p4d_bad(p4d))
 			break;
 
-		pudp = pud_offset(p4dp, addr);
+		pudp = pud_offset_lockless(p4dp, p4d, addr);
 		pud = READ_ONCE(*pudp);
 		pr_cont(", pud=%016llx", pud_val(pud));
 		if (pud_none(pud) || pud_bad(pud))
 			break;
 
-		pmdp = pmd_offset(pudp, addr);
+		pmdp = pmd_offset_lockless(pudp, pud, addr);
 		pmd = READ_ONCE(*pmdp);
 		pr_cont(", pmd=%016llx", pmd_val(pmd));
 		if (pmd_none(pmd) || pmd_bad(pmd))
 			break;
 
-		ptep = pte_offset_map(pmdp, addr);
+		ptep = pte_offset_map(&pmd, addr);
 		pte = READ_ONCE(*ptep);
 		pr_cont(", pte=%016llx", pte_val(pte));
 		pte_unmap(ptep);
 	} while(0);
 
 	pr_cont("\n");
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.53.0

