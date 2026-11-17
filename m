Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940325;
	b=IElI43n7vj+PFs6c0dk2/dB90mbC6gPRKkSiNUgJZUtqFNFVu/lJ4Fesud4qxcukVsng
	 8ne13Nq5DjmdmNNjqOsaTcfeVX8ST7+ml8fYzQXaIM2zwMQtNj8FfE5PwJnZAjr1qxKUP
	 TrSSshJ72kII/pBVYk8PYaroc9TQGSK6o5lOwSraUKnATivVmvQ3hdOb9g2w5QEHf2zwB
	 cVRGaU5ory4Nq/kkqJcsmW5SI0n9hwRyaaCi2tLQv3g/et2nTXPcqubylzOsVcUSmc0Bd
	 zwR7vZ9TrA0Vr/O0/9W2wLOeJC0iCgJgKu5J5GDDjKHPTPS/qnxfJLYbSayybcUeCCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940325;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LmYgXS2j+OqkL61e2BRHprYvo+imW1RdtkRAOJY6dIQ=;
	b=po9KGZ5enLps5Ji3rPhH1ofxOqq6PPcJRmZFf62wgjtk/L0Q3otrTfA4LYmvwabZuLK+
	 68McZ6WZyWI4uyHnCbaKuaY4TVxj+zAiok61Mki4hZL6Y77iLhh+0K8Gf/+CyH2OXkFR3
	 GHYufb0fSIUku9IdeT9vpc9+8BdRogtgYVDGUinAlIrkzrQOiv4KFSE0V7HFSpIcTSrqv
	 czyHrl9ChcQqL0TuiKRsnSWvzrhWhNvELMigeJKDAxFR+8b/UtvQ+RTE/AHzeRGxsFSYu
	 hgTa4Ee4Pbukc1REIHNOME1EYBbqVy0JWS3s2zrdQHz6XyHEOboIhOeqwrTicP+jaeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTEwdev8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C7606A33F;
	Tue, 17 Nov 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTEwdev8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF171F000CA;
	Tue, 17 Nov 2026 18:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940325;
	bh=LmYgXS2j+OqkL61e2BRHprYvo+imW1RdtkRAOJY6dIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XTEwdev8zMecd1RUlqSDNXj6cLrBVe7Q8pv7AG5q6/uv2UObUSAcjfVAYFJu6sHX6
	 xZSmgL+rE4hTBnAakpe4EQPiXvZjzYREZwIko2MYEPFRkTHU8FfOnpe1Eha++Yi3Xs
	 Pp5V9+jiQzXlX/nStK+N3ciDtH6uUY2G4mz6hqXmwmINJeY83Q00Lm7l3Irlmg/glQ
	 Epoen3m3u6GpT5NuK4iQGy32Bis/Vn94E+2qFVJVHmeRwbRCpc/WeLxS7+Xc7z5iZC
	 PAjafjplhsp5njWM1Act4+W3cKZ8nPm72rAhhN4wUxBph7Ox90JbA3QHxSxEzDYvM+
	 WURzJPwPRS/5g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 17 Nov 2026 18:31:34 +0000
Subject: [PATCH v2 3/4] mm/memory: do not report OOM if insert_pfn() races
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
Message-Id: <20261117-huge-pfnmap-fault-races-v2-3-276007e73bcb@kernel.org>
References: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
In-Reply-To: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
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
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=ljs@kernel.org;
 h=from:subject:message-id; bh=gqH7juwzoon3ftwWqkG3rZSx+Xcu56JBKdW0c7DDkP8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL+zO3esO2KcZdcQo/q8aRf385++su83HzxLd0v0+8uM
 928PyqhpKOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQATWZ7E8E9Z5gHT6yNNRRLp
 H/6wrVc78+1eidutteHbVGLfXzdK+v2a4Z+RdDXHcuZI96odK69OK+qTYXs65aFqdupGl5YXjn9
 S7zACAA==
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
if a page table allocation fails or -EFAULT if raced.

This allows insert_pfn() to return VM_FAULT_OOM only when an allocation
fails and VM_FAULT_NOPAGE otherwise so the fault is retried.

The same change is applied to insert_page(), which only impacts DAX (which
has its own locking).

This means that insert_page() now propagates the returned error, so -EFAULT
in the case of a race. It's not possible currently, but guards against that
changing in future.

Similarly, update walk_to_pmd() to return -EFAULT if it encounters a huge
PUD leaf.

Target the commit introducing the first driver able to do this.

Reported-by: Eliav Farber <farbere@amazon.com>
Closes: https://lore.kernel.org/all/20261112051440.16140-3-farbere@amazon.com/
Fixes: f9e54c3a2f5b ("vfio/pci: implement huge_fault support")
Cc: stable@vger.kernel.org
Suggested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/memory.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 20b818bcdfbc..04a518d6059f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2383,19 +2383,48 @@ static int walk_to_pmd(struct mm_struct *mm, unsigned long addr, pmd_t **pmdp)
 	pmd = pmd_alloc(mm, pud, addr);
 	if (!pmd)
 		return -ENOMEM;
+	/* We may have raced a huge PUD fault. */
+	if (pud_trans_unstable(pud))
+		return -EFAULT;
 
 	*pmdp = pmd;
 	return 0;
 }
 
+/*
+ * Map and lock the PTE entry for addr, allocating page tables as necessary.
+ *
+ * Returns 0 on success, -ENOMEM if a page table could not be allocated, or
+ * -EFAULT if we raced and found something other than a page table.
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
+		return -EFAULT;
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
2.56.0

