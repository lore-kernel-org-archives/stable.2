Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ECD58F066
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067325; cv=none; b=BjI8WvsNb4xp/FVEVMtcJCCNQKwKNGBYTHM9sLYfzAYL17flIOz+8VuPRdQ1+bzTCBJKQZ5r8FeW+izxd+ZgJCn0vcDDtGQWBhy2tzu14fCXyqwoDzWnRg/2u8k3o62ZI9blUIS5XSzu8y857CbGgUIW1+up9uOWzB6g4EoOXZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067325; c=relaxed/simple;
	bh=RiPsCQPituENL53gccxkXUYYXp7BHFy5sxzaHNDbXRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMBZZlpzm8M/rtJ8XsnItfgw1ZA/u7PaZ7iedaf7sHXo08/ZGd0i8lPVncTdyBa+ZZpW0KJ6xjVc+08cy+IYD2YmDwh00KDo8B5+bC1Kf45nAnodFWSX4BL46YHslJ8Vi17p+9ATO1dExJEE2DWGdmDijVsR/hrKHNxPbEB7gFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhD2aXGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhD2aXGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A7E1F00898;
	Thu, 10 Sep 2026 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067323;
	bh=q/gk/YpLPeRqTFdCdODsQWsh+oCQnScR+9+xqn9RSHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fhD2aXGZdFncJl5o2HvL85bDWMWV5eOTjO1HLmgJUq6qMu/TOlLmDoD3VYQvFFT/s
	 wiqQ+T2AsfDJd8hqOqmZZX2p5T74mYaT19Kq/ZT9ovRjVYDsFO3qxc6yo+xyrGUuvT
	 fku+VeiL1NDgxgIm2J9vb4ffxNsrdjBRFIScBBHaw1HTOQ+DVG7RP4Tnz6qtlfnukD
	 eAPJLBaBwZNwjXXFU5hwbJ7IxGHFibYnUYMgrEnRFPsqVsxvSX/w4Et44/1KpfEMz3
	 SifdumPyijvQWdIraw+n7Jtn6V/RwY+2uQBGgwVyeEQSEtnoIiqZPeZItoouGXcDmm
	 rb1eff7J96URA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] arm64: mm: Fix the lockless page-table walk in show_pte()
Date: Thu, 10 Sep 2026 15:08:37 -0400
Message-ID: <20260910190837.1453363-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190837.1453363-1-sashal@kernel.org>
References: <2026090941-average-edition-4184@gregkh>
 <20260910190837.1453363-1-sashal@kernel.org>
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
[ replaced guard(irqsave)() with explicit local_irq_save()/local_irq_restore() calls to avoid declarations after statements. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 39f03d18717eb..0155330b9d0da 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/kasan.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
@@ -123,6 +124,7 @@ static void show_pte(unsigned long addr)
 	struct mm_struct *mm;
 	pgd_t *pgdp;
 	pgd_t pgd;
+	unsigned long flags;
 
 	if (is_ttbr0_addr(addr)) {
 		/* TTBR0 */
@@ -144,6 +146,9 @@ static void show_pte(unsigned long addr)
 	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp=%016lx\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
 		 vabits_actual, mm_to_pgd_phys(mm));
+
+	local_irq_save(flags);
+
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
@@ -157,25 +162,25 @@ static void show_pte(unsigned long addr)
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
 		if (!ptep)
 			break;
 
@@ -185,6 +190,7 @@ static void show_pte(unsigned long addr)
 	} while(0);
 
 	pr_cont("\n");
+	local_irq_restore(flags);
 }
 
 /*
-- 
2.53.0

