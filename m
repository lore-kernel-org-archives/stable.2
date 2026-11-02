Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641299;
	b=xEHV0cPVRH8N8V/U2lK35M5ejO6mb0XpeIGlkkzb5M88MBsFdllBtRCQ3e3v5zzK2M96
	 M/40SUMhE3wJ92+NplEWltMf51vBKx/iE/X9QZoUk4H6gaROjYq44LPCzMDnrtX07COqo
	 G7LxCCG48kOLSLhwXFCL2zBpPXx1i1pAmw3ugab8KVaU9OM9bCjEcMSGH+IbHqknA3GVC
	 FtzhQ7PWI6S77rBmfbMl4+2KC6C7QHAphfo/ArUSUppuY5HEWJVwkBU8DSc1BGgfLHjID
	 z95VXoNMQJgh9oF2LofDg9058k8WW4nQPZ1dRBM+S80ndD0k7iPFqI8Ey9HJ0+u17mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641299;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=8QRJSjFRhFjsEIrLMUF/Qbq9FSRASB71Ae5rA38ygI4=;
	b=xCnq+3lEsYAsilPPGgaX/0J2HxYZS939G2+1mQ+u8dyaMe4rc2ksMvy8LTxtIsEC0xps
	 h51Sn0Xc5XWXk27jm+SyMurQJ1i4neAT3RWHAi8skeG/2fCzvu5pNZKff3prqr4LX2NCu
	 vbR+Z6p4pUbWYbphNoeg/Q9r7LConPUcy2xc0c03YIk3cxk+4Qn5g1vDNWZdL3SNnT5lp
	 ECyHLm+glhVi1l1mAv1Hu+c6C6oDzp1P377WaHFHOzNCPWJOIWoZaxSYTPIKKGMRi7x4I
	 bUbCYrL13/lTuj4V+gUceeOwKYbN2loPwOVnWUPjKCFcHNZTaAkdZzY6cR8Xibvc7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OkOleMPV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A660716CF
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 17:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 704A660716CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OkOleMPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QRJSjFRhFjsEIrLMUF/Qbq9FSRASB71Ae5rA38ygI4=;
	b=OkOleMPVyjo9h2PYYcKB5TtjFQFWdFkzZ+a6b/WMjTkfDo3EiqXaZQwHVtIUn3ktAvdO78
	u6VYUjQq2E3Uo7PGjHuM7yLdDeAzMZXcWZah9IksiHMFuqzmGtnY1C6Xm60Ee4H9iv3Kls
	nxR5GX5+yUxyVuPPRrwXaQIVY8Fmfl4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-84tavbVfN-2gsjiu0x5Y8w-1; Mon,
 02 Nov 2026 12:41:33 -0500
X-MC-Unique: 84tavbVfN-2gsjiu0x5Y8w-1
X-Mimecast-MFC-AGG-ID: 84tavbVfN-2gsjiu0x5Y8w_1793641292
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 700C219560AB;
	Mon,  2 Nov 2026 17:41:32 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8DF030000E3;
	Mon,  2 Nov 2026 17:41:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/45] KVM: x86/hyperv: do not overwrite hc->ingpa for SIGNAL_EVENT hypercall
Date: Mon,  2 Nov 2026 12:40:46 -0500
Message-ID: <20261102174130.8779-3-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When a guest makes a HVCALL_SIGNAL_EVENT hypercall that is not fast
(i.e. has arguments in memory), kvm_hvcall_signal_event() reads the
connection ID and overwrites hc->ingpa.

If the connection ID that is valid in userspace but not registered in the
kernel conn_to_evt, KVM exits to userspace; however, hc->param still
signals that the hypercall was not fast, and userspace will then treat
the connection ID as an address.

Cc: stable@vger.kernel.org
Fixes: bd38b32053eb ("KVM: hyper-v: Collect hypercall params into struct")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-2-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c952..798baa9eaafb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2437,19 +2437,22 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
 {
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 	struct eventfd_ctx *eventfd;
+	u64 conn_id;
 
 	if (unlikely(!hc->fast)) {
 		int ret;
 		gpa_t gpa = hc->ingpa;
 
-		if ((gpa & (__alignof__(hc->ingpa) - 1)) ||
-		    offset_in_page(gpa) + sizeof(hc->ingpa) > PAGE_SIZE)
+		if ((gpa & (__alignof__(conn_id) - 1)) ||
+		    offset_in_page(gpa) + sizeof(conn_id) > PAGE_SIZE)
 			return HV_STATUS_INVALID_ALIGNMENT;
 
 		ret = kvm_vcpu_read_guest(vcpu, gpa,
-					  &hc->ingpa, sizeof(hc->ingpa));
+					  &conn_id, sizeof(conn_id));
 		if (ret < 0)
 			return HV_STATUS_INVALID_ALIGNMENT;
+	} else {
+		conn_id = hc->ingpa;
 	}
 
 	/*
@@ -2457,15 +2460,15 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
 	 * have no use for it, and in all known usecases it is zero, so just
 	 * report lookup failure if it isn't.
 	 */
-	if (hc->ingpa & 0xffff00000000ULL)
+	if (conn_id & 0xffff00000000ULL)
 		return HV_STATUS_INVALID_PORT_ID;
 	/* remaining bits are reserved-zero */
-	if (hc->ingpa & ~KVM_HYPERV_CONN_ID_MASK)
+	if (conn_id & ~KVM_HYPERV_CONN_ID_MASK)
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
 	/* the eventfd is protected by vcpu->kvm->srcu, but conn_to_evt isn't */
 	rcu_read_lock();
-	eventfd = idr_find(&hv->conn_to_evt, hc->ingpa);
+	eventfd = idr_find(&hv->conn_to_evt, conn_id);
 	rcu_read_unlock();
 	if (!eventfd)
 		return HV_STATUS_INVALID_PORT_ID;
-- 
2.52.0


