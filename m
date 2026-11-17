Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794927329;
	b=uE/BFvobsEsFt2qywlBtWfF/TZFns2bDDr3Jy6N6Rvws5w5hAiU6v6qWcE99b/+W6zhw
	 3rRFNL7K1wqKmqI/s/STrrmOtb+h9lBuynN4PNZOIOll28rI5+E+WijC20OaasEOAvpLS
	 g3QQxqHx2s2hC/z6F6rsbJGcpjRo1I7OwMiQ7acrfzggPt6IBXFb6RMJST11zVyly/bqD
	 fpEoKZt6ZHZp+ZSr8IF4maz5q9RG1eapHbCjhW11bQ3/kTWj48SFNZs1zeWiCBxvXNHjZ
	 txJOEozyVb1y+WNYNShitPgRy5ejOn5zRa2Zr3H3HQYHyQ+gweT1oMx5XuXnPrar3gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927329;
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
	bh=fsboG2mhQ8Bs8gKCnM/fcad38tCKQhkoW7tEGPb1fzo=;
	b=H/i8DZfGtNTOfDvbzhYofKVegMsHTyRdQShJJ5+B1TmfNJ0SX+zsJDSDSqoAD8nv2in4
	 XbHSTax1V50p6dwu+o7UL620xjFQXEbZKL4bjO3IyRZIVsHlm4UMKfidrAtVDm6l7YnGA
	 1blJRz0EPqbH+tfS4farWWahZZZjkGjVBF+XquV/Ts9ybr+eT5ZxYtl32GV/4grn/sNvF
	 P5U9sB2FnkunRdaAyDsGJnxyOPajwj9y9aWm81QdisJzu7FEuX4QDbUk2fqTIuC2pCm+o
	 x1JQb+R+jp0RsbcGK5PeSrpB06myc2EOcXR48odntdUwwmkLoLJ66dvIvliKo+WSC9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c3kTp4Nc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.51
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159D606A32A;
	Tue, 17 Nov 2026 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F159D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c3kTp4Nc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2+Ny66FRkrWBF9e7iaePzUaNWpWpPqtFVLc+A3qQcIeuSvnruye5rc3P0WpKrne+cHOZ1SP9dIjOhMZ1lF5Yio3DM3mwGmwOh8oipsV1O7e3+dphlkDp+VmcyhUqZKvPrg06uZE5c4CINk66I8qxrKq7x6BGdhVzS/U6uiV+WzYB+TbygFM8FHS69LK3eHBAfUvxBjooayCWZVklkcrqIRyN0rsKlQLu477GeN9nocOQStfKUE3eDRrhORDZx8Dd/96/kAqKZEyf/ZzCZzjIQbVZbosU7K7yRSsSosWAq6YA1p8cZ/DMCSaLbHMD221ZoqnhNURoPbl6qIiWBpjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsboG2mhQ8Bs8gKCnM/fcad38tCKQhkoW7tEGPb1fzo=;
 b=zILwNiaKV3GTRmRieHt85a1Z8WxHiq+1sekCRUmt/Vfw6cEQ1ITQhPxQVldC5DRQyK125UYZWYx+IXSFcqTUlKCfFZDdGbvcgrNkg2dZo4qWzT3lmD4WY1BK07I5Yr8eN+pdWeWj9GLsFefD9vd20tRJ3qQKlwkhalo2yqRJ7LMGt7bQpp4VqYMBE2izZiekfGt7FYoCLnc+Z2rSXDGGJswwMU/a8OFzu5basmzjiejPiRH9KZrkGXdYJV5AgJIkk0Sf97lhGyzUJiKCANtwXfcQ3xn2dUKTuKhGJfAYejI6/kpaCGuC4HJ7NJ+3vUq2klI/IfyskIQ/QhuWiHkq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsboG2mhQ8Bs8gKCnM/fcad38tCKQhkoW7tEGPb1fzo=;
 b=c3kTp4NcCmL+k5juXel3URtGHJ11vh1JlYnxc4oxNEPWtkTlPWCXmTZMYKeIO6jpUIr7gACKObTpWa7IIs01OQSke9dRL2evDuXe51HgBH73hElikGYsLfb33wjxMbwi73j5t9JA4RZYVFVgcON+n+kbSprY43gVWxFkbf88TTE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:55:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 14:55:24 +0000
