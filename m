Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2A3F8891
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473238; cv=none; b=SFNhC4ITw1RFmha/NmTvBPibdtTiZ3pkYz5wd/8QjSYZHDmgHJbsACbg3FcVlw1z5SrHLIzgiIYQH+boARAdNOW6JZfAmk1LSEMZKpm3BioaFel/1B0EwX5i1ewpZ6LFrvOENMeuNE4dSpO5rXtGDpkJt7Qkya3V1iCT5ikzeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473238; c=relaxed/simple;
	bh=4Tk1T7bAQVtVDSO4Cyz1IjBHx8Rh6j6660OzLHVl9iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV63zlb8ah9uwflxS+EZdNCdFCAdPURgqo1Ou1M9jdVdFl12NsCnZnnxTkvEcvz7g0a/tRWkgTtTYYop22MP2QqZGOhs7/mMLQ/bn57IsoOl1SouabPgbvDduTRFgCePW83G8blqha5qM0kv2bd6VY7CVbD4mkRr046jUCXdmdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZTYctDq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEE1Iu2I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZTYctDq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEE1Iu2I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwvKrDNtiRlmaWjGsQV6M1SJ94iS+Y8ruq6qo2kSihw=;
	b=UZTYctDqUzxp20KEl4lend5e8obY4EYZhnIM8WsMCN6X0CpKwpYosF7HRdcUVMIkvXiuNw
	2JHJsVq8TDHIXbAGwJwa+5qfP/yfdS7H7AdxnW6+5SSfcSIKK9Ow4ANzVv9eRvGJhU3BYj
	jOHA6Qsm8SSH9RS1y6K02oNr7CmlUZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-SJ4mSWQpMb69GQszP2zbKQ-1; Fri, 26 Jun 2026 07:27:12 -0400
X-MC-Unique: SJ4mSWQpMb69GQszP2zbKQ-1
X-Mimecast-MFC-AGG-ID: SJ4mSWQpMb69GQszP2zbKQ_1782473231
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49244130073so6456345e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473231; x=1783078031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwvKrDNtiRlmaWjGsQV6M1SJ94iS+Y8ruq6qo2kSihw=;
        b=PEE1Iu2ITK0JP/GuCbN6I+1FleyBuMl1RmyAMjTv88lHOqJcxNswlEh5Y3bbeGNOgP
         t9FVQG2sNGteqdx8nTGfRNcWeGtpDhE1zK+NwL0N42g8pqOiIcz36cNwrutxSgKCWZl3
         CGlIx/xwfy7ZvSmxfHKCLNhT7H/P5+dIyAjZ6pFsURU0QhMssxE3p0i8duwdEn3Jn0rf
         YkD46stv52D1vEqiWx1cU74vTpNqGirfwGJp9GLftsm+LrsG+DE8EYLOtv01BeDCmr/Y
         APWwLK8+HpvTCySuHOv7Ms/bN9MOxIYQV0Pq+PxiWmYKilvMmYQVcgfI67frhNg/ySij
         tR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473231; x=1783078031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OwvKrDNtiRlmaWjGsQV6M1SJ94iS+Y8ruq6qo2kSihw=;
        b=WliBAukwIVh970bJckHV9DWI9Maxz/NyF0gu41az4xJJgcPGVYo1hBQAqoVgPGLJus
         +o7N0cvWSvuQK+j5EO/u+RqcVpLE3Rk2drNrl8QSf0gs7jkbsHi6q54z1tucc7reuium
         VD8xi/nqIC2OkOFFLE+HW0hff26vfRDO0lOMzQSgiyz5aHHDSINOtHDzNyfFQqiRZsEi
         ZCeljoswNS6oxQkkcLY1H4ec1LPIPu5D6IPc1E9ADY/qH9LTjDuUBFny6shHzcHAkJCG
         Yiiub/sw3XmnA0UjGvQr2YfZnMmP3CCLX6rskXzSiT5SVrUpQu9SDc4psQHW9ymY/pAH
         v4ow==
