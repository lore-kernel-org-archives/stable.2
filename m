Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E250A45D5E3;
	Wed,  9 Sep 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990579; cv=none; b=GeclajELSop/Mk1dWl2Y1wDhQwE829JaVrUXzI/FXj7Uc01tjsDkatpgy2e0yNAuxKDwEOp3ET/6B8ojUotqTGEj0Wq1qgSsb4zDYuIxeVk1GvTf41iP6lTSULteuXarMW9Pojku5zIkn3eCfFPP7gW/Qz9myUkDVU42NgiBaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990579; c=relaxed/simple;
	bh=9MpyGWIxUngkFXBOPjetH4RYkQ+9UxFhMjL5z4190vg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VYcw0u2ao4ayU5+BtX0LKqhfoTKikIUDPJKXgGxkXeEpX/7xR2GV3M7s0WzKG3Sl8ZySTDa98255k7Vmj2DHfPvSbYwaOdK/Wu92GW7fEDNLYfFu1OwR8tOCsxmHcFypM5aG0swBaYYrGDMDgggWXTRlAbIW1K8WhzbszIv8bJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkQC/KRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkQC/KRr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD5E2C2BCB9;
	Wed,  9 Sep 2026 21:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788990577;
	bh=9MpyGWIxUngkFXBOPjetH4RYkQ+9UxFhMjL5z4190vg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=gkQC/KRr5M9eb3CXKh1pFzjIhQjYdVLCRNaTJVXdryUuiOKHR9xdZXMJkiJciScXV
	 4pidhzLqEpzMP5s9Xw6POiMWEtRz1BdEJ+hli2DtlObfuswoHDxbyEgvGKdwBLbUIW
	 7lw7eMsgq98eJw4nlq/93kgXY1O8B5+AXJ5/L5COfbLiREHh/xvwH2gFIZLEscM/Ni
	 9vUvuhPla/yKnihOGXUhGrnQzF5BXchL09D9JPe6PJxKSDfH0s0vwxCpHwnef8L/GS
	 kt4h15qVx6ywIRTNpDgEnXeWryIylI2yDraLIvS17EQFoBOFcuU3Q1t7fSKkUOTh9V
	 c56pSDyGXBB3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1CC79FB6;
	Wed,  9 Sep 2026 21:49:37 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Subject: [PATCH v2 0/4] Fix HugeTLB subpool used_hpages tracking
Date: Wed, 09 Sep 2026 14:49:25 -0700
Message-Id: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGXUoWoC/5WNQQ6DIBAAv2I4dxugxNqe/EfjAWFFUiqGVVtj/
 HupP+hx5jCzMcLkkdi92FjCxZOPQwZ5Kpjp9eAQvM3MJJclv3EJ/exwCi3Q3I4xBtDhrVeCKWn
 zhJnQgiylqhTvlOEVy50xYec/x+PRZO49TTGtx3IRP/tPfRHAwaIwVqjWXsWldjG6gGcTX6zZ9
 /0LvU/MwtMAAAA=
X-Change-ID: 20260902-hugetlb-subpool-always-track-used-2624840f4c08
To: Alex Shi <alexs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Hongxiang Lou <louhongxiang@huawei.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Peter Xu <peterx@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
 Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
 rientjes@google.com, vannapurve@google.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Ackerley Tng <ackerleytng@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788990577; l=7030;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=9MpyGWIxUngkFXBOPjetH4RYkQ+9UxFhMjL5z4190vg=;
 b=2mY/vjTdLF0f8ExceLHlruHjV16Yg/8F5fthq5IUc4Zvg5MAXGlEEuXzOsxThqB6Wlzirq3kp
 9jAopCxFgbHAJHrDM1GJIrc3eGI6MgrcEFEb/fC07JsEJffr4f/7+O/
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

HugeTLB subpools currently only track used_hpages when the user configures
a size limit.

This is buggy since when there are existing allocations from the subpool
that would have satisfied the minimum reservations,
hugepage_subpool_put_pages() will still restore a reservation to the
subpool. See below for an example of a false reservation.

In addition, the subpool is considered free prematurely, is freed, and this
ends up causing a use-after-free.

The fix is to always track used_hpages within subpools, which is also
beneficial in general because with that information, reservation tracking
is also fully managed within hugepage_subpool_put_pages().

The invariant is that now (if min_hpages is requested),

  used_hpages + rsv_hpages >= min_hpages

This allows hugepage_subpool_put_pages() to always be able to report how
many reservations it can absorb and hence return an accurate number of
reservations to be returned to the global pool.

Hugepage reservations and restorations can always happen in parallel, so
relying on local variables to compute whether to restore to the global pool
(on allocation failure) is not safe.

There is complexity and some bugs in hugetlb_reserve_pages() and
alloc_hugetlb_folio() failure handling paths.

+ In hugetlb_reserve_pages(): On hugetlb_acct_memory() failure,
  out_put_pages manually calculates how many pages to return using local
  variables, which is race-prone and can leak reservations or underflow
  global counters.
+ In alloc_hugetlb_folio(): When allocation fails and gbl_chg == 1,
  out_subpool_put skips hugepage_subpool_put_pages(), permanently leaking
  used_hpages.

By tracking used_hpages in the subpool, these allocation/reservation paths
can handle failures by consistently returning pages to the subpool, and
relying on the return value to restore reservations to the global pool.

