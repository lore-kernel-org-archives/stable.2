Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538E32BF4B;
	Thu, 13 Aug 2026 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626453; cv=fail; b=V3Tu9NGfKIjQ8N1e2aH1vKZLPJD2Sm8FuIx+l7CHYtVxFFC4G0mQg0WKD/iawgIxyGRKG1azXo59s9PV2HCrW5NglWvJHNSvmLL8LR3jhvvaemHzTyzELFm71Hdw7tJz66IaLOq/mbAFKThVotsj5PukvnaoY8INqp1gj84WWwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626453; c=relaxed/simple;
	bh=iQDsbjvaywOoYqR1qaIjgDGK/+BaO9zU2ID4CJutN0s=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=OMr7pb1Z+duyMS4ix1Fy0Q5Z6jLGmuFU6s+O8CI+aYyS0YU3rIey230HQHaRzJCg43cnfJGgMy8YrD6CV3PdZih/ixJ6fu/YY6WxAkvqf4eJDCr/z+OpbVolt95yAg3I2GQJCU1qBwnao5XPJb619+rAU+DluWod9v9tcdxlpiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cbzMLcHC; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cbzMLcHC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu18TkRQwRIWmHGbg1WEdqYiJL1E0gMvLMp+C2DZ69papdGvGr8ngZ4cjaVRleRS6LkPsmntwO2rYrLkZlh4uHjkLMKFPe7XsE1AYQhCVykRf3U9zbBLw8lKI2o9rQf5GQnBcFMQAyJqXZNVMtzZNS1gId3MdoJg8GjJ772vD/sGs3zWGtw6TGwMUz6Je5eszWlA2pIza2miS58Ael0Iw99weZpN6Ob+V07g5BAHok1CDazNaGFvkhojyXGxxpoDjQX1nJ4MyV65qQelj001Proexv2w8UnkBYipjsYZl098Z1E98mRBKbpof2rhiKj2TdFWjWHHfGOgLVQlIFZD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT5DWriLSqUxkxcnsH9jgnRzU937IcgdophfMHpjGO4=;
 b=CGlcScFBwZSsxPSNEWVmiGgv2ETVuAzG2FoOTdeIKvPGp6yKfHEO0QzD507XNDr9dER9vNLpWiMmDB9zCUyqjSEyrXjjIulteB9ZrTuB0b9qN6wC4fQvoZhaRJGCteKXpbQpSGIuymYmE5+rWzW2KiljzTWB4GUrLEjYqvEWHNxFf0aAyFQyUQ+CgFElVVfF4vyEP78jfC3rdjJSGTbZPGMlaq81OIIGK6Bwuel5QpCXJ2aIQcKLihjTqxmgemTaMRdyagL5V2S1OlGgyTtVbCQudaBLw8D/rhSlovNWNd6sv1udvbXO3jCWOFLadCC0Fxt4I5CuX8rn60K5dozHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT5DWriLSqUxkxcnsH9jgnRzU937IcgdophfMHpjGO4=;
 b=cbzMLcHC04mJ2kVqUsK/3+aUaaDYHJbhSypRpKTi3881ORTCdApy68NhbFLjx2EVFrpfM8+KTYTQ1VTgL9awO/JYK3/NWtsc19GN4BdmIBYobpeRdiD9Y9abm9EyM5zDym133tVvRdMx6T0ZweK0IKiN7u5fLKb+iucSl6Z3T8vqwXy4Iw+0E4Jwsmh+Dz7geqWOS+iCKvxaZnn+ZJCy4bd/31g5KXwPOOppGCWQJ16UcgfsITeRWlRCFbLsxPgbE9+meWMbjvEf5AQ7ocbGTG7/XwwBYU7Dqod4YGpYSKL6ktGkC/nZX2/G1AMlZ96geO/+XJuajxlq4Tof8diSkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 13:07:28 +0000
