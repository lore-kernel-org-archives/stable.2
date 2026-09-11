Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2543246ED
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136034; cv=none; b=dXNDvwheyZ80vi4yqmDpqmINzAKDzSbcs2LSA3iAtraVQ34627RJ9zyVmP8Xfo6xPOWL2oN8Vc07PtS8QKfyyEn82rgyDFmYdkkg1dJEXXrfgWDclQZW35PbsBHu/URAe2LKjGfAmWv2bqntFq/blZgI4hj7zWM0tMErC+GA1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136034; c=relaxed/simple;
	bh=ZEuRbS4Veua9fOY4yoQ+WVPAjC/qrEtVLHrbxvQYh+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfonB+5dHYiaeZaOdRdH1wTfeZe3qiDz9cbQmyJupSFB17wPSZP+cdRIRJxavwMgLZtAFNxTmXwmZr9h2gNMnc+Gfn27UHCvSPYhC3Djn/xCdLMhnSSdhwlmPoDlyqL/eyqoLV5PPb9hyymKsYSsZ+IcdZXBT7iYwB3u66UsYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edmnaUYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edmnaUYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE01F008A4;
	Fri, 11 Sep 2026 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136032;
	bh=IVqOzyCI2i94WwWblRo7gW0qf5pU9pWTPX5C/cs7X2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=edmnaUYwKNYfhclGPV50PMErraGkQE/zLo+zPc/dPw7luV0KH2M2GHWj/Lvdn7QXf
	 rnF3q4Km1J2AVPb0XMnmSI99g+dNBDlkl8uFg0fEqiNO2j9bTlFEyR+kHUt3+PUTvv
	 OZZ/PtCEpjAGbtPn8LBLc8CJTT4uGI4zwZUS/CxQiz7mKo2n3j+PPtfTfYNcGGonFR
	 lwbyXL1UGkzz93AU9xyVgdzvJSyY0mE35F7hpvnyzNqqHTs6vqlSSlfHDk6rCst1eT
	 s5oJUALIsxDxwq4gSB5PI9ifdmwV3pK+7fGr3ya75tnYjxvRdnMCc/R6dZxEdkKlyy
	 myyzPx1O8FEGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] KVM: x86: Always initialize EFER reserved bits on vendor initialization
Date: Fri, 11 Sep 2026 10:13:50 -0400
Message-ID: <20260911141350.763301-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090907-snuff-blot-3cf8@gregkh>
References: <2026090907-snuff-blot-3cf8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosry@kernel.org>

[ Upstream commit a4b8acd428ba3f03952ef309d7f438dbc357557b ]

EFER reserved bits are statically initialized, and do not reset if a
vendor module is re-loaded. For example, loading kvm_amd with nested=1
removes EFER.SVME (and potentially EFER.LMSLE) from the reserved bits.
Reloading kvm_amd with nested=0 does not add them back, allowing
userspace to set EFER.SVME with nested=0.

Re-initializing EFER reserved bits before configuring them on vendor
initialization.

Cc: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Link: https://patch.msgid.link/20260713181020.2735367-4-yosry@kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ placed EFER initialization directly in x86.c’s kvm_x86_vendor_init() because this branch lacks kvm_setup_efer_caps() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9e7c9e3edb5b4..84f8120ac31f8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -108,16 +108,7 @@ EXPORT_SYMBOL_GPL(kvm_host);
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
-static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
-#endif
+static u64 __read_mostly efer_reserved_bits;
 
 static u64 __read_mostly cr4_reserved_bits = CR4_RESERVED_BITS;
 
@@ -9818,6 +9809,16 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
 
+	/* EFER defaults:
+	 * - enable syscall per default because its emulated by KVM
+	 * - enable LME and LMA per default on 64 bit KVM
+	 */
+#ifdef CONFIG_X86_64
+	efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
+#else
+	efer_reserved_bits = ~((u64)EFER_SCE);
+#endif
+
 	r = ops->hardware_setup();
 	if (r != 0)
 		goto out_mmu_exit;
-- 
2.53.0

