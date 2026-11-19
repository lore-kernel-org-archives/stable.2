Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795066872;
	b=kwA51tnDJOUni9jju8I31zkpQhf3eEUZBPk/I4i11CAUik15QaNJS1j+WIP/i4v6WKVz
	 cNl0rIbFB9tUUbdWsCQzGoVzNfQD7VyBNDlFZFJbg8LlLL0Un9j3jE0tqc5AWV7xDySBb
	 VAcFlhVN5mlQ3dx2Y0mJz8JM5ZiogoE5DY44X45tzq6176fkAglmEfCfRdtQQaZbMsMW1
	 YyULmikHhSoSInOdchbIBJpjTf3GI3Uq898yjWCvDSPS+9AHjmLHqjSY5TEuYc5cZr6/a
	 Xq3dYU+7G/CVAKYOWCiOBbHZITT+FCBi3eVaTEEGW1fVM3aOfIf7vMEoztLo+GmSc+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795066872;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=GgYN66jJPGZTale8AfLLoJzZ0ddD/o/KygcFldJpJ50=;
	b=yn7VlJxYte+simcWdnzv4EY5/xE/Mj9Gy6l2Q+IfdodE77zveFiTOcnGRYs4iVq7E/IK
	 U7EWLPA8X3mVWBY7xd9Gk+3cxu32vjYL8b/qp/pbF2EXbWyLASE+8tasLn0AootUmyvJ/
	 fwgKdPdwGKZHGra/0RUnO7z3M9UCXaBdIHYxB0o1lJCL95Gga/IebifGx4ZzPknb34liK
	 IUbshmCW4hrElAuSlfhz+STv2y6HB8PkNxuw3iH/XvgvjVRK/Ppfiq1g5lTpLD7P7X3vp
	 7ObQN+vGpz7NBLRc6c8IqxYSNisHzcZBku6lUMpSLQulgVzPDcDyoWrI8GqPJix6fxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cRBFDwzs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.45
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31662606A325;
	Thu, 19 Nov 2026 05:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31662606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cRBFDwzs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9Xn5f8p7bGI8oKO+UEYwBAvqaocaCg6o38hywUdkwv6sejt8r5zIBiX9RuRbDpN5aq9pmQKqZA8q9p4ucpdiXmqvgX0x/y63TVukqKZT4Jtiy0vCEgbrREbXnyEkNGL/pwVGh4tsFgHbaxFwR5mc35nBSQ6u9DWZHaWOMvlW4FvH8SJwpYRZo2VRESqf0JxZMeCiMl72EHlMQ3/3VK1LeWl1SFyoow62dG9TP96iBmrzRzB2XgepkfOs4kzAz6v46q+xb7h4D0oCDfKrJYXlMAz9IPkwLE1x6wYtyQH5TBXgFNUna+q3N3o0Sz+DttdN3A0cN63xLfvQXKajjwpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgYN66jJPGZTale8AfLLoJzZ0ddD/o/KygcFldJpJ50=;
 b=elxilYcVmzZFAN75D2YBg60yTyXU4xkBEmVieLxDqiftDYFkjkw0ZwsTBs4HO3HQr59wbnixsEerbRqk8wwAUwhiCc78e51odz7fkSdHMjUj2KmcYeJ8XryB0l5vkOluaW+LE3r6qlurJ9eJpVQ0p/wOKpsJNc9mbopDbLKYHMq6QQEc31Eq0INL50gHinmdln+kHjfo6ZqfCtMQ25EfBnYqiZhe9/UPh2/9Fu+oUD3+j8eyp58Si/8xZNOJMDmAt7pxOGQkdNiIrLGj29IJrzQbIEjv2KW+f1YbeGZ/+r96qZ+OAtUyxCvbSvrdMtS2DdDXHknp7gDRlQi7TkPTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgYN66jJPGZTale8AfLLoJzZ0ddD/o/KygcFldJpJ50=;
 b=cRBFDwzsX9vwxSREBbpU/TlXsMR2kd9isDHE/gORmPVgfM5dNRVYkbKPkL6S+5AUdbFdoFd6UxGjMoZ0jb2lL9gToeLFo0eUx74tbwVKMAuK4j26Ioq3Uyr4VjQUwEtQSjpp9tPSTMslEKIuICWLlqgDqGRuM0FqAhcYoowsw3Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 CH3PR12MB9342.namprd12.prod.outlook.com (2603:10b6:610:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 05:41:08 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:41:08 +0000
Message-ID: <dafdedf0-1f76-4446-b5d3-4d74fbb0dc1b@amd.com>
Date: Thu, 19 Nov 2026 11:11:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] dmaengine: ptdma: Remove completed descriptor
 under vc.lock in pt_cmd_callback_work()
