Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2148F848
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453369; cv=fail; b=gNuDwWJZR1aWUSxvjN10WCQFAIRfB/UuW8vZiiJcFjQXhiVqYuG+u6JSi9uMM1PDxsjBfWeVqg4y2CLmvcigx1i87m4LdDdvCA0+AXy78xmf3B/JHqtE+IXcXzAHHWbPfbtkiV15VAjhJ32mwgjXyeKcWQTgWJWYtKQg1q+pnQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453369; c=relaxed/simple;
	bh=fiAn+HQT/T4nJrqWS8I/iOjX1RWV6BM8WzJvCs/ljP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sz3nkTNVUv3vrZm1X0t/2014PNLTlgBSsFyGwiAsorcfHiwxNGtDp9iyi8GZ7ETYXMuIpVg7lZm34fY68EuTGKcE3i575H9swL4gOJ1M1hXHH/RRwz+/2Vv3gU6wc33UpNMjzXEnwZ9eL+Gvvb4krVUjCll+TUJShSQ0OXh0/yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfK+d0IJ; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfK+d0IJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ths4CJjmDdjc/8Njdi4G+cw2FbybMbHNmRWW8DYN64wB+uN98iMW+5+pbaD9adVsPWpeqxcNPSt85kNLEH/g5YALiClkf43ZjlxtzNfcEnfd6fLuzqpqImwVg05kEWORdP2vp8Trs7zn9P7PZ3IMxlDID+f+3KnS+M21k3x9MC23kJjzdf9gHpJmgHJMFimPVjht01fbCyu1uDUz9TJ+3oJ+GC9zJN4Gg8nsKLhvWmyu0YkBYX+6DGIcGy6CsVoPnjTQlf8CIFW30uf8nTPvYTt9kdUzn+z1Mp0r3lEmNB1h0ZEhkst1EvVT90wRGEc6Z3kwE6QePYRctMWk6Qx1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=276Ej9BsIrATu8ymX079m4eUYs7cIH6cDFmQwN/KNws=;
 b=wYi/vq67YZKbqvWsszDgASNRlP/+5bCe9hA1MItldU+tlYF0ARG8YEiJr09X/OjaFGVhvbCm/faC8slPEDkHQkgxmFeBLCJ2sdCj3sdPlDqIL1hdh2xb4sYsVInLsK+dp5C9jPm+3zVS9CVjTDJVPnCd/tiI5/24T6HutTcMuezq6yrXR3E9K/QK8IkVZ7he+0e8EdxF4gZWYrGDrhF/frvm++WlD+hWVH/YrxAYaPV3icrYH7+duTmL77lYRfLjAxo4CrYyEw6IovuqX1S/h0kkrd7gmfsDbGc6Q6begc7Mnd9J+IKtw8zsoV8f8Nabrrhz0GCpVIkoC0vT9DZR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=276Ej9BsIrATu8ymX079m4eUYs7cIH6cDFmQwN/KNws=;
 b=UfK+d0IJvOIRVlwvCTwP+5+hJkQbLL3ghYiHmvBDLMzGKJMNV0v5hq67+OvdMBDnJg1WZHQiob+j/1vwz5xx6brv/H50eaSkvv9N6eh1nuipNE/m5Ogjh8EGJB9342Pqp8Vt6NXmrwstWhZcXRmyzrYUnQRUUA/sN9xbLWaz27E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 8 Oct
 2026 09:55:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:55:32 +0000
