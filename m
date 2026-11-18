Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009741;
	b=Yi39YOPK0BuQhjQAoqAZjPOoky6YWZBv9lvG8GfYk88FuBfi1OFteO4osm50IqMKr3PJ
	 tACs5unyJEyUoRkY63VjO6VUgS2BQlJsNBY25c+/61EF1xawqJL7juWaVFm/Z21Ki2rtx
	 J9RHlxdhEqCg/jnWJJXmdovORmsfbBE8TMtDB4zGKNIbu3iiXPFxOvrVQSdaN+vywPWoG
	 SgQ4JWkbDOBx3Hs73iJBfjEfbv2aA5sPwhv7q+Q4TOoaKD+xFN4BzLrIs4Ge6mOn12UEA
	 x2y8hOl7gL+E+YuR3akvqFu83VPieXijv1Qd7vSA89/tTptvslahbN09rYAD5lqi2Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009741;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=9JG/HgZdfWiJm1kcLHFQu8u7nS7AdgoqDyWHfJsi2iM=;
	b=CoFW1FyCmUZaG0P4ietyCLM4MefOiPjz/MzdSozv4kbI+XmPYt4bdK9aMfPlxjda1aWQ
	 a+3b5IPnJabXPOsBI+SA3DSfGQ8RIYoaGo7eFpyTF6aE0zsMKRaZE02cUXxTgToFRxu+a
	 1uC1x+LIWtRHGm6xJFbSz4mXRjggSluuUZpav9/aDomYFJGzuJ+PBJoGf0iQe6ZcuKmLc
	 i8dxaC7N+curmfibTDKwxfpFCIIBccyx/qxS4CustGKqRb/0kuk1ADexi0GG9kZgye4A3
	 83kXfbJbCnJzmCrfJP1p+x8jo90Os7PLrjfQCV8Hy8MsJ+RFGS1QxVB+D1oJxSH+i9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=Ze07XzdE;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F726606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F726606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=Ze07XzdE
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id D7CC21017E7;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id BAE2C10144B;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009737; h=from:subject:to:date:message-id;
	bh=D89hnILMeBrbr9kOvzofvFnCnVkIpA6cDtBLokmbOEA=;
	b=Ze07XzdEfpyq69xz/F9YdufSS58T+Uki98LpWxgQw2ebL2SAk09Vuu2iGBJwhxLHuD6N7ZL94r2
	xpC2WXNC+v/wd+Vv3UsECNwkp6Tko3ILrmvtVdeXRUVJ4SrfYsFXda9yYsq1vwHokvoxmqqL1rmWh
	RctNQ9qRgn3SwAa+PN6GWsp0m3kkdtciFEslAUXLfgpINuytNqdouCSmoD8IX0YTl+fEQ2tvaP9P2
	wsGkIM9ZTnIa2rcRtt+biXFyWyYPqS175nJdLUkUSC2odHZNn/hW3CFEdY64/9EjdeqgCqKNIfYce
	qU6N2w1yO0+Gb86GbKswGRDeA5CVyDA1DiWg==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:48:57 +0300
From: Artem Novikov <naa@amicon.ru>
To: <lvc-patches@linuxtesting.org>, <stable@vger.kernel.org>
CC: <pchelkin@ispras.ru>, <rrv@amicon.ru>
Subject: [PATCH 5.10 v6 3/5] KVM: x86/mmu: Retry faults on obsolete shadow roots
Date: Wed, 18 Nov 2026 16:48:48 +0300
Message-ID: <20261118134851.203854-4-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118134851.203854-1-naa@amicon.ru>
References: <20261118134851.203854-1-naa@amicon.ru>
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

