Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97223E5577
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920839; cv=none; b=I3sJIDKwltgSXlh0MPhKmU1uH90+ev0i3iNtV6Baxxvv12HR/GYauf1LO8tRqI9pY9OT0cifA2aBpiukngvg0pvnAX3MAWTIuLU5YiHLhqqKZzmiA8iZLlbRsxf4s4o5+g3HGcMfX6QZPN8PcF+4vFmWd+CKAzQytQLyuwdQ/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920839; c=relaxed/simple;
	bh=ZU6v8I4daYgdcFRU986MFTtrdAQdVf/8pPtXosI/Pq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PsXzyiASJP6/FDNF9ktxgR15OhzcyJfMS/72l0EvN6737gs5n2awNnAeeqL/N/5p2JXUbyA87z4QtDj3Cfzf618/+cyBIH/hZtUA3Q/dTtJTr/QdMxFEVZLuAt8qwHgv61fLdbG86MFEjPryZNouqQpRgOABkhZ7T9KR6JREsJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nTH612fl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nTH612fl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785920835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+XTh5YfCdnKB/aSwCeyPpNR+1ZVZMYEDrrf6Diqu2cE=;
	b=nTH612fl5Vx0YT6YPtYYSnjipDresEX6tRnZQ8RbdJVw/AOH7TfOtn/i3TgClbt8mMF6Wv
	Oq1O87t34dsD5zqSdcYNp3CZzGlnJorCSfnhMGn99atn/ArjpuGd5UxIQEIllMyKQgUJFm
	SHUFUS/dHKzw6+ff4wLm9afuBDZUQTw=
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Ge <hao.ge@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Abhishek Bapat <abhishekbapat@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Wed,  5 Aug 2026 17:06:33 +0800
Message-Id: <20260805090633.141001-1-hao.ge@linux.dev>
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

Remove the mem_alloc_profiling_enabled() guard. Also return an error
after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
the mapped pages would never be reused - shutdown_mem_profiling() sets
mem_profiling_support to false, so no future module load enters the
codetag path.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
Changes in v3:
- use pr_warn_once() instead of pr_warn()
- return -ENOMEM instead of -ENOSPC (Suren)
- expand the commit message to describe the /proc/allocinfo impact
  (Andrew)

Changes in v2:
- return an error after shutdown_mem_profiling() to skip
  vm_module_tags_populate()

v1: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@linux.dev/
v2: https://lore.kernel.org/all/20260804122038.190270-1-hao.ge@linux.dev/
---
 mm/alloc_tag.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 52aece27b00e..35ef2bbfa13a 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -904,10 +904,11 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		int grow_res;
 
 		module_tags.size = offset + size;
-		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
+		if (!tags_addressable()) {
 			shutdown_mem_profiling(true);
-			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
-				mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			pr_warn_once("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
+				     mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			return ERR_PTR(-ENOMEM);
 		}
 
 		grow_res = vm_module_tags_populate();
-- 
2.25.1

