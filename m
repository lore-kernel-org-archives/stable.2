Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71643403FF
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947213; cv=none; b=rmzquBTDF0IRdHtzi0SxXQiaZ8U7/BZk15V4IeHc0hXMBro3q60l1EacsbLV/7kDucKzpGeBU7VfScpwEXYc1ktRHEDWRH+tACL74i3ytdiqB51mOjgjd7uXaZ/6EJa6IK9ABwfGpn1AGoQaKmIQ0L5DcYYida5i0ccK5BdqwGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947213; c=relaxed/simple;
	bh=GTJdzED5Z0TDpp/KiMwwI/4RSdNMK/BWouYQq3VbD3Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=deM3m840jhno6nGn2mhn24i1RGgznAoeSoTk6ZROlbIcjBNlnl/ebtrwhYyrMEZpkeN3sArDsohiZx4GqyC1KckAMGPBm5OWUORTKECeE5AGw22VqkWq9LiL+r/ypzPNpi/FRY0NwnvwfSIRZLkV3PJjfAyLpOZZapcCn2pBtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fjmp2qFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fjmp2qFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8AB1F00A3A;
	Wed,  9 Sep 2026 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947211;
	bh=7rzOj7mEMNBLiJ5B1/flRds2EcDzqKtyxrf+Gvonkr0=;
	h=Subject:To:Cc:From:Date;
	b=Fjmp2qFq1qm79V2jCZ2yvEvqen/3mkzIRI5iaW6ORfy4q3EpGo99Egkmpika0nv22
	 r8/bwwL1Pu7nOVaMLfa0qqgnnzfcoyaedP+EjrETEusC1HLJFb9lxzK9Rb1c1IOAhq
	 E5KLKzkSBB/F4KaZQPW6lPqCtGDl3/5oZuzlIyzg=
Subject: FAILED: patch "[PATCH] arm64: mm: Fix the lockless page-table walk in show_pte()" failed to apply to 5.10-stable tree
To: kmehltretter@gmail.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:41:41 +0200
Message-ID: <2026090941-sustainer-talisman-a5d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a77644d009dece1104b6fcc6e322b0e4503db0d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090941-sustainer-talisman-a5d7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a77644d009dece1104b6fcc6e322b0e4503db0d6 Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Fri, 28 Aug 2026 19:41:31 +0200
Subject: [PATCH] arm64: mm: Fix the lockless page-table walk in show_pte()

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

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0b52557652be..75c3e463df2e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/irqflags.h>
 #include <linux/kasan.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
@@ -154,6 +155,9 @@ static void show_pte(unsigned long addr)
 	pr_alert("%s pgtable: %luk pages, %llu-bit VAs, pgdp=%016lx\n",
 		 mm == &init_mm ? "swapper" : "user", PAGE_SIZE / SZ_1K,
 		 vabits_actual, mm_to_pgd_phys(mm));
+
+	guard(irqsave)();
+
 	pgdp = pgd_offset(mm, addr);
 	pgd = READ_ONCE(*pgdp);
 	pr_alert("[%016lx] pgd=%016llx", addr, pgd_val(pgd));
@@ -167,25 +171,25 @@ static void show_pte(unsigned long addr)
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
 