Message-ID: <efce5fe0-6e7d-417c-93a3-35247b431448@amd.com>
Date: Tue, 17 Nov 2026 15:55:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Prevent misordering for error checks
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117090144.581909-2-phasta@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261117090144.581909-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: a9717fbd-cf72-426f-2dd7-08df44bacf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|18002099003|22082099003|261009223027099003|11063799006|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3AIaR8n8DjXJtpdw7nEFf+/PEXcaeNiqi4aw/lP3xHr1ldcURnzgvVOS/Hc3zDaZTwPkaN6aSXqTTmFGGaWoqLfLdR4Xz8TQetkP2UDhIJ2PaN6LUGaekaWwplw5486bW2dWrw7xiYQrwegdyz2zcEBg0IEtyledlM/goVDWxC6pHJSU23GT0fnNuvilFAQoEXcvxDT9eNvIlSrElZm9LuL3IiDUiaBkWQj2X7eguAoNx0El7qTriTnoNpfQBj5KjIBMoInUqYyb2HE2s+jEawwWsM2SD34bMmXw5XIi/kkaoxmF/ACJHTNWGKIVuSZPgqKR5+z6jF/BBYpOUuNnzIdfY7kqkijq5Znatqq3gTV8wNPfmh1nxye6UjynYbkq11Fpdy0pSUwNDu7G6LS/ctvm7NJiqBRSlyr849nC4l4qYV1f3hN1X46k7dxYWpAgHr0ffV75k+CyEXrSxlbWINccMvMSPNLvlx3/j7UTlSDMs5AOhsA65C0latLzKSP8pJ94UP17QaBd4yPCIrb6gMtypSpxAtUrPfte8UgOeq6t+65k4E5ss/RcOzdVuxG6hWCt1is3DyMqT4nvcvF2Gm5gd4uOpgVu3wqaQdxQNiR2t2Htiyd6EHh7uJbjTAnFOkNOWnpy0XwydhxLQhuPJnJObTs1mtCvVvAhICNrDh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0x2WnBoaG5jVklDUmR4VEZhTFdLdEdTa3c1cyt3SkZ2RjI0LzRqYkxlcENE?=
 =?utf-8?B?cUxrU1dXUUlLTWFmTjlPMjA2WWM1Rk9yZHNaMFZrS1FiR0ExWHRmdm9oVC9U?=
 =?utf-8?B?Qlg1eGN5c1dsYUxFeFAwWTlHejBtUWJ6dGhOWm5PNzREWmVPbEY5bzVHNjFt?=
 =?utf-8?B?SU9PaVNiRVVhWS9jb2FMTEwyMWlJK3hpTlhGZkV1bmJJcFBDUFNuQ2xPTWVu?=
 =?utf-8?B?c2VpY2FTTVVaTld0Tlk0NUNLQkhjb0gzSnNWSlk0VW1WSUhYdG9rUUZ2Q3Ja?=
 =?utf-8?B?QWVoaFNkTERVdHpuUEZQc08rZ0MzUkhmcEl1V3NZcldTRVQwUFBaNUNCaHRm?=
 =?utf-8?B?elB6Y0tYak0vZHFYK1U4bVkwc3greWNPUmtJY1B6TXVQaHIwS0x6bjFzMnZ6?=
 =?utf-8?B?dWR1N0pxMHNETGx6eXRIRm1wMVZwcnE3SSt5VDRaYlRXTVM3RDBEQUd0MmdS?=
 =?utf-8?B?Ykk4S3lJSXUrN3VsV2ZhaGFSUkJMK3cwaU9hOVVYS1FzcWFPRlM0cERQangv?=
 =?utf-8?B?NlNUaWNCblhWMEVFUWJIWnVtdXdWS2lCODhGeXQ0d3hORlpGYlQ3WUFJYXBu?=
 =?utf-8?B?a1cvbXc0c0g2aGgvNnY1VlhWdUcxUTVKWmdsMS9hOERCVnZPRFowNXpVcHJN?=
 =?utf-8?B?eSt3RWRPaXc2ZU1WSjhKUGdxUTJlWG9CcWpPWDJSRG52dXlBQjYrN0JoMnNn?=
 =?utf-8?B?OXhEd1ZTQStLRERMR0dzMkphZUZzUXhwVVRRSXR3WlBuVk1raTJRS2swMVQy?=
 =?utf-8?B?bWF4cXFUL1k0RjdydVY4Z2JENEl2NlFYYmo3RklPY1h1b2orVWJSaTBTS240?=
 =?utf-8?B?OEtvSks3emZQSVJNemllVnk1dVRzSjMrUXowdUd3V2FxUVVSREZyUHBmOU9m?=
 =?utf-8?B?b3NpSnJ1bXlya3lBaTRwaWgxa1JhZWxUemFEU3owaGF3MXFzRFE1UTBvdHpI?=
 =?utf-8?B?eFlENUZlYUpjU09iOXBJTS8zTlpVeUwyLzFBQjlIWXhRcGk3S1ZxemxKRUV3?=
 =?utf-8?B?dkJmYThuYUV1RHhkdUNwK1ptUmpUQ0d1ZG5tZTJUS2xNTlVDQ0xLSXpqblRK?=
 =?utf-8?B?TUdsUmRuZ2ZlTUlVb2Nadk8rRitIWWwvcExEYjBPeExZd3JCV0hZWmZMRUJh?=
 =?utf-8?B?dmU1UllTbHoxc0F6SDNXYjF1aGxqdXRxTG11WmVGVDNrbldZZ0VycHZ6TkNv?=
 =?utf-8?B?TW9IM2VmNmIwWlVBSWhmVUwyT2VaektEY0lBTWQ0MFRMWktCWWxsQ3NvbHl5?=
 =?utf-8?B?ZXdqbUNqa1VKYm9BMnBIaFBVelp5NGdHd0VHdFgrSnErU0lGb25wdjlCZHVy?=
 =?utf-8?B?QXcwam1zR0poWllhSFlNbEZtL0JQcnNYWEliTGpibk1Xc3EwN0pSby92UkpY?=
 =?utf-8?B?eEc3QTlkaVkvcU5TajVCYkFKS1plNjhwQzUyVFg0bnF2SEdmRFFLYjQyVDk4?=
 =?utf-8?B?Q3diSy81VEdTVnFhbGl1ay9Bc2huVW8wMXpIczRMRmphMFVLcTIwN2NlVkZy?=
 =?utf-8?B?emZ2ZUVuT0Mvb3p4TXFxb1I5QWt6Y3VicklRNXV5dEhNSytxOUJpUTd1aVVa?=
 =?utf-8?B?Z0xVNG9PSGNoZTl1QlBHNzdaZFYvOXhjWm43REZvTWJ4b1NsRlJoc2t2UzVE?=
 =?utf-8?B?UndzSTlVZm1FUitwYVdpZFptWWdlaTB6TnpnMnF3TnhaNDI4VmJpbE5jd2JP?=
 =?utf-8?B?djFyNEZCd3ZKOGoreGIrcW8vZHJka1JkTTZNRHozYy9CNDNJL3ZidDZBUTBu?=
 =?utf-8?B?Y0pMeE5Tb2Y2OGtHbkRQK1Z6NEFVYzZrYlJLSzdiSEp5a1FIYnR4NnBUU2sy?=
 =?utf-8?B?ay9WRmFBVTB3M01ySitoWGV6U25OSnJjejNhNDE3dTFWY2JLT3hodWZpVjFC?=
 =?utf-8?B?Z055enFGbE4yMzkzL1N1SnlyU3ZFUDh4a09DVUU4ekxrRWNQVXZoNWhaZmFD?=
 =?utf-8?B?TVp2TGtDS250cFQ5WnNHQnd1azdvUCtNR0lYZTNuQ1M2REpIREFsMy9JQWYz?=
 =?utf-8?B?Z0tYQmZ0V1dvQ0p6MFhBUEhKa1NiOFRESG9VU2FveFNrdEJyOFltRkZRZE5w?=
 =?utf-8?B?R0dQWE5CWWZmZXdiS1hHSlhOMW5HTVFsMU1VRU1xZTJPWHZ6WXluOEMzaEZJ?=
 =?utf-8?B?TVpRcmhnT29lZktEV0ZyQ0lQQlVabTBCWXBtOUsrOWVpYm91ODlwL2FsaWlP?=
 =?utf-8?B?TmpQRVNjd01KQmZ6ajVhSGswM1RJd3ROZ0d4VEU0YTZYZG9QTllCVTkzWnAy?=
 =?utf-8?B?WFJWaytubm40TlN6Z2U5d0I1d3lzb2p5anFSR2JtWWs0SmhEd3ErOUNvY1RH?=
 =?utf-8?Q?hRmnP6TIB5zej3CJR0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9717fbd-cf72-426f-2dd7-08df44bacf68
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:55:24.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvvUnrAXiLapzqnvdcTvDSlvWSeOna//VG+WgMFLRzSAv0vWabhB0UHPBkECpWy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145

