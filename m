Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC6351C22
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790407101; cv=none; b=RnpCLIyzTVygGgeQCOKibagYa/+xawMwA318b1yf5FvQyDvM4ZPA7u/fGhSRAORMwjrvZDlFRauMgKeQHHrG+R6qTwNZxoJ5PdPGrD5tEG3eFtW2mjyuExkuhS2pDFIaXHsvABssR+FYSNmx31tmZVzpBWeCque7NFI3C2lLXew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790407101; c=relaxed/simple;
	bh=zhu5+JGJC/QQPTb6WtFZIWp9H9ce3LURoUuj98+pXWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K7NLkbP8VugX3Y7yUnMJ+X+CEvLXJOoKAXa48L+q70yMWxESt/VdbkC45uB2pY3rroTnM2WkDaNlELnrV13D/6+uzOS6xrjyFUYbH/bJdOfSmqacVetmxBbfw8QI6jbLfC6M38uobNcBHl+2SYTEBZOo+YQVJ/fi0s8uvw7TFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds076Nop; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds076Nop"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so8359655e9.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 00:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790407098; x=1791011898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kPn9y+WWBClwrAI2o2zL1CXuP72wHxoMXNLYbFghns=;
        b=Ds076Nop/8aocebkLoRL1bffBA8cuD2qfTRyBDGsMBmXqCDuqgLZgPvhq0vQH8XQYk
         K6PyRwMDyBk8D68EYN1cMCjgY0FycWxewrHsNzc2gl2TnTzc9aktuDfBdrk5hMQ8qA7a
         vs0bqDX3eKd6gGWXoyDT5cGP4dr5HrPVoZtTog4pVnAOM6cW+nAKbqbejJZAmmj+KAft
         bad2YeAU0xd6LM+n9zgJNawesybcwVoDGk8NiAF9151uTtKHV/WD73uVqIoQXvDVxUK/
         q0Z7IBkWXq2X7gzotKj3gH6g+7HtTT/MmR5wCG/d1YGXnxkUCAEV2PFMXMiXWaj5kELY
         qcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790407098; x=1791011898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7kPn9y+WWBClwrAI2o2zL1CXuP72wHxoMXNLYbFghns=;
        b=yL3Uq2EXzoLLdS0ckCyhXDz5TqlD3NDP+1FNjEXZ5JjuQ0r4K2TNyFacfEwAKQVwKw
         hJtZz06u5YYuj5rzZCt0RDLSqkCZf/3IC4/RYRHEC4TIm0DYNHrYQN1g8jpgwfcQ3CT8
         NdV221Dd5QbKSsPmbp6PZhYUIeEID/KSSPwpruKtv9YH4lcKIE2wIRB1riNxfZ4lACbT
         lsgFeL6nn+kpNZTB4LRaBY2hzU8F5zw4ewf/fXnWTqcNDaqA/HY3MZqPPV52uvu/GApT
         6FB9DzKHx0bRvVEKSkPuAD9rRA8jV7pK2pjeafQtX5qGOZqIv/tNaa8t8L2c7a0Z2HTi
         jpAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzkhLFeQcwr9ttI36BL8dPCfblhwD7zb/6RmIW8IteJChIaSrxrjquDAw6WOxYUPcPxzTX73zc=@vger.kernel.org
X-Gm-Message-State: AFuF++m8cT4/5mmUVEODraceHl/LvVY05cjyWYwev5J7b56P2jpI351e
	uPU2deFDIcAmGNIswf2zq2AN677HYpqFO5VDtMvwFnMb62A392Cf+Mgx
