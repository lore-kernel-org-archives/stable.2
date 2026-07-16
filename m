Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03129B78F;
	Thu, 16 Jul 2026 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237502; cv=none; b=i61bCPjyD32847HjUDzeLHxBNwddJnK/iDdByWt/YzjT2mxLUNbIpT5sxyLnn83FUdCxh5yHGqDv+kqlOD+PEgUCcrAfMcFlIDOfiAbVyY5QCg8X56FtzVSKHJ0cc/4ZElMMM81eYDuyxJdrNepfsEYoe8KGh4WsOFxDQxIx3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237502; c=relaxed/simple;
	bh=s2DMQxuj+wARf23igrWiIO38QL4W88FsmKaVkqAkZDc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r5EgDGeKqPYr2e1OWHihTt/yMdk4/1K8/zYrnvs2DrByDenLVs6bxRKEByB6EkP5G5ocxn/r7erVpeUzHqv8FQCiTNf8mOESv1mPi+Y+o2FfOesaoB1G+sF0HYgNDIV8qGnVMqACcXvA+oebjmLDXStCMWuS81U/tdymnXKtW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X39vbTHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X39vbTHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601BF1F000E9;
	Thu, 16 Jul 2026 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784237500;
	bh=/XpWjo+CY+i3zkAy1QKBLv4pMUDvus0JmcC9sLptdcY=;
	h=From:Subject:Date:To:Cc;
	b=X39vbTHIYMFqjWMbhlJTCYdjrt43MumW1RZeZzLa+nBT7P/YKhcP4ns9vTIJVD3Yt
	 Y669VoK9Z3V27X9jmusCtQw7RIMhc9YOd5XcEeuCl+LwRQQG2aIY8UK4x9FEBlkS46
	 UDIXlTFlJQ8rRvxqD9lFy/+I0w9uaiMyl10EpLFqTpKA3p3dKChyb8c5T20b32PA+P
	 SQRd1E5FJa1xecrQEIEYJu+NO9+3z69rbj7wNFs9MKmwyPQkQdxskiWzRN7/qqdzfv
	 slu04QvrMtLovoZoPfpAS0ssPuRGWmql2Qs3BCxtGDUDsv6y5M3u6JAUG4z0uWxMQh
	 o7cdD0HB+mpLQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH mm-hotfixes v4 0/4] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Date: Thu, 16 Jul 2026 22:31:11 +0100
Message-Id: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ9NWWoC/33OSQ7CMAwF0KugrDHKBLSsuAdi4RqXBuigpEQg1
 LsT2g0IwfJ7ePZDBPaOg9jMHsJzdMG1TQp2PhNUYXNkcIeUhZZ6JddKwjQPscYOPBJD6W6g0RJ
 SnmW5yURa7Tyn8sjuRF1D1fZT3k/NcC1OTP0Lfo1XLvStv49PRDUu/b8XFUhYFmadW1LKlLw9s
 2/4smj9cbwR9buifyg6KXhQxhIZVBq/FPOu2B+KSUqRKc1EJcoy/1CGYXgCTY3fEWQBAAA=
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
 linux-arm-kernel@lists.infradead.org, "Denis V. Lunev" <den@virtuozzo.com>, 
 stable@vger.kernel.org, 
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8143; i=ljs@kernel.org;
 h=from:subject:message-id; bh=s2DMQxuj+wARf23igrWiIO38QL4W88FsmKaVkqAkZDc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIifVdKqL/L1TM7I+h62WxjkYeI0qaNWyJSvbfP+3BvQ
 2XjXZMtHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiIjRbD//x+3sbbhxK+fyhN
 sAq74X3Zx2Pm/AupE21lYx1OhDednc7w30EwUHN36fqYj6YCvW+F2SW1+6RtUhQXJy8y+L04SbC
 dHQA=
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

There are related issues that we also address in this series:

* x86 page attribute logic, specifically Change Page Attributes (CPA),
  implements a feature whereby huge ranges can be collapsed into huge leaf
  entries. This can similarly cause a UAF when done in parallel with a
  ptdump walk, so similarly acquire the init_mm mmap lock to avoid this.

* The CPA logic also previously allowed concurrent CPA collapse which
  could result in memory corruption. Take the mmap write lock in this code
  path across the whole operation to prevent this.

* x86 and arm64 permit walks of non-kernel mm's (both allowing efi mm
  walks, and in intel's case arbitrary mm's), so we ensure kernel mappings
  remain stable by locking the init_mm as well as the mm being walked.

The ordering of patches is established for both strict dependencies (the
arm64 partial revert in particular has to be done after the vmap changes)
and logical ones (the non-kernel mm fix only makes sense once the vmap/CPA
fixes are in place).

---
v4:
* Rebased on latest master of Linus's tree.
* Accumulated tags, thanks everybody!
* Updated commit messages further as per Kiryl.
* Took the mmap write lock across the whole CPA operation as per Will.

v3:
* Rebased on latest master of Linus's tree.
* Accumulated tags, thanks everybody!
* Reworded commit messages as per Kiryl and Boris.
https://patch.msgid.link/20260714-series-vmap-race-fix-v3-0-b812eccfa0f9@kernel.org

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
https://patch.msgid.link/20260712-series-vmap-race-fix-v2-0-ad134cc3a12a@kernel.org

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
Cc:  "Denis V. Lunev" <den@virtuozzo.com>

---
Lorenzo Stoakes (ARM) (4):
      mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
      x86/mm/pat: acquire init_mm write lock to avoid UAF
      mm/ptdump: always stabilise against page table freeing using init_mm
      arm64: remove redundant concurrent ptdump UAF mitigation

 arch/arm64/include/asm/ptdump.h |  2 --
 arch/arm64/mm/mmu.c             | 43 ++++-------------------------------------
 arch/arm64/mm/ptdump.c          | 11 ++---------
 arch/x86/mm/pat/set_memory.c    | 15 +++++++++++++-
 include/linux/mmap_lock.h       |  3 +++
 mm/pagewalk.c                   | 36 ++++++++++++++++++++--------------
 mm/ptdump.c                     |  7 +++++++
 mm/vmalloc.c                    | 40 +++++++++++++++++++++++++++++---------
 8 files changed, 82 insertions(+), 75 deletions(-)
---
base-commit: e22254e9ddd8020130c4b806b6b4aa77b09c2560
change-id: 20260710-series-vmap-race-fix-2a4cac988938

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

