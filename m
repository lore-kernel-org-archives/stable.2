Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3631715D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089181; cv=none; b=ErKN/tuA4bhg4SyrpF2hRl3SAhNZL52Kp4vI3d07LmVenlKLZStSBxJopdXDtBTuA1grKGQPQDWB8CK8t4Lav8v7Q7Cy4t1IX1sc6+gPmirp2IdTi+gYOQisRVuQz80RspK8CP3k0QIegXYXyEekYvtsTYKRjXgLs/qTGKCpJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089181; c=relaxed/simple;
	bh=cQH8gPE1ASKj/gtwDIAn5BaNNts92MLIPkcG5mL+xG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbHEcwYDMA7rtlfRZzmDaWpAyHh+nDm550AFfRKYsUdJ7ZU28B/YThw6hEiLxstOneu+KlzimlLNW1qKdNNfLMZKBm2wY2Cb7ZmgUTOLloz5MFmx3sNAbsv1WRQ7xCNK93siqp1B9qzTlUFBYhNAp3ceUu7lUsePz89uXcodx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/MKzEos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/MKzEos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D4B1F00893;
	Fri, 11 Sep 2026 01:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089179;
	bh=pdv6Xq9EAoNxBW56IgF5jQJfT1or8M9noaHJD9TIJ7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C/MKzEosUxcX79vK7h0Edd9m+22fbT9aapRWEGeTOohx71M6sRsDIEBUfE6NHWyl0
	 +Un7IojLG6EZO7fQL0FWacnBzZcPU7dWfhu2HPek38A+u3ZW+/HiXAFr4KWVycetwN
	 H1Fvo4Q5OSNtv3SurKJvOLM6Ad1gKSixu4KL/29fMGQuUAxsVzAKwjB0+JAuRkygoB
	 t/NKvhoxJW9ldkK61Y5bx/kMmn3dRx2x3cfrQhAgSKqZ85aSY7OKAYYGQS+5BaNoO/
	 Su6QZQc7VTFXoHL4MHlxRF94rFGy/pEFzeSZv0VkPlhnfN+TbJ0xwQ/lw8QavVKsrF
	 IGy3jmZa3X0bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] powerpc/kexec: move *_memory_ranges functions to ranges.c
Date: Thu, 10 Sep 2026 21:12:55 -0400
Message-ID: <20260911011256.4032346-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011256.4032346-1-sashal@kernel.org>
References: <2026090924-deskwork-unvocal-d17e@gregkh>
 <20260911011256.4032346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit f5f0da5a7b18fab383bac92044fd8f4f288c9d38 ]

Move the following functions form kexec/{file_load_64.c => ranges.c} and
make them public so that components other than KEXEC_FILE can also use
these functions.
1. get_exclude_memory_ranges
2. get_reserved_memory_ranges
3. get_crash_memory_ranges
4. get_usable_memory_ranges

Later in the series get_crash_memory_ranges function is utilized for
in-kernel updates to kdump image during CPU/Memory hotplug or
online/offline events for both kexec_load and kexec_file_load syscalls.

Since the above functions are moved to ranges.c, some of the helper
functions in ranges.c are no longer required to be public. Mark them as
static and removed them from kexec_ranges.h header file.

Finally, remove the CONFIG_KEXEC_FILE build dependency for range.c
because it is required for other config, such as CONFIG_CRASH_DUMP.

No functional changes are intended.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240326055413.186534-4-sourabhjain@linux.ibm.com

For the 6.6 backport, keep crash.o in obj-y and move only ranges.o
out of the CONFIG_KEXEC_FILE object list. This tree has neither the
vmcore_info.c split nor the separate CONFIG_CRASH_DUMP build rule
used in the upstream Makefile context. Preserve its existing KASAN
settings as well. The existing helper relocation and range headers
are retained so the range-truncation fix applies without conflicts.

