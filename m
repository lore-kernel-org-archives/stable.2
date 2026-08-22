Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72821C5799;
	Sat, 22 Aug 2026 17:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787420837; cv=none; b=rkYbLoPn8ty+a5AtQuu7oUubWUoD/eo4R3TkaJ18PZbeRB+d0kiUs6Me5uxQQG66OIbBraJ21QSUIeUMJdHzkMEK8CeCt2HgIJ7LIxtcKcpxDBJwVgHF8aXd9azdXeeKFyp9I3uYETn62k9BvdbyWo0IVIzmhQ6itzoSrL7zM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787420837; c=relaxed/simple;
	bh=Eb8dLW3qlXvE3hOr7x9ioTlXIH5wQvzQRfxLt2LHvbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuBYFLGGQ8ezyNGjPmJZkHZhn1w5xwTOW/D9WsakpcXvq5kXypXc2XVmNKPGeVEhfgT+nAxzRuNMX8Dvt4YP8uUcfpo/H4b2C+12YTWptOwujXEaWgJk6P/a/NAcVj1EFvuT/7nNjMAi2V1kFHnrcpwq3u5qN8MGsZLwKJOl7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyaJzhz1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyaJzhz1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D158E1F00A3D;
	Sat, 22 Aug 2026 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787420835;
	bh=EPVp8qZRnMZeXfq+RBn+odqsFRrtbi3iJaeDsI8T0DI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XyaJzhz1f5ZToAy441FKAL1IE9zcbbdkuRQj1HEkomOe8RT/sac9G+KJOvisADX7b
	 RgpWqx2xx/bVFwvbKG2jznZllGCspd6lEf73lpJnlF0z9fNI3MIRr6/eGE2+UfHdAG
	 LEoissisbQ1P1ZCdTFp+XOprFGHmCxRvoNKdxFYv5EHLLW9D4Z74GoWIn+qnzUvXlM
	 rbiTdnKA/qjJ3i2ePHSh6/vPkR7DguyBWqzrEMLj4YbsMesDOo2dYeNO9rg3aBqb3m
	 n0qrFY84Y2xnBRwtToqSaYnLkc1flfyEpqSrQ+ks8pRlCGi81vjKomhr/C1w3F5YW3
	 UxWHsrcl69iAQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 22 Aug 2026 18:46:54 +0100
Subject: [PATCH v2 2/2] KVM: arm64: nv: Fix null ptr deref on nested
 wp/unmap, teardown race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kvm-arm-nested-virt-fix-v2-2-ac4059a0eaa6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Eb8dLW3qlXvE3hOr7x9ioTlXIH5wQvzQRfxLt2LHvbI=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI6H8xKLJm5SaLl/Zsoqad8n5+0vff8f1Pii3R5+MNVp
 +9+uX+7paOUhUGMi0FWTJHl+Rfx/UEiYfM6L/i7wcxhZQIZwsDFKQAT2WXF8M844dTn7q3LLi8R
 v6FaK7fw47NVr9fafpGenzuj0+sex5Z4hv8uTH5TWto0v5gn+/oInstSm/vOYOGlCdKbqvTFfHX
 YSrkB
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Commit 7270cc9157f4 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU
notifiers") introduced VNCR_EL2 invalidation in both kvm_nested_s2_unmap()
and kvm_nested_s2_wp().

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

Resolve the issue by abstracting the invalidation to a new function,
kvm_invalidate_vncr_ipa_all(), and check that the pgt is non-NULL before
dereferencing it.

Fixes: 7270cc9157f4 ("KVM: arm64: nv: Handle VNCR_EL2 invalidation from MMU notifiers")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/nested.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 17123f0b6dab..f69722e1592a 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1260,6 +1260,17 @@ void kvm_handle_s1e2_tlbi(struct kvm_vcpu *vcpu, u32 inst, u64 val)
 	invalidate_vncr_va(vcpu->kvm, &scope);
 }
 
+static void kvm_invalidate_vncr_ipa_all(struct kvm *kvm)
+{
+	struct kvm_pgtable *pgt = kvm->arch.mmu.pgt;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	/* if the mmu lock was dropped, pgt teardown may have raced. */
+	if (pgt)
+		kvm_invalidate_vncr_ipa(kvm, 0, BIT(pgt->ia_bits));
+}
+
 void kvm_nested_s2_wp(struct kvm *kvm)
 {
 	int i;
@@ -1276,7 +1287,7 @@ void kvm_nested_s2_wp(struct kvm *kvm)
 			kvm_stage2_wp_range(mmu, 0, kvm_phys_size(mmu));
 	}
 
-	kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
+	kvm_invalidate_vncr_ipa_all(kvm);
 }
 
 void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
@@ -1295,7 +1306,7 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
 	}
 
-	kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
+	kvm_invalidate_vncr_ipa_all(kvm);
 }
 
 void kvm_nested_s2_flush(struct kvm *kvm)

-- 
2.55.0

