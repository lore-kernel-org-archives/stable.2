Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C439330D28;
	Mon,  1 Jun 2026 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302820; cv=fail; b=IX/tB2pvStdTW34STIZpS6WC8gBxKxvIzOg3VYYhQ71Ln6e8+znw7FHsv5fYANLwoXsDVcBId+RdzYnQTEItHUrU4aN8g5HLivTTVy0bvJEkGQNnfVl+IM5WqNQmFx2Yk15lP6mUwaYptR8sHLzGx9/ZpGwkts3lZLQgycty6Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302820; c=relaxed/simple;
	bh=X6szSaTwqvNS+xKSfGF9ZoDiW40tfkpshJiY+wX4wGE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=De+/wKXFGIIpgdve0s8szCm8RgjiN1QD9Tqm2xv/hRMeaT81I+nuJlP5t/auUJiLdRf26Lkzl+TNcaq4/telAUlM54enq82JJmu3lKEsNqobTaQ8bKSlu13cw+xzpd6kh9uen4vvnGcANnfuaYXtsFnTdbTfKkCIMWATzHgKUXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Mo0iu9jr; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Mo0iu9jr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHF2ISdVaQ2YdphKGylNZnnOMqcHioLnfS5B7Fnl4xA288Eci5hqoBubH+yyq5RLmnig0SjZd3mxCU74AdNtKLQfbNphHd45+3JW1Cn6RRZynJAF+OZ4yMTOQMcnpTdLGtFVrxp7Tk3Q6Bcceive5o9c4kPpf64CUQl/enYhsvDv+G5DUle4bbE3xIG+u9PEVeHU/MPs4j9Tl1bEmVJqKVSKhQvrfqI4rby712hzWcvmhPLN30h60EC9V6SVcwmues3FQ8PbRtRmloJabeXV/pDM+UR+LnfCr7GPE7oFjDkq9C54+F60ItabRfNF+WKoeVdifjLN8ajeZBY2aUoYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rglN3qgDL7bQtrWGGDujSghFcRf2EwAVhAzRD0z7ivU=;
 b=vZbE7SEo9VEmk61MmSRQ3OGZV8hG7Ih3/JTXQlS15YREhrCWlDfKOq25cM3Sf7b/XnCHxWTo/Cqj0B4oct7A3x04ugQ0lBs9sZO0dO2Y17CJx/20fYekDToBcGFnAiuBr8/FhMPAJfrkHp4IBK3o/Cwc4mWSEibbOMfsPP6JpRYgiv/638jtZPzIhLN2HV+Up+hLRCuF8xUhDEfI0smHjvmqn1K4HX894VEKlgX57hR7k0K5nsMCv45hECcRG8fsZH2USn7ILJZ0UmRyzyEFXBui+dTmOVU+sF0e5JRs4j75TBwZ+Qj3xNxs38ezT7Ma0+2i7hKclIZMg1T7O+mStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rglN3qgDL7bQtrWGGDujSghFcRf2EwAVhAzRD0z7ivU=;
 b=Mo0iu9jrnkNGbXkresaMP6v1Qm+JCTvfMQhzrma2VGEyeCIUAKAFOxcpRLAFDVdXWPoNhuoW6dDtdSdAWT0DD5NzGVpxePExh5UKH3eTVAa2DButTdEubARxU0l9YdZC6F9fPBrUw/pbLZah9RV1tY9NHDebzPDc5yY81YUXEHVPesXBXjTqbuIXxI+g2HQd1d8X0iXZFwWWJFda3GZmOzO0oMnv7GVKdQ/7mvfvb4KvloBuWKasaI+iCneCDOp30nfSbJRHxTrIz+3Rk6NQh7VFu/e9FMe44MYStkrINFAzxviH9LCIY1Fkh6tHwewm9lWppsqJOStoRVh8Ctl7jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20) by PA4PR04MB7839.eurprd04.prod.outlook.com
 (2603:10a6:102:c9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 08:33:34 +0000
Received: from GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994]) by GVXPR04MB10021.eurprd04.prod.outlook.com
 ([fe80::d247:853:3e16:1994%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 08:33:34 +0000
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
Subject: [PATCH v3] ASoC: fsl_sai: Fix 32 slots TDM broken by integer shift UB in xMR write
Date: Mon,  1 Jun 2026 17:33:27 +0900
Message-ID: <20260601083327.1535185-1-chancel.liu@oss.nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::18) To GVXPR04MB10021.eurprd04.prod.outlook.com
 (2603:10a6:150:112::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB10021:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: e942727e-14af-47c7-ee09-08debfb87821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	J28MWrSFU+5rHiWnyN99Km8hXSXwB9wUIFVEd9OavSbRVJiB8PH57C9YBwX1IV11dWIZrfWgt2KOG/dTDD2a1Uhgw9/xB61JZWz0fvnVGbqP1NNDn++Tjk+e1gyt2z3fJQ4VyPoK7L6Y+2g6kfwrMqCG9mW0GnYbMHE1sIlzt7abUGTIiRoesMKSwKXMZU3G4ny49URxQeN0PEOB7NU0xTPQ7BRhVLPNrWKoShFtF8V/gafAdCPOw2xpf2sHXoHzZVSuToa+xdt7jRZ9pIxMpV92clFyVE9rdB8g+3nrx98MUvgFEh+QTnsnEapitlNebKP+GLQGkPk0ShCibAYVe2NSuhWGV+xA+QEHzQD4cltgFKr+z3eFcgNrA5wEXKKS1YxX4bVdFDdEp4Y2+CLVYC2VP+zSREeyPbtaocAdbajs8YkG8BqlhduSa+kyb5p0gCBi0rqjd/0tXHDr4kNuyrwIRvUBDp7qyp3suEctTuofiW+ZC4MEcNc40FCayISwSTKOfZdKoB60gqVHXxQ925XtpeFzAAe1jnp857Fzka234TUBiG1UVNevOfFCAcyFb0Cgg4zdOup/YFTdLBLiT3Jtn5z0hX2Ntod8Ug3n4tCaUEEdhc7XKvUaMC2Vi5u3K25a12vPZeJyHSUgnWLhPOZUNk5cLdw8Sb/T2Qrrjr7C7UbWC1iD3FQXO0qQNxUM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB10021.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9T2AV9YzVvUkY4Oo1xWybY9q0COygvpner0aPTvUL5JLygE7msYbUXetxPPV?=
 =?us-ascii?Q?xPomd4saIuZm/jH82LCkbpZIcBhV/4dyQgIG9jfne60ny/4mNwbduhn3FrY3?=
 =?us-ascii?Q?imoSN7Q4KTCfL/QtwXlegrSn8/BUqg9xpKaAOc6aockUk+4JM9FY7TTa3guU?=
 =?us-ascii?Q?CHbJq7OG5nJHVpQ+87e2wM/4H1dqF5wPk7ulI2Kh5ZyCeShpoVlxjD9szxtf?=
 =?us-ascii?Q?ICz9MYI5em0gvu8xOpzoW40rxKGcei4IUqxqPvJHNoG5fh01KYKcYPVwL2kK?=
 =?us-ascii?Q?ssYVWh6IQv6yAoopDeTtmDM0Sxx/n3plzZiqBNlv66aIgzmIxWQF1cnLupCG?=
 =?us-ascii?Q?rwE6F+cV05pQG/Qgt0CRyIKTsig9JpA6sj8TpiN5VVBnZz6N1F3uJjWgqO6F?=
 =?us-ascii?Q?8xTwdxPoXPcBl32CrvSTH927zmokA0a7zFr7boPnUkHQRkIHKO+ZyQcWbUFo?=
 =?us-ascii?Q?aVCBU0b0ZsRB7nki2eFeGm9UY2+QmOx9AUcBzeHzkCWdAN4msRjLkwoaHvS3?=
 =?us-ascii?Q?OYS0HvAVWjxjya/bFnFQztxGnqrTQDD/9xdmd2BU9LAyqsKOZiLf43JEauqE?=
 =?us-ascii?Q?Izcd1/6RZN1DW4Nj74NkjOO1poQtd6qzwfakzq5w+u8pebSuuUWQkLIF/sIW?=
 =?us-ascii?Q?SKcBsXbBU3Paf5p6pc+U7qJXYibFASoXYEW8Os5sDtsIERZBb9mOMtRKN8S/?=
 =?us-ascii?Q?KqptMLS2YcZWVB3lehWqI8HgM1FbCchgknZ7tvRZ4iUs5Q3Ztf0Ku0KyKG64?=
 =?us-ascii?Q?mi6OJku7d1+b4N8Bqa1AV4lilYuvMdo50XkJ4sRnWa/osJB0AbU9ZS3kexFi?=
 =?us-ascii?Q?dWeVAXgwBv0hfc6kKdRpwbFkeqZfAekb3jBL7DPN/xq3zw3WAFHbkFNVCc7X?=
 =?us-ascii?Q?1lZHBGr/VTZWgiVBEW6GdPDFsVcLuzDoMTuyiFOynPFtoot9IuUe92LTgrPC?=
 =?us-ascii?Q?W3yQsJnHs6jD42XXTJzZE/DkJIiRPneTOfB2YmWRHRVLwKnbla6fAnD4yPgk?=
 =?us-ascii?Q?UpFexEbw3iUQ07xFiizQ5rMX9IpAnou6/H/XJd8fvShSkwQLaeAN3oeSh8vG?=
 =?us-ascii?Q?AkEEuGldIXUddXeAXcN9Eksba9yErRJjjhtaMUtoOVvsP+1h7k07uxCr7R/P?=
 =?us-ascii?Q?H2W6NyGqQKHyx2X5taG+QUzi09+jPDFEPU6bqh02NPmzDDAqvAvDrVVqCY0/?=
 =?us-ascii?Q?bsyiXFjtaiLHLa1qyTGMd4D9xf8kqkIlk/hJ4lhnNjPfzQVIPO5zmMKupaQy?=
 =?us-ascii?Q?17+sox/03/1XAESIrNYkbGg4owROiWLg9e2jU7+rR0pZkiYrqkzwgBHytklW?=
 =?us-ascii?Q?f8bD9ZrLGuDRMQS+7bAS4JEkcIAD9brJyl5yWrsCXSYbVQRjO3sLopTC2Ukw?=
 =?us-ascii?Q?5ZpuQ3A7hhbOn+rqxn4x83RORNywjk6DFVqWoBNzgpiuhrutYrqehMOwRcv3?=
 =?us-ascii?Q?IaLR492V8L9qemL97LHxR0LQNVdlB479IXupJGt/CtrzGLk9Sg4iQP8k2H7l?=
 =?us-ascii?Q?qtFshK2bCSJ1bJpSPCoXwdMyHuJiHHC+eBT0SwcCNsl7YZTkYmr0Vtux3sFC?=
 =?us-ascii?Q?4xU+G3JsSfgeKVgXtbwumJmAsIEb1W5MxSijPcEIec3eYb25N6tfBhFrcuA5?=
 =?us-ascii?Q?y2vBm3hzfuzFGpdF5gcz4CE+eLuQC25doUJ/lFyeGiGfeYE3aYe99HpKvOIN?=
 =?us-ascii?Q?lfmTKNb5ptXi98qREcLecTFpU9GSWsCKXng+aYffMS0Mi0lp53W2jQLwqaEC?=
 =?us-ascii?Q?p7Qz2+n+2d6mSunYsnUdYiZHyes9lrSrfgFynygIhNCNVaT9q10Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e942727e-14af-47c7-ee09-08debfb87821
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB10021.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 08:33:34.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aBKbh8pMVlhhG1ZX6PYC/G83sCCTB9YEiW/KFBXAx+/iBgiBtTi1ct/0RoqYiUF0s+WAFXkNIFyKMFTXdz+0dAtsfzJ1+4BZhvhtdnH4XvQxBam2JHyM0UQaiCcOX45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

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
Changes in v3
- Fix patch can't be applied

Changes in v2
- Use GENMASK_U32() macro instead to make it clearer and safer

 sound/soc/fsl/fsl_sai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d6dd95680892..9661602b53c5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -797,7 +797,7 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 				   FSL_SAI_CR4_FSD_MSTR, FSL_SAI_CR4_FSD_MSTR);

 	regmap_write(sai->regmap, FSL_SAI_xMR(tx),
-		     ~0UL - ((1 << min(channels, slots)) - 1));
+		     ~GENMASK_U32(min(channels, slots) - 1, 0));

 	return 0;
 }
--
2.50.1

