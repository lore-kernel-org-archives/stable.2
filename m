Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608180;
	b=3BIaNb/Tugk1lNIVuoTE0g3CZdNQDE5fHBFvzdkAvyXEnNnG9TFsNbmriSp0gq/7rVdl
	 5GI727lR0NpjfqDcGEuRQ1TLRPYGvPDOrJ+CqSGmOTEW9eU6UuD5omk5JBsUQUA5EX/zX
	 wiF9GCowc1oh1ZwlySGRPKCHNiY9+iTdNC8LP/pq6C0AQ2qTU+FEiigrrMVsMAJie1g3U
	 p8yRXTR5qxmGY0lH5ZsQlnOZmK0x2DBkO4V9xRrzmo7H+JPXLPZ20FaH5HsAugCY1xEAl
	 rXdoBkyVcw0yS0qrl5PDT5BmEru8uc0cKi6ZvwDB9Ap8O8OnMqwikbDIaMesDkG+shA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608180;
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
	bh=vWTqbiKHqXrdvCjIjlAuFlbadZBAXvaeJ32YATNi1M4=;
	b=eRXDumkA7E3d/nZgMDlRLi9NKppfda58+Cxss4nOcyhu+P5+JgmA1h1T/qMuCd4z0ove
	 f+zx6ODoZcRq6XeVNnQfkDIQ0oiQ7RlyIZBASRZGCiOg5VtfqYzCoKUeKJKcgSpOUOjVK
	 XpDFKrqRSP6ApgaBCFFPszWnw4CSXIf4YYzVX3qYJwwzVTAV+1IkjhFAAXnJSTPtfEaK5
	 gXc88c9FkFMvmSZJPBUyT5hRW9Vjg67mTcC3ymCtGbx0D9gvZtVZV9ZnJ4Fvq/ZOkAytf
	 4pZaHub1nq1tR9nEJUukjM8VMzyc0NdfRubpWGzAWgaim1/5xty284df3v53nj9j27w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2Z2hGk62;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.39
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE19606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE19606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2Z2hGk62
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxSvpk0t1C9FIukulOwSZK96rSoczf1I1f1BM49scBo+N78yoYiEcoP9DsI1tUAMKjE+hoo6hccgZR+dtNzM1mZkZt6BqsKPD04OGXZut75ja1+MXpf+6vP+nPWz9NUU3MTy+tvXiQPhgUSKbAIHptriS1C9ETEWJDe7EN5nha0/orrXIddkTSyKOayKWFyHELymosq1PlkkLbpLDBFNgdMXNuXpTYRbuCbF51boqRbFmmvKj2xWjH4jVOpSutw8RpGOk/1fgznj7sGYqCpPnGTx1Uj8ureKvM6BQe7UMLFu3fRbMwh2VsKK3UBzzeXBR2OKNRNOzpH+QJr7f57zWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWTqbiKHqXrdvCjIjlAuFlbadZBAXvaeJ32YATNi1M4=;
 b=SkeSZNVM0xxHjqAyYMQ/jAnvm1R2ymnkODcsfBpMnQ77s+4ms7RvDexWo5K79VJCWJwM/V20aNxqQf01iLqSFBkyGIyh8yXBpEGaRozpk/cN3QhZmeZwESLeDdBe/Js5i+T+M+At6vcKuZXhv0p3v1rLgj+/rixOujXUFUpJmPgLqgCZOtwpy/q2s25RVW+1YQuHo9Q23IK1fM4zO31DVi4gZTNuDTooT7GkfddiXzss5awh4yOzxYiX6BNPSEBtRDl2hd0dioLKhhF8lAqWo2Xb4geQXjfIYg7XdMoC0jFsA5xKgClrqZnpsHE9uUlIOIv3aq0BP4Mt66JgzgklnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWTqbiKHqXrdvCjIjlAuFlbadZBAXvaeJ32YATNi1M4=;
 b=2Z2hGk62ywRkn3tco+lCKV3ST9R7KLvINokEAdWL+9LQlFl1XjgZ9RTxGuq1wAOXjDr2se2QF2KgEbwlMrmYo9+iHiRwz7mxyQnZ9D44hFeVVZSocn1Fyj2Of457F0/octEczBjt12nnfvkcSDdl3brOJdXNQsxv0ASt1jqNP+A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 18:42:51 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 18:42:50 +0000
