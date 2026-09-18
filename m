Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048A4FD263
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739440; cv=none; b=dIJzkXFqrv7xAqVNBFodc3NK2/vIEE/wBQ3uHBwTrko+aYzr4yp+LnUqPfPo7c8KtQ+gsHfTnfhx/SF9KFjC8px3vKbD8fuABTgAz03H8teqFe/DCVDq7QmeNGmdEFdIvPmXY6IKuU3spD2fQw05HLb8VVB8OKhgFUirpxjuAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739440; c=relaxed/simple;
	bh=6ylVGzoVg5WyGnxqAmFcToYzZVklKcib90G+PvfoyT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAKn9iHdls7GL3wFMapQ1QTSLgzkiwktxo1ad7PFDf9IvN7T/VtwNwxR7D8d82FHPHYJ4ys0Now5HGCPjeRSju9WQaZkO5urRS1QZT56Mxbv9fvebdFvWUwG6h3DY1UqNfPP6IP3lli/iprUPfzyhZC4K26uRPOyNGGZ+78DSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd4fAaKE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd4fAaKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPIhTn4sDBuz0G96LEXoKpjhT6oJylIi4yaM6st+xoA=;
	b=Cd4fAaKE1mDoEzNeanSbzTioEBnuR1r2NOBLedZ19djyEhg8+nRASWRN1kdifY1WRslDCo
	c20m35sgoN7DF32gUx3L6JoUQJLq/xKfy+xDniSzWdjDYsyUE2X1AprfV2dHcEQg4KNPJz
	bo90NaTb3ADBAoZKe4Hd5MTXPdpBzZo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-iQVw_cmHPXu5g8v5gitnTA-1; Fri,
 18 Sep 2026 09:50:34 -0400
X-MC-Unique: iQVw_cmHPXu5g8v5gitnTA-1
X-Mimecast-MFC-AGG-ID: iQVw_cmHPXu5g8v5gitnTA_1789739433
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08F7D1828B4A;
	Fri, 18 Sep 2026 13:50:33 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45BAF1956042;
	Fri, 18 Sep 2026 13:50:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com,
	stable@vger.kernel.org
Subject: [PATCH 01/31] KVM: x86/hyperv: do not overwrite hc->ingpa for slow SIGNAL_EVENT hypercall
Date: Fri, 18 Sep 2026 09:50:00 -0400
Message-ID: <20260918135030.171564-2-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When a guest makes a slow HVCALL_SIGNAL_EVENT hypercall with a connection ID
that is valid in userspace but not registered in the kernel conn_to_evt,
kvm_hvcall_signal_event() reads the connection ID and overwrites hc->ingpa.
However, hc->param still signals that the hypercall was a slow one, and
userspace will then treat the connection ID as an address.

Cc: stable@vger.kernel.org
Fixes: bd38b32053eb ("KVM: hyper-v: Collect hypercall params into struct")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/hyperv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 604651cb2739..d2921d443fde 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2436,19 +2436,22 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
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
@@ -2456,15 +2459,15 @@ static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
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


