Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453052;
	b=5PfdDlwBb/lSqNTFxvxnmGrUtGyp+VsbguGknBye0tE4wRYaasysSdsFaMhchc0YlyKs
	 5VyJUxL5MKyAucr/3YYwF6UGJMPwwKN0yp5ntiyjuQotMeqPM5JnrgtMIz0DpQDqVDlRH
	 FrMHNpJvnYMjr/7IRKMsqVCOakKorPPAUw3S1+sIByyTsjV30fUhiwU1onyMNHz6LQyzB
	 nK60xOmEzmu7mxHeSrk51e7R8TRDLn9VLtjDG+e7qtG0zYsqWVxF2mZb47/mhPEfxyox0
	 ekWd33iwrxEG07rbCjZ2Y/CfYbSpyuzdeCLvCUgPJ32kSs40u3F+Wsh+S0IYiw03Umw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1DGXPqp93v2h9lT5FNskLP4hfklZzdq6kW5dPmG0JmU=;
	b=MIO2nSlFsQ3D41b+JuFcOjdyBsEO3Xqn3QqF9Bi4NQumURuwvaqZNEjmtukwgJH7e5FB
	 HlH4pxhPdAu7Abp7zcbqRMd/MT792OP+YHSRaPKs4BuQe1dDTXbKzxCfWFceyylWw+LPk
	 o1rANJAR5pgfN/kXvq7URbarjb4TssKDugEFTwIAk/1s1A3aIXek/ilRarLroV0zNIs1Y
	 5rSQMyFDYWxt77T+X3hMKvbrXN4FwMiBtFAjVqRjCQwedQsPyirDz2oIWDirfMg3dgy6c
	 flxiDPvI9Z55AYODQNfYES4QbytT9+bWDV6GwSUnpgVGrn2o0ChNw5pjAAd79l9nQqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NO/P97ag";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57412606A32A
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NO/P97ag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285791F00A06;
	Thu, 12 Nov 2026 03:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453052;
	bh=1DGXPqp93v2h9lT5FNskLP4hfklZzdq6kW5dPmG0JmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NO/P97agXsK485g8du8KjrMeQW7xoq/atm1gtUXxX6aIfnbEXol2K0Spa4Fqo+AmZ
	 aU3JriHIQpotwzcRnzmZdq4rtrdcK7EAT8L6hcaFeTcn3L+ZHZjM6w+04fnL8Qc4+a
	 Sya27MdvYJ0+McCBt7IaowcXIb3FG+0KQ/3ZKwYXLtqI2FrNkZPUE3l/ijf+xOLWhS
	 P7R2ipzD1RgkZRvuMNOpSEZmpNcNxGklKG3hr3oDS6lWI6k4V48EVQDxMiX4BW3zNp
	 JuKz7+WB4L8la50BSh8dEebi7i2gZHa4l6fmS+z8peRQktrxl6DHEOtOR3J4fgy7cs
	 PBx5ZmqmU1O9Q==
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
Subject: [PATCH 7.3.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Date: Wed, 11 Nov 2026 22:10:50 -0500
Message-ID: <20261112031021.1419377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200136-failed-7.3-8146c6478224@kernel.org>
References: <20261109200136-failed-7.3-8146c6478224@kernel.org>
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
[ sashal: Replaced vma_can_merge() and vma_is_fixed_mapping() with equivalent flag checks and is_vm_hugetlb_page(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index e382fd32f0fff..9863668b9d6bc 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1882,12 +1882,28 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta)
 {
-	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
+	const bool can_merge = !vma_test_any(vma, VMA_PFNMAP_BIT,
+					   VMA_DONTEXPAND_BIT, VMA_MIXEDMAP_BIT) &&
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
+	VM_WARN_ON_ONCE(vma_test_any(vma, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT));
+	VM_WARN_ON_ONCE(!vma_test(vma, VMA_MIXEDMAP_BIT));
+	vma_prev(vmi); /* Reposition to start of VMA. */
+	vmg.target = vma;
+	if (vma_expand(&vmg))
+		return NULL;
+	return vma;
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
-- 
2.53.0

