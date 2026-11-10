Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273363;
	b=e2cJY6bCgyT5iRTzTtaXNxgylFop0ET4JFmxbhJsDyOwU0SHs22FZCR4snXSgh/4AuG3
	 YBdrzJIhfTlusP+NiE2CYNEMXnprLNZ6GnAKZ6HHqSRkSaYaP8KEH7SFw3XCD/aEzhQps
	 Xi1586kaXFuJo71yeE/LVQo+S5NP7qvKec04udOMVCmtj6NFXHNIx2i+YRVokMranbRZ4
	 XYuram3KA0gIDOgdrMyk49K9/DllIqUWLdAG/hqvhSk0g0UNInc68Xjz4utd8iMS3Fwm3
	 j747UJHNfUBNtcj30bEopx5LnpHxGzDajCMNQLucCllkhEvwpf/uICL6/XR793n+r+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9h6/iea5ReaAE1yHpaWNX9IKAUSxUMaIWyh5Zrw45fk=;
	b=1YUXRspoJafC44fsqMrHfph8qusAPRxvDryAGxIcAAI7B1znT46z9jCIZpTHwL0D/cfs
	 2VumrFgREYXzzl+sAgBvT4PyJ6fDSTzwJ3+BXnPfOkMG/xVviP/Cluy9cLtSuFSdwEzUP
	 VFv1tJHVQ0hQQOdIyxsWCi8eMPwjfpLfD7sDJMR7faHlIMkGY+PW04fGIJx3s4TLtcNAz
	 fA+f9r/i8E4D0BRccJCmivl+bqIsOYrOXNfM82TOllVDJJdAqtEA5lCYq2oX4m6gRene5
	 3AJuNIomd11wR3ILF3BXHeqiPEidb1/EHX20QwRqMiCMzifoy94v47Y6IKNknFAz/fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e67Yy3Ws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE56606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e67Yy3Ws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200661F008A1;
	Tue, 10 Nov 2026 01:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273362;
	bh=9h6/iea5ReaAE1yHpaWNX9IKAUSxUMaIWyh5Zrw45fk=;
	h=From:To:Cc:Subject:Date;
	b=e67Yy3WsLJCpO6iCHVbH6Dd7CJ0jhD5xsY35y8jOW45WyS+N/ug7CSfMpxOXx3OWL
	 KiS4Me/lnnAT3rSxl3Wst8TkR4ddvAZpegu3uF8CEOCrEoh31XqSZ3RD19x3App5tH
	 bmXCbBZ6IZiOI3BZ1kv3NbuoutTw0er79W+78XnOa3BAOiWkImhTvL2MotNgv7Exlo
	 Y3jxcSJPZ5kJ94yjJq3qL9TpL9LCmJ/Zu5WyEmsOjLr7ugyg5+XYTFyLQ1v173TrCj
	 AwHsmqJ3ZdfM0DEwYho19M5EeP4HbwqSl5U0p1hEkmQfPBu2wsIISYMhw7VkdiTeuw
	 l8hE4V2weV7YA==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	mason@kernel.org,
	cascardo@igalia.com,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/filemap: finish fault cleanup before dropping the fault lock" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:16:00 -0500
Message-ID: <20261109201600-failed-6.1-97156a6c355c@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 97156a6c355c21f7122421915f05461bd11699a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201600-failed-6.1-97156a6c355c@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




