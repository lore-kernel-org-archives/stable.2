Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F72481A8B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629715; cv=none; b=jFnT8LRdiKVDSwF+FjXACFmWAXdmueXakJiFVl3sNxhrCTCpC93eo+vu25+IpJS3HIPegZKT1c9FlB+9CTrp0ioq1ddDqF3XiFYvDw//CFbCqVVVwjTnUtByXfRyjbXFXTnrygVKw4maT2hTQEEIUqCXrawkdmPlF5Pnxf7si7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629715; c=relaxed/simple;
	bh=rxE672ury9tWTdjh2fA+6R5h3E2l5Y7B22DohOut5Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnigXqk6GTQWEJQJJ2TXkZ/khZhL7UyjxwkuzX+u5CDsazGEDDyyR8PgkSFK4W3p3geBklVEDaV/MDyPixyEuxMu+Y33Cy5OdpTenrzbr1H+bOaoiXOjlPjUrIGH5+vI7l5z4G/0sYto7i+BBiNVbxOxyeTonJ+adWACccyD5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYMXDmAH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SylRphOL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYMXDmAH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SylRphOL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784629712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E1MIb1SYEneoGIcT7yLYFlL1UIRAz+KVXytnxrYIFiM=;
	b=MYMXDmAH+257Grln1H0GrimnrZCzj4PokVlqyvdmaOrj1ykX5/+Ujko0cQLJxdRTU8WOZw
	GQSJ9wb/KmEhEt/1T3xkHOiJd4R6aOnq2P0U7FHcgIhr2e3A9hPzHzXyBa/2KBVxLaQHt5
	WSUG8dY/AH7iaIiI8dBV2e44+RJnavs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-qW6_yS7bMQOtn3Hu0Y74Fg-1; Tue, 21 Jul 2026 06:28:30 -0400
X-MC-Unique: qW6_yS7bMQOtn3Hu0Y74Fg-1
X-Mimecast-MFC-AGG-ID: qW6_yS7bMQOtn3Hu0Y74Fg_1784629710
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47162f83c75so2923834f8f.1
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 03:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784629709; x=1785234509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1MIb1SYEneoGIcT7yLYFlL1UIRAz+KVXytnxrYIFiM=;
        b=SylRphOLjQ5+xSK5K+oYgvB2qRZk5BjGY+fTW3t0gV4DrA4liifFo/68OgPsZJbwgX
         TANllWDn0o4tGor6LuMesJDyPAFsLi85wLYJeC9AlbrBdtcg88rna5i/Ta0h+PLwS2GS
         gtZGJguWi6lh8HXGlJNVQQTwF9ddWvLYgN4nkpy2dhWfKGSS3c5NKpf+2gAKL1UQLd5C
         K5lHRKalrwFTL5R7QxN3CoEIC8H3qYH/O9HloPJfcbZ9rLqhEKBAeC+RrDZsu1e5hBGr
         +lmN1MzdG5cErcspqVkQ6FEBHyogqefp3bHoWEevZ6OL4vpzw3SxWemYpPxDmNC4FVjr
         h/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784629709; x=1785234509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1MIb1SYEneoGIcT7yLYFlL1UIRAz+KVXytnxrYIFiM=;
        b=Fnsa9SkKQClNE1X2XCR1YCqu6huK26hQGv3cdU0q1jhMBJXnCGC25KQvz8hSTNk5T5
         p+DUqWKXWsmIC1oEwtcA23W0NUxJ4tgDyaVloxYdFOxcQMTUhWBD+BEWOiXZSNjzGtkJ
         LF20n7OMs12VBijx0ENaqcdybsJvaHFehOTOaOgVibej6tga63rBcuKCofLZjtiws0W+
         Nyey2b7MKS4tEBcGMOWMKR1ITysfvl4fHF8dp9fXPY2bxq2+uB3eFZhGazu5U61ZmGVE
         FrxdOus44nDxbnSYqLZ0CN95P6WwZaoyLjBOM19d6q9h76WSOhhPXiEVvQxWP49xC70x
         Ew+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoDCDqlinaLuHUDNURHyKv6qQLSRKkJSwIwPxHdLfhobDSovqszH3ZlaMXQvpPbJIpogtxsCgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLw31TakGIuuGMiSa5NGBH/HGu7ObpeaiYxpXu1Lp6X4Cjpf0
	wEFKNcGn4WlvAjJGjVgb+eoZToxPagApM9XxOdjpb9lnXvB2n2An55zIYGfEbLqgdf40AiH46FQ
	3PlT8tmvzWcMlmL179ZpF642ltrg7kAIeiqyShfPdIpEXlEjvSb/8JNcWEg==
