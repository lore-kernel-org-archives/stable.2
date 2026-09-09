Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D85632BE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966000; cv=none; b=MCVvGL6G49gZ0HeTOCWpr+zL3bRb8qyjZipiUNjfFkNTAnCxrKnRq4yq0PrvGRG7tzqOlVZpXLgKhJhfL9uyGnCtU2G/2UurDkJd+TilKVjSKDotpk5TSC6VKuC5kqUrFyYld0XWqxnwnB7Y9GjlKcBvdOwLNTJiDuh9IDpvzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966000; c=relaxed/simple;
	bh=XCgyUWvzw1GhzxJAHjCcGzz6Ys5eFEQZNyXaG3Z2xM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fl7vZbG5gsDD9PAl6jsF/EFPp0cYIdWnHU/W2NfbrFDWS7TrqqDr/8vVhR2B0dsg31H15iuZWNIhe9Cpqv7PR9T5/1nE/wwfzvl8sd0p6/RQ2XGq5iDbukG9JWYtcLZGgDvuxVPAf+nXR4FvpzFUpbPx06QyB5z6iLgisvjK2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoEBIS8H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoEBIS8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17EF1F00A3A;
	Wed,  9 Sep 2026 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965998;
	bh=x4b6ms6JqmGd+YOgH8ODYmL41XkS/faqlxU7e1lYlZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EoEBIS8H/EzGkOClqZuXC6SeW4JMoyIKV/HxQz+ckCPR+NbWPnke9u9D9GWvuWrXj
	 xv2sIf1JcsvaZ5DLIFA3QkynG1+N73brrthPtqV19qrEd5rBo5Dx8LG3+XkDM7fzhZ
	 0t+sooyhDT+wpsWMAwBzVYx4dArHprALZIEHrSbXe3NgcMpbAFDKg91qMBgojG+gfT
	 CbcuJk8o8lxf3yULsEYPbJfFnW1x+YyAaT9oUB43xVZnR4KrR46vE3SLYwMh6p4KWC
	 1yNdZOnWgaf8Kkb/zPY5kg/AGnO8/8lR7xH88jcKT4/JDg9Gjopdflajm3SakqyMml
	 TTWnNAUx/iV7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] platform/x86/amd/pmc: Move STB block into amd_pmc_s2d_init()
Date: Wed,  9 Sep 2026 10:59:53 -0400
Message-ID: <20260909145956.2754506-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090307-otter-shaking-7dc7@gregkh>
References: <2026090307-otter-shaking-7dc7@gregkh>
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
Stable-dep-of: 9cef693bce96 ("platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths")
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

