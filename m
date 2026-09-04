Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21747140F;
	Fri,  4 Sep 2026 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526152; cv=fail; b=uPh2wV53BiVrjWtXH18LamrTIDQRSPlziC7BtehkohskxPzgwA0vTuAcD+TBKGO5iCKnX6H6Bs5OOPXQBBDxmTrtFaX322BqTA9VRqCXCUu1QmyS6YHhU9PEMqAbrSma0uoKFLxVdTdf4hI4zBLLGB2xQjvslcRSc4O/+NgHY+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526152; c=relaxed/simple;
	bh=EC8DQVdjZB9l+mdD+nisUP+TkQWQb6NMiT/TEpw1fWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q0sfVofR5AncK0reSVCMcH53xI+36PtzxTopsZ7iiEa9pRkiVp1WEhVN++P3MhApoRWG06L7iCisYjjnR5Xzf79cz7A/3AWxftZhvxiSuxC3CJ82MZvOL+rCUNM1+/0TCLV1hy2+RFREebxGylM4T6LQsr5oc2nSX5vcInUg8Qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BzwTH1yn; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BzwTH1yn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7DjadXFhpBIeM8OTCNUdfA96x1EwhKcItYLY4BsajkSXmB45upuQauxAnxq+zn0h8DnAiDLN3FKqlC1t14MzkD/dsIOjotflFtIJ05xlqe+JfID97t7swN6yn4Tut6IxmWZ2utcWdC+azmtGsJ9dKfWX2fg8QTVcWOqTog6K6vNtr6SFnJZo+B5sZil+ndAcbh6mUQNu4Tx4K7Gu69iyHbVsurgzWVNNOmHlJGHQ5J+az6zB5NMRwx3fIKcNuvWM9S3XoOwfY5DWmFnrtE+vWs5QTH0SSh7iDFWkchJPJbO5danoyyeqQsTu4ttttY2Clz5+hxNH8m9NzCygVcX3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4XuDC/lTC3PIjDLLTdbN07wZImRwe+rJH157WUOK44=;
 b=lDw0Rt7q4V9Gv3U11/QJiIOaw9rqJQSVO/xi+wz2kkv2cr0OBuImhgs5gcDjYUnSkfGtag6wMyQ3a6gJ0ITunwwQKCIZSmPfBsFGAAJiHB0rvdyZugfOUWQv2r/2QwDzGCUV+7NkHIinRArnwpTxTOe2EjRRlC5siqre44pWnNLd9JBhWBn1q8okjOx2Y6uMA4N2im/z43RalVwuRxai0Z5I39iTacs2Y4L8q39x+YF3POy2pOczfzXdzLU9V0pp5X2uN/yqGAHyn60P3t2SDTHGBkXNIrTfGrdryEi7RA11JOsfohsTtobyYgGMb8a5mM4Dch+6lyhLZtreIDturw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4XuDC/lTC3PIjDLLTdbN07wZImRwe+rJH157WUOK44=;
 b=BzwTH1ynVpS8RuejRxr2/8wApEy5MgySwZU/52kOlDlCzw6LdGl01Rqc2+VOUOqP4/0Bgs8aESAEj6BHTBmNxPecvgVk5qF3RiyGMnUdsYIe6KPYpovaX0Mz18w9B21wx/dtjUwF7wdVQ7luLjY7ZOQiS/VHFu6l0p9B/JGd4xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 12:49:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 4 Sep 2026
 12:49:05 +0000
