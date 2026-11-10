Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273095;
	b=Hi/XUMXmpg5l4C3PVgCJ0uSpCtKX6xne8qby6upt5cK+i4dyW5VNVDMVjKixjOoKVBBs
	 f3S7hYaoFSwoJmALIlZmmhtIPTOhdzFG2CpfhjSd4fFNJ1GC9kDSLcGcpXp4kf/dJW8Ta
	 WTCeq9+TGbZB03kLmDoreOtOJNsML3mD2hE+EoVDVztuxSjMEUakE1EMCqFam1rub/0AM
	 vt93Z/3WHs7LxQFZl2xHKIpgDzQTGv4xzwk/xOT0NKsDY8OYKDhlFsdPtfFAYCNxgtgyX
	 tjsKhDCyWtB8oMpI+uTmyFZ8Ej01Nm+y5tcGe076ow3QPXYu5y5EytzhNkZD572sTpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273095;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=c1Rp/fvsiD8o/aH0rjAjGP5QcJStYZ3aZRTX1L7x/Ls=;
	b=dBKYsUwALyiyfB9XNrQNeHYJ49TWh16SQHEB66VlQrh3LRLFlbbVABaPUxdBx31AdtLy
	 q+xdFRYWaRe4ji8r2yeLtK2r+CNvO1peuqvlizwq14ieqEW1gqD4aYOS8Xc8QwdbsIL94
	 xzVR1/Ms6F97Z/aYp9syrqKOuMlwyehy4zos9nh8g1f6ukgzDQM4F6YqvsX/QbcjtoWeJ
	 lHx/cLpR0PJj3AmRCdRaoc3/F7pa1vTEo3u780IPP8IhTkrfgW31rbW5JElugD7mLOUMP
	 vsy7gkM16oYdiWPD63O3AtdqEEqWNMOE/Ts0f3/73SAI6O09/yO/LGLM8ibldUdm8GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgHRrX+W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F68606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgHRrX+W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E62D1F0089F;
	Tue, 10 Nov 2026 01:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273095;
	bh=c1Rp/fvsiD8o/aH0rjAjGP5QcJStYZ3aZRTX1L7x/Ls=;
	h=From:To:Cc:Subject:Date;
	b=KgHRrX+WAQl7XhKrcrSV8LR+372OkjIkGH6hcGQQ5cY4gFO9apdThG3P5wqWPeYOG
	 dM1PJmIVYUL9xWmlWBFzhcqtchJZ+KsnTFfHgmGcNYarnoFGf1czXhste9kQjLgQKW
	 D5upsU/D2oPtHhWOGo9+wAI2gr9qRVGWYZiCseXczN8TT608GLWEbfAqmMvXpoWeUD
	 1qvFayLcXsfgi4cH/CJwMq76MgrHrmnBCgp7LvY4fkW2NX8qTtShX6V38X27cwpTz8
	 RxyJpNvtd0ljlK095F8x1c3VNdvju0TEV7KkEa+n9mSCoxdu1s3FaDHSrHvWsm1V5s
	 rshecvtx8B0aw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	mason@kernel.org,
	cascardo@igalia.com,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/filemap: finish fault cleanup before dropping the fault lock" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:33 -0500
Message-ID: <20261109201133-failed-6.6-97156a6c355c@kernel.org>
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
git cherry-pick -x 97156a6c355c21f7122421915f05461bd11699a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201133-failed-6.6-97156a6c355c@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 97156a6c355c21f7122421915f05461bd11699a4 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:37 +0100
Subject: [PATCH] mm/filemap: finish fault cleanup before dropping the fault
 lock

On a retried fault, a fatal signal interrupting the folio lock wait
makes lock_folio_maybe_drop_mmap() drop the fault lock without pinning
the file. However, filemap_fault() may still need to release
mapping->invalidate_lock. A concurrent munmap() can release the last
file reference and free the mapping before that unlock.

Defer dropping the fault lock to filemap_fault()'s retry cleanup, after
releasing invalidate_lock. If the fault lock was already dropped for
I/O, release the existing file reference instead. Keep the fault lock
held for FAULT_FLAG_RETRY_NOWAIT as before.

Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Reviewed-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-8-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6b5e1d866a9e0..b04be64a5069f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3308,11 +3308,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
  * @folio - the folio to lock.
  * @fpin - the pointer to the file we may pin (or is already pinned).
  *
- * This works similar to lock_folio_or_retry in that it can drop the
- * mmap_lock.  It differs in that it actually returns the folio locked
- * if it returns 1 and 0 if it couldn't lock the folio.  If we did have
- * to drop the mmap_lock then fpin will point to the pinned file and
- * needs to be fput()'ed at a later point.
+ * Returns 1 with the folio locked, or 0 if locking failed.
+ *
+ * On both entry and return, a non-NULL *fpin means the fault lock has
+ * already been dropped and the caller must eventually fput() the file.
+ * Otherwise the fault lock is still held, including on failure.
  */
 static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 				     struct file **fpin)
@@ -3329,21 +3329,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 		return 0;
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
-	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__folio_lock_killable(folio)) {
-			/*
-			 * We didn't have the right flags to drop the
-			 * fault lock, but all fault_handlers only check
-			 * for fatal signals if we return VM_FAULT_RETRY,
-			 * so we need to drop the fault lock here and
-			 * return 0 if we don't have a fpin.
-			 */
-			if (*fpin == NULL)
-				release_fault_lock(vmf);
-			return 0;
-		}
-	} else
-		__folio_lock(folio);
+	if (vmf->flags & FAULT_FLAG_KILLABLE)
+		return !__folio_lock_killable(folio);
+	__folio_lock(folio);
 
 	return 1;
 }
@@ -3572,7 +3560,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
+ * may be dropped before doing I/O or when aborting an interrupted wait.
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -3728,9 +3716,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 out_retry:
 	/*
-	 * We dropped the mmap_lock, we need to return to the fault handler to
-	 * re-find the vma and come back and find our hopefully still populated
-	 * page.
+	 * With fpin set, the fault lock was already dropped. Otherwise it is
+	 * still held. Release invalidate_lock before dropping either protection.
 	 */
 	if (!IS_ERR(folio))
 		folio_put(folio);
@@ -3738,6 +3725,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
 		fput(fpin);
+	else if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		release_fault_lock(vmf);
 	return ret | VM_FAULT_RETRY;
 }
 EXPORT_SYMBOL(filemap_fault);
-- 
2.53.0




