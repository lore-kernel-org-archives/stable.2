Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C546A603;
	Tue,  4 Aug 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838459; cv=fail; b=TLqa7pbF4Lx53qT8oi0XONnXUE5en1OTYd8XZlZgGNihlxVwHj78rZq2Djula2oK7bw0AcpKHILfQnsY5kuLYGEMCJgResEaPxqtn/v6d4tGsESQpBgj727y/e8kYB+Gwx2Nk99GtbY08LBHpBwSe13w5tOyWgp8f1C0H/soCZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838459; c=relaxed/simple;
	bh=Iensk0F5/I00Oz+lUVszG7FuDmmf8NxEpcNwIkJOcUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSzXpyO/yWVxIdTIpOdWIJxx4Ls/RO3pCiLIViBiGUkjnQ/e04/KxUelUq+aCHLeeeEFMMzty1Swfz7QVd9YwAGDcO3nyYCg50Q+0r/Kh0tWhGxBA2yh8LfURY0s7vV8Xj6CTq5ntK0IlTTZm71ca+Wn25NbN8lJHMkqi51XKyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e50o08xi; arc=fail smtp.client-ip=52.101.57.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e50o08xi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfTSiunT9ho5XOtQ0pAc9tZYdyYBJOetTg6Ha110vh/WOfulh4x5stDui8zB/BB541PyzXzF7pAgxt+FgR3TInefgNd0SapZUNRvYw9UL9K8sXuOwDTsA4PRHKbDtvq57oOVHzK5NLauN9x1qqjmpI5QcRVnT91Nea+e5JDegjkHN2Eq6y4VjBROQvjfyNxK1no+bluVKVZXEbZr40+0KZ03iU3dKEHYqf1HnQsp+a25LqzqTW1aMBqxyvHb0a+fsXow/pMUNSi6fpLTEe/ZmlB2HzJZbY6AcRznuwGcTd2uCXDZD8lM3pqVRiobHbXa3JiNyafIvPUPIa9g2ohN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuFK8CN/P8iK0SzNQbj8g0zy5MbRNkWrrz5kBJWEM0A=;
 b=eZTY1neuBDaW74uxwTutpIh6yHIx/g+cmgB+2T3xqHT/gaYZ9hp9r8Y8IZzTnchHoYfgmEtYoPPW/t9HvqJXJv5rSdPNOEArYWkrOc4LAbqoTWV3yZyK7CvCIy7N0H/Trc0ekxjkj2/wl8wutFUEo+9QYEQ33Y2m9Bj36ZWUxDJB0GVGO6e8M30hggsyRutLLV/XQoUtgqre+ji10ioMIZYdZ80hPFH24k3CgcXSGeys0IxSi+fCg6Zh6CrQg5f/KjhvRtqTInd8Xt5HljSozuRQRKPBgUSXamlGGoGB7Two78HbEtV40LppN8ot3BboGBwAMqf9AIe4vB6JWuaCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=bootlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuFK8CN/P8iK0SzNQbj8g0zy5MbRNkWrrz5kBJWEM0A=;
 b=e50o08xi1SLecXjYlJzZxfDKYclK94SvM8cbT9rJAO1/mTMusO+0FfcfwJg9t0+lFtot+v05Z9TPAE1BGIfOZFSvvdwGHItDN69rX6B0KQmC+wCNSL97M3YWExSWCB4U6M0K9VjiTj9sxHl+IheowpkM5dxoXd1VoORHsXn6ESSRsfDnY9k1YUt6hwfUaN0T6GFt+So6Yerlx87WJoK6pW9Gs2QI3Z3qw1h+X/FKpVE65f/sek92IwZp0n07FNL1oXpcrX8hOgDlFy/uqTSSO3e6VXzp6neex4pbiIi4eJH0ILyjaMjhz8568ZO/rWwmb5nPym+BG7qxLqYISTJy3Q==
Received: from BN9PR03CA0066.namprd03.prod.outlook.com (2603:10b6:408:fc::11)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 10:14:09 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::7b) by BN9PR03CA0066.outlook.office365.com
 (2603:10b6:408:fc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 10:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 10:14:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 03:13:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 03:13:53 -0700
Received: from build-akhilrajeev-noble-20260602.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 4 Aug 2026 03:13:51 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Akhil R
	<akhilrajeev@nvidia.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Sashiko AI review <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 5/5] i3c: dw: Resume the controller before unregistering the bus
