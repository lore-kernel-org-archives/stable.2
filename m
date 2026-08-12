Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC243B6C4;
	Wed, 12 Aug 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541492; cv=none; b=XwTkV76Oz4an9gET7H6DlZ3uLDAGmgtl+SVtlEU3zcoNCkNiSsU2wsbkhs/J/YMNODVIPfr3q00zam2dhuntgbXSlJuJaJE0f3kEaE/EHU5QE79J1B6OTAyalTPNto/D4Km/lhRAzudQwJw7dHiwtzrGyuHibUd8WaiZw9u48Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541492; c=relaxed/simple;
	bh=ebHCoiKax54AQOHYUYR/XNV51O7qILF7crOxXBEsDN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5kmUcjsmx4qqOf6IetfZL3wPEOO17d2SFuVp2g5cLrythYxFxUCpYrH4LIVpJC6/HnHING9spJG161wVE7Q0snY4Xc+WEHwkxbhU/yLQ8ZVSNwi+ZHXOBUluEMNI/OBXqHMJt9jgS2fvJ4YNDg/e20bz03heFLiCBBNbc5/RJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYz2EhUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYz2EhUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA47A1F000E9;
	Wed, 12 Aug 2026 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541491;
	bh=Xc1dJgNFPhFAUKTazkqSjXkd0S7WfNcp7Fj08b74Ygg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jYz2EhUqqsIVbliose2b7vSWVnZoG+oLWobO9XZ4zFlEN5l1mlhA2wNmhNhY1n9zc
	 eORvQj5U0+BQzyMivvh+TdOasKUKekPBHgByiPe4GYc6KrxshY1sePWlYCOYtG8HBH
	 QlA+C0lSKDzLu0FVXEJHz51VNHXFBFEkquYsvDYcJuyMRM2bnZuS/4ye9qWzgaTZWc
	 LIBTSKxLrLJZg4NBWNO/zNiVVTdHgzuQN31tdx1YOQKfpJTR9Y9jK8ZqvlQ7lAVN60
	 6SURZxSjhaHIjyVuSTBVlDYsNzYF6diZmu+0AATx/DqOwcJcmzAuVqRy0cRBNj6QKY
	 6NN842SF3E1Sg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 12 Aug 2026 14:31:21 +0100
Subject: [PATCH 2/2] KVM: arm64: nv: Fix null ptr deref in
 kvm_nested_s2_unmap() on S2 teardown
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-kvm-arm-nested-virt-fix-v1-2-4ad883f1b6a5@kernel.org>
References: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
In-Reply-To: <20260812-kvm-arm-nested-virt-fix-v1-0-4ad883f1b6a5@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Jintack Lim <jintack.lim@linaro.org>, 
 Christoffer Dall <christoffer.dall@linaro.org>, 
 Christoffer Dall <christoffer.dall@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ebHCoiKax54AQOHYUYR/XNV51O7qILF7crOxXBEsDN0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJqSlcZ7/Ca21D/Ul3XJ+7ZjJVHJ7XKWh4QtxXw2/j6w
 cWDq18Ld5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiIe8Z/nuoKldLLp6x3Trw
 0KJUsZZDqxbfDBXfJGxw0mVO3KID114yMszZrH1i6renC1W9FHMjTm0y5bg+Z4b4oVe9omKvW9f
 aLGcFAA==
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit 7270cc9157f4 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU
notifiers") introduced VNCR_EL2 invalidation in kvm_nested_s2_unmap().

However at the point of this being performed concurrent stage 2 teardown of
a nested guest can cause kvm->arch.mmu.pgt to be set to NULL.

This happens in kvm_flush_shadow_all() -> kvm_arch_flush_shadow_all() ->
kvm_free_stage2_pgd() and is performed under the kvm->mmu_lock.

Commit ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow stage 2 page
tables") introduced the teardown of the entire nested MMU range, which then
invokes stage2_apply_range() with resched=true:

mmu_notifier_invalidate_range_start()
  -> ... -> kvm_mmu_notifier_invalidate_range_start()
    -> kvm_mmu_unmap_gfn_range()
      -> kvm_unmap_gfn_range()
        -> kvm_nested_s2_unmap()
          -> kvm_stage2_unmap_range()
            -> __unmap_stage2_range()
                -> stage2_apply_range()

This means that stage2_apply_range() can drop the kvm->mmu_lock and thus
concurrent progress can be made in lockstep with
kvm_arch_flush_shadow_all().

If kvm_arch_flush_shadow_all() advances ahead of stage2_apply_range() and
completes its operation it guarantees a NULL pointer deref.

Since kvm_free_stage2_pgd() is performed under the kvm->mmu_lock this will
either be observed NULL or not and serialised against
kvm_free_stage2_pgd().

Resolve the issue by explicitly checking for a NULL value. Since this
shouldn't be possible if blocking is not allowed, raise a warning if it is
ever NULL in this case.

Fixes: 7270cc9157f4 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/nested.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 17123f0b6dab..9fc0b1696dcb 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1295,7 +1295,11 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
 	}
 
-	kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
+	/* NULL pgt should only be possible if raced when mmu_lock dropped. */
+	if (kvm->arch.mmu.pgt)
+		kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
+	else
+		WARN_ON(!may_block);
 }
 
 void kvm_nested_s2_flush(struct kvm *kvm)

-- 
2.55.0

