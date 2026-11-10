Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272874;
	b=G1pdWJVE2YlYlcvw+LUW+QGvshUCU4TWt63MKPmperHbVGvYxY7Tf9mRTkQKg5eCU4GQ
	 nNMd5yWge8l9J9A6Vc1CJj5lPSZqVpIKsyPmc+kd3mMBCdN6KnUfyj5E+Brf/c5ZGHuIy
	 8vEbOkFXN7pFSUmeIkJf3BRCw6/mAvmNUV7EZ+GOo+/LHy9tQnchOyVVKG/BedKVScMHN
	 Te5NJK+GzNTYyXH8bw4WkOdjrXiiCoeFAevLVSP0BpabAbgNs966Mdyu2BSvXnD8Wvm3/
	 rWKJspzLstz8tcdzqtHGLVBYCHIMeGOgb/AGQcTD/P2FadXnZictZsz8BFG413CRLgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S3ILD50kmp4I3ff0Ob9KJ8xAczNjL7fM6BXSzY9W8b0=;
	b=npmzyRHZ7RXACWeaKLtE3X31PSj3a8v9IIhTc7PpfER6qfsigJMzB5ZUL7jJ0ZSgQgCI
	 U07ZUdnVUdrPA8TyWbsLbBmLw/hIlLc+Ea36K37a8uYsjyh/NZR+0zIT66fUQOoD2NKE/
	 7pFAGybDKMh00aDGDJeAglDL++co9quXCendbjyS5NnnS5Hy7ST4+gH7/Q5d2+v/ebiLc
	 0GkHgN+skXFTEth+Pgmpay3d8qj9sJReCTg7ou7KwwJW/RWS9LiGSxXKBlPQjgrtJ7Yg7
	 l0H05DbLGmOzR5v5j5XL/GlKyo8ysw/JsttW/+kkaXt6+JD9dxHWPx27uh1j09zcyUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVi6BKxn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVi6BKxn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36FD1F0089F;
	Tue, 10 Nov 2026 01:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272873;
	bh=S3ILD50kmp4I3ff0Ob9KJ8xAczNjL7fM6BXSzY9W8b0=;
	h=From:To:Cc:Subject:Date;
	b=BVi6BKxnl6D0caGsoSImK+a+Udgn7/wYyYG4L7JsKW+XzR8bv8NJJuC2PzGMxY2rc
	 HK+TVEBYGN6k7/nQgh5ZQOp46/hPVUgTbN/NmHG+Bk38jBFCsIZ67o4Ijem1EjCUHn
	 Rk4+bnSKt5iLaSs1jMHDwot0SWm0M77v/0v1df2v0geDyX/yYO1bs8wRTPW3l9P6ne
	 4XF3iV34eAe8mNQHxS0Q2Q1djPRuLm0ejf1puqlevxEgQEOvobj4UuyJ9hZEWu2ydz
	 sWj2LwcqkLc4M9IvAgonmx99gnkErpLpYIzyk5crKhJge5pUI5q7+NHtNruzIEWtDu
	 cwEb2XXikTi+A==
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
Subject: FAILED: patch "[PATCH] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:07:51 -0500
Message-ID: <20261109200751-failed-6.12-8146c6478224@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8146c6478224d8f6395c6b08a19c344a56d79867
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200751-failed-6.12-8146c6478224@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




