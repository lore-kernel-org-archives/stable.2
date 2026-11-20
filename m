Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795160033;
	b=2GLD1N7yhqjhqwQ1GwXYEhxTivAEMsgIAuNYxLeeDzoShqzH+ufSYPee/Mn+xkgm/647
	 n/AVG3OVfdlcMCl6VY/N21HfkfEinTPuDja7TpjYtewAGpTUquqI7ZjQSURNuxWtBFG+V
	 JGyeh4hcexGl0BtSVJevydTH2XUtAK8BAV1kBdpPOxVsolwajnQHUXKih1Bgx7TQq4uad
	 LA8ml7lhHtMNs0L3mehcx7sHbd/1aAxxT+DbLFaUpzc/N+1Gqvp2gEwVyZw8+cTASOOGY
	 LQ2erRWoK4Kf4lvBanCp0qQokCeGP7thRs6xAbXlL55xU6BLQh+kITUHT1fsk0i0FFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160033;
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
	bh=+h6LugcntSdWBh8T8fRdTZlAgbGfKAnsR8OnrD3E/pc=;
	b=3LzuQNo50E+9JiOQCLGrvoRpU+AqxWPZ9LXGQEVBJqrAFT8DwLjcvazrzrJ7HoUY7xpG
	 FZOw8SgvreD7SwklYlp0gBGFjo6PNPaYfA80zeZhnPhfxpGI0QrCU/liw+MHiYvf+CmMn
	 VnI81M1dAH8CtMOQcawnZrIpku9pm5pMzXgUSk3WYQkbHIAB+w+fLE2JB8j2sLa6GoML+
	 ZUrQUMUYrQ7/M5OlbD4Ja5MZGb6b1MzkDoJgtIXA8Nb96nMgRdR5iuhuIoz7UrhWp2J5p
	 70oOYGkEoY7ue22U6mvGm44tDSeoeScjmyo4DOoD2841p30OqTKjXQ3OqbLPaht925Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=xuTeFO62;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.108
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023108.outbound.protection.outlook.com [52.101.83.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D6606A331;
	Fri, 20 Nov 2026 07:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270D6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=xuTeFO62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHRzDDWACw+Lbj7jhUXwv0c9cAOjjIGAbYZXIJYcFzR2vVjPyARER0cFCfJ5ft3ZReqd+vMZAIIpH77E/Jmb5aj7vox/VqinZHkYDFS9pu8Sa7BriokYCH/hE6chUkB9opoyfmkHuWrhO1dcGmZ2c8co6RakqE0u2l+RcXIau/FluY10b3YE8/+pt1Lp909KGGEqaq5hOF+FCpm69ZbZz6c2rVA34aUYB/yKaAZ+SI6nV0WqATc+bcZTAey0Ac5VfsALSKH/CUk6fwuXygfsmNYy0P5ChrSRjYgmMWpcHZBJKd/H1qny9VeNDyeyhByaRKyQJi2Wrsz6mtVlRjBdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h6LugcntSdWBh8T8fRdTZlAgbGfKAnsR8OnrD3E/pc=;
 b=J1bMJaLgqt/KJKPoRX1jocN6EpF98AUyalezDjKi/VlcKE6b5yHKOlk9cFdcl3BBIsnvtBHDS0whALhQ09z7W7ogsoXhKX/fXdGo/6Aqia3/NynNL7+DVbWfkfmnFrc8WDbqoZnoCyrUB8GQtOWFsph6RXzi92VefIi0n6LEyp4JI/mC2WEWzDI5afahfV3D2a3Ja/6z459sZ5I9effUs3yV5NM/g8GmbwPkRHtkVteiKhTiCcmfrGXaVj8RQFku/7gqi7Rz5pk+7KPnif3GsH5UPBDm6UHx41JWxcPTBVbm3wy61nabr5rl7pfkCxF/wFm5K1vkm+e5wl/KfihAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h6LugcntSdWBh8T8fRdTZlAgbGfKAnsR8OnrD3E/pc=;
 b=xuTeFO62ff8IeYFBX1DSr1fK+nZEVHJJZTFUoSjJttOnagO+gIc955LGNX3YmWPR+/P8YE3jsL3vI60b6vq/qeF/04lX5ZhrT2WHn6eOeoB62RGsrdJ/+3bWl3QUci5xmtl/hlnwaxyn/5gfbxQcKatEVGA4rUzLXS++W1vGQN1jsEL9hftvXfj134S6ZgFAsl92eFDl/oxFSRXr24ff/eleQpCK3VWYDMKwu2eWRITzWOGsAJBz7CD5kjOLdjwQ0nSCI3yuLLpUMm17LdBmdEygscI2mmyA+lwK7BNJrqnuX1a4sU0cCw9g3D8Oov/+CmMAnG2ltFmEVXhFw3Gq+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS1PR06MB8539.eurprd06.prod.outlook.com (2603:10a6:20b:4dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 07:33:45 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 07:33:40 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Fri, 20 Nov 2026 07:33:30 +0000
Subject: [PATCH 1/3] serial: max310x: fix use-after-free on remove
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-max310x-teardown-fixes-v1-1-eb52c8b612df@vaisala.com>
References: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
In-Reply-To: <20261120-max310x-teardown-fixes-v1-0-eb52c8b612df@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795160018; l=4930;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=m2Q4DsH2AG7s3QjV69s4MH0gQwY+juJ2GNylRAESzy0=;
 b=7gpLTG6Hl8kxA68z3NyuIS3jX+8U1Z5XEVGeVXc/SfX8AsMxDaMIdCEChHbSWu4yhlviKI0kZ
 EAYPRA+1iBoB6CFmxXFPP+8b1W3SF9DYmpjM9y3doRKqGg2jJP4ZpDs
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS1PR06MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bee9259-aa26-46a0-49ec-08df46d898e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|23010399003|10067099003|11063799006|5023799004|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026140227099003|261102123227099003|261028144727099003|261026121527099003|56012099006|18002099003|22082099003|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	iKYEfN3a5wJJ8wJhd9TgRVf9g/O/bRDaaYXLnuQY5o0QCPW4CQ+1Jl319ww3W+K8RISzOODqNADdOqHHVga6uZ9U+mcm+u8fO+QpJJv2BMq/apo8hF6OGCsGczxs1cJAGeNBGYlRotbDq3yyMCF5QQaagN3eK4FCANi3IjyW8fZo6M3BAoAZ5inVgzpf8Dxhl8gjUHBmBf8bmBF9vwKEivTPgs1cDr/zI88MPQypH4GKI6RsQNFlvBl9BeEZsycYYFuiiZwgw5B9fy2s6/RAwSh8WMKr598QF5ruQKDDqXorfYs8kjuEPPb5eMCq1WJq2nPdv6x9HmhL631d+XOw6z6KPQSV1K7QlOYG/niYw1LQLkVUJI3EJ8c0t5NviEBYFCiX0UAMIWUgkUZVPSmZYte2XFxqAnwaIwoNrxpKWU7JyfJFdO73qhp7vI8EsA1Kr881Sb496oUKoyPwwNrf6hztG4gp4HPI6ddXY5pxj5CRQK6EY9HfLCYEXYrqIqxr7lTvmwk7P7H9vmSLyqCqSfxUbkfEA7KKH6eJJks5xTBXjaxZiTkYlWGPnb/GZZTsGA601mtFr0QkSYcApZSL/rpC8vH8cdAR/9ZQg+7v7KEgmwNO13xpHDeZhy6jQbyJVSj6HKl15hsbQNmeHAvvs2zD2PiRw6aqztHkBiO6pA/14kEmQeLoxF2OSE3h7ThCby2nVQfQ4E8kQ32ShI7fwWXuEJnMynN3EGNM1+3EUTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026140227099003)(261102123227099003)(261028144727099003)(261026121527099003)(56012099006)(18002099003)(22082099003)(38350700014)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUszbmFGSU9ZZVl5ZXc1eEpiaFY3K1BqZmVrclpUaTBDaS84Z2ViTDRoSkwz?=
 =?utf-8?B?emhCb0ZhaTNLN2RTM0ZJQlJvclNKZDlkOEFPRjRUT1VYK05ycndWYitpeTNG?=
 =?utf-8?B?Qi9kbFZhR0srbmd6dm1acnRHckRFQ3lMSUw4UEJSK1B6RC85eXdJU1FpNjJ4?=
 =?utf-8?B?bXNLQVFTeC84d05FT0pqRmJ0L2FEcGpBUGZjYzMvRnRXZHhrSEdTVWk3b1po?=
 =?utf-8?B?Y0t4Y2ZSZUlpaVhEQ293RGwvRzZzaHNyVnRHdVJ1NmlaODI3L3IvRE43Mnpr?=
 =?utf-8?B?a2pEYkg2akQ0KzNLOVRwVUhNNGtqSUd4R20yMGEwQWVXellkYkVWcW1sTHlF?=
 =?utf-8?B?OU4vMjlXMTBQU1QxWWVSemp5SVZZS1UvZFU3WW1Ldk5WRDJvbzNmWXlEM24x?=
 =?utf-8?B?Q0dMaU9XdHNmamNzV3RlNXpHbWQ3WUhSZUpobjhLNEFhQVVLZTcvMDl1WEt1?=
 =?utf-8?B?QzhSQ1hINm5CUGd4VHJydW1RT1M3REhvbldOT2pzR2xoSVRQYW5rTnZmbGlN?=
 =?utf-8?B?b1UzUlMwQmVYY1VORlQ2TURCNllkM2tkQ2Q4ZVhvdlkzcG1TeUZqcmFVeW9p?=
 =?utf-8?B?TVY4elB1TXNFOFRMQzZ3MGNQazU3SGlUNUhBREVZWkNLdjBDaTNQd1NBeC9T?=
 =?utf-8?B?Q2dMMno3V3c5a21NTyswSndCRmdQb3dFWmFDUWFWUE5XMzNFOHJVYk1LblA5?=
 =?utf-8?B?ZUpaZExHNVFIRm1wTjA0SzhQKzZsc2RPRVd2Q3duNEMxQVNKRXlWellwcjRq?=
 =?utf-8?B?UkFwSUVPbDk3eUthZ2U5bWpxWDdtRzJwWDNmY3lQdHFBWVlPZDYzYSs2N2RW?=
 =?utf-8?B?SjZWeXM5V2JMbDN5ekFKSEpvVUR1RjBNb2w0bWhWeE9kSi91d0FWbGVocVpp?=
 =?utf-8?B?Q21WM05TZk04c0wrYW8zdmdEc1VIRGVnU3pTTmdIU0RwR2ZaZDRmQ3NzOXFq?=
 =?utf-8?B?dGdlcVowS3lwaC9sS3hrRXcxUzhOMERtTktVeU5WYTRZdmlXL1ZPSWpVRlFG?=
 =?utf-8?B?dVQyRlIwNUI1aUs1TmwwbG55ZmlBdm9LMzkydkFySkRLejhiNWlzVG1oUVJr?=
 =?utf-8?B?TkdxbzdYeTNGWDcyZHdNQ2swaHl6b2xSTGllUSt0YkVYZUNTeURUK1k0Ukl0?=
 =?utf-8?B?dXNqQUxWTFhaT3NZczZmektpUUFjUHo1MllpanJ4RWtaTlNESm1UeW1Qem5k?=
 =?utf-8?B?ZGV5dUJoS2RaM1BVLzhwLzEySEk4NWxrQmtkdC9CY0gzcjZIM1J0Y2tYSm9a?=
 =?utf-8?B?SmR0MzBoZWx6K2ZITWRsMGZxWjZHYUx5b1pub1JZQmxmaDNZTmQ1c1dlM1Bx?=
 =?utf-8?B?cVB2dGZUQWNWZVNydUk5Y1FZdGw2YmlDTzVkT05LYWJCRnBGMFN5WGdSZzBl?=
 =?utf-8?B?NTVwYmZLdU1JbjNUS0kvbGkwVSthNkx2dEc1NEdZSGZQNElZNGYyakltZTZB?=
 =?utf-8?B?ZUJWQzlKZzRNUlBiWWxGR3VVWlJuV0pRQ1NJUTZKTU9Ga2MxTmhQT3lvS2Ny?=
 =?utf-8?B?dFEvR01YWW5wcEhZT2hMaklVbngxTFdBR2VpbnY1RjI1TFhxL1dyM2JHU3Zk?=
 =?utf-8?B?SGpjc0xQc0ZBbE9QNVgzL2RVMEJuSGFodkRqeVJydk51a3gxY1BhcjhIWS8v?=
 =?utf-8?B?cEhvaGJnZWNvYlo0Qm0xVnBEMFhaK2x6a3VucTRZaFFqMVpadVFOVmJYRUZr?=
 =?utf-8?B?NmhvNHFSTk4xaDJFSDlVNFAyWEJ5cWtpaVRGVVorRVV6VGpPaEwzVnU0N1Ri?=
 =?utf-8?B?U3ZHS2xzK0s0RnVicjJwZXhOYVQvNnAvVTkyb00zT1JiWnd3SVdvSjBhdkVm?=
 =?utf-8?B?UXZtNG5GektUYVZLZFVGUU8vblhSb2NLTE9udTZwNUo5Yy85U28zZzl4ZCtz?=
 =?utf-8?B?Mjd4L3M4NUl1RUNQTXNsNTFzQkFKL0FoVFRkWGlTdG5rRjY5REtvMmVzeGtM?=
 =?utf-8?B?SHB3d1FHZXlUU3BiYXhISEJkeC9IR3VIc3QzZWdIKzlpWFQyNFZsM1ZzS1lV?=
 =?utf-8?B?UGNrc1E3YlpWRE05blFVcWNMN0NoZTZxSGFRMWZDQ1FUc1ZYY0IvdjQwbmJS?=
 =?utf-8?B?NFVUYnRRVURkSzBkNU9pWXlvWGtkMGRoVVFGL0ltaExJN0YyRVFKSE13OHJZ?=
 =?utf-8?B?aWw5eFA3a2JaS3lLUDVzWFZyWVgyck14bHcrd0tBa0lJMUhjbTUwbGdLZWdW?=
 =?utf-8?B?MmU2S0R3emNGdlpGWVpCam5SSHJWQUdiWGs1WGNyWlo4Z2IrRGRSbFM1QUpI?=
 =?utf-8?B?TW9IeGl2TmJsNTRJbUVsbVFkbWVWbHVNd1NQa0dxZjJQbHlXTzRNQmtXeisr?=
 =?utf-8?B?RHMzbFFPRjNjTkpQMVQ0N01lVjZCME1EeGJPSlVBOHROSm1VT3dSVjk4VlFK?=
 =?utf-8?Q?NA/IaHGcodeOaRr8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bee9259-aa26-46a0-49ec-08df46d898e0
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 07:33:40.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbvzFc4nmuOUu8G4rQw07qwba9qeY/EtmEE/9hcowaU8sIIhGjenHyaBrM/1e4++iB4G+w6MFsWUBDkE2uyynT4K9HLLjSan3FnJjfbI8VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR06MB8539

max310x_remove() cancels a port's timer and work items first and
unregisters the port afterwards. Until uart_remove_one_port() has shut
the port down, an open port keeps queuing its tx_work from the
interrupt handler and from start_tx(), and the RS485 code re-arms the
delay timer and rts_work from those, so a work item or the timer can
still run after the cancels, on a port that is being torn down, and
fire after the port memory has been freed.

The unregister itself queues work too: the hangup it triggers clears
DTR and RTS through set_mctrl(), which schedules md_work, so a cancel
done before uart_remove_one_port() cannot cover it. Tested with the
port memory zeroed on free, md_work ran after the unbind on the freed
port and oopsed in max310x_md_proc().

The interrupt handler is a source of its own. The IRQ enable bits
only gate the pin, the status bits stay latched regardless, so on the
single-port parts, where the handler reads the port status on every
event of the shared line, a status bit left behind by shutdown() can
still queue tx_work after the cancels. With the IRQ managed by devres
it was released only after remove() had returned.

Similar to commit 36672c8d7d14 ("serial: amba-pl011: cancel RS485
hrtimers after freeing IRQ"), stop the sources before the cancels:
unregister the ports, so that the shutdown() this triggers stops the
TX path, then free the IRQ, then cancel the timers and work items. The
IRQ goes second because the handler loops while a port has status or
RX data pending and free_irq() waits for it: freed with the ports
still open under traffic, the unbind blocked until the traffic paused.
Keep the two per-port steps in helpers; the probe error path needs
them too, with no IRQ handling since the request is probe's last step.

Fixes: 10d8b34a4217 ("serial: max310x: Driver rework")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0ed70185555eed745d905b36c8b8f162468dd6f..f5b32303353208d9f85ae0b04d38a9abdd398d24 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1856,6 +1856,28 @@ static const struct serial_rs485 max310x_rs485_supported = {
 	.delay_rts_after_send = 1,
 };
 
+/*
+ * Unregister the port before cancelling its work: until the port is
+ * gone, an open port can queue the work and arm the timer again, and
+ * the hangup queues md_work itself. The caller frees the IRQ in
+ * between where there is one. A port that was never registered has
+ * nothing queued.
+ */
+static void max310x_port_unregister(struct max310x_one *one)
+{
+	if (test_and_clear_bit(one->port.line, max310x_lines))
+		uart_remove_one_port(&max310x_uart, &one->port);
+}
+
+static void max310x_port_cancel_work(struct max310x_one *one)
+{
+	hrtimer_cancel(&one->tx_delay_tmr);
+	cancel_work_sync(&one->rts_work);
+	cancel_work_sync(&one->tx_work);
+	cancel_work_sync(&one->md_work);
+	cancel_work_sync(&one->rs_work);
+}
+
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
 			 const struct max310x_if_cfg *if_cfg,
 			 struct regmap *regmaps[], int irq)
@@ -2068,9 +2090,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		max310x_power(&s->p[i].port, 0);
 	}
 
