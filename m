Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794776391;
	b=efYzUyyiN6zm9JZlSkfE7iDrchM7Sao2AzZWrIOiTrr6AGBR6dljxEQ5HW9rAARiaVpX
	 EKTI3N3bgZslFGRrYTtLMlncqhKcQquyOzNRqFOUT2kSdD1gcmvJ1ks6/zADmZG0IAP3s
	 C0BWzVZvRU9tXEEhC9T4URe4rBCpkBt67QxEYItIzERNKCCxEi2ezHKtOIpeEuiaMKq9e
	 djQzwo8SW8YhNCcZRXIUhrRa3MQlJmR0VZxLcb8CIODqXgodWTX+dGb0oCPTyL8fzZAJq
	 q9HIgRW2h8IC8yl1PAi+woN1bVEWYXLwkshle3OKs1S8Qm0icajLn+rdWkJI4oX6W4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794776391;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VA2364/cpCnUggdKro+8A6hQCGEzXM/toJ6MBqEOOtA=;
	b=VEiRn0ZHdsakhK30fEvuTYnpChWe0w6b6QoV1NDJqIulhKFfZhoMYVqKgL6b6xUHf5hg
	 +cHLfFiPH+4wSe+vnnLwaXJeJjTdvIY+AFYc9JXKKjrFEPIULLV98tl53RCvY5HgydY8r
	 LKRT1EbfKtcQgTN3xK2wAsJY1L57N6htryrDSK3vH/ikvDjCNfkmw6vV8OEMMuCgLU0Hc
	 HLkuX0q2lZ/yu+s7lFOXDl7SpKO7iUy9wmbepHlIwNBmA15YqPzh2Z63PGyhT8FG7cDHQ
	 LOSlYo03EV7bbJai8Xuf6Kyfp7M6IT4anyn7wsYtmuCQtMNUpj4ylpUZj1My5/w4kkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byhLqDIe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E868606A323;
	Sun, 15 Nov 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byhLqDIe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74EB1F000C4;
	Sun, 15 Nov 2026 20:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794776391;
	bh=VA2364/cpCnUggdKro+8A6hQCGEzXM/toJ6MBqEOOtA=;
	h=From:Subject:Date:To:Cc;
	b=byhLqDIegiQVqxAucl9Glj1PrPu917T1FZTNs3DV7p9HnAejAgQAbynrsCmrw7/Mm
	 JaTzPT1MXtu7jaYqDZ1s+W3fOGw3iixNVGPUZl9yHz6YHU164bYdk7NeETPpJHqUd+
	 I9nfdjFneqbnxYmYlKRzO9ioGQ2GRNJw8Y1h2vI3eX8IkXNz7Y5u4OJzWzCcln5Qg+
	 +tAMDmEkriNqw40FVMLziHs8KxCSDHLlzB79Jnv6vgPeDDxXkzlhcuJyRv6PwjQH2L
	 DXLZdPxf68lxWwnHXLohGwnnPkSn/LQI8dPlgRuZNMFM+hO6PZf5a1oqJHflx9oLcW
	 4UW+BE6Dle7uQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/3] mm: fix races between huge and non-huge faults in PFN
 mappings
Date: Sun, 15 Nov 2026 20:58:19 +0000
Message-Id: <20261115-huge-pfnmap-fault-races-v1-0-537605643f6f@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAOsc+moC/yXMQQrCMBCF4auUWTtgosnCqxQX6XRiRzQNmaYUS
 u9u1OX34P07KBdhhVu3Q+FVVObUYE4d0BTSg1HGZrBn640xDqfathzTO2SMob4WLIFY0V2u7K0
 f2RFBe+fCUbZfub//rXV4Mi3fHBzHBzCyPk97AAAA
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
 Eliav Farber <farbere@amazon.com>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3985; i=ljs@kernel.org;
 h=from:subject:message-id; bh=xSqJJkNSDKsyFei27utb2c8SL/5Rn98AsgyN1JAUJu4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJ+yTpFLf67/xKjee/RnzUbFI9ee7q1Xc1liUrb8eJ7q
 xl2KPuXdZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAi+5cz/K98tov5J8OUtd5r
 xNJ1p/LeKVpV75Ux1y6/7ZDLO2PDyU6MDJ+rxPeGbtcxrnjlevhKpfP5mhPVYc8U5UJv7XIwn8v
 DxgMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A driver that implements both ->fault and ->huge_fault must anticipate
concurrent use of both.

This can happen, for example, if a user calls prctl(PR_SET_THP_DISABLE)
concurrent with faulting, as that only holds the mmap write lock and thus
does not exclude faulting threads stabilised by VMA lock.

A number of places in the code that implements huge PFN support fails to
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
   not match. [ mshv_vtl, drm_gem_syhmem, panthor ]

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
flag to reproduce the third issue.)

Without this series the BUG is hit immediately, with only patch 1 applied
tens of thousands of -EFAULTs are observed within seconds, and with patches
1 and 2 (and the vfio-pci modification) both warnings fire immediately.

With the series applied 30 second runs at each of PMD and PUD size complete
with none of the above, with or without the vfio-pci modification.

[0]: https://lore.kernel.org/all/20261112051440.16140-1-farbere@amazon.com/

---
To: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
To: Michal Hocko <mhocko@suse.com>
To: Alex Williamson <alex@shazbot.org>
To: Peter Xu <peterx@redhat.com>
To: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
To: Nico Pache <nico.pache@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
To: Dev Jain <dev.jain@arm.com>
To: Barry Song <baohua@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
To: Kiryl Shutsemau <kas@kernel.org>
To: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: ljs@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

---
Eliav Farber (2):
      mm/memory: remove racy huge PMD assertion from walk_to_pmd()
      mm/memory: do not report OOM if insert_pfn() races a huge fault

Lorenzo Stoakes (ARM) (1):
      mm/huge_memory: only compare PFNs of huge entries on huge fault insert

 mm/huge_memory.c |  8 ++++++++
 mm/memory.c      | 12 +++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: 5b99c3309de70337f38bd6e6998ab8335c2758e4
change-id: 20261115-huge-pfnmap-fault-races-534e626de5cc

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

