Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D94B8285;
	Mon, 28 Sep 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790596867; cv=fail; b=a35wrCm9JE+s8BwOrbu6aHXp50Vw8WiS6FLqm798mBt0TDI2uhcOQpA9bRwdS1UVdTtltaR+Y92RW5qcb9Spf5scspyFU2fA672gDRxelvE5D9Sq9XQbObE3YbIgyPRz89Kva/uT6sUDppoNHfDDT1e5Aq74cRBo41jAHxe6Kmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790596867; c=relaxed/simple;
	bh=w0Nm/d4oWM/9fUHq8MNvF3XJjlCY20QHAymNb0i3Z+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXV/s0ENJwNqQaW83w/ZZM8/ITwN571HxwE07ilNlMnUlU4IybS/9cAy4RiQpHDhsPaNqgT8tfs4cqTIhAyoJzmnhbpmV/49iYJt15fxOtfdlTJTlPh0UyHQnZs17LskYAy4HHm/yPxG/sUoiG+VD/DPQU2SuQv95X11ngqYCdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dWRX7uZU; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dWRX7uZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmJ4s9sKZP5tdrsKD5ZYeQKm7MPC/sZyt+a0gQodkWR7Fbrdabu4NPpgzkAobArQZkyJ4Y87AzI+37tETRCbGJECdA4FFHXdgQXUqxjz0bURk6rc3QltuCN9TDRklmpaDysAw69QMl30ltHhs9Uxf+y4/O2M9xoYASN17zzIZ8j2sPJM8BD9O8z4sRW/drHioQ1fm9KQfUf2L7dYN6n1PkLAFFDNQ3J6/jwwLHeAFRa7PnpHERIiCCRm8PzoZls5sXv//asUKBFV6kXPnJvcOOhoGkRkkr8rWJSvktMmSDJanTnXeQAAsjwI7aYkfE4UuURQwyJtc6oqs0p57sgq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mRtwJBu5tb8Ms07j2cc24RSCFcqnLzaKZlIEpcLSr0=;
 b=uWQF7wOgIfue8+iSqtBg6hsVYW+XcfwJQ7Jy64okkpmId4ecy9Gw7N2E8ddvXrreR2F6yYD0Y3qTlr9VC7Dw0EA19FV4fZ3PWlHHdAw1cqPv48XVbf7tEpyOORYh7WinRvDdKy5yTa9qCKuK050ljAZYJ/mTBTJzu+ByqKaDZWyj0BaK9YYdnJVjdXyx+YwhR2ioemIBnMgfnyqeBzuYCKTRVd8M21B4yiKOaPtSXFWmHXAuWuDzMV3TsfVINcyKmy8yh5YN8sl0hM7WX/d9yN+nlUSbgKLHFr9Ih/YjlbabLIkAlE7YMAfvgv6wZVYT5WBn9ur0DCImyzWuKyv/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mRtwJBu5tb8Ms07j2cc24RSCFcqnLzaKZlIEpcLSr0=;
 b=dWRX7uZUNeqHEfHMlaiUax9Xe35psKly9a2Mezv4F+wbn6xRcFCIzcO02hIDbDo9erTCr5aVIw5UKyCFpi9XxxiuwkoP5nYpui3mugpFzMzPP3Wef962OSdm0LYsDBgnzC84fVi8XQEk20cNQRve+W+c8Fgm7/iPu9iFJJfEvfY=
