Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056680;
	b=0ZxoPQhEOpyHsnGSEDmJjgdEzFGtGxByVY9LRSG0/415ioY9hjHFOvBTIOi6oFqyPy/T
	 AKHdYKSVp++7pssxQSCiNkm0L3wFQqKHOTCX1SrAoFWxpKRE2XaQTHfqib83NfqVnAvVg
	 9dIvGhUsOVrCYCsiOOerlfkankAqTB3irGykFAPAYZ9IrIQbn3vD78lmyN55w1y3CWYFQ
	 GlOey1NIEBBtseF25VDuNQvunKsRkJQu6qRgw9deUhBymVQ/TONdxij/PTrTDGyOO3KOs
	 0eRgxfsYEI+S3F8VFhXDXSaGdLVWbs7+4oSVYkiaYIpoXv2np5D2U42K8erVG7kUEGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056680;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ayLTO25mv8hsmSbKJI2pgTaDpBZ/HN5CAIFHS8ZziNk=;
	b=yMRbsVUjJ5EnZVLa4xtc3xN3EH4UvnU/SPNVPgyMeY8u9GWEZOMbhfWcWpn0NLq8QJK0
	 Es3ivmOopfylVu6HUqF6tmgh/YfuZjHFNfRHzXFA0We08U81Z8EkAQ6gjWH0EYG+8aSQy
	 +nn+UnQK/9vkThvWTl5Pjgd3kvbz77X0+gONBcz7cku/b2cqBmUJNGJIQ+aEicG4bahk9
	 2veOUQx9V0uFwhr49WNX4dsJh0GzOs2A/sncn9AAx7cNoQTAlY6Wdk6ivXbWuP3xA1jDA
	 wCjDXQ8Xwe5F22ixWz1x6sQx1JsYqipmKgwTS5CacwhX0RvAML5clTNbEHIzVfA2vog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0btN4RF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE8606A31D;
	Mon, 26 Oct 2026 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c0btN4RF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7691F01825;
	Mon, 26 Oct 2026 23:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056679;
	bh=ayLTO25mv8hsmSbKJI2pgTaDpBZ/HN5CAIFHS8ZziNk=;
	h=From:Subject:Date:To:Cc;
	b=c0btN4RFNd+JK9rkuoTETc7VF6swnFyYz0/L+oSt8CLgeMxb0G2BDek2IJa55YHgH
	 jxflLIlpQ2WjGfXinmpmDcTPwOBNahVU3Fpt2SewilRmN+LtujcaoK9avQFbHhbqJn
	 AToCFd3ZAWENyki274UuV7Hrzyj3mkZx+lZBHJAgQM7sMTU2YygJXf/22VO7LBayGo
	 z1SiNI6qekyGCy9Qj3o0FBTBaCDVIkViGvV5TMESpQllEDQfyei0P9tTKvJQ0Me/gK
	 wyAA7x7FGyfUCmcqmTS1uQLx7441jdglWG11IvyD9a9d/vtZG2IIN5UFht4h5Bdhmc
	 BcrYLm+fhg8gw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/46] mm: various (urgent?) fixes
Date: Tue, 27 Oct 2026 00:17:20 +0100
Message-Id: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAIHf32oC/yXM3wpAMBQH4FfRubbapiSvIsnmjOMCnYOU9u6Gy
 6/fnxsEmVCgzm5gPEloXRJMnoGf+mVERUMyWG1Lo61RgS6Uzq+Myg2hLKrQB20LSION8UtTv2l
 /y+Fm9Pv7ADE+TOnff24AAAA=
X-Change-ID: 20261021-fixes_core-bdf638faf023
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6096; i=david@kernel.org;
 h=from:subject:message-id; bh=M759dBMTTuWvoyATaey2hLe92rKyKdXXWLH+ZXFHlx8=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu358o8+hoapKLufs0q+lpn12ZBLcv/3an4MwBsxfcD
 JVLS+V0OkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhI7S6Gf7r9S3UXX2XVt/qw
 JKtmldaMlmu2mzm5VXc2e62fdZhNyJrhn9WBe3v8/NPeHmqUd+L4lrf/+qQda2pP1TYyKv7KKbp
 1jA8A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Another set of fixes from the current batch that focuses on all core-mm
things that won't be sent out separately by others. I decided to bundle
these together as they are all over the place.

I have some hugetlb stuff in the works which is pretty horrible
(code wise ;) ), that I will send out once ready. Plus some
low-prio migrate_device oddities + two core-mm things that need more
thought.

This is the biggest set of patches coming from me, so don't be
scared ;)

Once more, some of the stuff is more urgent than others. No fixes are
crazy big and most are easy to review.

The majority are again fixes from Anthropic that I cleaned up or reworked.
While doing that, I found a bunch of other issues and tried to fix them
somewhat cleanly.

I gave it at least some basic testing on x86-64; more testing will be
highly appreciated.

This is based on akpm/mm-stable.

As with the shmem fixes, please prioritize review of these fixes, I want
to get fixes for the issues in a timely manner upstream.

Thanks to everyone helping out with moving the flood of fixes forward :)

