Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0D48B374;
	Tue,  1 Sep 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283771; cv=none; b=V3XzLkobJH9+uBKwvK7JYug985o1iHoc7USXU6lhw9QEt5I3OReF3KQfqNYmk5YJ7byG+Ew7yYOUWaqAypgaoC9MBlu1vXoeKLm5WAA6E1q47FLO/QHA09cUuO3HvzH56/kMSmqLd9Zy13EL8DBman9QFzbNoX6Qmc79BC8lLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283771; c=relaxed/simple;
	bh=h3OZBV0hKeSIcPk6cRu0Lh3Bz/res8fdkObbkPEf5Rs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d1yW1CMg4u84KhXqiffkb/cHyIrVNmHyRNN0eGsrnM5apjGRQeonqcD+Lj1o5D4jAPgnQinV6BZ+CibgVY9JM3r2TcIvfeuDW2YOs3mPfI59pXG1F2JVGim7dxwX5FDxCs1yMjcM3/01pLcyKd4K4YVcbmNJ9Ra2GafUWzs6i2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frdNKuQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frdNKuQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79871F00A3A;
	Tue,  1 Sep 2026 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283770;
	bh=KHeG1SyvdrKGHQb5ysxSkdvGXlCn0/i2CY3zwVay8Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=frdNKuQTDRxIJ6vJb9TfJRjkEv1h7/JY2wVGqrUjOvgRIt9wgsFBRJKCrVmacMr0y
	 efVyBp3S2voT/OVyszI3HTCOQ0fXk1IxrgysiBdydtpl6zyzlGDlma7NQUAgH07qGo
	 RIC4BsBvrlv7KIJNFsNLiO2f7SRNxF55k/pgYcbG3BE+lISADcIoWxLaXH7+mUmlSP
	 sZAjnWpm4hJuLP8TPaYdAG8nF9rnhYTgDjrUiWtf9w6duPyb5C4xg4PgfbvbUXorVM
	 0tmc/lVe4YDvY5EomxZzkeVWPBe20HmGnVII28fUk/7RtyEk7+ptUof/SbxCc3E4SA
	 D88L0ZOuDADUg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 01 Sep 2026 18:28:59 +0100
Subject: [PATCH v3 1/2] KVM: arm64: Fix spurious warning for benign stage 2
 teardown race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-kvm-arm-nested-virt-fix-v3-1-b154676f7e4c@kernel.org>
References: <20260901-kvm-arm-nested-virt-fix-v3-0-b154676f7e4c@kernel.org>
In-Reply-To: <20260901-kvm-arm-nested-virt-fix-v3-0-b154676f7e4c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Christoffer Dall <christoffer.dall@arm.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>
Cc: Wei-Lin Chang <weilin.chang@arm.com>, 
 Yao Yuan <yaoyuan@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4564; i=ljs@kernel.org;
 h=from:subject:message-id; bh=h3OZBV0hKeSIcPk6cRu0Lh3Bz/res8fdkObbkPEf5Rs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLKmcxfNbmniOF42tW9Txfd2joibRfXNhS9OCGubG6fw9
 V3/2vOqo5SFQYyLQVZMkeX5F/H9QSJh8zov+LvBzGFlAhnCwMUpABM55cPwv6B3d+KhauHZrUGL
 3i0y9llnuWNJ9SauUz3hzz+9NNk4sYyRYV1yRuh1iw8xJo11byZIS/3h4lS68nBv36lrbzp6ZLX
 6+AA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

kvmtool was used to establish an L1 guest with 8 CPUs and 8 GiB of RAM, an
L2 guest with 4 CPUs and 4 GiB of RAM and an L3 guest with 2 CPUs and 2 GiB
of RAM, all of which was then exited.

Under memory pressure in the L0 host warnings were observed due to
migration triggered by compaction:

WARNING: arch/arm64/kvm/mmu.c:336 at __unmap_stage2_range+0x64/0x80,
CPU#5: kcompactd0/66

Which was, in turn, triggered by an MMU notifier for the host invalidation:

mmu_notifier_invalidate_range_start()
  -> ... -> kvm_mmu_notifier_invalidate_range_start()
    -> kvm_mmu_unmap_gfn_range()
      -> kvm_unmap_gfn_range()
        -> kvm_nested_s2_unmap()
          -> kvm_stage2_unmap_range()
            -> __unmap_stage2_range()
               -> stage2_apply_range()
       	       <- -EINVAL, triggering a WARN_ON()

Racing with L0's teardown of stage 2 page tables:

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

It turns out there is a benign race resulting in a spurious warning:

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

Fix the spurious warning by updating stage2_apply_range() to no longer
treat concurrent PGT teardown on lock release as an error - whether the
walker is tearing down page tables or doing something else this is a
legitimate reason to abort the operation without error.

This keeps the warning in place for all other circumstances.

In practice only __unmap_stage2_range() actually does anything with the
error so this only impacts that.

Fixes: ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page tables")
Cc: stable@vger.kernel.org
Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/mmu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9ba86450fe4a..2d44cd6a5aed 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -59,27 +59,36 @@ static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
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
+	bool lock_dropped = false;
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
+			return lock_dropped ? 0 : -EINVAL;
 
 		next = stage2_range_addr_end(addr, end);
 		ret = fn(pgt, addr, next - addr);
 		if (ret)
 			break;
 
-		if (resched && next != end)
+		if (resched && next != end) {
 			cond_resched_rwlock_write(&kvm->mmu_lock);
+			lock_dropped = true;
+		}
 	} while (addr = next, addr != end);
 
 	return ret;

-- 
2.55.0

