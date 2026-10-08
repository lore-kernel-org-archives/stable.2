Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D227466A
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429853; cv=none; b=NdbBs6UxvGOk5uI8Les8K8o3fAcJS76/gemf+/mvM1Zlr3kZkG/+lm6DDb4l6AU37BtNfdT3UkMCFXkV3X+tuY0mgVQNKO3fxs+gysSV2KKwI/TFQ97MNxlkeLDfgIuTz+jKvns0CuTlcz/PgUybj007pVuSr4PLg3Qgk6zK9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429853; c=relaxed/simple;
	bh=Vq5SK1jm4LUuxhcXSRHThL4R5vnxbBTVBbTUFu6uFxg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bANHf6ScBRFoW+LvAiL9i045Afc3VgDw/pke38aZkNCY5J+R6nz2nJRG4Gj1KPZQqlYPSsFyaIJrLatqAAozZ7uM8uFHasHh/z8On7djxdgtSsFMOMZrAytrimU0TmYRq7Xkium8JKDCMGa0lGvF3QldSmiAFvIep2up4W0XEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkpwR9IL; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkpwR9IL"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6767d92cde6so2368650d50.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 20:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791429849; x=1792034649; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1QjFS0BxgyDFuUgadRLhJBbfGMZmEd0oyJgkkp9HNNU=;
        b=DkpwR9ILKL8MSypskQDOBIFo3qZ3cpIsPD9rOlsQ9nTKXe5ZclURjbcRNvJG+wjskx
         mHmaWwfcs/ff5OlnItlL6YZdujTv31iA4t4y/9XBDqYS2UEc61krssErpktFCQA88CC7
         zrV9lRl80gAmDnOMCp3s/ioD8SWYdXWXyWQkK/erKQEk1wn32mmLs8N4Uia/XKWFO9BO
         Hv1ZeOY8y3/ruhT9G83trLRSLKAHIvHT7Fg8c5sh7Sc7OE2uglQx6bScJVrXcfMsmXe/
         bVL4c9Jr2ZA35jD+82QntGbxKTnjB/EVyyVf6/ohNfjP0fyAkDpP8kQLv88maPZstAUp
         fA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429849; x=1792034649;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1QjFS0BxgyDFuUgadRLhJBbfGMZmEd0oyJgkkp9HNNU=;
        b=VZiECvkaX9KQ5Yaqlb7eNufw6k+mLHvOpEEDuln4E2ueh4nvkH55DICqAXHXyVaRn7
         a95TABYvZ0HAGgguO9YpLBtrxtF6GYaUW07tyRusmY0FvoEJYWM5lB6LB4QnaBk0bJYv
         WYf7PYTmbpsvqnVMtP3X8TMgMIAQJp9cUPAWqeoaRQhaTrpQ9pfd1xIgkrxyPWqBVwxs
         C7oDvm9BtON/Cyo+omYDN3gaQDFO86ceSMAEDdP5swx/DvogwWwtuvwq9dIz4DwGYgOT
         QLBiZUZqptNkF8ZDyQimLD3tQD744dj54kNuOl8d/gS/sa0pVi7MxFlVKa58XsQbW4Rg
         7duw==
X-Forwarded-Encrypted: i=1; AKwUvBxktnkRZoDIc+ZrZyINdyuAYSGqRjtNuNGsUlCS7rqUSmobMzUpak+20rp+M3b1yCUN9yr2r6U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWqM3Ib2vj3cjk774hgsKfETWiCgYubXVPoJtv4+00zecDB5uZ
	DzD3ud1got3Tdyb9wVnmOypiFFoDHC5HcsgEp5y6j1Wx1O1HAq5Gg97U
