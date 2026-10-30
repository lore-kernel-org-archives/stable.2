Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793364518;
	b=BzvU8PZ9XaF+WreCcdE7o3/Efl9fqZDDnDwkv2mjsAihGaXsRvPFWh8LrzKvOZhPp5iI
	 xxMQcHQVkFIJ/55FXgPkz3zvN+E/m5KHRX0hqfQup1S0yZEtSMOkYE2QauLgjLguVNMHP
	 EkeXPFM8UslUiyyLK3T/ALEdzBmZ4skUZz8KLQguqKexcrl7VJ01bNXdgNiCzBQ+E2qbd
	 cbURYgQuY/cRMzrI4gBO9t+3jE/oKgy4wp0XrdTjyQ8Z7mEw5qqxkSTsjARvcACimmXrr
	 5Inch8HVJcjm42Vwlj/5+Fh6MMNDcnLJH78BItrNje7brHm2BXY5B2S5Qz7vk2GMvTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364518;
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
	bh=covzK1D2wAUQcxY+NY895j3xQEZzaJ+MP45bqlpW5x0=;
	b=KraFir/wi/4sySsfpAe+VTWkWKWy7C7Aj2Q1BuK/XvwIIArYZqAFPRE8i1F1WbGR5ISQ
	 /3NQ+XIphwaErA7kAlHIupw5VArsdGHi7fFd3oTA6NX5IuTp25yoK4fzx70uwFd+6Wm07
	 SmScvvs26pUguLD6ggqJqvOA1NOyB4hRW4JAKdorVNUdxlUF84kq55jSVeWMucj2aMq2X
	 kqLsfMJtpOY4mta25VsqACndNIbhcloR5afla1ZTr/otr57G+TXqtFMV9u1aHeymjPXC4
	 OXU+ygU8bl9Hhpkg992w93NhQwMlLJRRifl7iaHrphL3oBwSa+wzxp4lf9Mr2usKaTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pfWXogms;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.38
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C659C606A31D;
	Fri, 30 Oct 2026 12:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C659C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pfWXogms
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toGDx0X1WIJ7FTjpaa7jgXDtP9Klb64rWIffSWtFEPLSxACIo+thfukRpTwzzBgwoQELy+7O1tnfjCRQ8bAnbgi/WlwopfzNRh4xGanc+HR0l3Md8RhT+S3mt0eH/RVIBoVZRslb6qjIQGBohbQmKtFN75ClSt4Y9cm/Mf5/8VcVPdpk8FQprekQ3JG8bM/icPh4l6WzDBJ+OfyxB8FDC+LLVoJ1DSL3jhOQPrF0Ocyei+OFEGLf2IHt/wEuG8ZfdAzzhXRbdQjykrScRZk3IQ/DaABF3XjutaU6rHcmzZx5nOCyXV9Yq57oZxRLflsi2JDIZ8T2M/AFbBPW89ArWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=covzK1D2wAUQcxY+NY895j3xQEZzaJ+MP45bqlpW5x0=;
 b=JidhdZUwVsNOWBnw7JHOoHPcwELhwjoJ0lk9aJoxosQ/hBJ+yAJBMAm3djZjs7FmIX7r9s7OR+GI/U7/reu3k/ztdHYTF5LkIyo1hLc0gI8P2T9k5Yq6LAz6soQ+vqf6Oe0JsWt5sATUOhoKkAzOwQlGdYF/IYQEQHGLMu5xGH7BtqFloeDYnbrjmPmjfi8rW5d8iE7hseIZebWlW6Eg/HClkVAp1vmglkK9355UE8fH5tiy2GUOrutK6GP7qxDzTMEtkOsHZlrKW8irWSRl2eZa5r/+IPifxjuVprdRRTNi0uaFYpabSTILXofsnggok9gRsdDCzA8W/Y5LEJTQ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=covzK1D2wAUQcxY+NY895j3xQEZzaJ+MP45bqlpW5x0=;
 b=pfWXogmsOHpchwIUiEd38Rk9IxaHNNzuHmMetoYLGrE9J2bal9vfYGPdWp9mS3541V32MNifZjXGOdnly7eDWCTxDXYzcSLunvLSHQggrs9VAEMB4yImxZpByI+3HvC/GahZUfe5BZ6xwUcGleujpiiSwz8roUuHMe7k7GYlvvA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 12:48:34 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:48:33 +0000
