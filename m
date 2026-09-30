Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013025.outbound.protection.outlook.com [52.101.83.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE954F93C1;
	Wed, 30 Sep 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777908; cv=fail; b=Wk1sjZ7otAtq1acvUwOuVrJAoIP6iRTcare3OKpk07fGjDpm8OMaqrslX+jwvEOwxfGULOs+3/lI38fOkoD5lw1thNXl0nkequrDZ++DhrXD34Q4h1GzPdoCaBqfRY7Q0Ina8F/kChPgr4yMSDtzgwPy1Dgr5iyU/Mc47IABQa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777908; c=relaxed/simple;
	bh=S308UaOG7HS1aJpmOm2EPf21X1s6e4G1y/d+gLabZu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9D/1/h0Y5VnrHTsxpww9gCQ92fB4iSh3oxWjUan+QWMBS2EA7HIbsebWg251pQwmKpm3l1A/6S5KveZgrLgTTOQYi5/cFLWe0RZGUc7nSliRlB+f4rKV2mOOyEVoMcjIwV74WGBRicr4Vjc+ACiZQTl18pZ04YMTiRm9iRsJTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=i+g5/t7w; arc=fail smtp.client-ip=52.101.83.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i+g5/t7w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILA0ydwlMzDcsJSvCt0LStzn+WiBlId5iJYO5WKmPn0Wy944V+ebjBDVnkDIKLE29c+248Y7sWtZnIpN4MMDJE//D7zoolQiuyQS2Gc7oRXHAloiEqeHs8+1nDBLKv5SIN2rlqTTpgCkJIXB7W2lZvA2EwxV0xI6baPgVIUuclDnnWuAZwKNpv375x7IYQWg5PLbuiFyyLQ9L6JdiF8KaqIMljN9rinmNoy4KbV74ZGIMVtdRuLyKx/eqxM5SsYtPyfWr//qHM8HLltdL+bqsW/1cO1E/SMyDp6dXiBr/Ne4fyK67fN8jFyWjDtjhOIShbE8mTAOHOn+x+rX/h6l+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jbhOp/u7O6TAUESIxolBRuLrgCpzY/KB1SzcllhmiY=;
 b=PwDM8wfoj26Q1L9gXrWI1cNcCb0A/iu5qS7aULNQ921AuI4moqP7T/41tp8jFp+S8znjZTFK8Sx9AFGpBHvyXVvO4SlDbF34ihT62bhJd9x9LGMGdaf7wbDftUpHNxrKoG7DSX1jxrgEvZg8SeyydLe7UShQFoEprnDptrd/hL+Qh5BJw+gfxI9L9H9SZDft3a4wj5qDX/uCGFQF0ARU/HgB3CTkJ4GV7TrTsi/XW/0WHRsyS3GJhvNtJjTuw7oE97Aiap43CpN96DP0tY+M6WTaFW/hDqvoCA2/LxHIn3VTg1rcAiNGRHYYtN0WsNIX4mkNGHZMsmkiaWwHKxl/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jbhOp/u7O6TAUESIxolBRuLrgCpzY/KB1SzcllhmiY=;
 b=i+g5/t7wgYYdfeBUAXmt8HdFjGm6GjjsdnDhMO4urYUSchM1T9ciI3N3jVXIdXVCAIXCDi75HmpIvgR1xFha9MGnN3U+clyXqoq0f147XKrZRiqDgJNFlmjPiFwLsgJu6Lwgj9QPXhnBu/M/k2ugtpfxvVpWJds/WQFgvYXQ9Ga5HIpv3I6aV28EjvvJMh9Qa3VEbrfzYg2yD4lpEj/mAG0D4wFCP2no8IiUS5RulsHnTOlf5MlV7qqBE7k+mTl9x2AKXmIuBYN4+gHGNtQHcFhufaGrIusxcoLXtaUHbdbIKMps/jr7PEnhw+lga5zYcjC3X9E4v6Y+KAlz5KnZ+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BR2PR04MB057688.eurprd04.prod.outlook.com (2603:10a6:2c8:2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 14:18:15 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:18:15 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Antoine Gouby <antoine.gouby@toradex.com>,
	Franz Schnyder <fra.schnyder@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco@dolcini.it>,
	Franz Schnyder <franz.schnyder@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: imx95-aquila: Enable I2C_3_DSI1 on Clover board
Date: Wed, 30 Sep 2026 10:18:08 -0400
Message-ID: <179077788251.506760.16212244787147769940.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928-imx95-aquila-clover-enable-lpi2c8-v1-1-9a9755acb8cf@toradex.com>
References: <20260928-imx95-aquila-clover-enable-lpi2c8-v1-1-9a9755acb8cf@toradex.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:930:8a::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BR2PR04MB057688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b582109-5ea3-4944-39d8-08df1efdaae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|1800799024|7416014|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	dyy5lUFMnpVcDzY20yfz53064Lrn+e/nDpFgQlESc2/UzJJDLpGXQd6HqwXsLnPMdOLdjcluRXAsNcD/7m8/77NVtod0pUeYlpzyPvcBv9Y40W0ojnNBUSQXC82yTwr0xz/9juAeUOazRbWAQedKiOlcb6vJ8C3LqPyKaAlDpk48cUz6YfWJla3Y+3yFzLBQmMgf+yaUQrEGxlIQHVlw2x/+cWRp2kvWR9gwtm4ZrLpDV62nfpf5FzpBRzqZo2zLb68BOiQyHvGoF7nNHKTW9Hl9gzZEYVSA1wIvwJ0zAcAc9bM2KP2/ThOohnGUW23z1Vfd8mV2MfDmaIMBGxAMoYtpM3ioVQrwL4Xv/QlT4vLVQRFXnvpNgjThmjdxaEDUcRX57V4nSQZv33VKKD91eivsI1UOwhUxbBZyuuZ2GigpO3ftGcgrqIl/4z6FgFZeX56v/TSuSx6Kye9dESdjP64iksoqs4WU5DdQHlyFGt3IowWqKqL4e1P2FwCZrEJ0bd25/7lCQuXA+6Cv5JcVFw3+7RsamStDl9wFFAy63Cr0746OWGfum9VpViEnbyepTFMyHsQEQ66inWsHIp4PANnp3W3Fu2f7THrMXzpv+cVY4UUMXACl1RvBdIs0Z+p/barBFuJ68q/Q573cCjMYBwdaw6eCqeChQtXIMwf75/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(1800799024)(7416014)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnlrS05OcFJqWDBnMmhhKzVvbGVOUVo4VjdPTTZjcUt0OGdSTXNoaTRGaC9Z?=
 =?utf-8?B?aEFrZStNNkFlYTNlTUxjdkFsYTI5RVZidUx2RGhIMURMb2s3cG9pSDAxUVZD?=
 =?utf-8?B?YU5iN3dQSWdpRlVaUWhyL2UzcGRZTVVxK2llV0lodkFTY3pkNFZvVUx2NzVO?=
 =?utf-8?B?eXVTUTJPeG9UVVlHVkNXTXRsMnVUSnlicXlPVlRqWXFTbzJ3TTg2VGFCb3dG?=
 =?utf-8?B?MmdCdVI4THpJcXpWalgvQ255Y2t6ZisxOUpmRFZrL1hjdXROU1NjL284cHNn?=
 =?utf-8?B?OVptMmkwSjYxSXhnUWhZb1Q4cGUrdlNTZ0tRdmxOZ0ViVnBvcVEwMDBKTkV3?=
 =?utf-8?B?eW5qRjBoUFVNbTkxSGxhQTFjNmxQRSt4cTF3VjNnb2hRUXpQdmdnd0JOT29O?=
 =?utf-8?B?VW5BV09BRzVCSEt0cU1QSldNVk9ja05jcURnZzlBWldrWi9GTzdxTUVxYWpy?=
 =?utf-8?B?TDB5cU5EUng0T3NtT1lvVGFxUWVxWkI4SFhIODJCWjh5RFhCUDc4enhQeU5T?=
 =?utf-8?B?U3U0NEVMUWhBT1RUaHdJMXpRUWV1dFpucUwxdkt0bll6Vk56S2hYRjhxRTl1?=
 =?utf-8?B?SURQSHoraXFuRkVKNTRYYjFzdmlreDl6eWdEMWdxRG1pRTA3d0d3T2o3K0p0?=
 =?utf-8?B?RVZtRFp4MDRYbTdzcGN6QThZcUU1dXR1Mzg3L2hya3g1cmF0ZHdCbDdFSGha?=
 =?utf-8?B?aXpOdW1IdUp2dWtCVHRTdTVnVUtZYTV5ck4vK0I5ak5iQ2tWanlKYmZseXV2?=
 =?utf-8?B?UnRBWGx6QU9PeEZPYUk3UXE5VlZBekpjS2VvRzdhUEJSbkpHRGRzWTJmZDI1?=
 =?utf-8?B?OWpuc2ZKa3ZFVG53ZEtheXMvelAzNnpCQU51dFZDQ0ZLY0JHdk1DRkVwcGwx?=
 =?utf-8?B?UXp5RFhqU2RSQ3gzSWswWlo2MWtValhSb1NGM1FYemU2czZwUzFGWjI4Y2U4?=
 =?utf-8?B?YUNGTUgvZEQ4ekhPRzB4OGxNRURsa3k4MjFSQkEzeEpBMDkvNFBiRUY4OW9q?=
 =?utf-8?B?ZnFycWY3SU5DZ3Jmbkl4NkhJalJQYUt0L2h1Q1ZZSGZFR1Qwd1hISGMyR05m?=
 =?utf-8?B?cFhNUTd1dGVwdHJ1TGFIVzNSelhyWkgxQzAwcEpoWHp6a2UrOTdXcHdkMzFt?=
 =?utf-8?B?czdPOUN2UW5xRXI0NHNVRTQwYXU3MDZLTVBOelZReWFGdlQ2TnBpWkIvdmVo?=
 =?utf-8?B?WUtoY1FlK1UrOFNVSUk0OFFJd2JkLy94QThHeEVNd0p2WVVoV0U5YzhjT3gx?=
 =?utf-8?B?aW02aXd0MGdEbUtJdGs2OEk4SjZQYU16THpuM0s1YjZrM0pMYThzZ1phTkgx?=
 =?utf-8?B?NDMwNWNXYlh5SkpwNGlXOTROcU92RHVIN2RSa21oTmdMc0FNN29sdktvZ0lk?=
 =?utf-8?B?TTZVWHZBdTc3ZHRvS3YyemROWmFPWVAwTjl6Umd6ckM5RUk0Q3VxRFcrYTdY?=
 =?utf-8?B?SzVqSGxIZFIwUUZzVVU2c0dYeWdoN3l6TWZYWldsZ0pKTDhpb0QwRzAxa1dP?=
 =?utf-8?B?VVdQMXFwWlV2SnhVK3Z4VWlrZ0g5Ym1OYUh5ZkQ1V2hZbjhwekpUbUxhUy84?=
 =?utf-8?B?czNLWUlrNU5FUElnUGIzWGptUGowYUo0TjVUYlhOZkZBZU5oby9RbXN6STZ1?=
 =?utf-8?B?L1dOeFdRWTlRM2hFUkZsUlgrYVhxaG9OUC9xWHB6WkdWeG02WlZFSnpCRSs3?=
 =?utf-8?B?WFk5S2xXSUh1UXRWQTRnWkVrMXNrdTR6QjdyK0JZMDJsMmJsaHNPcHhEbjlI?=
 =?utf-8?B?NHIrUnNPZEZ3clZialFzMTVxZElBK25HeVFpc1dDMm9lR0dhSWJBMVlJUVBO?=
 =?utf-8?B?VTVEYkRKVGREQ0FzOVh1RHdINUZvSEZSbUtsOG84emJRclcyUVFXZk1UdFk4?=
 =?utf-8?B?TEY3aUtGbkcwRnRPMFVtZlJ6VEQvdGRqaDhqV1FMZHdwMDNDMHE5TERuRUlG?=
 =?utf-8?B?T20zWG1ZQU14aXFGMUg2M0dhSXBNZXVvRFAveDVhaVFWWVBqUlRtUUdBaE5G?=
 =?utf-8?B?ZFBQdDM5QUJQZEk3RVpVZytTWXJWd2NjcDY5bkFVR3pZT3l0b0QwOWNCYjNZ?=
 =?utf-8?B?QmEzMTMvWTZuMGRJWlJaVTExQ3BWeEp4M1dYZTdsUUNhU0RvTlh1SXJlT2ZH?=
 =?utf-8?B?M09WY2hZNzNKalQ2c3JSdlVGSXhUc29MTy8yTFJwMlVaRFVYN0NzdzF5dE1y?=
 =?utf-8?B?Rlh6Z2ZWYzBpR05DRlo3a1lVN1ZWaHZmTEhBaXQvSk1qcFNMRUJPL3ByL0VS?=
 =?utf-8?B?elAyd3NPUzk1RmxIUk9OL3NVTFRVR3JGRks0VXVJYnRaSUN5ZzJWaWxGZVBY?=
 =?utf-8?B?T3l5dzl4NkZJeUFiNGdhYUowS3N1QW1HOWV3ME96NUhkVndpUHI2bzRrMTQ5?=
 =?utf-8?Q?w3YTYM2uSfHvLfDAzK4kXVKfJwJXOMEPPKZZp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b582109-5ea3-4944-39d8-08df1efdaae9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:18:15.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9qwMRNgFSDZaTShWZXFQnU7kd7ynS9U00BsUdnAnqgr3MtlNI5nnz3uUpGaAxwWZq6X46s7uI87kkKkE1+V+C5z8cQ9qjkOpI08JKr1EXfWsqfLLCRqot7Mo4dafinE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB057688

From: Frank Li <Frank.Li@nxp.com>


On Mon, 28 Sep 2026 17:00:46 +0200, Franz Schnyder wrote:
> Enable lpi2c8, which is used for the I2C_3_DSI1 signals on the Clover
> carrier board. It was left disabled by mistake in the initial commit.

Applied, thanks!

[1/1] arm64: dts: freescale: imx95-aquila: Enable I2C_3_DSI1 on Clover board
      commit: cffbc25c212bd41885094648918a935da0115a0e

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
