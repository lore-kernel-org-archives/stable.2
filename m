Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFD8344025;
	Tue, 16 Jun 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593936; cv=fail; b=PMiOjdX2Atc93KTs8yzNmXmRjOnGYPVDcsvgyGnOC/3ff1KzHBZvMcaITmk9qfWmR+J1zYWvjItHosACYKXFCXXn2Pqax6OCKwfJYA7sG5nEtmSf9BgzOJQ7dlsjIn0k3wfICLyHswFn2oOKwq3pONvmUv7hWc2JsczOkHs7aVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593936; c=relaxed/simple;
	bh=3UqjMV9lTg1W0GCTxi2t3iAFCRGzw6kEXVqUGf7ny8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKodWMT0Bg3MkTfiFNGDm64lUxjLzGhbRISqVap66WWLv6WUVE2Jh1JMFnMe4Kq2bHfbvMetMJ5XMTjDfazeOd53avHaYuWh2NeTLThVENWrZ9CPTKSDIoLI0865Pe9gAu+s5d/7GYNz7hbsc7vtSRFF+Jbw8B/AjNdZTeEHShw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NOTDqspw; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NOTDqspw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABDAZK+JJJWuDrDJYsBB8wpI8Pop051E5j4iJF+GsdsC4RY1BrQIX7/rx2ZklImevTJRkyXHhQQGe0/WYPqIlaSFQ91Dj57D+iLm90G88CG1+f/4bg7LzJajon8gjh8i0enjNL891Qzck+xwVj65b2WI7X3CFxpSB06j5uZKXbxnb+MSqyo3/NEePVUg7+4OgDFeDZc5+04iucD3d5KfLC8AShvfc42l67IgDEhBI9s6jHLJAHMcW1/tkYNtNI6bJDI3x9GYdv+F2VeSvfC5iRQLHesFAowU8ckAOfRMJSNnKKdluklg8XYD+HBUazEcV85cg4r98TCsgXGQJxSfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3L4+G6gaFYqk1iDIwARa1apYscxzBZ4XzGtB0q1J50=;
 b=IHt54S0osyKlzKceFLo04XATjCM4PgNMnqHIdFhnTsTRnDZD/HY36Y9z90U5Az0dfEYHoTWYiBjHL22KD6D1PxyuPCkSg5c5u1B3mlra9+eracC7ezTZGYnBIvBjlQLecwfGz0RcrN0148PBWKL7eCFD0hLLTbjOmFyNEItlp6YgfYkcN5P+k3lk8VuatjvcKpccSpggBdxW9SZddulsNOkaLPeoVum8AKjtyErCUO1tmk1Hfkw8Ecsh/rmJjZ20MBiMlC49IyUmicNXRuOCvRrpLEK9ZwOlZVfYSTyI9h9O14Qb0R5e5UzeHJ+NsBAQoe9l+FqAunUims2X1/bRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3L4+G6gaFYqk1iDIwARa1apYscxzBZ4XzGtB0q1J50=;
 b=NOTDqspwLcheSMHO9w3ns3ZGs0QpSqw7RiA65a+KLhBLRf+cYFMPXA1iBYHgFS/fzVqLSvKFdlZ06PL/SHZV90w3Jj/WnxEAhJnIL9Jo6mXo1WvO8cAMz6UH9Kxx4TZwmhfMDoXSjyxNmqJf6U/v+bb9wsfK57z3QCkebCMJqVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Tue, 16 Jun
 2026 07:12:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 07:12:12 +0000
Message-ID: <8be98ab6-3843-474b-841e-3ef3e37d054b@amd.com>
Date: Tue, 16 Jun 2026 09:12:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/ttm: don't leave bulk_move cursor dangling for
 unevictable resources
