Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702137;
	b=VNQoM08gB99ELxoX5/sEbp6u5WdY8TL3QcpdoCk6dX5fiIGDTi0WsNblSwVym3l+rbXV
	 Y9w2B3q0UZ71qc3TROvxqw4YspEGG0HQ6AJT5ompmbMBAVSKEAqEexBqCjn91eEekV9Cj
	 DmUjGUY636TC7fHMpLh6QttE7oHFN+7vD/Z+NzPozFfsGWsyfSci1s3+BveG1m95qGhwA
	 m0SGJtQ3sPL2JXutvaD++AKFeT/vREsp2OVDcs03iRqQudksqp0zVb+M3+LTyfW08islr
	 LByYhXQPcdg1HJrKRHs5D6Gf5nXDn7jcAVnPGnLajc5hiEj6pNgqnhIf8UwPc4+gYmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702137;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Ib11J+vVA5aXOtwIn3szcSoNMQHISL1ty4QM97FYlM=;
	b=k0Iq6svmaJmLxwoVSzMRf2s6tB5ErSC6/R5+KYXpx5cKkxEQxCIS4oAzSWIYpjPMSi+4
	 tucgLQCjTu+z3lnquzNGJl2EGoc05HJgbcLDQw9RtxXboKFH1KYIeoYNFHy/Nk9DIasYf
	 unzAGeUMTqRTKP22B3cKZLHYs4VpwduvYhIz1XSiBOdpC6THsCIxVQY745ZH9SANsa/+E
	 tnE+sbLUPtEd9LwzyoBE38wJV3lbHi7Vq3XKPwYOU7i/NQPrTGl1AAAcwYYVA8vz7Yd0a
	 HVeBM7bQWroC+5qVD2KGVH9OXaAM1gUcBdmvTRErPsqXt42mv6eYE7QmUGqyK/6kiEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXdzQ+pu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42978606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DXdzQ+pu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F01F000C5;
	Sun, 15 Nov 2026 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702137;
	bh=3Ib11J+vVA5aXOtwIn3szcSoNMQHISL1ty4QM97FYlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXdzQ+pu/m5VrYqZFOA5pQJNXL+5quDXcEQhNvAgpHyrxqKkfv2mPA5jTqjH96nha
	 R+vP00PXoyy9wZjlAIst9eCVL+mxZrH4QBTfOfJTHSlSYm02c5jL1oBI5h3v3/IGWI
	 uMIM6gl0WHvTrJHM0GweqC0K6p6I4OxYWyXZPjxR5Fy2nj71M8los5Geou+smNNfeA
	 mNXzB16/OkNJwpC9qh/tdc1V7p/cBm1gmQ0pm2ubHjeMi9WdkOg74a1dwFzAWDXC2K
	 EgcXQLhQnprLgAMUmLrUvcGb18sLxs44kgJTlABEESGsqe4F1DCm/n4AuVshwSCF6L
	 ZWbV+uy1xoThA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] mm/filemap: finish fault cleanup before dropping the fault lock
Date: Sat, 14 Nov 2026 19:22:14 -0500
Message-ID: <20261115002150.534207-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115002150.534207-1-sashal@kernel.org>
References: <20261109201133-failed-6.6-97156a6c355c@kernel.org>
 <20261115002150.534207-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 97156a6c355c21f7122421915f05461bd11699a4 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e62509489c58..fe469f6c24e52 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3140,11 +3140,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
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
@@ -3161,21 +3161,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
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
@@ -3294,7 +3282,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
+ * may be dropped before doing I/O or when aborting an interrupted wait.
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -3437,9 +3425,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
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
@@ -3447,6 +3434,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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

