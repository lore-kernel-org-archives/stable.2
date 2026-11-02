Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661279;
	b=gSHPFknUzerHaBE6RahVf53vyf6s4TzErsOsUzfaJQFbmRSETAkC52MsVFr7Dwe6sl2L
	 96hUiXXWSYFayNTh4Nc+5Gp0bM9b+AYNwofPulvhRvZKlKe8qB1DnOla8U3NF+ZFFEze3
	 xbj7CsU7MxcYuDWoFMUKYeYXAC3DuFCxMgdQbE8tV6uOce0mLtHpB9N96aLe4djiu0gXt
	 P7e1d43I4mmXCzJriCLf9I9XNoZ7dr+3NpZq1icCI6jWTHnLDj8CbTpsk7aGZxIAbIkRT
	 7mEyvNJhgvHE8k4Izrubv0UJhuMTxyiXFrhnJoeLuK/TP6yq9YKeRF+cF4RFC7/8bTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661279;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=3+6FRavmCgIlofFAI66EfQeYrz6NFFwg0C655ZeGgZg=;
	b=iHPKPauTT98EeCYwnwCz0Of/rsRB6pMNLsiHv4vHFHx7h/WSubz7/cCUopVHXdvUMMtr
	 jMZIV+5m54C0bWRAhEZ9SIqcHRaZTZxdVJpgaLWg76qWoA9gPbZtXbROHLbYxMbrbLTEz
	 hMIE7OFcveZXKOHpCmu/VmAtR3XOg2ZOR06ydUJkIKj91zz7q4KJUn+LBaAQckbzhi1s2
	 fpAwoWfbl9ZePmicbN4ayc6ooqMTbJi6jzG1OONOD3VMeJZ6xisF9r7+3c7SDomFrJPmy
	 OLrFl46lDJC+Rboez28PyuCmVFindCRxQNS/Y53USalqSae8GyrKYWGfE0Qxl+8hjag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b6s5jCqM;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8B4606D82A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC8B4606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b6s5jCqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793661278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+6FRavmCgIlofFAI66EfQeYrz6NFFwg0C655ZeGgZg=;
	b=b6s5jCqMVoub4g6f9x/S5/LrIp1zNWQyYQJhOfxmrTKJasEZ4kiCSwB17Uuu/uhUJHbMyf
	x0za/Vxf40qJ+dE8JIiZM81X2crODtCdUBVr9eSfSdDBgH2bdmQAZgbOaMBq3ox+3ol+3R
	wmyOzi5xn3sU0qRiDt6NtWPx9pFYUfw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480--GH3GszYOnG-6CATvZjN3Q-1; Mon,
 02 Nov 2026 18:14:32 -0500
X-MC-Unique: -GH3GszYOnG-6CATvZjN3Q-1
X-Mimecast-MFC-AGG-ID: -GH3GszYOnG-6CATvZjN3Q_1793661271
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80165180065E;
	Mon,  2 Nov 2026 23:14:31 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE6AF26C;
	Mon,  2 Nov 2026 23:14:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH 2/7] KVM: x86/mmu: Conditionally resched when retrying gPTE walk on A/D update failure
Date: Mon,  2 Nov 2026 18:14:23 -0500
Message-ID: <20261102231428.13523-3-pbonzini@redhat.com>
In-Reply-To: <20261102231428.13523-1-pbonzini@redhat.com>
References: <20261102231428.13523-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Sean Christopherson <seanjc@google.com>

Conditionally reschedule when retrying a guest PTE walk because the CMPXCHG
to update A/D bits failed, e.g. because a different task/vCPU modified the
relevant gPTEs.  On kernels without involuntary preemption of some kind, a
misbehaving guest can "capture" a pCPU effectively indefinitely and trigger
soft lockups by continuously modifying its gPTEs such that the result of
the walk is remains valid.

Fixes: b3e4e63fd9ee ("KVM: MMU: Use cmpxchg for pte updates on walk_addr()")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20261022015903.282261-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c..18f7eb633127 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -340,6 +340,13 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	gpa_t real_gpa;
 	gfn_t gfn;
 
+	/*
+	 * KVM might sleep/resched when retrying the walk if the updating A/D
+	 * fails because the gPTE changed between reading the gPTE and trying
+	 * the CMPXHG to set A/D bits.
+	 */
+	might_sleep();
+
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
 	walker->level = w->cpu_role.base.level;
@@ -482,8 +489,10 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 							addr, write_fault);
 		if (unlikely(ret < 0))
 			goto error;
-		else if (ret)
+		else if (ret) {
+			cond_resched();
 			goto retry_walk;
+		}
 	}
 
 	return 1;
-- 
2.52.0


