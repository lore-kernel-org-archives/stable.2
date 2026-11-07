Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049529;
	b=llWGgOy3fUJt/BFXLJ55VsZMqY5Fwnwx9xHCUvDqRXkZOs3UU9toWeRyFDVlm+5u1M+A
	 Wx6C3fyJz8Zr7Vw16FXkFMLaubwaGnQSb/64zMquz0WpXQHh9Pu/UhgrtD89CRbECrvf1
	 9MzVINWnHf3Y8enXSuCKhxaAoFP5GVrlBMq7+bb4I9cF8wUVb8/fSPMX27RcawazyyPiQ
	 X49FqGxxVjtifFNgbNvlzix50AnYQHtKUk55zVuypISnR3WjoQBLFmc0OIjpjSSByD7Bl
	 t3sYHZsycoiuCNKBj9y52R7Tljm65OFSMPovB2jm+1rhl8ouPiKCeoc6eTvmbIqDyqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jXaeGiyJYUbd1922KpWPaPv0oRvHvDFYe8D0u94F0II=;
	b=xNgkUwmOOZNRaN0xdJsMGUYgkudVRcS95khr/TOVRypc7hzk7sbVQG/+VpnswKdv0P0Q
	 rvfBS47dqB64OxMWNsNeeeYVy6zT3ngyLHOLbo6dcrjmieliziGZNf4pKkJUPTmsiG6mq
	 NdRCJPkvpeZp+jnNnpqTChKImDYo8yEBcFpUjXeWvNswgAGi/ZSRW7TfrGlG5AnfHbmi2
	 Oo860Ys5fOJbWqs2VSfqITriWvKqrv2Tjijdmh8oiPcm+mgGnjct9Sv9LkHgwmJmti08y
	 uNYP+jBYy07V1nbPOrulpdGMorzjiaPd86smg0V6wiDqGcVZr9FF5v6Oyd1wNOmSsBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faoTUckO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faoTUckO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05321F0089F;
	Sat,  7 Nov 2026 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049529;
	bh=jXaeGiyJYUbd1922KpWPaPv0oRvHvDFYe8D0u94F0II=;
	h=From:To:Cc:Subject:Date;
	b=faoTUckOdwmkbULx3CcHXzguv0fTpy3OTTaA4H2IGq5igV95vNaGFQBfhYtHqbVKh
	 JnTEamVcdi5vz3oaNAa2QM6Xt+ppYF4sOOv3V6g3Ro0rFbYoTRBbMqUHhlAnYWYwhd
	 aisjoJ3xh/kaJT7fcmFuh73M4YQzOGp8d361lp0/+VDa6kAh8KJhGiSiWHgYKpZsML
	 xKxr9LSO2yojgYx8ZYW4CQIbHhpuyhpR2e/KZHkNYpAuTyQLqitJqAt2QXxXHOVk7r
	 /coej7VVKy9nd6Kr+yfNJJEptFAWydDwbql3Ngf6ZmSUOEQs/ZgeRMvWw7rBA6fL3p
	 3ngdslhplHMNg==
From: Sasha Levin <sashal@kernel.org>
To: ts@linux.ibm.com,
	schnelle@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/pci: Add error cleanup in zpci_directed_irq_init()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:05:27 -0500
Message-ID: <20261107060527-failed-5.15-769f66f595c1@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 769f66f595c11185c66913ea5d96420504bfebc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060527-failed-5.15-769f66f595c1@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 769f66f595c11185c66913ea5d96420504bfebc3 Mon Sep 17 00:00:00 2001
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 9 Oct 2026 08:15:52 +0200
Subject: [PATCH] s390/pci: Add error cleanup in zpci_directed_irq_init()

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
---
 arch/s390/pci/pci_irq.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index c5fabad381395..bcf11585df8d8 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -569,14 +569,9 @@ static int __init zpci_directed_irq_init(void)
 	if (!zpci_sbv)
 		return -ENOMEM;
 
-	iib.diib.isc = PCI_ISC;
-	iib.diib.nr_cpus = num_possible_cpus();
-	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
-	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
-
 	zpci_dibv = kzalloc_objs(*zpci_dibv, num_possible_cpus());
 	if (!zpci_dibv)
-		return -ENOMEM;
+		goto out_free_sbv;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -589,13 +584,30 @@ static int __init zpci_directed_irq_init(void)
 						AIRQ_IV_CACHELINE |
 						(!cpu ? AIRQ_IV_ALLOC : 0), NULL);
 		if (!zpci_dibv[cpu])
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
+		if (zpci_dibv[cpu])
+			airq_iv_release(zpci_dibv[cpu]);
+	}
+	kfree(zpci_dibv);
+	zpci_dibv = NULL;
+out_free_sbv:
+	airq_iv_release(zpci_sbv);
+	zpci_sbv = NULL;
+	return -ENOMEM;
 }
 
 static int __init zpci_floating_irq_init(void)
-- 
2.53.0




