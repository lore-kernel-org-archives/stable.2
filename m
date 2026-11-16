Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794823057;
	b=VK76UlDM05W0ngxcPlzFBI6vwnpH1oymd2/3zNyxgmKpKiYCcZpYiBRLOuROZp6pTJxG
	 JWctmbBCZHpm9+pymzXhLpRGDf5ECWvdnz5arsxGw8k17cFDK9ARDek5S9doqAqBCqCKs
	 Dw/b/JUU4MMNP7vDkRQyS+mlbyXwSdoLI0bKBK5eS9PbEsT2gAM5TYKZma9VBVD0J+nAO
	 Wz4cJfWHwNr/ZdNnEsLA3hVfTkyKXIFJcOF6lCNznkOdElbSvB6LqkgM56HIDlDMQyVhC
	 D6Yi1xAkk0v8wUPt41SNiA1u7NKz1JeZiY4abr6PF0M8SUNIda0Rx36kSEnA3ncTfMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823057;
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
	bh=9h66KDrxWfN/RFSj4zxJE1q18IX9IgGTcqzKL9l0VHc=;
	b=MvykUcZ+uqhx1Ut2zhVZvamkM0siqvOyMEYGzYu1O8kFmuFXzOoDNNi9zODpUanapNQY
	 2CcmsJVvowP4rRYxWxfa0Ji8vjDa78ZQSyrAhUXydUtCnscePD7KcoMXCL7ZQqqW6A4Vx
	 BCJqRYsZGy/s0CdlPQGK4wtFHEFtd6N0FwOelm19+KpYIgH4prUkBm9FdGut5FvwBFiHS
	 vZIqcCz+xlJ1pU2NgihmubjOJMsyS2/ILJwNncu+MPBO9f8iHddC8ORIuXD12zhl+M8Vy
	 VZLvjy1RF1dlgSH4MXWBpr9nBVnqLfNaqtBdmlX/jANf1CJyZI+fZQ7mFHKeY+jZ1yg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=DBpvNGbV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.103
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021103.outbound.protection.outlook.com [52.101.70.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA51606A323;
	Mon, 16 Nov 2026 09:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAA51606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=DBpvNGbV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ps7MQjKk3yVTAiLBqoUIJmG+hF8jhOxjGngzQUrQWWTFdGO5HMFLUbKq997HmD91lg3c0gPkg/wIHd+OJ3tXnH1GVVppQFvK4l6qcVA4EM0mQR0Wms67LIpO4IP4G2Xu/Vo0o4S6r9kzMWJebLnBu0mLp6ptQ+1K6FK5K8aSQ1K5rXomOs2rWeDrbLk2FRSA7Onwh1qjjpLekebKL8fgKk39QSKhtYLMfg6JvUHCm/yyimfNBQC3cBjd2+8jPWC8sBFzljA7aoZlm8pe9tzu9NsPOoks1nhiUg4B3BsTkqxcVjC6wv2+6ieNlhNMZSaXwXphmF6jHEkh4WifQW0/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h66KDrxWfN/RFSj4zxJE1q18IX9IgGTcqzKL9l0VHc=;
 b=RCno4lnSyjkouHrXeaPrs7QeqbyKcPUm5gXYnppsLGKa5ksNd/TV8I8o5LKyEDYxF7cd808r3joAFQejnkf5VHUqxvmSWw4OWTi0FUTp9wQcUfA3Sd2X+7FvdHHYX+JsUUUOI+Z0RhQINATdIQHpZ0EPuhVAyte9ybqYu/4by358R8bdYzGcsTXRfjcBs/p+qe5WiUtkb9N9mh9XBof7YsNMkUCU3QaXo51ijKD5FHNaH3XaJMXTamy0OLywNYKSWt4lkIChMZXKqcTxGS+cd5xpz2v/kPlPuJrHfjHZhKwU98r0W81fkgz30e/LVkZfNQTw2rxh43dRH6cZXXdFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h66KDrxWfN/RFSj4zxJE1q18IX9IgGTcqzKL9l0VHc=;
 b=DBpvNGbVg03PK3VwWLmeu3scvOnay3r+3yaRWGyfIz/MtLX6m+mMtGvjU5FmrPG2yXqh8KwpG8fn6BPLAPbSSx/YvfU/If6WuKXwpIqe8XFDalwJHfSWKqJKqLh/Jwleh1vZeeJZMpIYbve7dSGIuedqZjl7uFE1nHmJLlq6kDi/VUYagie3PjAOLG4HZ5V+K/fCHI0ocUhyyKTZsB8xhCMEtcnCLOyoWYh54H3IEqmuuR3UvoFpLd/oM74ZdvDTJoPkdue1rRmWl1WRb/87ocu+nwAvt4StriQ2lHFy7qSzxglLpi7VUqGeKxL14NaiHBXjbqcBqC649QXfga9QMQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by AS8PR06MB7541.eurprd06.prod.outlook.com (2603:10a6:20b:33d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:57:31 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:57:31 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH 0/3] serial: max310x: transmit path fixes
Date: Mon, 16 Nov 2026 09:57:21 +0000
Message-Id: <20261116-max310x-tx-fixes-v1-0-61c01f180911@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHT+moC/x3LQQqAIBBA0avIrBtwlKK6SrSwmmoWWWiEEN49a
 fn4/BciB+EIvXoh8CNRTl9AlYJ5d35jlKUYjDYNERk8XLKkE94JV0kckSdnW22pqx1D2a7Afyj
 XMOb8AdBez6JiAAAA
X-Change-ID: 20261112-max310x-tx-fixes-eba3803195ae
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794823050; l=4325;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=fVwFYAslN9GETxKfQUn9C6O/X16eUTZz/IRY59OOpLg=;
 b=UWejJsyFKIGVM4rw08BHDQFdWnCaQ8ywytCTJlK4ynFU79+C8s4zROTbAfcAQB3OX1YVSNMU4
 AnQD6VygGIeALWri9mQjgHgH8aZgac8LxX0xVUWa8Cd/wAO3JvxuHLx
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0068.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::10) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|AS8PR06MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 3655cd8b-471e-4212-bc8e-08df43c807b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|6133799003|18002099003|261009223027099003|3023799007|261022105027099003|261021123027099003|261022075727099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|11063799006|5023799004|56012099006|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	bYMCFvXqbGCCc8GkEoH6Y6AmHTmdBDTG4Lc/X2ktMkU8YdjBlAwvgzBef65KGXfrn1uBVA+YrgMf3M3+Ma44m5cmL/EvVPYEYBAdps/XglNyDAlTAYvs4GgCiBU+YL54nEihpkG3NcgyK8GrfB6woBrtkk+DCoxAomY1KTs0vS/ZYFbLUA2sw3LFKYlIGS/0I8mF/wYuUbhH3w6jdfP9gQ7mAm50vVRygAWp+TfUVe4FrhoX2S6fXs3XHbpBAG+6EHfYNeN6wv9c3UjUYIVFF/bANCTPP+dFUnYHI/3FfV11XVLUcRSuvpF0YtLoIuqfTS8tKqd1vsZJnvAg9J1ljZdBwGJDn+2ORb8+FnEJH0bxpSEbPU3WdfzpdzhdnqCPnKVlmD29n7W/mPU06K1Nl2Pl5vJbohX0djABXgUtSVDSMBSgAexT82BF7WfDL0HcP2b46ob9w2U1K+wFNLjWcCmd9PsUDRapCqWj/G2/KR2XHQRiKrRGsmZf3A/puxXbAJv0jJL3Wv0WzuNMnevDU2GzMP57RGhamkNOFeUu0Y7JYUMXrqUgPzr2GtIUE2Qk/Gxr6m47l+uRQ1YO9GbS9YSTQ9mAJsPGsiLU2TCe6xcZJzkT01y/lNgp3gM89q9nbqiVghpV+m03wKfRKXBAsX0jzpivPXCHM2TSLqHW0q+Yo3x1i0xVTP3bEkIrrRWTw4UNBpwlQ4GAhpFPupidvfeXkS/f0Zhp8iQ8mRVqjs8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(6133799003)(18002099003)(261009223027099003)(3023799007)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(11063799006)(5023799004)(56012099006)(10067099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUhjWnQyUlRwV3JwOEd4aEVsRzZuWno1enFBZy9ZTlQ0VE5WVEhma1c2Q2Ix?=
 =?utf-8?B?cXZyd0p4RHk2d3Z3T2c3OWYvSzVMV0gzMFZidVVaT25CeE44eXNnYkxPdGdk?=
 =?utf-8?B?RVNaUi9SbHExVDN5UUNTeHBQZis4Qkl3ZjNiNUN0R1hVTjNwOVVDYXVncEZp?=
 =?utf-8?B?MFRhcXFxZEcrMlc3NWJTWW5MZFdkcUdHRkE5b0Y4ck9WRjE1cmwxOWw3a0hW?=
 =?utf-8?B?N09zQXBEQlZPZlNUeVBUOVcxOXJncnRFZ1EzcGhWZFBSZ0FFMEo3SjhhOE9Z?=
 =?utf-8?B?RUtsNkp3T0prc1JSbEFZOEh2RnJpTnZ1VUpLYW9NYWVRVUE5NDBrL2ZVWXBv?=
 =?utf-8?B?TWFDc0lSWXViSUJ2LzVRdnVhNnVKdVF4NDFoWExEWnQyaXdDMHdPdi9Obis4?=
 =?utf-8?B?ME5rbXlLYkFlb2EyMXdhZ3J0SG8xa01IUWM4ZU5zZDhlcmcxLzFXeHJPR1lS?=
 =?utf-8?B?V01MaVFrTytsZ2Z3ZTFrUVdqTlpGWGxtbThwVVhnbDRSRTRtWUhyTUFTUzlK?=
 =?utf-8?B?SElTMG1IMEF5SlJXajBhL0t2cW1rdWtJZlhPK2UyT2NVNWR3ODJaRzVGRmxG?=
 =?utf-8?B?blBqeHk4QTJSSTJsby9VbGxlN01Zamt3V1hyVXhidlNRaXNqc3Q4NnZlWUhn?=
 =?utf-8?B?bUFnYnNSNTNwYkMrRWdENjVoSU1KRUFPR0hzQTdsMm1tdEZjZW9yT09iYnFL?=
 =?utf-8?B?dTFOVkozQjlnNGI5U3FPZHM3NDcrRGNIOFM3WWJXRWtyTmx4c2RmeUN2RmVl?=
 =?utf-8?B?bW4vYVpIVmpBb1AzcUZNOTNYbGRneVBWK1I3R0lDbVdDWS9YUjVKWTUxZEs0?=
 =?utf-8?B?dWdVaEVTZndvaEdFZDRWemVuSCs0cm1IL3VNRHZsbmNES0xkdUZGdE5ieDFw?=
 =?utf-8?B?bjJra2U3U3ZJZWtQUFlQUzdsTm1OcDhoWXZDNmgrV0dGMFhpVEYrako2Q0NV?=
 =?utf-8?B?MjVUaVlCMjlHQUVLNkI3VHVDY2lERHgweXFYcGZiVG1lempPZTVLWUtkZUhq?=
 =?utf-8?B?QmpqdjdqWWllbTUvUFdVR1ArbWRMWlVtK3lXVlZIbHdHYmljM2h1NW1HSVdm?=
 =?utf-8?B?eWF2N0h2azNFV2RZYlZLMVlyMEsxWWlBRUFpUVhDZEpxY3hqUDByUGRrRzJI?=
 =?utf-8?B?a3BKMERLcWlBeHgzUi9DNkhsSVpXTGRiU3Z0dGZkNjVVaUtoYTAzd3hzS1lu?=
 =?utf-8?B?NXhPbCtkWmk2MXptaUtjb2NDeWJ3Q0FtZHZYRjkyKzVSbFdmSHRFSGxvWUVW?=
 =?utf-8?B?Zjc0amprMzVmcGRXdXJnWElvYnVjNDRJanltUllQd2MxRmludjJDY2puTkhj?=
 =?utf-8?B?S0ZyNjl6Q0ZidlluS2JpOEhBRFdiV3REb3FyUld5bVdqSEMvZ29udlNvYXBF?=
 =?utf-8?B?bGc5WEw3YzQ1eWpmWkpzeitsbTRON0RXWEpNSW1sU1BuY1psODZKbDVTYk4w?=
 =?utf-8?B?dlgrOGFoWklSN0RKT0IxSDZPUHJBSkI0ZkgyUFNrYkg5NzJnZHZ3OFYzdnZS?=
 =?utf-8?B?UnhWWnlucU9WaUxqSldaNEV4a0JUeTc0Y2dSMlhWZUQrekQvZzU5R1R5V2sx?=
 =?utf-8?B?MU9yTGhzNGZRdEtKdnMrZTU4QlVhOWZMOTE1Szg1MHdZendNNmtwb1NTOGo1?=
 =?utf-8?B?bXFZd0NFa1pDL21oS0FrT1lQZTlCK1pHbTlTY1dMd0loaHRWY1o4dkhaK0xS?=
 =?utf-8?B?dnQ1d1hlTk9IQ3NRNDN1a09sVnZpdG5wUE1pdms4cjZWT0ZTNlBQRVZ0ZjJi?=
 =?utf-8?B?ZGZCOHRYM1Rmc1dFQVVVVXNZUHA5SUZRU3JJQlVsdll2cnlNODJtLzZyNUxq?=
 =?utf-8?B?S2Izd2pHRjRFYW9xWXg5ZkhDQ1dKZnNqdHpNRjVKNXBoay9XUU52ZnRKMU56?=
 =?utf-8?B?MjFvU2xPL0ZRaldBMElvbzNFUUlYcTFuVkZFU01weDQwK3JnNVkrWTVlZXk5?=
 =?utf-8?B?YnRqYkZvaDdJYkFIMFhtb1ZCWW40dUNLdDhDWWRNekJuYksyS2dNNHlCQnpo?=
 =?utf-8?B?bnY1ckNWNnU5eFV1blZLcnJ4dmFBSk0zZXhJdFhlUy9kSnA0dVg3OGRhYlE1?=
 =?utf-8?B?eUhsNXA5cnU1Q1p0cFRsZWROcmpKUjdTVHVRV1c2REdqNzdrVVdMeFA3NTZT?=
 =?utf-8?B?RXVnczJ2RHEwazdFSVhiTUM1MlZ4TmhGTWV4MnEyUm5XZ2diWUE5QWx6Znp4?=
 =?utf-8?B?MnBtVDhHaS83REYvcEFDM2FPc21EN3VVdUZWS08yK2QvQm5UUm1Jamlvcy81?=
 =?utf-8?B?OHhoWUorZktaVXF3L1JKVjZER09DaHJuTFpZWTkvZjRIREZhaGVRVTRudk9q?=
 =?utf-8?B?WEpub1Y1cHJFbU5SWmZwMVJKb01mZVBVMHpxd2lDNmF6aCtvbk1yMWExalAw?=
 =?utf-8?Q?ExcAkOK0rs2Pn7rA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3655cd8b-471e-4212-bc8e-08df43c807b3
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:57:31.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83oufSf1T/AjefxJB8HDV+TDIwTcxk9/gZ60g6mhPniZTetwHpZNxdjeQtgqKON8Pz8mjOsFrYr3qAcReaDx8CKPr0EtUq8pCIoJZilt7+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7541

Three fixes for the MAX310x transmit path, found while stress testing
the software-timed RS-485 delays that are new in v7.4.

Patch 1 fixes a race between the transmit work and a flush. The work
advances the fifo after the SPI transfer without the port lock; since
the kfifo conversion in v6.10 a uart_flush_buffer() during the transfer
leaves the fifo length wrapped to about 4G. tcdrain() then never
returns and stale data is sent until the port is closed. It carries
Cc stable, but does not apply to v7.3 and older as it is: the context
is the v7.4 driver. I will send backports for 6.12.y and later.

Patches 2 and 3 fix commit 33632215e1bb ("serial: max310x: drive RTS in
software when hardware delays are too short"), which is in v7.4-rc1.
With patch 2, data written while an envelope is closing no longer
leaves after RTS has been released. With patch 3, a late TX-empty
interrupt of the previous envelope no longer pushes the head of the
next write out before RTS is up. Both lose data silently on an RS-485
bus, so it would be good to have them in v7.4.

Tested on a MAX14830 behind a single-core i.MX6SX, on v7.4-rc3:

- flush during transmission on all four ports, five minutes: the fifo
  length stays within 4096;
- 20 unbinds with a tcdrain() blocked on a slow port: no task is left
  sleeping;
- RS-485 loopback with data verification on three ports, 57600 baud,
  25-byte writes every 20 ms, 20 ms before-send delay, ten minutes:
  no byte lost or misframed. The numbers without patches 2 and 3 are
  in their commit messages;
- baud rate changes at random moments under traffic, each one moving
  the port between chip-timed and driver-timed RTS: 7672 changes in
  ten minutes, no stall, every byte sent;
- TIOCSERGETLSR and tcdrain() polled after every write, 12500 writes:
  the port is never reported idle with data unsent;
- xmit_fifo_size raised to 256 with TIOCSSERIAL: 570000 bytes per
  port, all sent, nothing in the log;
- output stopped with TCOOFF, data queued, baud rate changed: nothing
  is sent while stopped, everything after TCOON;
- TIOCSRS485 repeated every few milliseconds while a second block is
  written at the end of the first, with and without CPU load, 50
  minutes on v7.4-rc2 and v7.4-rc3: 30900 block pairs verified through
  the loopback, none lost.

The envelope timing was checked on a logic analyser with an earlier
version of the three patches, on v7.3-rc7.

Not addressed here, all older than this series:

- an x_char is written without regard to the RTS envelope;
- a reconfigure while stopped output has data queued asserts RTS for
  about one character time;
- by the code, a TIOCSRS485 applied at the very end of an envelope can
  arm the after-send hold while a new write is being pushed, and RTS
  then drops under that write. Patch 2 closes this window for the
  transmit work, not for the work item that applies the ioctl. I could
  not provoke it: see the last test above.
- sc16is7xx advances the transmit fifo after a sleeping write without
  the port lock in the same way; patch 1's race should apply there
  too. I have not looked at that driver further.

I will send the max310x ones separately.

Tool use: Claude Code (Anthropic) was used throughout. It drafted the
code and the commit messages, wrote the test scripts and the hardware
test plans, and analysed the function traces. An LLM review of an
earlier version found two faults, in patches 1 and 3; both were
reproduced on hardware and are fixed in what is posted here. I decided
the approach of each fix, reviewed every change against the code, and
ran the hardware tests. The code and the messages are mine to defend.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
Tapio Reijonen (3):
      serial: max310x: do not advance the TX fifo past a flush
      serial: max310x: re-check the TX queue before the after-send hold
      serial: max310x: hold TX data until the software RTS send phase

 drivers/tty/serial/max310x.c | 122 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 26 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261112-max310x-tx-fixes-eba3803195ae

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

