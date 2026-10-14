Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378654A7D0;
	Wed, 14 Oct 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988979; cv=none; b=rNA46C/fgBMEvbgaz9H4qxLDn48sPri6uijNc0U7NqHP111r0JkjhYXQT/keMpy3Y+Ehnb1G+3opTlXgoCIhskL92ugKaj/6oAs8dd5LH2l8inF0nEpNYe79u1CwKAVQUo4A6wOB83NAze0eNn6LBX14qVQc33t8upyklMIv4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988979; c=relaxed/simple;
	bh=24xsS9uHXjbHNUmfuAgnap1aLrWSBY6Mx7i1m77Ij0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kflDWoQVcEn8jry0JBIvdS1G/y+yej2DqSzYcDl7nCkQB5fXZH7kcQzCTm4xwmS24IRhxfNOJnjokEpEdRmZGZ/VfO5o6sU85FOt5Z6EcuMFpG5FCvE6uSZqxggW7cs5qZZLKNnCGNLXIIH7bWq6NXqTyNVhZ1K0/C90bViIDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=RBgg/XHZ; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RBgg/XHZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=t/UZtKfAP/AOsCTLOqASa/QaRlwucOv4zkWaYhC/wA0=; b=RBgg/XHZEF5N4a/JZiG
	jP43gQhG6kJRhxVD+UVnG/cpXJfYdqXv+tkYtUFWvu6oYafc9fBg4QjYzBGXa9AquIuLEEhhsZ2EU
	3e6+ppoTzCf9+Ht+c/c1MEsntPoSdw+I4P7Ux97Xk6Ji/bBfgCGaJOM1/4+djhW00mZWnJkcGYLhw
	sti2RK8i+TowPnAQf3dzTp2myVyqjW4kk2UZP9uNz7xKq/AksmQsbro1IeD1OOop2Tug24foQYmWl
	ESOXF5pPFQ73IvLjxdZP/2NfWwwZ0ED2I1i3Sw1mId+dow5gCH2Agj8y4pY5Wkf4byiMFNIrK5Ick
	t3fAIp+ysN+vxGg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xH08A-005A8J-2F;
	Wed, 14 Oct 2026 16:42:30 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 16:42:21 +0200
Subject: [PATCH v2 1/2] mm/huge_memory: recheck a special PMD under the
 lock in copy_huge_pmd()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-1-e1548488fa68@virtuozzo.com>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3447;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=24xsS9uHXjbHNUmfuAgnap1aLrWSBY6Mx7i1m77Ij0I=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz5TUTk1Iq6n/aWWXcVJlaLQNo84wp5TFDgCA1
 cPpv8dcbTSJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas+U1AAKCRBRlgpH+WFc
 KnVYD/wNHthVuGM6T21qF1NC3MBC5WWWYhNN2wSERL0OJgSUtoxYYWvBeZGsCrUsmlg6MjLeCjV
 5Zqdhw5Khly/2gpOYdz1bYUYQS+6+4avGm/L9e/3h+mUkBjEr1Z+p5g7rOoEe9QeAGh7MjoCw0n
 PEYr3RSsywRBLqHoN7iCxNJojbjEmlMgW28z46Cn2PoGPirti16ZxoWpmTvC6EZs8hWrYS/YYeN
 xFTS4RAxPtk+xWGUeDP/jHeEniMBbEKf7/pNy54bbhxrD2Ln9p3EwanHm9V3noI2IFefm/QAvYg
 QBG33/zassG97uUFEjsi6XY+qree+V11hln5c0t7mOpjAv7uc/bdY7hzM7GC4T09QSZvUCTiwYQ
 Fj/VbO1VD8fqG3g45EiAoSOfUkUBdmPhhas2lw4qn5RnDAZHED1uAaFdJAAFBE33nF5aYB2Ehiq
 VZNgSaqnUj5Quue405tJEhJVt0lD5DvR4qBskWeVIX5O8+V9v/S1OSPkV/vBj4sYNFhujEIKoCT
 VYV71TiHUPiyFVQIhOk+RspeWyHi0nRK0KUUW0aXiuvhxDXFmc/qqQXgJE1pzRmGop/0uVgdX67
 XkmRK24Xi41gpTDYGTXE0aZGvvT53/enIROVbAjb+j6k2l6Xx8tA3XOwxm7GyirCDUGC+LieM6f
 CQsQZrrKGsQXv3Q==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

copy_huge_pmd() reads the source PMD without the page table lock and,
for a special PMD, installs that value in the child without reading it
again under the lock. The comment says the PMD cannot change while the
mmap lock is held for write, but unmap_mapping_range() does not take
the mmap lock: it zaps under i_mmap_rwsem and the PMD lock.

dup_mmap() links the child VMA into the file's i_mmap tree right after
the parent's VMA before copying the page tables, so a zap visits the
parent first and the child second. When the zap clears the parent PMD
after fork has read it, and passes the child before fork installs the
copy, the child keeps a mapping the zap was meant to remove.

Drivers that map special PMDs with vmf_insert_pfn_pmd() rely on that
zap. vfio-pci zaps its BARs when the device memory is disabled or the
device is reset, so that userspace gets SIGBUS instead of reaching
disabled MMIO; a stale child mapping still reaches it. panthor zaps
the CPU mappings of a buffer object it evicts and then releases its
pages; a stale child mapping points to the freed pages.

Read the PMD again under the lock. The zap clears the parent PMD under
the same lock, so either the recheck finds it empty, or the copy is in
place before the zap reaches the child, which then removes it. If the
PMD is no longer a present special entry, return -EAGAIN: the source
mmap and VMA write locks keep faults out, so only a zap can have
cleared it, and copy_pmd_range() then skips the empty PMD. Otherwise
copy the value read under the lock. pmd_same() would be the wrong
test: threads of the parent can still set the accessed and dirty bits,
and -EAGAIN on a present huge PMD makes copy_pmd_range() clear it as a
bad PMD.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 mm/huge_memory.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a5..fcea98f0d8865 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
+		 * The mmap and VMA write locks of the source keep faults
+		 * out, but unmap_mapping_range() does not take the mmap
+		 * lock and may have cleared the pmd since the lockless
+		 * read. Let copy_pmd_range() skip it then.
+		 */
+		pmd = pmdp_get(src_pmd);
+		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {
+			spin_unlock(src_ptl);
+			spin_unlock(dst_ptl);
+			return -EAGAIN;
+		}
+		/*
+		 * Make sure it's not a CoW VMA with writable mapping,
+		 * otherwise it means either the anon page wrongly applied
+		 * special bit, or we made the PRIVATE mapping be able to
+		 * wrongly write to the backend MMIO.
 		 */
 		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
 		goto set_pmd;

-- 
2.43.0

