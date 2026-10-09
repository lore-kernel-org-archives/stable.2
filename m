Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639914503EF
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551098; cv=none; b=X1DUNjBZGnoos7e4Jqd54C5xsozYOtd71+wdHqPq3p/3lEQO8ClJDsPhsnY+05PubbyYAt/OvOAszS+NfFTZi7yPZV0pRDW2l+GgkHpZzPVVJ1mgQ/WUEmakqPWAeynERoh3vZAabATDK0zEAQgHJSSgbD8GD3yju4HZatdJ13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551098; c=relaxed/simple;
	bh=wu7qPu0I/hvfIuP8Kg+HVnLAD157Z9fBDyj65s9OurM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMquEw/iIVLBZzP+Vn+dA73vld3WeTXc/rtqKmXH2GwdXEpXbua8/4WzLaPd/3pQD6e+0+hsFEh7s9prqv3S61oQx4AjjNpdw7z4nbOzaC4fHkrLTwxitDt0+VKD+qadMeNlcZbe7pqCxZULD51Th1GimYRRTkXIm7jSYLLXSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKxVExV7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BegyF0xa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKxVExV7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BegyF0xa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791551096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5K/NbHjKEBWTtJ1boI870+SFHYfqVm2UR2n7LXcsi08=;
	b=EKxVExV705GIcvsnBJx1xKUOFEHXC3EdlpHid9tiCRTHERFhfiH3SRjcUTATom4MuG/szd
	gvaw0amf7yZlvreuFVzj9z53kK5Yf/qZyj4sNb8Nq/83hHWr45qP6WpNDeavEKlY3xShaz
	VVsVAys9ryljthTVw0Z2i+XwBNKahYQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-5fYg9P_mMtGhI_tAFGF1Bg-1; Fri, 9 Oct 2026 13:04:55 +0000
X-MC-Unique: 5fYg9P_mMtGhI_tAFGF1Bg-1
X-Mimecast-MFC-AGG-ID: 5fYg9P_mMtGhI_tAFGF1Bg_1791551093
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a16db51147so39178425e9.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791551093; x=1792155893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5K/NbHjKEBWTtJ1boI870+SFHYfqVm2UR2n7LXcsi08=;
        b=BegyF0xaO0mqr6bUbjy8CsAv8S57jP+KSPDm2vhw8JYYVaiAbUP8Bf6mMFDxzikAhy
         H7fH71JHuG4bFpxax++ms5vzrrF/CVkZSCLzu4FM0c4L/R2gyBAZeJHrO4b+WYFgCQG8
         5Xmjg6n4593LFiyme74ETXzT9ymp9+GBKp15CNB+2WRlHj1PDLIWAFq5D2VKtT+RcDLn
         Hz7CptwwmByWRQ+FA7BjINioCcO9fEl1H1KwmT+yOPtuum9x77MAfggEgofA0rveVflz
         1nRDZ9hcfZeCMj+x1noEYUbvoxnkt7vedR0hgTPAi7Lv2a7j58r0zVkN2MCw5zA+Pb3j
         FdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791551093; x=1792155893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5K/NbHjKEBWTtJ1boI870+SFHYfqVm2UR2n7LXcsi08=;
        b=ovotWx6OZ/WdAVcMzaNxt4XvHrNSaHO9tGhyN94ImOp7W6iVEcU89r03Q0dAGJ1CUt
         NerGmTUVb+J7J4m3kxIEKwykmhcyx+Zy88ATo++3BtnZNAbp0nRJMQtEzaImfDdZzJbk
         oEkvcpiX2MRmH7n5IJ5EWNoNauKioyn0JjPslIGm705HiZoVDLA/1h50AHLANQN8e8Q3
         u1yMKX8A4VpIlbDH/TmdzIlHnXIkSruDHOBi650Wmzf5VzpmMKFUB1dnQyDoGXyDSuJ5
         McL/8dPzdC80lHCLxyviQfknUvtPQDT9agXXTOphGTvCsPbcxhHqhQf/Gky/PqCDVGRO
         T4zA==
X-Forwarded-Encrypted: i=1; AKwUvBwM9Zpw3sPy3fbAy8GJttVdPEZdTEETtJ81lbUA6l4SbDTll93q2N/rdFj2RAQMIjj5G0F6r54=@vger.kernel.org
X-Gm-Message-State: AFuF++m3SQsuCPIXCrwnyBfSc3cUWaeRq8PvbOcYGW+HLm1cdo2czv1t
	yFLDZw5LaBkqxXv7qt0R8y+oB+3gRncPtqdFi1LV3t1848pHrTlM0ioObMNu7rp4atfGSCOmHi7
	6Q63h0vxOYiofUW190K44Ru0M8ymFgxAVRkCbL+XSYKzE1+1tmaEurdpRWQ==
