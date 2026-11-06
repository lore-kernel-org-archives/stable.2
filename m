Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976428;
	b=a6yjZmX+mYGWybKCofoHZ+9fm3cpI0huE+w2yXSNEp+ApireMXws/U940nitTVWylV27
	 eniwqQ7lOVHO5xLw25ZyXitrmAhlhIVwX1OaGEC5CSPR6hJwh9XZKJ6mrOA0NaAMdCPip
	 h1qp+xJxTr2CKuf0iDcC0z4iIh6h0eDCB87EGqH5t1C5nabmrL7iQR6aJqfMlDsDNQbw4
	 wVgGv4RgZ8nZXpO4kDtQvGxJ56ZlXHcOCaZRd6gcIQQmJ3EoedpQpkgLyzBo9pDmg5vRs
	 tbDXalhgMWCGSmUs2jujH76cKwgg/RMj+QI8is4pI3Boe5sMPR6Tl76Es7MjqYpYoNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jvr/PYbzE/CPdSRDB5iJ614xdptc0r5yeiPTqzdBhhc=;
	b=N3rBpaEzlF4kcK0LESy/b6iqbyyePkSAHTk6ey4SZlWg8OIMNa7RdF3iVLI9jXWV4f1i
	 RQmbuY30gyLttUulikPpCipVuyuGEQy2zpYxnbFoWDHer4pQOZGxAr9Y2IkARyVugOWsI
	 6i/0OnK4y3aEjHC0udA6QueDDOd3xrHHi8o5bh4PUzDITsVn6lrGA+mTy9dg+strabXgv
	 Qk2BZMUrqlqUKTLST0XNUPA2TJo39RxzFvOXome0tvcYxlbIEZ4S/dFWl8+EMOqnpZGdC
	 Fhyu0AXoHsqUa4KMHOYFNIY6/p3Vr37b/+Q/CNC8LcRmUedgvGH918oewGQerhWECZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUz+J1eC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BECE606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUz+J1eC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCFD1F0089F;
	Fri,  6 Nov 2026 14:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976427;
	bh=Jvr/PYbzE/CPdSRDB5iJ614xdptc0r5yeiPTqzdBhhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OUz+J1eCqP6S9jiFmdzYT+UaOfu0BGIIw/Y5pakulMWeA0mwe9FJVrKOYlBjtYYiq
	 54WrbUaDLyDvA63QRn2TAIQnPK2DhPlpnTgr4ZV5TSWS7UgW3tVXeEqeEQEG+SXwyN
	 I0LryxvDvVoOxYlqjx+h8ne/67n3n2YiqngqFivKR+62ODlRo968odOXiQygDaES+G
	 QMSgAFdK0+vvfJPB0K8s3O49guPhLzTzh54hC1ZhA5MCWKqiYpjpgObg3uOaqHHf0c
	 Wp7/sWfXVR+ICXvFk4kCKLVS5Fg8WNpt20jM2gUWM7dzLkaB+onRxOES5INqvZOHuv
	 SHsWAzmYDVvVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: TDX: Set bits 31:16 to 0 and use UNDEFINED when synthesizing exit reason
Date: Fri,  6 Nov 2026 09:47:06 -0500
Message-ID: <20261106144334.354667-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-porous-slather-09d5@gregkh>
References: <2026110415-porous-slather-09d5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiaoyao Li <xiaoyao.li@intel.com>

[ Upstream commit b43c520b198ab70868307a489ef2117ed6d6c4cc ]

Set bits 31:16 to 0 instead of all-1s when synthesizing an exit reason,
e.g. if the TDX Module never attempted VM-Enter, or when stuffing the exit
reason due to an unexpected "real" EPT Misconfig.  Opportunistically use
VMX's KVM-defined EXIT_REASON_UNDEFINED (0xdead) instead of -1u.

KVM is going to support Bus Lock VM exit for TDX, after which bit 26 of
the Exit Reason becomes meaningful and indicates that a bus lock happened.
The existing synthesized Exit Reason, -1u, will cause a false positive in
that case.  Change the synthesized Exit Reason from -1u to U16_MAX, so that
bits 31:16 are set to 0.  This also avoids the potential issues when other
bits in 31:16 become valid in the future.

As a bonus, the check for synthesized Exit Reason in tdx_failed_vmentry()
becomes unnecessary.  Just drop it.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-4-xiaoyao.li@intel.com
[sean: use EXIT_REASON_UNDEFINED instead of another magic value]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/tdx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index dcbfcd79791c8..ad5b5497473a5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -904,8 +904,13 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u32 exit_reason;
 
+	/*
+	 * Return the synthesized invalid Exit Reason, as the TDX module
+	 * never attempted to run the vCPU, i.e. the Exit Reason is undefined,
+	 * but this is NOT a failed VM-Enter.
+	 */
 	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
-		return -1u;
+		return EXIT_REASON_UNDEFINED;
 
 	exit_reason = tdx->vp_enter_ret;
 
@@ -920,7 +925,7 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return -1u;
+		return EXIT_REASON_UNDEFINED;
 	default:
 		break;
 	}
@@ -951,8 +956,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
+	return vmx_get_exit_reason(vcpu).failed_vmentry;
 }
 
 static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
-- 
2.53.0

