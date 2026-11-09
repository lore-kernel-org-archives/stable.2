Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225275;
	b=BKrKqIcPxKZ+M4oxUmT10+jqf8yzs0OpfOAWOrNgLtfnZFzwUC/efOKNPdVeEfZg6Sub
	 L4dyCIIq/rDn6fktrRrcKimsIO8nM+jLfeZ4NSeKwbj8uXRuGnIRY9yYgxMje1yU2SEqq
	 dH/88H7MSwApLDGu/41KbSqv5vHL/mwlwDZZtEq0aJCVd+7FVGLXSRJAWuWua7aTSFDO0
	 t8XUW3CKjQ1v0wJChDLjsJiKwNM6YN2F61WAJYfvbzhl5a6FzrfDyGycrk8Xf1ZiFMmlx
	 lcmm1RMnX7yYLaNtna5Lg/1F1q2GBIi74lczybcyE4C6A8M72iz+QyvObvlUcZ+l3Hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225275;
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
	bh=N6T+xqRBe02CsLidTs+IL9dgnZwCx+CZF9sL7P0Hkn4=;
	b=XQ4Ggy5FmiywoqPelvCYd9rTZWIEhDCuormDtoaL+UAMVM0o8OlKFtLBRH0HRwoA9GK7
	 ueGC0z4dNS9aRmQmlG2Hc5WjwOp67Tnkz2YGlkTzKDCGbSu2PIITq7Rl+Yya8/dIMmcA4
	 sV0CljDNBTO64YAKXyta8qcsR+1uescM9Gi0fc53EdnIJlnSTFshv+7dlh5SifBsfi0CM
	 3qu4s+kNRb2NJHheGHbYpzZM1T03Rz6u4ZJGEEiNV0QOAjIB2E68ZlL7OCpmJUuUKWCjQ
	 2H8zBg4Mqh+2w02WnV0LTSZUJv2UMc6g4QAcvZmMhroqhFTD2lU9fTHMgNTE8OJcelQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wnU4QLvL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.45
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A78606D81F;
	Mon,  9 Nov 2026 11:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47A78606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wnU4QLvL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK+yGy2624cI4F9IehoRNnPinRdZ3iCmyXUrDV4oxi1ZtWjN3cnWZBhW701A3riLPZtPYH7M3fZzjc1KH6TNkBNGVN7Qx7b8ZPUZts74tjRRwSphsVxsmPXq5IqxvJngK3UQ5y8sL/YFd0Jbcc68CSbZNdw3R5WhdnMHlcJE46icf4X0qSoOI03Lvv/rvTzOZfGQWd1cnV/mXUMiW2Wk7gjIoiEQSY+Y5WueUMH+GopVFPPEk3UsYhfK4wfM1giVvVEo5H2QuNHprcwpcRHmkl6NS8Q5HZsMwmAmESvL20nWm734J90Aofc7JZBbckAx+ME7OeZKuwtyBx++8VbWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6T+xqRBe02CsLidTs+IL9dgnZwCx+CZF9sL7P0Hkn4=;
 b=Nqv09AmrPKCD7UL+3ChwSL8CWPrJGhkZKg/FWOFq72TBZsIvMJRBbeFTXaIoGoVYWB5efP8zhUTkKtVqMfsRKiKtA7gn8udOIS+QJPYT1R0KYl3FL6w46SwAmqnz3ltf0tm+eQOkjOexnS4aGCarC4wGiCHG/uTQoyAMxwAqWaqMFOerW9rpsEMmNyencpJCnFHF+bwWFubIqH06ZFWhSiO83cYtjJu001NRXTE2tpyP2uITwzLntezfKCSBA3AXj72cfjNfMcvkl+4OkO7uynPtfMrNIukYi1gGbjE/k/YDEWdWuIfjNnRXpGxYIPxmPvJPEHuKWMGfiLUqb8BgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6T+xqRBe02CsLidTs+IL9dgnZwCx+CZF9sL7P0Hkn4=;
 b=wnU4QLvLUiK2tR/bn14+dxQ9J4pRYW/H9lFZEaBvRloa29lJ/cT6Qt766IdzxnbYt/81kuHT9of5NJ5Ga4yE5JzhUJzfru52CKecDz1YYP+c3VFzeAbjQ7isGYuZTDQu4LPUfvCOICYV44nr2twX7Lxyv9cv/hn6/z6OSV5xIm8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 11:54:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:54:25 +0000
