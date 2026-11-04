Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788083;
	b=IrTI2Fo+R4kxqpL1sWUfA5ImVQ5quZHFwvvmzgdpH4xy4QJ9+LK4ArO5FUu/4JyS163G
	 liwOeRy0vv5BNioU91Vy/SLTY5+VzcgGs6y3SLdKGpQeH2/yTQy02HRghlSl2TG8TZoZJ
	 v/Le0uXCP8EXo9RBtMTfZdiC2zQU3ahWZe2ktRiqduaYz5wPAJUrttcIc9tBpGgv3QlYa
	 JnCyR/e8nwO//KQ0n9ydlx2RMA9jXAdiScGCaxfaDj8wr/w0yd9rzI0gV+4vSR8WrJn/k
	 epgZdWKUZVnH/XvDrOSKterOCiE7InWgiucuFKuu3NkomntCu6HZe+qGGejd9Shrs8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788083;
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
	bh=DuVgdIN/BKQY5DED6k7KJfLegJzbQEP+Oj2ZMjni6F8=;
	b=bhNSjhXi+CfCtHUK3dUscvdg8aFjzJJYwItj02djD1y65rSnHzswrLXC79cYDrMO/+vC
	 QZS5UIfGpbsm9jUxOqn6q/ECrlc0KNCRb2LSdroY6nnQZzJ8x018j8LH6kYEwLr5KQ5x6
	 qRamrwtRayR6CC+p3DBZyCjwfG4UtoU1b8nf73r2kj/jzli2UU2KL39KyY3H1CfrQ3qJ6
	 d8iyAfzPQOfw5BiRCgq9epRQJdlPIlAd6LU3alCA1SCXsLwUllzrHxNpQghyMIneVprip
	 jJEooQxy86XUHehmUvLdUQmpY7I41nC1c19cDfvEy67aGNluD1BzO3SZ2BoTL/vFSwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=j95Nb9ok;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.110
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023110.outbound.protection.outlook.com [40.107.159.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9AB606A326;
	Wed,  4 Nov 2026 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF9AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=j95Nb9ok
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mx4vnNTDg0q9WbRLk7fECpCi5McgJioXgrOMaNwyEZw3VVTQXoU6T4Q41hNpwB8ttZ3o97VeMq5ZXsfwPWtWoRFvZoDEUmg4VvpYuH+DqYIJ8tSJ40RcBzorvpFBQFp6Vz90ElY9ZkIqylCoZf94/iGQdqCErTSW0NhPg6vyQNlKAYie0XYsEXHE4veYBW3gFhjihdJOWFoCUMRotpzgFGZO4ojiJsDKteGg7kZcQxG7Ay/JahvfjyKDItHqS46s6n+Po3W5ZCilg0Mzmay+G4DFEVdIuTTjBjr93rKCnKA6KSF4vupXDWLiG3BZh8s2C/Y1022EOU2qPHN1lbet+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuVgdIN/BKQY5DED6k7KJfLegJzbQEP+Oj2ZMjni6F8=;
 b=Mkby67Ot6YGgEk8LpXZn0B/Xj3LVkGPdWLuG+Pvt34FbCOs3VajDwwpnGnHqLDcd3fPiMWfC+o9Bl7JeR83iH6tvIx+RH9o04Py/GsY9tMzjROM6xLRuEEe1sXZq83R7N0PQ3ymONpFxr6pUGjfGjbRrPteNtEwwxIGVIH3Impnf2BnIvE9mjPC8+XtJ6iZSwH9QeVH6Qiw0SPNjG5kocQPsqgh6ErAxqR1hTWXn4AWxWvoerYva5dEPbY7FwN5s4S9YUFHntYlGa0iK/bDJxTylXqUg8CQHrls32ENm+/cIUrjUIUdRn4huhrf/j33AmfVg09KVQPNZQ2w5ew4QxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuVgdIN/BKQY5DED6k7KJfLegJzbQEP+Oj2ZMjni6F8=;
 b=j95Nb9okxiuc9YOR2wKWobqilosThVBGmCZHxCPeDLBon0c3xQk1EdnBdp8OnnmHNuqMGuLeSJqcwDFKZRMlIMuFQyEa7a8b75/FAM3MPF3r6yVRCp67e9SBJ0V1lneBkr5KeypU+4RafmmteA6Z54v4htBLb6Dei1GeV+xQ0QSeT8BxifftR9swZJibVX9eUBmTUvL4OCyU5vcoWf2UXQPQBCi/+nmPi4qKToZNig8z7lyWxrAlKVFGS3Az07Kkh/wkb4lioq8pPRppYJB/uNBWmqjfK3NljoTd91AgTX4u2YGRpO6EMBGnIw5aOw4r1X2S1xbj7Aut4outsB48TQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DB9PR06MB8910.eurprd06.prod.outlook.com (2603:10a6:10:4c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:27:25 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 10:27:25 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 04 Nov 2026 10:27:16 +0000
Subject: [PATCH 2/2] serial: core: do not touch the port after dropping the
 last reference
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-serial-core-remove-deadlock-v1-2-6a30597adcbf@vaisala.com>
References: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
In-Reply-To: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793788042; l=1828;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=+eyIDAZBwXXMw56IndrUsL2PucDqIdBnTamk5HMeDdw=;
 b=xJpIdZC67I0P5HA5xEX5+eUTAV+d68oAFqbePnlXtG7NqnrDAiCBOZbI99ThrI2sW9KPKaxZB
 FByG3V4vM77DgMxn9myTbMr7CLeU22r9jtZQSaxzGnLL8xaCCmKRG4p
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVYP280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::23) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DB9PR06MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8de31c-5290-4d53-7b50-08df3a5e3806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|23010399003|366016|10067099003|18002099003|22082099003|38350700014|56012099006|11063799006|261021121427099003|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021123027099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Iqmkzf7Czon2DFuOzjVLSucXC3++IWN83rnQVpz6j7pqtRrOZ6V7dIPMazX2KdPy9+IHpL6WdIpQzjqfqKe87SG4Sf/SPiU/BKfDZvbcksqNyJ4gJKs8eVNWg/DPpAX7VnSIoWPSDgMiyU/JcwfSuShgMN89lDMvZr1FQgPBo1I0UOzLFFJfyEGyHofANuKUrH99sfD6ppEJ1eMgCeVAFztknt5hhh+btJ/1hHB9snr4Lm/7V57eKCvuSc+qh7IQvGO+q7hnyjt4P5/e8C8xlxbW3gUEXKNQUir5qyEGRSjGP8v0Hs4AhteFbh8lR3bhzuEqNwmOmrLwBoT13QfxJEx5sq8UWMq9pyV18TCgGXNrGhSRk1qUxA9/pAWQzJj0zZ+UW4IO/UIjyjIgmCRTL9QuZqokwVWiqSpi9rr3xfUp+LF27ljZFtfNorawl/S5JZWLDuCtBlWWPotzGyMYg7XvEY0LbjI83wW9GjQi/doe6O4NhiYrfGO8Hz1hL90PoER9lZ/yRO1q/f/YT+n1414gECcJghCb63n6zgV6xMpEWE3IW4mJbqBLaOGiLsmiud1NpqwtPGxiDhD41tnxZFlY1tK2Irx2auXB0MYhbq/UyHWFy9xctdJDBV8WR6nJCHnPDBBfGO4pWIHON4NjVCp304uWtmjWGKS6WsDXTkIgal90kTfdCmKlHCKcLdzOuA6RZB1IOEPqfO9x74MDIz1cIBgqSLI6P3B0eQ86lvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(23010399003)(366016)(10067099003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021123027099003)(261009221227099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnhiVkV5VGdLQnU3QVo5SHorL0xhaGJkSmRxNTdxMzNhb1ZUek1oZTNqaXBF?=
 =?utf-8?B?N3RTTS9vZ3AxZzVCVnoySHQ4MFJoa1VFWm05YUFEOGNrKzVpaUpaN2p6THEx?=
 =?utf-8?B?QVZtQ1RpR0hHMmJsWFllWlBGRUxkZndaNThTUUNqcUpMOHE3RUQ0Rk11bWhT?=
 =?utf-8?B?dURFamtKQXRxSmcreVV3ZkJLbEtPcGpkY3RpZVBLL0piYzdocFdsUzhJRGNN?=
 =?utf-8?B?dHRGNnZtTGx0cFdDYjdJMUhtZEFtNEVad3BGT2JWUW8yL2R5aFlpT25qQlpO?=
 =?utf-8?B?dUVvQ2Z6MFJKcjNZcjBDczdRWW95LzJxWk9IRzJGeU80RXJBMWl6MEZsK2tL?=
 =?utf-8?B?NjNoSlpaRXNkV2srdWZxaWlwcXVQZENRaCtYLy83bm9Pc3ZTU1BWamNyYUZO?=
 =?utf-8?B?S3hCcmxsMTN1MkRPVWxwSHVBRjZLSEdoVWpEaXlPZngrbVVHVFJoMGxxODhX?=
 =?utf-8?B?UEIzNWFNY0t1MGZUbTBxZHBwQzU4eHdJWGlRQll5Zm0vVmEzR0dwVmFTT3N2?=
 =?utf-8?B?UkkwVk5JbDJQLzI4LzBQaTZuR1dOYXJoVGJZbGgrdlB2UU05Z3hpV3RGV0Nx?=
 =?utf-8?B?eDlnRWVJSUF3ZjJCUWsvVXNvWWxzQlpOeFliL2hEZStWUnZjSzZOSXhxL1p5?=
 =?utf-8?B?L0EvV3NHMmxTM3JrbFRURTVLN25DZUxHTWJsNVRCVWM4K0k1bjBqaVJ1Rjh2?=
 =?utf-8?B?UnBxWm0zUlR4YXh5bk1BYk1EeVFPSWduaWJFN2tqVDIwSk9sZmZMMllEaGFj?=
 =?utf-8?B?QkhxVUVBRFJRZnpaZk1DZEtVZ1Eyc3ZJbHVGRmVFUUZkU0huYi9iczRNVkg2?=
 =?utf-8?B?MnhRY24ybWR3L1NRbWlwZWxUS3JTZXI1K3FuYW9nT1AySzM1ZllXdCt1cnFS?=
 =?utf-8?B?SktZcEUzdnVyS0dIWWZ1VXhjWi9id1ZKM2p3SWZVMUxJNUo3M3BkZGtOZERS?=
 =?utf-8?B?dktNYjZTTW9CK091Zm9DMWhaanhBd0g3YjJBbElncTYwWHBHWVZqek5ERWZF?=
 =?utf-8?B?UjN2R08vT2JyL2hmMXlSSURyYk1hdmE5RmpXQmhtb3VleXdSNGVVVk50Wktv?=
 =?utf-8?B?aHAzM2pteTdCbEROeVlhQnh0NDNwTEdnVkRDMk1lZEM0UTBnTnpGUEk0TWdw?=
 =?utf-8?B?ck1sYTZKYkxKRFdNWGd2TlNEK1hKK2xBS2JoTjNuaUNCTzRJYkgwTlJoQ3dS?=
 =?utf-8?B?K1ByZGlEeFROTG5XM1ZoT3E5a0pKTDZ2My8wKzB1akc4UkVNUjdmMlkrQ01v?=
 =?utf-8?B?YlRMclc0dVk5TFlidnVhdTZvOHZ5RG9meEtZNHZBMlFaeXhnMGJaS3VvYmdW?=
 =?utf-8?B?SjZVQ3RJc0poTlU5ZHdDVjhTYTVkbnB5dWMveTlMNFgxZnN0N3RDSENtZWFl?=
 =?utf-8?B?bjZHR0Frck1CVTE4VjEzYVdqbURycTFTeFlXeTlHVENSRmFGS2lMb1ZKZTJp?=
 =?utf-8?B?YlZ3bERsRUIxYVlaQW9CVnFoQlZYK0xVWFFaREVlV2x0OU1SaE1IT3dBaFZT?=
 =?utf-8?B?TExEdHR4NVpsYzE4Qk9ENm1FbE9DUlhUVkJnTWdKbG1CVU0yN2xXMG9QTnVF?=
 =?utf-8?B?eThrQ3IxWFB4SGhVWXBjWEFLK2VBS0lrN3AvOFBMU2pCdWlwcWQzbjBMSk9F?=
 =?utf-8?B?VTZlOWY5NUtMYS9wNVIvK3lmbld5MDZ6TlhSa2ZTM0hrNmtlb0IzUHZtREo1?=
 =?utf-8?B?dk8vNkhtT093OWtpZEtYeW4xWkxzU1B1WlRidWk1TVE1MUFiYnFNMjBqdlZv?=
 =?utf-8?B?a2JBaTQ3ZDNQWkh0ejV5WWpsb2poU0dYZ1JXNElFcDd2ZTBWSU1JWmRzU3Q4?=
 =?utf-8?B?WjlYWGtGMUN4RVU4WjlvTGN1aVliTjdEemNjMmUzMmd0K3VnbkFCd2dlblRt?=
 =?utf-8?B?VnFYeGM2YU45UGFYMUgzbjZJdGg3Q1U0U3k5MW0ySmxmQUtpU0VlOURCallI?=
 =?utf-8?B?M3lkTXVta0NJU0hkblBZUjRxVyt4VjUrWmRWc2Rrd3dseURHSy9zKzBwR3Zo?=
 =?utf-8?B?VGJHUjAyeTQzcUp4eUJ6Vkc3U2c5QkQ2UUF0RTIrNzFEcDRiSDB2YnJ1eC95?=
 =?utf-8?B?UVJsalo2SEVUT0pDVmZ4MVRxK0RQcWdMS3BmL25OTzNpM3VGa21CM1B5LzFx?=
 =?utf-8?B?Nlo5YmNGaVNTemg4a0QxK3J6V25aby9nRktTNGRock9mVmVOb2NxSS96U25C?=
 =?utf-8?B?NVZraTc1cU5vQlpYMGJnL3U3S3M0cVNiY1FNR0tJQWY2VEo0VnJhTjA5KzlH?=
 =?utf-8?B?NmNFVjI5b25JWjlPL1JwZVFUMmdTUk0zSVBoVHRnMy9DT2VyOFBmMXFxR1Fk?=
 =?utf-8?B?QU1zcTB1MHp3anBjUEdMM1pBNkhIU25aZlorWTR4alEzanlRNkszRVgyN2Fs?=
 =?utf-8?Q?hHd3s5N7ozd47FXs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8de31c-5290-4d53-7b50-08df3a5e3806
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:27:25.2080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqT8zUwSWQkv0q2U8sqIx5ncQEFgHw5ICPIo6YFd5D8QjQmnbc4WBk1YS8+Lequ6VoZukAiU4/eaKQ0Lx/yWnLnp+dqggBHtwMR4WB0qfzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8910

uart_port_deref() decrements the reference count through uport->state
and then reads uport->state again for the wake_up(). The last
decrement is what lets serial_core_remove_one_port() return, and the
driver may free its struct uart_port right after that. A reference
holder that drops the last reference can therefore read the freed port
on its way to the wake_up().

Read the state pointer once, before the decrement. The uart_state
belongs to the uart_driver and lives until uart_unregister_driver(),
so the wake_up() target outlives the port. Drivers that unregister the
uart_driver in the same remove() are a separate matter and not changed
here.

Found by review of the removal path while fixing the deadlock between
port removal and a blocked tcdrain(); not reproduced.

Fixes: 9ed19428a51d ("serial: core: Prevent unsafe uart port access, part 2")
Cc: stable@vger.kernel.org
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2e53d194ecfe853ade1ac6f33e047eb8ff11e283..c3d21acbd606eb3ea2909736a01a66f204141be1 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -72,8 +72,10 @@ static inline struct uart_port *uart_port_ref(struct uart_state *state)
 
 static inline void uart_port_deref(struct uart_port *uport)
 {
-	if (atomic_dec_and_test(&uport->state->refcount))
-		wake_up(&uport->state->remove_wait);
+	struct uart_state *state = uport->state;
+
+	if (atomic_dec_and_test(&state->refcount))
+		wake_up(&state->remove_wait);
 }
 
 static inline struct uart_port *uart_port_ref_lock(struct uart_state *state, unsigned long *flags)

-- 
2.47.3

