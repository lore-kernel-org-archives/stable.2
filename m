Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328117;
	b=riAMt6+mfLxRNwoGOCfaylvm9L2vjEFt1+zv2tJjwGSIvSL6AJKlt/rmYSNmmk8MAiyY
	 i2hozHTjKv+uf0Uq8umzyMcgmTpllb9zVKe1kB1Cf8ReH1vOz/JN975qgQg2xADWonnlS
	 rpDwFYGWBrbN4zrRv0YLkFntavzvU/C/XVYf/KFpXUOmfvXQPEcAR364N5SU6OvicvLab
	 WJcIFZgFLimN8IRqVrokJfAgbxQpLSMm92npce5hUMBZZ2kWKQ6iSikH/qL5L6ZW8btzG
	 GTwLMij+KUV5OtecM4p9SovfBvB809zbMQPeTQElDPUoiMRV9wz+OBdgdhTMb+HJHaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328117;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=j2hGvG/ODFJfrs6rMDguXVF6yRZLpOuLDIeqIBU3BNI=;
	b=Y+Q8JvxfeKAy7XFRJVt+Atb+auyF9CEqy1wcpoJ7aPJm7LNXPbCsM0VtFejLVbeGvllj
	 s/mT2/hvQJuPeCfm82hyoWAPDJ+rIQ3d+6QD0jRi5xt0N0avC7/m06d+W1thF+Tqfrniy
	 PIG+Gue+Vu2+0NY2s5Rh7M4g6kaLpJ++VYywtETCUfvdG7oEPq43drxEyLlK+XsqLHI51
	 LIBtZY0Qg1cUDLfUv7qZcIih47dnEVKAscYXTPtrXvKtgknH1MtdImHG8lBokWH/LRXFd
	 mQm+j/z2WDexdjTDsiIJ+hcvUCac3eNlTXwrWKNWWZOZAlP0odLrN9JmsvBj0vN8V2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/bb/2KH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B78606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/bb/2KH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDE81F0089F;
	Tue, 10 Nov 2026 16:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328116;
	bh=j2hGvG/ODFJfrs6rMDguXVF6yRZLpOuLDIeqIBU3BNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/bb/2KHutSa13uqr0fbLk/rjRzQE/6f6aOx8Cu8Xtd2/LAAA49j7WWpmnTUGIER7
	 MZDKLqCHyecPUcCve2X1N0ML3Lj+lbQKj80u7chxZi5IGHqxb/prTDui7B6M0dNJGY
	 OYg9PxXSBR6Y1p1sDp9wbE3pW6ghU4auOGbGMTJ8+zZJbPDH/KlUStUYlzcDSgW2Sb
	 7fn/kjeenhxOA7fqv2tZzZd0Lql/plyLIfGXsSKf4e2KZQsUL8ZCR+mm94lvtRMyCY
	 225aLp0ZTKEK2mY9NsfXNr/S1ib9vsxlYDQCjqcDKPY54ttz8N8hHhAdEMP74zHB50
	 CSh4md3pEryTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Rik van Riel <riel@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
Date: Tue, 10 Nov 2026 11:28:33 -0500
Message-ID: <20261110162754.2491684-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053852-failed-6.6-4590752e20aa@kernel.org>
References: <20261107053852-failed-6.6-4590752e20aa@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 4590752e20aa393cc0d4fe538c0747d14a98c97a ]

generic_access_phys() can end up getting called on CoW PFNMAP mappings,
resulting in it trying to ioremap anonymous folios, which especially
the x86 code doesn't enjoy, and which is in general just odd/wrong.

E.g., with a CoW mapping of a PCI BAR:

ioremap on RAM at 0x0000000045623000 - 0x0000000045623fff
  WARNING: arch/x86/mm/ioremap.c:216 at __ioremap_caller.isra.0+0x4c2/0x5f0
  Call Trace:
   generic_access_phys+0x130/0x4d0 mm/memory.c:7178
   kernfs_vma_access+0x1ce/0x280 fs/kernfs/file.c:437
   __access_remote_vm+0x58f/0x890 mm/memory.c:7256
   mem_rw+0x2a1/0x670 fs/proc/base.c:912

But more generically, we should disallow access to anything that looks
like ordinary RAM in the system: including allocating memory (e.g.,
alloc_pages) and mapping them in a VM_PFNMAP.

For pages with an online memmap, allow only pages marked as reserved
(PageReserved). This also includes memblock allocations, however,
distinguishing them from other MMIO is tricky, and nobody should really
be mapping them in a PFNMAP (except someone abusing /dev/mem, which we
do not care about).

So only allow access if there is no online memmap, or if the pages are
marked reserved. Reject other pages with -EINVAL.

Note that, just like other pfn_to_online_page() users, we won't care about
concurrent memory offlining; mapping memory that can concurrently get
offlined is highly dubious.

Link: https://lore.kernel.org/20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org
Fixes: 28b2ee20c7cb ("access_process_vm device memory infrastructure")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=49b1021becba70c1f3f6
Reported-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Closes: https://lore.kernel.org/r/20261001152524.171115-1-ngocthang2710.1999@gmail.com/
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rik van Riel <riel@redhat.com>
Cc: <stable@vger.kernel.org>
[ sashal: Adapted PFN access and cleanup to the existing follow_pte() API using pte_pfn(pte) and pte_unmap_unlock(ptep, ptl). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 6d4a1032ca61a..8376b7c768831 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5757,6 +5757,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	unsigned long prot = 0;
 	void __iomem *maddr;
+	struct page *page;
 	pte_t *ptep, pte;
 	spinlock_t *ptl;
 	int offset = offset_in_page(addr);
@@ -5769,6 +5770,19 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
 		return -EINVAL;
 	pte = ptep_get(ptep);
+
+	/*
+	 * Reject anything that looks like ordinary RAM, including anonymous
+	 * folios in CoW mappings or allocated kernel memory. Note that we
+	 * cannot distinguish memblock allocations from non-RAM reliably, so
+	 * we cannot easily reject them here.
+	 */
+	page = pfn_to_online_page(pte_pfn(pte));
+	if (page && !PageReserved(page)) {
+		pte_unmap_unlock(ptep, ptl);
+		return -EINVAL;
+	}
+
 	pte_unmap_unlock(ptep, ptl);
 
 	prot = pgprot_val(pte_pgprot(pte));
-- 
2.53.0

