Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621745;
	b=Qhf9NIhmCFUfgvKt48QSgDAlwtZ7TUfpF1S6aqUMKs+Gqa8NB/DZav2YJ5Lf7j9yyf2d
	 Q/DUnjmtN5MY0ESguv0MGTQn0e5MWC+zVL75TjSxFGhVlDYssN2/Yqh55mi4cmBm0uGxd
	 YyqIrKgwtPubG7lvaPwzQKAhjMNF0tEvxJ5+2uOTEAVo5eR0MNezRJDMdf4uENnyLBFr0
	 hc9xeSCKE+anR0MtrgBJME1d7SF4Nf2qcx1ArtZHeeSLXC8CT9lXRdB8KcyCrYAEMIJGA
	 8z4/cURac30Gibai7YfmJhxXMGt5nJJM5ubwRmY5D3w5JuDWl+xDngldC4N766Ae/rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621745;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=f4E9fqa7EjT34/pouEYgQMVfRSlwer9Fxd7blOSlVs0=;
	b=g5Zu1JntfvEg7G/yzDf1aXSh+LBb7CWoDu+6OP5cRG0xDav1DZrurl/EBmWiSXjwAsA2
	 vWJZdjW3AP5/9c94OkrXmvCkSn+2UgNx5ajIpHzK3mQYG19aNmjzviRckZTv5vncdU5x9
	 FNY9M1jMbOHyHwGOb5Cz7yl1mARYR20JJeOl6hlOaaLCwO6P2vJDDMtsVN1F7sR2TFiFa
	 UGpfvKs/w3um4ShceCvs1EDS6S6zipt4kjgpigzbym/w/MNbJAM9iNnBW+M+3F5tIEAyQ
	 Ew5n10ug8eeemIMIBBp1dsHj/Aiofr3bozkZUHre17VUkJU1LP19sXKmy20eyOdnvYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzEpqPcP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C5606A321;
	Wed, 25 Nov 2026 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jzEpqPcP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D5C1F000E6;
	Wed, 25 Nov 2026 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795621745;
	bh=f4E9fqa7EjT34/pouEYgQMVfRSlwer9Fxd7blOSlVs0=;
	h=From:Subject:Date:To:Cc;
	b=jzEpqPcPKJl35HJnMb6btHGNnboqsxn2LLtp3CiO3gs8EwuRvcCpl8cNZxXbE0Bpx
	 MZrdOn9ufSNMSQopTzSQLWdCfqg5kGmeJuCH65BtmASREu970zUL4CFkuLtrOPSiSi
	 rkbJh8AHapnJCS9g3ZELVYyzhs9UPXBpfhS4dW22hw+8R7Lwexu6lIvPqbpejLzNiO
	 ltTjVyTpvpCxL4ukQAHxwoEHHxPAR4DJFeBNBdVmAb3duepteGgpHXrxvo4gfruVzg
	 c0WWUsv0I8KuAjFumZgNAeQ73OFtSF+mCp1osDEXh23UrkR3A2kiN6NP34dfpTlfYA
	 FLw+pGFqhAl7w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v3 0/4] mm: fix races between huge and non-huge faults in
 PFN mappings
Date: Wed, 25 Nov 2026 15:48:48 +0000
Message-Id: <20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XNSw6CMBSF4a00d+w1fdA2YeQ+jAMot1BFIC0QD
 WHvBpzowDg8ycn3L5AoBkqQswUizSGFvoOcqQMD1xRdTRgqyBlILo0QQmMz1YSD7+7FgL6Y2hF
 j4SihVhkZaSrSzsGBwRDJh8cuny/vnabySm7cuO3RhDT28bmnZ7H9/ldmgRy1soZrkylv/OlGs
 aP22McatswsPyH7G5LIUVrDuSWrSld+Qeu6vgDBJnW4GgEAAA==
X-Change-ID: 20261115-huge-pfnmap-fault-races-534e626de5cc
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Alex Williamson <alex@shazbot.org>, 
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Wei Liu <wei.liu@kernel.org>, 
 Roman Kisel <romank@linux.microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Naman Jain <namjain@linux.microsoft.com>, 
 Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "T.J. Mercier" <tjmercier@google.com>, Eliav Farber <farbere@amazon.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4496; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Z4LO9d2vnfeRNb+fw6qh0PkH0/UA2FTNFPb1bDNeV6Q=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLZmdOK5/z9oxXgpmdRH8+6Xej6Uu7/3yNyimKNtjVzH
 lwX6iLeUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgImc62H4H5a6tEHhzYy8sk9F
 i1v28UzfdDyHucj+36zLOp/W+Ivv+sbwh3NzfHpVwGLvu3ECq4L83TdbNU87vfXNz4m8aV+OVMc
 V8wMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

