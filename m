Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086145;
	b=hOzuzfrpVr2uOu5vFNCmi7OSZhGRdMOYu4TnfE/eoTyP3hpVBfz9acrRNUn4hjewquUU
	 k1n5xlFvwy9c1RdvZWVCWKjZ2TB5DqwQHl/8dkAMqx3iqs2IWxGGUd5hT8+tVn0XiWWd2
	 2z07dhSct6h/f2G7ooieRHT8qsWhXTa27icyeZHTTtcuca6cAkdxhuJWvM4IcC2j2Ykfk
	 T6WcIidRtLnspXLkJuD3LZty5tar24r5cBO2ppLLt1l+yl3zCQGLv1eFyaKK9XmW3TJlC
	 /DbKbCdvereVWOFFOomMR+ER1op6qXCjLEFuwpS5FlvK/Z1cRxpML72kSpaRvRaa7eA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086145;
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
	bh=iZn2BE7p1dvujGhvhNoMaIK4WdTRD8Sc8tLq71clqOw=;
	b=Rw6IyZjQs09I8yFdhXLyraPBZVpXCyJwHsv6ylaZfSeIMFifNCYaZWtTg4V5gIpP/4uQ
	 gEWewQ8EeCEpJVTJlJYfciLmas6DI+8Pm3AvtiHDRcozsVgs00oqY3H3t7VUBNZIVt+N7
	 Rd0kIT54YlwnRNG5CXMore/fmZdhRrGt3jU5DZU4bU/l0X4Ex6Dn5gvrn1FOwAqdY5x9+
	 sib9C2w5ADbQVXjHYhdrjjoAODO7NQh1vjN5f9Kpw4SH5PnVNvoEVZnV+g63R47kwAkX/
	 TjEITkIbzvX/n7bKZQ9nixiT5eHLen9QnveO43fKTE0Ma1cNv6AUNP2J99HdMU7FEtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gc9Ih0Yo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.17
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247E606A31A;
	Tue, 27 Oct 2026 07:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1247E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gc9Ih0Yo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcE6wlee+FgP8WLmqNiQJuGvOaJQdV7bLMvsCS9ovrULqyCF/edPQdSXYPChM8t34CbY/9oivWEkXmx4RXOsHVriCkgYmVMsrWtj/7Hn2uvyuxpl1HE4Co64AvLj3p30Zt82EcOzKi13G7rAProAXXLrgDKnnV0y7Iv51s4vC71lFyfR55sXjO6JMvrcR/5qQ1o/95dk3S68SyhbI8yRsKBJxUePAGIsNIL15k8nzfSpnD+ZIrie6hmDCSrR0dIksZJZhVQRIq2qY7g6KzrRqSO9nthrxax+BsPCBjnhXtdYRaqvk7x6zNM578ntzaAQ+TRg19Y+AOPV9emsghkrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZn2BE7p1dvujGhvhNoMaIK4WdTRD8Sc8tLq71clqOw=;
 b=m4uSh/05gtYrVOiAAmjBfceDFBfiTndJPwHRkMG500Y6J0FO7yNzzks7cTodwYtQFqU4Z7l4aj7nHLV3IjmcG83XfoWTmlpk1pXDgyZ6wdUui4o5glA8cXafrIfKgT2fEW5p7KoHKrZ8gHVYDmSdiEYHfQEbnsCo8InZ5GA7tJOUme2GSIid3lsaMlw+g0zHpQ2xOuUJXBHrOv6MWBIwK8KSkZyC2FPikgsKz98tcdbCRqNBzibZ9mjxKOajAIVg4Ur3K41nwywDEKCAlYOt3ASONTGK6SrCZgCDL07r1vLtpq1NcglSmuxehFx6muw4y/eZGVvljdB/f59uCQUtbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZn2BE7p1dvujGhvhNoMaIK4WdTRD8Sc8tLq71clqOw=;
 b=gc9Ih0YoQgiCIaOGLAWyu5rOeqTPwNjsuWph3b2NhGnXe9vGAkDY7uERaR0wPqhLBm899tJlv0eD+lvIu/kny9j7AU3jtoQMeZSBLZxldfLC3wQjx0emhHl69ruaOy/HkmB1N+IZzJw9JXN0vPnUUWDnp9H+VyFlyX02HpwZRJg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by PH7PR12MB5832.namprd12.prod.outlook.com
 (2603:10b6:510:1d7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:28:59 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:28:58 +0000
Message-ID: <bbfffc93-8314-4f84-87f3-2a837878c57a@amd.com>
Date: Tue, 27 Oct 2026 12:58:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 wangyang.guo@intel.com, tianyou.li@intel.com, tim.c.chen@linux.intel.com,
 dan.liang@intel.com, stable@vger.kernel.org
References: <20260826171537.4167367-1-Vishal.Badole@amd.com>
 <20261024014740.3701054aa2f412748b985de2@linux-foundation.org>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <20261024014740.3701054aa2f412748b985de2@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0177.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::10) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: d321061f-b774-4c0a-6442-08df33fbf727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261009223027099003|261022105027099003|261021123027099003|261022075727099003|261021121427099003|10067099003|56012099006|261026121527099003|3023799007|22082099003|18002099003|4143699003|11063799006|5023799004|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	2E/0JnkZJFZekPSlGnh9wyCGmGZ9tIRIRJjGhv3BSeJEmIZvwV3gpVTRU26fHAqyKPdm+EgjlzAKvRI9GzAx6pejtgGtrIztmptYC6IVmchmuBenLnSQy1v+PUSA1JpF4AfthOaZqsrdfB1IB3gAkYUNqqCcPNlzuy+1lPgz50ROKZAvkkzsqsC2qqcVfrOZIsq7LyaDQnNhfcBEHuMSdWsUBNWB/D7ke8CBxPD1ngEHyZ+rSHdIYITBlF6QuazL8AGLQPJ98gajpMqRv5ukvi6uJZkTCpqpMKuGpM4GGyZECOhKIwPlqd159Oyq/TYlFqL7PF1qyG+EbEfem5oNO2JCjkj6NecfjGscqM5ThnCgjfYtBpQ1t+hkqI9KGWyeoHRS/5+KPGu0Cq/dxyJJtdNGGPzE65T1yQhZLLLby23EVck7VPdu5mMaskZChCXJ8ff5YX0UCjGTHBiJdbDeKVieLL36rNtDNpAp6nD7kpr9FrCGnK/n8RAHiSRG1CPAK5AD0FSpJwz32LmW8OKaMvdxYxoSN0d2fdBfd/8BCPCsErL0PIAbya6OQuSW4QBLhVEA8t3qwrMVIDjQNSrwAZI4Iy4/2tMUrMyYnYgmeErbeZGBxWsS5OJkwkTc3DUvYgNRc+wcZxOkylokjTLA+6ha6ET1FooxUMgfLSpzLvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(5023799004)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFd0V25vZ1BIbitIbXk5SjlEOGFWTTNKS3BQTWRrYW52MzYxWWQyWS82RGpV?=
 =?utf-8?B?SUVYeVlIWUgrdklqb04rclF5TXJnZVI3TTdvamxhYW1KRVZsU1Y0NHNRZTFH?=
 =?utf-8?B?TWpzd3hCWlpnZ3ZlUmlaK2oyRVNlLzJObVA1WG5wOXJDU3FvandGN0hId1Ev?=
 =?utf-8?B?R3lYYWxIdDMyM3lwVmE1eU85SWJiZUJreGRhY3VuMDM4Y0FHUFkraTlJZ0gy?=
 =?utf-8?B?WXFGOEdSMW9xcGNBb01SWTc0V0graWZLR0NOemFwZUN2RmdXTWJ2QmxicWJY?=
 =?utf-8?B?ZlV1bUtBa1pkS1JCQnRMQWJEdEF1T2NmUGZyRHQ1S2lpUTljeDhtb1lSSUQ3?=
 =?utf-8?B?TzVOL2xHS3I3R2RieFozc3JSK1NiTVlySnhpUDRDbml5dlBGb01aMmtiU1Vy?=
 =?utf-8?B?aERFcVhlaktJUktWdytSNC9rV1NMR0VrYXREMWlyWUxpYjRYb29MSURoWmdk?=
 =?utf-8?B?cERqRDEwKzNDZU5HVzFEMklFcXZJN295WG1EbUpDYjU3RkVZYXR3NVV3Ympm?=
 =?utf-8?B?cmViaGMvOHp2Z05XRERqWEYzc0IvZVpUTHNvM1pnZ2FhZEdMN011U2JrT0RU?=
 =?utf-8?B?WGVFdDdQc0JJZkR4cHY0UHV5TG5aNlJQSm0yT0cvSzl6SDE4OWxpdlVUaXhE?=
 =?utf-8?B?VE5GSEhjY0VJUGpGZ0pWMURnVjVBT1daOStIK2plNis4L0hVR1lDQk8yZEgv?=
 =?utf-8?B?Um1odWtxTmNmd2JBanRNTUpGN20vQitROWowNFZwUWgySFI4Yjhxa29RUkNB?=
 =?utf-8?B?WUtyK1RsZjNsVkxIeEZ6Y2pBaXJaK3doaEdncFNXZ08zOXQ2Q1BaN2h1bTdG?=
 =?utf-8?B?bTVGZkhrM3Ayc0FOT0xvVW9OVlRTbGlWK09sSW0xVG93YVVFVTBrQlV0YVRX?=
 =?utf-8?B?TEdNZVhGdEgrWVZIQmx5OU9DM2Uva0dLUkhOMTFhTnlwL1BsTnZSamhzYUVh?=
 =?utf-8?B?RzRMWXJIU1lNcVpkTUg1bS9sbk1BL3Y1Z05EcXhGUEQ1RUgxRzJncHBIVWJT?=
 =?utf-8?B?cGhHUGVqWkgyb25sRUtJbzNIam8xRE91UzN6bFRUSFBib2NRQzVpR2xuRVJ6?=
 =?utf-8?B?dS9acUlHRkVSUTdiemx1S0RJdHNPMjBiVXBzRXUvaWJZbnNHMXE0SkNtZzh5?=
 =?utf-8?B?NVRtZjlsSThhMS9POWVWUWdWVWR3ejBWemtBL2N1aWpKRCtzZUhRaHpKSGtL?=
 =?utf-8?B?NFROUUYvemRyV0lQSlBhQ2ttdVU2MkxhSjRzVTlJVVRCZ0VGMDNvVVZPeG5p?=
 =?utf-8?B?azNBQ09JbXVCZlJ6UjNnT3pjN0t1R1k2QXdua3FOZWZ4a1EwRmV4a0hQNXNN?=
 =?utf-8?B?L0JWcElROUh2L3RhMVlJelNpT3NpQWRxSno3d0Vscnd5bjIxSUhmMmNWMW1I?=
 =?utf-8?B?MEhLWlh3eTF2VmFvZ1llcVpHeVppcmwxcDg1M243S08vbC9VWEJTT3FhMzc3?=
 =?utf-8?B?NjAxK1o5TzVGVmtmZWRjZnRyQ3hZemJiejdqNGhMWmI1MjdHTCt6emRaR0M4?=
 =?utf-8?B?cTNqMVlyOWduRUJwRm8xV0Y2b01EazJzMU93NDhPTnFlT0xpVVdiRDBVazRr?=
 =?utf-8?B?YVZsVmJVV1NsU2o0dER2S0E2aWlPME1UNGRlSmR4UHZSUnRBQ0hDT2s1RVlU?=
 =?utf-8?B?VjArN0tkc2lKOHRhUVlDYWNZNnVWTTRDV3ZrbVlmOVY4TlA4eDREWFQ1VzhP?=
 =?utf-8?B?M0o0NkFrUHZZYlh0eVcvRndLS2RzMU1JQ3BWcjh2YjJhb2ZreXNncld1TEw5?=
 =?utf-8?B?R3VMMFlGMml5N0VLNG1XcWh1ZUVhU00wU0FmeVVMdXVQdk02ZWkwS1kyUU00?=
 =?utf-8?B?dm0rSDF5aHJKTzY3enNlL04ydm1IaEplM0VhaTd3Rnhmd0lNZUZCS09Ea2F5?=
 =?utf-8?B?ZVpJMFVtdkcvMEZuem9qS3FFeXp4RGoyaWV0ZDhNYkppL3V2Y3lHaEFkR09D?=
 =?utf-8?B?QWZXdnZLZ1FHQlhRVkREVXZaSlkrUzUrTTQvdVlidzd4UkNkOXZnZ095azR1?=
 =?utf-8?B?REtIdzdNRUtxa0lURmFZNVB0UWxIV0lVMnhFdU1nWmtBbmV4cUJKY0Iyb2Ry?=
 =?utf-8?B?Q21ZT2pRWmU1Y2VyeExPM1M3OXVKNzgvVUN0djBaRkllb3JYQVF0bk5XUUF6?=
 =?utf-8?B?VGQxb1hnaTVJRXdnQ25EOWJlYWNwbDVaS0lHdEhpSmNueUhTUWYrUDYwL0tk?=
 =?utf-8?B?UUpDdzYvN285MDRleTF5MUJ2ck9zYWJ5TG1YRzNFMXh4VXZTK0R5c2dsbEtS?=
 =?utf-8?B?TUxvS05RMXdkbHNBc3Z2enJRTkN4ajBhK0xNRG5NQlZ6SGlBam8weEVhZ09W?=
 =?utf-8?B?bTJBdWQ0Y09mdm9aTDZjWnBJb0JqdTJzV0JNZStMbUJnNTdYM1FJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d321061f-b774-4c0a-6442-08df33fbf727
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:28:58.6951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Uyx9Uhbm5A4AAtBugzRUWzjm6DdHVH1STKjmTcNWMgu/XtROYkeVj3v54kGldMoqM/B4bDthXUpTznZnzWoAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832



