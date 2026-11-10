Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333877;
	b=R0RLqRmtdEReN5Jr1ZcR1Jdrdl7KaVGhBNB8Q0mqP976ySwqazlc1ZMaElNnuhhzoZDL
	 T/cZ+tTvFsNztp0crNBK8yBxxTAkofRRoa3fr0DJ4qmenFmiLBnfEY1+p2MoCwKOmCSHL
	 jFy7wdJctP4w5zHnppoUtNqEAZjRh1vnvGKbauAhWMjYi0gzbuDaPHs8wcmTO+JOeJFjR
	 RPDyWP9ztj97XZYl+FV7sq81lDcDOc6o8KKzqNHOMGjy9spWhJ7YZGqCDXJnXFLQDELpR
	 RCNwwLdDYGdBkXZS8sLTWLvA0GR8daBnYNPXAZVvcbid2prVsdGux/jICPO5DXSFy9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333877;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S/FqL5qsrSDyBfTUxrvxQ8Ttte02sRNdxfzvppAPpJc=;
	b=htctMWMZcN5xnAWZQeYMs+ELPxYbLqKlkEz1kzwzgWXkpPGLtH22ldIPULolIITiZpza
	 fkq94hBi2WQXu5fsqFrZnLfW1N+k5rXTxhZjRlr5detz5hzSes2/dFixkI5RFX7L5Aqr2
	 82u5/XzX0zCKUjH4FWtJ0G/bDU8pzuaJ/Mx7P2+BT2XQqGKGvvVRohUncur/08dmUoRZJ
	 53lD29Iez09lboqt6ezcnzwTX1qFSVrgiXc7wANRFjxFE5Cxvme1J72DDQIbtCgoCzq0V
	 Y2xhs0sUa6bg11Tl4oODCS0hY4GYgmrJAtqwQk9Fl/aSotbaKQCA3AzWRpTirCOw1Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sk25a6Dm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2073606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sk25a6Dm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1530F1F0089F;
	Tue, 10 Nov 2026 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333876;
	bh=S/FqL5qsrSDyBfTUxrvxQ8Ttte02sRNdxfzvppAPpJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sk25a6DmMfTusvk9rWm1ZQWsROBPXGvIrMiDmetx4fulWvL+Q7yVLF/Xz8zIJNUVO
	 lPYCKRis502K6qNFtDg726dm9L/NHZRQrsFdW2SoYeOlraos3NILFK9+h7GxWaZT7f
	 sVftmjl/vQSrtODGoXFO/4c5HsmZfUg/N+CDPZNKdkx5uxQ2yC9b+ebQJwTkVB8LZ5
	 vbIBfMcpMMZW/+ozZXHWl/OcnXS/arwxGYoa49itR/DRb5PxV6BHKgwwuSQGfPBqCF
	 6BWyGvf4+4D2oL5uXlb/o7HX+ZhD3bAv2tGnIEEFq3RLhzEKyBXCZhm+a8xpkt2s9Z
	 PoUj1rAT6axeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luxiao Xu <rakukuip@gmail.com>,
	Ren Wei <weir@nebusec.ai>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vega <vega@nebusec.ai>,
	David Hildenbrand <david@kernel.org>,
	Grazvydas Ignotas <notasas@gmail.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/memory: constrain generic_access_phys() to page boundary
Date: Tue, 10 Nov 2026 13:04:33 -0500
Message-ID: <20261110180205.3057093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052020-failed-6.12-ae0298a5fbef@kernel.org>
References: <20261107052020-failed-6.12-ae0298a5fbef@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

[ Upstream commit ae0298a5fbeff32951c0d31398ccec97ec6aa0ea ]

This patch addresses an issue in generic_access_phys() where accessing
memory across page boundaries in PFNMAP VMAs assumes physical pages are
contiguous, which can lead to accessing unintended physical memory or
exceeding VMA boundaries.

generic_access_phys() improperly validates the memory access range: it
only validates the start address using follow_pfnmap_start() and passes
PAGE_ALIGN(len + offset) to ioremap_prot().

This poses two problems:
1. In PFNMAP VMAs, consecutive virtual pages are not guaranteed to be
   physically contiguous, and individual PTEs may have different access
   permissions or writability.
2. The mapping may cross VMA boundaries if len extends beyond vma->vm_end.

Constrain the access in generic_access_phys() to at most the current page
boundary (PAGE_SIZE - offset) and map only a single PAGE_SIZE via
ioremap_prot().  Since the caller __access_remote_vm() already loops over
the requested length and handles partial transfers, it will naturally
iterate over the remaining pages.

Also add a missing (resource_size_t) cast during PFN re-validation to
avoid truncation on 32-bit PAE systems.

Link: https://lore.kernel.org/e06e28a46c2a176238f03b5740df0913e57c2861.1788842306.git.rakukuip@gmail.com
Fixes: 9cb12d7b4cca ("mm/memory.c: actually remap enough memory")
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adjusted context to retain prot != pgprot_val(args.pgprot) for the unsigned long protection API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 564c0ce0aa6d7..b452d3c91e25a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6572,6 +6572,12 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	bool writable;
 	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
 
+	/*
+	 * Limit access to one page at a time, as that's what follow_pfnmap_start()
+	 * guarantees; expect the caller to retry to read larger ranges.
+	 */
+	len = min_t(int, len, PAGE_SIZE - offset);
+
 retry:
 	if (follow_pfnmap_start(&args))
 		return -EINVAL;
@@ -6583,7 +6589,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if ((write & FOLL_WRITE) && !writable)
 		return -EINVAL;
 
-	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
+	maddr = ioremap_prot(phys_addr, PAGE_SIZE, prot);
 	if (!maddr)
 		return -ENOMEM;
 
@@ -6591,7 +6597,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unmap;
 
 	if ((prot != pgprot_val(args.pgprot)) ||
-	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
+	    (phys_addr != ((resource_size_t)args.pfn << PAGE_SHIFT)) ||
 	    (writable != args.writable)) {
 		follow_pfnmap_end(&args);
 		iounmap(maddr);
-- 
2.53.0