To: Samuel Ainsworth <skainsworth@gmail.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260615234922.151263-1-skainsworth@gmail.com>
 <20260615234922.151263-2-skainsworth@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260615234922.151263-2-skainsworth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:32b::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: e13fa2c0-9dc1-4539-14be-08decb769626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uSeJjhrkzoKvJCb3ZKshiCY3LyIbiGt6omPAGH7Zihoem5PzZOblEF+8ZMyeehAXvX0Aa6o4W05fyIuibZVwXTJx9vu3AZky+LyM43/zY1RVqq63mUtR0D7YsNxsNaB0CsGNSKJrkwOD9LlNhximcIu2rYXfCT4q/QVqBR/ovWIXDwJMMgucwZEGAk06XWP12mbKh0HowQKcnFPX1MIfNAuIfF71OyklVqoaHr7oCs0PR14zLuXgtx31hsKzdRWg2iRZ6W8j86SOtK+EnHqQIV0uIsEQu6KEVLi6HxZojGZ9WAffjxJm0yR9lLJrLd5/PIhzMQsFj5S6wUg3YxjfhLXN5CJtXuBvq+OwTjsyXzzG3smpZ5V6t9Jcsqxbiv4zDit0kF2fV5iDUY6u0YOjkh4rfzy8iOJurAATlmoVyS4zXw8zSf+ga2ftAnCbUPPj2J5LuDiV7dVJIiUjrmeneoYifWBTn1GLMow7b8qD3fJ7g5kYB+JfMGvC1E0+hdO6AtCXSnyLCFmbPbk0/vGM8xcBjuCFbMsZobs8b+Nmd6DYFw4q3hr8gEf+tr2m32kcTJU3UtmFHuVKX7ebFJQbASU566IgZhcXyxwWIYrljZsIs/oZJNl0Invm2kC37R4HBudhHTH90SfXpWYn+Uz+w/f/FVWJvY85mYpbLiONERD8ipzCbXjpP9rjyWkpOp9m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?empocWtSWGs4dS93SFhCWC8xbUVPMmovaEZwbmpRb0NsVjRSVGpITVZoZnY5?=
 =?utf-8?B?UmdNOUFNUlE1MUdLUlN3QjdkQ2FwRWdrWTNpaXNkaUxNMDF0Y1Jlak5GWFRk?=
 =?utf-8?B?YlRCc3NLcGVzSHRMTHFZaEJIWm5XaUFFMi9QcFo3RGZQMXZ1U1BBY2l0R0tI?=
 =?utf-8?B?M082S2E5MEF3NEZzTVYxZVh0MGNSRW9YaktUQnArMzBFaEs0RzFTOEZ4ZWpD?=
 =?utf-8?B?SHU4UDBjWTJ1eUVkWDByTWVxUHRydnlCd1VMdWFOL3gyTWh1TjNIU3RZbllW?=
 =?utf-8?B?WHN5TEtVUll4MFpmQWlqMFFpbzFNQlovNllvL2dlRmlvZzA5MFQ2blh0dnNW?=
 =?utf-8?B?T3NPT0pJNEJ0Nk9kWWZaSHR0d1YvNlg1d3VCbDhQVE1nVXdhY0RyRzVaRDlo?=
 =?utf-8?B?Wi9zMHNPcFRoQzNOUm1QUGY2R1BtK2x0L0xvYUVzZ08wSzBRWHlsVmI0UDZI?=
 =?utf-8?B?ajFLMXd4eno3L29QbHNUZWdDUWtlSUx6bFRYajRTTzRMTG80TVhWSVJieC9Q?=
 =?utf-8?B?Um1teGp5eHBzVGdhSnhaUHgwZGpTcUpZN0R5YzdjU2l6ZGc0REd6MzlXb0dp?=
 =?utf-8?B?WnA3ZXBlTUg2YjE3T0tFd2Z4SnFXM1VieGJJRWcxRHhnRDUxbnA4amhnSERh?=
 =?utf-8?B?NTFmUE1mTTI0bi8zNFA2aEhPc3Y1SUhnTDQzYmdqT1BucWkxSnNMcWlReklO?=
 =?utf-8?B?elBQakdDQmRhbDVDWTBBZ1N1TTJaK1JkdXlwVEo2SnBuZ0VPMTE3OFVxZDV4?=
 =?utf-8?B?elVjeXh5WTdNR0RzY3RXU1RkbHo0aU82UXFOMmN2d2VhL1lCRWhaY0RLVGpw?=
 =?utf-8?B?YitPRzJsbk5QbW1nZFV1MWhVbzFqd1RpdGo2NGlrYml0d20zeFc5WlhIM242?=
 =?utf-8?B?bTcyMHVzV3lrQnV5d2lObUNuMTBHdFFad0hqdG54VitSQVdTSmZicit1blF4?=
 =?utf-8?B?K3VTcVd4bGFRTnBMVnVDRkhCYWJ6TXlSMm9tSm5odGh4bVNGNzl3R0ZuL0hM?=
 =?utf-8?B?QUU0RkFFOENRRWRrSDdTMFFUSmtFUWxoYjJsK0VzS3NWWFNZUEZYcHpiSGMz?=
 =?utf-8?B?WDl3Y2hkSXdYOFV4SEhXTDd3WXdudU1jS3hFc29mNG85NDJlS1VVbmxJcm1Q?=
 =?utf-8?B?dGdyWkcyVHAxdzdwbTZUYlZFSTA1b1V5OGUvZkVtVXcydTNBWmdLcE9wTjJa?=
 =?utf-8?B?ZGkva2R5SkhNTURISW02SmQ1YTVBMVVDVWg5cko5b1hkWEQ3b3QrTlFYbnRt?=
 =?utf-8?B?N2l4cTNURnVqMnVLZlJtN3pzTlIwOXZzK0k0aGlyTmlTQnlVYmlpVnRDTi9l?=
 =?utf-8?B?Qlk5UFZUN21tbTFDN3IrWG5aZkJCTmZTRXQ2aWhnZS9PNU1qYWRPRWhhYTVs?=
 =?utf-8?B?OHpjbTcyQWE5ZHUwb1lHTE9naVRFaEFNTXYxREg2UGkwUDE0elBNR1ZOZVQ5?=
 =?utf-8?B?WUpYaTdMVnVzdTJUSXgzRU1IQUQ5dmc2Nlo2RFlwU0xtaHRDbXJiZTdZTDlx?=
 =?utf-8?B?MGkvNHJBSTRJZmhxcHFBNThmOTF3bDlCTVhGM0FFZGduQXNTMGorTndOS3NF?=
 =?utf-8?B?WHFOYXhVWkpwdWxmYy96RjBnTEhjY3ErVzAxV3lRMm94SDkraThpWmoxOTlX?=
 =?utf-8?B?ZXhmNkVXQ3c4NVBaRUZ1RWZUK3FXRzdZOGhpbCs1SDJKNFZ5bDFFcmhvaXM5?=
 =?utf-8?B?c25sSDRQNEJEcWNZSkNsNlh5Y284RTBheFF0UUdpRm1oSVcxZ0owYm1XSExH?=
 =?utf-8?B?VmNQMjZ4UDR5a3ZEMG8vL1pJTFZKQnhEcWlPL3RESXRhc3JxNnhtTjlZQ2pC?=
 =?utf-8?B?c2tOTi9NdW40OEdxRUExUEZGUU10VnNVOVphU1dncUxGSSthZm1jeDYwVTI0?=
 =?utf-8?B?TWd4bzBCN1lsTC95N0F2S3hYTEhWVnIxdGpyRzRPSjJNZ0RlMW1SYzV5dnYz?=
 =?utf-8?B?YzM1Z0tZTU9VYXhMcE4zRmNKY2VZVWFYOG45TG5QZ3FwenhKVHJLbE1BYkVP?=
 =?utf-8?B?Z3FZdnVwZjh1ZjFTSkh1UjdVWUQyU09JUzVHaHBDRTdvZHUyMllqR2N5WFFh?=
 =?utf-8?B?UEptRDV4alhxeFdLdnRuTGNURHZlNnJ6U0MxVHIra0h5TXhiaWlwb1pDeS9u?=
 =?utf-8?B?WGpnUmYvb2ZCaTBub3QwQWVLczdocmU5dXlrT1VWY3lzdUcwSXROWTZ4ZVJs?=
 =?utf-8?B?bjBueUlwcTExNU9EcTh6MEVpaGFlSHRXWVNlUEc5SkNhbUdaT25CTWZaLy9p?=
 =?utf-8?B?OWJlOVNybm9yaDBmRW5WWEtjUXR3YnVKOU9LanFvWElrOEY5TWEycjZaY0FH?=
 =?utf-8?Q?LHRq17/5g3PxtM+sXU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13fa2c0-9dc1-4539-14be-08decb769626
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:12:12.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bxQUDAo6Sp4DTZJESqkxGw+Zqlmk8xhI9UFEznQ/TBv8gSc4oIB4g1We+wykG3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

