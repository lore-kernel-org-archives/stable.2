Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125D3358C4;
	Thu,  9 Jul 2026 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610364; cv=fail; b=BDMwq5G3xno4aNymuM1ZwyxtNgS/UTPdb3tyveIddMKZoK+KkG+L7b+yI+fqgY9J1UZW+qrJCjhascy21wLLuRadFGvQ6713PIkXQ4Uo8nPcw/s6dxnauxv9BQgglZnP2FKZOewqc9E63NI3xtugOPO0e5XknkxwctAMFg9GIWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610364; c=relaxed/simple;
	bh=oBWHYrDQ88t6X0Wkz/K9iJVb26mlHvEN2b1RzA/OM4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f2vYl7hcZHqlnDQBTitrDmpgMZn48UoXG7d1eIJ9PsF6J6qAS6DU51wZkhKv5U1A5M5Mrlr+SdyBv1ZpDJMabY6LXOv9rde5Qn+vZgauPxkzY6s14fXiP8dG7aWUj4FTg7X7MrM2VVfAQqQvmnld8zxhUiz7pwT9riHO7q4q+GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l1wg51gB; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l1wg51gB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqg23Sf2qdAefVttRZsnjGEbFeWg3LFAgeu8Aj67+JQEOVd3nfu/fO7mA0gnTBFNihyIujXsv+4keMuXn4xHUx8JQhWG440x11HSSfbRjfMcX1msnntOxkJXKC5NNXtp8iaFfGD3ixS7/UhOH7pnVsDLogMD+ZsG9bHith98Q+ig0vI0/ShlHUKOSyqb8e4yy+mSgQTzCOHheV63I/uet8bZu7XEIWV/FJ8MwJTSsdfunv3KSCUq/qUdKq8AINxIkLBtbYi+/6EQlROSOExwZLmZb24vzC2fQaBWxG5YeKUxQC/LSYBzI5VtHqriopL+6fHE800qkx3yAySeA1+kgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhaeECYSfJotN2g2VyeWVX131kD9ynllgAEh5qDnx4s=;
 b=O5VBvWWL+Y0zIWCj4bo0m00DvlC/18cIZXK0QhMUEbKLTpqVkD2dKORNfUNKeujhJp1S80Qvg66oPOhc6FW0p/QVGf8jZo3ZppT+ofKoY/4MUer28e4vPL97rauzrQLYeE0y2SGKahaW2hkKu7o9VMHkjuYHDAnmQXjqI9R19xRF/fslFpS76kZZimMA83uWvNLFLl5XypwvJCcZgRlHq/zZqNvtDlFfYFJuiX/f+MLRDIL6znURwHHHWY+3ntdI1E5mif1sklgOVWMrlk65uH6HoDvK9Lsm4Q1C2yxDp3mISn9ykwfs0YdAkgAS9qCZVOoljgjQMjPZHlOIHw9c/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhaeECYSfJotN2g2VyeWVX131kD9ynllgAEh5qDnx4s=;
 b=l1wg51gBaGrd6cfEb3LE1nfje5hNugLZBwglCjiGrTFVMncoHOiv26W5VlxRD8HzNLw3rQBt77hVK6MrV7+iE09wQtS8CYHFcWb2SN4PiAC3Z5kJUOBwQuIFK6ZJinAjTHLd8fo1gNZ3PsCln3neMJrZuLqmjlRrRUFM7ZqB1tw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 15:19:18 +0000
Received: from CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6]) by CY8PR12MB7433.namprd12.prod.outlook.com
 ([fe80::faae:d638:bdc9:4bf6%4]) with mapi id 15.21.0159.018; Thu, 9 Jul 2026
 15:19:18 +0000
