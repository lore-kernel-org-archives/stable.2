Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795646007;
	b=35Y/bRRm1qPyoSGv57Os/9UL3SZYaSR2MXP0/SmsNAMASNXqkbS7Dk94Jqy2CfVRgNry
	 uq5BU+CDzy/yXFZFrJpyYrWvg2dMpaLZMhzyafB2NWWt7gegeHRdEyJqIn56F8i1q2QjG
	 GZ9fVxtpj9HKMbxvygeYT+QWha+CvmYvx5+f1ngiFyyD7SHQmtQgaCt8MNwRMgjbIhMLR
	 GTDWhHv6qlbaYh/r270D2w2p/eh7pZM0XzPPat4lShVh9e2ZAYYfIAiyoF863hLycwEgB
	 3kQ2V1CH5KCZYeDEkghxOjdCGmBASzWqtu2WsmkRruwDItniLhFXSJU3AMLCa47k3eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646007;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tzn+by+k8G1JwXk+S/E0tJAgmy0jLDfOi0f5NcqA/MY=;
	b=etIfPFiDEcqW2qOOe+TrG1z6Kho3IQ+t/5H1NM6aPV9IEoey5HrX9Sao1NbfYvvzpX6c
	 oQmLqsMPEQycOZjgIeAZrWZ8Ct11K7ZPnrUKVN94kjolvQSQs02QxB+eQJ3Md342g7rqG
	 GLoU3rQMB9AhYUqXDCuh27jn445fol9M12HhYBPFk3QJZCZkKYb4JECWHRgOhQanMorZS
	 VOIvsnnSUHx+poMKtPu49und4vA4PlBjqE7Jr/2kOZVASnqahLHYX8UbpB9K5wgBf3mOx
	 k9TYavT47O08Wn/aYLYAze02t0/tmw687lnZddGuGZdXfAcIzdHA52iSVzYMhQA0GJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeF+83ri;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE971606A321;
	Wed, 25 Nov 2026 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oeF+83ri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655D71F000C0;
	Wed, 25 Nov 2026 22:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795646006;
	bh=tzn+by+k8G1JwXk+S/E0tJAgmy0jLDfOi0f5NcqA/MY=;
	h=From:Subject:Date:To:Cc;
	b=oeF+83ripG+YMJQ6SibQuirzvfqlLreGg2dU0N4iBw6J9SwMfGbEdiYCtiUZLOpMd
	 JYqiF79Vytug9G0B2DkzFLIWoipJtdH+XMvOxqN0DGGpyctPV9W9zPh95DOEF2Z+QY
	 Xceo8UU5pO3BjrUwnu0S1uUp8LqLqgTugPbAVmqe/LCUO1oXZ7psZ5qitBlKCivcYb
	 cJwxUd3Rj2XwgOzgIRdtbB/JU+sW9VMX6ByXF7MliTP9djs6rMrE08LzryKnJqRfcE
	 PzisQMZIlNmWvvo++RWg05A5YHf7BJGoQffk2A7bJcTCTSBVSYYhY9OhGmH+h5669x
	 28AaXAPpZrf/Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 00/21] mm/hugetlb: various fixes (2)
Date: Wed, 25 Nov 2026 23:32:58 +0100
Message-Id: <20261125-hugetlb_fixes_2-v1-0-db27fd2f71a8@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMUQqDMBBF0a0M79uAGRIp2UopoumoU4otGS0Fc
 e9i+3k5cDeYFBVDog1FPmr6mpHIV4Q8dfMoTu9IBK658Z5rN62jLM++HfQr1rLjJsSY4yUMQVA
 R3kV+hETX279t7R+Sl3ODfT8AsQh4LHMAAAA=
X-Change-ID: 20261120-hugetlb_fixes_2-26455c584f4e
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jinmeng Zhou <jinmengzhou22@gmail.com>, Hongfu Li <lihongfu@kylinos.cn>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Mike Kravetz <mike.kravetz@oracle.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Dave Airlie <airlied@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
 Mel Gorman <mel@csn.ul.ie>, Dave McCracken <dave.mccracken@oracle.com>, 
 Andy Whitcroft <apw@shadowen.org>, Adam Litke <agl@us.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, James Houghton <jthoughton@google.com>, 
 Yang Shi <shy828301@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Matthew Brost <matthew.brost@intel.com>, Byungchul Park <byungchul@sk.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Wanpeng Li <liwanp@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
 Kenneth W Chen <kenneth.w.chen@intel.com>, Hugh Dickins <hugh@veritas.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Joern Engel <joern@logfs.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.cz>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, 
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, 
 "Kirill A. Shutemov" <kirill@shutemov.name>, 
 Sasha Levin <sasha.levin@oracle.com>, 
 Guillaume Morin <guillaume@morinfr.org>, Wanpeng Li <liwp.linux@gmail.com>
