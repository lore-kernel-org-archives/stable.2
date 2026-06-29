Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02433FE363
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735008; cv=fail; b=iGXsTUvWff3nm47RzvuxyatvXzsEngAob9xkt9bjVPrJ3QTQq5WmAwwPWD7D+Mc7Uy+VT7ek4Y/2q3rvl4KqGP5LD7iMnZ9sYZ11Xdpo/GrdbDKkObuYGMANyGy5J45HvIYqliBD3cf53i4mlqjq5M80oiUcWYzMjh3ogQ5fETI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735008; c=relaxed/simple;
	bh=cR2WDBbiRp0awjmMlGaKBCVgYVItsVg2MPNC8sF+DSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O+ZyeImiB3qmHa7FevQ5IhkAQjTGbKBOAdMI+hbQcufHONjF1mql7kwreXIkz8SG571COBc9pMPf542iztf6Y8hBYLOGMRX3m2xBcRTqEyXdFHzdqhXDhgaNR+akN8rJ7UKRYn/XRFN2j9YK9c3gatHoxIG6icff5EuftH5IAyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ac1W8ASq; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ac1W8ASq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYpS5AYKYEGNmGCFxn2BuVgiP+RJ75iSRcpic+KH/M5LSPJPYiGqLvkewCJSTx68/gMoRgOwhEDCeH4i8wiC9ofsIEIiB547kJSn8luQh/8GihNRB2awHqk746aVavhAWW2+4kmLTLEU04Fd/1lzre4Oc1tVnAKWwo8DHKBukPsigteTHZxi4jfOvrh90BgjA8J/K2SfgRYtJkZZWhUnd5fsJvBol6RhZQclAKMGOjps486OeUM7yQfAue9ZxLwyZxAZMigk3Q5gLStMQp5/LSRJwTV+xtQ6a4WcOC34z6iQVg/K038Y38nS+S+baX6hueiE3Xgu7+D3+O13yrUh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT6ph3n3w57c5+AC8JDj0oY4YxnvyYOARAgQDUUl2O8=;
 b=VVLsEwwEzuyt3rtxrZL0xVUj7hTKljDveCEL83ujbiQiDo8W+K0ZMRuCgLdThoufwFum4sreja4OWcCB7Nhj0D8cTRJ3OEvU4qDnRWUL9RyxfpmfANmdsZncMD0AS6uW/nNVh2JlolinoLMR7hKj6HWsAjFmqamNWRb3/K1jvyFC5JWCPw7WxVHbCOQ8ScBTkAImTJQsLgC9Gc6WtCkW3q+x6i3yEP291EffQ4xpOVf0kctKY2ldbZJvO8dgtm+8nXTb/HPY5hWYO+2RPBERmL45XVwqZfZNmOzF2Ae3K/LtgZFCfEB5sYiigmcyjluoeGP3bm/M353L70a5CuhlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT6ph3n3w57c5+AC8JDj0oY4YxnvyYOARAgQDUUl2O8=;
 b=Ac1W8ASqVNEz+SZscwFQBm9KpDNf2QcwKrF8UGj1nX3ByCkh4qS6H83MV+TsmbD0pd/FviQq8ctnFh2eYnu1f70HD610w8Ed+8IBJtRfDyzP8nSPOz95xsioaBlfP6PxFJQehGPHzAo7+A196BGA4z+Gb/V6Tr9yrrkfs1FNrT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:10:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:10:04 +0000