Message-ID: <88b8a710-7674-49b4-9bff-13958f97fe7c@amd.com>
Date: Thu, 22 Oct 2026 00:12:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm, drm/xe: Don't invoke the OOM killer when
 evicting VRAM at suspend
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Natalie Vock <nat@pixelcluster.dev>,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20261020100504.46684-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20261020100504.46684-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0182.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::17) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
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
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 7100afa3-f0dc-4843-72c3-08df2fa31c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261021123027099003|56012099006|11063799006|5023799004|261009223027099003|22082099003|18002099003|10067099003|6133799003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	yFpjJuB0/bkCZYjpPusC/ft8hYDap5SluVzwEZZXGOTZb4PqjfciGdJipWDF46zM9N78v8NyxaXuZ0UNOPMf7nU5ClivZfLYq0oidNbf0CEQoDu6mcohI2xvxUJxrYJyVXuXScmsL9oYnmmsQp18k/wYEtpnq4tuCAsdq3BNquYUU2y7Ag4gTTAHmyj2XEn+qxX5T5zpARRU1NMHa0ke7JfY4PbfddqA61v/f414ZXUqjwZKVONvipF9Fy0yjXStui3Gsbl2usQMEqCNCnO2oVRtsL3yv24QcRbvTSGEi3WPesNXKNqqVXlExOs6zjdAWwmE+euvSFIU4qdfZd/R3UUHSFarTfaG4rb2g+WCc5CML2kWsA7rSDW4BbH5PTnf2uXvnlG5A2wrHgDCegGVIGxMBKGIswnLxQfBwAHpePXRJHWh+tf5VUVuE/li5Yh6aLlPle3k8VpkQXBM2rZr2x1HIB9dsyfpXAhXk6wDqDhK3rFxYllI7Q6h+2LHytuuUozhYXTuW7Yuq5NsiLlnxbmTf06kQePwFVArD94N/5hgqjl1B7QpnBZba+gErh9TX1qWqiNVeZkbA7zv+IL9UHfHzGz9Qyq9lS/PlMPDcGueIVa17TkWuPMhAS3dKj8c
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261021123027099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(22082099003)(18002099003)(10067099003)(6133799003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2Qrako3amtUZ2I2cUVMaER3di95RDVieVprbXhnMFhoaE1MeFR5d0hLY21G?=
 =?utf-8?B?eEVzRGpVZ2R1azUzdURZb3BLUmRFek5KczFLSVdzaHg1Nk1qNEZ0WmhhaFdU?=
 =?utf-8?B?aFR0dU9JYVVQRUpWR1BTczJBSisrNnR6UFlUQ2wvZjFwSFR3WHBvbUc0UXpR?=
 =?utf-8?B?VWpXQ1NFL0RWM2VmdTkzSG5aWWFudXFZSnFEYXZYUFRHRmZnRzNCK3NNNUky?=
 =?utf-8?B?UVpJS1BGQk9UNnc3QkVXWFh2a2Q3MnFjMWdLTWxUaFlKS25JLzZld1J0aklx?=
 =?utf-8?B?akdlQnlmTnVvY3pQYW9NTUN0bG92RmwwSDR3ODRYOXl1c0EzK3d3VndNTzJ1?=
 =?utf-8?B?MDNGY1dlZDhveVdlakVrend5YVNuSjlOdGIyWVdxVERQd2s1OHVOWnlsYVlp?=
 =?utf-8?B?ejNwLytLeDVYamIrYVVoSXRuaDFzQUpHOXVXbUd0b2NMcFBCNGY0em50Y1FI?=
 =?utf-8?B?R25kc0ZNRDVBaHNRTGtubXNpSFdNcjRVM1hPT2VBL3BkY2FnbFFWa2ZMcTFz?=
 =?utf-8?B?WTBVSndhQUc1SEczZ01NOS9sY2xMQjVwQVRCVEpRY1orWWFneFFhY29WNkpX?=
 =?utf-8?B?eFBsZmZpMzRhR0NPVkZKa3d5YlV5Q093SkdjMlJFb3ZxT1JSQWlLRXh2dm1O?=
 =?utf-8?B?clRLTkltTUdDSHlhNnVxSU12RXJOSEZZWnVQR09nYjR6SXIrM2RSSVd0Uldo?=
 =?utf-8?B?U090WWJOekt2OFc2TnJjUU1rTGlXWE9keDVkaEFJbndEVi9IQUJzM0lpbXNY?=
 =?utf-8?B?STlrNjVtZVBRMWRyMWJwRGcwK3l3Q0dNejgvUnhwdzN1bUNGcnFVUG55OGxF?=
 =?utf-8?B?ZzhWSzdBT1NYdVo4cXZ0Um9FaXNvVnE0Lzg2bS9Ib0FRbU9hVTBEb2VDYkow?=
 =?utf-8?B?RktXRktjUUFWMUVEcXBCQmloeWdvUjl4Sm44MDZCSng0WVdpeGFJYkJZbjdk?=
 =?utf-8?B?R2JRZThZSVVMQzhvOTJUc3R0RHJBZWJIdUpqWVVUZXhnTC9hd0VwRmJwbzVX?=
 =?utf-8?B?UE1Udjcxd2hwWjhqSVRnOXRxZmVIdWlvcHBhRWtITU1PZnh2dHVoMzEyVVV1?=
 =?utf-8?B?c3JTaUVONk51VlQrRE1YRXA3ZytmUk41U3NJMkpDUVYvbS91OXFEUFVnVGdQ?=
 =?utf-8?B?WThqYk9ySytJdWFNY1dUM3UzRlppckhFWVl4ZlJMYUZ4RlI4c0NlL2xJMG5R?=
 =?utf-8?B?TzFxMHBGSHloTFd4ZVliSWhHelU5RFFOWkxyZG0zQ2NXMUtwK0pUM1VQaHVz?=
 =?utf-8?B?YUc4QmhkVzFYaWhoRmxOZ1o1TitReVUrYTQrM0ZUNVY2OEtlMEtsbDZZSFox?=
 =?utf-8?B?bjhVMUEyK1ZYSThMbFFaSjJaOW0zTmlldWFHSys5R0J0ZVlmUUtSc0hpcmJl?=
 =?utf-8?B?VGJWSjRnMHFjZ2E3Nk9tbkxTaHcrQ1FhWkd6eE1MSk5QYnM3MWFnWEFRMHNQ?=
 =?utf-8?B?VXBIejU0SkY4TnFZZjVWdkdHNWlFYUpWVFV1K0hvalRzKzVIbHZVb011Y1p0?=
 =?utf-8?B?WmliaGVQalBJRmtMaFBoK3o2UVVyY1NlbXpRR2xOUFU4dVVLQ3lHcE1OempR?=
 =?utf-8?B?Y2VQcEhOWWN4TjJya0lRcnVpd013bHlJRDkzalFWMldFNE9ncEFzelJDdytv?=
 =?utf-8?B?K0llV3ArVk50ZWdWMHc1K0VMWk5rRlA1UVA1RjlGOVEvMkJBakVRSG1vWnpV?=
 =?utf-8?B?T3hld2tMYzlIK3Y1blNNeG5hejZqdytVN2hUbE9PUGIzckYyL1pHRTdPMjVV?=
 =?utf-8?B?UW1hWG9wdVBKMUpGL0lwT0d4S1hxWFY1SHZ1Q0dzekljaHUwTTFCUzZ3bVc0?=
 =?utf-8?B?c2NCa1pVN3IxQ1Q3UUN5bWNpR2ZkNHA1bTFobnc3dGRWM0pPNlY0dXo3T3A1?=
 =?utf-8?B?M3B3OVlDN1MvZ211Ymp2Z1hYbVExcFVvVVJIVGl2MTBVQ04vbFlmaE5oQWVx?=
 =?utf-8?B?RU9VZnFuM25qUGVMdXFRTk1LdEVFWGptajQwZUVxWVBhbWkxNTRUYUpkUjlK?=
 =?utf-8?B?QksvL3Rwb20rZERHb0V4allUZFh6djFWaFI0aHR6ejhoeklrL0FlS01TTWVQ?=
 =?utf-8?B?dHBWTFpoVWQ0RzBuaGVSendVek83aWNYb1lwYnNLZ2sxdzhwZExzL1cwb0Y4?=
 =?utf-8?B?NnQ5UmN1VHJHRnZOSUxhMmVwSm0yaU9CWDNrbTMxbWxDQ3VTUDB6ZmlPMWVn?=
 =?utf-8?B?VXN3YmthTkZUM0E5aCt2a21sSWJDODU4amZ3L1JYVlhhdVdWQlBUa3F6U3Ey?=
 =?utf-8?B?Z1JrcTRHaUM0NGxIWkZ1blo5TzJTd3FWUnJXdVZjWGNiSVZqa00vTll6a2xy?=
 =?utf-8?B?TjRreWVwSkl3ejdpcEdnTnNFQVVPbHQzNTA5Yytza2FUUkpyMzlFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7100afa3-f0dc-4843-72c3-08df2fa31c1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:42:50.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZizapheuUSD30lYp9+MF2BvpGex3eB3T74j6OeMy0bJvFLeMWWzHwj9GVgIEDyWtMv7APuUi/BfT0ADd9uq/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711



On 10/20/2026 3:35 PM, Thomas Hellström wrote:
> When evicting user BOs from VRAM at suspend time, allocating system
> memory for the eviction may currently invoke the OOM killer. Under
> memory pressure it is preferable to abort the suspend and return
> -ENOMEM rather than killing processes.
>
> TTM's ttm_resource_manager_evict_all() uses a default operation
> context, which doesn't allow the caller to request
> __GFP_RETRY_MAYFAIL allocations. Introduce
> ttm_resource_manager_evict_all_ctx() taking a caller-supplied
> struct ttm_operation_ctx, keeping ttm_resource_manager_evict_all()
> as an exported wrapper using a default context so that existing
> users are unaffected. Also honor the ctx interruptible setting when
> waiting for the eviction fences.
>
> Use the new function from xe_bo_evict_all_user() with
> gfp_retry_mayfail set.
>
> Note that the PM notifier eviction is best-effort and ignores errors.
> Any remaining BOs are evicted again from the .suspend() callback,
> where an -ENOMEM might then cause the suspend to be aborted.
>
> Fixes: c6a4d46ec1d7 ("drm/xe: evict user memory in PM notifier")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Natalie Vock <nat@pixelcluster.dev>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

> Cc: intel-xe@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9615
> Assisted-by: LLM
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>   drivers/gpu/drm/ttm/ttm_resource.c | 37 +++++++++++++++++++++++-------
>   drivers/gpu/drm/xe/xe_bo_evict.c   |  5 +++-
>   include/drm/ttm/ttm_resource.h     |  5 ++++
>   3 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 4e6d3d658d85..5296b32a2e92 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -568,24 +568,26 @@ void ttm_resource_manager_init(struct ttm_resource_manager *man,
>   }
>   EXPORT_SYMBOL(ttm_resource_manager_init);
>   
> -/*
> - * ttm_resource_manager_evict_all
> - *
> +/**
> + * ttm_resource_manager_evict_all_ctx() - Evict all objects from a manager
>    * @bdev: device to use
>    * @man: manager to use
> + * @ctx: operation context for the eviction
>    *
>    * Evict all the objects out of a memory manager until it is empty.
>    * Part of memory manager cleanup sequence.
> + *
> + * Return: 0 on success, negative error code on failure.
>    */
> -int ttm_resource_manager_evict_all(struct ttm_device *bdev,
> -				   struct ttm_resource_manager *man)
> +int ttm_resource_manager_evict_all_ctx(struct ttm_device *bdev,
> +				       struct ttm_resource_manager *man,
> +				       struct ttm_operation_ctx *ctx)
>   {
> -	struct ttm_operation_ctx ctx = { };
>   	struct dma_fence *fence;
>   	int ret, i;
>   
>   	do {
> -		ret = ttm_bo_evict_first(bdev, man, &ctx);
> +		ret = ttm_bo_evict_first(bdev, man, ctx);
>   		cond_resched();
>   	} while (!ret);
>   
> @@ -600,7 +602,7 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>   		if (fence && !dma_fence_is_signaled(fence)) {
>   			dma_fence_get(fence);
>   			spin_unlock(&man->eviction_lock);
> -			ret = dma_fence_wait(fence, false);
> +			ret = dma_fence_wait(fence, ctx->interruptible);
>   			dma_fence_put(fence);
>   			if (ret)
>   				return ret;
> @@ -611,6 +613,25 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL(ttm_resource_manager_evict_all_ctx);
> +
> +/**
> + * ttm_resource_manager_evict_all() - Evict all objects from a manager
> + * @bdev: device to use
> + * @man: manager to use
> + *
> + * Same as ttm_resource_manager_evict_all_ctx() using a default,
> + * non-interruptible operation context.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int ttm_resource_manager_evict_all(struct ttm_device *bdev,
> +				   struct ttm_resource_manager *man)
> +{
> +	struct ttm_operation_ctx ctx = { };
> +
> +	return ttm_resource_manager_evict_all_ctx(bdev, man, &ctx);
> +}
>   EXPORT_SYMBOL(ttm_resource_manager_evict_all);
>   
>   /**
> diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
> index 7661fca7f278..a37316a27573 100644
> --- a/drivers/gpu/drm/xe/xe_bo_evict.c
> +++ b/drivers/gpu/drm/xe/xe_bo_evict.c
> @@ -114,6 +114,9 @@ void xe_bo_notifier_unprepare_all_pinned(struct xe_device *xe)
>    */
>   int xe_bo_evict_all_user(struct xe_device *xe)
>   {
> +	struct ttm_operation_ctx ctx = {
> +		.gfp_retry_mayfail = true,
> +	};
>   	struct ttm_device *bdev = &xe->ttm;
>   	u32 mem_type;
>   	int ret;
> @@ -135,7 +138,7 @@ int xe_bo_evict_all_user(struct xe_device *xe)
>   			continue;
>   
>   		if (man) {
> -			ret = ttm_resource_manager_evict_all(bdev, man);
> +			ret = ttm_resource_manager_evict_all_ctx(bdev, man, &ctx);
>   			if (ret)
>   				return ret;
>   		}
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 714c533622c2..6cf9187a12eb 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -42,6 +42,7 @@ struct dmem_cgroup_device;
>   struct dmem_cgroup_region;
>   struct drm_printer;
>   struct ttm_device;
> +struct ttm_operation_ctx;
>   struct ttm_resource_manager;
>   struct ttm_resource;
>   struct ttm_place;
> @@ -488,6 +489,10 @@ void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *man,
>   int ttm_resource_manager_dmem_reclaim(struct dmem_cgroup_pool_state *pool,
>   				      u64 target_bytes, void *priv);
>   
> +int ttm_resource_manager_evict_all_ctx(struct ttm_device *bdev,
> +				       struct ttm_resource_manager *man,
> +				       struct ttm_operation_ctx *ctx);
> +
>   int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>   				   struct ttm_resource_manager *man);
>   

