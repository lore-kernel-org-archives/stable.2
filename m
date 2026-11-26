Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795709106;
	b=yqE/MSThTAqeMlSDan0Esh6z1tY9Crdjq9aIiuPBOogoBZB68+MfqLd0ArE2PDJWOb17
	 g1FYjsmQ5L30EQnzMYmcu+vJvY4h0TmSWhyDHF/Q8K8Z8BMZBtC7C8zL22YsJmZjPPr8d
	 uWbn6x21+HxA9UVxi0ZobE9vOj906gwNMEhFoh2GocrXRESaj8ZQD4gpqbv+mDDSCGVRH
	 zKNvD+mAOePD6ZpWcMxajTsTuBeuswLWWSgLE4XKYYQgPTBjrD6O9oogowpWtQfTVD84g
	 lZ3CKUvsP5UsGoO0yinR8CKq22kc73hUag1XqNP9CO0H5MWJ5RpLQo4Vw4FpCipE/Nw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709106;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tQLgQpuSH19bItFTN8KsZk4x9XzMmsk7CYiIZOMF45k=;
	b=5rJirK9uuG/G99jlGSnjolrbGNl4cgn/erByV2b81M1Ji8NHPVprRHj8e7o0FChwthYc
	 1FCQyNAuWeUtXv4o1pqtcU54qrK2hfhVQwz3/L39OLNWZQGvXor3bEtBWg/5y32R8X7TM
	 /3sj33Ehqk8EW5JPob67YUtqczg2YjmdOFsYfjSPhMQ12bvmKllIplgnJg3fs2XvKMNZk
	 cu+oOaJm33ihjUckLc1Qlpp517gonhRYhX6fc7VRWTJhGxjUu884nSYN4l9aCK0iZ43xK
	 t2EB7wBLPbOpIAndWDpLLnSLDkFy9FsAWcIXCn9ZJ4OxAN/PnTYg4rZ4H9u1TsWZQpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b="G0HCZro/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.46
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011046.outbound.protection.outlook.com [52.101.65.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E7606A323;
	Thu, 26 Nov 2026 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 590E7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=G0HCZro/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx5QJjFihbo16xfj3L+1pyOwFliBAdOtQ7/WAZ1fuKaXKKSXSGZ5sCGfWvhGi2ymD759DlSCbNhzaa98qXzAl+LgkmC6q1kxOegcGX/CTICK5cqmqRoNd23BbcPC5Xyd6WXn7ZGGElwUiAthnvL3RP+8/WwlFxuiWX4Xe75OeQ8aqC5ogbdZANMGsmSTOFudDvrp8gmGD96i1u9mz8xw8YkWzVg11CNJsNMqjkIJYF2/Ow6QqqtToGlojVYlj0UCA1uFWeFBfFtaalt7lASHO/LTZ4F5iT26tLvbibpei0ByNz9nEQvusZqB/UA7OnjEU9x7aYaJ2lbr6xXz2Ik+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQLgQpuSH19bItFTN8KsZk4x9XzMmsk7CYiIZOMF45k=;
 b=OMB065Y4UDuOCnKwSSsEhu+oJHDZjr8Y0xZlYzK9C585OPHmIhpXa39WhM/3vWikHCwGUExSfN9phw++cTKTBmrKPyX0ARbufs1RykvKE3lmLVGcfqXeOciBfTkJdtMoUivrkCbWpcW+BKloGquTFcoe8nA1f7eGysVT9ShBobYTKjX4MeTflycY4T7NBZabLl8k1KydLn5UxPnSSHQSmtged1TuqZ1tf3mjZcRL/44wMJAB19pNik44oFon60cLkjDyxJg7fHG8a71ZjCvlcamyU2V34PDvfqtuBVuBl23NpomNqhPm0yDCN3y4SuAfan18kcfLMLNxLA4DXU2ELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQLgQpuSH19bItFTN8KsZk4x9XzMmsk7CYiIZOMF45k=;
 b=G0HCZro/SoOU1RyXrFXS+Sj7Ml48vdVszNY5i+qv5s8tXhiB1F1HM0BtwYhmlS/jDPcLbDkF3aeqHG1BLZMBsdDcyN4PM73GcHCr23jqFQ1QDM+8tGYfwNdSuikAW5V9TxeoHn7WqbANSxKU1WmusJsPWat03381g9sZAoBASjyjyWNIZXxsKBqyEZMwVbceY3dnbeGPrNwFsCZ9NylKqixXw5oFp+r06clRTNwzNtwOhEXBu3cYUYKGjfKN41REx9e9J+J2vewPLTt8PmQWpVYcdPuMjqO+5J15vlzKK7wAEoxP7AKEGGL1SY57XtatGskdMiK77HZGAUeDfJ1/qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 16:05:02 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:05:02 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: Frank.Li@nxp.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	lei.xu@nxp.com,
	haidong.zheng@nxp.com,
	francesco@valla.it,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Steven Yang <steven.yang@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] arm64: dts: imx93-11x11-frdm: fix ethernet PHY reset GPIOs
