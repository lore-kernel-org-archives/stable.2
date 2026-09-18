Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0363FC5BE
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724611; cv=none; b=cEBCCqixi473HIOS6j3cP5s6NOMHTu+jN+RTkFBrE3u27MS4n4CkxaWx7FWw5Ab1YKg2lgSJowBoSyfk+qMx8FoB/wDU4j7wrKCg9xNKsdmqvtqZsiqBwXOg0+H5EIjB6em35FpapgOczhbXdvnEs27+DNrrTPfU8FeFG19ViWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724611; c=relaxed/simple;
	bh=YM9BQf4ErIDgU19uy/gKY9+H0f4P0KhPIGXQbbqdQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lTtONi/HUtql4gOhm/K42RtelE3ugJJORg7yIgCdefAjOJ5rA3LJ2ROfK9rJQJcIGVG8iRSgbaPFd9hk6wqUofYu5blXl6EdcI33/exhz/zYRBO+tI5S+hcM5nY1CiW3gRSetintZLSYe18u/WW9H5G8KY+/IZBbR1fNt2crrqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUQCtrZp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUQCtrZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789724607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z5TU7PallJ1RPWaWYTk7XS3Dm59h/qbbVQnv6/Nzc4s=;
	b=eUQCtrZpZzc2eKIHFURzJ6RoJPUl3SU7i9qV+nmMCJyBNNT7bZ+ldAkEaoBTGpLAmj1Kaq
	UTTOEHaHBR+q8udYDSiNIESBhth5t2u/HjKki1g8dQso0RpPK5w6rDV2vs1FNSQ1ZyCbSR
	ZBrj2ZAolFHGFF9UEYlj38bpp/dQWkk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-suHYJGCEP8CooeBbAmwyXw-1; Fri,
 18 Sep 2026 05:43:24 -0400
X-MC-Unique: suHYJGCEP8CooeBbAmwyXw-1
X-Mimecast-MFC-AGG-ID: suHYJGCEP8CooeBbAmwyXw_1789724603
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EE541956042;
	Fri, 18 Sep 2026 09:43:23 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7A7A1800370;
	Fri, 18 Sep 2026 09:43:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] KVM: x86/hyperv: do not overwrite hc->ingpa for slow SIGNAL_EVENT hypercall
Date: Fri, 18 Sep 2026 05:43:22 -0400
Message-ID: <20260918094322.152817-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When a guest makes a slow HVCALL_SIGNAL_EVENT hypercall with a connection ID
that is valid in userspace but not registered in the kernel conn_to_evt,
kvm_hvcall_signal_event() reads the connection ID and overwrites hc->ingpa.
However, hc->param still signals that the hypercall was a slow one, and
userspace will then treat the connection ID as an address.

Cc: stable@vger.kernel.org
Fixes: bd38b32053eb ("KVM: hyper-v: Collect hypercall params into struct")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        originally reported by sashiko at
        https://lore.kernel.org/kvm/20260918083322.C87F11F000FF@smtp.kernel.org/,
        but the issue is preexisting and unrelated to the patch that was being
        reviewed.

 arch/x86/kvm/hyperv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9f5adcd26cba..e3a8e8236230 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2501,6 +2501,7 @@ static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
 {
 	struct kvm_hv *hv = to_kvm_hv(vcpu->kvm);
 	struct eventfd_ctx *eventfd;
+	u64 conn_id;
 	int ret;
 
 	ret = kvm_hv_hypercall_check_params(vcpu, hc);
@@ -2511,14 +2512,16 @@ static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
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
@@ -2526,15 +2529,15 @@ static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *h
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

