Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365007;
	b=f4OL4Z6Gmz6tzqZceNi8q/TiWH3asSGj8nCh/jOrS2sf2+a2lnfFKuwMHI/1YV9uRtGt
	 jTzCODQScgLvZWhhGzj4VI0QDR4LxfdhX7smhgoD3cMbpohcD7QczDoNAbh6qnQ5oIwa3
	 yQRMy+4IEseiMmCWwndbSZIwMg7RxUOWxeSwgiZMq9WfXADQyWs3EYgKI28PHy1D5V17I
	 wjOwsTAmzELjFdKhjJgObMy2NUjkM8RwrFUIKGJXWL3EV5NFM6OZasN1tpRyOdBZOMOEq
	 2DkTTZiao4vOTddeGLZJgIkhXaH77lYOMOfpYWNd3YxLffZHSMVrVOMVvYMm4H+RLnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365007;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BL9/shUs4sNyTekNHUdOeGAmciAnxWgHpV9vI7+dPj0=;
	b=w/wXxw7YXi+2bGIzNibPB/ZXD9OnJh+OUiFa57Vs8untxsFABmOiQS/e1HDBRolACslS
	 W4x6cdmmOPY1u7KyqQo0LOnpvAjWlCwkBF9dL8Ds4CT1K2Uz+mNfZ921GoaoKe++Ou99v
	 Y/zPPrOp3VQe02aKBt9E29Ko7SgdlURnP1u8M75ftaHYf0qehDK2w0w6rmQ4P1sltllMa
	 WIL4R1op09D243NX7QQjefJNth9F0QeqJjz0qKQwuKY+Khpn/IOPS0ljFbeg5EfAjip+f
	 mtu6bEmOHC8DEHR/MT8LMCDK+6UQWO+HLQQScZvAkGNFUiRMfp5qNR4HKmVPnxoqEjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsGT+llp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7B606A331
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsGT+llp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909631F00A06;
	Wed, 11 Nov 2026 02:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365007;
	bh=BL9/shUs4sNyTekNHUdOeGAmciAnxWgHpV9vI7+dPj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsGT+llp5wY0lmmDSNbaraw2z9SjR/SgfmjFVBszrszA+0U88WYB3KYGVO3erREh8
	 DOqcwDKNvThg0bVo5b8L+j1Zr6QnBF6qqMziIG5pnA0wyB39ba3bnhveGUU6cl1NoH
	 GGmA0U+KgyEEjgQAC67iSPuyxruvAh3+dEydZCObNiV4N55IUI5aJVF+wJt1zqJFu7
	 utsfkPNBb6sCIn41y0wK+acuSiMesb4/jfjvYOtdSwSIYHxSfx6jMYcf94s46/Lo12
	 4Y/pg0MDyWgarKC0F2cTnwTSAwzXGXYowu2VfQrwBC4yU9VH4/UqrBIukr9KG27ziQ
	 KGC78IrkJbbhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] KVM: s390: Refactor kvm_is_error_gpa() into kvm_is_gpa_in_memslot()
Date: Tue, 10 Nov 2026 21:43:22 -0500
Message-ID: <20261111024039.676658-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111024039.676658-1-sashal@kernel.org>
References: <20261107052838-failed-6.6-eacdb76c5f04@kernel.org>
 <20261111024039.676658-1-sashal@kernel.org>
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

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 9e7325acb3dc8df8a6370ebc18aef107aae17ef0 ]

Rename kvm_is_error_gpa() to kvm_is_gpa_in_memslot() and invert the
polarity accordingly in order to (a) free up kvm_is_error_gpa() to match
with kvm_is_error_{hva,page}(), and (b) to make it more obvious that the
helper is doing a memslot lookup, i.e. not simply checking for INVALID_GPA.

No functional change intended.

Link: https://lore.kernel.org/r/20240215152916.1158-9-paul@xen.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Stable-dep-of: eacdb76c5f04 ("KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/diag.c     |  2 +-
 arch/s390/kvm/gaccess.c  | 14 +++++++-------
 arch/s390/kvm/kvm-s390.c |  4 ++--
 arch/s390/kvm/priv.c     |  4 ++--
 arch/s390/kvm/sigp.c     |  2 +-
 include/linux/kvm_host.h |  4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 2cc3ec034046c..74f73141f9b96 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -102,7 +102,7 @@ static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
 		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
 			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-		if (kvm_is_error_gpa(vcpu->kvm, parm.token_addr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, parm.token_addr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		vcpu->arch.pfault_token = parm.token_addr;
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 969a5e1569192..12dd833952f68 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -681,7 +681,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_REGION1:	{
 		union region1_table_entry rfte;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &rfte.val))
 			return -EFAULT;
@@ -699,7 +699,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_REGION2: {
 		union region2_table_entry rste;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &rste.val))
 			return -EFAULT;
