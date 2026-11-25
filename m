Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621767;
	b=VkAIafXjNoH/b4WQogC+CJo1xhwcuDbLha04VQCREo6yvhdt6qUAZvubturnOa2U2to3
	 PyS4KTLVpdqtS0uIwAT4ffcRR5p0UyjqA1+u+BDxXpxGwjPkJLLxGcee0WYwn4iU3z8WV
	 8wwvlSopAl541jVg59IdMWQkioZo8kqJHeKAxR4iVUjO4wa1HOxbvJQziDRahN034UYHP
	 qZadsp358iQsZsQZjwOBhhY5L585PK3a/t4hazueP4VzjNq/o7e/xZDTHQ+nfJblsx2BN
	 AIbrNOG/THL09/vTS76XdkC8o9ntgxdxO46QCiBYkq3dJ7DhrTiVBWOuf0C7BbzgwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621767;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=jxE1/+fib+yfqKL7hQTdhQN4mMmRO0JPMa9EfCUn0qo=;
	b=phzOPdRPxLjKtSjKXNnSDMPlleo8Zz925BDMXzmZ/ssJofmtzUfDgTQ6BIdR9niyzF3d
	 9zwV6giowwxf07AYo9zLUnIUMWNTxG7AKXjcwNqBioPGwD4xZxxYd+/BsnAUzgjxtw3n1
	 Qrh5N+BGezs0l/4D/oapuG2+Ni5u2PHH4iBPos38KSFAE+/deqTun4KrcL0mPT6ORkP5y
	 IPJIsmy/WYaMuBKRaUfl4qhrkJKpER4zx9ksZ+b9T5DhWHLI/e+Qj1Br+4HOa7ET1AbqI
	 I4lalvwLVMFVhdlSMSvmqqi+x9uug6VNJ1l7Fv3fmDyRBanRzENEtkvU9/qBRfWQhXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5kZ8cZO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFF4606A321;
	Wed, 25 Nov 2026 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i5kZ8cZO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE83B1F0089F;
	Wed, 25 Nov 2026 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621767;
	bh=jxE1/+fib+yfqKL7hQTdhQN4mMmRO0JPMa9EfCUn0qo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=i5kZ8cZOJdNawYlTRVZPrmVOMxIFTkM0kiZawV34piEHw6o69PTf6ibI0YHGXLjIR
	 P65Ri51slfGoIgKk5Ve9nairo6xIQsrrh01Ptt/hhs5y0g5NtFJbpG3OO2cBS6TBtf
	 aYTAB+MIPqEgvPa+x5VNhZWW2zIJEMvtSJ2lZjgggIRw0hcIYXCFQhxM4+lJcEh77u
	 V+W0ozXT1ZBt6IqK8umIJVhykebDfasoq3/vc7lamO+xxVwrBnAo9j+zXr/jonRJu+
	 baZF0ZA0WFg+IK6tH3wN4BdqYZk3PHdWxmY6cG0eL2nSELpffitOOZNB0yHLB/q5IP
	 Lc5rVueipSK0Q==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 25 Nov 2026 15:48:51 +0000
Subject: [PATCH v3 3/4] mm/memory: do not report OOM if insert_pfn() races
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
Message-Id: <20261125-huge-pfnmap-fault-races-v3-3-bbc44489341b@kernel.org>
References: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
In-Reply-To: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
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
 h=from:subject:message-id; bh=lulZtlCT/rNCjAjKCr+HKwrQyF0d8uLYpS1OwrjQtF0=;
 b=kA0DAAoWz53NioHifxQByyZiAGsHA2mhDlQLMwrVll+T6x3OJmlGz+sUf7yA+uhcY1XxtA7OJ
 oh1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmsHA2kACgkQz53NioHifxTFnAD/dwjG
 uETKFncRNcYNGPcRyVQtP1yTsTyK13o4QO3NZLAA/1enaaGEuUE5n3YP+4M1KOg2Is7jcC8f3lV
 U5IwR48oF
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
index 20b818bcdfbc..2230c2079c9a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2383,19 +2383,48 @@ static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
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
@@ -2497,9 +2526,8 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
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
@@ -2553,7 +2581,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
 		if (!start_pte) {
-			err = -EFAULT;
+			err = -EBUSY;
 			goto out;
 		}
 		for (pte = start_pte; pte_idx < batch_size; ++pte, ++pte_idx) {
@@ -2865,10 +2893,14 @@ static vm_fault_t insert_pfn(struct vm_area_struct *vma, unsigned long addr,
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
 	if (!pte_none(entry)) {
 		if (mkwrite) {

-- 
2.56.1

