Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7330DECB;
	Thu,  9 Jul 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590645; cv=fail; b=CkOgAG9WgSFELMlvC6ekf+0XmGCLA2dbY3qzwz5TiCA5oZihBviX+ZfYHXzlEV9bmBdRw50Jye5vCR/MLzf+rKNd/NjDWVlLUpcpPuociKutrcjHhJnG7OigsQ8wN1ZOKCthAkOQrFEpSrC8++0qTWOaYJC2Qig13L1QWFGsZ5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590645; c=relaxed/simple;
	bh=F+RWTw1VJCTaYwXOHQd3982oNXLENfo+5LHl+V5Q6kw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NPruLC9OuC9Brs+nmjU6plUStqXKv97pgscoEhNTNt/Bpw7b9rx6qiBhsGJaOMaY5D0wXAqKOrGFo1RghC/ATenfV6tDM5KJb1V4ohPwGqmDYdREjtEr4Qw333jAf8kzdCdt1iv01beL9FktjyE0TTlbp4GSCj6s2vqinr20n0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hHW9cVPy; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hHW9cVPy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dX7IeP5f9Ro+UbtdKG4v8uZ1hfB5WjqtNGtH1noa/Zcw4d4j0mVkQ931mol5CXWRRlNkT5Uf0ZqrC9Syjm4jNRwlFu7s+Oj0FQwp8bnOaMGdZTEEdtaE6A/RVs5sAMykraY24BLpxMcYF2nTcxPlI0x8lbZPxHV9xyBoOx6zIzAB7XMUgofNOJG1V7O2olhcPsEDTxUFF7am9G6Iz/9Twv6U/XoARjN9wnrv/kzSC2h08QJg80Hscs8PH+YiQ/j43JkGSHpGcrsP8CvGvGSYvb5bNO87bqFr9srwP8SSlJ6Rxy86ZA68VAoiu8xKWOKhhtsGJAZmV2A/UztyNrkRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSc3wQj2/msW31q2W3GqYS9i4t1ZLOKilbTIuskZrRo=;
 b=TZyqiX4ap66rpoGg8hAnalaeSF9vbZpz4O17MPIqrtyBbJB+ojztiSyh6EFmvrsSuCNeQmbntL/lvwb6NI8qVEpKrWeIsaJqWQKR+9hOuuYDSHt2fx9RJ+ET53tmUZBVN9qP7nxUgI5acPsCNowpBCY8ceDn5Vy7hjlBVmiz8W8Y3b3kTtr5HLuHAVD+fqWw81EZZnFQJeM+R9Lq6ttiwgMK+QoQR/omRVYzRd1uyxNuE6ebqsp9DCasklCW6K8wvt4drKcYr/s0GrJTSKuTQ4T+z+1EpsuhpC+cVf8RhZSx8KoHAO8eKNu91UuJiIvrrwIMte0kltioDExg7AqkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSc3wQj2/msW31q2W3GqYS9i4t1ZLOKilbTIuskZrRo=;
 b=hHW9cVPybkq32xgl23nMlTAg24ZhZ8x8EDG1Uv/8+Ono/vpCDzfIcU2qRrV8z/g4biiHPASvcXxfv/RlxQKkJhsX2aSFrnRuw692yEIWZpegfUCTQAQFFo8TeslYDBYO8UW5t1DD+3UvavCaodAEFNlH20VKpPB30Q7Ip7rPSu0=
