Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020104.outbound.protection.outlook.com [52.101.69.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147E288C0E;
	Fri,  3 Jul 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098560; cv=fail; b=GQQ8hEi7XljiCyFE8bArIfEq6hUIhEBBRS487FIhyHY6Z5d5NyvURQoSaccm5l6m9Y0a+u6w5Xf2eltTpTjBuGA9TJOQO/G6a1XBfgGFXOBgAWf++Q1IF+eRawH2y2ANs4lErgtSBwIWOqg6q3E7h0mnry8FBQaXpwnwFkQmfqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098560; c=relaxed/simple;
	bh=6+mGg2Ek3vDda5/bJ6MSHxOFSAlC3MgJg20Qg/UoV1E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bxzXuqtlureFkyLacDxFGA/ABsBiIFBABT4X4+UJ85pG7hR1TlXweyU7+fQmI5vw9KiRw9W+rqfYGD0XIndXbW5LhiCcVJkkniHlR85xVG+dR1ZD+pLfUJ3qU/ZwavA+9PbTP9nHP2gbzZPXFq8ckFyEWOb8Sc/psiPSCIiqX7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=ywGOQJjZ; arc=fail smtp.client-ip=52.101.69.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ywGOQJjZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6G3reHvgMiw8X6TbK11uPeJgYtq5OZKp5Gm8cHfMKt5GCVcDFL0366IaqGF0ePRUwH71p+7KMvSs4TsEBcPjMmrmCSKB3LcBDObW45TSqAtvKn6zOW66lwL8tEGAHZCLz3y2VWSwOF6+sX7xF5fQub6wxzknYKf1XDtPo4NtDjmAn5UU1AYA7+P13ynMu+vFNnX8kSCr+VA4jQstjswF6LLthIcPCcs3ChxV4xRD7UIQrtdryA7ze1OuQOv+eN3FMy7tX+4X3gdDPIi12zqK1NEzhLBupRniOBI9tD2FMFZmW4QRYNgHFqz96GEXJKPKsoQdMgFfxCD0WKGUmSOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Txsl/MD43yv9ZmVHwsxdPUtsQR3XoAcJNF6zJV7gtY=;
 b=EI4F4kR2WGEmhK96DyJ+X4YAz/OVA0TWsu+yA9B8t7b2Ia/JnxUGjSiOsbc500FZ0kcNqz8H7CBCDmwSP0qS6P5fm6gZDXZamYGcX/SlF7c138pUCbQ8UUWPX3ufAywTCcWaPSAoB/eoQtyR6ltHtrYCh1Z1AENk+FgSa5QVsff/k6IGWUuDtoMlQXG1QLQ14SFPlxCynn2FRP2T4WdUcB3LbLCUGkwR7URLy43EZbQ1pdz4GpOQd0DjOzl+OWHRZUuWy2uKKrwGyvxzVKU7fSnMYjRaBKgBv7MsUuXTzJcpJG3BYrVv6VaeCobp474Cie0GxZYZzWuSumwAtgDtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Txsl/MD43yv9ZmVHwsxdPUtsQR3XoAcJNF6zJV7gtY=;
 b=ywGOQJjZFTGiez2ZZRPByqbACvHEE38xIzqwcqJuK/JJX+8S41OjF4+1hxlXNvV9b9t4gCDYISCqOP0Ve/YUqyG3UkMDQc/vFpIfeM9HmC5ZU+5vdBIL6+5i+pUHlsXabeaFjFQagVYlAzCD8rZdpEerZ471oeLP+x3oCL3/jb+IMCCzp38beAYi8NMW/5UB2XIPSIBh0V860gKI0aVFr10rJV7GJb7ERM1vz/3VSgMIPOArpxSVzVNPr9Ni8smZ58mhNc0sU0eMJ+eF6rxsOmnP8l6gI0+5E95tb4JMbYGhyQGN651lXvhO2muhbWOadbUee8Wth/iexnGM1XSgag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14) by GV1PR08MB10606.eurprd08.prod.outlook.com
 (2603:10a6:150:165::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 17:09:13 +0000
Received: from AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a]) by AM0PR08MB11804.eurprd08.prod.outlook.com
 ([fe80::bf46:f137:f6d2:5b3a%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 17:09:13 +0000
Message-ID: <534fc230-c863-4e4d-acc9-90bb889ab9ab@virtuozzo.com>
Date: Fri, 3 Jul 2026 19:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/kmemleak: fix checksum computation for per-cpu objects
To: Breno Leitao <leitao@debian.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
References: <20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::9) To AM0PR08MB11804.eurprd08.prod.outlook.com
 (2603:10a6:20b:747::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB11804:EE_|GV1PR08MB10606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3085a755-13e2-4bb0-17af-08ded925ce93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|23010399003|366016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MkA2wHUhzEQlHImJ+0yVjwSWKuN39Myw8wDXK5MrXF/IMZtbXckOgnT+y/61CG6Q3CidaIHquv15/fpkum1ka2mPA5qMBNjx0CJoHtsqhyumy8O2GrKolAiTC3F4o6XPGGz0S9hSJ/UmFVVABegoAF0g9snLOlRvk/xJcJr91anxCXIJhd0fbFN0qF5l1XLW779ykjmIUjZqvqhS07/G2d484GjSltlnfzCB63cJE1E67niGJJkskFu+h7uSOeIXapYzIf/c+SIjl5DTxBKfOo5BsXHWOV1Rtf8XJA3SVmiHfV/OAs2YRfwJpCQM3x77F93Wwye7E7D75296Yw3fEzaeLqxfQxMI1/DAtkANeJStOkqyFGh2paQ2b3+yT/d9tsu3j251FyfDxfNAz6eOqb8TJ3W4tADs0xve+Uhxow0CX8fjr+AzNQoI5I8DRWf74x5LzDHYqwaQU0dw8PYWjRI8SYkMDZtjwlZ5y6qRt3qZfQhPU008yfmEEYfwIyCabBrQsAxf/jqgS8KZBK75YUrLvnJeO0RnonzoqExQJAR/R8q6QPZlO8X75H8IqGE3DENq4UUUt7btopNDXpia1P2pYc4gDw9J6XvqVCuaqWx70dzbYFqobUb6clwI+CInmDWBFNiSLaR/mY0jCPGYHf7+991Wkbk6RawI2bLUyfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11804.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTZHZE5aUzJoemczRVVQUkhZdkNZUnZjVHMySkxja2s3eThqdTJ4KzlxZVdK?=
 =?utf-8?B?eHQxLzNhU0FreXpzRE1Qd1M1amZBMWxNU3RUbjRjcFltUzBHZzhKb1JJd0JW?=
 =?utf-8?B?Q0g1TlJhYXVrbXR6V2N3aEtJUmdpWGlYYXZzZHAwUm5NbEEzQ2habkNyNXBi?=
 =?utf-8?B?M0RNZWQvVGJaM1NoSm1tWjFBTS9NOWErOVlTdHhTL3lrbUVzRlhjWFFIS29F?=
 =?utf-8?B?L2hBZWRJT1RDMlRLYjF2SlpKRkZyZS9kYVRSNTh1ZmtnZCsvM3I4TFNBZ1N0?=
 =?utf-8?B?MWF1eVNoZEJDTlY4ZFpWMkF3YytpNFQ0QXNUdlhPcVlIbncwcUlpZHg4OU56?=
 =?utf-8?B?NUtOOTI1Sm5rTDNjVnhIWm50a20wN1gzU3YvVktVOGlzWTZWOXhWem9RRlU1?=
 =?utf-8?B?dDU4akVkVzYwSzZNMzB3aVRwdFErd3JyTGszOUltVm9ydkVXK29FeGYxVDNi?=
 =?utf-8?B?ckJWbzlOVW5ERk93VWJLZmpBVW5iWDZuOXYwZ2FSTSsvWDgrUG10aVZ4NWhn?=
 =?utf-8?B?a2cxSC9odmlrNjdDUlVnaU4wb1BHNytCSVFQeDdSRThOR3ZHekJuUHNoak15?=
 =?utf-8?B?STRKS0xaeERyZjdwTGZ3MnNJaTZPcDJjZVBWbmFoeHhvZTBxWW1Zd0oyUGwv?=
 =?utf-8?B?UmlBdWdPWURIVlg0d3VrL1owMEVPUWx3QWhrY3NOK1l3Z3U4bEJHWlJVaURI?=
 =?utf-8?B?cG1GN2x2Rk9YdElTWG8yZnV1VW1iclhzZzJORDFYVmhISTBFbjZXeUJHd05h?=
 =?utf-8?B?eU1OMjk5Z2I3QmtiY3k5Y21yc0swQXZmOEtqR3cvdWFvT1NiZUMyRVlRdGJU?=
 =?utf-8?B?Sy9RcXJyWEcwNXNGNDJNT3Bka0pDY1gwc3ZZQ0Y0bW1TdnF1VStka2UrOHVE?=
 =?utf-8?B?S3JVTy9PMXhTVFY4VXhUTUpLckhvbjYzemFOcytGV0tRT2dtZFN6Mk8weVEv?=
 =?utf-8?B?QWt0MXFxM05DT3J4UGFhNVBtMjM0eDRiQWlITDZ5NFg0bHlMc20xTzZtOTVR?=
 =?utf-8?B?TkF3eko0Z0d2a0dQMFptVVlGTWZrb09RYUI1V2FLTGZMQlk0Si9lbCtNV2g2?=
 =?utf-8?B?ZHFmZGpBL29pV3JxNkMrbDNUSWFUSmJtaTVCMUYrQ2I1NTY4bU9RL0Q0V3Q5?=
 =?utf-8?B?V2xMQ0pVaFRobEVnYVMrcFhEc1lxRGc1b3kxZmdDLy83eGd2OHFDbERQMlhJ?=
 =?utf-8?B?YWhUTUxQb2JGUVMyd3ZrdCtCUjZ0R1JSSW14dWU0TldjalNYSDB5bTlsK1ZY?=
 =?utf-8?B?RHRkMm40K08xOWlNb1Y1N1o4YUEzZCtTQTJqdW5LQ2tueXZTRC9NMUFCLzg1?=
 =?utf-8?B?akFYVkVjbU5FcjIveUd4bHVJRC9pbHRSWlZDcE1pNkZzWDRta3UxaFhicXJR?=
 =?utf-8?B?S3JldHdBRlZ6RVYvR2VEOVM4SlBTUFhLTUQvSk54VjF3ZmFJbjkraG1ISmZa?=
 =?utf-8?B?OXF4V1hTT1JHNG55STBaS2xMN1IvNEZjNWZ0Yit5dWxhaEFML3dodVRtaGYv?=
 =?utf-8?B?c2dxdk5Lci9wc0pzc1kvaThpb3NLbFZPNTBjUXNPbnpwME5FQTlBVHlFcTJW?=
 =?utf-8?B?Wlo4QU5ocy9qbXhvOU1YREFKK1lUTThCSlNVODlDWW9EZnpKTkhVV0RtZTc0?=
 =?utf-8?B?VCtseVlHMkozVFZQQlR2c2hTNm9uRHpCMXJaZWdQckRJSURMNTVNeHFlYStj?=
 =?utf-8?B?YlFLWHlpRHU4K2NqdXpzditVYWl6RkVkS3lieXdPQVNpS1dVdk5DNEd3anhN?=
 =?utf-8?B?STdpYUJYR1dwa2tod2QzR0tSeGVESDUra1lWVWZZZ281Rm40NlU2K1dFckJj?=
 =?utf-8?B?MTFiVkhiaWJnMGgwc1VacjMyTWxHMHZnMHdaRVZ1enQ2cjFBd1R3NDZjR3FE?=
 =?utf-8?B?dG1GSE5aRkZYRXpNUk1GbzZRQ2lnZUdzUkNwdFp4ZXVDQmFDMzUycFhTbFdV?=
 =?utf-8?B?THF4d0JhblFUMTliTXo3WnUra0kycmp4UHBkaFZlN21BU2JJY3VPMUxtejFu?=
 =?utf-8?B?VVhvaFhxZ05CWENCZmFwU04yUzJJRTgvaDdmcCszellMRThTWDR5TXh0Y0dn?=
 =?utf-8?B?SUpkdlRmMCtQbHIrWDBVQkNDM3hmYzVzMWh0MWMzVCsySXZOUmhCNndHQTNv?=
 =?utf-8?B?anFzdmFWMHFkaWVBbE5JaHlpdzV6RUhubjlnTk1SNFVsSkNaeWVta2xveHRK?=
 =?utf-8?B?VU1QM2RiWCs4NEhWeU9IZnV5MEpPSTV3TkVpSkE1ZjJMayszNm5yaDlYNXUw?=
 =?utf-8?B?Y0JCTEE4aUF0NjFZQkxoRTloaDhOK1BpQzJkTnpXY2lhRE9jem1HQXlWR3hK?=
 =?utf-8?B?aHpLUUwrTGhPUC9DOGhEM0ZlUWdYQ2JtUXBnRmJDSmszR3VwbkxSN2pBb3FB?=
 =?utf-8?Q?pmi7M/MqqGu+ZPFVmyyd9M7rZWGPIrA2/ukR5znsNlTGs?=
X-MS-Exchange-AntiSpam-MessageData-1: T54fJSfL6s0v0kF9ue4NC7DGV2fmQG1j4gY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3085a755-13e2-4bb0-17af-08ded925ce93
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB11804.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 17:09:13.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzfq6QPyVH2+z+qc9aH/fmpgZo7Sd+VvklUc+nKyXo1JNHThlmFuBg2iDF2egQPrCgNTW26DA2LYfSDKRNht6VDpJXsM14ZYJYEvpynfPNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10606

Thanks for fixing!

Reviewed-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

On 7/3/26 18:17, Breno Leitao wrote:
> The per-cpu object checksum folds each CPU's CRC together with XOR and
> seeds every CRC with 0. Both choices make update_checksum() miss content
> changes:
> 
>   - XOR is self-cancelling, so equal contents on two CPUs cancel out and
>     simultaneous identical changes leave the checksum unchanged.
>   - crc32(0, ...) over all-zero content is 0, so a freshly allocated,
>     zeroed per-cpu area checksums to 0, matching the initial value, and
>     the object is never seen to change.
> 
> See discussions at [0].
> 
> When update_checksum() wrongly reports an actively modified object as
> unchanged, kmemleak stops greying it for an extra scan and can report a
> live per-cpu object as a leak.
> 
> Fold the per-cpu CRC as a single rolling checksum across all CPUs and
> initialise the object checksum to ~0 so the first computed value always
> registers as a change, even for content that hashes to 0.
> reset_checksum() is seeded the same way.
> 
> Link: https://lore.kernel.org/all/akfYImSNDh3OjIfR@gmail.com [0]
> Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> Fixes: 6c99d4eb7c5e ("kmemleak: enable tracking for percpu pointers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  mm/kmemleak.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 68a0e30eea1e3..e96e9efd19b0d 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -687,7 +687,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
>  	atomic_set(&object->use_count, 1);
>  	object->excess_ref = 0;
>  	object->count = 0;			/* white color initially */
> -	object->checksum = 0;
> +	object->checksum = ~0;
>  	object->del_state = 0;
>  
>  	/* task information */
> @@ -981,7 +981,7 @@ static void reset_checksum(unsigned long ptr)
>  	}
>  
>  	raw_spin_lock_irqsave(&object->lock, flags);
> -	object->checksum = 0;
> +	object->checksum = ~0;
>  	raw_spin_unlock_irqrestore(&object->lock, flags);
>  	put_object(object);
>  }
> @@ -1410,7 +1410,8 @@ static bool update_checksum(struct kmemleak_object *object)
>  		for_each_possible_cpu(cpu) {
>  			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
>  
> -			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
> +			object->checksum = crc32(object->checksum,
> +						 kasan_reset_tag((void *)ptr), object->size);
>  		}
>  	} else {
>  		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
> 
> ---
> base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
> change-id: 20260703-kmemleak_checksum-e69602b36a3d
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.

