Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272498;
	b=xQqKrbVUgXxz8dECVEPEiT16tN/zS92XP6fEJVbS9QVmZM5blNrUVjY4crfIiEnUlzS8
	 uBN50w+x6JSXw8/AbynffMKtUpIWZuM6zRIwTCYxpAmNkXC0+Brc7qZ7ln5Dsh7dvWcLb
	 Q+wN4YAGHu4F2uk9RsrUcXXU/6y+FBNVGUTUIMRfBPpADPJ9qT8SsN9768CoLUr/EyWl9
	 kC3XV1UMs57TrHEh3SQP4ICCQDmETqCBw8VRACWZ9eUO8InZLW2Pr7hyqnOjoFAX++OMj
	 dgYmppBvCcZFnSZaaa9tcoR+0shArnPGl4L306rguRxei8sAuZLQwQyEzAdIZH7eyxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272498;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eGuzzNkUk687hUx2u7NeTLqvu5vpdvrfIY5jv5nN3O8=;
	b=EXKCc+46A6jVHl6tV1/R1zaf3LVs774hiFl4g/3sFcwzCKKoYzNEm3Agfq/GOcG5B+Ez
	 2M4739nTDgF9dxszeO1JB3V2aGNprLXIJQR2E30P04ts6pY2CpwTujJbi6o4BMe12sjIE
	 zmU32KBjRzkGALo7yddpAd6y72ftQPTMSNWWVz3Af876jgSr5CIQZLBH9C+BDjq6OMw3V
	 3y/8clY4fH4Iy0znJEcJqcFxxVD+LFTVgCV1XKOML2hCmO4Ma0o0/EyynqQgXdBhZoJh2
	 WyqVpQwf/uhraRzqqvo9xc63kQmmPGoDzHgtYpjskwRWYIik5NhFP6Q/cJc7tSs5qBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO3nqRwa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50360606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gO3nqRwa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348281F008A5;
	Tue, 10 Nov 2026 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272498;
	bh=eGuzzNkUk687hUx2u7NeTLqvu5vpdvrfIY5jv5nN3O8=;
	h=From:To:Cc:Subject:Date;
	b=gO3nqRwa+f1WrjoXc9JbwrS/IZ+zJjqed81u3bc7dPRLPkUGQ8dGGFh5tEG89X4Bo
	 vZnDFbT5HWBlxPWRe4H9bK4YWCkuadjrGIpXCbco9xwdTG7L36DbJRLp0kJ+jYepNY
	 8u2W23fZdTdk5oTnS1boW3Cu5UOewLke08bm5T7gsGmUGlVncYBCkQLgn6CtGgJ9A2
	 b5b7mEwcXiiONZuDf+wNQHpl+ZKVkg0CesUd2RljZZgKZz8K672x0STU+thIGx/y4o
	 ycuXcPVgOMrDlQt7JBSampP8RFsqjw2aJ8uoSWaRYuSU4UBVFkG5nHjlUu7f9U9+zc
	 oDa57w+GmiT5g==
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
Subject: FAILED: patch "[PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:36 -0500
Message-ID: <20261109200136-failed-7.3-8146c6478224@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 8146c6478224d8f6395c6b08a19c344a56d79867
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200136-failed-7.3-8146c6478224@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




