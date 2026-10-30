Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793363751;
	b=klSrJ434t/07Nk0RdOyrP0anziNjuPYYxeTUSwbX6hSwsnilUg029oWYC393diBxI+kS
	 Cuqu1PG94aVQaM4Jo3NjwXBiYpot/WeyME6l9SJHG5srqu9NWSiu43t4GXdOg9stOWSwT
	 XHNiXBqHh7Gb8Wc0iqKwTzWk/8sJmNWoTIm72lxO9Qw4wnVgovZcSoab8GEVlE0lMO924
	 DgErwyVavVKJjbiBKl6wS7gmnBmCXWrL1YhJWaTc2eWL12Z5alojiUc46gXua7UirnHEb
	 8pn4Loir0/HC9QhrYedejJRnG0JJjr/oMqDkqZwb+Hb989eG3AgznlP8GuIOkYArt1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363751;
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
	bh=4wL2BoxjK0hK5neYFIn9XPGar2g1pwnBrVdx4iMFhqg=;
	b=p9Q5PCYb6So4xYzW0c129Mbjphv2eDPMsJ9JpBMIAQBTtlWCTS57U1quthQtsmlvjSIp
	 aohx9/JGNqpFj7p645jbaxA5XUzSYwMpD3Q+1kCJFfuKmEQpdk5LJ7h9Tr7/Dp2F4P7ct
	 zq9OdqSYAXwdQesHyRMzVQs/5QX6YuMk7uNKZGSK1prgyPeTq8D9uilfhbVBqGczRiaM1
	 Cn2Mk0JzfgV+ZvYgGaLe25FMIvIIH5tnnsbgVvsaWb5NMoZU2QxZl41cWWOCqR8CH/Q+j
	 ICYgyHXi7lH3QUx3mjx9EVt6cLJ+zcY/aZFyVsaoUYEXFE8uVgV00M8vTI9/Cmdm4Wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JMiT5iRL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.18
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32811606A31A;
	Fri, 30 Oct 2026 12:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32811606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JMiT5iRL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylLED+KDrOA4dHCs8NpvSZ4flo+uffZhn0qwIcmGMFVDD3lziLopHls2QqtARr+s/R2MpvNJkoD4usbCB7U3ArG0IsE1hcykJB5aqpgKBj8RR9aTDgac0Orfz4y5ledMh5pWheTh/xtu7y2HAJySGNeZ9zZPNM/W1QUW2BumW/P6gfeZmKZRmlUwSIl1PuKlzTy+hEAJctguKNlEmOwRaGfzS4IJ27SppgejH7WffZL7Ir91GIO6XYKqxLxel2MLWBBt0EEWLcZZO+sIKo7yC1vJaqq6rQWTJpo2nt8syeZda5XLeqmatuT/1CllMyB0hfYSS6LP1y8fi8v2KzuJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wL2BoxjK0hK5neYFIn9XPGar2g1pwnBrVdx4iMFhqg=;
 b=WraUkK0wnxMySSX3C2xmcSmzHWKGjg7ONArCY0AgQAO10BwvvpiQTLrmVHGmb4kdzM/yo6BX9+SEEADdpFZ0si2iGlUbfrqIEtFYvQec8kPkJJDVETb1iuAsFoBGv1L1MmwBqaZ6cSDGJZ3sADvnyIosJfbMvj/hvA7Rq6r/7hvnZx9WeOXZk5ug4ELH7KpEILWK/UhNNlngcOnz06bPBYK5bOQGPThxgQoDHZohjUtLNNC4uQv3wa0W+bhVOtPCipG6Gfxa+Tq9lQ9+/R03G24LOv0vWuO5a3BIm3urzvyf+bzH1nq1+kL8P9UZAeYuUq5nUHOF30pYxIRmH2vLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wL2BoxjK0hK5neYFIn9XPGar2g1pwnBrVdx4iMFhqg=;
 b=JMiT5iRLM5yA90cTMuhnvd4UHrCeM7i4D8Kipdcnkr4RHZ1EvYCOw/sfvL1c0dIvdudUrtK/Cx41AIrM4+60fvlAMkT9l5mGsvXuv4UEZwvmpXcADA+PbjJ59P/IeqohxsoefzWjLzlPraBe8PD0t9hQnIelC+OB3iSOu7+iGzU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Fri, 30 Oct
 2026 12:35:48 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 12:35:48 +0000
