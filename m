Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891B5540AB;
	Wed,  9 Sep 2026 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788959591; cv=none; b=M8cjE/0ID9ACUEHw7WEEqrYHmOpRezWD7OIgdoBJiF3BFtODHvDk05qafqLYiJXre484aXuX0OP8PGR7x6KxTjpO2BXAKjuj6x7BnRIazX61Xn9OhUW4G+3TCweDyqHuSYaYry0ONUmf/mmGGmtn4Ovkk4qrI8nttzkSoiYzfIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788959591; c=relaxed/simple;
	bh=Cco0eLYO5xHXTcrEHeQMkw1fFhGetnR/HOL25tY05Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7aJlc1lgzUZp6Qmj2vLsz4BPHaWp4RlBgZEqtYLbjTgbqugNDW7kRCM2FnYlhQE1h1cNvngkHGoJQjnWW1AX6KrCSQkuiXVTcsjRnxLhhoByXu1r/puFr3IB02LzzqhIVDRfnY9dKu6XLjTSDQgbG0C8TS5ao5cBdVHQIre5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OabBCNAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OabBCNAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0FA1F00A3F;
	Wed,  9 Sep 2026 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788959590;
	bh=exrp9sOpIrw8gCLYhyGLzFm16RZmIHh9nMD7AtHeshY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OabBCNAEx8zSE+TP2oDCidL0efN3Oy7t7e7v9T4Azc3+UhgIwGKm6KxJKZwVGqHi1
	 5I+8gQ9CHwYydhf0Ix6bPUzni23iNb8iDirKCHPs9MIIHyZOl9lz5nJgTuTy7dbIGF
	 prauwfrLO68//1scK40MV1dmX+x7Z+YcjrTR+7h07B2HvE8Eu2cOaPB5Jn7oO5zA/u
	 77lLXzkUC2iXwj+YS8LqdnuMwJNuezTRFbYNv89ZgMnEwpopKtd1yrftippGhvnzZb
	 gFtq3gI/jkVfWCrRFR54USf13QSZMWV1n0RcJM2Rtgrg6NW76FHFrxDEp1dUzJSlRt
	 TV2Wj3RHQIQjw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv4 1/4] EDAC/altera: Do not allow driver unbinding
Date: Wed,  9 Sep 2026 08:12:50 -0500
Message-ID: <20260909131253.2158486-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260909131253.2158486-1-dinguyen@kernel.org>
References: <20260909131253.2158486-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EDAC driver must remain bound; unbinding and re-binding it would erase
active system memory.

Remove the .remove functions because they will not ever get used.

Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: rebased to edac-urgent
v3: simplify commit messsage
v2: reworked v1 to include only true sashiko hits
---
 drivers/edac/altera_edac.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 68846f583eeef..fe501c89dd0dc 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -453,15 +453,6 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	return res;
 }
 
-static void altr_sdram_remove(struct platform_device *pdev)
-{
-	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
-
-	edac_mc_del_mc(&pdev->dev);
-	edac_mc_free(mci);
-	platform_set_drvdata(pdev, NULL);
-}
-
 /*
  * If you want to suspend, need to disable EDAC by removing it
  * from the device tree or defconfig.
@@ -481,13 +472,13 @@ static const struct dev_pm_ops altr_sdram_pm_ops = {
 
 static struct platform_driver altr_sdram_edac_driver = {
 	.probe = altr_sdram_probe,
-	.remove = altr_sdram_remove,
 	.driver = {
 		.name = "altr_sdram_edac",
 #ifdef CONFIG_PM
 		.pm = &altr_sdram_pm_ops,
 #endif
 		.of_match_table = altr_sdram_ctrl_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 
@@ -517,6 +508,7 @@ static struct platform_driver altr_edac_driver = {
 	.driver = {
 		.name = "socfpga_ecc_manager",
 		.of_match_table = altr_edac_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(altr_edac_driver);
@@ -803,22 +795,12 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	return res;
 }
 
-static void altr_edac_device_remove(struct platform_device *pdev)
-{
-	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
-	struct altr_edac_device_dev *drvdata = dci->pvt_info;
-
-	debugfs_remove_recursive(drvdata->debugfs_dir);
-	edac_device_del_device(&pdev->dev);
-	edac_device_free_ctl_info(dci);
-}
-
 static struct platform_driver altr_edac_device_driver = {
 	.probe =  altr_edac_device_probe,
-	.remove = altr_edac_device_remove,
 	.driver = {
 		.name = "altr_edac_device",
 		.of_match_table = altr_edac_device_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(altr_edac_device_driver);
@@ -2214,6 +2196,7 @@ static struct platform_driver altr_edac_a10_driver = {
 	.driver = {
 		.name = "socfpga_a10_ecc_manager",
 		.of_match_table = altr_edac_a10_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(altr_edac_a10_driver);
-- 
2.42.0.411.g813d9a9188

