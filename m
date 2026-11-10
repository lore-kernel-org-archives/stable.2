Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351192;
	b=u92Mlq+/ISQrSfshxCGwfCBQh1NLxKBFT4GN+8O2H8taXP1IOrkgO3Hq0xDWKFY/p5fP
	 VXRIg/mOpSSG2kiXYrUvoWYr+CxvH73SOreF4cBzPuHYxbQyf3dRjE9O1AvN4FKmwUtMr
	 rXake6vQNIzgYansQ109gTwIHIzbG2IW1VaLED7uF8TGhE+92G3Vu6zDUdl4Fw0PNw4v+
	 7yE4g9wQgtR4oMmr/Yu41kIfLDIK7Gq8DJEoZXpWhw5JexQtGpMPWz8gbdNJGfkscd1et
	 SagPFULA1uMBobtxZBaCSbJ6T6z1DuHqSTNf9wssK6VNAuBKUcvz+rqhVwCLZ+AC0Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351192;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Vk+N/BR3oq3dOLJw2HOby4lRjZ68GbiZNocZF2b8xsM=;
	b=Ji4Uap/4aSm/DWf7MfgWiNnWKVhs3USwXm7pk/Kms0Y/VJLQAdr89FjMVQ6cfahP+kGt
	 LXWoD7IGHa/rzG02kNPomtgFIORlp7apgSRAAE34UF3rpChK4L5cvPOdDugxYDzz8lSjf
	 03uodc6hfW1/H1xCzg3askrzeyCEit/333sh19GJSp2h5ZVr4ny9asMEPJVvvcod+lXjW
	 IDpUbaV7lRcwUzKwJNyhaoxydpbIYArAP2x9BOPnoy2a4XbBxPdkBWhXqFPOBAmqC3DuO
	 T0gfr6uMseYLM9wR3MU2YqqaEx2X7GrOrfoktVUnfnv8PkQDhIGxbXD1s4pheNMS1rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PLJx5l0t;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EE606A31C;
	Tue, 10 Nov 2026 22:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PLJx5l0t
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D0A51477;
	Tue, 10 Nov 2026 14:53:08 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4406F3F85F;
	Tue, 10 Nov 2026 14:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794351191; bh=QOvNQt7N495bFF4N6iQj4KiaBeii7WdXwg+ytvNzrWw=;
	h=From:Subject:Date:To:Cc:From;
	b=PLJx5l0tOqXX0R0L7sLJugk1Cw7QKcW5WN8nKQkRpIp332VdWteDv9BHVxJ9e7HDm
	 TJtio1zYRZUtbVw7xOhZnSqQ38AwDVy4fEDobpDbZKd8oWibr5W3WfctpbSgoFJad9
	 XNwEko7cmSOSeO4nYBZkT+57PJp1AhVftjuvdCks=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 0/6] mm: gup: batch PTE-mapped large folios in
 gup_fast_pte_range()
Date: Tue, 10 Nov 2026 22:52:50 +0000
Message-Id: <20261110-refactor_gup_fast-v4-0-e779a7674274@arm.com>
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
X-B4-Tracking: v=1; b=H4sIAEKg82oC/33PwU7DMAwG4FeZcibITua05cR7IDS5qbPlsHVqR
 gWa+u64Q2IgWo5O/P3WfzVFhizFPG2uZpAxl9yfdNg+bEw88GkvNnc6GwcuICDZQRLHSz/s9m/
 nXeJysS2R+ESN76Iz6s66kt9vmS+vOh9y0f2P24kR59f/0ka0YL2gJKIq1CE983B8jP1xjv5yD
 tZcTE3lsOEu+LjgcM0BELPXGoT01/nVewGqtgJPtYZ/u7nz6O499W/JO/VtRI6Adaz99rf3P32
 z5L16xywJXJdA8O6nafoEqEgWxNgBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4597; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=QOvNQt7N495bFF4N6iQj4KiaBeii7WdXwg+ytvNzrWw=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq86BR1knAjC59wruT++kV/bxr6upRF/f2+ltxo
 RrraiQUjkWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCavOgUQAKCRBt1cPRWsUx
 M5x0DAC/qwxIFe5vjUZkBHSXyu0tm2VuSW1bcyDPWN3fAFQmAYSz7Zl95yoXv53Wpuvf+/TcPH2
 VRF/P2yqrfp3Cu5PoqI8fBD3tx5fhOURvp0c+fzVo5NW58v31+iLxpscD8lbAwu23QABBrFKzIV
 EonpsO6m8rLfj+DjmfcjdVh0zRqgcAZ69GzbscuAoKtHo5A7fZPilIiteAY16WmGBxjCJ4oZY7t
 Br0I3vE/WprrRsxCi4Fby2i5hJN214MpAc/zKxNqrywdRSN6okV7eyTC9+1ID3XrFnt1+jYN92q
 XzwpQMrPNtjHHKrHHpAXTjq8FJB8RVXL0Hh27D+evRa3o0gbB3XyIqhf3bt9K9ri/I+QgkfCZ4k
 5ZG9DbessJ5uqwuh4R6m5xTGe4AAWPsH309H6DxkoXQ+we432Iz46CD9qOF7ZPCOgmSFbU9Zpgf
 xfs7wPQd4EWbYskMa9Z5KOeVS8opojMr23HYasBD8MwtULT9MCY4KQ+BXk6onWwh+LAzE=
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
Changes in v4:
- add r-b / a-b tags.
- rename gup_unshared_page() to gup_pages_not_requiring_unshare()
- Link to v3: https://lore.kernel.org/r/20261109-refactor_gup_fast-v3-0-2aaef02df0e1@arm.com

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
      mm: gup: introduce gup_pages_not_requiring_unshare()
      mm: gup: batch PTE-mapped large folios in gup_fast_pte_range()

Yuan-Hao Hsu (1):
      mm: internal: introduce FPB_LOCKLESS for folio_pte_batch_flags()

 mm/gup.c        | 185 +++++++++++++++++++++++++++++++++++++++++++++-----------
 mm/internal.h   |  78 +++---------------------
 mm/khugepaged.c |   3 +
 3 files changed, 159 insertions(+), 107 deletions(-)
---
base-commit: 93d7a816a2df3e907e2719bd12b0073f1285fc5c
change-id: 20261015-refactor_gup_fast-b55e3f593dc2

Best regards,
-- 
Sincerely,
Yeoreum Yun

