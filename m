Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706278;
	b=1e6HsF0CmZTKe5dhMMb6feZ4Mxqhj9/JNVG3TdQgqEmlmRJQp5z+Jmnoe/cOEnEQi94u
	 ETBgMBoDDB2U9L10ASUykflqh9kt9mkv13ij5xJr1fYujl75zR6T/Z7b4rQnEF9xbYWQv
	 FWI9emokSAUBq4aAQhmZuOkkGdc9Erjm+n2oUMrEs7CVMfYpq85aIHlCWFYTwN/H1aNjW
	 tvSyYmOhtmWsDXPkAB16nifnqcBx3vquQzX21EBCMEJIJ/B4P7XWXe9SrcQZ77suTxk5c
	 IvZqm4BSYQob8xLbKrQp3UV9YThzc48f2REIg6wctwdyiRZvb823FpL7tukGuRayikw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RqFmeSuXfKwzh6ahVFLLnCY13TcsmgSS8+wDHQOoqJ0=;
	b=gcyEoU3wZRuU1OjLrBMRd2qZIypbjfmC/0o5oPH66nMtoMbpjriL6L27S8TLK41NkoAe
	 i/USpEzXvDuCHNzcjilHT/kIWoVk0ON0t0Xwe2dGX2nRtmN6cZye2iUk82TWwmlMSp0lK
	 eaicRuVaPlBHC2CfffM6Dj1leCA8ZBi+LfDm2eS7l/KCSIl9fZYOG7LA9NxOFdirzg2GV
	 AKG3qKx//GfoLGaDuoP0JLN/KPKX4C/nD1RBZWaL7u5wS9nQus4MQI4p2wDhUQeO6lzKp
	 44n3jDNEy0Kfr/vwcaqB9t+PewcnOOmtUPlzjkv8J3C8Bd5NCoV95SbRFFrtZAB4qUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--ardb.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jJE4k9Rx;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8F606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D8F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jJE4k9Rx
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4afef353dd2so27613265e9.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 03:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793706277; x=1794311077; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RqFmeSuXfKwzh6ahVFLLnCY13TcsmgSS8+wDHQOoqJ0=;
        b=jJE4k9RxS5Kev1g0QAoBvBSES2eXInhd3y27I8RDgIkT68kW6bGn+9ewRqE0YWIr8Y
         2XQMdX4j1JXkzjaTG+4ZOhgGLo+77HV/YYhcvKI+JpIbcXu1DE0wUxrtPopEouqwihRE
         uFR7uMHiyMbNu0gbUGqB0g0+SXdqMdX1TJazXoWxxrPrjQXC6mgnps/60DaiVXCaxIYy
         XbZBwab7MEb+hfo/WBPs/eUr9rGgIutHlQ5N37x04wKOhk7kv9fW5J47FeyVHsTGfvoq
         TIjM4GlSsLozlSbE8frG4zRz33iEcnc2u4Jn2Ww4EJpv4dxFf/unwdhHWcRTLWsLI4YV
         zZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706277; x=1794311077;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqFmeSuXfKwzh6ahVFLLnCY13TcsmgSS8+wDHQOoqJ0=;
        b=keeGAYumyoYmzolqBQr3C1EHT8GqdStCTA//3evRJHNWVirB5G+DRDQx9BBz3JqE1c
         oVSOSf3BKk0ywVS7245BypDD18HhdY0zYh/s7hH43Kgf7j4+pEy+fngW5SFyzBiytFLO
         1XD+mTwVDb96pn2qpzRWHQ+3MgrCoEMrFsmomhvdyB2Pn7us7ISGOZeqKfSpDeyw2vKV
         57SI3UF47u9N0qE7MGXVVVUSDmv65U2G2j/WgMPTBSptg3bL2qqDbmmjBfUHhsHyBtjB
         KB+AbZ8xEWFKK0FtednuDIiptSHBZfOjAxYGhRSpMQh/ccPVHgOzt/CyvMY/8Cq7ibLq
         fRlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWGwCj+hxzgp1uI04YuZ8HE0BoTL674ipzno2O/spk1K6RaPPletWl79OolnMP25LWcOASw1Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bGNB2w+GOsw+wvG0u8UAR/faz6EXNh2QClOr5sgafqH0KdZBF
	UmdcRTfEDiOGwivlO16SfBC77+ytkyIT3XQ9XAdtyR/2VcqOaBTLDBE2kDSE0YSjslGJOAOs7g=
	=
X-Received: from wmgg21.prod.google.com ([2002:a05:600d:15:b0:4a2:11fa:1981])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:870f:b0:4a2:1196:db0e
 with SMTP id 5b1f17b1804b1-4ac1899348bmr268213665e9.30.1793706276582; Tue, 03
 Nov 2026 03:44:36 -0800 (PST)
