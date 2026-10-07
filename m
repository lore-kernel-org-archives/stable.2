Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010037.outbound.protection.outlook.com [52.101.193.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785F4D9F88;
	Wed,  7 Oct 2026 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401098; cv=fail; b=hkCYpV15BPb9epYYypQ06Ky2u2/AHUsEEBIE08kP3n6qzig//2a5RzxxpP5eYPt4YreW7kWQDGATZp0kgVxRpRwS9JlSnvJpho/w32v9E7XnURtASUBvOW2VPP+0t83w6pYq2xE4vek7RYGXg2c2lHwKdprOJ00gQOmKzu7mEBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401098; c=relaxed/simple;
	bh=bDSJouVdpBAwdPnAPDJWuf1Isemhj20+T+uK9nJ1eDs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsPmGVaAfJqLp57VQFxMDi/uvZKjpwolLjapvWIJM/wjd93Pq9fYJPPhagISLg5GA8MCAFQyTGQ+aRflEhavVAkr9n82iG+bxtP0X+8qs53Zwqsux5hkKCl4uqoOG5P5W/Wx6b84A7RNMzHzOV14MgOuRgXud77L1COBEs2hAFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RWrLXPbL; arc=fail smtp.client-ip=52.101.193.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RWrLXPbL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLjvUAPSYgsaibFubgl7dp6niFRfxW1weteUfbFUdDfTj/P9FG2ehri2P7hQTmPQVjhhVIcxzxppiCiR1sEq+Bps0hCpMDNtMVQDZRa8bw5r3vCo7mp45JFN/Ydy+NO1OSpAdVVMbrw+NFrw5L/Dkko90wXyIFCxB1IVGjwoS4VIkw8HB/W7YgEHqAa/j5bRbOqB00dg2JJAbk4GlRKpfZUNCL9h9ZPputk83E/PLvFBilJCsJenu/p/JSVh6FEzuYfVrhZ3MiphMhPXCI7PeSioPeVAZNrEf16vML6gMXbGZ2oQrgMCvCA1HEni0OimmKGYP3bjGiEvpsi4Pi01RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCYhGhG/+l1B0ELo1/gNE/CI0q/TZS+IvAKfCVJDHbs=;
 b=b7zmnCCI4WxaMUSvVtOP3HLNVweReMlSSnyZ30xp0PmjyV++3u8oP9aHrenjTqbP7/ZdfA5ZF1buMWMzhUaNtXS/7WMmO5l8z6V3jb1+ZSym+p5cc+Y7M90JvCV4gdtvQr6Eo1GwcVfID1H2xTPZFzxryKS+mmjvCrUCyXzz9HGnFmCwnEypuWuWcF2V1qrcEqN7U3m6hNQQWntoWF6hQ6PZaspzg716AofDDq68yzLjc/NBsTwx6I1pxlaT3CZhIMzX74ikLhYjVoG23Y6NPokzqWvwdqAzBevwZv9HHUIfVPxvARJhAMavbl7C3dMzg/mcLtdcTzq7jkxRBXaJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCYhGhG/+l1B0ELo1/gNE/CI0q/TZS+IvAKfCVJDHbs=;
 b=RWrLXPbLEw/ZGLLGmytM23xOhSdX9kkjOLEozRDRg5tQVJ4QK8AQubI5Zw4L/O61+9fP7tuniqEgjIhd5WjqGRuMU9ay0cjLSx5MXyOp+61NsUdSiZT9O8bWDcM1ZE8IJSR/ZE1HBK53WRpxbGNakntNZmPtHqpZQIz+UV97hE0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 19:24:54 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 19:24:54 +0000
Message-ID: <b54f6026-b65f-499a-9513-3abfaed97f2b@amd.com>
Date: Wed, 7 Oct 2026 14:24:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: amd: Clear S4 wake bits when firmware has
 _AEI
Content-Language: en-US
To: Linus Walleij <linusw@kernel.org>
Cc: Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 Olzhas Marat <marat.olzhas@gmail.com>, stable@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20261005180150.1024336-1-mario.limonciello@amd.com>
 <CAD++jLnO6QuphZwOiT9kYpn=CiPFiQfxj9bdbDw08d=GdAhD=Q@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAD++jLnO6QuphZwOiT9kYpn=CiPFiQfxj9bdbDw08d=GdAhD=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::24) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: affd04c6-2607-47dc-a5df-08df24a8aa76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|11063799006|5023799004|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eOJnKo/mq5gjW9c0VaNFa3jg+t2Zh7b6nsf7ZEHITePYNq1vgvqG6kStCa8iAWcdCLmTbf4CurqG4KnTU6bSmWhCECNEQtoXu/H2OQAPTKAcj1ln4loDrT8T32aI8QialyRFyIUNxR7F+9ZMLkyHWjh5bDCnUdAevm4zITpsoYjb/wlvHTHeiJMd/Z7JSra+5tgSIEFicC4PrheE/DUWsAkvJRLguYyrkCpSTOM4XLswb6QZw16SVCYDvNAjBfyJe4uNqxHOMOMTwLUAop4VGgXfjqn7BU581nGN9OH0aMXBmGi63XH+7HBtd0Ie7c/GmRcXm7BpW5Aqf4ZrBejadk6/8DjR+LAhXZcpeGIGCrxyBsUAKVPuULWNfuddIxm8GBG5ddd5TWMKqXv3t7HXR5aMpkoozhTE4DE3MDlg0v0zNYm5yzhYL+LSh5AX5QxQ+2c4SfDHF4Oadwz4E3sXDBQjmlcUuTqnuMy47XzWpZmx/F+utrrWr3otATYupCuheyJ0q+fX2b4ZldXbYvPABNv/qfGB2RhaTUstC/XG5rHUOk8omdNB2TZFFuf8t0w/b+e5UKOoBvSRXk+o/h9fekaHmTiYtSe1mZo0ZdHryKFcsgwK16xgqeu6c5Z0p/SOteFr8caKemBSpDV6fit5eoDqk84rxtYeTLkP1/a/OWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(5023799004)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3gxZjhCVVpDaUUvRlY3S3hSb25vNk5ldzJ3dVgrV1QrRnl2Zk4wcE5KUy9R?=
 =?utf-8?B?a3VxUDFmUi9SY0xCeHpFUUM4WXBSVUthbGVIYnhGSjUxVyttUnU5aTkwQW9a?=
 =?utf-8?B?RGFWNmQ4MEdpR3hDUk4wenRZNExnWTh4TUhHeWh5M3NPcFlYeHQwNmRiWDF1?=
 =?utf-8?B?TExPZUFyd1R5K2Y1b25yMERBcTBJUXJ1dUJIT20vbW5aL2tIUWMzQ1N6ZjhX?=
 =?utf-8?B?elB6QnU3bVpjSXArMytkVFZUL2E1MkJMUE9icTJ0eFNQbldTekpWb2I3VEJT?=
 =?utf-8?B?UlducCtmK3NIVHdRNlViYmFNRE1RMk5xa1poMzB3K25Mck1mR1ZRcEZiK2hI?=
 =?utf-8?B?a2VyOHVqVm4yalYzYkNrdkhzNHJZaGI4N1dKRnpKcU16OWdMVk81MWJVTGkr?=
 =?utf-8?B?VUM1YTlNRVFXWnFuTklUR3BGRFlVM0xMMUNwUWpIRmloWHh0ZUdMTm91aHE3?=
 =?utf-8?B?N0prWGpuQk1NNmtPd01pZVloLzVlVTdDalAyRW5tdEQxb2R1dDdiRjJxMVN6?=
 =?utf-8?B?bk4yT2Zkc1hWZDY5WmcrNFRSK2JybjlXcURreFZneGNuaTlmVUQyZURsYkZG?=
 =?utf-8?B?bWVvQ0d5WE1kVERFSHBWWk5mVFBVNEdqak1JaTQ3WnJWWUtsTEtmbWtmQm56?=
 =?utf-8?B?ZlREM1lMSlU3cVNwb1J3dUNSMHZ5dmpwRXRTQ1czWjJxdlNpS2xRRnFRTW9x?=
 =?utf-8?B?QU5EVUtwZXhMaE8yZkpwZkFtV1poZEM2N2ZqK2szemZLYkFKRzJyaTA0VVFB?=
 =?utf-8?B?dW9kSldXN0JJeVR0MEhMTzBLOVBHVU14RW8yNStKTlBhRHFWc2J1ckFvTjh0?=
 =?utf-8?B?b0I2RVljcHJVb2xtS0I5UWp3MlI5NmVWbmFTdy9pc0MyUk11Z1J4dW13SytS?=
 =?utf-8?B?K1BtcmlMbk5KZWlXM2J0a0hZNE1Ib044M3h6dEMrQnF4QXdSRHppaEdDT3NW?=
 =?utf-8?B?Rlk5T3owUUM4V2NmaVdramE1Y3NZWjlXSk1uemFyOFdHc3IxNzJQem1JcDBw?=
 =?utf-8?B?QTQwZGoxei9JVHVtUXZ1MktXR2xmRXN4TVl2ZHZaVHBpZ3pXOXdjZjN3SFNo?=
 =?utf-8?B?ckxrcnd6UndnUm5yN3BsRDB0dUZkS3I0NndFVExJS1M2dUR0emZHam9NZEdD?=
 =?utf-8?B?RHN4a1RuZ3dtdG40L1RXMkRrT201MmRXWEl3ZjJCOGdGWUgxTCt5M0xyRWgw?=
 =?utf-8?B?M2c0OHEzZjVMVHJzWnByc1lWdHFmTUdPa2dtQktLelgzNTVUUEU4Ujljb2Zt?=
 =?utf-8?B?MU1EVTJMdmNKSng1SFVlZFBodzVzWGRUSWZneTZMOVJLaGJOWmR3clo0NS8r?=
 =?utf-8?B?RUpDYXZNdlBIVC9qaWgxeEhndG91M2RNaTk2cS9EbXErbUdLWGZXK0MyTXIv?=
 =?utf-8?B?WGU0enJKZEZSa3RzOG5QVGlBM1VlWGVsREVmR3JpbVJvRGJzOE56c3lzU1Q3?=
 =?utf-8?B?MGJ5aWo3dUE5RnlpdHNEbHBzcnVBUE1zc2tkSlRrVDFLUmQ0bjloS1N5TGFT?=
 =?utf-8?B?ZVc0dVowbXpSaG01RldiTHc2Q2I4KzdjcUpseDFlMkcxYUZNMGhjSlEzYUZB?=
 =?utf-8?B?T1BpMmdSc01yNkVsWit1emdUZC9ibXVUTjlzb1lIUTE1aEZHYVNPRmdaNDdt?=
 =?utf-8?B?djNRZXlSTlZxdGRGVTBzZjBrQTV2YTFTdFZOVkpXeHdvdUNiN2JFZCtNRHN6?=
 =?utf-8?B?TkZnMVZnK0FwekhZSkZTNC9RcE03aFJJanhmaUQwZGlObWdVK203Tlo5emRr?=
 =?utf-8?B?SWozUk9CL2x2eGdGcHczTU9lZnZQdUlQY3V0bVprYlk2Y1NtNjNhdXZQWWx3?=
 =?utf-8?B?WTl0YWsxbC9nQkJnWXJ5eWJsbUU0T2t6MW9YUEQ2Q3VSNCtYR2krOVdmSXVD?=
 =?utf-8?B?dGl2a0VWeG9hdFdEbDNNc1RhY3pSUU5QVmNXUVhBbVJFaTdjUWFaazltN012?=
 =?utf-8?B?NFFKVmRkdENOdGkvMGRPSEE3eTlQVU5aZ0FBU0RJUHBBWmxYVTQyZ2NhOVR2?=
 =?utf-8?B?NEg5WURDblV0YzNqb2lEa3pXOEdaNmJ1WGI2TUpobjFZNUtac0M1UkNVUzZa?=
 =?utf-8?B?QSs0bHBQbVZIamdnTFdJSzlEcnlETXp6aERpRElybUhDdy9pK3Rxamh0dGdX?=
 =?utf-8?B?Tlo5NUhOaXR3NGV5MUMwenpQWHQ2c0tlSmpOUnRMMG94dThEWFRtVEpXOU45?=
 =?utf-8?B?QWVOMzgzSjNZdjUrZEgyRFVlNmJoK1NxbWdzbXZNZlZXcktCYVZva2l2UG5I?=
 =?utf-8?B?SzVpdnR3NXJBNk9JMjFwQWM3ZzlqRDdMR0dRdHc2NVZrZ0hrWUpyN2F1QU1H?=
 =?utf-8?B?QjlId0szZXpUOU1CaGUxdzVqOElTekkxazZwaGhCYndTVVR4MDFMUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affd04c6-2607-47dc-a5df-08df24a8aa76
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 19:24:54.5493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urp7H0SRCMace+Jn7PLv7LWGs90cIWqbYtXmJOoY4llBZCRIqzqnDhoe/0786x0Gbih0iiGmnMGG1uiK+asD2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411