Received: from SJ0PR13CA0070.namprd13.prod.outlook.com (2603:10b6:a03:2c4::15)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:00:59 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::71) by SJ0PR13CA0070.outlook.office365.com
 (2603:10b6:a03:2c4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Mon,
 28 Sep 2026 12:00:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 12:00:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 07:00:57 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 07:00:55 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>
CC: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/3] usb: dwc3: xilinx: fix system suspend and resume PHY handling
Date: Mon, 28 Sep 2026 17:30:13 +0530
Message-ID: <20260928120015.3152461-2-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
References: <20260928120015.3152461-1-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH3PR12MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d4fa99-0cb9-40de-f0ca-08df1d5828eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4KPCKYZhFCoZWRZ+K6ZRGZkMl3cM6xcDcTj07losK+/7hTfdOb8VWOYkh2oLwRb59d6GIPk8iUiaPYZ0cMWsS0Od6DZrfnuEXNnO41DvHZJz9bWxGSKwQUb6XdbjjDIClq2ylVA6Nfo4x1lytHY6Qn87oUhNLE5SgF3o/g8Ynpy/qefj26KW8bY+D7CAnD3vOwxyKCz97hVpG6MpOMXxmXiZFx1A7QUuCTfX73xcJcg9ZWPWn3W+P/6BkrVNQlQOC6UgUHIuJrSJLJl+3y6lWNfHHVFPcHjuAR+D7tWMh+wxBLxYlSO5hlsoqIYTcgxBr8Aqo5vIylIQ6YUbxbT/Fp/+CM7z9Y40xdt7Wig5y5mm5CmrIsYCHWYVrWEZWDg40C/w7BhCuGh2xH4NeWVYJnwnDNmQ93Q+d954gzd+M2dcnP7FzZ6IC3Qpw9QLmtXNvoCpLLVREm2b5sbfB+inwWDDkqAR6g26xgJxjNapVywsJNaJiB2OR0lNE+aCsZkP1MBQVOy8KHU5THr0VRjmQ87UvN7yoL6L93cMP2jUNFdHRiMSDkTRHshnqfNfSdGsJ2mR1oFZReKdmNV2f2rV7AdtsPTfvapUtTRDKTPy9TWXHtcczmJdRT9Th4Oyib1rSLQGGTt3O/+QgJoBpi9y0wrt11KB6YJ1moFInp2iCGpUou5O/y989fjcXTwZjD6pi0TY7z/tBs+LhA79/3et+g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UMWINsQ9jAvfdCLAUqV2fBCx2RDFl8vRnb50wxDhdVxtsxiZLejR9L1CzAc9jCkjlH/zNk1KE3JxV9XIWAVGbcp+k4yapPryPlc/57bGLVpOAolxUOsGHvKOXZEq6oIqf3aBqPMdIj3v28Gmq/kH+dz8PQGRlQZZWmhMhBAJKp7FekQtXa0cCPe5W7sfmkSlYbe76iSIL1hbLugPEm0BGMs7471g1esw1ytjKhxF5i3UsqmznRmlp/kkfGkMfMtxqJ/bcNVAeA5jxgQ+e0yeHG+X1UmX1K3eu7hpsd5m3mOCVJFbYRawP22VVhA//TiEbk3++XDci9B1vLgizmTB1/ly01THGzLjxM1bhr05tZyXfRIG2Hr1rEiuBM2qkpPddrKBn4UhghghZu5GwbvNOIpj/mLJ7lM39PwGe7CqhKhhmzI3d0Ei979pG8MMDdnd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:00:58.9500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d4fa99-0cb9-40de-f0ca-08df1d5828eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073

System suspend and resume error paths do not handle PHY and clock
resources correctly. Suspend calls phy_exit() without first powering
off the PHY and ignores failures, while resume can leave clocks
enabled if PHY reinitialization fails.

Propagate errors to the PM core and unwind resources to ensure a
consistent state on suspend and resume failures.

Fixes: d6edcdc1ef06 ("usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in v3:
- None

Changes in v2:
- Split out of the combined five patch series so the fixes can be sent
  and backported on their own, per review feedback.
- Reordered ahead of the platform-data cleanups.
- Log a failure of the phy_power_on() rollback.  phy_exit() leaves
  init_count untouched when it fails, so if the rollback also fails the
  PHY is left with power_count and init_count out of step; that is now
  at least visible in the log.
- Added Cc: stable.
---
 drivers/usb/dwc3/dwc3-xilinx.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index b832505e1b04..8c63e02575f1 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -383,13 +383,26 @@ static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
 static int __maybe_unused dwc3_xlnx_suspend(struct device *dev)
 {
 	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
+	int ret;
 
-	phy_exit(priv_data->usb3_phy);
+	ret = phy_power_off(priv_data->usb3_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
+		goto err_phy_power_on;
 
 	/* Disable the clocks */
 	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
 
 	return 0;
+
+err_phy_power_on:
+	if (phy_power_on(priv_data->usb3_phy))
+		dev_err(dev, "failed to restore PHY power after suspend error\n");
+
+	return ret;
 }
 
 static int __maybe_unused dwc3_xlnx_resume(struct device *dev)
@@ -403,15 +416,20 @@ static int __maybe_unused dwc3_xlnx_resume(struct device *dev)
 
 	ret = phy_init(priv_data->usb3_phy);
 	if (ret < 0)
-		return ret;
+		goto err_clk_disable;
 
 	ret = phy_power_on(priv_data->usb3_phy);
 	if (ret < 0) {
 		phy_exit(priv_data->usb3_phy);
-		return ret;
+		goto err_clk_disable;
 	}
 
 	return 0;
+
+err_clk_disable:
+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
+
+	return ret;
 }
 
 static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops = {
-- 
2.44.4

