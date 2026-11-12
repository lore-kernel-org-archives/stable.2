Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454657;
	b=AKFG4DIcNm9g3LUjgrzMaX5Rle2s634Otq8qJG55iC3k+Ruk4niZ7upNn4xbGUCCaETc
	 +oaCUAxboI9R9WUpM1Iledy1jqqLPtonodpAWA3dyPGyK/bt4+DyiNRvHbT/YYFCQDvB7
	 mO5CGMuzmDuk1qlpK/hUwcnKrixpEr4OxIKgXvmRHyg81Hy4GR/etqBu/iTLpgcfcb5Ro
	 y5IH1XBHktEEacVZD38LVhiOgfR/umWR8JrvBDd3QJB5jlQOuXiTgdjKlx6OHIplA3Vyu
	 VFWZsWwyCd1zHycGCG3v1IxeMyNRpUxjrM5EYoe054s40w8tycb45ssB2/u9+L40E1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wKAaGKGtSVWVQjj+t1TXtl6Y1QkWZpTnFFgkETn64/M=;
	b=MAmJW/sqvZe01CJ+ntn8Ubv9AEXhU1smFwVaTIAFkLIfHoScqHx8epH38DCx3riI+tw4
	 aeUHlsJxvwusXFHBzDGmkS0pCS11hmZMxlJMFL0nL9F1uT5QWttB/7uai2MhQnx0WYkPP
	 83Porlr8lnSkEBZJwc4Gun+4FkpwqENu5UQJtni7iEtnA4dI/cfbOXH8C/go+GOSLWZmQ
	 dsu42B5dDqmNa54LfAVpng8sqE6QPc3oezER8ZU5JdLAAGNpVMfUlNL0kFVjV1uAHHyHJ
	 sdSO2c0bzvQWB86MGgl4zRXdjQp/ghQ1RT2JvuBVOESWt2u6CxZdQ/hOm/nzCGi6AeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/bMvnPw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D412606A338
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/bMvnPw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A4D1F00A05;
	Thu, 12 Nov 2026 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454657;
	bh=wKAaGKGtSVWVQjj+t1TXtl6Y1QkWZpTnFFgkETn64/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/bMvnPwq1w20naiSdCBIT5o8fPi9YYVI2d9pljZ28q2mjFit+t21NHLYRKmZaJaz
	 1bJTPL2ZEbHHw3SzgOCi8ZnWzhTFx9pFcAa383HXQ8/oFxMbIFxYujtyaMtyjOR5m0
	 BGtJSNX+m2IzXVx7ISUaBB9TyI9OcB1q3f8zpXXz8ylNCeAH4Rj/p2XLRr/ocm4VSu
	 KniCTrlgeEokDHgiinCyfIvr1WotjYjdT/ztsR46sXiVt9QAicRl6HL/O5ElzFBCiP
	 WsnC81oWQ37fHVXyyNI0XI9e/qYxs6Lkm5dYfFbrJJhuCD1WSLkAxAfhLH7kYZYV7o
	 EPvjKP+4oAX9A==
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
Subject: [PATCH 6.12.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Date: Wed, 11 Nov 2026 22:37:34 -0500
Message-ID: <20261112033709.1560178-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200751-failed-6.12-8146c6478224@kernel.org>
References: <20261109200751-failed-6.12-8146c6478224@kernel.org>
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
[ sashal: Adapted VMA handling to use direct vm_flags checks and the existing vmg.vma merge-state field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 66b0472b7d8a6..41cdf4199e715 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1544,12 +1544,28 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
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
 	vmg.vma = NULL; /* We use the VMA to populate VMG fields only. */
 
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
+	vmg.vma = vma;
+	if (vma_expand(&vmg))
+		return NULL;
+	return vma;
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
-- 
2.53.0

