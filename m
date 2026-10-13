Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82ED4F0538
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891923; cv=fail; b=YuQKnAHys6XJBGMc6zsWSJEM3rsHrJel5QfkqTRPLq3l4l5B7QszDzxyA/D8VLYU9X1UG4hQURff+VfgBnbET54W5cZFKx8zsBH9IjdBIotClttfz+MGgbpWC0bvJwnW/EEky2apEq+VBojMz/4cUEO1t+FfPYPlOyW9Plrfpq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891923; c=relaxed/simple;
	bh=usR5Q+Djfi5k/TnaB0IpIf+gZRpM6jk2IJpBmImC1Eg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fHP1eCtxBVM1Eg2fvfphTHkHTE1QT0syUjrAPoMuuk7Jvc/j1x1dZu/Vc6TqlIvCSBUaSj7b/RXdjRbvXld2gESZwF6Ij56Q6yV4p7p1ymPOtEDwnt8/EjQpLq9jjyXa77+lDnsitvoKbEbqofRGPxXwkBXxm+fUex3knb1A4pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oe85KUm0; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oe85KUm0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyGbo98dyzLGZGqnbipArAQGR4FRXLxcCozygJ1bUpnEdLNbt9XJh7O5ab85PRvL+cWXWx5bydeW0fYrr5xJDqbEdApICN/8KrLMkAOWkoxavRNQD32zoPey8IM0UGFajEMcw8grZuua0GUoHfz54o5SwlfL2dKB5Kl+8m/KelAMcGXe7MXXtzSgydS2q7KBvUdABlV9pcm4LBVGy/XgRyJj1YjKtGGrZm9TfCZnzGeqVCL7b2GCZrd3XmZs2q1uaFXR5XFUmfo/0thaoctazSeCcsLiyEW82VGLrdzrO3LU9E9IhdJjCUCTcknVt/mIq7HIPwlE9o3FfHrrgQfm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JQET2+cOASH+P5NU9kUPohUSLnUVpSNSdTf2flskqo=;
 b=IZ6As4dFAEnY0Dvfdf8LN2CxWRcEG6prKUgKsgLhEfzz5mLNb9Gwqi2hLng7sO1mA9KzYe0dg68/EVkNaNtHAxrZHSi6Q0MGMNdu+VrsY+3Q7qlfdRRskx/WBl1L5AEbZU1ez65flM1+hFH3OZrphnWWuca8JaGEwimxHdiRztLOzc89wviWQl2f31n9jXVjAqhDU5KcSAg8OMdEszFSnzz310v17wDMwJxTDRte2LizUR+9Qadx/gmWaou6G+ay9qtuvG6Q8TeBz5MELEVmU0gADJFby8tS2edjSAYMGNNKOoiYiDYHSkoBnstrpH0dxqyFd9hw9PtTdLabX4AJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JQET2+cOASH+P5NU9kUPohUSLnUVpSNSdTf2flskqo=;
 b=Oe85KUm0d5WjqFUkfHCLyfujJolIwfZGYTFMncBMqfufIGHZiKTLMCpjFQXpLTtPGvJ6rpvbZ8pf7IW4kZlvMPRcyIU+iBdWg13T6FECYIucD6hDWXJZYzczShvAFpC/3yPAmiCDuY7Zk7y+NjpTIuWo0OuVqSvJ0Mfzf/jpkxI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by FT1PR12MB748946.namprd12.prod.outlook.com (2603:10b6:170:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:45:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 11:45:17 +0000
Message-ID: <9a77cde3-641f-45b0-8c30-69184c0f1a4d@amd.com>
Date: Tue, 13 Oct 2026 13:45:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/xe: skip p2p for suspected display buffers
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
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
 <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
 <8d0eb215394e7a285813fe87def6bee358063431.camel@linux.intel.com>
 <f570087d-9d67-4199-b5db-959741379835@amd.com>
 <9ba9558a85e3df1bf50db7a2265ecb99d746cf9c.camel@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9ba9558a85e3df1bf50db7a2265ecb99d746cf9c.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|FT1PR12MB748946:EE_
X-MS-Office365-Filtering-Correlation-Id: 3219b5a2-2160-4889-8359-08df291f73cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|5023799004|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rGkHCMP9hl1vylqvLY5CTtR223EfXPXWaFPB4bpf0cTJOMTHZcv/1Lc5dyq71FpwFwCwyUOHNXulr38q8diM1KMFckl8cQxQXsu2R4iIGQsqRhRsqjxqpmyEBbjYDjIcfM9DYLxz3yT46RXd6HkSsB8nKnQnKqCkJWDuDgvOLIY7Bxg0XeoYReqjbOnjUvOM5RIYm/+yxFOXu0ptMtEjuw+aRBx46rwqPSUNS9OkHk5a7Qd261/ndPgiwDsmVwbGZsf+IGYfrmmGQVqaaJe91wJ/deolTbOGv4NN15m0ks7HxL1UQXZK5YN6bjAYUxmesiHpp2+INjAvywzNiG5x39R+tMhC47cIsRdG1gAYW48I0/I1YFweqPiREKVPKpBoG2Ucu7HFX9sZM6LjPRdHPB1kroC1stgazif/OhnjMGlvkzwYXowpOM2V6xUf+x3AYX65ErL4vD9XohztFUAhDfnj0eF2m1zP/Td1JHe3+7NhrhASKruO38ea+/4Wgrn5GqcVB7G2rcSTlq7Niw7iXVVbvMv3RoapvJZbEpYqKXt0GAS25uEdDa2V46x9GIgZrWO/GaiJA4mUWiES8q6yO4DmRA0SZj6+ZXkjhs2FsinoohRGHR2XZL/WbW6nBSgJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(5023799004)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STNhMmJHbk94Z2FGSTdqYzUrS1A4Mmc2SWxmVFJqTlhwczFpZkxZT2JWQi9G?=
 =?utf-8?B?Nm9mSjdhditDQlQ5RTJlTVBBMkloVDllaUJzMVhXNllOcWMzaHpva2hOVlFJ?=
 =?utf-8?B?YTVXYlRqT1pObm1Rd1I5UHFEZzcvdGhPdk5Wbk9rcWJOUkg1NDU0amQySDJR?=
 =?utf-8?B?andtTzRXWU5RdUtpcTA3VzVjMjc0ajUrM1lxVlYzSEtIMzNiQVRaMDRZMlFG?=
 =?utf-8?B?cVczUGJiemFoam4yMGRhUzVSbHdYOFAva2RQWE5hcU4wU3RYWW1ta2VzQmVY?=
 =?utf-8?B?Wlp4TzFwYmFuSE0vTjZmeHRlMHNSeUtjVnRBUkZVeUp6MExoZXIvN0s3U0F4?=
 =?utf-8?B?SVhXdUdKaXU0RzVYRWF1eWxxeFYyNW85QzBhbFI3MnpXcDhUN0NFK3YvcFdE?=
 =?utf-8?B?OG5rRUdRQW9PN1ErYkpEcWhLZDlrSUZLMHlWczJBYnhMS1ZhVEN2a2puS0FY?=
 =?utf-8?B?VStjbDhCamFnMjVCSU94c3VKRERQWmxScllSdGJyanRIYUJCakhqWHpaYXdu?=
 =?utf-8?B?Y1NjVkZhYzMwMENkbVdmT0pqenVDREhuNU4zKzJ5c1hXc1ZaWTJJd2RRSW44?=
 =?utf-8?B?UEdDUE5tVytWR0VIWHhuOGJ3VWVHeWJQdDFWaU5XM3RiVEhPZXg3TG9CYmZH?=
 =?utf-8?B?OFBDRXdGY1ZqL3hsV0FKcTJsejhUQzBRdW9Fc04yUHpxSE9Xd2pEdnNVWGRW?=
 =?utf-8?B?QUJuektOZGZpYW56Y0lpMUZGR25jM1VYMVl3ZHZuZitnVzYzRjZsWGQ4RjQw?=
 =?utf-8?B?cHZaVVJxcTBxTG13UjJwelltbHhIbjhMUW40RGRXS3FBMWdFSUNLZTVFemk4?=
 =?utf-8?B?OWJiYzRjekwwcTJJbmpETEFxOW4yMFdMU3hyT3lwVkE4MCtVNExYNi9YOC9l?=
 =?utf-8?B?R1ZvdUZYUjVtdU5OMzRLMzdsQW04Y3J6b0tXVFNGSDNHSzExRHZwenZXNXQ3?=
 =?utf-8?B?NFZmL3Z0alg1NHBGWlplZXNvcmp3bStQczVPc2FEajhYZFpsZjdzVTNSRm5l?=
 =?utf-8?B?UnArU3FaYUJ3eG96Z25iRDQ3N2NOZTFNRngxWVRpZXpiVkxhWFlqVUlmOGp0?=
 =?utf-8?B?WXdSTEMxM1crN05pc05ZRENNTXEzbFo0Ujd5Z0FJWUJGYXY2OCsxU2JnZExI?=
 =?utf-8?B?Z2ZJeVhwRmxMS0EzN2ovUy9SRTFqL2QwdHlHcjl0TC93Vk5DeE9jY0NJejM5?=
 =?utf-8?B?QWdFeTZzVEx2K3dDT3BXY25tRlUzOG9jYitsL1hiTU0waW1tNWhXZDV5SjZ2?=
 =?utf-8?B?UHZaZmpyNVA4S0VyUTVwamUrTGladnY1Q1NZRGZiYjlNL2VUL0NpRlZteDc1?=
 =?utf-8?B?Tko5MUVqaXpFb3VSQjlhTTMrS1NWM21vSENVSGFwdkp2ZExvOS94Y2djQ1li?=
 =?utf-8?B?MnhhVmc5djdiWlVLV0NBeXQyR3dxSUdXQ21KMUttYmtGN0J1SDBQekpCUWhx?=
 =?utf-8?B?NmEydytBMDYxYkRZQXBpZU1UeCtqWDI0a0oxRmpsYmhoalZhOW1qbjAxRE1y?=
 =?utf-8?B?MTNYMmFuMEZiTVZsR2pyMHF1QXQ1cmRkc0Z1aTRzVkFxQW8xdlVUT1A2anlo?=
 =?utf-8?B?d0Ntc29HdXZlZjVpTUFCK2wwWDZGQ0NOQ1VQTEtxdk96RU1SNEY2RkdFVmNn?=
 =?utf-8?B?NVg1V2xXc0VXdy8vcEU5L0ZzYmhTVlZzMmhKT3hwajJCNmlCY0xNRWpOVFZl?=
 =?utf-8?B?MWtOUHh2YWh1NUpET0VzaFY2K0VkV244cEliNFNsSVhKWGRta2FMemhqVnh6?=
 =?utf-8?B?THdDNm9SMGJLYzRJS291aXQycUFCOVJqRys5Rk81aTJGUzlOaUdkd2xPNllI?=
 =?utf-8?B?VStVKzRRN1ZibnlFcHM5ajlRdmJlY25vQ3hjZXdQSFNlVUlOSytYVS8yMmh4?=
 =?utf-8?B?Y2N3aWlYZzFHTERIdHEydlMyVVdmWCtRRE0vdU1pT0pLNFpvT2pMMUpzQk1U?=
 =?utf-8?B?Y0MzbWZsUHlFR2ZBWkU3OE1tR0hVU2ROcHhSN2dzOWt6SWxoQ3NXQWw5UVFV?=
 =?utf-8?B?VkVUM0dVdW9zWU01NHZSRHlHdFNKeFFGUXVjR0RYazhzOEhtak9jYS9pUWtD?=
 =?utf-8?B?UnF2UE1nb3BLR256dE4zSzdsL0xBdUdWS3NpVTZPYytjak9tenRWQU8vYXRC?=
 =?utf-8?B?S3NuUGtQaWRKemR1cDJHS0pLU1dLWnh1UFZETm5wZjlSSFhHQVBxTjU5U0Vr?=
 =?utf-8?B?UFlTS21VcTExYnNNSzBLZ0JkNWdDTklUUUVGUlpGNHR2dk9QVGFXenpFeFRl?=
 =?utf-8?B?bXpQWjBqcTMxNUw4dmR5T040SWNFeFJVTEVQZXZmanNoaE1zRVBFZTh5b1dU?=
 =?utf-8?Q?X/tUUkvhIm9Na12Q2R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3219b5a2-2160-4889-8359-08df291f73cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:45:17.6106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4uGkVBJR7RcZPbwuO6T9zVnpwi1oF9JZWwgEiOEBkYYo8oExSJl4WhSIkK6HXF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB748946

On 10/13/26 12:16, Thomas Hellström wrote:
> On Tue, 2026-10-13 at 11:55 +0200, Christian König wrote:
>> On 10/13/26 11:18, Thomas Hellström wrote:
>> ...
>>>>>>>>>>> Ideas on how do that? Could we do something like
>>>>>>>>>>> allow_peer2peer = false in
>>>>>>>>>>> amdgpu_gem_prime_import() if
>>>>>>>>>>> this is an APU device, or further check if the
>>>>>>>>>>> exporter
>>>>>>>>>>> side is not amdgpu, like APU + Xe?
>>>>>>>>>>
>>>>>>>>>> For example:
>>>>>>>>>> https://gitlab.freedesktop.org/mwa/kernel/-/ commit/7
>>>>>>>>>> ec86
>>>>>>>>>> c68b42655b4bb85ee90af434a617e7bec8c
>>>>>>>>>>
>>>>>>>>>> Is that something you would accept?
>>>>>>>>>
>>>>>>>>> No, you misunderstood me. Enabling P2P is perfectly
>>>>>>>>> fine
>>>>>>>>> for APUs and mandatory for a couple of customer
>>>>>>>>> projects.
>>>>>>>>>
>>>>>>>>> The buffer should just be rejected from scanout in the
>>>>>>>>> display code and on the AMDGPU side we already do that
>>>>>>>>> if
>>>>>>>>> I'm not completely mistaken.
>>>>>>>>
>>>>>>>> Reporter confirmed seeing the issue in windowed mode
>>>>>>>> also. So
>>>>>>>> I don't think it's just a case of rejecting from scanout?
>>>>>>>
>>>>>>> Then I don't understand what the problem is.
>>>>>>>
>>>>>>> When the dGPU renders and the iGPU displays you have only
>>>>>>> two
>>>>>>> possibilities, either the dGPU pushes the frames over the
>>>>>>> bus
>>>>>>> or the iGPU pulls the frames over the bus. Both should be
>>>>>>> equaly slow or fast, so what exactly is the expectation
>>>>>>> here?
>>>>>>
>>>>>> I assume the AMD APU/iGPU is sampling/reading from the p2p
>>>>>> window
>>>>>> buffer every frame.
>>>>
>>>> That is not possible. The HW can't do this and because of this we
>>>> should have a check for that in the DAL/DC code.
>>>>
>>> Couldn't the issue be that the compositor, running on the amd iGPU
>>> blits from the dma-buf rather than scans out from it? And the
>>> scanout
>>> is not the shared buffer at all?
>>
>> Yeah that is possible, but that should only happen when there is some
>> change.
>>
>> When the iGPU reads the buffer only once then that isn't really
>> problematic, it's actually exactly what should happen.
>>
>> It only becomes problematic when the buffer is read multiple times to
>> construct multiple frames, either because the compositor does
>> something unexpected or we really start to scanout from the buffer.
> 
> But in windowed mode (and perhaps even fullscreen?) the compositor
> blits repeatedly over PCI each frame from the dma-buf? 

It usually doesn't.

In fullscreen mode using the buffer directly for scanout in an atomic commit should be rejected by the kernel because the HW can't do this.

The fallback path then copies the buffer content to a locally allocated buffer exactly once and then display that new buffer.

I'm not 100% sure what happens in windowed mode for the specific compositor the end user is using. What could be is that when the compositor gets buffers from multiple applications that it composes multiple times over PCIe, but it is unlikely that this will cause problems. You would need something like game/test running on dGPU and glxgears without vblank sync on the iGPU.

AMD uses basically exactly that setup in the Tesla infotainment system for example and it works perfectly fine there.

I have not the slightest idea what's going wrong here. 

Regards,
Christian.



> 
> /Thomas
> 
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> /Thomas
>>>
>>>