@@ -717,7 +717,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_REGION3: {
 		union region3_table_entry rtte;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &rtte.val))
 			return -EFAULT;
@@ -745,7 +745,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 	case ASCE_TYPE_SEGMENT: {
 		union segment_table_entry ste;
 
-		if (kvm_is_error_gpa(vcpu->kvm, ptr))
+		if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 			return PGM_ADDRESSING;
 		if (deref_table(vcpu->kvm, ptr, &ste.val))
 			return -EFAULT;
@@ -765,7 +765,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		ptr = ste.fc0.pto * (PAGE_SIZE / 2) + vaddr.px * 8;
 	}
 	}
-	if (kvm_is_error_gpa(vcpu->kvm, ptr))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, ptr))
 		return PGM_ADDRESSING;
 	if (deref_table(vcpu->kvm, ptr, &pte.val))
 		return -EFAULT;
@@ -787,7 +787,7 @@ static unsigned long guest_translate(struct kvm_vcpu *vcpu, unsigned long gva,
 		*prot = PROT_TYPE_IEP;
 		return PGM_PROTECTION;
 	}
-	if (kvm_is_error_gpa(vcpu->kvm, raddr.addr))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, raddr.addr))
 		return PGM_ADDRESSING;
 	*gpa = raddr.addr;
 	return 0;
@@ -974,7 +974,7 @@ static int guest_range_to_gpas(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
 				return rc;
 		} else {
 			gpa = kvm_s390_real_to_abs(vcpu, ga);
-			if (kvm_is_error_gpa(vcpu->kvm, gpa)) {
+			if (!kvm_is_gpa_in_memslot(vcpu->kvm, gpa)) {
 				rc = PGM_ADDRESSING;
 				prot = PROT_TYPE_DUMMY;
 			}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c0d8c59bb2cb1..827857f90d441 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2878,7 +2878,7 @@ static int kvm_s390_vm_mem_op_abs(struct kvm *kvm, struct kvm_s390_mem_op *mop)
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 
-	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
+	if (!kvm_is_gpa_in_memslot(kvm, mop->gaddr)) {
 		r = PGM_ADDRESSING;
 		goto out_unlock;
 	}
@@ -2940,7 +2940,7 @@ static int kvm_s390_vm_mem_op_cmpxchg(struct kvm *kvm, struct kvm_s390_mem_op *m
 
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 
-	if (kvm_is_error_gpa(kvm, mop->gaddr)) {
+	if (!kvm_is_gpa_in_memslot(kvm, mop->gaddr)) {
 		r = PGM_ADDRESSING;
 		goto out_unlock;
 	}
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index e5b220e686b09..298ae2bc0e1c2 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -149,7 +149,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	 * first page, since address is 8k aligned and memory pieces are always
 	 * at least 1MB aligned and have at least a size of 1MB.
 	 */
-	if (kvm_is_error_gpa(vcpu->kvm, address))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, address))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	kvm_s390_set_prefix(vcpu, address);
@@ -464,7 +464,7 @@ static int handle_test_block(struct kvm_vcpu *vcpu)
 		return kvm_s390_inject_prog_irq(vcpu, &vcpu->arch.pgm);
 	addr = kvm_s390_real_to_abs(vcpu, addr);
 
-	if (kvm_is_error_gpa(vcpu->kvm, addr))
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, addr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 	/*
 	 * We don't expect errors on modern systems, and do not care
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index d9696b5300647..55c34cb354281 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -172,7 +172,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 	 * first page, since address is 8k aligned and memory pieces are always
 	 * at least 1MB aligned and have at least a size of 1MB.
 	 */
-	if (kvm_is_error_gpa(vcpu->kvm, irq.u.prefix.address)) {
+	if (!kvm_is_gpa_in_memslot(vcpu->kvm, irq.u.prefix.address)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INVALID_PARAMETER;
 		return SIGP_CC_STATUS_STORED;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 17ff73f1b684b..0ec67217803cd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1772,11 +1772,11 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
 
-static inline bool kvm_is_error_gpa(struct kvm *kvm, gpa_t gpa)
+static inline bool kvm_is_gpa_in_memslot(struct kvm *kvm, gpa_t gpa)
 {
 	unsigned long hva = gfn_to_hva(kvm, gpa_to_gfn(gpa));
 
-	return kvm_is_error_hva(hva);
+	return !kvm_is_error_hva(hva);
 }
 
 enum kvm_stat_kind {
-- 
2.53.0

