Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795598884;
	b=AHmUszldMIdG0toOpr7fCkTDavDF4pG0Jibpqg6VUxUkNrk/ZeC5iSVUSU4/A7hbuPoU
	 M4MJzCkGqCNwlSOH8LHE8h8WrExkQe+zQlUAGpRLiFXXsWE85h0LclHumnikCUzD2X5xT
	 Z3e6s96G2esYAfKVLvGGinvsxMorq8aQpEXUD9m7hA/fYt6ne+Rb4fOY9aEyFDZK1Arj2
	 ntlv432ABE+ZmzpTkyLInEhJEfPsCfxFG+RqsdALiImDkJECUXzuQkJ9ywa52q/tGguF2
	 ibawlezCUcYlr8ZvdMwiXnzxFtAHA/v7/H3acmGV2hDM9DEGPGmlhmM8aSBxuiYySjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598884;
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
	bh=dQBqbiIv1p2VBFGRvFWllkt+MEWE4IbU2cfydV1kTdA=;
	b=OWqXsoLYO34Vr22mm9DzFsvx++nyL9QAiz5ifo6HvSK7v9LPjXKoB2aeCbLfRO1hGiTC
	 AspxkHwYa7f9i+pBJHRumzgX4wunaQ1NOU5Tx4ylHbI/l2cGaJB/Zv8tGtMDCGlas396e
	 /nMQl6eA3JCLnbbTYVfux9ROw/Nbmxg3wrJ0Z87MCdcqkdaNoS135pCm+g9Q6TZuaWucY
	 rYs0HYttbNPs032WC4E/mG5OHY9Sv11aaScs9DL6FImbMLJqPElzhVHbPkQsU1aWTTpqI
	 8H5g5ZB6aJGSTLmAR7cwKtT5C3aOTfP4pWc58gAPWkRcM3ttPTwRfSCV0J5OrFBophA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YR1rLXFZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.7
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013007.outbound.protection.outlook.com [40.107.159.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8763606A31E;
	Wed, 25 Nov 2026 09:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8763606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=YR1rLXFZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7Ibk+NBI2v2Sdxa3NHDgFZ1pi7tU7lId38OPtqLzt0W1KaFyEqG1Rr1t7zbjL3FY3hv8EubufAYw7SiHyBBhYqX0hQzDW4ZFaWrQgSJDBGFg7AK+4mwATYrTKM5egA2ELpDeoXsjlgb3/V7PCqfu4muxf09kWIq0is7brU5q8gAjAITvSrhnyuKtnC1zDNAk36PH6gJOsOvrlsTXv+YUolYG+6fLcR6hq8q0vWt/rJFmcTiiaxoH8cMMzGYU2Mwdy6MbIsCePC+YK/rsL3pHJGvcWJvwvFngZScU3xsMVVmE2eSFVsWYGuP3X6ogNDqLHYUammEbO2536/CPrH/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQBqbiIv1p2VBFGRvFWllkt+MEWE4IbU2cfydV1kTdA=;
 b=lB5yGKEx3rBg+O/qQsWYw8O+q9Cr1XBsY2wCal2CPB8J0dfaxtirFSmDhFoZ78XCmSdm1P536+dvxuBGzdtTiwnPkdu9WG5hSXBRJ5JGTcsvu5Gk9kgBc/FOa/S8qxenL59uZzAvyiVTrHhHodOAtrOTxrCilFdh4+ep8qSHwM7XLjgb1xC0AxIVltf+Q8DcmW3jlAoHipOAGn94or5WIuAEFcRRbXxl3U7r3THUIxQlwEGgGHMASuBaApjWg2sMzP9Cd5aHKsBVUwV7mmiyZaM/ZwGWv4wn+Ov2GqNPQ/tUOLYNuILMIHX4vvc+IhQEUH/cdL+aMEfHJCVxIKLmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQBqbiIv1p2VBFGRvFWllkt+MEWE4IbU2cfydV1kTdA=;
 b=YR1rLXFZ9GkopNtWSCv6Fd/3FPFoJrb8NwLufzgu3xkguoteEp49P5GRMX849jYCZ8PLyaZa70WlfWunwit+q8tGK7U30toQ82B3flwynjm8xbyCnV5ZTDsYhClXt3lGX9gxS5j5fHu8EF8PvCIiWvBfQrQQMTYR4+2Wd5UXfK4BuwLwlezgfC9oAEf9ZjPlfjYU90CvHEBpwy1t1HCF61FbkaxbDZC6p65GEXju9FiWG8zNykxw3X9Q8NSjIsugtp4BSolnF/fIejWoOw2Aq124PS39q6/GVpnB4r7qQQGwNlJG6ZxFMSHfMqqWGycNnNO75+qO1C8x70NBWG0boQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 09:28:00 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 09:28:00 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: Frank.Li@nxp.com,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	aisheng.dong@nxp.com,
	shengjiu.wang@nxp.com,
	linusw@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Gustavo Arambula <gustavo.arambula@nxp.com>,
	stable@vger.kernel.org,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] arm64: dts: imx8mn: Fix SAI3_RXD_PDM_BIT_STREAM1 input select value
