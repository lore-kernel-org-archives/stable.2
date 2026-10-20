Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483373;
	b=wZo+r+WSpphCtdTrbeW8JtCzoJu7HW0m63K27sNUwd6MAg5wB0jNiFNZOzwx5wrntiKq
	 SlOWadpihtj9qWzjpWqeRwp7XcPIrxJI8InyXaCWbTvLPM/jZCgmmwDDsEBhGbGArHMU+
	 QKqwZxHWMtHsOksDagjYbAYKSSP5C26zmfTXB3hF3k16Ky4i8VFAamLcNSLgxajxmw3CV
	 gTO49Vjv6Vh01EdG5vfanEaOn6uslTIOpObeoiUzM4fRLmcF7MxX8o63dkiO7sO5XFHmy
	 3+xGjaO+p56bkTewCHG/xWxx7qBUbB/rLA5mhHDGNKQvncwdx4sqXZghBEy4MClmKaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483373;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3fBhBx14YdpQ6xbyzxedit+AJwOT1Pr9VEmDx8TyUgQ=;
	b=KdW+8GnC9ZxqccOzZWBNoRFpQ0DRqhijDPgC3i3lmC0rl+RaAgbL2hwy7i20joa3I+nK
	 7/HbOwd5ENyVUhHs6L6cy2AoW2Ke1/Vy8aydYiKG9D5gPdMdNgyf0BmrPWWyNV51Xwklq
	 T3ZBrLHBZmZeKw5o9K24tniAMa1mFhhW/YtOTqCzKj1e17bUlXTa34EsLwe0S1PKBcSAe
	 mS3QRTQuH0ZTUTuJExIQr7liYZlI3SUl9c/hHX22HOYA/ng5egucBiahAun8cn/EHNoRP
	 CczKiOgM+2qfulpouN2Bllu2OpM23dQLlriJY/qRPbmhO1c+teaxe0M7mrW2ZBmzL+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lG18CBLs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.46
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336A606A31B;
	Tue, 20 Oct 2026 08:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4336A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=lG18CBLs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8UZEP6q30aBMeoqml3OO69c7J8fX1ruXJAIJxvJXSRjucrICeToDFlzQW5xoG0gS6Yqj7RFqDWRQ/IVBnIeAd+3Pg27XlHiL2UcTTX4wtRxT9RIfiuInei09n7q03XNxJJQyjqaCXAnJXQC82qxl1P/ighqZ/kHicGIQ9Ch1PgDd3tyFY5Xv8T8FeQ5I/Xb9g6S4EKTBUWp8puRkdFRowe7dvvSFU9d9pn/700IpOTu+JxSa8Pf08NUzeKUmU+rS7k5StbUkap7BILCi7Wkhed02x9zWeZKtWWSkf5PMEnFrBUyeg+kLizxRzBskK462JDq2HHLRMiHH886i3pnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fBhBx14YdpQ6xbyzxedit+AJwOT1Pr9VEmDx8TyUgQ=;
 b=RIMvBXbnRk+j2SlVdjHKKiFcLJP5VPNrNB/8RfhdT6PEJkIEx3fU2HT0oIQh2CoFwPWGEoHcunhz0mhMHSPN0Q3Qr236xISnyMQUFtUZa7zyIs/HZlN2evc/3jf/h3sI+XzdRa8sFA0OdKPQoOyi2pbCY+s3veWjoC+gJ+VNCrCMJzYHG2x0nt1YQyp7NX6r8jdCDdXmYrDwUV7RkH9rHDWXlXNyGaleTc3bJyJlJKnjs1wB2HmhSwC7L0mnJ9Z3CZw9Vn6F2ah7L7IIDBNpQfhxIwWRRIVfxZ/RDYtUrq/mftXh68mbq/V0sysVDpUBiqdI2PtM8dHYetUdRLoTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fBhBx14YdpQ6xbyzxedit+AJwOT1Pr9VEmDx8TyUgQ=;
 b=lG18CBLsHDGem9Pk6QPeQtMt3U6gtjucOPqZvBRhieBM95i5ZpruRFqS/jCof1wNosgbgFYncbsouQ84Z2hGrbKF7Unz9wVRHqXYnAjZIKaLZn01DDZqEwmtm3Tex6jxJcoIiIx5kQeRDxZYUp6nJr0Y5lEH4yHZc6aheI6teoOrCMqZMdweu0IDngM0Iy4rHIVtJPJhMJZ4ojURvKFGhMb4qBuquKY0pOpWIQ8GTwbFdiBAAMFwWNaTs3H+n9Vy0Gp9nIQ8eCdgCvBUQo/x5Fq+ehcPVPOkRA0isyCp6z4N4AjGe59NFS+gQVFXlEdiKvyhotdjbOQgxb0fzysrMQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB7847.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:364::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 08:02:47 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 08:02:46 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "lee@kernel.org" <lee@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "pavel@kernel.org" <pavel@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "kabel@kernel.org" <kabel@kernel.org>,
	"ansuelsmth@gmail.com" <ansuelsmth@gmail.com>, "mike.marciniszyn@gmail.com"
	<mike.marciniszyn@gmail.com>, "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Thread-Topic: [PATCH v4 1/4] leds: trigger: netdev: Put netdev on activate
 error path
