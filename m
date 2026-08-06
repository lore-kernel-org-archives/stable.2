Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2391481FBC;
	Thu,  6 Aug 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031687; cv=none; b=eeuDdrQsZpd8KhGSMhgqaDDEyA9moLNNAzhSnShvq8EYoDWlWSkBW/rKLOG8jiVhlziPsLHUCFMR3xD40kmtqJ0oyJzeuG7rZw26ymxxldNjpElQyGtP4094WkaDiMG7R34qbB3/RWqTRmppHsnrAP6ucGmiQzKzQtGS9wA9FXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031687; c=relaxed/simple;
	bh=cJhild7tj5C4HdDZCSijyw01evpaCANG62VwSL3U4Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1UdNLLcBjvKKNGjFptRGAjruOIHWYvsEqofkHxbfEY5+7wPhQCsbzxzvAlafnNVC900eZna4yOerVQo6ab6ry9ppPUNUlmo57pXr4LPz5eAF4f1WfDqS9/dVMf3MVI6D0RbmJEceSKqv/qnm8xBvuD1rBlyzcP5SiEvNUQiBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4EilNZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4EilNZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2831F00A3A;
	Thu,  6 Aug 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786031677;
	bh=fA/JaboSNDsEZkkigGD/qDoilPwlK5jX0t/qy95nR+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4EilNZyXyQAaS/Rld4UGwWHUy47AINYxRdn9pYzR6/Mv3ar/QSwsHag2oL16JF4z
	 lpaNy+9MXtmn8+wOUspOJf99RrSZ02f4QP8Gwf8kC7htlHcwdeduHz7xPFzfdGpK5e
	 JIL5umJInJnljbhbnqJctqoUd36OS49Rukum/uLuDr7ns267NL+yMtq7UYFIv3h8Fa
	 52CjtdoXD/4Co2YszQe/rWXzHfiS8h5UevZ4kuF6kttVf4e2orRI+l8Qd1C8vhndpf
	 Wukt3eZcd7R3LZZUX8dZxGAhEGPb6lvIXCS0p2p5q7Wt8CJLCVCp6Rv5f3YmwA99ie
	 I6zPWtByrYJiw==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv2 1/4] EDAC/altera: Add suppress_bind_attrs so driver cannot get unbound
Date: Thu,  6 Aug 2026 10:54:09 -0500
Message-ID: <20260806155412.1518582-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260806155412.1518582-1-dinguyen@kernel.org>
References: <20260806155412.1518582-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EDAC driver should not be able to be removed from userspace because a
re-bind would clear out existing memory contents of an active running system.

With this change, remove the .remove functions because they will not
ever get used.

Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
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

