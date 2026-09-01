Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22082BEFF5
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284126; cv=fail; b=dKWYOuwsog7Hu3PStWgQCfncS6BEQoS7T3xpOpLT+m7iyWQkzOYE4WSJgIM0pqnAP6VZx4oSxg/Hs0wq/mL5PsDmG/mUzesAtPTYthBT26uTiJxTIAy8PS+twiXTQQS+qBwRWKdS2vznRtdB5XHpIsCGYdq7fHkEyLlqmLt7DSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284126; c=relaxed/simple;
	bh=gbqG7OV5DidgfruwQT5jKvYeXZEpfKElTWQfAvL0pN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WviT6zjXvkMzWVTR0CLdD9NheBEetDw5Tk9sAfjQY2rexim29HcHYTQg2BkzqD3w5tBaxJv7/NgM6W0AgB7/aXEHm1boCrSNLA2p98dkj0eTj3Gh9vGB7kXdoUNNxm7txyTsJyCe6XLsaYhmA8QEaw5OmCobfiM4GHDT21/8C3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2jR9VaKZ; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2jR9VaKZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1GLn6oQNfh0oZ6ZJ/c8Gh8p2tYjSFlMTUsx6l54CammCQQ2XVM5+AoXhOliywkHbLNg55f0tPDfLAbXSbFDiBijBbgdBSDRhZkbs30gfuW/5oh/znQQlShHR8mXepgbXlcINN5LDQQopN2yv9CMSiJoJXw6v+W3DNNlOCtoQAg52L/y8pNQiTGbDSpbKl3oDk3DV9lEyu2EF83PzPeivT5KdfJ14fhncd+8QpkVUVCrf8if/1RHvUJxAz2PBTWnQ/OEJqvdjmops2jZGaa2I2l3HI3r9YIOl0//xzoWmMvZ+xILm5Qmuq7Ilzy78AFlwAY3xAia1u10V4QvSBv2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eyk476kikLrA3RWV80hOXoY/bRbZg3eTIbIu+5FE56s=;
 b=afrURUMasABWagr4Wc8+v+XErujm+IBDlpt2q+lRsbWuFdUc871WCZ9G9uCe63N2OZqWM6EY8iUb4tkH62wf4Ggm7XEhrwOcmoxXxsSLvL3/UelxczlP/sGZX3ffQlDYFaaJHeB7/eRy3VeJx8pKsmPS0rg+IZ2QvydF9NRCNRljEJheG2Qn5npMCrOj9vVvBjqNDLq9D+O15xVmTDhgnS/hmoiYsDIeJ4MddAnWPAOvk4YU484vKms0vehwwQr7Ji/OdrkkCe0LsdqnPAhqAuAWV7PtsbV7tjRcCcAoQgR83ttyN+CRXacHkgnCux57rRUuAYaosQ39GBQFbW4vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyk476kikLrA3RWV80hOXoY/bRbZg3eTIbIu+5FE56s=;
 b=2jR9VaKZu8jN52TwPoz3goFRFRkSVG8yRz+4f4Wuibmaeqs45vrJ9CuI3bOuHrL0j0yEXhgbN6PHnPUUxQjMTyIREbjeBBczHl6i4huAMlCoJkaNNTwaRYN1ovsIN6WZt5CoVodQXSdrz4DODtqfYVk8GKTuKEVmwqBY0ha6+po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 17:35:20 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 17:35:20 +0000
