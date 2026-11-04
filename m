Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819922;
	b=AtIDvSMouZMZPqY4+rhZKJFJQuTt7UcG+JXZGK8u6LnHoQaqevGn8iai9qF8KU5lqZmp
	 TWj/z2YlBThcOSg38vG7i626Ugx7XeJ/ZssME6pQ9YLHURO1G+z4VvFlRG0EH8QzNyHJH
	 HC65D+eABIf3DhPnl3w76uHTy19Gne/589yVf1ctT65yDerWHDmcZSUpEarm86w5qG6JY
	 3hzBjxXaqIJoRBhIRD5c7NIdk/EWGxNaUrwRBZO/+luLl76o2tLTizoavqosqIpJCYg06
	 qHKuZGpnIs1GnmJqDt6PpV6aJK67/Y9YqVSSEeyXNjjxEbttbH7YpY83Bbxx0Xv2GxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819922;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4aRXolj3DcxyowgYB2B/4T5GPw5sT30CQ9iSEg7MFAw=;
	b=Yg2tQrjMsBKPHUDlr1g/ZC37am221WD16nZMiSqPc82ROODfpPQ5lXO57IOgJ+bxNYYz
	 DTqSnPaHqNmzjYD1EfAShvp5BDa2Z4a0wL+6TW6DdjK4xe5fh8T8MB6riLDC6+ST9tMyw
	 MaiA8/qy5fT/1PYzNc/oXDfYlapqB5RNAE7tMRZPailz7sx4JmUdRhO4ZrhridVifVQG2
	 RDzyUJiByPt7fQLolTGYYUjUQTJmo89KEJoj1XX56MAYn3X65plG5QfTwNu7+QblKQmBN
	 7PJutvBOv3e58SqKBJyNXP2dqSSur+3NIJ+y8eqC7Q1/ueoVW5Wv4uZAiGcTbzQcP8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VbORWY+x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F87606B2D8
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=VbORWY+x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0904A1F00A02;
	Wed,  4 Nov 2026 19:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793819920;
	bh=4aRXolj3DcxyowgYB2B/4T5GPw5sT30CQ9iSEg7MFAw=;
	h=Subject:To:Cc:From:Date;
	b=VbORWY+xdhcjtRVH2m9g3UjrzGV7Mwx67QnqIsyWhGUGEVJvRD+NByJ1wMaR8z+zr
	 Ke6XGkuZAvbqdAamXivxPcagkvs73LdMdNNbsffmYxP82hJ/zQagJeL/E2AeTVJY2z
	 Q+hxSDCvSlZdAoZsijmcdPDzOmTWOVq6mFMInt2E=
Subject: FAILED: patch "[PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used for" failed to apply to 6.18-stable tree
To: seanjc@google.com,binbin.wu@linux.intel.com,rick.p.edgecombe@intel.com,xiaoyao.li@intel.com,yan.y.zhao@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:18:38 -0500
Message-ID: <2026110438-shrink-panic-2119@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110438-shrink-panic-2119@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d85f7dc8cf3c91a131946dae4c3aa8d9c97322d7 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 16:56:55 -0700
Subject: [PATCH] KVM: VMX: Formally define KVM's "0xdead" exit reason used for
 failed VM-Enter

Add EXIT_REASON_UNDEFINED to track KVM's magic "0xdead" value that's used
to stuff the exit reason on a failed VM-Enter so that the magic can be
reused by TDX, and to make it more obvious that it's an arbitrary, KVM-
defined value (though the whole "dead" thing makes it pretty darn obvious).

Opportunistically add a compile-time assert to ensure the KVM-defined exit
reason never collides with a "real" exit reason.

No functional change intended.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://patch.msgid.link/20260921235656.1107929-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 3f1b3096ff04..e49b836c7313 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -20,6 +20,14 @@
 #include <asm/trapnr.h>
 #include <asm/vmxfeatures.h>
 
+/*
+ * UNDEFINED is a KVM-defined value used to indicate that the basic exit reason
+ * is undefined/invalid, e.g. on VM-Fail or if TDX never attempted VM-Enter.
+ * The value itself is arbitrary, it just needs to not collide with a real exit
+ * reason.
+ */
+#define EXIT_REASON_UNDEFINED			0xdead
+
 struct vmcs_hdr {
 	u32 revision_id:31;
 	u32 shadow_vmcs:1;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..c897dbf0e954 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6388,6 +6388,8 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 static const int kvm_vmx_max_exit_handlers =
 	ARRAY_SIZE(kvm_vmx_exit_handlers);
 
+static_assert(EXIT_REASON_UNDEFINED >= ARRAY_SIZE(kvm_vmx_exit_handlers));
+
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -7474,7 +7476,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	vmx_enable_fb_clear(vmx);
 
 	if (unlikely(vmx->fail)) {
-		vmx->vt.exit_reason.full = 0xdead;
+		vmx->vt.exit_reason.full = EXIT_REASON_UNDEFINED;
 		goto out;
 	}
 

