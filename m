Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338712;
	b=3HMUsBRqd536B9Y51i6N/B6LJZXEthNipMkbch/0f80bIzI4I9M0e9ZKIN04OBP8oZCT
	 wDnBHzRoyo+ZUTPRq4gmDvfBSM545NBtV+9iYOXz9b+2o/nVFMMG9jfKvLqyyiC55HjWa
	 +tn8pQoV7tn7tCBj5KaDY6sZ+2enW0UEFw92okG1/BIK3dyX722QrSLK5qcf8or2mzaGp
	 NkdJJFWH+qtKSjN2GJGWe67hZ4JvKGB4e3jzpRzdNILKqNMrUi2jYIex+9LzNIpj2ezhy
	 44/cob4BaJaAtSzxpQOX2CB83Bp1nRMYBjsXWqSn/N26Rcr1r7Z2LVd7xz+7sDqGvVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vgdESjZzDXG1xYKVM3WnBi0ZWbzfUiqIREyP14pavu4=;
	b=hbUQVYFUKoE96zC64Dc9XTE8rJit9hJs3hguamc/Fk2FUJLSeohwY9D8zrjIYJshcrRa
	 JibzXyKQHEmpWtCsKnhKPazBKzBqRrM9jQeOczAL/T25XCZZ1mRdJ/gGLi+6KknrIkOzR
	 ON5EZuBoP4Kv0GNVFwOHFzb79V5M8sZPmW/d3UjC33N3mxy+Q5R8njdRd0Z/qoiScEYNj
	 TsytNW1fkVVahv1hRbAvCJGGZm3T68lFIwxaNu2pYIRCcJf/KtaTjhbIMqHmARDH/gC2C
	 5hVr8fhPosZ/R0/H1l5ir1+yHlHzdUr1J26cD9wfu/XoGfY5DlK4pgKTrgzp4VMKgqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbOsfbWW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65001606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FbOsfbWW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867E71F0089F;
	Tue, 10 Nov 2026 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338712;
	bh=vgdESjZzDXG1xYKVM3WnBi0ZWbzfUiqIREyP14pavu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbOsfbWWvQuaeXMDrISd9tgVXlyxOudDWxyAkQNnc7wmZwSWIw+M5yox8VXNpizKC
	 EvL4d9jnQtgZAMl6g2KGQZ+/Qkqq9bEJmjVtOTXuZfzZylymi4Qz0e9puUJuXMT4oN
	 tBg7wcuQkoE+i1Qklyf5Xl/6EugdGs5blHEvtH6FQlb5+Rokb9pFuwaeDHVdwBvnaA
	 DZsvwcy2P/eaqN4EkkTHI6CqJAjRlryT247bR9Ku3FgIa86OZzHlFDENdw2rq2TbBU
	 X6POWF0Z0dhuwBTmpdnUWc4eeRMFTSXoBXcHSI6O6oFHpb+2OTjrLstPJhqGzvc+sN
	 IYkSl+eu0bZCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] soc: fsl: dpio: Free the IRQ before releasing the I/O object
Date: Tue, 10 Nov 2026 14:25:10 -0500
Message-ID: <20261110192451.3542847-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062013-failed-5.10-a7831c657c90@kernel.org>
References: <20261107062013-failed-5.10-a7831c657c90@kernel.org>
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
[ sashal: Changed devm_free_irq() to use irq->msi_desc->irq instead of irq->virq. ]
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