This series changes subpools to always track used_hpages, which itself
fixes the false reservation bug, and then uses used_hpages tracking in
subpools to fix other bugs.

This series is a subset of patches from [1] and replaces [1].

[1] https://lore.kernel.org/all/20260722-hugetlb-alloc-failure-fixes-v4-0-88e8b81970dc@google.com/

Tested:

+ Reproducers (see below) pass
+ tools/testing/selftests/mm/ksft_hugetlb.sh passes
+ libhugetlbfs tests pass

Changes in v2:

+ Add patch 4 to avoid a possible page allocation in the cleanup path of
  hugetlb_reserve_pages(), addresses Sashiko's comment on v1.

v1: https://lore.kernel.org/r/20260902-hugetlb-subpool-always-track-used-v1-0-de1cd14bd713@google.com

I have reproducers, get them from

https://github.com/googleprodkernel/linux-cc/commits/hugetlb-subpool-always-track-used-with-reproducers-v2

Here's an example of a false restoration:

1. Mount time
    + spool->min_hpages = 1 (user requested min_size=2M)
    + spool->max_hpages = -1 (no maximum size specified)
    + spool->rsv_hpages = 1 (reserve min_hpages)
    + spool->used_hpages = 0 (not tracked when max_hpages == -1)
    + h->resv_huge_pages = 1 (reserved by hugetlb_acct_memory(h, 1))
2. Shared mapping of 4MB (2 pages) created (mmap with MAP_SHARED)
    + In hugetlb_reserve_pages(), region_chg() finds chg = 2 (pages 0 and 1
      need reservations)
    + hugepage_subpool_get_pages(spool, 2)
        + spool->rsv_hpages = 0 (consumed the 1 subpool reservation)
        + Return 1, since this subpool only had 1 reservation
    + hugetlb_acct_memory(h, 1)
        + h->resv_huge_pages = 2 (incremented from 1 to 2 for the global
          reservation)
        + region_add() records reservations for pages 0 and 1 in the inode
          resv_map
3. Process touches and populates Page 0:
    + hugetlb_no_page() calls alloc_hugetlb_folio()
    + Page 0 reuses the existing reservation (vma_needs_reservation()
      returns 0 => map_chg = MAP_CHG_REUSE = 0)
    + hugepage_subpool_get_pages() is not called (map_chg == 0)
    + dequeue_hugetlb_folio_nodemask() consumes 1 reservation:
      h->resv_huge_pages--;
    + h->resv_huge_pages = 1 (decremented from 2 to 1)
4. Process closes the file and exits:
    + For MAP_SHARED mappings, reservations persist in the inode resv_map
    + Page 1 reservation remains active
    + h->resv_huge_pages = 1 (retained for Page 1)
5. File is truncated to 2MB (truncate -s 2M):
    + Truncation invokes remove_inode_hugepages() for page range [1,
      LONG_MAX)
    + Page 1 was never faulted into page cache => freed = 0
    + Calls hugetlb_unreserve_pages(inode, 1, LONG_MAX, freed = 0)
    + region_del() removes Page 1 from resv_map => chg = 1
6. Inside hugetlb_unreserve_pages(): hugepage_subpool_put_pages(1)
    + delta = chg - freed = 1 - 0 = 1
    + Because spool->max_hpages == -1, spool->used_hpages always = 0
    + spool->used_hpages < spool->min_hpages => 0 < 1 => true
        <<== subpool assumes 0 pages are in use, ignoring allocated Page 0
    + spool->rsv_hpages + delta <= spool->min_hpages => 0 + 1 <= 1 => true
    + spool->rsv_hpages += 1 => spool->rsv_hpages = 1
        <<== false reservation restored to subpool!
    + Return 0 (subpool absorbed the reservation)
7. Back in hugetlb_unreserve_pages(): hugetlb_acct_memory()
    + hugetlb_acct_memory(h, -0) => does nothing
    + h->resv_huge_pages = 1 (remains 1, not decremented)
    + Both reservations have ended (Page 0 allocated, Page 1 truncated),
      but h->resv_huge_pages remains stuck at 1
8. Later during unmounting:
    + subpool_is_free() checks spool->rsv_hpages == spool->min_hpages => 1
      == 1 => true
    + Because spool->rsv_hpages was falsely restored to 1, the subpool is
      erroneously considered completely free
    + hugetlb_acct_memory(spool->hstate, -spool->min_hpages) decrements
      h->resv_huge_pages by 1 (1 - 1 = 0), masking the leak on unmount
9. If the folio outlives the inode, when the folio is freed (Page 0),
   free_huge_folio() will read subpool from the folio and act on it =>
   use-after-free and then double free

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (4):
      mm: hugetlb: Track used_hpages when getting/putting pages from subpool
      mm: hugetlb: Fix out_put_pages subpool reserve calculation
      mm: hugetlb: Fix subpool usage leak on allocation failure
      mm: hugetlb: Avoid re-allocating global reservations on region add failure

 Documentation/mm/hugetlbfs_reserv.rst              |  17 +--
 .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |  11 +-
 fs/hugetlbfs/inode.c                               |   8 +-
 include/linux/hugetlb.h                            |   4 +-
 mm/hugetlb.c                                       | 147 +++++++++++----------
 5 files changed, 90 insertions(+), 97 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260902-hugetlb-subpool-always-track-used-2624840f4c08

Best regards,
--
Ackerley Tng <ackerleytng@google.com>


