Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329822;
	b=SmwDrsKmK8Mz2e1SUdsBsFLqkox7juSdEiKI8Ssg8cx/g+nJ81Ge9+RsfuEkin8eB7LS
	 AXMQUvK9jcDdvGvYUSwUNsP8fng/D4OXqIi0LNEBHOVHfbvI8OICBi7R5FsLv++65j224
	 HI64xVPIppggInQ4FC3WjuHbwCcSwHrcbAyetmAIBuK17V6h7KxeMo4+mSQTgrFr/P8UV
	 XSO+HrGoP/wJLZiBvsTX8DI4RUv18EYjH3726ROL4ESyTtqcWNI5C+SwVwsyuTN6V3/DG
	 xyLeoeuUzuUDkpD+1HXuIKHFN2JLSw/K1QJa/QilFVqsrfJOvop6g2768uChb1M00qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Beeqtp5OVXOe0tTGMQfdFPhbl+k2SX9mz5TzeNe2+TI=;
	b=HjJY4UKRsquZcI0cMvh7MVdDy4AUB9Uk/eGLWFLHMa2mxLAIdEEZeB09GmYHJBp19cNA
	 2CDGS6DQLpR+FkFOjQaimN3U0pHuYOaJyx7+DqIJyFUF0uOwP93ANGz3BepO++9yxcvZy
	 rQDOS3+K22udh1NTQUdu2IaMl35OF0DWCeG8rB+QaqQtBMI853/SuX6VBrXf82zEN9xsO
	 KTwz6gHHTBwDghlR47gzG4ufnoHi+eiupEMUqSNFLfs9h9F8dvwVaSjwjSwrJdWEKFT37
	 RM31THBm1ghV0WlDcB/sz4MucL+bBJARkUBYzpRBZ9yF6/8sCRB3J3p/ba3GNO6vofA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtkpgLM1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7F3606A9D6
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtkpgLM1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A441F008A1;
	Tue, 10 Nov 2026 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329821;
	bh=Beeqtp5OVXOe0tTGMQfdFPhbl+k2SX9mz5TzeNe2+TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WtkpgLM1q1YDmSe6waNUTAP7R0ibp4Azdb2En3Elesq85e41IUr+JRCWp5DwzKNnd
	 ET4kRtmE3hXPAgwrPDpXNL4zwhu3hmKW4E66eJFAMvmSF2ZlrTEyxN7RDQs5NL6Q5Y
	 okf3eJNXwjuyeckZlmliwQRl69Gf6+hcLaEkKKtEFatoktZdo7JsLWIZF2bJuMr8pj
	 8t2YXNgfB/ADG3caA/DVNxFRuRo/hMhpLsVCrcn6hVhgh9xsslxVomeUL0p1b6F/kq
	 DpVoEyJ8AcrWhrqrhj9+K0ZnXe8YRVXHNrSBTcYnAQqxRLJhV2+LKYvyPZZwyY+Cme
	 GOTweU475VX3w==
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
Subject: [PATCH 5.15.y] mm: disallow ioremap'ing ordinary RAM in generic_access_phys()
Date: Tue, 10 Nov 2026 11:56:58 -0500
Message-ID: <20261110165630.2620914-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061132-failed-5.15-4590752e20aa@kernel.org>
References: <20261107061132-failed-5.15-4590752e20aa@kernel.org>
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
[ sashal: adapted args.pfn and follow_pfnmap_end() to pte_pfn(pte) and pte_unmap_unlock() for the existing follow_pte() interface ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e5c54f39e7e04..3c5abd02aca64 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5150,6 +5150,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	unsigned long prot = 0;
 	void __iomem *maddr;
+	struct page *page;
 	pte_t *ptep, pte;
 	spinlock_t *ptl;
 	int offset = offset_in_page(addr);
@@ -5162,6 +5163,19 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
 		return -EINVAL;
 	pte = *ptep;
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

