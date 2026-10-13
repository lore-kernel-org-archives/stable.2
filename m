Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF039FCAE
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882642; cv=fail; b=jZ3s/l4BBcOWCDGTNaTBIHtBKWj9t4Va+MYxEApKJ0X2rMJpeAy+lHwkZ4P+P8kGHdm917Wn4OuCS2qB9+dE+8zhCnYyC7j1PetS8zb9+gCa7QLM6JKzYXN2GvRhaxGFv94nl0u6OAXeBtN9wB2AEpXkMmyAMjM0qZcn8uyi48A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882642; c=relaxed/simple;
	bh=Ovr6Hj3FyFUonZndI6vJTH0W+lbGpItD8/IDtzQVDss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WIY1K+ZSGdVgYtV3ONFMmC/QgpjDbDyyzg3nNLWFiWbSrECThGbnlnMnDtvtZju+8eGqTSamOqLglbDkAOifOLGW4TUI31zjKg7RkmBmofrzUP7JTFTwcuDOLWndbG3NBcDHQDIwKXoGipkmslgRytlV4YDg2IXnvCt/AbB/1LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oCAS87/p; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oCAS87/p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xd5eN1DZr/n1rjF3x00H10hyQMGFYEv8dA6iV4co66CDEeJlKiRNEG0Ia+N0bMgJ4qhD+63Shp6Ea9M22SQUnh7iye1YMOkFVkLtPgA90PTAGFSTMVS2WFkC8MzmErV7ELfvBimmxLNzeC7ROOUqD5SVvCXKGMnKG5vfiJATH+/k4x41GqfP3qni3Y4bHwHVuU/2+pCnHb2uNjS8WrM5GKoFGDB++Xaeqd5ozjGdSJ654Z8ECSARGqwBjY6rEOD1Ksb4y+ajPcvLgrkY0MbReA3neaquOF8Aij/fZkzDdq99oIOgi7rBejrVXEHsuXS2a36DTOlBligjyDo9WCGopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEM/VGlCia1IojqQaq/eKJ2KoklBNZBPmgol8Vsz2ig=;
 b=EodZOTmhLmclxfnSm/BY6LTQWoAbd1ezliZjbpuxUClhC5yWfun7EAMogEy+EY7QwJUYtmz3t5Owy7/cgv0R2DEsNWpAIA9Rdi/oLfUWOIQEnx3F3VGZF68Hl+ihwPcG/2WmTU2HlfakjZdccq/OPgTK/7cktm0IUViokzfBuGIRfxYo1q7X6dvp5lz0Ge65cQbTl2V0WftCbWQNklhtmt+dTXIkr2SKBAb3zxPhBaSF0nGD5Q7S0K45GiV+FNkjyjVcyyKzzALNX9LslDnpjyvDHThmQ+pBsRT1M4n3goc/339eQ+GSLaxENNHRWk5ouTamGLvE55Isy1hNSCofvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEM/VGlCia1IojqQaq/eKJ2KoklBNZBPmgol8Vsz2ig=;
 b=oCAS87/pWB2s25LLQT6JkQkc5gqG/l85NyOv63pR4qlpNFg6stvs+lSmbdOJk4NyhcTcbngDsan+DevFNZiPLW6DJAtj+7mVd1/uYRDSXg3xhEyi1liCLpiXEIG1wAOOwh60PZgZzVG8zBe7po1PYc6Hrb/y6pmlMQBH4Bjp4ww=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 09:10:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:10:37 +0000
