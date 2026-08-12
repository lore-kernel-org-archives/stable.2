Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E064445628F;
	Wed, 12 Aug 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542392; cv=none; b=XRqjAFk/rq9p3YUqAs9y/VXKubIjOJGgl/54y0LoIqOJQ9qE3n6GTb7Gyj04A7IfMQ5+7gZZfpi4GkMjGlrcz7cnZWMEToHrLvp1Mf8yCOJyiXIt8pRWwHcMZTDwUYhtq7D9Rnu+BknO7v8GfQs3li0Vr5iKrnBm44tmB3PcE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542392; c=relaxed/simple;
	bh=d6CFgm9ThDI74C5UpE0AaMmYwSV538IKMaCXrd5hQp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGrHHoHoTFlESGCP8uf4kcngVOETbPIzx4F9+RHylJ+oNNr20Pwf/ac0wxHVVMz0AVbxNVUPvQfn5Or0e0oDq3PA0UujTUQLn6VL1S2czRRGRvYskW5F6slszeW+R2sq6Z5zKrooXUVp2Hq+zTXE3K2DefN0yEhLRQDt6U0/w7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/XwHSDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/XwHSDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF67A1F00A3D;
	Wed, 12 Aug 2026 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786542390;
	bh=3sp0BNJKgir4wziOWxyB3nibDSrXXlF/m0GwaxwJDoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j/XwHSDDlSeIfFJkwG+03RnS1FIDWCvalaj6TTMs9rirdJk8Xj+nPHaGkq+b+fLoh
	 ygXhpCrNkZdM7uGIQHeW88B1speKaGqBlG01SE8kh8cJb+uDyzgiAVcljlW506ZpiY
	 nHOxFIaPczrGkmhFBxtISWT9g10oUFpZKiUSQNbXFUQmYOzxw33it0XXiO/0yqrbRB
	 MDPT3LCZ6X43BmuAF5gmtzyzNAgRpyULCZ1xUPw+xybHn8mZFDkdXa4psyDC9bMwby
	 eTvlLhpK2k+EBw4SrbaOnUc2AEHeZcY1xVuI9pK+bLo3wv/2XcZi9HG2DCv0V5l0lc
	 wFGqJ1/M2YreQ==
Date: Wed, 12 Aug 2026 14:46:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jintack Lim <jintack.lim@linaro.org>, 
	Christoffer Dall <christoffer.dall@linaro.org>, Christoffer Dall <christoffer.dall@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: Fix spurious warning for benign stage 2
 teardown race
Message-ID: <anx42VidDlhWKBYt@gremlin>
References: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
 <20260812-kvm-arm-nested-virt-fix-v1-1-4ad883f1b6a5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-kvm-arm-nested-virt-fix-v1-1-4ad883f1b6a5@kernel.org>

The splats:

------------[ cut here ]------------
WARNING: arch/arm64/kvm/mmu.c:336 at __unmap_stage2_range+0x64/0x80, CPU#5: kcompactd0/66
...
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Apple Inc. Mac14,7/J493, BIOS 2026.04 04/01/2026
pstate: 61401009 (nZCv daif +PAN -UAO -TCO +DIT +SSBS BTYPE=--)
pc : __unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3))
lr : __unmap_stage2_range (arch/arm64/kvm/mmu.c:336 (discriminator 5))
sp : ffff8000856e7450
x29: ffff8000856e7450 x28: ffff0000404b2000 x27: 0000000000000030
x26: ffffffffffffffe0 x25: 0000000000000001 x24: ffff00000eaa5920
x23: ffff0000404b2000 x22: 0000000000000000 x21: 0000000000000040
x20: 0000000000000001 x19: 0000000000000001 x18: 0000000000000006
x17: 0000000000000000 x16: 0000000000000002 x15: ffff800083adbed0
x14: ffff800083adbed0 x13: 0000000000000008 x12: 0000b00000000000
x11: 0000000000000001 x10: 0000006000000000 x9 : ffff8000817334fc
x8 : 0000000000200000 x7 : ffff0000c59ea000 x6 : 0000000000000800
x5 : 0000000038000000 x4 : 0000000000000000 x3 : ffff0000404b2000
x2 : 0000000000000001 x1 : 0000000038000000 x0 : 00000000ffffffea
Call trace:
__unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3)) (P)
kvm_stage2_unmap_range (arch/arm64/kvm/mmu.c:346)
kvm_nested_s2_unmap (arch/arm64/kvm/nested.c:1168 (discriminator 14))
kvm_unmap_gfn_range (arch/arm64/kvm/mmu.c:2416)
kvm_mmu_notifier_invalidate_range_start (arch/arm64/kvm/../../../virt/kvm/kvm_main.c:718 (discriminator 32768) arch/arm64/kvm/../../../virt/kvm/kvm_main.c:633 (discriminator 32768) arch/arm64/kvm/../../../virt/kvm/kvm_main.c:765 (discriminator 32768))
mn_hlist_invalidate_range_start (mm/mmu_notifier.c:525)
__mmu_notifier_invalidate_range_start (mm/mmu_notifier.c:580)
try_to_migrate_one (./include/linux/mmu_notifier.h:478 ./include/linux/mmu_notifier.h:471 mm/rmap.c:2459)
rmap_walk_anon (mm/rmap.c:3001)
rmap_walk (mm/rmap.c:3106 mm/rmap.c:3101)
try_to_migrate (mm/rmap.c:2774)
migrate_folio_unmap (mm/migrate.c:1330 (discriminator 3))
migrate_pages_batch (mm/migrate.c:1909)
migrate_pages_sync (mm/migrate.c:2026)
migrate_pages (mm/migrate.c:2135)
compact_zone (mm/compaction.c:2663)
compact_node (mm/compaction.c:2932)
kcompactd (mm/compaction.c:3230)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/arm64/kernel/entry.S:858)
---[ end trace 0000000000000000 ]---

