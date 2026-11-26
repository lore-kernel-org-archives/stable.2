Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703792;
	b=qkTcyVg4AQiqXW/p5bxgk9Aw38Bz80lxUyGuDZ/cVhqKIsqQGpNzy6aqRhOt0ZSkdNf7
	 UOjQT1xVW0phps0dtIFJOsgTHQ3yDkHK8rjpm9mH+2Aj4CVcwoLr3LW6O4UWVbxYP6TIB
	 gikNqk83shftIbrZtwp638FjIeqWBYqxK/vrkaYwcsie/zbdYId5dh7VWHuFMupxrqXy0
	 nc54TpNQufIXkPxQneQ57M5kDz+qn8Da2f3wpfgZzhFsSAeCLgTtrfnIlS/425Lrmwd6R
	 vmJSmBydz83gAgzKPNKiDl60yZHzwh5w9BKsCVbNihFyOYviWwn80PNO3FWH/4AU2aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703792;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kYrLxqLUpWVgKn3zzF+gWk/ajqUs6nOlEAHO0CfcR6Q=;
	b=tUUiM+YSAlNXZTRlg3uQCrk1U6+0CbqCnk36X1rboh8uAq/Ms+oWpb5ezWyoGS09zke0
	 3tV6f4vwpVreX022bCf1KXiYj1XNBqDblbKsRxQHOmoeiN2yq3i2fwONMrCEd1lWhIaV4
	 t7QmRWTxxLuKP5EdIvk/EBtU4+VXbGghkPEOSeNpiibmTUv9KSk/MuKJgRL3uvbIVt9sa
	 heJdNRym4my3+w+ueeT3V3hnz/KZh0Czvo59RvF8QVbpuX7TC9+goAVbBb6Onph0QN/m8
	 Z7Pci0gJS44v2nkjc5oB0eYn868EmAtKMWbOO4FLcxCUCS5LGleLFsQMjDxSBvc7iKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0BfK7QY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE5606A326;
	Thu, 26 Nov 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0BfK7QY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9B11F01562;
	Thu, 26 Nov 2026 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703791;
	bh=kYrLxqLUpWVgKn3zzF+gWk/ajqUs6nOlEAHO0CfcR6Q=;
	h=From:Subject:Date:To:Cc;
	b=H0BfK7QYVTriVdhymieK7UYL1mcWS2BeLUaphRZegSaUknJdRwTUKHzEXAiiYK9cH
	 fX0DvcnXUgSuuZzylyDb/mZ5KwFE21oLmq3olRZSeStzHNP+vSrzDUgao/nG4WZHaz
	 pdXMNKN5i7fgRkBaUhtYh96N/5TiaLRECbqrM264VMcXnXOIx9XkZToa6fWCch0ysS
	 Ku3t26MLBCEydgmd7eyCRsmK8nC3UG1Q5L8mAd2bbyaTST+nEc2CL/myg1lYLMG6U7
	 bYpDQ/CiBwTexZZzWiQBQUClD2Agl2bD+QGF7krfMnnykXHw5YZJvPmQX8MnjS8pPb
	 66WA0Byn7stvQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v4 0/4] mm: fix races between huge and non-huge faults in
 PFN mappings
Date: Thu, 26 Nov 2026 14:36:18 +0000
Message-Id: <20261126-huge-pfnmap-fault-races-v4-0-feecd58bb14f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XOy27CMBCF4VexZs1Uvhuy4j2qLmIzTswliewkA
 qG8exW6oUK0y5GOvn/uUCgnKlCxO2SaU0l9BxXTGwahrbuGMB2gYiC5tEIIg+3UEA6xu9QDxno
 6j5jrQAWN0mSlPZAJATYMhkwxXR/y59fPXSZ/pDCu3LpoUxn7fHukZ7Hu/q/MAjka5Sw3Vqto4
 /5EuaPzR58bWDOzfIbce0giR+ks546c8sG/QOoJkn98pJCj90Frvd0pLX5Dy7J8A+ihNCpjAQA
 A
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4624; i=ljs@kernel.org;
 h=from:subject:message-id; bh=LjQ6DmHgJktoUdlUzhIdMVT20fXjKvMndIPL42dNs9w=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI5nJ9e3DTz7PPGNVx71Hj4WDRnl7Xm8PTd/V/Tcr5ln
 QwX9670jlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExE4CbDP4PjoTWqVdJC5yt8
 +G9q/lCfktV34FxYb97O+xcV7ra7T2ZkeMR8PtzPsrD1iBrPjf3H3k67crf07sEoRVfjzy4f7kl
 m8wMA
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
v4:
* Rebased on mm-core/for-next.

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
https://lore.kernel.org/r/20261125-huge-pfnmap-fault-races-v3-0-bbc44489341b@kernel.org

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
base-commit: ded26aaeec76470592fb8e5eae1ec7bcbfa14b24
change-id: 20261115-huge-pfnmap-fault-races-534e626de5cc

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

