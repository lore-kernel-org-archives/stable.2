Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277003;
	b=vKysGq4Mgxknh7+i5GkpUY7XrqFfEwSN5Ws4e9kAO/fyGPRVNLCcFJG7Qzphh7/f22va
	 wKWu5zL6BKygdeay5WmRX6g6hqKF7dzolZmA5P8ER4x0D+CkTB1wRQxtnfOFrS/l03wdQ
	 PTrkC1VdWwGrBsyq3J6vOOYchseAKet6BOa0/LAreAWGGqFc7miKFDcikzvXHN5asZstB
	 4kPBj3jEBlcV+x+UmexG3bK3XA5cwx/CWJQ3EKUapghkhCea36gs7QAdCnlQ2H+1Wc0W5
	 b6xjpymdwcnuC+NJVsyjA6TnEW3Um1maEveptQVhXBDnS5MYcrakCTsCDrXFUdpsDrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277003;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LId/pfdNK+kcwrBUkujBAEx5NAsbcSjlaxfY3IRiHMQ=;
	b=NUz4ghE4z45JVmx6jS72vpEuCqSOOdE+ZqfcghbVgFasgFk98PY7tjy9yd+e6xh4ehAi
	 2tBrNN4yoLFLalZf/s39ThT1/k22Wxy8C1t0qq7DLpJfnsPqAj1MguYTHIFYjikRkREj3
	 kvvcB9eYMk+YTLUUcLK9OegIHoiKjGfSIBc69w77smGd96sMCDc3myEFL9JExxc1Fai2o
	 e7q9qWcC4hzIdmSiCjqcGgKgfAv/C7I/7qXc7AsoUgdX/kz3586SuEjalAy3Z+UpHtII/
	 2yNfn4700KexLZASgEUWQfbzzEkuKPyQMV5Eu3+rJAWmxQOcyLHu96XzfaP3we6P7Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+Kgbu0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDD606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+Kgbu0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60DA1F000C0;
	Sat, 21 Nov 2026 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795277003;
	bh=LId/pfdNK+kcwrBUkujBAEx5NAsbcSjlaxfY3IRiHMQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W+Kgbu0c6J7SGfPQ62/PPeyc4fUL1Z6sm4hDkdNeYNV90392EaD2iD8hCMRfL9q/H
	 EkjPSGjTuwn6j5ALU6yA2mau7ArCdK+LGHOgFDz4gTkjiQsMqq3MKun2ypLTSSN+hm
	 7L+fqa6neyZgUoZ3XbM1HEvyFNXkRyoeyWfbELQTTOwb8phr7+nF83wMfj1d2JewLq
	 RB74X9qZCCq8HDGAJbJet/enCNUSbqw0gEotGLbEc5fSNusnqM48mxWN8Sm3kI8iGQ
	 WbjWR9KGSl4RGGag1na8PxxH3bT5lSZ0VIdRL6V1IfuQ8aDi2QpVyW3bMyJ6xiatkI
	 2uQgjwRcmPQGA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 21 Nov 2026 16:02:28 +0000
Subject: [PATCH 2/7] mm/vma: lock VMAs before taking mm_all_locks_mutex
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
Message-Id: <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4094; i=ljs@kernel.org;
 h=from:subject:message-id; bh=LrpiwotdXkJz5/ABY48wAzoP5uiMEH0O95S+K/32rIg=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIZD2xP/HWsKIUv41ZP+9YPG7MeHpby+H3+0Y7fS5IML
 SQkjq/b3VHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJRBgx/LOb8MhgJ+Ph3QUr
 BNlftZrKc5Y92eNpvezaCp/7PKsKYxczMsx9wiXqmj+37mTH6T7L8vANmrs26z3KkTpWzfDi/G2
 nEgYA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

If an mmu notifier is registered for an mm while one of its page faults
sleeps indefinitely under the VMA lock, the registration of mmu
notifiers for every other mm can hang un-killably.

mm_all_locks_mutex is shared by all mms, so its holder must not wait for
something that has no bound.

However, mm_take_all_locks() calls vma_start_write() on each VMA with the
mutex held, and thus waits for the readers of the VMA.

Since commit 4ed4379881aa ("mm: handle shared faults under the VMA lock"),
such a reader can sleep in ->page_mkwrite().

Consider fuse_page_mkwrite(), which sleeps until the FUSE server replies to
a write request:

    mm A, thread 1          mm A, thread 2         mm B
    ==============          ==============         ====
    lock_vma_under_rcu()
    fuse_page_mkwrite()
      folio_wait_writeback()
                            mm_take_all_locks()
                              mutex_lock()
                              vma_start_write()
                                                   mm_take_all_locks()
                                                     mutex_lock()

Fix the issue by locking the VMAs before the mutex is taken.

Additionally, make the VMA write lock killable so a fatal signal returns as
quickly as possible.

Finally, update the comments to reflect the change, dropping the lock
ordering list which begs for bitrot.

Note that the lock order at the top of mm/rmap.c doesn't appear to be right
- the hugetlb locks are taken after the VMA write locks. However, this was
already the case, and can be addressed in a follow-up in any case.

Target commit 4ed4379881aa ("mm: handle shared faults under the VMA lock")
as this is where it became possible for VMA lock readers to sleep in
->page_mkwrite().

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 4ed4379881aa ("mm: handle shared faults under the VMA lock")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 09bbcdb4971b..f8cf319ff9cf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2375,15 +2375,10 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
  * mapping->flags avoid to take the same lock twice, if more than one
  * vma in this mm is backed by the same anon rmap or address_space.
  *
- * We take locks in following order, accordingly to comment at beginning
- * of mm/rmap.c:
- *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
- *     hugetlb mapping);
- *   - all vmas marked locked
- *   - all i_mmap_rwsem locks;
- *   - all anon_vma->rwseml
- *
- * We can take all locks within these types randomly because the VM code
+ * Mark all vmas locked, before taking mm_all_locks_mutex. Then take remaining
+ * locks in the order mandated by the comment at the top of mm/rmap.c.
+ *
+ * We can take locks of the same type in arbitrary order because the VM code
  * doesn't nest them and we protected from parallel mm_take_all_locks() by
  * mm_all_locks_mutex.
  *
@@ -2400,20 +2395,24 @@ int mm_take_all_locks(struct mm_struct *mm)
 
 	mmap_assert_write_locked(mm);
 
-	mutex_lock(&mm_all_locks_mutex);
-
 	/*
-	 * vma_start_write() does not have a complement in mm_drop_all_locks()
-	 * because vma_start_write() is always asymmetrical; it marks a VMA as
+	 * VMA write locks do not have a complement in mm_drop_all_locks(),
+	 * because VMA write locking is always asymmetrical; it marks a VMA as
 	 * being written to until mmap_write_unlock() or mmap_write_downgrade()
 	 * is reached.
 	 */
 	for_each_vma(vmi, vma) {
+		int err;
+
 		if (signal_pending(current))
-			goto out_unlock;
-		vma_start_write(vma);
+			return -EINTR;
+		err = vma_start_write_killable(vma);
+		if (err)
+			return err;
 	}
 
+	mutex_lock(&mm_all_locks_mutex);
+
 	vma_iter_init(&vmi, mm, 0);
 	for_each_vma(vmi, vma) {
 		if (signal_pending(current))

-- 
2.56.0