To: Lee Jones <lee@kernel.org>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-6-lee@kernel.org>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20261117163809.622249-6-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::10) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|CH3PR12MB9342:EE_
X-MS-Office365-Filtering-Correlation-Id: 900d378b-0e18-49cb-836e-08df45ffb5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|4143699003|5023799004|56012099006|11063799006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	EnZsZDxyuf1K6NhvTKK/UTrHXlHi+Fl86kqCBOhQ+qh68wYH8u6qwxyK7oP0ozFJxc/Ob9yduGOpAHmJFWqk4b0fpm6qH1LU5mUhgbnypgXTKDmFQKxjkmKMBPgNbztUamYsUMt6F/7b2Lw3hg+PSlY7ct+ZGEIUMLBM9yyDLSE+UILSYw7RDKwBmwBVA84KVkmcOplopsBECWlKcD1TrD8iKfPN1wqdYHDixUowaFzAFthVSUWQ84X3HOwXK7wpoVtMCrPMc0MWR2ZFkFKBt5itMJ+lHWtwpDrjQH1di3lbhLEozWUR6Vzy88xWKOavAJpR3oMga2Jgs09uFjLuwXnx3hoCWXit7k35NT2ITJPUgiJAoDE0wm8Om/IAC0kOpocGIlghNLUU+JYKmPL5oAwx3HX8cID2/hrvgAeyhdTAQypg2bMdYv/sa2NwdYHT2/NuC1Yh0Boe0aBkuJDy87nzZ8uJXRcjwsAUPMgWeuJQQkG4m6c3nzNtCKy8OwEPQ0pvX0D0l5GB40LRuj9rGaonDWyqUubM2g6Ty6yJc0d8pckSbBmuT0p6gGn+Mqit7j0eZaqfswIazyWkMlDlT6sVRMBmEpO5ud600uehCtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(5023799004)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NBTHFmcFYwNmZxL2ttUWFkUDRSdWhZbjd0RlhCVnBQUUh5TGNwaFVHMUFl?=
 =?utf-8?B?UGVraDdWQUJkVFZZbDh2ZDZvS2JzNW85TUdrMkUzQkczTWhYR2FwSTMzVVRS?=
 =?utf-8?B?ZVFQRXpZdEZ3azQ0RGpSdFYxZ01kVHdxUUdtT0dVY1R3Mk1RSHFEajlXNitE?=
 =?utf-8?B?WERDdGo3eFZaN1NSZzJ5ekk4aHR4NFBlOW8xc0xQc0F2bVY0YWdXUzJoOEg1?=
 =?utf-8?B?YXJvUWdkeFFHdHFuUU96MmplWDU3VloyMXluZTl1NHV4VHprQzFHRGErOWJB?=
 =?utf-8?B?QVppMHlJcnNVc1o3eEZyazEwRlByLzBmVVM0V1NtcGIwWS9EbmpVRTNWa216?=
 =?utf-8?B?VVBaNWxNS0JXUkRlc3NrK0FiTWpCVDNKbGxBNFhYcDltWVF3M3p4Z0FaNzN1?=
 =?utf-8?B?M1YvdWNhSWt6UFVVQWUzbXYzaDJ2SW1aYjBpVWRTaS83NVJqNExTSjFuaEx4?=
 =?utf-8?B?cEU5RVd4TFJNNmpybVJNV0xrRk9MSG9hL2d2ZjY5Yko5MzNwZ2QrZkZYcHp6?=
 =?utf-8?B?UEcyVm1YZXFqNEtLb3g3ZWxuVXVsbW5uQXAwS21UUm5kQ2tMSkpSVFpOYWN0?=
 =?utf-8?B?dW1wem9tOUFmc3F2ZWN6TVh3Ym5WbWJaU3A5ZmNGNVVYeENDZTM5RFlaOUlC?=
 =?utf-8?B?L1pzdXZhWmR6RkRKVzVTQjI1VGZzL284Mkg2dTBtU2xoV3lZam1wNFJqVStB?=
 =?utf-8?B?a2dDOFpzM3NJaWx6TjFwTUN4UlZUM3ltMEsrY2hHSEhOMWw1N2JBTVU3ODUr?=
 =?utf-8?B?RjdXM2dGdjg1eTd5VTRteWowbGhnQW9FRDJBZUZYaURpNjRCaDlOeXZzOWxG?=
 =?utf-8?B?dkMwYW1wNGIxYndZWnhnQ0xpSHJGK3NlU0JtZkdWQ29IWUhxOXRoSEFkUThU?=
 =?utf-8?B?TVBialAvTFRsUUlnS3ZETlBmMjArcWNROXhZWDZyYlA5ekJmSDNaVnhBRUxF?=
 =?utf-8?B?Y3piZVUwMERyRGFuU2h3RDNFa3QweG8vU0Fuc0ZwQ25NcStZT0I2eDNXdU5x?=
 =?utf-8?B?ZTJtNGhNTTIvTmExWFIrRFB0QStBZWtFdmwyMEhqamZqdFRaM3F0WDJoU2RG?=
 =?utf-8?B?cDlWUnM2MXNkRUFVclBWVURRdmdqZXJkeWJ1dk9pb0VxU0dWQnRIVWxGZHVV?=
 =?utf-8?B?Y1dzY2plWmZiUFY3cjBoZXI4QXFnbzloSGdzWktma2xsazIyeEtnZ2NvTVNv?=
 =?utf-8?B?eGRYUUs5UFFOUFhYdm5jRG5MY3dMN3Y5ZzA5VFBocXhWRnNOZ05qUm50eVpj?=
 =?utf-8?B?d01WeXp4aVVXTVlmWEVkSW5JREYvenBZMTJwSmZHYlZyTmx3S2VmeGFQVncr?=
 =?utf-8?B?bkI4cEdsRmJ6VW01YXVZYUlocC9qK1VJaXZkS01ySG9Od2lnNEFFZGkyODJz?=
 =?utf-8?B?MG1hbkJhSGx0QnpISXE2bExIeEZCM1BzSk9xMkd3aDVqS0V4M1U2NEZCL3g5?=
 =?utf-8?B?clppdi9LL0Y4V1VYdUFDSWJ3SFl1Y2lXcENWSVI3S2p0VWdJYU1pOXBKTTZr?=
 =?utf-8?B?ZDVTc21JMkVUdExtQWczOTJoMHBXcjNNTFlwQlhoYWtaWTRMT25abUhhZThu?=
 =?utf-8?B?M2tiVXI3WW52UkVoZjVENHpJMmM4WFBhdytMVGZrSGFKcmNhNW1LdEJJU2pq?=
 =?utf-8?B?eUpYTStuT0RHdXhBcFVyc01nUnpxclY5TFdMT1UwV0dQTDNnd0ZtRVBTbTV5?=
 =?utf-8?B?ZzFLVWlBblRDWmtWVkFvZ3RZbVJZcDh0YU5KRkJkdmw1N3kybFZoS0IxeVgv?=
 =?utf-8?B?WlRhS0tPOTZZbVNYZ2FxOEc4dEtHdzd6dFo0dFBJNEZTLzN6OG5LUkUvLzNG?=
 =?utf-8?B?ZW40cWZpY2tYQTdndWFUVDRodEZzMzZ0Sko5eFVuQllmcjB1T3FEeUFMejZY?=
 =?utf-8?B?bTFsQ2Rka0lGTG9XMUdxU24veGdLdHdpZ0RYVUMrZDFFbWhEbUFEUGovQ2pV?=
 =?utf-8?B?Wkx4TEx6QS9vSlVlS01pRHR1eCtnUUFrb3NFM25leDBVMjh5SWpBREJpZENZ?=
 =?utf-8?B?UFk3T2tjeWNUc1NsVEpyQkVwbmVXQm1tQ21hWlUvZDMvYzJUaTZtSXZZcmNj?=
 =?utf-8?B?a292MEQvN3d4dE9yeUtmRWEvT2gxQ254cmRhOHVidzZkQmVmRWFPa3hub3pO?=
 =?utf-8?B?YWZSTFBNUnAzQUFGNS82ZEdpbm9JTU9mc0RWZ2tNZWhTTi9vcmJYTy9HVW92?=
 =?utf-8?B?QjZLczhNb2lUSEtYQS9XMkdhazQxVVczREIxWkxsTzhqdVgyNFcvWWRBL3ZK?=
 =?utf-8?B?YUhOcjFKSytMZ3pjUGw1aHl0WmxSY09rNGVhS2Z1Zy85OVY4NTZhVElXUXNo?=
 =?utf-8?B?Z0RGOUpQVjdndlhBRTUrS3BMZXhqckMvUUd4dkpMaDIzaVJCQWJoUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900d378b-0e18-49cb-836e-08df45ffb5aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:41:08.0389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELP//fqpPI7jzpPodk5CQEusMneawwQSOJmQP70+gz+ai9yIPfAcMXbVChabdOa4CkN7KWIGxD14ZtT9GTIhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9342


