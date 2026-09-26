Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D13749EE
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400785; cv=none; b=gEeWe7kHGHikLTj9uCbSeRw1ulklE6Yel5Z4yc5jkzB66HqxDkcfOL5IvkXQ1thQH/Czb5zh+9bcOcQVTplA8hIUTbXEVXhaCudqtCKLdZZShgoQl0LThNfLl9QIlaVLVXox1ZXUbml9WKj73aENAjqAmHA54Av9g+whnkYB8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400785; c=relaxed/simple;
	bh=UHidOX1h5rkNPOmxeoBXFalSIwJq30tlVvb26oTn4PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZS2bJd5ouLNlffcpi3t6PNs7nAbwt/0skK+s4OhBkCwPIMBpaWbqHqKlIXygT+GHfAKUrxRR17B/d1udVqV2LbvKS6NK2ZxwNH4QvJ1+GIJmUxFUVvvzsagZIxQmzZlgPJ1Lpm1vZmrjFinKaFR94jdocTPnOwm4YYtWy4IeHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/fxIunT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/fxIunT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mydJGLik20szAmekuOZywCxXeIbJ+ZXqC7OHbSNFa7I=;
	b=Q/fxIunT++BcK4QYxFNOqs9k1ki4YJHyejAaASlp62h/NCogrs/Q3wSMphwSP1yoOawFpk
	hzTm8a0y+EriGKN/VENWD+Hg1gOHvUMUo+R9w6Do5EunURVgfo3labWgy7zwIgw1RqMnPA
	a0RBck+hVGHfTrphEuabek7lkHVjxpE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-BFpWQpdsNFCdA-Fw2BE4fw-1; Sat,
 26 Sep 2026 01:32:57 -0400
X-MC-Unique: BFpWQpdsNFCdA-Fw2BE4fw-1
X-Mimecast-MFC-AGG-ID: BFpWQpdsNFCdA-Fw2BE4fw_1790400776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D71FD1954B24;
	Sat, 26 Sep 2026 05:32:55 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D332D1956086;
	Sat, 26 Sep 2026 05:32:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Jim Mattson <jmattson@google.com>
Subject: [PATCH 01/11] KVM: SVM: Preserve TLB control (i.e. pending TLB flush) on failed VMRUN
Date: Sat, 26 Sep 2026 01:32:43 -0400
Message-ID: <20260926053253.195597-2-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

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
---
 arch/x86/kvm/svm/svm.c | 13 ++++++++++---
 arch/x86/kvm/svm/svm.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

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
-- 
2.52.0


