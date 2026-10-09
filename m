Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550134CDA22;
	Fri,  9 Oct 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555262; cv=fail; b=c3WLXylZrNwJD477onzGhyRWo2OTvN6eQ6KWAU6K9OiDA8GH+fV51Tkl+7U0UOtKY9J3iUlyb6HDawliG+kpJ6Z3NWzYS/R5GnRJ6YRx628GNLgyhkZ7s6OYPx7X9D2HKXwKAd48++vNuBBtH74EEwEwbef0dKAeRxiYlHZT+8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555262; c=relaxed/simple;
	bh=D3AK68vaFEmIPdp+vk4Tntdvmg7JQ5KD04IUSCqSba4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J/KVa2FCRqrvCxsheETU5UGL4avG3E+pezJX6DQMKONU2ox2pTTfboJ5BCjC2J5TvqjPpwA2SGDwIj/2JHytl/TE3adb93e9/NclZ44yiwCL3urNk6TcM50S6Mt970pENgU7Vai65o48/qUZIFKPqb8vW/NdBdXr0ZaAabeHBBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AEbB1kXX; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AEbB1kXX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lK1CQH9HC+WlLIf9Pmn+JGevOARWRKVXXmxpMRXbHdxPCm6e1Q9KDHmlebGvRptc8l5VHWCTUBNz0QLl6DCyjgZRBxlC1ZnrJI7dNWKHvZ2MBAQydmbLUAJ5DAdn5KVBHkODcj8W8uySORVzFHDar8Cpf7CY/UQLYJ7MXQ2vdED4LVbhjMYqZbWFixT/FbTDqO+hUUvM83baciSHqTWN388yzLSNcencYM4SeHP/RilCv0KYewl3hPfCftNn12B6h1YLV8w5R69GX4NHnIR30x4+6rW6UXPkRLJ7TR0LpvldECYRkgZwadcJIFXFwUb2UCdZ05NZuDT9g7hd7Rkdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TFpuKuIyNbGE09Ek1a/p+VHQZELTmZ3qJvrslfC/lk=;
 b=xkBVv2s8b9VS/1INidOwzmvG7d6eO/J5Vyf34W/rA2ll8ZnQD6PcxvB5Grkc1tFHRijtN2/Zkv2EcItHJVUx/rZPnCrPeOaXeFTnFOfeYYrp6vdenqmwslZ7Gx6DsXAaDC+bxCyBf5YeErRZ5o0dyYeDnzyRdupDKtglcaYrR6FKdeTJjQyQY5tawixRNZoMX1v1zK9peZPqlDxCZ4tKS/Uk8Sh6pPkBfGPpLxyrq9kSQOoZe3SKnrAppdVO23uENjRbSxsnN3dcTe41ARz3pE7rSs8010mu1DDisMj4cmsXvsO6NXyTYJaurkuzBMGFsgubwWY7l186IgukKWBwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TFpuKuIyNbGE09Ek1a/p+VHQZELTmZ3qJvrslfC/lk=;
 b=AEbB1kXX3jB9yjYzlouVAm9BZ3SvNRytd3QJwnnmJ/oZuP5vBCKgigFgpKWGx9l+UAFeVUjDjEFfSyxZ925rH8uRQHSJu3MVW2IVJbJiLPDMSu+hjajDmqxrmSM4HdqBHN4YS3ThuODcYw8aEfnNKhw0d6DB5KDfp2QmpMO50TU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA3PR12MB362669.namprd12.prod.outlook.com (2603:10b6:208:700::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:14:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 14:14:13 +0000
Message-ID: <2b0d0a02-99a5-447a-8e3f-6154b2660425@amd.com>
Date: Fri, 9 Oct 2026 16:14:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/loongson: Handle buffer mapping failures when
 clearing a BO
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Evanshenf <archwse@gmail.com>,
 dri-devel@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
 <20261003093415.902f89244043-2-archwse@gmail.com>
 <f25629d4aa3c0132275b0a798e1491119fa8d502.camel@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f25629d4aa3c0132275b0a798e1491119fa8d502.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA3PR12MB362669:EE_
X-MS-Office365-Filtering-Correlation-Id: 36713df2-4926-4bf5-c176-08df260f9869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6KlHF97+CaE3+KQ7Sjy41v0R3eh6czeRVghO96K2E1NZGs4IAbdAk+jypBbR1ml16tuQE4HPsI34Lyq7924kCkpBzwQvWdFQlPQ+qELxpj9E3n7HFiAlzlKf5fDP4jmwU4cHQSTlppA6lR3xknQJobaqO3eeBz08SiX7EL0qV7byQ/6MC18wIQgOXbDaxZOvsdfPOWHOFhQqmIgSEcK5sn3SzVX5G/n38UAgg4Hi+9xxukvq8ws76jd+QDYx+YRb0WlVBsgY8hZWLI0EJcCAk8h4NKhDW8ED0qaVK9ywPF26DrGmzqZW7aibhRA51swq6d+QVqnNsmkb9ll1C82xiYAhcE4zJlj6AyVzYXPE/vnMcrh4tv2LzNiVBz4388+Mi9kQmJJQ6GYl6jon9GNgkJSIt0EsbcHGz0n256oJsC8eP+/v/CidGvTPno5q11KHabgbIhlRVsbdc3e/e+H7Q6/n8rg1LpzoFy47Akam2oER+Z2/qEaec+w3R65lv2ZWsv3g2ZOqKDWyP3Vg5G61f9iS1B0CidmaTyLpQ+bGqwesjJABVNbCyxfL8R1zEafsdmuRB5k0QZ+luYn9qTuUgrKppFpRfYs16L1zScwfRcp16vt7T5Dzaxxo0qOYdA5iYbu3omMGVU2TAKRkDfWl/p5snny5teKxE5qQrgJnphM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3BWTmVFUmVZUHRqYnVuaGFvVktINmladkRCaVBzdExvTElBTkZOY0IvRVVw?=
 =?utf-8?B?cjdmM0IrdkpoQVZ3KzFBOXBOU25uWWNKbzZWOTdvUWIyOWxIemVmbHN4MXRu?=
 =?utf-8?B?bjVBaGFtUjFHdzBFVml3Q0RnazBNcXIzUkZSNDhaTWZDZzVHbWJGSU1sdEEy?=
 =?utf-8?B?cXNYcHhrQTc2ZkQyK0hISEhXOW0zOSttU3RKdnAxODNUb3pmSjlQMEducUpU?=
 =?utf-8?B?WXpzMEdWUkFwREFHZVlJU0Y0ZW1xa05hY3p3NVBndlV4dGczYVpOakExUDV1?=
 =?utf-8?B?V20yVlhxamFZckRrOXdoMDc5NUFML0dBTFd5cWd6KzRuUzVETDRsYXVCR3ow?=
 =?utf-8?B?Vnp6WlJLTGJvN1A4bGZwY3RENWVudGFPZnQ0NzFkWmdESllSK2FIb0I1L0M0?=
 =?utf-8?B?dVlvaVNHajFqNzlWUlhFTXZHNUU5YmkxdU05ME5BbGtuRituaUErTWZFOENi?=
 =?utf-8?B?Z1ZIZXdScnNjcXBtR0dTbHlYMXhIWW1EZFIzT2N5TWhzL3BDYS9JeENmbitq?=
 =?utf-8?B?UTNseFhmeUFRWERKMlBVdDk4MG02S2JNM3RhK25jQ2lhN3hFbnhEdVh4bVFY?=
 =?utf-8?B?RFo1cVdJV0NZaS9iZVBGWlRINGpZa2RrUWpGU3lLbFZUNjdmZVIwUWtyZElr?=
 =?utf-8?B?U3V0ZllETVlwdFhJS0lLbnpmaTlHS2FZOFp3bEZaZzBjanZOWHVia0U0NFpD?=
 =?utf-8?B?Nythc1ozaGtab2pYeXZxRTBndnZBanhZODJIV0d5ODlTVjBmdWIxQnVEd0pE?=
 =?utf-8?B?SW94QmFYaWl5emZHK29ISDgwbUxZZkRTSEhmcHpOWGdSZ2E0R1ArRW5YSGRX?=
 =?utf-8?B?bUlLMjlIRnRGTFNQZUQxNWxRQ3MwZnRJWEV2N0JKd2dWQURJT1hMOFhYRWxD?=
 =?utf-8?B?enJxU1Z5d3NDWW1lNUZRbnFCLzV6V3VPM0pDeWw2ZURrNk1sY2J3QjZLMkxs?=
 =?utf-8?B?cHVNS3RWTmdBaUhDRW0rSVRxNURMb0dqQ2ozUWRyRzFHNWg3ZFFlV25hY2Mr?=
 =?utf-8?B?NVBFaDMxb1Z6V09GWXRncUNZOTR6UHF2K3RNK1RsaU5rblJCZ1BuelFJcVJH?=
 =?utf-8?B?T0F4ZUhlTUVnT1BZc3hlYVJpejdhWVQyY0RRK1orMXAzSzlmL1dRdFBPUjIw?=
 =?utf-8?B?R2RmN1QycGxKMGlqWk1iTFpUQXlCSzZjNWZMMjc3UThibEJhd1A2NWJFQ2xx?=
 =?utf-8?B?Q1lEb1VWS25aQk1kMHpsZlVyUjJtWnJtWHIwY0pjR2xGK25SbDN1NGd6QVZn?=
 =?utf-8?B?TzQ2LzAwek10SUlxdTkrdmhoZTdPYzI3eUR5U0QxdkxpeXBEbVNHSFBocXZr?=
 =?utf-8?B?NVVFOWwwNEJjdHhKNXVtVDNLNUxBcnVWOEY5Q0xsQUE0elp2dll3SS9sNGRT?=
 =?utf-8?B?cEJreWNZazlOVE8rWjBjZDJSQmhSaWtpTzd5a1pNcis0NCt5OHpnSXZQVk1M?=
 =?utf-8?B?M0EyRzdicnQ3TFRxU3E0dk0rVkt2SmFmWnV4VDV3UkJWYWhsVTA2bFZVMjBO?=
 =?utf-8?B?cnU5SzE2UkxxN2NrNDhUKzVYNFhVY1VNUVFsbGRzZ1JFMWlCRTZRMkR1MUFi?=
 =?utf-8?B?Z0Q4eDJPejJMRjUxLy9uMENUQmdQSkptTG5kQmY5K1VBMm80SnhCSUZFYlo0?=
 =?utf-8?B?OHN0RkFXRmE4Ly82WG1vd3l2R3REVUoxdWhZbzd6czVBeFdBUkcxaG5tN0x1?=
 =?utf-8?B?R2xjcUdtSms5Y2hZbXZ6ODhFaTRMMStUQ0hmdW1jWkZpU3JQckJJK1ppbUxj?=
 =?utf-8?B?MERlbzQ5cExDY3cramdHVWVoWGs3N2Z5amRTejFSK0piS0NkZXZwNkE1MlZV?=
 =?utf-8?B?ZEVZTCtxRzc3d2FyTTkzVC81Z1d3M1ZBTTBqOEFXTjRQNzFXVSsxVjN3NjNB?=
 =?utf-8?B?eVl1N0c0QytQZGhMdXZkQXl3WFR2YjFqbDJseFB1RlJXdmh5QlFPUGgvMGJC?=
 =?utf-8?B?YnB2Nnd5NGovWnZFUHlLQkFZVCs0NytjdStuNGNZMHVMdHcxdG14SlV3bkJG?=
 =?utf-8?B?TEswc0MvVzF0RTFOM1dzZE41R2tEWmUwZ0J6R2h2Nm1EZ3I1TFpOYnJUUXk3?=
 =?utf-8?B?aE4zbklxNDh0STg3blozcTcrem5xTCtYSElLVWVXOS9qVUZla3EwT3VzUXp4?=
 =?utf-8?B?TitqWjVoQ1A3Z1VnaVVUbFJFcVMxMkl6bDY0WFhDMWJMRWRORWhkcFQzRnNO?=
 =?utf-8?B?ayt5WXZ4bXB6ald0d0ZlTVFmNVVZb09qbGd2cFJ5Nkp5T0RLS0NUdkJIM0lJ?=
 =?utf-8?B?Zkw3M2FIam1PaUh5NGRlTityQ2huWHBmMXoyWFh5dEswbXQwVDJxTlU3SlNj?=
 =?utf-8?B?RnlZeUIrWE1mRS8wU0ZMSzQxcWhSbWZPakExcFU0SllrMzRxazdVdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36713df2-4926-4bf5-c176-08df260f9869
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:14:13.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJrHhQvYy7Xhdm02qM9mkT86CkV3lR8/0a1mPeH6m00Gzl2YyeXMR0kz6PaMdPUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB362669

On 10/9/26 15:50, Icenowy Zheng wrote:
> 在 2026-10-03六的 09:34 +0000，Evanshenf写道：
>> lsdc_bo_clear() ignores the return value from lsdc_bo_kmap() and
>> writes
>> to lbo->kptr unconditionally. When the first mapping of a newly
>> allocated
>> buffer fails, kptr is still NULL and the subsequent memset accesses
>> it.
>>
>> Return the mapping error without touching the buffer and propagate it
>> from lsdc_gem_object_create(). Install the GEM object functions
>> before
>> clearing so that drm_gem_object_put() can release the buffer
>> correctly
>> on failure. Do not add the failed object to the tracking list or
>> return
>> an uncleared buffer to the caller.
>>
>> Imported buffers still skip clearing, and successfully mapped buffers
>> are cleared and unmapped as before.
>>
>> Tested on LS7A2000 with a one-shot range error in ttm_bo_kmap(). Its
>> -EINVAL return reached userspace, the object was destroyed once, and
>> no GEM handle was published. Normal create/map/zero/write/read/close
>> cycles passed, with the tracked BO count and VRAM usage unchanged.
>>
>> AI assistance was used for the lifetime analysis, fix, fault-
>> injection
>> tools, build and test execution.
>>
>> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
>> controller")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Evanshenf <archwse@gmail.com>
>> ---
>>  drivers/gpu/drm/loongson/lsdc_gem.c | 12 ++++++++----
>>  drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
>>  drivers/gpu/drm/loongson/lsdc_ttm.h |  2 +-
>>  3 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c
>> b/drivers/gpu/drm/loongson/lsdc_gem.c
>> index 2fb0348..9eba4e1 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_gem.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_gem.c
>> @@ -157,14 +157,18 @@ struct drm_gem_object
>> *lsdc_gem_object_create(struct drm_device *ddev,
>>  		return ERR_PTR(ret);
>>  	}
>>  
>> +	gobj = &lbo->tbo.base;
>> +	gobj->funcs = &lsdc_gem_object_funcs;
>> +
>>  	if (!sg) {
>>  		/* VRAM is filled with random data */
>> -		lsdc_bo_clear(lbo);
>> +		ret = lsdc_bo_clear(lbo);
>> +		if (ret) {
>> +			drm_gem_object_put(gobj);
>> +			return ERR_PTR(ret);
>> +		}
>>  	}
>>  
>> -	gobj = &lbo->tbo.base;
>> -	gobj->funcs = &lsdc_gem_object_funcs;
>> -
>>  	/* tracking the BOs we created */
>>  	mutex_lock(&ldev->gem.mutex);
>>  	list_add_tail(&lbo->list, &ldev->gem.objects);
>> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
>> b/drivers/gpu/drm/loongson/lsdc_ttm.c
>> index 88536e2..7b30dea 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
>> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
>> @@ -388,9 +388,13 @@ void lsdc_bo_kunmap(struct lsdc_bo *lbo)
>>  	ttm_bo_kunmap(&lbo->kmap);
>>  }
>>  
>> -void lsdc_bo_clear(struct lsdc_bo *lbo)
>> +int lsdc_bo_clear(struct lsdc_bo *lbo)
>>  {
>> -	lsdc_bo_kmap(lbo);
>> +	int ret;
>> +
>> +	ret = lsdc_bo_kmap(lbo);
>> +	if (ret)
>> +		return ret;
>>  
>>  	if (lbo->is_iomem)
>>  		memset_io((void __iomem *)lbo->kptr, 0, lbo->size);
>> @@ -398,6 +402,8 @@ void lsdc_bo_clear(struct lsdc_bo *lbo)
>>  		memset(lbo->kptr, 0, lbo->size);
>>  
>>  	lsdc_bo_kunmap(lbo);
>> +
>> +	return 0;
>>  }
>>  
>>  int lsdc_bo_evict_vram(struct drm_device *ddev)
> 
> Well I currently don't know whether the clearing is meaningful...
> 
> It seems that drm_gem_vram_helper doesn't do this.
> 
> Cc'ing TTM maintainers for an answer.

Natalie and Arun are TTM maintainers now, but I will try to answer here as well.

OpenGL doesn't necessarily require clearing of VRAM nor isolation of VRAM data between processes.

So it is up to the driver if they want this or not. Classically a lot of drivers didn't clear VRAM allocations until explicitely asked.

But if you clear the memory you should have proper error handling and a kmap/vmap can fail at any time for multiple reasons.

Regards,
Christian.

> 
> Thanks,
> Icenowy
> 
>> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.h
>> b/drivers/gpu/drm/loongson/lsdc_ttm.h
>> index 843e147..df47d9b 100644
>> --- a/drivers/gpu/drm/loongson/lsdc_ttm.h
>> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.h
>> @@ -89,7 +89,7 @@ size_t lsdc_bo_size(struct lsdc_bo *lbo);
>>  
>>  int lsdc_bo_kmap(struct lsdc_bo *lbo);
>>  void lsdc_bo_kunmap(struct lsdc_bo *lbo);
>> -void lsdc_bo_clear(struct lsdc_bo *lbo);
>> +int lsdc_bo_clear(struct lsdc_bo *lbo);
>>  
>>  int lsdc_bo_evict_vram(struct drm_device *ddev);
>>  
> 

