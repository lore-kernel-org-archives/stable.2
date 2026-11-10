Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338348;
	b=hA/cISzjIYion4GaAwSFebLzQRTbx8vGHnNjQNh75XrkJMtRSpWz90CU2pA8/1Jp0wGe
	 9rdiu9rrcdUJtqJmfx6kLaE52dqHF1g3cyckrl9DeJkqh9vLnhyotw4kMbjmwe0yqGhPQ
	 0cDbXrnmJBuYoL/5KsRLvXECrhHEnfvzmrXpRdS+Y5KjCRMEJvWv6xlxj2cNwQUubHL3T
	 B1W5jCvFABBu520b0JvEfAkNF4y9uyBPEVt8qXW+2xr+GvHlqe/1IMp39tNGV2eU3a+Mp
	 giRbVaERjv1DHnUzBtpY7lvTP97nAi9VLYWRzs7bI0DHGUmgyaQxB/8s4WNMwWySBvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DIVFirmjx6SrN0MpKUCQ5LgmYjDrueLm+TUMNP8AvWY=;
	b=Xy3CzoH9vOPS9BMkJL7NUK/m/phjXHWPvFuggdJpiNXiThFdy3fmdIz/myg9Ho62Asni
	 e+GYcoAjnPTdjcwW3TfRcwmMrViCpZLMfMj44I37x7/U+n1DJ+AJb9d8PWRWumgHRt6YU
	 kQly+EaOM/znLZ4Arzg692U66sHB1p5ioW9xP9qfAP5mONdPcKStO+Xvaog6WrVbTy7cn
	 CrlnavpIeUKNpOMxidh/SRgbfxJkxX5GQaJO4OcGqUfua2OZn9knzKGgTA9su4pGoJOcN
	 iXxrJqK+HflHMg/F0RS5pMfEMTA/nSlTGgcmbmUcJr4ZCBJOXIvVsCjvf5FikzHD+zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N410xZfJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N410xZfJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35141F008BC;
	Tue, 10 Nov 2026 19:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338347;
	bh=DIVFirmjx6SrN0MpKUCQ5LgmYjDrueLm+TUMNP8AvWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N410xZfJPjXDUgUVH9iRoxvdIfrz92ArYpkVDZPGKbMGT8E9OLhzwwqr8c4rRYhSw
	 kQGLzopLKX/Hb5kxZe9MsTg4KOiyuliDo/1LFddFOjpCHEZ0N5jfGj3MaX+eWzrj4c
	 MI+RU/XbILZ8tfUxa/tjVMsbEpahVTEWAknyJ6SOE091CZFJIoilCQFe/7l5iop9gA
	 0JkWrQGNCTVQGUJdaSrR2WZ1ly/6PQso3hKp5W4wg055uY60Xj9cl8HH4is9+xkFd7
	 vsrK+FHMe9OatT9mzZHLN6eyKyOlnvT/INpqwmbX3nGClpW1bi5KT0jiext/EZFPRW
	 jMRyfNP29UeMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] soc: fsl: dpio: Free the IRQ before releasing the I/O object
Date: Tue, 10 Nov 2026 14:19:05 -0500
Message-ID: <20261110191600.3423079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060333-failed-5.15-a7831c657c90@kernel.org>
References: <20261107060333-failed-5.15-a7831c657c90@kernel.org>
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

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit a7831c657c90e8f9165f6bbe0cc56262fee075e8 ]

The DPIO interrupt handler accesses priv->io, but dpaa2_dpio_remove()
releases that object before tearing down the interrupts. The IRQ was
requested with devm_request_irq(), and unregister_dpio_irq_handlers()
only clears its affinity hint. fsl_mc_free_irqs() returns IRQ resources
to the MC resource pool without freeing the handler. An interrupt can
therefore access the freed I/O object before devres releases the IRQ.

Explicitly free the managed IRQ in unregister_dpio_irq_handlers() before
returning its resource to the pool, and perform IRQ teardown before
releasing the I/O object. This also waits for an in-flight handler while
the object is still valid.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 993fec7e11ca ("bus: fsl-mc: dpio: add the DPAA2 DPIO object driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20261002194802.375497-3-mhun512@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
[ sashal: Replaced irq->virq with irq->msi_desc->irq in the added devm_free_irq() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index e1dd4cc0702da..8a93dabe1727a 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -89,6 +89,7 @@ static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
 
 	/* clear the affinity hint */
 	irq_set_affinity_hint(irq->msi_desc->irq, NULL);
+	devm_free_irq(&dpio_dev->dev, irq->msi_desc->irq, &dpio_dev->dev);
 }
 
 static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
@@ -280,10 +281,10 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 	priv = dev_get_drvdata(dev);
 	cpu = dpaa2_io_get_cpu(priv->io);
 
-	dpaa2_io_down(priv->io);
-
 	dpio_teardown_irqs(dpio_dev);
 
+	dpaa2_io_down(priv->io);
+
 	cpumask_set_cpu(cpu, cpus_unused_mask);
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-- 
2.53.0

