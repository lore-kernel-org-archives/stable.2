Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793788051;
	b=yG8ORfBy6A0m1bTnuDRLHUTVr4kbz1AxGC5/fqq+brNGnKjunVkuQTdxTSeF5Fx6VwAG
	 x2jxUIXUGsfD2tlzzRkRh4tKga8qxqVZ/RVp8NjFV1UeAoPG3lTzHQ3HBoySVkASDCVyz
	 UxTLBHczYYOW2NMsmewOvC78CkEGXOSc5NM6Ull2pQ+IrpJ5DPJiIAPUf977oeR7YVneY
	 mBfbvh0pt7Lut1ScSrhIl9POokeSdmviDjehlntwsfugq2KKkX91Ew8aqX85dKFXxgz96
	 SQZWOrK3BoBW8jm9Fb5bLbJ1BVNYoyWrmZV1frY6KsCzQ0NX9PmTC6/yTtLDjZiqH9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793788051;
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
	bh=vS1czoyGGGoc88HdrSqOob64iun8K6WqkOKRA5EMS64=;
	b=j9OVkbyR5zUxj/fgXiyq3nf+aV2iqTXciYMXO/RZzYe7rZSeE7xipIgzdWXan3aKL/yp
	 xPFdjujbxHhcCp7o3CgG1CvKstbxebbIyCj5TRyYGUZQp0xinK51BMVm/Xq2+gJahsSDt
	 /3VKVS9FuFFXbz2sDDhcydfpXL1/npr89e8TDaW5f9NiUjAgaiTQgps4QuElNQccfJTdQ
	 /0DFb4N5C0vKrBZRd8htgLoCW8UgVHsHii9+qpIOvliYfOeuLzR3NtTn4MTPNTKJXbxBK
	 oo3ja/bnCsdPkwofVd5zXrYi3bPcsNcA0YGOAg7vS8b+TmMTryo1kpIRqDaE+Wg640A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b="ywPLa/b4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.113
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023113.outbound.protection.outlook.com [52.101.72.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203BA606A328;
	Wed,  4 Nov 2026 10:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203BA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=ywPLa/b4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGo34JwTTgQqoGrnkNaBHqgmcg6FZUsWuPjC/0tAjEr3Fem+1/2aoSbzth6HxtPcxpqawkxgbkLvWwLObfpKd2/eE0xPcu/vVXLU4JJ1Jxj6wu5qLYCOIkz6jOVCb38HB7F+HcWS0baFDpubM2B/5sQKwJp6RF+AVP9Ti7wjf6Cuk0WJ6IxRhNymnH5mLvPMgUboP35O44fmPOMKv9f5rt8PyfU10oat3DxqQahaeTpTdNsMtIQPoYPWCk0FGoKU2zg9y6aoeTAJ3s7Pdna5d/wsTq7fxMEGq8WJKJUjcq9BLCpBDmWm2VNRJEtNmSFJnhTc+qoW1827b6mGR32yYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS1czoyGGGoc88HdrSqOob64iun8K6WqkOKRA5EMS64=;
 b=kFwXTncTH2vwiZjY4MGBu0FIT4oRISXdf8sBoIeQBPLMsviyPJn+tylOLhE/5TPPICqi5psOv3Ks1sSx57O+mRUJzMo4w3kncfoTRZXA0fGiNMxG6bJrCZ++7PH7A+S6ZeB5nmXezCqPFOjeBWbvlfGGDZ5Z/qKNNmAUfSMxXFej1SiUkG60t6oFlouWat32XUijYT8NU2OQJkjw4dyMFaIU9N3UIbNmRah0f7atj4NAHFEhBoK9IIMUad39RqL3CSJVerWsqC6ZL5RnJiIOpUPCXJHdOkYNBAoVtWkjBm/JeTj1Zb/mCrb6Oj7fKtxsl2N+uZXGwGp1WETNv5X3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS1czoyGGGoc88HdrSqOob64iun8K6WqkOKRA5EMS64=;
 b=ywPLa/b47R9KoTtoq947OvOXDeowf0z2EJcCmZCJrRQWE8wknV4gsL+HP1aqv8pSYdboZmZ+j6bFl1olNkJ/ULscYlsO4lweZzqQj1NizwhPtoXVKQhF+5vyqkkdn+/6igM+F8skQJxw7NJ+G6MtoIdcXkQsk4LwtZ6+b9iOdwxdv2J+MjQOX8JhXtqflBVbScH5UUBljQGQl1x6UH3eM6FQvHhcaHcK0ZED7pCNQ6Bv9rGvUBnBygoZckVSZxEr1qG+/TjgYQjSdecAIbQfremP49Tx2gp9atqXgG3eNMWeOgVYVf/X69DdoOjafhkBQq0BpwKlMfwb7Rj+jej6rA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by PA4PR06MB7199.eurprd06.prod.outlook.com (2603:10a6:102:f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Wed, 4 Nov
 2026 10:27:24 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 10:27:24 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Wed, 04 Nov 2026 10:27:15 +0000
Subject: [PATCH 1/2] serial: core: do not hold the port mutex while waiting
 for references
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-serial-core-remove-deadlock-v1-1-6a30597adcbf@vaisala.com>
References: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
In-Reply-To: <20261104-serial-core-remove-deadlock-v1-0-6a30597adcbf@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793788042; l=2860;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ZFIVMlJMVMfNye467SURZK6vIPx9Z8n4vYwpeSfFFIk=;
 b=Fl1/fgMR0e0u3Ukg6/gZFDY7ykUPS3NAbF2UU46chgHIP5tGDEDALweU9qSSLYE1KadTq6TOS
 ip2odSS4w+DCQ1esnR7PucnnIHpux4twt6sp6x74KAMH+m5SgasUD/z
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
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|PA4PR06MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: c04252bd-486c-4ca7-a7e4-08df3a5e376e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|23010399003|366016|1800799024|38350700014|10067099003|18002099003|22082099003|261102123227099003|261026140227099003|11063799006|261026121527099003|261022075727099003|261009221227099003|261028144727099003|261009223027099003|261022105027099003|261021123027099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	uYw0KPoVhL+B2LxPxLV5ZbB1rvE4VrE/Ka/Kzwrt4psS5n28ZD50QttyprYky3aWm61FexRNgelHLuG2jNUyujYI45MkSbIN9/sKvO7DD05sVUIS5s6opri+TMni7ljihFrmhj5/CKZcasl8QFkB6aDfymCpq0108bECUN+m834aFH0N08l9Eu2KQJ8FGgVa5JZtkYwnZQ4hE/cSD+Lvoe3AZDb5EgliW6/Awedqps2VS24Cm+mNv03WKVC8xEvalKQNL3nnb8zPTEd43RzB7jLpmHOo4B79/apZAHUlhUe2X/5gfjaLfaTMe4cyCNjUf4S3CqrBaN1ay+T3ddxz/tjqMQRPeOAIa/0tSk8RkM9ZYDnuKEH9cccZgsxq7uZoEpylWgjmwltSePZcW8XGSoPU5M8JoIbK97PS/jIYDuTHpLyQv22dAT0y0hZ83VVhElL9Sapt9FlL3fsQ4cZltJyBDCjaGyuXs1d1xicZIxN9LUYEeGszrzIYeKjCUt1waBm5Il+0AdHU1fSdp0CbSQI31ncClVlJVuzLv6q0CTj2QUqox5fqNmzD9G6r9ChGYkNpIkZnapqPEBQgeQhuoEb6+twOvHtOszt4S5YHcY9qrxp9eUXJlTiozaJsmc9dlq+yIE0gZIrJPs8Ua4KxLglUWF8USlhhhs6jRvaSsw80X6Y8C7vAx+BSNDOO6Dn41aDRgkZE7uqk+YjKGXAk312250A9q3LUEAwuU5Zaaok=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(23010399003)(366016)(1800799024)(38350700014)(10067099003)(18002099003)(22082099003)(261102123227099003)(261026140227099003)(11063799006)(261026121527099003)(261022075727099003)(261009221227099003)(261028144727099003)(261009223027099003)(261022105027099003)(261021123027099003)(56012099006)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE9zOUt3S2Z4dXNndzJaSkNITzZyRFg3QTJzOUc4TGIzbzVNdmFWcFk0Q0Yr?=
 =?utf-8?B?QVI3WWRHVVJjcmpIZWE5ZEgwVjVYN0hJUUFlcFhwYXB5RlBieC96d2NYbmpj?=
 =?utf-8?B?bUI0c0Z4SGhqVVBMYk5tbmhFM0hUbmxja3UrRHE3QWdCbUZpSlVFZUs5WEhI?=
 =?utf-8?B?TTN0cTYvK2V6WmtkUVhmY1J5TXlhYjJHMWJMT0FMNFc2ZFdacGJIU3F0ZFlo?=
 =?utf-8?B?L01uV2R6REQ4aThvQ2kwY1JBZ2I4Z1B6THBIK2lIOVN1cFRnNnNWeWdXdUpr?=
 =?utf-8?B?Q3MwYmduZDdORmw1bUVuTFRtakljK1plSmRvdFlIenFub2JWZDFtMEdIZkg5?=
 =?utf-8?B?NDc3S1g4c2Jsb2FMYitCRUttcHgvcGZGVDI0aHRuby9EdlE0TzBCdzExcVJ3?=
 =?utf-8?B?cGc5UkdtQ0RSQWw3TFpKNCtMakFaaURqd25IUUt5dWJLcTJVNkJ5MnRLdWhO?=
 =?utf-8?B?T1FjeU53SnZBR1BJMHUvQWpMaGcwdWx5NVJjd1Q0MEdxQk0vcEJQVVB6R2NK?=
 =?utf-8?B?eml4aXhQRUg3ZHVOYkxKdmN6OWYvTHNlUFJCRjZ0TnpmekF6UTBoMFNQUzFl?=
 =?utf-8?B?Y1FmTDRsYlhQd0ZFWmthQVIrOWJqVld4eHl5VWNhamhXallXdSsyMFJXaUl3?=
 =?utf-8?B?bmk0QnpsTzFERUFOdXZUNnNHcHdmSGw2eEVRRUo3MSszTlpLRWxxVUlLaC9w?=
 =?utf-8?B?ZjdwMDdGSmVCOUFMMXdsWG45SnZiMXRIYzhFNDYxQml2TXVpZFJBR1ZRUTBV?=
 =?utf-8?B?Ky9XMm9sY3BzaC9UcER3d1JvVUlUQkllSEdOOTVHUWhzeEpoQUV6MXN5QXFa?=
 =?utf-8?B?ekRvaEFIN3hhU2N4V1FuNnlXRlp4WmhpL091amttV0MwY1hBZkp4R3BYa3U2?=
 =?utf-8?B?L1ZnVm40Q3RnMGx1SWtjWHF6RHNSRmZIdTIxcUhUQ052dnY4b2U1ZW5uRHZ0?=
 =?utf-8?B?dTl5ckk5a0ZZNjA5NnZwTmZCUnhSWm5lZ1F4enB5aS94WTcyQ29XRzd0U3ZX?=
 =?utf-8?B?Mm40dERuS0ZPcWlLNm5qLytrM2F4bWJsRVZQMGZlbVB3ZTU2RS9MbXdxcjhY?=
 =?utf-8?B?MWJyY2xGMTduV2lzZU4wa0pXNjhWVmt1dXJMZmUzbnh2Ym15NkQ0ZzgzM3B4?=
 =?utf-8?B?WGdBZFRiSWJXYnpiTWp1QWo5YWg3ZTF1Y2RRWnNtZXhEZWF6WFZUeDVCMkZm?=
 =?utf-8?B?RUgxazdCNVN0SUwwRFZBbWxDQ05ZcE5mdXlwTytURWttR3lpOEk1RC93cmRy?=
 =?utf-8?B?bFlpcThpL3BvTCtiZVNobzBGV1BsWVpTY1AwVks5eThhOFppRlhpbkxkVHFv?=
 =?utf-8?B?ZVhjeEJ5Vng2OFdOVU85L0daSHZSeXF2S3AxOTI3WXpXbFRYYWN4ODJvZkNx?=
 =?utf-8?B?RkN1c1hsWHNyakRkNStTcWRhQlFFWEI4QUFoVlhuNzJZZTV1bnZ4U3NVUkY4?=
 =?utf-8?B?YUZqYmhxYVAvWGQ1eTdkSzRuQncrNGh2ZkljTW1ZL3ovK3RIbzdTdCs1UzQy?=
 =?utf-8?B?UExleDJYWU9Vb2d5d3hxbWJBRjlJQytQRlQzYTVpSjNwMldzUHQ5V0pkeWJh?=
 =?utf-8?B?L0xjR2hCeHU4S0dub00yWHJmcEY5Y2tuK0ZoNGtrTVJnTlpXN29ITHdPZ3Fh?=
 =?utf-8?B?UWhJRVpzdjErWWthTEJBTXgvMmphMnVNcUhhN0JWWit4OTY1anJ0MXQwVkpq?=
 =?utf-8?B?M2dKajJMWnhKekYwU2x5VCtLZmE4NERJSlY3WEFYVHY2b0o1RWRMek9tUnNn?=
 =?utf-8?B?OXhPblNGdFlpcWo1ZmtkTzB6R01SSGx0NUhOQTFBV3R5QlRaakRsNW5BOGtY?=
 =?utf-8?B?dGYvb3dkOHB5UDkxQ3dSWUZqYlh2WFVzMGVWUUZzWWpRTDV2SUZZdlFkdk9t?=
 =?utf-8?B?Qi9WM281SGVtQkh0VnVVd3ZlVlgwalJpTDNOMHVqQTJLc050N2xTcjd4WStY?=
 =?utf-8?B?K2N6ZTRrSXE1dDlibCtyNUp0b3ZDME9wYWRiTmt5Qkc5SFVTWm4rcnNveWlG?=
 =?utf-8?B?ZDJhaXdlS09LNE0xNHFHOUNWeXQ3VlRQTzJYZ2kxY0t3RTNLUXVYYWc3b05y?=
 =?utf-8?B?MVlVVG41VXVQTS9TTmxORlNqR1ZtMy9ZZWpkc2tIMUVxRWNGbWpVNlNDdkYz?=
 =?utf-8?B?d0RwSVlYUFY3YXdBV21ZaEhDZktJRzV0Qys2RFZBcEd1d0ZNR0ViZ1lkbE9I?=
 =?utf-8?B?RytaTE4yM2JtaVc3ZkI2ZmJINTVxYUVwYTBBeERPYUpwWHEwaGU4UGtoRVVw?=
 =?utf-8?B?VjdMWkpSWFhuY0tQWVF1TysxTnFTcUFJMUpsakdJU2tvZElwWnI4VTh6Wlh2?=
 =?utf-8?B?c0FOd0NCVGlTMktKUVRleTFXUFZzZ3hQSGtQeEJtcWFQOTQ3Q1hCZFpHa20v?=
 =?utf-8?Q?HvqefTQqXb9PYBQo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04252bd-486c-4ca7-a7e4-08df3a5e376e
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:27:24.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RA4WzSmLZDm6wZaFR/5wwu3saN2JhuyiHwrpCGyMEH4uHmyFvI4BY8xmRK8mh0VEovatuYqodrfpGZPXXeTKwA7ZGxdAjeUohRX896ruS0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR06MB7199

serial_core_remove_one_port() takes the port mutex and then waits for
the uart_port_ref() holders to drop their references. Since commit
8ca59f7baee7 ("serial: fix ioctl hangup race") uart_wait_until_sent()
takes the port mutex on every poll iteration to check for the hangup
before it touches the hardware, while holding its reference for the
whole wait. A tcdrain() in flight when the port is removed therefore
deadlocks: the removal holds the mutex and waits for the reference,
the drain holds the reference and waits for the mutex. Both tasks sit
uninterruptible, and the port is unusable until a reboot.

Reproduced by unbinding a UART driver while a process drains a few
kilobytes at 300 baud: the unbind blocks in wait_event() under the
mutex, the drain in mutex_lock(), and reading the driver's proc file
blocks on the same mutex.

Drop the mutex around the decrement and the wait. The decrement is an
atomic paired with uart_port_ref() and uart_port_deref(), which never
take the mutex; the clearing of the port pointer stays under it, where
uart_port_check() readers expect it. Between the hangup and this wait
the removal already runs without the mutex, so a mutex holder seeing
the released port is not a new state.
uart_wait_modem_status() takes a reference and then the mutex in the
same way, with a smaller window, and is covered by the same change.

Stable trees before the guard() conversion of this function need the
same change with explicit calls: mutex_unlock() before the
wait_event(), mutex_lock() around the store of the port pointer.
7.3.y has the guard() form and takes the patch with a three-way
merge.

Fixes: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Cc: <stable@vger.kernel.org> # 6.18.y and older need the open-coded form, see below
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/serial_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c0deec0e6af41db10de15ccca4169c603d9cebf6..2e53d194ecfe853ade1ac6f33e047eb8ff11e283 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3266,10 +3266,17 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	uport->type = PORT_UNKNOWN;
 	uport->port_dev = NULL;
 
-	guard(mutex)(&port->mutex);
 	WARN_ON(atomic_dec_return(&state->refcount) < 0);
+
+	/*
+	 * A reference holder may need the port mutex to see the hangup
+	 * (uart_wait_until_sent() does), so wait for the references
+	 * without holding it.
+	 */
 	wait_event(state->remove_wait, !atomic_read(&state->refcount));
-	state->uart_port = NULL;
+
+	scoped_guard(mutex, &port->mutex)
+		state->uart_port = NULL;
 }
 
 static struct serial_ctrl_device *

-- 
2.47.3

