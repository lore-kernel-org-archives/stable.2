Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06444606B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125739; cv=none; b=OHWj7bNi55mhDR/n82hZ6XUzPoMqOTmedb1ad4oe7nvjIPnwYJ0ypN/ZGZI46LY442m7a/LNteinbNX3WyxFppDvGRwVjhz3th9EiUr9C25Fqo7PLHgazJPKMfpXLw//httuowVq1MJLnjRuHl8BB1WsrVpOBvHRlTzljSJ10ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125739; c=relaxed/simple;
	bh=NMR2ceud922ersi2jPBkBRyeJ5/Nb+A3NRxNlqvB9dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbk/btKKVACKzFaYno3qkWqN0jwXdCHmFl8QN+IezChOMQmr6V+BC1p/lyN6Vj86V01G3YkhqeRQFbkruUwo8hj80FvgSn/T77pf/Hjl9c2bOBgLWxygadNnKqGgde1ojCTFfpd6HnFuAcrRZ+iLYlgXYRe7FqHPnlEJNz+uIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orfjNEON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orfjNEON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6BC1F00898;
	Fri, 11 Sep 2026 11:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125727;
	bh=jD/UGVd4ncFQBICJ18Z1riMODWwf2sJhMVPt60ZIhpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=orfjNEON54ipC9y1tWTzvwXyfgZArn43cZ2hGBJopzdpGIkc7j6BMaQPpXiI/OXKZ
	 LUgvrNqDyJwWHRte+fE9Sd0Pru2paOtu4PmxXX8LG776YLA3Tdx0Tj8MgdSjwhPbCu
	 lZ8drbmJIoiaqlTtkjLzhDkeTA1c/Nj5vyCg3H64qG5UHa5Q42eFmdS8oylvy8N7hn
	 50474hb2uWS5yFX/LjP8pKENHsZSw9D9iAiM9KbRSH72Xa1q0szwBVFjTtUBU7A3ca
	 Y8pRoA2+rGK+xgiV4nFx8Ky4ToLzHpXJZ7UMOZTXNetPrz4FUlJiKy7wzEbp59NZ6t
	 S/fm0o2hCzr3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] KVM: x86: Extract REGS and SREGS runtime sync code to helpers
Date: Fri, 11 Sep 2026 07:22:02 -0400
Message-ID: <20260911112205.352046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090911-keg-hunk-4c3e@gregkh>
References: <2026090911-keg-hunk-4c3e@gregkh>
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
index 9e7c9e3edb5b4..34dc99d6e4871 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12307,7 +12307,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	return 0;
 }
 
-static void store_regs(struct kvm_vcpu *vcpu)
+static void kvm_run_sync_regs_to_user(struct kvm_vcpu *vcpu)
 {
 	BUILD_BUG_ON(sizeof(struct kvm_sync_regs) > SYNC_REGS_SIZE_BYTES);
 
@@ -12316,13 +12316,18 @@ static void store_regs(struct kvm_vcpu *vcpu)
 
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
@@ -12338,6 +12343,14 @@ static int sync_regs(struct kvm_vcpu *vcpu)
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

