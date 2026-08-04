Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7A426ED3
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825884; cv=none; b=XHs4/c/zjdrti0ruroHgQBbT2fcS+Q9nf+h7HHHyvnA0skixG0K8nx/jg+6+q+IkEdhXqnB1DyyazSt+SB8ZiudSN4/xs5h0VMR+mtGEM4P5t3AKyAdb/Vs2LUzutSjTkIKSgf435GMV+WNDGs/r5ka83hH1vhniWXzso/lniP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825884; c=relaxed/simple;
	bh=auyo8K/F0LOd5Qt/4SOXsPr0pHJn1K42mGK0XoMRGS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/7/ftxIFCKyLcjkqaWWxr7db+YWo00T4cY/Pg2uBtZ1WjrfvCFV693XGHVT6VUC7GR6wT8DCqluhYMNPivvLQXuWIGlrVZrKudhjEbSf+wHDRQZ505Vw3hArSwxdFMVSrJV8WmNTBDfD+MAPqiFzKTNR5hMb7ejmTIsJi/Ovxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ta9rkB+P; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ta9rkB+P"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785825870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zKx75AMauM0RaOxCF4agyTe8wC94OE6OVaWCflojIjw=;
	b=Ta9rkB+PXIYAYLAnSW3VYj9gennu9yzIK27t64FtepCEz+k78xTO29O9dhgq+0Ezcyw1qk
	TEPtyLHvsPGcg+yWOfldKG1o7yf23+dGfP96HgFAOrMhHuxekJqF/hJyjm38xpOl7f+1Sx
	O6pgGIgtEiRTc7DdzWXX7bq+BN/rk5Y=
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Ge <hao.ge@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Abhishek Bapat <abhishekbapat@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] alloc_tag: fix undetected compressed tag overflow when profiling is disabled
Date: Tue,  4 Aug 2026 14:44:08 +0800
Message-Id: <20260804064408.105033-1-hao.ge@linux.dev>
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

We therefore remove the mem_alloc_profiling_enabled() guard.

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index 52aece27b00e..a387a17211de 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -904,7 +904,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
 		int grow_res;
 
 		module_tags.size = offset + size;
-		if (mem_alloc_profiling_enabled() && !tags_addressable()) {
+		if (!tags_addressable()) {
 			shutdown_mem_profiling(true);
 			pr_warn("With module %s there are too many tags to fit in %d page flag bits. Memory allocation profiling is disabled!\n",
 				mod->name, NR_UNUSED_PAGEFLAG_BITS);
-- 
2.25.1

