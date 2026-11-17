Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940306;
	b=5EgqkLzuCnS0drn+PL2CezjoUaRdrkCre5lHJU1gkw0NHUHQHllGfTrGpNLgYXSw2hes
	 pfYXv8npOSjWNf2+UkqMl05Kle2ACn31FRi8r/UfdtOWXp9o8ohw9HOcU4fmXpBmD36CT
	 +ce1QrFS4AXoN9o5I9aEdJKmhnqj2ZG6CSN3oQeYCXNeFV2aIdgcH8gSF6Ity1Swk3HZl
	 el8FVGsHtj7Ow/ll+iDmQGERhpLzy8qPXfPv+TBNWbv2codvPpXtG/nFKKAV5PYXmc5kI
	 9+yLVW1jQI8tW8W9rQHwyyUhi7F+SmU3mpbuAKSL/SPyPHBleRZez/fupsOAU3NoAGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940306;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MF6sJUYsF2XNf12BApOVZGbhsY2g7WBXuedDspoOUkQ=;
	b=kGMYtyRXLqTCwx03k/D3SBaKu4uHcrhTlXLxRZuWyUaj++feNbIJQTv46SzsUvgpNLnk
	 ceh9WiR9dgxFV7G2OSBxvTMt6eO/WJ14sKFHbJkBViKjb+L3PZV6pqhCiwBtcvP25wLSB
	 leSPpIjOH90lB1s3+2Gr1WU6N71bPmGkrVPTRLd+K/3HjNaQDhJ2KH5rio7IIiTsfcs0j
	 Q203hRPoXIdXJwcnzwXag3IvqtVZr1duIdDzLXjUXOSSA5Zr/M0H+eC83tEW8l873dwDg
	 +s2dv55osu45VePejBSi/fE8nd39y/8GdpnNDyzDzCPCZlvkOk+IT2dBqZ7brv+42eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7Iq8gA5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F24606A338;
	Tue, 17 Nov 2026 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7Iq8gA5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07881F000C8;
	Tue, 17 Nov 2026 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940306;
	bh=MF6sJUYsF2XNf12BApOVZGbhsY2g7WBXuedDspoOUkQ=;
	h=From:Subject:Date:To:Cc;
	b=K7Iq8gA5YcR1AChHEEa+rSjHfNrQ0i3b83shOSO1uvX4Eq2j6Rp0mY//V81RcJwMn
	 nXy/0zTo9ZrBFWx225OJLv3Qu114JHzW4k6/yuVFAYgqJLZ/7PbyVRCE+o/ohtPI6Z
	 GI71KOnULKeLlar6gzhz2C491/4Vpe3IlQqVBQqKEvnWymr5Ghnbc8a7OqZqd1jda1
	 r/160s/TwY7IWxVxnlOdC0rVFm5H8NDQp4kTVUMHBm1ge6UHPInxvxKK6Q8w2QBtrw
	 dmEUVhUBo0LA85UvMMubGim4uWgoE6dNcaNKDtwhBvsWNLocsllzBe+LBybeAvmFhP
	 c6zePBpd+gQxg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v2 0/4] mm: fix races between huge and non-huge faults in
 PFN mappings
Date: Tue, 17 Nov 2026 18:31:31 +0000
Message-Id: <20261117-huge-pfnmap-fault-races-v2-0-276007e73bcb@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6DIBREr2L+ujSCQpOueg/jguJHaS2aj5o2h
 rsX7AG6fJOZeTsEJIcBrsUOhJsLbvIJxKkAM2jfI3NdYhClUJxzyYY1ZbP1Lz0zq9dxYaQNBia
 rGpVQHUpjIK1nQuvex3PT/jis9weaJd/lxuDCMtHnUG889/5bNs7KpLqoUqq6ssrenkgex/NEP
 bQxxi8B5Xu20QAAAA==
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
 stable@vger.kernel.org, Eliav Farber <farbere@amazon.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3913; i=ljs@kernel.org;
 h=from:subject:message-id; bh=00OYcEgp48TVHPBBwzIuZPpKjP+lTWun/5wvtt7xAnY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL+zG1jWLbC2FfasYZLbtX/ALfsiUrmuy+HSRT+fr/9b
 W1457a3HaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE9gQLk4BmEj4Joa/kqEf1TTV2Xpk5L3/
 Nr/Xqt/w9PxCNV6Ow6a/BFkPZ8vHMTK05ViFeHk8klJey3jxiI+Z2VLn6WtEJl9wL/76Pjbo3k4
 mAA==
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
 mm/memory.c      | 68 ++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 19 deletions(-)
---
base-commit: 5b99c3309de70337f38bd6e6998ab8335c2758e4
change-id: 20261115-huge-pfnmap-fault-races-534e626de5cc

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

