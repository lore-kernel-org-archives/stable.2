Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047392;
	b=fm+zeaL+0DzVsLpGnyD79MveyHfYxpRGmDktdSApR35+Fg9ooxGPN91QuYIGZrch/iEB
	 Lt/c9GRYlh+ik+blCvqT/wh0FJWOQntremuyqvwa689aQRAa7jBX5XjTZsatodmpN+WU/
	 lhYezJuIkFzQjdfJlbpcb1mTDjaZKbBeRIwMQ8uvJqLwTvB+VMa0u0JRiJvsm2ImiebmY
	 W7qXNeo0RcuWZM6vcPuskDHq+ucqgeF5aB3PCDAFSOKSqutxSp4pZ5RGeScwZf+Pdk5ss
	 VThEwUoGi56ZhLwRinh+fB8f8HNuW0J9ZYWtjNpUV7tYHLSz+O1oQeTMoziWiOdfK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GBzhIQgfOqAqPAtygu4nyEpMBjqBrKJb0PyWkQ3mYcY=;
	b=PQB6jxj/yBMazS2ocUclcT6IEmWPDhovWZ0/E++srweMOkmUTP3E0oHhsXPPQ5oMnFvx
	 4FQ991Dqf6qvbz+z8H1qS18Evs4mj8r1RItgXe47JzTpfRAcV4vp4rEbcAKScyi0te6U2
	 +Nq2GScYUvuYHUHFegtWPPdti2sFdmP4jEQFeiaZQol1M9ewXlhMNYJtyaQXdbSXn6GAR
	 1AoDCLf+svqXide3aiKecOo0yLxQric3YIo1EHL9cfEV1FWzC3gxkgTK3qfHIhACw6w2M
	 uyfKjDaWxPSIM8iQFytSPERcBPZVpZ74OxATyALqcI93Fn7+obJPCdyMEOKuibg9R+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYrWz8Hj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECD606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYrWz8Hj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464D41F008A1;
	Sat,  7 Nov 2026 10:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047391;
	bh=GBzhIQgfOqAqPAtygu4nyEpMBjqBrKJb0PyWkQ3mYcY=;
	h=From:To:Cc:Subject:Date;
	b=aYrWz8HjySy/gcgKMRtn5+ghFyN45NLCpHOHfw9gh3AJIL/wb/ubGkOX2EOaA49R6
	 k+NzPgnD7EOvRStgFTQcWL99wYfWlt31GrmIOESZCSj7QR4dSlc5ncdNPuVqyUkt86
	 j3QxEg9VQNSdEiO4qFMu5YPccb86yFCSvrMotz1phqKpdTeUsc2+x+nX4Nm2V4DzQc
	 i/+nDsfZuXebDkGy77j00W7cHvqxw7vCwk2hnDajn0JuU9aIsEZiIDV3IYdxWQLcuM
	 pBSzsRx1wFhqsY41EFlEsDY/QUysGjmJUFilIUsAXhzDKFP1fZ2pDzvVhcu0dJ29Fw
	 Kxe3cQRMgOLVA==
From: Sasha Levin <sashal@kernel.org>
To: xiaoyao.li@intel.com,
	nik.borisov@suse.com,
	seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: VMX: Make handle_bus_lock_vmexit() a shared helper" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:50 -0500
Message-ID: <20261107052950-failed-6.6-326fa2c9b4d3@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 326fa2c9b4d3e6cab58c139eb55aaabd7179192e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052950-failed-6.6-326fa2c9b4d3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




