Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794458265;
	b=V7p0deIh53Hkw0thtn5DxZYX2nLh8pjPQUzoeFOT1ssAADr5nzM58WvO5Geu2aLiyRBM
	 iPhhO2SYbEGgL7Qt9dwzLaRGYhiklJ7Cc0L+8IdxRolM8Zq0Vjmw1Zw7zDo5E1mKzL90E
	 0UPmYpm7sRolUt/2Cy8G/+8bOU+udkbtfThZR8F2vtcD0BYIKCuyLw4HCetVjXAVBo5tD
	 oMKrMhS2rLYfDKpnAme7jd9/xiDXv2+OsQVniuWMDqru6L2LVY/wEuNGJutzryabSxzUp
	 I+EkUnzvzS30AKe+WZGrtUa5QwVfN9m8s8C507mcFNVd0vtI0Kjg1kdFz3DIwfEniMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458265;
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
	bh=+6h4gw2zPntHuQ0cAqt0ws3Hg5SitD4E685xlhiWZoE=;
	b=dmVLzGV7XKR1Nk+Im5d+lzxyMih8/S9+oGXo67Kdrzte9FWWWhQhmnR1PbC5YV6pjf0x
	 exO6OSpEZNemeDF9jUYJsVTdLcMrnZoX1Y02nW1OPYa5dToYX6aWJWyjobtmBadgf8IQz
	 /Ntwfa8zKU8kxt4hb8OB4to7lMg+IogsBsuN5SMesA8yXs82fb5wZXcAMn4qQ1cpBktfS
	 wwJ144gi3mpNeiwpNUoZmi6O02RqrKyB9s3/5ta1mA2gWXGZSRVZEsuwgZiyreFw3Os00
	 XntHyfCfLzWRNJxuMP8k46JMU84fkRZhhuiFnxx2xvnf1U7PWxtE7Gq7AyTp2pnTArw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=yU5HaHzi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.122
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022122.outbound.protection.outlook.com [52.101.66.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1426760A2609;
	Thu, 12 Nov 2026 04:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1426760A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=yU5HaHzi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyIBeRsrNb2ccmLvHHonRji0zSJFJEX5wD/O2UHfD92vLK+EVdti6AKvhvw27eV7Sol2K02DPGQo0DLZyxe3uSy37UoKbp3PtqaSmWapTWncBXTKcpxFwWlyqkaIDBV9h0PejjJeo7hh4RS/cbMzrZiizBg9OHeLbR5NJ01MI6ec2vPeaQsdqGfjbvGHmorGMimjscrBWuL8ABKHEnaZDtXNSudJ9Yfmje2hQVFnkUO+AXT/e+lZ6uuFmoDMDD1UTlf/6LED2LzlnxzfDxm6rRuSzKoD0LHYru0f+eDvZDIMpV8H7DAJARVwt1ISwwm15E/2YpKUq+sYZf9NXl5w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6h4gw2zPntHuQ0cAqt0ws3Hg5SitD4E685xlhiWZoE=;
 b=HCWY1OM/uT1qJPJRIgBuNYvFiZGz5rJRCdj8/g/rUeFFjBWjw6WHjHtM7ArN8wRpLReZgAL5mHT2FNISSRdjg0EswkA9z8bBsGbnxMdsEmsdSEXoiHI/UudeVb22YKdnxPSBMzbZhol/QTIjS4YO8Qd2XuOkCfmbtRQQrO8/opgEO6jVi4yZCeWSmSoHarrtYHFk+AsXikYaBmvGTjgkf/mHHo8RrhJYvxrx5oxKR4EVOavi3QSRqSf22oCAI7n1emKkIq7gywaKqd7Hws30gMGD734lhpHB4gZeb/r6eS23mPTxreqm8mvsYVDD6B5L6fGuJZIYJv3GwIZo35VxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6h4gw2zPntHuQ0cAqt0ws3Hg5SitD4E685xlhiWZoE=;
 b=yU5HaHziqzSXmGw39C65mi5trV8J8OoeJxSJAImv/SkWcVNOXt/6YXOO8qNHdzSsjnBy7hfq+NwCx0qyYnTpKB1LZR6RxMpCEpoQTa855ar+e0UFkq2qGuAKiGA+NaVPbDLUhDkyFiMQhwZ1V746GEfnCfQ48P7mmChX3fc415a3sP+bB0vdjWoKY4Mh3tXXjHZV3wk5Zrhr2xubiqeKH2o9WbquGWgA7TJzqwc43nX22CGOBInAsLtVWF9e/fLZT2jleISaKNodQofgqnMZxnuiFEZy82jxkll64DRVpZbJuuQQyMOUsvRxm2cbENbd/Gjph5JAyVX6rK5cJJFL/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by VI2PR06MB10826.eurprd06.prod.outlook.com (2603:10a6:800:327::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 04:37:35 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 04:37:34 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v2 0/2] serial: core: two fixes for the port removal path
Date: Thu, 12 Nov 2026 04:37:26 +0000
Message-Id: <20261112-serial-core-remove-deadlock-v2-0-d3ee4ccec37a@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZC9WoC/33NwQ6CMAzG8VchPVuzAcPoyfcwHMpWpBGY2cyiI
 by7g8Srx/+X5tcFIgfhCJdigcBJovg5R3kowA403xnF5YZSlY3WqsLtnka0PjAGnnxidExu9Pa
 BqtKq6ywZY2rIwjNwL+9dv7W5B4kvHz77s6S39efWf92kUWFDlTLnEznb9ddEEmmko/UTtOu6f
 gFcwWYQyAAAAA==
X-Change-ID: 20261103-serial-core-remove-deadlock-0310bbca5554
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794458254; l=2765;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=5xkbIG/tBS+x8niLhAh9ExKxYX4Pytu9PCxBqUSGP3c=;
 b=febmaBsCK21A9kgiuu4tMVAiBMu1k1/JvJ2tpJa0kvUezasP+Y3h43uiYtxg/MB41XkTZnnsR
 P8eRlfloNjSDXATVcwlsLpmN02fKQqjD7gdOZax6U5IxB13/ri/DDhY
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::17) To PA2PR06MB9176.eurprd06.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|VI2PR06MB10826:EE_
X-MS-Office365-Filtering-Correlation-Id: 503f6bc9-0a48-454c-4855-08df4076abfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|261026140227099003|38350700014|10067099003|5023799004|261021123027099003|261021121427099003|56012099006|261009221227099003|11063799006|261009223027099003|261022075727099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dCbDFSK05ZWabJ5OKwfHbW5G7Nadz3iRzVq5KMPUW/WdyGXsuZik2bGMuWtDcXDZKm5KJLa5ZMlsVga6uLiKSC9+rkGnDOqDo/iuuBDzZAB4JrOU6/rbEA08WTx4QeAn2QR3O9WF85AqVr+fSo0a6xM9a31du94UMFadwaus4bSJ+irYtQ9khXhGTQ+tDvtHPTXRdwAmvKL6Uf5PrdWaAdLC2+LJOdEX35dctlSOtul1AbM3kFk945Ox/T7SoOm3eYpbCe3YVQNzuq6/nv36Xv5dQUajLEHWus7QKJVQwhuU3uDBCrj627cNpw6knA1/wB29srsm/CVUShyDMr9bZSyZ4RtvzAC5fDWxeYGJMhN51T3Hrr+jqqaiGZICf5qIJIbbMFwdQS/WkMeI9uPubPLWW2TTJc36QK8/ar5iaxRPGxNTEOmKc8Esr/FmgXVZHkh4gX9OL30o/oJbcYtfP9y6lwbw4vIfdC3FaBE6bzX6gS1DinEFvvsrKqrUAGiofPP1wykYyNIsw7+G8tS/+kWtC61Vc8RmrY0Xtw/3CD+HB68lch76Gt2tvIfd4WWUC0RZGPBIvwU5LG8LLLwSiJ2AbJ+M8xpxXTcVufXWSIBMW7VsO/ZBeXsKXw7hpoOlQrVDI0Kfh55H2DVjXJlK9hhqldfm64QtnPZVrLoqyHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(261026140227099003)(38350700014)(10067099003)(5023799004)(261021123027099003)(261021121427099003)(56012099006)(261009221227099003)(11063799006)(261009223027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0kyc1FIcFpWUGpXazBvOTNBek5USzk2UVBhK3E4NHpDU0JReXJZaXRNcHZr?=
 =?utf-8?B?ZTBMNmplbHo2a1JWZmFUUEVZQnRKNEhydXRGU3IrMXdUU0ZON3Ztb24za2U1?=
 =?utf-8?B?UXZmdWYrRzBmUnI0ejZWa0toT1ZxYlV6V2MxbTFEUnZJY1dzY3BjR3ZhVm5B?=
 =?utf-8?B?N25BK3htZmg0WnluN3ZWOGlZYWZIbmdCeTNybXhEaFpvdVNyUng4SjVsRTht?=
 =?utf-8?B?STZmWDdQZWYxUCt1MVNEQmJBZlB2MTU4QkdPUzBWUjN2KzRTa29vbStqOWd5?=
 =?utf-8?B?NFdXMGx5OGdVRVZXMk5aMFdKaHJtcmJudy8rdTF0RnBybVkyVm03YXkvVEVn?=
 =?utf-8?B?ZG1KbE1UTXNxNDNnbFNKcVBBei9mZW45cmtxNzFGQnFLbVpTWjczeTZGcGNR?=
 =?utf-8?B?MzYrK0xIY2pZcS9TaGpqeEUxZEN1STR6eU5oL05RcFdIeW9Bb2tDd05RajNV?=
 =?utf-8?B?S2lCbVNoa1ZQU3dlK3MvdGdCeEhDK2hGcXhJNkI4Wml2K05WRDNrZDcyUm5y?=
 =?utf-8?B?Sjc3R3JtWFdudWp6ZFR4RCt1TFp6SFMwZmxIbkp3VDBUdE5iaVl2blg0QVMv?=
 =?utf-8?B?WGRxK09nUVRLUCttYmQ0bGZ3SVVlT3NreEtMZWIrN0VqR1hxR2toRVFWS1Rm?=
 =?utf-8?B?Wnoxekl0QjZVQnJMVnZJMlJzWWh0OEhVMTlPSnFwcFJ6VXYybldocUhPRW1t?=
 =?utf-8?B?MEhBK3VPRm45NENId05aTERKMWFhd2x4YjgyZkZkVDNtR0lJcEJXT3ZFd0pY?=
 =?utf-8?B?ODhITDBrVUFxSENJaDlyUWlIanl2NnpFSHZlMWxxdEx5RERUQndxMzdRVHZE?=
 =?utf-8?B?dkZoT1BBeFdKbzJVRTBsZm50eWMxQWNTTWxjYTUvNkhjMFo5U2FneEdvOXZX?=
 =?utf-8?B?bmZHUEg1bXZTcjV3a2FlMVQvSjFpMVhkS3poc1ZHcnNCV1Z6ZUJLMlZBQ2ZC?=
 =?utf-8?B?WUJNSXptWFFmTHJYdUt2NFRpTkZFeXlqWTZ1NzRCRVpQQ2RXZDNVSlhCSDZH?=
 =?utf-8?B?ZzJYdXp4UUM5RjhzNlAzMjQ1MFBzK2ZYbThERzcvVTlaTUNTbDVDYURWajFV?=
 =?utf-8?B?TVJkY3hxSFZuUFJId000SW5ORGQvWFFKanVNdE9rdjg4SkhmWm5OS00zL0pS?=
 =?utf-8?B?Nzh0RW10eVZMRFVuK2JtR2xDQ1VoRW1GT3dHV08wL0JiOHkrZlJFdktFWE1Q?=
 =?utf-8?B?UzJvVmUzN25OakJucVF4NHJhVlRrNEIvUzdnWGRBQThJVVNaSWhobUdsQWtM?=
 =?utf-8?B?SlJ4QTJYNmtXMjgyZTVTWDJ4aDd5UWJPMW5oL3FaelV6WjRXK0VvSC9YaDQ1?=
 =?utf-8?B?K2x5VG8vS0xSRGdXTnJ1M09YclRJNGUwMEZ3VnRjOENVQjNmQkpNWmVqZ0Fz?=
 =?utf-8?B?dkR6RzlETVdYNXE5M0VIeWVKSDRzWkhsVjFrWjl6eGhoRVJWb0dYNmhQMDQ2?=
 =?utf-8?B?LzMzMFp4clBrWmJqNk12akk4bE5wbVNwWXlqdmk1TWxJTndwanJOTklkdFJX?=
 =?utf-8?B?UEp0YzdXUzZFU2RPTTFhTmg1ZndWcmc3bWZkZElla0o5SWk0SE1OWUZKcjh6?=
 =?utf-8?B?d01OcmtJZi8xLzFrWklDRUNqZEc4eHhHMUxhdm9vOXd5MjZqdktWT1pqUzEw?=
 =?utf-8?B?VnhuaDh0Q3p3TzRzTXVtM0QzcHN5RWU0QzFWanhzeFpTcUlmTzNtZEJ2RWl3?=
 =?utf-8?B?cnFhdHpmZzR4b2ZMMGxzVDFlRFl4RDV5dVJCNndYTzI5cjRYMmlaSEk2RmJx?=
 =?utf-8?B?OFF0R3E4Z2RiY0R1TFI1ZFd6MXFsaXI1SE5CWWhFQUpHSXYxcnNpaGtyVllu?=
 =?utf-8?B?U010a1IxSFR3NktqcC9BTENsSjFqSllJZnRtaWppeiswYytWS0Vpdlc0Tk93?=
 =?utf-8?B?dC9aM1pLYnBBQStkd3VNTWRmenNhbFpzbWtHZ3I3eFJwL0haN2ozZW54MUFo?=
 =?utf-8?B?Q25wNDlDRjA2YnBqY1JrTmlJTmwrSm1tVm1FVWVWeXBHU25EK09MaHlGRXUy?=
 =?utf-8?B?cFpNU01kK2RMdjd5N1Q4MUxNYU5jRjFveDdTczNDSzl0NVU0bGlaSnF5NDhk?=
 =?utf-8?B?Tm4xNjFJeEtZNXEvWXVxUTk0QWF6T2hPckhOMUN5VHhhTUdqNWxURmRFdjdY?=
 =?utf-8?B?THBacTBKdHpGQmQ5Tkl5VjI0QTkyUlJ6QWMvYWl4eDJObGlQcHcxZ0N1aHU2?=
 =?utf-8?B?WWVSOHZ3R3MybTNudGdyK05oTm9QbDY5SEVhWlVhUHg2a2VlQWRkSzVwN0I0?=
 =?utf-8?B?Qk5pNmcvc3ZhY2d5ZDN3SzlnSlNVbU1KTTM0cDhIUzdySVpJSFNibFM0OTNh?=
 =?utf-8?B?eVRGQ2dvN1dGWTlTSDhvOXRDQ29Mc2FSSVkyY1BjSk5KRGJZRGw1azQ4a2g3?=
 =?utf-8?Q?iMiQwPozveD2JzTA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 503f6bc9-0a48-454c-4855-08df4076abfb
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 04:37:34.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cnmEkFkd6iDvmQ4jveYiGsnH5YZ0HOsHjABjoaqzuXjkB0Wr7X8pe9qwIyrbmp5t0Kh3+blchkLHwTzGhyq2WpdXXm248qFSvS7vXkON4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB10826

Two fixes in serial_core_remove_one_port() and its reference counting.

Patch 1 fixes a deadlock between port removal and a tcdrain() in
flight, present since 8ca59f7baee7 ("serial: fix ioctl hangup race").
Patch 2 fixes a read of the port after its last reference was dropped,
found by review of the same path and not reproduced.

Reproduced on a MAX14830 (max310x) board, on v7.4-rc1 plus the board
support, by unbinding the driver while four processes drained a few
kilobytes each at 300 baud: the first unbind never returned, and the
hung-task detector reported the unbind in wait_event() and a drain in
mutex_lock(), with the drain "blocked on a mutex likely owned by" the
unbind; a power cycle was needed. With the two patches the same test
completed 46 of 46 unbinds with blocked tcdrain() waiters, each unbind
taking 2 to 3.5 s, the time for the drains to be hung up. A two-hour
soak with lockdep and kmemleak enabled, 1472 unbind and rebind cycles
every 3 s while other ports of the same driver carried full traffic,
completed with nothing reported. The change is independent of the
driver: it only moves the wait for the reference holders out from under
the mutex those holders need.

Tool use: Claude Code (Anthropic) was used throughout. It analysed the
hung-task reports and the /proc stacks from the stress bench, located
the lock order between serial_core_remove_one_port() and
uart_wait_until_sent(), drafted this change and the commit message, and
wrote and drove the test harness that reproduced the deadlock and
verified the fix. I reviewed the locking argument against the code,
decided the shape of the change, ran the hardware tests and read every
result. The code and the message are mine to defend.

8ca59f7baee7 is in v7.3 and is tagged for stable back to 2.6.26, so
patch 1 has to follow it into every tree that takes it. I will send
backports for the stable trees where the patches do not apply.

---
Changes in v2:
- Patch 1: dropped the paragraph on stable backports and the comment on
  the Cc: stable line (Johan).
- Added Johan's Reviewed-by on both patches and Tested-by on patch 1.
- No code changes.
- Link to v1: https://lore.kernel.org/r/20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com

---
Tapio Reijonen (2):
      serial: core: do not hold the port mutex while waiting for references
      serial: core: do not touch the port after dropping the last reference

 drivers/tty/serial/serial_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-serial-core-remove-deadlock-0310bbca5554

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

