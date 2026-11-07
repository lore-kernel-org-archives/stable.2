Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046823;
	b=dfANwk/LL8KMMwVO5wnujEeHFtUF9T9OGimWLcdUeT3dOBs8F2XXLOwXgrtRxxaw4X72
	 k7zticeNd9pR/KDxF4yssrqCD5Wit9trV477jJXziBnYxgPrubwqEzfOcAaunKQGL8jdK
	 XGvCKGarzpqBmoD1EeqS102fvRnaof4QOLZJXFu3RlfXasR3NiOVuAy3ytTS1LQhdEgK4
	 aRcJ5wtU/ix9koCDxOOj1Kbv7XQriwazLIOn6Pw9upjojnuiZWSJ2VkAxWDeK3jY7qyHC
	 cX8NExVOKOafZo0I2nykJxKU+FERemSfXg4TM/xw8deYHWiNQaV3BKVkhH38/GFD0uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Kjb73h3nFQR3LGOivYkEGD4pODkGUwk15gOTAGDttOo=;
	b=ICA1bf2XFqYrSziqzaYN/QJiOTd47Y4I5YCrC6E4WN6pPG9WRvS8Tm5NR1mtTE7BqsWQ
	 MKL8fZ9LLfG3wFazIQsJ/3N/YOWGgb05/pq0K4BZamOZv1AmAJgzsqFjgz9uPr07cf9jz
	 ylvKGGZGtKntwS2RCfihgfWb/jw6wJHuxClbvQErgLa44FBDyuK7rG+kbkpT8qUGW4r9q
	 HEVzFafp0NLMkEu4j2gc9jGxd/yJh026egs4OGzgEN6QMDkZo/fNMEDaIT2n+dOZMRNEz
	 P8YMyuXmAxhxzY53yVWIX5/749BepRMx4iMMYWnKidbBrjAYtNJS2OX9xAPzZQlcF2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLKuBYjV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11020606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HLKuBYjV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9139B1F0089F;
	Sat,  7 Nov 2026 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046822;
	bh=Kjb73h3nFQR3LGOivYkEGD4pODkGUwk15gOTAGDttOo=;
	h=From:To:Cc:Subject:Date;
	b=HLKuBYjVySyFp+BCcJ7MQFslHEsn7QYxBV8fr+aZySXeM/5umEoRpg8/wvHzVLfdc
	 Nvz4og2oPpfk9xdef/KFAI1h2eARM3vshsss7SopohLKtjjpQY7k9WY7SOAhjj6IJ3
	 MtBqH5Oy+rUz5k7hqUrliJeFX1xdnG4/2FC1PXhVaPFwEISzVCiVQei7soy/CTGmfx
	 z3dCPQlCCAue07J2FmTGvm26CW9hJtZ4aW7CtvkBhbgY0dfzgy2UL5BmGegJt+c3pk
	 Sc3yqBceF88sJQkuKXY/2bYSdOJeYEnsyArcZClMFRycYl6oujxZ8ds4Frf+4V14xf
	 dq6LaYYBLd4rw==
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
Subject: FAILED: patch "[PATCH] mm/memory: constrain generic_access_phys() to page boundary" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:20:20 -0500
Message-ID: <20261107052020-failed-6.12-ae0298a5fbef@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ae0298a5fbeff32951c0d31398ccec97ec6aa0ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052020-failed-6.12-ae0298a5fbef@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




