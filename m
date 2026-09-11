Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B223466B57
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125741; cv=none; b=Oe+U82XZvbqg9lqNCU7PDGmiE1CfU26l9CR1gDP1Rn/Bq0uEDijz38hUMsQwhk75YbtYehbNSO0bkTISAOeHw8RJQSNRHv1r2hcvKAm46SQ87OYgDc4THdmESqQpzZOJC/Bv9TqBDkwA4YJdnvAMCU7NvOR8+PwzEc0I8MMMcLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125741; c=relaxed/simple;
	bh=kcCWp8ctpYIsOIl4GMi5qBHP9dnYjaFRqYAIc7JMNF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByYNfcYgoyoUCXzn8F4zSgkSMX4a18UO0urT+CgDJxR4MPIdiV801/REaoLjLjqw4CClAEDryR4FQBB+hmivoNwCk9Rs7grai5cEsecPNN4YjxrJ3RLLFRZU/Vnokz5sCPTYtV6PWr87b0jC9CZRMsllAuDHUgD+Vtq5lFl22X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYnd7ZSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYnd7ZSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913761F00893;
	Fri, 11 Sep 2026 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125728;
	bh=G2tWXlTYjsDmMICIOzzEPiGlGydEjnxt1a7P5F83SgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYnd7ZSb75sVqw2mFNU+atrk1tivbCZ8dhC7q5GPzGNQQT78qx945i0xfflL6g2Bg
	 0/Ud3GH/Y2QiZAk27HwMf4HH+1TNOhGK9+oAqNiZFwrBqQU+4I/X9o8j8FzRR1uYjR
	 IifB/s6TSRIZRvadY4tAYp8KBUjWcggsiKRmr5SyA6DRVmMrkPLPD79Dr1mQGbQOWy
	 P8/hehwD/MWfRi4laQOC9ZZGFO1Az+872EDpAHB8jUcciQRvjUGlk2tLN+IevwZCk+
	 ymNr1xbvCo9iBMkEmAG2+ZijUQyQIqwAnRXriSoN+usElH0VGEOO5LIJ85tl1J+JYG
	 T1duztH/ouEIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] KVM: x86: Rename __{g,s}et_sregs2() => kvm_vcpu_ioctl_x86_{g,s}et_sregs2()
Date: Fri, 11 Sep 2026 07:22:03 -0400
Message-ID: <20260911112205.352046-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911112205.352046-1-sashal@kernel.org>
References: <2026090911-keg-hunk-4c3e@gregkh>
 <20260911112205.352046-1-sashal@kernel.org>
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
index 34dc99d6e4871..7080d66ecf99a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -135,8 +135,10 @@ static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
 static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu);
 
-static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
-static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
+static int kvm_vcpu_ioctl_x86_set_sregs2(struct kvm_vcpu *vcpu,
+					 struct kvm_sregs2 *sregs2);
+static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
+					  struct kvm_sregs2 *sregs2);
 
 static DEFINE_MUTEX(vendor_module_lock);
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
@@ -6304,7 +6306,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!u.sregs2)
 			goto out;
-		__get_sregs2(vcpu, u.sregs2);
+		kvm_vcpu_ioctl_x86_get_sregs2(vcpu, u.sregs2);
 		r = -EFAULT;
 		if (copy_to_user(argp, u.sregs2, sizeof(struct kvm_sregs2)))
 			goto out;
@@ -6323,7 +6325,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			u.sregs2 = NULL;
 			goto out;
 		}
-		r = __set_sregs2(vcpu, u.sregs2);
+		r = kvm_vcpu_ioctl_x86_set_sregs2(vcpu, u.sregs2);
 		break;
 	}
 	case KVM_HAS_DEVICE_ATTR:
@@ -11842,7 +11844,8 @@ static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 			(unsigned long *)sregs->interrupt_bitmap);
 }
 
-static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
+static void kvm_vcpu_ioctl_x86_get_sregs2(struct kvm_vcpu *vcpu,
+					  struct kvm_sregs2 *sregs2)
 {
 	int i;
 
@@ -12105,7 +12108,8 @@ static int __set_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
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

