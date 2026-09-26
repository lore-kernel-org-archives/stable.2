Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43F367F3A
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400784; cv=none; b=Jkag7jEBfbcX1O0krmT1GUpHZcdbOc1uTbFfttHjL7L/rxfzRE/QVY9ZGudgJ6SfK6oBWwGhXGUGWEEOPvp/IMrSr6Fpsf0M5+EaNVvQ6V/wNsZcuXFD4N1zTnsbXUTWSwHVAf0s6kRTx9ZouxQIR1FUpRZO9qK7Ur+P4W3pd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400784; c=relaxed/simple;
	bh=GN8GZruQXYRaF7EO63+YgQk2i0jrLoiCCKQQn3gDa9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REE4g12B7ALDE4YNPURd09zztjTAlurvdOmMYzhl+5SPa+YsSn+KMatX7ZyrdpHpXLiwzZM6Imb4ZR1+5pAAX1LN+Q8JRgUONH6aT9o8EXceuxe+MmnyvJI2VXlAxIc1e1x4HzHJlu7M7iagomBb8XUgaEyFmBCBLzu21J86Y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lvvap1c2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lvvap1c2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+M2+L1H5egwQQlZ0xHrmsDhZ8xEZMT62MEpuXSNGixQ=;
	b=Lvvap1c2wSL6R+aTalxeR7ftDN2dlCHfVeKi51lh7TX/2ID9fOa734cKlQEzjmde6M6Ir/
	S0f9qeCOsbRY8dGc0peCG6zPG8Pv8YA95SAs+0/vLLD9bsT0HQZ3uYTtI4ezNM42I0mA81
	ySX/9zml8+ruDvr5L6bZTnuoh8ivNAE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-43i1mL1sM4qBU_AMwsrp5w-1; Sat,
 26 Sep 2026 01:32:58 -0400
X-MC-Unique: 43i1mL1sM4qBU_AMwsrp5w-1
X-Mimecast-MFC-AGG-ID: 43i1mL1sM4qBU_AMwsrp5w_1790400776
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9400A1800871;
	Sat, 26 Sep 2026 05:32:56 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A11F1956086;
	Sat, 26 Sep 2026 05:32:55 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/11] KVM: SVM: Update control fields on #VMEXIT if and only if VMRUN succeeded
Date: Sat, 26 Sep 2026 01:32:44 -0400
Message-ID: <20260926053253.195597-3-pbonzini@redhat.com>
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

Leave control.erap_ctl and control.clean as-is in the VMCS if VMRUN fails,
because as per AMD:

  there's no explicit architectural guarantee about the behavior in the
  presence of VMRUN failures. So the best thing to do would be to assume
  that if VMRUN fails, the actions requested in the control fields may not
  have been performed.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260904170642.3291466-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index afbaaaab84ed..b63e7c69aa1c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4625,17 +4625,17 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (!svm_is_vmrun_failure(svm->vmcb->control.exit_code)) {
 		this_cpu_ptr(&svm_data)->flush_all_asids = false;
 		svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+
+		/*
+		 * Unconditionally mask off the CLEAR_RAP bit, the AND is just
+		 * as cheap as the TEST+Jcc to avoid it.
+		 */
+		if (cpu_feature_enabled(X86_FEATURE_ERAPS))
+			svm->vmcb->control.erap_ctl &= ~ERAP_CONTROL_CLEAR_RAP;
+
+		vmcb_mark_all_clean(svm->vmcb);
 	}
 
-	/*
-	 * Unconditionally mask off the CLEAR_RAP bit, the AND is just as cheap
-	 * as the TEST+Jcc to avoid it.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_ERAPS))
-		svm->vmcb->control.erap_ctl &= ~ERAP_CONTROL_CLEAR_RAP;
-
-	vmcb_mark_all_clean(svm->vmcb);
-
 	/* if exit due to PF check for async PF */
 	if (svm->vmcb->control.exit_code == SVM_EXIT_EXCP_BASE + PF_VECTOR)
 		vcpu->arch.apf.host_apf_flags =
-- 
2.52.0


