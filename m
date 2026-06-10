Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013031.outbound.protection.outlook.com [52.101.83.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF440962C;
	Wed, 10 Jun 2026 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097735; cv=fail; b=o1XVhJc8Dom0o8MiRz/loepzBBh5/RQVDvp90BSQdCScIPiSvdURvBSq3cfO7/M8+Dufv2pEn98A+J96SeHqYwp8RaJveYpz8YuU2EBQ24z4LFoQRUhrMiDNvP/nJYmoi2VLxVzWJRjluF9h4FqIG1/v+ASkNI6CjZBNVo896Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097735; c=relaxed/simple;
	bh=EbeecH1D4eoyQh119xzH5IbHRrp08/ynnJHxNIcMNLk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HYucmjVNApmH11HPyxkBN0x2MtudvYAshXHThYVZjjPws+sJEiEbBkztPFJAifdS5ko30q+blplTGDvRzujnsqAzSjC6vSA48NAHYBFYcxeulayjHVI5Vn6dv2giPnccoFElifLYCNSNKDcGX/IQTHajgKnIVX3cqeQk6Sh/GMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ujJCW+zM; arc=fail smtp.client-ip=52.101.83.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ujJCW+zM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqgnBsVixpoKbbvMNj0Ts/aoh5Kqr9XB3i4Gmx9DqCku0ch+yWCwS3x73nCwsm1+tJJw0TrX0aBvmy1mTyo+sVDMkNUnQrZXaGSoVK1Z023e3jp1le44YtOz8r5sRclTf7dgDz611Fdd8GEizN2sWb/qp50lhEM2Smc0niamX5c4sv5Ixyh6VDHMTPGE6YUOZgdbosa8rnzkhLZlHPZfwYgTvdyOlVepVMMzpm/sv6mE+Cl/D/tDrCjoX10I+6twfcFpIWMzdbBh3JUVKquThXrMzifd4XCNtWveB4dAyNg9AA3MJIvLiXoJLKfQ9CImPIo5P0RnL1hzaqEFPdsHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/nFouoPSbHNsG9JhIfi4eiO5XGpj6TjMcnWG3/vEqo=;
 b=wiely0M8kURrt1MxXyBKyWZIC2zotkaX4mgZcdnXXaE01cwD43LIJFLJi3ORL698PAiR7o1F6o/OIN0V+/l+5/UDpmCmMHAHuUexi9jTkYe9nMTc3VJOOdB+A0/CHIvJLOcqwvLJBLaYdfpg/tdJ9xLbdb5j54fkrz5u7v4j2/aSLkvS460dtDFlu9PR1QGdg5lXjWfps+NdFcvTf1eJP9uWCk+0zkpWPrsAEgcxu8LZVs6hZSZ7l+JoXGxmTEN6AacWRd6fWmIwCntL78FpbQMJU6RR0FiX827QAZqaknrKnaiYpXKzt99FxRjoKrFQ+/cPvcJwureeUhS7nrT8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/nFouoPSbHNsG9JhIfi4eiO5XGpj6TjMcnWG3/vEqo=;
 b=ujJCW+zMklaFJvNCT19Iuj3TfdCL3mCNNzqEaiO5lzcCe+ipNQhn/cqLPSG7zQ/nyaESmWz4UrkszPcA9nyhZWR156gcAoSA5xdesHC42x3185+HKemzflDp0GXUCgZxRPqebYd6gFKFl8E+/tfaxnvd7pYawJi6xtaZx1ni0hzQgmmNF5cAV9b3O84gxL4pQc4cYLd+QecrbjLw/UYOFerMyc+65T1AkTrOwYNSVVCkRzlOzC+1lcyjECTo1cJntaXE3svTzk4PIDkl5rLIDc3o2qFQajab0MI/LNmiV4A9DPWtch0CO97/iWLafJmKYA5Ejm4zz9i5iJuvSPDMRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DU0PR04MB9658.eurprd04.prod.outlook.com (2603:10a6:10:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 13:22:10 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 13:22:10 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 10 Jun 2026 22:39:11 +0800
Subject: [PATCH v4 2/2] pmdomain: imx: Fix i.MX8MP VC8000E power up
 sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-2-ea58ce929c84@nxp.com>
References: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
In-Reply-To: <20260610-b4-imx8mp-vc8000e-pm-v4-1-v4-0-ea58ce929c84@nxp.com>
To: Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DU0PR04MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: bc57f82a-411b-4da7-1fdd-08dec6f34722
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|376014|52116014|1800799024|38350700014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BkNawE05RaZGqGrUmBj8ugHmYULktdwX84NI8S3n1ACjb93KBsAlc6dtc5dyEYZE4iMiwLIGtY6zrVKBQnNtw4/ty9//HNrC+Wzi8bjSuiVIe2WbKv+PydJHYSKe3bESyAg+6e44Z2nBGRpSdW2FBcOignbF9ouBJD6gjQzv98H+PCn6ixBntmb/sUtKSIdXUCPe7f6m2Gzpd06F8tIvJm+mCtWYqQ18r7xR2CEZF/08Pw3snErBquNOiNj6uTurELIuaQ8Eat/7wwsCbfFeGDwX4mtFjvFl4WQ9TTXAKN8BvsxI5qUnr7k5GP1xXnFyVpDhA8l51wv47UI/4AjV+O2THtZY3ICkhY6EyNo4R0fcbYlgp7WsgPy6u4AtB+D3qM/HcE6QjqrXiqOL6V4wHOc8ycfOybX7RexkZdRm6DRv7PEvY446VqmKFt7llV3ww6mv5QCQn3Blda811Sk1WaQv6uxmhR8tsOCdTYO7gJq1Pl0atRPs4GvDZUUPi2DGpj0bAOaNx7KF+j5AHfr2KODMxGeWrVVQ9H95wtM3wau/UGXYf8AsssNg8x+xS4tCfYNXxGCJzYqHRZDccrGDUSsX4xeT55ASLsHbWO0h7aPafrd+w6BV4PENj2Z8HMTsIvMyAEL65f79tDu72IzaYg87CDC4cdsUiqSlBuq/aXZ5beKtjFuFWoDMcUgAlT3BhkAmY7yyppTM5fxksAZJjNuhHXhyaj+3e6yEX7DqrbeOxa8TycOtffKCFZEp65No
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEh5bXM0RTI2dlB5VjEwTGE4SXd5RW9KL2x2Z3MrajM5T2x1NWRCcUNyWktW?=
 =?utf-8?B?K1pYN3BjOXZPNjBGMzNFRFQ4a05ZOXJGYTBvSGlMTWc4RHNCakxZNGZMR01T?=
 =?utf-8?B?bllzd3ZMKzBNMndSNTRJOThaOWF2Qnk2NDhhWm5BMXY0Tmc4NVptQlYzTEhL?=
 =?utf-8?B?Y2xGNXZFU2w5YjlJNTJLQmhzbldWZ2x2b1dFRFBnaXdhSjhEaDkwMEJFSy9o?=
 =?utf-8?B?SUp0UXJ4bTZpZVU4S0RxL0NETUhwUEhlUEM2NDNtMGNKNDJQVnFzejFjUEJy?=
 =?utf-8?B?NFlRdjMzVnlrZExES3RXR2NibllCQVlEaXZKUjdubVpDL0FYNG9sdEUzU0Rn?=
 =?utf-8?B?b1QvWFZDVUxDRy94K3oxdGYrZjIzd2libWxXS0JPdkRMbDMxbjNwcjNQREZD?=
 =?utf-8?B?Z3pGWnpqT0w4Mmp1WE9hd2lQZTd6a2hwQnJOeDV1SGYvSnFKQVBBeU5hTC9o?=
 =?utf-8?B?c1B1bSs2eDhadHdPMXA3anQ2RmR1K3dVK2NYYXlKc2hJdFp1cHlrbjBndktl?=
 =?utf-8?B?aDQybkxDbjdkaWJPQlhiYjJQWHBlMHZEZTBiY1dvVjFrYzU3NzR4MUlRVm5T?=
 =?utf-8?B?bENweWltM0ZFUXF1T2JCWWQ3T1pNOEdvNjhOeEpCUFkvcnN5UDg0cVVtd3I3?=
 =?utf-8?B?L3owb1lRcUFzUWZsd2l3dkRJdWVjSjlsQ2djU3BIN3RDTVorU3FqcmhqRTAw?=
 =?utf-8?B?SkMwQWtlY3dkRVpRT2pNZnA3bTRTbE1FVWZUbVMxZVl5UEUraUhrL3FkbWVq?=
 =?utf-8?B?L3BaampKVjlyakphREx2THVndUdYakhQVm12WHRVblB2SnhtYitYaVRoaEVz?=
 =?utf-8?B?RXcrdktFSzVXRk4xQWRNRFJrRjhWbUxnTXVtSWQvREV2TlI3UlU1QXoyYzZZ?=
 =?utf-8?B?OEhHelVTWUhPOEdGd015UmNqMnBKeXpSOHpRalRDZWZkaENNY3hTUWRlY3VF?=
 =?utf-8?B?aU54dWwrZ2JSN1NvYkNJTFRqMFBjOGtEK09xcTV6VEhBZWtDQUh6NW5ka1RW?=
 =?utf-8?B?NWJiQUZ2Smlrbjh1U3l3S1VuWWkwNHAxWFc5N0xKa2ZUSWNvbDZwKytwUldG?=
 =?utf-8?B?M0puMFpYc1A1dU96OGUzOGsvZUFzU2JiUlJtbTArK3VQTTBFTXhZYTloV3Vm?=
 =?utf-8?B?cFJ6QnpiSGVubWdOVEVnclBIMDRHeXJzUHlRTGRuNnZKZ2ttT0dVOHhEUFFs?=
 =?utf-8?B?a1AycEoyelVGZGJzejNOYURRY2hLQzBhdGFOYXVaODlqeTUyTytXV29URS9s?=
 =?utf-8?B?Y2I0RzgyVjN0VndrbUUyZ0owU1A5SWNQcWoxTWd4K09DVVZUWEtjNXI4Y3dX?=
 =?utf-8?B?RXhnYUlKejB1cVJJUW12RWdDbk9KRmFPalRlWTF3Y1liYk5LZC81dWVCeSta?=
 =?utf-8?B?SXMzT1ZzWUlQVGFpSGNGL0RIVU5pYWtaY3VuVUNrTm5JQk5raE5aUktEQjZZ?=
 =?utf-8?B?U2xZK1pHRS9tZUtZRFRUbkExaUhZbzhlR3JWZVJPYWdxZitUTVVjSUZ3cGNM?=
 =?utf-8?B?SXV0VDI4YmRMVnI4R1N3ZjNjN0EySDlOb3o3MUFMWFp5bmd2VVBKRnF4U05L?=
 =?utf-8?B?NHZHRUFFZjJiUk5RTE9Ca2RJS21WeFNmTUQ3WXZ3WlJrMWFjRzFpckVJU0E3?=
 =?utf-8?B?RTN2eCtGNWx0Sk9yNElkMzl2Z0lSNnpxNGxHTFVrY0dvemYwYXowUE1LMFha?=
 =?utf-8?B?czNuMlFGdGM1YWVkYWpLN1oveHZFdSs1Y29tRFN1aENtNC9MYXRJSW9aM2Na?=
 =?utf-8?B?UUFpYWdDSURQaXFjSGtudEJkcVQxcWJPaUxjRXNHYXdwZFlTUUxiUWwwUktv?=
 =?utf-8?B?U2ZkNVlsTUptSjFlWG5udlJ5TFhPbk1yaE8rWndaZmwwZERkZXZhWGVBRHVy?=
 =?utf-8?B?UVNrQ0Rra3llUkw3SFI5NkdLMnp2U3ZKYXo5ZnVubkp0cXBxZUo0eW1aUUxV?=
 =?utf-8?B?V3ZHeFM2Q1B6bjFsZUxSUFgrNWQyS3dQNFdjRi94VlpLcWRLR0c5N01RYlpj?=
 =?utf-8?B?ZEFzbzBuWXdXNEVwczg2RzNiR1NJQU82QTJMZ0paZVQ4TGdMRnZuN2FqVGlh?=
 =?utf-8?B?aWNlcnBkejZURm41RWhmOVl2WHkxOFZMbmY5YlFvVE95Nlh2aU5HZGhmcmVR?=
 =?utf-8?B?bVI4S2hQdWdxY0lIMlFBTFZOUnY4ODVnS0RoUFpzS0hiN1o3V2tZK3d0Y0ZW?=
 =?utf-8?B?TWpWbUEwNkZMNHBiblQrMWxlYUMyenlkTy9FQ001bUxwWUtaRnFJMHFkOHRq?=
 =?utf-8?B?UU1PVjFBSlRnUHNSbzhEQmdqYnRWek43SHFWVi9uRzlSRjJlN3Q5TUVCUkgr?=
 =?utf-8?B?ckMyalVOcWR6WTAwUCt2VUo0d0xvbzNkR0pYQ1dQeWN0cCszZDljZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc57f82a-411b-4da7-1fdd-08dec6f34722
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:22:10.6799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LFQcsbvYR09Dvd2w05HutTQvFtetWFOWB9m/R0egHSRN/wPmHJ75Wiezr3zM7YcZSEJ2nghjdYcJfjAmhdyDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9658

From: Peng Fan <peng.fan@nxp.com>

Per errata[1]:
ERR050531: VPU_NOC power down handshake may hang during VC8000E/VPUMIX
power up/down cycling.
Description: VC8000E reset de-assertion edge and AXI clock may have a
timing issue.
Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
de-asserted by HW)

Add a bool variable is_errata_err050531 in
'struct imx8m_blk_ctrl_domain_data' to represent whether the workaround
is needed. If is_errata_err050531 is true, first clear the clk before
powering up gpc, then enable the clk after powering up gpc.

[1] https://www.nxp.com/webapp/Download?colCode=IMX8MP_1P33A

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index e13a47eeed75..99d100e1d923 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -54,6 +54,15 @@ struct imx8m_blk_ctrl_domain_data {
 	 * register.
 	 */
 	u32 mipi_phy_rst_mask;
+
+	/*
+	 * VC8000E reset de-assertion edge and AXI clock may have a timing issue.
+	 * Workaround: Set bit2 (vc8000e_clk_en) of BLK_CLK_EN_CSR to 0 to gate off
+	 * both AXI clock and VC8000E clock sent to VC8000E and AXI clock sent to
+	 * VPU_NOC m_v_2 interface during VC8000E power up(VC8000E reset is
+	 * de-asserted by HW)
+	 */
+	bool is_errata_err050531;
 };
 
 #define DOMAIN_MAX_CLKS 4
@@ -108,7 +117,11 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		dev_err(bc->dev, "failed to enable clocks\n");
 		goto bus_put;
 	}
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
+	if (data->is_errata_err050531)
+		regmap_clear_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+	else
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
 
 	/* power up upstream GPC domain */
 	ret = pm_runtime_get_sync(domain->power_dev);
@@ -117,6 +130,9 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	if (data->is_errata_err050531)
+		regmap_set_bits(bc->regmap, BLK_CLK_EN, data->clk_mask);
+
 	/* wait for reset to propagate */
 	udelay(5);
 
@@ -511,6 +527,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
 		.clk_mask = BIT(2),
 		.path_names = (const char *[]){"vc8000e"},
 		.num_paths = 1,
+		.is_errata_err050531 = true,
 	},
 };
 

-- 
2.51.0

