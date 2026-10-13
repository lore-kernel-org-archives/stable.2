Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011012.outbound.protection.outlook.com [40.93.194.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781D4B0C9E;
	Tue, 13 Oct 2026 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887573; cv=fail; b=hvOfOfhtemlCwVEnR+5JPRccBVVqMxi88/Xw6TuVBrZej19Y3YvHEAE+SkEgACqCfRDTtQWwel4ZHVjLXXYgo4S94lGsepiv+xYWYeltXf/AEdiL6TBChSqASCpol74m5TYX73kd1oGB8zXI4zaeHmjhG1yP6efzxvmEHKnIgV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887573; c=relaxed/simple;
	bh=qRMk9IeFCsOL5AOecD0ZD9eE41EBpJ2ikUrs5OE8cqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dUL6De79pPhOjxWuSG+VLAVGOVfUopbiYQ2X8TkebHlHOkh4L4+atNb6T4RKVxSHuNMXIdnc9n3HMVk2Mknbkc+XDXGMzeh05lBzaE0krx3M+lymHX+VWEjI21JHkQe7APMUxjfd+1bqKk00kAhr7T4l5tK7A+3PSfLTVF6MPas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zWIpKHk7; arc=fail smtp.client-ip=40.93.194.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zWIpKHk7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhjUkNiEGRE+7sfg3egFvxztWyPCHst5jf6StTbY2EIsOl8A3QHh9cK2H8GU1SMSwNmdNV8/brh/aE7IaBgOkeOnHi6vI/wx+lVHv8dJK1HF22BW135pGVKYMfi1K/TpEGFa877elpqDR56UHHSerKmp/y9FkuRlCeon8hQtDdEY5+UECZd4mAxkAhr2FxHSsv2weyzXULTJyLLnc2WueaHJcVqSgnC4AxIqq247vQBpAYro7jZqgWgtax9z/ifjAD9y3e0Weh8YUI5Csrt2ukVBxQtxtyoHtk2Gcs0sLVPOJoIR5N8o0cpDwx07ULEaOuQdYkYEtKFW1SuSxKsYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QADdGo93H30LhnDUtLuiGSRfN59vq/jLMxnf8LbGG6I=;
 b=RHFie8BTjJcauEWiiA5tlaRaGHaChlVJwOpLsUqbpSHUU+WIAL8xgy2g7xpVLiPUe2s7sDUJWzR9MPQF1p+GWwKAfp7XXNCJBoJirnO81iRu+Ax43qcyoGjjrz/EjZRjIWSyQKY3+V5Xwvr9KrutLWEbGHEBt/iGCKMLlSWMAetNwAcxfxrp3p2LDkN6hlCKJvoiZygmKAQK6NacEWO/K8WMT9zA6HTsCH4rBycP/MbmonQUWKuBPrPMJkPiP4PUJb7w0bYb5K+YoXhQaNHi+aBGDecZ+Z6bg0taban7XaRg8CdIt0HrO+K3QjWkZMtZ+sUZnHF558rL2BlBRrIj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QADdGo93H30LhnDUtLuiGSRfN59vq/jLMxnf8LbGG6I=;
 b=zWIpKHk7m6vaMVpLqUnh/2m+tMiuw0WZmWTejT3Q9zduuIYcTAv4arq3ZYnT5Mnm24SZXiLxjaRYCuPii2KnsM7VETyNzuMqIqO3xUtkml77gf59EXhDr2T36p1XzNsJAzVGzBRn8MeZ1zQqaalrOaO27+YIrufj8lbZAGjMfDg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 13 Oct
 2026 10:32:46 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 10:32:46 +0000
Message-ID: <25da2a40-e197-4415-bcde-48f71d0e1f84@amd.com>
Date: Tue, 13 Oct 2026 16:02:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Program device table when kdump reuse
 fails
To: Matt Fleming <matt@readmodwrite.com>, Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
 Baoquan He <bhe@redhat.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
 <20261002133143.3628181-2-matt@readmodwrite.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261002133143.3628181-2-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0162.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::17) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: d6013837-f212-440c-e0cd-08df2915527f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	e/uAE8sAaor28KPJyGuk3QJXJeXjfxpUqMZG4YoJiI7Gv6vIrHElyySxyoCuySoDtM/orfkGZLMacyNADoNgRyn/IbJu3VStZgbjyD257JorsT9A+crulT/YImD0OR4xb+qULQj6KhxCYkM0vR4GKMzYZF4bn06vEdw3sN+ZCY1cYkKg0vq1HkEbcjOQ7XkkjrDPDlHcA5FZmxVLsqgGtL4cTfncalKpvtl3Iguki04k/Xqx2JlB7oSk+J8xOBhGnR3ynfXuYuDJHGULFngi8/pGPWQkwHMBrbN2DwiXfvMy6Jqgpbc7gbQBlSzbfT7xz08Tfu3o/DttkRL9yIYma4ojbjCchSO9tIHN4FH1Z2pN3780emgFAkEwEBH4jzJ/WrKQxBqyBQSd3ME+Ihc1rJOIVLNy0JDs7EgmGrCKiSm44ckCxZ7lGGuEzPDF8EqKRr1f44exMaVtsY7E7ISiz9S4ExcO2Awjtd8wZfqE9905LcuXqU34zJSXDZvsGfYPSKxLq06jajVKRPsT64WstDhRRbN4bqDcfzsDjEvD7l30VW98/IyMpYMBoAooKT6MyHFMalgU3SBPZIPtJJG+jOeDMZCRg6JApE8tN6hqERrlzDxupONYPqvg5czbyrMnFfUuBdeio+PQrp+/CF9+cxTmHIGgbfWzOO00FtvOIIw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEJNc1BrZzRkWXdoSlJzNnNDc1hoY1VUTkMrT2xLU0plRWJGbTAyaDZNaERz?=
 =?utf-8?B?VC92K1l6L0F0WFpwY3FJRW55Qkd3bWZCMDdWb2VOdmJmUEFoQ0VBRjI3WTRI?=
 =?utf-8?B?b3B2UUV3VlhvZ01YMmVBRGFPZ3hoenNhQkVtdkZ3bFhKcXBmc2VaeEg4ZHRC?=
 =?utf-8?B?LzM0K2YyNXNXcFRNUTQrcWNaOGZrMXFZNk40b0FrcFQvb3VlUzdOOXIwNXNn?=
 =?utf-8?B?bE53emZXSkVOWWlxR0phZ0JIb0pMYWdQaldoSyt6UnhPQ3JBU29XSW95RHpq?=
 =?utf-8?B?SHArOXcwNmdWL2VWcUwxRXBzUGRKYTZYTjZETHRkMFBoeGRKYUNCMWNqNzJn?=
 =?utf-8?B?b09oSFk4WHRNcVdoY0I2T3lNREpLZTB3dXBTbnpVUFFISEdiblMvTVAyeFAy?=
 =?utf-8?B?OEQ2cnNFMWdoQzZra0t4dnIwamd4c2duUmxNZGNrZ3JuWkFkSTJLMHIydTJs?=
 =?utf-8?B?SlJjWmZqUFdyQlNjL1lSVnpVOVFrU1ZzM21iN0p4bWFjUHF3ZmNIOWxCNVRI?=
 =?utf-8?B?M3Zxb3JqS2hoSzhpTlRkbk8zbW4zSjkwR2UxTVFiQ0lZSzdxN0pxc2I4dVhm?=
 =?utf-8?B?UFFSakRKVkRnaVZrRkFaeEthL3pOREJlRGUwVnFVVktBVFFRQ2U5aDU2VlEz?=
 =?utf-8?B?TUJ3T0ZFK2dzSEMyYVFkTngxcS9HY0dLb292cmdyZVhodWxTMzdFN0JDOGRB?=
 =?utf-8?B?QlU0bjdSbG1MVTFLOFFUU1lhWm9DMk9EcVRZVjVtZEdoUllrcE9MUWZDQ0ZW?=
 =?utf-8?B?eFdJb0pSdVl2U1M4QzVvSVRMMDQ2c1BIWGtxZ1l5Q0JPQi9tOGxhL3MxRlZB?=
 =?utf-8?B?Vml5TmlIOVVZaXpLbTJEeEF2SDlKdzZsUjZXbE1Cd3BqaWRnZlpHSHZocVpp?=
 =?utf-8?B?RlpOQjhHelZjUGNaRFVnWTljUjJtVk4wYXNWeXBTenp6OWR5cGt3aVJSU2Nt?=
 =?utf-8?B?R1NvaTR0ZHE5SDhvSFVpTGNxL0V2UlZrZDRpU3dERzVZVEptSFhxS1FERjNO?=
 =?utf-8?B?a3ZlUlA3V21KS3dGY3FGNkpNa1lCdFN2RFRvNXJzekZrS3YrbEdFendKT1hL?=
 =?utf-8?B?RHlrSUttSC9hbnMwakdqWmJJM1FnU2VheHEycW52bG12MUxDUXZNZzJGODV0?=
 =?utf-8?B?bjczeUxEMWJmeDR2alpHSWRJMThVVS9PbFAwVEZwc2dHRlZaMXk3QzV4dVdk?=
 =?utf-8?B?eFRuOHRvSGV2cjhsR0t3djBlQ2FmWjNuRnY3MXlzcVFjYmpWY0RJenFzdU03?=
 =?utf-8?B?L0p5a1dXclgvT1BSb0cvWnAxc1BPNnBqU0JsM0ZtQld3VXUyZTBtOGxLaGJ6?=
 =?utf-8?B?RUJIZitTMnF5aWpTc3R1MUZkMlZGVW5XZmZzaGNBZVl6aVN3MXYwNzJHZDF2?=
 =?utf-8?B?U0QyRmNWQ3dJemt3Z2VWM05qSitKOG9zbklRNGhhT3pWWmZwZ2E2TkVQV1Ax?=
 =?utf-8?B?REpKNzRJNVdmbFgwY01sMm01bW1BdUZBVnpkSUZrU1RXcThYclRZdWVFOXpL?=
 =?utf-8?B?VDVHd2RHek40TmpscllISFZRTksrMG16WkJDVGJyQk5TTFJLTXB1UmJtRS9E?=
 =?utf-8?B?TjNJRmtzend6WWdsOTMrK0d1VFQyN1RwdFdlNEV2blRKVWgya1NOMTRZUHZT?=
 =?utf-8?B?R2k4Rm1hWFo1L0N2emdqM3AyV2lNNHNGY2FHVnRSSDVWWGF3bXczOVQva2Zu?=
 =?utf-8?B?cTd0NTVlNCtuM09lT3pSTWZwclpkdnd2RWJ0UVVQNHFHSW9FaStTdFlCRS9W?=
 =?utf-8?B?Nmk3d1BMSFlubG9qRlBuMUk0WnhFUkJTdWJSaDFMbWlnaThsWkU2ZzN5VVZt?=
 =?utf-8?B?UmQ1eDVqRTZIMVRYbHZZN3IySFJoQnBKZGVwVHFaOFJ1bkdSaXRudDExNUlO?=
 =?utf-8?B?bTl1SmdoUWJlbXRlaHA0NFpxR3JreTcxTWVqbUtSa2h3Yys3NWtqNEJMWS9T?=
 =?utf-8?B?cm5OVjBUVXZiRTFxWkYzUy9yaWxxT21yYTRjVHhqSGtHRzJRL0JkSEtuaXVX?=
 =?utf-8?B?aE9xMm5kai9QQmQwUDNhNXpONlJ6ZTQvQnYwRk5jMkp1WjdBQVp4aEZZTjda?=
 =?utf-8?B?QjdDMCtEdWlXTHlRSFV6T0ExSUR6cCtsKzF6Q3R1MHVLNnFUaUZnQjNxa0ph?=
 =?utf-8?B?RVZiOHVaMEtMOE5MY1N5ekFGMjMwVk9qODdUYmVQbXVYQ3hYSk9RcUcvTXNO?=
 =?utf-8?B?RXBQbWpGeno4NFJGWXdoUEExT0JDZU5YMEI3L0pOdFVLQUVyc0VZVEJ3NXMw?=
 =?utf-8?B?d0FQVTdRdWI0L0pWVFZqSDMwb1BPRVhZRC9wY3lORXc2VlNoQnBiL01rYmcr?=
 =?utf-8?B?S1NwQU9aRDlqQ2FIR2gvZ1hvM2FqYWUwZzVlejBEdEo3OFFvMnVlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6013837-f212-440c-e0cd-08df2915527f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:32:46.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdXHc9yfKpaM8PDm6AAgr6FxWsqe5Rcj9ibjOJ3Dwgw3krGkCXmmzAodCyuv4spnrubrPLDPlPmHu4fj++mq1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604