Message-ID: <b4bd7430-a45d-4925-ad30-ba8e987389b5@amd.com>
Date: Mon, 29 Jun 2026 14:09:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
To: "Gote, Nitin R" <nitin.r.gote@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 "Auld, Matthew" <matthew.auld@intel.com>
References: <20260625055734.2831607-2-nitin.r.gote@intel.com>
 <331d68c6-aa51-48d7-8c15-69d5dbbe35b2@amd.com>
 <SA3PR11MB811816455F96AB93CD54C57CD0EC2@SA3PR11MB8118.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA3PR11MB811816455F96AB93CD54C57CD0EC2@SA3PR11MB8118.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 898dbf4f-7aa8-4ea7-c9c5-08ded5d759d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|5023799004|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	LePdDWtxZO+YtWAVP9DVLNQp8yhgKis949NaamRh+zexOPCgX4cpSS3ryB7Wvd9UqXCN/XrHBHUInKyNAtspfO0aqN25/ivlgr4j0pl0AP537vlxjmiwHgGqBHPg4ScjDcw33tPKGBAOmwqgL9zKtUxUMtyQOaf0SzsRDENNn5RPxttKiEHR93C++BCxMmtriT87DY+2X0ZuFrFdCPcJhQc1rgIcqygZv49AU4wjGUvvT3My14HusshHGF4vF5AfY8iARRmY9OpdoIi9WN0a6I2Ue7oXDozMYdgP3X7Es+nuFlohjmO6TJC5nf4lrbQ4O4LZMr7PnQM59924JPAEcD4pgZ9SU/Qi8qA5hQFueZgLkqEf66UnBykHRFxl6bpd9uTu8v13eKUlKroZWlgXLgdi+c1rRay5XpIifSYlcFlwL0PSMTWz9l324S7lZNn4rLcil9poNTStXbd2qVOecxBu4ISs5lHXiSxHHM/yFVqjw9JQdV19y80iDz7CW6k++3utf4IWGhXAI39uq/oMlRd0GXBmf/iHw6qmTDFev5m8h+vurOjRaK4skfU168Uaxh6qHvr6yhEiQupu2RJ9h/dbWejqHuyJJWxSLj99W9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHdNR2NHV01qWG1hc3Bvb3E5YXZjVDNicHVCOXpmN0xRY0NKWWxEd0YvbnE0?=
 =?utf-8?B?TVpBNVk3MlRyby9ZeG9yU0gycG9xQml0bmluWUllVDVBRTczYjA2MmptMXVB?=
 =?utf-8?B?MFpuODdZb29LZkUxbmpoZVpLR0dJUjRNTkZSOTRQcmpPdUxOcVBsUE1sek5Y?=
 =?utf-8?B?RU1EdmFwUEY4SWVhY1NNbW5RN2lrWkNXNTM5QTlrcG9ZS3V0eVluUGhQVS9S?=
 =?utf-8?B?RldjakpKbmdFM3NWUTFHOUlwMkczQmlCR0pkbThGSkNJbkZGZWgrYUsveDNh?=
 =?utf-8?B?TXJOVzFtWXd0QUloUnVlSGdwS2s3NGh2UlpTcStuZWtLdlVlZ2NUSlVwbHEv?=
 =?utf-8?B?VWhIY1B6VjFPcmhVc0NWVDdwK0plMEVkWENhUjBaQU45QnNxdGo0U3V0aFFP?=
 =?utf-8?B?OTFCNHhDdzBISmk1aWw3L1JEcHZ6Vk9GMHJqZFlKK2h0eUlNSzQzdi9acm5z?=
 =?utf-8?B?cUswV1gwWk05QzJIMytMbHdkVFNCM0VlajdYTHVDRlU2UkxwRitCNy9rUWhZ?=
 =?utf-8?B?bGhMZU5VNjBTb2R6SnllWW0xRzdsbkZ5K1lQSnpnVUpQakZtUVRDOFZ3WHc0?=
 =?utf-8?B?MnhRdk1MYk1FY2tESzFPWnZvbEdGMmhQQ2xqQlRnZjg1TWNaQnpEdVJOQldq?=
 =?utf-8?B?ckNqQ3pPbmQ2SndPT2FQQkE3Q1JVYkhLMzNKQjF5T3E5U1BPaWJUUGdndjh6?=
 =?utf-8?B?UnJLREJvUHdXUHQ3bkt6bUtUWkhmQzE4eWdlT3VvSEU0eFE3enRiOXN6VVly?=
 =?utf-8?B?N1hYOVM0SDlFejU2Y254SmUwTlRIRjFJTUw3WUo3RE5JWjNaenNaMU1HN1F4?=
 =?utf-8?B?R2gwUDlyRWxYWW45MEZIUGY4dk9ZSXBkd2NYUTFHZTJwNmpFa2psVFhzbGoy?=
 =?utf-8?B?c0ZMSkZUZ1RHVi9xNGd5T1NtZ25GTXRZelJYVVM5YzlNNk5MYXQwcWVOUWVG?=
 =?utf-8?B?TStrbDBOVG5TQko2SEUzY3hLUnZKS3ExbFoxYzhYZ0dFV0ZzVDg5QllhMVNz?=
 =?utf-8?B?NVN1UEdIS2VQcnZvTTdIV0FHVlB6ZFFuVEtlUGUrRS9ydEtWWklRZEpTUWww?=
 =?utf-8?B?SWE1dDlJTXk5aDlkQUJpa3c1b3RsclZ2YmVIbm9iN0NzVkFUTWdPSW1qY1dS?=
 =?utf-8?B?MUJtczVTdDc3NDRIWXFZaGRMcVF3U0p0Z0p5WGE1LzIrT0lsVkFCMGFFUjFI?=
 =?utf-8?B?RjUxVmhhdDhrcDhSV0FrZWd5dVp5dmdPMkltVUw3U3lMKzdaNXdwcFFjMnFy?=
 =?utf-8?B?WEV2NnFkZlowbVJ2UWxyRFVob0htOWxteUJhWTZWN3dSWWdSSnpJcDdnRERE?=
 =?utf-8?B?NXJxMzRrTWxYajA3VTBmRFNsdE1ITGR5RXFMaEJvcDFSMlZtVDhqQzVXcWFK?=
 =?utf-8?B?c3JJaEdQTFhhRUVoVTFZeWFwYWlhRzNWNnpPQkljOVRmeGY2N3crbjlMdlpm?=
 =?utf-8?B?czh2OVBaUFRXUGROc2ljV2dzdmNKeG5lRW9sWFZlRTVCQnVoM2dZYTZ3aU1R?=
 =?utf-8?B?OFdjaWF6R1huR2twZVIzODhIZm9JTWpDMmNIa3JNdlV6MG93VUVLcEt6T0F4?=
 =?utf-8?B?VWRxY2dLQ0c3NmdUWjFhQkF4azdueXh5S0h0WkRVeWxmQXlPOWtvMTdQVWFH?=
 =?utf-8?B?dXI0OWJwdHh2RmxWdDRPVG9ZNGNFSGtuVjVOeXRWUnhSUzRJZDFKQjcvS0M4?=
 =?utf-8?B?N0laUTlndHVxUm1lZ0hoditPN0h4UmpNS2UzN3RsMFVkdDRGRFVXbXdWUFo5?=
 =?utf-8?B?VHhabkh1VU1FMmc1QzJtSnltVmZlVzRPbFlDc3hpSEhPRitJeGo4TTd4YUpN?=
 =?utf-8?B?UWYwN3hYRUpzWGk4M1VwbWRpdGlVY3lCN1RBbmJjZXlXMkV6ckRyNUFxeGZX?=
 =?utf-8?B?WVFvTWl1L01DQUJxYVBLaHRHb3BzbnpJS2pCenh1OTZ5aGFnU0VGN0RoT3RP?=
 =?utf-8?B?Z0hFZE9rU0JUSm5aQVlNbWlEcWoyWTFneGFtdUdJaXBXU3ZZcFZNSUFqWG0z?=
 =?utf-8?B?cmcwU0tkSXRCMk5GSGozM2FTd1FpUDVrbEVKT1VFYWJpckhxcW92S3FWbGZ3?=
 =?utf-8?B?eERRME9lQVlvVDJHOHFqSzlIYUw0RlVyMDdFZC9wMGFiYzRRK3FyaXBnN1l3?=
 =?utf-8?B?alcwbkdCQ3B4ZHZNQmZ6Q0RwZnA1TVpObFVxbkNyZVBEaE5aY1lPTmdBSlE4?=
 =?utf-8?B?dFZNYTk5YzZXSkdENDgzdmhwRmN2N2JaQUVUZ0RVMlFtVWxqL1VjMDhKeW9s?=
 =?utf-8?B?aXdQN0hPRmcxYTZPRWlHV0JFcTErOFI3a3Z5UVpnbXRVbFR4bWlqaXp4UTJT?=
 =?utf-8?Q?phoo+TgQ326fYe4tRg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898dbf4f-7aa8-4ea7-c9c5-08ded5d759d9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:10:03.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b2VW9c8KNNqBjpfZr5yfTX/R4M4j+j0Ke+J+RagSiUIarf6ntQKZ9b98JDm9z50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292

