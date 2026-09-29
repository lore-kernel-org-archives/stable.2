Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB53A7F7E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681935; cv=none; b=bycyTrf7eyox0BhQ47xDIxgJzweYwBzJFvON0Q+8v8pVsVlz/tAxEjrspCn/WR7O3WvuDhD0XJvf+TT/oXg4lPp4n6I2mlEkjS/KOc8e6hwvsyZ07llwhognI+DeZ7VMp32UpfipX2a0LeEDamEMHY0iFv8NWbBbyS4Yxsgkgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681935; c=relaxed/simple;
	bh=tPAdumBYxnb6kKxVv+rGG8hzNQt3KhbGqK1ooGxnFGQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CkGxZuH+bK21RBnKc9pChHr5ApuI9+utUNmHjr04Aeuo+d6Eq610nTvVBKIiceCw6dg0XurReUVy5kCs2ecgUq5ITW94gY4ZZ1wJBeerxJqIBdhwyvEul+7kLLiZ1mX+lH5lN32WMlCQclSxEoatY+xd72/5uaLcAjJUhxoqBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KdPRzKq2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KdPRzKq2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026321F000FF;
	Tue, 29 Sep 2026 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790681933;
	bh=27Jw7ylYmq4x8n6SJb3zuEuw0+4iYPMDKswzBCp2CcU=;
	h=Subject:To:Cc:From:Date;
	b=KdPRzKq2MG0n8WhCv8rfnvleJm1zAwS4v73HFOa5Yd8chnTYLQ5Uwqmx7cUDd8wOd
	 ZGQ2t4A2RkqGfri50xE+qSn57XfYeOALXjYrsgC2X/o/h8rkJOGq/fU3GOLcqCQowc
	 UmrjIJJekY6VpGX8GSFkwQ5V8jvDuKOgkaUWjMX4=
Subject: FAILED: patch "[PATCH] KVM: x86: Fill kvm_run exit fields in common" failed to apply to 6.6-stable tree
To: seanjc@google.com,fane@google.com,rkskek9254@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:38:39 +0200
Message-ID: <2026092939-anew-saggy-f399@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c1214f293d77c6e425a379f90d09bdb4815993a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092939-anew-saggy-f399@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1214f293d77c6e425a379f90d09bdb4815993a8 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Mon, 21 Sep 2026 14:16:08 -0700
Subject: [PATCH] KVM: x86: Fill kvm_run exit fields in common
 get_nested_state_pages() error paths

Fill kvm_run with "internal error, emulation" in the common error handling
paths for getting nested state pages, as requiring each check to manually
fill kvm_run is error prone and requires a non-trivial amount of copy+paste.

Specifically, both SVM and VMX fail to fill kvm_run if load_pdptrs() fails,
and SVM fails to fill kvm_run if kvm_hv_verify_vp_assist() fails.  If those
flows fail, the *best* case scenario is that KVM will exit to userspace
with KVM_EXIT_UNKNOWN.  The worst case scenario is that KVM exits with a
stale exit_reason and confuses userspace.

Note, SVM never exits to userspace if something goes sideways when dealing
with vmcb12 assets while emulating VMRUN, i.e. lack of SVM-specific code is
not a bug.

Fixes: 0f85722341b0 ("KVM: nVMX: delay loading of PDPTRs to KVM_REQ_GET_NESTED_STATE_PAGES")
Fixes: 232f75d3b4b5 ("KVM: nSVM: call nested_svm_load_cr3 on nested state load")
Fixes: 3f4a812edf5c ("KVM: nSVM: hyper-v: Enable L2 TLB flush")
Cc: stable@vger.kernel.org
Reported-by: Jinwoo Lee <rkskek9254@gmail.com>
Closes: https://lore.kernel.org/all/20260813043932.3214460-1-rkskek9254@gmail.com
Reported-by: Stefan Teodorescu <fane@google.com>
Link: https://patch.msgid.link/20260921211608.1030158-3-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 73f37b050d0a..f9090b601efa 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2125,13 +2125,8 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 			return false;
 	}
 
-	if (!nested_svm_merge_msrpm(vcpu)) {
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
+	if (!nested_svm_merge_msrpm(vcpu))
 		return false;
-	}
 
 	if (kvm_hv_verify_vp_assist(vcpu))
 		return false;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..40c1a5f6fa8a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3465,10 +3465,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		} else {
 			pr_debug_ratelimited("%s: no backing for APIC-access address in vmcs12\n",
 					     __func__);
-			vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			vcpu->run->internal.suberror =
-				KVM_INTERNAL_ERROR_EMULATION;
-			vcpu->run->internal.ndata = 0;
 			return false;
 		}
 	}
@@ -3539,11 +3535,6 @@ static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	if (!nested_get_evmcs_page(vcpu)) {
 		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
 				     __func__);
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror =
-			KVM_INTERNAL_ERROR_EMULATION;
-		vcpu->run->internal.ndata = 0;
-
 		return false;
 	}
 #endif
@@ -3915,8 +3906,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 
 vmentry_failed:
 	vcpu->arch.nested_run_pending = 0;
-	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
+	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR) {
+		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+		vcpu->run->internal.ndata = 0;
 		return 0;
+	}
 	if (status == NVMX_VMENTRY_VMEXIT)
 		return 1;
 	WARN_ON_ONCE(status != NVMX_VMENTRY_VMFAIL);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4ec17aaff413..aad065d035fb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8072,6 +8072,9 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 		if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
 			if (unlikely(!kvm_nested_call(get_nested_state_pages)(vcpu))) {
+				vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+				vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
+				vcpu->run->internal.ndata = 0;
 				kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 				r = 0;
 				goto out;

