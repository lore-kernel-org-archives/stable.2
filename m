Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E48367298
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460929; cv=none; b=PAB+rbiY1eBpaJzqReQ9cxcS+d/n/XkowI+Ijk9A7dlhov07FhxQvbN7Nvfm7HCW49syz7Fc+/H38eZql2hz0EmpGvZOR/WAHYuM3yI6VylS5AyXxHoq7KO8+q5Zee9NLsisXJXlPS/gCbiTwAc/d9uL7eHN6R7cPxEUhD3u6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460929; c=relaxed/simple;
	bh=QkYe8yMaTGHhvKHkBL9jPv4MRfYFWAJwY5Y1LklcES4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NatCNPizm/oN/EBdY8aooChgch6b0flTtnIrUD2lTFWbywYocpzjhsa/5iOfjNm/Q+AphnzqO/kHNnhQtHP4W3nAcOQspdvZ+j90UZEV91UZUYvKgofOBy48AqtihkRlH9x3wHoI0nghTe3Hw/2s7aIzAtI3PKRBFduJsv0W8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pxd00T3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pxd00T3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5AA1F000E9;
	Thu,  3 Sep 2026 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788460921;
	bh=sNeZgb44musgSTavs9Kw4MJhdrTxoxH08MKOF8nphzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pxd00T3hA42xl/WDN/YSoNLi/GQ//DVSYaBe+7xKbPlgu8a0mrJ9lDQt6rgM53V/X
	 VgJaDxnvBI9tkcv22GT04/IW9ZFcbjNH3qNANaYNnqGMA1GaVIbJcVDlXG1Ex5S5aR
	 TZmHPCgxQ+6EYJQa3vN6PEFR7wu+w1x5nmLD5I5io/WWbb2yEEuyQi6rvxPdTHcsDU
	 d6Qy+NuB46f2r93seud1Ll8t8NRMb2pTmZ3DyfXQLgUBSK7K3E81CUepZWghzDavmk
	 PWbCXO3w1gC5JRfFK5c++zKRbC4d4q0sobBJ6fb7VCOaNcgrFcjjTDo7nS2zcWxxHh
	 EDF1iI+ULwxfw==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: justinstitt@google.com,
	kees@kernel.org,
	morbo@google.com,
	ndesaulniers@google.com,
	rppt@kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH stable] arch_numa: avoid false positive fortify warning in setup_node_to_cpumask_map()
Date: Thu,  3 Sep 2026 11:40:37 -0700
Message-ID: <20260903184036.3827332-2-nathan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090312-geometry-relax-b127@gregkh>
References: <2026090312-geometry-relax-b127@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f2b1cb39d5ccab090d8353788f186f7e7a1fffd4 upstream.

When building ARCH=riscv using clang with CONFIG_FORTIFY_SOURCE and
CONFIG_UBSAN_BOUNDS enabled, CONFIG_NR_CPUS > 64, and the default value of
2 for CONFIG_NODES_SHIFT, there is a compiletime warning from the fortify
routines.

  In file included from mm/arch_numa.c:11:
  In file included from include/linux/acpi.h:14:
  In file included from include/linux/resource_ext.h:11:
  In file included from include/linux/slab.h:17:
  In file included from include/linux/gfp.h:7:
  In file included from include/linux/mmzone.h:8:
  In file included from include/linux/spinlock.h:60:
  In file included from include/linux/interrupt_rc.h:17:
  In file included from include/linux/smp.h:13:
  In file included from include/linux/cpumask.h:11:
  In file included from include/linux/bitmap.h:13:
  In file included from include/linux/string.h:383:
  include/linux/fortify-string.h:430:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribue-warning]
    430 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  include/linux/fortify-string.h:430:4: note: called by function 'fortify_memset_chk(unsigned long, unsigned long, unsigned long)'
  include/linux/bitmap.h:248:3: note: inlined by function 'setup_node_to_cpumask_map'
    248 |                 memset(dst, 0, len);
        |                 ^
  include/linux/fortify-string.h:462:25: note: expanded from macro 'memset'
    462 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
        |                         ^
  include/linux/fortify-string.h:453:2: note: expanded from macro '__fortify_memset_chk'
    453 |         fortify_memset_chk(__fortify_size, p_size, p_size_field),       \
        |         ^
  include/linux/fortify-string.h:430:4: note: use '-gline-directives-only' (implied by '-g1') or higher for more accurate inlining chain locations
    430 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  1 warning generated.

In this configuration, MAX_NUMNODES is 4.  clang unrolls the for loop in
setup_node_to_cpumask_map() past this, which triggers the fortify check
when accessing node_to_cpumask_map on the theoretical fifth loop iteration
because it would be an out of bounds write.

Make it clear to clang that nr_node_ids is bounded by MAX_NUMNODES due to
the logic in setup_nr_node_ids() by early returning in
setup_node_to_cpumask_map() should that condition be violated.

Link: https://lore.kernel.org/20260813-arch_numa-avoid-fortify-warning-v2-1-093ad97a78df@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2174
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

This version should apply cleanly to all supported stable branches.

 drivers/base/arch_numa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index c99f2ab105e5..a36c939b8e90 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -105,6 +105,18 @@ static void __init setup_node_to_cpumask_map(void)
 	if (nr_node_ids == MAX_NUMNODES)
 		setup_nr_node_ids();
 
+	/*
+	 * This check should never be true but it makes it clear to compilers
+	 * that node_to_cpumask_map is bound by nr_node_ids, avoiding false
+	 * positive fortify warnings when accessing node_to_cpumask_map in the
+	 * for loop below.
+	 */
+	if (unlikely(nr_node_ids > MAX_NUMNODES)) {
+		pr_err("nr_node_ids (%u) is larger than MAX_NUMNODES (%u)\n",
+		       nr_node_ids, MAX_NUMNODES);
+		return;
+	}
+
 	/* allocate and clear the mapping */
 	for (node = 0; node < nr_node_ids; node++) {
 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
-- 
2.55.0