Message-ID: <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
Date: Thu, 9 Jul 2026 17:19:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: Lorenzo Stoakes <ljs@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org,
 thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260701144543.39582-1-pankaj.gupta@amd.com>
 <1cc159b9-5f94-4524-8e03-efe91601ccfc@kernel.org>
 <db303a0c-98e3-4967-9b61-ccb711b776c8@amd.com>
 <46f19bd8-0d43-4b0e-a8ab-0ef9d3b8bd1a@kernel.org>
 <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org> <ak-uER-RndpksnhR@lucifer>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <ak-uER-RndpksnhR@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To CY8PR12MB7433.namprd12.prod.outlook.com
 (2603:10b6:930:53::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7433:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4604b1-8fa3-4cf9-4080-08deddcd71ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|3023799007|4143699003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Ea2Fh8/5bfnHOm0rBozhasQRxloYJE4JYQ1cvQt9fWAE8jW8gwRilZ1+60lz8H8Pixu2dxk7ZuAR/1FjbuehNhbvVIa45CTWRNNA2MHpPBYiGXiVt3GULGrNVyF16wGmszo7cc8tpiLnatcEszYH/VJ81oa8pZVZBxIBUfFO/50hpXuWVb7pVZcit61mPTHIMkYMJ9HF3lwrOuf6P/YdbE9VgfFIpPzmC2lCq+a5oBlOkHpE37e/fphI0uFQr3cpEu/0nhM/IDFafvjW0IEIJhRZ15ehnC81u2Nl2Tzqjj7yTqRvqi1Ou3+Vptlj9zp6u3Gu0VEqhan+/6oB7xn0VTFVcIGHc0y0jxnxhlqai4BeB603Qrwc8FqjHuFnIAxnIUgiSWMJ7sF6S25FtZAbr/G1+0XTuDaLH5aJhN7pcUfwnK1H5aa+j0DjQktylcRr3zFULRV+R73Fzzw0HINtTaC5iBSXpNfxCWsntcYnAHCVmWT2P6mfY/0wlMrQPeznT79OwTFOjKP+iWaRQoLIx+e9+PgsUnFCRCgigNUNpOv13mQ5deRgeUEoMWfpVWRzVY6xKDRKcfuH8GHStqPgnLsZN3aGi3s5aGthIHdbV5L4mU6Kq/fVjX+VuPq/afjyFyxhdltQ1x5Y7mk60wc4NZBL9lkVQ8iAgLAr+eeNp90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7433.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(4143699003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVQxRTN0L2NOdlVvUGRmQSs4V3FBY1VLVEg2U3dhcnlsTzROQlJUSE13RGd1?=
 =?utf-8?B?eDY1Q0VYUDVTMDFPcm8xZ1RydHVLSFhQUGNWNW5OVG91dHRaNmVRTjdQRTBZ?=
 =?utf-8?B?QlFyV3kvdzRFVFhadHp2YjRsQmVMWUpKZWZmR1dSVWVzOGhxak00dTd2cEd2?=
 =?utf-8?B?Mkc0ZGI3ZThKK2RsTkMvemJNTHh2R2NOemF4cHJ2bUpRYTIvZXNCdjlBd3Fs?=
 =?utf-8?B?NG52RSs5ckltUXM5anhDQ0VwMzBtblJKQkoxRVR0MFBSR0hkVnBjTUZOd0VG?=
 =?utf-8?B?Z09Rb3RFYVZwVlZBaGdmejVLU2RtZDlCajlGcElUaVQzQWtuUy9PTWFsSWdh?=
 =?utf-8?B?cG9vWUVkVVRGWnI3Ym1pN3VBV1pqNWNnN0ZkeGZYQmJVc29aOGVQa3JydTd2?=
 =?utf-8?B?QmhoNU1Ra2JEeVVpVUNaNDg4alAwMGZKMjlsbHFTS0N5YzZyQVFQUlVGNkhC?=
 =?utf-8?B?NnpESWZ4M2lINXRyOU5PYUpBUEhOQVlDQlJkOGJzOVhMUVFLd0FkSjViTEIr?=
 =?utf-8?B?b0cydnNmL0RVaUJzbk9TZ2l5YXNySm83RUtGR1krN3J4VHo3RG9Ud2tkSlZZ?=
 =?utf-8?B?ME5wV0dIOEpxK1V5SjJhTUwyay9pVUpGQ1NmQXNJWjZtbHZGVGQ5enh4OHBC?=
 =?utf-8?B?MDkrd2lSWExkdDRSV3RrVFlMdExvcVBUb2Z5OWJ1UmNqTU9wQnRMQkF6NGdS?=
 =?utf-8?B?eXZ0WnhiaUpoQ2szcFYyYjJzbmlraGsvZjVjNStUdHdBSityd21reit2bnd6?=
 =?utf-8?B?K3NoVjZ0Wjg3MStuRkN1bUpxb2ZxWUZ2dDJ1eUJveXQvWStTNFNxR1pmL213?=
 =?utf-8?B?SEQ5Z0cyNTFEOW0xTlVOS1pMRnRSWHZRM3VIUWg3ZXU3VzBBQnZ3aS9kWmFD?=
 =?utf-8?B?aDlVb1UwSTFnUDhWeHVmQXUrQ2daZU40UjFFdnQ1RUlkeS96empIbno2K21D?=
 =?utf-8?B?ZHV0RTlGVktoc0FMalA2UEl4bGhxZ3NKcFh4TE9BRUc4K0tybEtRaUhJa29U?=
 =?utf-8?B?ZlFISm1DMTRlRzM4eDF5SzRGS0RsSUZ0RjF0dkdiY2dtT084QUxWY3VPTXNm?=
 =?utf-8?B?VnB2MnIyOWdWRU40VGwxZVdwQ1l1VUFUUmN0ZG5vQ0U3WkMzbEFSdDZBZTlO?=
 =?utf-8?B?dFZUTXhIdlFPK0w5Qm5JT1JuL0xhYjdFZlVlNUlodDE4M1lxNlRkQTZEbUc4?=
 =?utf-8?B?MjdTUW9oYlhhVEZ5ay9va2c2SFVkL2hiQmx1aTdLamRKSUlIYVlzSDlINFhF?=
 =?utf-8?B?cTQ0STNaM1pSaTcrV0dOU2Y0ZllkM3lEOCs3eW9QNHhGVEN6eTh0SGdNU2x2?=
 =?utf-8?B?b0lKcmhraXBpcXhPR1B1b2hZK054L3EzNnFHVTYvOENvR2E2M1daVTJsbVAx?=
 =?utf-8?B?UjRUREZWb0lwcUkvbjk5czRmbTlVZzF1akpLQzhzWWJ4UHpKMXFLVmZzTTA3?=
 =?utf-8?B?TExyZ3d2S284dUk1NERhNkpRa2hwQjBiV2k3K3YrRFlXNWlvamdwaldpOEtr?=
 =?utf-8?B?Z2JuZ0tSSWdTVGxhWGJRNjNSTXdLclZUS0ZvREdHYlFSdElMWXJ4Nkc1WUU1?=
 =?utf-8?B?V1lZT0g1dlVobUdwSEdvNGRMejRrVnVuR01iV3REY1VHVVpIRmZUUlAzTUhJ?=
 =?utf-8?B?by9sVXg1UzUzTFdiM3p5VjFHRklkMzlJdkVuNzBLNENNRUQ0RDdCZG5la0Vl?=
 =?utf-8?B?bkpMSHNQZEtCcVVEbVcrVGRUSzc2VDVuUkIrMWV6R1F3dEQ3aG1idHBzNW95?=
 =?utf-8?B?QXpFSGZWRktrQjNVS21xeWVQUjRCNlYxMWpSbmJKN3Y1cWEvRmxsa25iVjlN?=
 =?utf-8?B?d0FwU0o5M1RLem9UaEFEbkl5cmJ5NEdid3BFU3BBU2tRd1c2NGc5ZWNaUVZ5?=
 =?utf-8?B?bzYzOERDa0d1QjBYVjdLMjJCMmJ6dEJvM0RxKzZzb3NZMjdTUTZzVmcxNTA2?=
 =?utf-8?B?YllMeGVqbVByNHY5dU5qejRnRHhRdzRJVVlUTGVSNGtZOEVuVDhhd2FkYWcx?=
 =?utf-8?B?NTY0RlpaeXFUbCtOQnlQVjh3ZWtYNmdDdWR4K2pKbU93aFpvUXJaMERXMmda?=
 =?utf-8?B?Z0RIWjVTeERiWldaTEJPS094ejYyWkU1eWpEV1lURW9uL0xOd3BuTXY4SG9L?=
 =?utf-8?B?cDczbUtzVlI3Q0R1c25HdFdsd045SktkQ0c2dkVxOVpkUGVDRzJrK09jSXZy?=
 =?utf-8?B?OGVDczJKWmlyTzZ2a1FFeXdQdU8vUmdkd2NGVkhSWGMzalExV29Ic1FHaGg1?=
 =?utf-8?B?Mmw3ZkVnM0I3K1Rucjd6eWsweFB4ZkdZcHg4Z29LNGF1Z0I0MEcwTWhEMHRU?=
 =?utf-8?Q?j2cZt2BERFaMp1jQQS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4604b1-8fa3-4cf9-4080-08deddcd71ab
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 15:19:18.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibrswqR4TjFAjwjm9Bcytu4LnfnRQLh+96HK503AKJu13dW6IKn0/1Zj+t+svz7bCaZEOmz4uW6XnYTBuvR+Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622

Hi Lorenzo,

>>>>> Hi David,
>>>>>
>>>>> Yes, it fails in this path but for file backed mapping, vma_is_fsdax() returns
>>>>> false because
>>>>>
>>>>> vma_is_dax() returns false:
>>>> Ah, okay, so fsdax is not involved and we really only fail because of the
>>>> writable_file_mapping_allowed() check.
>>>>
>>>> I was for a second thinking in terms of nested virt :)
>>>>
>>>>> Host side backend is regular file backed memory (no fsdax).
>>>> Okay, so we'll end up mapping an ordinary file into VM memory, and expose that
>>>> to the VM as part of virtio-pmem device.
>>>>
>>>> That also means that vfio etc. won't be able to longterm-pin such device memory.
>>>> So this is not a problem isolated to SEV.
>>>>
>>>> Forbidding to longterm pin is actually the right thing to do if the filesystem
>>>> relies on writenotify, as spelled out by Lorenzo's commit:
>>>>
>>>> "
>>>>       Writing to file-backed mappings which require folio dirty tracking using
>>>>       GUP is a fundamentally broken operation, as kernel write access to GUP
>>>>       mappings do not adhere to the semantics expected by a file system.
>>>>
>>>>       A GUP caller uses the direct mapping to access the folio, which does not
>>>>       cause write notify to trigger, nor does it enforce that the caller marks
>>>>       the folio dirty.
>>>>
>>>>       The problem arises when, after an initial write to the folio, writeback
>>>>       results in the folio being cleaned and then the caller, via the GUP
>>>>       interface, writes to the folio again.
>>>> "
>>>>
>>>> Hmmm
>>> Yes. For file based mapping we don't allow long term pinning.
>>>
>>> If we take into account the fragmentation concerns for MIGRATE_CMA and
>>> ZONE_MOVABLE allocations
>>>
>>> solvable with FOLL_LONGTERM, I can think of two options(tested) to allow file
>>> based mappings as well:
>>>
>>> 1. Fallback on FOLL_WRITE when FOLL_LONGTERM fails as suggested by Sean.
>> That is just not acceptable, as it breaks random other stuff (MIGRATE_CMA, as
>> one example) besides the file-pinning problems that Lorenzo added.
>>
>> If we're going to hack something in, then that we bypass the file writeback check.
>> Not that we don't use FOLL_LONGTERM.
>>
>> I'd hate to use a GUP flag to indicate "this is a legacy hack", but it clearly isolates the
>> issue (needs a better name obviously):
> So under what circumstances are we happy with totally breaking dirty tracking?
> :/ seems iffy, and exposing this to drivers generally is a bit worrysome.

The intention is to allow long-term pinning of file-backed mappings only 
for migration avoidance,

without kernel GUP writes, and therefore not impacting dirty tracking.

>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index ae9bca4eda5ca..e2c531f914d44 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -1912,6 +1912,9 @@ enum {
>>           */
>>          FOLL_HONOR_NUMA_FAULT = 1 << 12,
>>
>> +       /* TODO */
>> +       FOLL_LONGTERM = 1 << 13,
>> +
>>          /* See also internal only FOLL flags in mm/internal.h */
>>   };
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 0692119b79043..1fa0aa0cdc99d 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -1186,8 +1186,8 @@ static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
>>           * If we aren't pinning then no problematic write can occur. A long term
>>           * pin is the most egregious case so this is the case we disallow.
>>           */
>> -       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
>> -           (FOLL_PIN | FOLL_LONGTERM))
>> +       if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK)) !=
>> +           (FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK))
>>                  return true;
> Hmm I'm confused, you're then allowing FOLL_PIN | FOLL_LONGTERM, but disallowing
> FOLL_PIN | FOLL_LONGTERM | FOLL_LONGTERM_HACK?

