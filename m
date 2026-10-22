Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792638816;
	b=uzcY77hbC6OrAPmIxsFpOjVCEI7ag2xxYne8lIeB4W/H7mQknFdDp8lv/xRMDy8llmVu
	 x0+WwPqrz/hEfrkD6Enp92MHjFyEDprcM0oRuyvyM4dTnfvdGrz2iIaYycjiiU1fqul43
	 INQ0gauT3TZ9G7asQsEmQ9fsZwM1HQFmLGFM6PiPN5OpvIfs7Gg3PgOfRrO5Olq60rTxk
	 aku1COJMS0mMYhUjnQjM4XstglcjV6/mWtplyyZe4JsRmo+US5maYu/89V28T0qL3whkN
	 76QqxUq0lfVxXcPMeTpnBFKBTbXqYfPR29oNocDmnbs8p5cCDsAHDHKHePcXSS2ssuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638816;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
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
	bh=djEL+a+QsR91YUK3ZJhIstAWQU2KtbMmluB/ab/xOdE=;
	b=oIq5khXb4r+RKjJyQPvinNvfGLDBfBjMckil8a1KICqvcbJlGlQmyCC3X8ga5NCk1GNj
	 CWvJH1vAeQBJHORxhojDLZEKjda+JDwcYKzCcx7e2p2R+Zp/DrtVXbYvM/v3bRZjB9til
	 7q8NfUF989bc+Zp9ABqaVzcnnC6EWhYN8qiIyrCCxT2XyYwExlg5bTKZjya3abgi7Md9o
	 Q6Og/kUSh0YVm4eM1xhxu9Jqish8TJWbQo7Sq2r9RaxnCAQIeg8GpAoXW8EJzLTz54qC6
	 /VYpR9dloQqt4K7rUuwF9XZMpV0zs+ujPkecfrM3jDkBVWT+ph3ol5eYdXG9/lsal6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=C38opmUI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.58
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013058.outbound.protection.outlook.com [40.107.162.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3E606A31A;
	Thu, 22 Oct 2026 03:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D3E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=C38opmUI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adJb+2IaZ2x+4OsPquHK6JiLRLouVQiX5wz+ziD7diyoh/CS3qXzKQGmDnHydTUit+i/sL3BP+IZHv/y1koIHzIsCENxeAlPWmIdyL6Ed6AkT4+vO+qOe++fmhxiTUSNQl5ShkaKoTihlly1og+hsUTB+2AKgCqtZrWAXubkxiK4RhfiK65thCmt+T5NtXhNrMIOPRmWMp6ULZCgKXt7Eh4xhEYSuQcLgAG1tyidkF4VcgJ0DO/xJusmfCFoHX9wjudFJbwGPfA8pTONN+++i0aDkcRRa9vYxKVvz2mvu2QmAWEG6/1xo/JtjNHf2JDFi5iPpem8UrBjBy02dRGvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djEL+a+QsR91YUK3ZJhIstAWQU2KtbMmluB/ab/xOdE=;
 b=eP9wScJ5NV2QRSLfdcXCsI9POLGxtH5tBIWHJnswlsNDcZdh0OGRDhNGO9EKZ9yMgtSSM36LFFaoftl8ly5ANkdYXZIhP8naxkfaxU8OUQsdj96v0kgcr79G2JCQ/RJnw2H1SYg+GzOvpaMAevoHw7b1SXoIdBRduRa2aaY4jlrpOBaB2qbwHywCp72G1LIZ3K5g1tU5sv3MQw/6vhddnGCA9CSY4gXRByRvKyXnQts0AWb4eDce4JiiHbpA6G5mo7nzUeKcCdQNiOXswjXRYm1MSNdB5U2N6o4X24+PkcY6Z4yIXqvvcNMvXG7VliMXy1oX8YXZrqUOQgUDBgBbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djEL+a+QsR91YUK3ZJhIstAWQU2KtbMmluB/ab/xOdE=;
 b=C38opmUIjLHojNoWYj7/Y7fuCFLEzD1c+j8UfJa6XtjfdV+eweKtk6Jy0RKYnEDiEw9wGwg7+ZT9jycTOT7BSUkWZo2h6bMhMRjBAKlHOKvMPcE0OgapRUsYohCcHLRymkBwxddA1vI5Q89FSjME8Fp4HD7aaA3frTs4CgIT47cjozu3bJ53gFbIdAzblsPioSUBNwY5+bx5cF4F59Je8dw9oHQU0dJj4ruqow3Te5MB4vU4Oda+miakAMxITt/PxbvEz4RCsQgalRCOKXBpqppTgHrlieQTZN3HFI0zvvj8GIXqeKg762EeFkpGdI6MRzivGgelmiPVyKFzBeYobQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM0PR04MB11877.eurprd04.prod.outlook.com (2603:10a6:20b:6fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 03:13:33 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 03:13:32 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Subject: [PATCH 0/2] tty: serial: lpuart: keep RTS deasserted while the
 port is being configured
Date: Thu, 22 Oct 2026 11:15:53 +0800
Message-Id: <20261022-b4-lpuart_rts_fix-v1-0-207f91580dee@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOp/2WoC/x2MWwqAIBAAryL7nWAava4SIWVbLYTFahFEd0/6n
 IGZBwIyYYBWPMB4UaDdJ8gzAW4d/IKSpsSglS5zpbUcC7kd58DRcgx2pltWRhVN7dxYmQlSdzA
 m/T+7/n0/6IJRSGMAAAA=
X-Change-ID: 20261022-b4-lpuart_rts_fix-730498ccb73d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jingchang Lu <jingchang.lu@freescale.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792638983; l=1881;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=SREGxdvGSOP1WzgOcpJlms7Vc4dUiEc400T2szkyvuw=;
 b=0/JtrD1dBCL8KvgAXJj8e2mdWUT1sFFagkiaf+VmjN8v99NEFC9r8NghsgBr9TMXGOfamAYV/
 L4DF4v4WYe2B7btSbNfEgzhm/HAxxNshSd4G4QIr7NTAKucdPR77/qZ
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM0PR04MB11877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0173da-58f5-4fe7-c55d-08df2fea73df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|376014|1800799024|10067099003|261009221227099003|261009223027099003|261021123027099003|11063799006|56012099006|18002099003|261021121427099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bUEsgMuq8SYoiwpMDeabLiinig5UsS72AvE94SlOk6MCyI0rP/BvZYdHoOEgJofahgJZEmm0F4uynPEt3LASHllBLJQalAPpRhHQM0xTmFmXhfL05yr7BO9V7ZEzD9h7V6q7URtDOwcXJvBpw2gXM+ghlEs1YXdkMtQZhYbPL2yojdTLGFPEg1EOV8H1EOxvDoliY+ObQdwD84CkVH4lBrYcBmd5wnAubzJ+Ax2T3LJwSOJ3HUnpw1kpsgxAPJ/j64yFy4YkD6UCoTpcuMMz62UvT7uKItyl0H84zDhmvC2Qp2i6xuG+9bRZxAJJPlrPaXRLcjw4BpyhSOScRJPbK/V1JH1DO3dlnpzbAbHcQcosOO8tGmKPSSCXuG2kNtUhEyk2o2iqIlp7wdQhKl5ve3Yxf0nYRz8k4VKwbZTohFN7UppDpZgPLTS/v0dcw4q3tbq+8DwrN7vgZQSx/fZ/N6n66CMf2pcO45etcihP1UJzBV97QTBTvJOn9OdrOCH1m+mJk1YuCsOtqCHRjS089Uaghr0mM6t7XoQZxZPyApG+cZCLmPoNT5qYR/T1+lTX2+RX2kxRBugEyqjOH+J1GY6T+VJVFs7YLGAYbCkbqGK/1wsCpM9JX5DEigmfLRgw/FAI/+aspy0amNlanSdaT3vSOiVkfvkgBWdE2GNpK5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(376014)(1800799024)(10067099003)(261009221227099003)(261009223027099003)(261021123027099003)(11063799006)(56012099006)(18002099003)(261021121427099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVmSCtaSmU1c2ZiNjBSc3lsMVkwZ0cxajlxQ3hSdWZyYnZhakhOVkp3QmlQ?=
 =?utf-8?B?TG9DTnFMMDBEdUtWR1BkMW8wKytaeFkxMmpHZTlZUFJWaXNqaExFYXptZHZv?=
 =?utf-8?B?b0k5RjYwcko5SFE2OHlRQzV2bzBoaFZjdnJRUUwvTHJhTjNueWRjcUEvWEtz?=
 =?utf-8?B?dHZjU0p2akkrbXN5NGdwQUR2R1U5NldyZ1VUWm0rV1pHdG9uVnJvODdKQWRZ?=
 =?utf-8?B?TjUxNXc0NERJbCt3Z21oSnpGdzNPdkpnWVhQeFFHWllxV1FxQ1Fmdk8wVWFT?=
 =?utf-8?B?NG11NmtXSXhNTkNIK3RwYWY1TnB3NVFEMkRCZmM4YVV1YWFzQ1hkbzFqODFI?=
 =?utf-8?B?NVpZVmUzVTZVanNBaG5rYjNjdXA0emxRdUszYWtHYzRETEtmOWZMVk1McWJO?=
 =?utf-8?B?ZCtIeWhJcXNZRU9Gby80aXRaVE5OamFUMmc1QVRkMUx2UWZ3YmRFVWNRZ0tY?=
 =?utf-8?B?ald2eWFvRGE4Rkw3Tk92Qi9SUFVRVEw5VS9kVWdLZUFqcDZKcUlJNXk0OTlK?=
 =?utf-8?B?YjBHdkFyZUNzZDA4SFd4MmI4cXhDdkwzc2NCMVRaSUtYdlo3K1lLeUhRZ0o4?=
 =?utf-8?B?aVZxWmZkeXdRN2VQb0NyNTlJSWdCY2RGUGhTckVVeUtidnZ2dERKbkgvMmhr?=
 =?utf-8?B?TW53Y2gvWjBqMkcyM1F0aE1MeVlIdUtnWGdaZlNUNGgzZDJOMGJkUWw2emx6?=
 =?utf-8?B?c2c0RlZKZVBaTUVKb1dqWkJaNkZoNVVONlJLb3RWWjE1S1lXRElCSm1pbGZU?=
 =?utf-8?B?UUxZUzdvaTlMMjRkaGNXWkVNTVNYUDA1SDFlckZ5Vit3WS9lS3NuRS9nMGUr?=
 =?utf-8?B?Sm5BUHRBN2ZUOWNqQmp1VTBJbjZIdm85OG5Rb0M2V3RTMnNmRFBINWZFQWZM?=
 =?utf-8?B?SFZpS2tHVXkyZDhXREpLOElYcFFDSjBnRHdKaU1uUWZrZGZxcFcydk5QTUox?=
 =?utf-8?B?VG1EK2NqanZIdnpNbG55elhPRlBOekNzcVJac3RmQ0o1TWdpNjVINWxKMDlq?=
 =?utf-8?B?SWtYTGpOb24yWnNtQmUrL0YzWnFuNDVUMmF5NHpacXJ3ZnJ3aHd5d1cxUFNH?=
 =?utf-8?B?Nm52Z21MZFpFTzc2N0lLZFpzWkZHMDVxTUkvT3N0cis0cXFFWmE1MUlKc1VE?=
 =?utf-8?B?dnBnbG9SK2xsSmEwY3RtdjcwdE5nQm5TSjlXVS9nSUJZRlZyZkdVTmVnTzli?=
 =?utf-8?B?dU9hMVhZZ1RnVTFNVlNjSlZRSVAvaTlDOWxZVHBuempJNllnUmk1L3duZ3Q2?=
 =?utf-8?B?enovVmo2OHRpM0l6ODN4RHVBQjRHSG4rZEc4a1VibEI3czhpbEg0eDRUWVBB?=
 =?utf-8?B?dHFUcjRObWNHRUEwVy9SVDR0UGlpZnZEK0dqK3U2OTZxVWFsKzYrTjRpTUxk?=
 =?utf-8?B?d25yOUN1MEFmamVsdktDTG8xeTB6S2RoRXBxUjdoQzdwM1ZlcFlFdmt6ZFUy?=
 =?utf-8?B?U1NNbTZDUkpDeUhUOXJXSHV5RzRwbC8zeXdRZVNnckljbHVSNTNjTmRmRFhv?=
 =?utf-8?B?OCs4R2k2MDJhS3llR1NIRXpQNDJCR1pHcHFLNzgxUkJkc2hkV2hRSE9acWt1?=
 =?utf-8?B?TWxWd2RlbktLU3VsMHlKc1k1aUhxajNrV0xXZW5KdGlNbG8yRDBiaTY2Q2lJ?=
 =?utf-8?B?YUUxY3NBL2NsM2dueVZib3l4Q2ZjcENqOVQ2RnJYakJGN3A1YS9qV3B1akc3?=
 =?utf-8?B?Um9OL1o5Sms4eVBobWozQ0M0SHpnT1dIZnpIQWQwWDIwVEg0dnE4Wjk2cmNa?=
 =?utf-8?B?Y0FiWURKMmRLUHhNdXNIVmdxM3lJZFBBYU5qNHdXa0NSUTRUeTlQWjRQYzcz?=
 =?utf-8?B?QVVBTDAvaS8yaEJwZTBKZUhYR2hQeW1mSHppNkNXaE4zS0pkTVBkTko0R21v?=
 =?utf-8?B?b2VZTDJkaC80OUtNSkhZeVdsSHd1ZG1UNmpMWndqdHc3QUllWG5KNFRCUXBy?=
 =?utf-8?B?VkRzK0ZhY2JMVWo3cVVORzN2bkQ0Q0c5V1RwSjRHckpubU0xOHNKUWdlNDFs?=
 =?utf-8?B?MjJjS1FEUVBIZzVrcTYwWEk4M0RLb0NCUmYwN3NXT1hzZHIvZkNndXVDRXBE?=
 =?utf-8?B?WW9vdVRSd2w4MkxNd3YvY1hiN0V6ZUpFTzhFcG9zbEM0MmxIUUFLU1JlWXlB?=
 =?utf-8?B?TzFMUnBxQzRnazQvSGlQbTBNYVVUODFZQktzaWdhQXhKbCtQZjQwdjlrdWYy?=
 =?utf-8?B?WGhJQ2VzelJFemk0T0lTZ21pYldKY0Rab1lxNHNuTlpFOXB2eGdGNjJRT3M4?=
 =?utf-8?B?NUJ0SkR4QVN3NzlWaFMySy9VTkRWWi9jclFzQ0o4OXZjZFRYMEloOXRXbjBO?=
 =?utf-8?B?VTdDYUlhMTlSeXYxV1FDYW1ySVdTaVUrTllaZ2liZXBFRjhGQ2hHbmowUFZn?=
 =?utf-8?Q?atw/LKn5lFY0+ffL1843Iu4Up1CSFsE9PH1NX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0173da-58f5-4fe7-c55d-08df2fea73df
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 03:13:32.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atI6UBMyDhtuRsrr894tIG9cAp1fdd5agmjWO6KmDVDM2sk5GlWouYnqNaX0FyHjM9bbAMIRECkmvV/RcG8kzA+dcHvWGA9JNhlwNoowIHMseAonGBWPz/aQdjV2u3VX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11877

When hardware flow control is enabled, the RXRTSE bit in UARTMODIR makes
RTS follow the receiver FIFO level as long as the receiver is enabled.
In the lpuart32 code there are still two windows where RXRTSE is set
while the receiver is enabled but the port is not fully configured yet.
In both cases RTS can be asserted, so the remote side may keep sending,
or start sending, right before set_termios() disables the receiver and
reprograms the baud rate. The characters in flight are then lost or
corrupted, and a short RTS pulse can be observed on the line.

Patch 1 fixes set_termios(). Since commit e98ab45ec518 ("tty: serial:
lpuart: only disable CTS instead of overwriting the whole UARTMODIR
register"), the UARTMODIR write before waiting for transmission complete
only masks TXCTSE, so RXRTSE stays set, or is even newly set when
CRTSCTS is requested, while the receiver is still enabled. Mask RXRTSE
in that write as well; the final UARTMODIR write still restores the
flow control setting requested by termios.

Patch 2 fixes startup(). RXRTSE/TXCTSE keep their value from the
previous session, and lpuart32_startup() enables the receiver before
set_termios() is called, so RTS is asserted immediately on open and on
resume. Clear both bits at the beginning of lpuart32_startup() and leave
the flow control configuration to set_termios().

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Sherry Sun (2):
      tty: serial: lpuart: deassert RTS while reconfiguring in set_termios()
      tty: serial: lpuart: disable hardware flow control in lpuart32_startup()

 drivers/tty/serial/fsl_lpuart.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20261022-b4-lpuart_rts_fix-730498ccb73d

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

