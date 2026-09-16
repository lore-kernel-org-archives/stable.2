Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E724AB3B5;
	Wed, 16 Sep 2026 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789601946; cv=none; b=tHiezyuVojdQ9nB/oJOli16Ez2wm4bzJF30+wighKXKF57gPq2P7Q9TodiK2zxakSjU4xiuKsJZyvF93R9Upp5Mas1/0VI6fW1s2QbLYdLPLKgCtYJjJ+3kk1Tkpq/gkFMxyeoG20LorXfZeTTrONIc5bEPyi8qD6zQKGPbZolU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789601946; c=relaxed/simple;
	bh=Dswu9zsCEsbMKYUfI58iswHURG052TIHJ8r8CFIpEHY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uRR+hHNuTiKeArATee20GIcLzYx+DEl7h2mkFPqt/tEOOQoQ7JdsuYqm/5c5a4RmEQ+t5wqrAUIaSP7gj0EYsdTx/AX7qPR368gICB7I61utpE09lpL9Eyoft2529W1NRRUa4Ic9H1nl3dobUA5Cx5YQqmt3P5fiT0ZsvTy7VNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLHXdzls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLHXdzls"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12F63C2BCB3;
	Wed, 16 Sep 2026 23:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789601946;
	bh=Dswu9zsCEsbMKYUfI58iswHURG052TIHJ8r8CFIpEHY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YLHXdzls85mYvdXkRJNcF/o48MWZ20lilprXr12ykvF32U3l3NRdZ8IU+mmTg1etc
	 Y87xAyQlx4VfwFnIa/sWfPc6TDmrEfV74A3/696vyZRnarWHNheV5Q6lIypONyUuuR
	 7zM4nUx/9jkVqgmSAOKougYHAhpZsLnj0YZU/3RMljbzFJx80VJqFi5y8khPHSBTTn
	 CztVeBkOrDQ+e31Kkc2mPfIpq/1+Zq8v1d/bX6fMq3D1AWHDqN4GGnkq/7ivhHOOOy
	 ij0NE6GosTqxdW0OTDvkYg1ifcyEglpgl9vOhmgIl9w+V/o4sFXsDCeK3SEQ400Bz9
	 uf5E4GdunPfGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB48FC982CC;
	Wed, 16 Sep 2026 23:39:05 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Subject: [PATCH v3 0/4] Fix HugeTLB subpool used_hpages tracking
Date: Wed, 16 Sep 2026 16:39:00 -0700
Message-Id: <20260916-hugetlb-subpool-always-track-used-v3-0-38aae9b5ccdd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJQoq2oC/5XNOxKCMBSF4a0wqb1OHry0ch+ORUguISMSJgGUY
 di7gUo7Lf9TfGchAb3FQM7JQjxONljXxRCHhKhGdgbB6tiEU57TE+XQjAaHtoIwVr1zLcj2Kec
 Ag5fqDmNADTznaZnSOlW0JNHpPdb2tX9cb7EbGwbn5/1yYtv6jz4xoKCRKc3SShdMXIxzpsWjc
 g+y8RP/JE+/kDySgqpMl6LKCi6/yHVd3216AbQmAQAA
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
 Yanteng Si <si.yanteng@linux.dev>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, fvdl@google.com, 
 jthoughton@google.com, rientjes@google.com, vannapurve@google.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Ackerley Tng <ackerleytng@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789601945; l=4449;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Dswu9zsCEsbMKYUfI58iswHURG052TIHJ8r8CFIpEHY=;
 b=tZ5c/LelNfH0teOFwwHcB+51dSHMOtfpAUHlSeNCULgokAeR1g0kBdwQSqAZfMj00+/z7/nIh
 plRVYhBRjP3A1V4VddwNUHRPIXQLEzxqYuZdALb0T7kNNMz42q6PGNa
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

HugeTLB subpools currently only track used pages (used_hpages) when a
maximum size limit (max_hpages) is configured on the mount.

This breaks minimum size (min_hpages) guarantees. The subpool guarantee
requires that the sum of used pages and remaining subpool reserves
satisfies the configured minimum:

  used_hpages + rsv_hpages >= min_hpages

where used_hpages includes both allocated folios and active reservations.
Therefore, when pages or reservations are released, the maximum number of
reservations the subpool can absorb is:

  limit = max(0, min_hpages - used_hpages)

When a mount specifies a minimum size guarantee without a maximum limit,
used_hpages is untracked and remains zero. The subpool assumes limit ==
min_hpages, falsely restoring reservations to the subpool even when
existing usage already satisfies the guarantee.

This series addresses three problem areas resulting from untracked usage
and asymmetric error handling:

1. False restoration and premature subpool freeing (Patch 1):
    + Global reservations (resv_huge_pages) are not decremented when
      reservations are released, depleting available huge pages host-wide.
    + On unmount, subpool_is_free() checks (rsv_hpages == min_hpages).
      Because of the false reservation restoration, this evaluates to true,
      freeing the subpool while folios are still active in the page cache
      and causing a use-after-free when they are later released.
      (See Patch 1 for a detailed step-by-step trace.)

2. Reservation rollback races and underflow (Patches 2 & 4):
    + On hugetlb_acct_memory() failure in hugetlb_reserve_pages(), the
      error path manually calculates rollbacks using local variables.
      This is race-prone when concurrent threads interact with the
      subpool, risking reservation leaks or counter underflows.
    + On region_add() failure, prematurely releasing global reservations
      forces error cleanup to attempt fresh allocations that can fail
      under memory pressure.

3. Subpool usage leak on allocation failure (Patch 3):
    + In alloc_hugetlb_folio(), when folio allocation fails and
      gbl_chg == 1, the cleanup path skips hugepage_subpool_put_pages(),
      permanently leaking used_hpages.

Always tracking used_hpages establishes a single source of truth within the
subpool. Allocation and reservation error paths can now handle failures
symmetrically: return the full page count to the subpool via
hugepage_subpool_put_pages(), and rely on its return value to reconcile
global reservations with hugetlb_acct_memory().

This series is a subset of patches from [1] and replaces [1].

[1] https://lore.kernel.org/all/20260722-hugetlb-alloc-failure-fixes-v4-0-88e8b81970dc@google.com/

Tested:

+ Reproducers (see below) pass
+ tools/testing/selftests/mm/ksft_hugetlb.sh passes
+ libhugetlbfs tests pass

Changes in v3:

+ Rebased on 7.3-rc3.
+ Picked up Reviewed-bys.
+ Rename resv_get_accted to resv_get_accounted as Joshua requested.
+ Now Cc-ing stable on patch 4.
+ Moved trace of a false reservation restoration from cover letter into
  patch 1.

v2: https://lore.kernel.org/r/20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com
v1: https://lore.kernel.org/r/20260902-hugetlb-subpool-always-track-used-v1-0-de1cd14bd713@google.com

Get reproducers from:

https://github.com/googleprodkernel/linux-cc/commits/hugetlb-subpool-always-track-used-with-reproducers-v3

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
 mm/hugetlb.c                                       | 142 +++++++++++----------
 5 files changed, 85 insertions(+), 97 deletions(-)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260902-hugetlb-subpool-always-track-used-2624840f4c08

Best regards,
--
Ackerley Tng <ackerleytng@google.com>


