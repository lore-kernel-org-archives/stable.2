Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483930568B;
	Sun, 12 Jul 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783853057; cv=none; b=GH+3hpIMnOlchm7guAVg0OMAlxFvNpkmZ6IMlM/aVsSH23Oy0BSerSxbTWyyMq2yxeaYkgiPZvJORT0yObApb7RurNBnlXYt/Q0HVnARBcQKiyg/N3nOARdfAn0Q7FUfmiDyreO2NVZmgdUw/nuc/gUVlaReAB68AKntIQnl/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783853057; c=relaxed/simple;
	bh=94ohPt19KBXdpXV0tk2uctqp6WqGAL7X+3ddUv8veLk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mRcgjLu4xC9pUOSs5k/J+GzIG9sZugkHtuNTFd8VVgkdd/ZWRKp5FY5O/l5sEL4HMZFH+BHpfcwbXLjW2W9SCDogKobC2LVmt4bnSIIcB488xLUa5BLDCckzGCef0dr4aFk59u4BjcPogbaSxXmyasSNXzTf8Kxv5MYn6moKmxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaYc6nFA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaYc6nFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A801F000E9;
	Sun, 12 Jul 2026 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783853055;
	bh=n5Y4kSef/beYZfYsug/ValOYyvl5bXs5MyYCHxnTyIU=;
	h=From:Subject:Date:To:Cc;
	b=OaYc6nFAMKMaV/JnB4SRlLS0mhdgISliANj6s7xPbY7ZhsbNGp5lcfhnQknzmBdTP
	 Pygl5zOgh+i/GhnXd3ObgnikSBdScNxBpePj4iR++ribG9Y2zFgdXwOu4pxoUKWo6M
	 TZydcxNAiVOAWLDSDfqd7UN17lXm1fzBp59hne5n35B7K3IhmZpoTZFR4ghHsd/UN6
	 eCVxW7GDo6XS/YrhsgRPAWmJcWT139kDgrl9trHrV1AxEwzqnM/8gURGoaZ6T3QaVB
	 BXJZVZJXhQfiRbPEtyqTWN9W79YbOBJTGxlRUGmMcAziz6/xk6AChbIP0eSj/5EhOR
	 nQYWUwcnrjNBg==