Message-ID: <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
Date: Fri, 4 Sep 2026 14:49:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 tursulin@ursulin.net, matthew.brost@intel.com, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:b0::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 328d88eb-8c2d-463e-2262-08df0a82e73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OtHxlPDUiIdBJuosSQBIZl2te2XG4tmDpxy1a2SSf8amcxkJIfHmJiYdBmuswT7cwKaGB8vweam0LUzDI9/TT320+0owJph1hm9EbBFgyv7PsjW6XdmACiSfIBZDCdNqfrYAi7nXJEhYgXmV/ZmiA+MG0jMuzXSFGX3PklWs/QPRfpy0m6mr1INGMzf+l0kGiwm75392alCG+kyBIG0F+4dpRBuDt2KQqnWNzmCFjHL7hzSLKA+aVPr4wAnF3Bps74lgVsS4dEJ00DGTbRyzLVu1llgULGtEQhmM6w/V6p8EPC4UClETbYGoXKdsY8bHjJ4Z0y0v5Kvc3ZU5NpnrLwa6F5ZH7bW3m5GfbkCZOtg2lSLGphgQhcJzi3tXR2HkFatoNSmrBChAWteM56iJDcilmFQb3WAuPyxEpYWvaOqCbg8sDeiPluEjfvElSpfj218CE8v/qH6jTGInedz40ySoK+j2bqWdp+KBb+wDNAh+NrgsLlPAcKphexgONuSZYXlr7ZbJ7eWnFhtLivkSBdXzCtSjbcNFznIS//R7f1YKYVwxVuSEVg5y+G921qZ/Wyw+y9/J1TbJCFY8mE9plxgMxg3jEwcdTc2WByoUc013Jl4oNmZGVR5aFf3MgEVpMVh3lDzaDlvqdXjqnNYlT4DQfRZimBKXjZIJE0omjCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXdBa2E1NDd3dmY2T0NaNTROcENpTERJYktUOXhRMkRQUlQ1enArQ2Q5WXp0?=
 =?utf-8?B?L09Pb3BGb3FGN2xsVHl0enFCM0kzbkdkZFpEZ1I3VHgySnFhUTdUc01nRm9Z?=
 =?utf-8?B?TEk4NStCQTkrYnZkck9HS3phSUhBWGtPRytYNlFBc2xpTnYrZEw5WnhreTJl?=
 =?utf-8?B?Y3JpV3NvNXNDbTJLQzRncnE5bFkvdDFZZ21zLzNMVTdrRGlJODk4WEk5aTA2?=
 =?utf-8?B?QkMxMlc4QmkrUmx0UHRvWHp3YzhkbVhNbWNsN0ZzMzlBVGRBMVltWnY1Mmtj?=
 =?utf-8?B?THNSTkVGVitxN01kU082SnRzTTR4ZHdLZzNGY2lnSjFsb0t5blFhK1FiemFz?=
 =?utf-8?B?YXQ0S1pib1N0NytzS0FUd25aMEZvclZpdmlvU2FFVi9COXhQalI4bDY2aFV4?=
 =?utf-8?B?eGlRcDAwTVozcnpLRkUrZllDODRrb3FydEFWaFBRZFlpVzNzeHA0L1U0L3Z0?=
 =?utf-8?B?R21PaENZS2tORjUwMGZOaXBhcjVodUJsNDdNVGRXK3BXT0pnekFyTnh6SnFS?=
 =?utf-8?B?SStPUnA2Tm1rVk1VNkUzRVJQRnVERU9DenJGVXRFVUZmei8zWnUremVzWnZp?=
 =?utf-8?B?YTd6NUFnQlRRRVdleWFHL2IyZmV4Y2R2Ung4NlZsR2prbFlNOUJKR3J2WVZy?=
 =?utf-8?B?bnpGZTh4ZFR5bVR0Y1N0UzNGOXVMY1kwTEFRZXhvbnZhemhTR3lVUVNTczNS?=
 =?utf-8?B?ZGNheDF5ak1jNjFFREZ5QlZKd2o3aHk5KzhQcFlEaTFRQWFRdExqTE4vYU55?=
 =?utf-8?B?YU1INDgwRGRITlhOZ0FpSmY4V3k0WGF5b2hJRFNQZWVOclErZXBhemJqaGtM?=
 =?utf-8?B?ZENNRitUbDVhK21Td2lkRWtESUN6bmZCaFdFclFOREJwWUpacWlqWUtiSGVH?=
 =?utf-8?B?dmJ0Z3MzeFcxZThxWUhmak5sWE1lOEpONUQwYjM2ZWprbzhHelU5UlRyVkpu?=
 =?utf-8?B?bm9hUURBdGhoOUhBSG5nVzRab3Zlb2VTL1FlcnRQSmUwenN6Uy9EU1BXV2ZT?=
 =?utf-8?B?UWdKMmkrMWRITlpQWDYxNlBrOERneFVtaDlYWUdIY3VURzY5dFFxWUR4SnRx?=
 =?utf-8?B?RUVmOXNuLzh0WWxFaXZ0d1BnOGhabHRFY0ZJNk9mVEtpeTlaSXBIeXJLaW9j?=
 =?utf-8?B?ekpoREs0SXBzcTR5ME43NzFJYXNHLzBlMmIzWWNRUUVIbkcwOXNaazI0MkxK?=
 =?utf-8?B?WWt4WFhTMFU0eE9OTVdpNUZLRkRLUDdGN09GWHVqRzVvTENLb205cm1za041?=
 =?utf-8?B?TE5GZ0JZbEkyVnBzMUVMZEg4QklPTDRUTXhtL3QvcFAzMFlVbE1oU0VVUE9O?=
 =?utf-8?B?Z2xkQzlQWkI3WFM0YW1NYjBENmtiNEVqcTRRbUhOWGZiclF5WXBTaTd1eTkr?=
 =?utf-8?B?MVUxMnVYOW0yUWltaDFXODhQVitoZW80SjczaEM4K29Ia09odHJCMnk0cUdI?=
 =?utf-8?B?RUZzejJCZk1JL2pCOGpLQzF5bllwUXd6enIrak5FWWgwelRiYkNIc1ExcHln?=
 =?utf-8?B?c1h6cUtNYUFobTF2VzhJQ3A3c01TR0c3b0U0VnhzQUVJdEc4NDRkTVhvdzJT?=
 =?utf-8?B?aTNFZU5OUFlaN1MyOTRTZnlyaC9jajd5QmxXbkhjNCt6YTU3LytmVDVEYXFm?=
 =?utf-8?B?d0g5clBuOG1EcmpOM1N2MlhWeXFvMVZlMU02Z2JPbUdaYWN3S0xkL2x2bUxl?=
 =?utf-8?B?a0JEUnpBS0lscEVBeVp4UzVJZjI1Mmo3VTJFbGd0a0o1QVY5bEhXZTFuSThp?=
 =?utf-8?B?eGkvb2pySkhTeGlBR0tOaVgvZ1NsdXZtM2hvT0JaUzNhTzIzaVNBZUJRUThs?=
 =?utf-8?B?cmtDNHBNcDVrTmhCeCtMSWwyOVpmK1l0c2J1UWorVHYxTUxmTTJ2SUgxWnpO?=
 =?utf-8?B?aFE2dGdXNENhVEtHRW9qVnRYaWxnQ3p6UysvaUlYdVhsMmNRVkthdGs5dmtL?=
 =?utf-8?B?Y3ZSYzdWZEVyUUVzTlFnMXJvZHdzZW81NnI0TWpFcjBVdkU1MjVXc2RkRVE2?=
 =?utf-8?B?ZHlYTmtyQ1BKcEZtRmJQbUJ0RzNXT1ZnVU14QUdSaUkwWW50V2phR1FvVHZC?=
 =?utf-8?B?NTlrcFBoVXpnWG1DNU9GSng1eERCdTRoQVozblhXUEhRTDZTNElwRVJHcVg0?=
 =?utf-8?B?QUNtU3hhZTVZNi9XUVE5MVVWU3drd3pXVWFXV0tTT2lTRnZTcHNOSmk5dmc2?=
 =?utf-8?B?bmlqbDVYTlZIMjlYTU15QmU3alJyNUgvRFZsMWtXb2hwcWNEM1VpenE4ZGxm?=
 =?utf-8?B?L01Rc0pJMUNnclJvb3dXOEpWSjVBbXdISWIwSVdoajRQaDEyZTk1a24vcGlx?=
 =?utf-8?Q?85/+2RSJ/i60nE+U57?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328d88eb-8c2d-463e-2262-08df0a82e73e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:49:05.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SCD7m7woH98Jg4Vrgb9mMex/lz4YOr+8F21v83v+DkWtTElzb50eyvbmUFnHpgP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

