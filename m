Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888743B6D4
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197904; cv=fail; b=NIhlNO/tfXm4T74GqvawtVmOAHPn5rcRy2DAa/HQJJhzCR2G360vIuMtO5EIa12JKARGxExUgRY3eBmRxGWTJ+lQ+HxuwOLMQl8qrkdvomBBsuU5hr7qpMwKCPr+W0Y4BkofdXI9V5itXt4Q4Rx3aLznEfOup+w1G2DVgcCpLt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197904; c=relaxed/simple;
	bh=4/dEJXki9zJtQkDkLz34l0YHV0H9jXsU/TBuq7tmKag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jqliW1b4huePlKnaF9+pfi1RAr92MMxS+irEDe29PzxEqdEJQCiOgAGG68Xp0OuPwT+ffX7oRhSUxJAN4YKB5D90Z0gNX+eV2InKTxpaFBokg1Mnacdt3tZmF+KWgHxU5UOk3Uj1hzHC0YhNAwo9ifDKkwnyXaYXqY0PnDsboqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztxfHLcI; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztxfHLcI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsjEgthqAhQGObTFO+8oWVzqoyYh7wdQ9mbDpla0ZgMgsspw9dVCuOnz79hKGW0TqgPAtX1qW6Qy2u5bhTqSIAEELUyNUsfywAUUmetQgp0pcTDAwmObaX2SUIKDWiEUOlUoLTj2KxpWTFX6fizCkr5zAkpqKuxhCMBK/Jx0FuRt3e9HB0yujkPh9sF2hLk+ctbhLngTvT1e6zh1JLkBKZjpBzfyu4Oa2rlhDHHFKxJyMdkQEWFaH9c7eOuESClss5U+OsZtRYCvxqxZA9XwPtyxXDJkdA8N+dogJvDoYTJj9UhLzgGt6vuIYvLRwvI0EY5j4AztkW/D+TuIfnHrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GICYtZbfCaGDanZKgdSB4hY4mUeqG5WOx/3x/EC3LnI=;
 b=w2mitC+wFqzgDfoV2eZ56bF9vZI8jn7HiBItMrq9k0BPXV8tW7uGFApQQqULoMWiQcTLjekXRUNJU88bNcUjdHohehj6Y82OUZg3NAoPHM/qloTe4fSKZ8qDk+b1I9jwm0fAgv2rEL9Il4K4Rcr2LRbM4hfTctSk7lVwOGfUX62CLEUfd/I2NRkjYoa1/JAAqhpxO+VcjQK+BSjnhqoBH9abR4WthI8eRgoNCuVbu1ARz+/XsGaCxmtEqyk7hPFACJ0d67VB+rA9QbQ/Pu94+vgeqmR1iePwORe3ISm24gwzpLM0kpajliAluumlLiOXUo9o80ag74p4D4FwZsSOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GICYtZbfCaGDanZKgdSB4hY4mUeqG5WOx/3x/EC3LnI=;
 b=ztxfHLcIUMuhoA1sRkBtiNqkesw2CgqX7Q3lw0s2q025HHxUdih17cX4AAb6431UySsa6OG/SFgtHnMhmbgY5klzTTmsyRSzVbrfGDCPGkmblQqxnZffM5yGdwC1Z0I8YhJqGk+HxVWg/bRq5I28kq8gxRik0R0awaFNFAIFsU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 17:38:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 31 Aug 2026
 17:38:19 +0000
