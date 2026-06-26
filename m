Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78243F8894
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473237; cv=none; b=bb3MwHQPPnNSi+VAinF7bEPZ2046/gf0TmXF+4O9QUKViaBV4gkVQK2wrAmb1/tTiikjc3FXzoz12WruU9WDCvMzX0zpg6MeXDdVffp3gGDdyYI24gkJsvJETWuW3gBFqO4jA1ZseJg0aKZwAvicHwk0iftiyeTR216dd8uNg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473237; c=relaxed/simple;
	bh=2DLg9jc/WkFVoQBTSVRm/gj+d811yECfIGYi1C2vlAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtGdcd3RwqfZ32p8DzGu1KTGurWGO0Jz/h47LVxGDtm/jDZFU1g5araiZK77qf6/mH5GvP5LjT+FHeHOC52Yn5wHAxC11HsWWQYyJWFUpCWDlPXqzEl4qlw00j/zyht9ukxQ2BRN00Cy0xm/qLogZGRv7lBRV37VvHWqsgNC3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaolCjm8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tfvV8n1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaolCjm8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tfvV8n1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D8lHy1EHGZTyo8zoJXSeb/nhL4XSNnc7/kx0wm3H/k=;
	b=EaolCjm828/RDo01TnSXbhzI3tyNJs9wjG9+1dNHqUmzNMNwSNioOGMQlNo+cmwfuh4Fss
	kDX+H9hpNNhJUeV5L/hSWKJKs51FFD1GoeTh990bK9o+t254f8kA2T0zCDTL1mgk/o+x0c
	CJibQfWFrNavmSw5eqg51BYj5bROrOc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-u6lbvNqqNS-JsH9PR4PnfA-1; Fri, 26 Jun 2026 07:27:09 -0400
X-MC-Unique: u6lbvNqqNS-JsH9PR4PnfA-1
X-Mimecast-MFC-AGG-ID: u6lbvNqqNS-JsH9PR4PnfA_1782473228
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso5662515e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473228; x=1783078028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D8lHy1EHGZTyo8zoJXSeb/nhL4XSNnc7/kx0wm3H/k=;
        b=tfvV8n1OEUn6jMhvUygwgYfH9IYwg1gwBoYGbDRUtoomrrcYpQW1+Ezw85VsvgXPwS
         CW8BVYYUlBoJ6bqqFAJYrvSeBXYB+ykWNoDesgxVHjlknnpt1qirFzZWJj8+NZNZ/C/y
         ERG2mxcCyCoVdOGDtb+jLtSbS4q7NVDkpLUkZUeapD9O3hZEh4tP880dmInDoYMclWt8
         1W9xDJ+8nzmJJpeachobED10Y9dXU0TIN42FDxgrOPmo7v0g64i3VBBohgaOn7dlufM7
         +rgNgpnR0kUrPIvPaN6dOhbiTWgdetFjbeTbNQrLNxB614uvZCSeGrJaarT/rltSLweS
         w0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473228; x=1783078028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D8lHy1EHGZTyo8zoJXSeb/nhL4XSNnc7/kx0wm3H/k=;
        b=PVygB3iVeqv40Y1AYj1zq/2lKlCE9iC3Cbv/1lxcQjGTF77XjXn/FGCUvwVHD1dRCx
         Y2oJVT1+py0Dk3mL+7gZTRiKQFaGxa8on3k9WtgH/2lobbtzqJn44tEV9GJOliJ4sjpX
         xfmJlAgLbcAl+FaJoSG1akzjU03jRze9B1GKryROben+EYOsXHWV0J9Ysg4bvLgCFSzt
         3phlwDeBNBMEaI/v0MEyjp/+uJD7nr6MVi5hcBJzx+toXIq7gtad718u2SxFL0lsEZAQ
         5sA/uWLiapB7ZI7yi+ljzGFqr2SzRZBYKA85oW8ZrB33Ky8Fg6rzURR0+8JjEhm7YKi9
         h44g==
