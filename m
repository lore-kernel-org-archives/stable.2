Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A913A545E
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885315; cv=fail; b=HuWfaEiWOer8kfXgFjHQHKAX3TF6pG7r8kBGNp6ANhr3hG5lvaV2S0Sjtgq9/siy6OiemGWkIIsXGYUSRhuKgC1+l4S5wKV3g2IDLzolr87QlCYk+XWU0zoJMuSSdG7l7riqjxrIPY/p6UNsy9xYdqA7EHkCl5xev1tsyQzJQmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885315; c=relaxed/simple;
	bh=jjOxyc9/97LZ9n5Stni05C6AsmpiFJHVKmphU1+H6PU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5Po+GYn6kxoTu7rJjb6g7hTfEPf81l6tN4+TzCPqDMaJePRktPvoGhYo7U4UrKJr+XZDJ+PEEleVO5wEKMk367V00+PySuDpUIdLxCpBvmkUOYs9PGSVZB+Xc+iUC41Kl8Z7YdjAEmkDrIc1lx30X/wLLm60a4n5y2LLjaSiyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sZVndgsB; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sZVndgsB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHsJOC0sfFNnPo2WOBqvZsjGeSYgkjUeJ4x8XFkxpWW8Xfq6ssv9vBRVYSBxn2FWThAe11uvKHY0XjJPPilQsDICM4W5516cMZubucMMD1sl7tQyBIU3Orp7F9x31imHsnSNZxXrj6BGtuzf+ImQnirA3QlN9saM2uO+eEQSS6WW7GOE3anuCo9jpmC2uBuuUW5AgcVlLGI7phh7/aZGvI76D9gSOoeRTyo0c5CV/1M5ao5QcTomOM/hvrlRD5NqQ9u/vK68vDhBOCZ0lsKo9pL8vO5FH9Mj16HPYxIwJyEbhsPQa+R/34WUQZs6vd/HwNqEREb7Y1in7sRvJFLx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcTSanuXEyN0qcrF+qf2jrGHIj26XDA5/KVanZRM1Ps=;
 b=mzQNmfzQsaAkxb3c+k7+osFf7eLmrN8YjJ/JnN/DHL6al4wEiftzxGGVcFHP30fmSmH3Z3WFofmHpwv+flOrG1V583W+ipofXincf5cGqloSab/N3YMoloqtjnqnb7BU4J2xLeSzybVi+JWxRB73g+VzvJZNVQ+5grVtU/IJ50sHZ95sCG9mxdEuCSXQy+IvH+qCNXoo+xZGhUWlPvboIZ5X4VciL0J+YNVhUxCyfv2wJl9tvdb/j76kizSgTxJVdJmoX5uTo1zwYPswjtdb0wfFBc6wjfJ41Exind8EGOlSbXtoOqXxax6Kf5z69qK3/iTGUU0aPvyw7HYN6xSbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcTSanuXEyN0qcrF+qf2jrGHIj26XDA5/KVanZRM1Ps=;
 b=sZVndgsB12AvZnGDS5j95QAXoA5kX0IVNNdEl3OOr2gi6FIIt8+zKThDuSPgPfv/xit9MTMz7QDy9pMV4bl7YQOqWeyYatYEOTj+BJ/Vy+8AUfKXqP7ZB3ji1i0vaFv0svcZ+xbZxZl2sdvtln81rO940hbv4x7I3yqTs48n/OM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:55:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:55:11 +0000
