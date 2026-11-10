Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331275;
	b=Re2+Kgil2ddC0Cqca5/nYUGAKUe8BI9JbUFBsQRZdy7ooas4cl/vVI/EI0JxhW+p6b7R
	 8UK2YIQCSIj8OxmdK2TGPoJNxxNwYSrUZeyQ1MfxMdSGiZmuIadjbbpAKVwGCHpuf0YGP
	 SoHbI2FC1bp8V6JdOhH+iLu2uVISpbCRf28Wh8yNVJ06t9jMxkFZ6YW1aE/lpMFBaypVv
	 ArB4GQb5uBritQ7np51PZ4hTpUdVTdJJB7ytpPCaiWT1F4NwZ/Gcl8ZvXdwh9kRT39EHU
	 PsI8el/Mx5ESNB03slSHHuVV9me8XdoCjroFrXo1/+2jiBenU68azEACuhFHr0ZfKPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331275;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H84rM+Y0wR7EbElopbz5RcYfa+BcZXdCGR3oZs7Bmng=;
	b=QH5W+Gls0F/89csCrFMosL8fxKBsCsToCnzRJzuaD/FgM35YVaCZM7F7uabT7iXmg42e
	 5C6ZNwS0Low/AJlKtbgPOFbmXE2hicJkH+Q758xN+PNE48+MJyObb/Z1W5/hNxjp3FE5q
	 xyFmBVMAzEir/CuzrR5JlcmmUJG6tpVypoxmrOI34pB76HxmbTukBm1Deme7smOYB2PH0
	 TSg7cuekqldhCTEf4W+hBWPdeGgCuztn/IOo6dzUuTE+GaTsTGQneKUEqMV2UmvqHqsXr
	 pV37fEM7WQ6esbZ8jQ3s4E2cL13i4/ZcV+kgEfwV9OPB3azsJszhRge4EmVytQSfd/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLmoqyJy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D06606A327
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LLmoqyJy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7161F008BD;
	Tue, 10 Nov 2026 17:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331275;
	bh=H84rM+Y0wR7EbElopbz5RcYfa+BcZXdCGR3oZs7Bmng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LLmoqyJyS1B1pXY1IJxXxi/IPCeVi81ubsWtRv0aDa2lPrgKCo8xdlALzOsbWdgNA
	 trotK2QA2fS7u1u8gHXNEpXaA/f0xDHaSAC/OP2VUDYRR7Gc/G6NoQhDJpJlVfa1VG
	 dpz3ok4QHit20LlY/tik27+p8Md1sLoM9MZmRyW5GVFHIEZA/PwRAZV2lV0jKwmRHq
	 i+tEnIP5WIe+rO/3KXuRaV2RYhDN5R5cMNP24/7n9G8ONUBtiF8lEwx1zijxl10bPc
	 hGycRWQnLf1kIaNUrIIKyD5mhPRzt1Je/BlhqP4tR+eCmJkZ2eJ+kGTeglsXg4hma4
	 U1qWkEikN36fg==
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
Subject: [PATCH 5.10.y] mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
Date: Tue, 10 Nov 2026 12:21:12 -0500
Message-ID: <20261110172038.2654712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062836-failed-5.10-4590752e20aa@kernel.org>
References: <20261107062836-failed-5.10-4590752e20aa@kernel.org>
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
[ sashal: adapted follow_pfnmap_start()/end() handling to follow_phys(), deriving the PFN from phys_addr after the PTE lock is released ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 403fcef10bdac..ad8184041a75b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4985,11 +4985,22 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	unsigned long prot = 0;
 	void __iomem *maddr;
+	struct page *page;
 	int offset = addr & (PAGE_SIZE-1);
 
 	if (follow_phys(vma, addr, write, &prot, &phys_addr))
 		return -EINVAL;
 
+	/*
+	 * Reject anything that looks like ordinary RAM, including anonymous
+	 * folios in CoW mappings or allocated kernel memory. Note that we
+	 * cannot distinguish memblock allocations from non-RAM reliably, so
+	 * we cannot easily reject them here.
+	 */
+	page = pfn_to_online_page(phys_addr >> PAGE_SHIFT);
+	if (page && !PageReserved(page))
+		return -EINVAL;
+
 	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
 	if (!maddr)
 		return -ENOMEM;
-- 
2.53.0

