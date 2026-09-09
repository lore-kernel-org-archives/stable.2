Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5D5476DE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971202; cv=none; b=qq79n2Edph/xa4e9JLR6OEgEcBJ6M5KfazSgFS2kYDffWjQaqxM1ESXU8Kx5kdFT2I8MF6aJGM8Ot/FSJEgcNFuhnITfNiuM8Ff5HvNwikOjHFoOhMvH3TVj1ZSR0YVqrN7aTV5XUolxSKOd6+DqDT/v/yCZVINz3q5hvbL2Cmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971202; c=relaxed/simple;
	bh=pJjuLblbxzk2gjOti0iGQHAeP825ndXFfutj2TKcNng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llNpK5Hzv7l6SgnvbfAhXN+Q0dotuqeJER9oNulCKTA3nMwCWpN7gfzEb5rrt2pXZWxAgdpydCqMjMSnGZH67UxwvlXX/g3/nrX65HodyMzmO5gV9o93kp2un5WesktCSIWXwtlxPDCIc8yfsB8zu1dFuzLRlVvhhpsZfo0Zdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrCjWT/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrCjWT/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040921F000FF;
	Wed,  9 Sep 2026 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971200;
	bh=6hKmcydaZtvTd8Og09yyTg7h9/tCcu1Rt+ZGF0P6Qpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrCjWT/dTC3r+/8OGESavgSDFp3Lhlt7PYeg0t6GcUP8TpGkVc2m/+PY67jR1c7r6
	 hpD+hBa5blS3CI1LK+5zKf5q9tBRx2B/ZXOl/RCAWc6dL9buFhJidQztTiUPoLJOYg
	 o3SdtD4D4LACuJQ1jRM4OtUXWeCk79xdAX7fX+F5j+yLKQfAlqoAK3M9OFJ5TkQyB8
	 Vqh9eU6ykqvDGkMWoA2/hwQnwLZ54QAlFhsAVqQh0qPub86Me2A3sWgbDwVNVuz7Hs
	 yPMrc5XpGYg/4WwbsFcFApgY3+G/x//3a8oJ4hUbdMyjBDqLKQECznhFu4lh4ScUVs
	 /v+LJAhdCHBHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] platform/x86/amd/pmc: Move STB block into amd_pmc_s2d_init()
Date: Wed,  9 Sep 2026 12:26:34 -0400
Message-ID: <20260909162637.2981292-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090316-rogue-eggnog-a086@gregkh>
References: <2026090316-rogue-eggnog-a086@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 83ad6974dd3bf34c080b3c08d36d02ebc3bd6da8 ]

Transfer the support for STB-related file operations to the
amd_pmc_s2d_init() function, thereby consolidating the STB and S2D
(Spill to DRAM) functionality in one location. Also, relocate the
call to amd_pmc_s2d_init() to occur after the creation of the
"amd_pmc" debugfs directory. This ensures that the driver's root debugfs
directory is established beforehand.

For older platforms that supported S2D, exit immediately after creating
debugfs. These platforms may not support the PMFW messages available on
newer platforms. This adjustment is necessary due to the relocation of
debugfs creation into amd_pmc_s2d_init().

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20241108070822.3912689-2-Shyam-sundar.S-k@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Stable-dep-of: 0225c1d63768 ("platform/x86/amd/pmc: Propagate SMU errors and validate S2D address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc.c | 31 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 343f75eeb7f28..91d164a3ca3bc 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -657,15 +657,6 @@ static void amd_pmc_dbgfs_register(struct amd_pmc_dev *dev)
 			    &s0ix_stats_fops);
 	debugfs_create_file("amd_pmc_idlemask", 0644, dev->dbgfs_dir, dev,
 			    &amd_pmc_idlemask_fops);
-	/* Enable STB only when the module_param is set */
-	if (enable_stb) {
-		if (amd_pmc_is_stb_supported(dev))
-			debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
-					    &amd_pmc_stb_debugfs_fops_v2);
-		else
-			debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
-					    &amd_pmc_stb_debugfs_fops);
-	}
 }
 
 static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
@@ -1069,6 +1060,18 @@ static int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
 	u32 size = 0;
 	int ret;
 
+	if (!enable_stb)
+		return 0;
+
+	if (amd_pmc_is_stb_supported(dev)) {
+		debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
+				    &amd_pmc_stb_debugfs_fops_v2);
+	} else {
+		debugfs_create_file("stb_read", 0644, dev->dbgfs_dir, dev,
+				    &amd_pmc_stb_debugfs_fops);
+		return 0;
+	}
+
 	/* Spill to DRAM feature uses separate SMU message port */
 	dev->msg_port = 1;
 
@@ -1187,12 +1190,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	/* Get num of IP blocks within the SoC */
 	amd_pmc_get_ip_info(dev);
 
-	if (enable_stb && amd_pmc_is_stb_supported(dev)) {
-		err = amd_pmc_s2d_init(dev);
-		if (err)
-			goto err_pci_dev_put;
-	}
-
 	platform_set_drvdata(pdev, dev);
 	if (IS_ENABLED(CONFIG_SUSPEND)) {
 		err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
@@ -1203,6 +1200,10 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	}
 
 	amd_pmc_dbgfs_register(dev);
+	err = amd_pmc_s2d_init(dev);
+	if (err)
+		goto err_pci_dev_put;
+
 	if (IS_ENABLED(CONFIG_AMD_MP2_STB))
 		amd_mp2_stb_init(dev);
 	pm_report_max_hw_sleep(U64_MAX);
-- 
2.53.0

