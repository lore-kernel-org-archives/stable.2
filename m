Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB20D33BBCF;
	Sat, 22 Aug 2026 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787420834; cv=none; b=DoYQB16eIj+hoxPtgiKgcqw3aaSN4gYi30GYz5Wa6v0row331kH4pL/xb16bf7z/HVTNaEQKRV/6pzWXhTS49BaPy/xY19n+jCmZ3xk1DXjaehycEm1sCX7EDPRFTxv3FjNgCDryepGEHpjAvO52PTEr8ICQiU5Cgac4qJsljaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787420834; c=relaxed/simple;
	bh=8LNmGXzlmgxMWU1FepZ/orH8subma92NfOqYuZvssUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1HnubI/ixp7rrFVZbfOpikiv6OfkDJ8CmWsgmbQQ3v6qwU+uABmbI3MG+f7lGw3CITwgSit85Apbi2zP6gNGT87FaNXtSPZQua5dnwnXifT1eynu2K2VxCctCvDoXa2D43VkRDZGKhHGcEnliTiygKk6GUdxxfijyn4/2sQqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf8k3Gs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf8k3Gs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EB11F00A3E;
	Sat, 22 Aug 2026 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787420832;
	bh=d7wGI6rY14jaaHYUxcqFHLnsSsbhaMKq2yfxDsNBo5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nf8k3Gs6QeTLL3pinx6bwjZIfnxGRSuu3DrIW4TU4bR6ZaTkw8JLLp2tc07LHNwwj
	 xn8ESLycIGcB92zPeZrb4EC26p63Ip3+Fps0gqyUXv6DmKDQys7ovYTW/TprPzvOHf
	 Dj4SNR5FPcOI1pSUabYbsvtIckg1LstqmrrljShDE9utbzRvyfD/Uwh7AAWGaEq/Fe
	 bL23sSkAGrXmxJ3vF/+mKeWkquu4K22i9G/ugkNuDxkA8hFYVOp2APE90KD7cZ4v4P
	 2DLbDEOgkiHaIiMGdEblHFP2R6epkfbqD6OpH+5zHhAYW7arVn8Pavqricdc3NHvnb
	 OM7iBudbYoKWA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 22 Aug 2026 18:46:53 +0100
Subject: [PATCH v2 1/2] KVM: arm64: Fix spurious warning for benign stage 2
 teardown race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kvm-arm-nested-virt-fix-v2-1-ac4059a0eaa6@kernel.org>
References: <20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org>
In-Reply-To: <20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Christoffer Dall <christoffer.dall@arm.com>
Cc: Wei-Lin Chang <weilin.chang@arm.com>, 
 Yao Yuan <yaoyuan@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10133; i=ljs@kernel.org;
 h=from:subject:message-id; bh=8LNmGXzlmgxMWU1FepZ/orH8subma92NfOqYuZvssUc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI6H8wqW2Ml8OftwyCR3ywK7NaxC6qf6jQv52yXyZi/0
 qGs/drEjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAExkvzIjw9LjvAHnnNqF1e+6
 Nt6W5trsdWyrEnflcY3ePybv+wMz2Bn+SnNrtW8VsZZyuD6tId+9T8xNTOFi/q6PGa3sWj8YKmd
 xAwA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

A batch of kernel warnings were triggered in the L0 host kernel when using
kvmtool to experiment with nested virtualisation.

The issue was observed on an M2 macbook pro with 24 GiB of RAM running
asahi linux 7.1.6-400.asahi.fc44.aarch64+16k with 16 KiB page size.

The bug is confirmed to exist in mainline and does not appear to be
impacted by any downstream patches carried by asahi.

kvmtool was used to establish an L1 guest with 8 CPUs and 8 GiB of RAM.

kvmtool was then run again within the L1 guest to establish an L2 guest
with 4 CPUs and 4 GiB of RAM.

Then it was run again to establish another inner guest with 2 CPUs and 2
GiB of RAM at L3.

Both the L2 and L3 guests were then exited and another L2 guest was
established with the same characteristics.

Sufficient memory pressure was present in the L0 host to trigger indirect
reclaim, waking kcompactd up and triggering migration.

