Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977261;
	b=fNv5EWlY0qdW8hr5FzXa3IA0CahjP8lZzJVKs5SeU8ZFNbPEms9rqXnLgUXRGLQRI9mz
	 VGXABTGoEn9yYBMfORpYlOZAGpgooSEfwTGyuj7tupsTxVTR8lLOBMn4HCjJc7D9xwilc
	 5ZYwFHhbfJjAEpJsiB40U7ZJolYeRBJHVEWjiU6v2I6rLvrhVYiBxPMZplVtzIdYXMPtR
	 chlur+jMiBsKxuN067V7tZ623ZUiIH0B/+xYxi81vhek/ggtsw7IqxG2JY+LLwvbczf3Q
	 EyF8aTyx1LIQlw2bPyfKzLyjIec+XZOiqfJG0DAcgoR/a7wXU4XGIrPDpUvy9ZX+iZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977261;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wlQ/ylp9GVZtOOHn9Jt4l4fXgeRsbR0XY1uRiov6ulI=;
	b=f1I6c/N5YgJrJeSDgI3Jag0HruwwxctR03nXoX/9j7MU39qRMcS4HFohYh7R5OhufZ5s
	 PZam9T+Kch3+R6kwC1GWEfg5N/PxN5gTY5hIsY9Zx9QVqkgTPRFvLR28FVQTI6wMetmGA
	 sE38iWljb8ZPC3JOY+6z77Uu5RB9IZfOZADGmHy0UQf6lKHOyZW+AmnZtVOjAk9xUJSHT
	 D6/h9nzhVDz86Ni2DvOToBicien3fpr4OlXJYGRfarM3gduGLUMkAfecO5JEP9yMTjseH
	 zgoOm53N6a9t30ybIeRMObY8ytH476AyZYhv/aIqOgJTvIEQLuSgxwFjRAIwdJOhbIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO2RWjZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869F3606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YO2RWjZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A7A1F0089F;
	Fri,  6 Nov 2026 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977261;
	bh=wlQ/ylp9GVZtOOHn9Jt4l4fXgeRsbR0XY1uRiov6ulI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YO2RWjZQt+zIFMY/bwd7PQzBXX7oHTLvrq9UhYJVg3CgDDhpq/lmffBWozFXQncrr
	 WlSOyh7KcE//j1NBe2UvYTfOllplkNGNZzczpuDhgb5FvXm5h55pNMlZF2JGMnMEL6
	 Y5HRYqa/V7PjlGoG22kX961LlojqeHQikd+Vk2+cXjZ9MP5Ldp5zU+AfEqnQo/5uHx
	 gptM2LbrFpKZExpjq7VmPWgy33nX7BXRBAEp/kdS4TjfkU4ZCYNE5g343KQv+5m38X
	 YQ480pR/A520nW/Nne10SCb4xwJYOov7TE42Fm0YdiU0IEMA9cyDSZX4KJp6GzOo8f
	 TEdf4t7Ih6XRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] KVM: TDX: Don't assume exit_reason[31:16] is all-0 in tdx_to_vmx_exit_reason()
Date: Fri,  6 Nov 2026 10:00:59 -0500
Message-ID: <20261106150048.399638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110444-external-riverbed-0f47@gregkh>
References: <2026110444-external-riverbed-0f47@gregkh>
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

[ Upstream commit bc335ce04408750585b4b32f248c543c9493d545 ]

When handling the real Exit Reason, don't assume the upper 16 bits as
all-0 in tdx_to_vmx_exit_reason(), in preparation for enabling Bus Lock
VM exit.

When Bus Lock VM exit is enabled, the bit 26 of Exit Reason becomes
valid and it can be 1 with various exit reasons.  Change the logic in
tdx_to_vmx_exit_reason() to check the 'basic' Exit Reason for correctness.
Also preserve bit[31:16] when changing the (basic) Exit Reason, to not
lose the information in bit[31:16].

Change the return type of tdx_to_vmx_exit_reason() to
"union vmx_exit_reason" for the convenience of manipulating the basic
field.

Fixes: c42856af8f70 ("KVM: TDX: Add a place holder for handler of TDX hypercalls (TDG.VP.VMCALL)")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260819094903.3060020-5-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Depends on <20261106144334.354667-1-sashal@kernel.org>

 arch/x86/kvm/vmx/tdx.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ad5b5497473a5..2739e60bd06a2 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -899,10 +899,10 @@ static __always_inline bool tdx_is_exit_reason_valid(u64 vp_enter_ret)
 	}
 }
 
-static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
-	u32 exit_reason;
+	union vmx_exit_reason exit_reason;
 
 	/*
 	 * Return the synthesized invalid Exit Reason, as the TDX module
@@ -910,22 +910,26 @@ static __always_inline u32 tdx_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
 	 * but this is NOT a failed VM-Enter.
 	 */
 	if (!tdx_is_exit_reason_valid(tdx->vp_enter_ret))
-		return EXIT_REASON_UNDEFINED;
+		return (union vmx_exit_reason) {
+			.basic = EXIT_REASON_UNDEFINED,
+		};
 
-	exit_reason = tdx->vp_enter_ret;
+	exit_reason.full = (u32)tdx->vp_enter_ret;
 
-	switch (exit_reason) {
+	switch (exit_reason.basic) {
 	case EXIT_REASON_TDCALL:
 		if (tdvmcall_exit_type(vcpu))
-			return EXIT_REASON_VMCALL;
-
-		return tdcall_to_vmx_exit_reason(vcpu);
+			exit_reason.basic = EXIT_REASON_VMCALL;
+		else
+			exit_reason.basic = tdcall_to_vmx_exit_reason(vcpu);
+		break;
 	case EXIT_REASON_EPT_MISCONFIG:
 		/*
 		 * Defer KVM_BUG_ON() until tdx_handle_exit() because this is in
 		 * non-instrumentable code with interrupts disabled.
 		 */
-		return EXIT_REASON_UNDEFINED;
+		exit_reason.basic = EXIT_REASON_UNDEFINED;
+		break;
 	default:
 		break;
 	}
@@ -942,7 +946,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 	tdx->vp_enter_ret = tdh_vp_enter(&tdx->vp, &tdx->vp_enter_args);
 
-	vt->exit_reason.full = tdx_to_vmx_exit_reason(vcpu);
+	vt->exit_reason = tdx_to_vmx_exit_reason(vcpu);
 
 	vt->exit_qualification = tdx->vp_enter_args.rcx;
 	tdx->ext_exit_qualification = tdx->vp_enter_args.rdx;
-- 
2.53.0