Date: Wed, 25 Nov 2026 11:31:27 +0200
Message-ID: <20261125093127.1353451-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::14) To GVXPR04MB12316.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: c21dc550-98c4-48b2-637b-08df4ad665bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|19092799006|10067099003|11063799006|56012099006|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8tpQb0GE74oaIEV9+d8a+2Y7bN0oGC48xKFkr4GSWPfdpIHGrRYrToNnW7u9GHwCL8aTD9NsXPD24K6hD8qkUELo4OXakldaRBU2xEGO8G0SmqLDz5gEyLtmLHu8g4DnLF0D3TNw+QHckU2F7nPOPvQwbeQcEu5xW2R1lk6kvDk/1ElkiyktTRTTC2O0oZ8Z51Q5LR1NF97mKVQ6qaMRTConvKtv0Tc56Dvjk9MTIMxZ+UvzTAd7fkvq22e9EkAyYvUvORPSz7nMBdtWgVqjAeNfiIIhLRKSrASjtrIOcgcIDE0wJgVoAsD1WdRg/Tcg2OzypU631pwb20W17EfBNZ4mAeEdpvgum9pSyOTJDnj5Ico/N2PYhs3r+BLxkNLkUEW7iz6Iy/KT/Le7zYqJ9j3iUb/qdAjzk4XLcfhHVSo7hkIpmCfh+oVu/20I7E8LK9+w1iKmA7de2ltrmRymAsS5T6skgk8Hpl6wxs5KPPi0yB1gb2BL8uH1J5+m51WCo5+spECQ/PrKtJML+OKueYm/RZzTtDkN49yQXDasaywMAUZnL05CZOiP41YpjTO6r1XBSzYIZQ6KdTTChef0VjzBj2CGiDwHrxFRTIZoP/MWj2XZ87Y4pPHYr5Bpsw6GIru16LK7+ZcNfjEnMTWdF+lwVYDD3N2MicmaD4J0y/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(19092799006)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QLuOvHoo+JGqRKAOPjfBA1ACI3wZ1KK0O05LVUoOmgGJxtUkieR0vOuTbkLv?=
 =?us-ascii?Q?NVmxLERWIyMWHuM7DDgOY0DVWRvdPj8jMSZ/Y8sR0MvwSPCWQQhtXJrPh/Wa?=
 =?us-ascii?Q?oaNyeuCkhOH8a8dS0qZcHSk6Fk7pfZ+eAyU42HjpSEK3Trk6oGdkIOxtgqkr?=
 =?us-ascii?Q?XxtJMhvm39OWD3hV+kgvp8nQG+i+rBZ42NWWzCuLte6e2GpJbJP+qvPeO3a5?=
 =?us-ascii?Q?IGH2AfEKFtKGdyh2eq3MADmwR9ZNuTt4i6nwFkJVN4qFWHiIPSEAThbiq/zc?=
 =?us-ascii?Q?wlLiUG6f+ZDI7PDt50qfA84c/QI26/P79sw4htfkxGbEpmqAzlTwKyXS844Y?=
 =?us-ascii?Q?GMU+PfMe/ss0u1nhkgtrQly6cm+rSCg9+QD3AwWwfVvPJrz5nSNWtOLzx9+i?=
 =?us-ascii?Q?WbDDP6n9/nmjgV7lOKf7vAW5XnELvzNqwjkllJG9Ib1wke4scCV5riZEcylM?=
 =?us-ascii?Q?axme0xptV9EQ3wIy/WP9gTYXEvAsvQGvreQT4pDOCwaTA84Qv6S59wi2gZnF?=
 =?us-ascii?Q?8ps3ffbm5gwP6wv6JTTn+HStJ9CxskI4V2qW6ZTVDRSLI7UOpAKdssAm6iNq?=
 =?us-ascii?Q?4pOAzVaukiB6VYkRGZenmvI6wHvZvOHnTNaY9IHGAV2s6v1HNi4hchzh5zJG?=
 =?us-ascii?Q?BECsFhcuJ7KvmjKNAbWqExGtJbiUw1DtJLLlaqCPHofDdrFenIVXNmBiixv9?=
 =?us-ascii?Q?/EfYsWuYlDtU5vXos3r2XgAuPg0dC6vN4GMvTee/1dhX/e4zw0i5efzcXR53?=
 =?us-ascii?Q?U1VjBppDwhx6BKQLgWdgqq8gNOd51/WwnrbcW/GQPAmpeSL1h0HnxpZVH4py?=
 =?us-ascii?Q?GXkVcTeQ6RskH+YbG+EJMpqX977hJm8ibVlNQybUgiwZX4zUNHDoJzQWIj1a?=
 =?us-ascii?Q?yRUqb7bPigBg5MQBOegQkwqXJuj3MWeXrbA2vFdiWIBXJO8OwrgKWfy2pFDz?=
 =?us-ascii?Q?W13d5OyjW4gdi6BJiI76F32Tcio6yLT1ASH1i/ZwQ3IBkPGMy5B78GVZ2RkD?=
 =?us-ascii?Q?PpCHRAuvRniXJFpPq7MIrT5HZcpVYORTL5ucKdRcgLPFSCPW9E4zOP1Hj7Q2?=
 =?us-ascii?Q?ICgtwngXAxyr8FLFTRCHKT30nZXGFkDLDvpnBghWx7CEuwkqnjqH1eOi++eU?=
 =?us-ascii?Q?d6+3xqYtNoWPi0EZHVON2bnzoxypzq5xzW2aJRCtzB0SkBv5GKPb9RQWqAhL?=
 =?us-ascii?Q?zzLgQQaAOt7AJCZJrcPUbRleyjDf2Y7i4mfFhSECfe+FoddVl435EPyeHUso?=
 =?us-ascii?Q?laxyEf5fZWuMDbvMuDuJJAe4LIUlfvvtAqlpemNSoAqoxonvLggoS/qJffwd?=
 =?us-ascii?Q?NpRd9mFA/9D5TyKud3AU0xOBuCX3KGqYvaDXqeEH4STIiOfEmQSLgPMdWmIP?=
 =?us-ascii?Q?BuX7pQq4le/47QlvWSv52L4zXp4Ji+LvaWigKPUTtcfAqQm9iO+JKQMcIrJV?=
 =?us-ascii?Q?PQIo27mbhFotcmulVeqgY4w9rx5pPcrqwglH/U1STXBfVxVeg1NhkargfXdi?=
 =?us-ascii?Q?TcxJbQSPi7WSBJNeiSWBK44CXlrkkGSwbAvhVS0xf7iq6HGJD2OEcDmBfNJE?=
 =?us-ascii?Q?t8x9xWb2oIsyLe8fJc0yHF9C2coIMsjTfAAycjP5JCJ2O9uU6ax6z6/5MrPm?=
 =?us-ascii?Q?IGyTY9uvvfUGQttZUfazFilnfOCEVvuXOG3Sn/a5zecahVe6fFPqPIdtAGtK?=
 =?us-ascii?Q?ol0crdmjUbLw0TpzTbmBfM2sNpDu6NlOv0+AeI311WqgGEUiMz/zzT6YF17N?=
 =?us-ascii?Q?BSUelwEwVw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21dc550-98c4-48b2-637b-08df4ad665bc
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 09:28:00.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XohfsOOdECBSgWfnKUaWzVd+8OuVB4SW2udy1F9ssruqjXHHUMUyxKtE3pYPTXJ4xC1+odvQx5CtJvhCnRhJFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942

