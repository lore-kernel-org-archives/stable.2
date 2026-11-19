Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095890;
	b=Fw18VbjXJjVxOZ3XRUsdz81kOPdjQN+3rl7OXNxWBCMPWakzly1hG6rD0AbLCf4MzQIO
	 tTqdeC83Yzj5phV5AGPV1cBlsRz5EdGbRJqy5khzOs/zR4o22t1wJFBRvc7+WtM7ohj8d
	 H/H+YejwhCzJ+UvcLsSLYO0VpsavyjiRUqUg47VzPm1hooocFSNUCuZZcerLt4PNWgSg3
	 GT2v1B+ALJ7M3bVPo2Id16K8cCIWdO3+9hBy6UDBP8j5uu4AEfiL1kT11fKXyYvmh+gOb
	 WVK6jGFdEOSMIW2JArOq9dDDicPbVCmQUFmMIThkfqjSQg7PI2pyjVNY7I6PsqgfaaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095890;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dZ8lvCFTu0O9FoidI/X/pRCQPikMWlHxxoOJ5DRMpU8=;
	b=mkNIlA5zk6YB28gSKkawDbDfKA7h76g73pJCeyLaiIBATw4WrdRppylzL+phIQeCo3PH
	 NV/oNDeEl7Tt9QfJ+Vgt8mC2+/lDe3nJqWTaoqn1tjwCcc+AbTlC/FWHfi7E2hk/z51r4
	 roneOCZHuCqDxf4ASN/w0x5ft0wkhgzxe6czUnWf6BR5oKIOn5/fk3DiGd+F8iWVKfyqP
	 8kPRheLqpBPEazF7PoMWTe3SUJCALkVAGjjzEGyLAOzuSbTad+CsrW6aRlsYVfwziYpPZ
	 EHQs62bxcIaItzTPWC8s+siV4490ZMSCXx/zuMmfPrT/wuy0W5W4OT+B7eg7xE0ebhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=virtuozzo.com;
	spf=pass smtp.mailfrom=virtuozzo.com;
	dkim=pass header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=jbfWT5bX;
	arc=none smtp.remote-ip=130.117.225.111
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F7C606A33B;
	Thu, 19 Nov 2026 13:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F7C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=jbfWT5bX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
	:From; bh=dZ8lvCFTu0O9FoidI/X/pRCQPikMWlHxxoOJ5DRMpU8=; b=jbfWT5bXgutEbmcQBEn
	hFLznr6zAek7ILMK6chMHNklLEn2FwPK+GS/9DnPKBgiw+xwBbge3ZuSq34FFIycJpiWXjY0p9sYH
	f5nXr9BB3ite5stMOa3UFNKwTgU/GO/8j/enuI3WINEOjf+YerjkSsn3xHeq0WJx0oZvRlelRhE6b
	0z2nX0fN+6EkvYUm+DRmFKVCcWa2mIO5a/b4r6bm3pDzjyMxkptynTj8ZhKk8J5XA5YBtiGaj/arh
	iksEu7JwLVYCjeG4Yt/+ow92aZRf5V7R07wH9niPoKAdP1mYB9+oCgtoCwxu7vnV/skeBvwBbibrS
	HH9I6FDqg3nZsEA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xU2R4-00FBqZ-2B;
	Thu, 19 Nov 2026 14:44:22 +0100
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v6 0/4] mm/huge_memory: copy PMDs at fork like the PTE path
 does
Date: Thu, 19 Nov 2026 14:44:01 +0100
Message-Id: <20261119-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v6-0-efa7817a2bb3@virtuozzo.com>
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
X-B4-Tracking: v=1; b=H4sIACH9/moC/63PTU7DMBAF4KtUXjPIdmzHZcU9EKri8bgx0CbKj
 0Vb5e7YZQFCWZUu32g035sLG2mINLKnzYUNlOIYu2MO5mHDsG2Oe4Loc2aSSyO4UOAU9AP1kMa
 pG0CorVU1YNefdu28p11/8DAQtoTvMPaEsfmAMnM+1BScERIly8fzjRA/r/DL63ceZ/dGOBWtb
 LSxCKdrsyTK3r9LJAECvJQaDXdYCfOc4jDN3fncPWJ3YKVIkvehJHAgoZVV1obG2DWqug9VZcp
 qagitEnVY/Ur9oqS4mVKZMiZw7upGG4VrlP6hBL/9K50p1MZzL03Y1vwvtSzLF6Vubne+AgAA
