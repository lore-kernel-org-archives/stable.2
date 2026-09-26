Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C50547063
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408371; cv=none; b=Ke8px8DJ/YqlN1ixoSA7nd9DejYEVKFV8/VLZP/b/F1gN9z49giomRGvTVm4KCl19fwooYQEhXihENTu7foWNWI1C8OS2CNJfzqbs5B+06KQ91yWjENFGLrLDD2AajFubRKj8NpbkT8DGEitedz7FLzqhUZflCEbTSgd0uzxgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408371; c=relaxed/simple;
	bh=CXqRtoZh4GI3UnLTwnDqyxPCp9CeruuC/cJzJ/StYZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TD9HD8FI8KBTJVFqN10iCUh8LcEe7WviqH8CgqMVbHIPwlOvux3K34tJPPsIJC6O6Qf775EuAGFOw5vnmFciRtRZJxcm1+MnklVsJte5asbgW/eRSRfxapDk1ll6HLD/hnxn7maN59hcPwh3Ah7tm+XDbUNTGGVhvniY7uP3APQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdRVl9RH; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdRVl9RH"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso11406945e9.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790408368; x=1791013168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UzNu4qsML/vUrmG56fm/uRslLdrHhJ56SN3Sn3YDpZg=;
        b=FdRVl9RH+5vGkYo7Q3hjFnwMBW9PQdsUu2fgN7+lAh11gQ4MNfNICiIzcTbaHuM375
         2l5av0/H2Iz5N+sHYhsq+vVQ6MMhJaO34DsU075qIt1rE8NlYuQlzrq9j2BftkWxvx5B
         kDv6rEdQ/aOWaJry99j/hne5nnatV5TWI+m4KpwIiDAJS/D0nI+YeweYc2U+fpDAY8QZ
         WkWMnY2rij5jwm/pcZbLo7chNQ8RmawlJwZ1ySzoQ9PBgKRnHIHtnj3JN4cwdqHuVuRf
         DnZf7rAb0vVYYN0BI+nPI+xwqPQct5N/G2zRXtsFvABhwWXSWM8qmFCefz3B/BIkahY5
         ENWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790408368; x=1791013168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UzNu4qsML/vUrmG56fm/uRslLdrHhJ56SN3Sn3YDpZg=;
        b=Yt0onivGZmRD9NlY1hel3FLxtDzYd44RLfe17v+QPgMkBxXyNuaeU/JJIu5glI+H7m
         UHuUaoCQNSXt8yHUGO5LpPGh/UbDIXAAQ4jwklmrR14wciWb4KK9h0P/08sRJ/HjjQM9
         7FX3XlsrmITI1KUIO7aaDUsAjKNnuu1lis9JOQFn1ZGtBtg8XejGz1qW8Mp+YxZGemhA
         BSYSfNMGxs3nhhElMKjs4IgxRhNiYb62kfC9OHvPLk0x0rK/a3rBJz1pa3uWq2mzxR7Z
         F9Sax/fSu/UGBzPM55cUGZ3uICPngy4uKfQinTdthKPmIdTqj1LlE+KrCskgDPmTFLfK
         fm9g==
X-Forwarded-Encrypted: i=1; AKwUvBx3oVBNOR52SrUfalFwbaXFo29LGeG8Jed9MiLto7Bmdccw1KCXtNYbInljr9wz/02KdEJBNO0=@vger.kernel.org
X-Gm-Message-State: AFuF++l8JzBBEjqc4mjIbD6WFzkcWqaZJ0yDrZuwG4YqLkVsHP6dIEb1
	U9SYUKIDua/nGHlyEXfD5yVdxJkfTgg7mfFpHI3LWR5xZ931tTMT3vRx
X-Gm-Gg: AYBFou2GEcdNHhIktDzuOh9xV2fTB9tSyyf6petOIpI6bAS8uWBzlaWchyr8yRNdw2o
	1hWafXgQovgLt1O3cw37EgZScNqPpurijFNqhaKp+wVIC3NQ6oFxrr6YEpWx3Egum8RPA8C/LSh
	6qvrQhG4h709yBY1rXdXK9vj/CSwv6F8FvlVpfxIE1KoUQbH7WhONg7Dnf1evSCajZNUAE5KJXo
	Zrwl2t/qKCwZg7kRWZbWPnT3/7iMC8FrA2hqOOqLNuLaILhM0ewVZdbkARWvzxZ5kq+OPVoF9gA
	2gHaL5Ka4P52khKX3mJqgbt/CJDd9VY+ehlZKsdN25lK0xytQNvy3DxTMyMdmZi3h1bBjjYnhRO
	hrdfx4WDP1LPqWJdCPkvgHUOFd1ZXvMApiWTYkfDqibgyx2OicAAuacxt8gFN33Ta+gIJZ1wGXA
	dTxBtry0TcAXQwsTqDCuZU189UOvgDfD+h5dYs4yRG93oVdWx7PITQ4Qusz0IlQ1dl/nQ2O+URu
	I8mEPpjdWpcyJZiLAb2HK7SkmtVRNJeawTAVpqaYLd80DT+SvvhA1ZEUl581hgNQ0agqep4KFZd
	bUgBhPTNF99wfvtAEXbTevKRd7pskQvPSgyiEfZKE4Aj2Tfm/Tm7PMQAT4ukfac1e9C6dJLCvwM
	SzsLr9bQ=
X-Received: by 2002:a05:600c:6990:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49fe7b52fd1mr130966035e9.5.1790408367344;
        Sat, 26 Sep 2026 00:39:27 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff06b4d45sm118038915e9.7.2026.09.26.00.39.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 00:39:26 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
Date: Sat, 26 Sep 2026 09:39:16 +0200
Message-Id: <20260926073916.78450-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2025021025-deflector-judge-df07@gregkh>
References: <2025021025-deflector-judge-df07@gregkh>
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
[ Karl Mehltretter: The upstream changes map directly to this stable tree's
  page-based HugeTLB API. The backport retains this stable tree's inline
  free-minus-reserved calculation and direct -ENOSPC return; the functional
  changes otherwise match upstream. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested against the current linux-5.15.y tip, 5.15.221:

- x86-64 QEMU, 2 MiB HugeTLB pages, at 1 and 4 vCPUs
- compared with the unpatched kernel, an extended version of the commit's
  fork/COW reproducer kept the child mapping alive during the parent write
  and changed HugePages_Rsvd after program cleanup from 5 to 4 and after
  unmount from 1 to 0
- parent/child data isolation passed and no kernel diagnostic was observed

 mm/hugetlb.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e0908e491065d..947610e37a33c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1144,8 +1144,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 
 static struct page *dequeue_huge_page_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, long chg)
 {
 	struct page *page = NULL;
 	struct mempolicy *mpol;
@@ -1162,10 +1161,6 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 			h->free_huge_pages - h->resv_huge_pages == 0)
 		goto err;
 
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1179,7 +1174,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	if (!page)
 		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 
-	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (page && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
 	}
@@ -2775,17 +2770,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
@@ -2808,7 +2792,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	page = dequeue_huge_page_vma(h, vma, addr, gbl_chg);
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
 		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
-- 
2.53.0
