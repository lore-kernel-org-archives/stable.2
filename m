Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A101F3B8A;
	Fri, 14 Aug 2026 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677185; cv=none; b=ed9jIJ3owEr13y7U6GBCPbCgMyQBm2GaCBqfTjUpUzzBZl1msGjqal/TDsAwnmr2+uw6EtwnhSlIkwpTHsEKHfl5Rx3tbFWy/O7xofYXeWQIR/uD8BGIrVJanYb97HZaBrb2reOSp+dU9nQHZKnkE7L/MwyZVeebU+sHyH9iwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677185; c=relaxed/simple;
	bh=d3ptSvmswCLpNbskdAJb2art6bCO2dkEZ4BpRXjgdEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jkb2liDw4yNQ9CV/PQov4WBFByNbVHINBui6ycFERh9xDcM1bp987h/pOnmoLr/s76gN6xN6ojluj+sG+JEFg7vV2Ss77QHnniXUtKyFwNOP3VWS6sYQakTPoQt9YDhHashK0MC7I7BAz3l6gB3pAKKEWSwx6UBgiHrmVgl52uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBJ0OJ9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBJ0OJ9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED131F000E9;
	Fri, 14 Aug 2026 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677183;
	bh=BIOSwc1xpJnji8+UduFcZ8xM4GL3ivYKfnxeDdc6zK0=;
	h=From:Date:Subject:To:Cc;
	b=IBJ0OJ9XviiBIZaMSV64pzz+c5ElwbHPeAd6w2fXrJPwD1jsEhG47458+BdQX3oIq
	 8Pny9ytVbch2A9ylb52CgE+xLo1T+Q7MRp08uFwb6zeyAPAvsRShkv4IPOnvZy5nek
	 bmduvLXgUBjP/bAm81UJjoNUi/J4bSVui1n5WozItKHFYjYulpxxNqbFAacyEoqgl4
	 APR+QDBLOptdfm9sowerPS5FTqPWL0OjQauDH5txBKsTF0D4v7dZXUbc8FO8wR9iYE
	 Sc1zNedSYQJvcXM1L7xdiaW6+ZL83urzTz+xdeGd0NwSRqOs2RLxaLhPtD0l/dr0GI
	 JZw96UPBjVYHw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 13 Aug 2026 20:12:55 -0700
Subject: [PATCH v2] arch_numa: Avoid false positive fortify warning in
 setup_node_to_cpumask_map()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-arch_numa-avoid-fortify-warning-v2-1-093ad97a78df@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OWw6CMBBFt2L67RhaEMEv92GIqWUK46M1U6gSw
 t4F3ICfJzm5544iIBMGcdyMgjFSIO9mUNuNMK12DQLVMwuVqDwppATNpr24/qlBR081WM8d2QH
 emh25BvJc2+KQJWkmlZhXXoyWPmvhXP049Ncbmm6ZXYyWQud5WC9EuXj/16IECfvSYIp5UdpUn
 +7IDh87z42opmn6AhVO8nThAAAA
X-Change-ID: 20260811-arch_numa-avoid-fortify-warning-66af87403412
To: Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4672; i=nathan@kernel.org;
 h=from:subject:message-id; bh=d3ptSvmswCLpNbskdAJb2art6bCO2dkEZ4BpRXjgdEw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFl17bsqJ8+qTY/P3haXNFlTdZuWioBElqTcleKu6w9bg
 g8Vrm3vKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABNxUGZkWLyC5au4cotgzeG6
 6sKKvH2vty1lLk+9fvCYRP7VBhHteYwMJ515tHqmOUyTcnnJtN1b5EnOO+dab8u3sbH2v9hyOmL
 4AQ==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building ARCH=riscv using clang with CONFIG_FORTIFY_SOURCE and
CONFIG_UBSAN_BOUNDS enabled, CONFIG_NR_CPUS > 64, and the default value
of 2 for CONFIG_NODES_SHIFT, there is a compiletime warning from the
fortify routines.

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

In this configuration, MAX_NUMNODES is 4. clang unrolls the for loop in
setup_node_to_cpumask_map() past this, which triggers the fortify check
when accessing node_to_cpumask_map on the theoretical fifth loop
iteration because it would be an out of bounds write.

Make it clear to clang that nr_node_ids is bounded by MAX_NUMNODES due
to the logic in setup_nr_node_ids() by early returning in
setup_node_to_cpumask_map() should that condition be violated.

Cc: stable@vger.kernel.org # all applicable
Closes: https://github.com/ClangBuiltLinux/linux/issues/2174
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This is based on mm-unstable due to the move of arch_numa.c from mm/ to
drivers/base/ living there. I have CC'd stable because this warning
appears in my testing back to at least 6.1 but I see no reason why it
should not apply to all trees. No fixes tag since this is a layered
problem that just happens to appear under certain conditions.

Another alternative would be using the __assume macro to say something
like

  __assume(nr_node_ids <= MAX_NUMNODES);

but that seems a little more fragile than an outright check.
---
Changes in v2:
- Add missing newline to print message (Andrew + sashiko)
- Print MAX_NUMNODES using '%u' specifier to match nr_node_ids
- Link to v1: https://patch.msgid.link/20260811-arch_numa-avoid-fortify-warning-v1-1-59ce3e689f3a@kernel.org
---
 mm/arch_numa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/arch_numa.c b/mm/arch_numa.c
index 442ea239bba7..459fa60a5621 100644
--- a/mm/arch_numa.c
+++ b/mm/arch_numa.c
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

---
base-commit: 47870fb9b0e3bd20b45e3a069b4c766f3dcb721a
change-id: 20260811-arch_numa-avoid-fortify-warning-66af87403412

Best regards,
--  
Cheers,
Nathan

