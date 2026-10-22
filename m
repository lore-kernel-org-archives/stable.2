Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792638824;
	b=SaxbpdutEsA+ThYgvJ+h6ofnwMEAM07RpVhUKdsXhbgQFGH3wll71nc6PVq5cPg8N+WF
	 ORZHhxnwr+qHx1sb5C4Tmh9yDoVUT2ap/U6YPaMg/nfzKjKsEFdiC4GBW6MTdT+T6MV6O
	 8tQBeobpNzjNfjqnXULZVHHF/gqLfU6nnG5/6wnbj9/vZM6KR02m9KNCLhJ/SG5zBJYNi
	 TQv0YDHDGnPFmqLEg0Fr9r/u3YfdKLnftfnFLar/Q2GpUBjms5UdKVIpzQr4FblkkzH6Z
	 BZrZLFmmEsTg3fVy1l+WqCGyJo96pKWdchBR3QGuB9vZflmMySQb8j6Bo2cKLdp28iA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638824;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=fgeeDie/T13jq6WBTcTnvu8NmLZA1I4Q4/EKFO1PhgM=;
	b=Thu9NnbxBNdxEb+3lrEy7hv4oRH1y3iC4fv5e1nvTTM5PlIWucrzjKdGlwzqeV++BTYL
	 ZMOSdb7TWglUuEkaw97NubWSJ0hZ8ThanJF4+/Zng3nsv0mCsPwOvNx0WVet6fAILMBYx
	 BhK8/ew9ru5GuZiQhUvK3ldzg4G3FsmAMYyMZuowK0iMuYEmY3vG/pIptVq6KnnI5+9bj
	 I51U00NvKAwllWnnIf1gySjiKSvCEqvPnkPwQXmTtthlwn1wB5TPE2W9rglTZ+iFZua+Z
	 YrFhy3WHlWFPPTNSvrCGsdhMKtbKJb5kjBSPmyjFJ9CdeN0F/SKbiwQYVg/5fpeV+dA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LTruYLXZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.62
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BF606A330;
	Thu, 22 Oct 2026 03:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 132BF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LTruYLXZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d07dGIcJOSAgD7MgtWOF8fTUjbHllXBDpjmvCar6PvUYbsAfIPAD49fvA+Zlvi72kGTqX29276IY8vNXt65hXxQODhZguofwO5jPaI620krVwqR4ScQYGT0z/aEd4IBIeRs5dO0srJEFVnt7X5XKtj0oq2Ly6/0ZurqWTa/dxsjU4E81MC72cbkXgYVsyjC2FvLZDRbP7ORELug1kxq/rQ2Vh3cgYfVrPCNZTcUmOwgLt83FRx/4FUg4gve3UlqZaXXmXPeri2Me4/9wMSDaau8sEuzHmQdrLXeTG+HpH5235usp5yR7ASU4xCFr9N6AFzlGwftye8dSZFgqPW6cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgeeDie/T13jq6WBTcTnvu8NmLZA1I4Q4/EKFO1PhgM=;
 b=Qkgg52T58mCJ9GQN0gAzi0uFs3JuK5p2hNu3C1/rG8N43Q0D0pqTMR5G+yJ99alvBb7b+aIZIm6OUEQMN+zzDcIio8LE97iTRA77xy5nLYaD+fv0BaBa3WtC6Hks9rnifEQtlY+ASgUJqMpaZF36nMFUWtdw9XWJLpUAdeGKBWgk6hWwB/ZIBTK3zGDw981zMejen9NElfkZW+6qNdM7Y7Or7iORYi75ik+pd0PfWnUcwTrHxSRvoVO65AKfLY8S+GS8Fp1s8441IwTtBOMe1x+YKjvfR4q1S3ySu6pognWQjmCGevvA6BIsbvC5WwW4XjX3L/y6dfFampjWQW18eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgeeDie/T13jq6WBTcTnvu8NmLZA1I4Q4/EKFO1PhgM=;
 b=LTruYLXZ5RKTk/rmbS4FT7IcR5jTNM8D86Zyr/tapsM04y2PRdvBY4G7QktYoWxjxx5qXBTJs7jMuuwX5FVFtoCnd4dj6drazv+Rwa1/S7pcvZWcUx0t6RI705MfR2GBVh05HFc8GvEGK/06y2uN88lVcb3STK0NpA0UQqjrtTH3534OrOkYnJubmfZXRxIWWC2gKyN14lQ110pqLFKjY08tE6aUKrIIS/iILgxAXOM3XtW72e5UwgbfO24OhvMYg4227Y2CAxZkMkpV9/IDQSSxRfaHUbyOHVS/QtYUmb/swbDDF3Q9Ag5n+fy4Tzymfbr40B+Dyu+GTaIUsY/T5w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by GV2PR04MB11639.eurprd04.prod.outlook.com (2603:10a6:150:2a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 03:13:39 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:13:38 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Thu, 22 Oct 2026 11:15:54 +0800
Subject: [PATCH 1/2] tty: serial: lpuart: deassert RTS while reconfiguring
 in set_termios()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-b4-lpuart_rts_fix-v1-1-207f91580dee@nxp.com>
References: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
In-Reply-To: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jingchang Lu <jingchang.lu@freescale.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792638983; l=2583;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=yUA+FOZ1r0LX5+Q9DDqgqVKiYQLsiaJ/nCTP4Sns7NY=;
 b=3th2T3m5jVSXNt6KSHHUP9CEjdchc16OdnQVvDlT2XjkD6MLhh7hiUh4BAgRgdjBy7wigKHAy
 O0pefeY+5T0AfeF82GItarlBkMX/kdSTpWfztiTtwGBGsx2uTJKuKHW
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SG2P153CA0044.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::13)
 To VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|GV2PR04MB11639:EE_
