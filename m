Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DE2EDD53
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150043; cv=fail; b=H4aifYtKyOm0EJbUPEntrL0vCosG74BbK7fmGH8oXxvysCrZaUUv5wYqGaKsCwgYT2Eiv/S14mF8OF7dewe68GL1md94qi/8JjYYFLT/V40CV5REMh4Ttb+YAGBAZ/YYsuAz0AKRjHtXrNX9UlM/KtAkn5c3lnerG54pttPkmvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150043; c=relaxed/simple;
	bh=N95GnPUfBH9b3vZYjOPTplwEQ2XHc0hKYcXZsCOCydo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DIWO5Ep8bGX6mhkCAq5WgPSVqmNEcewNm/kDIYbELk+s2du9zOR0Avk9JNNg/KjQ47Xyp75iiPVPSe8Q9Jwa9uqNt9hziGxoVQM2kCqVAQwUxTkR1OxpAAzDi1bnnic/98EEVcEMz/HKWOKlH3LKFTfobQN95cqvJbsOrBjRxx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DdGb269V; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DdGb269V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5+OeD9Q8mZEq2n1x0doyyHzhEm6X397kULuJvRXNS8afEOEeIMzBYkXsU0I1PRD+dG6U6CdKx5O3F6TuKLl9pCWQUA45pJn8caByqJrvCVChQI/7fiCKmOnTPgDAzbIi4TPBXljiMs0Dbfa6BJkHNfvCj14FgjXYu+Oq+o1tJXCCy3c2wWHAV39+KfUpXkMXXvv4QtNIV+K1tJmqXEDHeso9h3P/fU4h8vO5mmwsWInS7IqeeVyiKlRxx/+dlrAbRjthVCFlaUYfVyf4RwHV9Ir+Dmi3Y2kFd1cgkOIFIlJIZ5suQhIjTzHqkY3bt3cI737roDactEXqgQGhe8OJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmC3k+DGxwd0erPZ6Jg3rRzZ6icRHpZm7zlCJj+SK9g=;
 b=kKmAxaeIzhPl9hQbfeS4JBbztBcZJ+XhdJAZWM81lDneUDeqhH7sdsjHDnNQlr2fbUX320UbetqNEh4H3xSVPJ8chIc5JuGrMDv5k9YbpZeRoWDr36yDPnQWUu4UOzhBkHHSthq0wWx3Sk89oeeS/eAJajGnmVQp8N9hnB+RoAX7y0khv5ZeU/wJW6t9UYcsFJ/8wBBYId4+QgvKfE8sZt3m03cBlrQw+9Xeo31i4tTsIDnI/pr8UzTMsYJM4HaFV8wuRQX+k3O/L2wnqiRNRZUlNloxw/JmYdSMAtF2cz9ku9vYeckBz031EZdpIXlOpgimiSKh1YX2rnj27nBTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmC3k+DGxwd0erPZ6Jg3rRzZ6icRHpZm7zlCJj+SK9g=;
 b=DdGb269Ve7nXRRFyNb8J3fg/n+BPA1QhhmxdSHYaZdZO9V0bzf2sbQinlZFX7Z+1Lw+V5bF09vqfW6LkwHKBuEHpRmr7OapnMBNhpJOKnXk62S/69PgwsPlIUgx1fndaq8vTWpjGGxgfAJ55qj0CfTUdIVVFVuYfRmV9AissGJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:53:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 07:53:58 +0000
Message-ID: <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
Date: Wed, 23 Sep 2026 09:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
To: Greg KH <gregkh@linuxfoundation.org>,
 Vadim Nikitushkin <bub4z0r@gmail.com>
Cc: stable@vger.kernel.org, thomas.hellstrom@linux.intel.com,
 dri-devel@lists.freedesktop.org, skainsworth@gmail.com
