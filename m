Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5F327A916;
	Wed, 23 Sep 2026 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193916; cv=fail; b=RspSfyA4Y6GXfCk1aBOKD2quDzrWCIIxTbdfwRYd9wOHtg40CVuOOmvXOub/qzU4TXqfehff4eoL3K5Gx7ipBQI77dwpJbbygZjO5jUlbGSyEtpm91IWg60f83wVXsk2IkXcHfIq4cGHd9+BAhupogN0P15PbWsD6hPIyhBD/ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193916; c=relaxed/simple;
	bh=8y8SRyjN7lu192l8EUSMoh4ZvJkKLJ6TMCVkILMiaHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCge/xOs/8ATFnWI1UFVSS4ET3SiIXkHUSFayZecKxv3WHQ4CU1J0Dy5i6l2x3wZ8ASkFPFGE6NfJEtsIccD9pCMrXKQXdzujKFmSlB6a9UWZ0ywz1HKAv5u648pA3Jz2/29/MEGAwrE6l9ifY0chdRido+QupgV7PjqMxGWEhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ioWonR/A; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ioWonR/A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8hXAlh8UkO8XrKzPsQ1ImRz2S5okbBJGft6MGFhWwueyIBlJzjKkTLMUcBsh5UdAKsCD+76iqZKdnMaWqSUZFiC+ke7F0StQFU5aS8mSFTjz2s4tpF8lCpYErDPF2B9/CS3WUaNYAvYQAlgm01fwXB1Dy1XVjP5B3YB0r1AtseebPTB9A11attHCBHvZr1EovDxQseDlYt01lbO4NP6WFWTXhJXLfLnT50Tc509cJWH/XC2JNNHxdKdUIohXZxFHvqu9nuVbL/g9RA9IH6CbuwsCqyKKBYlR2XQKk1H1wqvo5CLsYMt6/7ZdcrjgLIoMgEssSQMZfdBAUE1FhIWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jSxnkMeGXZlmQnIxY2aznCyO5UudSBPYAeIEB7ZBGk=;
 b=wWztlZNX5blFkgAdf7nU8Fr2MUXO/P04jxsRfd/+ToIbr7kLyimT4z6g1n7drmQM6SgN9IpfKlWMTpFMSyv9zWacAyCiRTYddkDH26qbVX0Q+Nm2t8j40KvoChsCvYhuD4A5rCa2sB55zqj/97WmWnpyC0xuFVi4WmVB7x3s1ypxNDrzh6USHW5X5oSH9R/SKztm+biaU9quZ2kZo4GQX5RLuwElkVJYflJheClbbJLJ4oVLlJveuJmdUnOngNpu58MxQQuve6pFuwDHNoMBwRV4Cflx/QdoIlWs8sg2g2roYEnNGznk8l63jvRU3w5YSjj0rzQB1vy6Yigm7WL4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jSxnkMeGXZlmQnIxY2aznCyO5UudSBPYAeIEB7ZBGk=;
 b=ioWonR/AmMCcoiX/f+PGl48cyRAmb++lBiSReLMoBXhCj9PRRuED7avZxEEK//FqmoRT3aUOcaug6I2BkBJhsJ6QkHptuMaUIBb7BXIJbPjvudjxNLn0UiPOhFZclHK82ml49XhYTLOU0ouwJAL5S61pSooQkArfcqLNZH6rcpfKAcpmhisl5+awX2Lb7W7DWYzDE79aNYCtM6CFj/qUdBRV3Qrf4UmM0i9vzJ7kS2ZF6KT3dwXp8IfFUUpjKc/HjsaKnyNjwampGyiuHCI4YPhZSJLdloeEhKZWgpdASiQ9UnkoXu1NQvTZPRRmA2QAxDUSoGmFs5pGT62F41jNng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10715.eurprd04.prod.outlook.com (2603:10a6:800:277::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 20:05:11 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 20:05:11 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Frank Li <Frank.Li@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs
