Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27565286D5D
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 05:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400785; cv=none; b=avGqIR/krTWwGCBJfdJB7TWduVlLytMqzSo92rIt32VIUCzMrmM+tmk+FHeSzDTTbcBt0ibfd8oOX7+XWzPxSzInyDmrjrgMkAQZK/7gtUP16sMRurZhUZw6UV/0Q2yasqAN9Vi7/zz5qrg0uVcfsmlEyC5zPxkvEIPu9mtW1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400785; c=relaxed/simple;
	bh=qIkQ6MQyGnoAAQ5Sa8eDyvnkbfgQaM0rO33iPuvoy74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLKjxOhQFe0L9f2gTRJD0L9mQ6hS//Yr4EdH2BT4Mga+xvbfCpPCUckFxRxWS4aQAuxZKx+37t2gKCh8y79kwQALn5cUKfGM/+LjE7LcQgAiWraa/0kN+W27RgRaOSbFe8+dSlzCwI/QJwKe5RsXIWMSVGZiB/f+4JjonHmabSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQyPgBuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQyPgBuM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=swg/O/aAJab+PGMsJFcDfjnZcC8fg7p7jjtw5EIsJaU=;
	b=DQyPgBuMu6rttIjMxsW54/At4IGf2bQXAlLcsEg4NGesgOa3T3+Hj/id2qcaHNlToTSk46
	vEf1GeMFLn2jgHv6tPqD6/TW5aZpsOOx2Flig/6Q8rYfJSscutoIuC/90VGzWSppzNvgcs
	pUpnCI6dMm61lEEWmgCNszH1aBKOJZg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-0fEplLNvOj2qDbUE5XKL9Q-1; Sat,
 26 Sep 2026 01:33:00 -0400
X-MC-Unique: 0fEplLNvOj2qDbUE5XKL9Q-1
X-Mimecast-MFC-AGG-ID: 0fEplLNvOj2qDbUE5XKL9Q_1790400779
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A42631800632;
	Sat, 26 Sep 2026 05:32:59 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA09F1956086;
	Sat, 26 Sep 2026 05:32:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 06/11] KVM: nVMX: Force MSR bitmap refresh if runtime eVMCS controls are modified
Date: Sat, 26 Sep 2026 01:32:48 -0400
Message-ID: <20260926053253.195597-7-pbonzini@redhat.com>
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
---
 arch/x86/kvm/vmx/nested.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
-- 
2.52.0


