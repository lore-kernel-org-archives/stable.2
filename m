Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37863128B8
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188004; cv=none; b=hN/Q9Vg9jbnqMJf3dCuIGTf+qkSrgEJBSRAz6SyeQ75brovy2U6s1vkaPoXCgv6s79hEJJtbOK31QthE5xM13jo3aG/Lm8/4oojKGEahIgjPrzL4oHlORDGEEuJ5+1wLeiGalRFToCUe73ssTu1UdPZ6XzzQFZFqZUHgx4GfUuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188004; c=relaxed/simple;
	bh=HbK1+JLVKgOJTFvYTojhO7JSe+mVALcF9merhE7NbHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqKBSKCA0yCKPTSIyavzxP4O6bKXIIP/Gd1IT0UCjcRwfaflBJCUN+zsek89ppBXVoJje02n+iduTTdrH9jaBKg8blrGwC0IXPACVb6QOJTU5O8r+oaKDjnxng4HUXR25FmrzSI39Imh68/dZOLP66jsSXRmdc1WipeQXl6U3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UTr2uhPL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4XsqW/m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTr2uhPL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4XsqW/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784188001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bl2gNkOAcxltrIfsVP1WCcvdBOInCr+iXCm5EqvvKhY=;
	b=UTr2uhPLyDS+T7ECAA3m8leB0DhrkTN7p89H0o4g5PNcJZZ7WTa6HC2rX51zrPCoRhYEei
	8Sfc7g7lL7UaK9v74ghcxywQsfyrfHN/ZxGuxwA+T7SAjUny1e+vAlhUulq9A0S3fUEztd
	Wx/DxL2JK9dY9K74wrLta8pjy1xkyTw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653--irC2jsnPrmgcBiq8HFv8w-1; Thu, 16 Jul 2026 03:46:40 -0400
X-MC-Unique: -irC2jsnPrmgcBiq8HFv8w-1
X-Mimecast-MFC-AGG-ID: -irC2jsnPrmgcBiq8HFv8w_1784187999
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475eba52438so2568896f8f.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784187999; x=1784792799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bl2gNkOAcxltrIfsVP1WCcvdBOInCr+iXCm5EqvvKhY=;
        b=E4XsqW/mAGYBPdPIj1krXkDw68fVLtpkflszoDVZNymRS2PAAam6Bv1PNFWnaijC9/
         D9XdnRYxYP0f3S5YFnpPluTI5L3f1r+nTzEt+N5wBlJ0fLSHguVIcuAKZYn23KGe6IIu
         TIH/dLpbHztMgFaxDu0epy0q2m49CBgDcKgSxQCLX+jicQdL8PCNb1wS9REs1IOAuVqy
         Vo345WecjRoPAawxoPdPh/PyfbfG4b27ffKYS5e///OYBZrajfNDzmmUlMfMaXoFBF6e
         6bt762lanYP15ScDLLf7YbdUbVhBJIE8lADm0WIqRo+V5lEb0zDAk66/rS3KMztQ+h4Q
         lGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187999; x=1784792799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bl2gNkOAcxltrIfsVP1WCcvdBOInCr+iXCm5EqvvKhY=;
        b=MsfKL1CFvnaqz9n7MfkiTP6YEUDsliZgT8D7Q+72JVDPPrB8aXaqdjpqwhusIBe3ic
         8nForzpiGeeshdbK95+Q6+4luwjrFKP11lmm+FqRREQCglo8us+iFu12uNlVUzpUlw7j
         9VRjVohgr36AdmpM4n45gV5/fWbRq++CYdPyzq627Of5gAvt3UlO3YhVALk1siRlRMK+
         p1wYqnyBcteeuBNJda2v84lNFjJq3je1IdbMiljhuxlLhQGk1pA+BPkYe9FRQcD+aAXo
         gfJjnsic+j34dshvgD5mOLZUsRAMLqi4aV4SAZGoMgKQ1daWTluFrwmSmEJoJyCSyjbj
         a5kA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6Y4z7XatqKnGnPJz2/4vd3qMoXhXHvuHH/eRwrxICGAgOS4ejt/4Nyz45imNOy3+J2yFSaYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExw7ogxREqn7xMZNz5Yd6+BKG+nZIr+r5+YIke6eo+64ej983
	7hC4fWWLYBUF58eV+TrewTxJOn5SOG+lJ9RnPRQSfABpu2i3IUGBjH3iDCDStY1a2v3q/32jSii
	vZ58CFRH1zJpKJ9ExMcngQ8Ri6BIj+K1MErtcWqhN2qJkW81jo6EgYdGPhQ==
X-Gm-Gg: AfdE7cnKYDLNLngss/S4C7M4keO1La+4pca/uZIqQRiyquP56CcEKpOm1infmr6CozP
	0VXv4WryqNf4JYAVdObrlZOJX7GlZy6kBYMYcWLwz1z74kuMa91haCGyG06zKMmt29dlqv+Oszs
	OdCg1SfNm45VbuI1DXrGQxGW2XP8hO4s5iXG+njcJJQWT1FoVylbXOAV0IvRYcB0FOWgv6PeB4I
	2QZKaxQLJoS96Uh9vk0pUW9o9F1FR3x6NP0llmfrT5Sdrer3X92YJGfLmrlTu22eM+hYO3N3Cmh
	U2VuuqCvNpQKVkjD0qKFzVkv9uD7pRc0KuoNEaXSYMuODOGV/5K1TUfTjRNWbX0fcM+6ZMDiVlK
	ZZ2XyehiMEr1ZZ+k539+nH7lKule70UTq3md15yOmOlSYr0nY5aPfXnoLqPMz3i9NFHKj0W423V
	Zkiws=
X-Received: by 2002:a5d:5846:0:b0:475:94e1:29d5 with SMTP id ffacd0b85a97d-47f2dce942amr23649759f8f.20.1784187999249;
        Thu, 16 Jul 2026 00:46:39 -0700 (PDT)
X-Received: by 2002:a5d:5846:0:b0:475:94e1:29d5 with SMTP id ffacd0b85a97d-47f2dce942amr23649701f8f.20.1784187998681;
        Thu, 16 Jul 2026 00:46:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm22810165f8f.37.2026.07.16.00.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:46:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state
Date: Thu, 16 Jul 2026 09:46:36 +0200
Message-ID: <20260716074636.756689-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Put all vmcs12 pages if KVM synthesizes a nested VM-Exit due to invalid
guest while emulating VMLAUNCH or VMRESUME.  The invalid guest state path
doesn't use nested_vmx_vmexit() as that API is intended to be used if and
only if L2 is active, and the open coded equivalent neglects to put the
vmcs12 pages.  Failure to put the vmcs12 pages leaks any pinned pages
(and/or mappings) if L1 retries VMLAUNCH/VMRESUME.

Note, the !from_vmenter scenario doesn't suffer the same problem, as
vmx_get_nested_state_pages() only gets/pins/maps the vmcs12 pages if L2 is
active, i.e. if a "full" VM-Exit is guaranteed before KVM will retry
getting vmcs12 pages.

Fixes: 96c66e87deee ("KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page")
Fixes: 3278e0492554 ("KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table")
Fixes: fe1911aa443e ("KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bb0eb40b4448..220d42ebc82e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3761,6 +3761,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	if (!from_vmentry)
 		return NVMX_VMENTRY_VMEXIT;
 
+	nested_put_vmcs12_pages(vcpu);
+
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx))
-- 
2.54.0

