Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C1489892;
	Thu, 13 Aug 2026 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634711; cv=none; b=FQrNSc5iZ/xdwOafpm7BRG72Z0D+p3/vP2r0R3xKiqDooz97CrXmcJjVOIjGUZIjr4dxLZNQK05djREjZi9ZUfe8BTpHCHgW8VBD9Be+60oeHa+SIug9s6ygbtzepS0Y6UHl8z5Tzg+EUo9IkYv6DOJTW7WWanDgX7jL3YWvAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634711; c=relaxed/simple;
	bh=kQozxNKGHZ1GnTNpHrg15veJkJB7tAok2GxZVqn+kpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCxKo2mQYmiyunYYIQUUrB+2jX/zgZJeN6y5ac0sNNguvJtbEygoaN998XNEn/EtT5n1ieouuTa1f1U7R1d1O19T4t4jA4uI18z1ZxJoHGBbhcIqHN1P4jsFHvPbnh+dS7meVhVcq3rGjUD029UlYD2mbHuB8qK/QKT4H7+PR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtHjOlom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtHjOlom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5061F00A3A;
	Thu, 13 Aug 2026 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634710;
	bh=sYSZsb+cjRbFmXXNbYjzkQ1QslgmWjmFaOwQT/Bodys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DtHjOlome/8+yJItZ5HleqQ3D66/ETJ8PcGfxGsTSbeiumeS56uVSXNvlSESZFbyO
	 SEskx2Na3oQn7YaPvQro11zSK+5ApidXqIwe/Y4z2KqZJYOnrPqodxxxfTfvbK7sJy
	 jxRl6VaeUF2y1SLA0h5jBmxJGGqey3HwMzD6tZgr175eLZR3PNxiLmorWyyAdW5uoA
	 ZQ6WO5KKUsH5VxjNuW6pMzjQzRDYT/RfipINQwgcuk9rX/Y845xbp7UM83XJGPo6an
	 1F5ofQlQjzEcPK6YMpBZm7dD6sbIuQFUW2Be8nbUaZydB8ketke7dHd8eVZPIN0+RE
	 q/pGAp/pvbZUA==
Date: Thu, 13 Aug 2026 16:24:49 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jintack Lim <jintack.lim@linaro.org>, 
	Christoffer Dall <christoffer.dall@linaro.org>, Christoffer Dall <christoffer.dall@arm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: Fix spurious warning for benign stage 2
 teardown race
Message-ID: <an3gqCJ1fzloWB_N@lucifer>
References: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
 <20260812-kvm-arm-nested-virt-fix-v1-1-4ad883f1b6a5@kernel.org>
 <qfhlmmidzdmmsfopfhxpddgwa7nob45jwgb6sabskawaxtox7i@mnxplk3zn34k>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qfhlmmidzdmmsfopfhxpddgwa7nob45jwgb6sabskawaxtox7i@mnxplk3zn34k>

On Thu, Aug 13, 2026 at 12:20:43AM +0100, Wei-Lin Chang wrote:
> Hi Lorenzo,
>
> Thanks for the detailed analysis!

You're welcome :)

