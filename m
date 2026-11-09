Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227556;
	b=le/yghcwuX6zc9SPjNUJDgFimmyXX9qdAEeyp2jAlRbFgpW+62ggeIv/MyFJ7qUPN1RS
	 xOOFxRuYyyqrMKxkDUeSMF2EUaQmJWGnHnJH8mXQDHmoOMMulmCqEOcc+OBkh1R2ZNPLe
	 UPljNoDkPxO6W2F9tzwYVAEo1wEseHATIbeAxvejPk4uoRHrvtMHTHUwQ9IXsgbTcQxm9
	 pjVgS4cyVPJFtI2V9s96zLLJWkO7wfLxIgemQUL+jCeqWzeRLFEGh9A7v3ZIarsKdYklV
	 S1eqMz1ocxIYEuWUzV0odqjkZYsCq1ht9MJmBI6jXmVbg4yW52r5snMb0Z+kOtBg3Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227556;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=udxm0MTbbrdZXwgUGf8nDE4esUDzC+N90hU7KZ64eOw=;
	b=NHMmtrMroeBgtZQJeqXFfRXXaZtKeV/OgIc2Oc9m/d+p3D3P3pbGQL1XHQ5wnCmxH4cT
	 XyV+aL9lK5ON/9mv6dku71MlTk7GqYwU5m/my4vaF9Jy8kG/NDDNXEvTPmakEPgXc3w/1
	 NQqMMtWOw0GVmJuvXo4p2qYPTIhP/x0SsDGV9eWNX4l2wnPP6d4XTwW15lmWULmL79pIH
	 WRvdVSfjR5IjZygxuWr7h9F0oEbvd8lMl4BAbig3AB68v90I5+sDuF7COgnl/ieGRCTNT
	 s4s/T314Im7a4IhrlN5LjGsjEA4VEq+il3DOgYgbSFGBbWeKRsR/3Km5ZITU1WwfrDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jVUw9NIZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45726083607;
	Mon,  9 Nov 2026 12:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45726083607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jVUw9NIZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E7F1516;
	Mon,  9 Nov 2026 04:32:30 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D685A3F632;
	Mon,  9 Nov 2026 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794227553; bh=QEIH/LF9UuKjHrGluytD0ntXd7KX++xnyDqOTz3eQxg=;
	h=From:Subject:Date:To:Cc:From;
	b=jVUw9NIZJQgWxyUNHKdc5Exo6aZc4V67EokCep5T4IuCtIkIYUkyvE6/dwyws9SRF
	 F4Q+MlU9oCT1yg6ZcQGut0uAj7EhqwWgdpFhM6VtJlZ3BIij13jiAL63Wbv4OXw2rw
	 BPaAPIpdz+wt4M2bhue6a4U2/Fwh4lMLlKexi9OQ=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 0/6] mm: gup: batch PTE-mapped large folios in
 gup_fast_pte_range()
Date: Mon, 09 Nov 2026 12:32:24 +0000
Message-Id: <20261109-refactor_gup_fast-v3-0-2aaef02df0e1@arm.com>
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
X-B4-Tracking: v=1; b=H4sIAFi98WoC/33PwU7DMAwG4FeZcibIjnHa7sR7IDSlbrLlsHVKR
 gWa+u64Q2IHVo5O/P3WfzU1lhyr2W6upsQp1zyedKCnjZFDOO2jzYPOxoHzCMi2xBTkMpbd/uO
 8S6FebM8cKXFHgzij7qwr+fOW+fau8yFX3f+6nZhwef0vbUILliLGxNz41qfXUI7PMh6X6B/nY
 M1J6hqHXRg8yQOHaw6AQyCtwch/Ha3e89D0DRC3Gv7rls6Tu/fUv0feqe8FgwC20tLL3c/z/A3
 MG92wmAEAAA==
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Yuan-Hao Hsu <aa9736195201@gmail.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4382; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=QEIH/LF9UuKjHrGluytD0ntXd7KX++xnyDqOTz3eQxg=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq8b1cwMlPTqUm+x5Hxjglzdl5JcKEFbgfCrTWS
 TJh461BZ/GJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCavG9XAAKCRBt1cPRWsUx
 M9Y3C/4/1RLK0kmQkgFGc/uX6lWK1ZEh6vA4r9A2qySbAcekJskXN3a0cqbYnYyZK6R/OWWD6uu
 56YEDOfgDN0kDoeNB2wrJjqUTis7CG1JdPT7Ab1Eeen4/M0XDlTHB8hmume5z+p/NWKWFEoCBMp
 0BaN0G45miLkLN58dHZk8xzeye/VLwmm7+KAkLfx3HvNDk/kQqoYrkSugMwQdvT0sFLf0mh5yFQ
 66Z5j5c5gZKnE3vSawjpSWJtkmsofclWDmfCn2gg7y0FnJLMMX8pESvnjpCJv9ZxevUVQVaUD+6
 uH6OoVZbyhZK7sHzA4HY8iM4iAnCttvb07jLW/XTlXIrz2OmemCuCkXOJlgspqrq7DPBgHGf9xd
 g3GAu5p0EAJjOU/LF19RLBIg5c+QlVNtky0OM8AKx7H9x7BCHb8Ppe5l5hViDX5UAxvc7dl0ybB
 yiF/kQbTOqnqo6gZ6zfwEwjdRteIBD1o71IFlwpedaWPrhU4S97zCqrxO/VI916q5CgCQ=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

