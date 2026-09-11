Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EE3DC4C9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093869; cv=none; b=HurLqNd4ohIx68eQjT02d8lTk+xbP2twFk/lRrQ/iHBUDqhJGnx0oQrMonhGebG+S6UHQJAE3ea1gJgd+l46Kxy1nfPCOXgt1iEmamDmyVXwfwLdFrM1GEXtKLPOdsOnZSSlm2ziIHFFHHxLgh7LoulluRO/2WLY8D51yZdLpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093869; c=relaxed/simple;
	bh=MqXwGzCRRGJz+BoOtxcDlHgz3Gi/1zowiR9L1nJX+d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqbJVCVlldzlkAu9BHOlTLJIjzioOCtbOitxMKbYPLvdTlaX9ZtUX9mjNvZXHAcINKUgWNiFEm9BNossjW1Zzo7s6Tm2o9DGiEZv+mKXebLhhdty4BVQ3uIjKgNytjyIhztqMcY6GAxeXoLmFuxqYI1RAcJ8SarUNCuKnf+ScfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFYoMccd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFYoMccd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0772D1F000FF;
	Fri, 11 Sep 2026 02:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093867;
	bh=VEB770gRanWZkacp/uUTK7N7BMaGZQCWIeFH1ryJRX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hFYoMccd6qkQ/CkacUbCV4PMMpLPQGsIC/KKAcKA3GuTc5X7tYM+RJ+GJ8F8jp1Aa
	 tnb1jh7+tCqGDj4RRS3at0LmxP0d1K7JfvkcUvTSdg+8kEvHLj7rW6FX2oW7hAqPAU
	 VFCeGjxSeZBx5Cb8pk0/QfweFdC8GtvChzQSx4SwOD6h88J3sIYEahTzIpJR2E/DZo
	 yU4gRspG53sbAUlLaN7CNPgVjLZdlqdlDyy+pcD/RQpKY95h28wz3VapFuxVQp3rBy
	 xfazqH3H4V1DpBDQxUQZXYGrIzt7Q1ScubN481pK/VBO1/JXpYD6Q9wlHA3AkEhOIU
	 s3L/MltiID9uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/5] KVM: x86: Extract REGS and SREGS runtime sync code to helpers
Date: Thu, 10 Sep 2026 22:31:01 -0400
Message-ID: <20260911023105.76544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090910-manned-fang-c784@gregkh>
References: <2026090910-manned-fang-c784@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 6a8a98aa9c147eb63f5a360f157f207bf46c05ee ]

Extract the REGS and SREGS portions of {store,sync}_regs() into separate
helpers in anticipation of moving the register specific code out of x86.c
and into regs.c.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 184bd464bdb6 ("KVM: x86: Check EFER validity on KVM_SET_SREGS*")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 47cb9eba113b1..734ef633d24e3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12685,7 +12685,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return 0;
 }
 
-static void store_regs(struct kvm_vcpu *vcpu)
+static void kvm_run_sync_regs_to_user(struct kvm_vcpu *vcpu)
 {
 	BUILD_BUG_ON(sizeof(struct kvm_sync_regs) > SYNC_REGS_SIZE_BYTES);
 
@@ -12694,13 +12694,18 @@ static void store_regs(struct kvm_vcpu *vcpu)
 
 	if (vcpu->run->kvm_valid_regs & KVM_SYNC_X86_SREGS)
 		__get_sregs(vcpu, &vcpu->run->s.regs.sregs);
+}
+
+static void store_regs(struct kvm_vcpu *vcpu)
+{
+	kvm_run_sync_regs_to_user(vcpu);
 
 	if (vcpu->run->kvm_valid_regs & KVM_SYNC_X86_EVENTS)
 		kvm_vcpu_ioctl_x86_get_vcpu_events(
 				vcpu, &vcpu->run->s.regs.events);
 }
 
-static int sync_regs(struct kvm_vcpu *vcpu)
+static int kvm_run_sync_regs_from_user(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_REGS) {
 		__set_regs(vcpu, &vcpu->run->s.regs.regs);
@@ -12716,6 +12721,14 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_dirty_regs &= ~KVM_SYNC_X86_SREGS;
 	}
 
+	return 0;
+}
+
+static int sync_regs(struct kvm_vcpu *vcpu)
+{
+	if (kvm_run_sync_regs_from_user(vcpu))
+		return -EINVAL;
+
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_EVENTS) {
 		struct kvm_vcpu_events events = vcpu->run->s.regs.events;
 
-- 
2.53.0

