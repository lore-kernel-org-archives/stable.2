Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792739246;
	b=eL8CDvNNNxUdqHuCTWrV8miZ4BhBedgTyejABoHhTcbBgAhWfddtEuDehPu+2vjW1nXU
	 54U7siqVFBMk5vUESknfrsAMRiXgwzvEKHXZ9eNw4RbkSSdqc8HUhmj6ZDsskWG8C4f2Z
	 y852g64jpz5J8e+KoluUg1L9XDCvAr97qZMFJJaHdIQKoF6CPMFUXw1dZgt3yXWlA775r
	 3W24aPC4twldQsfabPa4+ktlaYXFC9S/X9XVhSV7GYpatgZDvJYTvsSDpD8l7JFrT/uRH
	 GsNP54Xyw1FmE+opq5r/fv2K2CjOStxPxxUUaMuu98lQw3n+fXVnGiOC0PTPusqrX3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739246;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	bh=tL8xTL1rsEvusWU+NkX50y7lNoQgmfN1AzMTmKmsrl0=;
	b=BJnNZgfDjxWNymX9VNinwXLaurLX/deNT3iumAhePtgRh10BkOn/km8jr0LkMlCsiizT
	 UreJYE8rT2A1M+WCYv4aCc2bwa7nvglKpEOaDP/nhwo7Uc/AhzxRDqlkBslc5XkTMdr7g
	 vneldY1EMG7LQWQqiGlPPloaEWErcYo2rt8w0jO8X1NeDY2fZmlFAS6GVGaiYNaNX+Lxk
	 /3rYNvd9VvRVvWGXAdyQadwd/9IW7to1imbBRFsdejz4hsF7yS9VOINEjEbVns37buou/
	 YpVnA8AKGZI55v0u3JZgJ6ev3J1YT79UD41aCERGIMIEIalDEHfgfaoHOvydTPkFOTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bMlJHjqa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.47
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10247606A31A;
	Fri, 23 Oct 2026 07:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10247606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bMlJHjqa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch+tn0CdQfBDDIo233zZ8mHB9+Mov42XzVYejC5vWNLOMZj7azhUgr5wNT0RJO9gIpYb/+9tadtvco9MXAxV1fQwxtKcmIi5FiCZoolnbEXFByszccYp+TEwDH9TETCrD5OX+36kjLNYG04zPjYh6n460NTjkbThkOZztQE9M6Zw+VEf2uEBTiR78hvKjfA6dL2HH7a493F2ZIL74So8ogB8xKgmamqdt45V/Bwc5VdDbvWZieMNFsEevQBfBMFE4bYirwHYFpN5mYYvftm5kJjeSZsZ8EQiPbIkhvWQ1Wfg29mWhLI3WkDzFc1EztdX2PDduJXRRjZZ3obLWBqy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tL8xTL1rsEvusWU+NkX50y7lNoQgmfN1AzMTmKmsrl0=;
 b=yxV9nFaqEwDA086Hy/haO+vwHboX3lwOU9tq9meqlcpxicdYyymmeGXeM276Y8b3g8BjLX293w261aFGIwJ3AfAcZ5xqbwq/E4HNH+Musgvv6JNg1kSiQWg9s7n9Ill8lgT1YUWznW/2GSVrgvIqZJeUYloqQshPSsTpEkBDL09D3cfSRtPLlTsNxyTEqbCQBOJzf0T0PEeeG34KMi8faSvfL9n2Sn7nO9Lx7VFXgdFBMljHyCAG+zWjm47B03GbQN4otNnorD3c4faaKDnbxnKuUamOraG2/vp/oRtgBrx8RVfFSc5gB0HovwbpecwQDHb7RWqf22pW1RJrrQpo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL8xTL1rsEvusWU+NkX50y7lNoQgmfN1AzMTmKmsrl0=;
 b=bMlJHjqajw9izxu2G5g6dprM0Ofu3j86Um3wjd9zBwxs1Imippts3+vkKcI07er16jnhuSXIKdMGu2nD1ggnszNwiOWr+SBQqlOrawve2xDBlgRslpk+ujPn/YYgNT0AFEdYppA/ZM2BQbQKAMCqnpGkKUgn30n0JdSinKUME5K2fvs6++LAEacgUUb8kG0RPWY+jgzKIuiZEzrYRCIMEyo67aaduo80HvokSrJ16bkrsA57reiDf7dtpVdknDb9du7ZPqLVTwUs4UMr6RF8/Ooptdo5mPTilfxbpey4cpYlJzozTDTTkgi3HmNELLpbAbqHZF/Eye2phAWdb9fT8Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by VI2PR04MB10091.eurprd04.prod.outlook.com
 (2603:10a6:800:22f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 07:07:22 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0546.016; Fri, 23 Oct 2026
 07:07:22 +0000
From: haibo.chen@oss.nxp.com
Date: Fri, 23 Oct 2026 15:11:54 +0800
Subject: [PATCH v5] mtd: spi-nor: clear the default read_sr2 opcode for
 Octal DTR flashes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>
X-B4-Tracking: v=1; b=H4sIALkI22oC/33MQQ6CMBCF4auYrq0pQ0vFlfcwLtoylS4E0poGQ
 7i7AwuVxLh8L/n+iSWMARM77SYWMYcU+o6G2u+Ya013Qx4a2gwEVKKGI09D4F0fuQ8jR6vRIoD
 RUjASQ0S619rlSrsN6dHH5xrPxfL+7uSCF9xhpayphfO2OXfjcHD9nS2VDN+y3kogqZWUxFCir
 rayfMtCAGxlSdJ6b4SwWjnQWyn/SEnSW1OiKxuwCj9ynucX2YnodlIBAAA=
X-Change-ID: 20260928-spi-nor-fix-eb7ebe22a740
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, michael@walle.cc, Haibo Chen <haibo.chen@nxp.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792739523; l=7268;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=8wpCsjz8f6Fv7dmKbaq0WGU9v+jDfolyvlIJKnIdZng=;
 b=DdCGIFdWMhBXn+cho9IkeqZXyN+WyNOyrxJSMJ/p/ddSf7tSM7JmWgGGtGnTuY1/gJnQRqix1
 5jCbDsw2rJBA6DQICFyGCdQXTJC9drXZLBfDeWSf1DKkvlpkHwChn9B
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
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
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: 575fe637-5a25-4333-1fcd-08df30d4486b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|11063799006|5023799004|56012099006|261009223027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DkTDll7Yyc3JKZZHXlldJ45E+s/u3FeU8I7tOYdJUFpdprIeak03uYRdtiCm+hQo0mu6ds7aIWWvj1ISs4dbqrdCIv0v6shsYLJXYpgczrqo2EBr6kXZ2D+LHL/o42nSY4bEIztJPT0aGiyC3IXW2cmmlkaDZobpMgX130i0JzxzLVRjWHl9lQnGXtNb0XYHdwwalbJ9kGYONzPwib4j86CjFCIEW9B7sNEMWbcnsBzykwWLEP+431GzCy0NSchsTcxCtk5niRPASshq2pSS6QqOO49q7EnsmQUC5ewxtWG9zunstF7zUgPgO8lfE1bIxXNWx6OzWYZj3KLFrpykRwL/ZaI2TubQOPIh3Khq6CDnQiFYmczhik7JrJbYg1EIgji++kWDNXHEx8eKjy0gzoTnVjq5dWxfeiZlY2a8ExADYtJINmw3EINufPFm/FAvhL7YdmIKkXjMvQ+5mLNI48dwt9VWjrlDtHyqnXyieAmdsTSOqud69+vymR9j2xV5AOTVjlzcxhhf3wauXto25Rw4zlNJALtcFxP9sqA/rUI2G4TKEexGi5DfJk0OAWEf9hMVCgqwgHmI2G8WRS38GDsv81vsQw2iWRbgfhhSxfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(11063799006)(5023799004)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjUwbzVEeW1JeU5kKzJPOVl3SFhQRmtMMFEycDlaN0lMWmZYYzZqL3ZRazk3?=
 =?utf-8?B?N1Z0WDdLcVlYSW5ZNGptWVB1TTM1MlZ5YnI1R3dYT28zTWVndjhiTUp0TE9r?=
 =?utf-8?B?bFBodTJjVHo4WFlJcXBLWW1DNmxOUDIrNUxzNjZ4MXFteXk4akFya0lDUUlL?=
 =?utf-8?B?SUw0UUFBNEk2cmZVY3pPb2ZuNUZWd1p1UFNJVUxuZE55UDVxMzVWaEtQKzR1?=
 =?utf-8?B?TzdXZXJmM2M3dTlJQndpUW9aL3JFTlFjdW1IRTRKeVludWNsdFR6Q1VWYzVX?=
 =?utf-8?B?dENWOTNCRUZLUFdwRXlWVjFrZXl1dFpBUm1iaDRvMTg1YnpuRWZrVVc2Mjl0?=
 =?utf-8?B?VVRXRnlSUFRkNWxYRlU0TkdydmltdW9CcU1IT0p6WStROFpDOENJMThGQmw0?=
 =?utf-8?B?bmNvNzdnUFprUytvNmdZbWRxWlZqTk9uQlRmV1FTZ254amY0Nm5ZRnFwQmNW?=
 =?utf-8?B?K2RISStGUndkZDRNSndHUHpRYVV0T0RDS0U3dGY0L3dtOFYzRVduVXlkWXda?=
 =?utf-8?B?YmZBY1JxTnJVbCtEZ2lYWmFmWGVvNDJ4dlREbGorU2g5c0FYT2Fxb09NZ1F4?=
 =?utf-8?B?aVFjL21MbUIzNHpKdWtONG55UkZlbXdQa0g4Q21CaWYyVklSOEt6NG83M2Q3?=
 =?utf-8?B?NEZyZkR3QTViWUEwY2x5SEdBMXJ3SmQ0clMvOFF6NGQvZ25HY2xubDdkVWtY?=
 =?utf-8?B?b0xwVEFEbFlEaWhZUDFHVHdReSs2RkhHUHpUZW14NnhyUDdBMmRrVDRBeXJX?=
 =?utf-8?B?WmFZR2VubVorYVh6ellzelR6dnkzVXZXMlBrcHFLV0VqNkxaUi9nNHI3UHhP?=
 =?utf-8?B?d0QvN1c4a2pGMUN0RnlJWFhUbktIQkZvT1l0Z3hyYWpzKzc0RnUxWXFwS0Vm?=
 =?utf-8?B?Q3BYYVR0dzJFRTJMRXArdHB0aERCQVBZTTFlaUV1Y0dkdmZpY1Z4YitpUXlP?=
 =?utf-8?B?UExtekJYM0tjTjRnNk1Rck8zbmtWNmZIbDlDemJOaDFaTDhsZ09OOEZ3WWo5?=
 =?utf-8?B?RVBnQ2JFTXJFelFmSWdpcDdGUzBKN1g5eFlWY1phQ2EzVndXRUJ5WnZEVjFE?=
 =?utf-8?B?emUxMnZVZUdwazNXcXAxbzlCYk9KTFFXdjdVQTJOTnpPR3Q5VTlSUWRtS1VF?=
 =?utf-8?B?RHd1Umhqakh3V2xXZnI3Z2lPb0NxZ3N3NmJNa2RBV0YydXJ6cWpJOW8xbXlo?=
 =?utf-8?B?Y2pIWUZraUZ6SjlDc1NkbHQvTUpTSVpVYWd3bERvYU90aWExK0Fjd2dLTmFv?=
 =?utf-8?B?ZlJrZXZGVkhNUFVkdnpTOVc0eC94dHp1TFMzWlhTZUNlcHA5L2Q2RXlUTENP?=
 =?utf-8?B?WTNSMjJBZGx0MmRocWpGTFM2OURSWThJbnRVVlMrM05rYjFHWXNOMFFidGNI?=
 =?utf-8?B?dGUzejVZdkowNkhjbGplcEZueDFyZEcxYmFuYi9wRkZoZUluc3ZDbmRPQzJN?=
 =?utf-8?B?K1NORUREZiswSXgxazg5WHMxaFBNbDV6SFd3U2VWdk1aUUdsOXdrREUxU3g2?=
 =?utf-8?B?N3ZacVM4TmV6WVp5ZVprRGZBaXpDQjZRVm5INGJNdGgyOEZ0UVlJeU1UZXZu?=
 =?utf-8?B?R0xTSi9vMmVhbjhIaW1MUlh3WC9HM2I1bjJuRkFRQ0pUMk8yMklsQURlQ1Ba?=
 =?utf-8?B?K0xJS1BVNXBnMEl3UGVnV3B0b244cXBJbVZMMGc2NkxRa04vbkltQ3ZoSTBo?=
 =?utf-8?B?enJOeTk0RHU1b2o3enlQTmsrZDRDTmEyWTQ0NTlsQ2tUU2VxZkdNZWF6MFF5?=
 =?utf-8?B?cDY2UVdINk1KYS9yK0NIVXJjbW9LN1IwTlNSL2duQkZtdkRIY2NFRjh1RHJz?=
 =?utf-8?B?RDVNRm5RN2xsTlJpUmY4ZklVQzlKQnFwVE4wK3FJS2ZMTWRJVnVOWmVzaVFD?=
 =?utf-8?B?M2lIL2lqT2xFc0xkTHVYUVNzejI1YXA5N3VNRzZLRXF1OHg4cXc5ZnFpNnll?=
 =?utf-8?B?MTRSWjBlbTBIT2RIZ09hTXhKUGlURURxUk9SZUJxc3UrS3V2L3lVZXdQYjM0?=
 =?utf-8?B?YS9oRUJEZzBtblNvQkxmSU91RlVGV3Btc1ZFaStIUFh2eExVZUNRU0FUZTVB?=
 =?utf-8?B?OU9hcVh1QkJNZVFELzJhUXVyVnQrNXpUOGNRSmJBSlBLVlBweHBTdXZRMlZR?=
 =?utf-8?B?WDJVYVJQdTdXZ3pmUzZDOUdWMVZmMkpnU0pSa2w4c0t3MzQ5RTRSVllRMTlJ?=
 =?utf-8?B?aGJvQVlYR003WDBSM2JIV3A1Ym1obTYzT2hTc1hLbThxNGovRGl1K3ZuUk5R?=
 =?utf-8?B?OFdEMlU5cHFrYWZRc2d6c2QrSW1KOU5zUGo3Ym1RTWFqS2YzUUZ6Zk9Hd01k?=
 =?utf-8?B?Y2M2Q3RwRXh2MllhMzd5eHR4STRnaFV0N253amdzVVlpYks2Sml5RFJRT1Z1?=
 =?utf-8?Q?rCLQRUKWXuoRTPuRCwy/dD5L0Jv62VFAElYPN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575fe637-5a25-4333-1fcd-08df30d4486b
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 07:07:22.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/pfPCE8bJ3xnWk+IPSpQfxr7H5utdyCbP6yZjn59qfcjyu9reeSrkIgIb5U3Vic6zVDslYEsnZ7OkSctK6RJJ55kyadVkZDoLU7eYF0ToYq2+mj/1NJPDnnztrU37fh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

From: Haibo Chen <haibo.chen@nxp.com>

The core defaults opcodes.read_sr2 to the legacy RDCR opcode (0x35), and
spi_nor_cache_sr_lock_bits() reads SR2 during spi_nor_init(), i.e. after
the flash has been switched to its runtime protocol. On an octal flash
running in 8D-8D-8D mode the opcode is extended per cmd_ext_type (e.g.
0x3535), but RDCR is not a valid register read there: these parts access
their status/configuration registers through a vendor-specific indirect
space, if at all. The flash does not answer, the register read times out
and probe (or resume) fails (on i.MX FlexSPI: -ETIMEDOUT and a controller
WARN(), seen with a Micron MT35XU01G and a Macronix MX25UW51345G).

Clear read_sr2 on every path that enables 8D-8D-8D, so that
spi_nor_read_sr1_and_sr2() degrades to an SR1-only read and no
unsupported command is issued. A manufacturer driver that genuinely
needs an SR2 read in this mode can still install its own opcode in a
later fixup.

- spi_nor_parse_profile1(): the common case. The xSPI Profile 1.0 table
  does not describe any SR2/RDCR read, and it runs before the
  manufacturer late_init.
- mt35xu512aba_post_sfdp_fixup(): some mt35xu512aba batches lack the
  Profile 1.0 table and enable 8D here instead, with the BFPT QER field
  left at a reserved value so read_sr2 keeps its RDCR default.
- spi_nor_no_sfdp_init_params(): non-SFDP parts that enable 8D via
  SPI_NOR_OCTAL_DTR_READ keep the RDCR default too.

CMP (the only user of SR2 beyond quad-enable in the locking code) is
Winbond-specific and is not placed in SR2 on their 8D-capable parts, so
no octal flash loses a usable SR2 read because of this change.

Fixes: 63489002d397 ("mtd: spi-nor: Refactor Read Status/Write Status support")
Cc: stable@vger.kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v5:
- No code change; address review feedback from Miquel on v4:
    - Drop the Fixes: b7b63475903c tag, keep only the Refactor one.
    - Add Cc: stable.
    - Collect Reviewed-by: Miquel Raynal.
- Link to v4: https://lore.kernel.org/r/20261022-spi-nor-fix-v4-1-fba3ec3d2b5e@nxp.com

Changes in v4:
- Following the Sashiko review and Miquel's preference, keep the
  capability-based clear but cover every path that enables 8D-8D-8D, not
  only the xSPI Profile 1.0 one:
    - spi_nor_parse_profile1() (the common case, already in v3),
    - mt35xu512aba_post_sfdp_fixup(): some batches lack the 8D command
      info in SFDP so Profile 1.0 parsing may not clear it,
    - spi_nor_no_sfdp_init_params(): non-SFDP parts using
      SPI_NOR_OCTAL_DTR_READ.
- Checked all vendor drivers; Micron is the only one that enables 8D
  outside Profile 1.0 parsing. Macronix and Cypress rely on Profile 1.0.
- Link to v3: https://lore.kernel.org/r/20261022-spi-nor-fix-v3-1-bffa00b75c27@nxp.com

Changes in v3:
- Clear opcodes.read_sr2 in spi_nor_parse_profile1() (capability based)
  instead of in spi_nor_set_octal_dtr() (runtime-protocol based), as
  suggested by Miquel and Michael. It runs for octal-capable parts and
  before the manufacturer late_init, so a driver can still install its
  own SR2 opcode afterwards.
- Confirmed on a Micron MT35XU01G (i.MX95) and a Macronix MX25UW51345G
  (i.MX8ULP): both publish the xSPI Profile 1.0 table, and 0x35 is not a
  valid SR2 read in 8D mode on either.
- Drop the Assisted-by tag (removed upstream for 7.3).
- Link to v2: https://lore.kernel.org/r/20260929-spi-nor-fix-v2-1-75440cfe4e76@nxp.com

Changes in v2:
- Rework the fix following review: instead of guarding the read at runtime
  in spi_nor_read_sr2(), clear the default RDCR opcode.read_sr2 once, at the
  point the switch to Octal DTR succeeds (spi_nor_set_octal_dtr()).
- Key the clear off the real runtime protocol so a flash that advertises
  Octal DTR but runs in (x)STR (host without 8D support) keeps its RDCR.
- Drop the swp.c change and the -EOPNOTSUPP handling; a cleared read_sr2
  already means "no SR2 read", handled by the existing debugfs caching path.
- Trim the code comment; move the details to the commit message.
- Link to v1: https://lore.kernel.org/r/20260928-spi-nor-fix-v1-1-ce65ba90cfbd@nxp.com
---
 drivers/mtd/spi-nor/core.c      |  6 ++++++
 drivers/mtd/spi-nor/micron-st.c | 10 ++++++++++
 drivers/mtd/spi-nor/sfdp.c      | 11 +++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 90524c58602e1c27cd83951ab0cdd3669a2ebfd6..8ded5cd12669161a95d7c08773b5a3a9a5f9b3ac 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2711,6 +2711,12 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
 		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
 					  0, 20, SPINOR_OP_READ_FAST,
 					  SNOR_PROTO_8_8_8_DTR);