Date: Thu, 26 Nov 2026 18:08:34 +0200
Message-ID: <20261126160835.1811145-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::18) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ed5963-c22c-4e28-5c0f-08df4bd70717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|19092799006|261021123027099003|261021121427099003|10067099003|11063799006|56012099006|261102123227099003|261009223027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	4EgV8ix6aTS/O+6fofRgCMuX3dmh/t2pepvbAvOtzWW4ZrptXM2tU3iqLSyEbWt2lgU8R6uLpcin9r9j1ewAaDxda8W+te0AnnSMSBrDxAaXweMRaLHETa8cZgSaAw+P6sXLbe59PChaWL9qh5KCPtUrVI5+Te5lNDUVpzIjdOVqOvCf4t8NLupNLlyj+e5s6+gKmEs+jHBu6yD2INnar9GQvwu/MZFw1hWXO53tcvOYaCCkMlWh8qifEaHLaMKYhAmqpWERc2cZ85gRlJV8ytNVZxWoj6cXB7oPRJfyRYSrOZd9a165JIOCQmpvASSQDrW5RMvBSPqBWpveKxGzE3Sh9hYf4mEDKGNschJckRIYAa4u0ywlV+OfVOE8nfcwij84nlqPUCP1c4jm4fVa4FEVjdx9cV305XYDPiERBDdkEe4UeAcWQaqadfKyQoq8imuHy/jhrnCARhAVrtJ2LtXtyejt5tOlTBBafynIIY+5qS1uAUv64RZWEu5Ov0h1jaBeiB/7lBR92T+F8mOP281Ch/xfkTIELmPChUN1BGhBoz4PTrIOIg6p2WIo9PL2eGmvh2IaPvZ11nn/JUK/FeuH63EEwUoVpOu1rQXUVG2tdGk4RhoeZWh9RXse2rBbUgnK9S7dSRc8LohpRCW1uPzsydKoQ84KOT4KDNWj6f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(19092799006)(261021123027099003)(261021121427099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?arGoAoFozlnpSkUNkkmA6LVxSs3y0cIB3X4jg62arwooWeEVDMGGVcjV9ced?=
 =?us-ascii?Q?p0iHoaSWDcgxBPJl1VqEGSgMH7IOR7ZfjtDBHyomI47hKFG8JvxoQfYQnDXZ?=
 =?us-ascii?Q?QC/JOt1wd4VhCHaBsV3aJx2wxhNAgymYXRVLZcy8U0GT2JsBkyCMpZViADhu?=
 =?us-ascii?Q?UPX1NEP7+/Vtjs/bh6bxsYwZWGbxuTeQ2TX6coSbJVckUcjDJl6eIsEWjbbP?=
 =?us-ascii?Q?GMctBxo5HIkBxmhPo4Q9hE2anY0zOxtxGSMbYvku2fsAzjBo94WK1o7RHsCC?=
 =?us-ascii?Q?LyDUUBmRiBaoNAJrGLwKELYA/iOx7W4Q/ptmg31JOjVviUk0scA9cpwJJEUg?=
 =?us-ascii?Q?g4U24JtMsrLp2YeF4EFkDpCGDlzwqJ5+KodndYomsNavSBC6xtZm7TNzyR1V?=
 =?us-ascii?Q?tgLZuOd4QzpLnfC6Ubk1HEMq2zFfqcarVI139+4SKsvic6H8FpCz0kWZy5uY?=
 =?us-ascii?Q?CRgoOh4bmsd/ZLYeSJjB4ZHpToXWUl8Ke0Eev4g4iK61SKXiRnemEzjTGF2N?=
 =?us-ascii?Q?ZcfmZKdgqwwBpBsWtl35pa/DiRrV0PmTs2HJV8I2ailg6T9wuj3VuaUzmHbw?=
 =?us-ascii?Q?FM5aIrF533FLfHkz9CUHZc1K3UU4GHX5k0vpU8GF8d/WWCYitz3YJp9Ikyby?=
 =?us-ascii?Q?MUlWGM7Co4OQsimeAh9ubwnBLZ7CbCyU7/h2i58s4KnYioziAREMVt5KpgOg?=
 =?us-ascii?Q?/oIojbQIWwlruDnQ7z+BGbRvgabb2X37j1QXVgoV/mSR7Yyth1Uq2orY6UCQ?=
 =?us-ascii?Q?cJFm4+sthlZ6N7GWXZTMxoC2V7+T9Xi4NRUsiVdUackpeARMIEuUeeN73oXl?=
 =?us-ascii?Q?nNXCVLtuxogiWDew1emxzOAPSyhKqqA/VoX/yQ0GGZUc8gzXNKRmgntGDZpU?=
 =?us-ascii?Q?MFlXQ3aMw049UDQ8zIZfrokplk6g9IFfQIse84hGKE0uJtqgjammsR1SdgnB?=
 =?us-ascii?Q?KvAAJo4irT8mfJdAr01teFXNHYfl88NIr4yTCZRkjsaIt0bABqe5GUz/P/YZ?=
 =?us-ascii?Q?1IkEXE9UaZeVLTiTR5eHKAVtmmoMwESBnCa0bBX62wsrtFdJ27eNmv/pYWGK?=
 =?us-ascii?Q?O4RCgnNjV5F7u8QLpD+AjrQqxGyVp7vA2rnMBVC2wc/LZmsVFn3UuslNYoQu?=
 =?us-ascii?Q?6AJutn47opjG3NcW15Qe9zOwS7ERArS3R9+Lrcp3jzjKp5YA4uvfhLw5HoCc?=
 =?us-ascii?Q?doPFvjnnLAwBmnZHvV64eAJ1et60YSFFMD1jrMylqOB5iAyjErkUOTHaF8zw?=
 =?us-ascii?Q?slxIFZJEqYFRgHCSaLc5lVHd+GY8cfNgeFFmDJ6DUgdD+sDkC9yXWjVc8zbn?=
 =?us-ascii?Q?M/7fHomwRM67vxJ9GNeGzVo7VWfBwxvZPpRnE7lHxwoxqyhr5CK5jZBbF0Qg?=
 =?us-ascii?Q?C1baL9beJ6ZcVJGTpwEGo+rw0fXIdlQ3BMY+dSVeNKsVgzAhyJq6jY9JCE0K?=
 =?us-ascii?Q?wCVMUDM87KP36P+fDEAWDca7pSHljC9xqvwLcpFaV+cepNEpTvevNHJy3tjz?=
 =?us-ascii?Q?DhrgMaYphvu+l5LYKBRcpcO2LNbmPADxL+c5nPPhzOeY5hPTANluHvYe4Bd1?=
 =?us-ascii?Q?sisVA87C7neKD/KDZn4Xmf20ccO2nI0v/w+cO8UvCHatOsqTGAwJNcQUHr3Q?=
 =?us-ascii?Q?UMzRXiMOWfKcRPR3LNkPuTHq6QjqIOId1ueUbGsJzDKJB9nDaVmJa7sXxjt7?=
 =?us-ascii?Q?Bjfk71xj6IKYhkyPxm7FbFi2ghgI9+NuLGPYI8CGoTplBSrVhtOe9gZO2FZA?=
 =?us-ascii?Q?3nykKhXmfA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ed5963-c22c-4e28-5c0f-08df4bd70717
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:05:02.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /T59GurxM9JVewVLkOItXYZwLdn4QIpoWDIkaQFpzwzbRu7P1OXGo0UxwxJ9qfEQZnWrcyG51I4UfJ50JXJrrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953

From: Steven Yang <steven.yang@nxp.com>

The reset-gpios of both ethernet PHYs point to the PHY interrupt lines
instead of the PHY reset lines.

On the FRDM-IMX93 board (schematic SPF-94611 rev B2), the PCAL6524 GPIO
expander lines going to each PHY are labelled:

  P0_4 (line 4)  ENET1_nINT
  P1_1 (line 9)  ENET2_nINT
  P1_7 (line 15) ENET1_nRST
  P2_0 (line 16) ENET2_nRST

However, on the PHY side the nRST and nINT nets are swapped, so:

  ENET1_nINT (line 4)  -> ENET1 PHY RESET_N
  ENET1_nRST (line 15) -> ENET1 PHY INT_N
  ENET2_nINT (line 9)  -> ENET2 PHY RESET_N
  ENET2_nRST (line 16) -> ENET2 PHY INT_N

The device tree followed the expander-side net names and uses lines 15
and 16 as reset-gpios. As a result, the PHY reset sequence toggles the
INT_N pins, while the real RESET_N pins stay deasserted by their
pull-ups and the PHYs are never reset by software.

Use lines 4 and 9, which are connected to the PHY RESET_N pins.

Fixes: eb2f28413e23 ("arm64: dts: freescale: add support for NXP i.MX93 FRDM")
Signed-off-by: Steven Yang <steven.yang@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi
index 33ed26aafde88..8c7b08894bc0d 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm-common.dtsi
@@ -145,7 +145,7 @@ ethphy1: ethernet-phy@1 {
 			reg = <1>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
-			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&pcal6524 4 GPIO_ACTIVE_LOW>;
 			realtek,clkout-disable;
 		};
 	};
@@ -169,7 +169,7 @@ ethphy2: ethernet-phy@2 {
 			reg = <2>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <80000>;
-			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
+			reset-gpios = <&pcal6524 9 GPIO_ACTIVE_LOW>;
 			realtek,clkout-disable;
 		};
 	};
-- 
2.45.2