X-Gm-Gg: AYBFou1f76iRkHWZg4+M1gM9tkqXSVdB3/Ggu2Laadp6u+OxCLhLSVtSepSR+DHW5ka
	cz9yEeQ/sir/nBDL0CPzvFGGVLYL5RaFcNyK5jZ8lAghkEv3CEsFg78DMA8mcHknv0r28xIs9sH
	tMAGsmAUnMcf0Bsmi1MXVKveJjWHEHTmMEqDV+4OqJT8HZ1nIAIo5ZtqR/mL0B8ft2ibcb1pke1
	n4U/GDssV8T/K9vP1J8eB0NvBjGDb0dngeQ0p0Mu6KZfcudbb/fppAgg/2CDqa7KjTIZSMf5845
	k8/5O3XIiLNyySxCPlPKIPjlVHa4bVXkaTzxlMDT+3JYTRmh6kowcz0VEtKcwv8FkSmbLAHwERu
	WfZ0ZbMDiBSZqdE71mHS26VMgWWA4siOwIrqQ6DWocjrtHmRBVnbkbbDSOeIuV2Nr5ZKejzrXjC
	4qOcbZ3h2Uo315nlIzTVPh3x4U9gYl0+v7nH1u91nnZ30XZ61P1FjCzNVVonR4kndz4p7Q1UxPD
	zhMg9NNQVdUXmnYrUeSK4+WGJizAAGuE9+ZKeQBiDqH9Yk28DCrgNskPbloRDH02kLsFGFTdTNF
	n+MuQAVyX4KTp0B32QyTvqXoTopWvm9kLr+xolsq01gA6X3vScWjZdTgf54F6RO7il5ZEH9h98n
	/ld5Bggmf
X-Received: by 2002:a05:600c:4709:b0:49f:fbad:29c1 with SMTP id 5b1f17b1804b1-49ffbad2d61mr16100115e9.33.1790407097646;
        Sat, 26 Sep 2026 00:18:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4271sm289294915e9.5.2026.09.26.00.18.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 00:18:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>,
	Muchun Song <muchun.song@linux.dev>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
Date: Sat, 26 Sep 2026 09:18:11 +0200
Message-Id: <20260926071811.77481-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2025021020-copper-visibly-e6a9@gregkh>
References: <2025021020-copper-visibly-e6a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

commit 58db7c5fbe7daa42098d4965133a864f98ba90ba upstream.

Patch series "mm/hugetlb: Refactor hugetlb allocation resv accounting",
v2.

This is a follow up on Ackerley's series here as replacement:

https://lore.kernel.org/r/cover.1728684491.git.ackerleytng@google.com

The goal of this series is to cleanup hugetlb resv accounting, especially
during folio allocation, to decouple a few things:

  - Hugetlb folios v.s. Hugetlbfs: IOW, the hope is in the future hugetlb
    folios can be allocated completely without hugetlbfs.

  - Decouple VMA v.s. hugetlb folio allocations: allocating a hugetlb folio
    should not always require a hugetlbfs VMA.  For example, either it got
    allocated from the inode level (see hugetlbfs_fallocate() where it used
    a pesudo VMA for allocation), or it can be allocated by other kernel
    subsystems.

It paves way for other users to allocate hugetlb folios out of either
system reservations, or subpools (instead of hugetlbfs, as a file system).
For longer term, this prepares hugetlb as a separate concept versus
hugetlbfs, so that hugetlb folios can be allocated by not only hugetlbfs
and other things.

Tests I've done:

- I had a reproducer in patch 1 for the bug I found, this will start to
  work after patch 1 or the whole set applied.

