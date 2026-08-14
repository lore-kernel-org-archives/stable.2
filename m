Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE01B3321A7;
	Fri, 14 Aug 2026 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715356; cv=none; b=kQVFoprmIlkaVTcru2l0KsS2RjdewlTRc2Xez+C4vanIZOiFJSCvVQsUrNgOtWAIt7/BuvdMpkcuDrPRYQX6m08/KDx8rO0T7W6bNehwHa5gLQUkHLcrve/ZQXFCKMDXwO/C6EHecnWUvNBCot/dwi4TUPhwHnO4mRamVKlbZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715356; c=relaxed/simple;
	bh=Zo6nNvLXZkHJvy+NhwUk2vKqm+NT9vWy1+w1nTqbw+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuW1MOvShWdsgaBa7BiXZ4JelCjqvUZe5hdTGWQRcdVLBqZPrUPVk3TalQ/2Fc5ZxeWjKpzGfRDJlgGRaHqKmPSj9h3QLzuvr8yAEbLDW1qiPWrSkkcB5LPe8dwuB1Q9iTCRpmjxZF9UbwqFL4mVOVGRslFgd83pGSqto3Wuq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXb7FoPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXb7FoPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A8F1F00A3A;
	Fri, 14 Aug 2026 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715354;
	bh=ZPSbnE7ok3VTtDDSvAFlFQfBEfyWF6aj5wy17pVCpCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DXb7FoPUJotZBkpP9i/AVLCjvDXtS9k3uxAElAAcuyrEU/pqMwH3D7fVuNUw1VIav
	 xPeAiM7Nfqirz+8IcFe3tuhppFKcZkigy5y9XDAxp0RLg5OJ5OY/SOPNirvC9uNelP
	 +dFos2P92sendXhd3q2ozcoDfJU3UiBfT8O9sR+QPyHrZnOHO2vIoU5T7/8QrcJokS
	 DqXu34cGk01oVOD1mxOqfspzvKrT5ZeVqvDW6ptN337sLN6g0WO3H2E+ClTuloSL3j
	 62Z9MDwVXG8J74AYG8rB0k2+5hY6V5Y74NDU2a/WlykTur2VbAf33FbspS/pPjUWap
	 t3NBRoDktT2vA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv3 1/4] EDAC/altera: Do not allow driver unbinding
Date: Fri, 14 Aug 2026 08:48:51 -0500
Message-ID: <20260814134854.2397810-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260814134854.2397810-1-dinguyen@kernel.org>
References: <20260814134854.2397810-1-dinguyen@kernel.org>
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

