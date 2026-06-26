Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531B355F53
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495998; cv=none; b=NFtRHgcyGg4Xkewhv+5OOe2+pt6QkEZvN4mkDmAMvvTto9Xd3f0LMh36SmCGI/31T+Cowx67ZbXY5hPgUpv7hKoAE3x19ATT5iIr3gXqd6VzJyXD331wfajlclGog1q5YS5RVi3Zct2Ktq7F8tjJLD/y0NhAniODlAlsoNR9zO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495998; c=relaxed/simple;
	bh=zLklgwFSYl7YtDQHnnsYt3gGsS6PqKoqQGbciUElPpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hmq3Cv1xpdlcdBygaoYWknwDwLVntFqaylKdbuqH09nk5V4zND5qTONIYdeBOAy419RqDauJbn8kd2kxyCS7jhiMnwMdBFKmy8R2KKbyYueHza8SaWwDp4ljUSar0S+ttWyryHc42xOwwp/uXO6kk1zSsVw8twL12VTobEiLurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WDhONaZO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUrX6wbO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WDhONaZO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUrX6wbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782495996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwixNX9Ud324NM9GYv258HhoqjuhQ4b/EvEuH+s4zXI=;
	b=WDhONaZOfpj2hF8WOtDNAiutS+UTicQ1U/Yf5iLfxMzVy+4GCEg7Ae9//SuteFkpnG6t4M
	+KNBuMzkoK8u9gDOpffV3nM6Fj0HVP1D8qD8YNP/A0tZbp6NWO9SUd5nK3C9UB18b3GH9f
	PF3CJRNgPXg4Eha4XxiJ1NgZlMYXRio=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-yNMUVt99MLGIxtKMNNJYXQ-1; Fri, 26 Jun 2026 13:46:34 -0400
X-MC-Unique: yNMUVt99MLGIxtKMNNJYXQ-1
X-Mimecast-MFC-AGG-ID: yNMUVt99MLGIxtKMNNJYXQ_1782495993
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46db5d470bfso854776f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495993; x=1783100793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwixNX9Ud324NM9GYv258HhoqjuhQ4b/EvEuH+s4zXI=;
        b=XUrX6wbOkQxTfu4f+4xnKnFX5+1PsDX19dmpIj3YTgvFq9IGn4y7RHCgV0YvmGI3b3
         4sluYTBDMWI9C4MWFSGjmWsaXLJT7lEx5uLeP/l9VUXyfhRF3sDYr/fJATqg8MeWPsGF
         KOD1SKNCbBNId09KQSLvnFjNSVLxickvHcsVQD75KYPlQ+Rc+rM1UfHAKVvc0urX2gha
         ktHndXXWwhM61RG84ENfk+4VBy5dQnG+sh/mo4y9qGLE1F9s3eLN8+gYs2TxqbKvVcrD
         +KZZXupu2XQwqai83S0E6Hxq/jKUuUpYD+nu2gueuqDRinvf70faxlZHlT2gW3DVt44w
         9UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495993; x=1783100793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwixNX9Ud324NM9GYv258HhoqjuhQ4b/EvEuH+s4zXI=;
        b=Qad/d/NVgUX38HmlOy2mHhG22yVg5TCO3HsQCTQaxcJJ1LO20kqCr5xqEW+MLD5/kr
         BJiqODv4n2Y0XOaFvL64LPwdmdaAUarnqpcaFqjMuy4dSQrwFGHPCiRskzXxpVrZuDUS
         rrA6hHxzTH97wQBB1VO3CZWAHtGK+8v/6LFObHvlqSV419EDpghLWDUFyRrjBptkfzd7
         QNUf32NpMZkjRr6Cov2LV9JGYsGd0+4NvtLMxFjz1T6d/Kvi9NxjzofSmIvLVGh4a8sC
         wnREfv4G+dP6jRJs3L6+ny7t39GlvJLAFgdXMbwg7UEOpnc7vOo85elrpv/uCp8yXDkf
         +zaw==
