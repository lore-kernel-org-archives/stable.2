Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41335B657
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846077; cv=none; b=fsERq33NDkDDdx9XYtK5kBVFDncfPxaH5hoRUQFDAZ7fAV1Qq1nLphGknC1e1nDhuXrqAWcKAX4DAPoyNQdtSNWfykVSpm97Bd3eFCAReHxs3mqjm1tqC+3kPfBi1ofi/RjJYi4HAGATs8uMtsU5XtlLsaOr1SKZxUCFoC5UR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846077; c=relaxed/simple;
	bh=F7FMyRvxWAF2Z7610HOVSsKGPQbXiYODSlxaQVk9MMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K0cUgL+sumE8qOlby3h95kE8tV7/ER6ipn39y+WoN6RK7g2meAfdbBqhVZZjJOPFXOG10HE5vNuz2Ix+uCIL9/KXhr9Z/xsBchbBFYoQuo0kWLqofU7QNyjJCvwkL32Hz0F1A//4hpKdIr/yRHw019XC0wXp9hno8+OoW4mT41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TGkVHhF8; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TGkVHhF8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785846062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2sUfUtBlTrxznqbjUXb2OOf/gmZXR4ctuPKgvPoVXf0=;
	b=TGkVHhF8YYdSRTNBqyi/ZBaxf+Ijgcmu0ex0JOCEKNtRbQn+dIAwivlGIyX6KFGkvqeAnR
	AjHauDvs3Kzm/TUa6pi/7E79wDikBv1tyzMwlLRjkOrWQelV0rajHHggD2M7ky2Xr6UJHL
	M4lVUITZibvR6Zmv5tlYC8B7oCq/rXM=
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Ge <hao.ge@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Abhishek Bapat <abhishekbapat@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Tue,  4 Aug 2026 20:20:38 +0800
Message-Id: <20260804122038.190270-1-hao.ge@linux.dev>
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
Changes in v2:
- Return error after shutdown_mem_profiling() to skip unnecessary
  vm_module_tags_populate()
  v1 link: https://lore.kernel.org/all/20260804064408.105033-1-hao.ge@linux.dev/
---
 mm/alloc_tag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 52aece27b00e..d8c36430f1c0 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -904,10 +904,11 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		int grow_res;
 
 		module_tags.size = offset + size;
-		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
+		if (!tags_addressable()) {
 			shutdown_mem_profiling(true);
 			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
 				mod->name, NR_UNUSED_PAGEFLAG_BITS);
+			return ERR_PTR(-ENOSPC);
 		}
 
 		grow_res = vm_module_tags_populate();
-- 
2.25.1

