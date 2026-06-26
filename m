Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301F355F53
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495991; cv=none; b=fmSWADv6iqHat9T88bvaDQ42O7Ig5fuMyfeNJRNDslbaup0502RNwY37p/0b1Y7oBabY9UP+VaKcwQ4g5i8f3eC8Ct0Eh3pxnjgTWRKwoVYWpE6Wb5iDxAg4FaRVLRyY0gHV+glJawnDhNZdpL7y+WsGQan2FDoot9bdkpgU6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495991; c=relaxed/simple;
	bh=b8QVOIKLan9yq832oH2Egu6sdAJpbT6DrHtWhrkgxBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtAUsfk675CNunIc+m9D0uoEDx53HYwlXnTMnPEiX+b2jc/gurYyMXXFfdQEQIMJe2ztYONx6efMybien1w4yf38VGWp/9g9I56QSG2xY9aJ/aFpK0ReIOi7WKq6db8VCRLIgSKL5G5El8os1p/QcqxOgwTfiHqrjlDr02KhgQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDWydgTd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ViPa65Vf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDWydgTd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ViPa65Vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782495989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMU4Vfx0eRb3lQlGhmviCet5Divd/GCVj5w0pP3Lgu4=;
	b=FDWydgTd0Q6G5z07eUI+VLDWuhbjNJDNjZNu/F2KVVq3Mxiqg/9OIEmbbIxrEZ2QXBaFLL
	OEmmBgL8M/svMVQCLBBM+DqAIMoWMx56tS5O1rof2M+kpjtnJa716M9w1hqZHmVL44ublo
	alqnmjPWC4Q8g2ihkZoR6rBVwpuAo9o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-eKlRtFzTPOCAfuzaJkJluw-1; Fri, 26 Jun 2026 13:46:28 -0400
X-MC-Unique: eKlRtFzTPOCAfuzaJkJluw-1
X-Mimecast-MFC-AGG-ID: eKlRtFzTPOCAfuzaJkJluw_1782495987
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso10003715e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495987; x=1783100787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMU4Vfx0eRb3lQlGhmviCet5Divd/GCVj5w0pP3Lgu4=;
        b=ViPa65Vfy5xZZZ5o4M4PCbQlCW7iMDRcE/GKJrmE6Cj45Kp2Pgv7D5hpjVSdN4wGBJ
         BxdGMPXkAzkARDPIYU1Lrpy0oxqdT8xn0iz5nMxjJaLuXFcEwPlUCO/riJPiOwQVa1Iw
         o8EBZ908/7JMNYTG5EYt8RSZ2e3FiQGPb19VPoXMJQZQYVCPC1GIqi1BFj+ArkzFw89X
         O7yswohCpA4V5chBCLTudQ1nQImhiNZSx+xuffiUxZ4CHrHS0gMywylUElXqfHfBFi/f
         pN1gildh2ZJYwIHkz/qdtq+EcsySjNGFCQjYdXGTj+CsvzTk0Bf+RxeXpNGJlmCjV9ui
         iOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495987; x=1783100787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMU4Vfx0eRb3lQlGhmviCet5Divd/GCVj5w0pP3Lgu4=;
        b=LKNUiIJ+ae8OV4OdHTCx5SzEbDd3PQHEuH2E9UOtbAx7ltXXBKEEB2SxGmragLL9XK
         /pdbQDtC8/UQljj1Hx9gs4+CxVdB+s3UKo90JhBJ8iWXOjDKg6EiVRYYNSJiK9/twpyB
         /bkwsKWHuW1T+fRWKwnJFJk6WgGihYNo0Jr2HFIN7Yfw6ABFqtQpsvlvsvDxr31ElzYr
         cQzTwaYe8fymUjKVl3lwQ2sxX2S9sf+DHbrflzAMXiAIAOTlCZuTvl+/fguEX3OZiAl3
         T8iHtPDh1KTN2CCaKGtqTM30izL5vLziLADV3hhK/eLEYIYxAE7Y32zKq1ACm4s1uPNM
         3tbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Jw6EE9MlO5uVDE8NCUZOGIuraT/I08cROzYZOF0ZvfBzYocQyw6vauu9/3z0SBrexU6MfHlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5Wp+RxjNJiumM5iTh7DYv6m8SLIhg8Cf9gsGlHw6qNo7J615
	M377BDaKb+utAxkrvdonVN9BG2OPt9jGPNoPMgCmZ7tdFdQOB/UT0VatB3QPrYV77o7+Vk+IOh+
	miHa80xOlVYONtCjWp7YbI0qusmrvChvMs8w9+KhSkq1Q7wutdJESWAglbg==
X-Gm-Gg: AfdE7ckmcCpg/SRtnMyfSB6iVEUbgihPcD3XyqjuncVyO13oTV4XHU9vMSZ6WfN43LB
	4P7x+pZOsiDMY3Yj5v4KlP40vA2TMwxsEbdzVXrZUFDoM7wMenDbocPc6PJNmx/EI4N0ng+sJby
	3htIAci3CsWgbOiTlX18Wq0zse2X3A1vU0L+8Kzmz7JUt98aqlWpcBHrYrfhm6bapGcbrcYEf3P
	kmluqEYCol//N60hdeBF3I+iIp3aTK1br4M/ueE9cf8Z6Afhe+EGmjTt+vODilFlRJWHF2i3qz9
	YY4I9X4CTYnkUaFxAEZgWlyK8uWcKeiE+gq/1xggZOCO4Y9rRgVUijNgv8FPk3OoaONQZRp4RhO
	ASZHnW1kz6V8gw8ifu6mcxUR40hT7cOl+helzbe0ax/DtPBQWtZZhfLZGsKJYzv6lI+yN7y0GXP
	QlY3VTwgt3zJFWGEaM
X-Received: by 2002:a05:600c:a403:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-49266899836mr101222315e9.30.1782495987061;
        Fri, 26 Jun 2026 10:46:27 -0700 (PDT)
X-Received: by 2002:a05:600c:a403:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-49266899836mr101222125e9.30.1782495986729;
        Fri, 26 Jun 2026 10:46:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49269086ab7sm133015395e9.13.2026.06.26.10.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5.15.y v2 2/8] KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()
Date: Fri, 26 Jun 2026 19:46:13 +0200
Message-ID: <20260626174620.1819772-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626174620.1819772-1-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
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

