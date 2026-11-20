Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157095;
	b=3fiB/bdMpXPRyiLgPRKa687IGrjzWXWRnEEyUK56ekT7TXMkDCO8GmKXEP9ef2bZJz3R
	 dWFYMYl+BVTCOUN9qwitbBDq2vQ/MGMn0AkPeFsWTqyY/7+ggprXp2XlhYLlzmhhggfXO
	 kjwfIzcxOh7L1Mye0QeFG2VQPKnJIdkvgZ5ylydvmDPnOrNT/w3/5THeM2n3gVHU1LmqW
	 dmgj2gr2oSDQavayOL4QtkP3esLeez0W9IzqNAOjtFKPYK32S8JZeeWsgENTT3+0dhU67
	 dwU70+FBupCadThzoR74E1BVwnsHIqyhXDKF7aI+JkbstQ3oD6fnx4CCYMFTNMHWkgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157095;
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
	bh=xT6362r/ofZlEhjRPr00Z/kXxG1rc2PdCrraMdwmrJI=;
	b=1pvHdTl4s5oW//WvD3kWo8XO9cLg3kmg5maEb3bD/5Q9b5OhpowD1wiKAUpvF5W3i5/L
	 uHB6TbrXE/a5UTbJrlPTfyMUcQov8X8zjYYJ7lsYMxecmxrOyM2BQpsVhsSvQc+vdzdyX
	 gCJVRiSRtYaZj/V6ueN5XySYTCAaDtu2T+owIYW/Buzaz5+NvKXy1B8Qq3iPvwz/P9Fd4
	 dt5AikW4ilyW4xZRcPgUAj0/Xpx39CT5RrFmihUu0aGPD4SygT1hJS05/mq50+Xr7+ARG
	 H9jXC9u7m1ZruqitxcpoInTjD8lwq7SGiV+x1I2tK0ELOB219ycIZYiRWE2L9ARF/ZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1u7cSa9u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.32
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD960A2601;
	Fri, 20 Nov 2026 06:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DD960A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1u7cSa9u
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgxocg/KvGsSvHpwcfUNLPyEIrwJu2Mt6H1/3vZrIR7CkNlJXq0UW53L8ker8Id1Gi/rvzhfE35PdD5UFptBYendTXiSCon4HyZRofwm55gi1AnDzfaNZgd5xkKiuvJksarpdLpDUp64lwzagqpy7hMpBxtxANN8NV61GeTx+zomaoRE4kTvD6DohdLqdwIktFvnJu6JCbCP81ySaDiDUhO31haZWG5Ha+tbg1rWcX7VO95xFLt2oftdFqTC3VUKRvuuxd0sXASxm/rM+ybwkw39tlG5CmbBLxpLUbJcgRDDs9qmtFaJ5xT6hwYlX/8mK9PHoV4f6UQP68TnKdZDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT6362r/ofZlEhjRPr00Z/kXxG1rc2PdCrraMdwmrJI=;
 b=m8xk3Wg0iDnysiMtAlTmNvfB2v8Gqz6K/2iBWgXTUjCzt/LVfNTv4hoolZiFCCCA72AnrjPKyKlN3813Oe4WOsji8JlrqejZZoYqZX2+SmTiIVCp0ztX4nrjfdHiQULtdfASCe7Mv748TQWmkmf2otwa1LzPjNwAuzRkfHL2aRgyQDv/f+eQABvjhD5pWZN+LJOoInBNHiOWftiMBB/mDoSr7G+u4j7X74fexEVVw1FFv0SeJNsUFt2A4W2njpToZ0w5cjSsBuWlf3bLOJsH80nGq6SKkS02UM8fjuFpy+KS93z3GzsSewwZuxF6kmmTWWcu8cWimtYSJTCxCO2LAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT6362r/ofZlEhjRPr00Z/kXxG1rc2PdCrraMdwmrJI=;
 b=1u7cSa9uZ8ENrWRYSTTXCZGLkbuqNDNIbamnpiQFo+NFbBvOAElzf8du99DcHczVkECrG3yqGJzyidnkuwCD1XffxhshlScFLWgHvC6y/nHDHNQwB7riOVxvdR8EkkFHE/MlVZG4KKNzxb+0lp/y/L/s6A7uAj0juqn+0Iz8RL0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) by
 DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Fri, 20 Nov 2026 06:44:51 +0000
