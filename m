Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132733;
	b=nQEM0q3k/zkP0+d+LfIY3kAgUzXXEf3hh8sXm3N236oewaY8FJSdy9GZiSW6WKirCsmZ
	 i+tNlmddKjyQJfAPhZUOpRTi2hTPzHxl1HRP7XhttKAbqpOWM+uPkUR/Ip42xxjiMHlRq
	 KkNO4/EI+fkahK4QNP1sV9bqzkuAxtPtRTGPJmVb2kg14e75NkR56BkqU/h/ZxnuVnqv/
	 1DTddrnwF1RZKD0oSx3ufO6PL2CquVlYobgtXHFbhthQSxT+VVmOTTnC8T6wrscDupu3o
	 +vxNuEenWBpTJgM1wbVU9urSFpDtqCkiQwecnrvMOalvc9lNsOpgVIPAG89EVkQHy7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132733;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MVs4vMuJcPOl7XdAOTCViYEzVoYTSgeCpRTxv5DOkG0=;
	b=3fSZZe1Hgk+ibmhw15EoIKf2yMwqeOgzbvXghsA+SnG8/kds8n22+OfFy5os2TF3K7EE
	 J3Wi6xcSu5/M+tV/9Jzl2Q/OLNGIy0gy1vi3Af9TEcnQ8ut6uYzOVB6t1Pnh6VZqLHPDc
	 NKVNwkBLalKE/0cyfpVaGz3UXz1C07T9sQPwa99u0Ggbw+q7UuuCecu4awlpE6NxOPy1j
	 4y3ojP9oytbAXwBAruLDjVd4LZ/UWQMV9ybjTbH7aJEj4VkXOOzSZKdH5i9SM55mflilK
	 lXLb3Xtk1qgyuIavfTYA/UhzxsIZ2DWszq3V6Syd+qSMzK5LCtW0lnPyiB7mGnBsXUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LvifACqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.37
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010037.outbound.protection.outlook.com [52.101.84.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8C606B5D8;
	Tue, 27 Oct 2026 20:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CA8C606B5D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LvifACqW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNJ+6eTu6XYL8+fZ0xIABpEHrlPb9O8phZdSf/dppO6nNkrSlJWjcD1ZadL9ZXKMaZTfFLLVuulSbv+RszP8zoLh2UbhJqx1miSfn+BQoxsFFWaIp7d6LFYtVCo/uH39euX5XaS5Nx0Z1xlpFuo0Dll2Kr5FkxXg6WCuuqLWRZxDquwZgj3a2V8v76psZyg33VTFgCIawFblpAtj8XsOh/jxB4NueLIbD+Y1GoH2lWo5resQQTJJpl1k7T4QgPj9L6+o//Xug/m3boSuLyOLIfdfYd1/An50/IHT1qwPrHorcAgZX9tXNURnwQ5BivLBL+WjbXD3S5+kTaSseMzi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVs4vMuJcPOl7XdAOTCViYEzVoYTSgeCpRTxv5DOkG0=;
 b=JJcxmeHxNHWt4dh5mqenWtU0JNcIFEgI+vdIRA/HZ7pFX/GY2lXWAlHw8WJTJF2vDoVj1XkSv15kKOFq0TReKrJ9fZ+wZpwbclDKtVgZtToJCHHR8IpzaQJjtJOqnmqVtFtHmCZZNPK+TCrO1QF7cX9ZKl4SertDuISsyM25w7meTi2cbFKo+ZRLfbOBOBaFbX1WGjKFtvGx6VdynRH7/b/DdxjYU7VYSWvqZ2QFJKaEwPOQMIVPgrAuSfs1VexQThfJ5E0YjeuLFcF1ohGuW9+rMYu26jRpJz1fTDTKkwl/S2s/IXoRyIntKhI8GO8m3D+n2nQvGSX0f+yPIoH0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVs4vMuJcPOl7XdAOTCViYEzVoYTSgeCpRTxv5DOkG0=;
 b=LvifACqW5wknB8FsP5uqe5x26P5tpt5m7A6elThE++p7mjv7VcL5XvXkjfrIbbOOEwzyjjBZ8VRkExUtv4tPlChXMxTGMExDc91VpR0XHB/dplhEyed51eDkFwz+vqR/s8Uzhdu1sCiScOspLWdXwe44hdhG6kF3dzFsXXreSzMg6C31lYwZwv1g3XyzsX7pgbbbnNMOAo2jabvrZ2Jh5dyoNcODIQPPhtesV9ZhePgBIxUkXqi5Y/e9r5D12rRmObDJk6XKucQD+wdpjqaPmyb2Er8yp0GI1JIVUA9c2ut3/36V3ZK40F+X8LMM4DVuhzoqhF6vXdylFGd/him7OA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:25:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:25:29 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?S=C3=A9bastien=20Royen?= <sebastien.royen@armadeus.com>,
	Julien Boibessot <julien.boibessot@armadeus.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: apf6: fix Ethernet support
Date: Tue, 27 Oct 2026 16:25:20 -0400
Message-ID: <179313269141.286433.16417489150461232324.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013-apf6-fix-ethernet-v1-1-9530efe1d23e@armadeus.com>
References: <20261013-apf6-fix-ethernet-v1-1-9530efe1d23e@armadeus.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:510:23c::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: e01c5472-e28c-470e-2fc8-08df3468712f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|23010399003|1800799024|261009223027099003|261022105027099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|921020|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	KchNfZtvsvc7QVuALA3QQTo6wXiyz9ffar9lUJEuJfQY9uRJ0Oq0/yqbhE+2FagvHEikAQZ6JVlM0nq0Zj6kGAOrVcVxnvmbg0pGmr3SbOC0SAQ+f2nmgcIx1klusbkAuUjNIhZUK8Uv1WBDoRcAFrD5QevdWY24b3sBGcdEa74G90usfl6JQ0BZOeDlo1GdkSBWj16OFtvMaKQwgpH48XfeHCE9dtFZYkfNzJuAi8DyJFIeU2aDC8t0aPriucA6/u6ZgnRJYi94YNv52cvfarMLEuOxpd0xgTbrEPjKHiF4Vx2+ORO4RhZhU8gNr+eeG6Adli8mClqyAyJo0v5BX8auW/H69yfQ+Tw0S4q7CjpC+gBDrKezs6M2cm79Z0RoYKk8t9hOcoOstxlXll5pmVPWJOgM0HVeWZpn3uL8yYWokEeE4PET3f+gOxOdbxl18TAAtPZrJV+CFjF7zJnr2fJ3MfZr6cqEpmLQKmD3Gt/D9vL2AyTumxt6PLyk0Hfn9PU7h8pyEcARDTbks/5Jbr6dnkdTK8M3H8nzaJSCFavqf4iLHLpsRwnSKVc0E1MALMl3oIyua29Rk3Ro+cCN8+asfzPmutSG+7E1XVHEqTsRTjeOMyuLB3FD2gHJ+b3fp/GCcb5zgt/D99TxRIJZJnEFPr4sHN8bNhMfhHi8hWYL04L/JaBK0bQE5eHy1zbmJghHcH4UkX7i4zdvEUyTlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(23010399003)(1800799024)(261009223027099003)(261022105027099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(921020)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Njh6WVZEZU5OWmZsSForMHVOOXZPZkgxYkdVVHh2N3l2bDBSblgzQlovbDBk?=
 =?utf-8?B?T21jWmxYbzQ3NjJQZXJSR0xBVXpaSng2TktnZ0RnWWJSVVFBcy9qQTQzNzhn?=
 =?utf-8?B?MDBjM2FpTnpHbk9vWG9KaVRyc2FZUjBmQ2VuM0MvZjc2STJnelgzK0Q2WjI3?=
 =?utf-8?B?TkRmL3h1UjRSUlN5MTVXajFiUFJzMk1La2RLTUtmREVldnc3UjdRaEdmZk10?=
 =?utf-8?B?YnhCNXIyMWFVN01PSGR3U3NyVzFvRG9UM1AyUUN3eU91SmZsUEZCa1YzQUtS?=
 =?utf-8?B?MHhlZnIrY1RJM0Y2WlR2c2VybnhZazhiSlpiQnNoOUIxYUVJZldhdFdHR3R1?=
 =?utf-8?B?WERPRkNzOUx3Nm5lREZDMHI3Y2VWU0FVT09udzBkWi9HWVZwMWQrckx4NVFS?=
 =?utf-8?B?aVc5S09iUWdpeFVmdjRqdjlCK2IzMmdxVFl5dms4MWRMU0RPbkprY3I0UVFE?=
 =?utf-8?B?c2hzeDJrZHhyaXI3bC9OSjRZT3p2L3cxV2ZaMTIweExFN0NnTWV3NnN3UkJ1?=
 =?utf-8?B?VVdySGkwTXRxU0ovTnJaQlNId1Y2K0lXOHN6MDgwN1p4cUZoV0lNNXNod1lz?=
 =?utf-8?B?QUZFNjF3RUpqcHpkMUc5NFEvOW0ybHYwMUxBTW00aFFOR2g4QWRkK2ZDMzRn?=
 =?utf-8?B?UUZ1RkdaWU1GVGh2K3p0ZWQ2c2RtZHlRc2J6UlhjRGcyV2FFK3RWMHk4Q3BL?=
 =?utf-8?B?UmtFNG1qRERqTXFFZ0FqaXlYeWM0SjNEOXd2RjV1TzVzcWEyTXhSTFdFVXNx?=
 =?utf-8?B?M3FEd2ZHZ3BSS0g2QVpHZHNzNFNGclZhWWRodWR6QTRQeVRhK1V3MzlKbVpq?=
 =?utf-8?B?MlVQS0dyZzFHSWNVdHVnemZFZ1VHSTkxeFNxUmtxbUdvUnpMem1XbTFoS2Zl?=
 =?utf-8?B?RDVOd3ltQU5ZYVJjRG83NUF3eTYrcUZwMXFoMkw0QzVTQVhXdlhESC8xMU5o?=
 =?utf-8?B?clg4MEh1UHVEeHRBUTdGWXkzNW02VGZyU1kycVNWbDNuY1FhNU9CRzZWR1FU?=
 =?utf-8?B?VjRXL2NySnNWZkExdW9aT0t0VHExVHFGSEM4K3FFRTVvMUNvME1DSk82MzZV?=
 =?utf-8?B?ZllMV2toNk93aE8rZEFYV05zSUhUbG9MenJzWXR1RnlFTmdvZHBXRnE2SmhM?=
 =?utf-8?B?bTlSc2o3ZDJZUDJEOUFFUnJhRnYvZGFTOXJSU2wxWTBwa0NvWFMvMzc1cENL?=
 =?utf-8?B?TCtsN2ZIMXc3blNFeDNoanBCTjNPV3JCRGkzeS8wbDh0bmpVVXR6dUZhT1ph?=
 =?utf-8?B?a0gzWnEyKzV5MVYwWXpkZVQ3Vk1ISHBiM1pyM3NqQU45VExUdU8zT2ExOW5J?=
 =?utf-8?B?ZDNJeTZxQ0VYUTdtMDJMRGZoN1FpbzlYVmtReDIyUEFvU1FBUWpUZGRDazhY?=
 =?utf-8?B?SUxvekVFdDIzZDVNUnlmRzNGN1ovTUhiajNETGtCUDZkNGVzcXZ5S3JiZk4y?=
 =?utf-8?B?UGN1SDBhKzQ5Y1NQVVJwM2wwNjVxK1BHclFxaHRza0tadTdSODh2NVk0MUZ0?=
 =?utf-8?B?eGZQMlhuZ2lEbWU4LzdDVXNrdUJ2WnArdjhxQ1ZMcVZPSW5rclhEbitFbGVs?=
 =?utf-8?B?bnFkUzdwT29UUE13QlRuMXhudkRaejV4RUtDUHlCU0ovWU8xbklnL09EbDVi?=
 =?utf-8?B?cWFLS3Z6YTU2eXZCWGRJVzlWQ2p3cWJEQlhBY0liUlhzOVU3TnZ0S213Sksr?=
 =?utf-8?B?dFkrL0JBdlBydGJ0cHlBK0tiRjdyakNnaGNxeUJHMTVDWlk0ckdhRFUrRlVE?=
 =?utf-8?B?K2VaeWM2YWFIYnpoQ0VKaytPVVFLQS9wREdiRG9FaEVPcUVveUF2VWpSUVlR?=
 =?utf-8?B?dTJiRk5TeE9aZTVVTGp1NlpFZWJJTm9lZ3NXZG05WkRDR294aWd6ekpGMmIx?=
 =?utf-8?B?UmlPU0xnWTUwSkpsb0pnd2o1YTBBSU9QRHpNRktsS2RxR3U1Y2pzaFV2RkpU?=
 =?utf-8?B?ZUdYN2d5cXZESGdCb0FoYS9kZGV5Nm5pU1ZXNnlsZzZxRi9oNXFQVUp3ZHU1?=
 =?utf-8?B?V3ZYTGNTWUxPbVpRb0tCT0FHZ0JMOHh6VkZFN09ZRzhWUWt6MFkvZWxNaTQv?=
 =?utf-8?B?VktVeWE2dmxvdjBmV0hnY0krSGx5U2kxSXk1MTdVRm5rakIvMVhrMEdxcG45?=
 =?utf-8?B?NGJMYmJpYXpsQ1kzd1hNbXNlcUozRWZuRzhFS1VzZFhETVYrTDRlTXF6ZjVv?=
 =?utf-8?B?YzYyVzA1aHVKelRUakRqaXRzWGxOMnFvYUhYejIrVzVYd1VEWmp2NmljZzIv?=
 =?utf-8?B?dTY0bXhSTU8zWnJaUzR6ZnFSaUlmdWhvTS95ZG4zWURtTWo5dHJBWk5NaUxu?=
 =?utf-8?B?RStnWlZYTld5bW1NM1hCV2VoNFFPNDdsUkRTMXR3OTNBb0hBUzRKaC8xVGE4?=
 =?utf-8?Q?D1fviQoG5FLHq9GZWXoIDPt76LDz4+PNA02qa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01c5472-e28c-470e-2fc8-08df3468712f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:25:29.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Qb2G9bAT1SNhIRH7la7l+765o74wtUjHXhS2JlA+qxNrTbpxGIDQm22pjtsZ7Lv1YA39vrNj2XXm/dqHLx58J3F3fAX1/Fcq1YqyhGP1rancgPEcFBMNAomtAOJiOH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408

From: Frank Li <Frank.Li@nxp.com>


On Tue, 13 Oct 2026 18:07:24 +0200, Sébastien Szymanski wrote:
> Commit f5d9aa79dfdf ("ARM: imx6q: remove clk-out fixup for the Atheros
> AR8031 and AR8035 PHYs") removed a PHY fixup that setted the clock.
> Make the Ethernet interface work again by doing as advised in the
> commit's log, set the clock in the device tree.

Applied to imx/dt-intend, will see in linux-next after v7.4-rc1,
thanks!

[1/1] ARM: dts: apf6: fix Ethernet support
      commit: b3839c6c5cee4f75229bc3805c43a2dfa51c4bca

Best regards,
--
Frank Li <Frank.Li@nxp.com>