X-Forwarded-Encrypted: i=1; AFNElJ+IjVVNhEB3SoIa63NVewQ/oF3qhp0p/vxd8hxLBqOLkJgmIhFZ3H/nhxF6r7CmHi18IyU+TZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypQE+3ocorOv2A4FkM0ti568Ddyvac9lI/kAhVg6EJMj5394bx
	dvFENHY4LG7a5Jnz5hWe7Qv//GfP2CL9EOu/+B1daJnVrpESOFC9w8+/8XMv/nwcTweVAgEhWQK
	vcRhOy8cdS1YnJu/ww/o5wtAi9NMv8qGnT0FIBYDovAhJvnekzhIOPAPSzg==
X-Gm-Gg: AfdE7cnmwGvjk6P3X87AyegbDVM6i/mtCEAEnp2eDhwaRXA9fZXgUPYgg3VEtTulkti
	XJsSooR4uQmatbr4RGt4VRS00ESkfZyZ6TKHyXn4kKY8v/sTollOAWIUmCZemaTKzyJpeDmbyj+
	i5uIY3KzgKXBfqyJzZ7v5hppNUJbtqlmkbaT4pEjlMg3pPFlc4/sC3uCKfS0Ez47YDtGcShGhdt
	EZyxhdWBbJSYsVZe5wnLu9FP7SW0e15enlCfIvFWnQYSLX21Rail2InJc/1oBZSDP+gtxYhfCiy
	mfunDSQ8yhEKhMtpYYo+cyZzqOaP7EDvIk7atU/01HaTCQzvTyjGSfK7S+cEkmjnIdI/fl9a4cD
	mYzXGGiJ9V1aa4C0UPvOPpoFdpU8wpBjQv1wr/EIBtO642ePyB4M28bJSDGGXrw0lK4qiLbpNi5
	3+s6vS0a9EEbCwcW8x
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id 5b1f17b1804b1-49269541111mr72347625e9.14.1782495992951;
        Fri, 26 Jun 2026 10:46:32 -0700 (PDT)
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id 5b1f17b1804b1-49269541111mr72347355e9.14.1782495992589;
        Fri, 26 Jun 2026 10:46:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d998esm25805016f8f.24.2026.06.26.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>
Subject: [PATCH 5.15.y v2 4/8] KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
Date: Fri, 26 Jun 2026 19:46:15 +0200
Message-ID: <20260626174620.1819772-5-pbonzini@redhat.com>
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

commit 7f49777550e55a7d6832cbb0873f48f91c175b9c upstream.

The quadrant is only used when gptes are 4 bytes, but
mmu_alloc_{direct,shadow}_roots() pass in a non-zero quadrant for PAE
page directories regardless. Make this less confusing by only passing in
a non-zero quadrant when it is actually necessary.

Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-6-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3a5ed9670377..dbc18d4cc572 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3444,9 +3444,10 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	struct kvm_mmu_page *sp;
 
 	role.level = level;
+	role.quadrant = quadrant;
 
-	if (!role.gpte_is_8_bytes)
-		role.quadrant = quadrant;
+	WARN_ON_ONCE(quadrant && role.gpte_is_8_bytes);
+	WARN_ON_ONCE(role.direct && !role.gpte_is_8_bytes);
 
 	sp = kvm_mmu_get_page(vcpu, gfn, role);
 	++sp->root_count;
@@ -3482,7 +3483,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		for (i = 0; i < 4; ++i) {
 			WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), i,
+			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT), 0,
 					      PT32_ROOT_LEVEL);
 			mmu->pae_root[i] = root | PT_PRESENT_MASK |
 					   shadow_me_mask;
@@ -3506,9 +3507,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
+	int quadrant, i, r;
 	hpa_t root;
-	unsigned i;
-	int r;
 
 	root_pgd = mmu->get_guest_pgd(vcpu);
 	root_gfn = root_pgd >> PAGE_SHIFT;
@@ -3591,7 +3591,15 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 			root_gfn = pdptrs[i] >> PAGE_SHIFT;
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