On 11/17/26 10:01, Philipp Stanner wrote:
> Many users of dma_fence do things like:
> 
> // Thread A
> dma_fence_set_error(f, -EINVAL);
> dma_fence_signal(f); // <- Takes lock, which orders against the above.
> 
> // Thread B
> if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> 	pr_info("err: %i\n", f->error); // <- Can be loaded first.
> 
> There is no memory ordering between reading of the signaled-bit and
> reading of the error code. This can result in outdated, wrong error
> codes being evaluated by the user.
> 
> Though dma_fence_get_status() does take the fence lock, it is equally
> broken because the misordering can simply happen within the critical
> section.
> 
> It's not entirely clear since when this bug exists, but at least since
> dma_fence_get_status() was added, which is why its birth commit is
> marked as the Fixes commit here.
> 
> Ensure ordering for everyone evaluating the error code centrally by
> using test_bit_acquire() in dma_fence_test_signaled_flag().
> 
> Cc: stable@vger.kernel.org
> Fixes: d6c99f4bf093 ("dma-fence: Wrap querying the fence->status")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes since the RFC:
>   - Order with test_bit_acquire(). (Gary)
>   - ^ also makes it easy to backport this for now.
>   - Try to document roughly what is even going on.
> ---
>  include/linux/dma-fence.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index dd07d128adc3..a8d23fed70b9 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -496,7 +496,16 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
>  static inline bool
>  dma_fence_test_signaled_flag(struct dma_fence *fence)
>  {
> -	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
> +	// Best-effort ordering of the locklessly evaluated signaled-bit,
> +	// especially so that reads of fence->error are not misordered.
> +	//
> +	// The release counterpart is typically ensured like this:
> +	//   a) Error codes must only be set before a fence signals and
> +	//   b) The fence's spinlock's barriers effective in dma_fence_signal()
> +	//      ensure ordering.
> +	//   c) For users of dma_fence_signal_locked(), the barrier implied in
> +	//      test_and_set_bit() should do the trick.

That should probably be a C comment, e.g. /* ... */.

Apart from that really good catch.

Regards,
Christian.

> +	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>  }
>  
>  /**

