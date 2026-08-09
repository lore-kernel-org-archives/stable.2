Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6A5397937;
	Sun,  9 Aug 2026 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295521; cv=fail; b=aXvZT4NXZ9iD9I6DWswx9KT8JS6VINiLYpCG8W34XkMtbPIF5or4d741t0LBn/esd0hLzfLJm3Gq1Tp34QptYl+Nwe97vvPVsusucspS8FHzBbLuDG/LPj+KtA1NMYK0d12Lr+4R1oeygVmWmC9JC/DACTZeBjw+ySBv+kpIz5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295521; c=relaxed/simple;
	bh=24j3mzAUJdOAvQcXUq95821N35FVB3bkRu4OwFJcDRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E659qVJ6oMJfePb6TZJmI8mvtd/Q+my6yzDmvUgLCdooHt3+qhKOHAiYIDyvdVUenQ6NuFIKNZd7SRxCnShUhxtcGs/B4hm/Z63Un99IMRzVSw5XLAEu1wuLttDKhQnTgHtI6VN8aE4o8gE6V76LxkdS0A9i9mZkjWG5T0g7tdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wPCCA3gP; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wPCCA3gP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUDEKuViU96iwL9bLL3TiJId+95/wpTx+XjsVMXyhttDbj7L2z/jCSSUYz79bYA5w78yfy6Qnr9KjmskM3AudMiJO6k5t/Lygm/Pb6G8XDB9/PxEZenMByPSePehrtg7sVd+5rMzPevwV9eAY1MMGwfSvNWgB/pkGhvmxE4wB4hfL0GuQiEd6EMOLTNZZrr/cTtreL/HKzVb3MQZN11YVexE0atVaLbFaCU8h3JNaBP5CPPUFw6iaqeFSVi5f2igZOq9M27SrMwMj8ReLCfaI6WfBKR/vpEgz4aMpLwCxFA55pcCngXy+akfhbgeLCp/bh268Jn+QJcRbn4mYnLM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew4poBEY6Q7bQZ4P1iXziC4U8wENJ13RIOh/zNdpH2g=;
 b=vmrIp0EeZDH7EC97FW9zMw5nwZsElgfDTzS9fchXD8lCIgeuk75cSFDGiArwUD7mc+IQkFEvxqggmjKQSa7fK4SWgn5Oo7k8P2zjzVhtob+jFpeNHx3n/tRw4OxC48I2ronexjt/PPaiaQKLpW3XzxPN2wfAIuvqT+P2gpUIF2bqZh4OH9G12eHwfAVf9D/rGaOSny909ROQaEeMo5Defo58cCi8yvapBUjP/pDRGJGPcez0MaJWP7N0Si5cy6WzPNJ4Ann3KOgCzE+5zXKgExel4Jp3BD5jZkrqMM6ASKc7QYx6/ieeNWfslrWLI8ikHeMzEll6sCN2k8cxJfiVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew4poBEY6Q7bQZ4P1iXziC4U8wENJ13RIOh/zNdpH2g=;
 b=wPCCA3gPkMdKOsHoQpeeJLAf2asbWNQAXlk9heKNkZKW+1H64ioDPdIaEt38NFu3QNNrbkPrfzfWiKBjzRYuFkB7F0H8uJF8wMTw3zBVt8nW/2pprJOqS/TaN0GoYzzsmMXFJXskyfddAhqJPOoHM22HO1NMT506OBm3FsCSeVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19) by BL4PR12MB9508.namprd12.prod.outlook.com
 (2603:10b6:208:58e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 17:11:50 +0000
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99]) by LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99%5]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 17:11:50 +0000
Message-ID: <fdec1131-7de8-426d-b2f3-9e6266e6d49c@amd.com>
Date: Sun, 9 Aug 2026 22:41:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/group_cpus: Snapshot cluster masks to keep grouping
 hotplug invariant
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "tglx@kernel.org" <tglx@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>,
 "wangyang.guo@intel.com" <wangyang.guo@intel.com>,
 "tianyou.li@intel.com" <tianyou.li@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "dan.liang@intel.com" <dan.liang@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260807073612.3711269-1-Vishal.Badole@amd.com>
 <20260807133840.31a194a9cd04d4a2b6d817c1@linux-foundation.org>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <20260807133840.31a194a9cd04d4a2b6d817c1@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR12MB999069:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 6341ff17-7030-44a2-d456-08def6394cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|3023799007|5023799004|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zifH8GtG2k9Nw8IpIxUOaqTwd7Bm7MII+I7b24vyDNsOH31oMnwmprnXJjfSYcgmT+JIaKv7KF2S8mgoIdzyw7ev8vEuFhrxpiwbUdi966IbUT0VtH/8Yp3IQ06GHBwfy3RFA3rG2d/0bzzAIZl0GTN6XpaDUsQ/ctTZmGL4oCXxQEx1j4FbsBPYrTHXg2FhO88g9/8+KlqUKyWxfDp2glpnmcN+qvV5088mu/KTNVKT3lqi1+PIAEGYivKqZZUEiLlgSKryQdfBSqlQWDdz8WtmV5Iwh8XvKLlGLRRUpRdl+X//NXsL1zX9ksKMa7HK4S8JN8FsGB9WUw7DPHBgWe4/vl9hLC+qI+GuikWl7pXpubW1N/I2yfN+eXIhL9szZHJSwhd7Qbo6NChF2rfwFBZDnZAUsOCWcGBz9dv1Wor1keqzpiWk+PqMopBMqQAdFE4ZloiIxLKrE/rpv1Mgv0/qPH21qqIdCnZt8PDr+sqeYHhLTsI2dQuPSFifwNnMvIXyTan7Mi5yBEVrJmJrk+qfXna9Ni+F5pzTxe6NB3JqFSRE4uKRUv9hEfQfH188NTOF0BsY5TPPL0uOxpO+xkeIGwiTBVeeiLFLM+b5HGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR12MB999069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(3023799007)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZaYkhSRmJvenZsSTRpdjBZMFJXamNxTDhwei9IdGFUaG5oRUZCdUxmK29L?=
 =?utf-8?B?Q0NjS3Q5OCtiZEV2T3BNamlsdDdEc0U3NzZ2b1J3bHMzZ3hQejZyN0g3cHdI?=
 =?utf-8?B?bGw5UWNiUGtRNXlxYVV0SElRbnVFR2d6YzZNS3hpQUd4L1ZTUDFIVWdsNnhW?=
 =?utf-8?B?bDNsa2NiQWtyd1E1amNVTy9OUkQ0VmVob1Z1amIzZzZFWjBXNFBNT0pBVDdF?=
 =?utf-8?B?cyt5WStFdCsvR3gzNlBDallNUXBMMWoyRTRpZzB3NzRlYXJGNXNjY29uRFUz?=
 =?utf-8?B?VnExMDhGK3BtaUhyV2RvZDJRYk5VWmZ1SGNoRGdVaDZxTVpreDEvdjY3NGVi?=
 =?utf-8?B?bzVyYTQ1eGxibnIwb1RNcmFrZGdOZEEyVFpjbm5yL1VpRVNmSXpzUjlIc0hm?=
 =?utf-8?B?eGQ5UTN1QzFPT3hmZ2Z1YXIwbnJ4SEhXQ01zVU0wc21EUU5DYmlQZVgvTGcw?=
 =?utf-8?B?VkFFSDVHUUcwYTFZSUlxd2ExQ0xYVVlLM2UvM2lUamtKVm5nRTQ2d2huUUN5?=
 =?utf-8?B?TVFOTnRzRklyUk1wMVBwZDVGbHMxVHY2ZmVXQktkd0Z3UW12UnIvMTBNblY3?=
 =?utf-8?B?U1dYSzJXQTk0Y2haTFRpQ2VtdWFwTUM0N0FnRzV3SXVCRUZNUXdraEo5ZmhL?=
 =?utf-8?B?RkR1My9xeDVacnFQT1FoZ1JPOXJERlFXSXpjRitXM0x6NG1wejhnNUhBcU53?=
 =?utf-8?B?T3BHeEw5K3RKSTJ1N0w2MTVxeWhodWlTR3lUemd6NjIzK3lmSXNaUlNHckJ6?=
 =?utf-8?B?RDl1S1VnVkZaOFROMmdRMEZ6ZU5uMTZYMVo1THVseEJjcmZNQm5QZjJIdkdH?=
 =?utf-8?B?ZGF4M2hJbktWejZGWUJYK3VNZnZ4ZXFKdUU1dlpSQVlqU2h3Yjc4T2FjN1ZW?=
 =?utf-8?B?OXNIcWJvOHNod2MvelAzbDNXb3Npek01c05GNXpFbENraGU3NHVkbVBkY2d2?=
 =?utf-8?B?R1FidTdZTkRrQU5PVUI0c0dOMnVaa1drY25jdjJodFJNUWtIVlBLVTk2dTRN?=
 =?utf-8?B?T0U1YjB5ZzhuZzdvZWVyTGZ4Z3RXSCtNZWpsQVVad0FsMW9adlRYdzg2Y2ZT?=
 =?utf-8?B?eCtZbklBcFA3QUM4Q2VuSE5HMzhvRkJ5NTJRQ1FPVjZENTVCWFBScVo0enRm?=
 =?utf-8?B?UkVtYmMxOFdLZ3BYaTN6cmVtbVNlOHlxVC9WM3BSb0M0dkp6WFN1VFpISkxH?=
 =?utf-8?B?blFCTHl3Tk82bHVTWmoyVm1LQlpYT3FQNEljdWFkMFM3N0NZQlI1dUVQY0ph?=
 =?utf-8?B?NVc0Wmc5TWQxdkQxNU9EZnBidVl0M2NBMzQ1aGZ4ZVBPd1M5VmxKTlo3bnpX?=
 =?utf-8?B?dUxqYXI2b3huazFOY0FDYTBvMU1QOVowMnNTQ1Q5RjdNUy9mNThidWN4QWFn?=
 =?utf-8?B?V291Y2p5OWdpVDlRSlJUNHQzYStLNTBZcVpzaTVXKzhnc21lVWtZTzdqSG5V?=
 =?utf-8?B?Qkx3bDc2K0QrZFZhUFFqMnVIRVJoK2l4Rm8wRkRaVXBvOXphTWhYNGNJUkRV?=
 =?utf-8?B?cHlWV0w2OTZzUkFXckUzOFI5dERSVlgremRnYTNRYkhSYk5jM2s5Y09zdmZQ?=
 =?utf-8?B?dmlKeHJ3UTcrendMZzZveHJzUnVlektJSTBoSGVmVTlOMlVVVnpvelZIL2Y2?=
 =?utf-8?B?MzBuNEpCUGJCR0gyZXhKZlNDbU8wLzdIWWNsZWtzZ0huWVNKbC8yZFpJampX?=
 =?utf-8?B?OXZKTDFTMGNuR2lMb0hMTUVYNnVmaDgrMEJWOW9FZVcwWm0zcS8wWUJES0Zn?=
 =?utf-8?B?M1JWUmM4THNub1hQVXZrQjR3U2VwU0pVQTN0eTZjUDUvdkJxRHlabHhPREYy?=
 =?utf-8?B?UlQxVTdMdHF4SHFGYldBb1k0RVlBdHFpdUh0OHFWblozejJkMkh5WGVwbzFw?=
 =?utf-8?B?Z2JzQ2V3Qno3aUgyRnEzeGQrdmE4SjRIcEJyNlc1bkRHTGt6OTI4eEI1NXBl?=
 =?utf-8?B?RXdIUzZnOVdtMnlyTUE4ZDI1WU15MW5SKzJWZXlyRU10a3JPTGlDemZsZUtj?=
 =?utf-8?B?OHh5cjc1eTJVUkhxOGhtdXpKTDFKcFdGYStsUG0rbkQ5OER0MnN6SmNCVTND?=
 =?utf-8?B?RFlyMGc5UXRXL29UMkU2YjU0b1hXNnBrWktpLzJROVdGWXljdm82K1FIWUFo?=
 =?utf-8?B?RnBZOFZFUWt3UmVlaTRNTDBjTGYyOHFoK2phSWcwWjRWbXIxQ042ZllDTzlu?=
 =?utf-8?B?ZGNHbzlKcEpZZUozaWZvRTFCMzU4ZVR5TUZCSDlOSlA0L3ZFZEJJTzZpTW5p?=
 =?utf-8?B?bE1zbDRSdTd1bUVHT1lIejRGejQyMDNzRHlRcVNNMS9GRkp3VUdRUEhheW1j?=
 =?utf-8?B?Mkp3NTN6TzBWQ1lIbEJBV1c5MEdnZ2xRL0JiNEtRQy9iK0ZYYkM1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6341ff17-7030-44a2-d456-08def6394cfa