On 6/16/26 01:49, Samuel Ainsworth wrote:
> ttm_resource_add_bulk_move() and ttm_resource_del_bulk_move() both act
> only when the resource is evictable (!ttm_resource_unevictable()). A
> resource is added to its bo's bulk_move cursor (pos->first / pos->last)
> while evictable, but it can become unevictable -- pinned or swapped --
> after it has been added.
> 
> ttm_resource_del_bulk_move() is reached both when the resource is freed
> (ttm_resource_free()) and when the bo's bulk_move is cleared on teardown
> (ttm_bo_set_bulk_move()). If the resource has become unevictable by then,
> the del is skipped, so pos->first / pos->last are left pointing at it.
> Once the resource is freed the cursor dangles, and the next
> ttm_resource_add_bulk_move() / ttm_resource_move_to_lru_tail() on that
> bulk_move dereferences it: a use-after-free read of
> pos->first->bo->base.resv (the WARN_ON in ttm_lru_bulk_move_add())
> followed by a list_move() through freed memory that corrupts the LRU
> list. With CONFIG_DEBUG_LIST this manifests as a fatal "list_del
> corruption" BUG.
> 
> On a Framework 13 (AMD Ryzen 7040, gfx1103) this is hit via hibernation:
> a buffer object swapped out during hibernate (its resource becomes
> unevictable) is later closed after resume (amdgpu_gem_object_close ->
> amdgpu_vm_bo_del -> ttm_bo_set_bulk_move()), which skips removing its
> resource from the VM's bulk_move cursor; a later GEM allocation on that
> cursor then faults. KASAN reports a slab-use-after-free in
> ttm_resource_add_bulk_move().
> 
> Track whether a resource is actually on the bulk_move cursor with a new
> ttm_resource::bulk_move flag, set when it is added, and remove based on
> that flag rather than on the resource's current evictability. The del
> then always undoes what the add did, regardless of any pin/swap
> transition in between.