Stable-dep-of: fa40f9dbdd4a ("powerpc/kexec_file: Prevent kexec range truncation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/kexec_ranges.h |  19 +-
 arch/powerpc/kexec/Makefile             |   4 +-
 arch/powerpc/kexec/file_load_64.c       | 190 --------------------
 arch/powerpc/kexec/ranges.c             | 227 +++++++++++++++++++++++-
 4 files changed, 224 insertions(+), 216 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index f83866a19e870..8489e844b4475 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -7,19 +7,8 @@
 void sort_memory_ranges(struct crash_mem *mrngs, bool merge);
 struct crash_mem *realloc_mem_ranges(struct crash_mem **mem_ranges);
 int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size);
-int add_tce_mem_ranges(struct crash_mem **mem_ranges);
-int add_initrd_mem_range(struct crash_mem **mem_ranges);
-#ifdef CONFIG_PPC_64S_HASH_MMU
-int add_htab_mem_range(struct crash_mem **mem_ranges);
-#else
-static inline int add_htab_mem_range(struct crash_mem **mem_ranges)
-{
-	return 0;
-}
-#endif
-int add_kernel_mem_range(struct crash_mem **mem_ranges);
-int add_rtas_mem_range(struct crash_mem **mem_ranges);
-int add_opal_mem_range(struct crash_mem **mem_ranges);
-int add_reserved_mem_ranges(struct crash_mem **mem_ranges);
-
+int get_exclude_memory_ranges(struct crash_mem **mem_ranges);
+int get_reserved_memory_ranges(struct crash_mem **mem_ranges);
+int get_crash_memory_ranges(struct crash_mem **mem_ranges);
+int get_usable_memory_ranges(struct crash_mem **mem_ranges);
 #endif /* _ASM_POWERPC_KEXEC_RANGES_H */
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 1146af73a866a..4626a656baab7 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -3,11 +3,11 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				+= core.o crash.o core_$(BITS).o
+obj-y				+= core.o crash.o core_$(BITS).o ranges.o
 
 obj-$(CONFIG_PPC32)		+= relocate_32.o
 
-obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
+obj-$(CONFIG_KEXEC_FILE)	+= file_load.o file_load_$(BITS).o elf_$(BITS).o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_core_$(BITS).o := n
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index c66773bfad695..7ba98ecf95d42 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -47,83 +47,6 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL
 };
 