>
> I can follow what's happening from the report, but one thing I don't
> get:
>
> On Wed, Aug 12, 2026 at 02:31:20PM +0100, Lorenzo Stoakes (ARM) wrote:
> > A batch of kernel warnings were triggered in the L0 host kernel when using
> > kvmtool to experiment with nested virtualisation.
> >
> > The issue was observed on an M2 macbook pro with 24 GiB of RAM running
> > asahi linux 7.1.6-400.asahi.fc44.aarch64+16k with 16 KiB page size.
> >
> > The bug is confirmed to exist in mainline and does not appear to be
> > impacted by any downstream patches carried by asahi.
> >
> > kvmtool was used to establish an L1 guest with 8 CPUs and 8 GiB of RAM.
> >
> > kvmtool was then run again within the L1 guest to establish an L2 guest
> > with 4 CPUs and 4 GiB of RAM.
> >
> > Then it was run again to establish another inner guest with 2 CPUs and 2
> > GiB of RAM at L3.
> >
> > Both the L2 and L3 guests were then exited and another L2 guest was
> > established with the same characteristics.
> >
> > Sufficient memory pressure was present in the L0 host to trigger indirect
> > reclaim, waking kcompactd up and triggering migration.
> >
> > Shortly afterwards the L2 guest was stopped, at which point three warnings
> > were observed in the L0 host in quick succession with the second and the
> > third occurring 114us and 189us after the first, respectively.
> >
> > In each case the call trace was the same:
> >
> > WARNING: arch/arm64/kvm/mmu.c:336 at __unmap_stage2_range+0x64/0x80,
> > CPU#5: kcompactd0/66
> > ...
> > __unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3)) (P)
> > kvm_stage2_unmap_range (arch/arm64/kvm/mmu.c:346)
> > kvm_nested_s2_unmap (arch/arm64/kvm/nested.c:1168 (discriminator 14))
> > kvm_unmap_gfn_range (arch/arm64/kvm/mmu.c:2416)
> > kvm_mmu_notifier_invalidate_range_start (arch/arm64/kvm/../../../virt/kvm/kvm_main.c:718 ...)
> > mn_hlist_invalidate_range_start (mm/mmu_notifier.c:525)
> > __mmu_notifier_invalidate_range_start (mm/mmu_notifier.c:580)
> > try_to_migrate_one (./include/linux/mmu_notifier.h:478 ./include/linux/mmu_notifier.h:471 mm/rmap.c:2459)
> > rmap_walk_anon (mm/rmap.c:3001)
> > rmap_walk (mm/rmap.c:3106 mm/rmap.c:3101)
> > try_to_migrate (mm/rmap.c:2774)
> > migrate_folio_unmap (mm/migrate.c:1330 (discriminator 3))
> > migrate_pages_batch (mm/migrate.c:1909)
> > migrate_pages_sync (mm/migrate.c:2026)
> > migrate_pages (mm/migrate.c:2135)
> > compact_zone (mm/compaction.c:2663)
> > compact_node (mm/compaction.c:2932)
> > kcompactd (mm/compaction.c:3230)
> > kthread (kernel/kthread.c:436)
> > ret_from_fork (arch/arm64/kernel/entry.S:858)
> >
> > Analysing this:
> >
> > try_to_migrate() performs the first part of migration on a folio -
> > establishing migration entries in all page tables mapping it - calling
> > try_to_migrate_one() for each VMA the folio is mapped in.
> >
> > Immediately prior to installing the migration entry, try_to_migrate_one()
> > calls mmu_notifier_invalidate_range_start() to signal to notifiers that the
> > existing page table entry is about to be unmapped.
> >
> > Since this range happened to contain folios used by the virtual machine
> > (given its memory consumption this was highly likely to be a target) this
> > in turn triggers arm64 kvm code via an MMU notifier:
> >
> > mmu_notifier_invalidate_range_start()
> >   -> ... -> kvm_mmu_notifier_invalidate_range_start()
> >     -> kvm_mmu_unmap_gfn_range()
> >       -> kvm_unmap_gfn_range()
> >         -> kvm_nested_s2_unmap()
> >           -> kvm_stage2_unmap_range()
> >             -> __unmap_stage2_range()
> >                -> stage2_apply_range()
> >        	       <- -EINVAL, triggering a WARN_ON()
> >
> > Since commit ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page
> > tables") kvm_unmap_gfn_range() invokes kvm_nested_s2_unmap() which takes
> > the rather drastic step of evicting the entirety of the stage 2 shadow page
> > tables for each nested guest:
> >
> > 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
> > 		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
> >
> > 		if (kvm_s2_mmu_valid(mmu))
> > 			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
> > 	}
> >
> > This will iterate through every valid MMU.
> >
> > mmu_notifier_invalidate_range_start() sets the MMU_NOTIFIER_RANGE_BLOCKABLE
> > flag when signalling notifiers, so may_block is true here.
> >
> > __unmap_stage2_range() wraps invocation of stage2_apply_range() in a
> > WARN_ON():
> >
> > 	WARN_ON(stage2_apply_range(mmu, start, end, KVM_PGT_FN(kvm_pgtable_stage2_unmap),
> > 				   may_block));
> >
> > Which is precisely the triggered warning and means stage2_apply_range() is
> > returning an error.
> >
> > In arm64 return values are stored in the x0 register and in each splat w0
> > (since it's a 32-bit value) is 0xffffffea which, by two's complement, is
> > -0b00010110 or -EINVAL.
> >
> > The only way in which stage2_apply_range() can return an error is if either
> > the passed in walk function (kvm_pgtable_stage2_unmap()) returns an error
> > or mmu->pgt is NULL:
> >
> > 	static int stage2_apply_range(...)
> > 	{
> > 		do {
> > 			struct kvm_pgtable *pgt = mmu->pgt;
> > 			if (!pgt)
> > 				return -EINVAL;
> >
> > 			next = stage2_range_addr_end(addr, end);
> > 			ret = fn(pgt, addr, next - addr);
> > 			if (ret)
> > 				break;
> > 			if (resched && next != end)
> > 				cond_resched_rwlock_write(&kvm->mmu_lock);
> > 		} while (addr = next, addr != end);
> >
> > 		return ret;
> > 	}
> >
> > This loop is batched by stage2_range_addr_end() at the granularity of
> > kvm_granule_size(KVM_PGTABLE_MIN_BLOCK_LEVEL), which for a 16 KiB page size
> > kernel is 32 MiB.
> >
> > kvm_pgtable_stage2_unmap() only returns an error if
> > kvm_pgtable_walk_begin() or _kvm_pgtable_walk() return an error. On arm64
> > the former doesn't ever do so, and the latter only returns -EINVAL if
> > either pgd is NULL (we gate that already) or an invalid pgt->start_level is
> > specified (not the case).
> >
> > So the cause of the warning is that mmu->pgt is NULL here.
> >
> > This field is protected by kvm->mmu_lock, but after each invocation of the
> > walk function, if the end of the range has not yet been reached, the lock
> > is dropped.
> >
> > This is done by calling cond_resched_rwlock_write() which drops
> > kvm->mmu_lock when yielding the time slice before reacquiring it upon being
> > scheduled again:
> >
> > 		if (resched && next != end)
> > 			cond_resched_rwlock_write(&kvm->mmu_lock);
> >
> > Note that resched = may_block here and is always true for these walks.
> >
> > This points to something else racing this code to clearing the pgt, and
> > brings us back to the observation above that the issue occurs when tearing
> > down the L2 guest.
> >
> > Upon L0's userspace mm_struct teardown, stage 2 mappings for IPAs mapped by

s/L0/L2/

> > the guest are unmapped via mmu notifier:
> >
> > exit_mm()
> >   -> mmput()
> >     -> __mmput()
> >       -> exit_mmap()
> >         -> mmu_notifier_release()
> > 	  -> ... -> kvm_mmu_notifier_release()
> >             -> kvm_flush_shadow_all()
> >               -> kvm_arch_flush_shadow_all()
> > 	        -> kvm_free_stage2_pgd()
> > 		  -> [ acquire kvm->mmu_lock for write ]
> > 		  -> mmu->pgt = NULL [ among other tasks ]
> > 		  -> [ release kvm->mmu_lock for write ]
>
> You mentioned stopping the L2 VM only, which means L1 is still running.
> Why would the L0 userspace mm_struct get torn down if L1 is still live?
> What did I miss?

Ah yeah this is a mistake sorry :) It should say L2 teardown.

The stuff relevant to L0 is the MMU notifier bit.

>
> Thanks,
> Wei-Lin Chang
>
> [...]

--
Cheers, Lorenzo
