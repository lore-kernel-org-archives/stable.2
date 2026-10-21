Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592168;
	b=kVPyjlgDoQ/xHSFuqwiROzbqUDvUQoT6momELf/Mza9JX3LVSPKURXXrds9lZzcjNdBD
	 QsHgZSEBDVYk4SoYrIqCHkkIe4kdHijpSs6UpPfTobbruzhHhxc2OOZHPiP5msgZLGFVA
	 g14+1TuXUO9h+Cf7aupGdOGZCCbYMQ6wMCI58JIshxRGp6+9f09fT1dL3Stz3LapDO+kN
	 vt9n6LrBfyEjBO/4zv8F2uLu/aHjGsaFsEj4Xm5aPBYQF6wz/GecHjls60r/z63zPZLuJ
	 015K246Fo8JFiPgvDAxt9c2e1Mpu5DwqMD5F5LMdPXJe4xva5WdFrbph9iXtMPgjApg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592168;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QyCzWZARzlOpni62ULd9tzkAosXUHUFBhTIOTDFMNi4=;
	b=3Z+kR+3Z1Ufq0OJ1Vq6ZM/CSjwpgpRAEscltM8IcFuffoUAPGHOkS9g8X7gH83/e2ojj
	 LjzlN0ls/GgsQdjaYA7zxjOCvcARz0cspw4pdDW7gAmUkd/FLRGWO1TF8Ap9fxL5PQA8z
	 nqYfgAw4PxjbKL9MzzMQyvK4bokODhSO0N4wuj2vjlF1CxRSlD78ZJdvPbTlLvoYpqQWn
	 xCJf7in0Ws7HNNc4BdLpYld4d9cZ87fSDY+V/DwMQ8lZnMItHUt3JRirFz7kW0HgfUp/1
	 uiMV4Ag8mj2QL0msgcveBtxECLeC6/m+6GswTVIPsrgNVs7KTAPugrjnwB2zak+plrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="FI/8/w4g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.56
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AC60A380D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 433AC60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FI/8/w4g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCSFDazj3SkUmqzUv04FPXYR7kyYHzpm4LKTh/MmZWFwzMEU+Hdc8p2oGDHcpgD/wjiBYpW4HxTjJnOmRdauXA/oe4NEIVGLP1Cuok0CVb0DZHmHEMtnBKUS8qURuehZCzjRYD+fRYsCVFaz4IxQapZghz1dCXrv8lTJvDAz9/9gpZjwpLAjtrkj7yTgTnxeC+m6RyIj+arhuMue++0XOzq4tBFxYF5m6gwrEcYT2L7vT1L8eEQWSDznqDVBdqxYnVPPbHSUhW7jaIYQHldBQs+fvbVdidGdb6ctR1DvpBTHF8cZujX300uw+8HOL1ENUxGB/P3r2/QL3viT7P6V0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyCzWZARzlOpni62ULd9tzkAosXUHUFBhTIOTDFMNi4=;
 b=GrNFVup+q5HXrFqW7SlSntSJkKfmxWtFnPQX9ux+dul/ulGnZihNJnuARuIpsvgXbiLkWcAur92nPt1sAa3WS14yiKcp6K+FIkcg/uHpSuzIv8SWF127z4GwUr6JkntV3+ieeJsA0lDydT6afO0V/gETRQRDgIlS+nzI/+YkeFBXEGbmHjoZzoauc4Es9DMAyOqya4L8Ly8gxUrw4TbzOfrs8ktmL8ee/uIfBU/eA3+w0dOR3E+U0kQowDG475xOo8z9bMwLHRtqfR+jQyk5eWNSHpeuUOszKnKqDh1jADXK7aTY+sYqgl3QpTgcC8Dv10lalfCtp++99j1cENTFuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyCzWZARzlOpni62ULd9tzkAosXUHUFBhTIOTDFMNi4=;
 b=FI/8/w4gVA3e1RYp6zMRAQAGA7hrEkOeHthEgQUUE4A8olxC1pIBwKjsEfOr4/Wua+TyzVNM/evvEjpcI1b9fEETEdpnOSePfVulawvEDDJplp0hHZcNSN4B6yB47DCgfhyM2pVw8XRfMW8/8//GvOLl+IPWx30YG6HENJPOVR8gXQkT2oRykAW+iqISk4+ZiKZev+Zuc16oPDxTPq+/WhaLfEP1hkTaJMiH7BU1KcP+LhgGs+l6dQKXibl83OifXXd6ZMbKrlceG+F5CBdnNsfJw6C4mqyRJBrcIPm3ch5mxSXjmeC6cRAVMzH5QkeqHigMY/a1n6l1hsPOV3bFAA==
