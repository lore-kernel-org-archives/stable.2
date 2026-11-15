Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702902;
	b=s/W4GELPaAF81zc9lVNtSfb6yWPGI4YKHrWJsAkAVhSmYZBMSTTfvFLHZXYU4FFuB2wR
	 ZwLMq26ljAwl7r1WJmzHoTmdPr+iGJXingPVLlpC0/ipztox7J0tAaeJRAdHIwVf6AU0+
	 yLbYHzJmYOy0y9XM+gyQ/e1zBt6jsjQBRCcHwtuOuDsgK/VD7l9yf/jal4HKhu+uA6XmA
	 vD1sD5H09YDUyh8DLXAlv47F8d/GIcXxupJeNBGGi6wy23QJKtNjKOGLyfNMT4kTjYRe2
	 26m/zdhKxpBzn3EVG31PI1qYALxGt3H5XxWHCgicF5ImHnal3s9QWQ5atYwbMv7VyEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T9RCugWu9k0Yi0yuOLOvwdPbmC6z5rJsmF4k940UFxw=;
	b=OV38rTQFb4HYM3ddEpzajW2emRtyJFErAQXORAOedwB0maZTMM3+lZOCccQkmzHU6dEQ
	 v68eDiflUuad5Qyh9XLL1UOQK8y3DM6CQofnpH37xbQSTnYB9GuRMUqy6C71H9R+oFLDc
	 W+l1S3ED1OJbO3VTTmG5hAfsd0KD0HT0O3gitCdFOxfE30mGNIyojOCoqriHgHTR/FSa5
	 hVkFIEc2Yb1+yJZU+EujvCAUU9BjQ16Y54BYzvXrhzUG3dCoMmpetc7kafIZT5Vf4icsf
	 rJRyAnIx7Rr+2ETlEZYVydlwhgRtmdLmNCpGIrp+qWeFx0DfZz3PUlPiXK2FBvtP/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxce28XB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A759606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxce28XB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC311F000C4;
	Sun, 15 Nov 2026 00:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702901;
	bh=T9RCugWu9k0Yi0yuOLOvwdPbmC6z5rJsmF4k940UFxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fxce28XBA7bzPUJqCjMEFN0AhTYKig1svrvGvW/yFVLd83Qcx/DDUakROlEnN4be7
	 Y+5WXMUwhQj4qSKe9tr3BZz0dQ+YpTqvpE08+oHCei0IhdndCK9cJB33AQWCODy1iF
	 mGjhPg1DRj6OEfUnUUXdH7w65GR1yA5WowiUFj8SVH6CYCnq8cY+FlGJ0ELrfWwx/9
	 DIGCP5Ls7gaJOjgtbTNcpNZaIR7w6WiWmstNvTDFG8RE/QAHCZXxHIFGSUWBVWWpjX
	 UW+Go0OXv5mJpH7t7XWqLdxufz57wWO5j5F038Sc5s/F6tQqJdjBDIK3PHi4qn3jLC
	 wg54DE08NJWuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/filemap: finish fault cleanup before dropping the fault lock
Date: Sat, 14 Nov 2026 19:34:59 -0500
Message-ID: <20261115003438.562027-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201600-failed-6.1-97156a6c355c@kernel.org>
References: <20261109201600-failed-6.1-97156a6c355c@kernel.org>
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
[ sashal: Replaced release_fault_lock(vmf) with mmap_read_unlock(vmf->vma->vm_mm) for mmap-only fault locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 7c996dc4dad28..08f0f17447cf4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3075,11 +3075,11 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
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
@@ -3096,20 +3096,9 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 		return 0;
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
-	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__folio_lock_killable(folio)) {
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
-		__folio_lock(folio);
+	if (vmf->flags & FAULT_FLAG_KILLABLE)
+		return !__folio_lock_killable(folio);
+	__folio_lock(folio);
 
 	return 1;
 }
@@ -3228,7 +3217,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
  * vma->vm_mm->mmap_lock must be held on entry.
  *
  * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
- * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
+ * may be dropped before doing I/O or when aborting an interrupted wait.
  *
  * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
  * has not been released.
@@ -3371,9 +3360,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 
 out_retry:
 	/*
-	 * We dropped the mmap_lock, we need to return to the fault handler to
-	 * re-find the vma and come back and find our hopefully still populated
-	 * page.
+	 * With fpin set, the fault lock was already dropped. Otherwise it is
+	 * still held. Release invalidate_lock before dropping either protection.
 	 */
 	if (folio)
 		folio_put(folio);
@@ -3381,6 +3369,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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

