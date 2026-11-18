Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002172;
	b=QPVZ6yZ/3jb4GwNRivWYPk3tfRVky9sk69jsctWZyzfOGCNBy+nCONjZUEfLgLo8xo66
	 k0DmHEteF99yOIPOTy8HC5vcx5UIVkkIxydFRT3oUESwCoJvk4zcLknRceCj3EAIC4EYe
	 x5u7THnEPWnQtJPxrs5BVcJPDOULtVWZV2z12LYl/9e0XaX0AzxBPJeDm7j1SHYTH1w+w
	 TxII/8XdVj0lLRHWIAI5JJ9AY0lJXCGoocjVtSq3+SoqWfIjJmQdKBHH4daEhhJ2soLaH
	 MPK+ASXGbxh1UfPCa4dSJ2OfrKtku6kE9jn09SxDuvELh9u46CthFwi9YV9JX1A84uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002172;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Originating-IP;
	bh=D2jbpt4NMXX9Q/t261OKzxoOaYn/y7J8+K/ww+vFFLs=;
	b=vASuy3Lu+eTHWzL1yqG/2YnLwyVu4S8ExIrgsOHXB7OLvKSxCBQGN0TuFChhXes8uFnj
	 DhO8N9dJk9eS4UXr19y9j0gUHoQd0Fqupj5X9lYzOo9EFrhrZbBoko3KlKA1Ub6WLcFZq
	 i6LaKRd0Gbu6u5J3FedvRDE4r4nQ4iDNzlsvvvJPaOKEUMFm4AM9t02s8R6k/RnrGJc2d
	 pq2os7rPQds0IKMryaX41EnNk96t8K9aOvRn5rxhMaovHB8lmPB91oSx+jy5DQm0rV5DX
	 twK7ldmM3O+du3CBo/Svj2iR3+yL93z8jTB4YJsl1lS6atL9Z2tRvIPnIeQPR2OR+5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b="L59X4/aS";
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE56606A325;
	Wed, 18 Nov 2026 11:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE56606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=L59X4/aS
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 50B371017E2;
	Wed, 18 Nov 2026 14:42:41 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id 1EEC1101552;
	Wed, 18 Nov 2026 14:42:41 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795002160; h=from:subject:to:date:message-id;
	bh=hOEj1zfLkdDSVSsjr5eSTnPdiFLODPEGSeCFzk34h5M=;
	b=L59X4/aSJVhhVC5ZjcoyVCiKcXrnR1XqEiwnvK57eYOrmUc5L9f8nBuzXIZwLce92vbwaIDC5Mk
	lBmJl8f9KadYv+ENc4sVBrE0DhPr7Cop1W91P4RlIfp5m7vvXS2/oV3hiZR/YPiztLUfZZxM2e4hp
	VbhHDBR/Hi2hWDcPu+zWivOFlE24bu5oh2i9XAqfmZjLU0WStHquFX1GTjGvht0c9fgOG8NuCAkOn
	A/y+4EdvGiz+gqPcc/iFc3vFimT1QUVWV9wJHrrSrHTWg0oOucsG8M+nSwozQNqfvFqXo3YWK4+ZA
	Tq6X1fTJn/jNbMMFwLvScy3RAoubz55d2xgA==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 14:42:40 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>
Subject: [PATCH 5.10 0/5] KVM: x86: Backport shadow MMU GFN and role fixes
Date: Wed, 18 Nov 2026 14:42:21 +0300
Message-ID: <20261118114226.26178-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Backport the shadow MMU fixes for CVE-2026-46113 and CVE-2026-53359
to linux-5.10.y at 3a323bc22b88 (Linux 5.10.274). A linked child is
reusable only when its GFN and complete role match the current walk.

Patch 1 makes shadow-page sync flush remote TLBs when it drops a
mapping. Patch 2 syncs cached descendants before linking a child.
Patch 3 checks for an obsolete legacy root after reclaim and handles
synthetic roots, addressing the root lifetime issue reported for the
earlier 5.10 backport. Patches 4 and 5 check GFN and role, respectively,
at the three legacy child lookup sites.

The backport keeps the 5.10 page allocator's role calculation, including
the non-PAE quadrant calculation. It uses the existing zap and flush
helpers for replacement after the page is ready, preserving the existing
root-count check. The parent-derived role and its setup refactors have no
dependency in this implementation.

Regression discussion:
https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/

Lai Jiangshan (2):
  KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
  KVM: X86: Synchronize the shadow pagetable before link it

Paolo Bonzini (1):
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (2):
  KVM: x86/mmu: Retry faults on obsolete shadow roots
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN

 arch/x86/kvm/mmu/mmu.c         | 97 +++++++++++++++++++++-------------
 arch/x86/kvm/mmu/paging_tmpl.h | 57 +++++++-------------
 2 files changed, 80 insertions(+), 74 deletions(-)


base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf

