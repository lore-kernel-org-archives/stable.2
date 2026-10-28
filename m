Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198124;
	b=rlx9gJgjztL3D/CsSdzqSguH+87ZDBpiItYiLS1WQhCMKBMGmH03WqVnVZ2ZGZVmxDd1
	 eAc4eJeOJ+3Vfk95aGGgz0bVNadlTOOrE2s58rcY2dIR2zpCFciChKrPRMz0CiaTBQSib
	 7TM4fo/lIQ7O7sUMRdvp/YklFiQoqHbjFNObLChawql/AnC53JwUA3BJfyExlcpRRJs3b
	 tsxbHdJaPGGeQFjco1y07J2+zT80/nvuC0D5LCWTekKLxyriNIw3/L+4SQ27cgkL2d8zs
	 n0f4MJC1+d/5XzZZrp8VYnFpIoLJSXKsAhPpG5kWXavnp+tt5Gj/iq+pkVLLnnIU1yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198124;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=r3fxlZ2r5h76cH195mNtnLRts2D8lhDaQuQQ5yuWNAI=;
	b=X9AT2UxCstsaYYSV8tbM25fO8i45sbsAv05rbLCqaqrF3beYLRKqlTsG7zDN86yWqmm5
	 alp3WXGmD27Ah3cyrQ2ojoaXUQtjJtd28AlqghmMbw1be1ZrvaCzOwCTB+Qk8c19AZaRr
	 9i9JvMQO5m/u4AFhPfO1RzB5Z2F0k9IZClbb7uAHMTOQef7xUW6/GraWhtCGx71PQR/v6
	 z1w895De5wo35knqXW2ODcZ5GnTSW9rSYuarkKvQXAfZDUE8WKDTy2DjcFr3bUnkTJ2CA
	 7fLNKSbzVfEAv6iG0LT8nJRLu4k13l+xSemGbqP03LpbR6WtNz9ac51Zyrm0YpX249g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hd5twVmp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.27
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961D606A31A;
	Wed, 28 Oct 2026 14:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4961D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hd5twVmp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E286FC/LAGbU8aLgVkPmus56BwGHloNDnotAnWIfFWU0hJcNow3SlQXK62JTPG9am8ItQiCvl1+zWRlCReoXfsKwNpb/tPwnz9r3GV2gkYt7ijwyNQR8B4NqLS3zYqXZuWg9X68ttD48DbBKf1bsfD63EcxYrybOIHNnY/M1aL4Yl2ZoDD5YBONGLn8NQwzD8uqYbQl14BtmcKqzKfdASkvCG98O9T3HauwDRAVLgQNro2MCqx4Trxji6Zb6RrLmg9rY6Eb754RI8NeUWh8HXfnYS5oaq5+9Pf0YSiQ2lbNNPYtK6cpaQkp7TH7lxjeoY2a5a3rk9S1A/ZUjpkfwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3fxlZ2r5h76cH195mNtnLRts2D8lhDaQuQQ5yuWNAI=;
 b=STKHcFAIuwYaY9/pkbBeYyJsublBsoC2pmo8dcUwNPQ9xOk+hCSPbmK+YkmCxD0pSYe0XyKvG6Fcq0FC/OpzOmOLwiQzrGUP8Qkb1Hg8oxSXkBkG+1nRw7+mt7F1y3SFnecI3wD01B2N+6SdQ3kK2UlzQSCRsMOLFavoq7bGILv7YCWRc3MyThQE4FTsOvhP6NtH3NCJMQ5wj+DGmliEuzyBBKt8JUgGm6mAvjH2SyRjIER/xMAHNNGsl6NTwPVSmLVBOXQwpUmZC30gN9OOeqHTJrDN6fQwh03K4Dp/nB0nJKCTpdS57DeGQ9zAdLbLdryjVJ8zcTW2gOnj+M+jDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3fxlZ2r5h76cH195mNtnLRts2D8lhDaQuQQ5yuWNAI=;
 b=hd5twVmpn1ee2pQ/LQAnsRcN2ow65CS90uHJKyNTsUjJV9ZgNSydKAN3FwUPp44hPzzqXFOdvYDswYUi+ssb74w1E5V911fwSgudLrkWcpAH4bgImT3gTtcftniIZ4KN25620BCb1MZHYTsvfNtVYur4/4v+ZfJ0LMw+y3PPM5xGCL6rf7Q454i0i+mt0kORn7SuWrqv7w8st1c7ZZxz7PUSV6O3K6uj3Ld/gf6gLhut4JtzjGe98iHbh0rlpOlm0rZ8wErbes2cG8bemshuVCuSCmYumwwtFGVqW1PpDWXWssvk6T0iB91cFmX+EOjqOHTRgxBTxn/OeJs22I4Yng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8191.eurprd04.prod.outlook.com (2603:10a6:102:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:35:21 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:35:21 +0000
Date: Wed, 28 Oct 2026 09:35:12 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: krzysiek.sokolowski@gmail.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: pl330: drop only the runtime PM reference a
 channel holds
Message-ID: <auIIIC6ATpcJgDTM@SMW015318>
References: <20261028-pl330-runtime-pm-v1-1-f0fb5c34a7c4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028-pl330-runtime-pm-v1-1-f0fb5c34a7c4@gmail.com>
X-ClientProxiedBy: PH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c863a2-bbdf-489d-43ce-08df3500b1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|19092799006|11063799006|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hVOoZFedsPJ08K35tje5cxmmX3jQfte/zLLyBJPcybolIcBBcTO3ThvqpSb/ayQ8Yo6YF00/4hitO4XM429csT7C1EsPB/fLMlpjU56l4d02PMssQWk6f+R3TUw8kuHgUAm+dkjzmt8xPYVVYrKYg2V8Jklil1tTDUn5jysFbYC357EHKFrnxvOdKRL8sYVymqizXek5/RSc1PaU9JyjzV/PX2NYUIEdn089NY5oTFRYB4+QPGbSlWd1to8FjOcSKL4sRejJ78wLQA0MxqkIcWoudvSpVhBd5tiljifG8R3QQg7p6NyQhPQvN50CuWmcBnps+dKvo4unKQ/AuIgvz2FFztFdiLJ1dvhXFfXbmlrFMv/6Bpurf2mJbt4ra029h6//FfsFFZ2OIoZzEOVN2GpnM0zYFcvnaO+15glh+45gpUllbgBCQe0Re9OFv+eTQCSVddKb1r/5Bj3A4BjTQmaghokDxtBg44I36dQk1Wvg/fML7maAVHgDpqsym8vTBJooIrMLRr4GTiSsoiWt8ARQVjHH00SyK+Pj2fgMO+tMxEdPagRh3YiZy/l4Pk90C5piZcVZSOfb4v975litycPF2jbwuj+ArEnQ7MJQ5EOqpFXfIj7kUdUPAyr0O5xi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTVFN01GOGVmNmQ4cThFQWlWY1ZiMDJGcGhVN1QyMFFIQ1hQQjNiRWx3ckh6?=
 =?utf-8?B?eklxWE9XWEJiS3o5VHNuaEYyMVB0WXpOU0FjVXBPWDJwVFMzRGZPNU1sRHd5?=
 =?utf-8?B?Z0s0eDhSNDRQa2N0NEJGcFhqejc0Wi9UMFBsemhFQi9jYTRiY2VSU1E3T2Vw?=
 =?utf-8?B?NVRYS0JBZFhPTFZ4K3VNaDhld2RqS1A5ckYzdUlSNlVVVU5lSW9tcU01eDBk?=
 =?utf-8?B?RnhkeXJiRE9TMk1qU0FQNFhPcjVacGlsMzVmL3p6QU40WmFJdDJ1M2F6L3hh?=
 =?utf-8?B?dHpjZ3hNUTFKWm1zQng4ajVEMkhMYzR6YWZkVU9SRk9MUXF0T1dGemxaUDlT?=
 =?utf-8?B?RGZ4NlA2UExyNGZKWGVKMjU5MmowTEV2UjkydmU1MDdVTlVib0xVKzFEQldP?=
 =?utf-8?B?MjVtYXdnSEhFaElISXplZlh3UmhrcVpFYk9jZThYOXNYdlE3d1pFTVEzN05u?=
 =?utf-8?B?aCtxUTdaMU5mQWhzMTZPWHdOeWZGT1hadTNoM0E5R0dvdW5CdTVySEZUUitH?=
 =?utf-8?B?WElJZGFQalJ6NW5PUDhaSWZRVko5Vmh5TUJjcHZlbUdDRUpvRzYxMmNJbElu?=
 =?utf-8?B?NHp2azE3UDRjbmlkTTJ6SFlPQXJJMHZId2tGR0g5SmxablZGdDFOaDlJbU01?=
 =?utf-8?B?OURvdmJ0YU96NUdDNFp1Ui9oYkRkYVgzVVJvSW5lbFdyT1F0KzVUd1RMcDll?=
 =?utf-8?B?RlNzVDBlbEN5bS9PZU16NmdXRDNib2dqYXlQYzNmd1hXdnMxZ3VOL2xPUW9S?=
 =?utf-8?B?cS9vMWJ0cDZ5M0taYjAydEtzU3YvVEp2YWJWbkZUT3d4UjZaQkFKdms2V01u?=
 =?utf-8?B?YmJyNHF3U2RXZ0xBZ3FqWmZlVDJqeVZFc2htSS9Eam5waDRZdkZDOTRKemFY?=
 =?utf-8?B?ZlQ4VG1PNUVnVVo3OFcvZi90dk4wQ29Mdnl4VEZ1QzVxNU9LOVRYWEVRbFl3?=
 =?utf-8?B?M1JmakM3d0hJNmZoRVlXN2xMQlNVQ21rWkJjN0cyTTRycTcwMys0NkJ3cjBF?=
 =?utf-8?B?bTBObElYYXo0bVVmZEdsaURlOVpCRnd6QkpxbXJOR0xaTXlKbXZldjZEb3pB?=
 =?utf-8?B?bnE3NXIxNGhpN0s3MlFMV0xtWFVKOHZjUkJjKzNzcHhEUUl2NWVpTGhjUjgv?=
 =?utf-8?B?K0FxWkhWVWU4aTM0dFQ2V3pBUGtIYTdVdnY0dEd4M09wNWhkSkNralhJT0ZC?=
 =?utf-8?B?UWxQbUFCcTRvclVxNnBJckE5SVNKc3VDbEg0ajZncXRxaXJyazVJQzZNakw1?=
 =?utf-8?B?SVZVZXNwVkpOcTJlWEljaTJ3VkVqYk9iRUZnTWF0enNONEVWMXAwaDdHMmVk?=
 =?utf-8?B?ZzRRZ0JETXk3aCtjV0YrVHRNOWVYVGFNQitVUUMwZWxrcCtzaDZNbU5MUW9L?=
 =?utf-8?B?MEtJZGl0bVpyRllzZ28wSlVlR2RzNldpaE9vWmZhZm5OTi9uaHFHMk1CTHIy?=
 =?utf-8?B?UnN5MkxHaEpPSUZGUEExTVJ0MG4xUURmZjBGbkRpYS96emZJYmtHeGpHZTV6?=
 =?utf-8?B?RG0xZlF5a2RMa3Ftd1YwOEowQXRabW0xOXcwaDBWTEIyWUVWdzZ3WHBiQ2li?=
 =?utf-8?B?WG4xMlZyVkNRQmVJU2R3ckcxU1Vvd3FTVVhvMGlvV0xHV2RlWUlVRDhEL1NP?=
 =?utf-8?B?djRrclZ2Uk05THFObU5CeFJPeUZrQnFhYU9wbzNoWU9BWWlBWnNCcTNlUSsr?=
 =?utf-8?B?TVVSSnk2L1JJdkdMeWdrRHdEU2gvck4yT3BocTFRTnFPNEhYd1FoNENud3Qy?=
 =?utf-8?B?UWVuQ2w4N0EzakQ2SjZZOEZqL2dJMGJvdC9SYnFMZi90czBQSGdvekdRbnZs?=
 =?utf-8?B?NmNYZnphQXE3K05MNWxRdTF5NnBWTnk5Y2pyN040cUFPT1RObjc0RktWN04w?=
 =?utf-8?B?K0U3RkxLc1FwNFpOdVlrYVJsQXRXVTRVN01HdUNCZERNUkVuQnNQbE1Ba2dS?=
 =?utf-8?B?SEJLbEpVRVVmWm5MUGdaQzhjVXJWenIzeml2MTFHU0J5UnIrKzEwMDk3UEFs?=
 =?utf-8?B?VjkraDB6RGlheFFhQ1R3VmpZKy9wRmFsVm1RaVViR3AzQUtPOUNramtqYWRk?=
 =?utf-8?B?OXFSQWVtc2w3WTRUVkYzOWJDQlUreXp1b0ZKcWJiQ1B3R3B4SDhGTUVhS2ty?=
 =?utf-8?B?SUVLNmVQYndJOGJyVWF3aGVFN3h2Nm8wZTNqQ3NOQzFLa1E3dTFTOEgwQzFE?=
 =?utf-8?B?N3g3bmtBWm5UeURPWjBSQmhFV1pxd2JERGJFSkZ0YXBuTkV6NDN0TFNmeXFa?=
 =?utf-8?B?Y2NHV204OTZjeDhoZVJsSVpBcXFSVDhMcmdzWjRuVUdqbTZjTEFvN1NIZVlk?=
 =?utf-8?B?SC9Cc0RvVldsN0w3MXJSSjdxU0RmQyt1UVhlUEhJa0syaG5SSmxVQWFFMFRH?=
 =?utf-8?Q?w9LHnfNPjYUdUHG+y9y3llwfQ9JDYkDW2E8PX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c863a2-bbdf-489d-43ce-08df3500b1c1
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:35:21.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/UDB6mZ+B2k1w2zZ6gM4CcZt+yhKYZoheQ07HtJiGLetDi24xbMPAJUjTkHHYvyjMhixndZCEzlrwgqbd9EWHMAczC4D6RVpNiLc7+Z6tHES9DnLdj2n2w+scdlsan2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8191

On Wed, Oct 28, 2026 at 12:28:11PM +0100, Krzysztof Sokołowski via B4 Relay wrote:
> [You don't often get email from devnull+krzysiek.sokolowski.gmail.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
>
> pl330_tasklet() drops a runtime PM reference when the channel's work
> list is empty, without checking that the channel still holds one.
> pl330_terminate_all() drops that reference too (power_down =
> pch->active) and clears pch->active. If a completion schedules the
> tasklet and a client terminates the channel before the tasklet runs, the
> tasklet finds an empty work list and drops the reference a second time:
>
>   Runtime PM usage count underflow!
>
> after which the controller can be runtime suspended while still in use.
>
> Seen on an RK3128 board (dw_mmc using the PL330 for SD transfers) under
> combined SD and USB load, where the dw_mmc error path terminates the
> channel; the underflow was followed by "pl330_update:1678 Unexpected!"
> and a failure to request the DMA channel again.
>
> Take power_down from pch->active in the tasklet, as pl330_terminate_all()
> does, so the reference taken in pl330_issue_pending() is dropped once.
>
> Fixes: 5c9e6c2b2ba3 ("dmaengine: pl330: Fix runtime PM support for terminated transfers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
> ---

The same patch at
https://patchwork.kernel.org/project/linux-dmaengine/patch/20261015-review-pl330-pm-original-v3-v3-1-5be09f37df77@crepuse.com/

Frank
>  drivers/dma/pl330.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index c2d0b47..b0eced8 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -2090,7 +2090,12 @@ static void pl330_tasklet(struct tasklet_struct *t)
>                 spin_lock(&pch->thread->dmac->lock);
>                 _stop(pch->thread);
>                 spin_unlock(&pch->thread->dmac->lock);
> -               power_down = true;
> +               /*
> +                * Drop the runtime PM reference only if this channel still
> +                * holds it: pl330_terminate_all() may already have dropped it
> +                * while this tasklet was scheduled.
> +                */
> +               power_down = pch->active;
>                 pch->active = false;
>         } else {
>                 /* Make sure the PL330 Channel thread is active */
>
> ---
> base-commit: aff5e6a77fc69a7c490246465940d18422d7c631
> change-id: 20261028-pl330-runtime-pm-b5a30050b2f5
>
> Best regards,
> --
> Krzysztof Sokołowski <krzysiek.sokolowski@gmail.com>
>
>
