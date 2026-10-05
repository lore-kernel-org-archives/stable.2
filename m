Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE544AA1F9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210830; cv=none; b=oI7yu05h3UCuB2sHBNloAMB4+CRh/24nogmiJcYPRl1bfkVNG7c9y1wc8mcJkQ9Z50r5RB3QrFlVcewSH77U7RRmLZevTVRUbfj61Y5kuD9vqOVEs7NCvklvo+05dJJMHpPuB5E8IubIISRdJrav69AcSC7jZ2RAGuiH/7KxFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210830; c=relaxed/simple;
	bh=ahxgk+v9yQVPXD76LUByGNoL+KZpL9mQgW2TV5H+D/E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gha7U/lfupEJJ6OdVZvTyaQy2j2b2ufgBBQFhPTNBxKy48MhkhNNJyCvRHJFZSmT3cdkMHMbHCk5VGka35kwMWI76p58a8SH0TtZKqtmsAI8MpP6QC4RydLEjzv410mLllGu77Y6PohVvfqniHhjKXrGtJwTjo5CwgcX+0438XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lLMD8v+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lLMD8v+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177891F00899;
	Mon,  5 Oct 2026 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210819;
	bh=LrePJzaXojILQ4beYV6dbS1rbkfa0R93pHwrKRZRMX8=;
	h=Subject:To:Cc:From:Date;
	b=lLMD8v+mI2Xk/VvQ+36BIsfJrXDpKG+B1SFNwk10Srq0/pldtDPJBApHGXesnV6wG
	 35uc4i2NsI+OVgzmP7rbESlmIyw39HmlkJixJbzAe1Dv/AA2TgMiigvx1XGz84f3X/
	 yHhl1hoRJT3m4RpdCp5/V61SMZM9/Yg84aYlG9y8=
Subject: FAILED: patch "[PATCH] mtd: spinand: fix NULL pointer dereference with no ECC engine" failed to apply to 6.6-stable tree
To: nuno.sa@analog.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:33:21 +0200
Message-ID: <2026100521-bargraph-feminize-2166@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x b890e6163761ddb580cc74f43e15f8bbde15647e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100521-bargraph-feminize-2166@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b890e6163761ddb580cc74f43e15f8bbde15647e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 16:07:17 +0100
Subject: [PATCH] mtd: spinand: fix NULL pointer dereference with no ECC engine
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When "nand-no-ecc-engine" is set in DT, nanddev_get_ecc_engine() takes
the NAND_ECC_ENGINE_TYPE_NONE path and returns success while leaving
nand->ecc.engine NULL. The SPI-NAND code nevertheless dereferences it
unconditionally to test for a pipelined engine, so probing such a
device oopses immediately.

Rather than open-coding the test three times, add a
nand_ecc_is_pipelined() helper to the NAND core that folds the NULL
check into the integration comparison, and use it everywhere. Future
callers then cannot reintroduce the problem.

Fixes: f9d7c7265bcf ("mtd: spinand: Create direct mapping descriptors for ECC operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/ecc.c b/drivers/mtd/nand/ecc.c
index 6ccdff3fc913..1d809cbd47e6 100644
--- a/drivers/mtd/nand/ecc.c
+++ b/drivers/mtd/nand/ecc.c
@@ -159,6 +159,13 @@ int nand_ecc_finish_io_req(struct nand_device *nand,
 }
 EXPORT_SYMBOL(nand_ecc_finish_io_req);
 
+bool nand_ecc_is_pipelined(const struct nand_device *nand)
+{
+	return nand->ecc.engine &&
+	       nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED;
+}
+EXPORT_SYMBOL(nand_ecc_is_pipelined);
+
 /* Define default OOB placement schemes for large and small page devices */
 static int nand_ooblayout_ecc_sp(struct mtd_info *mtd, int section,
 				 struct mtd_oob_region *oobregion)
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index bea352dd82d7..4fb769581595 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -526,8 +526,7 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc->info.op_tmpl = &rdesc->info.primary_op_tmpl;
 
-	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
-	    req->mode != MTD_OPS_RAW)
+	if (nand_ecc_is_pipelined(nand) && req->mode != MTD_OPS_RAW)
 		rdesc->info.op_tmpl->data.ecc = true;
 	else
 		rdesc->info.op_tmpl->data.ecc = false;
@@ -621,8 +620,7 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 
 	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
 
-	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
-	    req->mode != MTD_OPS_RAW)
+	if (nand_ecc_is_pipelined(nand) && req->mode != MTD_OPS_RAW)
 		wdesc->info.op_tmpl->data.ecc = true;
 	else
 		wdesc->info.op_tmpl->data.ecc = false;
@@ -1279,7 +1277,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct spi_mem_dirmap_desc *desc;
 	bool enable_ecc = false, secondary_op = false;
 
-	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED)
+	if (nand_ecc_is_pipelined(nand))
 		enable_ecc = true;
 
 	if (spinand->cont_read_possible && spinand->op_templates->cont_read_cache)
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 09c8c93e4dba..6936180b6ea5 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -305,6 +305,8 @@ int nand_ecc_prepare_io_req(struct nand_device *nand,
 			    struct nand_page_io_req *req);
 int nand_ecc_finish_io_req(struct nand_device *nand,
 			   struct nand_page_io_req *req);
+bool nand_ecc_is_pipelined(const struct nand_device *nand);
+
 bool nand_ecc_is_strong_enough(struct nand_device *nand);
 
 #if IS_REACHABLE(CONFIG_MTD_NAND_CORE)

