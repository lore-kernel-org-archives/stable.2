Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AC415A86D;
	Mon,  1 Jun 2026 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273062; cv=fail; b=LtqqO1hEcfeKhscdEL0V1BwAGcTJilqJWBhF2cibDQD47REe5jikc5BxdqRO3BJRE8iUZXnkIe8UG7+nh0nC1cyS5uU2Ln1tEfOCKNta4BZg0S4aq4U4VmeR6yyX2g5hLXhInuTZ7QEebCP6oyhPfYPp7eeWsSKKx05RkG82Jco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273062; c=relaxed/simple;
	bh=NL2HOlpFiqAIrLdcF/0eyA43sOQ8yYZBJMqyBt/idJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PkMdVCmdtI0ngW1v2elIt67rVDcbiIHVLhxM0BPjAiY+N2CXrTwcmNLi4c9wmqIDUaCjWkd5PLNGDxLqg/YYti4EoHOpK0sIucLNNLsDeXTf0yw6pbfSNiMeS3KWUCU1zokADjLFZIHjBC5mwiuceh4OCheBieCLf+oojRalDFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ncBMRqsD; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ncBMRqsD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4TmjYNPSLqQgjnZuyq4rRjcxFqy7kI1EHlHFwfmcPmYekuAbLJQQcgbdcyNwBjBsfsmQ9mZwfeF39Pzj1C2ZmRr4Mm5DuCaNu9Ue+zsuG4REkdiq+PVOV5KKgv+4JrntSov9ldLOmM1WK5n21COTl5ydQk00BbgeaoT5bko0Q0YYHUlCRuIjUpGNs/+9pfe3yf0Wjj/YySsQNQtThpgn3bunK8r+STqPO6S5HPHHsr6VeKYCZzjVGeM0sgd6zTkveFQDgam7WW1vApbm4ZKHXzSlqkAzF9mf8YGKAFI4BVCbh4UcQfTyjFTF7esvJ3TaVBnHxZSr5CwdWu8x7PosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xdmjuujdw5Tvq3osOU2KMftKkC1tXXpDqilWTfFkzg8=;
 b=Y245R1UMOK7NDm8lWkbh58lZkTbGQJROhPbI+dhX+Dw5mpJiakw74CRrowvNyy3dNA0ScyrX7FfePAqY93xxi5E3DMYGF4vAfMlm4d4cSajTOY1AzmKr6omW9roXj0pNyO/Ao8RKfg4Lbs608S4Bxal48cOifETeUzbjXFoKH7SrZ0sKtx6P8vRC57FYSrEoTJbkCwzd5E9trAfVSYeDrvI/kuTMnypU4a+7r034GuikDBQWO5qhHp/9rrf4jPixufBEilS2OuZNlhjH37S7bCNeiGfsjNPLq7Jraho3v/mKdYdJnpoD2z6mpe+Zs3Ca4R79G2ubD7pxWWtnQHKV0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xdmjuujdw5Tvq3osOU2KMftKkC1tXXpDqilWTfFkzg8=;
 b=ncBMRqsDVcgF49BndMqlIlM+aMQQWlTaQ/RlzzRAHN0XKwSAsWwoFcLNj/OaRcYbMXgeOzTooZs+hxjGOM5OGb4wTzaEHQM/1ZfwFk+Yif8+c5bSj6PsuryjP2Bel0t3aqbjMIKVU+54uALBVUKqVFMw+UsUebgJK2Vuuzlos1VwBzaT8xHYHbIASgkb1JHCjfzZt0lV/WIOe9YoXPwZS37XAbpNvWuzqtcfk3JadpOD2rTEoFNsZr6WRUMnVbm2i/VzDJGuK7nVkngsNaWq1IjpypI3VcQvx3CU6qXrO2Hlbx4Hh+CLlWg6YK/0opHGEptxLgMsl+Sb2gCJ8q+UdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 00:17:36 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 00:17:36 +0000
