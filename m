Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617772;
	b=PsHYFraA8K3JmC7YItnpm9+AzsBweBOnP82XVY8+N0Xdb3UJFpElpaJXII64Q6aoNWAU
	 gb4zHAhfh4f0B1nH9jc/r8BD9gbPGrawjteQ82kXaUNc2yhJRidwW2Y457ybpLR/XpzGp
	 dmz2Xu3jggJ8ANVzEPIjSVnqVpuQEXD80U2+vOhS3bwVofmPCf2eWUQPbHWtCKHIus2Ys
	 ODrmsjG4XPgw/tYLxxN13yC13zB51C3c42EwnU+34SXBb/MZP8dnpzBuziAZn8a3DIFnH
	 sr0pKMHlhUqRmONclEoseVZ9uNL+3CF7iZs9sirN8T/KPGls+LD1JmmAbhZ43NPogXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617772;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=eEksHASZhmi2ifPCrIXC7jHISd0yGjpCfJlRidielrI=;
	b=2UlS7Gm8SZXJDm7VrrTlfg8ebiA/HS8obFdxZ5KJgYGzMCNrvOdcBzT4wp0t5V+xzSre
	 3fJCnMcSYWy5LC6WSaitf7Q4KhutaoLXli9eOBhAi/BrcBAADWmogo6dQ1qDr6GQa2fsG
	 pyYXj1gAtxRCWpkdBzSSRDkKQP3xPd8TN2Dnc6voCLkh9k/V6oodJp3w2gaflQkXhRjEi
	 bavcc6T7ERMJF/SB1yYawrBxzWO5eTamg+VciTfWcn8GD1CE/dnjSO61Ab/1iRndwP7Kj
	 Jug2Hz1D4JerQCm9GFBHOrc5w3kr8ulUkKBRu8dkrpusg5zmOOn1039N15GkwiFFw6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=D5omtltr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.20
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011020.outbound.protection.outlook.com [40.93.194.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020E606A333;
	Mon,  2 Nov 2026 11:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0020E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=D5omtltr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYYhPtJUv+uso7b5qgoQij7BDxcU7xCCb8vC+Lq4Rk5+aZUy8x/H4iBoqOcgdd9/kAfZ3WPjdnuhbA0AmHUUu/8A+4HRNZLXZOFLIYwDP89ue/aODsRQnJwPO3XDw4gqrbGMnvTWvmiEi93GnE8Om6nY7KnwtvOpkCb9dGp4D19wHmC6cyhyxt9WiGrNUC14qrjqm2ejiO34xpjXDqVszgLHxe1TCRJmPZre5iIPtzk0VV/GLVcF5M7YSAcufXv9J56GwVMhTKRZm67EfonU2eA8pkdh2WSW2h/uOSHeAwgu3WqEjyJK8eHd9SXzv0Xw15fOmLyb9OyrZvzdZ7SE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEksHASZhmi2ifPCrIXC7jHISd0yGjpCfJlRidielrI=;
 b=ctv7suudopkDIdZyFA3mF+CwY9jGY+4NIIQyNB9vz0YZ62355iHkzNJcSL3/KdKuDaxf0s7k5FtKCfCpVK2x+j2pERfa19xPDBj13IYJyBxBHPw7171LvxzpiaLRofF61da2cMYf1CyOS/WKaRxVGFk3cfF+BdEloMWpw5zT+L33AxtJKbFHEnxBVfiMixUHkek9uWYO3crqfvYdzGsz7sCH8j+xpUag0XcMC6BkxhPw4l0vy7PYKoyuGS+IBOSvqaj4vuqykymOxIQPZ00qC34t6gw0WBgMv70MZlfqNAM2vpMph7oWgp85wQ//RgZFWVZz9qriaeRBWdz98No69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEksHASZhmi2ifPCrIXC7jHISd0yGjpCfJlRidielrI=;
 b=D5omtltrsTJJTMKAfI1g9+f68zecFcHHAQUKu/1iwVvvNsmfiI5CausIxOqgws78jkCNJ9u9muMAIkZMT3RCPR8aK5w9euknb7TvztnxCmpLkWJ5+ea7qCwEkbQhnDjXuDjblu5EiyVBcKqNVlMQQXXo+tY2x8MZimEbtrZD1BM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 2 Nov
 2026 11:09:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 11:09:28 +0000
Message-ID: <a10ab532-1e9e-4a85-a79e-b712868889c8@amd.com>
Date: Mon, 2 Nov 2026 12:09:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: system_heap: Reject private mappings in
 system_heap_mmap()
To: "T.J. Mercier" <tjmercier@google.com>,
 Chris Wiseman <chriswiseman@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: John Stultz <jstultz@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, Philipp Stanner <phasta@kernel.org>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <18e3697ad6321d35.3137322e32332e3235332e313736.e98e6.0000sendgmr@google.com>
 <CABdmKX0YRmr0ovk7teNQdXdLmC2LKruT59EQarpDMFcxoOFcQg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABdmKX0YRmr0ovk7teNQdXdLmC2LKruT59EQarpDMFcxoOFcQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0174.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d1ccca-abca-40b9-ecc3-08df38d1c33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|261026140227099003|18002099003|22082099003|10067099003|261028144727099003|4143699003|11063799006|261022105027099003|261021121427099003|56012099006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	nQ5gj8CMbyqcuFZsPeA7BJpFlDQQWKwCMyXyjfossXXldHWUwNYYPoBww90TnwiVvoJ4ZNB0jE3vuVZwOjCHpdB7QiMhWD2/LPSWwd4Na5sK7PkPHFXBVaLQqB56KEbkwUesz1GjfIdlSHoKQgwaOf9saRym0qCkxQQYMltlMzdX2Hnu03mlpf7pww2h3lmX1zZnFKtl3mUfzvOz5NaxbfW6whfpyae5xRx08paBTtrJwKKoVihuqB9acqzsz+r9JZoVXpY35OumDS8rdaUOT5rw5ymWElH8NroXHqOYXOn0j53IryfS8NRuDfyMSlI3Jj7fflYf1C+ZhPopJY6dYtL7QPa2yOmsAobN4DEqeLHBXNyHaYSf/zR1W/U7lcsgUWOv5tDkCECRWnrwEcrTKKYHt9wXGRegNEJVAsiS+0q2yjVRQI0cP6olmMaPxeuIVVdTnO5wlEimdgGLDz1mvtv7GECc7xod4LH3/n8CISulH7J3bTwC8daDSq1oMOJFQD+SqMBZEF5lQr54v9SglrpYrYJUqbZNC6nTOI2hAcb9QL2mUNXrolGFu1Cl8SoUSPzxc1efdBL6jCeNxgzVoSF8eKqgXFRVReZ4EZwlpFwCFmXsWbismvfQXHSMY2OQ+c9QiR4Goi2RRiAe2xylYkgD5xUJ+IKIsA8pFWnLnvo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261026140227099003)(18002099003)(22082099003)(10067099003)(261028144727099003)(4143699003)(11063799006)(261022105027099003)(261021121427099003)(56012099006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjZ3V0xvOWw0YTZwYnZzOVNZRzRieXlWM1VaMWh0eDZtVEpzOWRvcks2akVU?=
 =?utf-8?B?UnlZVVd4MThXVHBPRnhvNzA4RldEV21tbHBqTFB6NkJPRXYyVDJENzhtTkhG?=
 =?utf-8?B?Qjd5NEZybmVWNkNMbXZZNmJIT3ZZVjRTYktaRk9ub3RkN0t0S0dCYmY0RVA5?=
 =?utf-8?B?KzJ3Z05rTU5HNEVBZFdkS2NsdXU1ak9NZ2ZSeEkxOWY3WHQ2MFVEcUlWYlYr?=
 =?utf-8?B?alkzdFpyUGZoVTFDbVNOS3NXb000U1hFVHJ2V1AxeDdoa0U4bFAyOUZRbHVC?=
 =?utf-8?B?R2ZXZGhTQ0RDVlBtY2NYNEduVW9xYjZwWXZycGtxTis2ZzFheVJSNVd5K1F0?=
 =?utf-8?B?dXM1UWppelpYME9FQnF1WTA4MTlhd0dtSDlZUTY3S0pvZXNPNXh0UEY3N1dP?=
 =?utf-8?B?dlZJQXBBUWc2Y2lya2ZMYWVtbFhQelk2blZwYTJ2VkJUc0tITFN6elRjSlg0?=
 =?utf-8?B?NHN0UnllRTJYNmZCelljMTgxNThwRnQrUlpvUlUyTVVUK2VELzRLOStpRFFL?=
 =?utf-8?B?Z0NvQVJYZ2pQNG8rYnhOcUJ3c0VJR2RRRmFGMTBJcksrYTYvVGQvT3FkUGUy?=
 =?utf-8?B?a0JsMmE4MWt6MW0xUjlNVWg5OENBTjREY2N0Ykd1N3doSENLUWZTdU1KeHV1?=
 =?utf-8?B?K21BWVF0QnJIMVUxWjltWnJ3UVdYbDZNbzQ5aklmbHI4dVUwbDN5WU43eEdn?=
 =?utf-8?B?VmVLOXk3ME5mQ2RXbTJUNlVPazEwRVM5bW4vTGEvSjhYeVpEWFNBcXlLT3BV?=
 =?utf-8?B?WnBKWm9pbkw2ZStKcHJWZlF3Wk5lNDg5MWpoazhqdHVxQ3lLcXZFN2tVaC9R?=
 =?utf-8?B?NnptRUZXTGNkdFVWOEwrV0RtbXRqbnBYVDhXLzJtRlpWNWVYc1pKRVYxUXVj?=
 =?utf-8?B?UTBzdkJOckFvS1pQNENwWWtGc1RTYXh3QU8vblFsWFY3eGRRYXluSmV6WWdh?=
 =?utf-8?B?aUZhZUpodnE0MnJ3d2F2UDlzYXNYaWd1eEtlQ3QvL1FqV3VxS3k5QVd6MWd2?=
 =?utf-8?B?ZS9jeUNkMHZIa3BRdEFieHE4elhESW9ZNm9ZWVFCSGxGelJwelY4WExMdjlq?=
 =?utf-8?B?OC9zejk0R1hLRXFNRmNsT3JRWSttZFJtOWVtT0VzREw1OS9RaU5BM25Bd2do?=
 =?utf-8?B?ck1JVEhUL3d1aitQUjU1T05RTXkvaVFaSjhzR2pNanhxZDhRamhLOE9NbmxC?=
 =?utf-8?B?b3NCVks4Z2haTjhMbDQ5TG4rbWJUQmpWTUhOdmttckI1MDRUbTNQTUhVV1Y3?=
 =?utf-8?B?WTV4WGJ0bjVqanhpbEZXdTZHS1ByT1Fnc0c2Qk1ZOWYzM2p2Njhwem5qbFRP?=
 =?utf-8?B?blNUQjh6TjAzOUNWOG5BaTU1TDNYU2dGOGxYTmVIbDRlMEt5M0x4S3RFTEc2?=
 =?utf-8?B?eU1TeEI0ODliN0g0eW4ydmdub0lIYkZrMkROZ2ZNYXZFcWw0azBNc2FHWWlS?=
 =?utf-8?B?ckxxSlo0MnZaa05qdWVaZHk1MEM3YjJDcm1sMldUUHZlZjA1K2tlNlBWN0Q2?=
 =?utf-8?B?QkJiSHA4VkVrWms5VzlOR0Q0QklZNk4zYnArK09oalBNNGxXVGRrNjIyZ1dx?=
 =?utf-8?B?L0hUbHpWaTJyK3IwTmw0dlExQzliVytVbXdEalJ6UDJFbkdWMXBsS1M2aTlP?=
 =?utf-8?B?NFJIYXhQR0EvMUxGKzB3WkFMRlkyakdndTdTdTdZdXNJQ2hjSk5KMC90QWtK?=
 =?utf-8?B?TlJRWTdWUSt0ZnZmZjlhYmorS3hFbHBCKzdhMmsvTVRxQ3B4TEYvd2dHb3pE?=
 =?utf-8?B?b2Q4c0hQRkJ0NHdXVVJtck5SK1NGY1QySHdVYnRYYVI2enFlU3hnWTRIazVh?=
 =?utf-8?B?SFV2b1p5WGZCSC9DQTEydDJncDRjWkFDcGhmWlNXVVBTS0hSdk1ta28vdita?=
 =?utf-8?B?dEtpY3hGdTNWYnI3c0VEQVZQMTdJYTN4MVBBODlLWmVFcE80QUJlblpZc01D?=
 =?utf-8?B?UW1kM05XR1BTRVArVzVjSXVvanMvanhPRWk3MTB1ZjEzejVxcHlqMWQ1a2Ft?=
 =?utf-8?B?Ny80SDYxQm5vam9PWEZIeXlQV3NvUlFBaFFmNWRnb2tQTFIxTTQrWVZPejZV?=
 =?utf-8?B?SWt4YjhXa2tkbUYzUTFTY0lDZWlSMkZ0RFd0NmRIZjhOQXlLZHNwVjJySUtT?=
 =?utf-8?B?UGovQmRGbkFBamFMQkFHWHd0TC9jVkJwUXFIU3hyS1RPLzdjMmx5UStjb042?=
 =?utf-8?B?K3Q2SXdOZ0d5NWt3K05rUkJkSG5wUnBzcWFEc1c3S2pQSWZ2c1lnNzRCd0Jp?=
 =?utf-8?B?aVgzT1pzR21ZbFFsWDhOQnN3Rm0zUWZzUzl3TStXS0dnT3pqVWtiK2d4L3h5?=
 =?utf-8?Q?uXQadAi9pK4ahCKmko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d1ccca-abca-40b9-ecc3-08df38d1c33e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 11:09:28.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi0Bze0c6AmLcopswZfABFM0+jGj/Hjpg1dKglO/kfihHyYVaDKWh+vhsODL5aOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114

On 10/31/26 02:44, T.J. Mercier wrote:
> On Fri, Oct 30, 2026 at 1:44 PM Chris Wiseman <chriswiseman@google.com> wrote:
>>
>> When commit 381295758792 ("dma-buf: system_heap: Rework system heap to
>> use sgtables instead of pagelists") stopped using heap_helpers.c and
>> added a custom system_heap_mmap(), the check rejecting private mappings
>> was dropped.
>>
>> Other exporters and buffer allocators reject private or copy-on-write
>> mappings in their mmap handlers: cma_heap_mmap() and mmap_udmabuf()
>> check that VM_SHARED or VM_MAYSHARE is set, and drm_gem_shmem_mmap()
>> and ttm_bo_mmap_obj() reject vma_is_cow_mapping(vma).
>>
>> However, system_heap_mmap() omits this check and calls remap_pfn_range()
>> even when userspace requests MAP_PRIVATE with PROT_WRITE. As a result,
>> subsequent CPU writes to a MAP_PRIVATE mapping of a system heap buffer
>> fault into do_wp_page() -> wp_page_copy(), silently allocating private
>> anonymous copy-on-write pages whose writes never reach the underlying
>> system heap buffer pages.
>>
>> Reject non-shared mappings in system_heap_mmap() with -EINVAL to match
>> cma_heap_mmap() and mmap_udmabuf().
>>
>> Fixes: 381295758792 ("dma-buf: system_heap: Rework system heap to use sgtables instead of pagelists")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Wiseman <chriswiseman@google.com>
> 
> Reviewed-by: T.J. Mercier <tjmercier@google.com>
> 
> I wonder if we should have this in dma_buf_mmap_internal() though. Any
> thoughts Sumit or Christian?

I do remember that this was once already discussed with Simona and a couple of others, but I don't remember what the outcome was.

On the other hand I can't think of a reason why anybody would want a private mapping with DMA-buf copy on write clearly won't work. Maybe for backward compatibility with broken userspace, not for a real use case.

I would say let's push this patch to drm-misc-fixes and apply another patch to drm-misc-next to enforce this for all DMA-bufs and see if anybody complains that this breaks userspace.

Should I push it to drm-misc-fixes or want somebody else take that?

Regards,
Christian.
