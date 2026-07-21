Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0E372B5E
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652476; cv=none; b=TsahQKqiOvY7jNgHaTYWBmK7cHW61AXVQMtY/lV01uHfJq+kfNlpCV4uqRyxKuFjAJOnKQGSbZdkl3YIGZ9XzghCitP1uIAeZCZdGSKqap79fhnFwKVIHs6R7JwP8P5+sASya1aCqed/MWzk6ohhW5zNvM3Oyuo9NrpY53iUDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652476; c=relaxed/simple;
	bh=6RwquLywhi0GBUCnzatAMSofcxVHNo0nZEB3gMhfyWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WSYNgD4T7J9ikgdwfiEHbCLpw2og2tZ7ALgJaj8QG+8xfiAhsv4Eghs7+IhAu4NWwJefOJnmNLoEiqYS7SiktMzsOt/ID5EFJd7rm5R2IaGrayUzt3ArsbyRbe0smFBg7Kcx0AZvadlsZjvrPPsIAVglMzPRSMlXKqqljxvwh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECsSr0jI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmsO8l5P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECsSr0jI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmsO8l5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784652471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=be3+Li/Szx6t4rZokyI99j2GfhjzMsbkOxQWganE5Mw=;
	b=ECsSr0jI7VObXm+K0bwnfNQ1EHsWBY6XFGWiABLxBvLTBmznDb/KsaQQnnyX07MCC/0VGR
	aU1RkwxGVSwIiYhw1jQhpJdwrHl4YV318YaiNtllqquJNOu8e0idOD7ZHQOQ1jMPr7iA40
	5RRSMFC69wUrVGTpVikoTw8kQOFiOXA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-G-_azEt3NXaB3fjUtJQu5w-1; Tue, 21 Jul 2026 12:47:49 -0400
X-MC-Unique: G-_azEt3NXaB3fjUtJQu5w-1
X-Mimecast-MFC-AGG-ID: G-_azEt3NXaB3fjUtJQu5w_1784652468
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f70d735a4so2401290f8f.2
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784652468; x=1785257268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=be3+Li/Szx6t4rZokyI99j2GfhjzMsbkOxQWganE5Mw=;
        b=ZmsO8l5PYnOuju9ndnj3ze3phK9B3AVkmjMwjgKTDrJi5nmBEyn/NaZv+vklTdaqy1
         tVeJerjZV8/MNZOBMHqZmwJC2NPtf5u5P9oiJss9Tphm8SIbrB0adUeFMyDoN1+3lD47
         N7lmDsirLxlK9skPt7rwz1cBt5T0imcjIvLflgQ49MHDsta26kVpz9Mby8aqmlwPYaGz
         dY8nHnBzcfWERETKUIiN2ASsTw6GL08YnPtEkmnee6lfioy77tm8BV/ppThcHjxxG+zT
         vRZ7+7koXSO2+/4bMJ5YAkZK6t6sUBVlSRck8DUiDzlJRFqRW656RKG4bqzXLCfq8dfJ
         //Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784652468; x=1785257268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be3+Li/Szx6t4rZokyI99j2GfhjzMsbkOxQWganE5Mw=;
        b=GBU+eUQbFPeYAy099L4KGO7H2Cbrh1sYQ1dj3Fg99XgTFKbVWw9EsXbCfHFQ2jMZQJ
         FW6Obl4lbLcBDmTxOJ0DsblaCmk0OTr2U9XY+cbNDnB9RvUnCLUn345wXDw+t6X7KIaB
         bbyq8OLbs+kGjuxFNxZQs3WPLzLxDf8r1gYhhMjJd9myIbqKlvAkOZ7DAuOWMhXpjj7H
         cLxOZcwVBXZNm1VPqkP+8GIJALurN6uZO9nLpMAoSLJCTqh96GMfuntAEtw1hvwE8Myg
         gS2C+6pto+1TyLl+3RjD7J2RRNKfevqAP96m8Qs34QP4rMYdwptcGZNUvHoECzPD1Oex
         hntQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKhIBk4NnN5PEWOQpeFhziCiY+dDR9OUmjHWurgdBfi+ZrxrA2Fv6mdC2YyET8fsLvTLAdxYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwcPj2csZh9pu7b0w6XixWQgcSctLsoW1rCrjsQxTRFXhfaIo
	7YhzHARwTIlqKZzC5D7edtlW2H4co2qnWKePc/ulp/4YDXPpxvhWhImkOConYHpyDzbfb4BkMo2
	4lrOfkhfn+8xv5eLrPO2tY/NZis65oBDvcWHTv7zvGUUC35ev0X0X//RgZA==
