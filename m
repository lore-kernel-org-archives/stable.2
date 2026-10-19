Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792439501;
	b=YNdfRuIXN1YoaubP2rt5hYc2ozgToI9xhyt1XNxzXBIoG8t6o2c4ge/NeqZ0UstqIgo4
	 DW5oCZGt8qtH2D4Ugvr9+DcbwP+W6XFYlrGQGvTDOPpIWlRYb+nQ6Ufko9PvVXwSwxd2s
	 INCdssrGQlnVhplUFodOZ+0kRRW2iVrnuNAncv1q+nWUfQYzRTlaX0joF9GCXSvxaYbIv
	 1uCwZclJP8ulA8lYeGd7kQNB3fmYHS1kr2GGRUIQCQDEenbZY5p3fdEck8DpCdS6rk1wD
	 vmCMErZA1Cs0T/47cW8JY4BUybBR9aItc54pc2jnn9zFIjjrRgsiwN17I6ByhDtTLUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439501;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=+t4f561lekgR8pp0icghWU3Lv2nfooJktVtw7jLUM/4=;
	b=e2zljijYSW1EAxlaNR8MYOFfARKKY5lsi+zQ2eLlaIfRQ2iniW0nq7VY08RbqeFsz/Gw
	 SdAzRyFbt7B3KYwmCypvD8eJ49HO04S+c/PpbXgWm9zJzXZyIUemkvGB6xkgwKHNu5GSe
	 YwsRuj/Cjye4ZMcbnrMmKfoDGjUPyqXNEQtTRrjpXR9wSWl3Twoh98VnA78xCKosHgCj1
	 YNBgTE/mdqmjjAe4akGudvUZvoK+l+1RelAYeh4fLN1UaNwufLSHtrT6aTECQUm19l4so
	 9p68OGTfuEjT+HYo2DwS08D9kEKrueaCiAhDwBOvPoHoqHbZZqvhsptV5VHYYSAI+tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fnYf8EPf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.49
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BAC606A319;
	Mon, 19 Oct 2026 19:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BAC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=fnYf8EPf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9FIl0zgdG7JzsvVeRMtK0jVXIML99M70TiP/kt2w7u9N1T4dxVcAuPFgb4ryUIEaDR6gkKzDuQxHLDwQpfoNwlMoNtqm1shQApAl1iu51Vr4QGh7yMh5YoX/l3rfe6T/bUhCKbN4HT7MOMgQVwCShDpmXA19KvvY8X7x3QDT3E+mgHPuBUHRK5/nxU+C7UvBsopfQX1D+lptIY7JzxjPdnRRz1MSVQRgO7yrGI5A80GqjIbMmk5rtkv/71US0iaO8e7AIUGEhYeOI0bTtqQ4uk9RsGHRy6Eke1ZQXqbmF9E2naqXhqz3ZydhxsUV5nSlBk5Of6muI/BO6WI99QWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t4f561lekgR8pp0icghWU3Lv2nfooJktVtw7jLUM/4=;
 b=wuz+yOI+dn9h+dmRMLjwtgsyZV2FUYjEJPlaRlk+f6D5EiBgHasgCx7R20EC3boU45vDseLaXRBGHYVpmZJ7RPXSbISrTMpM7YkzURI+Opwck1KxodVeLFrGly/+yIDKkBXY6QeQZ1H5+gJaSSCu2HjxSvElqLt3tT/03S2VavxmmimAkyn6w+LGQafqJLurIyWpzVUyywoIln3MAs8le1hMOTP3389wIGJDMFAk7+mOkupTpqpOcyFwUitSmqXwlMkOSlIpjDcqjcMG3ORDnC9ZAt++JqaAM2qH0CEs1DhvPSMVwXKfPfWdQsGvNcw47jCmc+64cIBVyklYY9TZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t4f561lekgR8pp0icghWU3Lv2nfooJktVtw7jLUM/4=;
 b=fnYf8EPfHGKndwWw4tVX/fExXemyzMzb0w5iMNlxDxJVLTEbBOHmZ1rSBLgvtgOGipmaFHU3Q2tQeCBYGSDyX4z95+zRCVWq9y+rVJ7Ru29lEk05r/KZ+3nH28KZmX2GP1avVhmxa7j+6LASYOHsrZdtGpJdke3MNLrtFP2ihvT9kpykibBhAMu/b0IW0cNKYtAOaRrYjMs7Tg+ZJG5a0NP38xW4+UlmGCXKGMcb+e1jDMNAAIpF1hxTFiEGvureRzDviv5KXpaK0I6cAwzMpeWJjCKOhzfQx1djCihK1dYeEWDuidFlTgsFhnxXogsfkpM/QN3kj/s78M4mjh6c/Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 19:51:29 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 19:51:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 15:51:27 -0400