On 10/2/2026 7:01 PM, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump") made
> iommu_set_device_table() return early in every kdump kernel. That is
> needed when the previous kernel's device table is reused: the base
> register already points at it, and on SNP-enabled systems the register
> is locked.
> 
> But if reuse isn't possible, early_enable_iommus() falls back to the
> freshly allocated table and calls early_enable_iommu(). Because of the
> early return, that table is never written to the base register. The
> IOMMU keeps using whatever table the register pointed at before, while
> the driver writes entries into the new one.
> 
> Only skip the write when the previous kernel's table was reused.
> 
> Fixes: 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/iommu/amd/init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index c07c3a01b978..0572e1a674f0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -409,7 +409,13 @@ static void iommu_set_device_table(struct amd_iommu *iommu)
> 
>         BUG_ON(iommu->mmio_base == NULL);
> 
> -       if (is_kdump_kernel())
> +       /*
> +        * A kdump kernel that reuses the previous kernel's device table must
> +        * leave the base register alone. It already points at that table, and
> +        * with SNP enabled the register is locked. If reuse failed, program
> +        * the freshly allocated table like a normal boot.
> +        */
> +       if (iommu->pci_seg->old_dev_tbl_cpy)

Yes. It fixes the regression and I am OK to pick this patch.

Ideally these low level functions shouldn't be called if we are reusing existing
device table. With so many combinations (like normal, kdump, snp, etc) its
becoming very hard. I had done prototype to get these init path somewhat clean
with ops structure. I will try to rework and post that series soon. With that

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant

