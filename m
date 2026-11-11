Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434094;
	b=5EIaMpQIzmeYh+8PL2DCRscHyVnSAilHHmpIOuHQnVU7ZtQxDPLZJ9fiCzSiJE2+jBaA
	 jLOmSl65nsDdseJ2XAywYeSDDnXpUfoBG3U8b+qJbLut5Ad5MDYYgeywTYnF4ajfIxly/
	 ixuTV3muzsgd3JB+vVt9mt2dh+GhPzIbICrS6HesgWftzURGSo+YLcyoDRuJV9ppI0pxB
	 I6ll6RJ7m/+fNsmI1YJt+JZPj35qm4cCbySdSk/AQ9jBJVMqtM++RwZXIwMA3IFHMMiNQ
	 T32XJ4bYbJ92JNZoCbD2f0ptcjkHHVeJBdXXXabbk2D4dKeLMA9/Nm+ABY99XsY5o9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kH/zOaQeVhdcg5Xef4ASdteo6F0tiwUHB4K8YD2JlYU=;
	b=cyqKeiGxB2Ihl5+GshQI7ruqRN2p2sY/KchKjZK8Pb9gYdEAZ+wg7fA9m2BY92LyYLxy
	 HmF1SrzVu3VLDdwbOCsXf8CvjqllQGVSpL9euuJvSYf4SrEAgIwYM711bgWmPJpXcj0mm
	 1RbghQfS8Xl2MdR1G0eI/oehHPSDJxE+gCO3mGHV4AB8eECTZM3SqI8jrnKY3Z9yOSwyj
	 bCPzQRgNWQcd/EyuKQshV+cWVuCcHwf9b0LbV0g0CvV3IFMAIOfVCsZQ+iMeIjiPTdRK3
	 VoW6Kb3YA7+frQjGPJdmRSGuqrpLGyrj2wP82q5h2e8RFsTlSnuoaOQby/aye2ucHJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsPrl6bY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66860A260B;
	Wed, 11 Nov 2026 21:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TsPrl6bY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4001F00A05;
	Wed, 11 Nov 2026 21:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434094;
	bh=kH/zOaQeVhdcg5Xef4ASdteo6F0tiwUHB4K8YD2JlYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TsPrl6bY1RlYRjhqw/+hR7a9vasT71eRJETPlmudZ1zw+YsRS0Z61TykgtNP9A9kV
	 DFZ9bmkbRVMd9YSO72SxD+uvhDCoNKMzl7k9KIKtWLT77eYfLBOaO6/uKfPF0u/j75
	 +etMgbHFuMECLcuVKGsofvhvoZjl0llo98sy2qRqmaj1NtbSEm7tHM9Yp3b163OFPZ
	 yZvcFkaG6RJIF4OqGNOEImyzZshKgXVu19xbYVf+trG6vYvfA9UJnajNZZ6x3q1G3y
	 aqD7wbgBRj/rPn9fEJa3tQdci+y5GJlQy7QZDoD1x6kg2uWXB5zNoYiqtbxaW8qI9d
	 RirYz2Dyn9QLg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Sylvain Munaut <tnt@246tNt.com>,
	Andrey Volkov <avolkov@varma-el.com>,
	Dale Farnsworth <dfarnsworth@mvista.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] dmaengine: bestcomm: Defer publishing bcom_eng until initialisation completes
Date: Wed, 11 Nov 2026 21:52:45 +0000
Message-ID: <20261111215349.1983909-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215349.1983909-1-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
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

mpc52xx_bcom_probe() assigns the newly allocated struct bcom_engine to
the global bcom_eng pointer before calling bcom_engine_init().  A
concurrent call to bcom_task_alloc() can observe a non-NULL bcom_eng
pointer before its spinlock and task descriptor table are initialised.

Initialise the engine via a local pointer and only publish bcom_eng
once initialisation has succeeded.

Fixes: 2f9ea1bde0d1 ("[POWERPC] bestcomm: core bestcomm support for Freescale MPC5200")
Closes: https://sashiko.dev/#/bug/linux-0a202799-4946-44bf-b035-fbb2e329e666
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/dma/bestcomm/bestcomm.c | 69 +++++++++++++++++----------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 241a91936fe8..dbc3ce5fc446 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -270,7 +270,7 @@ static u32 fdt_ops[] = {
 };
 
 