X-Forwarded-Encrypted: i=1; AFNElJ9ag27G2iX1xNS8CaZdUyKyjO13xIL8gJYQQvmfjLtCaD+rAACwx+WffiMLzSZ+Fq1x87/FHdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ40qj7JD4ww8Mc4ca064TQqiVqmPquyWCiXMr7YaAODxFe7ut
	TEEjayWVSCGMJlgXQkAvWAH0EGKJBIXQak52hZgcagsCRMaw7EVslBxYMXlAKTRmOV8/fPtsQdQ
	3Fo+JiVDsBFnNOJd4br1eyYryZ5SpPml6waTavoOO6E+BjfVTh1pPIoH1JQ==
X-Gm-Gg: AfdE7ck/qBV+ULnrQKqsZG3GCN8cL/oSSefRkhhO/LBgUCCDIverbJP+X1rnWZmBeFQ
	8PhzbO+aWGsIN7RqpCjBBHiY6ZKGM3WhfbLy509yH1u3Cuwr6Mt7uVNZbjs85D+QeDXzQCsJIo3
	GDAvzzrXvaRm+PkNVx6mjzqIY5DywUhURwU/NlkUxQbGRPhW+JormtGW9i/VTDNcCwz7GwYzlIL
	5wocJcByQLrMns8GOIT9l9Cy90HX1Mo2fAqfad39mk5+wJwsaxs+t7NwplxDQkbzC2wWaGGYzgJ
	EvgMIyHf604rSMhrcsvfwS0L03jKP2MVXfAqP/4FCOD3+TukyxjR1uoQvg/unhpAx4vlRuW2gIj
	9ycFkY1jkKPF0NCKMJUIRFV08Hyb4YtkG8XkgjrEyMmh0IKUFnpdSLdDIC2cxBSm7eMYK3XPuqo
	sFCR/ECaUBKc/yyoP3
X-Received: by 2002:a05:600c:c3cd:20b0:492:4911:8a with SMTP id 5b1f17b1804b1-49266872ec7mr73924955e9.12.1782473230222;
        Fri, 26 Jun 2026 04:27:10 -0700 (PDT)
X-Received: by 2002:a05:600c:c3cd:20b0:492:4911:8a with SMTP id 5b1f17b1804b1-49266872ec7mr73924445e9.12.1782473229639;
        Fri, 26 Jun 2026 04:27:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fe949csm84091075e9.5.2026.06.26.04.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 12/17] KVM: x86/mmu: Check PDPTRs before allocating PAE roots
Date: Fri, 26 Jun 2026 13:26:29 +0200
Message-ID: <20260626112634.1778506-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

commit 6e0918aec49a5f89ca22c60c60cb5d20d8c9af29 upstream.

Check the validity of the PDPTRs before allocating any of the PAE roots,
otherwise a bad PDPTR will cause KVM to leak any previously allocated
roots.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20210305011101.3597423-8-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 76d87da1d071..5df1cd5bff1b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3308,7 +3308,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
-	u64 pdptr, pm_mask;
+	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
 	int quadrant, i;
 	hpa_t root;
@@ -3319,6 +3319,17 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	if (mmu_check_root(vcpu, root_gfn))
 		return 1;
 
+	if (mmu->root_level == PT32E_ROOT_LEVEL) {
+		for (i = 0; i < 4; ++i) {
+			pdptrs[i] = mmu->get_pdptr(vcpu, i);
+			if (!(pdptrs[i] & PT_PRESENT_MASK))
+				continue;
+
+			if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
+				return 1;
+		}
+	}
+
 	/*
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
@@ -3348,14 +3359,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
 
 		if (mmu->root_level == PT32E_ROOT_LEVEL) {
-			pdptr = mmu->get_pdptr(vcpu, i);
-			if (!(pdptr & PT_PRESENT_MASK)) {
+			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
 				mmu->pae_root[i] = 0;
 				continue;
 			}
-			root_gfn = pdptr >> PAGE_SHIFT;
-			if (mmu_check_root(vcpu, root_gfn))
-				return 1;
+			root_gfn = pdptrs[i] >> PAGE_SHIFT;
 		}
 
 		/*
-- 
2.54.0