Received: from BLAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:32b::19)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 09:50:37 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::80) by BLAPR03CA0014.outlook.office365.com
 (2603:10b6:208:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Thu, 9
 Jul 2026 09:50:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:50:37 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:50:33 -0500
From: Prashanth Kumar KR <prashanthkumar.k.r@amd.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Shyam Sundar S K
	<Shyam-sundar.S-k@amd.com>
CC: Patrick Oppenlander <patrick.oppenlander@gmail.com>, Thorsten Leemhuis
	<regressions@leemhuis.info>, Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
Subject: [PATCH net] amd-xgbe: fix MAC_AUTO_SW handling in CL37 AN
Date: Thu, 9 Jul 2026 15:20:06 +0530
Message-ID: <20260709095006.3683940-1-prashanthkumar.k.r@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: deacffe7-f3a9-4f2f-9754-08dedd9f875d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|4133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2kOvgSQbFT5hNVGTA0tPfxTU+4OiHJ+h9zurwXnxeycrkL0k/FJZOGlPezMZSj7SCdB7llLZllodF0CAuseKDomqP/Mjrb71vEbtEf6R341hjBvB2XpjVtKkkp+etPPVBC1cPkuduPGNT6jAkoZMhot2F6dyJZYbSetpValhIt1oVG14FHrhREtBHbJnV/Kc+HLjgyCDu0+1DXsGNvQjvh9MlFkvYv8Akc2dT616XL75LrxPgvpgjeScnYy4ZyiobZnpBWxbge92xnE2q73+tlh0g+yDjul14ybd7bVu9Cxar/CHLuCH3fhJcJx5dMt/rnRxFB7LR/odkDMUBwSQaaTCw4u029E3WjeqZAEiZIWbgXdF0Wk5ldqPGVhc6JVbsi+hZ8/uVyzkXZzk0N6yQ5yaq+KtIswEejcW65MigG+txdY3TMlL0Fjcq2oj6ig5cLmCv38vST+r0bvMgTHHpc1ocmF4+Sl//YEYdwKNqmXeEi8c15JizUXZOXgk4HyPBtbyZyrt7yUEhgutB0xrxh3lLfCN6uOsNinmOtBRAlr8XO18pfPB9O6Psyytx1YR75L1BAnn/dmlzxSKboXaGdS9bTeixGRk35ajelAq1nGEz2WAEwOwpgL9/SsvDxpZtx2Pcx0bm5XUx+gBDhC/C9wDFTrEryl0RQMDGETWzkvWlICEaZgqEHrwMnHdeBFPu6DWYLaIN1vTA9D5Ffcelw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(4133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	87phniZ3Uszu2WdP0Dwu5Tsmdvjd/nnuujSxWeLA9jS1wmjIll6XkkCVnys/tQ8LH5MbUqGyAcjOkN14a5Dq2ht6P3uBK8a5nLEZggbix8/wsxt6BZolBVrHqGEF66bV8VPkocR2tuEcJ2K81Zm3WbY08CkLbhD5etZEvCUqSifCUQQH+Tyef2nopG1P36Gbtjw096U00py0fvkyr/5yPxOEXu5MYtsUQVmzdcb6OItGDPVxbDqVVMtdIBVY037fwMWLo1sqbMUuinaLAMBsve7CRo/SvFmM/Sd+JV3Y1Sk6XSceTxkyE4LJajBrg4NYr+wjclJyZbM9VFGCx9iQpzAyeYrV+QswFcGPifT5bys0+3Gam8yCAxfzeHbqE5tx1BASYNQS6d3GhFFLjVoc8BfI/3F76qgUVrGH8WRvzGMk8/28SCBwWsu5C6cgm5b4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:50:37.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deacffe7-f3a9-4f2f-9754-08dedd9f875d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>

MAC_AUTO_SW (VR_MII_DIG_CTRL1 bit 9) enables automatic XPCS speed
mode switching after CL37 auto-negotiation and is only meaningful in
SGMII MAC mode. The original code unconditionally set this bit on
every call to xgbe_an37_set(), including when called from
xgbe_an37_disable() with enable=false. This left MAC_AUTO_SW=1 after
AN was disabled, causing the XPCS to autonomously switch speed from
stale AN state during subsequent mode changes, breaking SGMII speed
negotiation on 1G copper SFP modules.

Fixes: 42fd432fe6d3 ("amd-xgbe: align CL37 AN sequence as per databook")
Reported-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Link: https://lore.kernel.org/netdev/CAEg67GmFS0Q4oSZkz8zWdOzckSth9_vBPiOy6a7-d697C2w2Xg@mail.gmail.com
Signed-off-by: Prashanth Kumar KR <PrashanthKumar.K.R@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index fa0df6181207..12770af031eb 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -267,9 +267,14 @@ static void xgbe_an37_set(struct xgbe_prv_data *pdata, bool enable,
 
 	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_CTRL1, reg);
 
-	reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
-	reg |= XGBE_VEND2_MAC_AUTO_SW;
-	XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
+	if (pdata->an_mode == XGBE_AN_MODE_CL37_SGMII) {
+		reg = XMDIO_READ(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL);
+		if (enable)
+			reg |= XGBE_VEND2_MAC_AUTO_SW;
+		else
+			reg &= ~XGBE_VEND2_MAC_AUTO_SW;
+		XMDIO_WRITE(pdata, MDIO_MMD_VEND2, MDIO_PCS_DIG_CTRL, reg);
+	}
 }
 
 static void xgbe_an37_restart(struct xgbe_prv_data *pdata)
-- 
2.34.1

