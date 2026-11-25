Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589811;
	b=UuE39mTfpDJFt6MvNRogFKh1841FNnqdD3rI88dDYavrPUpf+1IH3dlIuTo8LwtAEO2+
	 0G2TYzRUU5l0VwiNwkB26xJtqjh0YkWQxmWbXRej9IcMvcSE9qUptP5zMiGSzQaFNkDF3
	 i7HNNJMrZhMr0f/LgQ05I+5xdmBbukGqlBdERqAhePRuOA7893KL/lir8pN8cxGeVl78b
	 idIIFCnelgq+P4GxbZTDcVZytL7HpKxKj8elZj5cn+d1NkoM1QQicDLCO8tCJsAC4ZRCx
	 qPIeVN932er/dPIoN+5N44lsLq14h+ArGtPg8wWB0CmAYMCBHqm92OcWtDmiJXUrbjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RGa577wX/xgJLkYslmrPB3AiasjRjUBJpObETRH3ZKA=;
	b=xvXk1tkaF/gH/ZzJG65Bj4SI7faQAe3OQRUvhLEpl357/QTirShIYfVw2l/XVJMsprLs
	 oKal1/t0gsYW/sOYQ9vSAJJCkrFnxDYHG/EfKubU5xWAbqMb++ETd+TPcjOkQfaXVpILd
	 VNRZ7XHzsGgPS2VLlct3fgoCs+pfY2LCSrMy/yUEMjoTrqA8z9fG212PVlhBDNSwO+bJH
	 Fptvwqn/1blvPgHg26g+8F7uYCAUqZcUe+ehyFYgoujRoEsNv/PyRbCPon6XVn4R/9YAz
	 XeOdiZuR3UIoD2pkf5F8H4FAny9VeMJx/nqMmv+SboLjaCCshWTqEJ34OSdYnXeNG+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=hKxqrr3g;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56BA606A6B2
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56BA606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=hKxqrr3g
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so25014175e9.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589809; x=1796194609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGa577wX/xgJLkYslmrPB3AiasjRjUBJpObETRH3ZKA=;
        b=hKxqrr3gaqvIXon62dT+8//wIIjdDSIWRBzPd8QV1IYK3M82N3s8pT7KviOlpbceqB
         POL3tFPjnmgCXRvXs3bG0ihWnNUvLHBMDRWNVHVqTa9drm/i04+WX0EQ1JcraNK1UO2D
         rGTIdvjMeawaDNP+KUP6Wbru6HqOcnsPWNvQE3Ez2fsMxktWXBxkVX+oh987pvDJ/j3S
         qcccSF5b3xeERxNLxxFyr0QA0EYp1sBTBh1+GVlAtpj2u+tCsNbl0bOJC03qVUYLvdM0
         aZG+ezaxM97dC6sWPnDmWRletcm4pAZmkSg8dK2uH50d5PedPpEzp7HoGXwBaO/5Zeoe
         13xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589809; x=1796194609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGa577wX/xgJLkYslmrPB3AiasjRjUBJpObETRH3ZKA=;
        b=q3QVIN6BvASMUHUi7DjBNeGuwf/LxnJvAtBvGcGIHo4TviOSmW7t6G8CZ5apjxzzSJ
         uh/A0ESJWtPEpZXdu4tOM9kX39eOS8o7PGkznDtw9UcnWuPY92aSK25SEia9bpuUAtJ8
         L6cExURopcp+gXUmSbGBRbG0IBbE0il6kD4Ir8HDrpy3qv/ccgqspeUfeD0ht5TNr9JQ
         Z+UDgRvpfe30/9nCbTZSO97QGwcKTuF//ZGOP7bV5J3NJDdJbubrgyVlA2qiUBMGFLiT
         fGzTkj23/g+4wfBZgyBY0kp99kaoiNwJJgD6KVl3G8TrgS3LmPbxSadzejK/NzQwCMAB
         sXpg==
