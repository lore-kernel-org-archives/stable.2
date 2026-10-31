Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793450111;
	b=GReho+XMULXUrBSPi5ZjSov18J7YVCxeUZP9P6myFEL8rNCmfg0PL3BdG5hxsecBHjO1
	 K5ukMKj9SExlZvGV2jMdW7Tc6UBIqvACF0/lG9gTCAvF5u7IZEv8Gx4jGrH7fP+561Kvj
	 6UBow391EPEQ6qn0fM9TV7CrKcwlXQN8Lam1+I7o0fEAjZMeuNvvftBhO5+0gzuE7KtmA
	 849xrgYjvdJ/11kJYWPQKk8o5zMl3jwh5jOSs5Hu4+7COyy1+AQSJg41PSqeL4wt5CGlU
	 Kyc4V2K+Owba78XeQDcSokxQOEUsb9l+QF6RWl2Bu7jcCDXdfuqYsqYKNs/ij2hz9dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793450111;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=NGJd0b1x2Q+1ueL/OsZfD8yOd2huoS1n0KwD8HqgAlg=;
	b=LINn5WAhVX6L3Sk5KPhTFa6Pc/hPYn3wcGhxHCfGuMUyZ9isBBGfBh7s1t3q0RiW5m8y
	 poP9IODu3wq4waKD+8Aw6goL3Gt/MrjEO6zCgmRZmbDSf5VHYcG1qAGOdr5QlCxyD34U6
	 eVCxJWahXRHZ3bJdr2z6MqPwfmf3us7rZJQiJMqILvXQfRseRYNz06TzAWNLo2b9mDT+G
	 SFzqPKCU6WLllDpKHLJxSgnvgZE9Hjf3aaHocztHnaHQfN3cTTD+aZ5YK2TGIfvKL0MU1
	 +5gRkvDKTL801MF+zrf04Ej2sK+HMRj2TqIn3Gr+fsjxaHyN8vIxmxATcHQ/SEJ04kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfm6PN8L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF70606A31A;
	Sat, 31 Oct 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfm6PN8L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689D01F000C1;
	Sat, 31 Oct 2026 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793450110;
	bh=NGJd0b1x2Q+1ueL/OsZfD8yOd2huoS1n0KwD8HqgAlg=;
	h=From:Date:Subject:To:Cc;
	b=Zfm6PN8LblPUTpa6GSuOyMtI4rhBievlZLP8QmaQ2TBLtVx6AZDt0x78JwbUPawzn
	 YwsjaMNH/W+eJxs492Y5FR6uy8uquro2tsd80mZSO57H/XooUlyYF6sJPoJIwxiWih
	 CyBSNkjNtUE+BIYMqRebfP6YtCJI3CALiA0nxwItQFB1/s62xchPlQIv4P3BTG1oKB
	 IurDesNn8jhzIDPg/wf4CJILD04Ebb8xXbsqkWDUYLThn/O+3dQVIaeebLAZWy3MVz
	 XmbKRgkb+zJRZrTC7gI8KRv9W0Wrq7k5u/87+mxN5QEdnj13oT4lAMpgr4eOBkbyuj
	 DFgLtXHIYbE9Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 31 Oct 2026 14:35:05 +0200
Subject: [PATCH] userfaultfd: clear uffd state in child PTEs if uffd is
 released during fork
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
Message-Id: <20261031-uffd-prot-bits-fork-event-v1-1-3572921c2111@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw7CIBBFf6WZtRMLRmL8FeOCx2BRgYaBxqTpv
 1t0eW7uOSswlUAM12GFQkvgkNMO4jCAnXR6EAa3M8hRKjGeBDbvHc4lVzShMvpcXkgLpYqOLlI
 4dRbaKNj9uZAPn1/7dv8zN/MkW3uwP4xmQlN0slOfYsw1HmPElrhq8ybYti8YyPTDoQAAAA==
X-Change-ID: 20261031-uffd-prot-bits-fork-event-de821d651ab6
To: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.1-dev