Shortly afterwards all of the kvmtool instances were stopped, at which
point three warnings were observed in dmesg in quick succession on the
host, with the second and the third occurring 114us and 189us after the
first, respectively.

In each case the call trace was the same:

WARNING: arch/arm64/kvm/mmu.c:336 at __unmap_stage2_range+0x64/0x80,
CPU#5: kcompactd0/66
...
__unmap_stage2_range (arch/arm64/kvm/mmu.c:335 (discriminator 3)) (P)
kvm_stage2_unmap_range (arch/arm64/kvm/mmu.c:346)
kvm_nested_s2_unmap (arch/arm64/kvm/nested.c:1168 (discriminator 14))
kvm_unmap_gfn_range (arch/arm64/kvm/mmu.c:2416)
kvm_mmu_notifier_invalidate_range_start (arch/arm64/kvm/../../../virt/kvm/kvm_main.c:718 ...)
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

Analysing this:

try_to_migrate() performs the first part of migration on a folio -
establishing migration entries in all page tables mapping it - calling
try_to_migrate_one() for each VMA the folio is mapped in.

Immediately prior to installing the migration entry, try_to_migrate_one()
calls mmu_notifier_invalidate_range_start() to signal to notifiers that the
existing page table entry is about to be unmapped.

Since this range happened to contain folios used by the virtual machine
(given its memory consumption this was highly likely to be a target) this
in turn triggers arm64 kvm code via an MMU notifier:

mmu_notifier_invalidate_range_start()
  -> ... -> kvm_mmu_notifier_invalidate_range_start()
    -> kvm_mmu_unmap_gfn_range()
      -> kvm_unmap_gfn_range()
        -> kvm_nested_s2_unmap()
          -> kvm_stage2_unmap_range()
            -> __unmap_stage2_range()
               -> stage2_apply_range()
       	       <- -EINVAL, triggering a WARN_ON()

Since commit ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page
tables") kvm_unmap_gfn_range() invokes kvm_nested_s2_unmap() which takes
the rather drastic step of evicting the entirety of the stage 2 shadow page
tables for each nested guest:

	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];

		if (kvm_s2_mmu_valid(mmu))
			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
	}

This will iterate through every valid MMU.

mmu_notifier_invalidate_range_start() sets the MMU_NOTIFIER_RANGE_BLOCKABLE
flag when signalling notifiers, so may_block is true here.

__unmap_stage2_range() wraps invocation of stage2_apply_range() in a
WARN_ON():

	WARN_ON(stage2_apply_range(mmu, start, end, KVM_PGT_FN(kvm_pgtable_stage2_unmap),
				   may_block));

Which is precisely the triggered warning and means stage2_apply_range() is
returning an error.