Message-ID: <8dcda015-b591-43d0-96d5-1faec73294ee@amd.com>
Date: Fri, 30 Oct 2026 18:04:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] soundwire: amd: Cancel pending work before
 suspending manager
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-20-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-20-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ba::6) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: efff191e-eaa3-43ac-95cb-08df36825327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261026121527099003|261022105027099003|56012099006|11063799006|5023799004|261021121427099003|261009223027099003|261021123027099003|261022075727099003|4143699003|18002099003|22082099003|6133799003|10067099003|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	zpGjsHKbdyaQLUQL9VmEoDjg1r9wcvKbdGzh8YMblp/UIP9MtzoTonGCKcg2Ol0EdqFN36hO4fMQJ6ze9LHd/rr8ND7Zmjt2QNbT8JKfoHQWdmh8ACLy7lax4riV+0IohOAEoHUvuEfcQtTpzyddpG0r9PCZNkv1LaE+IPVuhcl35C7Z+01jKEEIHN5CIbsDwlg854glULPyYSuotB8BRE3r8R20zkIPPVMmvicJwyRVsV+Ke4W76P785ZuxSk8x6sc7JvPWbLEPMogAshEGPDnWEpMik9H/rGR9dbv03oPQV+Rle22lZook8BBT8XH/Z4mSzzCFx4snonAIZJ50Z5JB10Lk2v9YX2UIEPyiiTfUsfU8VeMRGDA2v77d8K+RcFSbryAt9aDaZZVTfHNXsacMpMC6iWUMf0mEUKEsSQjOP8lt/9/ynC50ekLYnNKvUNsTdyCzDAxdtCqMK3jNJG4F9ye2HgLwd1SvfSTKsOP3d1AHpU99loekHbEDrYGJIJcnkWchXKpS21Z3AAMeVLQwDPttpbDERnDR/8N6TtI9jibXfLVaoFqcwkIpSHJNnRO+71Yi5DepyGUX33SW2njaAgzYF0lHQTjZvhR4MjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261026121527099003)(261022105027099003)(56012099006)(11063799006)(5023799004)(261021121427099003)(261009223027099003)(261021123027099003)(261022075727099003)(4143699003)(18002099003)(22082099003)(6133799003)(10067099003)(261026140227099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SC9kVmtkNE51ZVBWWXM5dEVneCs2L1pkNDdZUG02N0ovMUFVUE05QXRJb1Br?=
 =?utf-8?B?NzNYWjJXVysyTjRWMHhXS3ltdjUvNjlzOUdzbGlvaVBnZll4aGlXMURkMnh6?=
 =?utf-8?B?UUtMMWZDeXNHSXNkZnk3V2ZVY2trYUxHMVp5TGZEM01GMDJyQlJ2UWxjZVM3?=
 =?utf-8?B?Q2dQSVlJUTl5a0Y0NmJOZ0k2OEZpV0FCY3dhczFGa05nVXFqL0g2cFdFaEJj?=
 =?utf-8?B?SjV4RkR4Q1NUc0syLzZTQW95R0JCY0ZXeFFjMUZUbnFzSTNxNjg4MTJQVlBS?=
 =?utf-8?B?ODhjMThWTktWRjY3Tmt5bDRsbjR2azVYdGtiaEcrcEk1aHRla0dHNE84ZkJP?=
 =?utf-8?B?MkJuMkZHMUd0U2M5UWphL0ZxKzQzODE5SEhkN2tIWmNzYUhTTzVGbDdMcnpK?=
 =?utf-8?B?dDliN3VpY2s2YUwwV0ZDR2ZVZE1nK2hhTVR6OEdjWThrQjM2eXh6RHM3U1ZH?=
 =?utf-8?B?TWdGR2VwMGJqMlBWbVN2M2lxeGRkWWNvS2xBS00rbUkvS05qQVVzQ0F5Q0Ni?=
 =?utf-8?B?MlVSWU8vUGlNa1d0dTQ1NnQybjJtV0VLSlFtcWY2dnBpWlhJbUpRODhiZjIx?=
 =?utf-8?B?U2tmVkVZczlTcFE4d3BYdWhQOVFBcTVVOWZWZU4vUlArV2dLWElETnBKaXBI?=
 =?utf-8?B?MlkwVmJqNngvay9zVkY4akpwVmxRM3Z4V0k3RGVtalFsOURYT2l1T2xQdllB?=
 =?utf-8?B?UVVDK2FnSjMyN2JZaEMvTXJ2N1c5WW9VRW1PVXYrV2VHNmdvODF2RjdJRGhC?=
 =?utf-8?B?OGhxcnFGUDAyb24vNHFvYWIxWjhwcjA0cThzbWlRRi9HNjV3N05sK1BHdlRy?=
 =?utf-8?B?RVFEakxGWnBzK0J6U1Q5M3cySXB0aXZaUGo3eXZFa0k3TjFYWHNGS2x0WXFu?=
 =?utf-8?B?STUyZjBuaVVpUElKSHprWklIcTZ3NGNmWjllRnZzdUtUYWpQOVp6c3VuMFV0?=
 =?utf-8?B?TzRJYUNqVkZBaFl3VkxVWUlvYTFZY1gzZFlHMXRWT2dVRGtEZzlqdWl4SHNj?=
 =?utf-8?B?ZEEwWlRqYVJEc203K3pQUGIzdTdQSzNSbUExc0R0aVl4b0NHUDJzY3o0ZFZ1?=
 =?utf-8?B?cDY4UGk5MjZFc0tIcU5IbC9Gd0duTnltRGxjK3hLeXpCSVYvajhyZ1ZPeVY1?=
 =?utf-8?B?aXlTbGx0OFVXbVNhcE9WaGlqSVo4QmM3QTdKZ3piZlpuQWlXaFEyeDNTN0ly?=
 =?utf-8?B?VTVTVkRZZWpweHUzNkc4eGpzdUlHdmZyYXJvdkZURzJtSG4zYWFpVzgwMGRa?=
 =?utf-8?B?SDhSRmovU0h0T2pkYzhpazNjeTNZMFlnY1VnN2lETCtIaWYzekRYaGRJSHph?=
 =?utf-8?B?NlVDZG4rNEdkWWdvVmdEUVZ4bXByT2tZYmVPMFZoc2d5ZC9XV0NJNUR3WTM2?=
 =?utf-8?B?cUhPNUpJOUxlb2s5SnVUaFZpek92S25mRnhPdFlrYUg4UUZqd1BFMXRRUi82?=
 =?utf-8?B?SE1lNXpQcUxwQU5YbTBBUytRaDNKMWhqRThYZkg5dWRlWjJsSCtqK3Y2NTdh?=
 =?utf-8?B?UUVhQ0RMbHRYRDFuUmx0d25qRUpCWTlhR3gvVjJyVVQzSENxU1JJOXRabDR4?=
 =?utf-8?B?dlZpZFNQT1JKZS9vcDJob295aWdJM1pVRlBGeEU1NXlkdlVid2ZyWUh4cVBE?=
 =?utf-8?B?QUpDTUZ5VitWbXBOcE56emhrTFRlclFhZHRoVGRzdHpVWlhaQVRmRk5iUEZv?=
 =?utf-8?B?c1RVZ0hGNTFtWVNVcXQ1SnVGL2xhZU5uT1Rsa0ZjeTZ3cGtMQ0V0c3pPTjVv?=
 =?utf-8?B?cUFhWFpDOHVFcTU3cklsc1E4U1JTY0VOYzA3VS93TGZBeVJBaDRscjEya25C?=
 =?utf-8?B?VE1udGdKVUFlaDZXR3Bja3JlVDJZNzRGdGlSenpQWTEyenAzUGpMaCtoMXMv?=
 =?utf-8?B?OTJTanRKZXpyMzVtbXNVV0UxTTgrUzN4SGdEVm95OXBPUEo2NWtsZENLK3Qr?=
 =?utf-8?B?d1MwV2owcGN0NEpFYkhoczJPVzkyVWkvUVp6QnpCWFd1QlZYV3Avc0dJMWp3?=
 =?utf-8?B?SmpMaWM1WTd2M2NMYzVWcXlwbkpOSmFSOExyblNNckE1U1FkMFphTmhBeGI2?=
 =?utf-8?B?NVpacXdlL1haV09PcWlJcFFJemdyaS95QVNvWmh2T1pYeEd4YTlsVDhJbTVL?=
 =?utf-8?B?VXpKdzN6TlBmOCt0OCs1T2ZLNXhJa3ZlUkJrL1VpMU1VdE0relRENzVzMDRh?=
 =?utf-8?B?M0Z5V3hpZitoQzMxNElhOFhZbTBTQXZVSnBYd1dnb3plVXVCc0MzN20rclFJ?=
 =?utf-8?B?VjhWYVRnZzVqQ1U0aXZRTWhmTlJ5N0wwWmlTbjZTMThtb29tR3kwdjlqdFZZ?=
 =?utf-8?B?NDMyeDVKT1ZqOEhzL1QySEJ4ejhya3JiMDBKdGZCYkNFZnVHQmprQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efff191e-eaa3-43ac-95cb-08df36825327
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:35:48.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiwtEGn9GLZphslZKw9+JkEi/KD/7lYM3GK0nE4/0FrmVHbmD3xQpz4ImM+Hk0qpTlku5lTqhISrbRquVl8Obw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834



On 10/30/26 16:16, Lee Jones wrote:
> amd_suspend_runtime() stops the SoundWire bus clock and transitions the
> controller into D3 without cancelling amd_sdw_irq_thread and
> amd_sdw_work, and amd_suspend() only cancels amd_sdw_work without first
> cancelling amd_sdw_irq_thread.  Queued work executing concurrently with
> suspend can access MMIO registers after the controller is clock-stopped
> or powered down.
>
> Mask manager interrupts, synchronise the parent PCI IRQ, and cancel both
> amd_sdw_irq_thread and amd_sdw_work before stopping the bus clock and in
> amd_deinit_sdw_manager(), unmask wake interrupts only after clock stop
> completes, and avoid non-wake register accesses in amd_sdw_irq_thread()
> while the clock is stopped.

Both issues are already addressed in our v3 patch series:

https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m7741edcedb1264764edc7f8559e39af8b23433fb

In our v3 implementation, both the suspend and suspend_runtime paths
call acp_disable_sdw_interrupts() followed by cancel_work_sync() for
both amd_sdw_irq_thread and amd_sdw_work, in that order, before
clock stop — for both CLK_STOP_MODE and POWER_OFF_MODE.

Additionally, the amd_sdw_quiesce_work() helper introduced by this
patch has the same synchronize_irq() issue raised on the previous
patch — to_pci_dev(parent)->irq is not the correct IRQ line for the
ACP dedicated interrupt. The disable_work_sync()/enable_work()
pattern also introduces a new window where a late IRQ can re-queue
work after enable_work() but before clock stop completes.

Please drop this patch. The fix is already on-list as part of our
v3 series, and v4 with further improvements is being prepared.
> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
> Closes: https://sashiko.dev/#/bug/linux-3b774ace-00cf-41e6-82eb-85cd43f5e1d6
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 40 ++++++++++++++++++++++++++++-----
>   1 file changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index f39f4f04db7e..ba8e6d42c467 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -148,9 +148,24 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
>   	writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>   }
>   
> +static void amd_sdw_quiesce_work(struct amd_sdw_manager *amd_manager)
> +{
> +	struct device *parent = amd_manager->dev->parent;
> +
> +	disable_work_sync(&amd_manager->amd_sdw_work);
> +	writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
> +	writel(0, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
> +	if (parent && dev_is_pci(parent))
> +		synchronize_irq(to_pci_dev(parent)->irq);
> +	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
> +	enable_work(&amd_manager->amd_sdw_work);
> +}
> +
>   static int amd_deinit_sdw_manager(struct amd_sdw_manager *amd_manager)
>   {
>   	amd_disable_sdw_interrupts(amd_manager);
> +	amd_sdw_quiesce_work(amd_manager);
>   	return amd_disable_sdw_manager(amd_manager);
>   }
>   
> @@ -1049,6 +1064,14 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>   	u32 status_change_8to11;
>   	u32 status_change_0to7;
>   
> +	if (amd_manager->clk_stopped) {
> +		status_change_8to11 = readl(amd_manager->mmio +
> +					    ACP_SW_STATE_CHANGE_STATUS_8TO11);
> +		if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
> +			amd_sdw_process_wake_event(amd_manager);
> +		return;
> +	}
> +
>   	status_change_8to11 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_8TO11);
>   	status_change_0to7 = readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>   	if (!status_change_0to7 && !status_change_8to11)
> @@ -1341,24 +1364,24 @@ static int __maybe_unused amd_suspend(struct device *dev)
>   	}
>   
>   	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> -		cancel_work_sync(&amd_manager->amd_sdw_work);
> -		amd_sdw_wake_enable(amd_manager, false);
>   		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
>   			ret = amd_sdw_host_wake_enable(amd_manager, false);
>   			if (ret)
>   				return ret;
>   		}
> +		amd_sdw_quiesce_work(amd_manager);
> +		amd_sdw_wake_enable(amd_manager, false);
>   		ret = amd_sdw_clock_stop(amd_manager);
>   		if (ret)
>   			return ret;
>   	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
> -		cancel_work_sync(&amd_manager->amd_sdw_work);
> -		amd_sdw_wake_enable(amd_manager, false);
>   		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
>   			ret = amd_sdw_host_wake_enable(amd_manager, false);
>   			if (ret)
>   				return ret;
>   		}
> +		amd_sdw_quiesce_work(amd_manager);
> +		amd_sdw_wake_enable(amd_manager, false);
>   		/*
>   		 * As per hardware programming sequence on AMD platforms,
>   		 * clock stop should be invoked first before powering-off
> @@ -1391,25 +1414,29 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
>   		return 0;
>   	}
>   	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
> -		amd_sdw_wake_enable(amd_manager, true);
>   		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
>   			ret = amd_sdw_host_wake_enable(amd_manager, true);
>   			if (ret)
>   				return ret;
>   		}
> +		amd_sdw_quiesce_work(amd_manager);
>   		ret = amd_sdw_clock_stop(amd_manager);
>   		if (ret)
>   			return ret;
> +		if (amd_manager->clk_stopped)
> +			amd_sdw_wake_enable(amd_manager, true);
>   	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
> -		amd_sdw_wake_enable(amd_manager, true);
>   		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {
>   			ret = amd_sdw_host_wake_enable(amd_manager, true);
>   			if (ret)
>   				return ret;
>   		}
> +		amd_sdw_quiesce_work(amd_manager);
>   		ret = amd_sdw_clock_stop(amd_manager);
>   		if (ret)
>   			return ret;
> +		if (amd_manager->clk_stopped)
> +			amd_sdw_wake_enable(amd_manager, true);
>   		ret = amd_deinit_sdw_manager(amd_manager);
>   		if (ret)
>   			return ret;
> @@ -1452,6 +1479,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
>   			if (ret)
>   				return ret;
>   		}
> +		amd_enable_sdw_interrupts(amd_manager);
>   	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
>   		writel(0x00, amd_manager->acp_mmio + ACP_SW_WAKE_EN(amd_manager->instance));
>   		if (amd_manager->acp_rev >= ACP70_PCI_REV_ID) {