Date: Tue, 4 Aug 2026 10:13:01 +0000
Message-ID: <20260804101301.2975911-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804101301.2975911-1-akhilrajeev@nvidia.com>
References: <20260804101301.2975911-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 7883ad75-2f61-4e8a-db3b-08def211200b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9mlw/99ABzjJ7aWPoWyN/519WkNubC3eE79QJzGzJWC1M5N+qAhJSeox4KjBmBz+v2t4RN3dIxLmK/78GZrltYUQeSWRM6dLed/k6VD0Redi+jn7wgkyjNsa9DK1Q2rFct+J+E4apJOIpHUSbqtCVASKcTgkxM8HdplvYOBU8lkgMEyqaotPhJmhLHFZCeNxXMHqpR3dqwi6ZWfvYu72b+QeoOm+ZFpIyil2gtnBPowdbGrnOHgy/8QdE30ErUZzIJ6nwQBoCTmmA2Keq0LxOOZAR+iFapuDNhmf0Hq0jz6uu4pHM1Yi6bTtj/7/y5B3o8Rsiw+N7qWFE2CGJJq0N2R6IOVuYDKSZsg77FITve0FSYGnvyZQu3YISQzh2BINShua4rlPJDzHGw/cGcnr2Ah4uD3HQK5I89Orgb4ryKe5PhrmhlhqnDqimkEiYF0UtYgrK+MzR0qXL5dEkynElyQNUIRw57SD7SjSDo/TiOcOIPMM0GUN3HdtSlROLwE6/dCQ83sAPVMF6CswOIjRbp/Jlr+Zzucp8NBNUKZDvCTDIUMQ+mDeLDdfH8W/xnS8hUK5z5LeJCr+GKAC1S36HMmJ6Q7mOnGR/jJ5WogCneX1N0jrdUD78JmmAw92UKMffwX+6EwFMtv6DSBWtvPVTlMKedgLQwyPtzC2inP8c35SljyDcguVLrDmgquq2DYg3GLTEe3abevIUQHv3p7hNw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R3yNDz3F8RjvFx2JRnQFhXL4nf/Vddp0ZUIVpy8I1x6lDg2Exx6NIsDVdacu4gRorOLkcdAsEMS8xINkvjsJHb9Hra6NhgP9kPbGmsJYIiyzgw75IgHgUsOPVgmVZoRBJsMM7iqWIrvuX+axANlWXXVgCJi6qV/37yldftVERqH4VET8gKxXOX9U1I4MNPWxWiWmVcKbIunjujo+YGcfobMtrzll3wzjXnFimHlxAWmJ5uM8fDdB0gTBCXnlaQB9PLHrSmvSMlnyAL5cmcJvIh2dtX34JacP2oCQC2EwKvDFAUuxCDlWNX0zYYSGKxMI7uPg0flIzopj3gEhEjmTIOQ5EF4ZnPfyb+9ofWBV6ezL5Mz79ftCbplCpFQAR8BkprYvPnh77YbyU+wl0C3oDofzct33KWtzHppW9//RFcgHDUR5hgClfCA4V93m3bXq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 10:14:09.7212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7883ad75-2f61-4e8a-db3b-08def211200b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839

dw_i3c_common_remove() unregisters the I3C bus without resuming the
device first. i3c_master_unregister() ends up in
dw_i3c_master_bus_cleanup(), which writes DEVICE_CTRL, so unbinding the
driver while the controller is runtime suspended accesses registers with
the clocks gated and the reset asserted, which hangs or aborts on most
platforms.

Resume the device around the unregistration and drop the reference
before runtime PM is disabled, so the clocks are running for the
register accesses and the state stays balanced.

Fixes: 62fe9d06f570 ("i3c: dw: Add power management support")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260728071757.5B3CD1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Cursor:claude-opus-5
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/i3c/master/dw-i3c-master.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 17e1dd4fb5f3..df542ab7744b 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1723,8 +1723,20 @@ EXPORT_SYMBOL_GPL(dw_i3c_common_probe);
 
 void dw_i3c_common_remove(struct dw_i3c_master *master)
 {
+	int ret;
+
+	/* Unregistering the bus accesses the controller registers */
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0)
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+
 	i3c_master_unregister(&master->base);
 
+	if (ret >= 0)
+		pm_runtime_put_noidle(master->dev);
+
 	/* Balance pm_runtime_get_noresume() from probe() */
 	if (master->quirks & DW_I3C_DISABLE_RUNTIME_PM_QUIRK)
 		pm_runtime_put_noidle(master->dev);
-- 
2.43.0

