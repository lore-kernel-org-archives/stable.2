Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E2347BA9
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206224; cv=none; b=I/aDHxRyc4VO4Cs58XoFQw24fniWqcRZFseonCV4pdrCKyA1cMO8CM0T7HS5pi4CdKQJj0JRnGocHEettptDZ50rOHM+sHcX9hZEaUt1kF1enHVqkArvI9innsPTU4ChhSjPnx862nO+ZfsrX7Hnon+rV4yxtrAp62x/stw9iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206224; c=relaxed/simple;
	bh=dsDOjJuHd18vZ7pF0FqL4XxJsCvT2rSPmYHW2QvjkU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSqw50XK4lb97k+Oja6NhFphbdOPSxTX7zhXDnLQaEVXapVMhPff8AV8jkb+JmLK7GECpajnJ86fha3HevRY1bkyorp1gO0Qp8P5P17Fixuvya64i0NAbUOPnHYHIC15zKTL6fdCkSKnvmHUrFPfZvpswSb9EEnPjbyrsPAIfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
	by Atcsqr.andestech.com with ESMTPS id 67K6AAI5097812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:10:10 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Thu, 20 Aug
 2026 14:10:10 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Aug
 2026 14:10:10 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin
	<sashal@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti
	<alexghiti@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Paul Walmsley
	<paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Palmer
 Dabbelt" <palmer@rivosinc.com>,
        Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH 6.1.y 6.6.y] RISC-V: Provide pgtable_l5_enabled on rv32
Date: Thu, 20 Aug 2026 14:10:07 +0800
Message-ID: <20260820061007.1718706-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 67K6AAI5097812

From: Palmer Dabbelt <palmer@rivosinc.com>

commit 10128f8b1663a8bce27df051c750d116bb8cd737 upstream.

A few of the other page table level helpers are defined on rv32, but not
pgtable_l5_enabled.  This adds the definition as a constant and converts
pgtable_l4_enabled to a constant as well.

Link: https://lore.kernel.org/r/20230830044129.11481-2-palmer@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[ Ben: Applies unchanged; needed by both 6.1.y and 6.6.y. Both trees took
  commit e59e5e2754bf ("riscv: correct pt_level name via
  pgtable_l5/4_enabled") -- 6.1.y as of v6.1.64 -- without this
  prerequisite from the same series, so arch/riscv/mm/ptdump.c fails to
  build on rv32 whenever CONFIG_PTDUMP_CORE is enabled:

    arch/riscv/mm/ptdump.c: In function 'ptdump_init':
    arch/riscv/mm/ptdump.c:387:28: error: 'pgtable_l5_enabled' undeclared
    (first use in this function); did you mean 'pgtable_l4_enabled'?

  Only pgtable_l5_enabled fails because pgtable_l4_enabled still has an
  unconditional extern in asm/pgtable.h; this patch removes that and
  provides both as constants for rv32. The only assignments to them, in
  disable_pgtable_l4/l5(), are already inside
  #if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL), so making them
  const on rv32 is safe. v6.12 and later are unaffected. ]
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 arch/riscv/include/asm/pgtable-32.h | 3 +++
 arch/riscv/include/asm/pgtable.h    | 1 -
 arch/riscv/mm/init.c                | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 59ba1fbaf784..00f3369570a8 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -33,4 +33,7 @@
 					  _PAGE_WRITE | _PAGE_EXEC |	\
 					  _PAGE_USER | _PAGE_GLOBAL))
 
+static const __maybe_unused int pgtable_l4_enabled;
+static const __maybe_unused int pgtable_l5_enabled;
+
 #endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1a94e633c144..d25871c60883 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -818,7 +818,6 @@ extern uintptr_t _dtb_early_pa;
 #define dtb_early_pa	_dtb_early_pa
 #endif /* CONFIG_XIP_KERNEL */
 extern u64 satp_mode;
-extern bool pgtable_l4_enabled;
 
 void paging_init(void);
 void misc_mem_init(void);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7e6ea7f0cb68..d6cfa7de010a 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -45,10 +45,12 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
 #endif
 EXPORT_SYMBOL(satp_mode);
 
+#ifdef CONFIG_64BIT
 bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
 bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
 EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
+#endif
 
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
-- 
2.34.1