On 6/25/26 19:10, Gote, Nitin R wrote:
>> -----Original Message-----
>> From: Christian König <christian.koenig@amd.com>
>> Sent: Thursday, June 25, 2026 4:16 PM
>> To: Gote, Nitin R <nitin.r.gote@intel.com>; intel-xe@lists.freedesktop.org
>> Cc: stable@vger.kernel.org; Thomas Hellstrom
>> <thomas.hellstrom@linux.intel.com>; Auld, Matthew <matthew.auld@intel.com>
>> Subject: Re: [PATCH] drm/ttm: Fix UAF on dma-buf attach failure for sg BOs
>>
>> On 6/25/26 07:57, Nitin Gote wrote:
>>> When a dma-buf importer creates a ttm_bo_type_sg BO with bo->base.resv
>>> pointing at the exporter's dma_buf->resv and dma_buf_dynamic_attach()
>>> fails, no dma_buf reference is held. The exporter can be freed before
>>> the delayed_delete worker calls dma_resv_lock(bo->base.resv), causing
>>> a
>>> use-after-free:
>>>
>>>   Oops: general protection fault, probably for non-canonical address
>>>         0x6b6b6b6b6b6b6b9c
>>>   Workqueue: ttm ttm_bo_delayed_delete [ttm]
>>>   RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>>>
>>> ttm_bo_individualize_resv() skips the resv swap for all sg BOs to keep
>>> the shared resv available for delayed_delete to release the dma-buf
>>> mapping. A BO whose attach never succeeded has no mapping to release,
>>> yet it keeps bo->base.resv pointing at the exporter resv that
>>> delayed_delete later locks once the exporter is gone.
>>>
>>> Fix this by checking bo->base.import_attach, which is only set after
>>> successful dma_buf_dynamic_attach(). Failed imports now individualize
>>> normally, so delayed_delete operates on the BO's private _resv. The
>>> exporter remains alive during individualize as it runs synchronously
>>> in ttm_bo_release(), while the gem_prime_import caller still holds its
>>> dma_buf reference.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
>>> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed cleanup path
>>> for imported bos")
>>> Cc: stable@vger.kernel.org # v6.8+
>>> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
>>> Cc: Christian Konig <christian.koenig@amd.com>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
>>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>>> ---
>>> v3:
>>> - Dropped the xe-side reordering approach since importer_priv must be
>>>   valid when dma_buf_dynamic_attach() publishes the attachment.
>>> - Per Christian's suggestion on the v1 thread, keyed the check on
>>>   import_attach rather than removing the sg guard entirely.
>>> - Exporter lifetime: individualize runs synchronously inside
>>>   ttm_bo_release(), called from drm_gem_object_put() in the
>>>   gem_prime_import error path while drm_gem_prime_fd_to_handle()
>>>   still holds its dma_buf reference.
>>> - Fixes both xe and amdgpu in a single TTM patch.
>>>
>>>  drivers/gpu/drm/ttm/ttm_bo.c | 24 +++++++++++++++---------
>>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
>>> b/drivers/gpu/drm/ttm/ttm_bo.c index bcd76f6bb7f0..bf8eaec0e9ca 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -196,6 +196,14 @@ static int ttm_bo_individualize_resv(struct
>> ttm_buffer_object *bo)
>>>  	if (bo->base.resv == &bo->base._resv)
>>>  		return 0;
>>>
>>> +	/*
>>> +	 * Successfully imported sg BOs need the shared resv for dma-buf
>>> +	 * cleanup. Failed imports have no attachment or mapping and can
>>> +	 * use the private _resv.
>>> +	 */
>>> +	if (bo->type == ttm_bo_type_sg && bo->base.import_attach)
>>> +		return 0;
>>> +
>>
>> Yeah, that approach looks good to me.
>>
>> I'm only wondering if some other code than the DMA-buf imports who uses
>> ttm_bo_type_sg could potentially be problematic here. The KFD stuff comes to
>> mind for example.
>>
>> Maybe ask some AI tool who and how ttm_bo_type_sg is used and double check.
>> I don't think there is a problem, but just to be sure.
>>
> 
> I went through the other ttm_bo_type_sg users, though I'm not too familiar with the KFD code. Please correct me if I got something wrong.
> 
> At KFD create_dmamap_sg_bo(): It creates the sg BO with the parent's resv and never sets import_attach, so with this patch it now individualises. 
> That looks fine: the new sg BO holds an amdgpu_bo_ref() on the parent until its own amdgpu_bo_destroy(), so the parent resv is still valid 
> while dma_resv_copy_fences() runs (which reads the source under RCU anyway), and with no dma-buf attachment there's nothing that needs the shared
> resv at cleanup.
> 
> The rest (KFD doorbell/MMIO and amdgpu_gart) create with resv = NULL, so resv already points at _resv and the first check in ttm_bo_individualize_resv()
> returns early, so no change there.
> 
> Seems like there is no problem in KFD case.