Message-ID: <3aaea7f4-62a5-435c-b1ca-35babf30a7d2@amd.com>
Date: Mon, 9 Nov 2026 12:54:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/syncobj: Limit the number of handles and use
 kvmalloc for user-sized arrays
To: "Yu, Fei" <fei.yu@intel.com>, dri-devel@lists.freedesktop.org
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org,
 syzbot+95416f957d84e858b377@syzkaller.appspotmail.com,
 Madhur Kumar <madhurkumar004@gmail.com>, stable@vger.kernel.org
References: <20261109014852.2127723-1-fei.yu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109014852.2127723-1-fei.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To PH7PR12MB5685.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: e9012fb3-34d4-4548-94bf-08df3e58337e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|261028144727099003|11063799006|56012099006|261022105027099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|261009221227099003|261026121527099003|261102123227099003|261026140227099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	s5YiyoXF3Tq4F++EppvcX2L7mbLqFXbMK7r1qBm3UXikYFGxcgPlqcwaVZ8lplldTiktynAJTxrXE7ZCW1wSsvBOM6QFWvUSFfiMalaAtmJOCCbiQNlt1FkUjLC0c6LQmi+ahUdX4Qjytxw9akpQyIYLX4MI1fg8q1N+VKSqGLSDaFEixibK/ID5A9hDCrV9Wt0cBFks7fJRmHnXnMpOQp9PNveAl7nXf5IAUWBqJQsvCT8LNDJPnEkLoUt7fGzRm+wiGSjwaIZWurD0P8FFNNZ+EHk4s6okTgTwuqIplUU5FF5ER8h1iXtCikTwGfjKu1qbp/IwrMqZ3jBzeaYaD2T92gepZfQ3VV9mDCjy7kcsG9rzx/xAsb43vSnijBgrJkLmwtL/S3HKtOnJ+dqTCxXnjVhXlRrHeeGH7j+lsBJ0NqiAr/u5vQpbXGfK1GjRRm+/wWMEuU7iQphZgTXTNvrWqFN97C5fN3jmkGP7lVOvSiVreWPoAbOzxJyDl5+zOr8+tK5loaHxZkBtev8q4zvu9ezEzdxlHox/qfGWMlRY0qlVeyqayPoqEqXoRGNd8n0hVq9bM3zn5OEzj5GjrkUNvwwQgcMdp79eyx0ui2m6N8+3TXc1jySA4Rn56Fbv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261009221227099003)(261026121527099003)(261102123227099003)(261026140227099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1lmWUpGWU02L2pwZ3MxWmdWcVRQeklCRlZoSkFhVm1Mb0wycWNKM09CSTBm?=
 =?utf-8?B?S3IrUnNtMVJReGNibEFXdmVPTkV5UGxjVysvdUJXUXFxcHlUWlA2Z2Nua2pu?=
 =?utf-8?B?RmhjWFh6bzJDdFRSd0JldkUxYkQwQkhMMHFOSjFSTkl2bVRWZXRGQ2cxUzZG?=
 =?utf-8?B?RCt4bUtSbE1JRmQzekJMWFhTMVNLdE1LZnRXb00rQkRpdGt1NWk1djZNdmFE?=
 =?utf-8?B?QXdnZGgrQlNTRHpZeFpWeXJaL05qU2dVTjdCaElkNWhqd3d4VWc2bGxVZGZm?=
 =?utf-8?B?UHc0TE1FdTNudk1FbDdDRVZrMkNiNERabXArdExjcHo5ZkNwRDVINWM2dGZr?=
 =?utf-8?B?RzIrUC84Y24rNU1ZMStmYzdSMS9MSzQ3M0MxTEhINlIvbHptblIzdVFHZGhU?=
 =?utf-8?B?Y0pua0Q3NnhNMlFLd0FUN2hidGxOYVJOejZrb3E5OS9rcUFmemZTd3RrWUh1?=
 =?utf-8?B?d1hzR2RWa29FaVRmUHBpRDBuRUZ5U1VwZkJlay9ZQ3dMYzNHd25ZeXlwb1l5?=
 =?utf-8?B?QTFrYVJwSEluYkc3TGRDQXZ4MDVUU3hoYmR0Z2NoT2pReUJuQWZHK2x6aUZJ?=
 =?utf-8?B?c0NRV3FRVkhlSE1oTnNhcjMxd3R2Um5md0hzUXRmYkFBT05MeXk2THhIVi9Y?=
 =?utf-8?B?bGUyWWgyeENOeFU0NkFSYzBFOG1xZnFoSUo1aDNXUGpuZjJxTHlTa0IyazhZ?=
 =?utf-8?B?bUZWQ0dzbVhzL1pPUndKblZlVUM3VDNFOWNQSEk1N1o4ZFBpV0wxUlFiK0Er?=
 =?utf-8?B?bDY1N3RUMFhTTWVqV2FJRk5NU3hrcUFZTjEvdmpZZ0krUStwRS9wZ0ZXdEZx?=
 =?utf-8?B?MEZhSW03RlY0Q3NBN0ExTkM0V09RMzVBOXVmOCtOZndRb0xJTUE4OENkWWh3?=
 =?utf-8?B?ODJtZkdWMlpCb1d4NVJVTWhwcnRDbk4yaThqTDNGMVV4TUp4VVQ4ZE1wbFBo?=
 =?utf-8?B?NHUyZERzMFg5NmtKQTlIaHpjMmlGc2VMbU1yTTZrRFJyZUZuYVZOMEJnUzg4?=
 =?utf-8?B?ZmI4SjlSa1dad20wVUs5STB4OGF2VlUxUmh2UTJQY3c4NDdaY1JjSlJPR1li?=
 =?utf-8?B?NU8xVXBZMkZhRnorMXBqc2ZHRmNtc201R0NibU11RTFUUWUwdGY2MHVBWFRz?=
 =?utf-8?B?N0xJZitqTHJqTlBBRVBxMVlLN2s1aVpuQ0czR0lCN3RHeS9Va1FndWFZSmxj?=
 =?utf-8?B?QWNlRlNmWTdnK2VGL0hmd3M5dDMxLzF3RG51K3B5QmRwTnlUaHhRd3BlWXA4?=
 =?utf-8?B?SDVkWUllRExoTmdIV1AyY3BkVFFIT2hWS1cvOWRFYnJzVmVlYzFaN052bTFX?=
 =?utf-8?B?NVNnVGdGREdkT3VBVFlHMStsYzVVcEErOTFyY1pjOHBJaGpNVExnZzFQamhu?=
 =?utf-8?B?V0hsekV4RGpldlFFNGJ0clVsazFIQUNvb0pTQXBSb1ladDg4QWxDaVFUK3RQ?=
 =?utf-8?B?VE1ZQU11aDAvM0Y5QjluanpMSWM4UGRUamNRaFZRbXoyZ1BYNnVaYXEyS1hj?=
 =?utf-8?B?cWJpd0Fqa2pGUzAyUFlMSXNzaVdwc0ZYQVg1QXlEdWZmTHZyUG94QjN4am42?=
 =?utf-8?B?bFZvRGhzaEkvbENxMGRXbXp5RlBnY2ZncElPZENnUkMySVZiTXMzV0ZiTXZv?=
 =?utf-8?B?OG85aTVSUUZ0Yjlxb093ajVNd0JIeGJ5eHNHUHNQejl6aWlIdWlkcHlzdEdi?=
 =?utf-8?B?NWNjQ0lvVWNCcGVGOWNOSnFGU1ZnTHlJemZCSnlOdXFnZnFiZHJyb0RVTEc2?=
 =?utf-8?B?S1N3ZEJWR2lsWXNFUThZUkVtbGFlYzQraEFlUUpjdktVMlhLOUR4REZiM1Er?=
 =?utf-8?B?VjROQWU1TjNQRDZXbU41WloxZzdGdUdHUk5UcWVnNzVVNzEvRzZmaDVnaE9N?=
 =?utf-8?B?eUhnS0hTR0U3eG5Uak1OQkl1N0pLTlZRRURHdUhTZG5zLzhvSnJmdlBBNGlV?=
 =?utf-8?B?YkwvOVZRME8zUy82bjZCOVpldzI0WlphU2dGMXFCSEZOdFlpUlRaMVZ3dlFH?=
 =?utf-8?B?Wk1EV3R5U1IvZW05akJya0dRenl2WGxYV20ydXYzMnozVGtnNnl0TWdoaGdp?=
 =?utf-8?B?cVZlMlIvYTUwTTl2WmxoQlpZZGw2UDE4MkJrWW9WSVNoa2ZHRzdIbVhvdm9o?=
 =?utf-8?B?V2dFV2RJNGw0YjBmb2RHT0xRN3UycWhiSFlZWktDMUNuYTZDaDZDRnl0VkFY?=
 =?utf-8?B?dUR4VHBsUlkvenhtTjBiZ2RNQlByMTZ6NnE1eTNqdFB6dVJvU041eVFpcklR?=
 =?utf-8?B?UGNCKzl6dVo3SVRURUJ3MmtzV0tpekQvOTh5c0R0Nlk2dko3MDk4SWFRb3ZU?=
 =?utf-8?Q?S60Tg+WqzGowf6Iv5X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9012fb3-34d4-4548-94bf-08df3e58337e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:54:25.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDJr+XwRjx0OJpv70fhgJ6oD3tByCFPSAsF0PLLe9v0v0kU+p80F6f2MgS1r+eOW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649

On 11/9/26 02:48, Yu, Fei wrote:
> From: Fei Yu <fei.yu@intel.com>
> 
> The syncobj ioctls allocate several temporary arrays whose size is taken
> directly from the u32 count_handles provided by userspace:
> 
>  - handles and syncobjs in drm_syncobj_array_find()
>  - points and entries in drm_syncobj_array_wait_timeout()
>  - points and chains in drm_syncobj_timeline_signal_ioctl()
> 
> These are kmalloc() allocations, so a count above KMALLOC_MAX_SIZE /
> element size trips the WARN_ON_ONCE_GFP() in ___kmalloc_large_node():
> 
>   WARNING: mm/slub.c:5459 at ___kmalloc_large_node+0x10c/0x170 mm/slub.c:5459
>   Call Trace:
>    __kmalloc_large_node_noprof+0x18/0x90 mm/slub.c:5502
>    __do_kmalloc_node mm/slub.c:5519 [inline]
>    __kmalloc_noprof+0x3f6/0x710 mm/slub.c:5556
>    _kmalloc_noprof include/linux/slab.h:995 [inline]
>    _kmalloc_array_noprof include/linux/slab.h:1211 [inline]
>    drm_syncobj_array_find+0x3a/0x440 drivers/gpu/drm/drm_syncobj.c:1241
>    drm_syncobj_timeline_wait_ioctl+0x18a/0x640 drivers/gpu/drm/drm_syncobj.c:1356
>    drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:817
>    drm_ioctl+0x70e/0xba0 drivers/gpu/drm/drm_ioctl.c:914
> 
> The wait entries are 64 bytes each on 64-bit, so with a 4 MiB
> KMALLOC_MAX_SIZE a wait on more than about 64K handles already fails
> today, with a warning.
> 
> Fix this in two parts:
> 
>  - Reject more than DRM_SYNCOBJ_MAX_HANDLES (1M) handles with -EINVAL in
>    drm_syncobj_array_find(), which every ioctl taking a handle array goes
>    through. The limit is a fixed number, so it is the same on all
>    architectures. It is above what these ioctls can handle today: with a
>    4 MiB KMALLOC_MAX_SIZE the 8-byte arrays already fail above 512K
>    handles on 64-bit, so no request that succeeds now is rejected. A
>    static_assert() makes sure that the largest per-handle allocation, the
>    wait entries, stays below the INT_MAX size limit of kvmalloc().
> 
>  - Switch the six allocations to kvmalloc(), so that handle counts up to
>    the limit (64 MiB of wait entries for 1M handles) no longer depend on
>    physically contiguous memory.
> 
> Using kvmalloc() alone is not enough: the reproducer asks for more than
> INT_MAX bytes, which hits the WARN_ON_ONCE() in __kvmalloc_node_noprof()
> instead.
> 
> Fixes: 3e6fb72d6cef ("drm/syncobj: Add a syncobj_array_find helper")
> Reported-by: syzbot+95416f957d84e858b377@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fei Yu <fei.yu@intel.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Let me know if you need somebody to push this to drm-misc-next.

Regards,
Christian.

> ---
> v3:
>  - Use a fixed DRM_SYNCOBJ_MAX_HANDLES of SZ_1M instead of deriving it from
>    sizeof(struct syncobj_wait_entry), so the limit is the same on 32-bit
>    and 64-bit, and add a static_assert() against the kvmalloc() INT_MAX
>    limit (Christian).
>  - 1M rather than 64K: with a 4 MiB KMALLOC_MAX_SIZE, reset, signal, query
>    and timeline_signal currently work up to 512K handles on 64-bit, so a
>    64K limit would turn requests that work today into -EINVAL.
>  - Keep the define kernel internal for -fixes; documenting the limit in
>    the uAPI struct comments will be a separate patch for -next.
>  - Add Cc: stable.
>  - v2: https://lore.kernel.org/all/20261104030930.3852781-1-fei.yu@intel.com/
> 
> v2:
>  - Drop __GFP_NOWARN (Christian).
>  - Add DRM_SYNCOBJ_MAX_HANDLES, return -EINVAL above it, and switch all six
>    arrays to kvmalloc() (Christian).
>  - v1: https://lore.kernel.org/all/20261103085002.3100723-1-fei.yu@intel.com/
> 
> The vmemdup_array_user() conversion and the points array cleanup Christian
> pointed out are left to Tvrtko's series, which he will rebase on top of
> this fix for -next.
> 
> Testing on v7.4-rc1 (x86_64, KASAN, virtio-gpu in QEMU):
>  - syzbot C reproducer: base warns in ___kmalloc_large_node(), patched is
>    clean, the ioctl returns -EINVAL.
>  - 1048576 signaled syncobjs; wait, timeline_wait, timeline_signal, query,
>    reset and signal with count 200000, 1M and 1M + 1:
>      base:    200000: wait and timeline_wait fail with -ENOMEM and the
>               warning, the others succeed. 1M: all six fail with -ENOMEM.
>      patched: 200000 and 1M: all succeed. 1M + 1: all return -EINVAL.
>  - drm_syncobj.o builds for i386 with W=1 (static_assert holds).
>  - checkpatch --strict clean, W=1 clean, kmemleak clean,
>    DRM KUnit 667/667 passed.
>  - IGT syncobj_basic, syncobj_wait, syncobj_timeline on virtio-gpu:
>    202/202 subtests pass, same as base.
> 
>  drivers/gpu/drm/drm_syncobj.c | 44 +++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index f1d4da168545..c8a8c49d12fb 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -199,6 +199,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sizes.h>
>  #include <linux/sync_file.h>
>  #include <linux/uaccess.h>
> 
> @@ -220,6 +221,16 @@ struct syncobj_wait_entry {
>  	u64    point;
>  };
> 
> +/*
> + * Upper limit for the number of handles passed to a single ioctl. This is a
> + * fixed number so that the limit is the same on all architectures. The
> + * largest per-handle allocation is the wait entry array, which must stay
> + * below the INT_MAX size limit of kvmalloc().
> + */
> +#define DRM_SYNCOBJ_MAX_HANDLES	SZ_1M
> +static_assert(DRM_SYNCOBJ_MAX_HANDLES <=
> +	      INT_MAX / sizeof(struct syncobj_wait_entry));
> +
>  static void syncobj_wait_syncobj_func(struct drm_syncobj *syncobj,
>  				      struct syncobj_wait_entry *wait);
> 
> @@ -1051,7 +1062,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  		lockdep_assert_none_held_once();
>  	}
> 
> -	points = kmalloc_array(count, sizeof(*points), GFP_KERNEL);
> +	points = kvmalloc_array(count, sizeof(*points), GFP_KERNEL);
>  	if (points == NULL)
>  		return -ENOMEM;
> 
> @@ -1064,7 +1075,7 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  		goto err_free_points;
>  	}
> 
> -	entries = kzalloc_objs(*entries, count);
> +	entries = kvzalloc_objs(*entries, count);
>  	if (!entries) {
>  		timeout = -ENOMEM;
>  		goto err_free_points;
> @@ -1185,10 +1196,10 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  						  &entries[i].fence_cb);
>  		dma_fence_put(entries[i].fence);
>  	}
> -	kfree(entries);
> +	kvfree(entries);
> 
>  err_free_points:
> -	kfree(points);
> +	kvfree(points);
> 
>  	return timeout;
>  }
> @@ -1238,7 +1249,10 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>  	struct drm_syncobj **syncobjs;
>  	int ret;
> 
> -	handles = kmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
> +	if (count_handles > DRM_SYNCOBJ_MAX_HANDLES)
> +		return -EINVAL;
> +
> +	handles = kvmalloc_array(count_handles, sizeof(*handles), GFP_KERNEL);
>  	if (handles == NULL)
>  		return -ENOMEM;
> 
> @@ -1248,7 +1262,7 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>  		goto err_free_handles;
>  	}
> 
> -	syncobjs = kmalloc_objs(*syncobjs, count_handles);
> +	syncobjs = kvmalloc_objs(*syncobjs, count_handles);
>  	if (syncobjs == NULL) {
>  		ret = -ENOMEM;
>  		goto err_free_handles;
> @@ -1262,16 +1276,16 @@ static int drm_syncobj_array_find(struct drm_file *file_private,
>  		}
>  	}
> 
> -	kfree(handles);
> +	kvfree(handles);
>  	*syncobjs_out = syncobjs;
>  	return 0;
> 
>  err_put_syncobjs:
>  	while (i-- > 0)
>  		drm_syncobj_put(syncobjs[i]);
> -	kfree(syncobjs);
> +	kvfree(syncobjs);
>  err_free_handles:
> -	kfree(handles);
> +	kvfree(handles);
> 
>  	return ret;
>  }
> @@ -1283,7 +1297,7 @@ static void drm_syncobj_array_free(struct drm_syncobj **syncobjs,
> 
>  	for (i = 0; i < count; i++)
>  		drm_syncobj_put(syncobjs[i]);
> -	kfree(syncobjs);
> +	kvfree(syncobjs);
>  }
> 
>  int
> @@ -1572,8 +1586,8 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  	if (ret < 0)
>  		return ret;
> 
> -	points = kmalloc_array(args->count_handles, sizeof(*points),
> -			       GFP_KERNEL);
> +	points = kvmalloc_array(args->count_handles, sizeof(*points),
> +				GFP_KERNEL);
>  	if (!points) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -1586,7 +1600,7 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  		goto err_points;
>  	}
> 
> -	chains = kmalloc_objs(*chains, args->count_handles);
> +	chains = kvmalloc_objs(*chains, args->count_handles);
>  	if (!chains) {
>  		ret = -ENOMEM;
>  		goto err_points;
> @@ -1609,9 +1623,9 @@ drm_syncobj_timeline_signal_ioctl(struct drm_device *dev, void *data,
>  		dma_fence_put(fence);
>  	}
>  err_chains:
> -	kfree(chains);
> +	kvfree(chains);
>  err_points:
> -	kfree(points);
> +	kvfree(points);
>  out:
>  	drm_syncobj_array_free(syncobjs, args->count_handles);
> 
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> --
> 2.53.0

