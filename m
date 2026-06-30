Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7363DE430
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840132; cv=none; b=kdMA4wjQhz5bPk5iOEa89VclmGzAt4e8TwMg8BigbRB+EJuLc5BjTi5WiTBQY9zoT5azgb1LgxZTXdephSaV6kdGXV1M4+pLZFrk1lgpkxwHjchf9FxIIFcOYn6MUQQ0pvSWDqsVQX2GwpyoBUN4ags6kH1CNMGmqhzNEKQRRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840132; c=relaxed/simple;
	bh=QownP5O3SgOH6K/a/4OEbY9KCQNS/sRmdjb73UxuYjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b1bWG8AP188X8k6ksLyyyizH7wrkqCij5InGSwcMAOjSon0U3tzpWmUCMYuLoC0mTjFR875ScTWYe6d6SMFMd8U/KjXq/g61vwGrppKgnxh5iRe2SmXEPeHFWW6TfLCC5c/9UqeXp1wTNNicbTaSRoMQn5NwM0wNlls5dx85n3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5lFtol4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5lFtol4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so1701985b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782840130; x=1783444930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aeKQsjfZgGnjU4G1lMW9mvpdAcNYgz7m2gaNolAJCNE=;
        b=V5lFtol4i6FK6+g3fefSLkN5iKfgz+WZoqV7I8FlF7iQT4kFw6cd4Iszu1CDyk21Vk
         9tqy33wDi6svWkCa6XFoZWY3osXXqk5VI6KWMBaUKFJUEP9CR2KhEZfa3/1zxr8mXPRY
         C0IcDFjVxBC/plqBGbkXy4LQSmfu+VVp5WIK2S6RgxMZ8qjH6RV5S14abn1UWifUfTvz
         H/esnHqm1sBHXaETdBOmbCMEd3K96ZnqnMH5CXTRQu9O4FRqcYp5SGLZBTrOHPJ0h5tb
         3CsqYPTM9G9nW5NEHVvY+qasZA4q6d6++BM3hWW1D4RkXE4VGbHQZha709fHqgLudP5V
         tCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840130; x=1783444930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aeKQsjfZgGnjU4G1lMW9mvpdAcNYgz7m2gaNolAJCNE=;
        b=QOcfA1c6scXQr9/3whnl8LNH7v/Dd/RJ6p/rO/CVaLSUuCDBHAfx9WYjx0lb2cLLck
         K+fvO27u7MBWMDrrXAA5ILDBKG/MzksztfO2qjon8c43WJ7QXw1psOtK5BEVFj/gccE0
         rfsMEUHm5P8BXwb3rZdAM6MuHhAalNYhNk1wULP7Xt/CdEcxd1O80UhmDHdh/UUcFISf
         OqD0Pi9Elw3UqVcA/Rqi6x5uoyMheLQKaEgOcuZEqqu8leasrUEvkJfutmiTkCZW0Zi3
         8Ghq4aSmxzD1thSBoSi9OIaZQ8+QDBTflPrIgTzstBhaNWvCS59O5x3ubw1m/iNDVV+D
         zwBQ==
X-Gm-Message-State: AOJu0YxtVe9GXYBEJF/x95wNHTKxW028a/UaCMdWGPch43/uQgo1AJgJ
	g1YqP37VB83uWC8OQ05YELgkLjFc7lZ5+BOyuQVLbATHUiV9kceKraH1Ca12tJ1RJT1TqeEG2u0
	HadLooXZuUYC4ywqQ/06d7fvjyA6T9Rp7eB7rjmqyWVIJy7uuQ6HcD6Gm5BDgv0IZh8qjmMs/1p
	MUe9pufTewvhpmnCUE8xOiG8O4VePbqwB64gq/
X-Received: from pfbmy9-n1.prod.google.com ([2002:a05:6a00:6d49:10b0:845:be7a:f76e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440d:b0:845:e04b:565f
 with SMTP id d2e1a72fcca58-8479f0ecfb6mr3579731b3a.14.1782840129783; Tue, 30
 Jun 2026 10:22:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 10:22:04 -0700
In-Reply-To: <20260630172204.279784-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630172204.279784-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630172204.279784-3-seanjc@google.com>
Subject: [PATCH 6.12.y 2/2] KVM: SEV: Unmap and unpin the GHCB as needed on
 vCPU free
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit db38bcb3311053954f62b865cd2d86e164b04351 ]

Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-running
the vCPU, KVM will effectively leak the GHCB and any mappings created for
the GHCB.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Tested-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-18-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[sean: Preserve @dirty=true param to kvm_vcpu_unmap()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0f79e052ac42..7914cdea4cdd 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3412,6 +3412,20 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	return 1;
 }
 
+static void __sev_es_unmap_ghcb(struct vcpu_svm *svm)
+{
+	if (svm->sev_es.ghcb_sa_free) {
+		kvfree(svm->sev_es.ghcb_sa);
+		svm->sev_es.ghcb_sa = NULL;
+		svm->sev_es.ghcb_sa_free = false;
+	}
+
+	if (svm->sev_es.ghcb) {
+		kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map, true);
+		svm->sev_es.ghcb = NULL;
+	}
+}
+
 void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 {
 	/* Clear any indication that the vCPU is in a type of AP Reset Hold */
@@ -3430,18 +3444,11 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 		svm->sev_es.ghcb_sa_sync = false;
 	}
 
-	if (svm->sev_es.ghcb_sa_free) {
-		kvfree(svm->sev_es.ghcb_sa);
-		svm->sev_es.ghcb_sa = NULL;
-		svm->sev_es.ghcb_sa_free = false;
-	}
-
 	trace_kvm_vmgexit_exit(svm->vcpu.vcpu_id, svm->sev_es.ghcb);
 
 	sev_es_sync_to_ghcb(svm);
 
-	kvm_vcpu_unmap(&svm->vcpu, &svm->sev_es.ghcb_map, true);
-	svm->sev_es.ghcb = NULL;
+	__sev_es_unmap_ghcb(svm);
 }
 
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
@@ -3471,8 +3478,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__free_page(virt_to_page(svm->sev_es.vmsa));
 
 skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
+	__sev_es_unmap_ghcb(svm);
 }
 
 void pre_sev_run(struct vcpu_svm *svm, int cpu)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