On 10/24/2026 2:17 PM, Andrew Morton wrote:
> On Wed, 26 Aug 2026 22:45:37 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:
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
>>
>> Make the cluster grouping depend on the complete cluster topology rather
>> than on whichever CPUs happen to be online. Snapshot the cluster masks
>> once while every present CPU is online and reuse that view for every
>> later spread. Every spread then groups from the same masks, so the
>> partition computed when the controller is reset matches the one computed
>> at probe and each queue's IRQ still covers the CPUs it serves. If the
>> snapshot was never taken, the cluster path is skipped and the plain
>> present/possible spread is used.
> 
> I fed this into my evolving AI reviewbot and it had a few things to
> say:
> 
> 
> The snapshot helps when the first affinity spread is computed with all
> present CPUs online, but I don't think it guarantees the invariant
> claimed in the changelog.
> 
> If the first spread happens while some present CPUs are offline,
> capture_cluster_snapshot() declines to run and we use plain grouping.
> When those CPUs come online a later spread captures the clusters and
> changes the grouping algorithm. For clusters {0,2} and {1,3}, two IRQ
> groups can change from {0,1}/{2,3} to {0,2}/{1,3}.
> 
> Also, even after the snapshot, grp_spread_init_one() still consults
> live topology_sibling_cpumask(). x86 CPU offlining changes these masks.
> On an L2 cluster containing multiple SMT cores, assigning multiple
> IRQ groups inside that cluster can therefore change across hotplug.
> 
> There's also a new failure mode: if the first snapshot allocation or
> cpus_read_trylock() fails, we use plain grouping, then switch to
> cluster grouping after a subsequent successful capture. I can produce
> different masks this way with all CPUs remaining online.
> 
> I've verified the mask differences in reduced GCC and Clang models,
> not in a kernel/NVMe reproducer. Can we make the entire assignment
> independent of online sibling masks and avoid switching algorithms
> after an affinity spread has already been handed to a device?

Hello Andrew,

Thanks for highlighting these cases. I’ll address them and send out v5.
