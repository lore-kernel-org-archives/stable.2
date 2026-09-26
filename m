Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCD351C22
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790407157; cv=none; b=B+l9BxBB2VnZlWNWh4UhMqLoDlM5sZtkFjQ370drsPqnt7d7lsGznZn2IVcX0k62/zJ+zTT3vgqNaOYvwchzBeBpH1hhKywgnuiiVKvjj0GhaSpSUGsdmnTvjCIPb41cr6/yHJ/idTEoa0H2bDSdC3gcFUKUlG7dOKypYm3lKHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790407157; c=relaxed/simple;
	bh=wt1G9EdRXHMt0dUJJPcioJa+Etvgiz0NvwrGIL/1pSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEuezqEL6KIs1DR5ok/HKIebgGrUAHzfbcXPtSn/fIh7LypxDaJbGkyckeSFY+fvjd132XpmD9rJ2TkwItZZY0pHT8JY9n7SEcILLUUQumeLq+YrfBiw+CmualqA6xgPrj0rfEPGJgWa194ubS9ivm6dDWSHBjtnsywqP2p2rcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLlp709V; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLlp709V"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e71cdb22bso11185125e9.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790407154; x=1791011954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29/rcOA6l7jaypa23Gt7b/u/553lXtaIHjUtlGKhfpw=;
        b=KLlp709VjvzzfY+25Su8RfB7HdVid3vOqZgx/A2m0YTd3O6KiN1bOaORBAsd/pKTwz
         go9geKSK05uLEX4XiUs5PZoWcrsg6hk3Oem08tB97dA/IT2PxqRrhNmLoK6HG3SIK4wY
         20LEZ+vXAeTH4o/JRy6M8WlX5A1hReQ/K40qQqxcH7eulBKfDvgGLZF+F/jJU8DjPyjH
         wFDx3Vf8dMBKshQxLU2KMG8PET5o37S6zhWW30rfONkki3jokW1B2aJgBhZNV2CKNIHF
         X07mHjWCyVkxkEAFom8GvS0hbMOXV084o0E/Fq8RPb0QAJSAgOy+E/iMhXA9YmhkapC2
         A8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790407154; x=1791011954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=29/rcOA6l7jaypa23Gt7b/u/553lXtaIHjUtlGKhfpw=;
        b=pDeRholqlFVdHXYxGAw207guoiOzRx0k7EhoFknWM4VuAiqOP7IOpydT7gh0UblYPI
         5EoKq28FjHy/f1meUZxRuh9aIl1/IIqbclcjnS741leIPnq63pCsUESlgpQIIsy12i96
         nBYdJRkMmdYTGqVgxjUey2UR8pmCZHZzTjEQqS1HqscerNAxduk4rKCwWIWwSwPadcvm
         IAWH/GUXs0dDRtcDxJLmlbEUusYW2MlPKkeJksvZEtOtyax5qmJ6uq96Clt9giTkrV0d
         72dBqsK7Cg0N9X8/wF3c/DszJy+oyzG3hrsRQg3EYlOy+cVxlnG1MN289I162A7ccKtf
         J7hw==
X-Forwarded-Encrypted: i=1; AKwUvBydd3CN2965d2uH0XyjmWMZyuQ3GOQEYI0fNDL1XkWdb0RyWsDZZ3w0aRGGt8iDngUGIjpCcxk=@vger.kernel.org
X-Gm-Message-State: AFuF++kfg/DmWE9/U05meqtAkHpUCCPaHytJBdBD/YKrN0Vdwp2jqrH8
	MurCTU5uSq/slk5eQMeA9rXHxtJO4bTfH57q+L2LbCXetgRGE7a3PhzjveDY8cpV
