Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BD3A4F30
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786346101; cv=none; b=EVVHQj09zE+KXvvbO0GiF4od4UqyCafl8uvHHBbN2b0AwcNHwgsx+vi/SOggsrKjgfL6UQIO2/RZrHv9M1goy8hZsEbVmPB468h5ci2kgbof2X/r6tRIuJPYjQ/z4LMShIwuFoRKUqJRhvRlM6AlGP4y8YRgo3tgI45RMcAw4WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786346101; c=relaxed/simple;
	bh=+7z3AP/ISNgtjS8Lqlp+ZNKMBFC0XbB0Gkd40yGE6eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCpzQ6hnmBwfmbVt6DkF3bVqNp7De49Y8i7aD5fvZIZZKN87MujT0oo+Otb2roitW083IxY+7eFoOQmfTb6wIqis6en5u2M3tiXgkw94BCi+3iQOGKi3/0MHzPdtyjUVPrLik80ONhLrio+G0D8dtG3XS5WDUE4hmFiFp2+BYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WTzjCl4L; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WTzjCl4L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786346095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S15GzqqeJfm+V4QQMSDG2XpUw61+RqiF3E72EGNCgjg=;
	b=WTzjCl4LqiQP5pdOMsKpqbXIZjS0MMSTzbIbKG/uOcL8SB/XCdu8qWfu3ZAVSSLMdsRnCx
	w0lcjxR7WXNbxeuZH99n4F55IIxv80hWR5dZ1yVvLhiZvjQnWRHbWqpGB+Z22L/fv8m70M
	G88BQJIk4aCgRSC3ut2PgnBz07l0Ex0=
From: Hao Ge <hao.ge@linux.dev>
To: gehao@kylinos.cn
Cc: Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v4 2/2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Mon, 10 Aug 2026 15:15:18 +0800
Message-Id: <20260810071518.115381-3-hao.ge@linux.dev>
In-Reply-To: <20260810071518.115381-1-hao.ge@linux.dev>
References: <20260810071518.115381-1-hao.ge@linux.dev>
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

