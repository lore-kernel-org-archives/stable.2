Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B99F42EEC4
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123311; cv=none; b=L1P+uaaeHOl4QRRYemsBsa7gY14MgtIT+W5M61OGuAkcQTO1GcCdyqE+1hsX5znQAvkgXd2tB80k/fiH+vqmSRvqXLxcVSjtLvXsBCWoa5Gxvv4YRMglaZpez71wwbW7GRoucLVpiH7rItNuZxPHKDIlkzKmrhOtmx3K5JzCWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123311; c=relaxed/simple;
	bh=3lznB0YYVI1QuuOha7ElLV+LqLx71qUjNoy9MaEfGXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSXSlDUsOSBpDTYmLeLXqoCc42LXgkzVGnM5zoDG1vzZkyUEveVXAEmbsYnTbnZIr0e4izzivT0tS3GZzm117oVIBI7bF4X8uTw2MTJ1xcvGNtxmW+BMT/fFqydFwjhh6GPXuCpsEJ1QI3vdJJYkFP11IOW2Xq874AgHJCoeE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGTyrynm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGTyrynm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530191F0089A;
	Fri, 11 Sep 2026 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123309;
	bh=PtpwuNYzOi+6MXI1r2+zI2F4NS9pvneP/iVNqti9skw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fGTyrynm0Eyf+bu3f7gnbZx63rKX/mHRqXO29qnEcmLi9uaxEnZMBwHkris555mtq
	 X6K8ua+NgrTEYfs10U1fbHm/sXmDoJFw9lxAHWf1xTJjgr7zORrLo82RZ5OsuUpZHM
	 s7Erwtzi4kr0VWV9hPHjmLgAglYtKtMHgRcbEaI9TAIqZ+UUeKWdwV6fPYzYuC2boK
	 DcY3epEmQvI4QPNG5K5ZA3daCLSBHRZExw9I3fdx6y4UVvHlxLbCfAg0FzHkhB/Dsa
	 0VlV8nWa2KbkK2/+fXdg/Lm2icwPg8EAtZB1T+j2E4M2otuXOnat494lnPQj+IfQoP
	 st27t2edrf02g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] KVM: x86: Rename __{g,s}et_sregs2() => kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
Date: Fri, 11 Sep 2026 06:41:43 -0400
Message-ID: <20260911104145.196806-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104145.196806-1-sashal@kernel.org>
References: <2026090911-unvented-professed-4dc0@gregkh>
 <20260911104145.196806-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit bd130c8d72a1c7dde5523b3f3fae9867eafaa1dc ]

Rename the KVM_{G,S}ET_SREGS2 helpers in anticipation of moving them out of
x86.c (while leaving the ioctl dispatch behind).  Having globally visible
APIs named __{g,s}et_sregs2() would be "fine", but ugly, given that
__{g,s}et_sregs() will NOT be globally visible.  As a bonus, this makes it
a bit more obvious that the helpers implement newer versions of
kvm_arch_vcpu_ioctl_set_sregs().

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Message-ID: <20260613000329.732085-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 184bd464bdb6 ("KVM: x86: Check EFER validity on KVM_SET_SREGS*")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7f27c80190f89..597ad69e5921f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -132,8 +132,10 @@ static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
 static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu);
 
-static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
-static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
+static int kvm_vcpu_ioctl_x86_set_sregs2(struct kvm_vcpu *vcpu,
+					 struct kvm_sregs2 *sregs2);
+static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
+					  struct kvm_sregs2 *sregs2);
 
 static DEFINE_MUTEX(vendor_module_lock);
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu);
@@ -6661,7 +6663,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!u.sregs2)
 			goto out;
-		__get_sregs2(vcpu, u.sregs2);
+		kvm_vcpu_ioctl_x86_get_sregs2(vcpu, u.sregs2);
 		r = -EFAULT;
 		if (copy_to_user(argp, u.sregs2, sizeof(struct kvm_sregs2)))
 			goto out;
@@ -6680,7 +6682,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			u.sregs2 = NULL;
 			goto out;
 		}
-		r = __set_sregs2(vcpu, u.sregs2);
+		r = kvm_vcpu_ioctl_x86_set_sregs2(vcpu, u.sregs2);
 		break;
 	}
 	case KVM_HAS_DEVICE_ATTR:
@@ -12159,7 +12161,8 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			(unsigned long *)sregs->interrupt_bitmap);
 }
 
-static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
+static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
+					  struct kvm_sregs2 *sregs2)
 {
 	int i;
 
@@ -12427,7 +12430,8 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	return 0;
 }
 
-static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
+static int kvm_vcpu_ioctl_x86_set_sregs2(struct kvm_vcpu *vcpu,
+					 struct kvm_sregs2 *sregs2)
 {
 	int mmu_reset_needed = 0;
 	bool valid_pdptrs = sregs2->flags & KVM_SREGS2_FLAGS_PDPTRS_VALID;
-- 
2.53.0

