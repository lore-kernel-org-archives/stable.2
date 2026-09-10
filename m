Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC564E8DEB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058693; cv=none; b=LEcI1a2/mjrtlRLlyhjFBnEy0rRQjX3Tz55fUQTDjbEdkNsYjZMOdnkyNlqbjml0GzRD6ur0Ryxy2UWFlAtnePodtq2mtvf5XIz0fvzU3gXGrmaIu6zAxWwWDJg7RU4pe1/F3k279fPpliNSUSNHSyv2TYUt+P5PPHmGQoTONic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058693; c=relaxed/simple;
	bh=VQpslFw+Dz/AFaksIbYUuvx20PsWVS/l73KJxojQvZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckDElgrpBCKeSWSAOmaMc6yF9VpT4wJkhUe77BWaAO4JoHGHs+z3vAFRy16Jx6eI19Ybg8wVwXpp2utwWbLNPQ2EozEickDqLJHzYqCgARSPecQfIZQxaSyfAq6QlrJ/FUtSzsKo3ymJhocDXzf5uOE++uVjdHk8wnIR3WdNrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnHjjxUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnHjjxUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BDC1F00898;
	Thu, 10 Sep 2026 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058690;
	bh=arVcku35rrEIavQ1WCgWY2NLlekJLmLjiBlHNYBRYxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnHjjxUSRI3uX/4wfFFsqGTK63418pdhcQoJHQhv5Ro+mzQeXb9+RuIwp/b6LK4jY
	 JJFzIVVBGzQKebd9Q+30OyVOWdbomVnVAJAr8eNBa7YL4UZj78f4FhsLqs55y9WR2i
	 vsQp6uqVOQdbOKmsR+Pt2cbt2H6Be9Qqz4T1QlcT5c8amvGQGX2t4rj75OOq+N8igv
	 +XCqnAZutYQcp/MCkIOdtBsBjym+XdcRlGhojHZpvs8xZxZtV/mKbIy9RrIeWKA4Jj
	 DGBURPTi6dPG2T4xJCvyuOCOdmbqPM43lwW7ByqmZIyUSvgHsa6s+5MmEkTpzq4qfL
	 H8I1JiumOPE5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] arm64: mm: Fix the lockless page-table walk in show_pte()
Date: Thu, 10 Sep 2026 12:44:44 -0400
Message-ID: <20260910164444.1248701-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910164444.1248701-1-sashal@kernel.org>
References: <2026090940-catering-debug-33e5@gregkh>
 <20260910164444.1248701-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c4120bd80a9b4..5bd5e10c49f18 100644
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
@@ -145,6 +146,9 @@ static void show_pte(unsigned long addr)
 	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp=%016lx\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
 		 vabits_actual, mm_to_pgd_phys(mm));
+
+	guard(irqsave)();
+
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
@@ -158,25 +162,25 @@ static void show_pte(unsigned long addr)
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
 
-- 
2.53.0

