Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB9370D47;
	Fri, 21 Aug 2026 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326710; cv=fail; b=H2oD+RkJ/M7BjNXDGnc8GCzZYqsNYfnDYjoQNQIIqV4r4Ie1AK+xTU6cpM/Cr2I8OSFcv+VNKOGvClk2bccwn9wuRZh49xOSywWmzSVA5lBSuXAjULyFwI5ljK4xQgurQhMYawd/ozoypiaKH1HFKbdD1moOO3CUClfg5I1aUe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326710; c=relaxed/simple;
	bh=eL0+ahRMgBGMYxrnEm45JrTjpbYGo17KdRAypV5sNbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFcT869oOLRay/PlZrCmuCiout2HSvL4uX/UT6p1CaJwDYRy+5y1jb76ocxL/SVyqL2wx8NQjmeUntOMzRZgqtz1nA966jkRkqbfM9TVE5ZN++AaO7WBEULOgV5GUwcRX0+qU2hA0e2KLjGjGu23Zto2h3Bdg++BMv4aFLkQFk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMtpETt/; arc=fail smtp.client-ip=40.107.209.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMtpETt/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZE6sRnBKM2RQ5f6Mbhb4FH+pPU+ZqWgvKUP1+ogRAH8U1cUgbfbn72betCXT/MQYIwAzWdbX1qV3qAA4Jm7sLAjjyP7Sd+s+7wjYg6RmCE9N9JgzqcAJFCRHjfc88I4q31lwxRFNgeXcdgrMau+BSEVhILqw9+JFespqDyCOBhfPDeRkhBz1/5eXOjurAAQBTKWiF2vGdf00HHVfzPixCNiX90eQnAexaxxSu5H/OxFHeNq9R9ERMm2LzjWOLNBhgTfH+m+1W4JhTji3BwX9SUVqWM84w9LDRBp2M4Tvm5/mA/Y2vI46WHAED8nkmtW+zEIk0BZYMN8UZhNXCd9Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X79Jv93XsOzxUYNBoFUbfzirCGnXFwBg/vsrEQt0Zq0=;
 b=jkLPzQV9tbk+VPTpiyfbwruqIIJu9i1MpNWdagM0WByFOOgaiEF4XTC4+YUrWbihHJFbhh3OCcVeceSMqeGsv0uWCa2jqW6Wrh1rj2YjV/4MrzQCkpXkdscF8OgKMcTdTSUJCDOPYGegMIIWDooe/rVMxoW74oDmdl0SRwdBMxFPl0wxukf3AXdnZLfQpd+vvtz4yN8dIvesJRc6leuigSDs3Y7JmGHXd2LDjXkPQaHsDVrpwQqnQDgKFWFcCq6KQXdcfWQX9fP9PKurB57zh2ipNFeUd1k3x2mzAdsQbnGYGfoFx2R4goo947wN+vT+IByhi4AhU+fSNgauYNDJWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X79Jv93XsOzxUYNBoFUbfzirCGnXFwBg/vsrEQt0Zq0=;
 b=oMtpETt/Zfb0l93o7x8u42aDFNwpa8cA54nE2lhUY5GkC1axUgcHRlC0mcMbe8NwjSr+Ti5jynmNhZ+jn8cfhW+9SIrNC9J66W4dCvcNm9vb6ed0r+t09AqUKUkGTBwpQ+NtsnjfIlSczTlj53RrUjh38h9rszJVzGkyQJjwc5gVv4qb8ACNUvXnaEAgGmjM4I2cm1rx4c27mdF46r8daXPylF4W6Q1BKQmlH/gxiAkIWjsUnQclxW1bNOUIOTLpDM7Nb6Sk9HlfHE6u0Kp5yjQKLlgyKqP16/bdNN1DR/6Vn7FCO+JBhf7t87w16rlbgJVG+BauTi4V1f0h8aOotA==