A number of places in the code that implements huge PFN support fail to
take this into account correctly, which this series aims to address.

Generally the shape of the issue is that faulting the same empty page table
entry can result in the ->fault and ->huge_fault handlers racing and the
loser finding something they didn't expect.

The fault code must tolerate this, but fails to in 3 places:

1. walk_to_pmd() asserts, without the PMD lock, that the PMD entry is not
   huge, so a VM_BUG_ON() triggers. [ vfio-pci, nvgrace-gpu ]

2. insert_pfn() treats a failure to map the PTE table as an allocation
   failure and reports OOM, causing kernel accesses to the range to
   spuriously fail with -EFAULT. [ vfio-pci, nvgrace-gpu ]

3. insert_pmd() and insert_pud() assume a populated entry is huge and
   compare its PFN on write fault, warning when that of a page table does
   not match. [ mshv_vtl, drm_gem_shmem, panthor ]

This was originally reported and fixed by Eliav Farber in [0], this series
reworks patches 1-3 of that one.

Patch 4 of that series (x86 PAT encoding of huge PFN mappings) is dropped -
it is unrelated to the above, no in-tree driver is affected by it, and it
needs a different approach which is better pursued separately with the x86
maintainers.

All three issues were reproduced on x86-64 under QEMU using vfio-pci in
no-IOMMU mode on an ivshmem BAR, with 6 threads faulting the same address
in each PMD or PUD aligned range of the mapping while another toggles
PR_SET_THP_DISABLE (note that vfio-pci had to be modified to pass the write
flag to reproduce the third issue).

Without this series the BUG is hit immediately, with only patches 1 and 2
applied tens of thousands of -EFAULTs are observed within seconds, and with
patches 1-3 (and the vfio-pci modification) both warnings fire immediately.

With the series applied 30 second runs at each of PMD and PUD size complete
with none of the above, with or without the vfio-pci modification.

[0]: https://lore.kernel.org/all/20261112051440.16140-1-farbere@amazon.com/

---
v3:
* Propagated tags, thanks everybody!
* Fix issue with 3/4 returning -EFAULT, which resulted in a SIGBUS. Fix
  this by returning -EBUSY so the fault is retried. As reported by the
  kernel test robot.
* Updated 3/4 comments and commit message to reflect this + also that
  MADV_DONTNEED can result in a missing page table.
* Updated 3/4 to also have insert_pages() return -EBUSY under the same
  circumstances as insert_page() for consistency.
* Fixed 'Reivewed-by' tag in 3/4.

v2:
* Added 1/4 to have walk_to_pmd() return an error code. This is marked for
  stable as it is a prerequisite of 3/4.
* Updated 3/4 (was 2/3) to add __get_locked_pte(), which differentiates a
  failed page table allocation from racing a huge entry, and to use it in
  both insert_pfn() and insert_page(), as per David.
* Updated 3/4 (was 2/3) to have walk_to_pmd() return -EFAULT if it
  encounters a huge PUD entry, as per David.
* Updated 3/4 (was 2/3) to be authored by me as it is substantially
  reworked, retaining Eliav as reporter.
* Updated 4/4 (was 3/3) to use [pmd, pud]_leaf() rather than
  [pmd, pud]_trans_huge(), as per David.
* Propagated tags, other than to 3/4 (was 2/3) as changed significantly.
https://lore.kernel.org/r/20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org

v1:
https://patch.msgid.link/20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org

---
Eliav Farber (1):
      mm/memory: remove racy huge PMD assertion from walk_to_pmd()

Lorenzo Stoakes (ARM) (3):
      mm: update walk_to_pmd() to explicitly return an error
      mm/memory: do not report OOM if insert_pfn() races a huge fault
      mm/huge_memory: only compare PFNs of huge entries on huge fault insert

 mm/huge_memory.c |  8 +++++++
 mm/memory.c      | 70 ++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 58 insertions(+), 20 deletions(-)
---
base-commit: 5b99c3309de70337f38bd6e6998ab8335c2758e4
change-id: 20261115-huge-pfnmap-fault-races-534e626de5cc

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

