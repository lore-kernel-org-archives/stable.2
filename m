Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA73F210A
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473179; cv=none; b=pQaRfcxvTNgOsTsI+aL3eufqA4UKPzhPErN0IGQBRffKSVPf1HONAvjgS7NgBZXAdq6saMoW0xyhg2Yen084voqRx0nXHiZHB7D/vepBHwHmG3C3e1odNVtkznbx32txz4JBIFCO8K7/76ypjZg//DDuDUjNUJbyodv1AKLc/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473179; c=relaxed/simple;
	bh=b8QVOIKLan9yq832oH2Egu6sdAJpbT6DrHtWhrkgxBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2EJtA0KZyrluX3Uq+OPqOvyp1pjgC26tPkcQXb4NlpRUMRIuncR1WEt+vKA8pmK3iketjXnqWibw+bCRK6ufGTAkXcSyZz9craNh1XpvEpZB6Yp0Kevsx3wG+x7rg1RfYjzArCV821sOq/Le/XpGlACSARdIBskVSXN+lQ+P/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJ4XAAJH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgGMiIx+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ4XAAJH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgGMiIx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMU4Vfx0eRb3lQlGhmviCet5Divd/GCVj5w0pP3Lgu4=;
	b=ZJ4XAAJHoKwUkWe/keYP5GDOePlU+19VFc3T5gK3jAdjRwDktxerXelQac43l1MWcDcjsd
	oANQju5K0vqnrQSJrab5frBZsYkZC/rWLjeXPUkQQGqCi5Oac97x5GsR6lYKTRS5TWWjZ4
	ywx/x1GbATTlZ3nklm3h6pCVLnvHGds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-wj1UxsFoMxa69SitaqpFAQ-1; Fri, 26 Jun 2026 07:26:16 -0400
X-MC-Unique: wj1UxsFoMxa69SitaqpFAQ-1
X-Mimecast-MFC-AGG-ID: wj1UxsFoMxa69SitaqpFAQ_1782473175
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4625e71d3ccso1469733f8f.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473174; x=1783077974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMU4Vfx0eRb3lQlGhmviCet5Divd/GCVj5w0pP3Lgu4=;
        b=dgGMiIx+uAXRMDyhe/woz10miHSDU5owwpjqjGIxJwMFqnP93SQ2vtNVCKHrCsdNxc
         HCFuTWZntIUx+tDFp2K74zQ0kS6E3hhX9h7GM8Gmu05gNFTDpKuwyIpl35jHd1V4NH1e
         65SaHa6RaPelyAumWU1ZQnsuuz2bH1Y0Z1xoXuiGk/mhA6sNeSPQIJoHYJaiDBYaQ1FP
         JsloEig9ozrjxPWFXilwsEHROau3RHvEMwYUH/JBWNk8mSQZj1Izl3f5QIZZNqMOzmXL
         RKSaQ2ii+b5GAWhVH68UXfUeICDomdANEdXFpgrXrxtL059Xk3oCET9+ngpP/PaoZ45u
         Ym6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473174; x=1783077974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMU4Vfx0eRb3lQlGhmviCet5Divd/GCVj5w0pP3Lgu4=;
        b=hvefsnN7CNTzmpr6oZ9SCHAIfFiDMyWYITfha5vHvX1Xj6ew6aXjq8vrPl3SSEYGVt
         3jmsnLxrbWIsfCDigSFYH67yPYIQ2namHetw1WSNmNm1qtTBuwj+MFbmgYb+U3r3DvF+
         YUdaW3dmXhBPn2FSbsYiaE/2J4HfrlKSa8pSMMcUwmlIupFFs6uhRa/cxYKZ78SmH0B8
         i4E44rs4Udgg/sYrT7tResZVySLjDzDSfoKvocndLVPs/jtP2d4E8dKL3qTs+/hinu3x
         UsyXCxzbEgEnCL3V3N1kVd7L6/fOz04E0gPsr+pT96RjGsISZPW8BVrl/i+1BBeOLX64
         fbyw==