+		/*
+		 * The default SR2 read opcode(35h) is not usable in
+		 * 8D-8D-8D mode; drop it so spi_nor_init() does not issue an
+		 * unsupported command.
+		 */
+		params->opcodes.read_sr2 = 0;
 	}
 
 	if (no_sfdp_flags & SPI_NOR_OCTAL_DTR_PP) {
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index f97f2dead8c2f175564410871c896260dc31aad3..cff774a83d7656ca2d7dc5af13a78c8c520b1dd9 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -181,6 +181,16 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
 	nor->params->rdsr_dummy = 8;
 	nor->params->rdsr_addr_nbytes = 0;
 
+	/*
+	 * Some batches do not expose the 8D-8D-8D command information through
+	 * SFDP (see above), so spi_nor_parse_profile1() may not run and clear
+	 * the default SR2 read opcode(35h). Drop it here as well: it is not a
+	 * valid register read in 8D-8D-8D mode and would time out during
+	 * spi_nor_init(). Clearing it again when it was already cleared is
+	 * harmless.
+	 */
+	nor->params->opcodes.read_sr2 = 0;
+
 	/*
 	 * The BFPT quad enable field is set to a reserved value so the quad
 	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 4a3f82e97cef8a76c9704918aa6558ca4e2f2b97..722eeff71d0df8c47ec7bdd795c08ba1bdf5e9cc 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1344,6 +1344,17 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	 */
 	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
 
+	/*
+	 * The xSPI Profile 1.0 table does not describe a Read Configuration
+	 * Register (RDCR, 35h) instruction, and the single-byte RDCR default
+	 * is not usable in 8D-8D-8D mode. Drop the SR2 read opcode for these
+	 * octal-capable flashes so spi_nor_read_sr1_and_sr2() degrades to an
+	 * SR1-only read and spi_nor_init() does not issue an unsupported
+	 * command that the flash never answers. A manufacturer driver that
+	 * actually needs SR2 can install its own opcode in a later fixup.
+	 */
+	nor->params->opcodes.read_sr2 = 0;
+
 out:
 	kfree(dwords);
 	return ret;

---
base-commit: 9a482184d910775cf648863148944945b74e2815
change-id: 20260928-spi-nor-fix-eb7ebe22a740

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

