Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327454;
	b=eF9wKPFBcQZnKuQ5TAuSA5zjaiZccRIwOxXV0U8Gq4EpWT9IyDT3QCAaa1DF1kicMgBV
	 bsAimD27O9CU8pmDCG1fejF5zI5dPnk0giI1QFbReWFxtJ50kGy6Wlk5VbmrgHPVBvzQz
	 cosEHEFKIE18FAZIteXUbJ4A05rMk25Sidj0TjTgt8bE+G995VnHYd2rZWVAfI9tN2Yj6
	 QlfTEVTRPxfj49+0L9mmj0hkdKOOBzKWlQAASdLsiloOkZNeZvyWVxcYCFmA5Cy/A9pOP
	 sXYN4Wv1ZAYY5a98qW9HufD60+OXeM1ash/zccOMf4pvyj5jUcFUXdsBQa2HKZvQX4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0wJmbMVPbbHTLF3NQP8jLxfZGzWqVLmMGDwueQFPtPs=;
	b=RbL8ZQTXbBz+3GGVuANPSPd0UB2Ym6EEbDPEvCWOV33/LK2to3p02FskpyoNPdCsjVe0
	 NDiWCPUWXfmabsGDKLB66k+oxEtJjzRGQvMdGcS2dfh0RjijPgV/cuJqHfnQ1JEFSb69s
	 diJNRNY39PrZVgK/dLHo7lKvHiDAI6fiTsBeZc9iSwDr7TEoH+Mw5GcS+plk2c/gKUGi8
	 wu4gVSVb4xssX+EnpZd56qIViBjcjGlz4m7IK/a3Ae1iJa4SgyTqBlykzJYAOlpMeWtVt
	 j+aT/nnXs4Q5vEQ9dJV7Dk9LWXkaCcdTFrBHNLlalOo49z3uQ6oGa9Kbul8rC7xwpqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aRagFB2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99606606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRagFB2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D7C1F0089F;
	Tue, 10 Nov 2026 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327454;
	bh=0wJmbMVPbbHTLF3NQP8jLxfZGzWqVLmMGDwueQFPtPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRagFB2/mh0xJTHq+58uZu/leHIRy+gmVJrWjec27S1EjAi5s+4BDEisJqLFoAFhe
	 310UES6I14uZECsg57av+DvH0hKVcxTaqRLGdgfPj1+ZnSzHGgplVAXx73WlOC5fvT
	 7xiKiHu7dWaGrhv0G6RBFC0VFGiMMLKsLjXq2ch1G+Go2rngk+NgtNrFyL4SZdlxHr
	 tRANAnvtp3ZfBdFRibug05FZoUNv2BZIqSPsp52MYwlm61Gz/yFkSuBWz4C/DmXSqt
	 aMs/AX+M9a7JF0GwVlamVWEE/RYR2oXTUI0TXK6Rm+4W8KBKtI2PUYIyk/NPXVr3N7
	 EBN7JSqpa9f/Q==
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
Subject: [PATCH 6.12.y] mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
Date: Tue, 10 Nov 2026 11:17:31 -0500
Message-ID: <20261110161710.2414839-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052606-failed-6.12-4590752e20aa@kernel.org>
References: <20261107052606-failed-6.12-4590752e20aa@kernel.org>
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
[ sashal: adjusted context to preserve unsigned long protection handling with pgprot_val() instead of pgprot_t ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 564c0ce0aa6d7..379ebbb834565 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6567,6 +6567,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	unsigned long prot = 0;
 	void __iomem *maddr;
+	struct page *page;
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
@@ -6575,6 +6576,19 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 retry:
 	if (follow_pfnmap_start(&args))
 		return -EINVAL;
+
+	/*
+	 * Reject anything that looks like ordinary RAM, including anonymous
+	 * folios in CoW mappings or allocated kernel memory. Note that we
+	 * cannot distinguish memblock allocations from non-RAM reliably, so
+	 * we cannot easily reject them here.
+	 */
+	page = pfn_to_online_page(args.pfn);
+	if (page && !PageReserved(page)) {
+		follow_pfnmap_end(&args);
+		return -EINVAL;
+	}
+
 	prot = pgprot_val(args.pgprot);
 	phys_addr = (resource_size_t)args.pfn << PAGE_SHIFT;
 	writable = args.writable;
-- 
2.53.0

