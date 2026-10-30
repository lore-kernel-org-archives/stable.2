Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.246.77.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356649;
	b=g7IiNZueU3+RiqsFrR48fpCZZoroflgWOcP6OtkfdPys7disW8FNRlDPGIfSTm1Grbzi
	 36vcb1Pp0OIm1Z1N/IE/tWGkuqs/wJfUvD6BFB1LDUb6nz7mPvM3i/3i/yFlriNrfiuA/
	 FBrG4pAWrISl+Dpl/WmWF0sF8MpQaCk5xaGlYQr542Ro5SD/bhei6CXai3wadJGi7oB5O
	 YdMKQS4TO8AsDSCH9vhIaPc1xkwMF+bMt7ShDtuAMnHD56TrL8DI0lF4hySP5xswokoAO
	 QY3ON/KZudvyEpdodvcuuPw2zH9vQd3BEl2aGcgfjpRAkLdimjLBy+ssOqXaFa5Xy/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356649;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=3TlDRIrdQFFwzDFTq8LEGSiE/Z2sDAfjnObNHmu9h90=;
	b=EObH+WaqEYUI33iQN/95rOS4by7fclt2ARk+vlAQssnqIw119biffrV3s3cPLf2KDeGs
	 bvTy9QUIP/EhioFNZHa/ntcsaFy4h3v3Vzcag3FfI2B5UxAdJEeZh/VzHpU96fOJ+0zXI
	 mAVHQAPPw0RDSpjC/T1YfT2i1f6zvcqGJCpC4Sqx2b40CBTKUC6Hfovl613lJouj7cdOg
	 bq79BXoCWMTybpAlNhD7Qs3PYHxGwLeb9dxlbaA9Bl+1y5tx8remB5BOkun8AzEB0Rlg/
	 VyOSfEqdZ7yHzWzEcXo+KUDm1jVCFfnDn/tMMqsi4Mnb50HoY9e8UbCml9R8c1IWLRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=DzZfgUnN;
	arc=none smtp.remote-ip=44.246.77.92
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A160A2603;
	Fri, 30 Oct 2026 10:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3A160A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=DzZfgUnN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356648; x=1824892648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TlDRIrdQFFwzDFTq8LEGSiE/Z2sDAfjnObNHmu9h90=;
  b=DzZfgUnN83ADVwDdyMwCKfl/Il9jBH4fkQ6AgxjhqZvuAJpRc6Strr9G
   akqkpIp2wloWyvGWov2ePoIf28EGChJy9dRm8U3uhPLsltMbfRLj3cAFO
   9n+TiHXZ6IAy5YG6iweEDndZ6K7dcSx/RA4SQDIc3/URJyBcnB8VCgH6k
   6s+c7e8LF4MeypJOcVI2d47kntHjVDL3tdwm0vxJgRUuaWHKpWjtMkJZV
   Db6MSZENU6/EjoR517b/eUAgR+woIO7k1XuyNPuT8OacOOn4ChGoDsmLd
   q0d0/S01kZXM3qo0EPCJNJqDahksH3TEHV82OYRrfS4lswoGf47eR71tc
   g==;
X-CSE-ConnectionGUID: Y+oLEREOR4a9nBa6w4j0Fw==
X-CSE-MsgGUID: GK3kvjY1RciMgmwKZcAVJQ==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32653087"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:25 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:7122]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.208:2525] with esmtp (Farcaster)
 id c9169a59-1af9-4be8-b42a-3b467efd1cf2; Fri, 30 Oct 2026 10:37:25 +0000 (UTC)
X-Farcaster-Flow-ID: c9169a59-1af9-4be8-b42a-3b467efd1cf2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:25 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:24 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "David
 Riley" <d.riley@proxmox.com>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 6.12.y 1/3] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
Date: Fri, 30 Oct 2026 10:37:11 +0000
Message-ID: <20261030103713.573783-2-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030103713.573783-1-doebel@amazon.de>
References: <20261030103713.573783-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Paolo Bonzini <pbonzini@redhat.com>

[ Upstream commit bd1c40114b02cf63ba33da8e7df71ed0fc2a3019 ]

The XS/XU bit for EPT are only applied to final accesses, and use the
U bit from the page walk itself.  While strictly speaking not necessary
(any value of PFERR_USER_MASK would be the same for page table accesses,
because they're reads and writes only), it is clearer and less hackish
to only apply MBEC to PFERR_GUEST_FINAL_MASK.  Allow kvm-intel.ko to
distinguish the two cases.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[doebel: load_pdptrs() lives in arch/x86/kvm/regs.c in this tree; keep
this tree's mmu_is_nested() in the Hyper-V hunk]
Stable-dep-of: 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits")
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
---
 arch/x86/kvm/hyperv.c          | 3 ++-
 arch/x86/kvm/mmu/mmu.c         | 3 ++-
 arch/x86/kvm/mmu/paging_tmpl.h | 7 +++++--
 arch/x86/kvm/regs.c            | 3 ++-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 40660da6b7737..8987d8da4baac 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2055,7 +2055,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast && mmu_is_nested(vcpu)) {
-		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa, 0, NULL);
+		hc->ingpa = translate_nested_gpa(vcpu, hc->ingpa,
+					PFERR_GUEST_FINAL_MASK, NULL);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 1a4d5fa11922d..b1baaf5161de5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4136,7 +4136,8 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	if (exception)
 		exception->error_code = 0;
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
+	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
+				 exception);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ce467bc3383c9..9e17ebcc4c318 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -377,7 +377,8 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
 		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
-					     nested_access, &walker->fault);
+					     nested_access | PFERR_GUEST_PAGE_MASK,
+					     &walker->fault);
 
 		/*
 		 * FIXME: This can happen if emulation (for of an INS/OUTS
@@ -445,7 +446,9 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access, &walker->fault);
+	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
+				     access | PFERR_GUEST_FINAL_MASK,
+				     &walker->fault);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 26ee933ef5490..b11e19c729385 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -166,7 +166,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * to an L1 GPA.
 	 */
 	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
-				     PFERR_USER_MASK | PFERR_WRITE_MASK, NULL);
+				     PFERR_USER_MASK | PFERR_WRITE_MASK |
+				     PFERR_GUEST_PAGE_MASK, NULL);
 	if (real_gpa == INVALID_GPA)
 		return 0;
 
-- 
2.50.1

