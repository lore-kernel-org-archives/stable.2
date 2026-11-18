Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002174;
	b=r+TWXFCuHdws+DXZ5uAnsSerYSWYDlH6DpAWjS+zQo2G9STarpO7KY4pB560WcnCp4ZU
	 pctTvy6NueLcyZf7Ivbe+UjROU6JpoM0PM1ooTbFeecrPRh3jenD39CwW6zysKHaRUQqO
	 gQtNT2M5RcnUH034ENiorH54afXPey3Xr5hArb7Nf3wdW3XUakdUbX90P46dMop7/gZWO
	 w83kQkvMkYTITpBqFixtDpLNwhWpqBOZuubQNqXUyEth0cy4lWKRGRnERhcBt35Lh4jNB
	 Lk/m1h4UOARrE/6DS51eEpuu4WsOJNKsqKunLx7CXVELMDRKj2WKFJ1bdJb5lSdDW0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002174;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=Xm1Qx58C3kdSvPTHXTBR7DDjRva6ecK+vC6rOyxx47c=;
	b=OHe1jCzD4DqMyYULYH2S0EzKbdgSridfblxvq0QHRvVwB9ce30ofn/vgbWbFds+5BNvG
	 62gOPELRvyZB9Lg9B8+LPAObYC2LA3fepZgjNFlioOQ47eR85rjN73vJMx2zY73mcoMF/
	 zVbMXqyMfPBurTiofcS4zyFesj3ZuomONfljuggGQ+t4UwHkedCFKpu7O/jdxxcFRn1QQ
	 6QL7WsY2cNuN5ERMSSg1qS8B2Nmi0K+pF5G3mKGUywepCxz+xSBNYehtLG10c0ELPaMO6
	 ct1D/KLJGlpsFTr8ItpcYL3Za/y8GKRWMZT0sLkXi+sLUHtzSdQDFyZcaPT8IwW1Qmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=f+gQxhXo;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (mail.amicon.ru [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D23606A31C;
	Wed, 18 Nov 2026 11:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55D23606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=f+gQxhXo
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id EAF44101822;
	Wed, 18 Nov 2026 14:42:46 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id CB4C81017DA;
	Wed, 18 Nov 2026 14:42:46 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795002166; h=from:subject:to:date:message-id;
	bh=bbyA87p3vE/FUl1iLmQDrgsU4+px9vVUerDXviDtydo=;
	b=f+gQxhXoeU12wfF7GYjqT9VLlBQufIWfFlxUCrtI/hu/E8FHaSHnMNoJz4tSwmdtEN3mjqdnm9u
	StCRBFyLqbirFgd/aTM0V08Qfopgm3Mc8EmMvDvor/6UxyYwGfUHLNggnWB2T2k5Sfr+NvVY87aPP
	Ky57yRqdxWnuVXtcb1oP0pMwNZysS+urSkv6ymQLENerGQnROEtVF9yOf9Xmytxp+2r8jq4VF21/v
	mhm791FPO7yEgMGdE8NTgsl1kGsar/l00KPYEjvJL0Te7qRXEVapJEBdT05Qf4a7YpJ7dQqNHd6Dn
	Yw9BXS5UEF7SaQNxHTxMSqtujVKCqTsBn20g==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 14:42:46 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>
Subject: [PATCH 5.10 1/5] KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
Date: Wed, 18 Nov 2026 14:42:22 +0300
Message-ID: <20261118114226.26178-2-naa@amicon.ru>
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

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit f81602958c115fc7c87b985f71574042a20ff858 upstream.

A leaf mapping removed by sync_page() can still be writable in a remote
vCPU's TLB. Request an immediate remote flush when synchronization
drops a mapping, so subsequent write protection can rely on the rmap.

Fixes: a4ee1ca4a36e ("KVM: MMU: delay flush all tlbs on sync_page path")
Link: https://lore.kernel.org/r/20210918005636.3675-2-jiangshanlai@gmail.com
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c6daeeff1d9c9d958e08375c8baaedc295f7069f..1500fc877aece64fc9e0f013554ae8ecff99882e 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -1007,14 +1007,6 @@ static gpa_t FNAME(gva_to_gpa_nested)(struct kvm_vcpu *vcpu, gpa_t vaddr,
  * Using the cached information from sp->gfns is safe because:
  * - The spte has a reference to the struct page, so the pfn for a given gfn
  *   can't change unless all sptes pointing to it are nuked first.
- *
- * Note:
- *   We should flush all tlbs if spte is dropped even though guest is
- *   responsible for it. Since if we don't, kvm_mmu_notifier_invalidate_page
- *   and kvm_mmu_notifier_invalidate_range_start detect the mapping page isn't
- *   used by guest then tlbs are not flushed, so guest is allowed to access the
- *   freed pages.
- *   And we increase kvm->tlbs_dirty to delay tlbs flush in this case.
  */
 static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 {
@@ -1044,13 +1036,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 			return 0;
 
 		if (FNAME(prefetch_invalid_gpte)(vcpu, sp, &sp->spt[i], gpte)) {
-			/*
-			 * Update spte before increasing tlbs_dirty to make
-			 * sure no tlb flush is lost after spte is zapped; see
-			 * the comments in kvm_flush_remote_tlbs().
-			 */
-			smp_wmb();
-			vcpu->kvm->tlbs_dirty++;
+			set_spte_ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
 			continue;
 		}
 
@@ -1065,12 +1051,7 @@ static int FNAME(sync_page)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
 
 		if (gfn != sp->gfns[i]) {
 			drop_spte(vcpu->kvm, &sp->spt[i]);
-			/*
-			 * The same as above where we are doing
-			 * prefetch_invalid_gpte().
-			 */
-			smp_wmb();
-			vcpu->kvm->tlbs_dirty++;
+			set_spte_ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
 			continue;
 		}
 