Good catch, but the fix looks incorrect to me.

Please don't add any flags to ttm_resource. The bulk move is per BO and not resource.

Why are we not removing un-evictable resource from a bulk move? That sounds broken to me in the first place.

Regards,
Christian.

> 
> Fixes: fc5d96670eb2 ("drm/ttm: Move swapped objects off the manager's LRU list")
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
> Signed-off-by: Samuel Ainsworth <skainsworth@gmail.com>
> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 18 +++++++++++++++---
>  include/drm/ttm/ttm_resource.h     |  9 +++++++++
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 192fca24f37e..1a031ef151a7 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -280,16 +280,27 @@ static bool ttm_resource_unevictable(struct ttm_resource *res, struct ttm_buffer
>  void ttm_resource_add_bulk_move(struct ttm_resource *res,
>                                 struct ttm_buffer_object *bo)
>  {
> -       if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
> +       if (bo->bulk_move && !ttm_resource_unevictable(res, bo)) {
>                 ttm_lru_bulk_move_add(bo->bulk_move, res);
> +               res->bulk_move = true;
> +       }
>  }
> 
>  /* Remove the resource from a bulk move if the BO is configured for it */
>  void ttm_resource_del_bulk_move(struct ttm_resource *res,
>                                 struct ttm_buffer_object *bo)
>  {
> -       if (bo->bulk_move && !ttm_resource_unevictable(res, bo))
> +       /*
> +        * Remove based on whether the resource was actually added, not on its
> +        * current evictability: a resource can become unevictable (pinned or
> +        * swapped) after being added, and must still be taken off the bulk_move
> +        * cursor before it is freed -- otherwise pos->first/last are left
> +        * dangling at freed memory.
> +        */
> +       if (res->bulk_move) {
>                 ttm_lru_bulk_move_del(bo->bulk_move, res);
> +               res->bulk_move = false;
> +       }
>  }
> 
>  /* Move a resource to the LRU or bulk tail */
> @@ -303,7 +314,7 @@ void ttm_resource_move_to_lru_tail(struct ttm_resource *res)
>         if (ttm_resource_unevictable(res, bo)) {
>                 list_move_tail(&res->lru.link, &bdev->unevictable);
> 
> -       } else if (bo->bulk_move) {
> +       } else if (res->bulk_move) {
>                 struct ttm_lru_bulk_move_pos *pos =
>                         ttm_lru_bulk_move_pos(bo->bulk_move, res);
> 
> @@ -339,6 +350,7 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
>         res->bus.is_iomem = false;
>         res->bus.caching = ttm_cached;
>         res->bo = bo;
> +       res->bulk_move = false;
> 
>         man = ttm_manager_type(bo->bdev, place->mem_type);
>         spin_lock(&bo->bdev->lru_lock);
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 33e80f30b8b8..1fedf75bab96 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -274,6 +274,15 @@ struct ttm_resource {
>          * @lru: Least recently used list, see &ttm_resource_manager.lru
>          */
>         struct ttm_lru_item lru;
> +
> +       /**
> +        * @bulk_move: Whether this resource is currently tracked by its bo's
> +        * &ttm_buffer_object.bulk_move cursor. Recorded when the resource is
> +        * added so the matching del removes it even if the resource has since
> +        * become unevictable (pinned or swapped) -- otherwise the cursor would
> +        * be left pointing at this resource after it is freed.
> +        */
> +       bool bulk_move;
>  };
> 
>  /**
> --
> 2.54.0
> 