---
Chris Mason (11):
      mm/huge_memory: fix truncate racing with PMD zapping
      mm/huge_memory: fix zapping migration entries for device-private THPs
      mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs
      mm/gup: fix clearing folios in memfd_pin_folios()
      mm/gup: fix out-of-bounds write for nr_pages == 0 in GUP-fast
      mm/mmu_notifier: set ->mm only after mmgrab()
      mm/memory: reject remote COW faults on PFN mappings
      mm: fix unkillable fault loop on MAP_DROPPABLE memory
      mm: fix deadlock of mremap() against UFFDIO_MOVE
      mm/ksm: check large swap-cache folios before mapping them
      mm/vma: call ->may_split() before a partial merge

David Hildenbrand (Arm) (20):
      fork: take mmap_lock before copying mm_struct
      mm/memfd: check for real shmem inodes before accessing shmem state
      mm/truncate: look again if a folio left the mapping
      mm/filemap: finish fault cleanup before dropping the fault lock
      mm/rmap: handle device-exclusive entries in folio_referenced_one()
      mm/huge_memory: fix list corruption when deferred_split_scan() races with deferred_split_folio()
      mm/huge_memory: properly handle refcounted PUD mappings on fork
      mm/khugepaged: check if PTE table is empty in try_collapse_pte_mapped_thp()
      mm/gup: recheck the PUD under PTL in follow_pud_mask()
      mm/gup: check for overflow when converting nr_pages to bytes in GUP-fast
      mm/userfaultfd: write-lock the VMA before waking waiters when unregistering
      mm/userfaultfd: wake waiters when registration modes are removed
      mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
      mm/mremap: recheck PUDs under the page table lock
      mm/madvise: fix data loss from MADV_FREE on a KSM page
      mm/ksm: reset the unstable trees of all nodes
      mm/ksm: fix use of a freed anon_vma at swap-in
      mm/huge_memory: split huge PUDs when adjusting VMA boundaries
      mm/vma: don't leak the charge for stack growth
      mm/memory-tiers: unregister empty tiers outside memory_tier_lock

Josef Bacik (14):
      mm/mglru: don't use stack pointers when walking PUD and PMD tables
      mm/memfd: make f_pos accesses atomic
      mm/filemap: read mapping->a_ops->free_folio under i_lock
      mm/filemap: don't lose a folio lock wakeup to a signal
      mm/huge_memory: fix livelock on device private folio
      mm/khugepaged: always recheck the pmd in try_collapse_pte_mapped_thp()
      mm/khugepaged: fix PMD table lock leak in try_collapse_pte_mapped_thp()
      mm/userfaultfd: wake all waiters on unregister
      mm/mmu_gather: fix flushing ranges with 4 GiB or larger
      mm/mmu_notifier: finish non-blocking interval invalidation on error
      mm/mremap: fix moving PUD leaves
      mm/memory_hotplug: avoid races in pfn_to_online_page() with dying pgmap
      mm: fix unmap_mapping_range() beyond 4 GiB on 32-bit
      fs/proc/task_mmu: refuse addresses beyond 32 bits on 32bit

Rik van Riel (1):
      mm/cma: don't release CMA pages still in use

 fs/proc/task_mmu.c            |   6 ++
 include/asm-generic/tlb.h     |   3 +-
 include/linux/huge_mm.h       |   5 +-
 include/linux/ksm.h           |   6 +-
 include/linux/memremap.h      |   6 ++
 include/linux/mmu_notifier.h  |   3 +-
 include/linux/shmem_fs.h      |   6 ++
 include/linux/userfaultfd_k.h |   2 -
 kernel/fork.c                 |  20 ++++--
 mm/cma.c                      |  10 ++-
 mm/filemap.c                  |  88 ++++++++++++-------------
 mm/gup.c                      |  53 ++++++++++-----
 mm/huge_memory.c              | 149 ++++++++++++++++++++++++++++++------------
 mm/hugetlb.c                  |  14 +---
 mm/internal.h                 |  28 ++++++++
 mm/khugepaged.c               |  77 +++++++++++-----------
 mm/ksm.c                      |  56 ++++++++++++----
 mm/madvise.c                  |   9 +++
 mm/memfd.c                    |  10 ++-
 mm/memfd_luo.c                |   2 +-
 mm/memory-tiers.c             |  29 ++++----
 mm/memory.c                   |  30 ++++++---
 mm/memory_hotplug.c           |  13 ++--
 mm/memremap.c                 |  13 ++++
 mm/mmap.c                     |   8 +--
 mm/mmu_notifier.c             |  24 +++++--
 mm/mremap.c                   | 103 +++++++++++++----------------
 mm/nommu.c                    |   2 +-
 mm/rmap.c                     |  23 +++++--
 mm/shmem.c                    |   5 ++
 mm/swapfile.c                 |   3 +-
 mm/truncate.c                 |  17 ++++-
 mm/userfaultfd.c              |  72 ++++++++++----------
 mm/util.c                     |  13 ++++
 mm/vma.c                      |  24 +++++--
 mm/vmscan.c                   |   4 +-
 36 files changed, 588 insertions(+), 348 deletions(-)

---

base-commit: 183895979c441e52dbd651b388553b09eaa35cfa

change-id: 20261021-fixes_core-bdf638faf023

--

Cheers,

David

