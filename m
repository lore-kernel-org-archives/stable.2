Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370167;
	b=iTsB+tnygDwZz9uI6rXmIAba4OKcK/KrZ6Wufyxf4uWau+nLEBUIMz91zIf+fVxXdAbm
	 gBLeQvPhgCs5X8p4Ttnn50nvAhYoOjpLugiIjifcMg5OERCRE25R7ha3spXYY+aK86nGV
	 DhtaNFogv7s/ie4s84Yj3FZsDmbqD4AQ69a9T6p0nkVBh5496jV/xDCvtHwZjjVa1asol
	 e9/MIvYgTh2hRRUXiy+twDYBXfTKW/UlZutkACbNB2fYU+seqdxOXOPvEnOFeVPob7DKw
	 lyAetyi6gODJ8+7Tej8YeLhyQMk6vIszN0DcT8ubSMhGEY/eXos2qEATC85rJcflbAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370167;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PSEMw9cBbCQhxqDi6XpTccEZBErSQpfZFqy7s79g/s8=;
	b=AGsHbGru6IS24veNy/bY94DN5jw6buSYUaeyX4LHLFRbb4UDTipSASSyg8sd9d8iw1Ss
	 OHMaFU9yDk5mmGyyLjjV3lQbahsiF6HZqLS6+Wq1A+fX7p1QJzGX70fGzf363YZk5lNq5
	 uDDeoaH8YcAfFXeB/OaqSvhoC+FjZvZ91aUrQ1MA43ZW8fidp/TTjYVLoOlJYsHOQh/Lu
	 JJh9y7I6bgKrV2t47E0TpPnHhHi9bvbohk05pKnpwNiLRBk6Ctotz2tXBzzyJl0Ps8e0J
	 el+X2er1hDaod/6FI/CztsKCHSr2iyUSE8jnYVMesCAPprNdhcpV8sONmwTNFPlT0Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSWZtAuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97047606A32A;
	Sun, 22 Nov 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSWZtAuX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5815B1F000D0;
	Sun, 22 Nov 2026 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370167;
	bh=PSEMw9cBbCQhxqDi6XpTccEZBErSQpfZFqy7s79g/s8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bSWZtAuXbodhiYKS2QPIX1GrJfI7jYB/qr+DWwbUs1E1rZZPYKKx2bLikqtCy0nSO
	 Gn//FmQaw0wS4tTguOSLzNq2bX0WX+mxY9jkuur8avzPxs1OTR/0mQtr20nPaXCf6E
	 bZ0jtjhy3yrIUdUaWOkND45Q4sbkHD+vEbFewxalXT6mTJOLMpZPixe+57d6y5174b
	 uJN6ICTkoIeGKFnDzvEfBhL6UUc8vmjPNibMcf+KbVpuaTWJ4nuKERVjF+CWLlgagn
	 K4Z3R0NUFpYdClxtlWMnv6M8prxTtqpBn3w9aYlnD7m5PsLu4EG3CrbyiUMM+uQlnE
	 KWDfYzaY/Vbeg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:21 +0100
Subject: [PATCH v2 4/4] mm: check permissions and bounds for vm_ops->access
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261122-access_shite-v2-4-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Chris Mason <mason@kernel.org>, Felix Kuehling <felix.kuehling@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4049; i=david@kernel.org;
 h=from:subject:message-id; bh=SDPlENgFxyN5yl7ubJ5nBWCfOxtZ7of4RTnCk2l/ZQI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTo55VPOfmTm5z/5fLKWxZ/CxsQFjBHPGmYJ+gRaM
 bGenrKyo5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIn0CzD84esXTI6vC3iXlrmJ
 u86ZlZVnVvTS5U2hwk4Bd1gkEv/cYWS4cMHoRm7Ed29mXi89zU1qL97WG2+ayKIx7fQUXoej3Im
 cAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
falls back to vm_ops->access without checking VMA permissions and without
limiting the request to the VMA size.

Consequently, /proc/<pid>/mem can bypass protections even without
FOLL_FORCE, or cross into another mapping without checking its
permissions.

Check VMA permissions before calling ->access and limit each request to
the current VMA. Implement access permission checks similar to GUP,
however:

 (1) Reject writes to CoW mappings because the callbacks access backing
     memory directly and cannot handle CoW.
 (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.
 (3) Allow reads of write-only mappings, as we historically did. Most
     architectures cannot express write-only mappings in page tables
     anyway, and i915 selftests rely on it.

This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
exploiting the missing access-permission checks fixed here. Reads remain
supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
in May 2023, already does so.

Similarly, forced writes to MAP_SHARED mappings of files opened read-only
(e.g., read-only DMA-bufs) no longer succeed, as VM_MAYWRITE is not set.
Writing to read-only files through ptrace was never intended to work,
and would usually be a security bug.

If this turns out to break real users that cannot easily satisfy their
debugging needs differently, we can figure out how to handle that.

Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
Cc: stable@vger.kernel.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5d0d58aeff3cb..d43837623a063 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7412,6 +7412,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags)
 {
+	const bool force = gup_flags & FOLL_FORCE;
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
@@ -7451,15 +7452,36 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			if (gup_flags & FOLL_ANON)
 				break;
 
+			/*
+			 * In contrast to GUP, we historically allowed
+			 * FOLL_FORCE write access to non-CoW mappings and
+			 * read access to write-only mappings. However, we
+			 * must always reject writes to CoW mappings as we
+			 * cannot CoW here.
+			 */
+			if (write) {
+				if (!vma_test(vma, VMA_MAYWRITE_BIT))
+					break;
+				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
+					break;
+				if (vma_is_cow_mapping(vma))
+					break;
+			} else if (!vma_test_any(vma, VMA_READ_BIT, VMA_WRITE_BIT)) {
+				if (!force || !vma_test(vma, VMA_MAYREAD_BIT))
+					break;
+			}
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
 			bytes = 0;
 #ifdef CONFIG_HAVE_IOREMAP_PROT
-			if (vma->vm_ops && vma->vm_ops->access)
+			if (vma->vm_ops && vma->vm_ops->access) {
+				bytes = min_t(unsigned long, len, vma->vm_end - addr);
 				bytes = vma->vm_ops->access(vma, addr, buf,
-							    len, write);
+							    bytes, write);
+			}
 #endif
 			if (bytes <= 0)
 				break;

-- 
2.56.1

