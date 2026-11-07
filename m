Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046030;
	b=SAucIGio7c4ywNZF9sIK0je3Iw6njeNnSQe6XmhbRZOKsIR61pX03zh/gRHR/trG0vGd
	 5ks+21PykwW1D+QGJR3p4f5wka5tOXjt6cjciFGS/TEV4VZTN7jUFA46eCM1PX222hkhv
	 lEY7MKzIopzXnb+wcVs7Q8NilgNDsr6jVv0vw+3a+7uez99rsGqLivk+j4XqpBj9UCAaR
	 KcsQoE03ospWakx7RjjDqPw+4oB4T/jBZsbbiDWJ8zZ71rvwIQeRDaN7k+nLiFWLvehYO
	 kP6tZmV49WnYCVxz1Dp4041Fst/g3ViKIWxfi3tZpzs1KD25lRKnZcuIpZCEABV859w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046030;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S8fjUKcRBvHFg9gFCqizASFSX+NDZLjrQWOMPpNITLU=;
	b=dJ7d8U6tT8sHDYhH4MVec+9rV48KTuCk5Rgh1xh+yEpG8bmPo4vBZz+rlZXzriv1uJ03
	 bF7dlDZj6hNlp9P83iT8tGO5TK5T3Jb2y9BgCwGT8KsjtOBJmUF39unjHk8auBHyDjm2P
	 4NtERXdWXjCYM8tqKlf9YSlVQTKOqd1M16Sga7hDr8FoJ9ujOPcGl/GKDLaC2EYt3atbQ
	 n2v81CWQEjSc7D5Fbs9YlByLXafDmQMqGvtnS9Q9/9B0cAvA8D7qcectqf7JNl/zFPWuv
	 EFkAMU4BCt3DeaDSjNa8Sfm49uOmJQ8kU66TVrJiyhTSfJi32Df+AVrQGmUF0iDDUjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S192mC74;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E454606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S192mC74
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F991F0089F;
	Sat,  7 Nov 2026 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046030;
	bh=S8fjUKcRBvHFg9gFCqizASFSX+NDZLjrQWOMPpNITLU=;
	h=From:To:Cc:Subject:Date;
	b=S192mC74cQMvSF/hNMUC4kMKAZbS0fYVLwZWyoKBwNdJVkncDDrEnAX/o2YLuMr9d
	 PV33sonK5XCgpAMxZ+EtTXE6XQLkyu43OcLKYbvgtK/BZ4+EdrenGrtkrSsrFWKQnA
	 EK2r71pIQ0gWCYdVIAeGVfrNlkg4X22raL0/ZOnLbBhwYp82eL8yLfEj3uWEYvSPUP
	 EoCjCELV7ozFyZCWqVm6t/Sfo/ooDPWJokbOX+TcNPQ5KY7lHBdfMicQBJjVnFrZ/z
	 THilR7IGfWCDRDi/y8UIm1+dka77ccRSyllgqoJouX9CUqbNHDmGeWhd//1FKJogYq
	 sA8N3L+udGeeg==
From: Sasha Levin <sashal@kernel.org>
To: xiaoyao.li@intel.com,
	chenyi.qiang@intel.com,
	nik.borisov@suse.com,
	seanjc@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] KVM: TDX: Enable Bus Lock VM exit" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:08 -0500
Message-ID: <20261107050708-failed-6.18-63d196e2e204@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 63d196e2e20429de5ba501f1b6059d9b93140007
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050708-failed-6.18-63d196e2e204@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 63d196e2e20429de5ba501f1b6059d9b93140007 Mon Sep 17 00:00:00 2001
From: Xiaoyao Li <xiaoyao.li@intel.com>
Date: Wed, 19 Aug 2026 17:49:02 +0800
Subject: [PATCH] KVM: TDX: Enable Bus Lock VM exit

Enable Bus Lock VM exit functionality for TDX guests.

Bus Lock VM exit is an existing feature supported by KVM.  Userspace can
enable Bus Lock VM exit through KVM_BUS_LOCK_DETECTION_EXIT when it's
reported as supported.  However, KVM reports the support of this CAP
just based on the hardware capability but doesn't differentiate between
VMX and TDX.  This leads to the issue that userspace can enable this cap
for TDX guests without getting an error, but the feature is not actually
enabled because KVM doesn't call the TDX module API to program the
relevant TD VMCS fields.

Enable Bus Lock VM exit for TDX guests by programming the
BUS_LOCK_DETECTION control in the TD VMCS and by adding the exit handler.

Note, there is no enumeration bit for this feature by TDX module because
all TDX modules support it and allow to set the TD VMCS as long as the
hardware supports the feature.

Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Cc: stable@vger.kernel.org
Originally-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20260819094903.3060020-9-xiaoyao.li@intel.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6762724a80f57..3d093efe8820b 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2050,7 +2050,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 }
 
 
-int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+static int __tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 vp_enter_ret = tdx->vp_enter_ret;
@@ -2151,6 +2151,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	case EXIT_REASON_NOTIFY:
 		/* NMI blocking state is handled by TDX module */
 		return __vt_handle_notify(vcpu, vmx_get_exit_qual(vcpu));
+	case EXIT_REASON_BUS_LOCK:
+		return vt_handle_bus_lock_vmexit(vcpu);
 	default:
 		break;
 	}
@@ -2160,6 +2162,22 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	return 0;
 }
 
+int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
+{
+	int ret = __tdx_handle_exit(vcpu, fastpath);
+
+	/* Exit to user space when bus lock was detected */
+	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
+		if (ret > 0) {
+			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
+			ret = 0;
+		}
+
+		vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
+	}
+	return ret;
+}
+
 void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code)
 {
@@ -3186,6 +3204,10 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 				vcpu->kvm->arch.notify_window);
 	}
 
+	if (vcpu->kvm->arch.bus_lock_detection_enabled)
+		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
+				 SECONDARY_EXEC_BUS_LOCK_DETECTION);
+
 	tdx->state = VCPU_TD_STATE_INITIALIZED;
 
 	return 0;
-- 
2.53.0