X-Gm-Gg: AYBFou0fPeFiVr5O9hIdJVY9EYoNyQttoZAQix0ZzmgDaTPjXdfMEdnW599g+jiOYPw
	ZC7S/1ByehygVaW/I3nGt2yZMlWhzgUHXbEGziAzYA5+wC1I/aZG/9q3IhforxkKkIcz05r2QM8
	equUIxTEXCh/IKc5M1IdSWwYfNmZKtf8qWt7E+mEzUBrH2ePzad3DHiFxCnpsUN3UqXHOMFdFKd
	AxnqO3jhKHvx6wtwKquNJ9C92VIAJ9bv0KEKQ0bI0RlkIE5J0MyjaWxFb+cdUBhfmb+HwxDvaVP
	H/9DmTeEvKd0r9Dd7TIdorNYje4Ke7QaGsKXaRx1HJ2JuPBzDW+PayWEv7T9Y8sXAx5wrR5W5Ur
	p/x1NTyfezKJfCBqDtxWgCuoTYjjAJz2ljpry0rMCLf9mPfpQ+AdNyvsnTOE8gULbJeoGu1GyQP
	FOTQNUKexoqEifc1JQlPMqR3w1aiUVK8nutGIR2QxXhV7/LJvZEv25k8jBaQTWhEC3LKicwB4=
X-Received: by 2002:a05:690e:bc7:b0:677:d93e:edfc with SMTP id 956f58d0204a3-6790a2e3740mr2705585d50.44.1791429848543;
        Wed, 07 Oct 2026 20:24:08 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791b0beed8sm702875d50.17.2026.10.07.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:24:06 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 0/6] alpha: hugetlb support using granularity hints
Date: Wed, 07 Oct 2026 23:24:03 -0400
Message-Id: <20261007-alpha-hugepages-v2-0-8e108af2d961@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNywrCMBBFf6XM2sgkYmpd9T+kizEdk4E+QqJFK
 f13Y7cuz4F77gqZk3CGa7VC4kWyzFMBc6jABZo8K+kLg0FjsdFG0RADqfDyHMlzVuisu1uHTXP
 uoaxi4oe89+KtKxwkP+f02Q8W/bN7SyPav9aiFSqy9Yn0hYhqbP1IMhzdPEK3bdsXpGK8e64AA
 AA=
X-Change-ID: 20260912-alpha-hugepages-0c6cb6c0995d
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9515; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Vq5SK1jm4LUuxhcXSRHThL4R5vnxbBTVBbTUFu6uFxg=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLKO81wRf92mEGobuXJJq47dHXWrasZwKZ/Uxd1JJ78ru
 bPdM43u+MjCIMbFMFNMkSVuvSLLrLYdS31OS/+CmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 gQwdo3iInB6DRmZxcWlqkW5aQZFDXn5JYklmfl6xXn5Bal5BeoFeWmZaSUZGflFxKtAIvbzUElN
 XRzcjQwMTS0cLMycLR1MTZ2cnQyc3R0dnVycjS3MTA2dLRxNXS3MGLk4BmGvWX2D4nyi09GA88/
 nyFS93Oezd6buSfT8/S8T+irq7WXO3RC+S9mBkuHph7rSFT/bc+n7cf+2Lq0/5r9polzSU2Bdz6
 txcw3sriBkA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

Alpha has no leaf entry above the last page table level, so the usual
PMD sized huge page is not available to it. What it does have is the
granularity hint, bits <6:5> of the PTE, described in Table 22-3 of the
Alpha Architecture Reference Manual: a hint of order N marks a PTE as
one of 8^N physically contiguous, naturally aligned pages that the
translation buffer is permitted to map with a single entry. With 8KB
pages that gives 64KB, 512KB and 4MB blocks, and this series registers
all three as hstates.

This works like arm64's contiguous PTE support rather than RISC-V's
NAPOT: every PTE of a block keeps the frame number of its own page, so a
block is written with set_ptes() and the frame number advances across
it. There is no PMD sized huge page, and hence no transparent huge
pages, no PMD page table sharing and no gigantic pages.

The architecture requires all PTEs of a block to agree in bits <15:0>
(note 2 of Table 22-3), and both __ACCESS_BITS and __DIRTY_BITS reach
into that range, so every update rewrites the whole block and
huge_ptep_get() merges the young and dirty state back together.
Rewriting a valid block in place would leave its PTEs disagreeing part
way through, so changes to a valid block go through break before make,
following the procedure in section 11.6.1. The invalidate there has to
assume the hint is zero and so must cover every page of the block, which
flush_tlb_range() on alpha already exceeds, since it rolls the address
space number.

