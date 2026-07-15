Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012069.outbound.protection.outlook.com [52.101.43.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD929225413;
	Wed, 15 Jul 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097527; cv=fail; b=pE4pVqB9x/LaLrroTleopM0eSzEQZfENLKto+m3tVbZFx4+DebZPIpFe5dNlKGKOSWIdqrK+RXyLypGgu67rfqX6xxnhLBOu+rvhdaTPkyIKQyy2FkL5AP6Urxd8GlqE6MDDw8PQa01VDIKY+q0Ii/biJa7Y/2U5PTG+tPOImDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097527; c=relaxed/simple;
	bh=Jb+dbzwD0E9G9Iz+FzO/SxLs4qQDCX3wqJvDS9uIta4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ci3/VB/FTFCED65tITDTXtqHQkxnVX375G8MJjviDeS18CC3tKg2uOvDCDz1BwvQjHN/Uw62/K7clFg+WrMrWrZ9G77T0zSmHebhYVptgq6u9Nk3524x4asbHMNe/FwcYURSxQ0zi6Jo2c4plRcyhSf/FTnzcmP41+kCrlwi6mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=puY0KpMX; arc=fail smtp.client-ip=52.101.43.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="puY0KpMX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djgsUV1xHnjUOLqMSQc0anqHnc7d0LNqEoE9kCE47LQrDXFE6ksd+dqudi2pAZugv9bjp149ntfmJBJT2eaI5UIGc2nvX+4JnpGtILgmkuViCZxVvS7UeH0BCqLhPe4rKK1UDpVV9CeUOe0/l6FI9kiYMiHzIRyFAeR1Hr/wJhKv7sWhYocnudZXk3rAPFr+njjD9Rmo7iEPhwL6MEhZ6nU/5k2MlDeRW2/mGj+WYAOJjvAeYWZ6uoZM7aPbyG3qvUCRmN5DTLvfyQgLRPFp69tuXwoG/nMSwqU6HOeZ7ybUN8CVFJ7x1yiFpy1pHuCsIGrJVLxs6I17bDMAMZ91+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVVICGuo72hCcnVpPnRZw9e7oJFhRFfYjIG5JZMKz5s=;
 b=srnvG6XT82f15UTDCLs6FAmWrm0ee50XO1PHeHdFRwfsy//a2LkyPChm34JD12DA1OZxM46nE6yefE4bknbaeTuCrrBS6jNnrmCMu5g/V1/6Hddz1OlYn7HhYSHZs4/m0UYHBSgy7wY1li/ic4/YkDWOQFNJtnjE3nDdeX+mZsPmMqrVdHgdrhG27wV7jYvX9JTQn0fuAn1A036GmqVZ7zD5o/UOu0IaGo4G3zVhvKGYklJAougDBMV/Aym5htfteOA7jwDfcQ/e+MS88TrPVgzdSJY22Fd3YD7l/Y1gLgFsYAsaaWfk8wjuRt/GX6pBaT9RUPTvq4m1fOG88hUKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVVICGuo72hCcnVpPnRZw9e7oJFhRFfYjIG5JZMKz5s=;
 b=puY0KpMXiIFEc84dK/NTwhsjfmZ99TS9QwpKNnxR1JzpCm1dExyGJpOrMCVuJG442H9wi4hZcjxrNv3UcGxvRKk7UnqN4y6e45EwcZ2Tro2B4ikU/AwPUKeapWkOaYLa/hMylFwOMSBn3/js3W0mRnJY7U+m2VIwAZCEW8XST40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) by
 DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Wed, 15 Jul 2026 06:38:41 +0000
