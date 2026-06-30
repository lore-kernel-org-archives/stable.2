Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34C3DE421
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840131; cv=none; b=Gj7fMZ7y4iwQgnQPZNAacIgy1AzwsVeE5Ah5KLMET3kFNh8zNe6TWk9H5xnvqwqH8vd1noYIknlJzXroDatcq6lDQNKHRwCKljpXtHWtWMv89U4mNabb+0ErhGkiF5cFzBqETLkalYSZZjp9E9ySTZNk1V8DA3q1kGfYZMYMk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840131; c=relaxed/simple;
	bh=GJiY0G+v1cHtWDhoF6H7oSsoQa/Y8R9a0sPu01Qf5Rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mcZLcX4tL52lt7ATzR8tHxDUc2dvJPY519UEcZ2U8Qltzm4lniziHahB5Lpob4VcScP6DQygse7X+HdeslqVcV8exL/gALA4SgU/OqC+J9TwxRvWHpIQEX4JqHg0F/r4pipkTdVWQCfoRmJT4ljzokAdhbxpj2C9HvvAjw4xopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eil2Qigu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eil2Qigu"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c894391f000so5903109a12.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782840129; x=1783444929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=plT5/1MQYoLBw0hf7vwLUa68BnMiEY/lHOfm/Z/BEKM=;
        b=eil2Qigu+nVxG+043Br3hYg3wzon+eM9FJBcif8V9IdXTLj/uIi/pwo11d9eM5HvtZ
         IMHCq//NjdrNphsq31lX31Zyf/KIRUjrFowQtO4mPlQc4SdYMKMd+jxANcgcnl/23kTu
         u8q3qm1wd4256aIobOp9rEiQhwAFqjMK/b8jNDI6PIw7j4aPI3DwpPs8VCEvp8WwHbR4
         ha3U2T33ehIqppTdNvWMa17/zXkrus5xjnrokuTOjl8r0lY1foUTOlfrA83vtmR+TNo9
         sMWd5aROQwm0N6rpLdSUxd+cBhF0NyDLgsY0fqBBfxK/dVQ5r2uyeCkuFJacJs5lcfR5
         9Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840129; x=1783444929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plT5/1MQYoLBw0hf7vwLUa68BnMiEY/lHOfm/Z/BEKM=;
        b=O5QrRq4dxlq9TTjtOlTcZHr3ELzEbA9Cg5piZRkNNtQIBzn2xFhcCVFlDB3HD++Iip
         niHPUAVI5/R4GPXXx3oBA4PF0S0V/1eJnelXgUvjuKxGkpe51CzuPlMnhm3PEYWQoL27
         4E0UWTj5pBxiUbj6UgqiiSfMfFtPj+t9ka61IPv7RMaMJsMVHJHK1xjaFMn0k/LehEfB
         MpanV8PP/9wXEOLH1+Pdy/NUXWrA66DeLu6ED8e43Z19HqJlYR4w/G7U7Qx0vmtTv/zD
         4G95fz/tqo6b9qewsShWajBvOrDVU5yRar6/1cHL8jcTwCs/prxH7SSqIWAJigXRCI22
         kueA==
X-Gm-Message-State: AOJu0YwnYpi28dYtKfXe/fFGJhCoSST2BxfjysBFBselzRtEp+i1h78K
	VSOFjYxXm06h5b/1Um5iG8SzaVtDsS8kyWNrWGfsOv4gV6Q5QXLUcFLgIhGobeFT67HHlG14JWY
	D6+H/qTfw4TAlFbydZJnVUUIrk2WJuaCxzNd1zMKGhfP9gu4eCWTVDOEfQ77z9TBkucGxfXwlXN
	sB3rRDsdr0wNMTYAH2Tzxg3J7rXkDW8nLDiOgE
X-Received: from pfoo8.prod.google.com ([2002:a05:6a00:1a08:b0:845:c4b8:9730])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea8:b0:847:7f38:27c2
 with SMTP id d2e1a72fcca58-8479f293658mr3669670b3a.50.1782840128582; Tue, 30
 Jun 2026 10:22:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 10:22:03 -0700
In-Reply-To: <20260630172204.279784-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630172204.279784-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630172204.279784-2-seanjc@google.com>
Subject: [PATCH 6.12.y 1/2] KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 08385c5e1814edee829ffe475d559ed730354335 ]

Relocate sev_free_vcpu() down in sev.c so that it's definition comes after
sev_es_unmap_ghcb().  This will allow sharing unmap functionality between
the two functions without needing a forward declaration (or weird placement
of the common code).

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-16-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-16-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: Preserve use of sev_es_guest() as is_sev_es_guest() doesn't exist
       in 6.12, resolve superficial conflict due to pre_sev_run()
       prototype mismatch.]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 115c59c86f44..0f79e052ac42 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3168,37 +3168,6 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	wbinvd_on_all_cpus();
 }
 
-void sev_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm;
-
-	if (!sev_es_guest(vcpu->kvm))
-		return;
-
-	svm = to_svm(vcpu);
-
-	/*
-	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
-	 * a guest-owned page. Transition the page to hypervisor state before
-	 * releasing it back to the system.
-	 */
-	if (sev_snp_guest(vcpu->kvm)) {
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
-
-		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
-			goto skip_vmsa_free;
-	}
-
-	if (vcpu->arch.guest_state_protected)
-		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
-
-	__free_page(virt_to_page(svm->sev_es.vmsa));
-
-skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
-}
-
 static void dump_ghcb(struct vcpu_svm *svm)
 {
 	struct ghcb *ghcb = svm->sev_es.ghcb;
@@ -3475,6 +3444,37 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
+void sev_free_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm;
+
+	if (!sev_es_guest(vcpu->kvm))
+		return;
+
+	svm = to_svm(vcpu);
+
+	/*
+	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
+	 * a guest-owned page. Transition the page to hypervisor state before
+	 * releasing it back to the system.
+	 */
+	if (sev_snp_guest(vcpu->kvm)) {
+		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
+
+		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
+			goto skip_vmsa_free;
+	}
+
+	if (vcpu->arch.guest_state_protected)
+		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
+
+	__free_page(virt_to_page(svm->sev_es.vmsa));
+
+skip_vmsa_free:
+	if (svm->sev_es.ghcb_sa_free)
+		kvfree(svm->sev_es.ghcb_sa);
+}
+
 void pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