Message-ID: <f570087d-9d67-4199-b5db-959741379835@amd.com>
Date: Tue, 13 Oct 2026 11:55:07 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <8d0eb215394e7a285813fe87def6bee358063431.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: e04c6fbb-baec-436c-d84c-08df2910122d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|18002099003|22082099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qZtwmOIT2lOedz6Sm+rRvSALXu3KHtqZ04T0p40IinA8zpaQvk/PgJ4kR37XLWhItGYjbOc6hqAcDI97QX3d2L/KJs0mnckiXUWTLwohyq9E83mlSGgwgohnRBPQ6GGxEc0RiBU3eIXskuFg4WbjijaMUhuaodipuaIxSmPcOmiO0b64qOUKnK9x1SlCp0/GCR4zL9VihLQqDuEi5KxvUjgXXqRAT6ZRyR3I3bw3kGFj/bNhmkodTO/vHmVMeAXO0acWSDIqBp4uLp8PFTGGAe6T29aw6ST5YO+79pvfW8AtN8vB1PhJnfv93+U57EYdjqSWN/b8XiRjxGs1uMTrcuwYP2u4AYNxutsE4TrMjbU6zcbG5XfVDSmSgeFNKl9PMzt7T5xVX0A2HnAYbdHErjqEdX1/Z3i5+MIbwFFupKIM0N5FHM+BCNXH4VTyluo1fmW/6Ms7YrxkV4Sjnbz0JY/HLv+iEWZ21CZ7291PKsPY/tL7np7IU075gEkwTAplSpHpJffXiYjVL2Q5+BO/jlgIhaehjqZhQ0QFsiDl/RrHtalxwZ7Fez0lsdl5EDKM7dVGYKm75Xsvhyp4AUvYL9Qg64VHHKNy6gZWwuT2TT5z6jO4zjJqvIHUVbfmC2Rj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlUzVGdHR1ZNWnJlOTdHbUJkVFU4UDFsRGQzTGhpaVp3eFVvZWNhK0FITFZF?=
 =?utf-8?B?T0RWS2F1anFJSW82SytBekhnODVNU1VMWUw3WkVNcE1HVlo4dEtkdFJ2bW5C?=
 =?utf-8?B?R24vcHg3MjNDa2wxbS9PaCtGSFlmMVhsU0hXSW44WXpZTUo5UUVQaUh6QURY?=
 =?utf-8?B?WFhpUzlwYW1VZGh2N2M0Z2Y0LzBWbytyU0lQdytpd1NKeGJqcnovWDRYUzJD?=
 =?utf-8?B?V2cyQ0NQdW54dDVEZ3d6N1lXRXd2cWhOc0ZMTWwwTmtXY2o0cE9vQk56WjVw?=
 =?utf-8?B?SzlyK1lxWkZBekp6OFRwNXBRMmFLQjBnMXo4ZE5JTzkyVmkxOEtOcTNSMnNu?=
 =?utf-8?B?Y3NLOXNhZDdHK041cmdFdXpLRXR3VFhpb3BsdHE2VGQ3OGM1cWRGdXprL2xv?=
 =?utf-8?B?eWd3UFRTczRNWkQwSmxLN0hWdGxTT3JRNEJMNGlsNHdaNHg2TW12dWJYMnFY?=
 =?utf-8?B?NEtidEhZemVDTXBNYUt6UGVYdlUzZVl2akNMV0hXeWVqV1M3NWlHd0R3aVNT?=
 =?utf-8?B?akg1V1J3Wk1pRnFjcVFGOWVjeVB5ZXlJdTBhZytpS0J2RzJrYnRMLzJycEJS?=
 =?utf-8?B?U2ptbEJ5MkRCdDNCMXBXMGtGUDJnbmlMVGFnZ2o1NlRicVBtZDBaa01PMkph?=
 =?utf-8?B?U1l3VUEwem1Qby8yZkNFNlBmRXgxeUh5cTRRN3NxYjlOT0s2TEpid1NUWlUw?=
 =?utf-8?B?aU9jUnZ6dGhnZnpPQUhqenUvRVREMkRibTRsMHZOK0JjdVo4SEZFQUNsdzZE?=
 =?utf-8?B?bUJ3aWdnQmNyWmx2b1BEMVJxb1YwWUM0MkNRZ0w3cld4S1VBTmNENEpuQ29m?=
 =?utf-8?B?ZG02eG4xNUZvTndZSFg0eHR6a2N2QXpiaHJ0blllL3VLK2xLTjRrRXU2M081?=
 =?utf-8?B?NXdRbURUdC80Z3BTUVJKcDR1ZU9VZTdEU3B6ZkZGcVQycDN0L0JMMEp3clFD?=
 =?utf-8?B?Q1dWU1gzbUFaeG9XZzM4WmdWcVI3aWpTSnZZaUtmaS9hNGliSDM4OUZtL1Fv?=
 =?utf-8?B?Rm9nTlFLMi82ZGM3L3ZaanVNVE41VmJDQ0k5UTdqSkxKVVFSdFdnNzU3enZ0?=
 =?utf-8?B?VzRGTWllRmlrREJwTXYrT2RIamNvRy9oZXRGNUdKR1pvaURFbkxqTkVKd1FV?=
 =?utf-8?B?Sk4ybE9mYWlaaFVDcTF6N0wxWFQvVmFWbnZLR3VyTE0xN2NCdzhKQmxHYVl1?=
 =?utf-8?B?eDZJaW1KVEVuNzdzYlNndEtGSUxuQnlMUnFsdTk2c1JseDRjVmZuc3BmTTQ0?=
 =?utf-8?B?NCtDVHhZcnd1L3YwTFVIT0RUNVVVeVNaMW9DQitybFgxNm9zTmZMbUVmOHN5?=
 =?utf-8?B?SHh6THhtMGdFSW1jMXB1elZ5cFg1Z1ZFeFdXY1NtMExjcGhhektPenFZUDhU?=
 =?utf-8?B?NktRRmgvMFlRSXY5bWZZNk9jUlFzanpLS2g4ZnowT3ZDd1lvbk9UbnhaV1BW?=
 =?utf-8?B?Sm13VE5YUVl4MzYraEtNaHVtNTJkbGJwNFdna0JsZWVWeDVEZm8wWWRLNTFt?=
 =?utf-8?B?NzRRV3F0aUNEdm5NcEJZZzE0TkM0Sno5S01vWFppTHVydmMrRll6OUdZRWFq?=
 =?utf-8?B?ZU5FU2R1OHJGYllDNGxUSFhMNWZjam8yK1MrR0Q5bkZVRGRLYitORnZtU3Vq?=
 =?utf-8?B?a0M1dExjYlEweXpRaEFsV25FbDZxMGt2bkdaQnZ0MzBhN0FOcXZ3OWd4RXlL?=
 =?utf-8?B?cDlaY29kc0hkY2ZZRXVKemE4V1oxWCszV2dvNmE3cEp5bzVCZGp6ZGErbjFB?=
 =?utf-8?B?Qk9MN1F4N0hqMHFnR0pralUxU0NGa1BzZWhIV3d4RlJJUmtBN2VGYVRaRkFz?=
 =?utf-8?B?WUxhdGpjWEJOaExKT1hSdTN2VnJVUzczYVFMQnlUM3ZqOE1Jd29MV2NNZlI1?=
 =?utf-8?B?RFE0WEQ2SzR1Z3g2ekJFT05rUXJadCtGZk9pVk1pY1Y2WEp5TU5uQXVZZStV?=
 =?utf-8?B?eHkwSGExak5yZGkxYjQ2OUF1N1RTb25VbFRUbjhkL1JIOEZqYWJTRTVsaVd5?=
 =?utf-8?B?TlNkL1FxQ2czcHBQVXdPR294bEd5Ryt4dmlMSklWZW1DcWRFcVhBaExhV0pT?=
 =?utf-8?B?ckdMeVZ4QUlHYzV6TDhsOCs5Yi91eFVDd0xJTDQ3OTRaOE5FZmNaT2NmcmE5?=
 =?utf-8?B?ekhmR2hjcEU2alBBQ1FTckFYZWFxb0l6VjZrK1F1U0hRa1VCSkNMN2d5NGJ6?=
 =?utf-8?B?Zk9sdFZ5VXNac29qMmdPTTlBSEF5YTFvbW5OUzBpWWVFUURhajZkY3J1NDhs?=
 =?utf-8?B?TGE0NTRNSy9PYTdqdms3WmJkQnJnajFGSXdFVXdrNkJKcElMTTZCd0tTNFdC?=
 =?utf-8?Q?Os43xKSOCz68qrQvup?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c6fbb-baec-436c-d84c-08df2910122d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:55:11.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfRYDUPHYCiFTxjgGFS8az2Rt4oh+mDcvogyzzdpEEBb112oZjpTsKAjipHlBF4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