Message-Id: <DM92ROTIF1U8.26CQNH7ZPEBG@nvidia.com>
Subject: Re: [PATCH] mm/page_alloc: let the highest memory node recover from
 hopeless state
Cc: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
 <akpm@linux-foundation.org>, <vbabka@kernel.org>, <surenb@google.com>,
 <mhocko@suse.com>, <brendan.jackman@linux.dev>, <hannes@cmpxchg.org>,
 <flyinrm@gmail.com>, <stable@vger.kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>, <linux-mm@kvack.org>,
 "Jiayuan Chen" <jiayuan.chen@shopee.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261019184850.3427905-1-gourry@gourry.net>
In-Reply-To: <20261019184850.3427905-1-gourry@gourry.net>
X-ClientProxiedBy: YQBPR0101CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::11) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM3PR12MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 970c202d-0de0-4971-30b7-08df2e1a5def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WHxqES5rmCseXsmD2IbaSnUyURCr9agX3VtzxY1uJOsXJtaKtfUtczw7avrBbqbRXrcghd9hIPPZ1CVDRto98YN7BHQSn+th+8EAfzFwLaM3yCA6DOKdwseQfjnE10yy1gn7wbOFerMGTZlb7u9mdrNacd/QS++JeTi9hvhwVzH/7u+vI2tuCmHwgz1+zkWVKVuhOpU8Jijuqp3VtPDpcnWTtmHHrxeptp7XPLlusPLq5vVPkU5qIyIo4RBoAsX7hEbARdNHIkv7AiHs/18PBynXLsEw5eKse26YsuDr5PyNKf5a1Fsu8eZCUUnod9nOzVnz2hwuFPsO4/lhRY1/OUpZ5UQywPhtsgZ9UBjWO8uuupPDHkHJNd/ViMeCIAm2pAI1I/xql6dO1VdZ2m6tdWNfOyt7WPh6OJSFT4cqDaU82wTnHhokg6dMs5M5JqT2ml7NQRCz2Qnt8Kvs++2TLumz/Qlxi8QICTx37Hr5oFB8BBsg6bflC5l9ThRiBbES9lKpJF7x59UJy/5RUCJEeZd3XPh6N7556gnHkOiNlBIB+3vFa+X+L8bCJvEbUEa0fPjLzXE+5PE9b0hiX3+KQmBTasuN3Vsv9H56E0wu3Q/lPpmiHhQ17jE14KeKrhwoLLsjWAJNBCoigbCttPeyoqeeyUB1Pjv4qcmngC9/XXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXpzbXM2Vmh0MjBQcUMwYU9ZRGhGd0VJdm1YNEdpRWptak9OaEd4S1JlOUVB?=
 =?utf-8?B?UzBjM2I4QVZxZ3NzNTJEYzFZQWpMZ21TVFNKVDFtZHM3aGZNTmVyRWxtTFhn?=
 =?utf-8?B?NDYvOGdKRDZVT3psM24rUVlUNDM3OCtjdElGaWprdFdUK3hyRUtuNUZKRjVO?=
 =?utf-8?B?b2Q2NmFhMzREY3I0N3JWNTYvZ0ZWOURNcVlXZnluS05pTXlHQWZHSWFPUno1?=
 =?utf-8?B?U2wvakNRQW9pSFNnaXl6dDR4UXRNYmNubmp6Qy90b3VBdXBmZm1Wam8xREND?=
 =?utf-8?B?UDRrZTNNWVQySGV2ei9mcVVzNzIwWitFM0lxcHJOc0JGS0gyQWNMWDFmek9R?=
 =?utf-8?B?TVBYZ0VMa0liQmFBRG1XTlQ4VnlVcGxBOHlUSS9TR1dEajlFYUdDbnJNQnRK?=
 =?utf-8?B?OVFuNklxcEpZcEVnazlkaklVa1hVZzdsWUxxN0ZEZStuN1BFenJEdXlWNDVD?=
 =?utf-8?B?RFhSOU5pVW81ZUZyaG5RWWZBME8vRHVJcDJuN2htUElMU0tsMzdFdmQ1TFh6?=
 =?utf-8?B?ZUpuR0pkWXJsaEcyZWIwQVVkb2Y0cFllV0J6QVR3OS9qenJieU05OTNkVnUx?=
 =?utf-8?B?eGIydjgyNVRObDJidUlVdkdNQ0VhUkFnZW5oRDM3T3F6NmI2aHpDZlpCcG11?=
 =?utf-8?B?ZWJMYU1EeEFudWE4VWdjYlJDem5oWWY4VU51MHNiN0JNWHF2Ym1vbkdOdU53?=
 =?utf-8?B?RXVnbklpMXV2VWErYXRualUrR1c5YUtaK2U2RllTdGtvZ2RFU2traHFTRFdV?=
 =?utf-8?B?NWxXSTVQVUdCMk1vODhROEVocjg1TWZ6VnVOdVh2QUxucFppSzB6ZDVrcW5m?=
 =?utf-8?B?eW55SGluOHZaNHg3L3gvVnVRMWxEMjZqQkFPNWNWR1hUZC85Vzl4ZVpzTmp0?=
 =?utf-8?B?ZG0yanVDUkwyTUhyQURhYVhYcXV3VFVxQkpSaEgyWnVEYzI4enludDAzeG1B?=
 =?utf-8?B?RFBvMjFzWlJPRXdxYzJFOUxBeUM5WkN6T1drTnB2WXVuVmNiczhmUEZkSEVF?=
 =?utf-8?B?amk3UEhnc1pPSzFoTi9oeEd4ODdjN2tYSGg3d3ROQVBLVUZ2MDNRVWtCdXdI?=
 =?utf-8?B?SE90ZlNwVHJvSGtXanZwL2IwTzlXVUhob2krRGVDMGNybEJtTGQwd0Izb0Yx?=
 =?utf-8?B?WjJmZU1FUkFsQm5PVUFyQzQxUU0yNzZORWRScVV2akJUQXRQR3l4NWM1YzZj?=
 =?utf-8?B?TGlKb2oySi95RW9rN1RUcmhqd3V1OWZFcllrMzVvbjNHZVMvL0VKb2MyMm81?=
 =?utf-8?B?OTQ3WGRrVDRjWkRldkxTT0dUek9IWlBHR2dIQnI0MmtVQ1ZrM3FWMkw1c2V2?=
 =?utf-8?B?VkYzQlpKOCtNZUVJV0gzdjN0QllMRnkrSFdOcHU1azduV1ExcVAvT3V4QVRW?=
 =?utf-8?B?d1Q0SjZHT3VCVEVwWWRPZlU2czZ0VkJKbkhqZWtYYWlVNDJ1WHdpMGJUN01R?=
 =?utf-8?B?RVNDem4wTjJXbWxKajh4OEZZWXFGVCtQdU1CZCs5UWtheUJOTFUwR0RXNFcr?=
 =?utf-8?B?QlRKNlRzM05EMHh3N25UMkU3S0hoOXU3U25ERU15MXZxeGFOT05Ka291TFly?=
 =?utf-8?B?ZUsvUWNUZ3hXSytaM2FGMm1FWUpQZ1pnTnE2M3hQTGYrTzQxak5Sd2ZNc0VG?=
 =?utf-8?B?Z3Y3MnZ6M1hBS3FLcWR4VnkzS1QzT1FRcHA1YVJ0UGtIMStsTUZ1bEE0bDQz?=
 =?utf-8?B?ZTZ3SWtkb0RYMmZPdzdWUzRBQnlPbHpsbjJWSzcrcVhNZWNXbVlzcyt1Y0ZZ?=
 =?utf-8?B?RDkra2FuR0RDcUowNm42cStTeWl5NDhFTzBaZytpejVRNGNBaGZGOVNWUzZm?=
 =?utf-8?B?a28zcEp5L2lpN3dENXE1UXJlc29jTFU0Z242U09VSW56K3V0Wmx6N1VGZURm?=
 =?utf-8?B?eCtDdmJnc3M3VnI2bTdZdFhscStpR0ErTnlISXplMEdmdC9JaEJLQ2RFdWdn?=
 =?utf-8?B?OE1LdE1FMkpwSUNoeUEyOGdFQ0VsODJoQ1Z1UUNOSGR2bHhVRkZNRUNJVUY3?=
 =?utf-8?B?MkQxb3k2T2FUQXVaSEJIM1o2UkRKcytlUkd2MGxkMnhOL1dlK1o0d0FNRHh5?=
 =?utf-8?B?R2RldzBRQ2dvdEhSR0h6T1JRUGxVd3I5YTJDcTkwemIvd2lzQTVjKzZRV1dZ?=
 =?utf-8?B?amd4SXkweDBvNVd4dmNpVVo4NHlVMjJwaTRQRFJPa3YrNi9hRklSd3Q5OHJT?=
 =?utf-8?B?STVaQ2FVSlJXVnllb2t5empwYXhjZ2NuZ0pVTU8vd2VpT1RPYWF6Y0pSb29k?=
 =?utf-8?B?TWtpOTdQT2hNSncwemdvZ0xINUkrOGdWVzg3VDVVd3NGM0hZWExvNmdXZ0c2?=
 =?utf-8?Q?IxJBvJpicJobo5f+Pr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 970c202d-0de0-4971-30b7-08df2e1a5def
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:51:29.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et95we2RwFu1drK3eJXTsC1PZr0ATJtM10JMvQ3GePFhLU5XBIVcRrTh3UvTTB+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416

