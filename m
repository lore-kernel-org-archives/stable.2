Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046647;
	b=j96PMLHvjHQGvY5oukpEATkngEf6/OT17QMcbV4SXVeyH+7N75XQOUlcNhCweArpJXh9
	 1dhARtaUFFHG0FtzooDdE7sCUWGKKNML7riBzWdXFCCSbeA5vWVNCQ+CbT2U+6GLt8epB
	 kD1WMWk2+JjGo5wDw44PSctS+Yr97eL09lZle0PbJJ0HgfhsvqMQ/KM4FVB67NqrjdvZF
	 TYAEvR7hD9vatY+fQwimy3b//8Eb9Hm9C54ZTzroUSWmJr97M2B+GC7oxuzoFffeweqlz
	 k5a+4oGB7+URPGczlbPUwBvEtnsIE+hcD9RSc7iy7I8bQGefmksvvaadJ1gKiya6N3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4N15mT9OyUbt26KLQw8Rbb9s3tlKCmxYstkFbUyVhk0=;
	b=XIsorz3UVXN639gYUkqagEkgydQwDZX2Bn901GhsjKs8DyFH7I3kickZgfOgs5nKhqxR
	 WdIxLdoiIDFIQ1m3euPbs0mk0okxz5hfeT3Ly8MkHL5dEZ7d4o8EI9hfS05+WC/eHTgiZ
	 zoB5kLVcsHfKpHDomPSlZmc8jO4wpdv/k2Sc5cZy4y5RaMrI3WpQ/Ch9NDTDcV1JeVFlq
	 RjAo0TAGjDTQztrC6ZsfUoTtFI+04FKv/wRRXqFUos4nnSmV3RyDppNaXXX+3QH5JTbtV
	 vI59J4a44gOYoDd6WoXR3y2h+3KdyMSU13iUWRaIL/xfh4ib5LAYObLPkTKcYHq7EfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmockIkc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EB608D948
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JmockIkc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D541F008BD;
	Sat,  7 Nov 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046647;
	bh=4N15mT9OyUbt26KLQw8Rbb9s3tlKCmxYstkFbUyVhk0=;
	h=From:To:Cc:Subject:Date;
	b=JmockIkccwkXCypVE+L1AV3dvfWCv8CJkR583bzKglsehrx8zUfcWOpnrea4o2+01
	 gCur8s7Q+aHgA0hcvgozwQtH2bpHutxLONom+KQ60ot/FPCQhdayzbqVXISXFOeQKz
	 az3ZunyELbfm9FAqlRlMwq87mauI3Mvxvvl8lJL4IHEaUdkXBpMnsUre0n6OhGaluW
	 OWl0GYOMSlRMHzm6QgiQQExFxcTx3W52SlS9MGJb2WPmixy6jR9nQgPj9QajAvfStx
	 S9YeSVcO9S3s+kMi9/8VO+0QwyzN4du5zgBz47eITj7MxNRUHBpmW8SGlURUid1Zbe
	 /8+bPdScbIkQw==
From: Sasha Levin <sashal@kernel.org>
To: xiaoyao.li@intel.com,
	nik.borisov@suse.com,
	seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:17:25 -0500
Message-ID: <20261107051725-failed-6.12-326fa2c9b4d3@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 326fa2c9b4d3e6cab58c139eb55aaabd7179192e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051725-failed-6.12-326fa2c9b4d3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 326fa2c9b4d3e6cab58c139eb55aaabd7179192e Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:49:01 +0800
Subject: [PATCH] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper

Move handle_bus_lock_vmexit() from vmx.c to main.c to make it a shared
helper so that TDX can use it for Bus Lock VM exit handling as well.
Rename it to add vt_ prefix to reflect that it is a helper for both VMX
and TDX.

Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20260819094903.3060020-8-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h |  1 +
 arch/x86/kvm/vmx/main.c   | 11 +++++++++++
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 7fce1bbabc78c..bbeec197a507a 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -203,5 +203,6 @@ static inline int __vt_handle_notify(struct kvm_vcpu *vcpu,
 }
 
 noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index ea0d825e556d2..835de375e8c8c 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -878,6 +878,17 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 #define vt_op_tdx_only(name) NULL
 #endif /* CONFIG_KVM_INTEL_TDX */
 
+int vt_handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
+	 * VM-Exits. Unconditionally set the flag here and leave the handling
+	 * to .handle_exit() callback.
+	 */
+	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
+	return 1;
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 6df390ae8708f..3ba1e762e7e75 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6267,17 +6267,6 @@ static int handle_encls(struct kvm_vcpu *vcpu)
 }
 #endif /* CONFIG_X86_SGX_KVM */
 
-static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Hardware may or may not set the BUS_LOCK_DETECTED flag on BUS_LOCK
-	 * VM-Exits. Unconditionally set the flag here and leave the handling to
-	 * vmx_handle_exit().
-	 */
-	to_vt(vcpu)->exit_reason.bus_lock_detected = true;
-	return 1;
-}
-
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
@@ -6366,7 +6355,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_VMFUNC]		      = handle_vmx_instruction,
 	[EXIT_REASON_PREEMPTION_TIMER]	      = handle_preemption_timer,
 	[EXIT_REASON_ENCLS]		      = handle_encls,
-	[EXIT_REASON_BUS_LOCK]                = handle_bus_lock_vmexit,
+	[EXIT_REASON_BUS_LOCK]                = vt_handle_bus_lock_vmexit,
 	[EXIT_REASON_NOTIFY]		      = handle_notify,
 	[EXIT_REASON_SEAMCALL]		      = handle_tdx_instruction,
 	[EXIT_REASON_TDCALL]		      = handle_tdx_instruction,
-- 
2.53.0




