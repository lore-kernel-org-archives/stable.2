Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009741;
	b=CAsdC6iOknJdtZt3AkFybYpDrzqvft5KFGKOxG/Ar9kgWUqol9jfamdPGld+JFl9R6c/
	 e0iOhLEmzAPLr2MJ2w8H/oaTOwRtWRopQ7iUJB109KAWOfB7yueSaJXQRMiLHUfKnExY8
	 ExVIYY0D54qShRpdNpCbPAH9Jfo+gsDAtmG0EonLgzxpt/ky+dH1M/LkD+D0aAsXnHNcI
	 LAH2WU660WWuWHR0vytK9afx191KJcdajY7wtysVPxhjoNQKDzd+fPHww5ktKA8ThTozr
	 cEdcwfc091Ds0qJmqQJ/bQVupI/s5iF0JlBWajONLRXUiR3XaT7zqACnXbzmXB+cOvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009741;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=FenO36YsPKOcHM6a5HIFoe7h0H1FiFANOUGA5BQ2+GQ=;
	b=HcBctUZ5ZZ87V+ohd1tphXccxR8pqdpEIlR075JnpSqUhJ2+C/s0OHjw1Do1/1neukua
	 5nTEY9OZI+zqO9dFNfr7OpdmDo9cJVhSYTM+0XxBq6Hs3ZtJkA/+LezizEXqkWpqZvvnl
	 uBaYwu8HaglYUH5fwB31l16vSBSd+Ostqfo0xdaaS+kSc+0L69tWqhs7HN73awRMfnKCN
	 TtbvTiYiRA+BB6pr3Fd0N9Aj6pGDldVq7QfNYfyAEG12clCFkrg9ygxl2JS9dCwTdajvC
	 AZ4aK2GsD578X25csalO9Y8xjWxqltJVqgnkfNS5SepmwDC7iAqSIFUXO3RMGLLD9Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=DwTiZFzx;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F817606A32C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F817606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=DwTiZFzx
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 036AC10144B;
	Wed, 18 Nov 2026 16:48:58 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id DB822101822;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009737; h=from:subject:to:date:message-id;
	bh=ck9n1FuJmSMm4kEV0/QNeA6bJKS50IbWq69j3buFKGQ=;
	b=DwTiZFzxvwFIeatJQq+oay3sWViMf4xqXJnQ/ENCZyxIKsWO2G925wDaUz9JUiJv3/cEcWm3Kkd
	2i3jWSseW92v5C3fXG5ee6rp0Rco0xpNEQgXHr84Jk6RuuQE8phLJSIKkpFyBl/27avly43MfpA7n
	624+rVGhIuNp9hW1cK0wNQhJCDA9/o6xKDyd1H2dyLJrbVA2vSDB9d9mW1MSxZ3TeUhgEJrqQu5es
	hxhbLu8+5zjY3QZFHeGhI7SC5TVDuZjdoWqa8Bp8g8S+fPhHflJVqw7CGvFX5Wddip5aU14gt3RQ7
	lJffMUMhU8CF/aK8XK0Ykec7MXZBLi/GI8rw==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:48:57 +0300
From: Artem Novikov <naa@amicon.ru>
To: <lvc-patches@linuxtesting.org>, <stable@vger.kernel.org>
CC: <pchelkin@ispras.ru>, <rrv@amicon.ru>
Subject: [PATCH 5.10 v6 4/5] KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
Date: Wed, 18 Nov 2026 16:48:49 +0300
Message-ID: <20261118134851.203854-5-naa@amicon.ru>
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

commit 0cb2af2ea66ad8ff195c156ea690f11216285bdf upstream.

A linked shadow page can have a different GFN from the one expected by
the current walk. Reusing it can leave reverse mappings under a GFN
that the shadow page cannot recover when removing those mappings.

