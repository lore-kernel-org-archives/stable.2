Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703814;
	b=zlNXzUyZ+fE+nvJT68i00TkOjQcqDU+vneyBeB4rhUR91nQbVoz+CM+eTGK4hevW1N5h
	 iIlHUNyKzU55OvQUsdYLtXLY9QWDPWzweuiLIdkwgEgEXQxcgenrEwB+KGcOllTBlxTcz
	 Z+i0jxemfzfV3D2cPQICg2SM2GkE6/njJrpdynuzCpJkRFpL3InQaslLlc0ms1ER4WfOF
	 vDOuWgB2xFPYEcyS+IVMpg+tpCJ4n0iGCHYBsjapKe8ugnghe5A1HMIJu0fFZ7eLh813y
	 og67euYlKrc1jolqsTt9yXQd91QV6I/DA+pSHDpuEjQY8C8LH9n/b0oN3OyGCNPVhOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703814;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=plPWFpfqGx7yQM3ExTUPYJV4MkE+gTXad3DC+CagbLs=;
	b=DdcedGOxqIGjDm5Gar24ZmuNQcRajnSHiTaC8J4m0qRBJ5UbJk5CJXLhPuRO8oSD6nqx
	 dlBR1uVseWI1heYdjnO+Ggv57KD0Khz0QZltftZ/X/j4ZJ/Kp4eg46NN8k0OIJnwPw778
	 eFs3/x7lMqi9NI7FTOusNw/JWiPxVvzjxAoJXfJF5TtXRVkQ2bdUwU3TuupgeTavmf9IW
	 vxCyUekligd6A1ak8dSbmDRNAlFbcSA/bCaLaH/grtqaNC9uSFYvWdrdZSfkjUD7hQbim
	 leC/bYQCxssGYYA8Su+BXJwK5R392Vv5CJ1CcrSGRCTx/K6cTh+k7F+xeTWLHCPPCTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZ+QMJSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31650606A330;
	Thu, 26 Nov 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IZ+QMJSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4741F01566;
	Thu, 26 Nov 2026 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703813;
	bh=plPWFpfqGx7yQM3ExTUPYJV4MkE+gTXad3DC+CagbLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IZ+QMJSlW/ChnEEa61TEH6TVlSIkBjGzbdE+VlPU3v8gFeHBEpzdU7Bt4MAyerw1A
	 ymumvfoDm+7czXZvuvK+WxFgNwl3CAAitX/7c8AS/qm+roU7adVG8XzObX62erXYt5
	 E76K+O7EjvixvncnCfdQY2EdN68j7yMeXraGrXU3HnVBIQZZEE5s676OXkl6pyMjNS
	 /zLf4Dop0dnDOYZt937sxoIE6Va+/fIVmOKbUmn3W+4Jx9sLt6TrRgLesKf4+kyXGd
	 5tmxnDo4sIILGM8/yorTS600cD0VsbG1td2gzPfQPS/lDo/n1kIN1Qgp/IlgTjeu4I
	 GQPqNAJtNs79A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 26 Nov 2026 14:36:21 +0000
Subject: [PATCH v4 3/4] mm/memory: do not report OOM if insert_pfn() races
 a huge fault
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-huge-pfnmap-fault-races-v4-3-feecd58bb14f@kernel.org>
References: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
In-Reply-To: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>, 
 "T.J. Mercier" <tjmercier@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5213; i=ljs@kernel.org;
 h=from:subject:message-id; bh=9n3K4eqh9JyPtTUrjpIO8YkXNto62bbbJ++HU6wLJK8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5nF9MfniZ/9Au5rRfig96BI/XZBy3zQ7sPjDriMmC+
 bPmXuY43VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJbJ7C8L/UrGGfR9/+5dM2
 2SfmT+ssVLW75rCMwUf01efVJzZmxV1gZDiYc/GrxbHNC7cV7b9TUNjz8e9HxgjFY6sZH8u+EG+
 4I8AIAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

