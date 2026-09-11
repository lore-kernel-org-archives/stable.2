Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A733E451B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093870; cv=none; b=DYUg74hMMQvZ/O215Q+vGyNdWnJwSwu4JSlJ6nkkulS3IsVa8NXg+LjpG+9CwuFQyk4e/ZyAeZgx267iwdute86b6gWm9vU93xaJ78JtLAX5BBqTGjm/9WfPDfEM6k23rqV8MmLcPh0ljvjSfWnDVy0Zk+eWJxfdvQHUGYs8bKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093870; c=relaxed/simple;
	bh=/OkZLjcWasEMe+bqtIQhWCiiivIxRxVKe+dMnWRxkdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZqpbBu/GLIw+kUULCxbn1c/jhQBiora9LzXqYkbR9+0qs8+DyFTDDIYZt0ARWnhHXXuPGb73X1wVpng8xMIUTk9jDcs43EtKPwwCzve2sL25iuyHoixv7UQU+3ReQgnTyaYW6awH6MfEW7uaNsaF+RfsU6a6MxSPbppVsQFwos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwhOilTM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwhOilTM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B381F00899;
	Fri, 11 Sep 2026 02:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093868;
	bh=XOql8YR/XmUlnbEmLS4q5uhu0tcJMDguJu58HV/l6vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwhOilTM1sI9UUKwOTh2d8tTcQWI8HpxksAK3ufX4BQ/7WRzfZ6AnhweYd/9pJOGO
	 4mfv/2M4jTFfL5m6JpcRG95SC7pDsNqzNiPdgAFC9czmCcr6nHyZHUymuB7z14k7Vg
	 QRQZFKWk8j4rRJOwYwKFgrVZE2FWBRw5r6mdI1YoB026RPtpATilwTIg9UALNE4pt8
	 9VbC+aYqxNie90gyW1k3mg31qZauq7KyFzmoLns7Adk2V98Y03MLb7jPpp72XbHYWw
	 sU4sbLi0Z4lDALXgC9rec0BijHWjapsuvZtjkx5lC5JnwdiZGXb4LQpZUof5iw+HqC
	 myvRXDRaNqQkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/5] KVM: x86: Move get_segment_base() to regs.h, as kvm_get_segment_base()
Date: Thu, 10 Sep 2026 22:31:02 -0400
Message-ID: <20260911023105.76544-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911023105.76544-1-sashal@kernel.org>
References: <2026090910-manned-fang-c784@gregkh>
 <20260911023105.76544-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0217de73439caf56db74da95b3bbad8c1cb066c4 ]

Move get_segment_base() to regs.h, as kvm_get_segment_base(), so that the
bulk of the register code can be moved from x86.c to a new regs.c, without
simultaneously needing to rename "public" helpers to explicitly scope them
to KVM.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Message-ID: <20260613000329.732085-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 184bd464bdb6 ("KVM: x86: Check EFER validity on KVM_SET_SREGS*")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/regs.h | 5 +++++
 arch/x86/kvm/x86.c  | 9 ++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 5bda738afb7ca..b17ab0d65ee7d 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -420,4 +420,9 @@ static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hflags & HF_GUEST_MASK;
 }
 
+static inline unsigned long kvm_get_segment_base(struct kvm_vcpu *vcpu, int seg)
+{
+	return kvm_x86_call(get_segment_base)(vcpu, seg);
+}
+
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 734ef633d24e3..955e341745f02 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8492,11 +8492,6 @@ static int emulator_pio_out_emulated(struct x86_emulate_ctxt *ctxt,
 	return emulator_pio_out(emul_to_vcpu(ctxt), size, port, val, count);
 }
 
-static unsigned long get_segment_base(struct kvm_vcpu *vcpu, int seg)
-{
-	return kvm_x86_call(get_segment_base)(vcpu, seg);
-}
-
 static void emulator_invlpg(struct x86_emulate_ctxt *ctxt, ulong address)
 {
 	kvm_mmu_invlpg(emul_to_vcpu(ctxt), address);
@@ -8641,7 +8636,7 @@ static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 static unsigned long emulator_get_cached_segment_base(
 	struct x86_emulate_ctxt *ctxt, int seg)
 {
-	return get_segment_base(emul_to_vcpu(ctxt), seg);
+	return kvm_get_segment_base(emul_to_vcpu(ctxt), seg);
 }
 
 static bool emulator_get_segment(struct x86_emulate_ctxt *ctxt, u16 *selector,
@@ -13843,7 +13838,7 @@ unsigned long kvm_get_linear_rip(struct kvm_vcpu *vcpu)
 
 	if (is_64_bit_mode(vcpu))
 		return kvm_rip_read(vcpu);
-	return (u32)(get_segment_base(vcpu, VCPU_SREG_CS) +
+	return (u32)(kvm_get_segment_base(vcpu, VCPU_SREG_CS) +
 		     kvm_rip_read(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_linear_rip);
-- 
2.53.0

