Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598483;
	b=fUj4RykHxoeUSG8u2SvxR+Enmlbce69ca9kQsWlryv7anFzK2ssrfD6/mbpoE8mxSk5X
	 XBpyQ51tYTROAwiCvrfnePb48fCxyS5PWgGUrg5jjHV5LNjld4FLxa57iqw6CKAhoIqiZ
	 tlKCo9a9P8DFwmTq1a2vkQq7+cVZNxbMS1th3LDXjtzytWHLT59EQFXCtntsppsC6eBDm
	 Fbk9zIKkAyP4M79uoB3jqeQKv8UTYAKkFNu1IB45oZC8v2M5Op0YoVikT1Usk1JpMT6Xj
	 Ecl9HTUWNuMks07ef4zfZo7RjRYpdc+z3ZzEF06gDJsJVbXIRN9/Qo7Z+wQizQ5XYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Tm6ky20NbdautqXgQTTifVFKqXqQLbVpH001XsB6AY=;
	b=TWSAePHHO/18/4IrV8Qv23ApnwcWZr2Qv1y0hLroPh1IcbFaX2jTXarSMdbuSD6nUXRm
	 yJcZGZpmWFQhDrfA1HIueGiQwwTQo60bg7jVwtJkVNjeOTUUiaFPa5zItrN2SH3GFm1NQ
	 T0S5fCiBJUypnXeI4TL8diz82vxByq/scNUdHuy8zGb6LdCmamqcz4EuRVlhbW+ptpjQ5
	 cxEVneto35meyxEgd9zxnDuQ6DCTmOOGH/fS0Efbwj8OfGY26Z8bXYn6SeVYk/XQ7PPTu
	 DU2eIJABGZ64pyXCDmaGWeeRwJViuid8MQnLOzvCE7MoYyd80RPMPG3dwTiAaYyr8yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+11AyZu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462B1606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+11AyZu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2821F000C4;
	Fri, 13 Nov 2026 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598482;
	bh=3Tm6ky20NbdautqXgQTTifVFKqXqQLbVpH001XsB6AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+11AyZuxr4IGQv+skL5rIFdyw59xuotwocrHEMrAWgI63EpSg4gA1bkWljrs+f1K
	 iCFPNWX6cd03vc862Y2y7qCmI6dimLgUSfcLt2fVzcCDdCUzQ/ToO0D5KuN9O7O1jC
	 8vUig8jIk5lia7AOx07BWTn/5a7+9ogtJYrykzwzhEm36OzEI42jgCiqHzmF1QVbIu
	 gAyyz4pNzuchm/XIRjJetrcXcVLCTlJgrheXrDGgItxLqbWYiVQl0DBmOv/7P3lutf
	 /pjTBq7DXlesZrN9cR84R1dH9fDByfQei+EAM9yUVdoxNQ7EeZ1vAaxvuLX+/LPotB
	 Vm0bfWH7nlgJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm: call wp_page_copy() under the VMA lock
Date: Fri, 13 Nov 2026 14:34:40 -0500
Message-ID: <20261113192843.2425959-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201352-failed-6.6-8db6921cc07b@kernel.org>
References: <20261109201352-failed-6.6-8db6921cc07b@kernel.org>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 164b06f238b986317131e6b61b2f22aabcbc2cc0 ]

It is usually safe to call wp_page_copy() under the VMA lock.  The only
unsafe situation is when no anon_vma has been allocated for this VMA, and
we have to look at adjacent VMAs to determine if their anon_vma can be
shared.  Since this happens only for the first COW of a page in this VMA,
the majority of calls to wp_page_copy() do not need to fall back to the
mmap_sem.

Add vmf_anon_prepare() as an alternative to anon_vma_prepare() which will
return RETRY if we currently hold the VMA lock and need to allocate an
anon_vma.  This lets us drop the check in do_wp_page().

Link: https://lkml.kernel.org/r/20231006195318.4087158-3-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 8db6921cc07b ("mm/memory: reject remote COW faults on PFN mappings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 853400f26159b..2ad125baa9504 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3050,6 +3050,21 @@ static inline void wp_page_reuse(struct vm_fault *vmf)
 	count_vm_event(PGREUSE);
 }
 
+static vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+
+	if (likely(vma->anon_vma))
+		return 0;
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+	if (__anon_vma_prepare(vma))
+		return VM_FAULT_OOM;
+	return 0;
+}
+
 /*
  * Handle the case of a page which we actually need to copy to a new page,
  * either due to COW or unsharing.
@@ -3077,27 +3092,29 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
-	int ret;
+	vm_fault_t ret;
 
 	delayacct_wpcopy_start();
 
 	if (vmf->page)
 		old_folio = page_folio(vmf->page);
-	if (unlikely(anon_vma_prepare(vma)))
-		goto oom;
+	ret = vmf_anon_prepare(vmf);
+	if (unlikely(ret))
+		goto out;
 
 	if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
 		new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
 		if (!new_folio)
 			goto oom;
 	} else {
+		int err;
 		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
 				vmf->address, false);
 		if (!new_folio)
 			goto oom;
 
-		ret = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
-		if (ret) {
+		err = __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
+		if (err) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
@@ -3110,7 +3127,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 				folio_put(old_folio);
 
 			delayacct_wpcopy_end();
-			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
+			return err == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
 		}
 		kmsan_copy_page_meta(&new_folio->page, vmf->page);
 	}
@@ -3220,11 +3237,13 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 oom_free_new:
 	folio_put(new_folio);
 oom:
+	ret = VM_FAULT_OOM;
+out:
 	if (old_folio)
 		folio_put(old_folio);
 
 	delayacct_wpcopy_end();
-	return VM_FAULT_OOM;
+	return ret;
 }
 
 /**
@@ -3449,12 +3468,6 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 		return 0;
 	}
 copy:
-	if ((vmf->flags & FAULT_FLAG_VMA_LOCK) && !vma->anon_vma) {
-		pte_unmap_unlock(vmf->pte, vmf->ptl);
-		vma_end_read(vmf->vma);
-		return VM_FAULT_RETRY;
-	}
-
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-- 
2.53.0