Received: from DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c]) by DS0PR12MB7771.namprd12.prod.outlook.com
 ([fe80::9a3e:791f:33b6:3d8c%5]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 06:38:41 +0000
Message-ID: <17acf880-e0c7-4950-89ce-9d3b47846073@amd.com>
Date: Wed, 15 Jul 2026 08:38:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Lorenzo Stoakes <ljs@kernel.org>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org,
 thomas.lendacky@amd.com, hpa@zytor.com, yangge1116@126.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <2bd89e95-9c15-4a3a-916d-0d71a92d8b02@amd.com>
 <27ebe8f0-78b6-402a-a2e7-4e807251d20a@kernel.org> <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com> <ak_A6Yc5mBXCrtXr@lucifer>
 <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org> <alDtzM28CgZJn6FF@lucifer>
 <62ccb0f7-a619-41b8-944e-11ae2d0ce70c@kernel.org>
 <alEUBzV1cevuPYeD@google.com> <alEZIuJhv5ZXGQac@lucifer>
 <alEc0I0VysX1p5Nk@google.com>
 <ad784f05-b36c-4e91-9f17-4c5b826735d0@kernel.org>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <ad784f05-b36c-4e91-9f17-4c5b826735d0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To DS0PR12MB7771.namprd12.prod.outlook.com
 (2603:10b6:8:138::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7771:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 7810bef9-d097-408f-078e-08dee23bb578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+OI2tXeyO9dT4vf1LYikzu+qGlJi5rD5Nl3pSJbnKnuyF3DzontVI7wyj+Hac2Sgwl+T3nM6t1OxNVlurrlzLNAOEpmD4XTU3cHibqsIJyC55WAjPRiTHim4IftGTpJEfjzGRuzY0AnZKF/AetE+gH7uZy92JmvMMQGJM5CrzzIXLTPiYgm/diRJ3tW4OfUsqRw16kM7SdqxLRtlYOP4Y5FV7np45RnuQsj2A4gLkqEK2BywQ0QRDB+fYfKk5p9AoDm44Ge9cCTLKjgCJ+aO72KkwU0Jg44+1VXzecqOtR7tXcucz0YviH0XbUu6ynSfM9qM2GI0kJ7BRGL4QbbN7VfTSZ6R2M2BsNdYmSqqCuOj0kbghovBzrO1DTicMLeXk8BgT6CaxyVB6BdBqnDf9o+svTaUDJ+EDhtO+XjlXQWuGESGs6eWHMD/hHf6T+0/lPatCKIRaGtpyzFPMr0kdqVqEO5zFL8NoVEgK+9WyKOKNTi5OnFjBRtBpVXQRkIp4bzjmVLNUT2RnnBWlDXhgt6VJagnXe6DteuNIbzU/OnUsueMIMNPmfrcbWVzsrMkKNgzKfiRGXXWmW67qBXFvTWaEb8FLUn53CX0UN6RtD9BzQ30VzoXKtzN0ZouFx61aRmrfVKSAV1PwXmuyMKb99Jfmz+9eRjmV91bLumHXgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7771.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0pBV1pqdjUzWGNtdWFTMit6YnlUQXJ2VC82UVNESGIxVWNQS2ZwdXBVOXlQ?=
 =?utf-8?B?Wng5Y1A5UXVFMWx0c2lscENtZldqWG9uWllRZitqV29RSjBtbGg0UDNEQXkw?=
 =?utf-8?B?V3NwZWVXcm1yUlh0RDhFL1I4RWhzR0dLM25DVlZLbkdhNGhhQTZNRmk2TEVw?=
 =?utf-8?B?UjRWYm93TDB3WFNscVlwRGlCdzFVUVJybTRtSlo1dDhzdW80WVZrakVTOEpr?=
 =?utf-8?B?d1cydit2THJTNWlOOG5HeHdhT3BoWDgwTk5IMnlXSXZTdkxGajBqOTNIRXlk?=
 =?utf-8?B?VmNuL2Iyd2FUSzgwOGkzYzlvWEM2dE95Uk8yMGlCckI3MzRvTGxwc2tzNVkw?=
 =?utf-8?B?T3FXOE5CZGdLNnpVY29jb3hWOHlkLy84empSYlM3VHFqSkxjckNlVW42a1l5?=
 =?utf-8?B?Q0VYOWpRVWpNK3B2SjBIOWM5ZGZkS3FJOFN2VlRmaUthcnRGa1gyME05RTRD?=
 =?utf-8?B?K2FHREVGRklzVC9sajdVbmNQd2FXQXNqQzF5OVoxeUN1UWMwU2NMQWk2cW03?=
 =?utf-8?B?WjBncnM3K0hWbTBZdTFBWms5Zm4vUUZIczlibFNralFUQ2NoNmUva2RFZHM3?=
 =?utf-8?B?ZG1lQXNvMk9Md3dzY1BlYkpjR2tVdzhuUFhkR2Q3dFlVbEZyQXBNVWowRlhz?=
 =?utf-8?B?UXFGekwrbWZsa3hVN3NxN2JieTMweGlaN2J1bzIyUEdHcWtma0JxZHZiYVlV?=
 =?utf-8?B?TFFwSklkMThtcmd5WEVoUHpUSEJxbEVmOHVia2dnQUZ3S0JabHpvWUkzcml1?=
 =?utf-8?B?bTU2bVRVNkZmaXI1M3VjdmFiWXhUWU5FLzkrckdua0dQd1pWY08wUnRYQ3Vm?=
 =?utf-8?B?cXJtSU1rMTZrM0dKQm1vWGVHMjFaaVU5VHVmMGliTVpIM05aTzlGODNaUTZz?=
 =?utf-8?B?NEhlNEJqZXVGM0pyY1hlUTc5Nno0azRvemJPY1ZCSmVKNS9ZWkQwSTVRZDcz?=
 =?utf-8?B?bStJYTBVMmRoMmNQeXNDcmxSSWtmZGxEb2VGN00rQmFHbHBHL1NMU2xON0Vs?=
 =?utf-8?B?OTFsZFo1Z3VIZS9pUXdFRjRZQXViSm56akxjMzlrNEI4c2c2cWFOaDZOUlpn?=
 =?utf-8?B?UnlSemd1emNtUUdCYkpxQm11M1FRTU5mc1ZZSFJLWVlpVTZNRXVvaUtnRk1u?=
 =?utf-8?B?WHB3cGZqeWFGRDZ6MWNHWnQxa212QmRNVzRxbE9uY2Q2QWU5d2o3T1lBaHcr?=
 =?utf-8?B?WFp4bFNQL3pRUlFmUzR5WndTd29ySWNrZG9FL2lSOHJ3S2lnSS80SHdQdEtS?=
 =?utf-8?B?blFWTWNLVitTMzFGQ0pQREFxVVV0VjZwMFM4cmF5eGMrb2xIc3dlT0c3Vnp3?=
 =?utf-8?B?S3Zwa1lMdjVnYkt0TnI2dXlJKzhGS21ncXR6YUxBQWoxRDZ4OEJrM09nLzcr?=
 =?utf-8?B?SkdkL3o0Y2NMT0gzK3R5Z0ZTUE1jdkNQdmFnWmNFUTBYa1FaVHVZZWREOE0r?=
 =?utf-8?B?RFhXb0xOOEJhOFlaeUJJNlkrTGM3bzhYckZEZStZaWtPQjJwQ1NPZHhvUUN0?=
 =?utf-8?B?Vjh6N0E5NkR5NnZSWnhuZ0ZQUkpyZ2g5RUtwOStRd0tBQjV0dUN3TGsvZ2Vh?=
 =?utf-8?B?WlU0bnZrZC9uZDJxN2o3MWhubGh1djRUZzhUVTRtN1hnK2JYY0lUQTVWOEY3?=
 =?utf-8?B?VkxwMFB3MjdjT0J0RzVOblB4L2NFejV3elk4YmJzYmNXL2M3Vm8weHBCZWF3?=
 =?utf-8?B?TnQ4S283NG1wTGVEdG5Td2FzRXZSd1lybmdnNmdsSmNZRWRxbTB1bXJtekdj?=
 =?utf-8?B?WE5CcHdJaGx0ODNjS1BjMStlVEViR1pQaDJnTFlhdUd0R3ByQXoxMDlpSU95?=
 =?utf-8?B?d2ZZRWN0MTBhbDhqRWZTOGZra3lHSWs2SmpXZ0srZlJLMG9yNUdianM3b2tk?=
 =?utf-8?B?U0gxVWdqTWgzYmZ2WUM3TkVDZlQvbDFsZW1kTWMzdG5sNDlXM2IzQStIMitT?=
 =?utf-8?B?N3J4NlI0TU4wVVBUM3FlMmhSQUljTjhJdXBrRWtHaU9IZkFNbTRBVnNVZENa?=
 =?utf-8?B?a1ZVQ2hZdEY3aDVtS1BvZWZFQ2ZTRXpYTW1FVWpPenluZGx5ZWV3TVhITzNB?=
 =?utf-8?B?cGpqZit2eHo1cUFXZ0xvYUFpZlR2SEVIRnhlbTVKWnp6L04rTnBTcFRBakY0?=
 =?utf-8?B?bTBvd2t1UjFGdmxZZFgvdUIybWRTd29QRG9sa05UMFB0dE1mOXJRY1RFcEF5?=
 =?utf-8?B?ZW1McnBRdElLc0xBYVByRHhNZFF1SkY1eUw5Tk9UbE15VlRLamtFcU9MbzE4?=
 =?utf-8?B?WGM5WW4wWk9KTnl0a09JdTE5OHlqSHNEZk41SDNGY3N6MVVXLzlESnVNb21O?=
 =?utf-8?Q?CuAUY99korQBB+P+kE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7810bef9-d097-408f-078e-08dee23bb578
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7771.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:38:41.1559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kD9Js8kT6aGtt1tZlBL2OchvXFnmCg0SCv40OjmNL3NivllU8LucwX2Ymwp53PFyVzzjlnnAWjI3MGdglXGO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247


On 7/10/2026 6:38 PM, David Hildenbrand (Arm) wrote:
>>> How long ago did I break this though? Why has it taken until now for this to be
>>> reported? :) commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast
>>> writing to file-backed mappings") is from May 2023 :)
>> The break didn't come from your changes, it came from commit 7e066cb9b71a ("KVM:
>> SEV: Use long-term pin when registering encrypted memory regions").  I suggested
>> falling back to a non-longterm pin, but David didn't like that idea :-)
> Yes, a longterm pin is a longterm pin.
>
> If we don't write to the memory, why do we need a write pin? To make sure that
> what we pin was actually unshared?
>
> Well, FOLL_LONGTERM does that nowadays.
>
>
> ... so is maybe dropping the FOLL_WRITE sufficient?

Yes, All that is correct. Sent a v2.

Thank you!

Pankaj

