Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAE241A54B;
	Mon, 27 Jul 2026 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158677; cv=none; b=f0j3Kln2FxyxQII3+0pmeHhp9toNkLptUNG3nDq1tRFrxId51dFJOZvPIvigY4JNNBrAGWMAxYjv+2nAcAovJQcUNke8dbGD02+cPQdLFAwKvI+JstbAxJaCQsrWEtMxxpcMiFfKPXVf37BcJk5SFVXexmCZwqdojztPWVPVwE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158677; c=relaxed/simple;
	bh=QrjWPoi14NenNa9D/rKXI2dfihpmfapF4mYbQhr17B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRUPYksnkBOMOQFJB7YCQiY36aC/ImxsdZsjwK0qNaySSiKiCex1p0tUOvBWcjpFqw1xTKjL2SPu8T03xaLyk5grJ2sZ4h7k/lU4L6jAEwX3Wc6M1vW2osb07vW+CNEqfSK7UHVXTsEB0hKSwoQ1jFp4XtoZQLzEVJZTHCLlxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6yMRjmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6yMRjmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D381C1F00A3E;
	Mon, 27 Jul 2026 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158676;
	bh=m2Cuzi0UE7YmALTWln32cW7oVGcDVVOZKAlvyTR06po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6yMRjmC+v9c2korPUaHC7YRHc/rpitutaaDXC/ECu/P2an+xM95+Jnz7+t76oI9f
	 ftqUXVzFxmKPilz5yh/kk5bi5WHDkZLYR1vuirDnaKhMVmfvcvQkE3+N35NlDmkTDY
	 1q2upiZbXbZHWYRZYLtdQ6nxlAg+773mpcCBC6Duaf9NsqrRWZwAKxo+YJQxHBWT3+
	 O6E1PZ2tC8+MomXGrOVo83ML0S6I7fs1VXASC2xmXrZdgTBcQoC5PZwTiVw+PL74jC
	 /pXsBZ6mPiv9aUZ5xOccxaTUdsExGLoTmWEcwVkUgUtv6zzbLz/yA1RUpcAh67yRBk
	 WwnqWquNTw1fA==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] EDAC/altera: Add suppress_bind_attrs so driver cannot get unbound
Date: Mon, 27 Jul 2026 08:24:12 -0500
Message-ID: <20260727132416.807230-7-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260727132416.807230-1-dinguyen@kernel.org>
References: <20260727132416.807230-1-dinguyen@kernel.org>
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
ever get called.

Fixes: 588cb03ea208 ("EDAC, altera: Add Arria10 L2 Cache ECC handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 09e040b244673..cd2c2d11214d4 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -457,15 +457,6 @@ static int altr_sdram_probe(struct platform_device *pdev)
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
@@ -485,13 +476,13 @@ static const struct dev_pm_ops altr_sdram_pm_ops = {
 
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
 
@@ -521,6 +512,7 @@ static struct platform_driver altr_edac_driver = {
 	.driver = {
 		.name = "socfpga_ecc_manager",
 		.of_match_table = altr_edac_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(altr_edac_driver);
@@ -823,22 +815,12 @@ static int altr_edac_device_probe(struct platform_device *pdev)
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
@@ -2253,6 +2235,7 @@ static struct platform_driver altr_edac_a10_driver = {
 	.driver = {
 		.name = "socfpga_a10_ecc_manager",
 		.of_match_table = altr_edac_a10_of_match,
+		.suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(altr_edac_a10_driver);
-- 
2.42.0.411.g813d9a9188