-/**
- * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
- *                             regions like opal/rtas, tce-table, initrd,
- *                             kernel, htab which should be avoided while
- *                             setting up kexec load segments.
- * @mem_ranges:                Range list to add the memory ranges to.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
-{
-	int ret;
-
-	ret = add_tce_mem_ranges(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_initrd_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_htab_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_kernel_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_rtas_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_opal_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_reserved_mem_ranges(mem_ranges);
-	if (ret)
-		goto out;
-
-	/* exclude memory ranges should be sorted for easy lookup */
-	sort_memory_ranges(*mem_ranges, true);
-out:
-	if (ret)
-		pr_err("Failed to setup exclude memory ranges\n");
-	return ret;
-}
-
-/**
- * get_reserved_memory_ranges - Get reserve memory ranges. This list includes
- *                              memory regions that should be added to the
- *                              memory reserve map to ensure the region is
- *                              protected from any mischief.
- * @mem_ranges:                 Range list to add the memory ranges to.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
-{
-	int ret;
-
-	ret = add_rtas_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_tce_mem_ranges(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_reserved_mem_ranges(mem_ranges);
-out:
-	if (ret)
-		pr_err("Failed to setup reserved memory ranges\n");
-	return ret;
-}
-
 /**
  * __locate_mem_hole_top_down - Looks top down for a large enough memory hole
  *                              in the memory regions between buf_min & buf_max
@@ -322,119 +245,6 @@ static int locate_mem_hole_bottom_up_ppc64(struct kexec_buf *kbuf,
 }
 
 #ifdef CONFIG_CRASH_DUMP
-/**
- * get_usable_memory_ranges - Get usable memory ranges. This list includes
- *                            regions like crashkernel, opal/rtas & tce-table,
- *                            that kdump kernel could use.
- * @mem_ranges:               Range list to add the memory ranges to.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int get_usable_memory_ranges(struct crash_mem **mem_ranges)
-{
-	int ret;
-
-	/*
-	 * Early boot failure observed on guests when low memory (first memory
-	 * block?) is not added to usable memory. So, add [0, crashk_res.end]
-	 * instead of [crashk_res.start, crashk_res.end] to workaround it.
-	 * Also, crashed kernel's memory must be added to reserve map to
-	 * avoid kdump kernel from using it.
-	 */
-	ret = add_mem_range(mem_ranges, 0, crashk_res.end + 1);
-	if (ret)
-		goto out;
-
-	ret = add_rtas_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_opal_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_tce_mem_ranges(mem_ranges);
-out:
-	if (ret)
-		pr_err("Failed to setup usable memory ranges\n");
-	return ret;
-}
-
-/**
- * get_crash_memory_ranges - Get crash memory ranges. This list includes
- *                           first/crashing kernel's memory regions that
- *                           would be exported via an elfcore.
- * @mem_ranges:              Range list to add the memory ranges to.
- *
- * Returns 0 on success, negative errno on error.
- */
-static int get_crash_memory_ranges(struct crash_mem **mem_ranges)
-{
-	phys_addr_t base, end;
-	struct crash_mem *tmem;
-	u64 i;
-	int ret;
-
-	for_each_mem_range(i, &base, &end) {
-		u64 size = end - base;
-
-		/* Skip backup memory region, which needs a separate entry */
-		if (base == BACKUP_SRC_START) {
-			if (size > BACKUP_SRC_SIZE) {
-				base = BACKUP_SRC_END + 1;
-				size -= BACKUP_SRC_SIZE;
-			} else
-				continue;
-		}
-
-		ret = add_mem_range(mem_ranges, base, size);
-		if (ret)
-			goto out;
-
-		/* Try merging adjacent ranges before reallocation attempt */
-		if ((*mem_ranges)->nr_ranges == (*mem_ranges)->max_nr_ranges)
-			sort_memory_ranges(*mem_ranges, true);
-	}
-
-	/* Reallocate memory ranges if there is no space to split ranges */
-	tmem = *mem_ranges;
-	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
-		tmem = realloc_mem_ranges(mem_ranges);
-		if (!tmem)
-			goto out;
-	}
-
-	/* Exclude crashkernel region */
-	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
-	if (ret)
-		goto out;
-
-	/*
-	 * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
-	 *        regions are exported to save their context at the time of
-	 *        crash, they should actually be backed up just like the
-	 *        first 64K bytes of memory.
-	 */
-	ret = add_rtas_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	ret = add_opal_mem_range(mem_ranges);
-	if (ret)
-		goto out;
-
-	/* create a separate program header for the backup region */
-	ret = add_mem_range(mem_ranges, BACKUP_SRC_START, BACKUP_SRC_SIZE);
-	if (ret)
-		goto out;
-
-	sort_memory_ranges(*mem_ranges, false);
-out:
-	if (ret)
-		pr_err("Failed to setup crash memory ranges\n");
-	return ret;
-}
-
 /**
  * check_realloc_usable_mem - Reallocate buffer if it can't accommodate entries
  * @um_info:                  Usable memory buffer and ranges info.
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index fb3e12f152144..297b8bc97b9f6 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -20,9 +20,13 @@
 #include <linux/kexec.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/memblock.h>
+#include <linux/crash_core.h>
 #include <asm/sections.h>
 #include <asm/kexec_ranges.h>
+#include <asm/crashdump-ppc64.h>
 
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
 /**
  * get_max_nr_ranges - Get the max no. of ranges crash_mem structure
  *                     could hold, given the size allocated for it.
@@ -234,13 +238,16 @@ int add_mem_range(struct crash_mem **mem_ranges, u64 base, u64 size)
 	return __add_mem_range(mem_ranges, base, size);
 }
 
+#endif /* CONFIG_KEXEC_FILE || CONFIG_CRASH_DUMP */
+
+#ifdef CONFIG_KEXEC_FILE
 /**
  * add_tce_mem_ranges - Adds tce-table range to the given memory ranges list.
  * @mem_ranges:         Range list to add the memory range(s) to.
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_tce_mem_ranges(struct crash_mem **mem_ranges)
+static int add_tce_mem_ranges(struct crash_mem **mem_ranges)
 {
 	struct device_node *dn = NULL;
 	int ret = 0;
@@ -279,7 +286,7 @@ int add_tce_mem_ranges(struct crash_mem **mem_ranges)
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_initrd_mem_range(struct crash_mem **mem_ranges)
+static int add_initrd_mem_range(struct crash_mem **mem_ranges)
 {
 	u64 base, end;
 	int ret;
@@ -296,7 +303,6 @@ int add_initrd_mem_range(struct crash_mem **mem_ranges)
 	return ret;
 }
 
-#ifdef CONFIG_PPC_64S_HASH_MMU
 /**
  * add_htab_mem_range - Adds htab range to the given memory ranges list,
  *                      if it exists
@@ -304,14 +310,18 @@ int add_initrd_mem_range(struct crash_mem **mem_ranges)
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_htab_mem_range(struct crash_mem **mem_ranges)
+static int add_htab_mem_range(struct crash_mem **mem_ranges)
 {
+
+#ifdef CONFIG_PPC_64S_HASH_MMU
 	if (!htab_address)
 		return 0;
 
 	return add_mem_range(mem_ranges, __pa(htab_address), htab_size_bytes);
-}
+#else
+	return 0;
 #endif
+}
 
 /**
  * add_kernel_mem_range - Adds kernel text region to the given
@@ -320,18 +330,20 @@ int add_htab_mem_range(struct crash_mem **mem_ranges)
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_kernel_mem_range(struct crash_mem **mem_ranges)
+static int add_kernel_mem_range(struct crash_mem **mem_ranges)
 {
 	return add_mem_range(mem_ranges, 0, __pa(_end));
 }
+#endif /* CONFIG_KEXEC_FILE */
 
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
 /**
  * add_rtas_mem_range - Adds RTAS region to the given memory ranges list.
  * @mem_ranges:         Range list to add the memory range to.
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_rtas_mem_range(struct crash_mem **mem_ranges)
+static int add_rtas_mem_range(struct crash_mem **mem_ranges)
 {
 	struct device_node *dn;
 	u32 base, size;
@@ -356,7 +368,7 @@ int add_rtas_mem_range(struct crash_mem **mem_ranges)
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_opal_mem_range(struct crash_mem **mem_ranges)
+static int add_opal_mem_range(struct crash_mem **mem_ranges)
 {
 	struct device_node *dn;
 	u64 base, size;
@@ -374,7 +386,9 @@ int add_opal_mem_range(struct crash_mem **mem_ranges)
 	of_node_put(dn);
 	return ret;
 }
+#endif /* CONFIG_KEXEC_FILE || CONFIG_CRASH_DUMP */
 