On SMP, break before make is only as good as the flush: flush_tlb_mm()
has to reach every CPU that may hold a translation. Magnus Lindholm's
TLB shootdown series [1] fixes flushes that miss a CPU after fork, under
lazy TLB, or on the calling CPU, and this series depends on it there.

[1] https://lore.kernel.org/linux-alpha/20260923074903.862898-1-linmag7@gmail.com/

The hint is advisory. An implementation that ignores it still translates
correctly through the individual PTEs, so this is safe on every Alpha,
and gup_fast needs no changes. The console block that would report which
hint sizes the translation buffer implements was never filled in by any
console through EV7, so which sizes an implementation honors can only be
established by measuring, as the last section does for EV7.

Patches 1 and 2 are independent fixes. Patch 1 adds a
page_table_check_pte_clear() call missing from alpha's
ptep_get_and_clear(). Patch 2 fixes a BUG() that testing this series
turned up: do_page_fault() fell through to BUG() on VM_FAULT_HWPOISON,
reachable through UFFDIO_POISON without any memory failure support.
Patch 3 replaces the "xxx" comments on the PTE read and write enable
bits with their descriptions from Table 22-3. Patches 4 and 5 are
groundwork and patch 6 is the implementation.

Testing
=======

Tested on megalith (EV7 Marvel, 8GB), with two CPUs and again with one,
cross-built with alpha-unknown-linux-gnu-gcc, with CONFIG_DEBUG_VM=y,
CONFIG_DEBUG_VM_PGTABLE=y, CONFIG_PAGE_TABLE_CHECK_ENFORCED=y and
CONFIG_CGROUP_HUGETLB=y. All three hint sizes register as hstates.

mm selftests, the same in both configurations: hugetlb 10/10,
userfaultfd and cow 7 pass 1 skip (uffd-wp-mremap), 0 fail, including
uffd-stress hugetlb and hugetlb-private at 128MB/32 threads.
debug_vm_pgtable validates clean at boot. No page_table_check reports
and no DEBUG_VM splats in any run.

Ad hoc tests written for this series also pass at all three sizes: dense
per-base-page write and read back across a block, which catches a wrong
frame number inside a block that a strided pattern would alias over;
mprotect down to PROT_READ and back, including a middle-block-only case,
exercising break before make; fork COW; hugetlbfs shared mappings
checked through pread and through a second independent mapping; hole
punch of a middle block with both neighbors and the refaulted hole
checked; ftruncate down and back up; and the 4MB -> 512KB -> 64KB demote
chain with exact count checks. All of it again with four concurrent
copies, and the whole suite ten times in a row.

An earlier revision of the series was also tested on up1500 (EV68AL
Nautilus, UP, 4GB) with CONFIG_DEBUG_VM=y and
CONFIG_PAGE_TABLE_CHECK_ENFORCED=y. That machine has not been retested
with this revision.

Magnus Lindholm also tested the series on SMP, on a UP2000+ (2x EV68AL
833 MHz), including a multithreaded stress test. It found that
huge_ptep_set_access_flags() broke and rewrote a block on every fault,
so two threads on different CPUs could keep each other faulting: 17,316
faults in 6 seconds after one permission change on a 4MB page. With the
check now in patch 6 the same change causes one fault. No writes were
lost with or without it.

Magnus has since run v1 on the UP2000+ again, both as posted and on top
of [1]: his test script 200 times, the hugetlb, userfaultfd and cow
selftests (17 pass, 1 skip) and the stress test at all three sizes, with
no lost writes and at most one fault after a permission change on either
kernel. v2 changes only comments and changelogs; the code is unchanged.

Hugepage migration is not enabled. It has no test coverage: the
migration, rmap and ksm selftests do not cross-build for want of libnuma
in the alpha sysroot, and neither machine is multi-node.

Does the hint do anything?
==========================

