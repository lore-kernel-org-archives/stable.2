Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629602;
	b=BIiSoEUeCDnnoEjrR9QnFw34PSlxC3Opjkrfdxv7jeRy8L1SkRPlHyCuBFG9iHj5KAW5
	 BN51IYsThuP0l9Y3gGxnPq1CiT/8EEa6owZqcOt75CdicWsaY8/910xclED+DwZivqZkp
	 atI626dqKB2RAhqldye/t+rUn4qfVutSCA+s0yhtOlP3UwWKQh9kO97tY7FjYxzKJMTIo
	 wTji1B5E1rxK44qjm1mUGmS2QUJtNzHYHRmhnqRcdT0o/nW3qtkZ5Wazuz7TtXrZQz3wn
	 AmGoHlklMryt6ZUWYNfoADnhjmjULpdxHAE/1LqBBo5Rja907MeWT2e1R3Vqs9MatRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xadpd7RUU6Lvln2PBkrHi+8e2a9864oiK/kaZf9Tvmk=;
	b=bEkJtv5tAl+xl3pHMz0XW7V3I8G/5D/la4fJBxv/swTm2LOtbYgx9CS3uqAA5r/R0kgO
	 cd4U24cXW0hHEi8A/fwhRjr1LPpvF9ywrEql5pbWTlYsB0dnZ7HfkXCsHbMhLvbqKpUgc
	 dQb0SC16YLQq/1nhK9pD22hsWitIQQnzJhQunBi0sf0l3dg8SF99K48FHAoG2si3s+SCn
	 Uk9WYxEeUxzKXFNKw+U+KaPbvHa4DAMsUK/9/DlBYwPb0+LTXWAClV4b293HWEHWOLENE
	 tdPEs1bgKoeoC2SBXOfvi0gUhanoUiUA7/+sGiMSpux0EQxMMA0TWz1AYTciUYMb7iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ87mVgr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B5606A336
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQ87mVgr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068B41F000C5;
	Sat, 14 Nov 2026 04:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629602;
	bh=xadpd7RUU6Lvln2PBkrHi+8e2a9864oiK/kaZf9Tvmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQ87mVgrx6McVtJxrj0xgPIQB+gY4yU3D+0ChJYbRjmh5YahxUB6de+GabuhA7SPS
	 k29IbL+f4WcuY3eZaMqqliLHovIX6VWhlsmewzjO3gtsCRGTvPk6c10a+rxshvYHS3
	 t18upviNonIXrfW8i+OEF9F4u54EFDv/YrEGraA978NkGcTuOZujuux3q6pSyvn6jc
	 B9IGrTbGGoa2cNGnZhQ3ODtW+gWFPSHVoKx5d1g4ZgCSyp/eKVJ3FqLmlEdijGi2oD
	 JYm92GXQJFBCaLjwI7SehVJKtrZhv55RTf9NHZnQdWuCYKMWaJISflepSmPW2VPiWu
	 ymB10Fog7tAEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lai Jiangshan <laijs@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] KVM: X86: Cache CR3 in prev_roots when PCID is disabled
Date: Fri, 13 Nov 2026 23:13:17 -0500
Message-ID: <20261114041301.2801291-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114041301.2801291-1-sashal@kernel.org>
References: <20261109202153-failed-5.15-c7c288d178cb@kernel.org>
 <20261114041301.2801291-1-sashal@kernel.org>
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

From: Lai Jiangshan <laijs@linux.alibaba.com>

[ Upstream commit 509bfe3d979672cd69c318d520420cf95b474fd9 ]

The commit 21823fbda5522 ("KVM: x86: Invalidate all PGDs for the
current PCID on MOV CR3 w/ flush") invalidates all PGDs for the specific
PCID and in the case of PCID is disabled, it includes all PGDs in the
prev_roots and the commit made prev_roots totally unused in this case.

Not using prev_roots fixes a problem when CR4.PCIDE is changed 0 -> 1
before the said commit:

	(CR4.PCIDE=0, CR4.PGE=1; CR3=cr3_a; the page for the guest
	 RIP is global; cr3_b is cached in prev_roots)

	modify page tables under cr3_b
		the shadow root of cr3_b is unsync in kvm
	INVPCID single context
		the guest expects the TLB is clean for PCID=0
	change CR4.PCIDE 0 -> 1
	switch to cr3_b with PCID=0,NOFLUSH=1
		No sync in kvm, cr3_b is still unsync in kvm
	jump to the page that was modified in step 1
		shadow page tables point to the wrong page

It is a very unlikely case, but it shows that stale prev_roots can be
a problem after CR4.PCIDE changes from 0 to 1.  However, to fix this
case, the commit disabled caching CR3 in prev_roots altogether when PCID
is disabled.  Not all CPUs have PCID; especially the PCID support
for AMD CPUs is kind of recent.  To restore the prev_roots optimization
for CR4.PCIDE=0, flush the whole MMU (including all prev_roots) when
CR4.PCIDE changes.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Message-Id: <20211019110154.4091-3-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: c7c288d178cb ("KVM: x86: Unconditionally reset MMU context when emulating INIT")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/x86.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e6bf0fb638abe..77aca3aa1aef3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1086,10 +1086,27 @@ static bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 
 void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned long cr4)
 {
+	/*
+	 * If any role bit is changed, the MMU needs to be reset.
+	 *
+	 * If CR4.PCIDE is changed 1 -> 0, the guest TLB must be flushed.
+	 * If CR4.PCIDE is changed 0 -> 1, there is no need to flush the TLB
+	 * according to the SDM; however, stale prev_roots could be reused
+	 * incorrectly in the future after a MOV to CR3 with NOFLUSH=1, so we
+	 * free them all.  KVM_REQ_MMU_RELOAD is fit for the both cases; it
+	 * is slow, but changing CR4.PCIDE is a rare case.
+	 *
+	 * If CR4.PGE is changed, the guest TLB must be flushed.
+	 *
+	 * Note: resetting MMU is a superset of KVM_REQ_MMU_RELOAD and
+	 * KVM_REQ_MMU_RELOAD is a superset of KVM_REQ_TLB_FLUSH_GUEST, hence
+	 * the usage of "else if".
+	 */
 	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
-	else if (((cr4 ^ old_cr4) & X86_CR4_PGE) ||
-		 (!(cr4 & X86_CR4_PCIDE) && (old_cr4 & X86_CR4_PCIDE)))
+	else if ((cr4 ^ old_cr4) & X86_CR4_PCIDE)
+		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
+	else if ((cr4 ^ old_cr4) & X86_CR4_PGE)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_post_set_cr4);
@@ -1159,6 +1176,14 @@ static void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 	}
 
+	/*
+	 * If PCID is disabled, there is no need to free prev_roots even if the
+	 * PCIDs for them are also 0, because MOV to CR3 always flushes the TLB
+	 * with PCIDE=0.
+	 */
+	if (!kvm_read_cr4_bits(vcpu, X86_CR4_PCIDE))
+		return;
+
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 		if (kvm_get_pcid(vcpu, mmu->prev_roots[i].pgd) == pcid)
 			roots_to_free |= KVM_MMU_ROOT_PREVIOUS(i);
-- 
2.53.0