On Mon Oct 19, 2026 at 2:48 PM EDT, Gregory Price (Meta) wrote:
> free_frozen_page_commit() clears a hopeless node's kswapd failures once
> its zone recovers above the high watermark, but only if another memory
> node exists for allocations to fall back to.
>
> The test `next_memory_node(nid) < MAX_NUMNODES` finds only memory nodes
> with a higher id. The highest-numbered memory node therefore never
> recovers on this path, and its kswapd stays disabled until reclaim on
> that node makes progress and balances it, or demotion is re-enabled.
>
> In many cases, direct reclaim many never fully run against a lower
> node (CXL/kmem), and that means its kswapd can end up full disabled
> in rare situations.
>
> To reproduce, fill the highest memory node with bound, non-THP anonymous
> memory and no swap until kswapd gives up, then free it: /proc/zoneinfo
> keeps showing node_unreclaimable 1 for that node. A lower node recovers.
>
> Count the memory nodes instead. Adding first_memory_node !=3D nid to the
> existing test would also work, but a count says directly what the check
> means: some other memory node exists.
>
> Fixes: e7a5f249e6db ("mm: re-enable kswapd when memory pressure subsides =
or demotion is toggled")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 417c427b196d9..6d4f03faf96ee 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2929,7 +2929,7 @@ static bool free_frozen_page_commit(struct zone *zo=
ne,
>  		 * kswapd work again by resetting kswapd_failures.
>  		 */
>  		if (kswapd_test_hopeless(pgdat) &&
> -		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
> +		    num_node_state(N_MEMORY) > 1)

Why does a runtime behavior, clearing kswapd hopeless state, depend on a
static memory topology (excluding memory hotadd/hotremove in this
context)? There is nothing telling us if a fallback node has available memo=
ry.

Just reset it regardless. kswapd can go hopeless later if the node
cannot be reclaimed.

BTW, LLM also points out that kswapd_try_clear_hopeless(), called by
direct reclaim, only clears hopeless when the node is balanced, but that
rarely happens. So hopeless state can stay much longer if there is only
one node. Adding Jiayuna, who added kswapd_try_clear_hopeless(), to gvie
some insight.

>  			kswapd_clear_hopeless(pgdat, KSWAPD_CLEAR_HOPELESS_PCP);
>  	}
>  	return ret;




--=20
Best Regards,
Yan, Zi

