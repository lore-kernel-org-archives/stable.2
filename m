Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226F4183D5;
	Fri,  5 Jun 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657808; cv=fail; b=Y9N1dXYCzxVLcb0oVt+sKgoMeDB249vmfDiv3Bdl0oF9CKlHCMozkrTXwh4xvdMHz3gmu16nTVUoydZOe2N03N+/v9svbssy0+L5hZ2MEaHNZwAQo+m8c/Mxe/5k74v6UolLh79n7w8WBvNy7yC16LQ2fpE/twNylMwXxbTvaiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657808; c=relaxed/simple;
	bh=hEYLLjn3H0PKNWQRcmM3nSfIWbvHjWizdMbIaWztSKk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tO7Naa0tUfOD6e8ZSvs+oudriEj0JKwWHeM1p8K15UypazKBi4nuO+affnR/9IPKbO7wKxjoVaIYmeRCxZ51Wo/Ht+BxYAL7r4YwhjgwWKDqsURUl2YrLdxINPuVyVa8nlCCkcMWJ+Uer/xCFrwTpIvg6iYvdGEHS54pKgRD0j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kQinR9nF; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kQinR9nF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VteBlhoTCEmro7qrhzSL2piGGIHv7Eh268gzdquD0AiU9ZjVNrpj+9hTTpAVe/22FRcdoPKjy+VS7aGtrQDAYVNxsTMNVIdmuTlOvq4rOStWHNtwIM0dS+ALcXKvz7BMfGUb3syZ+VroCO5Wd2ka9A0r7dzHULtEsnYcD/6XTY8DB0g9uQupwbBiVtNXPrn6DDK7ay85x4W3wXFDkGCh/VOnsKU8HekRKbMj7EZ1wPesUzU2ppX0f+RhzYGcRcgD27EMeDqH86dDAAI1kpyNs4fp8MNMKa74UBD8igAUq9KLoh8+AU2jzmq7n66lUNUBPDHPuz2IZyAHpYWq6RYwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q82PVgIGzTZgPpsyjExIq+m9iYgUtH3WG4huRvZuYMA=;
 b=Yt8GYUGyM7ohOx6IFV2/6uJ7IbZotKVzK8E9jc4uk9yOEcOFQ9MM1Z+LNHJQvyvhkEqu8avucjhq13eQl+2pgAkrgiMgUMKmcGaiewpa2ZRKaqpZbeC2ga9iOXO65N2uYaJSMlvHAOMKrBq5LTGs39zrObULPi13nTlYnyDHuOC6RWFjO188Qpb0UwhOXlingwMsBKYHIVHLnnyhqWNxK4IN49KADkKW/biUjL+AlItY0/tX33K9023iiXdpNDIuL19Vemuiql0fpEd9Npbd1ixETwXPrfDiJX/rNgO/+99WRQjwrZ0mkRFRR4ytSxmwWhoOnCzdr9BUldbvKfnY9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q82PVgIGzTZgPpsyjExIq+m9iYgUtH3WG4huRvZuYMA=;
 b=kQinR9nFQRpTJ6YvORvCWe92IXPtvHRcVe2SkO0fc6zBgtD3u1hzx97Yw0d6YKLQFySqMzY5RP1CtrC822fUkQvXg1T2KPw3amVHwrzf1+jIPBFsj37YmoBizj7ESL0zUyVFuIa/yIqb1x1WgGpBheAIbThJUxPEhYGTo7NJ2sQvgA/Fww3NOir02NTVDKZ4RMIWou9AquejYwTIWIs2rse4MeYCB9whwWKmpNwmiYPchmlSv/WdHcVgB+7LvNOHGNeoV/BitG6kLwTAFAdCA6lPEFUK8/sBZnk4A6h5qFoM/rhKBJlsaz6Bh/FFzLeNM+fbUm6WTiyStHrgZN+P5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by DUYPR04MB12689.eurprd04.prod.outlook.com (2603:10a6:10:661::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 11:10:02 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 11:10:02 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Subject: [PATCH v4 0/5] phy: fsl-imx8mq-usb: few improvements
Date: Fri, 05 Jun 2026 19:13:01 +0800
Message-Id: <20260605-imx8mp-usb-phy-improvement-v4-0-b2ddf2f3862c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2vImoC/33NOw6DMBBF0a2gqTORZSPjpMo+Igo+Q5jCH9nEA
 iH2Hgcpbcrzivt2SBSZEtyrHSJlTuxdQX2pYJg79yLksRikkFpoIZHtamzAd+oxzFthiD6TJbd
 gLRs5KmFGoyWUQIg08XrGn23xzGnxcTu/svquv6z6l80KBTbd1JvJ3Lp+0A+3huvgLbTHcXwAv
 hwpZsIAAAA=
X-Change-ID: 20260602-imx8mp-usb-phy-improvement-4272d308d862
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jun Li <jun.li@nxp.com>
Cc: linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>, stable@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780657990; l=1591;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=hEYLLjn3H0PKNWQRcmM3nSfIWbvHjWizdMbIaWztSKk=;
 b=N03BqGgTXsqfBHAclij5ckjrXqyPw8GUJ17Aoi3XjpSS0T3HfTfm9yVzq5AUOx9JRhp99nSQI
 MK2lUyal+B/C8bBlTUgEVRiL69UVINI5+qJXmDL+xlitKI/m7nI1i/B
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|DUYPR04MB12689:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e59fca3-1158-40d3-e768-08dec2f2fd70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	EdhVY2rG8ZdzwpFwwhUPa/TREzKY4UndvDkuqYGtZD7VovJVJskqgGF3We72taweevS7HTKMl6L5Wbpn4sobvnBMk9tsMM1JfkLWvxtZUJFanfwfMB058y/y9zqYRkT+KrTcahEy5ZsMVgisgc+kS34/yN9xJTPRSzfMosW6z5xs0CTd/DYW5tFtoAPTfnFvpFgT4G+KJKmAPA5/l0cpvKdHlhg3g65Z3DYoAKi3qdUUGqf0PZJmLLtt0tfyNgExrX240EA3jjOKYw08E7WaQQ0nJPcUQ9GdPbyRQTlIC5x4cBbx6wn6djQdec87LxXjBiKBVSIciKvZfh1a3cCiilUL5cLJGLDw8L0n4i6PJzJleuauJe1g34QlLIqYD+WzFWlJZZzHYENHePf/SZFu60AtJSo3+bW3B2ecQLqtUQYhT2qAgYmigqAfWO/w81C0feEC1a16J0pFg7JJIS6H8pFXLnhwlBynXuVydINDSRSl/a5FMeSXps6Gog40VhyVNkhIlXOulCPYhkYg5kB6aZxkUJBjrc3+NjD4d9l6TSsMKuWt+kw7fw/lSvo1IqeRBLWcFmkIsGrnGQRc68hCrVTP11C2c+49PeE+YL/RcqGlfVMh5sEkdaGlHtpF5t/XpWhgHPJtwKjIYlHO67R5qg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnNaNzU1SFpnSW1qbDlPQWE5d3VtTm1KazhZZXFWZFpHU2lsSmQ0SmljeDNF?=
 =?utf-8?B?allCUUhMVWhzL1pxTXFpcFFqaWV5N29HK0lnRFExTThqNlFadGNNTmFmMXRH?=
 =?utf-8?B?SWRyNDc3dDlSMTMzOHgxYzdkemxHMzFHUGNaTXd5VXo3NEQxY2VGUTV5andy?=
 =?utf-8?B?QkhZc2ZwcGkvOU1EYS8wQ1lBZ3FVR1h6YW92WVpjRWNuWW1FeU5sMUlRWXFh?=
 =?utf-8?B?NlVzVlp6b0hVcGZ3K1lFblp2NjdzQzdUbi9CREdRVlAxWG5wS2YvQ2RlU1Rt?=
 =?utf-8?B?YlhqWVdLUndrWWI4RFBUdTZMUlh2VENVemdmckx5R1pvQldDazlodFpZTE54?=
 =?utf-8?B?a3cvNlY1Wjh6Q28wVXd5SGErVFdJT0dBanZQQ1ZuK0dFM3dwRGR4SElFa1Ft?=
 =?utf-8?B?cE1VV0VPM3A1Y0l4eGNzYXdrRHJtTnBLQ3ZJT0JEMTVKelFHQ1ZKU0FheWhs?=
 =?utf-8?B?L0srRlhyWWZ5OExUTnlMSWtsanpNM2F3aHBoQWwvWERvcUxMaU5ScXRjMmJO?=
 =?utf-8?B?OFpmVlVkbGl4bktNanI1NzNvcXQvekNFVThiUGZGUkhQcjlFWHRmTnFLanor?=
 =?utf-8?B?R1VGS1hTbUhqU0RraVlaRWk4RHZ0UXRidmpnZTNvdjgrOEFzYlBkWmcwY1Jq?=
 =?utf-8?B?RlB2aGUzc1MrQ29jZ0dxbkRaR0dyS1Qrck1GYVNMZm11RGtjYlk5NHNOOUl1?=
 =?utf-8?B?cUc1b1lOOTgxYmp2c0I1QnI4MFpJZ3RCZUdxUG00WngxdGpjSUZ1NWwrYktW?=
 =?utf-8?B?RDJhMUk4Y0hPc2FFbm9tdHFZTXBZUzZRWmdHOTg3OFRRYjNuMVhSZkY0dzU1?=
 =?utf-8?B?UDdITkF4U3pOYXdTNlA4L1RES1dDUFIreHRXcVV1cHhFcXl2c0R3c3VVbzQz?=
 =?utf-8?B?OTM5RGdISTJRa0VsVElrcW1JVnVyKzNkaHIyWWcxY2dPL3R2eVd3azY4bTQw?=
 =?utf-8?B?N1ZMV2Q5SUlRZkgrWk5Xcm92NmhvS3JVakIzRzlRQ1ZPcFRjWU5PSjRMUjBN?=
 =?utf-8?B?LzBSRGsrVWNlcTVVVTJ6VzhvOE1iRFZQaGNrWmNmcDhISzBqOTUrYUY3QmU5?=
 =?utf-8?B?Ni9LWkpoRkVScTVKWlRzZmtFYitxRHFFZHd4alFLSzA5MHhOTmR5VTlYUEpn?=
 =?utf-8?B?WXE1dk9CSFBzTTAxUWxOOW4yMUdPTktoRE9CSUpmbmtFT3lkU0cvR2NpV1lF?=
 =?utf-8?B?UlNzT0l6aVUyYkpzMXcxVnhBS3BWRGh5VWVKUVlnbGdlS2xYU3lOem1UV2tL?=
 =?utf-8?B?R2Zka1M3VkNNTWVKSnJNOGhyS0xjRFdsVTIvcjFXcUNBcTdVNi8rT1JHcHNm?=
 =?utf-8?B?NjdhMlh3K2U3SkpuWE1nSnVlVWxPdnQzSEJFRkhEZ2ZBS1AwMU5DeG82QnJv?=
 =?utf-8?B?OGVGUlB0WHR2NGROa2p2eUVhNEIzSXZyS05wbmozdkFFdi95WXowRmg5aVFw?=
 =?utf-8?B?czBkZVhHVTRPTTZQeTB5UTd4Ymd5S0xibXdhY0ZIQU9YWG5VdlpLNXVINVZm?=
 =?utf-8?B?SzlQYzdTbndwMnpsSGJmUXM2NWk4RW85OUJ3Z0NNRm8xaEJxWXd2QUFCb25Q?=
 =?utf-8?B?aGo5MTI0QnVNL1F2R0c3VUxERDArbWxqY29KdjBDLy8vdDNKVmErR3pnQ2ZD?=
 =?utf-8?B?V3N5b2tEM0pLSkcrUnFwTkZqOEpVTzlFZlFFTlRDWnJuWUxTWHBYUnNkVUlm?=
 =?utf-8?B?c2hleFVxSU51aXEvbkQ0ejcwN3UzWkhtYmEvWnFtSmZhOFhZMkVNU0l6M1lK?=
 =?utf-8?B?eVVjdS9NSWhtS2NHV0dzaXgxbTNsSmVsQTlUcGREdmJCR25Fd29IMk1pbjU1?=
 =?utf-8?B?ZTgwRnFGVHB2dXlaaXZjMmZ1UE1xZHdoWno3dFdyeTh4THExbCttRTRDanI2?=
 =?utf-8?B?SnBuY2JWS3lnVmc1azY3L0NpclFjaHQyeng4aEE2eThvN1BycHpubk5BSnh1?=
 =?utf-8?B?UlFobmhNa1lXdHdHL3F5cHA0ZEcxdDVEeTdEb0VERGgyWUFPYUpDc3BGNnEz?=
 =?utf-8?B?ZGNuY0R5N2hlMEpwM2VxV2U3d29wL04rSnFVTG1tSjRkSkQ0c0lOZjNHbHFo?=
 =?utf-8?B?dFBmRTVpU0NqVXdOOGp1US9SZGpYdDJSb0xHc2V4eWZFYjVGOHhiak10eGdD?=
 =?utf-8?B?YUFtelpKYjJaWWgvQ2UzUnk0MkdlR3V1TWxwekEwaWVoRzE0YzB1OVgrT1FH?=
 =?utf-8?B?T0dnZ1QyZ0VzdklYaEhlZ1pvR1RCZUdYK1ZLbThMZ00zVXlzSTlIcVlHZm0y?=
 =?utf-8?B?bzk0aFA4UnBlN2tJNkF4ZG1iY0V2aDRoQmxTKzN5YnQ0QTAydi9QOVRVTDg2?=
 =?utf-8?B?S01LWVZxWGMxb2xDRXczTGkwL0JLbkVrWjdJMHNZUXZpYUxIb3VCcjZkdTF1?=
 =?utf-8?Q?QsTeXEbcBXn5MdhEijk4tse88HGMyULYV7Aq9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e59fca3-1158-40d3-e768-08dec2f2fd70
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 11:10:02.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ8jp/V4Hv57GlAa5CaCDqMB7UM+vvjBTiTzR+u9w7XDHPx+kp7ICHj4725Dj/u75D1X3rlVGxsOfePPdrPOEQYA4oOszdockQly6kC71NAM5BTEQLb+17nJ6CGuQKmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12689

This patchset is a continuous of v2, it mainly resolves some concerns
reported by sashiko-bot.

Patch #1 fix Type-C switch resource leak if probe() fails.
Patch #3 add runtime PM support to avoid register access issue if the
      USB controller enters into runtime suspended state, in this state
      accessing USB PHY register may lack some resources. This will also
      avoid regulator leak if power_on() fails.
Patch #4 add debug control register regmap
Patch #5 correct i.MX8MP USB runtime wakeup issue after introduce runtime
      PM support.

---
Changes in v4:
- add Rb tag
- replace guard() with PM_RUNTIME_ACQUIRE()
- Link to v3: https://patch.msgid.link/20260603-imx8mp-usb-phy-improvement-v3-0-7afb8f89abc6@nxp.com

Link to v2:
 - https://lore.kernel.org/linux-phy/20260512101046.1498096-1-xu.yang_2@nxp.com/
 - https://lore.kernel.org/linux-phy/20260512101212.1498223-1-xu.yang_2@nxp.com/

---
Felix Gu (1):
      phy: fsl-imx8mq-usb: fix typec switch leak on probe error path

Xu Yang (4):
      phy: fsl-imx8mq-usb: set usb phy to be wakeup capable
      phy: fsl-imx8mq-usb: add runtime PM support
      phy: fsl-imx8mq-usb: add control register regmap
      phy: fsl-imx8mq-usb: keep PHY power domain runtime always-on for i.MX8MP

 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 127 ++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 37 deletions(-)
---
base-commit: 08484c504b55a98bd100527fbe10a3caf55ff3ff
change-id: 20260602-imx8mp-usb-phy-improvement-4272d308d862

Best regards,
--  
Xu Yang <xu.yang_2@nxp.com>

