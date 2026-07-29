Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799C435A84;
	Wed, 29 Jul 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310845; cv=fail; b=ZNEAJdfkz4eWctuu5jnv8rA508doXNBJbVGYKWTr8HmdumHajenWooj3SKvc/wkaMpYgTckDisIrnAmy5W0iiGttZ2L/USQLRuJkdvhWwjiBbdaSrdCFKyhBVQpFgemdzNAjFSLGgYbbFsXT8qWxFtZQdwvSCZUdho0l8SQDrMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310845; c=relaxed/simple;
	bh=KZnBDwR9hzzQTmRP/DXKJRkxr5bvfsI7agxXcHGKrhk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YBDasOkwGtyIq/bcu8LrEl4RGyhqsazrrrckxqLau5dzkg/mGbAqryTocWAmLFQ9SCFf6OQKy+BhuH/nJIq28dKWJztRQM/bO6Svxh3qLjffQgMvy1DRtzWIcP4ax93cVf/ZKx7nBD4uX0+bUrujy51M4GXuN3dmASgOWouVO4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q3wnWpmc; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q3wnWpmc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH8po2C2FTYwVeowS9BRIAlGJ8BlHdHk+B7P1ADpAFQjQihdEg+nzsKXuNoNNnjkl+BI8czoqFxBrZpLl4Fx8mS0IEGRBmtuUM4JOUSgkW1/6il3pJEveAMyTHFqtx9hfq7gy5gdvqnASqTjEHWt8Gg1dsf1LMZZHbsZaGaaUyysy9WvpfHX2dt4UBS50roUp3r+XzE+QuxYlwQW0UQnSagqKweMnSWVuYboEU+jURnXUCR11vOzjyWqNjcBdCgxYoYm/MnqXKV0yomKHXrv/ybEF9hY/yDPt7bnlIW+BeO+oy9cc5lyfl19BCDPC8R+WONGPyd74qWs0BzI/DmegA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RDwZBDGZXPZXqaVj4Oqwg2mk+ASM6iTyZaWc4fDXbU=;
 b=hiWMEnrKOSQt4IXgGAoLTG7IssoHjvcu+dOm67fzyvFNmDpGAGyM74plSktOw+CsaGZStOLcAoxn0RLCJwEVYXLe4V/8pTM0LfcAGb8NGpAzKQgNJntK5BJ/tWTfh77YXg7NPG0TkwECZ6kPnBfBC9sD0ZCiV209OF2F+FlFcJLmecVgIJWcO0KsgyIonl0bXFd0DYv1CmznbsDdeTziGFY2RVWGbdvKtHG1LWJkAPxIqGD650vHcQfiCiKMmbZh7clyDjkfGZFswVSkIAfwUNoELJRP/b65ZGOwrOrJ0UfdNZcP1bGDnrdYyNp08sRsa0AbnB3eUsO2137oQblDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RDwZBDGZXPZXqaVj4Oqwg2mk+ASM6iTyZaWc4fDXbU=;
 b=q3wnWpmc4ECCOx9F9PbB7WWsfVm6PoHgGK/dLDroK9eJXJrtQwJTPr8/yi4BGJuFkXoZ3phYPSVsvX+EDO5BteToF7PBCJSl5TnMtmjap97ISC7y+aSbauclTwHekgvZA4aTB0ZkkBsybZd9Z/maqAuoDzlmySnps/E26vOOEtjm0eG4Nob/E9UnpaXYzSuAza+alJG9l8U4uqzl1nyrQSAqHRWGyvjEr3VW8l5DkudaV5dyZxxK61qyynx4rDPCLGuxuGiEjPMndZbRiaH5iAnWMQ9xvT2A4v1kHSnUnCRZ9nFNvNdfwb3KOxzxiUxhwwebqWgHI1Y1fWriyDtTSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PA4PR04MB7903.eurprd04.prod.outlook.com
 (2603:10a6:102:b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 07:40:24 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%5]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:40:24 +0000
