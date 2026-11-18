Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002172;
	b=Jx8SJ9ZcP/av2eYRaJGz+bvKJedzDg66Y6w7EVz7R+Mg23RVvrQ3WCJfNmnyopI7uWjh
	 LMJG4r2pm59O6gQRaysqbymJbL6UTzqrw9/6ku41xhsov/BxenauMtzGCqZ5uORYLcYxt
	 mI8D/d+pSDDEiWlJAV1axgynEwRH6RW09P3FPZk9xsNaxcOkpEp36T71fSlZhvi3cTOdF
	 JTjdD1ekH9zGNDqD0p4L1JRFszAErwghKhaPmsZ5pxPYTTeEa5zdXUyNVbnFGYpN9qohP
	 /3Vn1KDHevd/9RkkIolIEhywRFDOhG/YsKiWaupT68mLqyyV8v3vtub/XtHhRlsAcbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002172;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=9JG/HgZdfWiJm1kcLHFQu8u7nS7AdgoqDyWHfJsi2iM=;
	b=VzSB7EquhBxdQCOTEiU5JiCdn0GrLR4/tossrNSCXH0k1eXqvOyf2kHjdTlwYJDwv10X
	 4cYEMu6OhPkHdFADqVuaypGoF4kRefwAxa4lr8Lu8F7IBHIXwXQ3R5wWf4i+CRllUZ16c
	 nJMQBaWufU5TCdLJAe9kr00JVmOr97UZfMhvvoKyodjumFhiQHZjVipDdVFJDq+ROXDMk
	 eD+S0edronzV+ANvlJTmClE5H0cZBmHZX52gMX4Ns1r9DNyEXox3wwvbF6Ma8jOHEGB3k
	 J/TQGBklcOLoZquQlktqKqwGrC8kpQKFjapy9+XM3GnMFFNjjBdTczZdrYdjvMMvmLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=cfATHzrQ;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0E606A320;
	Wed, 18 Nov 2026 11:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DD0E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=cfATHzrQ
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 0ACE6101843;
	Wed, 18 Nov 2026 14:42:49 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id DF3DE1017DA;
	Wed, 18 Nov 2026 14:42:48 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795002168; h=from:subject:to:date:message-id;
	bh=D89hnILMeBrbr9kOvzofvFnCnVkIpA6cDtBLokmbOEA=;
	b=cfATHzrQLiA6CVotG6AiooaLNa1ixqcxy8fa1C7+XxBWyVdezxz6cMGZoDpV1bi8xWjnofUHfYe
	tDP9uua4vfgAWaHsfvYcw8tcYvPnXSdT7FK3mpmEVGxDf7d2VVDT/Q6VOv7fPyct6I+9GFOM8XbtI
	v/VBSa9b9eqJvIZdYf4SNgpYM7vdbrjtQWjmp3d0Js86vNcZXWldd7+B24/OmpPgXaGz7P6X6I6CR
	stdWVoRLDYHn2RRhVbdVUmpPnd+KBrk5sIyqSbR7XoMPoActNsNs59IBgHCZHsxN7lAfplmYdUJG3
	inuSRbBvI+sz1PoZKz4goOtBuS82AyC+Zf/w==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 14:42:48 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>
Subject: [PATCH 5.10 3/5] KVM: x86/mmu: Retry faults on obsolete shadow roots
Date: Wed, 18 Nov 2026 14:42:24 +0300
Message-ID: <20261118114226.26178-4-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118114226.26178-1-naa@amicon.ru>
References: <20261118114226.26178-1-naa@amicon.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Sean Christopherson <seanjc@google.com>

commit a955cad84cdaffa282b3cf8f5ce69e9e5655e585 upstream.

Retry before walking a shadow root that was invalidated during fault
handling. Check under mmu_lock after reclaim has finished and fall
back to the MMU reload request for synthetic roots.

Carry the follow-ups 18c841e1f411 ("KVM: x86: Retry page fault if MMU
reload is pending and root has no sp") and 2abd5287f083 ("KVM: x86:
Check for invalid/obsolete root *after* making MMU pages available").

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Check at the legacy walk entry points. The separate 5.10 TDP MMU
 uses its own root validity handling.]
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 arch/x86/kvm/mmu/mmu.c         | 14 +++++++++++++-
 arch/x86/kvm/mmu/paging_tmpl.h |  3 ++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9e711d0fa02cc972a817aef05a92253d04f8648a..7e82b2b33563db89a4020ae0894dd477570e3f72 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2852,6 +2852,17 @@ void disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
 	}
 }
 
+static bool is_stale_shadow_root(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu_page *sp = to_shadow_page(vcpu->arch.mmu->root_hpa);
+
+	if (sp)
+		return is_obsolete_sp(vcpu->kvm, sp);
+
+	/* Synthetic roots such as pae_root have no shadow page. */
+	return kvm_test_request(KVM_REQ_MMU_RELOAD, vcpu);
+}
+
 static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 			int map_writable, int max_level, kvm_pfn_t pfn,
 			bool prefault, bool is_tdp)
@@ -2866,7 +2877,8 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	gfn_t base_gfn = gfn;
 
-	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
+	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)) ||
+	    is_stale_shadow_root(vcpu))
 		return RET_PF_RETRY;
 
 	level = kvm_mmu_hugepage_adjust(vcpu, gfn, max_level, &pfn,
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index d9ab3a855a859bda1fd15f932db2eedf96f21953..0a500ac0e76e220ae484fdc60d1e5112b53abff0 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -652,7 +652,8 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 	if (FNAME(gpte_changed)(vcpu, gw, top_level))
 		goto out_gpte_changed;
 
-	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)))
+	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root_hpa)) ||
+	    is_stale_shadow_root(vcpu))
 		goto out_gpte_changed;
 
 	for (shadow_walk_init(&it, vcpu, addr);