------------[ cut here ]------------
WARNING: arch/arm64/kvm/mmu.c:336 at __unmap_stage2_range+0x64/0x80, CPU#5: kcompactd0/66
...
Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
Hardware name: Apple Inc. Mac14,7/J493, BIOS 2026.04 04/01/2026
pstate: 61401009 (nZCv daif +PAN -UAO -TCO +DIT +SSBS BTYPE=--)
pc : __unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3))
lr : __unmap_stage2_range (arch/arm64/kvm/mmu.c:336 (discriminator 5))
sp : ffff8000856e7450
x29: ffff8000856e7450 x28: ffff0000404b2000 x27: 0000000000000030
x26: ffffffffffffffe0 x25: 0000000000000001 x24: ffff00000eaa5920
x23: ffff0000404b2000 x22: 0000000000000001 x21: 0000000000000040
x20: 0000000000000001 x19: 0000000000000001 x18: 0000000000000006
x17: 0000000000000000 x16: 0000000000000002 x15: ffff800083adbed0
x14: ffff800083adbed0 x13: 0000000000000008 x12: 0000b00000000000
x11: 0000000000000001 x10: 0000006000000000 x9 : ffff8000817334fc
x8 : 0000000000200000 x7 : ffff0000c59ea078 x6 : 0000000000000800
x5 : 0000000002000000 x4 : 0000000000000000 x3 : ffff0000404b2000
x2 : 0000000000000001 x1 : 0000000002000000 x0 : 00000000ffffffea
Call trace:
__unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3)) (P)
kvm_stage2_unmap_range (arch/arm64/kvm/mmu.c:346)
kvm_nested_s2_unmap (arch/arm64/kvm/nested.c:1168 (discriminator 14))
kvm_unmap_gfn_range (arch/arm64/kvm/mmu.c:2416)
kvm_mmu_notifier_invalidate_range_start (arch/arm64/kvm/../../../virt/kvm/kvm_main.c:718 (discriminator 32768) arch/arm64/kvm/../../../virt/kvm/kvm_main.c:633 (discriminator 32768) arch/arm64/kvm/../../../virt/kvm/kvm_main.c:765 (discriminator 32768))
mn_hlist_invalidate_range_start (mm/mmu_notifier.c:525)
__mmu_notifier_invalidate_range_start (mm/mmu_notifier.c:580)
try_to_migrate_one (./include/linux/mmu_notifier.h:478 ./include/linux/mmu_notifier.h:471 mm/rmap.c:2459)
rmap_walk_anon (mm/rmap.c:3001)
rmap_walk (mm/rmap.c:3106 mm/rmap.c:3101)
try_to_migrate (mm/rmap.c:2774)
migrate_folio_unmap (mm/migrate.c:1330 (discriminator 3))
migrate_pages_batch (mm/migrate.c:1909)
migrate_pages_sync (mm/migrate.c:2026)
migrate_pages (mm/migrate.c:2135)
compact_zone (mm/compaction.c:2663)
compact_node (mm/compaction.c:2932)
kcompactd (mm/compaction.c:3230)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/arm64/kernel/entry.S:858)
---[ end trace 0000000000000000 ]---