Cc: linux-mm@kvack.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Andrew Morton <akpm@osdl.org>, linux-doc@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=david@kernel.org;
 h=from:subject:message-id; bh=nzCzOz26eddU4SO7rlRqgKmrjP0kTfGyA8Ecr2EgmCo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLZk5TjVFYV1bZe5k5Juf3u5oJJF15cifxTFhJhcLJqq
 bD0jE2KHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExk40aG/zULo7sKr5Xeb15i
 yrPhVfhsTYlSt3trHn7f/fipxO+MF84Mf7iiPeLe3jxfdNmWL429a9eJRb0vt/byrv3/cI5p6+N
 fbnwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Hi,

some more hugetlb fixes, this time not as horrible and confusing stuff as
last time:

 - Patch #1: a hotfix for v7.4
 - Patch #2 - #18: a bunch of non-urgent fixes
 - Patch #19 - #20: two related improvements
 - Patch #21: an RFC for a hugetlb cgroup fix

I think patch #21 is the right thing to do, but I am not really a cgroup
expert.

Patch #19 deserves a closer look from our VMA locking experts :)

Patch #1 should go into v7.4, the rest can wait for the next merge
window.

Tested with hugetlb selftests and some targeted tests that reproduce
some of these issues.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Chris Mason (8):
      mm/hugetlb: fix truncated copy result in UFFDIO_COPY
      hugetlbfs: fix deadlock between hole punching and memory failure
      hugetlbfs: recheck the vma range after the lock wait
      mm/hugetlb: don't zap non-present entries when unmapping a folio
      mm/hugetlb: unshare PMDs of a split VMA if allocating its lock fails
      mm/hugetlb_cgroup: track in-use folios per cgroup
      hugetlbfs: seal SHM_HUGETLB files against growth
      mm/hugetlb: resolve protnone faults without a uffd bit

David Hildenbrand (Arm) (13):
      mm/hugetlb: charge the copy made at fork to the parent
      mm/hugetlb: always mark new page cache folios migratable
      mm/memfd: mark new hugetlb folios migratable
      mm/hugetlb: free surplus folios of other nodes on free
      hugetlbfs: don't zero poisoned pages in a hole punch
      mm/hugetlb: only check PMD table sharing for PMD-sized folios
      mm/migrate: check hugetlb PMD sharing in move_pages()
      mm/hugetlb: don't share page tables of a VMA during mprotect()
      mm/hugetlb: count migration entries at fork and unmap
      mm/hugetlb: stop accounting HugetlbPages once PMD tables were shared
      fs/proc/task_mmu: don't clear VM_SOFTDIRTY on hugetlb VMAs
      mm/hugetlb: use the VMA lock to stabilize flags for PMD sharing
      RFC: mm/hugetlb_cgroup: charge faults to mm->owner

 Documentation/filesystems/proc.rst |   3 +-
 fs/hugetlbfs/inode.c               |  22 +++--
 fs/proc/task_mmu.c                 |   9 +-
 include/linux/hugetlb.h            |  22 ++++-
 include/linux/hugetlb_cgroup.h     |  30 +++++--
 include/linux/leafops.h            |  11 +++
 include/linux/mmap_lock.h          |   1 +
 mm/hugetlb.c                       | 174 ++++++++++++++++++++++++++-----------
 mm/hugetlb_cgroup.c                |  64 ++++++++------
 mm/memfd.c                         |   1 +
 mm/mempolicy.c                     |   2 +-
 mm/migrate.c                       |  23 +++--
 mm/mmap_lock.c                     |  78 +++++++++++------
 mm/rmap.c                          |   4 +-
 mm/vma.c                           |   2 +-
 tools/testing/vma/include/stubs.h  |   3 +-
 16 files changed, 314 insertions(+), 135 deletions(-)
---
base-commit: c8117bff684306f5c1f959d055cc2b24dd67b1eb
change-id: 20261120-hugetlb_fixes_2-26455c584f4e

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

