Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007C3CC9EA
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486451; cv=pass; b=KJ8DrUfwTMKKVGpoWV6NQ4PiKBKsQjM+VIjOy+aSwaNdl4poCZPploM5zInTOXeSYVp+E7vL7r6uYs33da3NOrCOjHqOKnC+F1psoZxJsRnb0UeCSSg3zzPDguu0/YdmrK00NnMgWb8wYNuJ7v3ETf4d/0XqkNpvgRXte5Zv/YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486451; c=relaxed/simple;
	bh=L4zbznCxGM8DXt+tdYNE6wsDaMkOzLpq8wiG3VRUuCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWYvFzuXAF/H3UkrORkLPPbcNN31npE/fEmXWkqRqbpQeOx02RZ/q12cai5YShFd79JrnpCM4mqtpwn1dZfYdiQN4K+uZONMJkViJcTSZBbWUrb6Oq9t0dt978+vaZg0FXSSXkmpDPWmv0EJ/Mn2uEqz0PIAgqHqE8m1zwTknQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbVEFt8+; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbVEFt8+"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c263415982eso476580766b.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791486445; cv=none;
        d=google.com; s=arc-20260327;
        b=g6nTfD9obHiQKs8CJ47eXw92myQ4mAn/OLDPtHBBvH6EK8R2PlmNUcDjLZS+AzDzZo
         p87HRjsUTmBlCsvBDtg65lKE6m1zlnrHjKgh6AEyks+COuetrgqycg27uGm/ww780BOq
         QPySUACwpecjPVAhneKJcsTaP0m2TEaU5BDK2ZPcR5lOa1+LyGioQCqTAhq0QzDyVC87
         rb7WQCDI7Fe8p8/qD3x3iO5syIW1iTCe1m87Jg7uvA5udDf1+MaH2lXVrbsvIZfZLpJg
         il4Inp5VXYZn4BxnYFpGi1SpIXxSCKynXCO3QZPjMedbiCP2n/4+KDp7rYAslpGEtvuf
         17+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QbfVIrBKW7YCVySdZBaYufzoDh46xjPGGKqhGJkrnf0=;
        fh=1jsqcEjZsJSg7/a9BZkH69bEKRXzXzYH85dVebEm3ic=;
        b=oK/RuU8zDY3Zk6gGCUydr1aCW2DBGn2I82t940Xjw9W7zbHaa8FNxINICU141RxEg2
         eLftl6zSQ9Ly18ImZYNCopLwWcd3utahYwbRo7fB13h+mJsz4ZXkTk5c+WlIPOufxDci
         CKunVDVXJPK/4YU841v11nA42Q4zCge2nv+A92RffswQCD5evJXEWMD9keSccAvML4uL
         L771X0aWxx6kDRgU9qIESeOGqyWul8+ddupReXRNlaYSecFoG5GSmrPYD5Az4eM5XaJw
         j7tc/VvQOjUDp4LMehCVmxUt/9RHU0duitL94PkSeF0UuADtViDHpGTtOZ2zZQBK76sO
         l7xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791486445; x=1792091245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QbfVIrBKW7YCVySdZBaYufzoDh46xjPGGKqhGJkrnf0=;
        b=jbVEFt8+AhHdLa5kdN3/CiSLxYSBKBNHq203IHiBkvejDyeTFbFs/+OuxeUSXULs7g
         T/CA4b6Rus4ghKSzSpC/HL1ZoEJ+d8/hWje5tCUyT3pmVWYwnNhnWo0AgVSOlN8mL7aK
         nrlfpTgWlFOIQgsojOOCCC5TaPQtEExSoO/IaZ7HelB7rbBHP5lzaqwLCLBgH2sQWjr3
         WgBz/ahg4RIcBNfCxP3ZQXKKOYq8V0toCZFnRK7vNJPHlqosSFLeYRje+cA5yYh7/h46
         F1QWPy93PUB9hOFL+kQuOmsjQ2bO01Ww118kS2OiMpzqBR1U8WJ/xUswaULTHb5WHgEn
         XPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486445; x=1792091245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QbfVIrBKW7YCVySdZBaYufzoDh46xjPGGKqhGJkrnf0=;
        b=VyYYoK7K7ehC4Cicl84+ePr9LLFP8Hvt2V1XgIGaepM90aWYkAQKVp+YKOlKsc/ebS
         KDf9eTA755HjRhuCxZPe9gRNEt4IgpERO94nZP9EMA2eY81eUl21ovFIXsxx0Q/fk89p
         wjIXhE811Ia2XAfB0ejZes58jeNRVO641t3+Mxmj2I1r3BfqcC+Y1noeWxNANvrzAklv
         3MBD53za5weGhJ4CrPYD0jDv85dtdpkqQZxGuHTOE5DCPp5RiAz7pjG/ZYn37E4Eowbp
         +WtloMPmS+vjV+JGGcArJLBUC4RJAqR7v3TnDZSLGOiM3qNE5Ai4efLzIES5FoLDUnco
         Y5xA==