- Hugetlb regression tests (on x86_64 2MBs), includes:

  - All vmtests on hugetlbfs

  - libhugetlbfs test suite (which may fail some tests, but no new failures
    will be introduced by this series, so all such failures happen before
    this series so shouldn't be relevant).

This patch (of 7):

Since commit 04f2cbe35699 ("hugetlb: guarantee that COW faults for a
process that called mmap(MAP_PRIVATE) on hugetlbfs will succeed"),
avoid_reserve was introduced for a special case of CoW on hugetlb private
mappings, and only if the owner VMA is trying to allocate yet another
hugetlb folio that is not reserved within the private vma reserved map.

Later on, in commit d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle
areas hole punched by fallocate"), alloc_huge_page() enforced to not
consume any global reservation as long as avoid_reserve=true.  This
operation doesn't look correct, because even if it will enforce the
allocation to not use global reservation at all, it will still try to take
one reservation from the spool (if the subpool existed).  Then since the
spool reserved pages take from global reservation, it'll also take one
reservation globally.

Logically it can cause global reservation to go wrong.

I wrote a reproducer below, trigger this special path, and every run of
such program will cause global reservation count to increment by one, until
it hits the number of free pages:

  #define _GNU_SOURCE             /* See feature_test_macros(7) */
  #include <stdio.h>
  #include <fcntl.h>
  #include <errno.h>
  #include <unistd.h>
  #include <stdlib.h>
  #include <sys/mman.h>

  #define  MSIZE  (2UL << 20)

  int main(int argc, char *argv[])
  {
      const char *path;
      int *buf;
      int fd, ret;
      pid_t child;

      if (argc < 2) {
          printf("usage: %s <hugetlb_file>\n", argv[0]);
          return -1;
      }

      path = argv[1];

      fd = open(path, O_RDWR | O_CREAT, 0666);
      if (fd < 0) {
          perror("open failed");
          return -1;
      }

      ret = fallocate(fd, 0, 0, MSIZE);
      if (ret != 0) {
          perror("fallocate");
          return -1;
      }

      buf = mmap(NULL, MSIZE, PROT_READ|PROT_WRITE,
                 MAP_PRIVATE, fd, 0);

      if (buf == MAP_FAILED) {
          perror("mmap() failed");
          return -1;
      }

      /* Allocate a page */
      *buf = 1;

      child = fork();
      if (child == 0) {
          /* child doesn't need to do anything */
          exit(0);
      }

      /* Trigger CoW from owner */
      *buf = 2;

      munmap(buf, MSIZE);
      close(fd);
      unlink(path);

      return 0;
  }

It can only reproduce with a sub-mount when there're reserved pages on the
spool, like:

  # sysctl vm.nr_hugepages=128
  # mkdir ./hugetlb-pool
  # mount -t hugetlbfs -o min_size=8M,pagesize=2M none ./hugetlb-pool

Then run the reproducer on the mountpoint:

  # ./reproducer ./hugetlb-pool/test

Fix it by taking the reservation from spool if available.  In general,
avoid_reserve is IMHO more about "avoid vma resv map", not spool's.

I copied stable, however I have no intention for backporting if it's not a
clean cherry-pick, because private hugetlb mapping, and then fork() on top
is too rare to hit.

Link: https://lkml.kernel.org/r/20250107204002.2683356-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20250107204002.2683356-2-peterx@redhat.com
Fixes: d85f69b0b533 ("mm/hugetlb: alloc_huge_page handle areas hole punched by fallocate")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Breno Leitao <leitao@debian.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Karl Mehltretter: Only the allocation-error context differs in this stable
  tree. The backport retains this stable tree's direct -ENOSPC return instead
  of importing the later out_end_reservation path; the functional changes
  otherwise match upstream. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested against the current linux-6.6.y tip, 6.6.157:

- x86-64 QEMU, 2 MiB HugeTLB pages, at 1 and 4 vCPUs
- compared with the unpatched kernel, an extended version of the commit's
  fork/COW reproducer kept the child mapping alive during the parent write
  and changed HugePages_Rsvd after program cleanup from 5 to 4 and after
  unmount from 1 to 0
- parent/child data isolation passed and no kernel diagnostic was observed

 mm/hugetlb.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bd8752a5356b7..8fe60577f209c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1398,8 +1398,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, long chg)
 {
 	struct folio *folio = NULL;
 	struct mempolicy *mpol;
@@ -1415,10 +1414,6 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
 		goto err;
 
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && !available_huge_pages(h))
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1434,7 +1429,7 @@ static struct folio *dequeue_hugetlb_folio_vma(struct hstate *h,
 		folio = dequeue_hugetlb_folio_nodemask(h, gfp_mask,
 							nid, nodemask);
 
-	if (folio && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (folio && vma_has_reserves(vma, chg)) {
 		folio_set_hugetlb_restore_reserve(folio);
 		h->resv_huge_pages--;
 	}
@@ -3088,17 +3083,6 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 			vma_end_reservation(h, vma, addr);
 			return ERR_PTR(-ENOSPC);
 		}
-
-		/*
-		 * Even though there was no reservation in the region/reserve
-		 * map, there could be reservations associated with the
-		 * subpool that can be used.  This would be indicated if the
-		 * return value of hugepage_subpool_get_pages() is zero.
-		 * However, if avoid_reserve is specified we still avoid even
-		 * the subpool reservations.
-		 */
-		if (avoid_reserve)
-			gbl_chg = 1;
 	}
 
 	/* If this allocation is not consuming a reservation, charge it now.
@@ -3121,7 +3105,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	folio = dequeue_hugetlb_folio_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	folio = dequeue_hugetlb_folio_vma(h, vma, addr, gbl_chg);
 	if (!folio) {
 		spin_unlock_irq(&hugetlb_lock);
 		folio = alloc_buddy_hugetlb_folio_with_mpol(h, vma, addr);
-- 
2.53.0
