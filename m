Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679714;
	b=ugPt5DyiIKbnb6gpDExP9JML12427LAv3iNW6XgTRblFgdHkrNMGNEDWbU6Qtf0J5Off
	 yKnB+7eagdtULDCrapdC46HbcQXZUTT6pgMi74GTUUqFFvR0pyCUtvdjd+ob5YWitZM0J
	 ULppSvKJjzTxsKKK+P35dV0yAH5o36FhM43NnqWnXDwQD6nhCLV/tgn4y/nYvwHEpStac
	 RlflzKMqIB38GiXeWNCPNo1GnyK5pYH9Waezx/GAMDdFMI4YujquVsGE7CR8lr2RA/egB
	 CkrwYkdME6RlOC1K1p9TXdwDtGL2sUz9yZ6GJuPPaBZO9a9J6q8Q9TbYE7Zfu9w5VXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZprGxEgVqdOxzCm64/WrtA78UrLHQce785Q9kPFKlpY=;
	b=M3/I/f+eU1th/TTegWdgn8qjfz+74d1GpmQDUffe2Ckc6awV3foypYfyO+3b+xMoCtKk
	 dW5iHJx0uXsA2Y3HcWfUe7f55YTrsMi59GB73En3Hp4Jh13SId3tooiupyMvUwsOlI91z
	 4r1C4/mPFGHRReddPN1gT9Dt3X9m1c5T1+LNjuNrncavuZ6oPzBl7pP4LJqJSiIXrkXCk
	 9db/RfVUEi2/VP+T2Lm6O8nEtBYLCY7fE2Gz+dDpsK8gBPXlqCIJi9vkN0DcSRd4a2DAi
	 Um279Eys8fPNMreF1ITKg5FP1LSf1JxVqcKzE4oDdVWJxFsjVXUSK2FAooXvc9vKRWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTDIW0oz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA865606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTDIW0oz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C741F000C4;
	Sat, 14 Nov 2026 18:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794679714;
	bh=ZprGxEgVqdOxzCm64/WrtA78UrLHQce785Q9kPFKlpY=;
	h=From:To:Cc:Subject:Date;
	b=LTDIW0ozW8N8vXgaBipBdO7eEB3sjUodL7vOEJVQUsUyN2AwetpSU7RB0nvXkZhwA
	 2fncDfrG5YOyP/1dB5Kxi4Wy0fUdH8hcJ9C8KcFdvXK0Pq0Fu2lKeY9nzsKA8GUpaG
	 su2kQ5aIqnt7vHQJXgFZ1eazDGbFtOs7iLlbPolr5+WYyXv7gDqfN5oeMIC1wS3yWD
	 na3WUPRcgJhCpSK5Nv8mZUmwHswp01PgLi6NEG9kaMW3+lJIGLchPoo8bgqMacvVDX
	 EI1ynhkUnzwcTUlvN8CTvCk3oJNSKM9vT3dW66ALCG8A4zvyRhjx5yUiBo/LLoyHaw
	 88ywpkhaUZWCg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Cc: ljs@kernel.org
Subject: [PATCH 6.6.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
Date: Sat, 14 Nov 2026 18:08:30 +0000
Message-ID: <20261114180830.55586-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
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

[ Upstream commit 7135a05838e85845e1bbf6caa6596a7e3b791a40 ]

A VMA is considered write locked if vma->vm_lock_seq equals
mm->mm_lock_seq. The latter is incremented each time the mmap write lock is
released or downgraded, while the former is not updated on unlock.

Both are ints, so after 2^32 such cycles mm->mm_lock_seq matches the stale
vma->vm_lock_seq of a VMA which is not write locked. vma_start_write() then
returns without taking the VMA lock, so readers are not excluded and a VMA
can be modified with concurrent readers.

So far the assumption has been that this overflow is benign, resulting only
in readers spuriously falling back to the mmap lock, however it turns out
that this was an unsafe assumption.

This deviates from the upstream patch, which resets every VMA's sequence
number on overflow. That relies upon mm->mm_lock_seq being a seqcount,
which it is not in this tree.

Instead, make both sequence numbers long. In both vm_area_struct and
mm_struct the field is followed by a pointer-aligned field, so on 64-bit
this fills an existing hole and neither struct grows.

User facing effects are - dangerous races that could cause memory
corruption or NULL pointer dereferences (especially on page table
traversal) are avoided.

Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Closes: https://lore.kernel.org/all/20261015143735.1630957-1-4ncienth@gmail.com/
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h       |  7 +++----
 include/linux/mm_types.h | 11 ++++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c365c33b9c3a..8bce7f49b6e9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -670,7 +670,6 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 		return false;
 
 	/*
-	 * Overflow might produce false locked result.
 	 * False unlocked result is impossible because we modify and check
 	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
@@ -695,7 +694,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, long *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -714,7 +713,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	long mm_lock_seq;
 
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
@@ -732,7 +731,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	long mm_lock_seq;
 
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 91c10d8b00c0..b6f981c8d1d2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -664,11 +664,12 @@ struct vm_area_struct {
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
-	 * This sequence counter is explicitly allowed to overflow; sequence
-	 * counter reuse can only lead to occasional unnecessary use of the
-	 * slowpath.
+	 * This sequence counter must not be reused while a VMA still holds an
+	 * old value, as that VMA would then be spuriously considered write
+	 * locked and readers would not be excluded. It is therefore a long,
+	 * which on 64-bit will not overflow in practice.
 	 */
-	int vm_lock_seq;
+	long vm_lock_seq;
 	struct vma_lock *vm_lock;
 
 	/* Flag to indicate areas detached from the mm->mm_mt tree */
@@ -847,7 +848,7 @@ struct mm_struct {
 		 * Can be read with ACQUIRE semantics if not holding write
 		 * mmap_lock.
 		 */
-		int mm_lock_seq;
+		long mm_lock_seq;
 #endif
 #ifdef CONFIG_FUTEX
 		atomic64_t futex_unique_id;
-- 
2.56.0

