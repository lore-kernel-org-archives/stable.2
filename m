Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.75.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792592096;
	b=2W4LpW2p6uwsNI8oZKEatngT36UMqnXNe48qQDpOyp0v1szCk/6MGijn96XH/id4pUrv
	 oZw5cHqThbx/WwpHW83l3z2aY2BlqDnwQy+JUR3mqmJiflo7xsCa9qgH3zZYYceaUf/Tr
	 cz/7/FLcFo9103teyX6Kzv/br6Huik7xRSoYy789wW92MaRuyt/238Uo4C6HziDuqwidD
	 1VPec5uTBnTAnw60OqydIMX+mgM4oViE5Q/Aq2182Cd/pNSgegqbEqkbt+TwpVYi4GXnP
	 6xsJVWV0WlUAp5dvd3HedY0PvgNFJuiqgCGeW6OoeuBvByXZJVkh/KdqR3IxvkiZcMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592096;
	h=DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=qYizYxwSUwgBb+dDkFOx1xIdGwm+OcLDgeA0dV2ZtbY=;
	b=E9zjyfGkRWdVYh3XTNBVWL7Ac4YnyHGzLX1HAEwqN/ABh76qWpHhhjcB3WXkhBN8shrS
	 wzb+U0CKrReUuyoIBLZn+emJOYyeI4dvMJ4WPMwcPKSUL7rPqA7OTxjosJAy570FjeJVN
	 y5e9/A5zn0d9LI5Hh+ZTXv3nGEX8sWgrV/uYqNcjoiPW6eeyGzk0cOzxhsWVXU0J1fEGP
	 wYVz1FALPCvKhPldMOdoj8JmNCWTsJXwSGXHpLnsDrU18mDRAZbY6npU+S9duOqsDCzO4
	 XNpoY4zVHqGT3dVbDwnvObD90pQm9GoX9EFl5ixrTpIjL8izrRJkCEZB1tAn4xSElyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=YlP+9OmX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.75.142
Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020142.outbound.protection.outlook.com [52.101.75.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040EE606A319;
	Wed, 21 Oct 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=YlP+9OmX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtLDsmnao3gq5MmDkTMAlgwen/FPlKiQLfZ+74Pb/yFpkN4/1PyUJnMsHApHse2GmS7cSgGMzHxg4JYxo+JJRjGd3cABsLz6VZ7Hj1QI8i9lQS2y3dpc5G/gXchNtkmb78vZVy+zNSQN47+QdsdwjUX7bT++fdSl9mcwvTPm2juv55jSX1QfQWPNoTxt71xP+8LT3DqWh3XTBbOE6lYmq6U5vWHsvoM/2Cc7TKjXdacieCyPIJKxR8Kz8Xyhrcv6AroCO3kIj2I+6bC5yxI4jv12ntqHXy1yzfgFzmyiAdIZ3tRJl/eT+5PYsF43Bze+y6Ca4Mug0gjmLLHcWn32aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYizYxwSUwgBb+dDkFOx1xIdGwm+OcLDgeA0dV2ZtbY=;
 b=yC4UjgMSEK0uh1FWKaqKj8JL/vtUMiWoHapmpp6l7+mm8qVS26/eQs00dY65vllFEJLvl2Ucef9HH7dHrs1O1lqr/ObBWCjOKAwEb01ehN+wMgQmzvUKT3wMQGY+aRJr3rCf/d+wA1dWhPEaDLbs0PNAhhSyiaxh7jW8Xb5mk4UVNJjqO8kEb23V9++0X5u9K0SRWpm0OGrpnHRxhSYOF3RKq7UZvgxuOpzlru66phkEWWWifPo697PYY6uSDSDWEK6PvcK27RI9rygrROUjtVMgd95E2vfkpcjelwX/CGB4PMt8QNEj+ebAe4XQ1xbCKsqAIrWD80kJ0SmDzbJULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYizYxwSUwgBb+dDkFOx1xIdGwm+OcLDgeA0dV2ZtbY=;
 b=YlP+9OmX1galKMrg/p/Nvl+3C+EPEIvEZ0tpFIXGp9+a8rA5+7/05i2mdt83qZlpHQXSUQ6b8GxJ2QMqaAT5z7KpmEMK4xw0BjKZa3EmatPIS27xRVR9pcZSCHhPWwBZ24Pj3bBbiagNLV/MCJwymTbHDI2D/Pm/Zv3u/VkW5NXzFbnNw2rtf2kksjrGuQeIiEX+L3Wp9WnhulWBV6Q+4b2ZtARG96mbPRf7lNc5hRD7zeJlIdyaXs+cQE7lqA+0Kvn2zb2B9pkf9GX+NEL8r7FxezxleQRGNtdheRoGxrNxWmWkxb4yJxMWGAf6bjzlOR02vVNdGLF+di3FAlgSTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV5P280MB2219.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 14:14:49 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 21 Oct 2026
 14:14:49 +0000
Message-ID: <84a43e75-6302-4115-9e68-90576a88163c@gaisler.com>
Date: Wed, 21 Oct 2026 16:14:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sparc64: flush only the aliased page, not its
 whole folio
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928132102.1707-1-kaloz@kernel.org>
 <20260928132102.1707-2-kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260928132102.1707-2-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV5P280MB2219:EE_
X-MS-Office365-Filtering-Correlation-Id: 34368836-3ae9-4009-89dc-08df2f7daabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|4143699003|11063799006|10067099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZbdhtMmn2Y+LCwMKwn3DMYsZEtkLByL/1ZR++HOcQ62CX4SvlrC1eHuPyeitDPbgkswVCyQI2F2ycTKhnDHu09bEHqhMnJwrxb6XTXlGdIcOGErt7Swhy/Fzg2gjVOede01RXn4kIkT6gywPlgAzWPFn2IZsdJgbApNG905VAUqsEex1mcv6nK+JcdWJB8SxdMcNrqcstfY4I190VNkBPH+VwH5Zgrm2Q3g1uHOmTG2T1hedL7YHZcbZi64SJJJpIanOT2hKOI3Vg2fABdgkakYdxCWlo8ZCABObRTsX6cfCnRLJwXMbNIlNmc0HGOmG7klIk8Ijj9Wp16+aE19kSKK5jY71UdRPRvXYYaM45kbdtqla8tr4ZWWlFoz59R/t1fj584x6Y0AR5BWUdYWxg8h51J9tWqEOWvllj2YWpgbX4roLyKgGReZ7voaQb+7DsfFSqBXovmJKEjEzBSayX6VZxiMoZMN6lMx2/StWWJOzkeIxoi5u+Fj1PhgrfSLQTtRj50h4BJntTBePOOwHBiSj8Z+ScaspJTE2oFJ/m/akr2L+SYJ43aNuaJ+QfwhnH7FZK5FCUzwtEeHQPnYdFMvP5R0kNfLrfzhSMj8SiGWsTldMv7fIKODBnE6PURxvmb1KPN33SdgpcxTce7dZo0iSOtfPTRpSn8UnpAXVijM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWN5QmI3UDZWTWduQ0pxUkZ6U2JNWGFWUVBmMDh4cThMV01SVlhZWWVJMjdC?=
 =?utf-8?B?UzFkc3VVblhpU1lpMDZ5RjlQL1pQRm40UjZSbExhSFIrOGwrUnRMLzVvSUlH?=
 =?utf-8?B?RlhjeHRucTN5YmJtNzlaU1N5V3pEYmJxYWJkY0UycGhocUhaSnFTNVJxWm9m?=
 =?utf-8?B?RmRSU0FNcUw2dkZHNi9FTGlCd3JYL0Y2YUVZWGNmQzNScklERFEvdkNGQjdt?=
 =?utf-8?B?c2pzR08yUXp5bXZsSkhhZ0RqdUhmaXR5WVc0VUxiYjFZaGJ6MVdPcVl0Zm9k?=
 =?utf-8?B?b21Pa0IyZEdyM3ZKTHR1d3VSMEM2bERnaTVqUTBsZi9vUUV0QTV5OWYzeFMz?=
 =?utf-8?B?cXpRY1pPaDl6Qzg1RU5WNzZjT1Z3RVY2dWd1VTZVVkxOMlhDcEVPQlF5RWpl?=
 =?utf-8?B?d2FZMlJSU0pzYW5idHozQUFieFQ4eGoxd01STldJUmJ3bUEzenNCZnF1cUtX?=
 =?utf-8?B?cFJZNFRUODk2eGkwUU5EV2JLSzFOWnM0K1NlWml2a0xlQm1pekFZWCtpWmUy?=
 =?utf-8?B?d25sUU0xYnYyTTYrQ2l1SGQvNlU0VHpLV1NSazRmV0ExbEFhUWdtRzY4cWQy?=
 =?utf-8?B?RWVMQUowajIzWk50bEk0SkRwN3lIQVhLOWRRY1AydHhvd0RvVTF5bEFhWlo5?=
 =?utf-8?B?TnBRTEkzNzFnUG51NWl5Z2tBVDNNRnhidFhHOW0xb3k5Q0hhWkNSb2ZRSU94?=
 =?utf-8?B?L0M2RXlkZjh3QmtwNkFscldEQUc1M3ZrQVU5Rm9zcCtuSWtJbkZLYzgrQlE2?=
 =?utf-8?B?d1dsUEk4V2dQQ1U1TGl5dHdUMzZ1UlVRUDRlL25lRmxCNEJkcDViSHRzOVFz?=
 =?utf-8?B?U29rTUZkQjlRa0FYZFNsaFB4RW8veS9TanQzell2UTRVcjlNbFpUYmRqaWZE?=
 =?utf-8?B?VzJORTUwSGR3MTUwK3RQUGF6Y3UyU0JEOHFUREhMLzdYWm9BZ2d1YVNmQ0JQ?=
 =?utf-8?B?WDAweWVFMHVIL2FpN1pVb3gyVHdKOWtyQWNjSWFNUWFnVmFRbEpGMlMxOG16?=
 =?utf-8?B?SjBhY2JqN21BMGNFSjQwRElvRTlWMjZxaWVyeUh6d3o3QXNwdHRNREZPSkF2?=
 =?utf-8?B?RUFpbEFLNlF0ZmlpSDc0bkFxRk1PSzJZYys5b2pydUlJTnRrLzNTSGVlZ1Ru?=
 =?utf-8?B?aytmOERLeDc5V2ZqL0xUTWt3Q2NVMTJ6UDlpTFJwVDdHd3l6WlNTWENRNjVK?=
 =?utf-8?B?Q1hKUEtoNGRaYi81elJ1SU5ZeXV2S09BL1BNRTEzZTM5SGc2Ti85SjYxNHAv?=
 =?utf-8?B?NG5HZnp2SXJaR0o3bUhwbG1SSVMwOFpMSWlJQXM4UmZkeElGcnJjeWg0Ym5q?=
 =?utf-8?B?ajZ2QUh3RDFoWW5yTGdBNTBLSGljUStzSEpnajVOeU8vZXZ5czNwWDgvTzVO?=
 =?utf-8?B?aDQ5dTZOVFJNcllLaTJOSHBXQk1tdmQ3VWNSb2tQejNrUmZNZ0NobHgydVFh?=
 =?utf-8?B?RkEyeW4wdE0xazJ5UURuTWhIak1sN3FSYTVjL1ptZjREbFlrRkRmYTU0N0tK?=
 =?utf-8?B?TDRIYzhGTUlkZ0ZxaW5pWGhEU2Vxb05LK0lBMWR6TTY5Y3o1N2ViTDdmL01W?=
 =?utf-8?B?N21JRS9uTnVPeUlqV1hQUnZJRzhVUkdrZlBWenJUVEV3Q2JjV1B6dDY3dXN0?=
 =?utf-8?B?S2d0YnVRd1hadEhqM1JWcmxONFVlNHdOTytaSmpaRkJoMkM2WmE5MGFNU1pZ?=
 =?utf-8?B?anNWZ2hrUWprM1ZEak5BejZ6M1VibFMwcTJybnA4SGtQNkttYWNaOEhaQW0v?=
 =?utf-8?B?UWl6VjROamM1NU9mckhBQXIyVy95d3ROcHJoc0lFVDI4N24va0ZBRVRaT20z?=
 =?utf-8?B?TjFJdUJsNndSSC9zRDBxL2JWN2pOVU1PcDNsa3RnSEdlZVV3OUF0eFNmdXhj?=
 =?utf-8?B?Y0JVaVA1TWNaTnVTbVMyNGtjdFR5ZHZOYmZWOUFkb3FtUkxyS2prN2dQc0FC?=
 =?utf-8?B?UlFvdVdFRnBIZytDNjQ4ZG00dEliS1o5QXo0bU1QT3VEK3N3Y2ZzVThkWTNs?=
 =?utf-8?B?Qkl6UDhKS3lIMUxvUGw0MUNaaGtTV01SUXRhd0l3ekNNTlBHeWJySkZKaGtq?=
 =?utf-8?B?ZjFmMDhySmo2SmZRcitzalZvNkJHQVZQeU5aeU9rVHM4aEo4dE5JTVlzdjF5?=
 =?utf-8?B?OW1UTE9iZVdndE5XbUQweFpaQlZCUm40NksxMEh6NlVZZk9GbFB2OEZLVWZY?=
 =?utf-8?B?ZGV3cjJTMHhPNG1QZEhwWHM4TExWTVh4SzluQnRQcjNRWU0yYkFEb2FqMXVq?=
 =?utf-8?B?Y0FtUjVsQ3E1QmxNV0g1Wlh3dkVGb2lyUzdBUGovRFVLZHNtVEVkQjFFak9R?=
 =?utf-8?B?RnpSbUl0dDVObGN1dnlvNUtaTEROYlE1SkZvZS9RWllVMVpqUkRFSGFvNFFs?=
 =?utf-8?Q?zpY1JKlFJ0+dEdDo=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34368836-3ae9-4009-89dc-08df2f7daabd
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:14:49.2833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8xwWsfTL924aMYDFRVda1ENz3/A10+mmWqwzhXp4m13hyjkX3DmdlRNl5Qgl3ehpU+uXBVsQ4OWLmGavCwi0JyrdS3d/7eB5oQDhMt1/Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2219

On 2026-09-28 15:21, Imre Kaloz wrote:
> Since the conversion to folios, move_pte() and tlb_batch_add() flush the
> D-cache of every page in the folio a single PTE maps.  Both run once per
> PTE, so moving or unmapping a range backed by a large folio flushes each
> of its pages once for every PTE of that folio, and each page flush is a
> cross-call to all other online CPUs.
> 
> Only the page the PTE maps can hold lines at the old colour, so flush
> just that page, as before the conversion.  flush_dcache_folio_all() has
> no other users and becomes flush_dcache_page_all() again.
> 
> On SMP QEMU guests, apt rebuilding its caches through mremap() triggers
> RCU stalls and soft lockups in move_pte().
> 
> Fixes: 1a10a44dfc1d ("sparc64: implement the new page table range API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/include/asm/cacheflush_64.h |  3 +--
>  arch/sparc/include/asm/pgtable_64.h    |  7 +++++--
>  arch/sparc/kernel/smp_64.c             | 24 +++++++++++++-----------
>  arch/sparc/mm/init_64.c                | 22 ++++++++++++++++++++++
>  arch/sparc/mm/tlb.c                    |  2 +-
>  5 files changed, 42 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
> index 06092572c045..02c969417e7b 100644
> --- a/arch/sparc/include/asm/cacheflush_64.h
> +++ b/arch/sparc/include/asm/cacheflush_64.h
> @@ -38,11 +38,10 @@ void __flush_dcache_page(void *addr, int flush_icache);
>  void flush_dcache_folio_impl(struct folio *folio);
>  #ifdef CONFIG_SMP
>  void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
> -void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio);
>  #else
>  #define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
> -#define flush_dcache_folio_all(mm, folio) flush_dcache_folio_impl(folio)
>  #endif
> +void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
>  
>  void __flush_dcache_range(unsigned long start, unsigned long end);
>  #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
> index 0837ebbc5dce..6712eac4baf1 100644
> --- a/arch/sparc/include/asm/pgtable_64.h
> +++ b/arch/sparc/include/asm/pgtable_64.h
> @@ -946,6 +946,9 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  	set_pte_at((mm), (addr), (ptep), __pte(0UL))
>  
>  #ifdef DCACHE_ALIASING_POSSIBLE
> +/* Without pte_batch_hint(), move_ptes() calls this once per PTE, so
> + * only the page this PTE maps can have lines at the old colour.
> + */
>  #define __HAVE_ARCH_MOVE_PTE
>  #define move_pte(pte, old_addr, new_addr)				\
>  ({									\
> @@ -955,8 +958,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  									\
>  		if (pfn_valid(this_pfn) &&				\
>  		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
> -			flush_dcache_folio_all(current->mm,		\
> -				page_folio(pfn_to_page(this_pfn)));	\
> +			flush_dcache_page_all(current->mm,		\
> +					      pfn_to_page(this_pfn));	\
>  	}								\
>  	newpte;								\
>  })
> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
> index 371460e34484..18b6145da591 100644
> --- a/arch/sparc/kernel/smp_64.c
> +++ b/arch/sparc/kernel/smp_64.c
> @@ -982,8 +982,9 @@ void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
>  	put_cpu();
>  }
>  
> -void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
> +void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>  {
> +	struct folio *folio = page_folio(page);
>  	void *pg_addr;
>  	u64 data0;
>  
> @@ -996,7 +997,7 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
>  	atomic_inc(&dcpage_flushes);
>  #endif
>  	data0 = 0;
> -	pg_addr = folio_address(folio);
> +	pg_addr = page_address(page);
>  	if (tlb_type == spitfire) {
>  		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
>  		if (folio_flush_mapping(folio) != NULL)
> @@ -1007,18 +1008,19 @@ void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
>  #endif
>  	}
>  	if (data0) {
> -		unsigned int i, nr = folio_nr_pages(folio);
> -
> -		for (i = 0; i < nr; i++) {
> -			xcall_deliver(data0, __pa(pg_addr),
> -				      (u64) pg_addr, cpu_online_mask);
> +		xcall_deliver(data0, __pa(pg_addr),
> +			      (u64)pg_addr, cpu_online_mask);
>  #ifdef CONFIG_DEBUG_DCFLUSH
> -			atomic_inc(&dcpage_flushes_xcall);
> +		atomic_inc(&dcpage_flushes_xcall);
>  #endif
> -			pg_addr += PAGE_SIZE;
> -		}
>  	}
> -	__local_flush_dcache_folio(folio);
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	__flush_dcache_page(pg_addr,
> +			    tlb_type == spitfire && folio_flush_mapping(folio));
> +#else
> +	if (tlb_type == spitfire && folio_flush_mapping(folio))
> +		__flush_icache_page(__pa(pg_addr));
> +#endif
>  
>  	preempt_enable();
>  }
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 103db4683b16..8792e5d92517 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -214,6 +214,28 @@ inline void flush_dcache_folio_impl(struct folio *folio)
>  #endif
>  }
>  
> +#ifndef CONFIG_SMP
> +void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	if (tlb_type == hypervisor)
> +		return;
> +
> +#ifdef CONFIG_DEBUG_DCFLUSH
> +	atomic_inc(&dcpage_flushes);
> +#endif
> +
> +#ifdef DCACHE_ALIASING_POSSIBLE
> +	__flush_dcache_page(page_address(page),
> +			    tlb_type == spitfire && folio_flush_mapping(folio));
> +#else
> +	if (tlb_type == spitfire && folio_flush_mapping(folio))
> +		__flush_icache_page(page_to_phys(page));
> +#endif
> +}
> +#endif

Another thing, an /* !CONFIG_SMP */ here would be great as well. In the
followup patch it drifts even further away from its #ifndef

> +
>  #define PG_dcache_dirty		PG_arch_1
>  #define PG_dcache_cpu_shift	32UL
>  #define PG_dcache_cpu_mask	\
> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
> index 6d9dd5eb1328..1221814ca0e1 100644
> --- a/arch/sparc/mm/tlb.c
> +++ b/arch/sparc/mm/tlb.c
> @@ -144,7 +144,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
>  
>  		paddr = (unsigned long) page_address(page);
>  		if ((paddr ^ vaddr) & (1 << 13))
> -			flush_dcache_folio_all(mm, folio);
> +			flush_dcache_page_all(mm, page);
>  	}
>  
>  no_cache_flush:

Cheers,
Andreas

