Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09593CF212;
	Wed, 15 Jul 2026 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115038; cv=fail; b=Nzg9Iu2sRlBrgtZF9rrC0qg3PRU7vQJ8mIKMeOmXgtCx0SlcZRH0OP3zPFcTUB4FtQzGTkRuETOUDoZnwZVcnaXIE21bQ0feg+flOyCP61sBfgffAnJogtz+atAs77kBLxxzb12mWVF5x0xca0aKjckEpYl6CffCT+UH0xcbk/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115038; c=relaxed/simple;
	bh=Er/3rOp/KX0QAh3cj3hkw2OC5kJ7Mn8MJ+ULbJXSuOI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mrCCoKITKyl6zm/Q9pbaqTBfi5lLvCeLIKqQdaHovIyoGDop1ds1mz5mreqmC1NBpz0ZsE3ef+sKVky1H/2g7WSe1/48ntmvJ4FlNIznn9QCCshQ087FIV3hudkBQJe+dAipWtZYy1fq6x1tAt+6BkCMUqYdU1xjoSw97rrgWSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=prqoXVRu; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="prqoXVRu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA7O380AsmSgOFrufIIAAS9z6kLx1/dQmSJjj9UD+c1bklOqSsmqjFAmzJga2axM22CO4xlon3xJmYQlKPBkSxuLJsKgLyOh+In8L4voXZcKad8YDWheqBsBBdAgpeihMLs46hRaEGmL0+bFCIm/NQ8c8U8XdHmBv4SiQgriBje2wMEgJcAZNCeCxES6Xlb7uUFTBAYj09AqSzXmMeknF6ZGNfIBgvYROk3R18E87UpfCIj6fb8l/6loIUxG4/ungRQPMIhroOMR8OI58+bSIGSzeNXDY7tQwI8iU+FQYWlJk7Q31Ws/Wtz1UBleyZlorU9B4Ckf3oOYZlGepwrP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWM0/dKUX8zCGUjE9cqph3ca1OTcroilnW34TnRkPu0=;
 b=APv3kXIO43IlmDj3pCShDG1dj92YRzSSfXQRJb+Va+KCVueGVLxTFqOqExlk/qify2F9EQ3AQtuY7NiCxiiDKJ12REBKXzrl1hmspIj8zvqQ102M5qi4t2KZwTql9FjdDMDVHixfgqJ1Atd3zVxZaQGi+DM8QvN6e0Q/vWNsLChPOZfHftzyO6C3PaF19Fp1sAjYQqT1HrEsdDYBCyco75pykeY+UkLFYuSe6pnZMiXYFE0SkVgnvLhQjGDyIKALECqJR4HwL6ZDZKGUZ4rdJdIskfYACvgDcoH7vzVtjBM5ohDwyiozpcmugV8ieiHRlsJTaqhy+yazGX3v4eDM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWM0/dKUX8zCGUjE9cqph3ca1OTcroilnW34TnRkPu0=;
 b=prqoXVRu6xE8kmTmfJH6iJn6h5kSe2SYYYdQH9vnlp1YsYjaMUd4tPtyP1N/5xJYrm69dhjagFFaX7iUwJ99xnnpkQkbnUqfr1atVPdmbTYi858ga8/eLQVw+hkY06uetzQIMN6BgLbAVa+Mih5bhez8HUND5/p4atnt4OTla0T+Ht76LSEKkLJoDwq7oh8sTXZtBVupe77bmUrjix+4UBp3TK6+jiQG6T6DKq3esaPmK2Uxa6mMfPL/EUGndWgYY90DN4z0QnMQM+bfQ1eBf9H+GLtlTXnTisXsfIIoW2yct1i4eVQbdFWwsWUoQfwDJ8xqt70xCMSV50ny72O2rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB9134.eurprd04.prod.outlook.com (2603:10a6:150:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 11:30:32 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 11:30:32 +0000
From: Xu Yang <xu.yang_2@oss.nxp.com>
Date: Wed, 15 Jul 2026 19:33:56 +0800
Subject: [PATCH v6 1/6] phy: fsl-imx8mq-usb: fix typec switch leak on probe
 error path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-imx8mp-usb-phy-improvement-v6-1-00d95e270e4c@nxp.com>
References: <20260715-imx8mp-usb-phy-improvement-v6-0-00d95e270e4c@nxp.com>
In-Reply-To: <20260715-imx8mp-usb-phy-improvement-v6-0-00d95e270e4c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115243; l=2860;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=KBrW5DQA37AQDiStxXTe/j8vzfNIUfWgsF52yv7R4yc=;
 b=VMfUrL78UE4BTnpsatN7PZHurk/xEvOKX5YChWAFW/nfLfjk22ROSlzsew2l6zEwPRZnHtIaa
 FnVwgZ0I7FrDjyKcUzauvYp6NOOrKqmp569lqCwDpAN39UlhPqvnr/a
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 06649c12-0427-41c4-130e-08dee2647afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|19092799006|366016|1800799024|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HDsgSi6sIQb0JF28Xtqi2ReW7SWFJBZzNkVMDlDCXXCQJ4h+sOtHe3GH/KjEMQ5mCxzdVEZ8Ot5+2vSy+81a6EEpgksAX4jrBu53OOCClc9FYIqRv0ZHV6SalYACFHp/L1KWQefU4HXo/SExgUdr00XAzecxqqUS6lOaXwP7OcGnKkSpaECiRXEXXHp5yPkB2GFTbOYRx/datGgl4fl+/JpPgDuGxeBVtD0NmJbs3eTsBSnIZePigToGIwALELRwaTf4FC4El85OhCf5/sr3BUCRePjxTAWKgRN829/OzwjDZ6ot5e2VKnri4gvR2S2EQuBWTP167ug9ucPqOtsA4ieTt+nKMdnN0tGRywpJTg/EXk4/JdqL56Hh87zl9QWAny+AVhILJPCqoNiE7ILjBze31ZA1Wd00K/K2JbDromMYYy29X2YG4BXk5NI6lvTnTMtWglS3UQbezsGwRoaONIvkCPH6EQ9ntaiCpknIZPpSzJ9BPGLaIeKoChYEB5lyPQUooNuBOB8M2ZfiUTrZmJlp/RFNpRh54CrfZY3cHo8GISGjF9HhE5QRzhXSWgG9PusiqSsQGM5ac0SgxaJ3vsenXtHIu0TSmS5jqeSk8sxSotdYhEoSZN1/IKJ0XQiKUV/bDGUhQ+cwLX8OSO4xyjEmLykzRjXJo7wEZdVxWVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(19092799006)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFlscHRGT1prN054WmVUamJyQm5Wck9abVhXVnVKNmxJVnVMSnRCTlVHMjRS?=
 =?utf-8?B?NHI2Y3dnMmg1OFF4aCtYVGZuWGdJZy9QMk9kdFd0OXdMVDB1WTVjcThaSlRl?=
 =?utf-8?B?WFJ1NHlnWTUvVTRrZlFMbHhqU2RtT0R2blMwbjF3UmVxOXRTU2JZeHczZ1FN?=
 =?utf-8?B?OWlhVGJIRUVkMG1OTzd6L1ZlZzM4Z1M2cGxJM2NxYStzeUErcU4rdytUT20w?=
 =?utf-8?B?QldhdENrMFZyYkRLWkJicWlZbzRjOGxRcFk1cEhWK0Z2QjRRbi82ZWNHeGxY?=
 =?utf-8?B?dWE1ZG16a0hIUEtJRlhwcXRqSzJycTFpendWbSs3NWZkQUhpNHlOU3Vjbk5R?=
 =?utf-8?B?M2VBWVhrdmx3cU52RUw4anV2ZUtvZUVzZ3NwNUFkaUxWNmxLMzIvV0p3cERM?=
 =?utf-8?B?RzM5YkgyS0tacDVpVUlrQ3k1TWhnZDdlanRORWw3ZFczTVQvMlNDMnpmNExm?=
 =?utf-8?B?RG1HbVhjRVlkY090OFQ2Y2pYbkdPQXR6NGp6Y0JscTdYTFR2bFl1MUdZTE1n?=
 =?utf-8?B?SnpzNFdMbmtPS0xuRWhZTmg2K0tXdDNLd0UrRzV3ajJ3MkFybWdMcU5PYmQ2?=
 =?utf-8?B?bXdDdHdQTXF6TlhhNHdud3JlbU5XbTNEU0IvU3huckNjbzNlUTY2d3dyaWZI?=
 =?utf-8?B?SWMwaU50amVDb1NuZEpqWS9uRnBVMSs2L0lSZm5GWnYxSndObG84cWkyeFJq?=
 =?utf-8?B?N1kxVlBhMjlESWx0UlIxUzFXWUx0RDRobzFkc1hnVHZFQmw3WHVIUEJjVjR4?=
 =?utf-8?B?R01hSzVnL0tyblpGWjh4aVU5UWpHZ1YwNDkwMG1iYndpeklvdk14USs1U2hq?=
 =?utf-8?B?cEYyQnR4RmNOb2RybEZwU05kMVlNb3UvQ3ZWWUhEdkFIWWtkSGtmWWhwTktE?=
 =?utf-8?B?azVneVh5WnVyTzAxek5HeHY0eTkvTUpEN1h6Szh5Uzc0WStTaWtlc0ZvdWNZ?=
 =?utf-8?B?RlZ4dFh3SWZmd0tSWWs3bW4yR1FMaXE0SGxrRGMyYmlINFVrQkVWcHpkTEEz?=
 =?utf-8?B?UkhFemNuN1FqT1FGY01ZekludXFxWFc3WUNuQU1CSHNiZHdHVzlGRVRXUnJM?=
 =?utf-8?B?YmU4WSt6TUVKT1hRQW9uVEtseWMxbExsRVJiNUtjNjdLRm5vTHJsRnAwNi9l?=
 =?utf-8?B?N21xMnVxRDMwaEp2TWQvNkJJTUFvT09PUnNvazJZTDNiR3RQUFZaeG03Q21D?=
 =?utf-8?B?VTQ0cHVJTFVycmNQNlBrZElhQ0J4RnV6ektzaUs3dld5UVljVUFndEQ3dDRs?=
 =?utf-8?B?dzdDcGFzQ2dTeW0ycU1zdFdWRVpnUENBUjJFVkpNUys3SnpFQi8rK1d6Skwx?=
 =?utf-8?B?cXZZWU5JcmVZOWZjMGVUTk4zQWJDZERJWktnOUhBaDFCSVZKeHMrbFU4YTN6?=
 =?utf-8?B?WDZNWmIxZWN0dS8xemcwUUMzcG8wZm1tc2dkTTlXaWR0Smo5M2drSWszUnI0?=
 =?utf-8?B?WEpNZE96c2F1bjdJTTcvM2MzWDY0Zlc5QW9wMVdJRzFmSTR6YW14MUtjVUEz?=
 =?utf-8?B?QkxJbHBGVlEzcG5NbHd1SngrejlCSjFMTE5lUk1taUcvZ1Mza21PcGpNdStk?=
 =?utf-8?B?b3p4RzloN09DN0dRUkR6Z09rVEQvU24wRmtkakVyazBocm9CdFBKZ1ZuQU1Q?=
 =?utf-8?B?d2I2Nlh3dkZNNWRhR2RRbHRRdHhaRmpabGt2ZVdmUE1wa09LWGJQVUF2K3VF?=
 =?utf-8?B?SStleUpSV0kzVDVSK0JvYXpudm43Z3VkVDBlS0NoRHI5aGppV1BtTy93dVR6?=
 =?utf-8?B?NTAyZmphREVjdWpTRGNGZ2krcEFKWVlvRGZBZ1I4TitKWmFuSkJQeTZ2Z0hk?=
 =?utf-8?B?T0M2eE5wU3FjT1BPaVQ2aXRXMTBXSTZEem5COXdZZWxJRjRVSkw3Z241VmRm?=
 =?utf-8?B?YmxsK2N3WXp1Q3hpcXdhUlNMR2JRMHNSTXpOQWVxZGtsSFNsWTBWTjRVVTZw?=
 =?utf-8?B?UTZpekdPbnhLNVRJUWdXa1ArVkhLZjZjeHZqTjQwNjFHSTFZa1lvNmJzd0R5?=
 =?utf-8?B?SWJ4RFd6NUJobGdhN2lSUkxoSHkwNmlzL3ppQTVlNW9KZ1B2amt5aEE3T1N3?=
 =?utf-8?B?ckxEdG9GckJiOFpFdXhoMFJKUU5qQnVDTFdJbGR6MzFQV0tlRHE5bFBXM05I?=
 =?utf-8?B?Z1VLcmhHeUFSanluY3pmdWJUUjVoNHpyemJYU3o3N2RObU90RW1SWDVUQ25l?=
 =?utf-8?B?L01TSm5PcTl0am4xM3l6VG9FeEpjYitBYzdpS2U4aXV6T0FQMnJHV2dkMTlS?=
 =?utf-8?B?dHV1eEJRTy9wMGs4am1wQlE5R1hyV0RZdWJQYlBCQ0dNaUVaSDdnd0dCdFNn?=
 =?utf-8?B?eHU0djE2ZHp1RldEV0dZdXdwZWhRV0lRN3ZnV1RzbHJ3TWhBQzVOMmM2c0tM?=
 =?utf-8?Q?FpJcY8BrBFW54DqNSqqItByLePaVJ5Y6d1q9W?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06649c12-0427-41c4-130e-08dee2647afd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:30:32.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvslutCf7xSQJ6GnRk9or0u+O18Z82qvRCeX2Q+br1OS+DWIB82g4GF3AA8qE4X7+9qQCcywLeu1R/iumNBhLBzxB4klkZEIYm8WrXEEvxBLe1UdMg7lE8+sR+SU5nOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9134

From: Felix Gu <ustc.gu@gmail.com>

If probe fails after imx95_usb_phy_get_tca() succeeds, the typec
switch leaks because the only cleanup path was in .remove(), which
never runs on probe failure.

Use devm_add_action_or_reset() so the switch is cleaned up on both
probe failure and driver removal. The imx95_usb_phy_put_tca() is no
longer needed, it will be removed in .remove() too.

Fixes: b58f0f86fd61 ("phy: fsl-imx8mq-usb: add tca function driver for imx95")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - delete .remove() is deleted words in commit message
Changes in v5:
 - keep remove() callback as patch #3 needs it
Changes in v4:
 - add my signed-off tag
Changes in v3:
 - add R-b tag
 - cc statble
 - drop "sw = data" conversion
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index b05d80e849a1..9a33c06d6fc3 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -173,9 +173,9 @@ static struct typec_switch_dev *tca_blk_get_typec_switch(struct platform_device
 	return sw;
 }
 
-static void tca_blk_put_typec_switch(struct typec_switch_dev *sw)
+static void tca_blk_put_typec_switch(void *data)
 {
-	typec_switch_unregister(sw);
+	typec_switch_unregister(data);
 }
 
 static void tca_blk_orientation_set(struct tca_blk *tca,
@@ -248,6 +248,7 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct tca_blk *tca;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res)
@@ -266,17 +267,11 @@ static struct tca_blk *imx95_usb_phy_get_tca(struct platform_device *pdev,
 	tca->orientation = TYPEC_ORIENTATION_NORMAL;
 	tca->sw = tca_blk_get_typec_switch(pdev, imx_phy);
 
-	return tca;
-}
-
-static void imx95_usb_phy_put_tca(struct imx8mq_usb_phy *imx_phy)
-{
-	struct tca_blk *tca = imx_phy->tca;
-
-	if (!tca)
-		return;
+	ret = devm_add_action_or_reset(&pdev->dev, tca_blk_put_typec_switch, tca->sw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	tca_blk_put_typec_switch(tca->sw);
+	return tca;
 }
 
 static u32 phy_tx_vref_tune_from_property(u32 percent)
@@ -741,9 +736,7 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 
 static void imx8mq_usb_phy_remove(struct platform_device *pdev)
 {
-	struct imx8mq_usb_phy *imx_phy = platform_get_drvdata(pdev);
 
-	imx95_usb_phy_put_tca(imx_phy);
 }
 
 static struct platform_driver imx8mq_usb_phy_driver = {

-- 
2.34.1