On 9/4/26 10:31, Philipp Stanner wrote:
> On Fri, 2026-09-04 at 10:20 +0200, Christian König wrote:
>>
> 
> […]
> 
>>>  
>>> +/*
>>> + * TODO: Both fences implement .release, so dma_fence keeps their ops attached
>>> + * after signalling. Dropping the callbacks would let dma_fence detach the ops,
>>> + * after which neither get_timeline_name() nor get_driver_name() can run against
>>> + * a freed scheduler or an unloaded module - the complete fix. It first requires
>>> + * auditing every to_drm_sched_fence() caller, since ops-detach makes the helper
>>> + * return NULL for a signalled fence. See Documentation/gpu/todo.rst.
>>> + */
>>
>> That sounds like a bad idea as well.
>>
>> Dropping the fence->ops is to detach the fence from the module which originally issued it and not solve lifetime problems between the scheduler and the driver.
> 
> It can be used to solve that problem though, can it not?

Yes, but I think forcing dma_fence implementations to drop their release callback to fix lifetime problems with the driver and timeline name functions is a bad idea.

We should keep this fix simple and focused so that we can easily backport it.

Fixing all dma_fence implementations to not need the release callback is something I really like to have as well, but not to fix this issue here. 

> 
> The underlying problem is that the driver has no chance to figure out
> when the scheduler is actually done with all the sched_fences.
> 
> Remember our lengthy discussions about drm_sched_fini(). Maybe we want
> to reconsider providing a function with which the driver can wait until
> the scheduler is done with all finished_fences?

