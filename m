Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306039;
	b=4tSIIaGar5gz4Mwj0mVXke9a4iTb8SS7ruqOLVyRlK/xhlqwDJSy7InNghr5Hj5VXNr2
	 Lwxxkca3BqqIh0AzzShgTshw8OIHU7aImtgJj+tNjFSV86MBjovSsd3hisw1VzGUY9hbF
	 VqCzvvDKypC+8PU2o7ZdJIFMnj7lOQ67+zRpgsf1HHtZnorNKlwJ2KYFfq+LDkBJD0zHj
	 rpq64620Hr+MUBgPT2oHUDAdkuqN1dfIeYyQ547JlpMmUkWSsCn9EMwWsY7FmIaYpcm8L
	 rDY2HPyPs/eMlfLXDQ3v7ZAClzMfTbtmCaS8DwXnddyVgDHduEWXT4P5LjWNZ8FHssg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306039;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bDnFHMjA66BoQB8Vxjf4dtq2kXA91I+j2LTsXqWaqtA=;
	b=nV5r546RYmbLBwuKb/vz5ZsOT/vNcpJ1fFQnJsI1lF8BqEm2C7CSdPpTWxgEU4fhesoe
	 1zbR1TsXE4tmCL9zLHzWGC3BRCZC5zobpf1qzqZ7XcWEZv3sEQhVUCjNw/AWRk+ynGVtf
	 DMYKXsoxMQxEoNB5JTNqAR6mAwWKgYM6D7j4mUfF1U0y1ifsJ3Dcm66iYHGE8jsZQ+iVc
	 6SbhqxZog9teew73XkSQvz1Tp/ZxyIXnnlYoXy7ydLkpVF1iLQEOi4bdvZCwVSPN5JpUu
	 b61umzo++osarb1RGnofN/9NU8TCpCPoSp6bD0vL+c2k/ImAEiCwFocKXR90Bg6fpjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am3XTgpV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C29606A32A;
	Thu, 29 Oct 2026 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=am3XTgpV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4651F01824;
	Thu, 29 Oct 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306039;
	bh=bDnFHMjA66BoQB8Vxjf4dtq2kXA91I+j2LTsXqWaqtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=am3XTgpVgHU7w4T2qNJKEWMRK6et1DuqCwcBz+lFGVUX9YclSBZSowWGPpIIV7+IM
	 tEP5omw5Vzsc76le081/xL21kHFi0mU57Zo/UxYgrjd9vjFBziVfQWssZ6DxVCwwwd
	 a5vGIMoc9rL00pdWDUba4bp8F+ajymkeQeip9JVHBkhVDQrqaZ0q/WtsV7R6RPztmZ
	 o3Lqrrj2Hy4L/T8SbZDJ8rfKUMyvKC0VMztk5TIhdV5tescrZ1yrfhQDpQdMB9rocm
	 /bxf+2RUoBuGOuMzXVjiDrWORAfn+A5CwB/wYWROwZHGu9vWzhfxTvQyxEW3T2w1yW
	 4Yac9xTxgMYlg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:32:57 +0100
Subject: [PATCH v2 02/47] fork: take mmap_lock before copying mm_struct
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
Message-Id: <20261029-fixes_core-v2-2-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3737; i=david@kernel.org;
 h=from:subject:message-id; bh=xdagUeG+am6KY+4B7movMSkDtyS1Wqo3jrGYGcvuKUc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer225Nkv/lfLjom53y+5P53z+3H8sojjThvvT+idNq
 jkbHhaLdJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRr2cZfrM53Vy4zepghm7H
 g3RhgbUcrCeYBC7JSO3ie1J8widy9xZGhjmZn/qvLHE9ceaA4JXr89f/6bqY9Ma2s2ZalHXVw1B
 tTi4A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

dup_mm() copies the parent's mm_struct before dup_mmap() takes the
mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
and newer heap mappings, causing later brk() requests to fail.

Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
cause inconsistencies.

As a simple and robust fix, grab the parent's mmap_lock earlier. This
way we don't need to update individual mm fields in dup_mmap() and
keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
exec_vm, stack_vm), as that is now no longer required.

Keep releasing the parent's mmap_lock in dup_mmap(), before
userfaultfd completion, to avoid moving the userfaultfd handling into the
caller. This should get cleaned up later.

Move uprobe_start_dup_mmap() to preserve the lock ordering.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Harry Yoo (Meta) <harry@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 kernel/fork.c | 20 ++++++++++++++------
 mm/mmap.c     |  8 +-------
 mm/nommu.c    |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 18b6dd851642..ee40142dab31 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1533,12 +1533,19 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm)
 		goto fail_nomem;
 
+	uprobe_start_dup_mmap();
+	if (mmap_write_lock_killable(oldmm)) {
+		free_mm(mm);
+		goto fail_uprobe;
+	}
+
 	memcpy(mm, oldmm, sizeof(*mm));
 
-	if (!mm_init(mm, tsk))
-		goto fail_nomem;
+	if (!mm_init(mm, tsk)) {
+		mmap_write_unlock(oldmm);
+		goto fail_uprobe;
+	}
 
-	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
 		goto free_pt;
@@ -1557,9 +1564,10 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
 	mmput(mm);
-	if (err)
-		uprobe_end_dup_mmap();
-
+	if (!err)
+		return NULL;
+fail_uprobe:
+	uprobe_end_dup_mmap();
 fail_nomem:
 	return NULL;
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 148ba01c0373..7618e72766a5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1713,8 +1713,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);
 
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
+	mmap_assert_write_locked(oldmm);
 	flush_cache_dup_mm(oldmm);
 	uprobe_dup_mmap(oldmm, mm);
 	/*
@@ -1725,11 +1724,6 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	/* No ordering required: file already has been exposed. */
 	dup_mm_exe_file(mm, oldmm);
 
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
 	/* Use __mt_dup() to efficiently build an identical maple tree. */
 	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
 	if (unlikely(retval))
diff --git a/mm/nommu.c b/mm/nommu.c
index 91ab65afda70..6c6f95329674 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1887,7 +1887,7 @@ subsys_initcall(init_admin_reserve);
 
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	mmap_write_lock(oldmm);
+	mmap_assert_write_locked(oldmm);
 	dup_mm_exe_file(mm, oldmm);
 	mmap_write_unlock(oldmm);
 	return 0;

-- 
2.43.0

