Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD43921DD;
	Wed, 12 Aug 2026 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513271; cv=none; b=KJUVtLwqZ6qwuF+aX3gteKVJzfzOuGto6mIsrSBil+dz8H2gyTdTo6zq8iTu9lIi0+I97m8d7wk5l/L7+So/V7+RAlxqZhmdoo+mS79E0VsgRfwscMAR7mdS2ZIjEyVJqCZfY8vmQR+1SKsEWveyvJlefZ2EIm8lQq70AH3adqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513271; c=relaxed/simple;
	bh=E6uGsbGqqzCkRoxACNAXopQ2UoUWKRxtKe6zwPPJj0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1Ivu3bRjuY+RB+ZXeIcZx1i3Yw2t1MzgKkz+pWova9y1wk4fXSM6UbD+6BQ4rs7HbSIHP0lYHPoezveprVADRbWLcJqNmZqLefHtdQgsC/6JOsfXatMNtzVsO3ySj+XVFAlXEPLehmK61RD0oEcJYuERrJaczU8wwmlrf2Ze/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Whpnxh9p; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Whpnxh9p"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786513266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TJw8Kb7KYo62APlX8MEZxvAZlhH4o0ziACenqfJhSwk=;
	b=Whpnxh9pXp2+bTxNYX9GyGV2YNWyFmEhiFLBxTHM1emfN+vJjElCcTotxQwVy3X1umLo6t
	yiTOJm0OqPnobb7aV185QEy//Yh3hnbhvUFaABU9uMRD6FwBkggx2YIhowltCfc/AyM1lq
	HTTnFTnQdY/3c7KPSiV2czkyKaweldU=
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Wed, 12 Aug 2026 13:41:05 +0800
Message-Id: <20260812054105.102637-3-hao.ge@linux.dev>
In-Reply-To: <20260812054105.102637-1-hao.ge@linux.dev>
References: <20260812054105.102637-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In reserve_module_tags(), the tag overflow check is gated on
mem_alloc_profiling_enabled():

    if (mem_alloc_profiling_enabled() && !tags_addressable())

If profiling is toggled off at runtime and a module is loaded whose
tags exceed the compressed-mode limit, shutdown_mem_profiling() is
skipped. vm_module_tags_populate() still maps memory for the tags and
the module loads successfully, but the total tag count now exceeds what
NR_UNUSED_PAGEFLAG_BITS can address.

Once profiling is re-enabled, ref_to_idx() computes each tag's index
as its position in the alloc_tag array. update_page_tag_ref() masks
it to alloc_tag_ref_mask before storing in page->flags. Indices
beyond the mask are truncated and idx_to_ref() resolves them to wrong
tags.

This silently corrupts /proc/allocinfo: allocated pages get attributed
to the wrong call sites, so the statistics it reports are wrong.

mem_alloc_profiling_enabled() and mem_profiling_compressed are
independent. Once compressed mode is established at boot, it stays
active regardless of runtime toggles of mem_profiling.

Remove the mem_alloc_profiling_enabled() guard. On overflow, shut down
profiling, release the reservation, and return -EAGAIN so that
layout_and_allocate() retries with profiling disabled: codetag sections
are then placed as regular module data and the module loads without
profiling rather than being rejected entirely.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 kernel/module/main.c | 25 +++++++++++++++++++++++--
 mm/alloc_tag.c       |  8 +++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..ed26f167be84 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2944,6 +2944,7 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
 	int err;
+	unsigned long frob_size[MOD_MEM_NUM_TYPES];
 
 	/* Allow arches to frob section contents and sizes.  */
 	err = module_frob_arch_sections(info->hdr, info->sechdrs,
@@ -2966,18 +2967,38 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	 */
 	module_mark_ro_after_init(info->hdr, info->sechdrs, info->secstrings);
 
+	/*
+	 * Save the sizes reserved by module_frob_arch_sections() so they can
+	 * be restored if we retry below.
+	 */
+	for_each_mod_mem_type(type)
+		frob_size[type] = info->mod->mem[type].size;
+
 	/*
 	 * Determine total sizes, and put offsets in sh_entsize.  For now
 	 * this is done generically; there doesn't appear to be any
 	 * special cases for the architectures.
 	 */
+retry:
 	layout_sections(info->mod, info);
 	layout_symtab(info->mod, info);
 
 	/* Allocate and move to the final place */
 	err = move_module(info->mod, info);
-	if (err)
-		return ERR_PTR(err);
+	if (err) {
+		if (err != -EAGAIN)
+			return ERR_PTR(err);
+		/*
+		 * -EAGAIN means profiling was disabled but the module
+		 * can still load without it. Reset state and retry.
+		 */
+		rewrite_section_headers(info, flags);
+		for_each_mod_mem_type(type)
+			info->mod->mem[type].size = frob_size[type];
+		info->sechdrs[info->index.sym].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		info->sechdrs[info->index.str].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		goto retry;
+	}
 
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index af44f90379f2..0a7b657fe2de 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -950,10 +950,12 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
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
+			return ERR_PTR(-EAGAIN);
 		}
 
 		grow_res = vm_module_tags_populate();
-- 
2.25.1