Message-ID: <77c82527-961c-4ffa-8447-f51d19111bbd@amd.com>
Date: Tue, 1 Sep 2026 23:05:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: skip the VMID 0 flush for VRAM
 clear-on-release
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, timur.kristof@gmail.com, stable@vger.kernel.org
References: <20260901095100.79673-1-Arunpravin.PaneerSelvam@amd.com>
 <8c1e54fc-037a-4940-8243-b9912e675da9@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <8c1e54fc-037a-4940-8243-b9912e675da9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0133.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::7) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 23013579-06e8-4fe0-0814-08df084f6545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fnvGqF4STWS/qH5TCPQUouqDNsbBSwoTFLeAYOtzYchpM1ezkvk5YYuJYfCQdfuQcoSIicPEVEtjnFBp+ISR/TV/SOkWx10j6Tj4J7v1REGEghw+Ct/hGdTKUXI+vecQfulSOeerJsdeTdjE2+VPkZfwgd0mUP1i1bu0yE6ORLXiU5oi1fDujZ2i31h9nSCR+UkKQ+e1NzLM5URVlmfQzew/MLbQ/h52A49fG9bpkMaMMQMmx18AZoRaTBsrMeheIt2ZH3MRlyAaoXXAxr9icKF3dAi4ErF6X5nyXkeFSFDnbb9icc2hrBgHDrSRhv72bqueQ82wEgzm1FKqdWFLEZeTF46Z08nTpM6fDqu1y2KBdGyjmBajPqDG5eviWcCNV1l8tHTjPbGerr4iZIrTVdRyM//Ptv/3QClv7Ayn1uPvW1gg4puC6yzYQ9x8q8PJwvw0PBTdPO7W0w0VTL1AVd5n0raxvzGWV05gjllYTaaiBAPJWgOdTZPFt0/SOIzS7zabn7fY1apK8laTSQUW5NgtZkQ3PH2k9G+EX50cm6F41pwMj8u1R4BfTmtlCj9CcSN5J197hHzMR7ZGIipCjyRYzO1H5T5QTJ7VQjhuhYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b09NQTdpckI0c0NxSGZPWDgxYWRXdnI3T1FuUDJFaUw4R3VQaFl0Rk40TXB5?=
 =?utf-8?B?QVc4UUxGeENnV2dRcGtWTGdaS1pkem43cWk4K2p5azdTTEZrenVJcmtmV0w1?=
 =?utf-8?B?eEhVUCswNkxuZG5xMFJTQllmYkdOdUtvQm5XeFlPSDVHenF0VGFGcjM2U3h1?=
 =?utf-8?B?cnVTNlNRdk9GWFBjbGF1Z0NYVHdpSnNtZjF2TUg0YWQwcisrMzMrblFJNkcx?=
 =?utf-8?B?S2ZLYmNLSUM2YSt3Q0JLQ0pRNXgxMUpPa2xoei93ajQyUVh3N2c3R0ttWm93?=
 =?utf-8?B?UWhOSU15MkFkTW1BVEZ2WUxLdGJvRzIwaDdFMlhkMWd4QzZmOHNDK2kyakpj?=
 =?utf-8?B?c2J5eWw3dk16Q2NkbGVaeG9xV1VVMGNUd2UzdjdmWFNOdkREYWkxeXFkU2lm?=
 =?utf-8?B?Z3hKb2tqRDZheEVGaktRUlhxZk9tZjZ1ZzUvMnlSMEl3WHBLMWthUDlFS0lP?=
 =?utf-8?B?aS9RL1NJM1FWQ1dHdGZrUzBSSnhJejhlQkh5eEFVZ3RXaW5aVXk1RXh3QjAy?=
 =?utf-8?B?Mkt2Q003QUpUWlhMYmZ4MXc2VjhJZ0RvNlZiT3ByNDdyOERBVGZCZktWS2NJ?=
 =?utf-8?B?ellWdEJJdUxFczRSR01JNGRJWU5IejlpOWswSVJvSzZ3b0tuNGNndkJIZDYv?=
 =?utf-8?B?cFJ3UFFzTVNjRTQzaTlOWnVXRmNZMkhoRnN6M1dweHRWQU4xT0ZFblJuVmNM?=
 =?utf-8?B?R2ZBQlFVNUwva0FBbitpTjlCZUFTMXlXb1ZmZG8xeVlMazNYNXZpUHR3VmtZ?=
 =?utf-8?B?QWMrSTNKb2d5TDBJQ1ZZdjB0dDdiMStuN21TZ3ozek00YlIrUnBxMG9OemRo?=
 =?utf-8?B?SjQvUEJHLy9DY1hFbk1BQjNsVTNXWnBNRUo2a1Z0ZVloa1pxQXJqV3ZSc3Zx?=
 =?utf-8?B?bUlJNk54c2N2a2FhQjRZaldDeTloVE9FMTVRVFJrQ0owSzR5NVV6WUdVUHdl?=
 =?utf-8?B?RkF0RkNjMFF0YU9LT29KVEQ3ajdVemI1cUZLMVE1WFZZazhhZmk3Y1FvdFF3?=
 =?utf-8?B?Mzl3TGwzOEZvNlBzOG9HLzRMUEtYRnorOGhUekg2S3QxWmNnM1lPTEZicjlW?=
 =?utf-8?B?YzJZZGFSYVRINyt2ckJqTXRURDFJdThBRDZ2RDh3Q045OHFSYnQvNmlFL3Jk?=
 =?utf-8?B?QjVSUlNvS0ZtdDNTWGZHZTFmSU10MmQ4OUlhbklmNDU1c3l1TWdYYThRNVcw?=
 =?utf-8?B?ZmFoMGFmOGo5cjYrbXB1Wkg1b2hneUFnZmhWWDE4VDBnN0UvRCs5RDdSTVdo?=
 =?utf-8?B?NVlvdjd6NDdOeEJadExWU1NmTWN2RXBQRjVOdFBMNmF5Z1lqSnVxcld0UUpY?=
 =?utf-8?B?OTRyUWhMb3h4UG0yYmJYY2pWV1ZpN3VMYmpPaEVseThVNjNLbWc3bGJpYkdK?=
 =?utf-8?B?dVBNaEhWVnhGODd1N2NkOFlNeC9TZFFoQlYzQk5BTGFLQ2lBdktNMFNVMWRx?=
 =?utf-8?B?V2dDYjRpdVVjY1BzeFp2R1hCemdZVjFjd1IvOVc5K1JFWlJzQXU5cDk2b1F6?=
 =?utf-8?B?VnBtTGIwZVNOZVZ1N3Qvb3F5S0tLUVd6K3dlak9CVytxcDNTNFpHUFNxczVH?=
 =?utf-8?B?T01aVExVLzhCTmhoUVgxY2E1SzJHYlkrMXRZWUhjT2oweEdvUmh3OHZiczBM?=
 =?utf-8?B?NTEreWEyV0U0TWpja1Z6QmVLM1FZNVNMak15MGJ6Rk5XM29UZ1BkMW9Kbi9B?=
 =?utf-8?B?WEg2clhnTnRENFhCSXArQzNsWi9yQlpWaTQzOFhLellyZUMzTVJvZGpBUG5v?=
 =?utf-8?B?NVdXUHhtTXMyTGNYSjB0aStwOHo0VkVQaDRtWERuSFIzYWpnWXNkQVI1WnNa?=
 =?utf-8?B?U0ZsaWg1bFNKOEVWTzdMMTNyQTNhQnk0cmZTUVpNaWl4aGg5M1VEcVJiT003?=
 =?utf-8?B?VHpRanRGRkJNZ3BBK0ZlWWpnQ0hxMjBHajZZOXFyVHJPSXE2WUM4c2JHS0Vo?=
 =?utf-8?B?N0tReU5RTnc4Qmg3RGxQb0VCRlFWd0Y3VmFtSWhPT2M5cEFGWmJLcC9NYUht?=
 =?utf-8?B?RTU4N3h3MWZRMkJ4L09Rejg2NVNnUm5uWll5WWxiL0RubW44NlpCY3ZQSmc2?=
 =?utf-8?B?N09TK2YvZ1hTNGIxVWE2UC94blVGQjczYm94UXR5WlVqclI5TUd6WEF4T3g3?=
 =?utf-8?B?Wk9ZT24rQ3Z1NE55Z0RFbnZlYWlaWlBOamlNL0RaejNpWTVlWmhJeFlINHZ5?=
 =?utf-8?B?eG44ZEZSZ0ZnQmNHR0FITFlETGtkcko5NEZBOENUSHVIMUtNOEJzRytnWGpD?=
 =?utf-8?B?SDMwR1FqVjB4bTJ0RTFPbk53K3ZsbUpBVlFvWEw2VllxRndGT2NVVUdBb1dQ?=
 =?utf-8?Q?3+ft4Req3DryYJzz26?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23013579-06e8-4fe0-0814-08df084f6545
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 17:35:20.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+9h4X/uoAbMbo8oCzILZPFjdT4Pmj1q0xEaKy3yKw1xJ0AQcfilgvtl3ZRLjjYdKhtKVL1qcziaHgwdbdauzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080



