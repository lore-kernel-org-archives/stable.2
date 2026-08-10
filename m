Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624F3B0AE3
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354809; cv=none; b=N/orVVdijIA3yoMUEl237YRDtHvB428tkc6DwpV3m1LRhKK2XQ2wDj6Hlrqm1ABZZxNMZ0Eku5LyhiAvVp/jsdHnokWgR3N3MX9l82ngN+/7oLmL132WK00ls8IdUnL+xNoKcsydA7tF6y81KXiAGslHSmzoinRTgVx70nrc+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354809; c=relaxed/simple;
	bh=+7z3AP/ISNgtjS8Lqlp+ZNKMBFC0XbB0Gkd40yGE6eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDQU3Gh6mlQpI/spKUWbRJb4rUXl/g1mp5RlIeS+FpvsyVgqGbpN7tSeTRTzfl6JrLmqL985L1TaAF9uuTqmCOkynRa/lhBYue9/f71H1TC0SjzIJR32Crq1qEEQJgrw5A+KxEwoJUqaBgOO9nk+PeEwz85Ia9bZHw6pLzBLytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X6JETdJL; arc=none smtp.client-ip=95.215.58.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X6JETdJL"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+7z3AP/ISNgtjS8Lqlp+ZNKMBFC0XbB0Gkd40yGE6eg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786354805; v=1; x=1786959605;
 b=X6JETdJLrNicIKajmnhxVTliKWjVG6cxTJow4sXQbILvCLiOXKsj1tEzo26qKwfiQ6S8BA+p
 XBBnPYe9+SwRw28+z938Zw4v/cTGcAmm7fp0KqIWYer0e0+XqfAbf4a71KvR+ElfK9ehdVX+6xJ
 F49syguUdUm0vLDLSDXRS+OY=
X-Envelope-To: stable@vger.kernel.org
Received: from localhost.localdomain (116.128.244.169)
	by mta10.migadu.com with ESMTPS id 52b4c21b50599e27;
	Mon, 10 Aug 2026 09:40:05 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
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
Subject: [PATCH v4 2/2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Mon, 10 Aug 2026 17:39:55 +0800
Message-Id: <20260810093955.153015-3-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260810093955.153015-1-hao.ge@linux.dev>
References: <20260810093955.153015-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Skip percpu counter allocation in load_module() when profiling is
disabled, as those counters would never be freed on unload.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 kernel/module/main.c | 17 +++++++++++++++--
 mm/alloc_tag.c       | 11 ++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..c32bb47a573a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2971,13 +2971,26 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
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
+			info->mod->mem[type].size = 0;
+		info->sechdrs[info->index.sym].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		info->sechdrs[info->index.str].sh_flags &= ~(unsigned long)SHF_ALLOC;
+		goto retry;
+	}
 
 	/* Module has been copied to its final place now: return it. */
 	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index af44f90379f2..3eba6331174d 100644
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
@@ -975,6 +977,9 @@ static int load_module(struct module *mod, struct codetag *start, struct codetag
 	struct alloc_tag *stop_tag;
 	struct alloc_tag *tag;
 
+	if (!mem_profiling_support)
+		return 0;
+
 	/* percpu counters for core allocations are already statically allocated */
 	if (!mod)
 		return 0;
-- 
2.25.1