Received: from BN0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:408:ec::19)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 15:38:25 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::4e) by BN0PR04CA0104.outlook.office365.com
 (2603:10b6:408:ec::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 15:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 15:38:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 08:38:01 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 08:37:58 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Thierry
 Reding" <thierry.reding@kernel.org>, Sheetal <sheetal@nvidia.com>,
	<peter.ujfalusi@linux.intel.com>
CC: <linux-sound@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Jon Hunter
	<jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: tegra: Fix the MIXER enable default value
Date: Fri, 21 Aug 2026 16:37:32 +0100
Message-ID: <20260821153734.158426-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821153734.158426-1-jonathanh@nvidia.com>
References: <20260821153734.158426-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a24bc1-baa1-436c-4e50-08deff9a3d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	PrHV8X7m+uftZIQUnQG0YC/A7D5Iy0OaWDAnDlXA7qDng3LNqMhFj02E9yHumNfJkFw8AHDPe1lmaekQomAbo+7/O+WQzpmOyjlLCDsH9PM8n9JWMD/I1p4axC2F/vPHHu8aicFUESWS3i8UkRYyIFGhdo+VhPrHbC/HDuVWgBo31at3nV0KeTQlETE9FwOtAvnpRSN0roTcBhKIvLLPG2vteF4ZHUt0v8GqxTjDvY0enelTwqy2VzOaW05JVMminpLAo9Otb9vJySDdX3GSCk4TplQ6U3TYgs92/vloxTZMtOCFv3ESwMQq6+1571+rAynYSgZLEkNi4eP+Udt2sv07mBLMD0yqNCtO2YSxDFjFNvF2YKcAwaSbZVgoqIjbaPdI3c+KxrXuBJmvFU2x+KQJWSzaWFw0x2Jxwp9KYbFI7NJLTXa9ZgFE6wy0npx8Hweejopa0zpZF7DhGAGwyRV2a/amMMC9KV7yXNdLelYu7QZxXMFnrQ9Lh/u1r34W3IBDW7t6C5sh0my/3HkcmU301b1nMa9MWnaSpIZ1eLpW+UOSuL9BaEHiBb5x47XYzUucfXBRk4/6E/H7PdnZ1F5sdZsXJOl1EorlZIm8GP6j6OsaSsV7ouHkwJA01sdYvC3+ho5dCwUYspjOkv6tuFGVkncP5HbSnXNT/AubiQsC5HDAjK/zyZ80RK2h4M28phTf6a+nk8WhhJvOY4soqQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hrj8GxHcrsJHGgRyH+qUU/dJCcWzH2c8vtScVFkaQtakMzifA7EU99b8+LZarCqAavVdur005DxbnO4eCU7b/tHwfczTVNHHQeUNXqfD24qh5Q1vcKxjDg0af4wKB4aC13OdHNy9qyEGuupNla0Rr0J0STUG4CR5eVdCUAGUotB82fYTi6LqCagGobOnLDp+BmGrYR4d1jhTs0bsrvhwxO3XsCJp4VrIXc6iq/KgfRDPzlEEBu2Q6LInKe8xyUMVAq2y4qucT4L/ZsdQBHDLTJ7zRNYET7D/c5cJz9/XIhGHdv6Arv6TxFiPCEaztGVIlZNT4+sUEs6CojsCWzgAXI8oznGG8aKGmKnhTsj859/Iqj8oVSLqn89uToiPayKK7Mm1Rr4ODOt6O312bTYa1DZsJvVmM6SuOWfXGJy0BBWkH1oTHW1OXeyAVZTce6Dm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:38:25.1578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a24bc1-baa1-436c-4e50-08deff9a3d69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra MIXER driver where
the register default for the TEGRA210_MIXER_ENABLE is specified as 1,
but the hardware default is actually 0. After this commit was added the
MIXER driver is no longer working and so fix this by correcting the
default value for this register and explicitly configuring the
MIXER_ENABLE register when runtime resuming the MIXER device.

Fixes: 05bb3d5ec64a ("ASoC: tegra: Add Tegra210 based Mixer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_mixer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index 8eb4e54b954b..96259a6cbc59 100644
--- a/sound/soc/tegra/tegra210_mixer.c
+++ b/sound/soc/tegra/tegra210_mixer.c
@@ -57,7 +57,7 @@ static const struct reg_default tegra210_mixer_reg_defaults[] = {
 	MIXER_TX_REG_DEFAULTS(3),
 	MIXER_TX_REG_DEFAULTS(4),
 
-	{ TEGRA210_MIXER_ENABLE, 0x1 },
+	{ TEGRA210_MIXER_ENABLE, 0x0 },
 	{ TEGRA210_MIXER_CG, 0x00000001},
 	{ TEGRA210_MIXER_GAIN_CFG_RAM_CTRL, 0x00004000},
 	{ TEGRA210_MIXER_PEAKM_RAM_CTRL, 0x00004000},
@@ -86,11 +86,15 @@ static int tegra210_mixer_runtime_suspend(struct device *dev)
 static int tegra210_mixer_runtime_resume(struct device *dev)
 {
 	struct tegra210_mixer *mixer = dev_get_drvdata(dev);
+	int err;
 
 	regcache_cache_only(mixer->regmap, false);
-	regcache_sync(mixer->regmap);
+	err = regcache_sync(mixer->regmap);
+	if (err)
+		return err;
 
-	return 0;
+	return regmap_write(mixer->regmap, TEGRA210_MIXER_ENABLE,
+			    TEGRA210_MIXER_EN);
 }
 
 static int tegra210_mixer_write_ram(struct tegra210_mixer *mixer,
-- 
2.43.0

