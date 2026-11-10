Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273139;
	b=jJDbP6qtOLLVmSuG3C3ZiZEMW3gqINs5CFz7yvlX71ciLv5VFKU16DSoZqtTb3zWN+OB
	 BX4MF4VnDnfAr4NQtEX/8EehPX8NHI7lJ9AMdBPrHb+jv5HShajHTsItJQhP1f+GRWZtz
	 bHrk1Dao4d/w1mdNuvMwddtInzo/zLxM829RRX+3jCngjS7CKmQt6/SURO2olt0rysuNJ
	 7ow3cKafWV3srWx8V/0LoAGmZ90nSrcEtYwNnVgdYEs9gh5mAIVXx1IUptKwJekJ6i+qF
	 6jAo5gnTjy3v6Jdk6Pess/Y1NuooDKDDLTuIlJm1p3Nz3FabykfkyoN43QClxZIwqTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=diFD2f3W0KhfQSQ5tk3M9+3xGXwhE2FxBznUUmBNWBs=;
	b=3jBba1FvD1tV6suTWhz3mlO+cCCducBkcLZsuAC6CBo4R+0kfORUm57Guh0rzleB1GRJ
	 P/jAdvbv21Bkfu51SOG5wXlVO6UTMB0qYYoavW5lHCLYjQNABKJ/pMBCefzJ3QeQ57Al1
	 u/JtFk4YM2BmgpEnytQAJX7Mmyli2dCn7qr3iBYIeIaNf9kmcSSXMRVg7uIN0CrJJNQPS
	 zmYoEFTrf7krVRTx9SJIk9/Pabl0N/ug9msCVoxEEOt7GBVZ/w0WT9r/hN8XGzhapeGzo
	 6gjdAqDVl7TGKB4msqiuZAGthOGfVi3JT7Ui7/FN1QYf6XAw68oN/utnJYjoz2Kb7Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDYv3Jlh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D174606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hDYv3Jlh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610411F0089F;
	Tue, 10 Nov 2026 01:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273139;
	bh=diFD2f3W0KhfQSQ5tk3M9+3xGXwhE2FxBznUUmBNWBs=;
	h=From:To:Cc:Subject:Date;
	b=hDYv3JlhMV7ugRdDdYoHfhdJkzaVlVzL1rsChIq59/AuE1imI1dBlhx7++Jtt0CqC
	 u73d0QcdnLgjCwCuuYKrb5lGDRWE1HMYZBc0yH9COm+qX+H70nsTRMFZg5OtRglO+K
	 8Yuw7XWnHlemh0bWrsm5mFoZP1GhwTU5xBpL5brKtae3+7+FZU5uSju4SOFwqkBDfy
	 GwNK6GUt1QxjbehzoKogRVna2IlGydOE3wVrDvJGGceiS7U2q3iI5yVB2Ghf1yrojF
	 VwUqEDx1vLuyXuqrbKw4eXtwy9fyG1hF64ZYwGVWxPtodmkiQN+MqkYiT5tvgPg1Wm
	 pNK1+UrwhLhBw==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	akpm@linux-foundation.org,
	luizcap@redhat.com,
	vbabka@kernel.org,
	pfalcato@suse.de,
	liam@infradead.org,
	jannh@google.com,
	matenajakub@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:12:17 -0500
Message-ID: <20261109201217-failed-6.6-8146c6478224@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8146c6478224d8f6395c6b08a19c344a56d79867
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201217-failed-6.6-8146c6478224@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8146c6478224d8f6395c6b08a19c344a56d79867 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 23 Oct 2026 16:17:31 +0100
Subject: [PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 mm/vma.c                        | 19 ++++++++++++++++---
 tools/testing/vma/include/dup.h |  5 +++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1be613044b4a5..88ef92ab24ecf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1851,12 +1851,25 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta)
 {
-	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
+	const unsigned long start =
+		vma_can_merge(vma) ? vma->vm_end : vma->vm_start;
+	VMG_VMA_STATE(vmg, vmi, vma, vma, start, vma->vm_end + delta);
 
-	vmg.next = vma_iter_next_rewind(vmi, NULL);
 	vmg.middle = NULL; /* We use the VMA to populate VMG fields only. */
 
-	return vma_merge_new_range(&vmg);
+	if (vma_can_merge(vma)) {
+		vmg.next = vma_iter_next_rewind(vmi, NULL);
+		return vma_merge_new_range(&vmg);
+	}
+
+	/* Mixed mappings are permitted to be expanded, not merged. */
+	VM_WARN_ON_ONCE(vma_is_fixed_mapping(vma));
+	VM_WARN_ON_ONCE(!vma_test(vma, VMA_MIXEDMAP_BIT));
+	vma_prev(vmi); /* Reposition to start of VMA. */
+	vmg.target = vma;
+	if (vma_expand(&vmg))
+		return NULL;
+	return vma;
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index f449129ea97a9..e0eab4eca998e 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1727,3 +1727,8 @@ static inline bool vma_flags_can_merge(const vma_flags_t *flags)
 	 */
 	return !vma_flags_is_hugetlb(flags);
 }
+
+static inline bool vma_can_merge(const struct vm_area_struct *vma)
+{
+	return vma_flags_can_merge(&vma->flags);
+}
-- 
2.53.0