References: <2026092253-dimness-unethical-2515@gregkh>
 <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2026092320-reentry-lyricist-330b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cf2b0b-4e44-4680-88bb-08df1947d2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pjrSsFHg0eO38Lvl3m87t+EYh0AUtkBJaooCDlcLLjkrj786k7lGJNm97/yKeyBo+C603OSoBnwKF4g7Y9NgpHJoHMhSg8Ojl6yovVYMPNkUd3ikP6Ojrd2HqZGTPRgW+Qi16YPqBa9JeVxQ9xKAxnGQMaZg6J4onGzotN4/8Rk3ppUHSWfnVcTMwKhyKWRvUwn/xgZO0NS3qInGqoQevhwN4Hh/GLMzmuxDHnmeaxPGrjqZPruPRuQQC0G2sv7exriMsOXdVDHmWXKZpgpkqBhJV7kZsDyNWC9ZoAqW/TOtS4C7yQZLmKPOJanZ71yoPrsf06lYs0hoE15IavvugL9yER6wYOTKUYyRUAmXVIH7+4mDHm7iGeMkWakbrF3q3pM18ZB74L5vHNJovLfGuNkmoMnTxIqCe7N+R0tWlMWXsRLxnoeH5Mv7Du3RrhF/xECdMs3nsVZBKm1LaRpn/5kRWAz9K6NOhsQIcNHHpYMFrpEKA1vTJxBhh7cF6G65E+a/9Fu43rlUNfFr9KqrgFw5uq3hMZEAsyCmKNRQfgad6ZuZT3HDReF08xpxJsw47wVAwqpLlQgwNdHu1jfes4gihnDSbHnw+wxn384dNUqo/yM0ZW9ubxcw1ihaEqLC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2IyVWtTRWlja3NEMWp4dGNZenVXRERIcjlZWlVoN29sc2tiZE1waWV3RXpI?=
 =?utf-8?B?ejB4TkNPUWVTZG5wK2llM2I1RmhwUThqTFF5TjYwM2JpSGlLM253YThaMUZv?=
 =?utf-8?B?d2RRTnRDQm9Cd3dPSGJWNmE3U0hzcXZMencxeTA2anVFMUlSQVY5QnQvZkFO?=
 =?utf-8?B?azkzUk8yNFViVUpmZzdITTQwMTltdjRjd1owL045K2FYVThPa3dTZmxoUTVs?=
 =?utf-8?B?dG16OS85dVdJK3ZiV0xBTFFHSW9hVzJjVXlLQk5vY1BnbzlqaGNqWnJMY1Ru?=
 =?utf-8?B?WUt2SkpsZGlKQ2RIWHRhNzFWbUFmVUllZFVxVHBoakZJelI0RG9aYUhLV29t?=
 =?utf-8?B?SjBTbDBMcUlWQzZIa1gwbkM4a1Fab05oT3JXdWFVTFovQm5UNXdPTTMzcUtn?=
 =?utf-8?B?MnVBZkhLa2hCbHNFenM0NDZ6L3ZJUmx2TzFHZHI0UzdHaWVIc0xNY2JhWkpK?=
 =?utf-8?B?NnFIOCtQUFBxRDFvc0VtNTMvV0tTTUhXQWJWUmNDVFZ3RmwxZDUvV0M5QTdH?=
 =?utf-8?B?cXBBcHREYmprU2ViOUpPcGhFaVAyY1F0b0JRb2UwczlRSWVOdnR1SUg3Rkc0?=
 =?utf-8?B?NTVudUdtV3lHOEJTTVQ5ZHFqSlNDdWlMdUlneEtkYWJIMk1qQy9mcExSMFpX?=
 =?utf-8?B?eFRlUVFua0VSQ09DRlZVOXlRUlp5NlRrSlFPK0hmU3VQRmNGaXNSYldkR05y?=
 =?utf-8?B?RGZwRFJsZm1tTDRDUXpxWmdLN05aUEZOU1M3NEs3eG1OM2czUXpSV21mUng1?=
 =?utf-8?B?ZTFJRDl0ZW1OTjhVQnBEZEtvdWVyclptTEJwNzBYaE1rR0I5MUxFajNZVWxx?=
 =?utf-8?B?OGRNT2lGbzFXMjVMSGVtRnpaY3pOeE5wT2lhMzhiSjR5MzVzZ1hheC9KWGJZ?=
 =?utf-8?B?YUN6eWgyMW5zTkRYK3dqRENRQ3NqU1dWdlpJbU54Yk8vL3Ria3IrRWlja0t2?=
 =?utf-8?B?YWF1UHN5VlpndVZVWjc4K1VkL0toUjJPVkx1N2VueWRWcm1Ya3hKMjFBaWdF?=
 =?utf-8?B?bmxmMHp6dGZZN0FnT29qZ3ZSVWM1cWovUnRzRzJHVlJ0azVHaU5DaDVlcUFO?=
 =?utf-8?B?V3FMSnp3ZFlVeXFickZMa3FZUmtOUGVwL3NGcGR3WFQyU2l2N1pXV1dwZ2pl?=
 =?utf-8?B?YW9VS2NZait2bUxRQkdlektQOGE5cTl0VkgrSGVVM1orMmFTdUt4VmFUQ0Zr?=
 =?utf-8?B?cm94VGpQQWVPUnRibVo1OGZXZUNCYm5jQ3BFaTNZVS90a0xIc2tOcXhXWERW?=
 =?utf-8?B?WUpnaStGeVZtQWc4a01tRTg4cFVLczB3RitKTVZ5U1NLaExIYzNwVm5LMVJF?=
 =?utf-8?B?M0NQbVJLNGVzVDdqempIWEt3S1Q4RlN1enRLbGJ2THAyU0JMVnpqOFNVNmh6?=
 =?utf-8?B?cVR4WlJjaG5idkx3R1poU0JGV0ZJNU5WNXRkV0lQcW45K2hPeWo0Mkk1ZEdJ?=
 =?utf-8?B?M0lZYm94Vi84T2lTbEVJaXBFQ1BJTUpMNk9WSWdrVHV2aDZldVV5SENKeTdK?=
 =?utf-8?B?Sks0Y2RDU2lHeFo3eTN5dGNnOXpDTnIvaVdFUzhXT29Ud1JhODh4Y0czS2RE?=
 =?utf-8?B?TnJMbDdaWTJITUpkczFCWWV4N0crVGFwT21BUy9DYlc5WE1INTR5V2RhRlJp?=
 =?utf-8?B?Zms2TC9JZkNQVEEwYnRpT2FWL0xBV2dsUlp6eGtYQjBXc3FNK3lUaG0wa1I4?=
 =?utf-8?B?cFZUZTVqOTFzN0Q2OXNuRnFYNWlFV3M0MmlYcSsxKzgxMm16U1RocGloeFFU?=
 =?utf-8?B?OUFJWWJHSDYrL1dacnZhV2IrZjdlZWlWVElLd2s1aUlTS0pTN3RVb0svMDkv?=
 =?utf-8?B?TElqcHpIK2ZIRWREbkgrWGNmVUxkSkhnYWJ0VldKaUtqZ1VnOFZ6eHlEZW5C?=
 =?utf-8?B?MklIbjlsUDVkTUdzWjBjOEZ3ODVIU011OEZ0dXAvTmFWNktDNGgyNlh1ekZ1?=
 =?utf-8?B?R3NBaWJYVWZvZnRDNW5VSzFrUCtqTjlBZ0ljQUF4MjNheDJqVVFtclpHT0V1?=
 =?utf-8?B?SU9ISXZmcEszYkxsNW9TSHIvK2R5akc5ZHJhWG9sK2ord011THdqb3JjT0ww?=
 =?utf-8?B?VXIrUG5reW9tRWsvbUpDWVBKb1VxSUc3M0RhOTUwa2NQcXJKM3RPZDZQQWs3?=
 =?utf-8?B?SDNna1FpODVuLzZtUFQ2R0h3cDdnbFJkWTBrNkJzS2JVSVpZUmIyWkJzQlQx?=
 =?utf-8?B?emhQUEFWbklnR1grQVFkSE53bldmTjd2dTR3dGxwb2hmVlhDQ0cxOGNiZzk1?=
 =?utf-8?B?ME9EOUdGVFNrZ3YyRTlzWnNRM1lwTVpWSllKRkNBVm1lLzI4cEYzSVBhdUJD?=
 =?utf-8?Q?jVI1yYct9V02vXKKxp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cf2b0b-4e44-4680-88bb-08df1947d2fb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:53:58.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPfab2I/3I1OqIpz1zSWWFUDWStPl5UnBJwlmusUWwzb5uMOIUBr0omCkNSa2gC7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683

