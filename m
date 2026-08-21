Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012016.outbound.protection.outlook.com [40.93.195.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9349362C;
	Fri, 21 Aug 2026 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334109; cv=fail; b=RqVLm3rOPrGkjYJfKcf6+7W0j/nXD/WsUpvzot0z3VhkfrH8BR6md1eghQauk59O6rK55TpiZ3Jn8MNz1nLeLoM8QNpQC4Ha0fTBCHcuafjNUdnOJHCG+Kx12OD0dmWf3zKWe+e+1W9FUNS6hUGKYWaXNaMirHlhpielaLPjVU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334109; c=relaxed/simple;
	bh=SjlsydcYq/WGLmbeM1RDGS6xX/hHbw6jsvy1JftnHh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pBq6LYx/tDtCxPErTE2g71N3nR2WLMhcCYHBP7wb9ZYa1HeSDrgghECoxvWzudSgzN6spYtUZmLHiuUisN0QkbP4eCHmM2VaN3V58aUmCnSSMw8KgdGe9UuYPAAAXwLN10V0tRBESkiTCU9g4o7zwcILO0IwlgPhSifpT205U28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yERfHrUj; arc=fail smtp.client-ip=40.93.195.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yERfHrUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ul2qWsqiewcKNe/oX5Xjp58vRhoBqJ5PibREzkenOLH6Ni7zCdz+LQ1rE7Yd1mZbGoOZyBhexXsFsMDV1sime4Xg4edbshHsKBRoYAcCkXXtm0k1/oTfvcpR+XtQRAiX6WIW+zm8wHiqRli+DcXhzhUNAZ2vWeQ9p7qI6h0MRz24Lkome8HkpdN9tHAKVI/4U9utdYHHTt9EBm0lcCzYQRA9cWGN2ZPmWrHLPcF52JHmMFYVLsdiG5GlXrIcCIe8h+2Cy584HwfaZSLhIFyKhnvgim+tZat8AnZYGdZi7U5jTZ1P2njj8iPBWFXFjlyMuJKL0VakEwkMom/yBAte0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6nV4VFVYmo0x56CxKegNfDP3/cAR2EOMdlHAiLgH7k=;
 b=qkA5sDgo3vOf3OB07v7pHFmZm+V75BrQrqy8mg0VJkzZ4VJKD9MrwRHiki4AP5794MwSDNvH9A9K7i57qXzpLcXALot9Sz+r66VcIOwbT0/+HImbJ10+WqcV0FXNlo0b8vLb0hTDqj1N1V2SW8bdBtjrEpOwNvBkASIKxaYHz347NHFT4DhJVHapYKWUFd6Ns2uf6iDCnm+fEqVQo84xTvmrnyD8W65c8NckK+J+r+Negm69CKN5padIIrJYabv0U+/q/QkNwwsyEYusE0jVSJU6/i8V9LmpHSWkTSgG0uN3L0AQpFcry/9trqWBKFpPoD1tpHu5T39uwVB+EiAMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6nV4VFVYmo0x56CxKegNfDP3/cAR2EOMdlHAiLgH7k=;
 b=yERfHrUjpQB/UnLRrkmkJMxBka9GsWoinCvbaPVTE7mB7fHbwpgWvgvKe5OBa6zzDdAqhXYbWtDrnUm8TBehiJXLrCc5wyYapMcsdSS39wdd++YJ02aNbYXEggCMjf+1tvw+ZRQ/9MFrB0aMmb5qSIeFxczuGc8mNXAS+ZVLok0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19) by DS0PR12MB7654.namprd12.prod.outlook.com
 (2603:10b6:8:11d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 17:41:45 +0000
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99]) by LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 17:41:45 +0000
Message-ID: <95b780d8-e294-4368-a077-7db94f62b114@amd.com>
Date: Fri, 21 Aug 2026 23:11:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
To: "Guo, Wangyang" <wangyang.guo@intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "Liang, Dan" <dan.liang@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260814123402.3170161-1-Vishal.Badole@amd.com>
 <DS0PR11MB8018E41AB42E110B167251DD92A42@DS0PR11MB8018.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <DS0PR11MB8018E41AB42E110B167251DD92A42@DS0PR11MB8018.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR12MB999069:EE_|DS0PR12MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: a658687c-4074-4f85-9ef9-08deffab77cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wMQUF6LRQvoJabOggQbNPjYOgz7/KzNL8SsD5uwAKkqdCu2ioCUZlzGMC18UXJC/AEE5IhaQkiHEdMNYSpInXZ6zghLWoIQHeZn13gdEBLiwRhcU4KlHNy38x6E615Y4c/fJqA6i+1HtqSW8oazR6TYJrzkXteDuNGTUkQKu5e0OqzJd4FeiP1b0jVI1TC4E9hgBfvpl6oQ9+4+wGnAsB3oMMnN5CSkOhJr9p8UuyzlirKvV3hFZPwKudQCi3Zs9cXQjvd/PgIz6UHOeSI9ZE8Q33/k9Br3dU2+7KHu3bG2h0uUzedtlAUUVWvWjYio/u2shgMkuGbxVPgQjHre5kTtv/LODN8HJ2QQ/tNl52YOhrGXP+7sc0KN1HqTTjMHNh0Dy61fwS1SNOyDmh3Voznn809iSN+y3XyHoNcNN6nMXD1M3IoD5r5MxmBF4Mu59Ehin/EsufTCFFhhXNZhFNUJhT7Yx8aF4trO/jJGuGxrTsKUCkk32ME1ttDcx/uCDfSQAy5up/oiEw0KXEaULdCrJPbQwLCS/7M2lw9JJ8rYOabNjo1XuzMv8xnHrGmNGlj2fhh5n8BwvZ1nCIX3bioYsUGD2OzNyAqrvaFGZJOzulvonZSq8DFgZfGzvyefok9jqp9PJgbk82U79cozIn2epXgWnAmccCAujZgGBM7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR12MB999069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWxBRExFK1RPUy9jckdESG15QWZQUy8rOVJqODZ0Ylc4ZnRrbTNGL0t2ZnFj?=
 =?utf-8?B?QUxwNmJyWVJXa0NMRUdRd3JRZ3RxeStCbEFJTjhSSmRSZEFjNlZPNHdBSk8w?=
 =?utf-8?B?UjNUME1zUnBxaUF3YjFMZVUzbGt2RFRuNi9xVXRGMU5CV3dyKzZXWXdKZ0FR?=
 =?utf-8?B?dnNuWkhreEpiNDM4bXkxRnBkVXE0cVlYby8raklsbnU0aTUvWmc2SUtRZUJp?=
 =?utf-8?B?Z05kZUFRenJuelcxZjJOaHBjaTlGTHROM2xCWm5vNysrUXhwOFI0RTlvRmIv?=
 =?utf-8?B?YkM0dGRraUZBVHhFNHdpQmZpU25nNTBBM2cxVkNaQk1TVE5HL0xtaFBnQ3Ew?=
 =?utf-8?B?MzRFMm81Ymc0clF6bFMzcjRoNXlOVWpJbU1NTTZEQUwwWlhJSEY5bnBISHZ1?=
 =?utf-8?B?NVNuelErbjZGSWo2YlMvUFNCOUc4eGVNSW9CV0pkc3R3Nm5mMWcreUVTUThV?=
 =?utf-8?B?WlRjMWVkampVckx1MmdDY3NoV0t2eTR6WlI3b2JTb0xkREVXbzAyTFRaWDYz?=
 =?utf-8?B?UHdGMUticlZjS0tzcTRJc3RFSUR4SjlEdzVjUVUyZE9ZQzZSZHRFVWR6Zk5S?=
 =?utf-8?B?bUZGKzFCdVQzaTMxY1JiNDJuRWo1bCtVRnVMRGFJWmVqSm51M08vK3plVGZK?=
 =?utf-8?B?djM2YUF5TDdLU3I2RVJyaU1tNkxDR2lEbysxNmhGeUQzUnpuRnJLVmlFODFh?=
 =?utf-8?B?a284TjR1eE9qSGZJbWp3eGNDSk40ZWRMTDI5ZlFhZ0ZoeGpiOEljODVRaCtl?=
 =?utf-8?B?QnFuNDJmZTBHcmNyNWNhWUt1TDdIbTdDZlRLb1FhMW1ObHVUMUpDOHJ5Mnht?=
 =?utf-8?B?RE5Lakh0eVNsYy85QUg0YTlVWlY1bnRTNFJHSi92QndRemxVV2grRnhmUkpZ?=
 =?utf-8?B?R2w1VExvdkZ6Wms0cU9DYS9OVUV1d2VFbHdJVVNQNlMycSsyTEVyMlRHNFhY?=
 =?utf-8?B?SFZ0dTZyTk5Fd1pvTWVyRFBQTStydTJDTkZCZFFnekdTVVdJV2REOFJOUFZv?=
 =?utf-8?B?bkoxOGNaQThjK2tvKzdqWEMySk5mNlN6VXZ3UFpLNEN6QzFqYWpFdGtaeW9M?=
 =?utf-8?B?VytMZitXck9EZWNkUy80WTdUaVdiRkRnaVVZK09BZ3JKeDJkUEg4a3p1Uk9K?=
 =?utf-8?B?SlJHWjUxbGpDTHlIVERpdHprdVlLekVROEp6RlU2dkRwcmlNYVdxdnYvazBq?=
 =?utf-8?B?T2Y2L1l4RVJ1V3NCODhmTHZQZkpFODRZT1ZiTWZ4SGkxWlBiYzdOUmp5KzNk?=
 =?utf-8?B?V2swS2pYL1hDRk1XMTJNUUJpQmdKY1RGczJkaVAybVBCc3RFZTR6TmgrQ09s?=
 =?utf-8?B?cGp2QmZOZWlVNDRTMDYxU2tDcmlVNkNZVCt4YUlkSlNTZEs3NGhKVkVIblJ2?=
 =?utf-8?B?Z0oxTHBCVC9CZ2VHOW80ZUxLTlBsaEFLZW5CNXh0M05XNTIvbXZWdjFXQ2Jz?=
 =?utf-8?B?MHIvZ1Z5cWpDUEMvSUNYR0VGTHIrc1V6dmJ4U3VucjJhWEZoVFl5UklEUGRa?=
 =?utf-8?B?Mlh3RXovSGd5UVZTVGxiMFltd242R2hpL3pUZXVSY2dWWXZOcFJaY1ZsYzJI?=
 =?utf-8?B?Z0s2UldTUHEvdGtPaDdQYmpOcWZDS1MwNHJtWlRvUjVDSitYTytJY3duK3Rl?=
 =?utf-8?B?bm5aTkd6K1BycDhxUWoxeVdoU0VXMlJaVTNBZnR5d2Z4ZHZvbW1oOGJlcG1S?=
 =?utf-8?B?R1VDYkpuT2ttOGFMWkpRZGs1b05JMFI2RnlKZXpJSTZEMExBc1N0UmlxRWQw?=
 =?utf-8?B?UWhXcjJYZE14dmJ0RWN3T2Vkc1FYU2cydGxVSDNpV1hrM1NOcVF6WXYrSUFn?=
 =?utf-8?B?L3lXTFA3VmI3Y2FTVy9DQUljbFd5aVZWRzhzV1d0L1NPY3hCY0FURXBoaXls?=
 =?utf-8?B?K3JxY0tjeUgyYjg1NXBTTGw4Nml5ZHozN2ZVTEFFaldNMkxwTFd1bm1GdE80?=
 =?utf-8?B?NldENG9qS2Y1ek42SW9BeWprT3BpVWFZaFdpaDg0NnNUbStadlAxTmI4ZGl0?=
 =?utf-8?B?UGpYcDRwNFdHVGNvaGFZVWVXTGN2SVFSN3J3cWxjd3dtVzV6RytlNWN4bDNB?=
 =?utf-8?B?WEpDaXlyQmhINVV1UHU0R2NwWWtvRERsVi8vWEZHZGRNL1B3Y0tLNDFFQ1JU?=
 =?utf-8?B?VEV4NERyQUhGYzVGeXNySzNwMStjWEY1bE0welNSa042blR5c2R3S0tuR0Rs?=
 =?utf-8?B?ODd6NjZUcWdrb2R4eHBCYlUyaTVvelN2aW5xMnEwS2srUTdaWVJveTN1b21o?=
 =?utf-8?B?MDBmc0VDeU5hUm9hM1hMc08xazhDdEpudVJwdTQxdWhkMUpPckdPUVdka2NH?=
 =?utf-8?Q?Ao7Q67vV1xJyJtmhkT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a658687c-4074-4f85-9ef9-08deffab77cb
X-MS-Exchange-CrossTenant-AuthSource: LV0PR12MB999069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 17:41:45.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tj4wh/AKO/SwYUODes6F35mXXimq1ZR24tbOn4+RcFKCaIp+BbRRoV4a61u/sHyrj3zvxnelLJEaHku0M19c9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7654



On 8/20/2026 11:23 AM, Guo, Wangyang wrote:
>> +static void capture_cluster_snapshot(void) {
> 
>> +	/* Only capture when all present CPUs are online. */
>> +	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask)))
> ...
> What if there is an ABA problem, some CPU offline during the snapshot creation but becomes
> online before this check, snapshot may capture the torn data but below check still pass.
> 
>> +	/* Drop it if a CPU changed state mid-copy; never latch a torn view. */
>> +	if (!data_race(cpumask_equal(cpu_present_mask, cpu_online_mask))) {
>> +		for_each_possible_cpu(cpu)
>> +			free_cpumask_var(snapshot[cpu]);
>> +		kfree(snapshot);
>> +		goto out;
>> +	}
> 
> What about check snapshot against cpu_present_mask?

Hi Wangyang,
Thanks for the review. Both comments are valid - I will address them in
the next revision.