X-Forwarded-Encrypted: i=1; AFNElJ/IbsXRtKYN6HhfDb8YEilyMt7DU56CbSmPNcPfL7tentFmP8jIWSz3KhilKcfaG/xMvhz4FXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyFtfyLdEC+aHOKC2Fb4auWRY2TD8rCm5NdzjGc6Q9INgWUnsi
	8EJ2bPnO+6uTuDw1PuO99Q3UnBgpJuLMGJrd+ZLeDydpDXq/sZCHILCyNk+L1jvCVob5gUtZH9p
	N8CgkRK/o3gHSwyFFyF5+BEPrXI3pfn9TwRfyPzEst7MXcn30VpWd+z00tw==
X-Gm-Gg: AfdE7ckqGZec17ZGplw/w8g4IYgLtrqqovIeS9km7ot5btekPFqwTHUPsQ7yKYROczZ
	4ztFKJcd2V20XJ+D6N1Q3eapb9U5VFT05Bs2BCmUj9M26tUYVI6n0YJ/wN53wTru/rkKDT9M6U+
	739fBNSBtadR6U5uty2XLtQXqxJ5I2aGEfauiM+h133YzsrQ/VMCMYAztXkL7FZtwU4bhVSTMzy
	IyABd5YH+6ZPaFYx32gPDhJjlNJrK4OcvIhKjzBwFbqNYcyib4qi7AYoO3w5VpUweaNp3bHAxDD
	NRrHHJV9PYnyuX7Bl6enpSJE71ZtCSI4ilVwdr6J3nAGzm11+qCo5JIdZDJ+VqGbFtSaJwS38GK
	WbiaQL8ISjfNdRbEbBLaTxfROzW0/xKi+sSAGv2byXc4hCBDbjP8AkzzLqco9y4i+0BPCDOD5hI
	3UAWvJniEslOBHhsRA
X-Received: by 2002:a05:600c:c0c3:10b0:492:69f9:1314 with SMTP id 5b1f17b1804b1-4926a713d2amr31598245e9.23.1782473228165;
        Fri, 26 Jun 2026 04:27:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c3:10b0:492:69f9:1314 with SMTP id 5b1f17b1804b1-4926a713d2amr31597935e9.23.1782473227718;
        Fri, 26 Jun 2026 04:27:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c2954efsm32015465e9.2.2026.06.26.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Subject: [PATCH 5.10.y 11/17] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Fri, 26 Jun 2026 13:26:28 +0200
Message-ID: <20260626112634.1778506-12-pbonzini@redhat.com>
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

commit 7f49777550e55a7d6832cbb0873f48f91c175b9c upstream.

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-6-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4759156a2dc..76d87da1d071 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3263,9 +3263,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	struct kvm_mmu_page *sp;
 
 	role.level = level;
+	role.quadrant = quadrant;
 
-	if (!role.gpte_is_8_bytes)
-		role.quadrant = quadrant;
+	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
+	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);
 
 	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
@@ -3290,7 +3291,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			MMU_WARN_ON(VALID_PAGE(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
 					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
@@ -3309,8 +3310,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptr, pm_mask;
 	gfn_t root_gfn, root_pgd;
+	int quadrant, i;
 	hpa_t root;
-	int i;
 
 	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
@@ -3357,7 +3358,15 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				return 1;
 		}
 
-		root = mmu_alloc_root(vcpu, root_gfn, i, PT32_ROOT_LEVEL);
+		/*
+		 * If shadowing 32-bit non-PAE page tables, each PAE page
+		 * directory maps one quarter of the guest's non-PAE page
+		 * directory. Othwerise each PAE page direct shadows one guest
+		 * PAE page directory so that quadrant should be 0.
+		 */
+		quadrant = !mmu->mmu_role.base.gpte_is_8_bytes ? i : 0;
+
+		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
 	}
 
-- 
2.54.0