Message-ID: <3f883f3f-221d-4355-a39f-8321f2ebce49@amd.com>
Date: Fri, 30 Oct 2026 07:48:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] soundwire: amd: Initialise and cancel IRQ work
 around manager lifetime
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-17-lee@kernel.org>
 <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <43cae78b-8a9f-4528-982c-85c0049b1414@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::28) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 821bd84f-7feb-4dd5-13a8-08df36841b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|4143699003|11063799006|261022105027099003|261021123027099003|10067099003|261022075727099003|261028144727099003|261021121427099003|261009223027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	CI8NOSJnapEA2Lwmk8e1HDGeoomuuNuXAduRwB266sQw5W7IQIAb/3VRwwZggYrNMh+Yh0KxXZLYJv91iir+akYC6nF2zJTvKHSIi1tIkacGL9QTm/QTfntJ9hmxB8b9SanBJIlkt25EBIQBCVzAhdSD9tXWKh5qFmuCqFqfBhvauESH5foDLzXJlX9lUavhhlxU6CYYYhwpo1zhBuuf85/FZzlSklrpFP+ScFHaw0V1rVMc65BrpOb/IHVE/7ZfP6xC90uggHGAX9SwIzI4vchAmUP6+C4k44grK0B6JPygp+hyISDc1DZahQAbZX4EK/SlCHMpJsaVS5jYpSOfSF6Cv8MRfSJV5Zp8G+U71IiPpHyAzhzbkaam0442dsUHOwzB0nt+WJq3vzIwJWYviNYCLI8152FlUIOmH7o3FuPRMWdBSwN6OA/YIkufJJuZqPr6DqIbQ31zDVJ04rfBM3HLTNYwrb+m1T68UgnvSkPuKrSaGW2pNoR1SCunijxi2KTGkGhkJbEfSdruJXtwDcnwt8COzSSDR4uC8V/PsxNHowcupHmLvLl0O8710OVlcIZJLumSIRpSQQHUHDDBDPeIf/CWvi+DxACTjAXqvbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022105027099003)(261021123027099003)(10067099003)(261022075727099003)(261028144727099003)(261021121427099003)(261009223027099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1R3MzlNd1FXRHpscUx6Z2xXM2ZJL3ZVRzR3L2FrZ0V4Y1gxMm4vWWdacFdk?=
 =?utf-8?B?WlFlZVVWa2p6Z1ptVlgvRFh4YTRVb1h3RzAvN0preHUyTDRFd2xteWgxTlI5?=
 =?utf-8?B?OVdVTGwydEc0NlNlZG9ZNDFBaEp3MVR3Y05IOGI2bGI5UGxtQmlBQjFIUkwy?=
 =?utf-8?B?ZUIyZnpVWTRaYkhFU1VNbHBzbTRVWmgyNXdydHBBZ01XWHZkZmhNd3VrcDZn?=
 =?utf-8?B?TW9nMklISzY3YTJVUmtDZ1dDRkIrTW5BZzZ4SGlLTTArTVprb3lEQWZjUUsr?=
 =?utf-8?B?bDA1UHQrcngvN0lFOXVTVzV5RnRBeHpLUzdtVVlVNEY3QnBxaitVN3dpM0dk?=
 =?utf-8?B?dWVWREZtS2RvSG16aDdyTkFkdDlxMVFLc3hqd0JWZFBrT1lHMkNjMHMrczc3?=
 =?utf-8?B?MnhTTEpDeHNaQ3F1enhQYVZGUTFaRlZ6NTk4TWNIYXI0bmxDRWRIMUw2dHNx?=
 =?utf-8?B?d3lFWmREbUJVUGw5SkNtR001VXdhaVd5bDhQbWR0SjFnQ0ZlUld1M1AwNyth?=
 =?utf-8?B?a3BaVFpNQ0M5NyticlRSaXA3eTdjNXBjdTV0azRNS0FBV2xFQUV1U2k0bDJE?=
 =?utf-8?B?aUFRbStpaEFVRGltNDY1Q1Y5Z3ZmSzEwMEVuOEdLTDhabzJ5MVlGeGZDM2VU?=
 =?utf-8?B?TjNYZlE2dVdVTk5mbU1pT1pFRTFYNWEvTTc4RzlTd3hyeFBIMk8xN05kZFky?=
 =?utf-8?B?Tmt2REN3TXd2Y2szMzRDbmRaWFE1Nk1zY3ZIN3VtT001OEtST0lwTllBWVh0?=
 =?utf-8?B?UFZTVXJZL0VlcUxLUEcrM1UxbHZMMGdKRkJUR3ZpY0M0NCtJVHhIczY2dy83?=
 =?utf-8?B?RlVVaCtscHExRnZISm5wbW1LWTA2dzl0SkN4MDNIRTg0WnkzVkJLWEtUZ0p0?=
 =?utf-8?B?RmV5N2EwS08wYytodkhaRlhVazZsaldRcXFFRy8xYWZ3WlczTi9EdFlwemhZ?=
 =?utf-8?B?bEtnekNJM0dma3JyT3ZhNHBUcmxBWDF5QjM4ckxLZXg1UHoxdDN4L0pWbHkr?=
 =?utf-8?B?NU93UFNjQkpYenhrTHdIeE1tMmw3WkcwRExRRUNhbTRRdFlkOHF6TFpnanpO?=
 =?utf-8?B?RFFRNGdoS2NWVUN5dENvR0prQzUycVJlRlNKczRKeGkzcmNMVjJFaXVXRnht?=
 =?utf-8?B?SnRIdXgzOUdyVXlQNlh6Z0I1YnprQzJiS3FZRUQ2a1Y0dC9hQThVRzhnZ0xG?=
 =?utf-8?B?UmRjaXVNU3NhRFBIem1kR2dwZWs4SE5EMk5aSTlXSk9CMzRWOURzYWRJa2Uv?=
 =?utf-8?B?UnBIcm9YbzBhMXpiQnBBTjgvRjQ0YlRaYjdONEZBaXduUWZqeTNEY05KR2lM?=
 =?utf-8?B?b1dMMFQwS3ZVbzYzdUJzYzcyaFZDU0ZGdTIwejJsdUFxaHA1R3RKdGYyWGpR?=
 =?utf-8?B?TTBPUi9MZzNtcmRuUDhRbGJGK09nams5SEJlUlNYVnpLVlE0eVViM1RSNWxK?=
 =?utf-8?B?RGpzMzd4UFNTdXB2amZ3OTJwLytpNHNMMUEvdHBuUnQ3aVVuMElNK2UvSlNk?=
 =?utf-8?B?VzhQZEdwOWJhOUFPdm9wQS85cGQxOVNIcEg4TzFaUE5Bcjh3OElLN0J1aGxy?=
 =?utf-8?B?bGozMVB0TlVOUHV1WkIxbkkvNzFoQVRBczBqZUp4MzlmSjdDWHFpM0ZDTjMr?=
 =?utf-8?B?M3ZsTkxsYkNIRHFqcGNWc2FrTTRuYjlnY1FwL3BUNFdLQklZUTRGZ0FKbXZ1?=
 =?utf-8?B?Rjg3d0dOUE8vTi80K3BKVlJkNVdvRzVEbkcvc2NkRnhIYzNTNDhTWEoxT21p?=
 =?utf-8?B?Y3Zvc0x2RjRGQjQzOGRQbnBGUzRHSkVRMDRtZFgxMU1qNWhBSWVvZTVVR0ZG?=
 =?utf-8?B?a3JqaFl2eGVIQlh2MXI1VXBpYUU5ODZmN2VGbkxIMHFENmFKNXpOTU9FS21l?=
 =?utf-8?B?a1N0VVhJVHJPL3JIMkF0N3A1am03dTd0b0ZhOWc4WkVYRGNzdWhtMXlROWxw?=
 =?utf-8?B?WGQxMFhyMCtFazV5aXpLVTI0ZVB3bGcxVUJaanJhWjVzSDE0aFNTTFlIVUVm?=
 =?utf-8?B?RExFamRDUUtibzZhbTBTU2JMS240Zjg0YitJamMrdzV6WCtSMTNvWkVEM1BS?=
 =?utf-8?B?c01WS1NBMklTTzFoUit0SE1OTTlvYXdic0pUcHdHQ3lsSVRYYWJMQjRhNng1?=
 =?utf-8?B?enpnazhYTEZTTFl4UDFHVEVQc0dBMExJMXZlMFN4Vk9tVEIwRnN5RW9yTHo2?=
 =?utf-8?B?Uzl4ZnNDV1BsUlNucFdTZGtjQms1c3dFQXpZTDFxS1Rxa0gzL1MzMUJENDJl?=
 =?utf-8?B?WG1JWlFFcWtSMThmTVppS1MrZm1BSWdiK1FCRDliTFkvRklYWGtGZGg1dEEw?=
 =?utf-8?B?bG1oOVp1MmhycHBGRHVZakdVek1xVzVnMDlid0xDdGloZ0NQZGtSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821bd84f-7feb-4dd5-13a8-08df36841b98
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:48:33.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK9MbjahDPHZi0XMJi+qZQVU1n0YCeSaxr8qjOEFhjYiT5AKpFi/SIb4bZ5HCsI7VH4Dh5qzSLqxq3I+CbTLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442



On 10/30/26 07:13, Mukunda,Vijendar wrote:
> 
> 
> On 10/30/26 16:16, Lee Jones wrote:
>> [You don't often get email from lee@kernel.org. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> amd_sdw_manager_probe() publishes amd_manager via dev_set_drvdata()
>> before initialising amd_sdw_irq_thread and amd_sdw_work, allowing an
>> early interrupt to schedule uninitialised work.  During removal,
>> amd_sdw_manager_remove() only cancels amd_sdw_work without first
>> cancelling amd_sdw_irq_thread, allowing deferred IRQ work to re-queue
>> amd_sdw_work or dereference amd_manager after it is freed.
>>
>> Initialise both work items before calling dev_set_drvdata() in
>> amd_sdw_manager_probe(), and cancel amd_sdw_irq_thread before
>> amd_sdw_work in amd_sdw_manager_remove().
>>
>> Fixes: 65f93e4096a0 ("soundwire: amd: add SoundWire manager interrupt 
>> handling")
>> Closes: https://sashiko.dev/#/bug/linux-9890e8dc-4b7d-44d3- 
>> bfb0-171dc421e28c
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> ---
>>   drivers/soundwire/amd_manager.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/ 
>> amd_manager.c
>> index 98b09d81f3b8..2e1038ea0f36 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -1185,9 +1185,9 @@ static int amd_sdw_manager_probe(struct 
>> platform_device *pdev)
>>                  sdw_bus_master_delete(&amd_manager->bus);
>>                  return ret;
>>          }
>> -       dev_set_drvdata(dev, amd_manager);
>>          INIT_WORK(&amd_manager->amd_sdw_irq_thread, amd_sdw_irq_thread);
>>          INIT_WORK(&amd_manager->amd_sdw_work, 
>> amd_sdw_update_slave_status_work);
>> +       dev_set_drvdata(dev, amd_manager);
> The probe-side ordering issue is valid — an interrupt arriving after
> dev_set_drvdata() but before INIT_WORK() could schedule work on an
> uninitialised work_struct.
> 
> The remove-side fix is already posted as part of our v3 patch series:
> 
> https://lore.kernel.org/alsa-devel/20261013085111.2009061-6- 
> Vijendar.Mukunda@amd.com/T/#m60177687bb84758efdd6f5f09eba8ad32f0e4631
> 
> The probe-side fix will be included in our upcoming v4 patch series,
> which contains major driver restructuring and customer-critical bug
> fixes. Merging this patch independently would conflict with v4 and
> complicate the review process.
> 
> Could you please drop this patch? Both issues will be covered by our
> v3/v4 series.
> 
Lee,

I think as a general statement since there is still these big pending 
changes already in flight, could you either wait a few weeks until they 
merge or rebase your series on the in-flight version to see what still 
actually makes sense?
