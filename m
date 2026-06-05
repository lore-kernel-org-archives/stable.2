Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F53F4DF1
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654485; cv=fail; b=iith5buIE6bNyD8OPBCkGqb4tT0lBhshU8Qw5U3V9wQq67QzlSlRwFzTNz4JL4wq2JpF+RndyT5NOs0XRx3tjULWZ6G+r3Dcv4U9JSiQnXPR8ICKPugGVcW1P7CUfWXTjc4HxDI69NqyWj2l4EymSU50jXzwW41iptbon59QCgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654485; c=relaxed/simple;
	bh=P/trqAXoltB1C2SeqBSSRepEeq60puqECT8wyB7PBLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AcBW6yBUCJaFNefWYs6bWQeYBUMjZgp+2jsTWX4azVMfBnVAfL7XI66xGZ4IfGceoMzMaZO6tMtLa1lvFshqX+SwEj0nB51ZX02aDeno0TnML+wTu+yJ1xzxlTKQne+2Jmf+HDsO1KDVLR5zXalr3XGXQmC4Bsg5k/M5yAd/NVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2VFwuS4y; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2VFwuS4y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBDHBGTBkHcd2Y87kbA/6se9o6AhBGsdG11rnDDtFNJ/tMW0cECeunFhsfGvHkCNUB0XlQ0WE3/zUtFZroMijHz1ryvt5yBAM54J7QRAIDiI8LXAG8K5IwJxRdwIf3y/Gn24AcGNekLp2qNWzSexpt3y2ujHm7cPMQb0IvpO7we5gVIQ6XZporiBGsaogRVONRjsTmK6ZUe+y6pcngaU0JAQILEd2f/lxH/bwtS1uaY+TFXmMvA0u93odNdHrHWPDkbkk5R/WKFES9wAKYYRVO5ZPBCmwjbAUX01hM7xCCIq2OVK7mxwd9diMB9rL7iVStxBgkEDotRNIffDoGsWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiXpOM3qNnLwUHu9+pyeRMJUmh/GLYi7f1cUOj8RMuA=;
 b=ebCPeqNfVAiEqciik8EE1+5WzAuLk49pFTfbvKa42Zg/M7UObFqRnbMtqQmJbJ1kptU2TxZSU4kgRHLkpPVt6Plz1hJR0qjN+83udsTNQgTnaMIycjeSFgzzNH0WRkSCLMN3gOC1K5xlOlGP6hZPQNI+CLe9561CxrndKECtAIUF+oe1MjLAPthELvxlOgYuJnITtoChe/dRlX4zqHJny8cz76+SPguGSNPsq4ykG4S3BRBf3XEXkFj6CSVuuOJUX9VWuVnDrILbU/m4kxPhMXPjIZKGEYAuX10eDbGeZiJ4uZf/0R86UjCmrSTtlBrBvUbs0xS2aS82snscN5nmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiXpOM3qNnLwUHu9+pyeRMJUmh/GLYi7f1cUOj8RMuA=;
 b=2VFwuS4yfjl+MRJTUH4BgmCQUYC9oTobwfg9ZrwSzNbram/zXgby6Qw3Uha3ZWuYt9ST0JIukr6nMlwHbR3a/exUqvEtaJnIvojjp7vBy+ncVzziMpOXV8RpbehsYUjxmtqGgrH1ALtfrVWNT496Yx9jGC8B97ipuH6Q1dLBeJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:11:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 10:11:58 +0000
