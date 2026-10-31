Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470449;
	b=swF87wd3PDmv/tfNvNGOp5MC2Udex4G0o8EHMKrsbgY8Rwa2fNI80uci5kr+wPVgu937
	 Vj0jiQfKrN3niZqpZrG4gv2klhEymKQs50B9NV6TgiHER640pMW1klAabxqHTQmu7omnP
	 TRgprc8v4ClfDQnZ47SfQt3iDJbkxFxOfbK1TsSHs2pkzZ0N7OxtgdSRNRpNpNc8AZNgR
	 DLOkUK9H82xMMebFSjZlZyXGarNUbsJ/3P8r8EthtVCRf+bzV9uFDtu7o4GM1rESbSnEy
	 pUEWSLrTA8cdfQr8Hf9yOg2Mnpyupgi80Bvunl3BTYj/FwksPAh7rSaq9GFo+XGlIYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470449;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=+lDk8EHYpV0tgsYzdqpx9pkwT/VF+dJgKPq60hbaEBs=;
	b=IDb+e5C4Z/Wb5OSD/kVL1wJ2biQFthZjPuglmkbpUv38hvxFH5tU8ONq1RS4q4uL8cFK
	 HBukveX+SOca09/G5CZObpH29/HzblVYtk2YFVb1Z23ZEkKLO8MnmBaaoo+ah39LWnpCi
	 RsizXVKOB6AG3gSfC5mw12nQHgHeug3P5lwlXCis+3w0F1YAE3IN9qvLGGAhjSwFXNf+u
	 fAhcFk4RDQ0yU7XO4n4I0csM56La00Z1cfY1YpIqyXPQIR0hbMO/mJcR87qxQ5Z9zmWep
	 moiJ9YKcws+qVn4aN88VlQEo9sjRhJpRzbMh8QDh/SxHv+kkAwGr8tmpJuIY9kl0dsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltuI0pYY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E794606A31F;
	Sat, 31 Oct 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltuI0pYY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759D01F00A15;
	Sat, 31 Oct 2026 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793470449;
	bh=+lDk8EHYpV0tgsYzdqpx9pkwT/VF+dJgKPq60hbaEBs=;
	h=From:Date:Subject:To:Cc;
	b=ltuI0pYYmAHP6jr8YvI2mcaCXAy0wGU5zNKYgobO5roa0kNXxuUoMEEude3X1Oq4d
	 pnZ6rPf4P5Q0Djz4L4HwBBa0lmBC8KylvWV6TxldJ8n0+tp0eErvLDiFw44syJo/zT
	 YGd9IvxWzwidEgr6jBR4i+xlbk+TTUp9TeU4qIzSX+Cd11FYtzuWFx5JPUjvYkdls7
	 J0zOx4QkwphnwTGLhkTmZx4eAhdOKxZAs8jsk4LzdFkEcTGAYj8n4F0yKCwxUcUp/X
	 F6HzCiGlbWJBU+G9pJfVX2NpaojdLGGdvG4DA4uBFeOrkuXUZz1KWEfssK9NMkb51M
	 dkW21P9pzLrBw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 31 Oct 2026 20:14:03 +0200
Subject: [PATCH v2] userfaultfd: clear uffd state in child PTEs if uffd is
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
Message-Id: <20261031-uffd-prot-bits-fork-event-v2-1-c448e57df417@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ7CIBCFr2JYO+rQtP6svIdxAe1gUQEzUKJpe
 ndLvYDL7+W9L28UkdhSFKfVKJiyjTb4GeR6Jdpe+RuB7WYWcicb3FUIgzEdvDgk0DZFMIEfQJl
 8go4OErumRqUbMe9fTMa+F/fl+uM46Du1qQhLQ6tIoFn5ti+RcyG5rXMw+JiUflLp9DamwJ/lY
 Mbi+udLRkCo6r08SmwlIp4fxJ6em8A3cZ2m6QtNamy8+QAAAA==
X-Change-ID: 20261031-uffd-prot-bits-fork-event-de821d651ab6
To: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Tal Zussman <tz2294@columbia.edu>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
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
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Tal Zussman <tz2294@columbia.edu>
Tested-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
Changes in v2:
- make comment about what userfaultfd_clear_ptes() does more elaborate
- Link to v1: https://patch.msgid.link/20261031-uffd-prot-bits-fork-event-v1-1-3572921c2111@kernel.org
---
 mm/userfaultfd.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b71712edab4c..087b66260d04c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2220,6 +2220,32 @@ static void userfaultfd_reset_ctx(struct vm_area_struct *vma)
 	userfaultfd_set_ctx(vma, NULL, 0);
 }
 
+/*
+ * Clear uffd state from a WP or RWP range: the uffd bit, WP markers and
+ * RWP PAGE_NONE entries. Call this before dropping the registration, as it
+ * needs the VMA flags to know what to resolve.
+ */
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
@@ -2239,22 +2265,7 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
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
@@ -2353,8 +2364,10 @@ static void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
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

