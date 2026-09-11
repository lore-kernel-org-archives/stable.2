Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2633E2ADB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123309; cv=none; b=Wi00G9jn2hzlwZpW84CLHkpRyp5M0J0E/IAesh0TmT9SRFMtVWIDtN0ymPzKFrPvPyuFIfGBWr0ZTypxi3eo83SAmdbxxGJHIhqFJQpxvR3UXj0iXblsSCcWBWo+d3qAiChjAwMPGKFc83GxBVHo6k2YH4spwSxf1nTfi6lsUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123309; c=relaxed/simple;
	bh=NVj3kq6bTePSg/hbK/+QY8RwkXjYFcUD82eFY3l/mUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAlZFaSYQ7TR/E7Z3JufbmrsA+6dPOXBolrEPityjWixHaImLJiFPnUrt+vQ5rapvzAPY1NnDADr9MdY7lKLntcw6hE8U0ELBlBq4hhNeCFMJTrJNWgX+nWD1TAElb0LoDFnZLIgjXk2eDRAFLfqiOBbiyG1yXU4U+Onh6peDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRwZnK/6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRwZnK/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544891F000FF;
	Fri, 11 Sep 2026 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123308;
	bh=Pn0qXpen+fT1DZyLkrZhbgGOFGL+I8sujppyoujSMWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lRwZnK/6zTqXidHeXUGl7v6rwIldQniv48eQnMrh2HU7leNIf9Dp3UxVmANoGpqPv
	 LB3r7YOfIXjmsxsUamlBJ6imVyYSlnnsT/pKHdLcnLg1if6RKDH0lKPSQ/MzhE9Hsx
	 GQx06qw7xaD8ydrLiZihlyKkFLtSxlODrlHybWg3xtkDL1tbEBa7KQWJx8R2V5qSvR
	 zg1nxC7CO7o9qhd38Pe8xafQGnf7w7WEJOMyMRpm+onVoQQCxDHRnH0lLA1gGg9/F1
	 5GphblW/qIIxVSRtJ1hdl91k5VYgm8Zbm6p+0hs410kS+oKbmI2DVYFI4u7gJ4SOcu
	 DsTmIYTe36ZRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] KVM: x86: Extract REGS and SREGS runtime sync code to helpers
Date: Fri, 11 Sep 2026 06:41:42 -0400
Message-ID: <20260911104145.196806-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090911-unvented-professed-4dc0@gregkh>
References: <2026090911-unvented-professed-4dc0@gregkh>
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
index f0707f0e1ec00..7f27c80190f89 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12629,7 +12629,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return 0;
 }
 
-static void store_regs(struct kvm_vcpu *vcpu)
+static void kvm_run_sync_regs_to_user(struct kvm_vcpu *vcpu)
 {
 	BUILD_BUG_ON(sizeof(struct kvm_sync_regs) > SYNC_REGS_SIZE_BYTES);
 
@@ -12638,13 +12638,18 @@ static void store_regs(struct kvm_vcpu *vcpu)
 
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
@@ -12660,6 +12665,14 @@ static int sync_regs(struct kvm_vcpu *vcpu)
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