X-Change-ID: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10365;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=l19IMOEaAgp+OXpSpDR6WQLceVX81e8fKiEF0I+rNKI=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq/v02LvsWBXpdzLMp866c1LiqFSiIqq+RvN/U/
 D9Ax3zbmdyJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCav79NgAKCRBRlgpH+WFc
 KsmID/0WbWFh3UfvfbuV0t7w+nHgEjkWJ9GTxIFNGD4K8CPfh6ZY38jIKMuxip99vdHTqgtA+yZ
 hUXufIYX9YMCib8XrmXYHbWHh/sw9RPIgHfjekgOzguUx+lnkhweb1ouF+Ly8WWHEoAvTqXNJNR
 qwvRNDnSTGVN5inCs1ZU0cH4SHzvKFJpyAZzj1DHDYQSov/2jeQthS0BKzQOvP1eLCEBqRNDdg3
 jtWiUMEwoKEcT/cCP3xiV/u/FqrxpCw7f2cg59IcrcF+bNMGCk9VdNrpIvp/WJQhSn6kUuCJ+C/
 mj/6znfnsjQtUKpWd2XH96zbvI207Id/p8uSOLalyOnB5Ft4n+ZBp3yzJPzpTZqWo+29yJQHa2G
 rJux8rk6aciguFtV8EyzpT78P+mWWBhqNahmn7yYh1uyldKS2yP1DDD9mCQP4LWWjXrTGJ1umTP
 6sswxXYlDXZEobafv24Var8l0lUqdFv4bD4WmK1YLMk9ztuUNdmv3k6LoqlzV6adl1D1qRT3dfB
 oh1mH2ClOp49Ng/1/Jscy0nMPdVjIC1+jIc7dU/9NQafJYKKL9lGX+02D+b2OECqtWrR2NaoPtH
 9KQVupXouXjuXMw4icV9pipWTnocSkNlUVzk5R1WaaCJLqbe3UKf8yZKgJh6Bwu/fS0wsLK115L
 Mp9c+8GubJ3yDzA==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

v6 is rebased onto mm/core for-next, as David asked, and patch 2 was
finished on the way: it now checks the page cache refcount limit before
it copies a file folio, as copy_present_ptes() and copy_huge_pud() do
since the refcount overflow fixes. So patch 2 changed after the
Reviewed-by tags it carries.

copy_huge_pmd() decides what to copy at fork by its own rules, apart
from copy_present_ptes(): a lockless check for special PMDs, and a skip
of every file THP. Following David's review of v3, this series makes it
decide the way the PTE path does, under the page table lock, with
vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
patches:

1. folio_dup_file_rmap_pmd() duplicated a PMD mapping as HPAGE_PMD_NR
   PTE mappings. It had no caller until patch 2.
2. File THPs are copied at fork instead of being refaulted by the
   child, as their PTEs would be.
3. The special-PMD read moves under the lock. That closes the race with
   a driver zap (vfio-pci, panthor) and the missing page table deposit
   on ppc64 hash that Sashiko found in v1.
4. A selftest for 1 and 2.

Stable
======

