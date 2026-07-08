Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269F435EE9;
	Wed,  8 Jul 2026 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528547; cv=fail; b=IjKUgMDdI+l7vx0rrUMuPDODxYP2LjtLUcHctVsceGi5bfgVlzZZ9wLfOCrXh64+2vPsKbw/nDq3DGA8AYhalRyNmEH4JW+YIjlmu3MCbxFx+jcJRcXtTrYxCCrKg9eU45q5ADeJ0tkw1UkX4Q7dN2TF1ld30Lq6wbD+Ch36HmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528547; c=relaxed/simple;
	bh=u+7hOWpD82o3neUfP6frZilp5gXk+hEUYQzSCLkQJHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TL0QzoWzlM1C71ALJhnIEnY3uHtM06ONVorudtrT5oYSSqTiMxzV2daZz4JTUUFCSBxXDordi/t4B4ujpOCP+tSb8/aJxl8xu8l43J/gLg0W1LqtRerKLxBW+K9PAL/NC+OrjNcoQj+7HdHVdoMnX2gXZHOtYiKl+CbruGlikZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L9ndiurB; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L9ndiurB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAgJOA701Q9JtbWuAtOOmLI+q4OLkVNoEM+/ap0qsTIdtYDm32gtaQgCoyMfkey1hDlzRLBfeBE5KBfNFrBf6q6TiEMwt6wZ6ZE7x0fXdIQJg58kCAeNLmQR6EgaZQvw5z/V10Sm4TDkJJuuNniTdjWda7xYRadGcnUKuDAmcGWiEMSqnf68xbUfjCm1jyin9x2XdUk7w35mftMSRzxVAsp7GVOLqqZUpleNM+STzF7H0E+UL/xWZjnpuz+HzIUWUz6yJKNuv8hlKLso2ET7yZ9TbtTN7JpJ9ArG8H5poEW/fNKghaylt/UVbnVj89bGq6sG40etJ3ryDiq8JiZYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KetVz6X+A9sXh7GEUPcXFZwkP59ve4HHpspwdSY8T80=;
 b=d63NrXCE/bccxB0lLcw5MlEsj0R8uXBKZvHGU79HRMmckV5wZgAQ37nvJ067ZOkQifAox23yUxQSZE4/7Ag1WxDPzpD43k1uZDzanMCkaLKbT6lqXhg3j2qmkI4CH2aA96VCX8fX+7BEGl0ur3/hhFQCRWBTvkgxSevuUDpisZtVj/zjSkaZBPsKs2004GwdINCv4CuwBJYi16yFzdJI4cDtPfiiQm9wJ8udlABmDhPddYVsyAydaJlxnhMQurWTrvCRdNA207a5u+G7y8nbKXODspCQFnNPr2A9qHBzj+Zm/UZhPZ2AE/109kg2/Nt8TnKQIsLwzpjVmibK3miufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KetVz6X+A9sXh7GEUPcXFZwkP59ve4HHpspwdSY8T80=;
 b=L9ndiurBCuz+pfu96xv/9rkWuvrpQOoUN1PC3+5Gd5yLAY36h9Od3nn85b/w0aGB7sZVFNLiwjB6ZJhgkJszgOGXP8fe80BAJ4dgUtAgRenMV8cYmijbvbBqjzBmWHMRzD38vhTtGmCkcZxRQJ2zQrPcVQF6JwZ3Tmn5IYbYkxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 16:35:40 +0000
Received: from CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6]) by CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6%4]) with mapi id 15.21.0159.018; Wed, 8 Jul 2026
 16:35:39 +0000
Message-ID: <1d0cf7b6-fe94-4a5e-bdbc-e75a371a41f7@amd.com>
Date: Wed, 8 Jul 2026 18:35:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: "David Hildenbrand (Arm)" <david@kernel.org>, seanjc@google.com,
 pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com
