Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455279;
	b=eQaCaR++Igf4U5YOwfk3GQWOi9YVIJgjisD1mTqecOOkiAlbxeCHxppf7tn2MAIUUAJT
	 Yx17QPGoxWT2t6brVkRKmp6lIfytSwBAOm7E5okLban2w09gyoVm3eZX5fpAsz7Jm+fnF
	 5g6YE7Q3F8Xb6hfRFkrObzflS+vn9xstZZ9uI5NCFTeO1POxhHKd5Dj5XHMYHcQyCk6lQ
	 S4PvnEZ0oBD4GOHhT3chIFWzSjUDczc3rW0urekWFC6TuQ4x2CEdkAkHCJYQDKV8m4xQ8
	 Lp+tXXhyKipHuVlz0NGTL85Y7gJYLTtuws+LWWViS2vTxYjimg6vqlIk1c4y1301kkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ShFOLd8JJMDMfRs8kbJ2xRTG7jrnMeWavY86zBMAdAM=;
	b=BS2eYQgbO+EtdPj+4dyTKckoRyHRaG5u5U4C6cDYAlpynIZknWznCLEGeTX5aL0T9nQc
	 sVQpcU6kpue+iWXUqFKFua9fZYUh93EDVUkyaUcvSlUwNexbZYEZATQqnypM4urN87DIb
	 gUSjbqz/vZmM4/kQv/F8EeAnyapN6eX66ha6HPb3umtNDCQsmTxPGetfN5WWVgsopvILG
	 jI6N9svGFtCjqN5WOp/EnBh9jeMd3tEhDGpiSinap7iKGCMSLMpG1HV5Bay1vBLch7AQr
	 xqqRK3n5WJI1svpGxspNMbY2eIYrCZE2eHDPtX9iGxxvUK6ckBPB/RW8znFqvK+bWvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv7FGhcN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87D606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv7FGhcN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A961F00A06;
	Thu, 12 Nov 2026 03:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455279;
	bh=ShFOLd8JJMDMfRs8kbJ2xRTG7jrnMeWavY86zBMAdAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wv7FGhcNmyREQ/mIOM4iNV6zoeGRsQ6JXamESMQ/uS/CLhBzfMJJ6wZGQj17D938W
	 UdnjRSvrUEm9qx3AXMHaGs4EpOLPsJxXCELzDOo6EW5ZqAnKVmfcI90r6ic6QvtSHJ
	 RBuvTFYCH++fbHJ8C0cvdMCpA0+qi0Jq0iUYY9bGWLx2PE0pS5PCB/NGDSBWRrYU2L
	 8/MTV1cJ7OkvkfP+P6tM9Glac/+1rb9yuRihcmMBAH0ckP9Ly6qG9t8Dal4Opfd9CM
	 shprfn5FBOE31offGtHnpV/H9qe2vnAV6h3Y6p65iaEdnM5bGyWnrPtGDtEaP1keCI
	 bf5CRgPUOhFyA==
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
Subject: [PATCH 6.6.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
Date: Wed, 11 Nov 2026 22:47:57 -0500
Message-ID: <20261112034659.1574521-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201217-failed-6.6-8146c6478224@kernel.org>
References: <20261109201217-failed-6.6-8146c6478224@kernel.org>
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
[ sashal: Adapted vma_merge_extend() changes to the inline mremap() implementation using the older vma_expand() interface. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0739a31b54eed..a37bcfda29261 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1120,10 +1120,21 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			 * the next vma if it becomes adjacent to the expanded
 			 * vma and  otherwise compatible.
 			 */
-			vma = vma_merge(&vmi, mm, vma, extension_start,
-				extension_end, vma->vm_flags, vma->anon_vma,
-				vma->vm_file, extension_pgoff, vma_policy(vma),
-				vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			if (!(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND |
+					      VM_MIXEDMAP))) {
+				vma = vma_merge(&vmi, mm, vma, extension_start,
+					extension_end, vma->vm_flags, vma->anon_vma,
+					vma->vm_file, extension_pgoff, vma_policy(vma),
+					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			} else {
+				/* Mixed mappings are permitted to be expanded, not merged. */
+				VM_WARN_ON_ONCE(vma->vm_flags & (VM_PFNMAP | VM_DONTEXPAND));
+				VM_WARN_ON_ONCE(!(vma->vm_flags & VM_MIXEDMAP));
+				vma_prev(&vmi); /* Reposition to start of VMA. */
+				if (vma_expand(&vmi, vma, vma->vm_start,
+					       extension_end, vma->vm_pgoff, NULL))
+					vma = NULL;
+			}
 			if (!vma) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
-- 
2.53.0

