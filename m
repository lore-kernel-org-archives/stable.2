Received: from mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3A93ACA42
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670040; cv=none; b=YUYlL1vMam+Psa+MPiKU+0p3Z8eVMQhGITVI/w/5mfly0sdL2jjMW11LAc3Hc3Q0qpELCTH0nGcMmwZIh9cSdqKMVFuyM7cjwmoQOCiEZDu0i8LAl3ddZC7ok8QeBqoCWHgxZqggbw24RKIwZa5lCsNRhD0BSRFE+APbSuOLO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670040; c=relaxed/simple;
	bh=NmOcbrfa7/oEgE3yYkATzy2rrRVs99nl3VT8zcqmJIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbd+uje1eePoP+JJ4NjU+NQaozchlqyyU2LVRUnRLaMQWf0IWT28ymx1Jv/ymu8TaLpcuSgOIR2oof3ywFzzx7nMwn7hNOSVOoea2LKAugBURvTJIDN7mJTuPEV83syOGoyzdDa+HmwmfZ6eSTJ3DiBaAZdv/5GALAS2TN4Qnlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MqOOxr/M; arc=none smtp.client-ip=91.218.175.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MqOOxr/M"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NmOcbrfa7/oEgE3yYkATzy2rrRVs99nl3VT8zcqmJIA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790670036; v=1; x=1791274836;
 b=MqOOxr/M5xlQLVE6f5SuNx/zhY+H1Hpij1X8M2I+enGXQulH9aDm+bZKgpyhk2Ak1B2z7lLs
 hD5sanuwlxOedmZkafWp/N6+Oez+/dkFtp+BPoQkWlRKgaZ7JR5TnFh82LXVEXePhhYU29OA6Wh
 t2lXUNb41RLRkjFfsIFm1mF8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ce78a524c08d6a9f;
	Tue, 29 Sep 2026 08:20:26 +0000
X-Mizu-Trace-ID: ce78a524c08d6a9f
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	=Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Hao Ge <hao.ge@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v11 5/7] module: allocate codetag sections before the regular module layout
Date: Tue, 29 Sep 2026 16:20:12 +0800
Message-Id: <20260929082014.160587-6-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929082014.160587-1-hao.ge@linux.dev>
References: <20260929082014.160587-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whether a codetag section goes to the codetag region is decided by
layout_sections() and asked again in move_module(). A concurrent
load can shut profiling down in between, and move_module() then
copies the section to offset 0 of its regular destination,
overwriting whatever is there.

Decide and allocate in one pass, before the layout. Allocation
errors fail the load. On a tag area overflow profiling is already
disabled, so -EAGAIN makes the section fall back to regular module
data and the module still loads. The reservation is released and
module_tags.size rolled back, so a concurrent load which already
passed needs_section_mem() does not skip vm_module_tags_populate().

An SHT_NOBITS codetag section is zeroed explicitly, the tag area
pages are not zeroed on allocation.

When profiling was toggled off the overflow check did not run, a
module could load with more tags than the page flags can address,
and re-enabling profiling then silently corrupted /proc/allocinfo.
The check no longer depends on mem_alloc_profiling_enabled().

Based on a patch by Petr Pavlu [1].

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/499bb60c-c6e3-43a3-bd92-95a0567ece5e@suse.com/ [1]
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 kernel/module/main.c | 101 +++++++++++++++++++++++--------------------
 mm/alloc_tag.c       |   9 ++--
 2 files changed, 60 insertions(+), 50 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index ae2678ac7840..b7ebcc40bdda 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1723,20 +1723,6 @@ static void __layout_sections(struct module *mod, struct load_info *info, bool i
 			if (WARN_ON_ONCE(type == MOD_INVALID))
 				continue;
 
-			/*
-			 * Do not allocate codetag memory as we load it into
-			 * preallocated contiguous memory.
-			 */
-			if (codetag_needs_module_section(mod, sname, s->sh_size)) {
-				/*
-				 * s->sh_entsize won't be used but populate the
-				 * type field to avoid confusion.
-				 */
-				s->sh_entsize = ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK)
-						<< SH_ENTSIZE_TYPE_SHIFT;
-				continue;
-			}
-
 			s->sh_entsize = module_get_offset_and_type(mod, type, s, i);
 			pr_debug("\t%s\n", sname);
 		}