The problem is that won't help unless we either add more checks or fix the checks in dma_fence_driver_name()/dma_fence_timeline_name().

The dma_fence object can trivially outlive both the driver and the scheduler instance it originally issued.

>>
>> I think we should rather re-consider patch 035219a760edb35ae9a9e96beba7f122e26a997b ("dma-buf: dma-fence: Fix potential NULL pointer dereference"):
>>
>> Here we changed the check in dma_fence_driver_name() and dma_fence_timeline_name():
>>
>> @@ -1167,7 +1167,7 @@ const char __rcu *dma_fence_driver_name(struct dma_fence *fence)
>>  
>>         /* RCU protection is required for safe access to returned string */
>>         ops = rcu_dereference(fence->ops);
>> -       if (!dma_fence_test_signaled_flag(fence))
>> +       if (ops)
>>                 return (const char __rcu *)ops->get_driver_name(fence);
>>         else
>>                 return (const char __rcu *)"detached-driver";
>>
>> The problem is that we didn't considered that there a fence implementations which still have a release or wait callbacks but rely on not needing to return a string for a signaled fence.
>>
> 
> Could we move the signaled check to amdgpu and pvr?

Yes we could. I also considered that. But I would rather like to see it handled in the common dma_fence code.

If I remember correctly either Tvrko, you or somebody else was in favor of doing "if (!dma_fence_test_signaled_flag(fence) && ops)" here but I though that this was unnecessary and we would rather remove the release callbacks. Maybe I was wrong with that.
> IOW, we keep the solution presented here (removing ops->release for
> finished-fence) and the few drivers that check whether a fence is their
> own first do a locked dma_fence_is_signaled() check?

Works for me as well, but as I said I would rather like to keep it simple and stupid for backporting.

Regards,
Christian.

> 
> 
> P.