Date: Tue,  3 Nov 2026 12:44:12 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103114411.3642140-2-ardb+git@google.com>
Subject: [PATCH v2] KVM: arm64: Don't livelock when AT can't resolve a fault IPA
From: Ard Biesheuvel <ardb+git@google.com>
To: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, Fuad Tabba <fuad.tabba@linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

When a stage-2 permission fault doesn't report its IPA in HPFAR_EL2,
__get_fault_info() recovers it with an AT S1E1R/S1E1A on FAR_EL2. If that
fails, kvm_hyp_handle_memory_fault() goes straight back to the guest, on
the assumption that the replayed access will either succeed or take a
fault that the slow path can handle.

That assumption doesn't hold when the AT fails because its stage-1 walk
takes a stage-2 fault on one of the guest's page-table pages, while the
guest still holds a cached translation for the faulting VA. The guest
doesn't walk its page tables, so it never takes the S1PTW fault that
would let the slow path fix things up. It takes the same permission fault
again, the AT fails again, and the vCPU livelocks in the world switch.

This was observed on Apple M2, which has no hardware Access flag
management at stage 2, and no DIC, so execute permission is granted
lazily and the first instruction fetch from a page takes a permission
fault. With DAMON_STAT enabled (CONFIG_DAMON_STAT_ENABLED_DEFAULT=y),
kdamond keeps sampling guest memory, and damon_pmdp_mkold() ages a whole
PMD at a time through mmu_notifier_clear_young(). With THP-backed guest
memory, kvm_age_gfn() therefore clears the stage-2 AF of 32MB of guest
pages at once, without TLB invalidation. When that covers both freshly
loaded code and the page-table page that maps it, the first instruction
fetch from that code livelocks, and the vCPU only ever recovers when its
thread happens to be moved to another CPU. In all 52 instrumented
occurrences, the AT reported a stage-2 Access flag fault on a stage-1
table walk (PAR_EL1.{S,PTW} = {1,1}, FST = Access flag fault, level 3),
while an AT S12E1R on the same VA succeeded. With DAMON_STAT disabled,
the AT didn't fail once in 210 boots. Nothing in this is specific to
nested virtualisation, nor to instruction fetches: a write to a
read-only memslot hit it too.

A stage-1 fault can lead to the same livelock. A guest that ages its own
page tables without invalidating the TLB, as MGLRU does through
ptep_test_and_clear_young(), can keep using a cached translation while
the descriptor in memory has its Access flag clear. If such an access
takes a stage-2 permission fault (lazy execute permission, or dirty
logging), the AT reports a stage-1 Access flag fault (PAR_EL1.S = 0),
which the guest never takes either, as it doesn't walk its page tables.
This hasn't been observed, but it is why the invalidation below is done
whenever the AT fails, rather than only when PAR_EL1.PTW reports a
stage-2 fault on the walk. A guest that merely races with its own
page-table updates isn't harmed by it: at worst, it takes a translation
fault that it was allowed to take anyway.

Invalidate this VMID's TLB entries on the local CPU before replaying the
access, so that the guest has to walk its page tables and takes the
fault that the AT ran into: either a stage-2 fault on the page-table
page, with a valid HPFAR_EL2, which the slow path resolves, or a stage-1
fault, which the guest resolves itself. In all instrumented cases, the
next exit was an S1PTW Access flag fault on the page-table page. This
only happens when the AT fails, so the cost is negligible.

With this change, an EL2 UEFI guest that livelocked in 27 out of 210
boots didn't hang once in 420 boots.

Cc: <stable@vger.kernel.org>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Tested-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: add DSB before TLBI so that it cannot be issued speculatively before
    the AT even runs

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Zenghui Yu <yuzenghui@huawei.com>

 arch/arm64/kvm/hyp/include/hyp/switch.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index e0c55644224c..6b2ca89e8326 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -843,8 +843,22 @@ static inline bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 static inline bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu,
 					       u64 *exit_code)
 {
-	if (!__populate_fault_info(vcpu))
+	if (!__populate_fault_info(vcpu)) {
+		/*
+		 * The AT couldn't resolve the IPA, typically because its
+		 * stage-1 walk took a stage-2 fault, such as an Access flag
+		 * fault on an aged page-table page. If the guest still has a
+		 * cached translation for the VA, it won't take that fault
+		 * itself, and would replay the same permission fault forever.
+		 * Drop this VMID's TLB entries on this CPU, so that the replay
+		 * walks the page tables and faults with a valid HPFAR_EL2.
+		 */
+		dsb(nsh); /* ensure that AT completed before issuing the TLBI */
+		__tlbi(vmalls12e1);
+		dsb(nsh);
+		isb();
 		return true;
+	}
 
 	return false;
 }
-- 
2.56.0.385.gac671c819a-goog

