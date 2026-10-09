Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E44CE663
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545904; cv=fail; b=aMdBs7gY8Ko+o1uRp0u/01ezz0acL3k/+GsQQCFt4N/1hApOblZKNChZYsCMXq+ESwnF8oNE6HwGpJlPAV5mkGEjmFC2cMH82MyXSicWO0j41mcJ0ElPRkoydZyfmpNrPYAJkou1TXEER7pSvws4j6WukD9W8pjGBhpVArTXjFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545904; c=relaxed/simple;
	bh=oiWwMkCHstLbmEPI0LIvsvuZt1PliD2yuaTagqGrShg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C0KNxOLMxYdCFEoEM2+6a+T3dofYKUwOgRE/9o1dkmoYVpwp9CA5YUU+yPAtTfUrr0x5DqMzXH7vnhGtKmrh+SZbSi7aFaHxkd2J81xJ4P6sLU0faZLkMOEVMTj/h8ZUDw/C2Z/a1+Do5XP0mUBRGf696L59MiE+kMgMvt9RU68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zG4tveVj; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zG4tveVj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccTghcXEkh66r+ZKq6yhcuIs14qXkPwa0DzIQlwadsfrFrIAQiWihHco2KI4tRaJpIYpNk6biHur31FISbJdlg8DtSRyMfesHWrIo/PFrh6K/NflPVWZMWqsDMNXt2CVxFh5VG8F6/ShCfzkMcsspLx/thx64GEi+GJnMD4xsq2qA+nBTGgJKmQNYvAPy8mf7anqOmxSA2T9YeuVTCvLGn3nYBqOyiKkmLNOn+HrHDB0lYDfMUQYHvG5tYDJNmqd/uhC9spPhzqZL6UsPOgWupb7pW3GVfQYzKFCvjN/0USyTDX/EaMTZ1dYLtXXEhIOqf9+66TnrxHHZX3rbSntgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GumxZlj11PssrT67j0PvEHnclnEEPx23uT/aoYE2R9A=;
 b=K6m58bOCgR+wTcvAgsyWRGTv/EnH42gkwmUufnWHBhBCfEdVqh1EQABj7iQGlbDED2VReqPjha+j2w+Wjy4Oa8/USRHxAq2sTtCRPvPugidUxch6Wis8+qcon27itZWXl5e2Gbuiku+8Bpk1JLIZLhxzCsJboj/Wuou2ugzPq7Tqix/oBj1d5FARM0FitnPOs2ShD9FNMbkopQ6LjjxEBl6rFXKKrkaADrmUSM/oMBKo1N9bN33duCPaoAtHCxTN3bZJ0850E4rsiWTVEZBNeyhbVEhcHLXJwcJWy0/KrUzshAB+yfbhemvooIy1muqLKcGUas5qSaUrq4xLKiHWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GumxZlj11PssrT67j0PvEHnclnEEPx23uT/aoYE2R9A=;
 b=zG4tveVjTZg8LwEueAMIV8Byo0NGy0ooPmT/W+ci1Pl4c+W2Qpb3f590iB3LqpN6dhIxaag6A8IFPFunzakYa6QRqYIrNJ+A5sMjCTVa5AXN3fstRHG7Ql8qoWVYYLF3+BcG8UYNEJge6T8oXsEIuUse4JVJHRjXi0N8xy7B8VI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7236.namprd12.prod.outlook.com (2603:10b6:510:207::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:38:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 11:38:10 +0000
Message-ID: <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
Date: Fri, 9 Oct 2026 13:38:05 +0200
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
 <bc2f4d82-5a8e-4d1b-a921-ee819ca5cac2@amd.com>
 <992d57f0-7327-4c36-adf7-6dd72137fe73@intel.com>
 <31f7eb68-6dfa-4ea7-93a4-d4897fbe6a74@intel.com>
 <3579864a-0283-4f92-b895-5cf399c2ee69@amd.com>
 <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <16cfde6b-8881-4ffe-8068-9530286da72a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 97100846-77ac-477a-7c15-08df25f9cb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	k39A4uGP3zbryBgT3W9kwpTokTbQXSHDDMsOvrnyt7z6WD/j31dE9R2j72yUBk6oacGN837yGHMUoyPpG3FXoqcjMxKAyMPIOoUx4omSlwezhTr6y+GRO9HYutbpq38eL3CH/h9a5N+851Hbpu3hLg4vF1WjZFDpqcx8tpeapqAqupPmTmEQjEW120CCtgYPTTA1ho3LecA1NQO1Nq4bcGtwKmMQ4xkA8GDLu+ATjDJHnXLjRDvwBEkfgq9EmT55AEpP+GlXI9up7mT0X4sJmkBygTOXfqRgJX2LZztEcQFxm67SBPmhjWDYMKOnigD8aQDPRRaNUT8N7w935KWc9CnEmXm0aBtpJcqaIqpTgmfM4fWf57yuwYCzSsz4tt4EWCUZ2t1otp1utYvCK86uYrFmx0x7YGqoPpZbtnJIRPxZPomzY69I6qJQqW2QZa2yWtWVsFeopTWbthrMwtZCSixofaLvey816umuaxwSriJ3sCUN4Vy5qgHLsh4Otni4sRQ9ZG1vNGbf0ausdkvuOLRPdepSJ5jAVUOUCN/NcZmOhSvT/rTNU82LiHmzD8t7IWaQsljwDgPMaHu9fB9c8NCYDFbwqRYXHIwibCWRdMsZYlFq6WW+p9ZVx1tTi4fx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UCtiSU1hTUVqamZObTVyQklJQkxQYnlvVlI2WXVuSVd4MjdRVDJ3L25WVWxr?=
 =?utf-8?B?QmRQbzRzZzZESVl2OExMNDMwMzBkeml2ZXFraWdqd0VUbmVPVEVpdUR4NThy?=
 =?utf-8?B?dVJSTG4zbnhuaHZiUVhPU1dpdmxZT293OTVob1dpUGdZZU9zY081ZlJ5U3d0?=
 =?utf-8?B?UVR3WFVVM2tBdVV3Qzk1c2p5ZWlhamtWZVpGd3BlWlQzUk9UM1NxK016RE9q?=
 =?utf-8?B?OWZYSzZMY3R1TVRIc2xVb24rM0xkRXRqUk1WVkhsaWNOeWNSbWhiWCtPQThH?=
 =?utf-8?B?S2xSc0U5WXBGamN5VHVreHFTT3VzZDVZMDlnVEZSakcvaTJjaHB2LzMra2xR?=
 =?utf-8?B?WGp6RkcySzhYMDhjMmFHcVZJUklsTHk0eFlBdEtsVzh4Vm5LckhRdFRuejkw?=
 =?utf-8?B?MHhUKzdrVlBZaUpkbnZmbzlJWnYxMDd5V1h3aVBpRTFEZkMxOXIxajlkNTkx?=
 =?utf-8?B?ZEgzZGdndGdpQy9mc0tNeElEelp6Z0Z1cmladkMwSEtpVmxUbEFabURHOGRD?=
 =?utf-8?B?VUU2bzZxTUFTWmV0ZU1tQnJRQlhQOXlNRllGVXpwdEN4a2lwQkdDZzdxcVFw?=
 =?utf-8?B?R0Ywa3RobGwrTVNTU2xONGE4OGxiOVg2WldNT1pnTEhCQXBsOUovajQ4UUY3?=
 =?utf-8?B?aHlDNmcxdDQybzZqekZoeG15WlN2UVhzY2xqL0QrZmh1aUEvUHV0NzVPWnVD?=
 =?utf-8?B?Y242eXFKYnhVSTg3OEw5d0Z5cWxpTWlCZm5YOTdHNFU5MUppU1pDNlZDM0JD?=
 =?utf-8?B?S0Eya2JTYnBRdjQvQWZBbVU4N3VHTmQwaktUSm05czI4YzFsMFo1czRBZ1dp?=
 =?utf-8?B?MHVxS1dUcXdiZ1JPVWdJakNDYVQxSmNRUXlhYVROM0s0WjBrMEdtM2V1V2Uv?=
 =?utf-8?B?cTI0S3VDK2NsTVgzaXg0V3VpMERVViszUExxblU4Ym1pOEdUUmNYZWg5ekY2?=
 =?utf-8?B?azV3dVBzdUJUMUkwY1l6MUN0Ujh2cENsV2w0Z1daakJnSjMzWGFyeXRPd1dR?=
 =?utf-8?B?ZzRnOXdHc2d0R3FSRDlvSnNiRGZZR01GMHdZNHdiaHZXMHJ3ekI2NnZiWnlT?=
 =?utf-8?B?dmllUjdScEtBVURZMFQzUUk5Q3ByL3NuN0xGbkVWUmVHckRMcCtXNGJwdkVJ?=
 =?utf-8?B?S0k1TnpmN282N2ZiZkhQRWVkQ3l3aTlnTVBsU3lLL2hlR1lpTGxnSmR0Nnc3?=
 =?utf-8?B?OHROSzZCeWpueEswK2NCUGVMN2VKMWhhUUdzYitNRjZISmNvUFhtSjFuelQz?=
 =?utf-8?B?MmRyejlaNjFaTU5BN0tPeTl0YVprUEdEemZIVzNDa1F2Lzl4MXZKZ1hoeGtx?=
 =?utf-8?B?eWlJcHNpMlZHbWtvZUxSVExSQ0JPZ2hSNVNCQXUzUktFMUNWRnMxU2RpSVN0?=
 =?utf-8?B?SURkNFkxN0JnSFBzM0d6akdMY2l3UXhwQmpaNkVDeC90c25paE9CODhPZWlP?=
 =?utf-8?B?UmlhMTdzMDYzMWxweWg1TkFsRlNNaDV0REtPTGZYbmVza1llcXAyS0lNVHhL?=
 =?utf-8?B?Z2dhYnBXOGQ3dWl3cnA5ckExVE0xOHBRUEhnb1F5TlFiMmdUb2dnS0dodHIv?=
 =?utf-8?B?ZVdIeWFwTThMcTBFU2JWa0k5cXl6RUswa0l6aS9lWVFqVnZBamZZZC9VQUQ4?=
 =?utf-8?B?WDU0MXZwaVhtTTY5UGo4cGg2Nmozb3hqbmFVYmRVelQ1MUhqWkZ4cTM4VHVi?=
 =?utf-8?B?SUJ3Qy9mcTEyQ1NYTXVWRjB6TFFiS3RHSjZ0SlNJQURQL1lXQmJWWkxBWis5?=
 =?utf-8?B?ckUxN0dKaFdaSDdKZXhZOGFUNG1mdi9XSHlQNFJGOGx2dG9lNXFDSXhSRTJP?=
 =?utf-8?B?V0czZ1RucnFCZzE0dGdYMG9tTlBidmpYa0YyV1ZxRXByOUlRdmdzbWphZmVX?=
 =?utf-8?B?K291RjduRXN2NVQ5NEljbC91TEFIM0Z0NnVlR3NUbGh4cDlPcGlLMjRLcHhw?=
 =?utf-8?B?OGhkbU50SEFvRnBEczZpV2ExYXZyZTRHSXh3RUNsSWREME9oQVZUaXlDYWRH?=
 =?utf-8?B?V3EwOG0rUkp6bTV0NGJFMmEvUTZaL1dmTmhNNVpydXpxTjM3a0s4Vnp1d1hp?=
 =?utf-8?B?akZkYlE4RG5CYnVucE82UWMxa2N4YmtxV0JNWlVCbjFnTTJ0c1pIZldxTUJM?=
 =?utf-8?B?UkJkUnQxdGhYa2RscWplcUVPeUNOdks5MGRYeTZJWDB0VUVZcFUxVmpQUUtN?=
 =?utf-8?B?Z0hLaWZUYU9SZHlHb05tcHdYTzF2SUVSeDR2bnZIQVZQRE9KdXhqdTBkeWhz?=
 =?utf-8?B?ZW9UOGFJS0I0NDRTa3lHUVVaaGhQdkdZZnhYMHA1MmZJam53Q3ozd3liend5?=
 =?utf-8?Q?5cH3w0LrSe4t/Vaeu7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97100846-77ac-477a-7c15-08df25f9cb5f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:38:10.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFcQ4lKTGNM3FcJxY2Yu2Lk6i3UeSpj/g7ZdA/ghPqPvJAamx//Wo3wq4SzTGQgT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7236

On 10/9/26 12:29, Matthew Auld wrote:
> On 09/10/2026 10:26, Christian König wrote:
>> On 10/9/26 11:16, Matthew Auld wrote:
>>> On 08/10/2026 12:17, Matthew Auld wrote:
>>>> On 08/10/2026 10:55, Christian König wrote:
>>>>> On 10/8/26 11:46, Matthew Auld wrote:
>>>>>> On 07/10/2026 19:11, Thomas Hellström wrote:
>>>>>>> On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
>>>>>>>> If p2p is allowed on the CPU (like on AMD), we currently permit p2p
>>>>>>>> for
>>>>>>>> all exported VRAM buffers. However, in some multi-GPU setups, like
>>>>>>>> with
>>>>>>>> prime rendering on a dgpu and scanout/compositor using the igpu, it
>>>>>>>> looks like the exported dma-buf window buffer can in some cases end
>>>>>>>> up
>>>>>>>> using p2p.
>>>>>>>>
>>>>>>>> However, user is reporting a kernel regression where performance here
>>>>>>>> massively tanks across many games/workloads, where it looks like on
>>>>>>>> each
>>>>>>>> frame, the igpu is reading/sampling from VRAM over pcie for the
>>>>>>>> window
>>>>>>>> buffer, since it uses p2p. p2p is currently more intended for dgpu <-
>>>>>>>>>
>>>>>>>> dgpu, and not so much display buffers with igpu <-> dgpu, at least
>>>>>>>> for
>>>>>>>> now.
>>>>>>>>
>>>>>>>> We don't currently have any hints to say "please use p2p for this
>>>>>>>> buffer, or please don't", however we can use some heuristics to try
>>>>>>>> to
>>>>>>>> determine if this is likely a display buffer being exported to an
>>>>>>>> igpu,
>>>>>>>> which probably never intended for p2p:
>>>>>>>>
>>>>>>>>     1. FLAG_SCANOUT being set on the buffer. Window buffers usually get
>>>>>>>>        tagged with this, but not always.
>>>>>>>>
>>>>>>>>     2. Importer being a PCI device with display, which is not xe driver.
>>>>>>>>
>>>>>>>> We also rely on the existing p2p Intel CPU whitelist to stop this
>>>>>>>> happening on xe igpu. Currently p2p is only enabled for server CPUs,
>>>>>>>> on
>>>>>>>> Intel. We also limit the above to dual placement buffers.
>>>>>>>>
>>>>>>>> The original regression was bisected to commit 609fc8766d68 ("dma-
>>>>>>>> buf:
>>>>>>>> Always build with DMABUF_MOVE_NOTIFY"), however the behaviour was
>>>>>>>> already present when enabling that knob, so this goes back even
>>>>>>>> further.
>>>>>>>>
>>>>>>>> User has confirmed that along with the sticky dma-buf TT placement
>>>>>>>> fix,
>>>>>>>> to prevent ping-ponging, the performance is back to normal.
>>>>>>>>
>>>>>>>
>>>>>>> Actually, I think this needs to be fixed on the importer side. Until we
>>>>>>> have some some user-space hints, I don't think the exporter should
>>>>>>> second-guess. Most sane solution IMO is if igfx importers could just
>>>>>>> not advertise pcie p2p support?
>>>>>>
>>>>>> Yeah, not sure tbh. I'm not a huge fan of this patch either. But you could argue that the SCANOUT flag is already a good implicit hint/ signal on the exporter side, but unfortunately there were some games where this did not reliably work. The other implicit hint/signal is perhaps the dual placement angle. For example, in compute-runtime, it might be that they use VRAM-only if they want p2p? AFAICT mesa for us always uses a dual placement or just system memory for these types of buffers.
>>>>>>
>>>>>> Christian, do you have any thoughts here? We have a kernel perf regression after DMABUF_MOVE_NOTIFY was made the default after updating to a new kernel. The gist is that this then turned on the p2p paths, with a multi-GPU setup with an AMD igpu/APU and Xe dgpu doing prime rendering. From the user bug report it sounds like the dgpu linear window buffer exported to the compositor (igpu) is dual placement VRAM + TT, and so this now attempts to keep that memory in VRAM instead of moving it. Compositor then uses p2p to access it. It works but performance falls off a massive cliff here.
>>>>>>
>>>>>> Perhaps Intel Mesa side should use tt-only for this type buffer (?), but since this is a kernel regression I was hoping we could fix this on the kernel side.
>>>>>>
>>>>>> Some questions:
>>>>>>
>>>>>> 1. Do you know what is the general story with p2p between igpu and dgpu? Is this a legit thing? For igpus/APUs, advertising p2p can't be dropped? It clearly seems to work though.
>>>>>>
>>>>>> 2. If this is legit, do you guys then also prevent p2p with display buffers? Are you just doing that at the Mesa level, or is there some magic in the kernel also?
>>>>>
>>>>> If I understand that correctly that the igpu is the importer and the dgpu is the exporter then yeah Thomas is right that definately needs to be fixed on the importer side.
>>>>
>>>> Ideas on how do that? Could we do something like allow_peer2peer = false in amdgpu_gem_prime_import() if this is an APU device, or further check if the exporter side is not amdgpu, like APU + Xe?
>>>
>>> For example: https://gitlab.freedesktop.org/mwa/kernel/-/commit/7ec86c68b42655b4bb85ee90af434a617e7bec8c
>>>
>>> Is that something you would accept?
>>
>> No, you misunderstood me. Enabling P2P is perfectly fine for APUs and mandatory for a couple of customer projects.
>>
>> The buffer should just be rejected from scanout in the display code and on the AMDGPU side we already do that if I'm not completely mistaken.
> 
> Reporter confirmed seeing the issue in windowed mode also. So I don't think it's just a case of rejecting from scanout?

Then I don't understand what the problem is.

When the dGPU renders and the iGPU displays you have only two possibilities, either the dGPU pushes the frames over the bus or the iGPU pulls the frames over the bus. Both should be equaly slow or fast, so what exactly is the expectation here?

The only thing you need to avoid is that the iGPU starts to scan out over the PCIe bus directly, cause then the frame is pulled over the bus multiple times (if that actually works correctly).

Do you have a link to the original bug report? I was only added later to the discussion so I don't have that.

Regards,
Christian.

> 
>>
>> Userspace has fallback path that when a DRM atomic requests fails for an imported buffer it falls back to copying the buffer first.
>>
>> Regards,
>> Christian.
>>>>
>>>>>
>>>>> At least for AMD APUs we clearly support P2P both as exporter and importer, but what isn't supported is to scan out over P2P. We explicitely reject that inside DC/DAL.
>>>>>
>>>>> And I'm pretty sure that you should do that as well. I'm actually really suprised that this works technically and doesn't cause corruption or anything.
>>>>
>>>> AFAICT on Intel iGPUs it will currently always end up with peer2peer = false on attach. Not 100% sure if direct scanout was happening on the p2p buffer itself, for the user report.
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Thomas
>>>>>>>
>>>>>>>> Assisted-by: LLM
>>>>>>>> Closes:
>>>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>>>>>>> GPUs")
>>>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>> Cc: <stable@vger.kernel.org> # v6.12
>>>>>>>> ---
>>>>>>>>     drivers/gpu/drm/xe/xe_bo.c      |  3 +-
>>>>>>>>     drivers/gpu/drm/xe/xe_bo.h      |  1 +
>>>>>>>>     drivers/gpu/drm/xe/xe_dma_buf.c | 63 ++++++++++++++++++++++++ +------
>>>>>>>> -- 
>>>>>>>>     3 files changed, 51 insertions(+), 16 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>> index 5065a7bac39c..e63437a261cb 100644
>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
>>>>>>>> void *data,
>>>>>>>>          * Display scanout is always non-coherent with the CPU
>>>>>>>> cache.
>>>>>>>>          */
>>>>>>>>         if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
>>>>>>>> -        bo_flags |= XE_BO_FLAG_FORCE_WC;
>>>>>>>> +        bo_flags |= XE_BO_FLAG_FORCE_WC |
>>>>>>>> XE_BO_FLAG_SCANOUT;
>>>>>>>>           if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
>>>>>>>>             if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
>>>>>>>> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
>>>>>>>> *file_priv,
>>>>>>>>                        DRM_XE_GEM_CPU_CACHING_WC,
>>>>>>>> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
>>>>>>>>                        XE_BO_FLAG_FORCE_WC |
>>>>>>>> +                   XE_BO_FLAG_SCANOUT |
>>>>>>>>                        XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>>>>>>>>         if (IS_ERR(bo))
>>>>>>>>             return PTR_ERR(bo);
>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>> index 1ddf3b6d4a9e..6965c2655731 100644
>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>> @@ -56,6 +56,7 @@
>>>>>>>>     #define XE_BO_FLAG_FORCE_USER_VRAM    BIT(25)
>>>>>>>>     #define XE_BO_FLAG_NO_COMPRESSION    BIT(26)
>>>>>>>>     #define XE_BO_FLAG_NEEDS_1G        BIT(27)
>>>>>>>> +#define XE_BO_FLAG_SCANOUT        BIT(28)
>>>>>>>>       /* this one is trigger internally only */
>>>>>>>>     #define XE_BO_FLAG_INTERNAL_TEST    BIT(30)
>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> index b973579a69b8..0a347f09cee4 100644
>>>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
>>>>>>>> _ddebug *desc, bool *flag)
>>>>>>>>     #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
>>>>>>>>     #endif
>>>>>>>>     +static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>>> *attach)
>>>>>>>> +{
>>>>>>>> +    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>> +    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>>> +
>>>>>>>> +    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>>> +    .allow_peer2peer = true,
>>>>>>>> +    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
>>>>>>>> +{
>>>>>>>> +    while (dev) {
>>>>>>>> +        if (dev_is_pci(dev))
>>>>>>>> +            return to_pci_dev(dev);
>>>>>>>> +        dev = dev->parent;
>>>>>>>> +    }
>>>>>>>> +    return NULL;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
>>>>>>>> *attach)
>>>>>>>> +{
>>>>>>>> +    return attach->importer_ops == &xe_dma_buf_attach_ops;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>     static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>>>>>>>>                      struct dma_buf_attachment *attach)
>>>>>>>>     {
>>>>>>>>         struct drm_gem_object *obj = attach->dmabuf->priv;
>>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>         bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
>>>>>>>>           xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
>>>>>>>> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
>>>>>>>> *dmabuf,
>>>>>>>>             pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach-
>>>>>>>>> dev, verbose_p2p_dist) < 0)
>>>>>>>>             attach->peer2peer = false;
>>>>>>>>     -    if (!attach->peer2peer &&
>>>>>>>> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
>>>>>>>> +    if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
>>>>>>>> +        struct pci_dev *client =
>>>>>>>> xe_find_parent_pci_dev(attach->dev);
>>>>>>>> +
>>>>>>>> +        /*
>>>>>>>> +         * There are perf issues with using p2p with display
>>>>>>>> buffers,
>>>>>>>> +         * like with igpu (compositor) <-> dgpu (exported
>>>>>>>> p2p window
>>>>>>>> +         * buffer). Probably we need some actual userspace
>>>>>>>> hints. We
>>>>>>>> +         * shouldn't really assume anything. Also, note that
>>>>>>>> some of
>>>>>>>> +         * these buffers are not always tagged with SCANOUT.
>>>>>>>> +         */
>>>>>>>> +        if (bo->flags & XE_BO_FLAG_SCANOUT)
>>>>>>>> +            attach->peer2peer = false;
>>>>>>>> +        else if (client && pci_is_display(client) &&
>>>>>>>> +             !xe_dma_buf_attach_is_xe_device(attach))
>>>>>>>> +            attach->peer2peer = false;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
>>>>>>>>             return -EOPNOTSUPP;
>>>>>>>>           xe_pm_runtime_get(to_xe_device(obj->dev));
>>>>>>>> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
>>>>>>>> struct dma_buf *dma_buf)
>>>>>>>>         return ret ? ERR_PTR(ret) : &bo->ttm.base;
>>>>>>>>     }
>>>>>>>>     -static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>>> *attach)
>>>>>>>> -{
>>>>>>>> -    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>>> -    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>> -    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>>> -
>>>>>>>> -    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>>> -}
>>>>>>>> -
>>>>>>>> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>>> -    .allow_peer2peer = true,
>>>>>>>> -    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>>> -};
>>>>>>>> -
>>>>>>>>     #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>>>>>>>>       struct dma_buf_test_params {
>>>>>>
>>>>>
>>>>
>>>
>>
> 

