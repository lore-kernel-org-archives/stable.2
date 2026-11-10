Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330409;
	b=doPIsjdVe2zWTBRCz5AbV6+DX/FWIDshdPi9JA9pp7SjuqzkFp7n3hMWZ5WOaDptiebo
	 6k00qBmGYVXXgT6KT+MI3ntreyoP2eBOu8k3z18szc3qTEyZ5kzm05nmoouKJtKc+FK4K
	 FRtJIjYGaiJiam0LeMN5LMrLBiNKhoBqrd9eEL0CB/JNL4yDZJmR6OtzEVKipN3qzhF31
	 rB9Z34NgdyGtUV+4QRVCj9+DJNWAd+3/zmTvqPm2BsWQCHkuzGwGJsIHGlhGJxhOLtftA
	 Cgc9AAHk84lhwOtwhaylGCtdy8xALEh5wHjaz4/QYq4n95/sEahQ/M3xgPUUY1JN85Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=suiklh/Bdm0xeIe/thaD75YIlepUKpTXNzEuIWimELA=;
	b=IpCldr0DQHxt9qSuPAQgZAX78Ny83JVtRLqI9oNWRFCeBgUXLWUk2qt2meKy5qkQuoiS
	 +K6lwgm2WuizufHi2v6k8uwxN2sYC+Quj60J/zwhPCRnrMYPW+wr81lg7EnwK1lnYbqwU
	 ywcvwu/V8hY+2H0D4JORfqXYyLglFmA/SCAZ07gVLwSkDsYy8CZDodfmx91KKPAlwgNlF
	 X6DjxFlVb58ZMtrO5R3mVf81P9JYVuFrmYByIToZnhzBHUu/eRTMUA7hXM0ikKCYEpqJu
	 bVEe7KIYqyjWcAiuTvjUKMJY1bMb9SfT3C4ZF4xST5T3zplDEu1QaFc09FqK+NLWMIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYKq4msV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYKq4msV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886C41F0089F;
	Tue, 10 Nov 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794330409;
	bh=suiklh/Bdm0xeIe/thaD75YIlepUKpTXNzEuIWimELA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YYKq4msVdjoRlIGabPxhuLAG21kp3nPUkfivP6R086s3+B+1Rhrm/5tP3xU+Zko7R
	 9ikC6XnWi3PPHScLUjuAixC2jZFomTJAjcBQ62it7Y3B+lrbBDvNkcz5eShTAbwOXi
	 +p8bHBNxnoDisTqY5pjFvv8yIfYXBHpeHKNjGs2MWbxdAMgpc+gbuFYB/qaXFu0NXX
	 JyxVu6aQ/5NP7E7jfx8jjyEdE8KjFmpPBTpY1EoUuVM+7rwIKclAX1krDSVRqH/VCf
	 VaarggJxjxchfrsHO43rALYBcus4+feuNzaQucOt7+gGv5Of0K6mCCqKbAQFrgjxeD
	 2IjlX4pKuILXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tobias Schumacher <ts@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] s390/pci: Add error cleanup in zpci_directed_irq_init()
Date: Tue, 10 Nov 2026 12:06:47 -0500
Message-ID: <20261110170629.2670343-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054805-failed-6.1-769f66f595c1@kernel.org>
References: <20261107054805-failed-6.1-769f66f595c1@kernel.org>
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
[ sashal: adapted cleanup to the existing zpci_ibv array allocated with kcalloc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_irq.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 69c5e4f9f10ea..24b8e95d03f4d 100644
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

