Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605315;
	b=GOZTLI4ozWmHXgA52akPMbnThrRTi/DZdT9VcUnO6csuRy6FbjDL2iAL1IPcbqa859gt
	 Mr3xyfowsRTrX7A8Iw3kCrUAnuChfmwRhPa0akg++hpFh8maB3ze1C7tYCSi5/uSIGPSj
	 PIwDIU2P4iESQn0FunqrIBz836uv/+cisdGuxym0TCRnDaGeZ/Vyg2C6sSjNYAJ5dUkZr
	 +59vm6159kkS0xUcQGe1gcwcTQluQvLZ2wqdstvJfTm7glsO2T5Yb1BXM2C6NSDb6QG4Z
	 rMimoNRwLtKKRmv8gk1zmuvKk6tCEl/hTuhETQhjwUL4E+I6vvlHJ79uqPGoAmRGDQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605315;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RLuE6cpRGND9LKxNx06PVWovjq+/h72bm6T4Mc0pymw=;
	b=vqyNPiovH3HgJU8hNPm41hUBpRpeZESy0eNFXmDYK/V7QYAsY2wA0h6dEQAxOYz/7BKt
	 d2lR/+tQAT3rPoUZkoRGHEv78m1mkWMEM3G958dhKYjfpDhJkqFhCnB/rnsdDEL3snZnZ
	 sbhmRfHXk0NwU9IhuVHf3fWs1l6Djoj/IAMx89FuK/391OzA85akP0IBhajwdfjbdYbzt
	 4G01Co+U6QBpWfdmwIIxqOvDuaO0nPIfhpzcQq6EMZKnDtFlu19prNToL40AEjKMlncQ2
	 8Fi8LPaM96nH5A3KevAXk/N0Oks490UyxOa7DCRJzak4oTOWXaikJ8fyky+rN2gj6Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=omhW4EGC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.36
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F97606A337;
	Mon,  2 Nov 2026 07:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F97606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=omhW4EGC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zb2YX4Pp1hPI/7seCmWSPhDIuzlczGixpNBxKpNzFsCAB10HVOLa3Hk5HRx0rVX7pN36aGeRlZuTNEj81bQZy64kKwobQ41O7kSepv38Q0/riW2G39SlssrP+IL9qQ/77pd7sfOCla/vqtaKsEoXaIclB8Mvnr1Ndp3Kv18FRf2812eoJyLCYL2Qq+7bS1otIckNKFH5fbh27eLpDHSCns/rzJMj4/QRKY1l69KGZjIxbHO6UqvOXdzPIFDGRu1DXXomZVcgYXOPGtLBiKB19U/6UflTorlqLIB56WcFkVU0Nz7F4OvyyNhGEwwLPxRI6zVNz+mwff1RtBqw5vTg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLuE6cpRGND9LKxNx06PVWovjq+/h72bm6T4Mc0pymw=;
 b=JkyQl3m8jVlLMScbNEANbaDZiERh/8A+X4RPlVdpK5KxMUVVSDBacCdc0nRZOEpEeaO1h5JNEdbGDZUjq+SxJqn99Pz9kwhp0x7ddCXSN8E39Nr4fT2AFNE2/cZGrV67PuGjjz3Ho4Qss6PeA0dCSQ5/ElRsbzgJtpc4FvEZXU8TlRyvS+klVLLDTFSSmtMel0sIrR8pO3l/g9/7oZFCCp01ZkuEOaE45d2458Wsr6sN3b3Yb5Fav6S1ttrzExJCIReNA9lp2Ldw7EX81FPNl7BkLRfLXcGL4RvPLXu/eX2v3g6gF0gl8veiKMjJQjixWj1hf9AJIaX/TxkNNRvLQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLuE6cpRGND9LKxNx06PVWovjq+/h72bm6T4Mc0pymw=;
 b=omhW4EGC1JY8MyDgto2peWkiK69aegtH14SGfNJlDUzXcsaeGJhv/rLNli7acfuSHCDpAP407DzZuK6nTudH4yhFhkWEr9VzUGb726Qr1mKN5Eb0nOOYWRMhlxRaML9ADAT1HjLPWZgdJXpLCUeCotblnPdthffFuYdL1fEWpdU4FSOvvJYLpBjc8L5dRCt67se+ba/r/jREIqHLwRvFl5y45WAmvTnfqN5N5JVY7q9kCRtd+xqUZTnzyZH+LIn9kPFB+EYxs1ty4PN5SGbUZpDPzYUvoCiJDFd8uvKX0woyIQkpWPGBa4x8IHOZeH0MrE7+xofEEpsnTxx7RF5YvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH9PR12MB389485.namprd12.prod.outlook.com (2603:10b6:610:312::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 07:41:49 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:41:49 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>,
 admin@tsv-stahl-riesa.de
Subject: Re: [PATCH 1/3] soc/tegra: fuse: Fix Tegra114 speedo fuse offsets
Date: Mon, 02 Nov 2026 16:41:45 +0900
Message-ID: <N-ws7JFVRJmI356qTqMaEQ@nvidia.com>
In-Reply-To:
 <20261029-upstream-speedo-t114-v1-1-81457cc9d94c@tsv-stahl-riesa.de>
References:
 <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
 <20261029-upstream-speedo-t114-v1-1-81457cc9d94c@tsv-stahl-riesa.de>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH9PR12MB389485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d263114-7691-434d-5efa-08df38b4c0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|4143699003|11063799006|56012099006|261021135927099003|261009223027099003|261021121427099003|261021123027099003|261026121527099003|261022113327099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VeY7G3FEFdyqCBCG2HD8QWQIW+ysjD2CUlOa1b98HuPVL7/ZI/gjz2GregGJutjrEZAhYVo9+Gbp2npOu7b1qU428y8INmikJF17w+2WBpNCx8b6Lp71O1BV0muv9DLcfKRfT54w5T/jreqeB6fw3O+ww0dLXOiK3nT0AGyN6G6TwiCTSAuPgabDMxv46rd7GQTj+0S8/zVLdMI1beXhypxnfCCjomhyM8tQBTctLBXpmbyYRQ3YeOyKn1hzNC2VvaZxLD8F1+EH3jcoUJ0yBLjecgg2V0EwCKI28tZJ4QG66MLq6ZwbaEbiaKHNWEbq4Lx2/N4pLvky60BWlPEn/VheOL2CQgfqb5JuPFJ/1FueQS3FGHYfCpRk4XTOO2TmUBBAOJdoGItG4mORdph0i0QVE+eYI98lqm4KjxI5DsHx5v0dJPxIO3XObQgbeXExT7e5nTHLTv3x3PaTGiUEN1jyCvgGSVEBvDaNLVIdLXUQBSDoBZuSJJtuv0B/+9kAT07r5144XVWpezt3TCeKI6KSITAjk2mQNc4kf5mXylqpKQg6mZRzjUVo44oAJEijEj2bB9uVeMvueSVmctUvulAi7Md/M5qkYUO8MhBuxZSae7x+48a8PuIpC34lzDHGxeR7RF5i8HpQz1fqAsRb1rgl6W+/aODJbynZUuaZSRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(4143699003)(11063799006)(56012099006)(261021135927099003)(261009223027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022113327099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk5HMlJub2U0ZjN5dVJyR05FSnJ1SnJqeERPKzF1K1NGWHR4Z2dQcTV3c3FH?=
 =?utf-8?B?M29Fc1lUK3B4OWFUdTc5U0ZxSXZGb3JweGtWaFdmZ1FSVGVyd1U1YUFaVS92?=
 =?utf-8?B?WENIWmxvU1QvSjhHNDRUcFUzbTRKbzJQQzN6bDBPMERZQjIwL1hlTFBSQmFl?=
 =?utf-8?B?akUrWmJPZ2ZBMnZ6NW0vT01Ca0RxWlRhVmFZU3hOOFlLTURWU05xYnFlakdm?=
 =?utf-8?B?QXNDWVRRdllhdmFjTGl6bWtIclJna0E4eU5VRklidUh4eHMvRlRtTHFvYmhw?=
 =?utf-8?B?OW1mUEdZRVk5Ym1PdzNUZythRmJBZVRxdlgwREc5dnhQTU5TdERMSXJUbHRZ?=
 =?utf-8?B?N0sxb3Brb09GelFtbjVrb1I3TVdvRWg4SXZrTnpUcysvcE13S0VpbVc2RkJa?=
 =?utf-8?B?VkFrVEVjSEVsckw0VGZIUjM0TU9GNlRwSHUvVG01ak4xaDMzenA3YjVrcEhF?=
 =?utf-8?B?YlRudTVLQmpqdEJ2SVZKckFGT1Z3OGtTOXJCUzhnRWlZZGRoaUliSXpEU052?=
 =?utf-8?B?THBIVnR3b1JhQzRnUGJYMnA4WlR6Uy9zUEdZRWVVUkFNUzFFUS85SHF1RmlX?=
 =?utf-8?B?ZlU1TndIaXZCYnhtUTlyemg1cVJYSGVnUHB5NzhidU1aZ21pWFhhSTJCeWUw?=
 =?utf-8?B?SXM2eCtlSXRZTnV2ME1JSFJxRktXOCt0NTRvRm9OdmlNaDRlQ2xIU3gvRmJF?=
 =?utf-8?B?ejFINkNOWXJyUDlCNUxGdVczSnRyTDA3cG8wWXRzNzhPMDU2ZlhPZ3U2SjNi?=
 =?utf-8?B?U3JucnRzcUFZSzQwTVZlR1hSR01oM2pMbWQ2andWOWdtQ1lTZ3J4dVpmMjd5?=
 =?utf-8?B?ckpscDhxQ2tYV2d1K1JFb3ljbXVtd0ZmVHVXN1VGNTdYK2dwVEpRN29waTFz?=
 =?utf-8?B?SkZuWUEvYWhaUzBRaUtTanQyNWw0SkdZOUV4c3dGaytrRlMxZmFDTDdOLzdr?=
 =?utf-8?B?aWFFcy96eCtGOFpRd3E5RTQ0WVBHS1NqUUlIUjFRa1NEWnVTVk8rcFlSb3hK?=
 =?utf-8?B?UWVNQ1BPOStkV0RaNFQ5bjJ1bEhFdUlxeFM0aUN4SWpGYXFlMjl2Vjh2N1ZB?=
 =?utf-8?B?UDBoTHBSNkpKZExaWnpRWW9jNUN0dnJxVmxZWG0zN2tSL3dFcFlLWjFHZjMr?=
 =?utf-8?B?RWU4aHJoRFlQbmdFeWNhamN6Z0RNcElhcUw4OWVYMU5tYmtEdDVCU2diWVFC?=
 =?utf-8?B?SGNGWDRjb1FEdWhkYjhzb3ZoVFZpS0NJSS9MS3prc0Jrd3ZkWGlSSXNEalYy?=
 =?utf-8?B?SW1GbDlMM09vQWtXNktocFpNVUZhRWxsNE90VmJHK2JzZU1ycDYyS01JQzlI?=
 =?utf-8?B?WmQyMy91czkvWUM5dWM1elRqK3VjWFQ5N1UyV2pkVXNqSnpoNmhJREJuVzRy?=
 =?utf-8?B?NUhzbGxQQUpEYms5S09OVkJQU3N2S0NzZFZUREEwYVNHUmg4WDR0b3RLR0ZB?=
 =?utf-8?B?R2loOVorNkM2UVMxckhoSUpYT0oyNmVmRlk1TWh1YkVsR3c5bkpTdWEweTZt?=
 =?utf-8?B?bFF2QjhVVFVsb1Eva3N1UkppbVB5dHhnTTR2aGg4aVlYa1czUGJUL2h4U0w4?=
 =?utf-8?B?Sjd3ZHFVNGRmVzl4NmxhMndhM1JhVFIzMU9vWDk1NVJocXJDZjRDcW1mNU1L?=
 =?utf-8?B?QUdhdUNGdHdacnJIWWhzcmcrd2RvM2hhMS9lUTBLZDFxY002RUkxVzJraC9l?=
 =?utf-8?B?OGduNlhxc2JjZnlFYnphcnpaY2dvNUxlQlBISmlYd0VtU094RWN6cHZ6c1U5?=
 =?utf-8?B?d0pNdHA3VFNjRWFMUFZOTGY4OWJDNlcrUEJRSU9wZWdvaThpZGV5MFk2Ylh1?=
 =?utf-8?B?WThXQ1pCWkdJQTBaNmp5UlhUQ2tFUnA5cXYxelJmM0FEaUFGaGtqUUthT08w?=
 =?utf-8?B?UDJ4bHlvMUg0U2xkVmU1ZStOME16OUZDeklIRTZ6b0ZkVXpsTmJXN3FuV3Vh?=
 =?utf-8?B?NTVyRlRCOXBwTTJrMzR6MmRVSWVPSU9oK3FlS2o3TGdMWjZHYVhyeERMVW12?=
 =?utf-8?B?dG1BQ2tPYVlSV3lLSUZ5enUvcWY4OXVTZGxKZm1RbDRJZ3hCS3NodEEyQnZk?=
 =?utf-8?B?eTNvMFJCczFQYXJBZ25YRFZ4VktnVVI0YllhcWVWWEUvYnh6bWU5Ni9jbWJM?=
 =?utf-8?B?dVFkWDR0T0RNZHR2dnJvaXFQR0hTTGNoVVVuNlNweUN3c2lvWGhGWkl1S2JU?=
 =?utf-8?B?U3J6S1JFQnhoWnIwVlUyVGJyb0dFZWllVWdlZWtOZjRWNWlGQzhlaG5QSEoy?=
 =?utf-8?B?WWdraEVBN2VuZisrdVQwMjFYNjF1U0tDQzRRa1ZERUFJSW9oUjdKNnlzMjNR?=
 =?utf-8?B?Y2YxZ0tYTFB5WWpqMEZhQW42bzRzb3QvUml0UnEzNkZDVFRkbkZEOFNtVGU2?=
 =?utf-8?Q?bwvRo7mMbmICFd223/xeDgvjuvsLqnjoQl2QYbnWdRIXU?=
X-MS-Exchange-AntiSpam-MessageData-1: rVIlqEqFEGeMKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d263114-7691-434d-5efa-08df38b4c0b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:41:49.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c19A2td8RR95J5ELVoPARGEKZPI/tVjFS3a1hr4iU147QnJPguoXAc6dHciF4LGzlQtKWu9C5sJUeiBOX0OHMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB389485

On Thursday, October 29, 2026 6:32=E2=80=AFPM Patrick Fischer via B4 Relay =
wrote:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> tegra_fuse_read_early() takes offsets relative to the start of the fuse
> words at FUSE_BEGIN (0x100). When the fuse driver moved out of
> mach-tegra, the Tegra30 speedo code was converted to such offsets
> (FUSE_SPEEDO_CALIB_0 0x114 became 0x14), and the Tegra124 code uses
> them as well. The Tegra114 code kept the absolute offsets from the
> vendor kernel, so since then it reads the CPU and SoC speedo values and
> the A01 CPU2/3 fuses 0x100 bytes too far.
>=20
> On a Tegra Note 7 (Tegra114 A02, SKU 5) the fuses at the correct
> offsets 0x2c and 0x34 read 718 and 1156. That gives CPU speedo 1742 and
> SoC speedo 1156, which is exactly what the vendor kernel prints for this
> device. The current code reads 172094 and 0, and so reports SoC process
> 0 instead of 1.
>=20
> Today only the reported process IDs depend on these values, since the
> Tegra114 core OPPs are selected by the SoC speedo ID and the CPU DVFS
> tables apply to all process IDs. The CPU speedo value is needed,
> however, to compute correct CPU DFLL voltages, which the next patch
> fixes.
>=20
> Fixes: 783c8f4c8445 ("soc/tegra: Add efuse driver for Tegra")
> Cc: stable@vger.kernel.org
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  drivers/soc/tegra/fuse/speedo-tegra114.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra=
/fuse/speedo-tegra114.c
> index 6695702bdb4c..1e6c2b5be759 100644
> --- a/drivers/soc/tegra/fuse/speedo-tegra114.c
> +++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
> @@ -14,6 +14,11 @@
>  #define SOC_PROCESS_CORNERS	2
>  #define CPU_PROCESS_CORNERS	2
> =20
> +#define FUSE_CPU_SPEEDO_1	0x2c
> +#define FUSE_SOC_SPEEDO_0	0x34
> +#define FUSE_OPT_CPU23_DISABLE	0x16c
> +#define FUSE_OPT_CPU23_REENABLE	0x170
> +
>  enum {
>  	THRESHOLD_INDEX_0,
>  	THRESHOLD_INDEX_1,
> @@ -63,8 +68,8 @@ static void __init rev_sku_to_speedo_ids(struct tegra_s=
ku_info *sku_info,
>  	}
> =20
>  	if (rev =3D=3D TEGRA_REVISION_A01) {
> -		tmp =3D tegra_fuse_read_early(0x270) << 1;
> -		tmp |=3D tegra_fuse_read_early(0x26c);
> +		tmp =3D tegra_fuse_read_early(FUSE_OPT_CPU23_REENABLE) << 1;
> +		tmp |=3D tegra_fuse_read_early(FUSE_OPT_CPU23_DISABLE);
>  		if (!tmp)
>  			sku_info->cpu_speedo_id =3D 0;
>  	}
> @@ -84,8 +89,8 @@ void __init tegra114_init_speedo_data(struct tegra_sku_=
info *sku_info)
> =20
>  	rev_sku_to_speedo_ids(sku_info, &threshold);
> =20
> -	cpu_speedo_val =3D tegra_fuse_read_early(0x12c) + 1024;
> -	soc_speedo_val =3D tegra_fuse_read_early(0x134);
> +	cpu_speedo_val =3D tegra_fuse_read_early(FUSE_CPU_SPEEDO_1) + 1024;
> +	soc_speedo_val =3D tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
> =20
>  	for (i =3D 0; i < CPU_PROCESS_CORNERS; i++)
>  		if (cpu_speedo_val < cpu_process_speedos[threshold][i])
>=20
> --=20
> 2.56.0
>=20
>=20
>=20

Nice!

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com> # Dalmore