-	/* Setup interrupt */
-	ret = devm_request_threaded_irq(dev, irq, NULL, max310x_ist,
-					IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), s);
+	/* Setup interrupt, freed by max310x_remove() */
+	ret = request_threaded_irq(irq, NULL, max310x_ist,
+				   IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), s);
 	if (!ret)
 		return 0;
 
@@ -2093,16 +2115,19 @@ static void max310x_remove(struct device *dev)
 	struct max310x_port *s = dev_get_drvdata(dev);
 	int i;
 
-	for (i = 0; i < s->devtype->nr; i++) {
-		hrtimer_cancel(&s->p[i].tx_delay_tmr);
-		cancel_work_sync(&s->p[i].rts_work);
-		cancel_work_sync(&s->p[i].tx_work);
-		cancel_work_sync(&s->p[i].md_work);
-		cancel_work_sync(&s->p[i].rs_work);
+	/*
+	 * The handler loops while a port has status or RX data pending and
+	 * free_irq() waits for it: unregister first, so that the shutdown()
+	 * this triggers masks the interrupts and stops the transmitter.
+	 */
+	for (i = 0; i < s->devtype->nr; i++)
+		max310x_port_unregister(&s->p[i]);
 
-		if (test_and_clear_bit(s->p[i].port.line, max310x_lines))
-			uart_remove_one_port(&max310x_uart, &s->p[i].port);
+	/* The handler queues tx_work from latched status regardless of IRQEN */
+	free_irq(s->p[0].port.irq, s);
 
+	for (i = 0; i < s->devtype->nr; i++) {
+		max310x_port_cancel_work(&s->p[i]);
 		max310x_power(&s->p[i].port, 0);
 	}
 

-- 
2.47.3

