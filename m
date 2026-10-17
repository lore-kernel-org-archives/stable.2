Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FF3939C1;
	Sat, 17 Oct 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229433; cv=none; b=lavnf/vVWpN1pBS7l6H0fLwnlFagNizKSymwpgeZstkmS3RgKGJ7wIr8UNcy2nWInQtraIdWnAYysGOjqEZpnVIqfiW18Aal7iTlQid+kpc+9VY5vRwQvciJZEPjB1wIXqRWiRhXN8Pv9o3JICVpfobgJ+QE99KS7GLMgECdZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229433; c=relaxed/simple;
	bh=nSVWA18uvGh4nAp8alVhSxOQW7XOzf91yi2GGtut3kY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R+PSHe4cz5wYsLSuDERj/WJ8OEswct7zt/ih4D5bC522lTBbTLNQf3LWIGKeveYDJaDDPG/OEDzhIjM0KmQfdJpfuJrCqiP9i8mMPhdZ6LPho2TkWeQiSHI3mK26ulzMt2XE7el1SUY/29gN8L9+EvH9f+JehwG3JfA+14GMOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=Iw5Qcgz5; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="Iw5Qcgz5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Gn5Yjmt5x1gvUfD5RTw6LXc3CyfsFmB+PGjK1hFs1uE=; b=Iw5Qcgz5egVfOTniBmsUP4BK7T
	Pf/uK0hykCq9k2229YiWf12bO9vCqGT7LB1BBFbLqY9vhqRwTiyC7J9w1//NPl1D83ThhyNMiWkls
	CjZRja3LUhV/Iq1J/NcT3bIq0ms37Tsab8ebf5KIVwgHRisizP1Acck5WOGc+mRQa9BVRNYtwlSuf
	B5w6mFDljYOxLTYJGNAJWjQEK25KdGI+K9zrGfWzGaFjg7a5gSS79pGPydQPdWOZicKPX9jAzdFJc
	flmSlRsR3PntDXF9YwYHjOaf7z66NDjacRWr3VRR4mTvB2ifvpGlCg6TixSq2uEJk/LbzrgcyRcEY
	RPSBvTTw==;
Received: from mailer.gwdg.de ([134.76.10.26]:51104)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kH-00BAXF-32;
	Sat, 17 Oct 2026 11:30:29 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kH-000VX7-1e;
	Sat, 17 Oct 2026 11:30:29 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:28 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] KVM: nVMX: Clear nested.smm.guest_mode on a failed RSM-to-L2
Date: Sat, 17 Oct 2026 11:30:10 +0200
Message-ID: <20261017093016.32348-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-07.um.gwdg.de (10.108.142.66) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

vmx_leave_smm() consumes nested.smm.vmxon into nested.vmxon up front, but
clears nested.smm.guest_mode only on the success path.  On either failure
arm (nested_vmx_check_restored_vmcs12() < 0, or
nested_vmx_enter_non_root_mode() != NVMX_VMENTRY_SUCCESS) it returns early
with nested.smm.guest_mode still true while nested.smm.vmxon is already
false.

em_rsm() turns that non-zero return into a triple fault, but the vCPU is
left with the internal pair (smm.guest_mode=true, smm.vmxon=false).  That
pair is not representable in migration state: vmx_get_nested_state()
serializes KVM_STATE_NESTED_SMM_GUEST_MODE without
KVM_STATE_NESTED_SMM_VMXON, and vmx_set_nested_state() rejects exactly
SMM_GUEST_MODE && !SMM_VMXON with -EINVAL.  KVM thus serializes a state it
refuses to restore -- a save/restore (live-migration) round-trip break.

The leak is sticky: free_nested() and vCPU reset do not clear
nested.smm.guest_mode (kvm_vcpu_reset() gates the nested unwind on
is_guest_mode(), false here), so a later VMXON re-exposes the bad
KVM_GET_NESTED_STATE with no SMI/RSM involved, for the life of the vCPU.

Clear nested.smm.guest_mode before the consistency check and re-entry, so
it is cleared on every exit from the block.  nested.vmxon is left true,
which is correct (L1 does have VMX on) and round-trips cleanly on its own.
Not a memory-safety issue; fidelity / migration only.

Cc: stable@vger.kernel.org
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 arch/x86/kvm/vmx/vmx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1f802cdbe..56332a85c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8381,6 +8381,18 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	}
 
 	if (vmx->nested.smm.guest_mode) {
+		/*
+		 * Clear smm.guest_mode up front so the failure arms below, which
+		 * triple-fault the vCPU, cannot leave the internal pair
+		 * (smm.guest_mode=true, smm.vmxon=false): smm.vmxon was already
+		 * consumed into nested.vmxon above, and KVM_GET_NESTED_STATE
+		 * would then serialize SMM_GUEST_MODE without SMM_VMXON, which
+		 * KVM_SET_NESTED_STATE rejects (-EINVAL), breaking the
+		 * save/restore round-trip.  The flag has served its only purpose
+		 * (bringing the vCPU into this re-entry) by now.
+		 */
+		vmx->nested.smm.guest_mode = false;
+
 		/* Triple fault if the state is invalid.  */
 		if (nested_vmx_check_restored_vmcs12(vcpu) < 0)
 			return 1;
@@ -8390,7 +8402,6 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 			return 1;
 
 		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
-		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)

