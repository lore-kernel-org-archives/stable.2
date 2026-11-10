Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329938;
	b=NqhHg2y6bqkTTCPuf6NhP7QVyM4IVeDenlsBKV3PdI52dRKJsO3YDjcBudND8aUBVlG1
	 9d1L9vINhBoLV+/vi1XrUsUHhJ+Q+Tj7ihfh5uZvKrtB8Aj4aWJWr8KB+OMkIZSLHLn3S
	 yhs7qAkKZcQ2FkV8j2BMBr5HqHKNz+ep5isyfYT6OHPtQGvRCumQ+CnC8OpWSejeqCCfY
	 5/PdMS1ZOvGu0eGO6Ptan1Ga7BAN8n7393Mi9rsYar1nyUzJGHpS0CLLnLgMuDKJMK6Oy
	 hhCndnF3Qgg5eHKbldmk757MqJGD4pukRmay/ncmSzOrN0pdFd5Nio6apnbMrctJNqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329938;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b8tE6XXf9Uh3AMhQUVq4h89Y/8tTLNnTd/6igwhVxrY=;
	b=S23zh+oez+O/w2TpuR6l66iwKBIMesbrT5XZCpBo8uu01ph43EkrNpnAXh5XrF8YZ4Wg
	 4PqamKMQ3g6yx3Pfgjowzu7SMFZOsUwAqbzRa0TExZ8LcbAm3F93QhXmYoQ8rc7v/ffHE
	 WyoxwDiYK+2lCzTdSq5RTc00N1Eex1jCapN63AtfdiSf5EJKtHdLMRmniKTeBQjGxQxd6
	 OHXn2WGkAlnC8ILc2Oh9cEa/3Ov1MIjW/900Nkw3Laj6JH1eorrMoR5JOku0F+cS5o2pw
	 UysvZq4R5sxG0c0u5L37JyvOW5v8tWZp57YHP5L9z6pFf3cG+l85nuoVeEIF/W1sSOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daopf1S5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE5606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=daopf1S5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB1C1F008A6;
	Tue, 10 Nov 2026 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329937;
	bh=b8tE6XXf9Uh3AMhQUVq4h89Y/8tTLNnTd/6igwhVxrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=daopf1S5gLzcI9kMXIMtOIbmGb8MktCHuczBoO6ZJrYkFQsyQlTIclm2gJOkuRZ1s
	 kXDXP7ZdEV5JaFf0sHcZA+O7lNuRxwX9hx9JmNBKVWoSRFCeCXbehNKzJeTCxc9FZ5
	 RK8vp7aGDD7btFTsz78FMLFm3A9mY5XO7/uFXV5IKiIns2+hd5bRvzrladVUr/rcQm
	 1ONyVUYUP+IaX+IU56vgOGa+FPokt8Jhs5U4UTPrma5n9lLSaDVb5NADlQf+vArPri
	 QKrszqq4mrUaQA1+wSi0Hca6GRWUr/roLhYVmeNjnrDzfuuBpDMwQbATPfJSJ3vDE8
	 H347RFJouomiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tobias Schumacher <ts@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] s390/pci: Add error cleanup in zpci_directed_irq_init()
Date: Tue, 10 Nov 2026 11:58:56 -0500
Message-ID: <20261110165838.2632768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053430-failed-6.6-769f66f595c1@kernel.org>
References: <20261107053430-failed-6.6-769f66f595c1@kernel.org>
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
[ sashal: Adapted cleanup from zpci_dibv to the existing zpci_ibv array allocated with kcalloc(). ]
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