On EV7, yes. Since the hint is advisory there is no way to ask the
hardware whether it implements one, and the console block that would
report it was never filled in, so the only way to find out is to
measure.

Comparing the three hint sizes against each other rather than against
normal pages avoids the hugetlb-versus-anonymous confound. A random
pointer chase touches one cache line per 8KB base page, with the
permutation seeded only from the page count, so every backing walks an
identical sequence over an identical footprint and the only variable is
how many DTB entries the working set needs. EV6 and EV7 have a 128 entry
fully associative DTB, so coverage is 128 times the page size: 1MB with
base pages, 8MB at 64KB, 64MB at 512KB, 512MB at 4MB.

Nanoseconds per access on megalith with one CPU, 8,000,000 accesses per
pass. Each figure is the best of ten runs, every run on freshly
allocated memory: single runs differ by 40% or more from one allocation
to the next, at every page size including base pages, so the best run is
the one to compare.

     size      base(8KB)       64KB      512KB     4096KB
      1 MB          11.24      11.11      15.02      11.72
      4 MB         155.47     104.54     105.03     104.17
     16 MB         156.69     127.50     109.55     105.52
     64 MB         154.61     146.79     110.16     105.76
    256 MB         172.56     171.34     175.74     107.47
   1024 MB         232.40     230.08     222.15     190.03

Each size keeps its advantage until the working set passes its own
coverage and then converges on the base page column: 64KB is useful to
about 8MB, 512KB to about 64MB, 4MB to about 512MB.

Magnus Lindholm reports that EV68AL honors all three hint sizes too. On
the UP2000+, retired instructions per access, which include the PALcode
DTB fill, drop to the no-miss level exactly where each size fits the 128
entry DTB, whose entries can each map 1, 8, 64 or 512 pages (21264/EV67
Hardware Reference Manual, section 2.1.6.4).

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
Changes in v2:
- Collect Reviewed-by and Tested-by tags from Magnus Lindholm.
- Patch 1: say which BUG_ON() the missing call leads to, add Fixes.
- Patch 2: Cc stable, note that any local user can reach the BUG() and
  what a backport has to drop.
- Patch 3: describe the enable bits as the Alpha Linux PTE (Table 22-3)
  defines them rather than the OpenVMS one, move the 21264 Executive
  mode detail to the changelog, and retitle to match (Magnus).
- Patch 4: cite Table 22-3 rather than its Tru64 twin, Table 17-3.
- Patch 5: name the commits that made the alignment the architecture's
  job (Magnus).
- Patch 6: cite note 2 of Table 22-3 as the reason for break before
  make and section 11.6.1 as the procedure followed, in the changelog
  and in set_huge_pte_at() (Magnus).
- Cover letter: state the SMP dependency on the TLB shootdown series,
  add the UP2000+ results for v1 and the EV68AL hint measurement.
- Link to v1: https://lore.kernel.org/r/20261006-alpha-hugepages-v1-0-a673a18aaa70@gmail.com

---
Matt Turner (6):
      alpha: add missing page_table_check_pte_clear() to ptep_get_and_clear()
      alpha: handle VM_FAULT_HWPOISON in do_page_fault()
      alpha: describe the PTE read and write enable bits
      alpha: define granularity hint PTE bits
      alpha: align hugetlb mappings in arch_get_unmapped_area()
      alpha: implement hugetlb support

 arch/alpha/Kconfig               |   1 +
 arch/alpha/include/asm/hugetlb.h |  43 ++++++
 arch/alpha/include/asm/page.h    |  13 ++
 arch/alpha/include/asm/pgtable.h |  61 +++++++-
 arch/alpha/kernel/osf_sys.c      |  14 +-
 arch/alpha/mm/Makefile           |   2 +
 arch/alpha/mm/fault.c            |  19 +++
 arch/alpha/mm/hugetlbpage.c      | 308 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 450 insertions(+), 11 deletions(-)
---
base-commit: e946efcc89066c5d80acbae42d015a4da33a11de
change-id: 20260912-alpha-hugepages-0c6cb6c0995d

Best regards,
-- 
Matt Turner <mattst88@gmail.com>