This is not currently safely handled by insert_pfn(), however, which
obtains its PTE entry via get_locked_pte(), and treats a NULL return value
as an allocation failure, returning VM_FAULT_OOM.

The issue is that get_locked_pte() also returns NULL if the PMD entry is
not a page table which can happen if a concurrent huge fault installs a
huge PMD entry between __handle_mm_fault() observing the PMD entry to be
empty and insert_pfn() being invoked.

This can result in VM_FAULT_OOM being reported incorrectly.

Fix this by introducing and using __get_locked_pte() which returns -ENOMEM
if a page table allocation fails or -EBUSY if raced.

This allows insert_pfn() to return VM_FAULT_OOM only when an allocation
fails and VM_FAULT_NOPAGE otherwise so the fault is retried.

The same change is applied to insert_page(), which only impacts DAX (which
has its own locking), however even in this case DAX can be impacted the
page table can be freed by madvise(..., MADV_DONTNEED) if CONFIG_PT_RECLAIM
is set.

This means that insert_page() now propagates the returned error, so -EBUSY
in the case of a race, resulting in the fault being retried.

Similarly, update walk_to_pmd() to return -EBUSY if it encounters a huge
PUD leaf.

And finally, update insert_pages() to return -EBUSY under the same
circumstances for consistency.

Target the commit introducing the first driver able to do this.

Reported-by: Eliav Farber <farbere@amazon.com>
Closes: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 50 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c07e1de63043..dfa307a9228c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2400,19 +2400,48 @@ static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
 		return -ENOMEM;
+	/* We may have raced a huge PUD fault. */
+	if (pud_trans_unstable(pud))
+		return -EBUSY;
 
 	*pmdp = pmd;
 	return 0;
 }
 
+/*
+ * Map and lock the PTE entry for addr, allocating page tables as necessary.
+ *
+ * Returns 0 on success, -ENOMEM if a page table could not be allocated, or
+ * -EBUSY if we raced and didn't find a page table.
+ */
+static int __get_locked_pte(struct mm_struct *mm, unsigned long addr,
+			    pte_t **ptep, spinlock_t **ptl)
+{
+	pmd_t *pmd;
+	pte_t *pte;
+	int err;
+
+	err = walk_to_pmd(mm, addr, &pmd);
+	if (err)
+		return err;
+	if (pte_alloc(mm, pmd))
+		return -ENOMEM;
+	pte = pte_offset_map_lock(mm, pmd, addr, ptl);
+	if (!pte)
+		return -EBUSY;
+
+	*ptep = pte;
+	return 0;
+}
+
 pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
 		      spinlock_t **ptl)
 {
-	pmd_t *pmd;
+	pte_t *pte;
 
-	if (walk_to_pmd(mm, addr, &pmd))
+	if (__get_locked_pte(mm, addr, &pte, ptl))
 		return NULL;
-	return pte_alloc_map_lock(mm, pmd, addr, ptl);
+	return pte;
 }
 
 static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
@@ -2523,9 +2552,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	retval = validate_page_before_insert(vma, page);
 	if (retval)
 		goto out;
-	retval = -ENOMEM;
-	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
-	if (!pte)
+	retval = __get_locked_pte(vma->vm_mm, addr, &pte, &ptl);
+	if (retval)
 		goto out;
 	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot,
 					mkwrite);
@@ -2579,7 +2607,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
 		if (!start_pte) {
-			err = -EFAULT;
+			err = -EBUSY;
 			goto out;
 		}
 		for (pte = start_pte; pte_idx < batch_size; ++pte, ++pte_idx) {
@@ -2891,10 +2919,14 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, entry;
 	spinlock_t *ptl;
+	int err;
 
-	pte = get_locked_pte(mm, addr, &ptl);
-	if (!pte)
+	err = __get_locked_pte(mm, addr, &pte, &ptl);
+	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
+	/* We may have raced a huge fault, if so, retry the fault. */
+	if (err)
+		return VM_FAULT_NOPAGE;
 	entry = ptep_get(pte);
 	if (!pte_none(entry))
 		goto out_unlock;

-- 
2.56.1

