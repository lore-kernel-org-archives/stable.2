Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7B579828;
	Wed, 23 Sep 2026 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193997; cv=fail; b=WhJSWGf11lCPbPuGfM3CSbBbDXBXA1g5mXwhGMilCK4xyC+1H+AsxJrOtYtaY565Ln4LSQ+tvm8OTUVOwF7Ve2DVEgAbG1S5URYL4aqINzfhfYriCFCg3AD/1Mg0xVC82MeAjrL578a+nJiXNIebATcWFj5GQSW31XcXEcfANgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193997; c=relaxed/simple;
	bh=8n2VBazTXVXH3xIGZ+G+y6ptoM24/16SAuBGvfi2Hh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8f1nftdQaI2sO9R3c4D95m9fnLfk1c8ocmH7LRNYhASLA8xJIXDa+bbHjcsR0Tfy3md3Ae9lMknX4sY+QW3wI1GG5PnTMDQGvqSJTcyD8LfIViIbzlF4+zjflmM01QGkMmp9XpEj7bRZT6fJzI/XLQQfWhwF3zuUgi85BxHBMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T42ODCfP; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T42ODCfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1W/13/ek3bPyJw/3Riv3lWpPFjL1wgukvVxtgykHiOQiNwJKZxOlH+w2sHK1XULUPg2sXdCRut+8BjdtZFS+UYUsl7tmXcRpBcLvwIzNnHzEz3j49LercsWDXgsyb3vnCF5WW3+yCVKSmMdlS7oM7xBiHbvuNYh8P681wPKCkRN4OBbPFtd6pheiIs0qm3B+64tXwTYlMwVv/oAVBkCP01oGPA/vcPg2t6h9LQ+DReRyCzgcphxB3+YG4MIVeCQix8csrKP8b6X8qfIFeKeJYEZ87ZdOiydXN4blswpZcdUoIHnDVyU5MKZJQOp9lvy+YaHtp9/X0aq5gf0n9guTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eZDrdAGxFxQ/Gbi5B6A4H47ftvNX3N4alF51KxrXKg=;
 b=dlk+Y5KsFpxSfl7kgCVBn0iGsJBmdHmF/8adVl1HQN1+Ns+8Ng2Rih/dK8jN3QBdLMNO0ArhtekNkbfBZARGsdmcKspqZL1YMHMpNYcQbb7i1hZFIT5wmNr/BqZzRuK1WoBeK0hDDc33xbPyhs2pUA+9HgalTAv4hP7rfQHfj0vIHGFkTuQqVuM2mJMHyxLfFi7xHz1oIPQmAsZEuADWyde3oeAGlfVQBzapGQPDCH8VizzdN7Q5vBca/9NKflHwSAJ1EN/W2TJkeXZV2WdJ+qPK2bhacYtr8pKKaFz2vg958DBzQpXvf+t/tzsxZwEzgmcusH4TcSFsqHmHaX/WWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eZDrdAGxFxQ/Gbi5B6A4H47ftvNX3N4alF51KxrXKg=;
 b=T42ODCfPXroFHrxI8O4BgATFykQ8OZUIqa8obQVZlZaIBEH3I2znU1Mf1SqX/wwQA5KGViYsk/yHEQGvj2ohoQmztXcgIJo4YFNXu7HEJFfbUUbqOhXVvmgkho/bE+MmZphA0pB19AJaeaGxt/9ldBVSWMG3eQRjjDlYJl29dqrubyWW+SI9QrVomFXQG3mJCdauL31GY9onntga3OsVkTHQCcpXEHvTrY8ZZq/AqSQjkUrE4bI5ThloJor3CGH2sFildelI4jG5+cvzK9+OwE2u9gBS56n1alVct42/yEv1z0crCjYFUiFeyN8lWnQlNBRioVft61BsxFOwNZgDjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU7PR04MB11089.eurprd04.prod.outlook.com (2603:10a6:10:5b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 20:06:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 20:06:31 +0000
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
Subject: Re: [PATCH v1] arm64: dts: freescale: imx95-toradex-smarc: enable Wi-Fi SD interface
Date: Wed, 23 Sep 2026 16:06:22 -0400
Message-ID: <179019397478.3738924.8779081389570740062.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914175027.9097-1-francesco@dolcini.it>
References: <20260914175027.9097-1-francesco@dolcini.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF000132F9.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2a) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU7PR04MB11089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc485e3-aa29-494f-e48d-08df19ae28e0
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|19092799006|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KvQYsAeXhIWyweFljZmHizyhl2EF4yz9mpZrRQpuEN60NzGU5aJBua94P9b9N/mvB0KYPLP/yKTiD/z5pq/gVjpnnMLJbdmr26pAvRGdBwWAebkuhNrAf9TcmBOBua7uaILtx+fOqtSzOjbPWe/qiEgUr6wkbxMFiMvyvN+k8y8nVyCHzp93UBq3yqCPBsivN6tlIR1urTuXRTaCu356pe4UKCP/0tQGfwGfdKe/t8C0VMaPOaYrsjRTmePNF5H8YXuCm03SkocEOAjOICXW6xmuaGpC+C5PCiUOUyNw+JJNJdnFVVOlIFtRfAg5cjxteW7VNZvmSjPYNBRxLK8V4QeltoisPgL9Q+3g32T2Hj1zMrWGiXb6yvCXXuvsUHg9bPEr6kmpORWqzLr3bJxNbdC1iDzh5Haa3lnW8kQqulPbJAKP0YluRpxOj3OTiT+64ZuLd1XS3JIARduckzg+BZiEa/xZOw9OUKpMmoKxnSArwF3MkDkIKBuXF9/ATAa2lGdzDXl98rYQH79rmvQtjCOutEOCOjrtQnIENOPLjN3om4zi4CAcX+bFj98dMQNs3TvZ6O/39f2lhmoMIhMYIcBrglphTQgKuD6i8YvdLaZndjf85c68obYNUBO5RgK82ud3qhsJlzF+LmmCImjc4DVl8CuNXvSoGujC3DNvrIQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(19092799006)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U212Sno0SDIyOGt6c3NyK3pZTW5XekNRNjRzNk1oRTBSSjFCNEVxSllJby93?=
 =?utf-8?B?Y2pqMjUySWRWMkYxZjcxZVpjbFpxNGUvbUM5MDQ5bUJvY3hyRVcrZVhQLzlm?=
 =?utf-8?B?U3h3aWtVTTVDQ1JUUit4dVJGVnY3ajNDZG4vVG5zcWt2dFBsd2F6cHh2MjZJ?=
 =?utf-8?B?T1J4UUNoM3JHTUQzZjJJWm54VEVmQ3RzOXRpWFU2dlF3RlYwVk1QY1pwd0ho?=
 =?utf-8?B?a2pZNkpCMEhWd01RalNjbHQ3TlM4YUVMaWJ3QUlJQXVYMVNOWG05T3laOGV5?=
 =?utf-8?B?bndGQkpwRFg3bk41MjRadFBIeE9DdGpkSjV0S01RVVV1S3B1djRmWklvZHNC?=
 =?utf-8?B?WnpYajJTc3h4ckk3Sy9KSFN3dlgxUmx5cU1TczN0a2hhZWY0TWVVUmlIRmNQ?=
 =?utf-8?B?NVZtRFBWc0NrU3dQSlhSR1FQRzRBWDNITVA4UnA2Zm5iazErTkFpVHhBTmto?=
 =?utf-8?B?dmxCdjJETzJxVVhVWmRCTzlLZHZhTDk1NitUWXhrZzhESVJKb0wySnhIM0ll?=
 =?utf-8?B?VWR4R25zTFd6Q1c2K1FSaVJzS2xiUzA4cXFTUjZDaXQxc2xyMUc1eG5JV1Jy?=
 =?utf-8?B?dHRyUXYzSVZnWXhCZExZSlp4Nk1Ba1FqNTBEVzlUc1FEOXhLSklwTHhJUFRq?=
 =?utf-8?B?M0NjR0tkcmdIN2FTTE9WeTdkaEVhMWhqcFpTYmxxaHNkYUlHcTdKaDJLMms0?=
 =?utf-8?B?SFdUUkZEcjE5MkQ4VWExa0lJU2dWSDhUNHZIUFFxQjk1akhnV0psOGYyQitT?=
 =?utf-8?B?VVMyMUJvZWhIK2dBbVdEZm1sM2F5V1lNR3h4YzRoUU1LeXF5Q0RlYmloempM?=
 =?utf-8?B?dHYwMm1XVGJxR2JTQWtUUDBkSWlmbGxBajNnYUdIZFVCdXdhTmVUaDFXR2Qz?=
 =?utf-8?B?R2RkdVViMlFNc3JPbUYvNmQwZlp1SnVrZHR5a1ZVV2kvWWZpZVhiT3NSdTVy?=
 =?utf-8?B?dWNXUmEvY1dKeVNQcWNSU2FvcVJCclFtY3BHNjJlTXZ4bWVuSCtMdmtPVGxu?=
 =?utf-8?B?RkxzbEEyeG5mWVdOYnRDMExSRXE4Z0RmZmJEZ2xkb3d2ZFZRa0RvSG4zZFpr?=
 =?utf-8?B?K1Q0T2UxWEh4WWRHd1FmSWFEc21GdEp2cW04ZHd1dkNJV1hQbnZZZmdvelZi?=
 =?utf-8?B?aVhnL2QrVEJUa2hNOHdDdzZlR3dzWnNDSVNvSytLdFVUMG5wMEJ3cnVXcWI4?=
 =?utf-8?B?b2NjMmdHNGV3MWNrd0VZSnFSUzcvMXhOQnpCUXRNVGI3SXdEOEVndWVwYzZj?=
 =?utf-8?B?TVdQNURGMmk2cDNsZElyenZpNkpIMUpqdUNmK1haUkJMdTdQNmhCMmowZlBD?=
 =?utf-8?B?N1JMR05vSmpNY1czbVgrVGQzRkI5U3B1QUZ0UnluZG9jK2w2QzVPUHZsbzZm?=
 =?utf-8?B?eGFyQ1B6QUpudFRza0o5THNCRGpXTEZNVDFMUjJqcWk1QnRXRXR1NXFXakha?=
 =?utf-8?B?WEdaRG9QekRiTXdCMUJjdGtEUUxRRGcyMFViYUZPRE81QVpjSjRaSy9UOWRI?=
 =?utf-8?B?NHB4UFpoc3pXcWhNKzZlUzRqaHdMYk1yTmhtV1JCVEkveFFnY0hpZTdIRnY3?=
 =?utf-8?B?cmVhMTRQR1owT0VRYjZhMUZXL2xNUzBCcFAwbk1TVzNiM2lPNXdnQWdnT3lw?=
 =?utf-8?B?eXhKVi9IejNFd2pLanBlWkEzUkdOOVVFR2lsQWpoT2t0UUNPVEJqcmRNaFY0?=
 =?utf-8?B?a0JsdDVvYWg3ZzBrd2N0V1hGd2hiS1djZUZSaE5xMzYwR0FsTWg3bTZkN0Qr?=
 =?utf-8?B?QUFsMUEzZmdPeXJkeGJ1Q09pSmt6azRFdi84dmVOSzdKczRUTk5rUm9GZUFM?=
 =?utf-8?B?MTh6ZEpFMFNqNzBzdlhFTFA5SHVIQTBzWXR1TlBNNDYrMDZWQW5mZ2c1Mnlu?=
 =?utf-8?B?b3JpWWQxcGJUYmgwazhPWktkWXV1MGdPbDk1ckpwSmd2YWR6TmZIK0ZKS255?=
 =?utf-8?B?TzVuMy9iQVhaY0tLMmVLTTB0WG5BWkJCK3I3MjRCYlVxS2ZieFk3UFFlalJW?=
 =?utf-8?B?RnkrcFQvVWVnNXNDNks5bXBVbk9oKzNGR2poTDhBd1E4dGdhYVJldXBmU29u?=
 =?utf-8?B?clNBNTN0WWsxR1lOZzlCT05OZHAwcjFmZmRtL044M3gzajVacjJ1NEFza0Qw?=
 =?utf-8?B?UGFpQjBLSzBBbmk1dHk0SHhTSlRXM3M5bWFZUHJJQjgvYUxTNi9PS3luQitI?=
 =?utf-8?B?WHZVZ2FLWDFublR5YXNpZFBjTlNmWjBsR2orM2tLSFh0WGNyWXM1UXBESVkz?=
 =?utf-8?B?Vk1Oeit6enJoRVFBcHNoTTk4TDZNSTJIZUhKQjZ0TnZrbWJScGU2MXdkcEEx?=
 =?utf-8?B?OVRCc09FVS9BQ1hnYVREK3Q0TEEybEhoVS9qRzFQeDA2aGV0a3luSXh3a3RO?=
 =?utf-8?Q?sycB1UxKnWZwBZE8R+FSPfyhFmGdyQqBaBg96?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc485e3-aa29-494f-e48d-08df19ae28e0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 20:06:31.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl/NT8w+y/ag2SC09mree2em3q97c0OYvyUDJ7sqSTj4z5CVQk/PbyRIIyqNPp0DmTjurule19eFt9IyKZcLlpN0DA6+UFrdeDOj0Um7lOn3hIW10WVdLOiZg3SHNPjT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11089

From: Frank Li <Frank.Li@nxp.com>


On Mon, 14 Sep 2026 19:50:26 +0200, Francesco Dolcini wrote:
> Enable usdhc3, used for the on-module u-blox MAYA-W260 Wi-Fi/BT module,
> it was left disabled by mistake in the initial commit.

Applied, thanks!

[1/1] arm64: dts: freescale: imx95-toradex-smarc: enable Wi-Fi SD interface
      commit: b91cb164517d6cfbccd8bedad11827d8ea3bcb97

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
