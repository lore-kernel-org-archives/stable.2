Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A939936D;
	Tue,  2 Jun 2026 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444498; cv=none; b=uEAWzQ437oYC/zYCm3eLtTCVM1cRVX4WWQo52SblBrBBEb9rp9fPAwRitEzSbDBaPFuWRDzQ5QGwLtJOggcwbtr4a5VVYL+WYVeaciAMn6oZwqF/JsNhxlYm0SfT5S/0UDwEymbCyAcvhlVmkMomH5AzmPWxDujQjl2L63dR3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444498; c=relaxed/simple;
	bh=9C8DQw0flKH0sM335ms4ayLG4jw5+1Dwb3103XIomUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7wxix9vTTGrR7kJNdQGxDiNNFagmzVnuddfJApyELPbpeY4HQdoSjscxfXG4vxjfbF75I6mAhxfpAU2zlM17WQwqAeBQ0/f5DsdSO+k0fJMeAcvf7HTHQvhc7Tz7wcufRUmoB9vhcbwuQC7VkayRWYlLdGGEaoHrOdZUyqeUX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkVkjvwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkVkjvwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126101F0089A;
	Tue,  2 Jun 2026 23:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444496;
	bh=0x6QdNpCBv6Ii/bbNu324c1LO1y8u1r1+aTEfVKd050=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WkVkjvwPfuN+Z9MaUcb6tGtodaynhsAlbysX2XQuO6RYPO1QgDg4rc094dDQ30a1n
	 FxPWPCse48KCXe+7XjcjGezzuUWAUxfNRwbgyHhaapE5a631Z65mt5AR+QMuL3qytU
	 NsNyU0LJtll9v0iWRnKWtyS1Y7zSpiUPkxqhpxJUlDHY5L00wsNxz1gd8fp0DGHLF0
	 7kCpzsjw79LAYewk67+4AmSITUnAWt2URUqd6AbTipz/93MLn7+1jPI2RoNXRo3b+v
	 w1xefwZ9QcfV3P9BN8FYuazVRYq6jAt5yh0jxW+m03gOxabPvNOc5iaftTluvuUJsV
	 XddUOG36lUpow==
From: Oliver Upton <oupton@kernel.org>
To: kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Wei-Lin Chang <weilin.chang@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: arm64: Don't leak PFN when kvm_translate_vncr() races MMU notifier
Date: Tue,  2 Jun 2026 16:54:46 -0700
Message-ID: <20260602235450.103057-2-oupton@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260602235450.103057-1-oupton@kernel.org>
References: <20260602235450.103057-1-oupton@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case that kvm_translate_vncr() races with an MMU notifier the
early return does not release a reference on the faulted in PFN. Add
the necessary call to kvm_release_faultin_page() for the unused PFN.

Cc: stable@vger.kernel.org
Fixes: 069a05e535496 ("KVM: arm64: nv: Handle VNCR_EL2-triggered faults")
Reported-by: Sashiko (local):gemini-3.1-pro
Signed-off-by: Oliver Upton <oupton@kernel.org>
---
 arch/arm64/kvm/nested.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 883b6c1008fb..4fa82e96454d 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -1326,8 +1326,10 @@ static int kvm_translate_vncr(struct kvm_vcpu *vcpu, bool *is_gmem)
 	}
 
 	scoped_guard(write_lock, &vcpu->kvm->mmu_lock) {
-		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq))
+		if (mmu_invalidate_retry(vcpu->kvm, mmu_seq)) {
+			kvm_release_faultin_page(vcpu->kvm, page, true, false);
 			return -EAGAIN;
+		}
 
 		vt->gva = va;
 		vt->hpa = pfn << PAGE_SHIFT;
-- 
2.47.3