X-Gm-Gg: AYBFou2zWZfJqRrWFdk/ZVpQ9NqwXtQpxAtPoL8poOu9gw6XXOir27W5G5MUtqH+Nsz
	ciKw3g3enpa0WmC7kScRskvf9QyY9aATg+qIw6vc1Z72kqF8W5bVLlCahARYC7H+q4fuJdgCAjO
	VtvKV51agofawCX6AZcW7FKTdr3GmMhok9A6Ggvj4tXyWFW9crZWg24Dd/cftQS+G5/8nbf7QFL
	Ye0h6/kSVvMehvzkjntbQXiuBefj5/J+Xsg63NyZ9xi26noXgb6zGavO4SalQpZZKeaklABrLPA
	INFTbRe70U0e/AYz5/lQ4Hp4wnXFg5qwHERzulEGltNRb0RPNkk1cuCgmb90ajcDoMgeVKwLykQ
	Du10ZQBNWQK/lsHB0ResYODT5OMi2fO1nq3H9ecKK5KIA193JtWuYI5Wb9Cnd2sl0YJKs6mGoqm
	G3LQ0k/8zECYap9BwFPj2ipRw+XXogSFmS8mwrzie1DhsjCi9hMQP2mR3+KodxwwkavICYHilCv
	76hUvmkYxu7rtLb8kjT8YQS56MREv2XU4h0G8UVf39fOhVw+xD/l2sPYStusqieGnp9OkmrMi4w
	orqCP258sIKPRWw4amuMg5deuqfkTDO7BBNsDSzhVJ8Emv0uGoe/R3NOq2FFIvu52x36/z4i3OQ
	ntnRpBwY=
X-Received: by 2002:a05:600c:138f:b0:49f:cbf3:551c with SMTP id 5b1f17b1804b1-49fe66cc5camr135423255e9.12.1790407153438;
        Sat, 26 Sep 2026 00:19:13 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a2acb4dsm12171640f8f.0.2026.09.26.00.19.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 00:19:13 -0700 (PDT)
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
Subject: [PATCH 6.1.y] mm/hugetlb: fix avoid_reserve to allow taking folio from subpool
Date: Sat, 26 Sep 2026 09:19:09 +0200
Message-Id: <20260926071909.77553-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2025021023-plank-tribesman-b3f2@gregkh>
References: <2025021023-plank-tribesman-b3f2@gregkh>
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
  page-based HugeTLB helpers. The backport retains this stable tree's direct
  -ENOSPC return instead of importing the later out_end_reservation path;
  the functional changes otherwise match upstream. ]
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested against the current linux-6.1.y tip, 6.1.188:

- x86-64 QEMU, 2 MiB HugeTLB pages, at 1 and 4 vCPUs
- compared with the unpatched kernel, an extended version of the commit's
  fork/COW reproducer kept the child mapping alive during the parent write
  and changed HugePages_Rsvd after program cleanup from 5 to 4 and after
  unmount from 1 to 0
- parent/child data isolation passed and no kernel diagnostic was observed

 mm/hugetlb.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bfcb936084e85..d588426f011f2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1397,8 +1397,7 @@ static unsigned long available_huge_pages(struct hstate *h)
 
 static struct page *dequeue_huge_page_vma(struct hstate *h,
 				struct vm_area_struct *vma,
-				unsigned long address, int avoid_reserve,
-				long chg)
+				unsigned long address, long chg)
 {
 	struct page *page = NULL;
 	struct mempolicy *mpol;
@@ -1414,10 +1413,6 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	if (!vma_has_reserves(vma, chg) && !available_huge_pages(h))
 		goto err;
 
-	/* If reserves cannot be used, ensure enough pages are in the pool */
-	if (avoid_reserve && !available_huge_pages(h))
-		goto err;
-
 	gfp_mask = htlb_alloc_mask(h);
 	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
 
@@ -1431,7 +1426,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
 	if (!page)
 		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
 
-	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
+	if (page && vma_has_reserves(vma, chg)) {
 		SetHPageRestoreReserve(page);
 		h->resv_huge_pages--;
 	}
@@ -3114,17 +3109,6 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
@@ -3147,7 +3131,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	 * from the global free pool (global change).  gbl_chg == 0 indicates
 	 * a reservation exists for the allocation.
 	 */
-	page = dequeue_huge_page_vma(h, vma, addr, avoid_reserve, gbl_chg);
+	page = dequeue_huge_page_vma(h, vma, addr, gbl_chg);
 
 	if (!page) {
 		spin_unlock_irq(&hugetlb_lock);
-- 
2.53.0
