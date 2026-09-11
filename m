Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5574844F579;
	Fri, 11 Sep 2026 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128397; cv=none; b=m6AL2wCPzMpJpUmy9Jc7Vv1C/oO0MLshpXKQJIKuFtXHVlJ1MQA1Z2sZ11FKUITT2DYx4szj1ydOwJNZ04t+PsB/zEnugYysugc8VnEJc6/MGwwfLKX8Qunk6PS/JIufJJVj9GvgsF3xdYC0zdQovXCrzaec1MWktRq/DnfR8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128397; c=relaxed/simple;
	bh=RNvOEEpj3eKecL7Z7VX+MIMseXV7PqlM99djCsrXoSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMiN/IE++2GiPnDmrs6aqOQXikKlFbe8/Gk+/BLPg5HUZoY6OoVMAznu0971+1HoF5Pn96fcxo2bIT0fwVRe17OYC2GVnnQxM0dCQgLGzUJmVqhrSCHpeB0cjJycZMdsLGgvT++s44rZkOl6E9SQURWQn9tqJ3mCenU40Re7gk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lodwYVJo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lodwYVJo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EAC1F00893;
	Fri, 11 Sep 2026 12:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789128394;
	bh=shz1qQVQ6eIQDjkUYGPiq962KaqWAWjBoEnlAV/h5D0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lodwYVJoQe/6G4hpNOCE0Nytsgz65pqjBCiucbDhCdWyQhO+XmN8+UW1VYS80cNuQ
	 yK4FxMh4aCzsgQvkFn030Dk5yuTrkXDwP48suKWlz7IPZyHGmKW33nik5RdgbqJ33L
	 5rRZYxsf5H1F2dPRC1wcFfDAI/uEl5MkE2J8CHZJiV3u4EsNi/90ejBcG62j0XdMeO
	 94arSax7FV0hLUgPhrzTCd2ooWuATi6051IZ48nIA+mm2h/VCJDYCHBdLRo+S4K9Bw
	 Y5JN9B6V80AWcwjwzZGESX090a/EGUzpV7dS51fJtfWfyNkkO8tx+ffl9IH8O1Z+MN
	 e4Ef2fmvti+tg==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	linux-edac@vger.kernel.org,
	rounakdas2025@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCHv5 1/4] EDAC/altera: Do not allow driver unbinding
Date: Fri, 11 Sep 2026 07:06:24 -0500
Message-ID: <20260911120627.2634225-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260911120627.2634225-1-dinguyen@kernel.org>
References: <20260911120627.2634225-1-dinguyen@kernel.org>
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
v5: no changes
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