On 11/17/2026 10:07 PM, Lee Jones wrote:
> pt_cmd_callback_work() drops chan->vc.lock before calling
> list_del(&desc->vd.node), racing with concurrent virt-dma list
> operations such as pt_terminate_all().
>
> Move list_del(&desc->vd.node) inside the chan->vc.lock critical section,
> matching pt_handle_active_desc().
>
> Fixes: 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's multi-queue functionality")
> Closes: https://sashiko.dev/#/bug/linux-55f1563b-5563-492a-a291-1a5b772ffd42
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 => v2: No changes
>
>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> index a0a1c7ec2ae5..a75a9a316e83 100644
> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
> @@ -365,6 +365,7 @@ static void pt_cmd_callback_work(void *data, int err)
>   
>   		dma_cookie_complete(tx_desc);
>   		dma_descriptor_unmap(tx_desc);
> +		list_del(&desc->vd.node);
>   	} else {
>   		tx_desc = NULL;
>   	}
> @@ -373,7 +374,6 @@ static void pt_cmd_callback_work(void *data, int err)
>   	if (tx_desc) {
>   		dmaengine_desc_get_callback_invoke(tx_desc, NULL);
>   		dma_run_dependencies(tx_desc);
> -		list_del(&desc->vd.node);
>   		vchan_vdesc_fini(vd);
>   	}
>   }

Acked-by: Basavaraj Natikar<Basavaraj.Natikar@amd.com>



Thanks,
--
Basavaraj


