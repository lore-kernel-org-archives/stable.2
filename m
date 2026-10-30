Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.83.148.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356625;
	b=zFQDwZeH2M5IJl+WleON3GYKjaXhJ2B7LtNd5KPm5TW7D5wIOwHLcvFrVp7wOvkZDtwr
	 SkQV4mThZ57xQ0Q0e0IJ+DxdludXMpkuUuB51O2baVYWUUyz2AO8lU4sw1w6I2Qusotu3
	 CKP7QNVNQoceIpw0yheqZLB8an5pmZfi4tE0YgYGWe56f36KF1Lo0I9km1O/bGgLS7IqV
	 6kbJPl8b7kzNhKLNW8KsKfjzk1H2M4a1Nw0tgASStzSKw92XwcsPSEuRhoqgqLZzCyC5X
	 iwyImKxRcIHCmGhmivv2V+WaTl4gZJ1++eTEj1ZhxuTYyme8EGh7xO4aU7y+FQEdgCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356625;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=B1wilA/ldWMO2WULW6H9wCWhSo6nF4UWvT2JvzEiIsc=;
	b=XzE45f/xuCrFcj2w3Jo10txOjO7w98eOkhLKwTgVbDFd2nOaV5gaH2QmheoAQdqQ5+b1
	 iGvtvt/lkf89dECWFBq2o801aCDT1ttMoFM+R/NIDQGXdkLaAPBh4K/Vkz3REtDQlTtYt
	 mjMjuYWcAVqCPZiBm9TsEv/3gDiOsZpopGfFeWjFyLmu2v18B6tJwUaMCMmJOhLQvHt+s
	 ce+6EhSdJtcfRgAF1hAm3XIvZGLAY0igXo88Yekivq8KYHhgWo+Lq6SJnQsKcCDrhoLe5
	 3Ci5RnDjQ7E4/lLLymaho7EolGiCZZ7vnGo/5b7w+guNymtLMf9hdnG4XySw/hpl+7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=sS2R24yH;
	arc=none smtp.remote-ip=35.83.148.184
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E24606A326;
	Fri, 30 Oct 2026 10:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8E24606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=sS2R24yH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793356624; x=1824892624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B1wilA/ldWMO2WULW6H9wCWhSo6nF4UWvT2JvzEiIsc=;
  b=sS2R24yH6GSSmSFWqgBxeF0xQgaEzCaba2zucreB/JL/dtqdNY+y6z5V
   TGxLUNUPL4ymnWeZVU0FiyYWVDjbFcEJIdyJfNlp45hO3kMzbzcGhO4Ff
   zT8YjRZy9N272Lc4kKwf6oJxGdBdpF5dL1V4pUwZTjbkL+K+ayrGHXIbZ
   K/5xTtYuWL4VGGAkksLfpKL6nGi3Jm9gqgv8Tjz0WKN8680Muf5rlgpym
   Pllz3U8lnP/bpwZ1vSJASjp5RHoKnhx9HFeL7Z/iBJFCQN9NxjiTIh1y/
   zZNJna5ZKMPxmw/y/3wM7FyZrVXngkKNv9XzfI/ymC8LrGFxmnmqR/YBP
   g==;
X-CSE-ConnectionGUID: doWah6zvRTOy9ZAbLIHCEg==
X-CSE-MsgGUID: ilTuR2lbRampeTwVwRFD9Q==
X-IronPort-AV: E=Sophos;i="6.27,186,1787011200"; 
   d="scan'208";a="32449757"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 10:37:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:6738]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.65:2525] with esmtp (Farcaster)
 id a77c8792-5c46-4f02-b180-de064c430f4f; Fri, 30 Oct 2026 10:37:04 +0000 (UTC)
X-Farcaster-Flow-ID: a77c8792-5c46-4f02-b180-de064c430f4f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:03 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 30 Oct 2026 10:37:02 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: <stable@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <kvm@vger.kernel.org>, "David
 Riley" <d.riley@proxmox.com>, Bjoern Doebel <doebel@amazon.de>
Subject: [PATCH 6.18.y 1/3] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
Date: Fri, 30 Oct 2026 10:36:41 +0000
Message-ID: <20261030103643.573356-2-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261030103643.573356-1-doebel@amazon.de>
References: <20261030103643.573356-1-doebel@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
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
index 56325ba9ef367..284adaf508688 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2056,7 +2056,8 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
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
index 66e18702e5a35..9c9d7b53c7292 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4348,7 +4348,8 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 {
 	if (exception)
 		exception->error_code = 0;
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access, exception);
+	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
+				 exception);
 }
 
 static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool direct)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 6e2ce54a13b31..bae9c781a301f 100644
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
index 7b997c4e6329f..d19a9e7e41f37 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -122,7 +122,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
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