Hi Greg,

On 9/23/26 09:41, Greg KH wrote:
> On Tue, Sep 22, 2026 at 06:33:34PM +0300, Vadim Nikitushkin wrote:
>> commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8 upstream.
>>
>> ttm_tt_swapout() returns the number of pages swapped out on success and
>> a negative error code on failure; for a populated ttm it never returns
>> zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU
>> walk on swapout failure") moved the bulk_move bookkeeping in
>> ttm_bo_swapout_cb() under "if (!ret)", so the
>> ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_tail()
>> pair is now skipped on every successful swapout. The equivalent change
>> for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink()
>> infinite LRU walk on backup failure") tests "lret > 0", which is what
>> was intended here as well.
>>
>> Before b2ed01e7ad3d the resource was taken off the bulk_move before the
>> swapout; since then a swapped-out resource stays inside its BO's
>> bulk_move range (and on the manager LRU) although it is unevictable.
>> When it is later freed or the BO leaves the bulk_move
>> (ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
>> ttm_resource_del_bulk_move() skips it because of its
>> !ttm_resource_unevictable() guard, so a range endpoint in pos->first /
>> pos->last is left pointing at freed memory. The next
>> ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cursor
>> is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(),
>> "list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
>> dereference in ttm_resource_manager_next() -- minutes to hours after a
>> hibernation, or at process exit / reboot following one. Samuel
>> Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
>> dangling cursor; the missing removal at swapout time is the reason it
>> dangles.
>>
>> Testing the condition for success restores the removal. On an AMD
>> Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate on
>> a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
>> crashed 5 of 18 hibernation cycles; a function profile of one
>> hibernation showed 336 ttm_tt_swapout() calls and zero
>> ttm_resource_del_bulk_move_unevictable() calls. With this change the
>> removal happens for every swapped-out resource and 12 further cycles
>> were clean.
>>
>> Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure")
>> Cc: stable@vger.kernel.org # v7.1+
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
>> Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
>> Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
>> Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail.com
>> [ Squashed with commit fcfe64715b425262af1b36f498f9197f3537ceed
> 
> Do not squash, send a patch series instead please.

in this particular case that squashing is the correct approach.

AMDs mail servers mangled the initial patch so badly that I had trouble applying it and ended up pushing a broken patch upstream. The squash is basically fixing that up.

Back-porting each patch individually doesn't make much sense, you would just end up with a broken tree in between.

Sorry for that,
Christian.

> 
> thanks,
> 
> greg k-h