On 10/13/26 11:18, Thomas Hellström wrote:
...
>>>>>>>>> Ideas on how do that? Could we do something like
>>>>>>>>> allow_peer2peer = false in amdgpu_gem_prime_import() if
>>>>>>>>> this is an APU device, or further check if the exporter
>>>>>>>>> side is not amdgpu, like APU + Xe?
>>>>>>>>
>>>>>>>> For example:
>>>>>>>> https://gitlab.freedesktop.org/mwa/kernel/-/ commit/7ec86
>>>>>>>> c68b42655b4bb85ee90af434a617e7bec8c
>>>>>>>>
>>>>>>>> Is that something you would accept?
>>>>>>>
>>>>>>> No, you misunderstood me. Enabling P2P is perfectly fine
>>>>>>> for APUs and mandatory for a couple of customer projects.
>>>>>>>
>>>>>>> The buffer should just be rejected from scanout in the
>>>>>>> display code and on the AMDGPU side we already do that if
>>>>>>> I'm not completely mistaken.
>>>>>>
>>>>>> Reporter confirmed seeing the issue in windowed mode also. So
>>>>>> I don't think it's just a case of rejecting from scanout?
>>>>>
>>>>> Then I don't understand what the problem is.
>>>>>
>>>>> When the dGPU renders and the iGPU displays you have only two
>>>>> possibilities, either the dGPU pushes the frames over the bus
>>>>> or the iGPU pulls the frames over the bus. Both should be
>>>>> equaly slow or fast, so what exactly is the expectation here?
>>>>
>>>> I assume the AMD APU/iGPU is sampling/reading from the p2p window
>>>> buffer every frame.
>>
>> That is not possible. The HW can't do this and because of this we
>> should have a check for that in the DAL/DC code.
>>
> Couldn't the issue be that the compositor, running on the amd iGPU
> blits from the dma-buf rather than scans out from it? And the scanout
> is not the shared buffer at all?

Yeah that is possible, but that should only happen when there is some change.

When the iGPU reads the buffer only once then that isn't really problematic, it's actually exactly what should happen.

It only becomes problematic when the buffer is read multiple times to construct multiple frames, either because the compositor does something unexpected or we really start to scanout from the buffer.

Regards,
Christian.

> 
> /Thomas
> 
> 