Date: Wed, 23 Sep 2026 16:05:04 -0400
Message-ID: <179019390119.3737954.1025344314457849212.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914183932.30325-1-francesco@dolcini.it>
References: <20260914183932.30325-1-francesco@dolcini.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0163.namprd15.prod.outlook.com
 (2603:10b6:930:81::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10715:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2ec596-33ff-4eaa-0965-08df19adf97b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|19092799006|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rMc8W8F2zCPR03apzwGCYObi5yuDhmWGqe4Dy9zXzbdlLqX99YPPktIN+GWr/yv2fgn1qYfhzt15Ti/xlTvJz3bB0e4WX09V8DqS7TVtjBl7lkVpLECG3m/HX9rG+E2oRegSUQ6npmi9w05+2hPYq56hT3CljcpLb6Wh53KIWTf9ziRMN3kq3dFvYB8D3Daek0GeLfzhBRYd8DBX356IlbXIDdA7L5OQX7CO2ZWQLJHR0tUHriymDB7psF6BMlZJk/Y3p2fVceFGMR+pVxzXqvj9jqkF63iQSwbvyZcGUVpu1JShUDCrUL++eH6Di/LlbkX7m/xr/bQD1tdJLZlKkJMd9FtyKSF3CdT8NHBFwKWP3QL5FwPwvxI+PHyAzjkCccAipH92DFuGzF10c8XW038Uiv0f+7edU4hhcjABjasjelcVTkCMrDeiDA0DfRxxZIZBLfiUhVeopj9TEwTpM9v8eK/3GyTgs46CCA5cVx70ekSnqYGRcfrD1JaN2zzqwQaCqAVq5RGwaFklSQAUTYBZi/DgZ4toqVhZ3/8U9NWAE3vcADS9lt9rUZh6LKYf4pJMGHoIsyIf/mv1MoGVFAo/8emkW+TnXVi/rPYHSonaq82z+HG9Xb36Okx1h800q5Al7rbqhp6k5N6yJvwDLJ5uANQG5NdbyTEHXxm86Gc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(19092799006)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhVYjJUYkFoZEY5UDdTMHJobFE0dEhDOWtKVDVzay9yYmI0V0FoN3FOOTVn?=
 =?utf-8?B?a2NWVWw1eTF6RGt2d2paNUdnc2pBdXJIU3d0UThkTEloeGFIck1Pa0JTZVox?=
 =?utf-8?B?d2Fib2ZZZEhkcjlWVmRqN0pvdnlQdjR4MTdsQlNrdXpjSmZTaFVwSVJPOGhr?=
 =?utf-8?B?bEZpU1k3SGF3eUd6NUY3ZnZWOEI0clJkYjliL01ZOEtsZnhDYTZEQ0xjcWwv?=
 =?utf-8?B?SGRPelk2T1E5TmowRVRQRkdxT3h2UUJKazJxd0ZOSExUQ003MGluY2ZEek12?=
 =?utf-8?B?VjNuTlg2WEtiL2hQdDlDczBPVHQxMTY0YytGMERGVUErMFFKNXdPQllCQWYw?=
 =?utf-8?B?eUJUalRNL3ZkYTZFdlZQRzA5Z2RHSTZpd0lGc3dyUW9KZmtINE9FaytOS2RN?=
 =?utf-8?B?TnpBQUdKaURBaVJhUlRqekZ6VTdKY09CVm9EQ2lSRHZOMjlmRHl4TUxJL1Y2?=
 =?utf-8?B?ejJESzBYL3JIdmMxa05uQVNWVlUzajB1bzMzZGVVMzRNN3VoTExmdXZUVnB1?=
 =?utf-8?B?VVE3bVI5K2dad0NBOERWeE1vWDlDcU1EOHVoY2NBM2VkUm0yMmJkRlVLTit1?=
 =?utf-8?B?c1dLMVd4b1Y5Z3k5d2tQRkZMVWZVdVJhVWtkandScFVVQzVMdWNWcUp0T1Rr?=
 =?utf-8?B?dFJpWmQyNXJwaDEvdXM3eVZPa3F2Tjl1RTNHOWdiaGppVlJOMDFqbDJsVmtk?=
 =?utf-8?B?TmpaYmcrLy9nWFhyS1NiZGRKeGpaNUYzRmRnVW5COHZoQUJIdHY4Z0lpajNC?=
 =?utf-8?B?dDExM2Z4RUsrVzBwbmkvWmNkZHVoV3RraFk3ZDJrbThOUUM5aW83clZEYjV5?=
 =?utf-8?B?emlFS1FRQzIwNzc5Mm9oZjZObElKOCtxcmlTN2JVeTEzQXp3TDcvSExRQ0Jz?=
 =?utf-8?B?YUtyenVac0l1M2IxUkZMbHJSUGdwQjVpSHNIVWt4dk9BajAzVjNoQTNqU3hQ?=
 =?utf-8?B?SXdKMmhsb29oY2puVE5KcVhieW5VNkVKeXhjdFBUcHkzRWd3VytnVHdDT2JY?=
 =?utf-8?B?bTZMb3NiWktoZzR2cWMydmgyWExjYzNXZ2N5RENNaVZ2eW5wWjBNM2V6YTRS?=
 =?utf-8?B?eVNCc0UveUJqTUljL3ZxSXc3NncvMGt3Y3R0OU1nUTVSOG5LRXk1SzNTL0t5?=
 =?utf-8?B?c1BZQUkyczlkU010UERYUU52YW43R01nLy8yYjlPdHRuS1JwZVV5bnZRQ1RM?=
 =?utf-8?B?S21VSFdQaTFGR1Z0eDEyaCtqRmJ2ajJDWCtpWUF1T3BjUVJXN1BzQW1ZRG9Q?=
 =?utf-8?B?RmNITWRlNFY5WU9XTC95MHhFY2pVOGVYcjlNcjBscGdGZU1hT2R2alNNYVNx?=
 =?utf-8?B?bm5FeUw1VVg3STd4czZaRU5yRW9zWUd6K1NRa2paUzI2a3RESERSY0E0QlJ0?=
 =?utf-8?B?aVR2MXdmaWRIOUYwQTRLenRQc3JIOXROYm1YcEt3bkd0T1FZOHd4ejAwQVVq?=
 =?utf-8?B?Y21ESnJBbTZzcFlUckRYclhIYzU4MGtwclJxNy8yUEptbDEyN1gyQnRaNjRT?=
 =?utf-8?B?NnkxUUhCdkpzV1dCZlRrOEgvVDRhdUp1MkgrWGE2VGM2NzA2VnROUVRoK1NX?=
 =?utf-8?B?eXp1aFhIZTMrekZhcTBTeDRHS0xlejV4RHlSdFBNcmNteDJ3WExFUUNRTS9C?=
 =?utf-8?B?c0NoY0lSZFI1WklOTW1oOEJZQmp5eW4zTC82VFNHSkpYNkpWQ3NrTzBwd1Zl?=
 =?utf-8?B?QTFkcDZGeHFsNllMMDY3eXJmQy9WV1ZRcXNVU3E3Q3B0YVcxMmpnM2dKcFRl?=
 =?utf-8?B?OVpjOExiWDdiRWFDNHhqdS9TZFZBVVlESFU1Z2FzTE5sZXhJdmFtcjRQMkxq?=
 =?utf-8?B?dUZJWnlpRkVlUjROR05NVGM4ampzSVN4YlZHa1gzVXVzODNhSFRPeFlHYXZC?=
 =?utf-8?B?a0FkMVhwaURxVWxiN3l1S21Vd1I1VktMQmt1L2lURC9EVVZ4NHJ3dGQ3VXVo?=
 =?utf-8?B?RHR3emVWTkNFTnErTDc2NTV1a2pRSjN6cHQzbEMrSDBNNkZ4TzdWUmF2cmVX?=
 =?utf-8?B?RFhBNXBWYnVsVEc5bzAvL3c5Tk11OUZSTERISm4vT3hTZHNQaW8vUjFGZ3Y3?=
 =?utf-8?B?VWYzNjJiMkwxdXFRTjl4VlVxdW9UVndBdlByNEhvRVZZVWZxdWFMSXdUeVVL?=
 =?utf-8?B?QmxFcGxTQ1RNMXRCZTJka1ozUVNzanhoUDZXWGtrd3VwNW9jbUJDdWJvZTBo?=
 =?utf-8?B?RzJ1KzE0K2RGK2JIMmRsNEprcWZJWDFwbGNwc25kRUdwQ0lNbVl4OVhURWpz?=
 =?utf-8?B?Rm9tRnlVN2xTTFZkNE14TlRZdWFxNklHZzZRSTR0SFg1RzJwWTdzS1BhZXVJ?=
 =?utf-8?B?UUJCVzBibFV3eFZsNm53bDhmbWFpUXBTcTNKZmgvNnl5OUZQWHFLbFk5Nnd5?=
 =?utf-8?Q?1e4NzmPKADHzmO/LVr2+FErFZZqpw7Q7DMK+c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2ec596-33ff-4eaa-0965-08df19adf97b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:05:11.7668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjwMv7q3oD1xb9XIXSRILx0bLHd68/frcfp2nhTehKl10qFm6WmCXoXlzWOA6qbUvjf4m8HqsnOraJsMvFCGvYtgh6FBdDZcX+3H1PJEJMDwsZnYvQZ1l5p4xXL1m6lG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10715

From: Frank Li <Frank.Li@nxp.com>


On Mon, 14 Sep 2026 20:39:31 +0200, Francesco Dolcini wrote:
> pinctrl_gpios_ext_yavia (SODIMM 64/66) is defined but never applied to
> gpio3, so those pins stay at their NAND reset function instead of GPIO.
> 
> Fix SODIMM 64 to the correct pad, MX8MP_IOMUXC_NAND_READY_B (GPIO3_IO16).

Applied, thanks!

[1/1] arm64: dts: freescale: imx8mp-verdin-yavia: fix external GPIOs
      commit: f377ac5999a5d045168ddd25d204691c6653c06a

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
