Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948DD344052
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.128.198.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787207673; cv=none; b=hvFouL3+hkzPeGzvtVEmSrYWRw7M2KYI0WnwwRS+30Ve82XZuzEsDXnh/ptPOl3Gex3dO3cvzQMB8HVZwCR6LLk2hdgXLOU36zs3lRJCVQAkF2OaVEChWpCWZa+fDxfU8v68zbZE6FEcOHoyNpbFTR80dnX5NJOiQv7mijTDp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787207673; c=relaxed/simple;
	bh=V4+ISOdVHOx4edqhLj6T6q06bkB70C+CcY4/CYupAJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lDDD/HluATu8FhhAyGmDuSvhzBpDrrPVIXWIlVLyu4CCenXv9j+mNDlktfnLnQtnqVO5iXkNUs99X4iiQGtYRM0JulYTj0KnH23D6/ypiQ1vn3ipCaplFEutDf3ofL/aswnAzUfaxUqi0r7xDQcUq2fUo5DMciu1Xj1HnJE0Pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=220.128.198.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 67K69A9r096381
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:09:10 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
	by Atcsqr.andestech.com with ESMTPS id 67K68ujs096255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 14:08:56 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Thu, 20 Aug
 2026 14:08:56 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Aug
 2026 14:08:56 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin
	<sashal@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou
	<aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>,
        "Ben
 Zong-You Xie" <ben717@andestech.com>
Subject: [PATCH 6.1.y] riscv: Don't use PGD entries for the linear mapping
Date: Thu, 20 Aug 2026 14:08:52 +0800
Message-ID: <20260820060852.1714595-1-ben717@andestech.com>
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
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 67K69A9r096381

From: Alexandre Ghiti <alexghiti@rivosinc.com>

commit 629db01c64ff6cea08fc61b52426362689ef8618 upstream.

Propagating changes at this level is cumbersome as we need to go through
all the page tables when that happens (either when changing the
permissions or when splitting the mapping).

Note that this prevents the use of 4MB mapping for sv32 and 1GB mapping for
sv39 in the linear mapping.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20231108075930.7157-2-alexghiti@rivosinc.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
[ Ben: Only backport the RV32 guard. 6.1.y can build the RV32 linear
mapping from PGD entries, and there is no splitting in __set_memory().
So a one-page permission change mutates 1024 pages.]
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 arch/riscv/mm/init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 72b3462babbf..7e6ea7f0cb68 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -666,8 +666,13 @@ void __init create_pgd_mapping(pgd_t *pgdp,
 
 static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 {
-	/* Upgrade to PMD_SIZE mappings whenever possible */
-	if ((base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
+	/*
+	 * Upgrade to PMD_SIZE mappings whenever possible. Not on 32-bit,
+	 * where PMD_SIZE == PGDIR_SIZE: such a mapping is a PGD leaf entry
+	 * that __set_memory() is unable to split.
+	 */
+	if (!IS_ENABLED(CONFIG_64BIT) ||
+	    (base & (PMD_SIZE - 1)) || (size & (PMD_SIZE - 1)))
 		return PAGE_SIZE;
 
 	return PMD_SIZE;
-- 
2.34.1