Received: from DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46]) by DS0PR12MB6559.namprd12.prod.outlook.com
 ([fe80::3f99:f532:cf6b:ea46%5]) with mapi id 15.21.0615.013; Fri, 20 Nov 2026
 06:44:51 +0000
Message-ID: <139a1c14-39a1-4bc5-aba3-673ba603821d@amd.com>
Date: Fri, 20 Nov 2026 12:14:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpiolib: acpi: Add ignore_wake quirk for Gigabyte B650
 GAMING X AX
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 silverducks@altlinux.org, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-gpio@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20261119083813.390337-1-silverducks@altlinux.org>
 <20261119122844.445945-2-silverducks@altlinux.org>
 <av8EszUWsJIq3hIV@ashevche-desk.local>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <av8EszUWsJIq3hIV@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::17) To DS0PR12MB6559.namprd12.prod.outlook.com
 (2603:10b6:8:d1::6)
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
X-MS-TrafficTypeDiagnostic: DS0PR12MB6559:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f404e0b-c199-4998-ab5f-08df46d1c716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|11063799006|56012099006|261026140227099003|261022075727099003|261021121427099003|261028144727099003|261022105027099003|4143699003|261102123227099003|261026121527099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0VV8prf4hF2jhLo9TxHALb0o5i2RUUfJiEl7l84zjHC1Xgihoz8DWw9WlqwledbOcp5i4YwbFXqL7YV+aMRTPQKMxUDaj5FoEhUGQ2jr3oVnEC4d/lVHrnQvS7hJNmI6TifxE7nJf2aO5/PhIOOaK2xw3f8MU8+jrlj7ym8qbf8Fs4uNU/M1eK5eZS3ivAyXu0hv7hGqoYnBk9Wo+WubeC2zXDi7KhOfF1ZK82Mx4sBuvFaN4gnymfB38hDEWoL/08ZuQm/iTgxNKVZEedr4iQqdF2tmNe/Py0iqo6DoSuB+Z6MExydimHX1zyPv+92eJavSm06Qgpme8TlyRKNgTd78bG65jTar5um4zSeIxX8cA49YKYzkJJuJlfpCgDPw/NIz/Dixg36mMg/PzgJwVaEAuML5ksqPfTLwwWn6R1+B+W+22KGfGAegJ6pPz8vT0kNhcErz3fGSTp17aid3X7+gCctN4Hrao28fgX6T+gOTb9z2SCsRwTgONSzzfgZHX/KzpzZDsvNA9GF1WkwltLk3qhkMpeL0mk+HgAECZz2G1uyKOA6qB0OudLDCOdhhSDYLNUOUhgTBWDDbppXxidKKuU8nCLq9TFXjP2GeyXwGrZBLqbts+RMMVAv3SyJZQ5RKgFi85Fe0Syx7Jf28J+nNuKoAw3rZMbK7hB76sMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6559.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(261022105027099003)(4143699003)(261102123227099003)(261026121527099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFJ3UmxxMnhXbEhjeXlJSS8yVDRyUE80cTJzTFNNamJQdU9ZYmhQL3ZnWEQr?=
 =?utf-8?B?dlhudlh6KzNpVE44Nk5tN3VMUmduNEVvT2Z3SEY5eFMybHd5K29Fazk1Z3BC?=
 =?utf-8?B?bHduOTVUWi9BeUZCdHZybXFVRFpWMzB2ZGN2VTRQd2habnlwK1k3U2FzNC8r?=
 =?utf-8?B?NGRlZUJmdVF5VktCZUhuZUNzTlI2elhWU3p2alRHVkw1YU5ZS1A0MTZJSnpE?=
 =?utf-8?B?cE5JUERaNXh1NVZqcGgzVktLYTVsRFh6Zlp6N3RML2VIZEZxTnBWRnlxQWU3?=
 =?utf-8?B?czU1K3RmTmRwVklLcnpFWTM5cFVFbDJ6a1R6d1VlV1doWEhPMndIMUx4VWFr?=
 =?utf-8?B?V05yaDJLN1ZRRjdzeU5lNVU1RU1sZG9lM254TkliU2xmKzFxcitEM2ZlSFpW?=
 =?utf-8?B?UFV2eW9WQWZrNnJEZE5TWTFKTmM1SDhuVnBHQURDZitrcDQ5WGQ0SjF4eFdS?=
 =?utf-8?B?M09RNjlpVDM5NG9qQitMQjI2QlBDL0o3RjZUUGdRUm9jVlJscEFMRU9STGNC?=
 =?utf-8?B?Wm53TVAya2xoczBBamMySUFodTdhQ1hPaGM1eWVzelF1S2U0enQ4QjkrcVZ4?=
 =?utf-8?B?Mk9BQmRxUDhnOFBlcDI5UDV3NnNMOVdDdVpyZG5iS0JNRlhFVVJrbmttVXJh?=
 =?utf-8?B?dkYrSms0S0RwV0owVDg0UkNGMWxVSzZ5YXdWbCttSzFiZGhBTFRDbXlGNEZB?=
 =?utf-8?B?emJlRkZySGF4S0Q0Z0w4ODhhbi9tbXRKb1FjL1NveXdZK2psZ2xnQnVHbHJH?=
 =?utf-8?B?bGVURC9LNDVzNlNtUmFiTFB3bVYyS3YzTWN4dUlaeDBOUEdWRkFGUjJBbWQx?=
 =?utf-8?B?THM4QkFGMU5CMUQ3WUkrQXZCMmpJZW5lOTFaZzFVam1tZUpQeldLY2NVaHo0?=
 =?utf-8?B?cERpdU95WW5EdU5rZTdHdGJxT3Z5RE9ZQ1lxaGZhSDdXb2x5N1M1MTZMallI?=
 =?utf-8?B?YTRLMVFHUkNzbWFzVElSOVpRV1QyMmFFK3F1Ny9qZk5sMktHZ09hNWVqZ2Zy?=
 =?utf-8?B?QXJxZnFuazROZllwUHV6VThFSnM3cUsxZjZuajVKTEExYVppellRc29XVE1P?=
 =?utf-8?B?cHVjVDhIRklJY01CVHRXamtUR3dQMDRKdForR3pweVhTOXBBVndtQzBEekRF?=
 =?utf-8?B?bHB0em5tendWR08xZnpPMWFwcytQN3BLWGpoNUJ3L1pRcDlOYytSNjJ4Q2ZS?=
 =?utf-8?B?Ly9DSURkNWNyUktEanZ2VW5UN3h1Mzg0bjVFdEJSc1Rub1pRNjUvVGZFeWNH?=
 =?utf-8?B?dGhZWmtaYktuNmZvSzZiL0pJdnpxMitCTVlEWGkvZllaVVZhK2RyVFlPZUY4?=
 =?utf-8?B?Z0o3bXdubDZ6N3MxOWt2dnRnSmV2RkN4MmhUcDh4RGpZd090eWw2MC94aUVY?=
 =?utf-8?B?b2xYSGJiUnJYQk8yczdPUmlaSnUxZ3IxcFZ3VCtWM3hRaXgwd1JleWxHR3VI?=
 =?utf-8?B?OGx4aElVQmJYNWR3MllQNlVpeVlRTllMUjlPVklyMVpBRElLVlFBemhtQkpv?=
 =?utf-8?B?aEs2QU5xeXRFc3NaNFJxSTAwU3pYbTVaaGZ5WHZCdTF3WEkvQllocS9WVHMv?=
 =?utf-8?B?dEtIcFcwampMdTlKWGgyc1N3b1AwQjlkeGxMZjVCUDZlbWh3UGVHVG12bnRr?=
 =?utf-8?B?Tml6OHlwckxCaCsxcnE2QlIzbUdGUzMyRFc3ZG9IUFdhUnhINEpoNmlBWXE5?=
 =?utf-8?B?dmpqdUVONXVxMjREYjV6dllGM05lWTFmZlNLS0IyaWpkaFh0aktBL1BFdzg5?=
 =?utf-8?B?ZkpKYUNjNUdzcU5YOUxseXFkT1VnV1VEZHk4K24vNzd4c25jTGFyMFRTT3pU?=
 =?utf-8?B?emFkRGd0T1M2djN4djBIMTF6Z2hnc3M2YzZ0UHNJVzBEeThZck9TYVRrMHAy?=
 =?utf-8?B?Yk9RcER3eDFlOEhLMUZ6eVovejFCUzN4YStxUlp2dXc0c3pDcE1zSm92OFBy?=
 =?utf-8?B?MmdoUG1BMTV0dFN6OXFka0t3dEJRdWNVVkRZU0RqV2h4b3VpZTVnbHBYTUcz?=
 =?utf-8?B?Kyt0RWgrOWtpRVpiUml3SlViWUN4QlhrUmxjd294b0h1Tnp3Q2J4eDFYN2w0?=
 =?utf-8?B?UVl2ZjBzaFJrQWhXVWVQdXFOaWhwZCtEeG9lWENyYzh0aS9udGQ3T0RZSXBy?=
 =?utf-8?B?TWVDY3NKcGVLVDlHbGdtOFdaV3VsOS90dmI5ZTJtYUs2QnhveDE3OUhGd2lJ?=
 =?utf-8?B?VXYyK3FLVGJVRGdYZzZqbkYrM1VyN1RpalJsQytHUmxwQ2xod09ETmVlS25s?=
 =?utf-8?B?T3JtdjVORkpmaVZUNUprK3dOU3U3YmVHS2JaUlFwR29SUkx0RXMzcWQ5WUFS?=
 =?utf-8?B?dFp1MXNINkZXS01lM0h3TW82Y1ZGUk1pUEVxVXdKVUFkaWRqQ3Uxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f404e0b-c199-4998-ab5f-08df46d1c716
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6559.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:44:51.3667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5T7iem61puRuSMz0qRNCURj48q3hCf1Yx204VwwTK6ERPvW0uzZ+lPYbTrfpgd7FCG1csmS0sZzPjO0/0Ipqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

+Cc: Mario


On 11/19/2026 7:46 PM, Andy Shevchenko wrote:
> On Thu, Nov 19, 2026 at 03:28:45PM +0300, silverducks@altlinux.org wrote:
>
> +Cc: AMD folks.
>
>> The firmware's _AEI table on the Gigabyte B650 GAMING X AX declares AMD
>> GPIO pin 3 as GpioInt(Edge, ActiveLow, ExclusiveAndWake).

Please share the decoded _AEI so we can confirm the pin and
controller and point to the GpioInt(... ExclusiveAndWake) entry,
pin_table[0] == 3 on AMDI0030 (i.e. "AMDI0030:00@3" is correct).

>> gpiolib-acpi
>> requests it as "ACPI:Event" and amd_gpio_irq_set_wake() arms the hardware
>> S3 wake bit for that pin. The firmware then sends the signal a few seconds
>> after entering S3, so the machine resumes on it's own six to ten seconds
>> after suspend.
>>
>> Pin 3 is the only wake signal the OS can see for the whole GPP7 PCIe
>> domain, and GPP7 has no _PRW, so ignoring this wake flag is the only way to

You say GPP7 has no _PRW. Can you confirm none of the GPP7 child
devices expose power/wakeup, and that disabling wake there
(echo disabled > /sys/.../power/wakeup) does NOT stop the spurious
wake? If a per-device wake control exists, that's preferable to a DMI
quirk.

>> keep S3 reliable on this board. Wake from USB keyboards/mouse and
>> Wake-on-LAN through that domain is lost as a consequence, but I figure S3
>> not working at all is worse. The power button still wakes the machine as
>> normal.
> Hmm... And you are running the latest BIOS?

+1. If a newer BIOS de-flags the pin (ExclusiveAndWake -> Exclusive) or
stops asserting it in S3, this quirk would permanently disable GPP7 wake
on units that no longer need it. Please confirm the BIOS version it
reproduces on and whether the latest available BIOS still shows it.

>> ---
>> v2 - Put real name in signoff; Moved testing information to comment.
>>
>> Quirk tested on upstream kernel v7.4-rc2.  Also tested on stable kernel
>> v6.12, which is the version where the issue was originally diagnosed.
> ...
>
>> +	{
>> +		/*
>> +		 * Spurious wake from S3: the firmware _AEI table declares AMD GPIO
>> +		 * pin 3 (GPP7 group) as Edge/ActiveLow ExclusiveAndWake, so gpiolib-acpi
>> +		 * requests it as ACPI:Event and amd_gpio_irq_set_wake() arms the
>> +		 * hardware S0i3/S3 wake bit. The firmware asserts this signal during

Wording nit: this is a desktop board, so it only suspends to S3.
amd_gpio_irq_set_wake() sets the S0i3/S3/S4 wake bits together, but S0i3
does not apply here and your commit message already says just "S3 wake
bit". Please make the comment match and drop S0i3.

Thanks,
--
Basavaraj

>> +		 * S3 entry regardless of the PCI wake sources configured by the OS,
>> +		 * waking the machine a few seconds after suspend.
>> +		 */
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Gigabyte Technology Co., Ltd."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "B650 GAMING X AX"),
>> +		},
>> +		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
>> +			.ignore_wake = "AMDI0030:00@3",
>> +		},
>> +	},