From: Lorenzo Stoakes <ljs@kernel.org>
Subject: [PATCH mm-hotfixes v2 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Date: Sun, 12 Jul 2026 11:42:23 +0100
Message-Id: <20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI9vU2oC/32OSw6CMBCGr0Jm7Zi2oIAr72FYlDpAVSiZYqMh3
 N0Ce5ff/K+ZwRNb8nBJZmAK1ls3RFCHBEynh5bQ3iODEuoscilw92Po9YisDWFjP6h0ZrQpi6J
 MC4jRkSmet9ob9D12btq52kX/rh9kprV4tXfWT46/2xNBbqH/e0GiwFOd5mVmpEwbuj6JB3odH
 bdQLcvyA3plZjrYAAAA
X-Change-ID: 20260710-series-vmap-race-fix-2a4cac988938
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>, ljs@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7382; i=ljs@kernel.org;
 h=from:subject:message-id; bh=94ohPt19KBXdpXV0tk2uctqp6WqGAL7X+3ddUv8veLk=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKC8z9E9Gf/vGlxmXUOh99F3YI/Nd/4vrF0fX6eNe3o6
 YWyP3YwdZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAisRGMDHPcXlTGzHbscfwp
 /lw4T/u9zfUXVw+6vTM+vM/37T/WO5wMf3ivLRX9oL1bYuM5KekAdoEPW95v/G/ScdypOiC1glu
 EmQEA
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
lower page table when it does. It does this with no meaningful locks held
against concurrent ptdump walks.

As a result, use-after-free can currently occur. This series addresses the
issue by having the vmap huge promotion logic acquire the mmap read lock
while both setting the huge page table entry and freeing the prior leaf
page table.

The ptdump code already acquires the mmap write lock, so by doing so we
ensure that the ptdump walker only ever observes either the huge page table
entry or the existing page table entry, and nothing is freed underneath it.

A mitigation for this issue was already applied for arm64 in commit
fa93b45fd397 ("arm64: Enable vmalloc-huge with ptdump"), which this series
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
lock in vmap logic, then partially reverting commit fa93b45fd397 ("arm64:
Enable vmalloc-huge with ptdump"), keeping the enablement of huge vmap
support, and removing the ifdeffery with the partial revert patch.

There are two related issues that we also address in this series:

* x86 page attribute logic, specifically Change Page Attributes (CPA),
  implements a feature whereby huge ranges can be collapsed into huge leaf
  entries. This can similarly cause a UAF when done in parallel with a
  ptdump walk, so similarly acquire the init_mm mmap lock to avoid this.

* x86 and arm64 permit walks of non-kernel mm's (both allowing efi mm
  walks, and in intel's case arbitrary mm's), so we ensure kernel mappings
  remain stable by locking the init_mm as well as the mm being walked.

The ordering of patches is established for both strict dependencies (the
arm64 partial revert in particular has to be done after the vmap changes)
and logical ones (the non-kernel mm fix only makes sense once the vmap/CPA
fixes are in place).

---
v2:
* Rebased on latest master of Linus's tree.
* Accumulated tags, thanks everybody!
* Fixed cover letter reference to arm64 partial revert as per David C.
* Combined all patches into a 4 patch series for ease of tracking/review
  and updated cover letter to reflect.
* Reordered patches in series logically - fix vmap, fix CPA issue, handle
  mm vs. init_mm then revert arm64 mitigation.
* Reworded first patch to be consistent with x86 wording to clearly
  indicate the intent of the fix is to fix ptdump UAF.
* Reworded arm64 revert patch subject as per Mike, Dev to make clear this
  is only reverting the ptdump mitigation not the vmap huge support.
* Added Fixes: tag to arm64 revert patch so we backport this also for
  neatness. Not strictly necessary, but is a better fix overall applied.
* Added note about stable dependency to arm64 revert patch.
* Updated walk_page_range_debug() to remove pointless !walk.mm check - if
  NULL mm then the mmap lock asserts would NULL pointer deref, and of
  course no caller does this anyway.
* Updated walk_page_range_debug() to always assert init_mm mmap write lock
  is held.
* Updated walk_page_range_debug() to always check for start >= end and that
  it has safe walk ops, and remove the unnecessary
  walk_kernel_page_table_range() invocation which ultimately does the same
  thing.
* Typo fixups as per Mike.
* Some small commit message/comment wording fixups.

v1:
* vmap/arm64 partial revert series:
  https://patch.msgid.link/20260710-series-vmap-race-fix-v1-0-5b3794c113fe@kernel.org
* CPA patch:
  https://patch.msgid.link/20260710-fix-cpa-ptdump-race-v1-1-d898699a7417@kernel.org
* non-init_mm patch:
  https://patch.msgid.link/20260710-b4-fix-non-init_mm-ptdump-v1-1-2d40982c98ec@kernel.org

To: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
To: "Liam R. Howlett" <liam@infradead.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
To: Toshi Kani <toshi.kani@hpe.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
To: Kiryl Shutsemau <kas@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: ljs@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

---
Lorenzo Stoakes (4):
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
      x86/mm/pat: acquire mmap lock on page table free to avoid ptdump UAF
      mm/ptdump: always stabilise against page table freeing using init_mm
      arm64: remove redundant concurrent ptdump UAF mitigation

 arch/arm64/include/asm/ptdump.h |  2 --
 arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
 arch/arm64/mm/ptdump.c          | 11 ++---------
 arch/x86/mm/pat/set_memory.c    | 14 +++++++++++---
 include/linux/mmap_lock.h       |  1 +
 mm/pagewalk.c                   | 36 ++++++++++++++++++++--------------
 mm/ptdump.c                     |  7 +++++++
 mm/vmalloc.c                    | 41 ++++++++++++++++++++++++++++++---------
 8 files changed, 78 insertions(+), 77 deletions(-)
---
base-commit: 44696aa3a489d2baf58efa61b37833f100072bee
change-id: 20260710-series-vmap-race-fix-2a4cac988938

Cheers,
-- 
Lorenzo Stoakes <ljs@kernel.org>