From: haibo.chen@oss.nxp.com
Date: Wed, 29 Jul 2026 15:43:29 +0800
Subject: [PATCH v2 3/4] leds: pca9532: check return value in
 pca9532_gpio_get_value()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-led-fix-v2-3-09ad218457bd@nxp.com>
References: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
In-Reply-To: <20260729-led-fix-v2-0-09ad218457bd@nxp.com>
To: Riku Voipio <riku.voipio@iki.fi>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785311027; l=1604;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=P9yYVubLoJCovnJ9Ep7KPGt5/pd750yL1W0Md84J07s=;
 b=vyHTn/+6Jae/plxBUTWy2knIkWzQba7oDQ6VdDedkIobeuuGSm92wxN8g782ibLIfxLsHmrwa
 PQPDFoz3ZoiB6XgdKUctYwtHkjZVSYH3zjUTSkl15acSnTN9ss2ACLT
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PA4PR04MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: a8209d37-e990-4bd6-8644-08deed44a6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nG+fQf7MgQhY0Ku2G5POBGZEWcEylsbUSxRiQ8HCD7qPLYWgU3FRWrmhLsPlQueXnThZtS8VCtQ0yz84OWwKRk91bxLjaSjZaYdgkeW8RgoWCn+1ZDX41/QYeed+xY01ibCMiFOgHHnrP7Hd4pcwrvKmBIV44pvrXF8DdxlmCwrggqhY0O8mTzxCqp2LxTolmjc54CSD3wmsfAGrPk96LQFop8eLYn2WjiQIfGh2QPemH7nQ7z4efn0vCyaQlDtgjYKzCz860a6uVM+FP+5m4OCKUKHZVzvt5tV8dni4U70clkaPH8d10GX0gTNjRDypvIwCxLk2s2V/1ma5g3bO3+0NeAOQT26UjErc0+T1Pk65qjIcaRpin1vuI9KZCKrVf+wzLovzCVH4lLyTJK+GP55Zdomqw/17jX9jl57ZnACiX9HSjFhy10sNKLgD+pK153tPxk6OQsJhR2bzDXtOq8/7iQPtnyDA4CVDHVSoVcdn31F4itlBVy1OgHs0gJlxGr75Gx6yr0lq+5p8UDlHvOOVkLO99m0TXOSK0QfXisbyZv9AVZSF9Wu9uqOR0emjjQUsA7DiMtcobdxS3hZBVcSu0eCHnzN+T0ldOSZrLf8Jw+75DFzlPkDePJyhAF3t+xfBsOqttlZaazxtVLob48/5U+PLCPSv3vZf/IgUwB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tyt2Snc1VkZmNm02d2I1RSsvUGEvSkVJaUhGcTJIZ3VYdFltY0k0N2E3ci9q?=
 =?utf-8?B?UVFpWUVTcnFwNStOcHkzblZGN3IvelQ4SjZxWFp6djNOWUh3TmNRbElCT3lU?=
 =?utf-8?B?Z0tEVEpRazVVb1ZzVzdIaXdCby9JaEY3eUh6SXFhVWVvejg5elBtL2J1WDZE?=
 =?utf-8?B?VXZobDFubHpBRXlkRnBoc2NkL3gzQ28yK3g3YkJ2OVVZdkMrZ1dxbEFtdmFQ?=
 =?utf-8?B?VVp2SHUxcEsyQWJEc3JGR0U5ZU1raHlTZEJGb28rKytnR2RMaUhVYXd4eWRG?=
 =?utf-8?B?QlBHZGNsT3VUS1QxMWpsQlFwSFp0Uk5pOFdjUVVId1JnSXR3SnNtODlpMExv?=
 =?utf-8?B?c2lHNEk0aGRqaU9YTEwyeFpUeGdOTTdkWWIxN2tHTnpUTi9pcHB1TDNOZ1Qv?=
 =?utf-8?B?RXV2aTYrbjRjY2hjaTdnallmc1A2Q2I3VVk5cE1BSG92U3J6bUFZS3QxMlZS?=
 =?utf-8?B?QXdBdnZ3Z0JnaXh0NFNtR2xMUmZhS2dmSC9iYnhScHJna2drZ0w1N3BHUVFL?=
 =?utf-8?B?cytOOXVYT0RjYzB3MnNEYkVhaEdEbHE3bGFZdjNNQVpiQzh0UkR3V1FVTEZw?=
 =?utf-8?B?ME5WNGMveThuNWdKaklIcHlVeElVYklaVlNLcFFwaCtVK3UvK0d2WkFmYklt?=
 =?utf-8?B?WHhDR3pTYjNtcTFCdkUzNFNqbFRuQVRISXoxODZvaVMrWnprNFA4aFBUR1Bh?=
 =?utf-8?B?YTdNTU5TZ2tTQk42OUwxK0FvZ3RvQkx2ZXFJVnlSb2Y5VVRoYVQwWlpSc24v?=
 =?utf-8?B?NUFSWkZ2SjBvL0FvMHZBM2x0VXcrYzBpclpweHg3Mmg2YVBIRW1XZmQrQWs3?=
 =?utf-8?B?bC9BYWErUUdQRDhwK3VjSWJDdnErSUM3amU2cmxTQlU4aTc0c1hZSlpQREVI?=
 =?utf-8?B?Q0RaeG1VcHhBQkZnL1pJSGx0Ui82dmt3RmNWa0ZQV2dPK3B3MDQvZmVaWGlL?=
 =?utf-8?B?U1dwVFl0aERpS2RqM3ViZU01K0VuaTdZUmhNRVBoRFRhQzJpWTVWMVVUNVVH?=
 =?utf-8?B?T3dyQzNIemJGWDhSckYwd0xjcGVPNlA3QS9jNUFXODhqMHNkQ2JUdHQwWkpG?=
 =?utf-8?B?blBUeU12bWdNVGNFd3QyTklSSHZQbkFTRlpOMWl2czAwMjhzMFA2d0FXZVB0?=
 =?utf-8?B?UEdPTEtRUlhSWVdmSStJSXlLRlJqL2NPelhGdkJFdVBKMTYyMlFDeDdiUTA1?=
 =?utf-8?B?Y2tTSWVveFR0V2xRM083ZDNWR2pDUkVIOFBBcHZENWYrekFWU2tRZ1NpODh6?=
 =?utf-8?B?VTZhaG95d0VhajNuWDBzeHEyUjNvNUdMNVJTSzJZaTZjUjJOclhRajg1bGlL?=
 =?utf-8?B?eDRkZzZLOVZ0bzRqUkJFbFUxcVpWT2xYb3dpVGt2OUMrTWZlRFJnaE81NHYw?=
 =?utf-8?B?Ulhac3I3ZUtGTlVnbE9xaWZsTThiV2tBd0NSSmI1L2lhaDFBT2JLQWFQZGxV?=
 =?utf-8?B?enpSd3hKUTAybWJFa1NOL2wvVmJLSm4xWU9ITnNvWFp5RFQvUko4dUx5R08r?=
 =?utf-8?B?a0RpR1B5WVVVZEV1QU5EM25vTjkxLzFCVjIzaWZPQTZlWWVzME5TVkRwVk5v?=
 =?utf-8?B?Umw5ODJsbTlRRk85Q2F3NXRVNDhpSWxldnpXRk9FZGNpWVRmZGljRE1PR2NY?=
 =?utf-8?B?c1RpTFBGUXFCYkxDb082cUJMUHREYkxzWXlyNGtxa2oxVTVqVWlTbUhGZ0hj?=
 =?utf-8?B?S0Z5UUN2SU5oejBQbUVsMkFPUFpVTzZ0dThQdWhwSlhTTFhadTFvQVpBN1dx?=
 =?utf-8?B?TjE0SndQdURWVndDOTJjV0pnQWJvbkhXMERpdDRoS1dyNXdGZk5Yb0xxekFx?=
 =?utf-8?B?QThtbFJyWU1DMTdmdmU5YmhSbXd0WFk0OXByWEZEbWNXbDB4Ty9XVk5ENEZ1?=
 =?utf-8?B?Mlo5bUtQdUN1SmVWK3BHYzJuVUNjNktoa1lyTlErTWtFRzdQWDkwWkQ4eEdH?=
 =?utf-8?B?cU0vcTdxY3JRVGpNUjJaWk5tZmptbFVFSTl6ZHBIZ2hVTHJBUXRWTHlWUkQx?=
 =?utf-8?B?bjM4c2ZPYVhJNks0TVQyTy9jMExLbERGWlZDNHhrSGFMN3ovOVBkTGtiUWJ4?=
 =?utf-8?B?aW5hWVJLOUhxbVUwaXNFaDhYVmZQWUFyejlpa3pIOWJnN1dCRVJXN3hwc2JR?=
 =?utf-8?B?MVRsdzVZUmhVNExpZGc1c0Q1Qnk0SGQ1Q3QwMzJzSit1eGpCYXFHM2xVTzJa?=
 =?utf-8?B?eThIQld1TGpGNnpXaWtrVWFRVi81TTFzMGs2dGR3dG9lT245WFowUzAxK2tB?=
 =?utf-8?B?bGNIVVNTNG5CQ0dhTXdoa2M2RlRrN1hLQlBVN1lBUk4wQlNJMXlkQUZqTGNJ?=
 =?utf-8?B?TE8wZ09TMTJxTzNCOGFHM1M3RFRndkhPdDVJQ1ZYVG9KQm1FU2UrV0V4RjJZ?=
 =?utf-8?Q?Kafc9O2ECN9EmTqPONzQR9t4vWMl1P2NbcPrw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8209d37-e990-4bd6-8644-08deed44a6d7
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 07:40:24.6967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KCHbmRIpwlwtEtSnve+Z93ebJy6LAPss9BeHp+xW6Rv6gRhsVmfTfwuM0/XO0vPytr3MwOyFbPA9gNiHrzFOTICEP4v5F9ZiQDw0q9Y5Ssb29rBArLpUsfm4SKk3eV4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7903