------------[ cut here ]------------
WARNING: arch/arm64/kvm/mmu.c:336 at __unmap_stage2_range+0x64/0x80, CPU#5: kcompactd0/66
...
Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
Hardware name: Apple Inc. Mac14,7/J493, BIOS 2026.04 04/01/2026
pstate: 61401009 (nZCv daif +PAN -UAO -TCO +DIT +SSBS BTYPE=--)
pc : __unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3))
lr : __unmap_stage2_range (arch/arm64/kvm/mmu.c:336 (discriminator 5))
sp : ffff8000856e7450
x29: ffff8000856e7450 x28: ffff0000404b2000 x27: 0000000000000030
x26: ffffffffffffffe0 x25: 0000000000000001 x24: ffff00000eaa5920
x23: ffff0000404b2000 x22: 0000000000000002 x21: 0000000000000040
x20: 0000000000000001 x19: 0000000000000001 x18: 0000000000000006
x17: 0000000000000000 x16: 0000000000000002 x15: ffff800083adbed0
x14: ffff800083adbed0 x13: 0000000000000008 x12: 0000b00000000000
x11: 0000000000000001 x10: 0000006000000000 x9 : ffff8000817334fc
x8 : 0000000000200000 x7 : ffff0000c59ea0f0 x6 : 0000000000000800
x5 : 0000000002000000 x4 : 0000000000000000 x3 : ffff0000404b2000
x2 : 0000000000000001 x1 : 0000000002000000 x0 : 00000000ffffffea
Call trace:
__unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3)) (P)
kvm_stage2_unmap_range (arch/arm64/kvm/mmu.c:346)
kvm_nested_s2_unmap (arch/arm64/kvm/nested.c:1168 (discriminator 14))
kvm_unmap_gfn_range (arch/arm64/kvm/mmu.c:2416)
kvm_mmu_notifier_invalidate_range_start (arch/arm64/kvm/../../../virt/kvm/kvm_main.c:718 (discriminator 32768) arch/arm64/kvm/../../../virt/kvm/kvm_main.c:633 (discriminator 32768) arch/arm64/kvm/../../../virt/kvm/kvm_main.c:765 (discriminator 32768))
mn_hlist_invalidate_range_start (mm/mmu_notifier.c:525)
__mmu_notifier_invalidate_range_start (mm/mmu_notifier.c:580)
try_to_migrate_one (./include/linux/mmu_notifier.h:478 ./include/linux/mmu_notifier.h:471 mm/rmap.c:2459)
rmap_walk_anon (mm/rmap.c:3001)
rmap_walk (mm/rmap.c:3106 mm/rmap.c:3101)
try_to_migrate (mm/rmap.c:2774)
migrate_folio_unmap (mm/migrate.c:1330 (discriminator 3))
migrate_pages_batch (mm/migrate.c:1909)
migrate_pages_sync (mm/migrate.c:2026)
migrate_pages (mm/migrate.c:2135)
compact_zone (mm/compaction.c:2663)
compact_node (mm/compaction.c:2932)
kcompactd (mm/compaction.c:3230)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/arm64/kernel/entry.S:858)
---[ end trace 0000000000000000 ]---

--

Also I wrote something extra but dropped from the already-far-too-long commit
msg but the registers match the diagnosis, basically:

--

The observed assembly from the splats is consistent with this analysis:

Examining the assembly for stage2_apply_range() loop and pgt check,
conveniently x1 contains the current IPA being examined (addr) and is not
clobbered on return:

	mov  x1, x19			addr = next
	ldr  x0, [x26, #16]		struct kvm_pgtable *pgt = mmu->pgt;
	cbnz x0, ...			if (!pgt)...
	ldp  x19, x20, [sp, #16]	}
	mov  w0, #0xffffffea		} return -EINVAL
	ret				}

Splat 1 has x1 of 0x38000000 which tells us the splat occurred 27 * 32 MiB
or 864 MiB into the nested guest physical address space (27 iterations).

This is consistent with an an interleaving stage 2 tear down occurring
part-way through this operation.

There being 2 other splats is consistent with there being a total of 3
nested mmus, as expected, and that the mmu is invalidated before the
warning can occur.

The remaining 2 have x1 equal to 0x2000000 or exactly 32 MiB, which is what
you would expect with the stage2_apply_range() and
kvm_arch_flush_shadow_all() running in lockstep across mmus:

	     kvm_unmap_gfn_range()       | kvm_arch_flush_shadow_all()
	---------------------------------|----------------------------
	< kvm->mmu_lock held >           |
	stage2_apply_range()             |
	  .. 26 successful iterations .. | < contend kvm->mmu_lock >
	  < releases kvm->mmu lock >     | < acquires kvm->mmu_lock >
	                                 | mmu->pgt = NULL
	                                 | < releases kvm->mmu_lock >

Then 3 occurrences of:

	  < reacquires kvm->mmu_lock >   |
	return to __unmap_stage2_range() |
	  WARN_ON(-EINVAL);              |
        mmu = &kvm->arch.nested_mmus[1]; |
	stage2_apply_range()             |
	  .. 1 successful iteration ..   |
	  < releases kvm->mmu lock >     | < contend kvm->mmu_lock >
					 | < acquires kvm->mmu_lock >
					 | mmu->pgt = NULL
					 | < releases kvm->mmu_lock >

One single iteration sets addr = next = 0x2000000 which is reflected in the
splats.

Finally, in kvm_nested_s2_unmap() the disassembly indicates that w22
maintains the i counter, which happens not to be clobbered over the
operation either:

	mov  w22, #0x0		for (i = 0;
	add  w22, w22, #0x1     	                 ; i++)
	sxtw x2, w22		}
	cmp  x2, x1		}    i < nested_mmus_size

The splats have w22 equal to 0, 1 and 2 respectively which further
corroborates this analysis.

--
Cheers, Lorenzo