+#ifdef CONFIG_KEXEC_FILE
 /**
  * add_reserved_mem_ranges - Adds "/reserved-ranges" regions exported by f/w
  *                           to the given memory ranges list.
@@ -382,7 +396,7 @@ int add_opal_mem_range(struct crash_mem **mem_ranges)
  *
  * Returns 0 on success, negative errno on error.
  */
-int add_reserved_mem_ranges(struct crash_mem **mem_ranges)
+static int add_reserved_mem_ranges(struct crash_mem **mem_ranges)
 {
 	int n_mem_addr_cells, n_mem_size_cells, i, len, cells, ret = 0;
 	const __be32 *prop;
@@ -410,3 +424,198 @@ int add_reserved_mem_ranges(struct crash_mem **mem_ranges)
 
 	return ret;
 }
+
+/**
+ * get_reserved_memory_ranges - Get reserve memory ranges. This list includes
+ *                              memory regions that should be added to the
+ *                              memory reserve map to ensure the region is
+ *                              protected from any mischief.
+ * @mem_ranges:                 Range list to add the memory ranges to.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
+{
+	int ret;
+
+	ret = add_rtas_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_tce_mem_ranges(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_reserved_mem_ranges(mem_ranges);
+out:
+	if (ret)
+		pr_err("Failed to setup reserved memory ranges\n");
+	return ret;
+}
+
+/**
+ * get_exclude_memory_ranges - Get exclude memory ranges. This list includes
+ *                             regions like opal/rtas, tce-table, initrd,
+ *                             kernel, htab which should be avoided while
+ *                             setting up kexec load segments.
+ * @mem_ranges:                Range list to add the memory ranges to.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
+{
+	int ret;
+
+	ret = add_tce_mem_ranges(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_initrd_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_htab_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_kernel_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_rtas_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_opal_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_reserved_mem_ranges(mem_ranges);
+	if (ret)
+		goto out;
+
+	/* exclude memory ranges should be sorted for easy lookup */
+	sort_memory_ranges(*mem_ranges, true);
+out:
+	if (ret)
+		pr_err("Failed to setup exclude memory ranges\n");
+	return ret;
+}
+
+#ifdef CONFIG_CRASH_DUMP
+/**
+ * get_usable_memory_ranges - Get usable memory ranges. This list includes
+ *                            regions like crashkernel, opal/rtas & tce-table,
+ *                            that kdump kernel could use.
+ * @mem_ranges:               Range list to add the memory ranges to.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int get_usable_memory_ranges(struct crash_mem **mem_ranges)
+{
+	int ret;
+
+	/*
+	 * Early boot failure observed on guests when low memory (first memory
+	 * block?) is not added to usable memory. So, add [0, crashk_res.end]
+	 * instead of [crashk_res.start, crashk_res.end] to workaround it.
+	 * Also, crashed kernel's memory must be added to reserve map to
+	 * avoid kdump kernel from using it.
+	 */
+	ret = add_mem_range(mem_ranges, 0, crashk_res.end + 1);
+	if (ret)
+		goto out;
+
+	ret = add_rtas_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_opal_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_tce_mem_ranges(mem_ranges);
+out:
+	if (ret)
+		pr_err("Failed to setup usable memory ranges\n");
+	return ret;
+}
+#endif /* CONFIG_CRASH_DUMP */
+#endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_DUMP
+/**
+ * get_crash_memory_ranges - Get crash memory ranges. This list includes
+ *                           first/crashing kernel's memory regions that
+ *                           would be exported via an elfcore.
+ * @mem_ranges:              Range list to add the memory ranges to.
+ *
+ * Returns 0 on success, negative errno on error.
+ */
+int get_crash_memory_ranges(struct crash_mem **mem_ranges)
+{
+	phys_addr_t base, end;
+	struct crash_mem *tmem;
+	u64 i;
+	int ret;
+
+	for_each_mem_range(i, &base, &end) {
+		u64 size = end - base;
+
+		/* Skip backup memory region, which needs a separate entry */
+		if (base == BACKUP_SRC_START) {
+			if (size > BACKUP_SRC_SIZE) {
+				base = BACKUP_SRC_END + 1;
+				size -= BACKUP_SRC_SIZE;
+			} else
+				continue;
+		}
+
+		ret = add_mem_range(mem_ranges, base, size);
+		if (ret)
+			goto out;
+
+		/* Try merging adjacent ranges before reallocation attempt */
+		if ((*mem_ranges)->nr_ranges == (*mem_ranges)->max_nr_ranges)
+			sort_memory_ranges(*mem_ranges, true);
+	}
+
+	/* Reallocate memory ranges if there is no space to split ranges */
+	tmem = *mem_ranges;
+	if (tmem && (tmem->nr_ranges == tmem->max_nr_ranges)) {
+		tmem = realloc_mem_ranges(mem_ranges);
+		if (!tmem)
+			goto out;
+	}
+
+	/* Exclude crashkernel region */
+	ret = crash_exclude_mem_range(tmem, crashk_res.start, crashk_res.end);
+	if (ret)
+		goto out;
+
+	/*
+	 * FIXME: For now, stay in parity with kexec-tools but if RTAS/OPAL
+	 *        regions are exported to save their context at the time of
+	 *        crash, they should actually be backed up just like the
+	 *        first 64K bytes of memory.
+	 */
+	ret = add_rtas_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	ret = add_opal_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
+	/* create a separate program header for the backup region */
+	ret = add_mem_range(mem_ranges, BACKUP_SRC_START, BACKUP_SRC_SIZE);
+	if (ret)
+		goto out;
+
+	sort_memory_ranges(*mem_ranges, false);
+out:
+	if (ret)
+		pr_err("Failed to setup crash memory ranges\n");
+	return ret;
+}
+#endif /* CONFIG_CRASH_DUMP */
-- 
2.53.0