X-Gm-Gg: AYBFou0nd6y11QX6zdX//RZKquyFXwQfiXT/dWxAeoMRtB1zjeQ3CR3U4dTiw/okjtE
	NbkkM0JOyeEFTxp1oVQk+57TAUobPjZeBlpIB0udttPLVRen5Rv9RZv6IMjYWGqcOJXFGWrXJ+q
	XN+zyPJ1nNv/t4YkQsUgWKx4wX37+VWP6tpOFlzuJY2Ge+OLE9nkpmi0GxUlmSN/hTeNls7fiBf
	iSn6IXN1uOJoqeg92YMe+heTmAKNGt5hkefYqrKRbs7cwge7YxOQSKA3RuXQzn5SFGrTy/DNV4T
	NwY5kroup6QmgEWyDH89o5jU2OsaljiBq7eq5FSRVn5EEQ9uaxooK3pFJLrNBw5EQUxZyY+gzv9
	utO6DBr9kOFsFEdjA7uIY9vAjsaK27A1Jn3ABipOtOIOynnc7VQJlmtCRSDjfDkNtuUeiVTq+dC
	5Rly7X
X-Received: by 2002:a05:600c:3b0a:b0:4a1:779c:dc8e with SMTP id 5b1f17b1804b1-4a18e4a01b7mr35867315e9.10.1791551092740;
        Fri, 09 Oct 2026 06:04:52 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:4a1:779c:dc8e with SMTP id 5b1f17b1804b1-4a18e4a01b7mr35866325e9.10.1791551092103;
        Fri, 09 Oct 2026 06:04:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bea0f1csm93839695e9.9.2026.10.09.06.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:04:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: SimonP <simonp.git@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Cope with the SS bit being set in #NPF exit codes
Date: Fri,  9 Oct 2026 15:04:50 +0200
Message-ID: <20261009130450.361690-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running Hyper-V from Windows 11, KVM is seeing the SS bit set
in nested page fault error codes produced for shadowed NPT.  The AMD
manual is unclear about when SS is set, including whether it can be set
when SupervisorShadowStackEn (bit 6) is not set in the MISC_CTL field
of the VMCB; in fact, bisection shows that while SHSTK was available
to guests since Linux 6.18, this started happening with commit
687ee95c1b6d ("KVM: nSVM: enable GMET for guests"), which seems unrelated.

Nevertheless, the unexpected SS bit causes out of bounds accesses in
permission_fault(), seen as either WARNs or UBSAN reports:

  kernel: UBSAN: array-index-out-of-bounds in arch/x86/kvm/mmu.h:225:27
  kernel: index 34 is out of range for type 'u16 [16]'

(in this case, the page fault error code is 34*2=0x44, i.e. SS|U; the
report shows SS|U|W happening as well).  Fix the handling of unknown
error codes by dropping SS and (with a WARN) any bits not among those
that permission_fault() expects to receive.

At the same time, given the uncertainty about when hardware sets SS,
follow the processor's behavior when constructing the fault's error
code, and preserve the SS bit as passed to FNAME(walk_addr_generic).
While the behavior is surprising, there's a possibility that Hyper-V
expects it (Hyper-V does not even enable CET unless it finds MBEC/GMET!),
so retain the information when reflecting the fault to L1 instead of
unconditionally discarding it.

Note that, even though KVM always tries to run L1 with GMET enabled, it
copies the GMET-enable bit of the VMCB12 to the VMCB02 when L1 requests
usage of NPT.  Therefore, if the theory suggested by the bisection result
is correct and GMET enables setting the SS bit as well, this would not
affect hypervisors that enable NPT but not GMET.

Reported-by: SimonP <simonp.git@mailbox.org>
Fixes: 687ee95c1b6d ("KVM: nSVM: enable GMET for guests")
Cc: stable@vger.kernel.org # 7.2+
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h             | 16 ++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 40dcbcbae173..36a3a42e0b18 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -275,8 +275,18 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
-	/* strip nested paging fault error codes */
-	unsigned int pfec = access;
+	/*
+	 * Of the error codes that do not contribute to the index in
+	 * fmt->permissions, PK is not included in EPT violation bits and
+	 * not supported by shadow paging, and RSVD faults are handled
+	 * elsewhere.  SS however is included in the NPT exit code.
+	 */
+	unsigned int pfec = access & ~PFERR_SS_MASK;
+	if (WARN_ON_ONCE(pfec & ~(PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+				  PFERR_USER_MASK | PFERR_FETCH_MASK)))
+		pfec &= (PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+			 PFERR_USER_MASK | PFERR_FETCH_MASK);
+
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
 
 	/*
@@ -301,8 +311,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	kvm_mmu_refresh_passthrough_bits(vcpu, w);
 
 	fault = (fmt->permissions[index] >> pte_access) & 1;
-
-	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
 	if (unlikely(fmt->pkru_mask)) {
 		u32 pkru_bits, offset;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index dc0155ed1cbf..a1afe2ae28ca 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -504,7 +504,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= access & (PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_SS_MASK);
 	if (fetch_fault && has_pferr_fetch(w))
 		errcode |= PFERR_FETCH_MASK;
 
-- 
2.55.0