Received: from AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308]) by AS8PR04MB9079.eurprd04.prod.outlook.com
 ([fe80::9761:3d78:e9db:2308%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 13:07:27 +0000
From: han.xu@oss.nxp.com
Date: Thu, 13 Aug 2026 08:07:24 -0500
Subject: [PATCH v2] mtd: spinand: Enable QE on all dies
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-spinand_qe-v2-1-376193ac7b1a@nxp.com>
X-B4-Tracking: v=1; b=H4sIAIvBfWoC/22NQQ6CMBBFr0JmbU1bCKAr7mGIqe0gY2JbO0gwh
 LsLuHX5kvffn4ExETKcsxkSjsQU/Ar6kIHtjb+jILcyaKlLWctKcCRvvLu+UDhXqqKWhe7KHNZ
 BTNjRtMcu7Y/5fXugHbbCZvTEQ0if/W1Um/c3PCqhhFVS2+pU54XJGz/Fow1PaJdl+QJiiN7ct
 AAAAA==
X-Change-ID: 20260807-spinand_qe-dd6148042f63
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Peter Pan <peterpandong@micron.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Xu <han.xu@nxp.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786626444; l=2338;
 i=han.xu@nxp.com; s=20240131; h=from:subject:message-id;
 bh=Lrsc9qvjhzzgpkaGQO2+qix1YF89TnNTe8MerZjoKMw=;
 b=tIwiObs2J1mZz1u14NcpCPApBT1atlVHmz2hIYbhwckveCIzTu5GkDSZThE03FyZx7rFeFz4T
 5hNhMloxZZBCALfRWfNDHy98HBhjEGZ7rHNvw0gtl9i21gKFjv/iUIF
X-Developer-Key: i=han.xu@nxp.com; a=ed25519;
 pk=XSryOlQ4EKXqt7ZHz2D+BcDu1AWYF0m5bX48xQOVF5A=
X-ClientProxiedBy: SA9PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:21::33) To AS8PR04MB9079.eurprd04.prod.outlook.com
 (2603:10a6:20b:446::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9079:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: ee03b6bb-db92-449b-6d4e-08def93bd30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|19092799006|366016|6133799003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BxUdqaOHJnsx8J4zkytoFwK9JuwJlhG1iGpsXqorqBTKycR5qIhS/MKPNsfglcSUXkVqq+xVlb5xMMsgekFwz07h4SHywIcre/QHEUF+8N/u7Cm0xMxIRDLtTP3dlem3nkLOBoS+PDFsBvKmZ+YXvu8PtC6qKHG1m6LgV3veMP450vaf0KAV11gxBpDgTlCVNJuJ+xtIANWu6lH5oP3vW6CiPRphZkAINgUs6DE7Zeg8fQDCDP0NidduYXwVDGOs7HEg8kEnTwF96Sm8LiHhWrudeQV29rvsEAFTJPynIj6jMJQHseiAWPolliiegRIgQMUebtp6tgUu5snTqx809YLjpIk/6VLSe99QAr5sUML2kx8HteBCVQpbFrMRb9dPcVJXYdlDlUolCx+qkOV0HbcjVbH5m25kHI+3DUad+Pvz+WISAB9vgvhPqEFJG6CpdfEPniVmOe8SHwZN8o/p3jTVOeB6at2fiiOhFz/nof+XAtoqNDvfTyIqu8GkPZN96oetZ2PNuaVM7akGbgEiw0qlTKaaCpqmuedT16iB4caQzAAYF3ZLU4g7OrkAsSoFbA7SBBCaPH98x69ZYgx5Vn+QfASHaQTSITOqwlcAIMNbkomW0K8SNsBTsyoHhH8r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9079.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(19092799006)(366016)(6133799003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkZSRjZ1Uk9lUy9zWnBvbHExaDFnTHE0T29xcXVrYUIvZ055ejkrcGM1MDVF?=
 =?utf-8?B?a0hUZ0ZGZXpnd0JybkVuRnNJdzNPRnNWTE03TXkvemQxa04xT2hBY0szRmJt?=
 =?utf-8?B?UnZ6S3pQVms1b2IvOG5LNm13WXk4VEUwZDNzNzVrb05LSWpCelNqYWc2WEdJ?=
 =?utf-8?B?UXNqbVlXSE80Tk5JYm9FVy9oczBFS3h5V09DR2RhSWhRNmpnSFROak9Yb3E5?=
 =?utf-8?B?dWdzUnBkV1dmdzRlS2NHeHVzaEhtS0NmaFFnTzhkVk5tVTk3bGJ6T1FESmY0?=
 =?utf-8?B?NDNSYlJUd1YwNkJnTkZ6K2sreDNmNVNkVXVFSzdKelpWUjkxSnBpaUE3RzJK?=
 =?utf-8?B?dWY2d3BQYlU5UERDRmhpaXNMbmNlT01VLzFsWmxJSDlMV0t4N0plVEZQc1pi?=
 =?utf-8?B?SVlPOFdiNStPdE9yejlBTEdEMVpoUFk0VCs4MmdleWQzZnh0a2FnRmpGUlh3?=
 =?utf-8?B?cFRYalU5TFZLMmh6dWIveWJQV3FMNEJud0ZRM2I2eC9tUHk4K2E3OUFML3Q5?=
 =?utf-8?B?RTQ2OTJvK2NyQnpYNGZZalpoSUVONU4zbktQSGVFYXR4Y3hkTThGbEdOdWJ3?=
 =?utf-8?B?RU9qMHI0d3lqS0RnUmhUcmZtbHdkUmpwMzhtR2NWZStTbnE4d0UzYm8ranJa?=
 =?utf-8?B?Y0poMDluUURGZ1gxTFk3OW9laTNmN3hXWGtQeksxcmdIdy9nL0ttemlzOCtZ?=
 =?utf-8?B?TUZtNVE2dXhQdUlHbmQzWkM2VTlWTG5HN0NLZWdPNE55dG9KVTkrcW9RdVNS?=
 =?utf-8?B?bEFPTlNGVHJBQU44ZXNyakZsM0ZVRi9oRG5hWjN4S2I1aEJPalVZQU1UKytL?=
 =?utf-8?B?enlXZTNsZWVuQU1nR3RTaEdaeWVEcUgyR0hGbW5BYkRIaWhEQy9ydEp5bHBN?=
 =?utf-8?B?NXpmZHZSbGRFMTVYMTBwS0lsRWdRaE9aZHFyTDBZWUFld21NRG5QRnVUWkUv?=
 =?utf-8?B?ZGlvOGljaU1GRGR5ejhKenJxUG5YNk9pbTNweUdWRENwU2laK0MwUzRkNXgr?=
 =?utf-8?B?Zk1JOG5aWmdBZ2I5YTNpeS83Y1pJMFVGWXhxZHhMWnVsUGtKZGh1Z04xQ2Rh?=
 =?utf-8?B?RWhYdi9kNEF2WUZyUGtMaWVHaFF3UCtHWlR3QUFva242djlybjNqL2ZCOHU1?=
 =?utf-8?B?TkxlbmpRSmdWd2Jkd0l6S1VVR1ZYcVpSa2syK0F0M0NEd2liOGlpWHJDWm1z?=
 =?utf-8?B?M1NnSDFPSGxWTldsc3d6MzdxRkh0dTVKR3Q0ZGdNbE1xcnNmc2U4ekZmNGdr?=
 =?utf-8?B?cnBNaU5ZcWJnaDQvMk5raEYxREpKNzgweVF4VFpjV3lSUWVQV0NiTUdOL1Jj?=
 =?utf-8?B?MEhEbk80T0RkUU9jUlEvTnZtZUpMUlRvTWo5eThWZE9MMzkyQVVCVm10ZFhq?=
 =?utf-8?B?NlBicmY4QkpzV3BkbzdSSHBtaStKSVRlcW9mNU5GZDdlYVBCQXpwU0FvUUZT?=
 =?utf-8?B?THhVNXVZc0ZzbUFvZDZLTDhvbEljdGNHY3RQdE5rbGU4SU1Ud3NwSFEvMlJT?=
 =?utf-8?B?YisvekFlTlQ3M3g5U3l0aU5GU3luSW9jcThHWG9vZmd5cW5hSnUxa1owUDVr?=
 =?utf-8?B?bkFnT0duM2p3Z2ZEZUs2clFLdnltMjhiZ09Mc1RSbEZra2hzNFJ4WWdJOGZE?=
 =?utf-8?B?eS9uQmIxZHRkdE56ZjU4T1MyUmNoUEVKN293Z1dGM2Y1Slh3dTBBVG1idVFM?=
 =?utf-8?B?ZjFsOGNjdW1ZNGtQOVB1V3F3eWJJYXk5Zk92R2JoamtsdkZtQTZoalNLSGZP?=
 =?utf-8?B?K2RWb0hLcU5oVC9EQ1NhUVVPNmowNllqWWM0MFduSHZycHd5V0t5M3V1UTBn?=
 =?utf-8?B?T3BmME5vL1VSRHQ5a25TMnZTRTBSdUYzWmdPM2ZucEp1K3h3RDVySUVLTUFP?=
 =?utf-8?B?T29mb2FpUkdOWUh6djlUR1FoaG1sSFlMbU5jS21HRDd6ZWVaU0IvSFEyUi9t?=
 =?utf-8?B?ZUE2dlY1VTJXUWp3WCtFY0ZkeU8wYzJUL1k2UGJPZE02NmlNaEpMRVpYL2hu?=
 =?utf-8?B?NGJuL2MrbURjR0x6SVkwUE5XT1ZIVjdZdmRXSDJNZUs5dWpJZ2Fzb1ZrMmdN?=
 =?utf-8?B?bnhpVXRVQ0FBb2tkKzVHbVVBMXFRMWUxbUJqcXlSUkxGank1c2dsSGhZQVJT?=
 =?utf-8?B?N1l4TmYvT3NqRDJWRk1XRVZDdEJXT1drQWZxVmF2YlA3WFJnRTRzcjI1d0xN?=
 =?utf-8?B?V0VmdUk2OVVTU0FIWHY4NWo5ZWpKZTF2MlQ4L3k4UlYwcWszcnBJTU5QRlpx?=
 =?utf-8?B?dnlLRjc1c0pHQjcvZWVqVDZkUzZXVkdCTm84UW9qSnVMd1N3Ukd1YnhKUkRx?=
 =?utf-8?B?ZEM3QTh3TmIvdHQvb2l2N1V2RXVSNnFVS2JhTXlGVW5kb3R0aTRKVDlVWWxz?=
 =?utf-8?Q?uXEtjK+SXs7UCze+DnMVIGBiBPDgHkC20JWKe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee03b6bb-db92-449b-6d4e-08def93bd30a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9079.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 13:07:27.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oid04mi5C4x/4x4eGgRFP1w2wQ90M7nnrvabI2b9G4IDqM0GyZsWdZIUDBCTXu9DZ7rBFUK/NniMXPNE394I5wtrJ02mVvxusb97eILwefc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160

From: Han Xu <han.xu@nxp.com>

The QUAD ENABLE (QE) bit is stored in a per-die configuration
register on some SPI-NAND devices. When a device contains multiple
dies, updating the QE bit only on the currently selected die can
leave the remaining dies operating in non-quad mode.
 
Iterate over all targets and update the QE setting on each die
during initialization to ensure consistent quad I/O operation
across the entire device.

Tested on ISSI IS38SMW04G8B.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: stable@vger.kernel.org
Signed-off-by: Han Xu <han.xu@nxp.com>
---
Changes in v2:
- Add CC stable
- Link to v1: https://patch.msgid.link/20260807-spinand_qe-v1-1-c102c79834a3@nxp.com

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Pan <peterpandong@micron.com>
To: Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 35365b67dd8e..744662533f37 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -281,8 +281,26 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 static int spinand_init_quad_enable(struct spinand_device *spinand,
 				    bool enable)
 {
-	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
-			       enable ? CFG_QUAD_ENABLE : 0);
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
+	int ret;
+
+	/*
+	 * QE is a per-die setting on some devices. Program each target
+	 * individually when enabling or disabling quad I/O mode.
+	 */
+	for (target = 0; target < nand->memorg.ntargets; target++) {
+		ret = spinand_select_target(spinand, target);
+		if (ret)
+			return ret;
+
+		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
+				      enable ? CFG_QUAD_ENABLE : 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int spinand_ecc_enable(struct spinand_device *spinand,

---
base-commit: 113f62225e98febabba0fee00afd29d4eaf65abb
change-id: 20260807-spinand_qe-dd6148042f63

Best regards,
--  
Han Xu <han.xu@nxp.com>