The race (since v6.12) and the ppc64 hash NULL deref (since v7.1) are
fixed in patch 3, which only works on top of the copy rework in patch
2, and patch 2 is the first caller of the helper patch 1 fixes. So
patches 1-3 carry Cc: stable, as David suggested on v4. Patch 2 needs
folio_ref_count_over_limit() from 26b8f029ce522 ("mm: limit pagecache
folio refcount when mapping pages"). They will not apply to 6.12 as
they are, I will do the backports.

The related refcount bug in copy_huge_pud() for device DAX is fixed
in for-next by d90bdc02e36ec ("mm/huge_memory: properly handle
refcounted PUD mappings on fork").

Testing
=======

v6 on mm/core for-next (v7.4-rc3 based), x86_64 with 4 NUMA nodes, the
series with CONFIG_DEBUG_VM, KASAN and lockdep:

- fork_file_thp (patch 4) skips on for-next, where fork leaves file
  THPs to a refault, and fails in both cases without patch 1, where
  ShmemPmdMapped drops when the child exits and the kernel reports
  "Bad page cache";
- with the series it passes, also under migrate_pages() of the parent
  and under reclaim in a small memcg, where some runs skip; with other
  processes churning PMD-mapped shmem it passes or skips, never fails;
- cow, guard-regions, uffd-unit-tests, uffd-wp-mremap,
  split_huge_page_test, mremap_test, soft-dirty, pagemap_ioctl,
  migration, madv_populate, transhuge-stress and khugepaged pass as on
  for-next.

The runs below are from v4, on v7.3-rc7 in a KVM guest with 4 vCPUs,
x86_64. Patches 1-3 changed since only by the device private CoW check
and the refcount limit check.

Race with a driver zap. The guest's QXL device is bound to vfio-pci in
no-IOMMU mode, BAR0 of 64 MB mapped with PMDs. The reproducer, in the v5
cover letter, forks while a second thread clears PCI_COMMAND_MEMORY
through the vfio config region after a random delay of up to 1 ms; the
child waits for the write to finish and reads one byte of each 2 MB of
the BAR. A child that reads anything without SIGBUS kept a stale
mapping. I have not hit it without help, so a test-only debugfs knob
adds an mdelay(2) between copy_pmd_range()'s lockless pmd_is_huge() and
the PMD locks:

  +-----------------------+-------+-------+----------------+
  | kernel                | delay | forks | stale children |
  +-----------------------+-------+-------+----------------+
  | 7.3-rc7               | none  | 20900 | 0              |
  | 7.3-rc7               | 2 ms  | 150   | 128            |
  | 7.3-rc7 + this series | none  | 3000  | 0              |
  | 7.3-rc7 + this series | 2 ms  | 400   | 0              |
  +-----------------------+-------+-------+----------------+

Ritesh tested v5 on ppc64 in hash mode: without the series the child
dereferences a NULL table in __hash_page_thp(), with it it does not.
Before that, on x86 a test-only hack made arch_needs_pgtable_deposit()
true and mremap move the table, as on ppc64 hash. Without the series
the first child of the reproducer oopses at exit in
pgtable_trans_huge_withdraw(); with it the reproducer and the mm
selftests pass.

Cost
====

fork() now copies file THPs instead of leaving them to a refault, which
costs fork() a reference, an rmap update and a counter per huge PMD and
saves the child a fault per huge PMD it touches. fork() of a process
with 4 GB of shmem THPs mapped MAP_PRIVATE and an anon_vma on the VMA,
x86_64 bare metal with 4 NUMA nodes, the benchmark bound to node 0,
both kernels v7.4-rc1 (v5) with the same config, medians of 2000 forks,
range over the rounds; the exec is of /bin/true:

  +-----------------+------------+-----------------+--------------+
  | kernel          | fork()     | child reads all | fork()+exec  |
  +-----------------+------------+-----------------+--------------+
  | v7.4-rc1        | 135-141 us | 3820-4036 us    | 559-567 us   |
  | v7.4-rc1+series | 429-440 us | 1007-1036 us    | 1190-1226 us |
  +-----------------+------------+-----------------+--------------+

A child that execs right away, or touches little, pays about 0.3 us per
huge PMD for the copy and the teardown. One that faults a PMD in itself
pays about 1.8 us for it, so the copy wins once the child touches more
than about a sixth of them.

Only a narrow case pays it, a file THP that is:

- mapped MAP_PRIVATE;
- in a VMA written to at least once, so it has an anon_vma;
- a PMD-sized folio in the page cache, mapped by one PMD;
- itself never written to.

For example:

- a big data file mapped MAP_PRIVATE that is mostly read and patched
  in a few places;
- a private mapping of a memfd or tmpfs file.

Notes
=====

- drm_gem_shmem and mshv_vtl map special PMDs with
  vmf_insert_pfn_pmd() as well.
- copy_huge_pud() still differs from the PMD tail in that it does not
  mark a shared PUD clean in the child or handle uffd bits.

The reproducer is in the v5 cover letter:
https://patch.msgid.link/20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com

Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
Changes in v6:
- Rebase onto mm/core for-next (David).
- Patch 2: do not copy a file folio over the page cache refcount limit,
  as copy_present_ptes() and copy_huge_pud() now do; fail fork() with
  -ENOMEM only in a VM_MIXEDMAP VMA.
- Based on mm/core for-next, which still has read_pmd_pagesize(), so
  patch 4 keeps it; on mm-new it needs s/read_pmd_pagesize/pmd_psize/,
  as Jose noted on v5.
- Collect the tags from v5, Tested-by from Ritesh on patch 3.
- Cover: new Cost table, measured on bare metal with a fork()+exec
  column, and the cases that pay for the copy (Andrew). The reproducer
  is only linked now.
- Link to v5: https://patch.msgid.link/20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com

Changes in v5:
- Rebase onto v7.4-rc1.
- Patches 1-3: Cc: stable (David, Lorenzo).
- Patch 1: drop the list of consequences, the helper had no caller
  (Zi Yan).
- Patch 2: the device private write path gets the CoW check of
  copy_nonpresent_pte() (David). Drop fuse DAX as the example of
  VM_MIXEDMAP, it no longer sets the flag. Say on the Cc: stable line
  that the next patch needs it.
- Patch 4: up to three attempts, each on a fresh file. Fail only if
  every attempt sees ShmemPmdMapped drop by exactly the parent's share,
  pass on the first clean one, skip if none is clean: other processes
  change the counter and reclaim or migration take PMDs from the parent
  (Kiryl). Keep every mapping until exit: after the bug, an unmap
  drops the counter once more, which hid the bug from the second case.
  Use check_huge_file(), check_huge_shmem() is gone.
- Cover: v5 test results, box tables.
- Link to v4: https://patch.msgid.link/20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com

Changes in v4:
- Rework after David's review: copy_huge_pmd() decides under the PTL
  with vm_normal_page_pmd(), like copy_present_ptes(), and copies file
  THPs (patches 2, 3). The pmd_none() recheck and the separate deposit
  patch are gone.
- New patch 1: fix folio_dup_file_rmap_pmd(), whose first caller is
  patch 2.
- New selftest, patch 4.
- Move Assisted-by from the patches to the cover letter, after commit
  1e035297ffdad ("docs: remove Assisted-by references").
- Link to v3: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com

Changes in v3:
- Patch 1: recheck the PMD with pmd_none(), as only a zap can change
  it and a zap leaves it none (Lance Yang).
- Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com

Changes in v2:
- Add patch 2, the page table deposit for ppc64 hash, reported by
  Sashiko.
- Patch 1: name panthor instead of drm_gem_shmem as the driver whose
  stale child mapping reaches freed pages: drm_gem_shmem keeps the
  pages of a purged object until the last mapping goes away.
- Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com

---
Konstantin Khorenko (4):
      mm/rmap: duplicate a PMD mapping as one in folio_dup_file_rmap_pmd()
      mm/huge_memory: copy file THPs at fork like copy_present_ptes() does
      mm/huge_memory: read a special PMD under the lock in copy_huge_pmd()
      selftests/mm: test fork of PMD-mapped shmem THPs

 MAINTAINERS                                |   1 +
 include/linux/rmap.h                       |   2 +-
 mm/huge_memory.c                           |  96 ++++++-----
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/fork_file_thp.c | 256 +++++++++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh  |   1 +
 6 files changed, 312 insertions(+), 45 deletions(-)
---
base-commit: f7d95bf74091373fad7273db4557df9b5a902335
change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2

Best regards,
--  
Konstantin Khorenko,
Virtuozzo Linux Kernel Team

