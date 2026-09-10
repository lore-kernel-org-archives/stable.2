Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC03DC4BD
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789032458; cv=fail; b=OhSq8gIqdOjG75/scCHLggjN3kXkfxHhbG9pA/hJpsgF0awwPAk+pxFShNxdJe0iPaAETEfXvIfKZ945BZXE/BiW2R8NHuTk96DMxRPipx2J52UJ3NL6RfhEpULdWN9hjuid04LXlz8WXsN69NJ/r3/azGRgL9z7VE8mDqsNCvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789032458; c=relaxed/simple;
	bh=TCPXrlnUniMnxFBNUEK3QGmxToto4YVMG3Xl+Csjqv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aKZZo3fDgy8TTD9zPX/fWEPlvGjiTDnwXte4IPLSwijzZpG+a5/C4FsGY0TyrxXAQCuWEu7vxSRaEehG/JYGlcX2d6ND2XOsKmgZolokSoiHo8f52aqPqXkG85CYV7OwaScDRVu01xW6mGlES6igswfMj8oTnh9kIeyg5Z0429k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sU9QsBvI; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sU9QsBvI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWi1qrNLB9oKBj4eslHpdyJngRi/6+xPM6wqK/6ashBEVUWGaiGYZnvCkDRc1bIRhaytx+qZmdhVKQ0WlWtLp6d7KfN8obxapEvabhc5ChjJRWIdoCEQ7mHYbAFsnbdA0O9FRsBGLhvGV7x8pjqoQ0o/QZ1fS/34D16H+0QmoUwRJz0EgtI5K//ZuTd2FLvBn9gsALK5z3yuh1Gn1qhNGd6sSqt5/a29C/1anwtChhWlSGHWYvD2FACYrmoxYNK+/oJbJ6q8Lf0nOst0dyEhEjP54bbXh0kYoSsa3PtlJljhhC59a1ulLGwKk1q4/VAoqG2Q4fTmigTYcfp9vL2H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6DaVCrxruT3b4V8RWlYmVYqwb6QbLOXCE4eZX7qN8A=;
 b=P+fAufi85PaRCa+E0Unt6C53zJ1GSqAkxi7OqWD0dBQoMsmSF7RzUoVw+P5MerGEEhZEcK+zxmGBUhyRaaZdjFgTNkviuHMHzI82xtTWHyjDEOG/BmYRKh0+gDJG3Svell2+lXmEqd8RY4/q9pxSDOyxifs0FlWreruuMd5YDh3Y7HZye3B7VJpo5UEJ+YCRcUWVpZDAz09YgxML6UqWFh1YjuEwBtU4kYWL6QQiFbLF1kzBM7isLqShReQwOuRah5CrbzvDaFcRx5HK+WDYtez0/fNwSLvqVuwN2NdmQfp+r2ez9yU/cBDoiy03jN8h5thM5vIPAUnAjK0WBuLB6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6DaVCrxruT3b4V8RWlYmVYqwb6QbLOXCE4eZX7qN8A=;
 b=sU9QsBvI+Kr82RX+1iKPMrHy7r583t7ENfqoHQSHspgV7f77WgXrXqptqWZQqRdvDSg1z9EuREs4jnC2EOjnEX41nOaei7gKP7Mm6VSJJAC+drocR2IQqOB5KT8xMIr4HG8D4YjRtn349GoR2kECNkuQX1NrEBk9LjWCbTq0KYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SAWPR12MB999270.namprd12.prod.outlook.com (2603:10b6:806:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 09:27:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 09:27:34 +0000
Message-ID: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
Date: Thu, 10 Sep 2026 11:27:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: don't migrate a dma-buf into VRAM while
 runtime suspended
To: Mike Lothian <mike@fireburn.co.uk>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20260909020854.58462-1-mike@fireburn.co.uk>
 <20260909094609.1541-1-mike@fireburn.co.uk>
 <e63d8ae9-f102-424f-88a5-0fd6837d79d4@amd.com>
 <CAHbf0-HAGCLcH2ryR6dgaTwMEjOgqbFFnzMUge-s1LZtjTohjA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHbf0-HAGCLcH2ryR6dgaTwMEjOgqbFFnzMUge-s1LZtjTohjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SAWPR12MB999270:EE_
X-MS-Office365-Filtering-Correlation-Id: adae0baf-cd6c-43f5-aa3a-08df0f1dbefa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	H1dOvQZMNjcnN5PmR36ato2wsFFY4FbnN4i5rN6L8O2tRFC7g6ytuqfzwLa6ddQTCmKn1pOev87LYC/CT923AUnU6DqE9LOA8GEPK2CHcIPyhX2QPtFcKtHuJQS4ZrTJ5iOfa6t58Xfm7MHTT2L9sN7PC08f2zov+l/MUXs3iVvAR675Tw0R0CMdM4O8BGE0nBSEdae4AKu7aj1fKKGy76RSVF/R56NqDXeuAoSCT44meCBOk8Off3/fjvv/TJ9P+UnqXzKcERbpcTgFiiWtANjF+tEg38lJVQZTUN4lFKKSlUWPHV+J/gX+AVfszPP6qzQK157FwCMC474E6aBvO/zrmGuK/SCV7mb4HfCvvCooTOMdABblT5/j91fzOnqz07bhAefY7OBhxTvdU6IT7IgqUw6Agp9Fh7T9n8Jlrgm8EZRx0Hq+srkkFFGo5y8bH+l1kdqGM4T17wc12W8++wGYjE4YpMEolCI7Ztu/oBPLr/CIjrH+9XW6g04zgj5oYdectbW2DQOXBh6Z/btUTg7pKAe7fTx9VSiIzJDi4N7Pr2zaRvIVsWc52Lbou8H4ah9OzyVaq03Ta6fEOgR2IIi67F+ithA1a2RAGpjDhQiYALwvLWiN/x5MRZj/heQpB+euU6O5kDyWr2/zKiFU7E0odVBOs57GIdSr/N/Z0Nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlNNV1pvTSs4VzhXSXREZW9DMnY2L1FldVVlNzFQZUNJR3d5cXdiZjJWcUt5?=
 =?utf-8?B?d3NybTdaN2pMenpPcGgrYmF5Rk1yQWhnTXd6ODFpZDJOdWxjMW9jL2FpWlZx?=
 =?utf-8?B?Z2RsTkJuUDdwVGxTTTAxVi9rV1FGQjVaWDJtV0NBeS9iTDN4RnNYT2x0cURY?=
 =?utf-8?B?dkljN3NId0kyUUtQQ3g2cVVhckpub0g5blZTRlRNcW9tZXp3L2NySjBScEt3?=
 =?utf-8?B?VHpESlRBaDhYQXJFY1paa1k3Zyt5dXMyRUZjMDByRHZ6cnFOckNwZmIrMmdG?=
 =?utf-8?B?V1dZTUhlNm1sY1RJZTA0U09HV0xqL3hFenNHTERjbkZXaHlxbVg2NDdVdEtC?=
 =?utf-8?B?eUowcURoTUI0SG01ODFDa0VtMWQvL3RhVHl3OXVWTUVkNlQ4N3F3d280OGds?=
 =?utf-8?B?R0NQMThmWmhRNDEzSHZtVHN6bm1qUHBRTnJNdDRWSHJQUnJGR25JK0ZHZjFI?=
 =?utf-8?B?cFVXUUpETTlZZkxFNlBGajF0dkJsSXJGTCt2bXhaV2dNaHVUV3FxWWJubjJ1?=
 =?utf-8?B?NTFZU2ZzMDZIa1pHbStSbVRPcWJ2Qml4SFRzYTZsaGNrcEtQMXE5dkJid0Jv?=
 =?utf-8?B?VVg0RHZwTzNBSDRRVHNMV0xST1NuZEc2MDNoSWhuaWhITkZZVVYwVWFVYkRp?=
 =?utf-8?B?M0FyVXhyQVA0amFxWkVVU1BURWdxV2hTR25aVWpYQ1ZPQlVxcWRzajhjZFNy?=
 =?utf-8?B?RlJtNTlTei8zRWJ2b0h1aFRFdnNiWTduVG1uSTM0cG94aVJrTjFMOXM1SGxL?=
 =?utf-8?B?Tm5mWUk0Q3ErWm5zQnlhS2w1Q3lMN0Z5RFFwMU5zQWRqWlpGeUIzOWNBM3hI?=
 =?utf-8?B?ejIrcEo3T1dRa3dyczFEdURLSEY5SVRhVW9IYjcwNnV0ZEQ2Mm96OU16OCtG?=
 =?utf-8?B?V1lOakZQVy96aStkekh5bVBIV1ZwNGhmcDNGSGRqbnF1ZXkxVllUTzQ2NEZK?=
 =?utf-8?B?Vk9IblRpNWFJb1hORVgvcW5zUm9KV2FCWWRLQjNyNHh1Q0grTEFFUXJQRS80?=
 =?utf-8?B?RHV3SHNQcCs5SHBlU1ZOVExseE5ScHU2eGo1UktwQlEvZTBpNkYyN2s2eFAy?=
 =?utf-8?B?V29RRCtXc05mSnFsYUw2c2w1UGRxcmJaYVJCOHVMTUxXdzJxUnVEZmNpbnlN?=
 =?utf-8?B?TUh3WmpXYTg4NGJIQUNSd2hhcnlQcVA5ekU3L1hlSWFpMDFSY0ttaklwdHEr?=
 =?utf-8?B?eUxtdXNHcUJrMVNESExRL0VBRmlFcW4rcllXQzJFNW9TY3Z0S2FxMjQ5ZXZ3?=
 =?utf-8?B?dWRnQkdVME5qSiszZE1ubldGT0FJSytUSXIxM2JZaGlEUDRaQWRYVFZUTXZq?=
 =?utf-8?B?ZUlPdFdOK29QRGtDckFxTzM0SzE3Y1pnMEJtZ2RlRVVYQisrN3Y1aWF0ejQw?=
 =?utf-8?B?elJnWWhwaWZ0WStEckU1N3dkWEd6WXNJME1KSmJlaWpWV001b3hnUFNKVlV2?=
 =?utf-8?B?QkhqcWZlZHVOZnAyN2daRXNFTXdwSW5pUEI4Q0Q4K0lpUkM0Q0ZVWXdjcGUw?=
 =?utf-8?B?Y2d2SUlkKy92cW81a2lNdWd1SlRkTkNsQ0EvWHNSREQxbmVCQURmYnErVlRR?=
 =?utf-8?B?U0xBMUR4QktnYmVuOUZkdUVJZ2hsY1JHVnpzVGZEMzBUU0VpdFkzV3hNMEhm?=
 =?utf-8?B?ZTZTNEZ1ZnFWenhJWitTYXZvaWpkSFh0RFpmMjdpNmVWVVBtNGVFcVoyeExW?=
 =?utf-8?B?ZHBzWTdSNHJwUUVwVGRZeUdDWmVOaUFsUWY0TkZvNHoyUXpPc3Uxa3NpUWYy?=
 =?utf-8?B?ZUFjdVBuMW5lZGc5bUtlNEFWeXF5UDRRS2M5OWVyWkM2NHErZVd4SWJGUWp4?=
 =?utf-8?B?aTBWMXYyS1locS9yMEw3WUh0TThUK3VkVi9FUEh4bDlTWWV0RnR6VGlnL01t?=
 =?utf-8?B?RThJM21oaEVVb2NMUTR5SjRFV3E5WERVQTZvUTdldXVQZGtaQ2F2ZDhVQ1Fm?=
 =?utf-8?B?YVlLTWUxdU52M01aRVFZUXh1b05LZ3docUtFc3U5T1VQb3BIOXQ1b3NHd05r?=
 =?utf-8?B?RUxmMjUzVTk0bDU0emxja3JpTlFOQ3dHcVU2Y1A4VlFibWpEUTJySzdjNVFR?=
 =?utf-8?B?VmN1V2c2dEpqUEk2dHlBaXFTSzBuNlJ6cDNncElzd0RUam9jWjdJajdxdGRU?=
 =?utf-8?B?SE9JaXdadmg1MU1XdnZRR1FTdWpEVVdWc3ZsNXFPdnpXVGZKMktUcGNWTjNB?=
 =?utf-8?B?M1FWVjhUeE52Y2NHOWlWOFpsa1o5eUpHQjc3bmMyc1V4OTJ2VXFwbEEyTE42?=
 =?utf-8?B?cnNXWXBlWVcwcHdEc3pBNlI5cGFkTGtUYkpMMDU2U1JDTU04NGFVYnpvNXNz?=
 =?utf-8?Q?sOd3A/Tr/d5lSqjakr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adae0baf-cd6c-43f5-aa3a-08df0f1dbefa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 09:27:34.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVmVPKx1O15MtqYJdnGbKCMZreHoiB14Wizikdl2KkWcz3gUGXjCXM7Na98y2YbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999270

On 9/10/26 02:15, Mike Lothian wrote:
> On Wed, 9 Sept 2026 at 13:46, Christian König <christian.koenig@amd.com> wrote:
...
>> That sounds like there is also a bug in kwin as well.
>>
>> The GPU can only go into suspend when the rendering application closes it driver connection and that usually only happens when it terminates
> 
> Not any more. amdgpu_driver_open_kms() does pm_runtime_get_sync() on
> entry and pm_runtime_put_autosuspend() at the pm_put: label on every
> path including success, so an open fd holds no reference.
> amdgpu_driver_postclose_kms() is the same shape. I see the dGPU
> autosuspend with the client's render node still open
> 
>> So question is here why is kwin still having that imported DMA-buf as necessary resource for the rendering?
> 
> Because it is the content of a mapped window. kwin composites on the
> APU and samples the buffer the client rendered on the dGPU. In 6.7.5
> EglDisplay::importBufferAsImage() (src/opengl/egldisplay.cpp:395)
> caches the EGLImage per GraphicsBuffer and drops it when the buffer is
> destroyed, so the attach happens once, not per frame. The client can
> then idle for minutes with the window still on screen

Ah, yes that starts to make more sense now. I was really wondering how this was reproduced.

>>>               if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
>>>                   attach->peer2peer) {
>>> -                     bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>> -                     domains |= AMDGPU_GEM_DOMAIN_VRAM;
>>> +                     /*
>>> +                      * Only migrate into VRAM while the exporter is held
>>> +                      * awake.  A negative return means runtime PM is
>>> +                      * disabled, so it cannot suspend either.
>>> +                      */
>>
>> Setting AMDGPU_GEM_DOMAIN_VRAM doesn't automatically migrate the BO, it just sets this as possible placement.
> 
> Not on this path. amdgpu_bo_placement_from_domain() marks GTT
> TTM_PL_FLAG_FALLBACK when preferred_domains has VRAM and we are not an
> APU, which is exactly when amdgpu_dma_buf_map() adds VRAM.
> ttm_resource_compatible() skips fallback placements when not evicting,
> so a BO in GTT is not compatible and ttm_bo_validate() migrates it

Good point as well, yes. That is for optimizing placements for BOs which have both VRAM|GTT set in their preferred domains.

> A WARN_ONCE on the failing branch gives old=TTM_PL_TT new=TTM_PL_VRAM
> with amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move in the
> backtrace
> 
>> BO migration is only triggered if the BO is swapped out or similar. What most likely happens instead is that we suspend while something is still ongoing.
>>
>> But anyway the problem goes deeper than just the amdgpu_dma_buf_map() callback.
>>
>> We have picked up pinning DMA-buf to VRAM for RDMA without ODP (e.g. exactly the feature I mention in the commit message of c52feb436539), but failed to correctly fix the PM handling.
>>
>> So we really need to call pm_runtime_get_if_active() in amdgpu_dma_buf_attach() and fail to let some other driver attach if the device is already suspended.
> 
> Happy to do that. Which behaviour do you want when it returns 0?

Oh, well that is a really good question.

> Failing the attach breaks render offload. The attachment lives as long
> as the buffer, so a client allocating a new one while the dGPU is idle
> gets a failed import and kwin has no texture for that window
> 
> Holding the reference until detach keeps offload working, but pins the
> dGPU awake for as long as any of its buffers are imported, which in
> practice is the whole session

Ideally we would want to grab the PM reference during operations like pin, map, etc.. *and* keep it alive as long as those data access paths can't be reverted by an invalidation notification.

But what makes it additionally complicated is that we hold locks in those operations which are also needed during suspend/resume, so we can't wait for resume to finish because that would deadlock.

So in practice that is most likely horrible complicate and error prone. And my educated guess is that it is also probably overkill.

For now I think we should use this instead:

In amdgpu_dma_buf_attach() when pm_runtime_get_if_active() fails we just set attach->peer2peer = false.

And then add a matching amdgpu_dma_buf_detach() to drop the reference again when attach->peer2peer is true.

Regards,
Christian.


 

> 
> Note the importer here is amdgpu on both ends, so "some other driver"
> would not cover this case
> 
> Cheers
> 
> Mike
> 
>> Regards,
>> Christian.
>>
>>> +                     pm_ref = pm_runtime_get_if_active(adev_to_drm(adev)->dev);
>>> +                     if (pm_ref) {
>>> +                             bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>>> +                             domains |= AMDGPU_GEM_DOMAIN_VRAM;
>>> +                     }
>>>               }
>>>               amdgpu_bo_placement_from_domain(bo, domains);
>>>               r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>> +             if (pm_ref > 0)
>>> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>               if (r)
>>>                       return ERR_PTR(r);
>>>       }
>>