X-MS-Exchange-CrossTenant-AuthSource: LV0PR12MB999069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 17:11:50.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hnf8m3wbYTgQfqS//N0y2+4yJoHctaqS+AQc3m3rC3lmX5J3us0H34H34sKI/Hb6+iZ5V+sVCBKqe6DtEJo1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508



On 8/8/2026 2:08 AM, Andrew Morton wrote:
> On Fri, 7 Aug 2026 13:06:12 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:
> 
>> group_cpus_evenly() builds the managed-IRQ affinity spread used by
>> multi-queue devices such as NVMe. That spread is meant to be a property
>> of the static CPU topology: it walks cpu_present_mask and then
>> cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
>> including CPUs that are offline at the time. A driver depends on that
>> partition staying stable across re-computation - the CPUs a queue is
>> given at probe must still describe the same queue after the device is
>> later reset and its affinity recomputed.
>>
>> On an AMD system that stability breaks across an s2idle cycle. With CPUs
>> 3-11 offlined and only CPUs 0-2 left online, the machine is suspended to
>> s2idle and resumed. The NVMe controller uses the simple-suspend quirk, so
>> resume fully re-initialises it and recomputes the affinity spread. The
>> system then hangs for roughly two minutes and stays sluggish afterwards,
>> the controller only making progress through its command-timeout poll:
>>
>>    nvme nvme0: I/O tag 898 (3382) QID 9 timeout, completion polled
>>    nvme nvme0: I/O tag 398 (618e) QID 11 timeout, completion polled
>>
>> QID 9 and QID 11 are the queues whose CPUs were offline when the spread
>> was recomputed. "completion polled" means the commands did finish in
>> hardware, but their interrupts were never delivered to a CPU that was
>> watching the queue, so nothing reaped them until the timeout fired.
>>
>> It happens because commit 89802ca36c96 ("lib/group_cpus: make group CPU
>> cluster aware") derives the cluster groups from topology_cluster_cpumask(),
>> which lists only the cluster siblings that are online when it is called.
>> The resulting partition therefore depends on the transient online mask
>> rather than on the topology alone. Recomputed on resume while the non-boot
>> CPUs are still offline, it no longer matches the boot-time partition, and a
>> queue is left with an affinity that does not cover the CPU it is meant to
>> serve once that CPU comes back online. The dependence is on the online
>> mask, not on any AMD-specific behaviour, so the same stall is reproducible
>> on Intel platforms as well.
> 
> Thanks for the careful description of what is wrong.  It helps.
> 
> And things do sounds very wrong.  Could people@intel please prioritize
> their review and testing of this fix?
> 
>> Make the cluster grouping depend on the complete cluster topology rather
>> than on whichever CPUs happen to be online. Snapshot the cluster masks
>> once while every CPU is online and reuse that view for every later spread.
>> A fully-online view is the complete cluster membership, so the partition
>> derived from it is identical no matter which CPUs are online when the
>> controller is reset, which is exactly the invariance the callers already
>> assume.
>>
>> ...
>>
>> +	/*
>> +	 * Only a fully-online view is the complete cluster membership; if any
> 
> minor: the above sentence is hard to understand.
> 
Thanks for the feedback, I’ll simplify that sentence to make it clearer 
in the next patch revision.

>> +	if (!data_race(cpumask_equal(cpu_possible_mask, cpu_online_mask)))
> 
> AI review suggests using cpu_present_mask here:
> 
> 	https://sashiko.dev/#/patchset/20260807073612.3711269-1-Vishal.Badole@amd.com
> 
Good catch, I'll switch to cpu_present_mask in the next patch revision.

