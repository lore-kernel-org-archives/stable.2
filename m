Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD3E258EC1;
	Mon,  1 Jun 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297554; cv=fail; b=L4ZlzdLoKmBJJ2+CLmAAieGiT3nmhnGdLnhtHMw9THjk1Fe3OrDZ5fNQ/rZWWuc6O/9fE+q/UkVNZL0YRoOhwrDLVIm/DKRudyFhxBhUjoVG7GQLdPIjC30sf4cMM6hw6pxUVN9RZxAixpIFJ7f1nfdxZYcK1zlYj9LXqyb48iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297554; c=relaxed/simple;
	bh=N3I+fDekBPF6jrqfhoMuS1EtGkkHlmcO4Y14anyslT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNlfawuEwZ3szIeKJSvCMAklTkqSjSqEg50AiZx/gItBUDf6EBCkHEkY6udiZLxT/sJH6+p/DQfaGcWt+UVIyHNWrSQ++CZX0YpsxXOtB9E/0C3Jv7uW1FuUb/nPO2L+96o2MaWeyZTEChDGQ+cxtqW6AJsvDj0Yua8X3PrGI/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cK3PgJxy; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cK3PgJxy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lngu8U/Xk2l8xHFcEmQFoYuOZWziyypLxQnKnIg/fEUwblX1XjMuKLo5KGzTPCLY7YH0ltNoQlDAmGEgGuvPmNfGhV3Sz/AOfVZd1+o08CaMIpunZFpI8OsaytcMWTnDZ0D/5TYS7mzrQDbJ7BiQ9QjrdaqegXptmc4qPsRj8WCTEkGKcNYniXcu7Ieet5y3YUJxV8fjlIe14GvLN6XVx9aYSRQTZboGo6I60i2ztrgAwBqjPmu4rg4Jc95Tv7+FXOcD36fuyhNppmj+N74RCQk5ygqRjty02G54sUlEKgPKyyCzhPnNgtB2+WQe/d6Yxb5rXHKIn60xhruTKbDlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO46UUMm5RHzo76c0Yd/ZCJl++PZbkL87KqWnIzfEfk=;
 b=BQ1XBnORNr9u9Hcxf2fPLP92knryV90+1Jjr2fXI3Vz6AFFn5K3BrfMPf+BtBuTIKCqSqbAZDE/9bZmy6LbQ5GPNjvuoPM0y+uzkIWmhPl9Qnb6tLC/PnnMa8d1etLFL2Oet9gZJSkNyrhIfe+vnXAXmzK3MKJ4hEtNXwNx3MBVH1AxrblevZvZgZa37oxMWNiB3kkxfJPIEiP91JRFViqI8mvj+usY52JZ+qsN0MOhPMKhzB6IzkwI8R3Xndwdk8H2Tdbm5FoEKIahbIG3bsheDO4XugNEkLf4I15kXO1/ZPEY15G8CCGScsxRq9Q/XxLLqI1uyl8tQph2nL64rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO46UUMm5RHzo76c0Yd/ZCJl++PZbkL87KqWnIzfEfk=;
 b=cK3PgJxy4ZRZBo62GdTkqCm3hyObM684Neb/vDibGR4gA6tZtIJ6+n3oh5kWq5UU5tQ45vA/PyJZYI3tZmsvYvjxSeEfOHPo5LW6JXj+fRoLv1yemmv1oKoNjOvB5h/alrat4G0NEQV4uAdlFc429X/eTE9WmN3FYCX7cCFi2pw7x3oAVOk7kPnzl16ms0BVPQWhmH+CPQ0BAzuijIbJ7ueuHesdjC07HQeK9h59wK8y08nzfjMiITp998VHicS+Oni3Xvpk7quNOObrogwJh1Js6N1wpVCNSlXAUSvSXUcIh0qS1kIgkh5gJMehSOaroGdvQWUzNsfi/GVy1+Gxvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by GV4PR04MB11403.eurprd04.prod.outlook.com
 (2603:10a6:150:29a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 07:05:49 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 07:05:49 +0000
From: chancel.liu@oss.nxp.com
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
Date: Mon,  1 Jun 2026 16:05:43 +0900
Message-ID: <20260601070543.1351629-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260529085020.3727790-1-chancel.liu@nxp.com>
References: <20260529085020.3727790-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0110.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::10) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|GV4PR04MB11403:EE_
X-MS-Office365-Filtering-Correlation-Id: 286326d0-16c3-41be-9013-08debfac35f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9cwpCjsyLe4Lo1ntdGfmQpBow6zamnU/SE3dOCBWlFFx1vO1o6FfQLCrrhIexaGulicX+k/DRMtmJGaZq41uZHE7n35+MdZunV1yktGET4WRwE5LAqwHMGHUArkizCWtoeMRGVO1x4AP7Gi1K9P/gBeWZGGiXRvsDNgSQFocbUsNkMR7JeiJmMacPDi3ew7INYN1fBakgknkvv8o+uVi75P7yI7AvN373AZIYSHSF60X9N0qyA1ilrmSpQSVXrNS6iQJkcLpyacx4sJ/zKDtPylRhLQOULgdDPtrBh2a8v7S9/IjAth4UlSAEoYX7AOh2FImGhWYJTgU6JoIiqZM7I8hKNCuTsTIqfo+Pblix+lf2/MuZKlPhljm89yxhqmbzMfv7IsAXxf+rekCVU55Z73uzoJcGbJ732G99HBF8I2vUKa/PUmAekEc6dYDqSGbPHF9Ty9PllOLzsvKI70M3TSbpeMDn6x41ZLq5YiSj3siR9Ox0y8riSpqTCDC23HWQqQqe3O5QLFXK9E+LuAzukGSeHLLQ5C5lujwnMVEYwXpKpNv0IcPmutrlIw7KLTW/RcaO7SZNgjM8yRKQYriN4Efri/AOncr5hqBR6rn5oS4qfp3nZ84C8YRnurxuXn/OWgarOdoOB8xnsdBE67ExKwE0kKyF8abSS4771bzAkCYl7vwOfA53cf/6ezP8cMJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EEokBmbxZjrkas0XnbQtTVlHdLkqlCvwgp1SRf1ny/s3k06nxML4iUlHq572?=
 =?us-ascii?Q?tDGSiCro4WMJs+Fuvqyr/A8QIb+8JW5yVYrflaWsdJ0CtX9B98jX/dNiLHLe?=
 =?us-ascii?Q?AxQDoqdrFww3boZNV0iyKnpj5yBtXbluysI0XhkYTW4EY1DwNDZfLX/QVFOF?=
 =?us-ascii?Q?Qz2jijQ9RBY16ZZHUCjvkiriG90WQepHeMgtogW35r4eIq1EDLLDBEUXhOOy?=
 =?us-ascii?Q?RkncRfSux9LEqdUH8vMY0+LnC8FD3eU6OCEaW3lQTw1SxowMoN6a36fPygYC?=
 =?us-ascii?Q?2sPvlC1LGtRDF/iEpr3ATN5xC+kiUiyOnUhqyDH9eubLS4BM0LXGXcneAR9Y?=
 =?us-ascii?Q?NcqDxPDGvVJvGll0BYs2U+oXpVrTpWcS2iqydjxD1kxsk0ZueRARnUYSBit+?=
 =?us-ascii?Q?hqnZ8nNgQEwTZp+iF5EoK2gDKvrpGwCunQQ9aeivmOtFNSvVuzdekp4Lx3BY?=
 =?us-ascii?Q?wR+RC+VK8pAaVnP7kTl6sPs4OjflCG0T2DqGtMaM01IFBeChdGWxDow6zFrb?=
 =?us-ascii?Q?FIm/r7rplSD9dEwWF5Gb82gy76dZAZkf7etUHVPXyqXiDnAOg7g0U/tNaquv?=
 =?us-ascii?Q?KYY99Qazfaa9A76ARj8pNEMYPBKdgH/+7xbPDDbdaBCGtsWQwiP3P79sCfS+?=
 =?us-ascii?Q?3rBdIzJMD2lDmr56qgcMeiw00GXSiwKCnA+zyEjJdUk73jbDWPwL8RtfrYQu?=
 =?us-ascii?Q?t/D66uarWN9ze4yaXTNIQtXf4EtoMp6SaAMClR0q02E4LYzTEYD6jbI7dZ0W?=
 =?us-ascii?Q?grhgtFIM+YboSq6LyI/SdgsfM4g3eOfqVNd31TTSNXWP9w33arFIPR+Lxtsp?=
 =?us-ascii?Q?Xl0RmoYG29ipDaZ4Ci5sXg9z78MooXTayWyhYsJflLiT8B43HM0R/aflsr/c?=
 =?us-ascii?Q?NJFaq9SAG9hyhNtBCxFCJN9afo4KJADdwsR+P66DgiDzpAtFjiTAJD3Bdq1B?=
 =?us-ascii?Q?2PHTdYllPavEns++S+SjlCdQdQS0UAjuBWhCTh1c9CgbJRZ+GnAGD85yyw18?=
 =?us-ascii?Q?W2t4c4O8r35WFvL+39+Sd7yPS4sNAmI8K59CB4DVs4IaK9X7KNVsQOEflRxx?=
 =?us-ascii?Q?dfRxZKC/c7l7JQLuy9RG8/8DUSwZtmEpJeOnCoriKo8Z/jjpf3vHNO6gGPS2?=
 =?us-ascii?Q?mi+1l8E0d4ouXpnntgn57O2pDmILiD5NGLvW8sY/X1nsovTgjIPUKG3jOm+5?=
 =?us-ascii?Q?aKvI9F8/YrDzNeIzyeezpdpFwRTSElHT5m8vGcYkSFsQ2j6rf4wsxgp/Qwct?=
 =?us-ascii?Q?UbKHZMMSH4iGBZcUbDQQ3k0Z8TuOvGUWti40GnbwrftdveZXZl8RJkQt+ZEA?=
 =?us-ascii?Q?W3dCTrWnEwIabyqMAFGVm/hGPJeVNq1VDFikA+zNHPEKoTKsMwSenPO9nGtK?=
 =?us-ascii?Q?0jqKLWtDPen502xrd2id2woInaZneO/LVxnChplFP6IhVCHrDx0Hite8135f?=
 =?us-ascii?Q?9lqcwx9CqZNU4XruCxTJ1HhzU5Y1cjGYnLfhtxjmfLwkmHDLG2Qhete9nTny?=
 =?us-ascii?Q?N4IFEorH56Z5HKAqW8/T2gPwWIdrjeRoKFYTFWXtM6QZVgyeWVs2X/Jsihhc?=
 =?us-ascii?Q?nTU4UsdhIS/XaE7QdQ+6V4nLe1O4gDWVNifbA4NbDzj/F7apihZEOKBkVmy+?=
 =?us-ascii?Q?9n6wQU0x02ewVpeE0cfD0/ozKvp7bLuaW9x8L3WRKNlRIM92itoKbllmU642?=
 =?us-ascii?Q?KuZQfjCtklD0k9K1Q81k8IWMOlSFZsYrtrDXfu1mtBfAe15QLEiiMgLcpKGv?=
 =?us-ascii?Q?EqknPG14SSZD5tBTf4qg0XA4nFGt+UxxElcNZDnD7O7muXI/hSt/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286326d0-16c3-41be-9013-08debfac35f9
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 07:05:49.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPFbfPZNhRWXMtCcuzHC1eOXo354dy5+Cyx04YVh3F19eyjhI6g4HJggP+vgkPowNyIW4N9vRyOVUMaBoMxv1gXcNiSjL4o46Jx/3NfBSwwBayJNcKrGglVGuYzR+nT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11403

From: Chancel Liu <chancel.liu@nxp.com>

When configuring 32 slots TDM (channels == slots == 32), the xMR
(Mask Register) write used:
~0UL - ((1 << min(channels, slots)) - 1)

The literal "1" is a signed 32-bit int. Shifting it by 32 positions is
undefined behaviour which may set this register to 0xFFFFFFFF, masking
all 32 slots.

Use GENMASK_U32() macro instead. For 32 slots this produces a zero mask:
~GENMASK_U32(31, 0) = ~0xFFFFFFFF = 0x00000000
Behaviour for fewer than 32 slots is unchanged.

Fixes: 770f58d7d2c5 ("ASoC: fsl_sai: Support multiple data channel enable bits")
Cc: stable@vger.kernel.org
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
Changes in v2
- Use GENMASK_U32() macro instead to make it clearer and safer

 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 821e3bd51b6e..9661602b53c5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				   FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_MSTR);

 	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
-		     ~0ULL - ((1ULL << min(channels, slots)) - 1));
+		     ~GENMASK_U32(min(channels, slots) - 1, 0));

 	return 0;
 }
--
2.50.1