With UFFD_FEATURE_EVENT_FORK the userfaultfd context is duplicated for the
child process, the child VMAs are registered with the new context, and uffd
protection state from the parent PTEs is copied into the child.

If the parent's userfaultfd is released before the fork event is read,
userfaultfd_release_new() resets the VMA flags but keeps uffd state in the
child PTEs.

This leaves the child's VMAs in an inconsistent state: they are not
registered with userfaultfd but their mappings carry uffd protection state.

If the child registers the range with userfaultfd again, the stale state
turns into protection the child never asked for.

When a write fault makes such a PTE writable without copying the page, the
uffd bit remains set and page_table_check_pte_flags() warns about it.

Split resolving of the uffd PTE state out of userfaultfd_clear_vma() and
call it from userfaultfd_release_new() before resetting the VMA.

Fixes: f369b07c8614 ("mm/uffd: reset write protection when unregister with wp-mode")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b71712edab4c..2c11ac5dad3d5 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2220,6 +2220,28 @@ static void userfaultfd_reset_ctx(struct vm_area_struct *vma)
 	userfaultfd_set_ctx(vma, NULL, 0);
 }
 
+/* Clear the uffd bit and/or restore protnone PTEs */
+static void userfaultfd_clear_ptes(struct vm_area_struct *vma,
+		unsigned long start, unsigned long end)
+{
+	unsigned int mm_cp_flags = 0;
+	struct mmu_gather tlb;
+
+	if (!userfaultfd_protected(vma))
+		return;
+
+	if (userfaultfd_wp(vma))
+		mm_cp_flags |= MM_CP_UFFD_WP_RESOLVE;
+	if (userfaultfd_rwp(vma))
+		mm_cp_flags |= MM_CP_UFFD_RWP_RESOLVE;
+	if (vma_wants_manual_pte_write_upgrade(vma))
+		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
+
+	tlb_gather_mmu(&tlb, vma->vm_mm);
+	change_protection(&tlb, vma, start, end, mm_cp_flags);
+	tlb_finish_mmu(&tlb);
+}
+
 static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 					     struct vm_area_struct *prev,
 					     struct vm_area_struct *vma,
@@ -2239,22 +2261,7 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 	if (start == vma->vm_start && end == vma->vm_end)
 		give_up_on_oom = true;
 
-	/* Clear the uffd bit and/or restore protnone PTEs */
-	if (userfaultfd_protected(vma)) {
-		unsigned int mm_cp_flags = 0;
-		struct mmu_gather tlb;
-
-		if (userfaultfd_wp(vma))
-			mm_cp_flags |= MM_CP_UFFD_WP_RESOLVE;
-		if (userfaultfd_rwp(vma))
-			mm_cp_flags |= MM_CP_UFFD_RWP_RESOLVE;
-		if (vma_wants_manual_pte_write_upgrade(vma))
-			mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
-
-		tlb_gather_mmu(&tlb, vma->vm_mm);
-		change_protection(&tlb, vma, start, end, mm_cp_flags);
-		tlb_finish_mmu(&tlb);
-	}
+	userfaultfd_clear_ptes(vma, start, end);
 
 	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
 				    &new_vma_flags, NULL_VM_UFFD_CTX,
@@ -2353,8 +2360,10 @@ static void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
 	/* the various vma->vm_userfaultfd_ctx still points to it */
 	mmap_write_lock(mm);
 	for_each_vma(vmi, vma) {
-		if (vma->vm_userfaultfd_ctx.ctx == ctx)
+		if (vma->vm_userfaultfd_ctx.ctx == ctx) {
+			userfaultfd_clear_ptes(vma, vma->vm_start, vma->vm_end);
 			userfaultfd_reset_ctx(vma);
+		}
 	}
 	mmap_write_unlock(mm);
 }

---
base-commit: b61fa14ce6bcbba2cb9a96feea31b760226d6b43
change-id: 20261031-uffd-prot-bits-fork-event-de821d651ab6

--
Sincerely yours,
Mike.