Cc: bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, hpa@zytor.com,
 yangge1116@126.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To CY8PR12MB7433.namprd12.prod.outlook.com
 (2603:10b6:930:53::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7433:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1640a9fb-d121-4265-80a5-08dedd0ef1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vxzA1aOXLPMdtPR3ZFSAhAVavt49mH2LwQQpLC3DrMBMtlWt+ahLB6rn/6PGUrF9Xj4et+T9WKjtjWiZbYtBL/1xrRbFToLg+GwBrpnCft8M51WwvcM5Ch2uLifGnx9aSAsk+TsIoFgcx1Kp/XhEaQz7uq07LW2HYnClc+WNCWAqezCxtTDA05OI97mYtKCKBzmwL6f0c5MOnaELpcoybKQcZ8nY6HbWYoeYQxsfIbzs3WAnDkrx5V9FsHDDuVq+UulHbFXAIIUrUkFxdu0IIa+6k6xKkDVW5pQG2hygcvixtk0YqyfHPKHp0CGlMMm15NAsRgrwdomzCP3rv41L7Rw3tFRGJcckFC7TPjeVtvOzOYw33c6kvtbk7EPb7yp7ZBr8Hs9Pv0iYjGWJGkcMDU0Z/Wa5MOlar/005Ej8Shf2488ELjPECemEFSQcczCQdIm5uTanX4/P7iE/TA43t7xT0fN3YwvnkQhQdvo653f8iCjPGXJK5Ew375m4Knx+uIArWySYCfvwXkWjwKDK0+5BNHXxIbIryPq5yOAGm0y3Ksu81SSQLcANiMKN/MlGGspwa0zjpo4LsGyV+BOx0WxZsk6Alic/3LrKStmxejeTKjaQJckKG94KdVudIePHHJMKlaK54RwgQHqNUXYEXJyJg7qjiXiyNu32GkBXrhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7433.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjJtclpoOS90OWpOSk41VytLMmZUY2dQNDVobVJqZ250Zkh6VHRtWDBDYk45?=
 =?utf-8?B?ZzVRSVlSaG9Pek12dUV0OGFHd3JaVGtBZ0dlb0tZamgzSVJDeExNRHdZZ0tr?=
 =?utf-8?B?L05vZlVXL0tubGpoWlcrdElxaHgrSk1KSE1DY1p2aGZGcHhmR2JTQUdHR3di?=
 =?utf-8?B?a3NFSkF0TWxqem9XNUxmY25tdjRJc2JzeTRmVVRpT2pna3A2ZnNITGRwRWtR?=
 =?utf-8?B?YjVjRkZFUzVtOW9uSnBSRDRzSWRSNGJiMDAzSjkxclB4b3hGNGVEak9kYitS?=
 =?utf-8?B?NFFlbE10UUVUaGRKcFhPNGowUVJpTTNWL1JyelNHWk4zd0R3dmk5NlZQOHBp?=
 =?utf-8?B?V1BCbHRsQk82dGJxR05WUisxaldlSkxwZmt0N0g4U1F0Nms0b01UaW9TOFdI?=
 =?utf-8?B?OTB5cVE0dnpTdW9MZVZXTGMranlwenBwZVhmRWxENDZ5bXVxUzFEMmhHVDJ5?=
 =?utf-8?B?WjlrbCtUbU1pN0hXSVVvTUxYZG5TZzJXVHFmSjl0bnFYeE9YUS8vK0t2WGNj?=
 =?utf-8?B?NGNtenNFbTVFUVlVUGZibEdBUEFaYzNwbTN3dStvZldmdzJuTkE4S0dySWFB?=
 =?utf-8?B?RTZCRnRuMnhUTDlWNUZaZ0RwdkE1OWxLRkJhTEFvbE5TNzF6djJnUTgxcTRU?=
 =?utf-8?B?VlM5YUdKcnpqRU82VGs1YmphTElJKzc5cE8zT3Y1bTFGNlNBT1d3SFpJUm9V?=
 =?utf-8?B?Mzl1YjVkTnpBZVA2ZTQ0U3ViNHA3cTJtUnBzTG1lb25TVzkvSGJ5Tjl6T1Vu?=
 =?utf-8?B?RlRXT2llNUlBNTNINmRBT1ZRT3pmeWtYcmNzUXU0WC9YaXZqVUVJMGpSbklJ?=
 =?utf-8?B?VHppUzc2NlVSOFNZa1pNRG1XMnRnYXZ6MjVhZVlhdTMzdWhOVVN0aVZGUjRI?=
 =?utf-8?B?eVhIZHJTZFg0WEVJVGJDbW1CMHUxcmtQNGFuZkNYYVhhMkJFb0Y5c0FQeS9n?=
 =?utf-8?B?VVhOOXl3MDJsSUt4QnZyM1dTNnpRYnN6akpPcjFOUlFHT2tGc0tPcFRDUEVU?=
 =?utf-8?B?S1BWeE9yUHlOcTR1cHdmeTRWVzRWeVZmdTZwYUJ6cHp1THhGcmwwOFpxeU9E?=
 =?utf-8?B?ZVBuanRzOHNXTFd1Z1dsS2hjRlM5ZGMvblI1dVI5Sk42T1lRNlI5bTltR3Vy?=
 =?utf-8?B?OW93OEJxYnpYczFDeVQ3L0lrRnpLWHU3R0k0QjhwcTBpRTI3WDZwbE8wR3dr?=
 =?utf-8?B?a3VTSEpNMm1vZ0FXUWdvaUhlc2dVR1p2MWhDbHZJNWFiYVl5a1JWbnRUMHpj?=
 =?utf-8?B?bTR3TVEwSjljWGR2MXZsSGZmbmlZUmo5RVpEa3NkbE8waUlIb0k3VHVidVpw?=
 =?utf-8?B?L0VvR09PY0pCMm9pZDZzRDkwTGJvVEVSVmdFa3FvL21CQlpxZWVrLzZVY1Rp?=
 =?utf-8?B?QWMvdEwvUm5IKzRQZFE5dzVkRGFhMDBiV0N4TEJFMnhhbkxoTTRQckFrWE45?=
 =?utf-8?B?dFFOMzJXVmhnM2NzeWZQdkhhQjdEd0pJN1BNY0V1d1VpWnpvNEtUcDk4Mzcr?=
 =?utf-8?B?WGtCNWQ2LzJwT3dKOVhBZFVjMm1zUkNJMk5TUHd6ajhhOExBT21WQStRMnQ2?=
 =?utf-8?B?K3RjQU04N2NQR3dhSStaUlJrNmJidm1CQlBITG1GTGJtL2pwcnRaZ3l5cFdC?=
 =?utf-8?B?Q2k4SVMwakZNc3FhVVNrL2ZGSE0rTjJ5THk1LzY5UmJwcXBqMW0wa1ZqRWJF?=
 =?utf-8?B?UFdPV1VjVkNLSTVJUGx2NjE4U01FKzhkN0lJb0Y1UGJESFQ3K2czaXNreldZ?=
 =?utf-8?B?Yy9iNnRUNlJHNG9NTDlydW9YQUlTUytEK2FXcU9CaU1QU3U5Z1NIQVQ5VWFJ?=
 =?utf-8?B?Z2hqN1hDYm5VYjUxNENJbmU3U3RmMDZXZS8vSUwySWppL3pGZHZ4cmtMb2JS?=
 =?utf-8?B?TU85cWZhbkJPTU1QOG1CeUNPaUZJL0xyS3pnNmJNOFZpMG5tdUk2OUNTR0xp?=
 =?utf-8?B?L0V3WHlrRTF3enBSOGxMYkVIVDcwTmlBL0Y3a2ZQSmRmaWZaU0lPRldxb2ZY?=
 =?utf-8?B?a3ZIUjhBemRFK0dRRmNoZm1wenhYOFAvcXppcC90WFpuMk5VRVpMZXpxSmFh?=
 =?utf-8?B?bFBVNnpxNzVyT2ZteFhjYVVBV3Z2REJRZ3IyYXpJQkVGN2o0NEVqNWJ2Umd4?=
 =?utf-8?B?UEF2TDM0QzQxU21HeHpKOGNZVFozcGlveW1RdGZCM0EwSlFWNEZiRTZGVHRH?=
 =?utf-8?B?MkdCcEZUQmcwRS92eDNFeTFya3VrZURIUU56ckp5MmhLcVlrQzE2K0t4Unpo?=
 =?utf-8?B?bXFNVkJZM0p5UlNjSnkwNWdDZVVIeTFoY3FWa2lXNnVwa0VnVVFVL281Q2t3?=
 =?utf-8?Q?uXH1d/i2d+lL2CDtp6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1640a9fb-d121-4265-80a5-08dedd0ef1d5
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:35:39.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0Rw4RpDEM1u5gAJSdxR+n33zI/R4jvxor2vlitBk0030melaegr7JRHvyKsQshgOy+63V5xBvz7gbWlxacP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165

Hi David, Sean,

Thank you for the discussion!

>> Yes. For file based mapping we don't allow long term pinning.
>>
>> If we take into account the fragmentation concerns for MIGRATE_CMA and
>> ZONE_MOVABLE allocations
>>
>> solvable with FOLL_LONGTERM, I can think of two options(tested) to allow file
>> based mappings as well:
>>
>> 1. Fallback on FOLL_WRITE when FOLL_LONGTERM fails as suggested by Sean.
> That is just not acceptable, as it breaks random other stuff (MIGRATE_CMA, as
> one example) besides the file-pinning problems that Lorenzo added.
>
> If we're going to hack something in, then that we bypass the file writeback check.
> Not that we don't use FOLL_LONGTERM.
>
> I'd hate to use a GUP flag to indicate "this is a legacy hack", but it clearly isolates the
> issue (needs a better name obviously):
>
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index ae9bca4eda5ca..e2c531f914d44 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1912,6 +1912,9 @@ enum {
>           */
>          FOLL_HONOR_NUMA_FAULT = 1 << 12,
>   
> +       /* TODO */
> +       FOLL_LONGTERM = 1 << 13,
> +
>          /* See also internal only FOLL flags in mm/internal.h */
>   };
>   
> diff --git a/mm/gup.c b/mm/gup.c
> index 0692119b79043..1fa0aa0cdc99d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1186,8 +1186,8 @@ static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
>           * If we aren't pinning then no problematic write can occur. A long term
>           * pin is the most egregious case so this is the case we disallow.
>           */
> -       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
> -           (FOLL_PIN | FOLL_LONGTERM))
> +       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK)) !=
> +           (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK))
>                  return true;
>   
>          /*
> @@ -2746,7 +2746,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>           * If we aren't pinning then no problematic write can occur. A long term
>           * pin is the most egregious case so this is the one we disallow.
>           */
> -       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
> +       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE | FOLL_LONGTERM_HACK)) ==
>              (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
>                  reject_file_backed = true;
>   
> @@ -3180,7 +3180,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>          int locked = 0;
>          int ret;
>   
> -       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
> +       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM | FOLL_LONGTERM_HACK |
>                                         FOLL_FORCE | FOLL_PIN | FOLL_GET |
>                                         FOLL_FAST_ONLY | FOLL_NOFAULT |
>                                         FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
>
David,

Yes, the above approach works with few changes [2]. If it looks okay 
will send a v2 .

Best regards,

Pankaj

[2]

> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..f9af801788b0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1911,6 +1911,14 @@ enum {
>          */
>         FOLL_HONOR_NUMA_FAULT = 1 << 12,
>
> +       /*
> +        * Long-term pin without kernel GUP writes.  For callers that pin
> +        * writable file-backed mappings only to prevent migration.  
> Must be
> +        * used with FOLL_PIN and FOLL_LONGTERM.  Bypasses the writable
> +        * file-backed long-term pin restriction in gup.c.
> +        */
> +       FOLL_PIN_NO_GUP_WRITE = 1 << 13,
> +
>         /* See also internal only FOLL flags in mm/internal.h */
>  };
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 0692119b7904..a83d100f7950 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1186,6 +1186,10 @@ static bool 
> writable_file_mapping_allowed(struct vm_area_struct *vma,
>          * If we aren't pinning then no problematic write can occur. A 
> long term
>          * pin is the most egregious case so this is the case we disallow.
>          */
> +       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM | 
> FOLL_PIN_NO_GUP_WRITE)) ==
> +           (FOLL_PIN | FOLL_LONGTERM | FOLL_PIN_NO_GUP_WRITE))
> +               return true;
> +
>         if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
>             (FOLL_PIN | FOLL_LONGTERM))
>                 return true;
> @@ -2530,6 +2534,11 @@ static bool is_valid_gup_args(struct page 
> **pages, int *locked,
>         if (WARN_ON_ONCE(!(gup_flags & FOLL_PIN) && (gup_flags & 
> FOLL_LONGTERM)))
>                 return false;
>
> +       if (WARN_ON_ONCE((gup_flags & FOLL_PIN_NO_GUP_WRITE) &&
> +                        (gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
> +                        (FOLL_PIN | FOLL_LONGTERM)))
> +               return false;
> +
>         /* Pages input must be given if using GET/PIN */
>         if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
>                 return false;
> @@ -2747,7 +2756,8 @@ static bool gup_fast_folio_allowed(struct folio 
> *folio, unsigned int flags)
>          * pin is the most egregious case so this is the one we disallow.
>          */
>
> +       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM | 
> FOLL_PIN_NO_GUP_WRITE)) ==
> +           (FOLL_PIN | FOLL_LONGTERM | FOLL_PIN_NO_GUP_WRITE))
> +               return true;
> +
>         if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
>             (FOLL_PIN | FOLL_LONGTERM))
>                 return true;
> @@ -2530,6 +2534,11 @@ static bool is_valid_gup_args(struct page 
> **pages, int *locked,
>         if (WARN_ON_ONCE(!(gup_flags & FOLL_PIN) && (gup_flags & 
> FOLL_LONGTERM)))
>                 return false;
>
> +       if (WARN_ON_ONCE((gup_flags & FOLL_PIN_NO_GUP_WRITE) &&
> +                        (gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
> +                        (FOLL_PIN | FOLL_LONGTERM)))
> +               return false;
> +
>         /* Pages input must be given if using GET/PIN */
>         if (WARN_ON_ONCE((gup_flags & (FOLL_GET | FOLL_PIN)) && !pages))
>                 return false;
> @@ -2747,7 +2756,8 @@ static bool gup_fast_folio_allowed(struct folio 
> *folio, unsigned int flags)
>          * pin is the most egregious case so this is the one we disallow.
>          */
>         if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
> -           (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
> +           (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE) &&
> +           !(flags & FOLL_PIN_NO_GUP_WRITE))
>                 reject_file_backed = true;
>
>         /* We hold a folio reference, so we can safely access folio 
> fields. */
> @@ -3180,7 +3190,7 @@ static int gup_fast_fallback(unsigned long 
> start, unsigned long nr_pages,
>         int locked = 0;
>         int ret;
>
> -       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
> +       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM | 
> FOLL_PIN_NO_GUP_WRITE |
>                                        FOLL_FORCE | FOLL_PIN | FOLL_GET |
>                                        FOLL_FAST_ONLY | FOLL_NOFAULT |
>                                        FOLL_PCI_P2PDMA | 
> FOLL_HONOR_NUMA_FAULT)))
>