Message-ID: <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
Date: Thu, 8 Oct 2026 11:55:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
To: Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20261007153605.1743626-5-matthew.auld@intel.com>
 <20261007153605.1743626-8-matthew.auld@intel.com>
 <2c6a97ac21c5ef161dbac279f9b971f383b6b944.camel@linux.intel.com>
 <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <dbabed4e-468d-4ecf-b295-f5d8c9c4b263@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0a64da-d592-4332-f454-08df25224a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FnvXruiXtzlbtB91o2DHMUkPfJoUlwgSjgyrbTXZHOmzlChQuG7oKa3j2SthOazVuJU8CDdJPCAL2kkppji7iDbO1Z89fwNrC2rbl6ASYnFEfsRc14ZD0S/BxalSKdolejoUi6txLeFdUtgznzx7F9MSNqfVmqzFQggNQ2b940YWi/PlWZCYZbRDo09o+baBpPLe3q2Oa0KlMVnyRJRPaaB0Af8I28hWAhukqKQqKm9iIkek+yGcjOTng0vH7emHDUxSWpgszgONxLgvPuRNK8luKdoQEolkx2k4YGMuA9Kat0lZIdIhzWsClRReYv5VF00qDRHwpdW7unphwiOJmea67nKxvfm7vp5MvlWYocXCMC7evjpSPS7FNd3Tyf88b+DWFsti7YOwAXr0OMT0jw7fI6aRU1ldXAiyWoFHyITP3sjhQs0b57DN4FrUmaEOs+v9xDYG3Hm1FPcqRIBxDsKkiWNbOovD4/Xb/v0Mg3ZGhvV60V9klMCnw8wgjvDe4tMANJGeeF04fbvw41GxvD2/ovnX9ekL0GbZay7mnwP0Jg5H5+M1oJoaXXKwSZ+YOuoIrIe6U07zroN6fXrpqVGa5ByiAJgPfI41WApGx4XUSSxqwp1zNU/0hn5oYWP9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJUT3JXVUNrempUdWhmMjkwVXFjeVR6dzFrVFgxc0VDNDZUOUx5MndEaUVY?=
 =?utf-8?B?KzI0YmphZ3JhZFNRdm1VREJGRDJJVEYyVzErYVJlMkRrbHB3NW5taEJrdHpa?=
 =?utf-8?B?WEtYYzB2RWZVVkQrcXB3cTBxaHgrQ0txTkVZZUliUUxCTWRUTzlWcDBqSlZU?=
 =?utf-8?B?alY3dWNDUjZkMzBpYzBwVWZFZGw3RXpGSkdNZFVMYmZqTk9KZkZYNm5laXB4?=
 =?utf-8?B?NFprbklMSWNqcXQvMGJlNE1TL0prdnA5eEY2Zmtpc1dGbTRUa1o3bUorcndG?=
 =?utf-8?B?b1c0OFJIOWZDamYwUlorS1NtK2YrN1EyTm8yWkhUMU5UT3ltWWNFU3FqVVlv?=
 =?utf-8?B?RFZzc09yRHNhNDlRR2NHQ3V2bmVsakYvdjNNYzZyaWFqSWFSSzZkZGVSNVZh?=
 =?utf-8?B?YWFCYUZ5Tmh2cmRlZGhFS3o1L0pCemlvbEJ3MVpOSWZtUVdhaE5LSkt5ZlpI?=
 =?utf-8?B?MzdWdzBBREcvK1IzT1BaeEVnV0ZiOTJDMVgyYkhJWkZETkR1WVB2TFFvV0t3?=
 =?utf-8?B?eTIwRVQ1dGtGMEx5UW5VUnBYZHB6VGR1d0JiLzRmUTVKQ1d6dGM0cFcyR1Zi?=
 =?utf-8?B?c3FCT1k5a0JscGlCRWhpbk9QbEZ4RDVGVnNWSlJUeVdoam12S09sNTVOMmF3?=
 =?utf-8?B?NHFqMGF0R3A0dGxxWWFTeUVJSjNPOFZOUlU2VWd5aHdxb01yeEZucmJ2MEl4?=
 =?utf-8?B?ajJOUlNyc003VXVGSkNYUzdsRTk1ZGM2U1VtSVFyTDlIY0s4MkZQbHNhMDls?=
 =?utf-8?B?VHBZS0Rpa3RkQ0MrUDRXUjZnS25zckp4SlJnSGxsakM4NWF5TWUwckZxNmlG?=
 =?utf-8?B?Rjg2b2pMTHdxcld0enpMclNjc1JnU2tmTy9HU2hPWTg5L1Y0Sno3ODVCanNp?=
 =?utf-8?B?dDNReGI5YVI5UksvZjVzdGQvZWR2dHEzczVTUmlkLys0YVJwOTVNV2NJUEVj?=
 =?utf-8?B?UXJMZDhNajZLVWxrcGNRWDc1aVRnQStIbTZWWXcrY2xIN0pTdkMzeVljbDJU?=
 =?utf-8?B?YjBTdVFaMjFsQ2QvampNc2FIdFZOYVhHcUtzdlpKSGxuZGZNTlA1MVY2SFdH?=
 =?utf-8?B?Qk5Ncytsc2NETWp4NkJnOW1rMW13emNmT3RwSFZhYjg4YXRUQVpOODkrY0pp?=
 =?utf-8?B?aFhtK3dDSUliOHQycVU1ektjdWgxOTI5YkNLN3E2alQvd2NjUkNrS3lxbUdD?=
 =?utf-8?B?b21Rdzk4Y2hYcEtlYVAwS1lmNHZpNkJwM09SWEtXaEdzNHR0ZG84cjQrTU1F?=
 =?utf-8?B?ME4rQzltaUxxaTFSL3ZwWVVaTFF5MVhLYmdvYTQ1SXRiK3JhbHN2SUxvdnZU?=
 =?utf-8?B?ZlF2ejhvVUs0QU9mR0pyZGZGNzF2L1VSV3BjZEk4RWVNandBZE5RZGFJVXlO?=
 =?utf-8?B?L25FeGtFcnhKUkhtaDdyTEZUdEhkd0JOYmpRVnJZTzJxZ0hLZzZmaUgzQWRr?=
 =?utf-8?B?Y3UyQ0JjY01qcXgydXNaOTd3bXZjdis3TkthT3VhY1ZuZTMrdVZRd1kxTHBF?=
 =?utf-8?B?R3U1QnA1NWF5MmRSYTcvM2d6dUlVTVFyblpOQll0QUNleXh2ZmlJREN0Y1hz?=
 =?utf-8?B?dUpRc2p3VnhCR1B4eFNydDBLbGM1Slhza3F0S0tpY3hxWUROK1I5eVRtZzUx?=
 =?utf-8?B?Kzd3Q2JSNVB0WUsrZHNHaUkxK1pzdThWNnZudmxPd3Q1UmhMSWRtSEEyNFZB?=
 =?utf-8?B?MjVuYWhUbGF4d3dYdVFmeklvWEtuV0I5ekJoT1k2TzRVSDdtbnpxeGJmOGdk?=
 =?utf-8?B?Y3UzVDRZdnZlemRIMXpHYTl2TUYwUmxsOUZRSzFETXZYVW9iQlQyUFhRd0J4?=
 =?utf-8?B?ZitoVFB1VWkwb1F4SWhUeXRJQXpJb0RkZURSSFdFajB3U3NwTnBvVlpJdHZ6?=
 =?utf-8?B?a1g5M1BYTDZqcWVrdlh5cExNUG02TENHNVdrUDRNcnk0QUp1MEI5WmlIbFZa?=
 =?utf-8?B?VmdBYVFMODdlVEV0czI1d2M0aWIxeWhCZUFYQlZlcDYySFhsT1F5Rkw4b2lO?=
 =?utf-8?B?V0hORXAxUmVNY0R5VTV1dTZpZGI3VWxMR0VCUDdyd2tRSGppOTBVQ1pvUUto?=
 =?utf-8?B?bFRTbDRraUExUzFpMXV1NWY1cDc2dW8ydWZ4RVJTVUozZGdTeFd6MEZQWXJG?=
 =?utf-8?B?cS8rZUd1L1dZMi9TWDdvR1hIRzJyL1MrQ3ZvemQxUjk4UlhQVGp3VHpIcmY1?=
 =?utf-8?B?eXpnM1VtWmE5VGI4RytKYkNCN1g4eU50SzRCb2l5WHp5SU9qS014aVA0ejkr?=
 =?utf-8?B?a21hc2hQY25EeDFwcFpJME5WRGFMSHN5bUlYWG05ME81OEUvbk01NldqSmFT?=
 =?utf-8?Q?7BRqEksyjWKuwxdPtK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a64da-d592-4332-f454-08df25224a90
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:55:32.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1MBdLLMWtNQAw9+7NPstkxjDpBlk2izLYmTcuN3MxnigYfTCAvdxMqdLem6j0hU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717