From: Gustavo Arambula <gustavo.arambula@nxp.com>

The daisy chain input select value for SAI3_RXD_PDM_BIT_STREAM1 is
0x10, which looks like a decimal 10 written as hex. The other pads
for the same input register (0x538) use values 0x0 to 0x9, so the
correct value for SAI3_RXD is 0xA.

Fix it so that PDM bit stream 1 can be routed from the SAI3_RXD pad.

Fixes: 124ecd6658e7 ("dt-bindings: imx: Add pinctrl binding doc for i.MX8MN")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo Arambula <gustavo.arambula@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h
index faf1e69e742b0..2288b16bb48b1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h
+++ b/arch/arm64/boot/dts/freescale/imx8mn-pinfunc.h
@@ -474,7 +474,7 @@
 #define MX8MN_IOMUXC_SAI3_RXD_UART2_DCE_RTS_B                                  0x1D4 0x43C 0x4F8 0x4 0x3
 #define MX8MN_IOMUXC_SAI3_RXD_UART2_DTE_CTS_B                                  0x1D4 0x43C 0x000 0x4 0x0
 #define MX8MN_IOMUXC_SAI3_RXD_GPIO4_IO30                                       0x1D4 0x43C 0x000 0x5 0x0
-#define MX8MN_IOMUXC_SAI3_RXD_PDM_BIT_STREAM1                                  0x1D4 0x43C 0x538 0x6 0x10
+#define MX8MN_IOMUXC_SAI3_RXD_PDM_BIT_STREAM1                                  0x1D4 0x43C 0x538 0x6 0xA
 #define MX8MN_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC                                    0x1D8 0x440 0x000 0x0 0x0
 #define MX8MN_IOMUXC_SAI3_TXFS_GPT1_CAPTURE2                                   0x1D8 0x440 0x5EC 0x1 0x0
 #define MX8MN_IOMUXC_SAI3_TXFS_SAI5_RX_DATA1                                   0x1D8 0x440 0x4D8 0x2 0x1
-- 
2.45.2

