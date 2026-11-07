Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048488;
	b=t17p3gcv4DKMJXaScMXRvhFG+bp4V5z32kWR5VOTlxl0MI0UDTDFQoqALos2m+pNxR0E
	 NvaB/kQzYZfAHFRdCyIligfn71Ddd0b0f2U8MTr6rADM+JMBIsGv96DFGQBD5G3Kr+oLV
	 o5sfK6MvTd+AHBFrxk6z0bkg4yowdNgZgAZ+bKO395itbYKQcwWeaCNj2OriVYpRMXC6m
	 H7lkcRx/w33NluT1ZnF9Zgysgd3MVRa+9tEj1iy27wyOyll68s8LTm/uqVcVu1vO9u+Bx
	 8ERSr88MZI4Iky4zyfc7J146QZ38qrFu84Ugt35eN1tkyMufg9H+Sox929WCvJAyQpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048488;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NaWAHc+OKeIgyosgSO36ibg4v6YFN8X5fhaQJDjMIuw=;
	b=dicJwvVJRW9XUSIX6VI+6t4Uz0O61MsdKnXWo+Jdxey4TqD9hLAD1VzUbN8vrzXlkf5Y
	 bTygfuUpz2WxUd/4DRb6CV1gpPSwjeaWln8IgLOsubf2Nc2qtwWN74bmB8EHfjefCYpCu
	 k6PQoPnZMLRJ0FUtvrX13u4HUs9IYU0Jp/Yh323au5sKIYSWNtTl8G+lCgIPy6cIbiNap
	 jDOAs3lF871IwFQdbNz2q/yqxV4HgTcSu8mgsMP3xAiucGb4DrMYaIKOrSqRC/j7UkYCQ
	 ehPSpthoTATVRyI6ePwNUBa50zMJCixNWiqXmszHy7BK1s5mRG6VddyqEz5aE26cHOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mT/DgjID";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10436606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mT/DgjID
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6741F0089F;
	Sat,  7 Nov 2026 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048487;
	bh=NaWAHc+OKeIgyosgSO36ibg4v6YFN8X5fhaQJDjMIuw=;
	h=From:To:Cc:Subject:Date;
	b=mT/DgjIDIkvim4gN05bD7/0VDd2GWDesLaFrIh7JxP7UVdtvqfBJQAnZZH2F+4mFd
	 N1/mB2T5P3VG1dleF+x1yg4xtuJI4Vy6JGOdB41j4s/FpEPpk8i6sprBOe2UcuqoeX
	 6T+TNRkOs8TCrjpeJmIM1N0O3fOssRIlm4VOLjFm8/hVX5nAbqRTJ7fi3xMfoxU8fE
	 h9TNNYZs5ztVv1Py9/ew+98hWz120vzvXa4vWfVRBxmhqsdUscZPXn9CjCdky9XYLu
	 x7Gq/WN3bMBILBj5BTuDAmwpuUMFqicOYQFMJEkLLEMtMwJOAdkMFgIfch4b/u2FKd
	 eLQcDZoxRvi5w==
From: Sasha Levin <sashal@kernel.org>
To: ts@linux.ibm.com,
	schnelle@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/pci: Add error cleanup in zpci_directed_irq_init()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:48:05 -0500
Message-ID: <20261107054805-failed-6.1-769f66f595c1@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 769f66f595c11185c66913ea5d96420504bfebc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054805-failed-6.1-769f66f595c1@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