On 10/8/26 11:46, Matthew Auld wrote:
> On 07/10/2026 19:11, Thomas Hellström wrote:
>> On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
>>> If p2p is allowed on the CPU (like on AMD), we currently permit p2p
>>> for
>>> all exported VRAM buffers. However, in some multi-GPU setups, like
>>> with
>>> prime rendering on a dgpu and scanout/compositor using the igpu, it
>>> looks like the exported dma-buf window buffer can in some cases end
>>> up
>>> using p2p.
>>>
>>> However, user is reporting a kernel regression where performance here
>>> massively tanks across many games/workloads, where it looks like on
>>> each
>>> frame, the igpu is reading/sampling from VRAM over pcie for the
>>> window
>>> buffer, since it uses p2p. p2p is currently more intended for dgpu <-
>>>>
>>> dgpu, and not so much display buffers with igpu <-> dgpu, at least
>>> for
>>> now.
>>>
>>> We don't currently have any hints to say "please use p2p for this
>>> buffer, or please don't", however we can use some heuristics to try
>>> to
>>> determine if this is likely a display buffer being exported to an
>>> igpu,
>>> which probably never intended for p2p:
>>>
>>>   1. FLAG_SCANOUT being set on the buffer. Window buffers usually get
>>>      tagged with this, but not always.
>>>
>>>   2. Importer being a PCI device with display, which is not xe driver.
>>>
>>> We also rely on the existing p2p Intel CPU whitelist to stop this
>>> happening on xe igpu. Currently p2p is only enabled for server CPUs,
>>> on
>>> Intel. We also limit the above to dual placement buffers.
>>>
>>> The original regression was bisected to commit 609fc8766d68 ("dma-
>>> buf:
>>> Always build with DMABUF_MOVE_NOTIFY"), however the behaviour was
>>> already present when enabling that knob, so this goes back even
>>> further.
>>>
>>> User has confirmed that along with the sticky dma-buf TT placement
>>> fix,
>>> to prevent ping-ponging, the performance is back to normal.
>>>
>>
>> Actually, I think this needs to be fixed on the importer side. Until we
>> have some some user-space hints, I don't think the exporter should
>> second-guess. Most sane solution IMO is if igfx importers could just
>> not advertise pcie p2p support?
> 
> Yeah, not sure tbh. I'm not a huge fan of this patch either. But you could argue that the SCANOUT flag is already a good implicit hint/signal on the exporter side, but unfortunately there were some games where this did not reliably work. The other implicit hint/signal is perhaps the dual placement angle. For example, in compute-runtime, it might be that they use VRAM-only if they want p2p? AFAICT mesa for us always uses a dual placement or just system memory for these types of buffers.
> 
> Christian, do you have any thoughts here? We have a kernel perf regression after DMABUF_MOVE_NOTIFY was made the default after updating to a new kernel. The gist is that this then turned on the p2p paths, with a multi-GPU setup with an AMD igpu/APU and Xe dgpu doing prime rendering. From the user bug report it sounds like the dgpu linear window buffer exported to the compositor (igpu) is dual placement VRAM + TT, and so this now attempts to keep that memory in VRAM instead of moving it. Compositor then uses p2p to access it. It works but performance falls off a massive cliff here.
> 
> Perhaps Intel Mesa side should use tt-only for this type buffer (?), but since this is a kernel regression I was hoping we could fix this on the kernel side.
> 
> Some questions:
> 
> 1. Do you know what is the general story with p2p between igpu and dgpu? Is this a legit thing? For igpus/APUs, advertising p2p can't be dropped? It clearly seems to work though.
> 
> 2. If this is legit, do you guys then also prevent p2p with display buffers? Are you just doing that at the Mesa level, or is there some magic in the kernel also?

If I understand that correctly that the igpu is the importer and the dgpu is the exporter then yeah Thomas is right that definately needs to be fixed on the importer side.

At least for AMD APUs we clearly support P2P both as exporter and importer, but what isn't supported is to scan out over P2P. We explicitely reject that inside DC/DAL.

And I'm pretty sure that you should do that as well. I'm actually really suprised that this works technically and doesn't cause corruption or anything.

Regards,
Christian.

> 
>>
>> Thanks,
>> Thomas
>>
>>> Assisted-by: LLM
>>> Closes:
>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>> GPUs")
>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.12
>>> ---
>>>   drivers/gpu/drm/xe/xe_bo.c      |  3 +-
>>>   drivers/gpu/drm/xe/xe_bo.h      |  1 +
>>>   drivers/gpu/drm/xe/xe_dma_buf.c | 63 +++++++++++++++++++++++++------
>>> -- 
>>>   3 files changed, 51 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>> index 5065a7bac39c..e63437a261cb 100644
>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
>>> void *data,
>>>        * Display scanout is always non-coherent with the CPU
>>> cache.
>>>        */
>>>       if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
>>> -        bo_flags |= XE_BO_FLAG_FORCE_WC;
>>> +        bo_flags |= XE_BO_FLAG_FORCE_WC |
>>> XE_BO_FLAG_SCANOUT;
>>>         if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
>>>           if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
>>> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
>>> *file_priv,
>>>                      DRM_XE_GEM_CPU_CACHING_WC,
>>>              
>>> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
>>>                      XE_BO_FLAG_FORCE_WC |
>>> +                   XE_BO_FLAG_SCANOUT |
>>>                      XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>>>       if (IS_ERR(bo))
>>>           return PTR_ERR(bo);
>>> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>>> index 1ddf3b6d4a9e..6965c2655731 100644
>>> --- a/drivers/gpu/drm/xe/xe_bo.h
>>> +++ b/drivers/gpu/drm/xe/xe_bo.h
>>> @@ -56,6 +56,7 @@
>>>   #define XE_BO_FLAG_FORCE_USER_VRAM    BIT(25)
>>>   #define XE_BO_FLAG_NO_COMPRESSION    BIT(26)
>>>   #define XE_BO_FLAG_NEEDS_1G        BIT(27)
>>> +#define XE_BO_FLAG_SCANOUT        BIT(28)
>>>     /* this one is trigger internally only */
>>>   #define XE_BO_FLAG_INTERNAL_TEST    BIT(30)
>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>>> index b973579a69b8..0a347f09cee4 100644
>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
>>> _ddebug *desc, bool *flag)
>>>   #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
>>>   #endif
>>>   +static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>> *attach)
>>> +{
>>> +    struct drm_gem_object *obj = attach->importer_priv;
>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>> +    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>> +
>>> +    XE_WARN_ON(xe_bo_evict(bo, exec));
>>> +}
>>> +
>>> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>> +    .allow_peer2peer = true,
>>> +    .invalidate_mappings = xe_dma_buf_move_notify
>>> +};
>>> +
>>> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
>>> +{
>>> +    while (dev) {
>>> +        if (dev_is_pci(dev))
>>> +            return to_pci_dev(dev);
>>> +        dev = dev->parent;
>>> +    }
>>> +    return NULL;
>>> +}
>>> +
>>> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
>>> *attach)
>>> +{
>>> +    return attach->importer_ops == &xe_dma_buf_attach_ops;
>>> +}
>>> +
>>>   static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>>>                    struct dma_buf_attachment *attach)
>>>   {
>>>       struct drm_gem_object *obj = attach->dmabuf->priv;
>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>       bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
>>>         xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
>>> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
>>> *dmabuf,
>>>           pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach-
>>>> dev, verbose_p2p_dist) < 0)
>>>           attach->peer2peer = false;
>>>   -    if (!attach->peer2peer &&
>>> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
>>> +    if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
>>> +        struct pci_dev *client =
>>> xe_find_parent_pci_dev(attach->dev);
>>> +
>>> +        /*
>>> +         * There are perf issues with using p2p with display
>>> buffers,
>>> +         * like with igpu (compositor) <-> dgpu (exported
>>> p2p window
>>> +         * buffer). Probably we need some actual userspace
>>> hints. We
>>> +         * shouldn't really assume anything. Also, note that
>>> some of
>>> +         * these buffers are not always tagged with SCANOUT.
>>> +         */
>>> +        if (bo->flags & XE_BO_FLAG_SCANOUT)
>>> +            attach->peer2peer = false;
>>> +        else if (client && pci_is_display(client) &&
>>> +             !xe_dma_buf_attach_is_xe_device(attach))
>>> +            attach->peer2peer = false;
>>> +    }
>>> +
>>> +    if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
>>>           return -EOPNOTSUPP;
>>>         xe_pm_runtime_get(to_xe_device(obj->dev));
>>> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
>>> struct dma_buf *dma_buf)
>>>       return ret ? ERR_PTR(ret) : &bo->ttm.base;
>>>   }
>>>   -static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>> *attach)
>>> -{
>>> -    struct drm_gem_object *obj = attach->importer_priv;
>>> -    struct xe_bo *bo = gem_to_xe_bo(obj);
>>> -    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>> -
>>> -    XE_WARN_ON(xe_bo_evict(bo, exec));
>>> -}
>>> -
>>> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>> -    .allow_peer2peer = true,
>>> -    .invalidate_mappings = xe_dma_buf_move_notify
>>> -};
>>> -
>>>   #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>>>     struct dma_buf_test_params {
> 

