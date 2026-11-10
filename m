Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335148;
	b=BhXqBjc218HJok68KF6USAlEiNXCJhYwu6F0y9P0RUzA8nzXItLdKY4Kb9/fxd/xcA0t
	 Jigh2AG1aUkr2Ei3JxIrtfE1YplStW5eNdkUhVPnfi0dD/hWw5K7QmpcjyA6vhXfeRQmo
	 zPwxRBm6qyOtXeHckkg/YNOvpX+W2Ag15Xwb8imaeV16ngEP8XPcSb8ZAW3JsLGrpSzhK
	 qPXYoZkoWtCbrNTrDVRrshes5yl4fEPuxixIxFO8ruU5gbjkLq3A26gdgiUWstDQMTkBk
	 jMc+oIdREF3OjYLrhy0iGPswdlKKQl2wTa4oGvBgfksGTRZjnP8h7IEZdLxzd5vgMXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335148;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SJ9aItkkmtqJX10z69V48Y2IkdOQutkiStOOAJ5W1i8=;
	b=U1rWSSEE0fRqmMT6VDMzO0LrHO8Z3+rkqa4fweAf8wB+56+kUAziKFxGsu0tT783vjdo
	 yvyA6+D+fWUZWY1QDdsZ0iKl9Yx5m6H9a0XnwRVCtvXJtfEEMKX/uXPWZQKBnjFAOY9V9
	 7IvBHTsZ8pmycg7pVq1Z2pnkH0CJbYRCgc56+P/hrbmxrAzYzs1FWq0hcqTUjvOSmFUpD
	 XGKjlidsmCs3D5F9ESPXSXhRBlPDN7xYz1kq1cRLN9BrbNo5XLNGC7mEUJBzAkZHziJPG
	 zD6m4OUIQo+QOG8DOik6IwsGhPOa90AKyIaoRT7EpLehpNRnCnzPTDLCR+g0m2CaGEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHiOWXET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6134606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHiOWXET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9D11F008A7;
	Tue, 10 Nov 2026 18:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335147;
	bh=SJ9aItkkmtqJX10z69V48Y2IkdOQutkiStOOAJ5W1i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHiOWXETp4Ze0N9fFZVonePcFWoWi5mLmiWNdjNQGw6fD9u5vog8vYGL+OAdEYaYy
	 KAdc/LFx9bf9j3oFbgnTkBeZZ7i2mk9Xlzeg9dExuXFhofg6enQzuKBC0yL8FvZoo/
	 E9yT/vTJkmOn1jYaY0qSZjhnbD1vn+rlDvO4f5r8lVYzrvMoN5mmZxkcsGuJyzYffX
	 QA32/1yC17/uMLGqF1xWnHQ3PUjFO9ZQmT0VmLAfH5SV/ETyBDuD7lMIgZAC5nedSI
	 1WfsKoDeaZEiZhda6bEhcqsrnPE+zUTKK2+4+LqxtF2+j7lzlzAVv7FYLZP0i2dnMZ
	 JBBjfmzAyzCow==
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
Subject: [PATCH 6.1.y] mm/memory: constrain generic_access_phys() to page boundary
Date: Tue, 10 Nov 2026 13:25:44 -0500
Message-ID: <20261110182443.3160165-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054554-failed-6.1-ae0298a5fbef@kernel.org>
References: <20261107054554-failed-6.1-ae0298a5fbef@kernel.org>
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
[ sashal: adapted to the existing follow_pte() implementation, where the args.pfn cast change is inapplicable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 53334915fd4ad..dc227172ef9a4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5652,6 +5652,12 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		return -EINVAL;
 
+	/*
+	 * Limit access to one page at a time, as that's what follow_pte()
+	 * guarantees; expect the caller to retry to read larger ranges.
+	 */
+	len = min_t(int, len, PAGE_SIZE - offset);
+
 retry:
 	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
 		return -EINVAL;
@@ -5664,7 +5670,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if ((write & FOLL_WRITE) && !pte_write(pte))
 		return -EINVAL;
 
-	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
+	maddr = ioremap_prot(phys_addr, PAGE_SIZE, prot);
 	if (!maddr)
 		return -ENOMEM;
 
-- 
2.53.0