X-MS-Office365-Filtering-Correlation-Id: eb23d157-ae32-4cce-22b1-08df2fea776a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|19092799006|366016|261021123027099003|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|6133799003|22082099003|261021121427099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gJnfrUehXwrK036Cr/I+e61PXV3ikUDNisY9rzH1P+SBT3qy/3EmcKuUoUBxFRVeormJ0yhCbSQssCa9IOIIfQz2NlDBVDOHebucpYMh4i8oRMpx6duk6ly1f1OOvVXmtnAO5wAkml6a3uT/AzkghswnEuSVBDq72zHjXFdhI3ookWlweQDc1nmMZ1HftfSHTq2JNHDfcpe6v+Vw4ZxqY0ZkCG8e7NpEBlhKQhxnOoPLfHY6OYO8LjdBsaAT9vWzFwIWUEXWoyfqmeDbQtZT/jMQkMY/usFM821XPlvSpo7NmKmKZOQbb6NhSt8lyfHz2PGGR261kn/IJFB/dOtcRJTwgVRYEPWlLMEUvSbWIIDnMh+qtWv4GTRdgraI0k8Dr4UUFCuwlu2h37FQcoH0MGE/5lPXObUBQOXypvoLzdsiSQVrmve/KGwlbdH19UtrsS1RBdkIswqqvLWzYlE3mM9Po+Z2aflzLJ07Vh5T4sTlz8XIvC++n2BsgDELi3804WyldMq4twrdzQ0DePNMSnxf30OPvmfFlqBirUdmTtyUywK0lylpqFCt2z40zSaUIbBGCdvops8hpC+YnAUubfI53F5JOFQxlnOFFf/P66qH7ouCm/QSzBsjGl+PCgITN+hLnHgaIJnf7yLpTpFbtt0YgvcCcueCv5W6SKaSpTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(19092799006)(366016)(261021123027099003)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(261021121427099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnNpelVSbVpiZlA5b21QN25MV2RHNGVkMDZwUUtMaXRINzZYRlE4T3UvRmN2?=
 =?utf-8?B?ZEt1NkZEZUtsOHNubVloRS9QMTBGMmdkMzZWbVYxUWdXbkgvYWMzenJUSU1P?=
 =?utf-8?B?R09wcnU2SURkUnl0T281Q1o0NDVPRG51UXpWeWE5cXpwdjl5QjZ0MktoeUJv?=
 =?utf-8?B?MElSbXdpbU5OYlU3UGxTYndwQUk3TC93QitDREtGR1hqR0dza05nTnJoRHhR?=
 =?utf-8?B?dy82SkdWYnE1ak9yaStjWUhHbzBlTGxIWnRudkExZVFtYTNKZGlLSHdLbHJT?=
 =?utf-8?B?em1FUUIyN01WekJhMlNudGpGOGNQTGV6bXJQZmIzZzRsRDhBN1A1VWZVMGJy?=
 =?utf-8?B?ZWYvV09DeFdnL0RPVmswYk03MjZkbTVKaFRmRE9VbTIrbG5HS2IxcmdsTWds?=
 =?utf-8?B?TXRWVU43Z0QyUEU3cWVMYkp6b0lodG1lZ0lKTW5RZUpRZnlvVFFmT3BzUVlk?=
 =?utf-8?B?Wi9OVHNZOGpLOG05cXZQazNMZURaZXFMUDZNWWRVdk5ROWcyT1YvNVpzSTRX?=
 =?utf-8?B?T0U5Vlh0QjZ6NjU4d0VnNmRhS3J5SDRvalNUZStuYmJEV0pyQjVuWVNPMDJK?=
 =?utf-8?B?ZTlnbmJmNzMvcURHRU4ybDR4SERWcWhkZTU0NXpYWjFLbzJpNkl3SExuTkZU?=
 =?utf-8?B?SWxLZ3g4bmdjNFNWYkV3NGVReld3bW1DOGdIS3lDQVFpd3R0NS95bmFvZnhL?=
 =?utf-8?B?eWpVUTZIMk02WTBGejN3NTYzRDNDczRlS3drNjFSbGczeDNwUVBsRlVnVnpI?=
 =?utf-8?B?L2xPTUozNWFiWHNMMmhWZUlOOE9WeGlEUnZpOHBpMGN3dStNa2xCeGlxeHpZ?=
 =?utf-8?B?YzB1bGdJMk9yQng5NFJIci9RV0NRRlJwbjVrdHhUMnJ4eW82Q3NrT0Z3cXZz?=
 =?utf-8?B?TVpmZWpkbWhESzZMWjMvUGNjdEZsaWFFS29EYTFLdldEd0hJNlVUWjRZc2hK?=
 =?utf-8?B?NHJUTG50YU52L04rd3BxZk91T2tPSGJKWkNId1JiL20zMWxTNERBL1ZsSTRE?=
 =?utf-8?B?TUxZOWxkUDhmaHpZSWtOZHBFekVZVStQZkduRDJ5dzJyNm5VRzdwYXRiYXdV?=
 =?utf-8?B?aE94Y3MxcEE4RC9yaDVlU2VhTDFBUFhDVzhmTDd5TUJ3YjR1TXRJWUJhckVW?=
 =?utf-8?B?ZWY2dVAxaFFsUXMvNFVnbWVsdzRDRElWc0VIdFM5U1ZIaVhybEM2OGMwNmpj?=
 =?utf-8?B?L1dxQUNsUG9UWVRwS3NaNnhWM1Jab3A3UWkvOE54TC85L3BkVnBmc2YvZkl5?=
 =?utf-8?B?SXh3bjBGQ2REQVkvT2xBQURaQ3ZpTHhhSFdYUjl0M3BlMThKWGlTNVptN2wy?=
 =?utf-8?B?M0pvZDhwa2lTY2phMU5Td1BRTHp4M0toMVhXQWp6dXdneVc2elB4eVd5RzR5?=
 =?utf-8?B?NFF3SlJ3TVJuWFIrc0FkdFNjTHZkdEVlM2JsSk9jK3VGc3NWc1JTbFZIZy9x?=
 =?utf-8?B?QkQzaUh2TXNXVHhQSENkSlBhVjFGMVRnVzNPN2NPREVKaTVHK0lVVlBmVGFv?=
 =?utf-8?B?SmpCdkNSeEJFZk9ZT3gvMzZucjNQVi9LSWQ5MWMyR25FMUl6ZEMxWEIyNFJ0?=
 =?utf-8?B?WXF5bWRJNGs3VTdYOTl5ZEdGQlNkQzlqWnYzYnNxM1N3YUlUZDM1eEMxWG02?=
 =?utf-8?B?d1g1TE1tM0I5eGR2YWFjWDR0cVNQcmRadW94Z2VPODdpQ0p0Z1VRRURueU1u?=
 =?utf-8?B?RVlBWlFuenFpcVV2VUJabTVpcTIrcS9TcG4vM211cDhRSnpMZXBSd0Y5WFFT?=
 =?utf-8?B?c1BWbmZRZ0hFMkw5dTZBRHRXOGhJQW9RKy9JT2RRTGUvN0lQbHBBM0c0dXQv?=
 =?utf-8?B?K3lDRjZMMXlqRXAwSVd0N25JK01FZmI2bTJwVUttZWhJa2Y4WlJCRHViM3c4?=
 =?utf-8?B?cHBhV3hzcm1xWXlGMlU5TXlPdFZYVVdRVVRKc044NndHVDFYbllmeUdtSHZp?=
 =?utf-8?B?M3NxQm9rMWdXd292U0h0RFo2alkzcjcxWWpodHl0VlQ4Znh5V0ZFTjhHZlJh?=
 =?utf-8?B?aWlzQzN6MlA0VUpzU2lHckpqRzkzekRKeTRvVjNvVTExckdiQlhuTjBmenl4?=
 =?utf-8?B?RjI5eFByaVB2N3RNRVRnRFVDT3FiQ2VhMCtxVmtuWWM3Rm9rTDRBRGp2U3NF?=
 =?utf-8?B?aHlXams0eTFHZExtKzZ1eVZZS2Q5UnIveStFbE56cmk0bkNCUktiWWd3NGdY?=
 =?utf-8?B?Mll0TFdpVzd0QXU4ejhSQVFVRTNpaXkrSEM3bzJ2alBSNXhlZE43WExpRjhJ?=
 =?utf-8?B?clRYdTlBQWgwcFI4VCtUSWw3SDg0VWZKbGZEL1VISnBZa1V4eDVOSTBBQmFC?=
 =?utf-8?B?eG83RFNFZ1VFTXloZEU3QkR5SU9kalQvREh1b1cxNDdGQjQyS3NsYS9iaWxp?=
 =?utf-8?Q?QcNYeexPRCRdtPcjwQSdaIOYxBkRB0h8nSuam?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb23d157-ae32-4cce-22b1-08df2fea776a
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:13:38.4955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFLrLNIJtXx04qPoS2Qx3cidcJYSzr5qCPXVssN8a1VmpK28mMn2nkRhjzKj2tuyn45sy5sPM9UV5m8xIqfjOe8SyjEcV+Ezcmr0j2RdvYqwpRs8azAfU2lzgWrsaL0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11639

From: Sherry Sun <sherry.sun@nxp.com>

Commit e98ab45ec518 ("tty: serial: lpuart: only disable CTS instead of
overwriting the whole UARTMODIR register") replaced the write of 0 to
UARTMODIR before waiting for the transmission complete flag with a
write that only masks TXCTSE. As a side effect RXRTSE is no longer
cleared there, and when CRTSCTS is requested that write even sets it
while the receiver is still enabled.

RTS therefore keeps following the receiver FIFO level during the whole
reconfiguration, so the remote side may keep sending, or start sending,
right before set_termios() disables the receiver and reprograms the
baud rate. The characters in flight are then lost or corrupted, and a
short RTS pulse can be observed on the line.

Mask RXRTSE in that first write as well, so that RTS is deasserted and
the remote side is asked to stop sending before the receiver is
disabled. The final write of the modem value restores both RXRTSE and
TXCTSE as requested by termios, and the other UARTMODIR fields are still
preserved.

Fixes: e98ab45ec518 ("tty: serial: lpuart: only disable CTS instead of overwriting the whole UARTMODIR register")
Cc: stable@vger.kernel.org
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c8575c965203..70b69870aaba 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2360,9 +2360,12 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/*
 	 * disable CTS to ensure the transmit engine is not blocked by the flow
-	 * control when there is dirty data in TX FIFO
+	 * control when there is dirty data in TX FIFO, and deassert RTS to ask
+	 * the remote to stop sending before the receiver is disabled and the
+	 * baud rate is changed below
 	 */
-	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+	lpuart32_write(port, modem & ~(UARTMODIR_TXCTSE | UARTMODIR_RXRTSE),
+		       UARTMODIR);
 
 	/*
 	 * LPUART Transmission Complete Flag may never be set while queuing a break
@@ -2380,7 +2383,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	lpuart32_serial_setbrg(sport, baud);
 	/* restore control register */
 	lpuart32_write(port, ctrl, UARTCTRL);
-	/* re-enable the CTS if needed */
+	/* re-enable the CTS/RTS if needed */
 	lpuart32_write(port, modem, UARTMODIR);
 
 	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)

-- 
2.50.1