Message-ID: <2b38d42a-4fbb-4d77-bebb-bf1cd04a31b6@amd.com>
Date: Fri, 5 Jun 2026 12:11:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Gote, Nitin R" <nitin.r.gote@intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
 <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
 <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
 <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
 <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
 <SA3PR11MB8118477615C02DD99CA966F7D0152@SA3PR11MB8118.namprd11.prod.outlook.com>
 <SA3PR11MB8118C54C085BCAF117582849D0102@SA3PR11MB8118.namprd11.prod.outlook.com>
 <9d26ec14323cb5a54e2b6e58cb177a4a7eb3652a.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9d26ec14323cb5a54e2b6e58cb177a4a7eb3652a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: d59ff042-52a6-43bb-11bc-08dec2eae086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
 04HtyiXsrnImxAqKaMwox+2ZzJn8V8XuYZ8ars/4B3emXYhZtMoL4QT58FEXoMWBLz/YwwEDp1ofvgqRZv2pUEwiqhukdHo37LaWy5TIsQuvzhwM8nAiiJeSwKPli8d7HPqfFQLaJ2URPyXNEPRZ6v8audSmmKGO0BuhjPPaqzymclhjeppCfDMi+zhfsBZYBcCjBpwwbrAyhUo5LmXnw1LDHk8oTvQKwjArj+3CADdZ2ESNhodfdpoVp0Gdcn5S/zO3J1QOdvM8hRTLpg7gm/m5cDu1zvXB5ZciSB1X2+PAreQL/USczRwsgKDh9mzykuV2cnNiRsJbQt9ugfiw7VoM7sOt4TXAT8qpwRtQD9hRmQ4P/MOpSzTMBvOaHaCjLT61wrFfFFpFrvwmcAP37GsAJ/qPZBDHigbIxZaFUrWWGO4udnyGFjv3HVeCdlEio247GuwWluD+OkFNtMYaMDj0YibJibJXFC1XWC5KIZbeJVLAg4OEoDDwKiJeoG46bz0HZK+MJw4pAF5Y3KnHCZMq/33VsxmPLqXif8FoTlU77csUUhFxFbokHW77zaMpWxFGQYoRzCd71B/3m/y5ak9moKwpQkVgoid3vkebUS+YAhTod/8zF014F6LvwvBoq4AE5yksQ0WY/xAcZyacEQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SDlMTkhnYzJrZTAvTmUvUlo2ZFd3MjluQ2dZMEp0YnZCbHJIcGxTQmFweGYy?=
 =?utf-8?B?eGRZOXRjTnl3QTNDbk1haDQ4VExnbFQraFZrQU8wWWVaREJuY2lVRjQwRDV3?=
 =?utf-8?B?ay9BTFg0aTZiVVU5eWRpQUgrSXJjdkdQUVJqYzZlWnpqd1puT3lyODZycW54?=
 =?utf-8?B?aWlSM3pXNW96dm1RZlI2UWV2bUtlWlM4dE5XMXN5V0Q2ZzhGR05vT09NK0tI?=
 =?utf-8?B?WUUxUUdyeEdJdFhnaS93b0JGajRxU0FSVVplcnhwNGVtRC9SL1Y0cThsekQy?=
 =?utf-8?B?TkNlQkFZUWZSdGE2SUZybTJsQVdzRHgvOWZic1UvcU9uK0pxZHdqOG9Ja2FT?=
 =?utf-8?B?aTVNNG5lRHc5U2N1SERBME5KQ0hFLzRncTZoVnh6dzBpU3Q4QXRmRGxBeXB6?=
 =?utf-8?B?QVdwQS9CSkwrZE5WSzNnUnNsK21vYlVaWTY5Uk53VGI2UWRocE9Va3lYL0FP?=
 =?utf-8?B?RHlsb21lTnN3YlVMVWl6bW9HUFM5aWdNVlJpNDdBMHMzWXdXZkVZVVl2M3VL?=
 =?utf-8?B?QUhFR01UcmprQlNrWGtWTUgxRkdFYkpEM3ljSFpxWlN6L0d2ODl0ckdWdy9y?=
 =?utf-8?B?OXhCUHprVEVmRVRxZlVHNHdzOFUxSUZVY2U0V1I5YkY3eEswRlZoaUpGeXhj?=
 =?utf-8?B?a2tXWkVxQ2FsN1NGLytpeWI5bXo3REZKTjlXVm1UYVA5a0xXdjlpdWlYMjZB?=
 =?utf-8?B?UmphenFVYklTU0hLM244YTNIRlM4dVlsSi80Q0Fjek54alFncWNveGZXRCty?=
 =?utf-8?B?RldtQUVXNWZNR0l1WmNtL0FEZHBibEVlMnZpc1B1V3ZEeXlFNEZPSDFCZHhF?=
 =?utf-8?B?T1QwVzBqS05ZK0JJZWg5MkphQmpWd1FjWTBwMUFjQmpVckJPaDR6dXBkeDM4?=
 =?utf-8?B?a0Y0RlI4ODBhRzVWdElvQWxLRzJGdEE1S3BqK3BydDVQZXFScTRQdWd4STVH?=
 =?utf-8?B?S1o4MDVQSEVUMDAxY3NLclpmM2VDY1g2SzJ3ZGJ1ejhOcU9samh4eHlEYk5p?=
 =?utf-8?B?YlAxbkVILzVYM05tZkNYaVgrMUN0ZU5LWFpueGhvNTI2dVM3SXEybTA5NHVn?=
 =?utf-8?B?TlQ3U2JUa1Iwa05LZ0JCQU1mQndDTDJWUkowUDBaeEJieFVFUzllaTBBN3Zl?=
 =?utf-8?B?djJSZ1M2S3oyMFF4Rm82TXN4TWRFSGlrKzlYc0tJM1oxSy9ZWXk2UWpRSjl1?=
 =?utf-8?B?M0ZsazQrYnFBaFhOaEdBQ1ZTWWFwc2VHTDQ0YnRQNkROUXpzRnI2VTNuYk5Y?=
 =?utf-8?B?cFcvYkE2R1JkMCtNemtVMnFrRHViWWJ4QnFkZDdUb3dONWNRRktDSkFNYzll?=
 =?utf-8?B?S2ZwOHFza0FYR0E4K2NUZFplWDBSSTNpTmkrTjFyRCt6K2o4VUo0VVg0MWYv?=
 =?utf-8?B?aGFwbzVzeWx2cHpJaktLcjVSZ1hpQmNmblpFeWlVM1pwNlhuZ3BKWlQ0dkpv?=
 =?utf-8?B?cHdTOFh1K0kxKytEdU9DeFNBWmIzYTlYVlEyazdKeHFKUDlPdXkxYlRiQndl?=
 =?utf-8?B?ajVhSENab0ZreUs4Vndlb3F4OWdkRXYvMGs1QWQwOHRIU0NCbVZWSlNxYjVQ?=
 =?utf-8?B?WDFGbjZScFFnYk90SnVjeFVGRGpoU2ZyVnFEaTByOWdLb1lrME9zNmhXOWZk?=
 =?utf-8?B?bS9UUkU5UGluZmNsNHNwTHlKNnlZRlpQTk55MDh6RmdsZHBvZklRek5acHhQ?=
 =?utf-8?B?MTRsTTNmQ3BVN1ovMXBtUzg1SlEwQ0t3N3pDRkZKRHBkQmN5am9jYnFjeHNW?=
 =?utf-8?B?U1hZWlFEZGNsMXZIdXEyVk9xRmxiVlJvbjZuOGhDNUR2b3AzSWQrcml1T1lm?=
 =?utf-8?B?NUNPSVozYXQ5N1kzMitRcVNFVUhwQ1lkcXliaUpjQjg3K0RhM2xrVnlTY3Zl?=
 =?utf-8?B?T2xHdGZTZ0xLNWtvK0E4NzVSc2paalNWNXoycFFBVGxrSUgzWTg2V0c3SWxH?=
 =?utf-8?B?UXZua1NpZmlCK2tvajBuZXVLNjBadVVHYmpkWmZqVkxWbUN4ZFF2c2tFa2ox?=
 =?utf-8?B?UDl5azVFWTB0dE1iT1U2VG5ndElrdzdnYzRmYjJlS0hOZmZVUGR6RmYwU0Fw?=
 =?utf-8?B?WTNSZStvTUs1d2tJNXFpTGZXSC9PbCt1V3YzM09Ob2ROcFBBRnFlM1JucU5U?=
 =?utf-8?B?d25oS1NRMHpMU012TG4wMnZ6eGszM1prNGhDWDZ3bjdDM2VMUkw5b0NqTWV1?=
 =?utf-8?B?WW0rNHZvU0wySTJOMC9zbkRIMnJvUUVWTkJOaENzdE5ERTAra2lMZThFUzFp?=
 =?utf-8?B?U0U2ZTRiSVRDcGhQTjNMck9GY2R0NTk5MHpjQTRKdDg1ckt2cUZZMVlldndL?=
 =?utf-8?Q?6xF0A8Xp/nTB2DQYG7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59ff042-52a6-43bb-11bc-08dec2eae086
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:11:58.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jcfm/OAFesQB1x/mRuCUtn4isAu5mjHeCle0KTMysr3CYTtZzMFQ/t9C8Yu/AZW9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