X-Forwarded-Encrypted: i=1; AKwUvBwdbdmzWhv4MBbomJKk8uwD59qRq45iIQ4YgrdTNUyr9ZUMaySl/TBRRk2R+j7pXdxSAV7SqCw=@vger.kernel.org
X-Gm-Message-State: AFuF++njemuYOQpgRvgQ9TXmLsR9UtE4L1HoVoVn++D2e8ZrCXjNzbFE
	zFmCLDp7ZDzoD+brhpnU5+d8B6bnSh/w3XFmhkQfsApjEmMMiFcm0N0PNDRblb1SlB9E7QvawNn
	VUbCBMUTskICIraIyAMfaC85jmn4t3X0=
X-Gm-Gg: AYBFou2vDwEYcC2C11sGMIg9tgb/cFCHjnxCFSjO/FHrdMix4iQYRe5S0dFCvtvl2v9
	YyIxKFrlRaXsXUDsjhG5p4bsYq2mO9yfVIFcNFdbh1K5SOxT4MPbRqtxYirfDch7H4qLPiadElz
	NFeuBvWKJ2iII0qve58S1E+9psWpp5j3puwTQbMPOjEUtWYdtNjXKz8kI9B/y3syFT5mlcgGsSy
	dhpgBIsVk82WBu4pJv03QmGGCPI0qy04eIinq/WP6Yx7rG6tB1nRt0FtX3a9cuZEG6LwKwcPuey
	yhc9QbBjiE1NZ7BsaimvxC9XTLICXQU32AotEHuLNQAWkkuskGEu5eVN92dC3RfvkeWSJ03PkmO
	S9fFyO/Gx1z9YNmul7ufTXzle2oMrkAY9TbTxa1r2Ww==
X-Received: by 2002:a17:906:4fc4:b0:c31:5bb8:4b26 with SMTP id
 a640c23a62f3a-c31a6ff943emr5674066b.13.1791486445156; Thu, 08 Oct 2026
 12:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-alpha-hugepages-v2-0-8e108af2d961@gmail.com>