Thread-Index: AQHdUaZ8jmNgQHiK10qKx1ItrNv3Q7b+xl2AgAdpHYA=
Date: Tue, 20 Oct 2026 08:02:46 +0000
Message-ID: <cd3b43e958eeb97af33c23cfa6c49b7abceacfea.camel@siemens.com>
References: <20261001131206.2513248-1-alexander.sverdlin@siemens.com>
	 <20261001131206.2513248-2-alexander.sverdlin@siemens.com>
	 <179198456306.839288.14631216021466477145@kernel.org>
In-Reply-To: <179198456306.839288.14631216021466477145@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-2.fc43) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB7847:EE_
x-ms-office365-filtering-correlation-id: 4ffe313a-30d5-4250-95bb-08df2e8086ba
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|4143699003|11063799006|56012099006|261009220027099003|260925021911599003|261009221727099003|261009223027099003|261009221227099003|260925022911599003|261009223327099003|260925021311599003|10067099003|22082099003|55112099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 DL6f50yaZpVztx2JT8Ij9rXKARBTQNEzeUQMJTNvscN3PZ6JMIogQGHpQelvEkfTfhvH++vt+pvEycqMzoQFqnjp3V01dc42xIrWlLq1yoHS0RKVowFwkIBaXepBfhdJYBPeqBsynzjk5YmqIicawQp3PoR6+FOEO1s7ez/C7Fz61Im7N15CwzPulTayn9qermoh7QSXfLG6jreei/f50ggt0MX8itGuGBelAVcYA6M+XNBToedpBTjjq00jZtDUuLC1y0WFRGWHJQVX4zih50GgxRfMOoMkbLXbPx6XkaaGtvqclyCXDshWhoRLoulsczSyRqUHx9CAkjPgjicMw2GMIGKTMjhmHV09tdMt7tMGMcjnsVukweFHHYf/TIQW9lF/y2sUGpAZI6XfscIamxY8x+4sKmLBm6lhnYF9O7MidDiDSAzyfeIlxNJ4qzMmzdSviB/nipa9Cgv+JJKpbm34JDkZCq+ZXSUYSle+Su6XT68oK1M2eedOCCeyQp6xUcjQ0sn5S6SynTVvjajLHDPGXw5bS2oiV3ga7h7e7P8Da8aJOVyKOL0VobK/+O4Fw3HERbBINlAnBTvJ+WGqYvKmSv6VordFAMxtBon5ADCOaduuOetUeV6RRdG/i5SZBKa3657UbjCQlRpCeZoJNiOY9mzgYw+kyrAuK1cE3wM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(4143699003)(11063799006)(56012099006)(261009220027099003)(260925021911599003)(261009221727099003)(261009223027099003)(261009221227099003)(260925022911599003)(261009223327099003)(260925021311599003)(10067099003)(22082099003)(55112099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QThYcWt6KzFzeG9zRDVJRGh6MUMrK3IxTW5zc3VwMHdld2dRcndWV3J0N3oz?=
 =?utf-8?B?eXdiM0NsQXN5dUlNN211YnY3MmJmUW9uOTEraHNUcHIxdVVFMHJXL1Z2WDJ5?=
 =?utf-8?B?UUhhTCtIZFc0Q2QwSTBnVHNZSXc0NlZPWVRZVEdSTVBpVVZCanIyZmZzZkVB?=
 =?utf-8?B?cmNackdFSDROZGc2MTMvM1RvczdWSkU4MXh3T3FSeDJTUDVzeDJwSStESWdZ?=
 =?utf-8?B?MysyZDJhWjRkSnkyek1nNjZhK2VGODA5N21CMGxTUEtRMytsSmtOWUxBMHht?=
 =?utf-8?B?Wm1mZzlORThkVHpCREZSaEhya25nSFU4ZE43dFh3Qmt0dSt1ZE9HVisyR0Fl?=
 =?utf-8?B?TG95bWgwM0xtdjRCcWhiUWxPYVI0QWVlUUc2OHBpOVBnV3NiU3VDRndDdUda?=
 =?utf-8?B?cU1jMjY0VjkybjRUUHFFVWlzNXRvR1hiZXNqNVgxN3BtN2hZOGwxMGZXT291?=
 =?utf-8?B?b2p6NnFWMFlFNDNHOHlrTnRqMHB4KzNRV09DV3dYK3Vob2lHdC9tdGdkN0Jh?=
 =?utf-8?B?SkU1cng2a0tSVzRZVnE2Mm14d2JiSGhNaXkzYXQrWTlOdmtScW83WDJvWENP?=
 =?utf-8?B?VGo0K1VQYkxTL2dlVDNqWkJrRVFjUlR2dHl2Z1hQUUs5eDlveDhjSHd3N1FM?=
 =?utf-8?B?amhXTFNsVTlUOGQ4UjVZUFpQSGcxK3g2bW9acldZRGEzcEtpWDZBZ3hxTXRT?=
 =?utf-8?B?RWNTeDVFVDQ3VnFWWitQY3BnSU9xMmhSUU1BdTcxTk9RS3ZkYnlBcjY2d0Y2?=
 =?utf-8?B?WnRKbHNUMU1welJ3ZENkUHhyaFpzcFNmVmEyNFBJcVJKWU5jUFhyak5udU1q?=
 =?utf-8?B?YTZHcDNMeTgvbURsVTA4elVyOG5Gc091RXg5Z1h6cVRPRkQzb0tNTjRPQWFp?=
 =?utf-8?B?NlNiQ2tsdmd2Vmg0QXlIeVRkbUZBOGIwZzM3d0JPV2VmbzdXa0FjTHdsWWNZ?=
 =?utf-8?B?V29JRUlQMll3eUx0NXVxOGZ3T2JlcmQzVVJHQng0N2k3SXNSbHAwbUw1aE5I?=
 =?utf-8?B?a3lJWkZUUDVvenNvZGdWOEcyYWNTd1RTaWtaRFVNcnpaQWFYQUxITWFsd1BY?=
 =?utf-8?B?aTZzVzRZTXFpTFo1OG1heGF4RjJaemQ2TGErdTJiS0dSUUtJeHJRQndDc0k5?=
 =?utf-8?B?Q0Z0ME1icmJkVnhzcUZ4d0h5dWhCQWlRaTNxRDNSNjVrMHBYYnJPd0REM213?=
 =?utf-8?B?SGZVcTY5YWJWRDhhTDJVM1NPZmdNQ2RreHZOcGEzdFJsbkZ5YjJvZW0veklK?=
 =?utf-8?B?U3k0eWZwMzFjZ1BURHNLc2hjRUZYL0lONmJZeVdNVFhxNkpaaHhHZ0RrSzFK?=
 =?utf-8?B?bzA4U3NZSFdyRHZlSHlxZUlzaWpWUzlvM2R1amQ1eG5qK3doZDBPOEVhaTJI?=
 =?utf-8?B?YmtzcEJ4VEIzeXF5VEQxN09VNzlzVDJaeTVZQ2ZZRDF1RkdvdFlqWlVNUDRp?=
 =?utf-8?B?dVdYOUcxaXdDZGUvcDVQc3ZJV0o4SmRIdHdESXMzM2dmdUR0b2xoTmY3Nkho?=
 =?utf-8?B?clVLb3o5Q2V2TXJjaVVqVGNUQ2k2d0xtdzEvcU1TWGpXZCtVY3ZCWHFvQkRp?=
 =?utf-8?B?SWk0RUtReWNsTGNHMWxLa1JJOFZXSlowbWRBcjU1eW9VUW1oMmdKd3JBeUpt?=
 =?utf-8?B?Sm5OKzA2cXltSlJXV0JFeFdZYmd3UVBMSmxZelFiKzJyOFd6cWk2VklzdGRt?=
 =?utf-8?B?NjU4WUxuWHJlQ2gvNkJmUnhwZ3lkSlZMRys0WHB5blpDb1EwdzluSUhXenRD?=
 =?utf-8?B?dktLMVBTUG5MZjgvbllvOFNGdU1VL1Z5VUFzKzV5NFk2eUwwTVFwME40QlFD?=
 =?utf-8?B?RnNxaVpIOU5OOENUNXlLZS9tLzZKTnBmQTlCRjdsTklpL3RGQnpxUkxsTlhH?=
 =?utf-8?B?ZXhNRHJuTC92WTRXSEpVOFEwN2Qxa2xHRFhYSGJwTjhSR3hLWmxjMXpUd3F3?=
 =?utf-8?B?dXM1UHpUTnpMNlFHYVZsN2RrOTVkdThvR2F0MVpuN0FKZGpycld1Z0xpeU5R?=
 =?utf-8?B?REVWcUlScjJ6dnAyQWFvdUJHWmlhblZQTkR5ZEpoQTd4MjdvcEJUM0lrTi92?=
 =?utf-8?B?a3RGbGM2Y1ZpSWZRNWJkZDYxVVB0QU9UczdqVzFVZzdwcXpzbUg5dytEOTRm?=
 =?utf-8?B?R1Y0aW13L3d4Y29RdVZ2aWlsWGR2TVk3RFFEWXpvMldWRmFYYXlYbEhHQmhG?=
 =?utf-8?B?VkRVZ2FCTWs5VXN0MENPS3dKd2xZZlkrYTRUR3hvUit4Tm9PQmE3QWVkUlRK?=
 =?utf-8?B?R3JjUlZxYlptdzVwSVVPN052emVhOWRJSWhFZC8xOEFSWnhMU3BzQm83Z3pt?=
 =?utf-8?B?U3M1MGc4SkhhYlk5QTFCNlZwMmJ4QjZzbnp6NE5oQzlwbERZNHpxRFZuV2xN?=
 =?utf-8?Q?8aFgJDQv4snezzVs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B1E00C4C4F4FC4187395640E4BEEA86@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffe313a-30d5-4250-95bb-08df2e8086ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 08:02:46.0603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDeBepLeWBNqTYT0VamQcATsWbQriAH4qPoG6W7Jk5JGKd9HGHQq59rVukLWWrH+Mt5dqXpINHMlYN/D/ACrptMBBTvfQd7RrekKlg7p/m4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7847

SGkgTGVlIQ0KDQpPbiBUaHUsIDIwMjYtMTAtMTUgYXQgMTU6NTIgKzAxMDAsIExlZSBKb25lcyB3
cm90ZToNCj4gPiBXaGVuIGh3IGNvbnRyb2wgaXMgYWN0aXZlLCBzZXRfZGV2aWNlX25hbWUoKSB0
YWtlcyBhIHJlZmVyZW5jZSBvbiB0aGUNCj4gPiBuZXRkZXYgdmlhIGRldl9nZXRfYnlfbmFtZSgp
LiBUaGUgcmVnaXN0ZXJfbmV0ZGV2aWNlX25vdGlmaWVyKCkgZmFpbHVyZQ0KPiA+IHBhdGggZnJl
ZXMgdHJpZ2dlcl9kYXRhIHdpdGhvdXQgZHJvcHBpbmcgaXQsIGxlYWtpbmcgdGhlIG5ldGRldi4N
Cj4gPiANCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IENsb3NlczogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwOTE0MTQwMDQ1LkI4RjRDMUYwMDBGRkBzbXRwLmtl
cm5lbC5vcmcvDQo+ID4gRml4ZXM6IDAzMTZjYzU2MjlkMSAoImxlZHM6IHRyaWdnZXI6IG5ldGRl
djogaW5pdCBtb2RlIGlmIGh3IGNvbnRyb2wgYWxyZWFkeSBhY3RpdmUiKQ0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29t
Pg0KPiA+IC0tLQ0KPiA+IENoYW5nZWxvZzoNCj4gPiB2MzoNCj4gPiAtIGludHJvZHVjZWQgdW5z
ZXRfZGV2aWNlX25hbWUoKSBhcyBhIGNvdW50ZXJwYXJ0IG9mIHNldF9kZXZpY2VfbmFtZSgpDQo+
ID4gDQo+ID4gwqAgZHJpdmVycy9sZWRzL3RyaWdnZXIvbGVkdHJpZy1uZXRkZXYuYyB8IDEzICsr
KysrKysrKysrLS0NCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9sZWRzL3RyaWdnZXIv
bGVkdHJpZy1uZXRkZXYuYyBiL2RyaXZlcnMvbGVkcy90cmlnZ2VyL2xlZHRyaWctbmV0ZGV2LmMN
Cj4gPiBpbmRleCA1YjAxMzI0ODQ1OTRjLi5lMmE2Yzk1YTBkYzk3IDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvbGVkcy90cmlnZ2VyL2xlZHRyaWctbmV0ZGV2LmMNCj4gPiArKysgYi9kcml2ZXJz
L2xlZHMvdHJpZ2dlci9sZWR0cmlnLW5ldGRldi5jDQo+ID4gQEAgLTMyNCw2ICszMjQsMTMgQEAg
c3RhdGljIGludCBzZXRfZGV2aWNlX25hbWUoc3RydWN0IGxlZF9uZXRkZXZfZGF0YSAqdHJpZ2dl
cl9kYXRhLA0KPiA+IMKgwqAJcmV0dXJuIDA7DQo+ID4gwqAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMg
dm9pZCB1bnNldF9kZXZpY2VfbmFtZShzdHJ1Y3QgbGVkX25ldGRldl9kYXRhICp0cmlnZ2VyX2Rh
dGEpDQo+ID4gK3sNCj4gPiArCWRldl9wdXQodHJpZ2dlcl9kYXRhLT5uZXRfZGV2KTsNCj4gPiAr
CXRyaWdnZXJfZGF0YS0+bmV0X2RldiA9IE5VTEw7DQo+ID4gKwl0cmlnZ2VyX2RhdGEtPmRldmlj
ZV9uYW1lWzBdID0gMDsNCj4gPiArfQ0KPiANCj4gR2l2ZW4gdGhhdCBib3RoIGNhbGxlcnMgaW1t
ZWRpYXRlbHkgJ2tmcmVlKHRyaWdnZXJfZGF0YSknIGFmdGVyIGNhbGxpbmcNCj4gdGhpcywgd2h5
IGJvdGhlciBjbGVhcmluZyB0aGVzZSBhdCBhbGw/wqAgV291bGRuJ3QgY2FsbGluZyAnZGV2X3B1
dCgpJw0KPiBkaXJlY3RseSBpbiAnbmV0ZGV2X3RyaWdfYWN0aXZhdGUoKScgYmUgc2ltcGxlciB0
aGFuIGludHJvZHVjaW5nIGENCj4gaGVscGVyIGhlcmU/DQoNCkkgYWdyZWUgb24gYWxsIHBvaW50
cyENClRoZSB2MiB3YXMgaW5kZWVkIHNpbXBsZXIgWzFdLg0KdW5zZXRfZGV2aWNlX25hbWUoKSB3
YXMgcHJvcG9zZWQgYnkgQW5kcmV3IFsyXSwgYnV0IG1heWJlIEkgd2VudCB0byBmYXINCmNsZWFy
aW5nIHRoaW5ncyB3aGljaCBhcmUgbm90IHJlcXVpcmVkIHRvIGJlIGNsZWFyZWQgYWN0dWFsbHku
DQoNClNoYWxsIHdlIGFncmVlIG9uIHYyIG9mIHRoaXMgcGF0Y2ggYXMgaXQgd2FzIGluaXRpYWxs
eSBwdWJsaXNoZWQsIG9yIHNoYWxsDQpJIGp1c3QgZHJvcCB0aGUgcmVkdW5kYW50IHplcm9pbmcg
ZnJvbSB1bnNldF9kZXZpY2VfbmFtZSgpIGFuZCBsZWF2ZSBpdA0KanVzdCBjYWxsaW5nIHNpbmds
ZSBkZXZfcHV0KCkgZm9yIG5vdz8NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI2MDkyMTA5MzI0OS4zNDgxNDEzLTItYWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tLw0K
WzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8xM2U1ODEzNy0yMTA0LTRiYTQtOWQ0MS1l
MzBiYTVkZmIzNjdAbHVubi5jaC8NCg0KPiA+ICsNCj4gPiDCoCBzdGF0aWMgc3NpemVfdCBkZXZp
Y2VfbmFtZV9zdG9yZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gwqDCoAkJCQkgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNvbnN0IGNoYXIgKmJ1ZiwNCj4gPiDCoMKgCQkJCSBzaXpl
X3Qgc2l6ZSkNCj4gPiBAQCAtNzc2LDggKzc4MywxMCBAQCBzdGF0aWMgaW50IG5ldGRldl90cmln
X2FjdGl2YXRlKHN0cnVjdCBsZWRfY2xhc3NkZXYgKmxlZF9jZGV2KQ0KPiA+IMKgwqAJbGVkX3Nl
dF90cmlnZ2VyX2RhdGEobGVkX2NkZXYsIHRyaWdnZXJfZGF0YSk7DQo+ID4gDQo+ID4gwqDCoAly
YyA9IHJlZ2lzdGVyX25ldGRldmljZV9ub3RpZmllcigmdHJpZ2dlcl9kYXRhLT5ub3RpZmllcik7
DQo+ID4gLQlpZiAocmMpDQo+ID4gKwlpZiAocmMpIHsNCj4gPiArCQl1bnNldF9kZXZpY2VfbmFt
ZSh0cmlnZ2VyX2RhdGEpOw0KPiA+IMKgwqAJCWtmcmVlKHRyaWdnZXJfZGF0YSk7DQo+ID4gKwl9
DQo+ID4gDQo+ID4gwqDCoAlyZXR1cm4gcmM7DQo+ID4gwqAgfQ0KPiA+IEBAIC03OTAsNyArNzk5
LDcgQEAgc3RhdGljIHZvaWQgbmV0ZGV2X3RyaWdfZGVhY3RpdmF0ZShzdHJ1Y3QgbGVkX2NsYXNz
ZGV2ICpsZWRfY2RldikNCj4gPiANCj4gPiDCoMKgCWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygm
dHJpZ2dlcl9kYXRhLT53b3JrKTsNCj4gPiANCj4gPiAtCWRldl9wdXQodHJpZ2dlcl9kYXRhLT5u
ZXRfZGV2KTsNCj4gPiArCXVuc2V0X2RldmljZV9uYW1lKHRyaWdnZXJfZGF0YSk7DQo+ID4gDQo+
ID4gwqDCoAlrZnJlZSh0cmlnZ2VyX2RhdGEpOw0KPiA+IMKgIH0NCg0KLS0gDQpBbGV4YW5kZXIg
U3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
