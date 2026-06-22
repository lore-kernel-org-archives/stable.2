Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3623803E9;
	Mon, 22 Jun 2026 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114680; cv=none; b=ALUasakVl+GkimY0SIPMmf/CyEgFIMLnKyM/nAdtpIOJfQ4swI/NFhKkFQ27nnlbrYkS5CJijyrnLDIzVXitjz+YafnFogUwnCF8ldScwdXuxeHawcz4paazIUCgnWuJ3+2OO/PupGojkAb/4lliFEQPs7akfTqJF/FR62uxoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114680; c=relaxed/simple;
	bh=GwVHIoZ7r/M8GteP9m8gN+gqChmMb7gtvlHqruMu3OY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBRcCAQrM5sHWKYMmOomDgbBkX5whGMY301/6rG6HSbcdHCLLEOULEh37J7v3wUCW8+AhxMCtNkVUKRzfhHWEvLYEWWbP/DngOHKLk2rWcMJi5yTsHeeypCiORB0nAU/aTvfgqWLmci81Ljc107h3Lfznzqto5q+jsCYTD/VpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 21bd73886e0f11f1aa26b74ffac11d73-20260622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:df1340d8-bad8-4902-a57c-bc94b27aad22,IP:0,U
	RL:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:97fc9069a1c6fe1949f2f7a7b81d7275,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:1
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 21bd73886e0f11f1aa26b74ffac11d73-20260622
X-User: leixiang@kylinos.cn
Received: from ninol.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <leixiang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 972357421; Mon, 22 Jun 2026 15:51:09 +0800
From: leixiang <leixiang@kylinos.cn>
To: 
Cc: leixiang <leixiang@kylinos.cn>,
	stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Suresh Warrier <warrier@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
Date: Mon, 22 Jun 2026 15:51:01 +0800
Message-ID: <20260622075103.35164-1-leixiang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x86 and powerpc add_producer() callbacks set irqfd->producer before the
fallible setup and never clear it on error.  The bypass manager doesn't
register a producer whose add_producer() failed -- producer->eventfd is
left NULL, so the later unregister early-returns and del_producer() is
never called -- so nothing ever drops the pointer.

For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
when the vector is disabled, after which a routing update dereferences the
dangling pointer via kvm_arch_update_irqfd_routing().

Nullify irqfd->producer on the error paths.

Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
Cc: stable@vger.kernel.org
Signed-off-by: leixiang <leixiang@kylinos.cn>
---
 arch/powerpc/kvm/book3s_hv.c | 4 +++-
 arch/x86/kvm/irq.c           | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..14919b76fb32 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
 	irqfd->producer = prod;

 	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
-	if (ret)
+	if (ret) {
 		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
 			prod->irq, irqfd->gsi, ret);
+		irqfd->producer = NULL;
+	}

 	return ret;
 }
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 8c62c6d4d5c1..cb8ac4b9b0d7 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -488,8 +488,10 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,

 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
-		if (ret)
+		if (ret) {
 			kvm->arch.nr_possible_bypass_irqs--;
+			irqfd->producer = NULL;
+		}
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);

--
2.45.0