Message-ID: <4c038fea-910b-4b7d-b0ca-2b6775d778ee@amd.com>
Date: Mon, 31 Aug 2026 19:38:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org
References: <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
 <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
 <03347904-e0ee-42ef-a40a-478309a2ba33@amd.com>
 <UJ9MXKXkSh6txd43wHcgSg@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <UJ9MXKXkSh6txd43wHcgSg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: e83700e3-1d22-4f84-9ec2-08df0786a559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|4143699003|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ajYtctLaPhOokfZUGDIQFFqLvbhFlM7pU6jAm4ctsfJzBvk1L9v8xdoKfHeJ9DJFnV6TBuUHCkTyDdZlRlFtQLiDW3IIjfDs3dGR5vANeUrxWAnMnMqTRvoTdXSXxsdGpTybRKiNjXd2DVkovt4qPLrewXQTfk+QevjjQXwNctwyMSNpiYocXpajlK1Q5ynGGhO9Viv25KK0z0c2PoMSRNAtWjf822CA4mm8zlBZ2JaTIi6pYZJwKwkYpoBn/B/Texp3glxe029Yqoh7M938RYJiM3Fxs4a5UGhYpmolDzUM8wzviDVnt0XtMTiBXzs54q6nzAy3sVDuwfXDACOgcDH+Ufme1kU6tP8lG/cmSb+ZO1Ct5FReNFitniylv3cFiIk5QEZQzYjLYHwWAp5DQPqozP1KzvcX4lXRVEKcahcIY267e5eTCXh8MgRc+jvuWUtNUxPJ/qkjHUGC1CDEZD0QbbPEYBLQvZMj0Sg/hXkUNbp3lCggFaBthkLeror0fymOJP+dsQxbr6EjmUDAhUEIo1zBc3NxbLkmbDSlpjAAsXsLBvf+qJQOwZ0SMiyjodfudKb0c4550VgKdzdYREdKK1ViIX63/iWJKw9rapyxmBkA++M/XeG6Hhnm/y57DE1PTHkts8C6pAEjLYbPfYrT2iJzHtq8Bq1O41lvi58=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNxcTFCaDFjRnhUY0tCNCtkSlQrN2M0enJ0OTQ1TFZLcVd0ZDVRbGFpczR2?=
 =?utf-8?B?SDRLR1Jsdnd6WnJVQ0wyU3pDVDByVXczaWY5S0owcWNYai9XWFpRc1k2M0JR?=
 =?utf-8?B?RzZ0aVpRL0JwaGVBQW8vMzZYWkQ3dGlYdzRhQVhmdUZIWFlqOFJSSlRLYkVH?=
 =?utf-8?B?SXJITjFwZk5GNERjQkVpWGJyeC9WL0ZVUncyRnI5Wmh0TzZLNWp2QStwUUhI?=
 =?utf-8?B?Z0Q5VjBrNmhKS1JXK0M4U1A3UHYzSWErcjBpRWVvcWpVWUdzeXNnWi9jREhX?=
 =?utf-8?B?cVhNcGhpVVpJZm1aNzV1b1NFVWxOL3hlVm1rMVE3UmlNUHBVR3p1bVd1RVdL?=
 =?utf-8?B?MVY2THMwcDlKNjdiT3MwUFN2YWRsYjZEaThYakkxa09DaFZjbFYweWxiOXdu?=
 =?utf-8?B?bi9mbEZsenp5Q04yZ2Jad1hyNnRlOGhxcU1nb0Q0YmFZL1lpZXRFd1dBR3M3?=
 =?utf-8?B?dmQ4QTFZNW5CL296Z29HSmRHUjJ0QTRwcHhKdXhlNGhlY1VLZ2NFNWxXQVRE?=
 =?utf-8?B?YjRiWG9CSFBPSTJHNm9LZm1wMFRUZXJPZHNIdXBpQnRieE5BSDZ6RjA2NHUz?=
 =?utf-8?B?aWxpcjVtUTRseUVGeWwrVGlad0h5SnhyWkw0aC8zVnYyZ1pYdzZ1VUVGN0Za?=
 =?utf-8?B?Qk9SVDJNTmdHcytCaVRzZWdWSk8xZTc1OGNaK2dZSG1iZVNmRUNqbHhNK1ZP?=
 =?utf-8?B?K01RWVluM1hsbUJyOHhJRFVHb1NvYjNSc3VTeC8xVTNWa3l2dGIyRFBzVksy?=
 =?utf-8?B?akluTUoxWnVMM2pieFNBNnhxdTdMMWttRWMzTnBOUzYzbHoyb0JxZGxpUWlB?=
 =?utf-8?B?Y2cyeVJmRzQrUTlRR29rcU9tMEZoazhJWFAxMjhBZytWWk9nM1NGck44K2Jx?=
 =?utf-8?B?QVFDaFJUOEF2QUE0ODlxS3pIYVRQaG0vUGZERDR4dU1aMWtPN2p2NXFVWlk1?=
 =?utf-8?B?WEFreldUZjJwMTF2NzVpSGk0cUlRbGYrUDVDYm9CNkNaViswUFc3NWYrd0Vi?=
 =?utf-8?B?S3hwV1lxSmVwV1BsZDhDejZERU9KL0luWU5laHBVTURZK1R0OS9kYzA5SkJR?=
 =?utf-8?B?Wmo5MktMclBERzYrL3BlR2cycXVwWXNyUEdHa0JDeXV3aVg3eFhiUk1XY01P?=
 =?utf-8?B?K1hCWXQybU5nK3J6LytaRFpaaVRpRFY0Z1c2eVJaTE0wS0l5dTVnWFF4c1ZP?=
 =?utf-8?B?VFRrbjFONFpBK0MvYUdleFM1eE1tdnB6ZkhyU2xMRUZiNVJ4S0lBQWVwMkpK?=
 =?utf-8?B?R1JEeUVvemZZRmtjd01ydlRwN0ptT3IxMm9uRnQxSEduVTNLYWJwQzhHUUhE?=
 =?utf-8?B?SWNCZXFlTStTRTQvM21jTkdUV3B5aUpnbFMwa1hnSVpFYzZaQ29GZlhRTjV5?=
 =?utf-8?B?NnNuTC93WURVODJRTThqcE9wUVpLNEpncVB0ZFllTDhnb0Q2SnhseEc4a052?=
 =?utf-8?B?dmJ4b1g3cWdUV2o1eE1wMHhZKzF1NTNCSzJIUisvQ3Y1TUY4VHB6eUh0M2E0?=
 =?utf-8?B?RmVrMWVoSVJjQnIyblJtMWpSSCsvaGlhNGhXZjNITFZ4RHhEU0dEcEJlejBP?=
 =?utf-8?B?by9YcVpvTk1TOGlJeS9yY2NtUFNiTlQzczMvUUMzZENUVCtQMUZIWmZNdVRP?=
 =?utf-8?B?TUVkT1AyVUJJazRUUGloZUs0UjQ0MkVaTmpiK1pCd0NIKzZhektHQkxpTmdW?=
 =?utf-8?B?L0xQcWxHL0lkUm1idXhXNjRGcHV3bS91QXlZS3hVL2FlSXZVNlhSTHc2Mm9N?=
 =?utf-8?B?d09Tb3RQejhiTi9kNHRlR2NSZlBwTm9kTkVyRlQ0NVRkTzlodEp0WXlNb3Zr?=
 =?utf-8?B?bG5PZEJMV2s3Q1JYNEo0bzVqbWlpWmhtd0hoWmY5akpTeWJEVDltNXhkVCtO?=
 =?utf-8?B?MGJsbXNtTGp5YStkYmRGekRtQ1pZMjkyRkt6T2lXVGNvTktkYWxlK01saWNC?=
 =?utf-8?B?eExxL2FjYXJ4Y2dCbnFvZ3VKM00rYVFtdlRKazRJWVYxb3F2SVd3Z3h4c0Ex?=
 =?utf-8?B?dGZCZUUxWWFNZHgwOHI5djVEMnByeG5BVmw5UU5MUEs2NncyRDg2Q0k0cVMw?=
 =?utf-8?B?ekxHeGJUOGJRTFZwa291QmJNU3FkVU81ZU95Mmk3L2xJd2ZvZnBIL1kvTlR4?=
 =?utf-8?B?cUtZS0Y1MkN5NWE4Qm11Y2ZibnJXeGhkTEFoTGVpVUhKZHBHSXNETlpJazFU?=
 =?utf-8?B?MzFMOC9ON3RoWUFTcGsxbW83MXpKbXphdDJ5dDVGUjlRQzJmLzY0dmNDTHVB?=
 =?utf-8?B?YTJkYzZucDdNdUxlWGx3enp0RFZvdC9uK1FtYStHOVhiQzI3N05XbWpJaE95?=
 =?utf-8?Q?NsdRRk7AEk3Zy8zHgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83700e3-1d22-4f84-9ec2-08df0786a559
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 17:38:19.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EfFWmav2fyWJfVYDDeoR6htJOLz0X7ZQucdIKoXL9pqf0OSxbO9iGzJxmRy3312
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

