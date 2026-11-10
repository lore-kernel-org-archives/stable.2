Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330923;
	b=V30LOvAH8H2fmz70nq8/7J0Ufl2RltxArxozZcoKZGibrx7PgnjiBq0l37tspaKJ9WcI
	 0bK9jvkGcxcZqImGqV9oaL2QmJXMIxLLil0XZ4/46T2xbbwO0cBXfCEVyFAEee7r7dFl7
	 nsrJEHUZ17w7BDIg9NWBuCtsZiASxCLGLpRVTLs18PiRj8PAu4SZaSY/4zivEf/Uqy2Ti
	 Voc1OOZV2LpLY//k4Gk+GIMNk4WPfuxpLWVlEIyqlVYGp5+nj7h+AQQp3vjgzVea0j3GE
	 ss75uEyVWpa2A7Hb9nDG52eF1vqfg6Ox4v3V/m0sb4p3WQsO8a1YGNp6c9EIRvW9+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330923;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mt2VifBso+oyzIMEm1BVWYeeFuLQENSd8+whEp1IBAQ=;
	b=VLte5YlAbnUdF4iBqLCN3YWOfpcP1B97Ru9WoHYHVJI+mI2hwfU/YScZZFDK5jEHROEF
	 xA2Oe6qGvITuRSWByXWc3cqNpAANiXrD2SzDjl96g+JQ5fpjX5g458NS/zKkVk9w/toTk
	 oCgbx8i4lrc2qtLEGgyPdlB2kgXpGkCC3dU4UfYrLlCW4V09n7TCR2tPR/tYGx0b5gIXc
	 e+FSSANaqHw4o+Pf3Vsl19eHDJTvhD9+KLBqNjlpS3zlf2z5zJ5KTWoTjsKz27Xll69dV
	 H+1PmxvgkRTiVkv0axPkqLqSE6RPVANgFwrtXQoGBPX1c1NLVnEPxddAlKeF1LuF3rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XsZT/+8g";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96146606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsZT/+8g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C26C1F0089F;
	Tue, 10 Nov 2026 17:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330923;
	bh=Mt2VifBso+oyzIMEm1BVWYeeFuLQENSd8+whEp1IBAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsZT/+8gkhInIPzRR7g8cHFE9zYjBCHFs+h1asRIGJU85xPcTuR2fFP+grvPlUJGi
	 9vVyaTgsX1tgszok4VTYGcLd/VgoyyDTb8VKZAFZK67UlIiIO0D9wCdKWYBoDA6L5Q
	 +EcCvv8Kdp4O8bqZ7xwBHUcSechlRwD6LssPK3Q8+AlO5Orw3Xy+RFSUp2FKhxyQ6e
	 CHr9KGbrw11aIt+IWKtKV3/7vKNfUpI+w2L+BhkpSUcGHZVrqEFHaRHoEEv7bK/7YK
	 0MiN0HCNxXK032+JEmZKCBo8vZzwRC0FUObr2539t5nyMjlGawyTA3P5g3LM2Zl+Sl
	 FfoKwrZhJbZ0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tobias Schumacher <ts@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] s390/pci: Add error cleanup in zpci_directed_irq_init()
Date: Tue, 10 Nov 2026 12:15:20 -0500
Message-ID: <20261110171451.2702862-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060527-failed-5.15-769f66f595c1@kernel.org>
References: <20261107060527-failed-5.15-769f66f595c1@kernel.org>
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
[ sashal: adapted the changes to existing zpci_ibv naming and older s390 allocation and IRQ-control interfaces ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_irq.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 3823e159bf749..5281772424e86 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -411,15 +411,10 @@ static int __init zpci_directed_irq_init(void)
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
@@ -431,13 +426,30 @@ static int __init zpci_directed_irq_init(void)
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