X-Gm-Gg: AfdE7cn04+NyeFpYUmA/p0kUcxgLmGGcr06SfLT2rdDl2LS+KCZhOqDuYKq+jDRFpRJ
	OVLskI0otEfoGg60+xFqKsh1E5ianzXnkqd3gS9Ap5q+/n4KwSRbr6aXmVkwv6F2udyEi4T5kvs
	lX+XWzAkv7NVcpndAajtyb7+iAOuFsh4tz9wyw1VSycNy5/USuMU1HvJWH7Mo7t7PLRMSg+GWic
	XY+rBrpDoxokE2BeDfwMw9AweHuBYNkhAaUsyzUEPDF4rM/vr9FntGMEmN5XnqfFiLsAJZavXSh
	A/64EXeCsujPFz8BRBZpTiYcb1s2Zz3D/f2y8NXT9XXX+PxVGqeowZhbvdZmEEbevgUrjJcyeGw
	8a1UL85iZ/Mw6MZhGSJgv4DD3MX1EjhqNa/NxE0FpUImXljv24rrOxc2V9hc79uVx2VUSjPITy+
	z8Ifz1
X-Received: by 2002:a05:600c:4f0e:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-4954f847354mr171614905e9.4.1784629709485;
        Tue, 21 Jul 2026 03:28:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-4954f847354mr171614635e9.4.1784629709119;
        Tue, 21 Jul 2026 03:28:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956537c7desm77013385e9.7.2026.07.21.03.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 03:28:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR
Date: Tue, 21 Jul 2026 12:28:27 +0200
Message-ID: <20260721102827.313208-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunwoo Kim <imv4bel@gmail.com>

free_nested() frees the shadow VMCS while vmcs01 still points to it. But
because it is asynchronous with respect to loaded_vmcs_clear(), the vCPU
might migrate before the pointer is cleared and __loaded_vmcs_clear()
may then execute VMCLEAR.

The VMCS needs to stay attached until its explicit VMCLEAR completes, but
then it can be hidden and the page safely freed.

Fixes: 355f4fb1405e ("kvm: nVMX: VMCLEAR an active shadow VMCS after last use")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 220d42ebc82e..ddf6df7bee93 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -336,6 +336,7 @@ static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
 static void free_nested(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vmcs *shadow_vmcs;
 
 	if (WARN_ON_ONCE(vmx->loaded_vmcs != &vmx->vmcs01))
 		vmx_switch_vmcs(vcpu, &vmx->vmcs01);
@@ -353,9 +354,15 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.current_vmptr = INVALID_GPA;
 	if (enable_shadow_vmcs) {
 		vmx_disable_shadow_vmcs(vmx);
-		vmcs_clear(vmx->vmcs01.shadow_vmcs);
-		free_vmcs(vmx->vmcs01.shadow_vmcs);
+
+		/*
+		 * Keep the pointer visible until after VMCLEAR, so migration
+		 * can clear an active shadow VMCS on the old CPU.
+		 */
+		shadow_vmcs = vmx->vmcs01.shadow_vmcs;
+		vmcs_clear(shadow_vmcs);
 		vmx->vmcs01.shadow_vmcs = NULL;
+		free_vmcs(shadow_vmcs);
 	}
 	kfree(vmx->nested.cached_vmcs12);
 	vmx->nested.cached_vmcs12 = NULL;
-- 
2.55.0