Sounds good, with the issue mentioned by Thomas fixed I think that this should work.

Please update the patch and send out a new version for review.

Thanks,
Christian.

> 
> Regards,
> Nitin
> 
>> Thanks,
>> Christian.
>>
>>>  	BUG_ON(!dma_resv_trylock(&bo->base._resv));
>>>
>>>  	r = dma_resv_copy_fences(&bo->base._resv, bo->base.resv); @@ -
>> 203,15
>>> +211,13 @@ static int ttm_bo_individualize_resv(struct ttm_buffer_object *bo)
>>>  	if (r)
>>>  		return r;
>>>
>>> -	if (bo->type != ttm_bo_type_sg) {
>>> -		/* This works because the BO is about to be destroyed and
>> nobody
>>> -		 * reference it any more. The only tricky case is the trylock on
>>> -		 * the resv object while holding the lru_lock.
>>> -		 */
>>> -		spin_lock(&bo->bdev->lru_lock);
>>> -		bo->base.resv = &bo->base._resv;
>>> -		spin_unlock(&bo->bdev->lru_lock);
>>> -	}
>>> +	/* This works because the BO is about to be destroyed and nobody
>>> +	 * references it any more. The only tricky case is the trylock on
>>> +	 * the resv object while holding the lru_lock.
>>> +	 */
>>> +	spin_lock(&bo->bdev->lru_lock);
>>> +	bo->base.resv = &bo->base._resv;
>>> +	spin_unlock(&bo->bdev->lru_lock);
>>>
>>>  	return r;
>>>  }
> 

