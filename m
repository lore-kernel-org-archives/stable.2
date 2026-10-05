Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B44A485F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210861; cv=none; b=TRKN2rBEK006qJf6VxqFHY00UW7x6W8MKOA5qoQc/sOF0dG8B3tTljz3ujldu9hpU6UQTrHWLwRJMyc5EoabX/2B2d0rYUSG8DV2o4LGY8OF50gJEovD08MFpC7i/mRvY5UwLFMOfqsXvpygyxrgkDLIHd/oeQmsWaIBaqovZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210861; c=relaxed/simple;
	bh=QdkrPIk5ibqXUSRvaLb+oXPz//41mNf/IA+/7rdhhvg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uKONTgfZeR91+jua53kHscuqVkyuuAkyv+eYP80h6HQ1ZkVFhPOn7SuX1ka96Wg1ED8YsGY7b86G+noppPL0evwYEWNs9Q2Frqrv7L1G8uPwrvVFnF7YuAE3quAaQN/qngyG1BTHJolFafpJ4FSS+1hqcblIUbFrFI03xtWv2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVvTyFhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVvTyFhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D91B1F00893;
	Mon,  5 Oct 2026 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210852;
	bh=DYUnX8Xn4qvlcZrM6KABsD/T7K8Z4jojxeZDdsFiuIg=;
	h=Subject:To:Cc:From:Date;
	b=bVvTyFhhzUOMK1cBcpKTo3vGVsBf+Sn25GcaQQpEPrnaTJCunSfagyVkpAa/O7QLF
	 tDC55kmTx4lauU+rl0n1b6ArpwlkPbY82rRdxyzFgng5tIgJXvKkX7nrAshi6WAisB
	 NOKWSaLGxWp/I1D02dUfNElwDlzewQM6MzODpNw4=
Subject: FAILED: patch "[PATCH] KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls" failed to apply to 6.1-stable tree
To: seanjc@google.com,pbonzini@redhat.com,vkuznets@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:34:01 +0200
Message-ID: <2026100501-quotable-serotonin-0595@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2abb25273c82061dd4670690c81c319c03740bf6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100501-quotable-serotonin-0595@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2abb25273c82061dd4670690c81c319c03740bf6 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 13 Aug 2026 14:44:03 -0700
Subject: [PATCH] KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls
 are modified

Force a refresh of the vmcs02 MSR bitmap during nested VM-Enter if the
runtime eVMCS controls (pin, primary, secondary, etc.) are being updated.
If L1 isn't intercepting TPR writes, runs L2 with TPR virtualization, and
then runs the same L2 with TPR virtualization disabled, KVM will fail to
refresh msr_bitmap02 and leave TPR in passthrough mode even though TPR
virtualization is disabled.  I.e. failure to refresh the bitmap lets L2 (or
L1 by proxy) read and write L0's TPR.

Fixes: 502d2bf5f2fd ("KVM: nVMX: Implement Enlightened MSR Bitmap feature")
Cc: stable@vger.kernel.org
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 40c1a5f6fa8a..b25216862740 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1754,6 +1754,9 @@ static void copy_vmcs12_to_shadow(struct vcpu_vmx *vmx)
 static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields)
 {
 #ifdef CONFIG_KVM_HYPERV
+	const u64 runtime_controls = HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1 |
+				     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP2 |
+				     HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC;
 	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
 	struct hv_enlightened_vmcs *evmcs = nested_vmx_evmcs(vmx);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(&vmx->vcpu);
@@ -1762,6 +1765,9 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 	vmcs12->tpr_threshold = evmcs->tpr_threshold;
 	vmcs12->guest_rip = evmcs->guest_rip;
 
+	if ((hv_clean_fields & runtime_controls) != runtime_controls)
+		vmx->nested.force_msr_bitmap_recalc = true;
+
 	if (unlikely(!(hv_clean_fields &
 		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_ENLIGHTENMENTSCONTROL))) {
 		hv_vcpu->nested.pa_page_gpa = evmcs->partition_assist_page;

