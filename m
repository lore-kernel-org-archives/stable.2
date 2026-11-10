Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335100;
	b=E/VVvnH+6U9nA6yDUvN2da6Cx/UoeV4rciD0tyxKTlrK4moI3lr1PjlooMN/7Kn3P74K
	 GrqJPGlRoSbAnPbunUqVzwQLnDNV5/SM4RKaxd5dNT+hoWJQjoLw1flvSK+RN7dBsBC3l
	 4OcBv0GmM8yxYajN3PkkmNZ7ceq1I34mbxUWxXkKUuV8R4uMSNFLvfF44Aer4/ziDzhPo
	 fBeMvcd2bN0gESUlHeS2HNnzejp4+yeJ9KdEIrbGFvSYCdJEV58or1cUV53fbVi2G1EGa
	 Bu5zEJIcO9NCA/5uk7x9rITb9ZDf6ru2ZPrVxUESFSW6+hEkD/C8/k3cXOaj/dsMM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335100;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OmMWMlmk/8Tx7em1Wt7w4eiau5ZxgoV4JEgnSUn7j4Y=;
	b=s681ei8Nkzl5VpPRxtJy4kr8Rcv7sYlX0sWqJlrywhvKGvjsYAY3KimXHWHXsZLgraIb
	 fTUB0/Txzk/V+76waOCy1rsJIgygKZRI2v8+PJVXR7ZtF+JaYqxZmKReaKrOftgynxP4G
	 FB6InksO7CFnwrIi4bzq6Gqkhqe3/p+iqPfbQj2KB64o2CrAFfDgE1nOyhyu0/c8jk7Ft
	 5e0teQKVB4lFhTOSaNrsolLEpj5gWm0niMtE2JJuGnbhktgqRDlpyvdVyn3bt48VJTdqG
	 LbahXW5mxrUUsJvg866niNGUT/L/qszXmOJtFtGJrMfL/aSewnevKAZblg1QnjdkJmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLv48CJ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3BF606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLv48CJ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F7C1F0089F;
	Tue, 10 Nov 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794335100;
	bh=OmMWMlmk/8Tx7em1Wt7w4eiau5ZxgoV4JEgnSUn7j4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLv48CJ10C4UKgug//V/wcUSi3UJpduexqeM34t75PZneRFsrms/C8NzO3w7DtYHa
	 mEvvJy35PXnkWiVZ7vGpPDgrXlUbkyyMNUxRNPDZlDDje/R94zroLe3fRfGg4PRlQJ
	 cf7GHpijK0chgZguBVOqAUKYdLmrVxwOiGkAw2eh6qJL1doH3APb6ZVadIpEH0gzn9
	 29MfOAYeYSjCWVyuD+F+2vVmyy1SmV8e1Q8sTdH6UHL89/USwjdgcZK5+gFOU449gf
	 hNjX6RJ5TmHkkvH+mAU3AN6MPexLA4IKV1mTNLnO2ToEGfMbamAR2YBVujtmeYesrn
	 ZW26fyqT4PjaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tobias Schumacher <ts@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] s390/pci: Add error cleanup in zpci_directed_irq_init()
Date: Tue, 10 Nov 2026 13:24:58 -0500
Message-ID: <20261110182259.2877900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062218-failed-5.10-769f66f595c1@kernel.org>
References: <20261107062218-failed-5.10-769f66f595c1@kernel.org>
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

From: Tobias Schumacher <ts@linux.ibm.com>

[ Upstream commit 769f66f595c11185c66913ea5d96420504bfebc3 ]

If per-CPU airq_iv allocation fails in the loop, previously allocated
vectors and arrays leak. Add proper error path to release all resources
on failure.

The error path frees zpci_sbv, but SIC_IRQ_MODE_DIRECT has already
programmed its address into the hardware. Set the directed interrupt
mode only after all allocations have succeeded, so a failed init leaves
no freed memory registered with the hardware.

Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
[ sashal: adapted cleanup to use zpci_ibv instead of zpci_dibv ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_irq.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 75217fb63d7b3..f29ac95d4d278 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -391,15 +391,10 @@ static int __init zpci_directed_irq_init(void)
 	if (!zpci_sbv)
 		return -ENOMEM;
 
-	iib.diib.isc = PCI_ISC;
-	iib.diib.nr_cpus = num_possible_cpus();
-	iib.diib.disb_addr = (u64) zpci_sbv->vector;
-	__zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
-
 	zpci_ibv = kcalloc(num_possible_cpus(), sizeof(*zpci_ibv),
 			   GFP_KERNEL);
 	if (!zpci_ibv)
-		return -ENOMEM;
+		goto out_free_sbv;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -411,13 +406,30 @@ static int __init zpci_directed_irq_init(void)
 					       AIRQ_IV_CACHELINE |
 					       (!cpu ? AIRQ_IV_ALLOC : 0));
 		if (!zpci_ibv[cpu])
-			return -ENOMEM;
+			goto out_free_ibv;
 	}
+
+	iib.diib.isc = PCI_ISC;
+	iib.diib.nr_cpus = num_possible_cpus();
+	iib.diib.disb_addr = (u64) zpci_sbv->vector;
+	__zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
 	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
 	return 0;
+
+out_free_ibv:
+	for_each_possible_cpu(cpu) {
+		if (zpci_ibv[cpu])
+			airq_iv_release(zpci_ibv[cpu]);
+	}
+	kfree(zpci_ibv);
+	zpci_ibv = NULL;
+out_free_sbv:
+	airq_iv_release(zpci_sbv);
+	zpci_sbv = NULL;
+	return -ENOMEM;
 }
 
 static int __init zpci_floating_irq_init(void)
-- 
2.53.0

