Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047672;
	b=nzQg96rCOHVtNkTGh5VpIhrJc2yTuylV9zdzxefW4YVyPKG2DF3R8jvr5FSeFceq5Yn/
	 T7R0028CXtLWOpGxkkXa/feUBpf9AySfsac0lKRQZkxn2peqX0TI17BkTEBKXn3G7o9qZ
	 7794mWC97sExdF7bFmeLXM8P9VWJ1DtDQRhIWFLgj5upZD+XJXU6CR2VQC/J2RzETJq+k
	 M3q90nu70Icg+4oxUKE/eHTeec0RLhWM3rwEUh3cDjwQlcZif8IKq5D66o1ZJphvbnunB
	 tcHwssqexPMViOfFB7JQ9ENvCyCmZusUYVp0lCLQXxF7Lk06TUaSarHiORh/Kq+s/xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Pfl3XNtdlDfgHw3J6yDEVXK98M4y5qAiOUQL+WHJKGY=;
	b=2kXHRGzOXo/0Z2p/ysTKJGBvDXcd2ZvPjbpGZPdsSEsSmK/bpepSRkji3bBF7SIIalMS
	 II5PISRPQZqn0alY1AOtJ1ojlLijkQMLI/GxCO0oIbaEeM5+hsJcm6rGRep4tpekb/C00
	 FRlt6pdUao6/Uv1pGVcLpFgt+BVymRDwOAubDC81QNX2mM0HWXjxZBEneOVKLqss55pS/
	 Q1DTJAmVLL+N6uHnMGNrqKrZFlR2vohxwv9ZTO/mlh96WaLtCtspkKNwBZMbBwH638GrN
	 XuLcVoRDXrt+gQV738olkPQKpvCTc0/nKSfbv3rkTYve7+cU9jFn18CksLjmxOICpCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX9uLblM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F8606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aX9uLblM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20081F0089F;
	Sat,  7 Nov 2026 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047672;
	bh=Pfl3XNtdlDfgHw3J6yDEVXK98M4y5qAiOUQL+WHJKGY=;
	h=From:To:Cc:Subject:Date;
	b=aX9uLblMOHTeTOgr8uWAZ45ZFw1lsFBqknCH5KDX9WVRaFpXlf+/C3yD5xOyNVm9+
	 ei+Zon3WcjLugCt1WUUo+ZATtj9GntDZla/fOEzwAIJWS6KXCNhq4A1KxmAkGoug63
	 myU5tVOAXVTQ/veCDqtF+yQfK+264XvYFgSR420kHm6r5Lm1431NLwyjO55KhTT6/e
	 o31UoPQ4nc2QT/LiVHcVZTVmWYh6OwnbYiTRCyciBUenikaCrXdKGG8Akf7kRzRrEq
	 lcb0CtVyARoLXWWEcISXm7+uWYrdGKe8W9b72bzNxL1N8hMVjFGNECXSkqc4I5NJh0
	 h/FjMvdWSFkcQ==
From: Sasha Levin <sashal@kernel.org>
To: ts@linux.ibm.com,
	schnelle@linux.ibm.com,
	hca@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] s390/pci: Add error cleanup in zpci_directed_irq_init()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:34:30 -0500
Message-ID: <20261107053430-failed-6.6-769f66f595c1@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 769f66f595c11185c66913ea5d96420504bfebc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053430-failed-6.6-769f66f595c1@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




