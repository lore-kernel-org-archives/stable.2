Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703474;
	b=zHEPl10dSarkL5QBxQUYycEEiJRtEaqHcJtWHbbaqD+L25HgaoaWNdfnGkEEVSS8/aQk
	 7jWK1Nhb+o8QOv8XB14uepZGjn4PUbjSm2ruiCiRRCZRWfxmdlrKbPjT4cKGLgYHBGjeM
	 5f10MYzeF8sZinsMFwJ0710llWeScSSg9DIrCnGcHJAK7ghQUOFruM0vCkfrWWJFr9LiL
	 LLmx5Fb+XFdj7WiUT/gFH8+xysALjkaMUu8K/u9Zm+PD3RTITvqeej1+xRoUWhb7wSmu7
	 9kS+F/4Dch3jlJFTYcuR2w3z/IrXETnnnOgddMEZ8VyURkkqoI0r7lW9xlZQOr2p7Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703474;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ecW6hp4wZlGHdbC08MboUJeTOF6UVrEhJ7KM222hSDU=;
	b=cU1uBr9/uS1cbBYeZvrVTwsz8ahJyVmYrA2JzYDiL+R3OHLviQmIG1H5MkrX6vC67h1g
	 qgo7OqG5gHMGFnSDp2zCF+RCY8RI/1QGhZToF4ecF7fHvE+B+hoz4To9MrTJM6FoSB7R9
	 sdMPN+JqS9kIVZ+sTyEFAq6lK/bpQ0frT/I017jPqqA+ITCBqUT0dJREQlDi/e8U01my5
	 h5VhondNEQTzwMBzudn+VUTZF+sKSeH1ov9d7nHl0ZHGn3hngyH6W/uuj3dnJC22B2YrH
	 DPjlMTwvJjwmnXUYA/Ad5YUJ3Gr8DynlNCHIex5rNAuxNgevkXTx0BKRrf4O0X/rExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsOSxJ+T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD8F606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsOSxJ+T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065791F000C4;
	Sun, 15 Nov 2026 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703473;
	bh=ecW6hp4wZlGHdbC08MboUJeTOF6UVrEhJ7KM222hSDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MsOSxJ+Ton0ukyPtBp9/k9M2SBXozbaDzw6X9ae8s+Qy+ynOBUlVxP3A3EHf4094U
	 BCEKANW7q9wkaB18BerPKoZLpfR/wgOMm/dlvukzWtz0URcUyB4os3t62vPWiSQFPT
	 t27hV4j88gA+oCMKOr33mX+SQsD/DcfkqkyGqlxBQ21BHRwrsFiHeK9dWvY7Rg56Tn
	 O5d9bsLMccKFablqmr+kCZi1hTU1NlNoS8Xkx4epAz0+r50ch/IsWIjumUXjPZKrcj
	 JUc6BF4y/UCuh2tnxBbFos45zArxyAs6zS2E59Lgpb5YoKf6/2vZlgRZd7Wd5uzgIv
	 bUxd//uCDVrrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/filemap: finish fault cleanup before dropping the fault lock
Date: Sat, 14 Nov 2026 19:44:31 -0500
Message-ID: <20261115004411.592484-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202113-failed-5.15-97156a6c355c@kernel.org>
References: <20261109202113-failed-5.15-97156a6c355c@kernel.org>
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
[ sashal: adapted folio-based fault handling to page-based APIs using mmap_read_unlock() instead of release_fault_lock() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9fec53a3f5505..c9e54120288fc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2907,10 +2907,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
  * @page - the page to lock.
  * @fpin - the pointer to the file we may pin (or is already pinned).
  *
- * This works similar to lock_page_or_retry in that it can drop the mmap_lock.
- * It differs in that it actually returns the page locked if it returns 1 and 0
- * if it couldn't lock the page.  If we did have to drop the mmap_lock then fpin
- * will point to the pinned file and needs to be fput()'ed at a later point.
+ * Returns 1 with the page locked, or 0 if locking failed.
+ *
+ * On both entry and return, a non-NULL *fpin means the fault lock has
+ * already been dropped and the caller must eventually fput() the file.
+ * Otherwise the fault lock is still held, including on failure.
  */
 static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 				     struct file **fpin)
@@ -2927,20 +2928,10 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 		return 0;
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
-	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(page)) {
-			/*
-			 * We didn't have the right flags to drop the mmap_lock,
-			 * but all fault_handlers only check for fatal signals
-			 * if we return VM_FAULT_RETRY, so we need to drop the
-			 * mmap_lock here and return 0 if we don't have a fpin.
-			 */
-			if (*fpin == NULL)
-				mmap_read_unlock(vmf->vma->vm_mm);
-			return 0;
-		}
-	} else
-		__lock_page(page);
+	if (vmf->flags & FAULT_FLAG_KILLABLE)
+		return !__lock_page_killable(page);
+	__lock_page(page);
+
 	return 1;
 }
 
@@ -3040,7 +3031,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_page_maybe_drop_mmap().
+ * may be dropped before doing I/O or when aborting an interrupted wait.
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -3184,9 +3175,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 out_retry:
 	/*
-	 * We dropped the mmap_lock, we need to return to the fault handler to
-	 * re-find the vma and come back and find our hopefully still populated
-	 * page.
+	 * With fpin set, the fault lock was already dropped. Otherwise it is
+	 * still held. Release invalidate_lock before dropping either protection.
 	 */
 	if (page)
 		put_page(page);
@@ -3194,6 +3184,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		filemap_invalidate_unlock_shared(mapping);
 	if (fpin)
 		fput(fpin);
+	else if (!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
+		mmap_read_unlock(vmf->vma->vm_mm);
 	return ret | VM_FAULT_RETRY;
 }
 EXPORT_SYMBOL(filemap_fault);
-- 
2.53.0