Yes, I addressed this in my reply, but it wasn't a clean inline response.

>
> By the way I think this should be expressed better if I criticise myself here :)
>
> So like:
>
> 	if ((gup_flags & FOLL_PIN) && (gup_flags & FOLL_LONGTERM))
>
> Or even:
>
> 	/* Only an issue if we pin... */
> 	if (!(gup_flags & FOLL_PIN))
> 		return false;
> 	/* ...and that pin is longterm... */
> 	if (!(gup_flags & FOLL_LONGTERM))
> 		return false;
>
> But I'm confused as to why we are suddenly allowing something broken and what
> this hack flag is supposed to achieve?
>
> Shouldn't this rather be:
>
> 	/* Only an issue if we pin... */
> 	if (!(gup_flags & FOLL_PIN))
> 		return true;
> 	/* ...and that pin is longterm... */
> 	if (!(gup_flags & FOLL_LONGTERM))
> 		return true;
> 	/* ...and not overridden... */
> 	if (gup_flags & FOLL_LONGTERM_HACK)
> 		return true;
> 	/* ...and dirty tracking is required. */
> 	return !vma_needs_dirty_tracking(vma);
> }

Yes, this looks much better. Will incorporate this.

>
>>          /*
>> @@ -2746,7 +2746,7 @@ static bool gup_fast_folio_allowed(struct folio *folio, unsigned int flags)
>>           * If we aren't pinning then no problematic write can occur. A long term
>>           * pin is the most egregious case so this is the one we disallow.
>>           */
>> -       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE)) ==
>> +       if ((flags & (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE | FOLL_LONGTERM_HACK)) ==
>>              (FOLL_PIN | FOLL_LONGTERM | FOLL_WRITE))
> Yeah this is just a bit horrid having to stare at a this a while... So
> FOLL_LONGTERM_HACK would enable here.
>
> Be nice to avoid this form of it as it's difficult to understand, do something
> like above or a clearer version anyway (probably best abstracted to a small
> function).

Sure.

Also, I am also planning to rename (FOLL_LONGTERM_HACK -> 
FOLL_PIN_NO_GUP_WRITE) in v2.

Please let me know if you have a preference.

Thanks,

Pankaj

>
>>                  reject_file_backed = true;
>>
>> @@ -3180,7 +3180,7 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
>>          int locked = 0;
>>          int ret;
>>
>> -       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
>> +       if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM | FOLL_LONGTERM_HACK |
>>                                         FOLL_FORCE | FOLL_PIN | FOLL_GET |
>>                                         FOLL_FAST_ONLY | FOLL_NOFAULT |
>>                                         FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
>>
>>
>> --
>> Cheers,
>>
>> David
> Thanks, Lorenzo
