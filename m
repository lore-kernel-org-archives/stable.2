Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648233BB680
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128310; cv=none; b=tJxaH36ezCeiO3rbB5HdCwtxm1HIq8uW41/4td63c/AbQLH8g3Au3EIyegbvY6/a6wnenaIOV0f9KNPlqa9QPFOUa/en9tmSs5qMY/rfF4lEUEyzjUJHjUe2mCZym1/8MJdZAD8Bm5jWpiRlbxbeWYHBBzoZTEV1q7Ff/dh1cXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128310; c=relaxed/simple;
	bh=rp2kEOEQzOYh7tPo5dirOpFNIXljMryl8YHILx+g4zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO6MsmvpLpfsb/+AsUurfLNGI04v+vZ7wnk4Ri7Un86nuxKUYxVXHZuwDrQGz2cyRj99XDQ554AevxkGc7gsK5R4fDlJOHNlQSQh7UTGMnge3JPPNegXyp2v80ehXnx31kIcpaLsHMYfyfJssEyIqjDveJV7tTVQJSCmdWiUeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXFI0NRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXFI0NRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F17D1F000FF;
	Fri, 11 Sep 2026 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128304;
	bh=xJUt2c/mNqCnCeKZpFqwYVIkwn1Q4jSdrRJpeIKjfQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXFI0NRnv3+WfaFNNJ+BDb+R+NTvK1pZGDyx6+VowjbBj4lb45SMA/A50qHPpPdvX
	 JjrSW2likZx1Gkk3poXyXm1L9/inrANfhO2PKzb/A88+AjndwEfPvoDaTlGm4S5BqU
	 i7op7R51Gs2ID/atJ+AOBGkHmaes6kw1br381aOMmi4L3cD1tpFg3C2PVHCCXPrWlv
	 SuFav3Q1FYQs2PKKFrUhl8qMFA+XhnE3tDq9IR+gPthxAQdyUI/n4o/A7D5veZd5gs
	 xrADStnXml+eVFj3YQixAIteyMVluahdf1eMCJLaAYdG20SmxTGHpToJtpvLblQEzD
	 oqkvxgkgj2otg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: x86: Disallow EFER.LME and EFER.LMA if long mode is not supported
Date: Fri, 11 Sep 2026 08:05:02 -0400
Message-ID: <20260911120502.489632-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090915-drainer-judicial-082f@gregkh>
References: <2026090915-drainer-judicial-082f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit e62392bf39ebfdf60d1d082799397fe1cbf8dfc5 ]

Remove EFER.LME and EFER.LMA from EFER reserved bits only if long mode
is actually supported. KVM does check long-mode support before allowing
the bits for guest writes and userspace writes through KVM_SET_SREGS*
(in __kvm_valid_efer()), but userspace writes through KVM_SET_MSRS only
check reserved bits.

In practice, this doesn't really matter. The true motiviation is getting
rid of the #ifdeffery when initializing efer_reserved_bits.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-3-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ adapted EFER changes to x86.c, placing the capability check in kvm_x86_vendor_init() because kvm_setup_efer_caps() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9e7c9e3edb5b4..5bf719a6a6b9c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -108,16 +108,8 @@ EXPORT_SYMBOL_GPL(kvm_host);
 #define emul_to_vcpu(ctxt) \
 	((struct kvm_vcpu *)(ctxt)->vcpu)
 
-/* EFER defaults:
- * - enable syscall per default because its emulated by KVM
- * - enable LME and LMA per default on 64 bit KVM
- */
-#ifdef CONFIG_X86_64
-static
-u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
-#else
+/* Enable syscall by default because its emulated by KVM */
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
 
 static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
@@ -9822,6 +9814,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (r != 0)
 		goto out_mmu_exit;
 
+	if (kvm_cpu_cap_has(X86_FEATURE_LM))
+		kvm_enable_efer_bits(EFER_LME | EFER_LMA);
+
 	kvm_ops_update(ops);
 
 	for_each_online_cpu(cpu) {
-- 
2.53.0