@@ -2795,7 +2781,6 @@ static int move_module(struct module *mod, struct load_info *info)
 {
 	int i, ret;
 	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
-	bool codetag_section_found = false;
 
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
@@ -2815,35 +2800,13 @@ static int move_module(struct module *mod, struct load_info *info)
 	for (i = 0; i < info->hdr->e_shnum; i++) {
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
-		const char *sname;
 
 		if (!(shdr->sh_flags & SHF_ALLOC)
 		    || shdr->sh_entsize == SH_ENTSIZE_STANDALONE)
 			continue;
 
-		sname = info->secstrings + shdr->sh_name;
-		/*
-		 * Load codetag sections separately as they might still be used
-		 * after module unload.
-		 */
-		if (codetag_needs_module_section(mod, sname, shdr->sh_size)) {
-			dest = codetag_alloc_module_section(mod, sname, shdr->sh_size,
-					arch_mod_section_prepend(mod, i), shdr->sh_addralign);
-			if (WARN_ON(!dest)) {
-				ret = -EINVAL;
-				goto out_err;
-			}
-			if (IS_ERR(dest)) {
-				ret = PTR_ERR(dest);
-				goto out_err;
-			}
-			codetag_section_found = true;
-		} else {
-			enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
-			unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
-
-			dest = mod->mem[type].base + offset;
-		}
+		dest = mod->mem[shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT].base +
+		       (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
 
 		if (shdr->sh_type != SHT_NOBITS) {
 			/*
@@ -2875,8 +2838,6 @@ static int move_module(struct module *mod, struct load_info *info)
 	module_memory_restore_rox(mod);
 	while (t--)
 		module_memory_free(mod, t);
-	if (codetag_section_found)
-		codetag_free_module_sections(mod);
 
 	return ret;
 }
@@ -2947,6 +2908,49 @@ static bool blacklisted(const char *module_name)
 }
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
+/*
+ * Allocate codetag sections separately. They are loaded into preallocated
+ * contiguous memory because they may still be used after the module is
+ * unloaded.
+ *
+ * If the separate allocation overflows, allocate the section normally
+ * so that the module can still be loaded.
+ */
+static int allocate_codetag_sections(struct load_info *info)
+{
+	for (unsigned int i = 1; i < info->hdr->e_shnum; i++) {
+		Elf_Shdr *shdr = &info->sechdrs[i];
+		const char *sname = info->secstrings + shdr->sh_name;
+		void *dest;
+
+		if (!codetag_needs_module_section(info->mod, sname, shdr->sh_size))
+			continue;
+
+		dest = codetag_alloc_module_section(info->mod, sname, shdr->sh_size,
+				arch_mod_section_prepend(info->mod, i), shdr->sh_addralign);
+		if (WARN_ON(!dest)) {
+			codetag_free_module_sections(info->mod);
+			return -EINVAL;
+		}
+		if (dest == ERR_PTR(-EAGAIN))
+			/* Allocate the section as a regular section. */
+			continue;
+		if (IS_ERR(dest)) {
+			codetag_free_module_sections(info->mod);
+			return PTR_ERR(dest);
+		}
+
+		if (shdr->sh_type != SHT_NOBITS)
+			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
+		else
+			memset(dest, 0, shdr->sh_size);
+		shdr->sh_addr = (unsigned long)dest;
+		shdr->sh_entsize = SH_ENTSIZE_STANDALONE;
+	}
+
+	return 0;
+}
+
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
@@ -2979,18 +2983,21 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 */
 	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
 
-	/*
-	 * Determine total sizes, and put offsets in sh_entsize.  For now
-	 * this is done generically; there doesn't appear to be any
-	 * special cases for the architectures.
-	 */
+	/* Allow codetag sections to be allocated separately first. */
+	err = allocate_codetag_sections(info);
+	if (err)
+		return ERR_PTR(err);
+
+	/* Determine total sizes and put offsets in sh_entsize. */
 	layout_sections(info->mod, info);
 	layout_symtab(info->mod, info);
 
 	/* Allocate and move to the final place */
 	err = move_module(info->mod, info);
-	if (err)
+	if (err) {
+		codetag_free_module_sections(info->mod);
 		return ERR_PTR(err);
+	}
 
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 3e6306ee0764..605c0016f646 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -951,10 +951,13 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		int grow_res;
 
 		module_tags.size = offset + size;
-		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
+		if (!tags_addressable()) {
 			shutdown_mem_profiling(true);
-			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
-				mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			pr_warn_once("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
+				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			release_module_tags(mod, false);
+			module_tags.size = prev_size;
+			return ERR_PTR(-EAGAIN);
 		}
 
 		grow_res = vm_module_tags_populate();
-- 
2.25.1