X-Forwarded-Encrypted: i=1; AL+hErFpQoqlEe/06Y7JOV5cmHFYQVEPddde/t+bzU6bHaVgDQIEkZzsnk1uCW7EcEmQ14dcYwlSe3U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pdobMMAkf0SRQ2CA0HdpIHNcYn1sHVfw4IXHI26ZoMdSjJngX
	KAXnsooBwHrYdAeNlqo8tgZVQyJ8Wkf6BiTHe34PPS3RS4CklEYBneSdBldDnD+qGBY=
X-Gm-Gg: AZFdTZdJNae/xsg3u/TslNM1ejHSQXqMsCwKmOox53gGxnQarfD2s+UdK8MQUzmmMmt
	SH6RaKYR5qX8mUtZTdKEnga/Px0DeMACxmSLmgI9Zz2qS+BpNEwwI+TocHoPb/Ihh6ZGDJx/mAi
	MKSzQKyDPl3518LoWIhN1J1Q/2VRyYf9Ma48hQwIU1+32PXKZ2Tu1a/8SwhN4RP/ZRuUtvwHnA5
	FdyWQ7tE69r5sov6QvoJoeB6E8NorAforcoQTKTaTqdX3u9q9GdxmTdGJXy+72wARRqzk8pvQV6
	alnM9OGkZVoTba7o+gwsvErcx6bPI8z15gBUyg5E5JFwtSxHik90DZ1r+4N1SzPlP4xnUgfWcyA
	q3xryxevoIBMSh94FtWNsfw7AGWTkNyHiBPU4WJCuCYOlYUZzMZoRGP/IJiRy5Fc8c5musK4ulD
	F/SE0eeGg36bOKo6OKFvwcLcmAEThlazqhRbXbY7TCfRnjeZk57abI9GsGZLbale4YL2hfve/V8
	pWRMTkGwuhe/4jK0d3472SU+JIGcoBFQPAhvUR/ssr5PgVWQ/cgPK9zLubJBEZEopx7JFb9n/AJ
	zhkl+wuxGfL1MxDfd/w=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb8881c630mr352660555e9.27.1795589809163;
        Tue, 24 Nov 2026 22:56:49 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm414574595e9.9.2026.11.24.22.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:48 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:20 +0300
Subject: [PATCH v2 5/8] KVM: arm64: nv: Replace a pending SError when
 injecting a new one
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-double_exception-v2-5-224689d8a764@pereq.eu>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
In-Reply-To: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <c.dall@virtualopensystems.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0

The kvm_inject_serror_esr() function injects SErrors as the name
implies.  The bug is that it doesn't handle already pending errors
correctly in nested virtualization.

In vanilla KVM the kvm_inject_serror_esr() function always sets
the SError to pending.  However with nested KVM, it might set it
to pending or it might deliver the SError directly.  We can only
have one pending error at a time.  Imagine we enter the function
with an SError pending already.  In the current code if we decide
to pend the new error that's fine, everything works.  However if
we decide to deliver it directly then the pend flags should be
cleared but they are not.  So we deliver the SError directly and
then the SError that was pending on the next exit or entry.

Clear the pend flags unconditionally at the start of the function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-229065@kernel.org/
Fixes: ce66109cec86 ("KVM: arm64: nv: Take "masked" aborts to EL2 when HCRX_EL2.TMEA is set")
Fixes: 77ee70a07357 ("KVM: arm64: nv: Honor SError exception routing / masking")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: New patch
---
 arch/arm64/kvm/inject_fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index aa2011cc0d5a..0f6a89b65074 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -361,6 +361,10 @@ int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr)
 {
 	lockdep_assert_held(&vcpu->mutex);
 
+	/* A new SError replaces any that is already pending. */
+	vcpu_clear_flag(vcpu, NESTED_SERROR_PENDING);
+	*vcpu_hcr(vcpu) &= ~HCR_EL2_VSE;
+
 	if (is_nested_ctxt(vcpu) && kvm_serror_target_is_el2(vcpu))
 		return kvm_inject_nested_serror(vcpu, esr);
 

-- 
2.53.0

