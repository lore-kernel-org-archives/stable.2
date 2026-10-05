Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920EC495AEE
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210928; cv=none; b=DQTA0gX0C2alHaimGu/Aeapzjv9i3gRk1Ar4yiPu5sMup3YchFWxIQA0/R/SJsEPn803MrVl9htjtfs7nSoSp3Th3SX0MQvzwJi6XU3JsZh9+qUxmee1qGofl5vq08gZ8IpnXSLW+tMWalhv/9j5PVDGpOp5CHLctFTEs9ZjpvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210928; c=relaxed/simple;
	bh=6U3ou4jKSWlJYOIuE0dJ9s0Zb6y/yh1UHIsazkF0u58=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jss+SC7IpI4LtfDNU/js8L9WWgsbZTUz0jAo8teiwrSTDDltlnL+ziAdn9Uc6PgaLvK/o8c+xUL6EOrFhVaEhINKPBJFbk3a0QsEffjjU5jnPA7tWY54FQ2hb7LrAnwoB2VdJrSQuir6M0E+xlzxEwM3wDajooppXWiBAg3l3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZZK2sDtv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZZK2sDtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05BB1F00893;
	Mon,  5 Oct 2026 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210920;
	bh=qXyw9XjJvubuY7aY5DQTamijPynVN7mgmLkINCJZaWc=;
	h=Subject:To:Cc:From:Date;
	b=ZZK2sDtvaFSGN7Bznx7dTHPVHj7iJn3A2+ybUnoKaDJiv2MRqxg8DPK4apzcZQH9+
	 LczzEDwZHZxgB+MLoMR+1OgWhhAay42qM7A8ukmrlW7WmBtFa40AFeCgqAKr4PyWml
	 dBfu8o7561p/how7LIaX5ajTA027Lf+i2FDZJtZw=
Subject: FAILED: patch "[PATCH] KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on" failed to apply to 6.12-stable tree
To: seanjc@google.com,fane@google.com,jmattson@google.com,pbonzini@redhat.com,thomas.lendacky@amd.com,yosry@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:35:09 +0200
Message-ID: <2026100509-applicant-justify-0464@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 60d93c27859fb3ec5b5a689e24de303f166477d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100509-applicant-justify-0464@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60d93c27859fb3ec5b5a689e24de303f166477d0 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Fri, 4 Sep 2026 10:06:39 -0700
Subject: [PATCH] KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on
 failed VMRUN

Don't reset the VMCB's TLB control back to "do nothing" on a failed VMRUN,
as empirical testing shows that the CPU performs the requested TLB flush if
and only if VMRUN is successful, i.e. clearing TLB control on a failed
VMRUN effectively drops a TLB flush.

Explicitly track the need to flush all ASIDs on a per-CPU basis, as the
ASID reuse condition is tied to the pCPU, not to the vCPU.  As a bonus,
this also obviates the need to avoid clobbering FLUSH_ALL_ASID with
TLB_CONTROL_FLUSH_ASID, e.g. in svm_flush_tlb_asid().

Deliberately don't bother saving/restoring the "old" tlb_ctl on failure,
in quotes because it's not exactly the old tlb_ctl, it's the tlb_ctl from
after pre_svm_run(), but before updating tlb_ctl for flush_all_asids.  If
VMRUN fails and TLB_CONTROL_FLUSH_ALL_ASID is forced, then the next
successful run of the VMCB *may* unnecessarily flush all ASIDs, which
strictly speaking could result in noisy neighbor issues.  However, the
fact that new_asid() is already guest-triggerable, because of KVM's flawed
behavior of clearing the ASID on emulated INIT, means that a guest can
already trigger a flush of all ASIDs at roughly the same rate.  And once
KVM stops clobbering the ASID on emulated INIT, *or* assigns a static ASID
to each vCPU, this flaw goes away.

Fixes: 38e5e92fe8c0 ("KVM: SVM: Implement Flush-By-Asid feature")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Suggested-by: Yosry Ahmed <yosry@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260904170642.3291466-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..afbaaaab84ed 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1902,8 +1902,7 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 	if (sd->next_asid > sd->max_asid) {
 		++sd->asid_generation;
 		sd->next_asid = sd->min_asid;
-		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+		sd->flush_all_asids = true;
 	}
 
 	svm->current_vmcb->asid_generation = sd->asid_generation;
@@ -4528,6 +4527,11 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		svm->vmcb->control.asid = svm->asid;
 		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	}
+	if (this_cpu_ptr(&svm_data)->flush_all_asids) {
+		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	}
+
 	svm->vmcb->save.cr2 = vcpu->arch.cr2;
 
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS) &&
@@ -4618,7 +4622,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vcpu->arch.nested_run_pending = 0;
 	}
 
-	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	if (!svm_is_vmrun_failure(svm->vmcb->control.exit_code)) {
+		this_cpu_ptr(&svm_data)->flush_all_asids = false;
+		svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+	}
 
 	/*
 	 * Unconditionally mask off the CLEAR_RAP bit, the AND is just as cheap
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e958943b8162..84f19026d3e8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -376,6 +376,7 @@ struct svm_cpu_data {
 	u32 next_asid;
 	u32 min_asid;
 
+	bool flush_all_asids;
 	bool bp_spec_reduce_set;
 
 	struct vmcb *save_area;