X-Gm-Gg: AR+sD135fl/hhjdXoQKmLT+0AemBjlJq4uL5iFa8WfVFF2tqwxxOaFtSbANZh8OWo83
	ywS4nJcwYzrQVn6bbPByCv8h62+pqJJT/nWJ79GZNHnYDZzrOM3Q5g1P8AITbuGp7NQyu5/+nJL
	yzpqkVjSYxhKt+JsAgVyJ+hUVseB1DUlAkpv8NLCzOm614kRZZ05Q54xSy66C4v8zE5FjTPV3QM
	mnHvwybhjAh+5dZjQFSfQBr/UjcwEepPa+EmtG/fDkKg7i8rUNHxXSzv3j83Fl3OJrt9vyaQYKo
	6oun/C4p55opIIQ2vAWOcfHACgzBieKKw6dP5wDtwnyBMs9x8iVsHkQ0zLyxIgFbrxCoboq9hjP
	TTxkY1A7gyHulq/DauI/fahKlYo/nEclRd+ckrzTrT3383Lu5FEDSLXfi5v/LNRmq3CeZqmX703
	Cxjw==
X-Received: by 2002:a05:6000:400f:b0:47f:8152:e568 with SMTP id ffacd0b85a97d-47f8152e595mr4213985f8f.60.1784652468387;
        Tue, 21 Jul 2026 09:47:48 -0700 (PDT)
X-Received: by 2002:a05:6000:400f:b0:47f:8152:e568 with SMTP id ffacd0b85a97d-47f8152e595mr4213959f8f.60.1784652467986;
        Tue, 21 Jul 2026 09:47:47 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ec7c69sm43124153f8f.17.2026.07.21.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 09:47:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: VMX: add memory clobber to asm for VMX instructions
Date: Tue, 21 Jul 2026 18:47:46 +0200
Message-ID: <20260721164746.376551-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMCLEAR/VMREAD/VMWRITE/VMPTRLD access the internal VMCS cache, which
is not visible to the compiler; without a memory clobber, the compiler
can reorder them in troublesome ways because "asm volatile" and "asm goto"
only protect against removal of the asm.  For example, placing a VMWRITE
before the corresponding VMCS pointer is loaded can lead to corruption.
While none of this has been observed, it is better to prevent than cure.

Likewise, INVEPT and INVVPID access the TLB and, even though in their
case the effect is only visible to the next VMLAUNCH/VMRESUME, it is
technically correct to add the clobber there too.  So avoid any urge to
special case them, and simply hardcode "memory" into the clobber list
of vmx_asm1() and vmx_asm2().  __vmcs_readl() open-codes its own asm,
so add the clobber there as well.

Link: https://lore.kernel.org/kvm/CABgObfbL3t21yVeSwiLSjjOUER+rTYDPHYAH9YU4TWGRjx6XHg@mail.gmail.com/
Cc: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx_ops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 81784befaaf4..9ffe03a0c223 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -101,7 +101,7 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 
 			  : [output] "=r" (value)
 			  : [field] "r" (field)
-			  : "cc"
+			  : "cc", "memory"
 			  : do_fail, do_exception);
 
 	return value;
@@ -145,7 +145,7 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 
 		     : ASM_CALL_CONSTRAINT, [output] "=&r" (value)
 		     : [field] "r" (field)
-		     : "cc");
+		     : "cc", "memory");
 	return value;
 
 #endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
@@ -192,7 +192,7 @@ do {									\
 	asm goto("1: " __stringify(insn) " %0\n\t"			\
 			  "jna %l[error]\n\t"				\
 			  _ASM_EXTABLE(1b, %l[fault])			\
-			  : : op1 : "cc" : error, fault);		\
+			  : : op1 : "cc", "memory" : error, fault);	\
 	return;								\
 error:									\
 	instrumentation_begin();					\
@@ -208,7 +208,7 @@ do {									\
 	asm goto("1: "  __stringify(insn) " %1, %0\n\t"			\
 			  "jna %l[error]\n\t"				\
 			  _ASM_EXTABLE(1b, %l[fault])			\
-			  : : op1, op2 : "cc" : error, fault);		\
+			  : : op1, op2 : "cc", "memory" : error, fault);\
 	return;								\
 error:									\
 	instrumentation_begin();					\
-- 
2.55.0

