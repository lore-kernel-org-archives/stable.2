Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795276991;
	b=HHAF6PS7p9GMhybArQVLVYiGxaVNXraPkGqDFQTDTiISpf7UzbWnaNnQpztxd5i1rIHc
	 8r45J9crecQZBoO7rvESOqDtx4muZKycSHmT60z1A5xl1JOZZnbHyV0B57s0+UrAuQJG0
	 qIzA6AvttHcd40cJguv3cO3erEDpYc2eoq8wlIbeBPsqoEOQtP1O3HpjjvBF6hVB8witM
	 gp9nsYm5J6FB51Qmh7pANA+hhY5bqd+/ewnsmwotgOgl/EJFqytkbqRyW5G+sueObmfmG
	 /MbrTdfpG27K8sr+sGQc5k+0YVyTwIy/0xTkiRLQHRkiQXDZEs41LzS/gjfIbZKCMWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795276991;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KmtJcCst2/r+CIlcfONxSVxRUgwHgVKNPqqN2/5YJ+A=;
	b=dwYgbD2kYYIFq1IXQrLwe6W9f//UOMZxt/YZlkgasaK6QI4OkpgC9x3Z+GKpy6m/qqzV
	 33I+zd6TZhnMpWHoUvbFak35BZxeYVp3Yd5IbK0rlA6c4IdF5eDfJJkirSuHAgkgtBb65
	 LS0Ao3p+iGq7tJ0P1d+kBGt0IivuJCMnc4ZHA98yDdl+Vvn4dNlPjd4eU92jQOq6icNyJ
	 n/HMEUfssGSRvGUo3ImOgBtf4fA5KIq6QqltKHYnhECdMDrtvC7xMvR2MA+Ao2Jx1t2iP
	 yPx7RfZApqbOrKuZ3IhMNikwObMrgvfStzj+9+mRmcPqUKtZALIlrLXfiKzw2GQRs+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9qpsHfY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88299606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9qpsHfY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCCB1F000C4;
	Sat, 21 Nov 2026 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795276991;
	bh=KmtJcCst2/r+CIlcfONxSVxRUgwHgVKNPqqN2/5YJ+A=;
	h=From:Subject:Date:To:Cc;
	b=R9qpsHfYx+rDofq/QUCfrQI8mEkYCYK0QQlD1LeSnRo/qiTn7na7Gz5+E+WN8LL20
	 pswwehqF3Bx859yEwso3IIdzx0TJv2XQzANySMF/aKcCQTVCcMNa8woxVq0t5YG3OR
	 4d40WwRIKsN7LItS2fwnEs7xYL02rJXD1Jn867ho3vArpfiq725qIg9G7fc9nGeKqD
	 tVWSAwzHGWHlj6/OpfoE8rIlzuki6E2wlqrbDiAEOvMLRwrKulGYMXHCwcnFokeVLD
	 n0lvFk2YbkHTxv0UbkLWwhcCJnAfeRt/kvTx0xo5WRHRlFw4LK6MmDzMaYS+cjWpZb
	 MgADsX3IIbUoQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/7] mm: reworked AI-generated VMA and mremap fixes
Date: Sat, 21 Nov 2026 16:02:26 +0000
Message-Id: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3LMQqAMBAF0avI1i6YaCy8iljE+KNbaCQLIoh3N
 1g+hnlIkQVKQ/VQxiUq6SgwdUVh88cKlqWYbGN7Y2zDmnbwnjLYC0e5oeyxtKGbHaILVMYz4w/
 lG6f3/QApS8PvZAAAAA==
X-Change-ID: 20261120-some-more-ai-fixes-aed3c4b5ef5c
To: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=ljs@kernel.org;
 h=from:subject:message-id; bh=rc0Rcgs0tXdSEXR4lnymZC5iarX/LI0OXwfascDWCDo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIZD2zjvyV23oz3kTz726Nf14lfuuj+g9/gA9vN1LAeu
 f1bJz492FHKwiDGxSArpsjy/Iv4/iCRsHmdF/zdYOawMoEMYeDiFICJMKkyMlwSfuM44Yte2KnU
 3QsyfdtmMzAurIyNWleRqWLw4OLDHUYM/xQbZyjdd5vbpfP/zIVDb1UKBQ++7EjQjyt61qQSvTM
 5nhMA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

I have reordered the patches here by priority, David - the first 2 should
be prioritised as hotfixes, the rest can go in 7.5:

== Critical ==

1. unmapped_area_topdown() invalid bounds - possible memory corruption,
   triggerable by any local user.
2. Lock VMAs before mm_all_locks_mutex - system-wide unkillable hang,
   triggerable by a local user with FUSE.

== Need fixing ==

3. KSM unmerge only interrupted by fatal signal - silent data loss on
   mremap() of KSM memory.
4. Uncharge after failed stack relocation - strict overcommit limit
   defeated system-wide.
5. mmap() offset limits on mremap() expansion - invalid file offset
   reaches the DAX fault handler.

== Hardening (no need for Cc: stable) ==

6. Guard gaps on in-place mremap() expansion.
7. Non-executable brk mappings under MDWE.

As usual, please go through and check these carefully for correctness,
sanity.

Note that one of the original patches was punted over to the BPF
guys ([0]), as it doesn't feel that it'd make sense to change core mm to
address it.

[0]:https://lore.kernel.org/all/awGZWsCp6v63H_py@gremlin/

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Chris Mason (4):
      mm/vma: fix uncharge after failed stack relocation
      mm/mremap: apply the mmap() offset limits on expansion
      mm/mremap: respect guard gaps on in-place expansion
      mm/vma: make brk mappings non-executable under MDWE

Lorenzo Stoakes (ARM) (3):
      mm/vma: error out on invalid bounds in unmapped_area_topdown()
      mm/vma: lock VMAs before taking mm_all_locks_mutex
      mm/ksm: only interrupt unmerging on a fatal signal

 mm/internal.h |  2 ++
 mm/ksm.c      |  4 ++--
 mm/mmap.c     |  4 ++--
 mm/mremap.c   | 10 +++++++-
 mm/vma.c      | 75 ++++++++++++++++++++++++++++++-----------------------------
 mm/vma_exec.c | 22 +++++++++++++++---
 6 files changed, 72 insertions(+), 45 deletions(-)
---
base-commit: d12eccbcb79a4fa35c3aa588eb79056af62eb859
change-id: 20261120-some-more-ai-fixes-aed3c4b5ef5c

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