Check the GFN in all three legacy child lookup paths. When a replacement
is ready, zap the old parent SPTE and flush remote TLBs before linking
the replacement. Use the existing zap helper, which also preserves
shadow pages still pinned as roots.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Fixes: 6aa8b732ca01 ("kvm: userspace interface")
Reported-by: Alexander Bulekov <bkov@amazon.com>
Reported-by: Fred Griffoul <fgriffo@amazon.co.uk>
Link: https://lore.kernel.org/r/20260503201029.106481-1-pbonzini@redhat.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Keep the 5.10 shadow walk and large-SPTE handling. Use the legacy GFN
 and role inputs when looking up a replacement.]
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 arch/x86/kvm/mmu/mmu.c         | 39 +++++++++++++++++++++++++++++-----
 arch/x86/kvm/mmu/paging_tmpl.h | 21 +++++++-----------
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7e82b2b33563db89a4020ae0894dd477570e3f72..cace229921ebf625286cbdb8b57ace2c8df71f10 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2178,6 +2178,30 @@ static void shadow_walk_next(struct kvm_shadow_walk_iterator *iterator)
 	__shadow_walk_next(iterator, *iterator->sptep);
 }
 
+/* Return NULL if the linked child can be reused. */
+static struct kvm_mmu_page *
+kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu, struct kvm_shadow_walk_iterator *it,
+		     gfn_t gfn, bool direct, unsigned int access)
+{
+	struct kvm_mmu_page *sp;
+	u64 spte;
+
+	drop_large_spte(vcpu, it->sptep);
+	spte = *it->sptep;
+
+	if (is_shadow_present_pte(spte)) {
+		sp = to_shadow_page(spte & PT64_BASE_ADDR_MASK);
+		if (sp && sp->gfn == gfn)
+			return NULL;
+	}
+
+	return kvm_mmu_get_page(vcpu, gfn, it->addr, it->level - 1,
+				direct, access);
+}
+
+static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
+			    u64 *spte, struct list_head *invalid_list);
+
 static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
 			     struct kvm_mmu_page *sp)
 {
@@ -2185,6 +2209,14 @@ static void link_shadow_page(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != PT_WRITABLE_MASK);
 
+	if (is_shadow_present_pte(*sptep)) {
+		LIST_HEAD(invalid_list);
+
+		mmu_page_zap_pte(vcpu->kvm, sptep_to_sp(sptep), sptep,
+				 &invalid_list);
+		kvm_mmu_remote_flush_or_zap(vcpu->kvm, &invalid_list, true);
+	}
+
 	spte = make_nonleaf_spte(sp->spt, sp_ad_disabled(sp));
 
 	mmu_spte_set(sptep, spte);
@@ -2898,11 +2930,8 @@ static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 		if (it.level == level)
 			break;
 
-		drop_large_spte(vcpu, it.sptep);
-		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
-					      it.level - 1, true, ACC_ALL);
-
+		sp = kvm_mmu_get_child_sp(vcpu, &it, base_gfn, true, ACC_ALL);
+		if (sp) {
 			link_shadow_page(vcpu, it.sptep, sp);
 			if (is_tdp && huge_page_disallowed &&
 			    req_level >= it.level)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0a500ac0e76e220ae484fdc60d1e5112b53abff0..95b5476ab150ff8660cbe0c9c8ead2c073916c3e 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -662,14 +662,11 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		gfn_t table_gfn;
 
 		clear_sp_write_flooding_count(it.sptep);
-		drop_large_spte(vcpu, it.sptep);
-
-		sp = NULL;
-		if (!is_shadow_present_pte(*it.sptep)) {
-			table_gfn = gw->table_gfn[it.level - 2];
-			access = gw->pt_access[it.level - 2];
-			sp = kvm_mmu_get_page(vcpu, table_gfn, addr,
-					      it.level - 1, false, access);
+
+		table_gfn = gw->table_gfn[it.level - 2];
+		access = gw->pt_access[it.level - 2];
+		sp = kvm_mmu_get_child_sp(vcpu, &it, table_gfn, false, access);
+		if (sp) {
 			/*
 			 * A change from a nonpresent to a present GPTE needs no
 			 * guest TLB flush. Sync descendants before linking.
@@ -713,11 +710,9 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 
 		validate_direct_spte(vcpu, it.sptep, direct_access);
 
-		drop_large_spte(vcpu, it.sptep);
-
-		if (!is_shadow_present_pte(*it.sptep)) {
-			sp = kvm_mmu_get_page(vcpu, base_gfn, addr,
-					      it.level - 1, true, direct_access);
+		sp = kvm_mmu_get_child_sp(vcpu, &it, base_gfn, true,
+					  direct_access);
+		if (sp) {
 			link_shadow_page(vcpu, it.sptep, sp);
 			if (huge_page_disallowed && req_level >= it.level)
 				account_huge_nx_page(vcpu->kvm, sp);

