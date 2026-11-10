Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329284;
	b=5aG626R5GucfPLjWcE/cenDbCBzl1GWoftFCbWvi64QXMGLyFaK2bIgDnNEjR3PZYMBS
	 j4wLsKuYWK6XFik/zZMZEdLxvEbPfpdEqvEWqHUCd62tiNmKuI0yh1x206QiY7oIrqc7p
	 pcVG5jVSGJ4JcrrS1yiSq43RaJgzMZVV0lmo5OAQ70BL5MppfS5h+v1bYDMIRNo5/aI55
	 hcNKNpuJioxh1sQaKj5su/WfS8hChI0KMI25aQnHgFwmUlob6v6TALgujTjvW0EYSsQXi
	 o8+bRZHXBVZUKy4l8zjmRrK/kCpI3XfrpFQqbIszp8r1uVeBHNXkqzJdJO+dIPSOcig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w3IyMQ0Onsoimx7jIdLbUC9Z/HegmbnbIQjB7LmdYtE=;
	b=TtVVTW+YobxlGXpBN8W0L8TFffL+I1GR9CD0BPNVI1IqVLgRq6GGY1viS1SKpnjk9gQe
	 1Ej5w3gUUDx0UIsacg/Tx7WBdwSq/Vh0yhUEboAUWqEQRI4HCQufl0wIWa3bC/IfLOr7Q
	 /nJtUCeqPJUcvdD8xV5YSartqBis0FW/Umnukzsc+9XpBE/WpSeBYgq5e4I7VFOxb+3oo
	 ETOJZWmx528l10o9/BqA4QqTRnN6pDvdDVLWaphfCKAmyU2hdpQFAhjFwl/85bvNKKVUv
	 ADVembI/OlR/jwcz3psMzTsAyDZzlu77vQk3IObkLqJgMBydpOKvXgKT1Z3YENA8UYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dToki2sC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E90606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dToki2sC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E60F1F0089F;
	Tue, 10 Nov 2026 16:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329283;
	bh=w3IyMQ0Onsoimx7jIdLbUC9Z/HegmbnbIQjB7LmdYtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dToki2sCE01XEWMshs46D7DNGtCrSxIgMzJoWIppzHVTuMNoTXbw4V1idey3WZW+K
	 R/6w9T5rngmwWFJrvwB0iovsVTIGKyOxJI9/xK6O51ufWsTuRNDAmWwbyoJix3vXAN
	 AkqsQRNpErhVjLygPi2qGW2shSvm1aO6IZ7U16F6oduRz+4n2QN3maI6OtZLdrSm0u
	 IH0xO4veQuwzQC6d2j+eZjjlSrRdDG+q+KQaPolU2FGcElrai0/imdxbwmmMVuLhiH
	 77ehwWtUtQYJL+j8lnqq6bbAVVRW8AIRzpIVChHJxqM1Zy2X0lG2QWCU/gdu5/Mot9
	 WXGswHmai57Og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tobias Schumacher <ts@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] s390/pci: Add error cleanup in zpci_directed_irq_init()
Date: Tue, 10 Nov 2026 11:48:01 -0500
Message-ID: <20261110164744.2547065-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051105-failed-6.18-769f66f595c1@kernel.org>
References: <20261107051105-failed-6.18-769f66f595c1@kernel.org>
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
[ sashal: Adapted cleanup references from zpci_dibv to the existing zpci_ibv array. ]
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