GUP-fast grabs a PTE-mapped large folio one page at a time.  Every PTE
costs a try_grab_folio_fast() (a refcount cmpxchg, plus the pincount
atomic, a full barrier and a node stat update for FOLL_PIN), a
gup_fast_folio_allowed() and a folio_set_referenced(), so a 64 kB mTHP
pays sixteen of each and a PTE-mapped 2 MB THP pays 512.

The users are the hot ones: iov_iter_extract_user_pages() pins every
O_DIRECT buffer through pin_user_pages_fast(), io_uring registers its
buffers through it, and so does RDMA memory registration.
With mTHP those buffers are PTE-mapped large folios.

After the head page has been grabbed and verified, extend the run to the
following PTEs that map the next pages of the same folio with the
same protection bits, take the remaining references for the
run with try_grab_folio(), and fill pages[] from the run.
The PTEs of the run are read while the reference on the folio is held,
so the folio can neither be collapsed, freed nor split underneath the scan.

A read-only run of an anonymous folio stops at the first page that
gup_must_unshare() rejects, so the per-page exclusivity guarantee for FOLL_PIN
is kept.

folio_pte_batch_flags() does the scan.  It reads the entries with
ptep_get(), which is not safe without the page table lock on
CONFIG_GUP_GET_PXX_LOW_HIGH (x86 PAE, mips32, sh) or with arm64 contpte,
and GUP-fast reads every PTE with ptep_get_lockless() for that reason.
Add FPB_LOCKLESS to make the helper do the same; it is inlined per call
site, so the other callers do not change.

The order-0 path keeps its instruction sequence.  The folio flags are
tested before folio_set_referenced() on purpose: a load of the flags
right after that locked instruction cost about 25% on order-0 pages in
the gup_test benchmark below, and reading them first brings that path
back to the baseline.

gup_test ioctl over a 256 MB anonymous region, FOLL_WRITE, 65536 pages
per call, median of 15 runs, two baseline boots / one patched boot, on
an x86-64 VM:

                       get_user_pages_fast()   pin_user_pages_fast()
                       before       after      before       after
  4 kB pages           849/789 us   783 us     1174/1138 us 1094 us
  64 kB mTHP           812/811 us   126 us     1215/1113 us  188 us
  1 MB mTHP            799/774 us    59 us     1185/1077 us   64 us
  2 MB THP, PTE-mapped 803/786 us    57 us     1159/1120 us   58 us
  2 MB THP, PMD-mapped  42/40 us     40 us       46/41 us     42 us

fio O_DIRECT randread of a null_blk device (CPU bound) with the I/O
buffer in 64 kB mTHP, median of 15 five-second runs:

  bs=1M psync                 126.2/125.6 GB/s  ->  220.6 GB/s
  bs=1M io_uring, iodepth 16   71.2/71.6 GB/s   ->  112.1 GB/s
  bs=64k io_uring, iodepth 16  50.2/50.7 GB/s   ->   60.1 GB/s

IORING_REGISTER_BUFFERS of 1 GB, median of 15:

64 kB mTHP           6179/5998 us  ->  1599 us
  1 MB mTHP            5790/5801 us  ->   893 us
  4 kB pages           7173/6741 us  ->  6763 us

---
Changes in v3:
- move gup_must_unshare() and INTERNAL_GUP_FLAGS from internal.h to gup.c
- drop the folio_pte_batch_flags() patch for shadow-stack.
- ignore VM_HUGEPAGE for shadow-stack via madvise().
- add r-b / a-b tags.
- Link to v2: https://lore.kernel.org/r/20261102-refactor_gup_fast-v2-0-bc1ac018c834@arm.com

Changes in v2:
- fix exceptional case for shstk on x86.
- remove redendant check for pmd change in each pte barch.
- Link to v1: https://lore.kernel.org/all/20260917083747.786-1-aa9736195201@gmail.com/

---
Yeoreum Yun (5):
      mm: khugepaged: ignore MADV_HUGEPAGE for shadow stacks
      mm: gup: clarify a reason to check pte/pmd in gup_fast_pte_range()
      mm: gup: move gup_must_unshare() and INTERNAL_GUP_FLAGS to gup.c
      mm: gup: introduce gup_unshared_pages()
      mm: gup: batch PTE-mapped large folios in gup_fast_pte_range()

Yuan-Hao Hsu (1):
      mm: internal: introduce FPB_LOCKLESS for folio_pte_batch_flags()

 mm/gup.c        | 185 +++++++++++++++++++++++++++++++++++++++++++++-----------
 mm/internal.h   |  78 +++---------------------
 mm/khugepaged.c |   3 +
 3 files changed, 159 insertions(+), 107 deletions(-)
---
base-commit: b3710a1d0f145a4f6f1d44fdaff56a6af8cffe89
change-id: 20261015-refactor_gup_fast-b55e3f593dc2

Best regards,
-- 
Sincerely,
Yeoreum Yun