Received: from BY3PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:39a::21)
 by CY3PR12MB9580.namprd12.prod.outlook.com (2603:10b6:930:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:15:58 +0000
Received: from MW2PEPF00014679.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::96) by BY3PR03CA0016.outlook.office365.com
 (2603:10b6:a03:39a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Wed,
 21 Oct 2026 14:15:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW2PEPF00014679.mail.protection.outlook.com (10.167.249.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 14:15:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 07:15:32 -0700
Received: from r-build-bsp-06.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 07:15:30 -0700
From: Felix Radensky <fradensky@nvidia.com>
To: Vadim Pasternak <vadimp@nvidia.com>
CC: Felix Radensky <fradensky@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] leds: mlxreg: Fix missing fan LEDs on systems reporting a unit count
Date: Wed, 21 Oct 2026 17:15:14 +0300
Message-ID: <20261021141514.591959-1-fradensky@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014679:EE_|CY3PR12MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc6b391-1baf-4007-bb16-08df2f7dd3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|18002099003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	PiDDVnUvxDSy0CtAQjCny4M8ZtVOOVvRBgp/GM8rrtL24eAjEs1rSw3jGDDWMYCZvpDSTVJ4+jyXIFSE3yjKIgbuaZdu8O8JbNnEIkKWxD4QZLdUnGEr4umQmNYPFYVWl0HeMMzOCxhPgzngRXD2Zp1LdxKLQKBDM74z4x1CRNal4w2mRES7BKU+kBK8weeNTXKerE/ny3nThIh/KLZUJZTjLg1xbXObKJd3en/tOv0G450dnshdAN/ZLjUvLNoEyBfC7apjN6VVqFYJdsv7R/70fvulR69snXP/3dEjGTv9VrYHWeS827rfc7Vz5Hk8F/bGsINtfiXtAOVkCUoabVEH3CLW+3eCZ6mQGLnSUmZi+AqtNNgN7dUmGXgKoBBPE4LmFa1dyd5tFEJgCwEIAJKYYTnNKNa+UP27isLalHPB0m/YQKm/xlABOlx9VxOJu33hR2amBgY0rAvWIYJsK7EMn8g0O+QvOqqm0h5CnxXz0pKbm9pmjQxgUMaJ6NqjHlYM/gtMBXJDOp4aMujqM0pDNCt8u8yvkiTpdXzhAyhPBcVbkJZBYmSgr4A0PoX2GEDIMNYfs2PI96BW+7DuBqwZnpGcw++lEueYK3lPULTMsbG8Wr3+Da6c/Ok/0FyVL4Kr8TOgo0DS6m4wdC4GmG5ncwMRE06E/JXy6voer4bX4il8pUkrTa1UYtPwwOTBCl2vOEATZxdzbZuxYFZWPQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(18002099003)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	54zYlwEUdkKridDZn2907BvMdwRZIoCMcM6BOm/bridhJSY/PMvKq6ouT9ciyrgeWLb+iEPSiCl4+fBlF/nCfX09lOg4EzbQNyXh0QVzN19GI7lcGhIwZ2omXDxvyQKMKsMIernlaXZiNz1w/Q5zo2FHSGita3jpLucrXHMEHIEpMUqleeFNG+6umHkYlIBGmfcwBYQjMotcFncsTdIF2rBzltg8+lD9q95g1mMNCCDbZJ9aYuiERfBzrjGbYaBq9adKPQ7tCI2AXUanFERGM9b6hDstPw0jI7YSKR4BvHEDh64/lfGp35/fgpqOeL5al/ZcBokEfOgBmowgKEPCTd6PgQJAUoj8C+Q3tMKaM+HxLOnvxuY7VgLOarZhkRyVBl9Z8L3IGEyfywPeMnVhXJIhILoaX3zl2qMYJmz+LWbvoCdjiZIfoE3haWSIUSiO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:15:58.0785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc6b391-1baf-4007-bb16-08df2f7dd3db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW2PEPF00014679.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9580

From: Vadim Pasternak <vadimp@nvidia.com>

LED platform data is shared between systems of the same family, and the
driver registers only the LED instances that are actually present on the
running system. The platform data entry names a capability register and
a bit in it, and an entry whose bit is clear is skipped.

The capability registers are a single byte wide, so a bitmap cannot
describe more than eight units, which is not enough for systems with ten
fan drawers. Recent CPLD revisions therefore report a count of the units
present instead of a bitmap, and do so uniformly rather than only where
the bitmap would overflow, leaving no per unit bit to test. Platform
data describes such an entry by its 'slot', the one based index of the
unit the LED belongs to, and leaves 'bit' at zero.

This driver only ever learned the bitmap flavour, so every such entry
fails the presence test: 'regval & 0' is zero and the LED is silently
skipped. All twenty fan LEDs of mlxplat_mlxcpld_xdr_led_data[] are lost
this way, on smart switch systems since the table was introduced, and on
SN5640 and SN5610 since commit 3113bcf4ccf0 ("platform/mellanox: Fix
SN5640/SN5610 LED platform data") moved them onto the same table.
Nothing reports an error, the LEDs simply never appear.

Use a non-zero 'slot' to select the counter interpretation: register the
LED when its slot index does not exceed the value read from the
capability register, and keep the bitmap test for entries that leave
'slot' at zero. The bit clearing that follows the bitmap test applies
only to the bitmap flavour, so move it into that branch.

This mirrors the counter handling that mlxreg-fan already does for the
fan drawer capability register, added by commit 1e11552ee54d ("hwmon:
(mlxreg-fan) Add support for new flavour of capability register").

Fixes: 783259e9b19d ("platform: mellanox: Introduce support of Nvidia smart switch")
Cc: stable@vger.kernel.org
Signed-off-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Felix Radensky <fradensky@nvidia.com>
---
Note for the LED maintainers: an upcoming platform driver,
nvsw-host-spc6, describes its per drawer fan LEDs the same way and
depends on this change as well. It is being reviewed separately against
platform-drivers-x86 and needs nothing from this tree, so the two can
be applied independently.

 drivers/leds/leds-mlxreg.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-mlxreg.c b/drivers/leds/leds-mlxreg.c
index 1b70de72376c..e428531f4ac5 100644
--- a/drivers/leds/leds-mlxreg.c
+++ b/drivers/leds/leds-mlxreg.c
@@ -204,14 +204,26 @@ static int mlxreg_led_config(struct mlxreg_led_priv_data *priv)
 				dev_err(&priv->pdev->dev, "Failed to query capability register\n");
 				return err;
 			}
-			if (!(regval & data->bit))
-				continue;
 			/*
-			 * Field "bit" can contain one capability bit in 0 byte
-			 * and offset bit in 1-3 bytes. Clear capability bit and
-			 * keep only offset bit.
+			 * The capability register reports unit presence either
+			 * as a bitmap, or as a count of the units present when
+			 * platform data assigns a slot number to the LED.
 			 */
-			data->bit &= MLXREG_LED_CAPABILITY_CLEAR;
+			if (data->slot) {
+				if (data->slot > regval)
+					continue;
+			} else {
+				if (!(regval & data->bit))
+					continue;
+				/*
+				 * Byte 0 of "bit" is the capability bit just
+				 * tested, while bytes 1-3 hold the shift that
+				 * positions the LED's nibble within its
+				 * register. Clear the capability bit so that
+				 * only the shift remains.
+				 */
+				data->bit &= MLXREG_LED_CAPABILITY_CLEAR;
+			}
 		}
 
 		led_cdev = &led_data->led_cdev;
-- 
2.34.1