From: Haibo Chen <haibo.chen@nxp.com>

pca9532_gpio_get_value() reads the input register with
i2c_smbus_read_byte_data() but stores the result in an unsigned char and
never checks for failure. On an I2C read error the negative error code
(e.g. -EIO) is truncated to an unsigned byte, and a bit is extracted and
returned as a valid GPIO level. This masks hardware errors and lets
kernel or userspace consumers silently receive corrupt data.

The gpio_chip .get callback may return a negative error code, so store
the read result in an int and propagate the error on failure.

Fixes: 3c1ab50d0a31 ("drivers/leds/leds-pca9532.c: add gpio capability")
Cc: stable@vger.kernel.org
Assisted-by: VeroCoder:claude-sonnet-4
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/leds/leds-pca9532.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index adfb5aa50e8e1f3ca0deb9261d8c9103903ef928..cee398d8275b8953b5dbdb741c36161f34bba029 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -345,9 +345,14 @@ static int pca9532_gpio_set_value(struct gpio_chip *gc, unsigned int offset,
 static int pca9532_gpio_get_value(struct gpio_chip *gc, unsigned offset)
 {
 	struct pca9532_data *data = gpiochip_get_data(gc);
-	unsigned char reg;
+	int reg;
 
 	reg = i2c_smbus_read_byte_data(data->client, PCA9532_REG_INPUT(offset));
+	if (reg < 0) {
+		dev_warn(&data->client->dev,
+			 "failed to read input register: %d\n", reg);
+		return reg;
+	}
 
 	return !!(reg & (1 << (offset % 8)));
 }

-- 
2.34.1

