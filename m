Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048357;
	b=ibfANUFe7tCgbERohmr+MXEhyRF/upCRd3qqCsZKdkTmean5/8qWF0D7N9FCfp0glv5U
	 usGgaeq7BxgsM8Iz1lFS27pJdy2FRArYjAv19iguzpmsSHSsunf/OXTiiPhnPAZG5lvMy
	 v1eqAeSlwNM+So7mn42cShMqiccq4mScospqJMVhZSP2mNYzjLQ2HmDST7xqnQp15GSzz
	 dCsFw13c8Afn+EK5jhcwqPAXN8LGBVYR8LsyTa2dGCWYGwflYO3cfpVD6rHPcDgBu7/fF
	 dfzPsMHdWhgMRtp4G2aKgLSD+2VMKedHg+9meY+TAF8TBCDqWG3gaD4LJfXuS6EM4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HLOwUv3+pQC8JCq0jU/zn0JwPbzHdzAhW53AqGAmcng=;
	b=1kwrzrxSOHCcSyMOfOI6tYK14T+NcrTLhhpOyX9Zl+TV2OD9TC4CH6mhkBfR3e7thju0
	 2ozMiIj4zyOh11X8uRpc7LIhjyAqRi5T9b9gOhwwxj5GSE4tej9W240UN0zRaA6zClgIj
	 lxWIjYlpZJBZyFSlAwXft77jGzoJlYwJBLGzMwyWQBJsG+bGtaXavD38HarvZppNVhg2M
	 2CD6fOZam/9Fuke9sENLFGxDNqF83wT2DlyTkiPAoOb/Pe0qzHj3TzVITD28Hz5bdpITY
	 cXoD9Bn1cpUTzLiqwW76n2MQHuBqKNF3nykdp0Y8LqPpyAuJCEicDZHUHkct8YknfzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOcSuuWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE93606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oOcSuuWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A501F0089F;
	Sat,  7 Nov 2026 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048357;
	bh=HLOwUv3+pQC8JCq0jU/zn0JwPbzHdzAhW53AqGAmcng=;
	h=From:To:Cc:Subject:Date;
	b=oOcSuuWGu2mVV94Rj9DyibXWvW+kAC05M254Hw8yTdfGqK3jWoyk8fAorqeWuyV1V
	 RWpurI0K4H991o6L+DdzcSiJOEPrfw5cRYTQdhsCkj6aPa/JRy1yNJEpXHzhlgUn7v
	 qbZ1nvO9HmG/0w7Q/OCQ//igy4lbga205FZ6aRqZYyLMsVtvw92cBBgTqww7jBA61I
	 1baqZXcbSf/SEV+gOosMsmqjC9h2Thtcf7D+9smdCQ2ZtSe4zpjAcv/J3AY73KKY+y
	 nUo5uuxXWDnchd/UG7rQyZqSqKJZ57rdYY2iBcKLmPWVtObRqzBFpwpy/NJ81gNHdi
	 WD1WVKABz3chw==
From: Sasha Levin <sashal@kernel.org>
To: rakukuip@gmail.com,
	weir@nebusec.ai,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	david@kernel.org,
	notasas@gmail.com,
	liam@infradead.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memory: constrain generic_access_phys() to page boundary" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:45:54 -0500
Message-ID: <20261107054554-failed-6.1-ae0298a5fbef@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ae0298a5fbeff32951c0d31398ccec97ec6aa0ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054554-failed-6.1-ae0298a5fbef@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ae0298a5fbeff32951c0d31398ccec97ec6aa0ea Mon Sep 17 00:00:00 2001
From: Luxiao Xu <rakukuip@gmail.com>
Date: Thu, 10 Sep 2026 11:42:50 +0800
Subject: [PATCH] mm/memory: constrain generic_access_phys() to page boundary

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
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ec63dd6212ac5..926276d419202 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7131,6 +7131,12 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
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
@@ -7142,7 +7148,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if ((write & FOLL_WRITE) && !writable)
 		return -EINVAL;
 
-	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
+	maddr = ioremap_prot(phys_addr, PAGE_SIZE, prot);
 	if (!maddr)
 		return -ENOMEM;
 
@@ -7150,7 +7156,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unmap;
 
 	if ((pgprot_val(prot) != pgprot_val(args.pgprot)) ||
-	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
+	    (phys_addr != ((resource_size_t)args.pfn << PAGE_SHIFT)) ||
 	    (writable != args.writable)) {
 		follow_pfnmap_end(&args);
 		iounmap(maddr);
-- 
2.53.0