Message-ID: <ccdca325-a33c-45ae-aac1-3ac4aea77a42@nvidia.com>
Date: Mon, 1 Jun 2026 10:17:28 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mm/huge_memory: preserve pmd_swp_uffd_wp on
 device-private PMD downgrade
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>, stable@vger.kernel.org,
 Sashiko AI review <sashiko-bot@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Brost <matthew.brost@intel.com>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-5-kas@kernel.org>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260529172331.356655-5-kas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0073.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f6::6) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fa8bca-cbdc-43c6-b9fb-08debf732edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Kzw6wK9YGX2zVKd5KlCG/ihZOzCAUuoCWOhTlikdXPc2HimcuEOcODBfq2L9rLX3bYK1IkoTrr79SSWrVE28CzFWpUy0O/DG1X1yOVoweA9MlVW69pDQtb94Ni92BqjOyyysoeTtIBDGkC/w51IfbFE8avf796n+7/QrgX//hTR1TwaPbuTqbkCeZqkMCPv5Tzcnbm/M3l0T1y4OO3ls8QbNUSdfvdw7jSNtbR4NS62dANh5qPQAp0zk6a2mLzaz1kHd/onAV/l/WvMVLKFNMX4lzhmlaPgUkuvWWeY+HeTwb0etaXaFhqYMQJKEPvQ3WqtWZp4pCOl7+m3TfWzTL2rbL5VNi2BnvfaRpS1Nz20AkQ3k9a9xUa9kRuMaFMFtg9jEZ7LLEcmlmyL5l/djMlezyDNNrqX6idM+m/T7Yocawbek7SEbbW3xc+n1AxlTTCWsbEMBSHSJ2erpdA7ltoFjv54tM7me5bv99lzyJyM2zSC5f1cBoQ/y1pmecHfxSkcteo4NjKhlRlFPN0KjNaTcADpNPVaYVZjxDl1KyHHEyEaXHuOd1xbXUiNo/JOyFXWYrLR+QWbz7qX/cgiqQ9rFZvMrIopOyU5ifD8oSpJxLSJC/YTWiYIhPAXni/bAoVxfxxdxPXUmABCuv4AGTmbLEs7QpuNHMG0fRY8py/F3D+VnB8ZZaT4/UOayoyei
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlphVnBSOGpCeFRoZHZLQUVYZVRab1BZeG1pc1QrQXZqbWp1ZE04cHN6S2xn?=
 =?utf-8?B?eE16NjlUcUdtendoN3dJd2ZwdCtUVStyOUdWU2FlSkxpTmZzMEtPa3dCMXZX?=
 =?utf-8?B?a1FFdmI3ZHlrLzVDNnVSTnlmRlduWHM0WmlxeGhaSmlOcFJuYlRINVY0anlR?=
 =?utf-8?B?MG1yYzNMM3hoT0hmSm1CY2M4bmxVZTl4NEE3aml1Zmc1WWJuSi85ditXNnpj?=
 =?utf-8?B?SXJON0N0QVV2cHhlTWFJbGpPTmZEMEx0b2xMUnk5cTZQaFB0SVpUOCtHL253?=
 =?utf-8?B?ZldLMUJOM0Vub0pSYzcwbHFYOExKRGlhTkpJbmJseEpKOTlmeEhPeU5oMUxv?=
 =?utf-8?B?Y2pvVGF1aUxBUWNkVldrcmV1TDNwK0xKTVAzWTFFRkNZM2RnaFFwT3M5LzNu?=
 =?utf-8?B?aWVBSkdLbkhCUno2QzQ2dTJPVGpYbVF1QjZyazdHd29DQTA0VnU4WTg1Z2hT?=
 =?utf-8?B?d0JwSDdTUGRxTktMNnM3SFlhOS9Hc0pJa1o3MUVtQXVkb05lTk10amFhdTJs?=
 =?utf-8?B?U2U3WUlEcDJWSzduQmVienpkcU96TFBMOUZlR0JPcnJDOXpQQjVJWVpSZ0xH?=
 =?utf-8?B?RVFpcWt2b01GeFhYcWsycUxObUFrai9WQmdxbzJWWEw3SjZqdGh4a0VEdGpE?=
 =?utf-8?B?aU4zVEZQRVE1RGV5WEJldjFHT3kxOXBoaFFxVEhzaXZWR2xaSjZ0L1lRTjdL?=
 =?utf-8?B?WG91Vm9qbCtkZldzeTNET2xka1pEc1BZYytmTGVQOHltT0haMnQ4N2dmZUhx?=
 =?utf-8?B?MnJlbnJ2b1VnaTlIajVMam5aQjdLbFJ4L2o4Mzl3RGdrMWRBNzdJSXhYOWVU?=
 =?utf-8?B?aVpTM3VSRlZXTkx0by8zUjRHUXJpcFRCbDg5TEsva2FmSVBoeUVaS2JJbWYy?=
 =?utf-8?B?UkNvYVJrVndZSHdyTWlXWmFSZllPK1lBZ0EzTGFzU0pYSzRyckpZZjMvYzJl?=
 =?utf-8?B?WHhIY2padjVVeGREeGRydXdhS1B6MmgrazZsMTNENnZKa29hUXFGY0Q1WXhE?=
 =?utf-8?B?d0ltelZXbE1qZ3pDRkd6RG1EVEUyeU0xNEpaa2Z1U3lBaDJzZjg1eTd3N0FI?=
 =?utf-8?B?bjQ1WjBuL3B1aURVaER5VE00cWV2NlFKb0JWb3NveGh3RGl6ZVlKNUh6QTVX?=
 =?utf-8?B?dFpCZjBraHhFbHA3a3RtNVcyR2RIYk1MQnBHWmRWSmdSZXVKQVNNSWs2am00?=
 =?utf-8?B?UWs5U3cyK09HMzZIRjRiaGRrNnF2U3Npdk42dEdlV3BYeVdGZUduWHBtSW13?=
 =?utf-8?B?cmpIemtpWDlGeUZ0MG5pYW90bzQ3SDgvK0VYS1Y1K0ZmUW03NFAzc0Rya3Vn?=
 =?utf-8?B?b21BdUJ6UjFLZFF0L2NzMXpGZHNDbzQ2N1Fwc29Gb1FtTXBPRW8rWm5mZ2w1?=
 =?utf-8?B?aWhJZDd2ZWtsQnRhWjVkZWg0S0hkYTltK0U4cGNPZ2p0bmhQai9nT21QcFY2?=
 =?utf-8?B?bUxnZmxSbzhUOXF2OGl3OUQ5VVFxTWpsNmJ0bnpIZnFTdlVaYjNadndDZXBM?=
 =?utf-8?B?T2x6TUttYVFoeFg2YlFFVE95U1Y5eSs4akRaMTB3N1ZJQ3FTMzhyMVcwclhB?=
 =?utf-8?B?MVJseWxsSUp6RHRnenBqNlVSZnNzWnI2UzhZQm93ZXJPeCtqdzVObXJaajhx?=
 =?utf-8?B?N25FaUV3V0dINDdWZjl3TXlHV3hmTlkxVzRNUnRUUHlyVFJYUWwvS2lwZ2NW?=
 =?utf-8?B?dTNvcnBUd2NHaXFYZ0ZzdSs0SGpiR1hzejdJSFNjTWc0NnJzRjloeVUzNlEv?=
 =?utf-8?B?LzkyZm4zbEZFTWxqVHJ4RW9rQzNzSy9vMUNQU05teGZUenpRYUh2dmRCTUhS?=
 =?utf-8?B?ZWY4S0pXangzNVlXMUdhTHhlcTBObjltUXcrbndqWWh1YVpvVyt4RGYwSkU5?=
 =?utf-8?B?RkQ5VmNSbVQ4ZCtQVWpSZWtyMVhsbTN1aWxpUnBSSFZnRGxHWmxWSXEwa21t?=
 =?utf-8?B?MVI1dTNYLzBpQTI1RUNVTW1XNkkzY1BCWmhOUzlqQVdRNjRoaG5RZGFCQnVF?=
 =?utf-8?B?MVkwM09zT2ZRWmM1UENVT1lqc1JFdDdPc2xaRHRWUWgwYzdwMzQrVlVlR2x3?=
 =?utf-8?B?b2wyR2JUclRFd1VvUWhLZlJwVVVsMFR6SVlHRW9lOTFzdnhOSUp0NzU5WDBU?=
 =?utf-8?B?aDd4UnFXOE9pZWNlWW1uQm9kaS9rZ005eDM5Q3NrSktOSDRmcTI5MnhnV1lQ?=
 =?utf-8?B?dHRWdk9ncXQyekNJUktNbzFhNGVwd2k3UmhOd1VFY2xqeFJuUW5yYzRDRnFM?=
 =?utf-8?B?VThBbExLRU44dWtpQmIxZU5LY2owWFFFYXk1cGF6c2Q4azlWa3Jkd3ZDcllp?=
 =?utf-8?Q?JM2hIADe/r5jeifRvY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fa8bca-cbdc-43c6-b9fb-08debf732edf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 00:17:36.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y6h8GNAJ3gh/CT+vsUKKozPqTkfWAnNzOQ1s92pZjqe5Quu9LeMO6LR8tXA7Z8TOQBEBkP83BFQLeEqzfqRqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319

On 5/30/26 03:23, Kiryl Shutsemau (Meta) wrote:
> change_non_present_huge_pmd() rewrites a writable device-private PMD
> swap entry into a readable one without carrying pmd_swp_uffd_wp()
> across. The PTE-level change_softleaf_pte() does this correctly;
> mirror that here, matching what copy_huge_pmd() does for the fork
> path. Without the carry, a plain mprotect() over a UFFD_WP-marked
> device-private THP strips the bit and the trap is bypassed on
> swap-in.
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 42b86e8ab7c0..b7c895b1d366 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2663,6 +2663,8 @@ static void change_non_present_huge_pmd(struct mm_struct *mm,
>  	} else if (softleaf_is_device_private_write(entry)) {
>  		entry = make_readable_device_private_entry(swp_offset(entry));
>  		newpmd = swp_entry_to_pmd(entry);
> +		if (pmd_swp_uffd_wp(*pmd))
> +			newpmd = pmd_swp_mkuffd_wp(newpmd);
>  	} else {
>  		newpmd = *pmd;
>  	}

Reviewed-by: Balbir Singh <balbirs@nvidia.com>

Balbir
