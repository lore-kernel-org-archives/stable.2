Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329752;
	b=cw/6AMuPzDx/gwt0Kt0FMEk8wrB97yJs+tp/dFvfyKQzRryipVmlahVO+mXKcww9P7+u
	 DZMh3DRS4Cux+V936NNY1kZDVw+WTTJxXT0cGHGShZnxyHPTK/vp58XZ2yqQVY/ZG33NU
	 PWxs0jaDCkvojhpDRIfEBkY0EArrL0ydSP7A3Vl0TyRmFf2WrFi7fvw6QhnNEND0r46ZO
	 oDgIu2WQ2yxnvZ9pGsPrsSIhtUvultgAneor7Pd4aDOGfbCOISNCqSVAMrzg8rdYXoPvQ
	 gbbz+VHP4z1EfD2jPuDO6+AfrS8Z/npoUNwmXjfl6HFy9n4I6N4Y9gSwN/dHsEPQiMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329752;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8QaKyb7jlYV+UFzDcHA2XjC0HBmkEt/SIL4MAaSAQQ4=;
	b=dUH1WRq5wvcx/cDq7du7AAlkkdR1tuZZ77P4dFvB1iHKqxLvAx3BfYDVjIjgC98vzHiG
	 nLGUDVpUOn+czM56v19am4anncO30TtNkh9VDhEw6jNii4c41g36/rJI85NiPafp/J432
	 mSFSLUmEPBGPF3tbc4AXwpVYxV7dt6h2mP482iFGoqWUQX0uw6LhAcnGhfOqVAkUlEizC
	 bH2wJh6gGMb73DTGjbDpDGW/YmYknrInV3LgFHHE/EY4eZNwzyUpqdDE65XpKLKIuYZy3
	 ZzyEF25CuUvPwHdsid7Y8GNphvkBRRIXvSEybGSeIpfwkqdrXoYRbqDWV/Uqco4On/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5qATf77;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB226606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5qATf77
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83331F008A1;
	Tue, 10 Nov 2026 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329751;
	bh=8QaKyb7jlYV+UFzDcHA2XjC0HBmkEt/SIL4MAaSAQQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5qATf77WYYqeHx2JKzHvs/cKW/nGSSZoPKP5OvWyU6hu4vuVYsgWvRnoUzUj6tBH
	 Y73TPh45XCb91pMdHfUqG69KIjIfLaRlxhsShdf3B2OBKCc95VO69S2XSMi7173pmG
	 FKkeduFtgGOXssxbfNPtOnaVneIPLxIvbJV6lnof8BNureV1vH2gyFQFw9z/trUwd0
	 yq9c1/3NVjLoWUtiJREEhhgOSxpkyNeCzXULSLMBPWJTTNZE1saOP0i/NhNYhkc4na
	 5hqqmoJ+iWuwReV8pZ1NY9FeQ37ic/ce6FX3bcrC02rM//cWsFRxwtqUMtusMdV39R
	 s3Jkuu5IeQ2lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tobias Schumacher <ts@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] s390/pci: Add error cleanup in zpci_directed_irq_init()
Date: Tue, 10 Nov 2026 11:55:49 -0500
Message-ID: <20261110165516.2615577-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052204-failed-6.12-769f66f595c1@kernel.org>
References: <20261107052204-failed-6.12-769f66f595c1@kernel.org>
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
index e73be96ce5fe6..836db17f4e8f6 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -450,15 +450,10 @@ static int __init zpci_directed_irq_init(void)
 	if (!zpci_sbv)
 		return -ENOMEM;
 
-	iib.diib.isc = PCI_ISC;
-	iib.diib.nr_cpus = num_possible_cpus();
-	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
-	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
-
 	zpci_ibv = kcalloc(num_possible_cpus(), sizeof(*zpci_ibv),
 			   GFP_KERNEL);
 	if (!zpci_ibv)
-		return -ENOMEM;
+		goto out_free_sbv;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -470,13 +465,30 @@ static int __init zpci_directed_irq_init(void)
 					       AIRQ_IV_CACHELINE |
 					       (!cpu ? AIRQ_IV_ALLOC : 0), NULL);
 		if (!zpci_ibv[cpu])
-			return -ENOMEM;
+			goto out_free_dibv;
 	}
+
+	iib.diib.isc = PCI_ISC;
+	iib.diib.nr_cpus = num_possible_cpus();
+	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
+	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
 	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
 	return 0;
+
+out_free_dibv:
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

