Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009741;
	b=zM9uKAL6sJyoMQeEMlnSlzxYF1NgHmDwmu2T5Cn5NUEgMnMwP8R1w6ZJM+ad/DCwCxgQ
	 FSDgj76y0eu5jmRHz3dWUt+1x5mvOilOOrzVfi4CJuvyIHPhLA3yZUCtGFTCpb4m5AwfI
	 waZ/1QO1ppL+mMFLgfVc04XPrlIjpHp2QqocIWVf+z2OV0bCfh1+Q1hAAp/4N3Yj1M19t
	 X0po3idc6qpkQLq22omlYvxl18OlnS6c5hqWoiE/z3VNTQtWzeyT0tb8WeJjjWpSYa5Tn
	 VOOH4T+XfJGHh7MDICKHWkyaSbEEjqFYSI72+9qQZsCkn77zUy2TbDC9E6iAffhhQ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009741;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=Xm1Qx58C3kdSvPTHXTBR7DDjRva6ecK+vC6rOyxx47c=;
	b=kNwZrp1Z7N5SciVsGhYH4OVrKJpvUcVQtDBh9HsHigFzPWaBzyZsvQGt1bTth4+MUm2K
	 +xCpJRkQf5K227dPPkOaJOgUVkmdDzBN0ugV8wLFrSauOoeaR/zNM771w9ZZC4TvGsTCM
	 AXceSkaxyl1wP8tIZh50CzmuNXTtrRFSbi8/MWS2WRfHut/VgSWpTxPD43pKeUca/5Rcp
	 9IroZQ8mE3KovN5cb+KJeHv+YR12YRmPM2ez1ph62TwStqhQpkCIYitt+SyiSXGyFnbtI
	 hTq4Rl0msv/sSHNaw6WwBsHhaFzLpQpVNwMGtRAKwv1i413hBaSZaFiytWMuSCMVlVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=P7mdtMjs;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A5606A325
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7A5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=P7mdtMjs
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 6FB6A1017DA;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id 56AEF101327;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009737; h=from:subject:to:date:message-id;
	bh=bbyA87p3vE/FUl1iLmQDrgsU4+px9vVUerDXviDtydo=;
	b=P7mdtMjsJ3PpqbwJ99PSQExnuv+QZnF0+/IQOR1t5hV0dKnOWv6jydTor7mqe9XGSbdgmxkjqwm
	GrsiciWtMu4Lgn/HwTU1POvi3/OMnCfsTWyKqJdFlLkCkSIBKT+/sGxhk/Fn7gpSb+t6n3V4+P/Hm
	xn2oGfWbAJgSR4HGt43GCZZzXwcd/8Z5Yi7LXXOoo4JnUhjXN6nMrh4LUMO6D2bXQ0VUTOSdRfajc
	4deLpSFyEKfjGZyFzl3HFwBo2aon42YDHIJZUyrfkad2y+zmRvrthG2pdZAJuMm9Tdyc+UHjbib64
	sB59QkmFZ5Uk1xrxhuL6tr5rXeo5l4kCXELw==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:48:56 +0300
From: Artem Novikov <naa@amicon.ru>
To: <lvc-patches@linuxtesting.org>, <stable@vger.kernel.org>
CC: <pchelkin@ispras.ru>, <rrv@amicon.ru>
Subject: [PATCH 5.10 v6 1/5] KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
Date: Wed, 18 Nov 2026 16:48:46 +0300
Message-ID: <20261118134851.203854-2-naa@amicon.ru>
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
 