In-Reply-To: <20261007-alpha-hugepages-v2-0-8e108af2d961@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 8 Oct 2026 21:07:13 +0200
X-Gm-Features: AclHuK_V5irsKUE5o6gBUZZUxiQVO75wTAIgxJfWeKIRzSwfCaTS3upD_vTYF64
Message-ID: <CA+=Fv5SrgT-4GchnpVS-xh5aLbWSOMrwMMpLw9QyeiN7pfG00Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] alpha: hugetlb support using granularity hints
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Thu, Oct 8, 2026 at 5:24=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> Alpha has no leaf entry above the last page table level, so the usual
> PMD sized huge page is not available to it. What it does have is the
> granularity hint, bits <6:5> of the PTE, described in Table 22-3 of the
> Alpha Architecture Reference Manual: a hint of order N marks a PTE as
> one of 8^N physically contiguous, naturally aligned pages that the
> translation buffer is permitted to map with a single entry. With 8KB
> pages that gives 64KB, 512KB and 4MB blocks, and this series registers
> all three as hstates.
>
> This works like arm64's contiguous PTE support rather than RISC-V's
> NAPOT: every PTE of a block keeps the frame number of its own page, so a
> block is written with set_ptes() and the frame number advances across
> it. There is no PMD sized huge page, and hence no transparent huge
> pages, no PMD page table sharing and no gigantic pages.
>
> The architecture requires all PTEs of a block to agree in bits <15:0>
> (note 2 of Table 22-3), and both __ACCESS_BITS and __DIRTY_BITS reach
> into that range, so every update rewrites the whole block and
> huge_ptep_get() merges the young and dirty state back together.
> Rewriting a valid block in place would leave its PTEs disagreeing part
> way through, so changes to a valid block go through break before make,
> following the procedure in section 11.6.1. The invalidate there has to
> assume the hint is zero and so must cover every page of the block, which
> flush_tlb_range() on alpha already exceeds, since it rolls the address
> space number.
>
> On SMP, break before make is only as good as the flush: flush_tlb_mm()
> has to reach every CPU that may hold a translation. Magnus Lindholm's
> TLB shootdown series [1] fixes flushes that miss a CPU after fork, under
> lazy TLB, or on the calling CPU, and this series depends on it there.
>
> [1] https://lore.kernel.org/linux-alpha/20260923074903.862898-1-linmag7@g=
mail.com/
>
> The hint is advisory. An implementation that ignores it still translates
> correctly through the individual PTEs, so this is safe on every Alpha,
> and gup_fast needs no changes. The console block that would report which
> hint sizes the translation buffer implements was never filled in by any
> console through EV7, so which sizes an implementation honors can only be
> established by measuring, as the last section does for EV7.
>
> Patches 1 and 2 are independent fixes. Patch 1 adds a
> page_table_check_pte_clear() call missing from alpha's
> ptep_get_and_clear(). Patch 2 fixes a BUG() that testing this series
> turned up: do_page_fault() fell through to BUG() on VM_FAULT_HWPOISON,
> reachable through UFFDIO_POISON without any memory failure support.
> Patch 3 replaces the "xxx" comments on the PTE read and write enable
> bits with their descriptions from Table 22-3. Patches 4 and 5 are
> groundwork and patch 6 is the implementation.
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> Tested on megalith (EV7 Marvel, 8GB), with two CPUs and again with one,
> cross-built with alpha-unknown-linux-gnu-gcc, with CONFIG_DEBUG_VM=3Dy,
> CONFIG_DEBUG_VM_PGTABLE=3Dy, CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy and
> CONFIG_CGROUP_HUGETLB=3Dy. All three hint sizes register as hstates.
>
> mm selftests, the same in both configurations: hugetlb 10/10,
> userfaultfd and cow 7 pass 1 skip (uffd-wp-mremap), 0 fail, including
> uffd-stress hugetlb and hugetlb-private at 128MB/32 threads.
> debug_vm_pgtable validates clean at boot. No page_table_check reports
> and no DEBUG_VM splats in any run.
>
> Ad hoc tests written for this series also pass at all three sizes: dense
> per-base-page write and read back across a block, which catches a wrong
> frame number inside a block that a strided pattern would alias over;
> mprotect down to PROT_READ and back, including a middle-block-only case,
> exercising break before make; fork COW; hugetlbfs shared mappings
> checked through pread and through a second independent mapping; hole
> punch of a middle block with both neighbors and the refaulted hole
> checked; ftruncate down and back up; and the 4MB -> 512KB -> 64KB demote
> chain with exact count checks. All of it again with four concurrent
> copies, and the whole suite ten times in a row.
>
> An earlier revision of the series was also tested on up1500 (EV68AL
> Nautilus, UP, 4GB) with CONFIG_DEBUG_VM=3Dy and
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy. That machine has not been retested
> with this revision.
>
> Magnus Lindholm also tested the series on SMP, on a UP2000+ (2x EV68AL
> 833 MHz), including a multithreaded stress test. It found that
> huge_ptep_set_access_flags() broke and rewrote a block on every fault,
> so two threads on different CPUs could keep each other faulting: 17,316
> faults in 6 seconds after one permission change on a 4MB page. With the
> check now in patch 6 the same change causes one fault. No writes were
> lost with or without it.
>
> Magnus has since run v1 on the UP2000+ again, both as posted and on top
> of [1]: his test script 200 times, the hugetlb, userfaultfd and cow
> selftests (17 pass, 1 skip) and the stress test at all three sizes, with
> no lost writes and at most one fault after a permission change on either
> kernel. v2 changes only comments and changelogs; the code is unchanged.
>
> Hugepage migration is not enabled. It has no test coverage: the
> migration, rmap and ksm selftests do not cross-build for want of libnuma
> in the alpha sysroot, and neither machine is multi-node.
>
> Does the hint do anything?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> On EV7, yes. Since the hint is advisory there is no way to ask the
> hardware whether it implements one, and the console block that would
> report it was never filled in, so the only way to find out is to
> measure.
>
> Comparing the three hint sizes against each other rather than against
> normal pages avoids the hugetlb-versus-anonymous confound. A random
> pointer chase touches one cache line per 8KB base page, with the
> permutation seeded only from the page count, so every backing walks an
> identical sequence over an identical footprint and the only variable is
> how many DTB entries the working set needs. EV6 and EV7 have a 128 entry
> fully associative DTB, so coverage is 128 times the page size: 1MB with
> base pages, 8MB at 64KB, 64MB at 512KB, 512MB at 4MB.
>
> Nanoseconds per access on megalith with one CPU, 8,000,000 accesses per
> pass. Each figure is the best of ten runs, every run on freshly
> allocated memory: single runs differ by 40% or more from one allocation
> to the next, at every page size including base pages, so the best run is
> the one to compare.
>
>      size      base(8KB)       64KB      512KB     4096KB
>       1 MB          11.24      11.11      15.02      11.72
>       4 MB         155.47     104.54     105.03     104.17
>      16 MB         156.69     127.50     109.55     105.52
>      64 MB         154.61     146.79     110.16     105.76
>     256 MB         172.56     171.34     175.74     107.47
>    1024 MB         232.40     230.08     222.15     190.03
>
> Each size keeps its advantage until the working set passes its own
> coverage and then converges on the base page column: 64KB is useful to
> about 8MB, 512KB to about 64MB, 4MB to about 512MB.
>
> Magnus Lindholm reports that EV68AL honors all three hint sizes too. On
> the UP2000+, retired instructions per access, which include the PALcode
> DTB fill, drop to the no-miss level exactly where each size fits the 128
> entry DTB, whose entries can each map 1, 8, 64 or 512 pages (21264/EV67
> Hardware Reference Manual, section 2.1.6.4).
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> Changes in v2:
> - Collect Reviewed-by and Tested-by tags from Magnus Lindholm.
> - Patch 1: say which BUG_ON() the missing call leads to, add Fixes.
> - Patch 2: Cc stable, note that any local user can reach the BUG() and
>   what a backport has to drop.
> - Patch 3: describe the enable bits as the Alpha Linux PTE (Table 22-3)
>   defines them rather than the OpenVMS one, move the 21264 Executive
>   mode detail to the changelog, and retitle to match (Magnus).
> - Patch 4: cite Table 22-3 rather than its Tru64 twin, Table 17-3.
> - Patch 5: name the commits that made the alignment the architecture's
>   job (Magnus).
> - Patch 6: cite note 2 of Table 22-3 as the reason for break before
>   make and section 11.6.1 as the procedure followed, in the changelog
>   and in set_huge_pte_at() (Magnus).
> - Cover letter: state the SMP dependency on the TLB shootdown series,
>   add the UP2000+ results for v1 and the EV68AL hint measurement.
> - Link to v1: https://lore.kernel.org/r/20261006-alpha-hugepages-v1-0-a67=
3a18aaa70@gmail.com
>
> ---
> Matt Turner (6):
>       alpha: add missing page_table_check_pte_clear() to ptep_get_and_cle=
ar()
>       alpha: handle VM_FAULT_HWPOISON in do_page_fault()
>       alpha: describe the PTE read and write enable bits
>       alpha: define granularity hint PTE bits
>       alpha: align hugetlb mappings in arch_get_unmapped_area()
>       alpha: implement hugetlb support
>
>  arch/alpha/Kconfig               |   1 +
>  arch/alpha/include/asm/hugetlb.h |  43 ++++++
>  arch/alpha/include/asm/page.h    |  13 ++
>  arch/alpha/include/asm/pgtable.h |  61 +++++++-
>  arch/alpha/kernel/osf_sys.c      |  14 +-
>  arch/alpha/mm/Makefile           |   2 +
>  arch/alpha/mm/fault.c            |  19 +++
>  arch/alpha/mm/hugetlbpage.c      | 308 +++++++++++++++++++++++++++++++++=
++++++
>  8 files changed, 450 insertions(+), 11 deletions(-)
> ---
> base-commit: e946efcc89066c5d80acbae42d015a4da33a11de
> change-id: 20260912-alpha-hugepages-0c6cb6c0995d
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>

Applied to my for-next

Thanks

Magnus