On 8/31/26 14:30, Timur Kristóf wrote:
...
>>>> only flush when a GART window is actually used.
>>>
>>> Does that mean that there is still a risk of the wedge when the GART
>>> windows are used?
>>
>> Yes, and that is actually not limited to the GART windows. It looks like
>> every time we map something into any VM it can happen that the SDMA crashes
>> when there are concurrent operations ongoing.
> 
> Would it help to set
> adev->vm_manager.concurrent_flush = false
> until the problem is figured out?

That came to my mind as well, but I don't think that this would help in this situation.

> Or can the crash also happen when the VM is not concurrently flushed?

As far as we understand now that problem can happen whenever any VMID is flushed and the SDMA not idle.

> By the way, is this the same issue as the Navi 1 sdma_invalidation_workaround 
> or is that completely different?

It indeed looks very similar to me as well. Maybe the fix they came up with for Navi 1x was never 100% correct and now instead of accessing random addresses the SDMA just hangs.

Anyway this is a serious HW problem and we need a proper fix ASAP.

Regards,
Christian.

> 
>> It's just that the GART flushes triggered by the SDMA made that scenario
>> much more likely than anything else.
>>> Can you remind me when/why we need the GART windows exactly?
>>
>> Basically every time we want to copy something from system memory to VRAM
>> with the kernel.
> 
> Understood. Thanks for explaining!
> 
> Best regards,
> Tim