Message-ID: <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
Date: Tue, 13 Oct 2026 11:10:33 +0200
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
 <1a852df2-c2a4-48bb-84de-cdd4b98b95bb@amd.com>
 <d493d4d1-96d5-4194-bbae-5c1e5d54d91a@intel.com>
 <5545db90-3365-4d75-9fc0-77dda42b7000@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5545db90-3365-4d75-9fc0-77dda42b7000@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: 817604a2-a5d3-4934-7eeb-08df2909d851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|13003099007|261009223027099003|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9gYnSYqAWXkvWh+VzEibKNDUO8En6JojZ/BkYirpBhdlrvuaWStRFtFKVHDIiyQENadFvwTudIwbYOxzz1YI3PM8PhzOD0lXYtlZwXgmN6Mmj6KmZqceHdg4iKllZ8PFfl32dRsDF/2AC1e84ALGOwAKhqlj/hw6RNS5hbFRJl0FNUC4nczACDI0/h0NpFIg4Ensh31KLs0eo0rrCsOezKSYO7QMUHmaH6Mz1JE8Vk4yeUXUxkPw3ATXNQTK3c6hFBgrrOwTChm/42WDDuyITznOqFynNgRdDLaRn4L+EE1Z5U34lVhDVnyWNtn2JKuoSs92ix6Avd9h06eGNf1FnrSyKRjmVWm/8DWTT4ZmL0m3KDsbDKIuzxiTqmapVChN190KrrFFszYDctaR266Di/GR/rehwKWOYm8Sb/vu8Me+KhjbWLsbWvYj0gpWibpfLdk4DKiaY7eP6ItojBPq5X9ihBfehymy2tTkgBxh/xPvV+xSbpmTGR3/2p1WdDRSr8R4MLbsFi+YhqOsRZr7yrQ9YpvNtfm1CtcZxjpaOlkRvAiMHGlhYVVmQhdASTICibA8HVAgZbQD1seTM8jyORwCzZvhl0mjKTYIJV1WYi6BWsf+HqFisIQ2gEUKBN/2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(13003099007)(261009223027099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkVNWWZEU0FnK3NXRjViL3BFVkg4Q25MVW9mL1NBT2sxdXR6VWZlWWVEQ3E3?=
 =?utf-8?B?VFppUGtJV3BERkNLV3NPOURHQnE0QjFCcEZzd0YraWFGVWN4aUthU0tSVk5s?=
 =?utf-8?B?d2JyYjdLek5sQmh3OTlCOFFIeDRsdFhsOElpV1Y2QTVHMzJ6Q3lwRkhxV2ZH?=
 =?utf-8?B?YzFCb0FicFk0NkY2b1ZjQTFUNVVQeGtETDl1Ujc5SlpFYktxRGxrTnVxeFgr?=
 =?utf-8?B?YmFjUCtva0tZTFhHdGFwQ3FIeGJQT0N1eVZuVUw2V1RWeU5tcFFzS2hOV3lX?=
 =?utf-8?B?Y005OVE4L0RraVBFSkNqK3dNWnorVVNKcjV1cFJWU3NqQUNnRlBYNENvUkli?=
 =?utf-8?B?a0JoVldhbWltU21qV242U3Z5UVZaWVpvZys5ejJNTHRWdW4vZDUyVzlkLzVo?=
 =?utf-8?B?aERSNW5BQmJFU3VMNjlwUjJubEkzL3lGa0xBTmdOMFRGRjdYZ3Vpb0RHN3Fo?=
 =?utf-8?B?QS9DSjBucjlONHgyaEJKRTZ5dFpEa1V3S08xekw2YmsvRm5rOTFycjBOdmcy?=
 =?utf-8?B?S3ZIQnFzMHNKNVhza3RNTDczVzNOZDQ1ZlRqSUNrMm9SS1hXeTFDRWJPNnpN?=
 =?utf-8?B?MlZ5WjNQRFNEMmdlNmpXZnZiOXdLTWE4U3BUVDE0WE1BNUpzRmp5NXVaRWZF?=
 =?utf-8?B?TVNSOUpQMFhUU1dDb1J2UkFmOE5CbHJYMElJcW9iUHJOd0hUYklaYTBLaUxp?=
 =?utf-8?B?SkxiN2JldUxvcGMvUGV2Ky9mNHNhaHQzR1lhK1JTL1ZsMnkwOWY2bjRWSytu?=
 =?utf-8?B?QlIvaG5WeGE0bk5IZk1CUkFKak5XcXp0Y1dDTjdqSmJIbFgrelExVHo2NTBk?=
 =?utf-8?B?KzdJaG94eFBFUHJNVWxVckFtVVdWWHNYUGVqbnU0R2EvVlphaXVZVlQrNkF5?=
 =?utf-8?B?SkMvODVENkJRR1N5TUN3MlgvZEcvMXFOa1hicDdqd2IzL0lwa2lNcE91RXBI?=
 =?utf-8?B?R3lJSmpYTUZINHd0VkMwS0tPejdVcEdKbzMzYUZrY1NmS3Y1dmlYRWdZRk9I?=
 =?utf-8?B?MisrUFlPdVdlZWMwb29xTitWM0h0azY2V1Zkc0hwSC9lTjJJdElaV3lyQU5U?=
 =?utf-8?B?TXZOUDBqc2JuUDkrdzIxRjFldlBWMi9mNVh3WWxBdU9iM0k0ajFrV1hJUHJ6?=
 =?utf-8?B?RDNHZ0VrNnZUTmJ6K2czZlhMUkhKUFU5N2QwS2pabzc2VkllSkFxd25TTWZt?=
 =?utf-8?B?bVpKcXhqVnZvaVkyTHo0d0ZheDBMVythUTQ3M3dKb0oxUzNtOXR0cWFkVWRX?=
 =?utf-8?B?SDdqQkVOc3RVbW92Wm0yWXQxYmpTUHIyM00wSy8vQlQ1K0RsYzQ4ZXI1YU9K?=
 =?utf-8?B?Z1FVVC9vczEzdTZaMVZPWlJmZU9yTyszWk9yM2hmc2hEYkRUdllOZFJzWmRu?=
 =?utf-8?B?di8xVG8zNURpQisyQThqS2RvRVhZdUM2MWhjMExFbWk3Mnl4ZG80MDgxZmRl?=
 =?utf-8?B?b1h2cjlWZVRTb3FFMEpFVnpFNUlzMzZVYmR2eTNyRmFIeFR2QUFOWnNQNHNl?=
 =?utf-8?B?U2lZRjJLVys4MVNkMHpONnRXdm5LMUhjbmtwNE1QOGFlVHFnU0dkUU9Ucm1w?=
 =?utf-8?B?SkNPZUdQb28zRDdHcm9NV2ZvTnBlYkhMWWJrRmFOK01xbmVLRUF0UEc5bjlh?=
 =?utf-8?B?Sk91aFVPZE0wMXk1akk3cW9kZzVCaENIMHlPM25mL0xhTUtNTnF3Yjl5OHlO?=
 =?utf-8?B?WDMrdUxhK1g2b2JPN3NDVE1QQVdYbWw5N3FpRSt5WjRoZ2NXTzFFRVJLUmo5?=
 =?utf-8?B?bEMzU04xdGNXYWhlMWVuRys2eFJEdjEyZnNEaTR6RVh2YU5jdUVhclV5Tlkx?=
 =?utf-8?B?OTVGcDZ0SmxqcE5wZEhONkRwclBzV05xa1cxVFBHREFyblEvWnlDQmgza1JZ?=
 =?utf-8?B?bmN2d09aZUUyYlpaYTlVM1RyVXdza3pHT1Z6bmZZVFBsQ1U2RTFUSDlLL3Bx?=
 =?utf-8?B?QzU2SkVtakhydWRKR2lKbGlsRmQ3YWJCdGZTUHhTOWZWZ3h3SjAzaDR2TlNy?=
 =?utf-8?B?SFNRVUhaQVdLQ2k2VmxiTFg5UzZ5NGV1YW8zK2dReXp2OUV6VmdQM2tJa3Zz?=
 =?utf-8?B?cE5VNGpHVXEwSmVRVm9XbUZoWWVVWFZOd3JxMTdJdW14Uy9YQWpGNWR2Wm1Q?=
 =?utf-8?B?YnEyaXhYZG9CczhYdDFlVnRlL3JRZEM0VWtmZUtwbVFMMzFWS01aSnA5VmhS?=
 =?utf-8?B?SmNVZmRTV1lDVzl1dU5EZXUxeFBCNWRSWkdQOHd6Z0xINHNyY0dRZFpWd2tV?=
 =?utf-8?B?cnNvYUNwSW9RanFxOE5DT3ZWSFRrQUZkc1BBYzc0YytrcGF3TGhtdGl1T0J0?=
 =?utf-8?Q?MuhnhDNop9tBTYpLk+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817604a2-a5d3-4934-7eeb-08df2909d851
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:10:37.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BYkgnI4GhwMhfofk5GSc2n1lnP3jheSwlbGonSxXSgT5TdC/tnxEJeKU6HJeGb4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359

On 10/13/26 10:51, Matthew Auld wrote:
> On 09/10/2026 14:02, Matthew Auld wrote:
>> On 09/10/2026 12:38, Christian König wrote:
>>> On 10/9/26 12:29, Matthew Auld wrote:
>>>> On 09/10/2026 10:26, Christian König wrote:
>>>>> On 10/9/26 11:16, Matthew Auld wrote:
>>>>>> On 08/10/2026 12:17, Matthew Auld wrote:
>>>>>>> On 08/10/2026 10:55, Christian König wrote:
>>>>>>>> On 10/8/26 11:46, Matthew Auld wrote:
>>>>>>>>> On 07/10/2026 19:11, Thomas Hellström wrote:
>>>>>>>>>> On Wed, 2026-10-07 at 16:36 +0100, Matthew Auld wrote:
....
>>>>>>>>> Perhaps Intel Mesa side should use tt-only for this type buffer (?), but since this is a kernel regression I was hoping we could fix this on the kernel side.
>>>>>>>>>
>>>>>>>>> Some questions:
>>>>>>>>>
>>>>>>>>> 1. Do you know what is the general story with p2p between igpu and dgpu? Is this a legit thing? For igpus/APUs, advertising p2p can't be dropped? It clearly seems to work though.
>>>>>>>>>
>>>>>>>>> 2. If this is legit, do you guys then also prevent p2p with display buffers? Are you just doing that at the Mesa level, or is there some magic in the kernel also?
>>>>>>>>
>>>>>>>> If I understand that correctly that the igpu is the importer and the dgpu is the exporter then yeah Thomas is right that definately needs to be fixed on the importer side.
>>>>>>>
>>>>>>> Ideas on how do that? Could we do something like allow_peer2peer = false in amdgpu_gem_prime_import() if this is an APU device, or further check if the exporter side is not amdgpu, like APU + Xe?
>>>>>>
>>>>>> For example: https://gitlab.freedesktop.org/mwa/kernel/-/ commit/7ec86c68b42655b4bb85ee90af434a617e7bec8c
>>>>>>
>>>>>> Is that something you would accept?
>>>>>
>>>>> No, you misunderstood me. Enabling P2P is perfectly fine for APUs and mandatory for a couple of customer projects.
>>>>>
>>>>> The buffer should just be rejected from scanout in the display code and on the AMDGPU side we already do that if I'm not completely mistaken.
>>>>
>>>> Reporter confirmed seeing the issue in windowed mode also. So I don't think it's just a case of rejecting from scanout?
>>>
>>> Then I don't understand what the problem is.
>>>
>>> When the dGPU renders and the iGPU displays you have only two possibilities, either the dGPU pushes the frames over the bus or the iGPU pulls the frames over the bus. Both should be equaly slow or fast, so what exactly is the expectation here?
>>
>> I assume the AMD APU/iGPU is sampling/reading from the p2p window buffer every frame.

That is not possible. The HW can't do this and because of this we should have a check for that in the DAL/DC code.

It could be that this check doesn't work and because of low resolution and/or not busy PCIe it somehow works, but that would then clearly not be intended behavior.

What could also be is that the frame is pulled over the PCIe bus using the SDMA multiple times, but that would then be a bug in userspace somewhere.

>> Expectation is that buffer rather gets moved from VRAM to system memory when mapping the buffer with dma-buf, where it stays, and never negotiated to use p2p in the first place. I don't think p2p is really valid here.

No, that is incorrect. When P2P is available it should be used, it's just that AMDs APUs can't scanout over P2P.

>> What happened is that user updated their kernel and due to the MOVE_NOTIFY config getting removed and enabled by default on newer kernels this suddenly started negotiating p2p for things like the window buffer AFAICT, instead of moving it to system memory and keeping it there. On previous kernel versions the buffer would just get moved and pinned in system memory. From user pov this is a kernel regression, given the perf they are now getting.
>>
>> On AMD CPUs you allow p2p for everything. On Intel iGPUs we currently ban p2p. Maybe there is bigger question here for what is the story for p2p and iGPU? Should it really be blanket allowed like this? Should it not be opt-in with some userspace hints or something?

Again no, P2P is mandatory for APUs. We have basically tons of customers using that with AMD dGPU and AMD iGPU and that works fine.

>>
>> The other important part is that even when you move to system memory, it's no longer pinned (MOVE_NOTIFY) so can you now can also get violent ping-ponging, which is addressed in the first patch in this series.

Yeah that is something which we have seen before as well. That should definately be prevented by the kernel.

Does that patch help with the performance?

>>
>>>
>>> The only thing you need to avoid is that the iGPU starts to scan out over the PCIe bus directly, cause then the frame is pulled over the bus multiple times (if that actually works correctly).
>>>
>>> Do you have a link to the original bug report? I was only added later to the discussion so I don't have that.
>>
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
> 
> Christian, did you get a chance to look at this? Any further thoughts?

Sorry for the delay, I'm quite busy at the moment with AMD internal things and preparing a presentation for FOSDEM.

Regards,
Christian.

> 
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>>
>>>>> Userspace has fallback path that when a DRM atomic requests fails for an imported buffer it falls back to copying the buffer first.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> At least for AMD APUs we clearly support P2P both as exporter and importer, but what isn't supported is to scan out over P2P. We explicitely reject that inside DC/DAL.
>>>>>>>>
>>>>>>>> And I'm pretty sure that you should do that as well. I'm actually really suprised that this works technically and doesn't cause corruption or anything.
>>>>>>>
>>>>>>> AFAICT on Intel iGPUs it will currently always end up with peer2peer = false on attach. Not 100% sure if direct scanout was happening on the p2p buffer itself, for the user report.
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Thomas
>>>>>>>>>>
>>>>>>>>>>> Assisted-by: LLM
>>>>>>>>>>> Closes:
>>>>>>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9415
>>>>>>>>>>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>>>>>>>>>>> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
>>>>>>>>>>> GPUs")
>>>>>>>>>>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>>>> Cc: <stable@vger.kernel.org> # v6.12
>>>>>>>>>>> ---
>>>>>>>>>>>      drivers/gpu/drm/xe/xe_bo.c      |  3 +-
>>>>>>>>>>>      drivers/gpu/drm/xe/xe_bo.h      |  1 +
>>>>>>>>>>>      drivers/gpu/drm/xe/xe_dma_buf.c | 63 ++++++++++++++++++++ ++++ +------
>>>>>>>>>>> -- 
>>>>>>>>>>>      3 files changed, 51 insertions(+), 16 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/ xe_bo.c
>>>>>>>>>>> index 5065a7bac39c..e63437a261cb 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.c
>>>>>>>>>>> @@ -3658,7 +3658,7 @@ int xe_gem_create_ioctl(struct drm_device *dev,
>>>>>>>>>>> void *data,
>>>>>>>>>>>           * Display scanout is always non-coherent with the CPU
>>>>>>>>>>> cache.
>>>>>>>>>>>           */
>>>>>>>>>>>          if (args->flags & DRM_XE_GEM_CREATE_FLAG_SCANOUT)
>>>>>>>>>>> -        bo_flags |= XE_BO_FLAG_FORCE_WC;
>>>>>>>>>>> +        bo_flags |= XE_BO_FLAG_FORCE_WC |
>>>>>>>>>>> XE_BO_FLAG_SCANOUT;
>>>>>>>>>>>            if (args->flags & DRM_XE_GEM_CREATE_FLAG_NO_COMPRESSION) {
>>>>>>>>>>>              if (XE_IOCTL_DBG(xe, GRAPHICS_VER(xe) < 20))
>>>>>>>>>>> @@ -4228,6 +4228,7 @@ int xe_bo_dumb_create(struct drm_file
>>>>>>>>>>> *file_priv,
>>>>>>>>>>>                         DRM_XE_GEM_CPU_CACHING_WC,
>>>>>>>>>>> XE_BO_FLAG_VRAM_IF_DGFX(xe_device_get_root_tile(xe)) |
>>>>>>>>>>>                         XE_BO_FLAG_FORCE_WC |
>>>>>>>>>>> +                   XE_BO_FLAG_SCANOUT |
>>>>>>>>>>>                         XE_BO_FLAG_NEEDS_CPU_ACCESS, NULL);
>>>>>>>>>>>          if (IS_ERR(bo))
>>>>>>>>>>>              return PTR_ERR(bo);
>>>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/ xe_bo.h
>>>>>>>>>>> index 1ddf3b6d4a9e..6965c2655731 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_bo.h
>>>>>>>>>>> @@ -56,6 +56,7 @@
>>>>>>>>>>>      #define XE_BO_FLAG_FORCE_USER_VRAM    BIT(25)
>>>>>>>>>>>      #define XE_BO_FLAG_NO_COMPRESSION    BIT(26)
>>>>>>>>>>>      #define XE_BO_FLAG_NEEDS_1G        BIT(27)
>>>>>>>>>>> +#define XE_BO_FLAG_SCANOUT        BIT(28)
>>>>>>>>>>>        /* this one is trigger internally only */
>>>>>>>>>>>      #define XE_BO_FLAG_INTERNAL_TEST    BIT(30)
>>>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>> index b973579a69b8..0a347f09cee4 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>>>> @@ -36,10 +36,40 @@ static void xe_ddebug_flip_bool(const struct
>>>>>>>>>>> _ddebug *desc, bool *flag)
>>>>>>>>>>>      #define xe_dma_buf_p2p_debug_flip(flag) do { } while (0)
>>>>>>>>>>>      #endif
>>>>>>>>>>>      +static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>>>>>> *attach)
>>>>>>>>>>> +{
>>>>>>>>>>> +    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>>>> +    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>>>>>> +
>>>>>>>>>>> +    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>>>>>> +    .allow_peer2peer = true,
>>>>>>>>>>> +    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>>>>>> +};
>>>>>>>>>>> +
>>>>>>>>>>> +static struct pci_dev *xe_find_parent_pci_dev(struct device *dev)
>>>>>>>>>>> +{
>>>>>>>>>>> +    while (dev) {
>>>>>>>>>>> +        if (dev_is_pci(dev))
>>>>>>>>>>> +            return to_pci_dev(dev);
>>>>>>>>>>> +        dev = dev->parent;
>>>>>>>>>>> +    }
>>>>>>>>>>> +    return NULL;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static bool xe_dma_buf_attach_is_xe_device(struct dma_buf_attachment
>>>>>>>>>>> *attach)
>>>>>>>>>>> +{
>>>>>>>>>>> +    return attach->importer_ops == &xe_dma_buf_attach_ops;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>>      static int xe_dma_buf_attach(struct dma_buf *dmabuf,
>>>>>>>>>>>                       struct dma_buf_attachment *attach)
>>>>>>>>>>>      {
>>>>>>>>>>>          struct drm_gem_object *obj = attach->dmabuf->priv;
>>>>>>>>>>> +    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>>>>          bool verbose_p2p_dist = drm_debug_enabled(DRM_UT_DRIVER);
>>>>>>>>>>>            xe_dma_buf_p2p_debug_flip(&verbose_p2p_dist);
>>>>>>>>>>> @@ -48,7 +78,24 @@ static int xe_dma_buf_attach(struct dma_buf
>>>>>>>>>>> *dmabuf,
>>>>>>>>>>>              pci_p2pdma_distance(to_pci_dev(obj->dev->dev), attach-
>>>>>>>>>>>> dev, verbose_p2p_dist) < 0)
>>>>>>>>>>>              attach->peer2peer = false;
>>>>>>>>>>>      -    if (!attach->peer2peer &&
>>>>>>>>>>> !xe_bo_can_migrate(gem_to_xe_bo(obj), XE_PL_TT))
>>>>>>>>>>> +    if (attach->peer2peer && xe_bo_can_migrate(bo, XE_PL_TT)) {
>>>>>>>>>>> +        struct pci_dev *client =
>>>>>>>>>>> xe_find_parent_pci_dev(attach->dev);
>>>>>>>>>>> +
>>>>>>>>>>> +        /*
>>>>>>>>>>> +         * There are perf issues with using p2p with display
>>>>>>>>>>> buffers,
>>>>>>>>>>> +         * like with igpu (compositor) <-> dgpu (exported
>>>>>>>>>>> p2p window
>>>>>>>>>>> +         * buffer). Probably we need some actual userspace
>>>>>>>>>>> hints. We
>>>>>>>>>>> +         * shouldn't really assume anything. Also, note that
>>>>>>>>>>> some of
>>>>>>>>>>> +         * these buffers are not always tagged with SCANOUT.
>>>>>>>>>>> +         */
>>>>>>>>>>> +        if (bo->flags & XE_BO_FLAG_SCANOUT)
>>>>>>>>>>> +            attach->peer2peer = false;
>>>>>>>>>>> +        else if (client && pci_is_display(client) &&
>>>>>>>>>>> +             !xe_dma_buf_attach_is_xe_device(attach))
>>>>>>>>>>> +            attach->peer2peer = false;
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    if (!attach->peer2peer && !xe_bo_can_migrate(bo, XE_PL_TT))
>>>>>>>>>>>              return -EOPNOTSUPP;
>>>>>>>>>>>            xe_pm_runtime_get(to_xe_device(obj->dev));
>>>>>>>>>>> @@ -349,20 +396,6 @@ xe_dma_buf_create_obj(struct drm_device *dev,
>>>>>>>>>>> struct dma_buf *dma_buf)
>>>>>>>>>>>          return ret ? ERR_PTR(ret) : &bo->ttm.base;
>>>>>>>>>>>      }
>>>>>>>>>>>      -static void xe_dma_buf_move_notify(struct dma_buf_attachment
>>>>>>>>>>> *attach)
>>>>>>>>>>> -{
>>>>>>>>>>> -    struct drm_gem_object *obj = attach->importer_priv;
>>>>>>>>>>> -    struct xe_bo *bo = gem_to_xe_bo(obj);
>>>>>>>>>>> -    struct drm_exec *exec = XE_VALIDATION_UNSUPPORTED;
>>>>>>>>>>> -
>>>>>>>>>>> -    XE_WARN_ON(xe_bo_evict(bo, exec));
>>>>>>>>>>> -}
>>>>>>>>>>> -
>>>>>>>>>>> -static const struct dma_buf_attach_ops xe_dma_buf_attach_ops = {
>>>>>>>>>>> -    .allow_peer2peer = true,
>>>>>>>>>>> -    .invalidate_mappings = xe_dma_buf_move_notify
>>>>>>>>>>> -};
>>>>>>>>>>> -
>>>>>>>>>>>      #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
>>>>>>>>>>>        struct dma_buf_test_params {
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