On 10/7/26 06:27, Linus Walleij wrote:
> On Mon, Oct 5, 2026 at 8:02 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> 
>> Commit ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
>> preserves firmware-programmed S4 wake sources because some PCIe devices
>> rely on them for Wake-on-LAN. The system that motivated that change does
>> not expose ACPI GPIO events through _AEI.
>>
>> On a Chuwi CoreBook Plus, firmware exposes _AEI but also leaves the S4/S5
>> wake bit set for GPIO 24. This causes the machine to power back on
>> immediately after shutdown even though Wake-on-LAN is not enabled.
>>
>> GPIO register dumps show that the only relevant difference is bit 15 on
>> GPIO 24. Clearing that bit makes the machine remain off. GPIO 24 is not
>> itself listed in _AEI, so _AEI is not a per-pin indication of which pins
>> the OS manages; it is a platform level signal of which wake model the
>> firmware follows.
>>
>> Use that signal to decide what to clear. Continue clearing S0i3/S3 bits on
>> every system. Clear S4 bits when firmware exposes _AEI, indicating that the
>> platform hands GPIO events to the OS, but preserve S4 bits when _AEI is
>> absent so that firmware-programmed sources such as PCIe PME that bypass the
>> GPIO IRQ wake API keep working.
>>
>> A platform that exposes _AEI for some pins while routing a wake capable
>> device through a raw GPIO not listed in _AEI would lose that wake source
>> unless firmware re-arms it during the sleep transition. No such system has
>> been reported.
>>
>> Fixes: ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
>> Reported-by: Olzhas Marat <marat.olzhas@gmail.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222041
>> Cc: stable@vger.kernel.org
>> Tested-by: Olzhas Marat <marat.olzhas@gmail.com>
>> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Patch applied for fixes.
> 
> Yours,
> Linus Walleij

Thanks!

Next cycle I'll send out a change to drop the #ifdef CONFIG_ACPI (there 
is a change in linux-next that adds a stub).
