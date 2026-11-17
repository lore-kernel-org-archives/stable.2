Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933557;
	b=UaVvjpOwx+d5dI96qeGpmZ1O5P8TVRc6yjidomyY0R/62adh/JWOUb1UFmNFxLNywHWh
	 3R4uDBzQ/leQdqeE+h85ZswebFhYf3lEJeQshxFOT5B8f5RI5hNWcEI32bkDz6y2EMRJ7
	 LL7yh5NNN0pbhTckK76BFux09sPo+KN2eU2GQlhKTL5ZdP0RjWPVXVaO0oqq1aw/BCr3m
	 4XhJhyJNPzmkCVASUQgdNP9xfOehL3yFK4CJHqb1jyNjmk6dimYe7+WeWg6olg92vesoT
	 eBvKzuiRiSaeJd3+7L1dChuuU3C1D/zsgCv9yADl2qfymtuAJZmoIex1/jrDuCzM6Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933557;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8BqLtJDzty2nEJmDiUpxbvlMovSIsgtxsZD0QmI163w=;
	b=o9eeg09foIf5yS/9mNFwRIMfbfEpi97fLg37arESMlrKmrWObN9wYWo99Lv3TzIjXuY9
	 5oyLtfRKgyBXVL8UT2gLWBEG3z+wd3F73WNcUwSlLigZcPcOEBmZlnE8MKuleVXDmYnbu
	 2Pt6iFuF81WHQe1I3u2k7GpDH9GXAUk25LV6vEvdq3dkG2l9kzbPahAUn0ges3bavlGEP
	 XrX8BwiRylx9h3zSSKEwJQNQpXXoYpFxjVQ6H4hHK/H0ys4bKgTDzD6bH1JX9ohZPLH5m
	 r+B/sFn5s+etQY+619mWg0pGjoKBqwuNbuqZBsN75rot1ZAu8kr71AWsRfKnV+NK0Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSFOngw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283E606A337;
	Tue, 17 Nov 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSFOngw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1601F000C6;
	Tue, 17 Nov 2026 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933556;
	bh=8BqLtJDzty2nEJmDiUpxbvlMovSIsgtxsZD0QmI163w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hSFOngw5PGz823ew2h21SJioirfGurHl9sKQno/VF7K09fGcwOk4XMKYqECbP4IfF
	 jSNFYEKlHsqflPsXc2b0WcqYDlIBw7BUiOWLf5iJUdDBt4qcoaPj96m4FlKT8ydb0y
	 aM/YvDiorskldxawX49MD+Ls8eKFCY71TtWAqKHL7S2/rFZDZll6c/0qggtodQnXdl
	 Jpx+TTV1ymtH6P4ymaAnp+mtKZskgfsbwCrdGfCT+k2l78hr9DnwWHT8DLE+r6K1wr
	 vYm1bx9dqObG7jNaDcMliRsvSBcoNsanEbOjUUjy+qDqnkgeHXbPzpIVWIWeI2aXAn
	 wbTKRQkQqLI9A==
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
Subject: [PATCH v2 08/11] dmaengine: bestcomm: Defer publishing bcom_eng until initialisation completes
Date: Tue, 17 Nov 2026 16:37:09 +0000
Message-ID: <20261117163809.622249-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

v1 => v2: No changes

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
2.56.0.679.gc527c65306-goog

