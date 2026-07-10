Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C6B3F6C2D;
	Fri, 10 Jul 2026 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680628; cv=none; b=CHvy11wc59Al5mcFFNzEM4u0bBu2jcyQhhWNZrKSBixMiWHFAW/bi84LGXicBmtSu0+s9+njOk4FefAkyidNO0prsVXBsYMjAb3E7zAJSkyoRv65SVQ2KciA0GJRGofu9JElj00qmRCtUR1oLoicyyNEi4zAxF0uN4vWFgSZhFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680628; c=relaxed/simple;
	bh=sMz40sYlXTtliml43cNKfdXOdD7XpzaddnUQc2wMyQY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dKWf10OyuykrFQj2Kh89754RzHbIB7C6aeTBv6wBXpKr2PlCmBNrkSwzUZWjtnMwN1EE2HVwjRIIPbhtGDw2WpSVbFHQ+K2DdCPcy3fjq0AoWchqy9BfQXBQ7V48lfyh5NGYWmWJuecDqopk3QlkKLG8o1vYUxwKQCT9GMkChtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvNpz50O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvNpz50O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA71F00A3A;
	Fri, 10 Jul 2026 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680627;
	bh=WJEZw+9x/jEd5nomnZiXByrKMCRFDaAVRo5p+ehSw4E=;
	h=From:Subject:Date:To:Cc;
	b=jvNpz50O/5E2VXWt/YbRjL36y/6Uv4nqe2F2So4M00tY+kTpB6dZNZkDq88So/9h7
	 FPEmtTLnn8oYAQpoLO0Oee5Eb3WAFx2uBZueusrF/5we/ZFruxxDunLOcuwj/IHNZ2
	 KAGj5goKudawqSj8Fli2LxVn5j8lF6FdckW70IiVErJjcE4WlprTAiTdKTSpgGmtIK
	 pH3kqAvywiNCrHLO2BtowqPcnIu6wYvsIoXDZ1RwCZr8IBHKzELYjxqKedIzGqgOdn
	 ZQGLPXonzu9vG7riMj81A3NqmUOkNauNDsaMyDQT8/2EQAsW4FfEgTm/RDmc4NS02J
	 Hv6p0I5VEI75A==
From: Lorenzo Stoakes <ljs@kernel.org>
Subject: [PATCH 0/2] mm: fix UAF caused by race between ptdump and vmap
 pgtable freeing
Date: Fri, 10 Jul 2026 11:49:17 +0100
Message-Id: <20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3OUGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0MDXYh63bLcxALdosTkVN20zApdo0ST5MRkSwsLS2MLJaDWgqJUoDD
 Y2OhYCL+4NCkrNbkEZJZSbS0A/Km8rngAAAA=
X-Change-ID: 20260710-series-vmap-race-fix-2a4cac988938
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: David Carlier <devnexen@gmail.com>, Dev Jain <dev.jain@arm.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Stoakes <ljs@kernel.org>, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3435; i=ljs@kernel.org;
 h=from:subject:message-id; bh=sMz40sYlXTtliml43cNKfdXOdD7XpzaddnUQc2wMyQY=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLICzqWfedV9ys7mTqWo11PRvSdz91c+qs7fd+Lw5Gy2R
 1+V/ZyUOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRJTMZGSYnzTsRodv6btXm
 qltSArffHelo5mkK9vC0jvync44ripeRYX73dpt3y0znvXRKL4271rq+bqqB1pTemgh/wYL6/Ct
 FvAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Kernel page table walkers fall into two broad categories - those ranges
where no exclusion is required via walk_kernel_page_table_range_lockless()
and those where exclusion is required via walk_kernel_page_table_range()
or walk_page_range_debug().

The former category is used only by arm64 arch code operating on ranges it
both wholly owns and does not concurrently write.

The latter category consists of kernel page table walkers operating on
ranges that are wholly owned (but which need exclusion against concurrent
writers).

The lock used for exclusion is the mmap lock, and for kernel ranges this
the mmap lock on init_mm.

ptdump is a special case being both the only user of
walk_page_range_debug(), and the only case in which it walks ranges it does
not own.

This presents a problem, as page tables may be freed under ptdump. And
indeed there is a use-after-free bug in the kernel as a result, which this
series addresses.

vmap promotes page tables to huge leaf entries where possible, freeing the
lower leaf page table when it does. It does this with no meaningful locks
held against concurrent ptdump walks.

As a result, use-after-free can currently occur. This series addresses the
issue by having the vmap huge promotion logic acquire the mmap read lock
while both setting the huge page table entry and freeing the prior leaf
page table.

The ptdump code already acquires the mmap write lock, so by doing so we
ensure that the ptdump walker only ever observes either the huge page table
entry or the existing page table entry, and nothing is freed underneath it.

A mitigation for this issue was already applied for arm64 in commit
a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), which this series
has to deal with carefully.

This mitigation resolves the issue by acquiring the mmap read lock on
init_mm on vmap page table free if a ptdump is in progress.

However the fix in this series would cause a deadlock if we were to simply
apply it for arm64 without also reverting the change.

This is because vmap may acquire the read lock before ptdump attempts to
acquire the write lock, which then gets queued, and rwsem starvation rules
mean that the (unacknowledged) nested mmap read lock in the arm64 code
would also block, meaning the original read lock is never released and thus
deadlock.

This series works around this by #ifndef CONFIG_ARM64'ing the mmap read
lock in vmap logic, then partially reverting commit
a93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), keeping the
enablement of huge vmap support, and removing the ifdeffery with the
partial revert patch.

Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
---
Lorenzo Stoakes (2):
      mm/vmalloc: acquire init_mm read lock on huge vmap promotion
      Revert "arm64: Enable vmalloc-huge with ptdump"

 arch/arm64/include/asm/ptdump.h |  2 --
 arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
 arch/arm64/mm/ptdump.c          | 11 ++---------
 include/linux/mmap_lock.h       |  1 +
 mm/pagewalk.c                   | 22 +++++++++++----------
 mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
 6 files changed, 51 insertions(+), 69 deletions(-)
---
base-commit: a635d6748234582ea287c5ffeae28b9b23f91c7e
change-id: 20260710-series-vmap-race-fix-2a4cac988938

Cheers,
-- 
Lorenzo Stoakes <ljs@kernel.org>