On 9/1/2026 3:22 PM, Christian König wrote:
>
> On 9/1/26 11:51, Arunpravin Paneer Selvam wrote:
>> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
>> via its direct MC address without programming a GART window, yet the wipe
>> still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
>> flush can wedge the engine; only flush when a GART window is actually used.
>>
>> v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
>>      and drive the clear and copy paths from that. (Christian)
>> v3: Make the vm_needs_flush output parameter mandatory instead of
>>      allowing NULL. (Christian)
>>
>> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
>> Cc: stable@vger.kernel.org
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Any news on the HW bug? If not please ping people again or we need to escalate this.
I have shared the latest register dump with the firmware team for 
further analysis.
I will continue to follow up and keep you updated on any findings.

Thanks,
Arun.
>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 6c07cee8e8777..bddecdd64f084 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -190,6 +190,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
>>    * @tmz: if we should setup a TMZ enabled mapping
>>    * @size: in number of bytes to map, out number of bytes mapped
>>    * @addr: resulting address inside the MC address space
>> + * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
>> + *		    needed) or false for a direct address
>>    *
>>    * Setup one of the GART windows to access a specific piece of memory or return
>>    * the physical address for local memory.
>> @@ -199,7 +201,8 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   				 struct ttm_resource *mem,
>>   				 struct amdgpu_res_cursor *mm_cur,
>>   				 unsigned int window,
>> -				 bool tmz, uint64_t *size, uint64_t *addr)
>> +				 bool tmz, uint64_t *size, uint64_t *addr,
>> +				 bool *vm_needs_flush)
>>   {
>>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>>   	unsigned int offset, num_pages, num_dw, num_bytes;
>> @@ -220,9 +223,12 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
>>   		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
>>   			mm_cur->start;
>> +		*vm_needs_flush = false;
>>   		return 0;
>>   	}
>>   
>> +	/* A GART window is programmed below, so its VMID 0 TLB needs a flush */
>> +	*vm_needs_flush = true;
>>   
>>   	/*
>>   	 * If start begins at an offset inside the page, then adjust the size
>> @@ -322,6 +328,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>>   	while (src_mm.remaining) {
>>   		uint64_t from, to, cur_size, tiling_flags;
>>   		uint32_t num_type, data_format, max_com, write_compress_disable;
>> +		bool src_vm_flush, dst_vm_flush;
>>   		struct dma_fence *next;
>>   
>>   		/* Never copy more than 256MiB at once to avoid a timeout */
>> @@ -329,12 +336,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>>   
>>   		/* Map src to window 0 and dst to window 1. */
>>   		r = amdgpu_ttm_map_buffer(entity, src->bo, src->mem, &src_mm,
>> -					  0, tmz, &cur_size, &from);
>> +					  0, tmz, &cur_size, &from, &src_vm_flush);
>>   		if (r)
>>   			goto error;
>>   
>>   		r = amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem, &dst_mm,
>> -					  1, tmz, &cur_size, &to);
>> +					  1, tmz, &cur_size, &to, &dst_vm_flush);
>>   		if (r)
>>   			goto error;
>>   
>> @@ -362,7 +369,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>>   		}
>>   
>>   		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
>> -				       &next, true, copy_flags);
>> +				       &next, src_vm_flush || dst_vm_flush, copy_flags);
>>   		if (r)
>>   			goto error;
>>   
>> @@ -2578,6 +2585,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>   	struct dma_fence *fence = NULL;
>>   	struct amdgpu_res_cursor dst;
>> +	bool vm_needs_flush = false;
>>   	int r;
>>   
>>   	if (!entity)
>> @@ -2599,13 +2607,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   		cur_size = min(dst.size, 256ULL << 20);
>>   
>>   		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &dst,
>> -					  0, false, &cur_size, &to);
>> +					  0, false, &cur_size, &to, &vm_needs_flush);
>>   		if (r)
>>   			goto error;
>>   
>>   		r = amdgpu_ttm_fill_mem(adev, entity,
>>   					0, to, cur_size, resv,
>> -					&next, true, k_job_id);
>> +					&next, vm_needs_flush, k_job_id);
>>   		if (r)
>>   			goto error;
>>   

