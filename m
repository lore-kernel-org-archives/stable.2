Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA639A4D8
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495990; cv=none; b=WitcnopHQU+1v2QVxy+fU9TC6BXMmfQnmae3Py6l+ZWtwN4oAIB3LDSmAHduIdJ7/wt0iDEPcZpGkGyGX2CdLmTe5KaMzFYjz/4xFELJS2fZWLnyFNyX+AdGqPXOLP7ohoC6ReUyL6Cj6yMihCtKz9ORlJch8eku5qjY+CxpRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495990; c=relaxed/simple;
	bh=/YwwEQLmxSbJMl1fdqSKJOWSf27TYniYxmWG9YBC5ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABMicFJMEb+oup/wMmNI7jX98Kv7r8xixqi1j/ikeEuJYl/kzTabVccYZMoJytPciOY2r2li3ZnJ/N3ma4uEh1HjmSV4SaMR3KX9QF4AlCn73gWvvMKOWmWi8tG4Xn2KPEQ+Q0/rQKk3wujg42jBnEyrpVui/LxwShvDdtmHsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWO7mknV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=trZpQ5cE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWO7mknV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="trZpQ5cE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782495988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
	b=dWO7mknV29vxtnKQA4L/urTXrNHDHc8mroYuyvAbG7CBWMUT8KCiJcdVsGPmqhwnLw8g57
	wUCh6lNkie7biK6fk0LV3vnfGsdhvj7aqWR8aH+xJIJ1Mx0+3bCQ6HftSnVuWUseRkS4tn
	f6wIeIZtDiF/jGyyuTaRaJv+PRCmI3M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-9D_XRYuuMH2t36A5DzD4ew-1; Fri, 26 Jun 2026 13:46:26 -0400
X-MC-Unique: 9D_XRYuuMH2t36A5DzD4ew-1
X-Mimecast-MFC-AGG-ID: 9D_XRYuuMH2t36A5DzD4ew_1782495985
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46e18156b61so1190300f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495985; x=1783100785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=trZpQ5cEHfhq21WrTiubFo9IQZTXG/e549d+UBZD+gS+oPRu+JDJbaRLw7ZloMDDGX
         vLLknEPIwHP9YvRuvf77utezJpuxYOEhUpGtsuGN43QgHB2XY8ef+4zffy+Cjripb1pD
         Z5qsVnrdLXPl8y9SJmEnluWay6mnm1Budim+Oxqa/mp/72gG9rEA+6Cb4sbdYauHBeBI
         y/mLGy5O2gpycLIp2tU6ztntCkpGVDORZ/8Rk7CDFDFju7WPVznwwHJVfJzjfe7w1hwg
         UCPeix4lsXWd90KgINkB4gPWz5oHhQ9d8lQZYyYxBrX6SH8IKKR6Znx9OrvNug/sPz7v
         CvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495985; x=1783100785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=OoOQ1s5iDwulii/d12OIIzGPGrZr03KIuOBLZXyoDYwGutJR8ibH03IUCITP+Ccv2l
         RR8puSXxfQdQMr55FyHy/5MFpU5eHFQWJGWUtrCnX0N/KLabk0U7E1VnY/E0VjsaRYjv
         lW+fIEBLwEJyNgPe4OxCjUnwN40q8FCvDnHlvGAq07PeqnQNWRBOrjK/e8GbAbPOkQgy
         OejsPKStyWmWmFAOylpkpRN0o8ipSy48UmhazDKnrZRDu9RDhd2qdGGWc2TINz8OGXtz
         QCQ1PIKnj7OSeZKsjcCfs/p4iV/wSf+0i2n6QfOtEkSmLbUHJQ8Rc9TiwoMgOV+iCp9h
         PMng==
X-Forwarded-Encrypted: i=1; AHgh+RpqzG2wdY3pDi3o1pi1LFI+aNXOS8LbBWk59o7OH6mNmA4HiBykfzidsfbu0+VdZuRBTQnTgXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuliPZZ1GdYrLiJUfP5YKZqNMGJ029wsvezFl2yAdsXpT/wyaX
	Vp6Zcg1s8G821L6pg93f6w7iGVMMbpYuBUr0ql7aQttt20NI8u0q3PdAZ+dk1gt0xj4nrF1ehXG
	iJvFbcIUkiioTh9b8EXzScXjILjFP3ZbFx8NFlxoIuRfctHuxDVzE+pX/OQ==
X-Gm-Gg: AfdE7cnXbWXUbJRMiwGnYj+OLY7wHdzSmdtNecfIYi87zbaEepVkYsmV6isDOTfT9ot
	4PduQeCyE4F/3PwTOUVn03tIbb0Lq0HoUiRFeQ16IdD/BisGZNdNgMydeq0Gw2zdvvGddWgAIEp
	Q2v10Kc9hQzX2e9Xxt0CRRpplldm5wC4AoSwMPq4izwn4KmxPiNpDFaNh054eOkwMt89dlfGbLT
	NWSccj4pBhZGh2TUer1jB70fRyrtjwnnHvEstA5mUWp6iFOLArMknSBOP3Ip17+LhNs9ia1I5qG
	mqlWUs7/Aq2br4Qaxm98mrUpXSj49lbDG4c2CQCspxpOAuxx1rX8nLgVddUStQqEmhRgQTvZP3j
	doe+Hk9tKkSngZH0Q6cvP2u20ng2O13dEsy68mYBvNv6kKGq05uprs20uRmdhfIQlM47wOt1VqK
	Hncf735QKNE4tEIEDR
X-Received: by 2002:a5d:5f53:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-46dbfca295emr12912573f8f.9.1782495985030;
        Fri, 26 Jun 2026 10:46:25 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-46dbfca295emr12912536f8f.9.1782495984640;
        Fri, 26 Jun 2026 10:46:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm13846549f8f.33.2026.06.26.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y v2 1/8] KVM: x86/mmu: Use a bool for direct
Date: Fri, 26 Jun 2026 19:46:12 +0200
Message-ID: <20260626174620.1819772-2-pbonzini@redhat.com>
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

commit 27a59d57f073f21f029df1517c2c0a1abea5b0ce upstream.

The parameter "direct" can either be true or false, and all of the
callers pass in a bool variable or true/false literal, so just use the
type bool.

No functional change intended.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4813964bfa0..c03c4341a87f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1737,7 +1737,7 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
 	mmu_spte_clear_no_track(parent_pte);
 }
 
-static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, bool direct)
 {
 	struct kvm_mmu_page *sp;
 
@@ -2074,7 +2074,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
 					     unsigned level,
-					     int direct,
+					     bool direct,
 					     unsigned int access)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-- 
2.54.0