On 6/4/26 13:14, Thomas Hellström wrote:
> Hi,
> 
> On Thu, 2026-06-04 at 04:54 +0000, Gote, Nitin R wrote:
>> Hi, 
>>
>>> -----Original Message-----
>>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf
>>> Of Gote, Nitin
>>> R
>>> Sent: Monday, June 1, 2026 8:57 PM
>>> To: Christian König <christian.koenig@amd.com>; Auld, Matthew
>>> <matthew.auld@intel.com>; intel-xe@lists.freedesktop.org; Christian
>>> König
>>> <ckoenig.leichtzumerken@gmail.com>
>>> Cc: stable@vger.kernel.org; Thomas Hellstrom
>>> <thomas.hellstrom@linux.intel.com>; Brost, Matthew
>>> <matthew.brost@intel.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
>>> Subject: RE: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on
>>> attach failure
>>>
>>> Hi Christian,
>>>
>>>> -----Original Message-----
>>>> From: Christian König <christian.koenig@amd.com>
>>>> Sent: Monday, June 1, 2026 5:47 PM
>>>> To: Auld, Matthew <matthew.auld@intel.com>; Gote, Nitin R
>>>> <nitin.r.gote@intel.com>; intel-xe@lists.freedesktop.org;
>>>> Christian
>>>> König <ckoenig.leichtzumerken@gmail.com>
>>>> Cc: stable@vger.kernel.org; Thomas Hellstrom
>>>> <thomas.hellstrom@linux.intel.com>; Brost, Matthew
>>>> <matthew.brost@intel.com>; Prosyak, Vitaly
>>>> <Vitaly.Prosyak@amd.com>
>>>> Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on
>>>> attach failure
>>>>
>>>> On 6/1/26 14:01, Matthew Auld wrote:
>>>>> On 01/06/2026 12:39, Christian König wrote:
>>>>>>
>>>>>>
>>>>>> On 6/1/26 12:46, Matthew Auld wrote:
>>>>>>> On 01/06/2026 11:15, Nitin Gote wrote:
>>>>>>>> xe_dma_buf_create_obj() creates the importer BO with obj-
>>>>>>>>> resv
>>>>>>>> pointing at the exporter's dma_buf->resv. When
>>>>>>>> dma_buf_dynamic_attach() fails, no dma_buf reference is
>>>>>>>> held so
>>>>>>>> the exporter can be freed immediately. Since
>>>>>>>> ttm_bo_release() now
>>>>>>>> always defers cleanup for ttm_bo_type_sg BOs to the TTM
>>>>>>>> workqueue, the worker later calls
>>>>>>>> dma_resv_lock() on the already-freed exporter resv,
>>>>>>>> causing a UAF.
>>>>>>>>
>>>>>>>> Reset obj->resv to the BO's private _resv before calling
>>>>>>>> xe_bo_put() in the error path. The BO is not yet
>>>>>>>> published
>>>>>>>> (attach
>>>>>>>> failed) and carries no fences, so the switch is safe.
>>>>>>>>
>>>>>>>> Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG
>>>>>>>> (QEMU):
>>>>>>>>
>>>>>>>>     Oops: general protection fault, probably for non-
>>>>>>>> canonical
>>>>>>>> address 0x6b6b6b6b6b6b6b9c
>>>>>>>>     Workqueue: ttm ttm_bo_delayed_delete [ttm]
>>>>>>>>     RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>>>>>>>>     Call Trace:
>>>>>>>>      <TASK>
>>>>>>>>      ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
>>>>>>>>      ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>>>>>>>      ww_mutex_lock+0x3c/0xb0
>>>>>>>>      ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>>>>>>>      process_one_work+0x239/0x740
>>>>>>>>      worker_thread+0x200/0x3f0
>>>>>>>>      kthread+0x10d/0x150
>>>>>>>>      ret_from_fork+0x3bd/0x470
>>>>>>>>      ret_from_fork_asm+0x1a/0x30
>>>>>>>>      </TASK>
>>>>>>>>
>>>>>>>> Closes:
>>>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
>>>>>>>> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed
>>>>>>>> cleanup
>>>>>>>> path for imported bos")
>>>>>>>> Cc: stable@vger.kernel.org # v6.8+
>>>>>>>> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>>>>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++++++++
>>>>>>>>    1 file changed, 8 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c index
>>>>>>>> 8a920e58245c..6d944bd4065c
>>>>>>>> 100644
>>>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> @@ -384,6 +384,14 @@ struct drm_gem_object
>>>>>>>> *xe_gem_prime_import(struct drm_device *dev,
>>>>>>>>          attach = dma_buf_dynamic_attach(dma_buf, dev-
>>>>>>>>> dev,
>>>>>>>> attach_ops, obj);
>>>>>>>>        if (IS_ERR(attach)) {
>>>>>>>> +        /*
>>>>>>>> +         * The BO was created with resv = dma_buf->resv
>>>>>>>> +(exporter's
>>>>>>>> +         * resv). Since attach failed, no dma_buf
>>>>>>>> reference is
>>>>>>>> +held and
>>>>>>>> +         * the exporter may be freed before TTM's
>>>>>>>> delayed_delete
>>>>>>>> +worker
>>>>>>>> +         * runs. Switch to the BO's own resv to prevent
>>>>>>>> a UAF
>>>>>>>> +when
>>>>>>>> +         * ttm_bo_delayed_delete() tries to lock the
>>>>>>>> stale pointer.
>>>>>>>> +         */
>>>>>>>> +        obj->resv = &obj->_resv;
>>>>>>>
>>>>>>> +Christian, does amdgpu not have the type of same issue
>>>>>>> here? Also
>>>>>>> +any
>>>> thoughts here?
>>>>>>
>>>>>> Oh, good catch. Yeah I think we have the same problem on
>>>>>> amdgpu as well.
>>>>>
>>>>> Maybe dumb question, but why does the
>>>>> ttm_bo_individualize_resv()
>>>>> skip the
>>>> final switch of the resv for type_sg?
>>>>
>>>> Because we need the original resv object for cleaning up the
>>>> mapping
>>>> should the initial attach and then map have succeed.
>>>>
>>>>> It goes through the trouble of copying the fences across?
>>>>
>>>> Because we need to know when the import can be cleaned up.
>>>>
>>>> In other words TTM takes a copy of the current fences and only
>>>> unmap,
>>>> detach and then do the final cleanup after we are sure that the
>>>> set of
>>>> fences which was active on destruction is now signaled.
>>>>
>>>> If new fences are added to the resv object (maybe by the exporter
>>>> itself or other
>>>> importers) after our reference count got down to zero then we
>>>> don't
>>>> care about that.
>>>>> If we do need to handle this here, do we also need to grab the
>>>>> lru
>>>>> lock, like we
>>>> do in ttm_bo_individualize_resv() when doing the swap?
>>>>
>>>> Good question, of hand I would say yes but I clearly need to
>>>> check the
>>>> source code as well.
>>>>
>>>> Might be better to switch the type of the BO on error so that the
>>>> normal cleanup will just switch over to the local dma_resv
>>>> object.
>>>>
>>>
>>> -               obj->resv = &obj->_resv;
>>> +               gem_to_xe_bo(obj)->ttm.type = ttm_bo_type_kernel;
>>>
>>> Switching the type to ttm_bo_type_kernel lets
>>> ttm_bo_individualize_resv() swap
>>> resv to the BO's private _resv under lru_lock, which prevents UAF
>>> without
>>> needing any manual locking.
> 
> The lru lock is IIRC only needed and safe when the ttm refcount is zero
> (in the TTM destruction path) to protect against a racing LRU walk
> trylock succeeds against the incorrect resv.
> 
> I wonder whether this was actually why xe code initially took care not
> to publish the bo on the LRUs until the attachment succeeded.

I think that having a resource object attached to the BO before we are done with the import is a bad idea.

IIRC amdgpu_gem_object_create() does exactly that. So bo->resource should be NULL.

We should also use the ttm.type = ttm_bo_type_kernel and only switch to ttm_bo_type_sg after the attachment suceeded.

Regards,
Christian.

> 
> A TTM LRU walker may pick up the exporting resv as soon as the resource
> is published on the LRU, and then try to lock it using
> ttm_lru_walk_ticketlock(). The lru lock doesn't protect against that.
>  
> So we have a sort of moment22, since with that approach move_notify()
> could be called without the bo being fully initialized.
> 
> One way to move forward would perhaps be to, for now, reinstate that
> and have move_notify check if the bo is a stub or fully initialized
> before doing anything.
> 
> Also perhaps we should in the future consider allowing dma-buf
> attachment removal under a separate lower-level lock than the resv.
> 
> Thanks,
> Thomas
> 
> 
>>
>> Checked all bo->type readers (xe_evict_flags(), xe_bo_move(),
>> xe_bo_can_migrate()) and found they can be called concurrently by the
>> shrinker or eviction paths without any synchronization, making the
>> bo->type change unsafe.
>>
>> Switching resv to &obj->_resv under lru_lock, mirroring
>> ttm_bo_individualize_resv(), is the more reasonable. 
>> I'll send this as v2, along with a separate patch fixing the same
>> issue in amdgpu.
>>
>> - Nitin
>>
>>>> Since we don't need the original dma_resv for the cleanup that
>>>> should work
>>> fine.
>>>>
>>>>> Ideally xe and amdgpu can just have identical solutions here.
>>>>
>>>> Yeah completely agree.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>>>
>>>>>> How the heck did you found that? Do we have a dummy driver
>>>>>> (VGEM?)
>>>>>> which
>>>> could be made to always fail attachment for a test case?
>>>
>>> The bug was found via the existing KUnit test (xe_dma_buf_kunit),
>>> which was
>>> failing on a BMG VM device. The test runs 20 parameter
>>> combinations.
>>> the failing ones use force_different_devices=true +
>>> mem_mask=XE_BO_FLAG_VRAM0 + nop2p_attach_ops, where
>>> dma_buf_dynamic_attach() returns -EOPNOTSUPP, hitting the error
>>> path.
>>>
>>> On bare metal BMG the race window is too narrow to hit the issue.
>>> To make it
>>> more deterministic, added a small msleep(100) in
>>> ttm_bo_delayed_delete() just
>>> before the dma_resv_lock() call, which widened the race window.
>>> With KASAN enabled, that gave a clear slab-use-after-free in
>>> __ww_mutex_lock
>>> — the 0x6b6b6b6b SLUB poison pattern in the faulting address
>>> confirmed the
>>> UAF.
>>>
>>> Thanks,
>>> Nitin
>>>
>>>>>>
>>>>>> @Vitaly can you take a look and try to come up with a test
>>>>>> case for that?
>>>> Thanks in advance.
>>>>>>
>>>>>> Thanks for the notice,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>>>            xe_bo_put(gem_to_xe_bo(obj));
>>>>>>>>            return ERR_CAST(attach);
>>>>>>>>        }
>>>>>>>
>>>>>>
>>>>>

