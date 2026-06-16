Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A436404B;
	Tue, 16 Jun 2026 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646420; cv=none; b=eBR2gsMv7RrKQaexgmWk2OO/Wge1XM77lTdrEfYc9l1dcet6nQrQu1odrVRbumYn2PSN2MqxD7JSNfmmaWTvmneETb4sl9fzIfnxX0f3Ua2sdivcyWgnchL8gKeBQ6kWHBfM70htRM1tL70BFXXOtI5Y1OVuuejTuWzZi8kGgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646420; c=relaxed/simple;
	bh=mumfvaawztzxAj4Hw1FFV8BvFZr+2txRPM1QgQkaTME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKjtVmq4ObFPuIRRhlFd/WOQLkq+AzWZMQLtZFtPtFzEvAlyVxD0357sglOZukVTKSeZ25XX1CVv1ty5t4xW5YRwi4SCIRg1ZDuSTISOgaSRK4m1hk/3DvWmX0xmFnmhQIZkDHqU2tEP9HAHg08pQ/vPz6Rf+W6y5qptm0Vnh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiYNu9tT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiYNu9tT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DC71F00A3D;
	Tue, 16 Jun 2026 21:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781646419;
	bh=px0GSg6CusRkP7s9q+eRKzr7vLo4Ei1zdyFx8CUbqWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PiYNu9tTlZSho8/6XNszfde5X9T966S4mnXhxg7g33CAWr5v1oqMV+Gr9MY/2Bcz/
	 0EnhUY9Pbgudc/BHuOfq+MuzLgygN9zsZzpg/4ZOu15sSWfJjCX2LzMBHohTe8P7uh
	 S8hP3giZSUu8q5Na72Eo0YSyCmT3PM1QSrqDTeS3Nuo2vSrSWsCNpbmPCB2VJetKex
	 gghVBRqC4ZJFl2fCciqLpnV2iDCOHPC50ESElMZoPdxxzpgaE+F46xBHxA27jfNNrU
	 nkMHfgzLa0m5mKDAPQDNs8uKbJuwNgIQeE0ae8QlSnm3zUmby3UmNg226tklzzNFDH
	 n7j6XLjPFcfPg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
Date: Tue, 16 Jun 2026 21:46:50 +0000
Message-ID: <20260616214652.2157032-2-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616214652.2157032-1-yosry@kernel.org>
References: <20260616214652.2157032-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure vpid02 is always flushed on first use by setting last_vpid=0
when allocating vpid02.  nested_vmx_transition_tlb_flush() will always
detect a VPID change on first VM-Enter after VMXON, because VPID=0 in
vmcb12 is not allowed if L1 enables VPID.

This avoids using stale TLB entries from a previous lifetime of the
VPID, that might have been associated with a different vCPU (or a
completely different VM).

Note that last_vpid is already being initialized as 0 when the vCPU is
created, but it is not reset when vpid02 is freed on VMXOFF. Hence, the
problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, and KVM
happens to reuse a VPID that has TLB entries on the physical CPU.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b2c851cc7d5c8..a49115d9a5a54 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1290,6 +1290,9 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
 	 * is the VPID incorporated into the MMU context.  I.e. KVM must assume
 	 * that the new vpid12 has never been used and thus represents a new
 	 * guest ASID that cannot have entries in the TLB.
+	 *
+	 * Note, last_vpid is initialized as 0, so the first nested VM-Enter
+	 * after VMXON will always flush the TLB to avoid using stale entries.
 	 */
 	if (is_vmenter && vmcs12->virtual_processor_id != vmx->nested.last_vpid) {
 		vmx->nested.last_vpid = vmcs12->virtual_processor_id;
@@ -5447,6 +5450,13 @@ static int enter_vmx_operation(struct kvm_vcpu *vcpu)
 
 	vmx->nested.vpid02 = allocate_vpid();
 
+	/*
+	 * Clear last_vpid to ensure that the VPID is flushed on the first
+	 * nested VM-Enter. Otherwise, stale TLB entries from a previous life of
+	 * the VPID (e.g. different vCPU or even different VM) could be used.
+	 */
+	vmx->nested.last_vpid = 0;
+
 	vmx->nested.vmcs02_initialized = false;
 	vmx->nested.vmxon = true;
 
-- 
2.54.0.1136.gdb2ca164c4-goog