X-Forwarded-Encrypted: i=1; AHgh+RqYLokfuLNE1a9tJppLuMHtFp46o8x9nOItvvqDGu5UiSWCW78oowQYOi/5UJ7SlYTFe6Pb0r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHZ8RqBvuNfE+bU8h8xK6rz/2UiO6ig3DRQWZny3FpCh2ww3P
	9oS1gxPKrItGQF0at0/zFbH/Yrirna4lgiSC7f0r8aMCmperhs5q03QC18rbmi4We1mrRa/CPhd
	f7mtF2lwUVG+E1Gdxy7feDiIdyWqhOIgmRBRAOXy6N4q25l464KJ4Iiz6lQ==
X-Gm-Gg: AfdE7cnIIkNcebnzU/kJfGSilDcktUGA6ZQDJ5Nc1P9p2qQm3EW071z9NXi8DTvZCst
	NTdmxaiEgEk7Kjp1aVCg/20hSs+1lSF1vZZnvjc/mD4mKK3Lk1G2hqpeGrsTG0D+7CjzIubgcPH
	04xSKY3rnUzvptLmjXcv+gbEAJHXFABw3hNnoCsjlCWZhbGY2JhHJR+oRSapom0KLw/aQ7EI2go
	DuUcoVB7JXQPpYsfd844Fcu+lNrOHpRpnl89GmRQhvZNhV3u80UFBR4XIpNvF73HhAAVKkt5QNb
	TGUhoNPGyxV4CdzBgCiag91m/fuyphIgUe6QJM7w2hPrn7q+XsxexKegCBZQq7prfbfWn5GPEoQ
	+rxFI/4IQt72EYl9FqSW7TEc7sx58fG4+C2xs6YRFkkVDFz97YiFVMxXbYK3Rq/xbLu0C4hLfsW
	i+t+eGSHiMonktfSwB
X-Received: by 2002:adf:e186:0:b0:465:f555:d9ba with SMTP id ffacd0b85a97d-46da95fdf75mr9561680f8f.18.1782473174583;
        Fri, 26 Jun 2026 04:26:14 -0700 (PDT)
X-Received: by 2002:adf:e186:0:b0:465:f555:d9ba with SMTP id ffacd0b85a97d-46da95fdf75mr9561649f8f.18.1782473174137;
        Fri, 26 Jun 2026 04:26:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b85csm22609647f8f.28.2026.06.26.04.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5.15.y 2/8] KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
Date: Fri, 26 Jun 2026 13:26:00 +0200
Message-ID: <20260626112606.1778248-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112606.1778248-1-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

commit 86938ab6925b8fe174ca6abf397e6ea9d3c054a4 upstream.

The "direct" argument is vcpu->arch.mmu->root_role.direct,
because unlike non-root page tables, it's impossible to have
a direct root in an indirect MMU.  So just use that.

Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-4-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c03c4341a87f..bd7650380ad9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3409,8 +3409,9 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
 }
 
 static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
-			    u8 level, bool direct)
+			    u8 level)
 {
+	bool direct = vcpu->arch.mmu->mmu_role.base.direct;
 	struct kvm_mmu_page *sp;
 
 	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
@@ -3436,7 +3437,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
-		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level, true);
+		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level);
 		mmu->root_hpa = root;
 	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
 		if (WARN_ON_ONCE(!mmu->pae_root)) {
@@ -3448,7 +3449,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
 			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
-					      i << 30, PT32_ROOT_LEVEL, true);
+					      i << 30, PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
 		}
@@ -3511,7 +3512,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 */
 	if (mmu->root_level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
-				      mmu->shadow_root_level, false);
+				      mmu->shadow_root_level);
 		mmu->root_hpa = root;
 		goto set_root_pgd;
 	}
@@ -3557,7 +3558,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		}
 
 		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
-				      PT32_ROOT_LEVEL, false);
+				      PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.54.0

