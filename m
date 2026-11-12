Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453995;
	b=papVpmkXzZEzYG8LWDIJHg0iwfDju2UM3LvK7s83YaPyJEPR4SYykCWYVw+4ltVdcKwv
	 9ldG+uKTMqJfv878T4w8xyMjJAWRJEtvG9f40jtfkfXC0b16fdAllXMOBJMiz/vPKnNZ+
	 WZvL/GA1meMXwJrfvc9qBkqALIp2zxjorn6yY1neqlxiriUmf1otzyxFCJjMoyhtO0E7I
	 oP701yPCa4bXkkCATL/wU+BKO+V+szgB2+Pa1pzB65WSiTKLBX8qfJiig19Yi8IoIwfHK
	 MtyCM7Sxl7BUG0JTCwsFRniKR/q4XRWHv2mFIAjfTp45Zw+ZaDjOeWp0w1xnRwm7lYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kZLfCEkYNR3aTFkGE62Dpsbp4vXo3cgt1ovFL5UjwOw=;
	b=GTyh94gw4ndP6ETXKB1vqu8lxprmRSdLlp1GN7JX/z9IINxJBoXj7bNPPr2IALCTt/9M
	 F8RdCueMevC4hDgmkWrNsOTv/CZ1pLXuwMTD8WtZyrN+wR9fehUJ0TWL/jPq47qiSlWAS
	 /Gl7lVJvZZwAZf4n9wVNrnYxuR7U7W91j3I4JjxazKYNlT3QtmKO6LuFBj6wMWbeDpJ5T
	 pA31JvmDOCF+PrAiwD3A6jzXSm2FF99df8DMOaF6OkACaK8UE2DbNv4xhs+5JsDAV03QQ
	 Mxdpa89KQsM6dJqyhZvmCj+sp/82quZ973/wnO/COK8KEtS6UWxv1iQY9KMmsp4Seww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m4D/jMl7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95388606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4D/jMl7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7882F1F00A05;
	Thu, 12 Nov 2026 03:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453995;
	bh=kZLfCEkYNR3aTFkGE62Dpsbp4vXo3cgt1ovFL5UjwOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4D/jMl78kXT33pL9Qzx1gnsFezNG4znPSaas/3S4iClivV/CEjJFCYxBu8+mzLvb
	 ge2XiIizVCgt/0GzANYwbjkfxuz5Rs+YRsMqIlx4CbD6d706F6a8l/ZUpjfU3rs5OC
	 pNzoprkfDzVKlSXBLIZLOwk6qRqZtu7xfogPf34frpUVpNb/0yoLrdr3j27B9R1GpZ
	 0i6LGx2r/Z3u9g7mO3HhKmFx9E1MLlm/mYxXHV5rUgVuNWSbudKzFDP76KauTzwx9z
	 CoYgF8EBP0i6DmMG6u0JJJ9gk2xZrUDO4fhEkgof3q8bVDm7mcCnIk+yOr38iLVsvn
	 qpi/am+CHjikA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luiz Capitulino <luizcap@redhat.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R. Howlett" <liam@infradead.org>,
	Jann Horn <jannh@google.com>,
	=?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Date: Wed, 11 Nov 2026 22:26:33 -0500
Message-ID: <20261112032559.1526093-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200401-failed-6.18-8146c6478224@kernel.org>
References: <20261109200401-failed-6.18-8146c6478224@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 8146c6478224d8f6395c6b08a19c344a56d79867 ]

Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
merging with expansion of mremap()'d VMAs, however it also unintentionally
disallowed the expansion of unmergeable VMAs.

Previously it was possible to expand a mixed mapping which mremap() had
already ensured was a legal expansion.

This is clearly seen in the mremap() logic, as it checks
vma_is_fixed_mapping() to determine legality of an expansion rather than
vma_can_merge().

Additionally, copy_vma() allows for a failed merge to result in a new VMA
being instantiated if MREMAP_MAYMOVE is specified.

However, this is not attempted, as a failure in vma_merge_extend() is
assumed to be an -ENOMEM failure.

Since vma_merge_extend() is used exclusively by mremap() to perform a merge
and/or expansion, resolve the issue by invoking vma_expand() for
unmergeable VMAs there.

Explicitly assert that the VMA is both non-fixed and a mixed mapping.
This provides double insurance against broken changes in future.

Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
redundant in this case, as a mixed mapping is not subject to khugepaged.

Also update the VMA userland tests to add a required predicate.

Link: https://lore.kernel.org/20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org
Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Luiz Capitulino <luizcap@redhat.com>
Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jakub Matěna <matenajakub@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: replaced newer VMA helpers with equivalent vm_flags checks using the existing is_vm_hugetlb_page() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8669da66edc5c..6f9e3d0c2681c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1770,12 +1770,28 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta)
 {
-	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
+	const bool can_merge = !(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND |
+						  VM_MIXEDMAP)) &&
+			      !is_vm_hugetlb_page(vma);
+	const unsigned long start =
+		can_merge ? vma->vm_end : vma->vm_start;
+	VMG_VMA_STATE(vmg, vmi, vma, vma, start, vma->vm_end + delta);
 
-	vmg.next = vma_iter_next_rewind(vmi, NULL);
 	vmg.middle = NULL; /* We use the VMA to populate VMG fields only. */
 
-	return vma_merge_new_range(&vmg);
+	if (can_merge) {
+		vmg.next = vma_iter_next_rewind(vmi, NULL);
+		return vma_merge_new_range(&vmg);
+	}
+
+	/* Mixed mappings are permitted to be expanded, not merged. */
+	VM_WARN_ON_ONCE(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND));
+	VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
+	vma_prev(vmi); /* Reposition to start of VMA. */
+	vmg.target = vma;
+	if (vma_expand(&vmg))
+		return NULL;
+	return vma;
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
-- 
2.53.0