In arm64 return values are stored in the x0 register and in each splat w0
(since it's a 32-bit value) is 0xffffffea which, by two's complement, is
-0b00010110 or -EINVAL.

The only way in which stage2_apply_range() can return an error is if either
the passed in walk function (kvm_pgtable_stage2_unmap()) returns an error
or mmu->pgt is NULL:

	static int stage2_apply_range(...)
	{
		do {
			struct kvm_pgtable *pgt = mmu->pgt;
			if (!pgt)
				return -EINVAL;

			next = stage2_range_addr_end(addr, end);
			ret = fn(pgt, addr, next - addr);
			if (ret)
				break;
			if (resched && next != end)
				cond_resched_rwlock_write(&kvm->mmu_lock);
		} while (addr = next, addr != end);

		return ret;
	}

This loop is batched by stage2_range_addr_end() at the granularity of
kvm_granule_size(KVM_PGTABLE_MIN_BLOCK_LEVEL), which for a 16 KiB page size
kernel is 32 MiB.

kvm_pgtable_stage2_unmap() only returns an error if
kvm_pgtable_walk_begin() or _kvm_pgtable_walk() return an error. On arm64
the former doesn't ever do so, and the latter only returns -EINVAL if
either pgd is NULL (we gate that already) or an invalid pgt->start_level is
specified (not the case).

So the cause of the warning is that mmu->pgt is NULL here.

This field is protected by kvm->mmu_lock, but after each invocation of the
walk function, if the end of the range has not yet been reached, the lock
is dropped.

This is done by calling cond_resched_rwlock_write() which drops
kvm->mmu_lock when yielding the time slice before reacquiring it upon being
scheduled again:

		if (resched && next != end)
			cond_resched_rwlock_write(&kvm->mmu_lock);

Note that resched = may_block here and is always true for these walks.

This points to something else racing this code to clearing the pgt, and
brings us back to the observation above that the issue occurs when tearing
down the L2 guest.

Upon L0's userspace mm_struct teardown, stage 2 mappings for IPAs mapped by
the guest are unmapped via mmu notifier:

exit_mm()
  -> mmput()
    -> __mmput()
      -> exit_mmap()
        -> mmu_notifier_release()
	  -> ... -> kvm_mmu_notifier_release()
            -> kvm_flush_shadow_all()
              -> kvm_arch_flush_shadow_all()
	        -> kvm_free_stage2_pgd()
		  -> [ acquire kvm->mmu_lock for write ]
		  -> mmu->pgt = NULL [ among other tasks ]
		  -> [ release kvm->mmu_lock for write ]

So there is a benign race resulting in a spurious warning:

	Thread A - notify: migration   | Thread B - notify: release
	-------------------------------|---------------------------------
	< kvm->mmu_lock held >         |
	stage2_apply_range()           |
	  get mmu->pgt, check !NULL    |
	  ...                          | kvm_arch_flush_shadow_all()
	  cond_resched_rwlock_write(); |   < contend, sleep kvm->mmu_lock >
	< drop kvm->mmu_lock >         |   < acquire kvm->mmu_lock>
                                       |   ...
				       |   kvm_free_stage2_pgd()
                                       |     mmu->pgt = NULL
				       |   < invalidate MMU >
				       |   ...
				       |   < release kvm->mmu_lock >
	[ scheduled ]		       |
	stage2_apply_range()           |
	  < loop to next >             |
	  get, mmu->pgt, check !NULL   |
	  is NULL, return -EINVAL      |
        __unmap_stage2_range()         |
	  WARN_ON(-EINVAL) <--- entirely spurious - the race was handled
                                 correctly.

This does not hide any other errors as the only other error that can arise
is from kvm_pgtable_stage2_unmap() which calls kvm_pgtable_walk()
first which gates on !NULL pgt->pgd returning -EINVAL if it is NULL anyway.

On reflection this race seems rather likely when there is host memory
pressure concurrent with nested guest teardown - the lock release will
cause interleaving warnings once for every valid MMU as long as at least 1
block remains to be unmapped by stage2_apply_range().

Fix the spurious warning by updating stage2_apply_range() to no longer
treat concurrent PGT teardown on lock release as an error - whether the
walker is tearing down page tables or doing something else this is a
legitimate reason to abort the operation without error.

This keeps the warning in place for all other circumstances.

In practice only __unmap_stage2_range() actually does anything with the
error so this only impacts that.

Fixes: ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page tables")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/mmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 74e7e7f7564c..31e049ded093 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -59,19 +59,25 @@ static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
  * long will also starve other vCPUs. We have to also make sure that the page
  * tables are not freed while we released the lock.
  */
-static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t addr,
+static int stage2_apply_range(struct kvm_s2_mmu *mmu, phys_addr_t start,
 			      phys_addr_t end,
 			      int (*fn)(struct kvm_pgtable *, u64, u64),
 			      bool resched)
 {
 	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
+	phys_addr_t addr = start;
 	int ret;
 	u64 next;
 
 	do {
 		struct kvm_pgtable *pgt = mmu->pgt;
+		/*
+		 * We may be raced on PGT teardown when we release the
+		 * kvm->mmu_lock. That's fine as the PGT is legitimately no
+		 * longer present.
+		 */
 		if (!pgt)
-			return -EINVAL;
+			return resched && addr > start ? 0 : -EINVAL;
 
 		next = stage2_range_addr_end(addr, end);
 		ret = fn(pgt, addr, next - addr);

-- 
2.55.0