-static int bcom_engine_init(void)
+static int bcom_engine_init(struct bcom_engine *eng)
 {
 	int task;
 	phys_addr_t tdt_pa, ctx_pa, var_pa, fdt_pa;
@@ -282,56 +282,59 @@ static int bcom_engine_init(void)
 	var_size = BCOM_MAX_TASKS * (BCOM_VAR_SIZE + BCOM_INC_SIZE);
 	fdt_size = BCOM_FDT_SIZE;
 
-	bcom_eng->tdt = bcom_sram_alloc(tdt_size, sizeof(u32), &tdt_pa);
-	bcom_eng->ctx = bcom_sram_alloc(ctx_size, BCOM_CTX_ALIGN, &ctx_pa);
-	bcom_eng->var = bcom_sram_alloc(var_size, BCOM_VAR_ALIGN, &var_pa);
-	bcom_eng->fdt = bcom_sram_alloc(fdt_size, BCOM_FDT_ALIGN, &fdt_pa);
+	eng->tdt = bcom_sram_alloc(tdt_size, sizeof(u32), &tdt_pa);
+	eng->ctx = bcom_sram_alloc(ctx_size, BCOM_CTX_ALIGN, &ctx_pa);
+	eng->var = bcom_sram_alloc(var_size, BCOM_VAR_ALIGN, &var_pa);
+	eng->fdt = bcom_sram_alloc(fdt_size, BCOM_FDT_ALIGN, &fdt_pa);
 
-	if (!bcom_eng->tdt || !bcom_eng->ctx || !bcom_eng->var || !bcom_eng->fdt) {
+	if (!eng->tdt || !eng->ctx || !eng->var || !eng->fdt) {
 		printk(KERN_ERR "DMA: SRAM alloc failed in engine init !\n");
 
-		bcom_sram_free(bcom_eng->tdt);
-		bcom_sram_free(bcom_eng->ctx);
-		bcom_sram_free(bcom_eng->var);
-		bcom_sram_free(bcom_eng->fdt);
+		bcom_sram_free(eng->tdt);
+		bcom_sram_free(eng->ctx);
+		bcom_sram_free(eng->var);
+		bcom_sram_free(eng->fdt);
 
 		return -ENOMEM;
 	}
 
-	memset_io(bcom_eng->tdt, 0x00, tdt_size);
-	memset_io(bcom_eng->ctx, 0x00, ctx_size);
-	memset_io(bcom_eng->var, 0x00, var_size);
-	memset_io(bcom_eng->fdt, 0x00, fdt_size);
+	memset_io(eng->tdt, 0x00, tdt_size);
+	memset_io(eng->ctx, 0x00, ctx_size);
+	memset_io(eng->var, 0x00, var_size);
+	memset_io(eng->fdt, 0x00, fdt_size);
 
 	/* Copy the FDT for the EU#3 */
-	memcpy_toio(&bcom_eng->fdt[48], fdt_ops, sizeof(fdt_ops));
+	memcpy_toio(&eng->fdt[48], fdt_ops, sizeof(fdt_ops));
 
 	/* Initialize Task base structure */
 	for (task=0; task<BCOM_MAX_TASKS; task++)
 	{
-		out_be16(&bcom_eng->regs->tcr[task], 0);
-		out_8(&bcom_eng->regs->ipr[task], 0);
+		out_be16(&eng->regs->tcr[task], 0);
+		out_8(&eng->regs->ipr[task], 0);
 
-		bcom_eng->tdt[task].context	= ctx_pa;
-		bcom_eng->tdt[task].var	= var_pa;
-		bcom_eng->tdt[task].fdt	= fdt_pa;
+		eng->tdt[task].context	= ctx_pa;
+		eng->tdt[task].var	= var_pa;
+		eng->tdt[task].fdt	= fdt_pa;
 
 		var_pa += BCOM_VAR_SIZE + BCOM_INC_SIZE;
 		ctx_pa += BCOM_CTX_SIZE;
 	}
 
-	out_be32(&bcom_eng->regs->taskBar, tdt_pa);
+	out_be32(&eng->regs->taskBar, tdt_pa);
 
 	/* Init 'always' initiator */
-	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
+	out_8(&eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
+
+	/* Init lock */
+	spin_lock_init(&eng->lock);
+
+	/* Ensure all engine fields are visible before publishing bcom_eng */
+	smp_store_release(&bcom_eng, eng);
 
 	/* Disable COMM Bus Prefetch on the original 5200; it's broken */
 	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR)
 		bcom_disable_prefetch();
 
-	/* Init lock */
-	spin_lock_init(&bcom_eng->lock);
-
 	return 0;
 }
 
@@ -363,6 +366,7 @@ bcom_engine_cleanup(void)
 
 static int mpc52xx_bcom_probe(struct platform_device *op)
 {
+	struct bcom_engine *eng;
 	struct device_node *ofn_sram;
 	struct resource *res_bcom;
 	void __iomem *regs;
@@ -398,20 +402,20 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	}
 
 	/* Get a clean struct */
-	bcom_eng = kzalloc_obj(struct bcom_engine);
-	if (!bcom_eng) {
+	eng = kzalloc_obj(struct bcom_engine);
+	if (!eng) {
 		rv = -ENOMEM;
 		goto error_sramclean;
 	}
 
 	/* Save the node */
-	bcom_eng->ofnode = op->dev.of_node;
+	eng->ofnode = op->dev.of_node;
 
-	bcom_eng->regs = regs;
-	bcom_eng->regs_base = res_bcom->start;
+	eng->regs = regs;
+	eng->regs_base = res_bcom->start;
 
 	/* Now, do the real init */
-	rv = bcom_engine_init();
+	rv = bcom_engine_init(eng);
 	if (rv)
 		goto error_sramclean;
 
@@ -423,8 +427,7 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 
 	/* Error path */
 error_sramclean:
-	kfree(bcom_eng);
-	bcom_eng = NULL;
+	kfree(eng);
 	bcom_sram_cleanup();
 error_ofput:
 	of_node_put(op->dev.of_node);
-- 
2.56.0.567.gdb80ae8cd5-goog

