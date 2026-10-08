Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443AF3A6B6D;
	Thu,  8 Oct 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476995; cv=fail; b=arYX+Kna6nolLqgp5+7DnnHTXGpDxE59eJqDqVQQhtO1alvfrdvDy0epGga9FQrBsaCeHri7hJXvAAppaDvmUmpWkm6etEXqLMrogI0Ztq31MzCgAKYZkraMO0bstQImQukyRXz2Fa8cx3I0PYXHow0JwgbiT1LN1gezzkJjBmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476995; c=relaxed/simple;
	bh=6hV0UlUdVthlRNzLC891sMt4P9QFcmw1OAHNB5Gkulw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbCh1fohSkwvsxScaqgsZLMPVj7dyv+fz2SsJgGI4k74FK3cKmxGQL3WtMG0D8ONf4k/OGzeskmRPIiIC4h1Pdp9gWrMSiPbe6DjFz+NzruE32/GULy0chliL/mrJXEqsD1cIXOva++1q17CIvj2uZLI021BrNdA3KwFPnCX/aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTTyvifd; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTTyvifd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp4p4/4C7vjXcunfEL8MQ0nkf/wvfrnS1cCbmWwgNtKiu/TyjXoACpxjyFrWzFDPMpiEO3AHbWBUy2U9Tgy2sd9+x9jYcUitRZxjQqDtHpUu5FK5mpDCDzTMgBI+nhLCuDXSl3EnQmdHvwZ900vs9Qs6VKrmfPA642Vspk1I2ibRsPHFJ7VbD7RPHa59R+Sr6vEhGfi6Ntkuwj8Mv8QD5aJKxM3pjm2Wor+ak0RHTQVmMZX0UtTa7nPC7C8Zs3AWHF0VOt5WwtEWNOtyEkqAo1R6RlJprovZF5w88xFdoT1By2yu8HN/nRzoEeUbPhxmkuXmYvp5iixdJlNS1YRn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y5L0JVBoDI6WhfE39Df6t/UsfJUcvE9U6Uz5B4PYm8=;
 b=JxMKaSHyP9pUPJIjQa5jeHZAE5UAw3s1iQ+YEDW5DRvT42UUoFR6TQcO/y5gVYE5KuLYUXNP3NIRDNsJsQX/3BdTHu4iFqdGPlTsAHoo1HOEgQvB7b1kCxBxf8ukaf3Mdn595+SR6IXWvOCBpJfiN4LLfItzqFHCfqrueuUwDE7OLDfjLE/grSvKn6mRMrBVRiRDFbMYt+dN7gK4MkpfgUArCg7Q4wToGZqVcOO/BHSadC7ucjx7G0X9U5iThpZCD2wj0tVjBoH4WOHGoc7eZQKPPnX7MeAHFmL8WAp2Gc5UdHca+iJRSAX354TP7R19NjWX5gPYk6+Cc9U9Adm4Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y5L0JVBoDI6WhfE39Df6t/UsfJUcvE9U6Uz5B4PYm8=;
 b=TTTyvifdbvTjEr+mmntDz0kVTBdez0Px5PYpjhQrWmJK7rTIvU5aKP/3BxJ3pzIyPi9QQlz+0F7cDi4TdbmIHc4CrPIMtjbmgBS0rEROxxW6m4Z8Ch4qayA3DJEZgYBfYx10R1ycB0ZXfxpKfjEXSTMOeQ6Pm8IiazJTvnnGCno=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 8 Oct
 2026 16:29:51 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 16:29:51 +0000
Message-ID: <04f5463b-f123-4079-9286-06a241976d3a@amd.com>
Date: Thu, 8 Oct 2026 11:29:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Restore BARs after powering up during enumeration
To: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com,
 s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
 zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, stable@vger.kernel.org
References: <20261008133708.947908-1-keng-yu.lin@hpe.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261008133708.947908-1-keng-yu.lin@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:5:333::23) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6620c0fd-f05e-471b-84e7-08df2559604f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KaE4JqaslkAQM1JJ16Rmx/YdtecQYBYAleUx6i1K1GipQiBfVsyyMD6vagDLYqX/aJJ2S2sVPwrV5qirntRiB/QIiSlOei0v6RWDCGr3uMcuJLwwJeVr21b8QMzeb9KHrZJ6aIguaOtk1w49GxRNKfY8kRTgkikL3NjAAn7nT8yKiOP9nvOWFRJXWwa+IcS/ze+Fw7DTwGCP8BFfMmzldFx7J7LIY4upUQP1k6oFX2OKdEvN0QwPU9wyp07EHnlh/6g1rnXzFSIe7SXjXKeSuW9jXlWzhB8CVaWkgwhaWpGel1u0kdaQPNzgFVHTvuY1Zqh8mgk47WX3XUKzCFM/jkl7Co98ShZlu8BMO7i7+dB16rmJNpAGacaV6iq2W5DQIhGwCMIrksT0Cys5K39kjEeuDG6bN1guo5zyOkcLqKCV8WgiYzfp1U4bi6XOLb0sUup1CpiyMKI0T7Iva8zc2Euhh2MW3dtXLQxougYoax2aR2U14wcSrkE2R49nd4TM3Mjt1miLRgXqcfUNWDcsE5Zeyb0oFzZT+GgXT8cIRY8LERaXjWDNsLeN/LKc+avmvFSS1c9CBKL6bvtwEOTLc56j70mhmntHqZ2kfc3dEUqfNcAbm4ngxsqo0+sllFg3TKZUYem3+v+zlpqaJ+j0Io1Mb9Ky1WZjljkHv4mLajM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHNKbkQwdEYyRkZrdG5Td3Q1Qld0TUJMbDQ1QlJUMXlydGM1UldFMWRWdGs2?=
 =?utf-8?B?WG9ITFpJbEpXLzVGaFkxcmdBYWl6VFV5eUE1T1dnd2dxWjNmaVpESnk0bHFs?=
 =?utf-8?B?c3F1YzdhWnZLUkhGMDJEN1lqUnozOHNQS2VCMXhvSHBrUldwZzdQcUFVZ1hP?=
 =?utf-8?B?bW1zVnVyOTVNWnJ5MjJDU1FJRmJqaUhEdzFWSUNJcDJtdkpxZnhtRjZZclMz?=
 =?utf-8?B?a0ZzOVdwTGk1MUNZYnltbm9OUEFlNlJSYVVxT3hDV0lBUWJXblBBejJBUmdF?=
 =?utf-8?B?ZEwreVVPdEVqdWNaSUJUbi9yZWdIR1pNYTZ3VWJGdVV0VmZiMjdjMTBWdWZ0?=
 =?utf-8?B?ekVBeUdzdEdWRWxEN0JUK0xteGhhMTVMU1hEWHY5ZTVsek9ZeXBRWis1anJV?=
 =?utf-8?B?RkhjNVhEODlDTWNLZk54ZzFDS2hxeWpLSW43NU5zUFI0czl2NEZjSm5FK1gw?=
 =?utf-8?B?M0ZiVzJCdnhrRkdGMFVqUFZHUFF5aXFETkR5QzRsSFUyRTVhY1RQMHdMbFNU?=
 =?utf-8?B?WEw3aDgxa0pPZUNsRk9yWW9EekkrcjNYeTFIUy9ob2xPb2FRY3d0cjVYS3Jq?=
 =?utf-8?B?d0ZlY0Vnc1M5YmpGTGtvWUNTTk9IbCtlMVZ4QnZnV2V1OGR4WnMvSURyT0dx?=
 =?utf-8?B?ZEJmNVYyUm9HNnlxc1RBSkVtWUs0YVZEUkQ4S3ZScTdVZHpLNDlUS0tSTWJC?=
 =?utf-8?B?UmcxZ0QrZzhMaVQySThvWWpiQSs0NDVENiszeE1laHQreS9qaW02NzlaZmxs?=
 =?utf-8?B?SkxHTG5rOGRMdnM4SDZxeUpVdERvd084cFRtTGpOVDZDQnJiTzY2RDdzNXBn?=
 =?utf-8?B?Yk9ocHlMQm9VQjJ5RmhMNWZYTE9pd2F6aGFxZWxYZzFuSkpmNVRWQ1NzQVdh?=
 =?utf-8?B?OVNZNUFwWGVtTjZtYXpqRXppeUxpN05Uei9McDl5TnNnWTByV3g0bG5sZSsx?=
 =?utf-8?B?L2ROM0xYUjR3aEdLMkRzMTFpWmpXTDNFRnJrV1UwdU5uOElFYmREcnlGaWdv?=
 =?utf-8?B?aVN0VEJseExSMXRsUFg4dWpoNWJzVWxMK1pjcSt5Mm5ERmZSaU56bDdWQUFS?=
 =?utf-8?B?NHc4c1NyQ25BQVZmUHhuRGVuejVZQ3VXcGF6cElRdnlDWkd3dTZRL1dlUFBr?=
 =?utf-8?B?dTJkZXM0TGNTSjZHNEhZS0U2SENpOGpsZ2c5VjhsMUtDQ3R5bk00OXJGZHhm?=
 =?utf-8?B?dXFjd00yT2hzeEZQcXZDTlJaZlVjN0F3NGV4VTRTUnlYdTBYSEtXR2VSTTdK?=
 =?utf-8?B?WUEzSlVFQXdZL3d5MldpMVFZTzlHQlZTWVdFQkd4SDc1WktYdnhFU3JVSVV5?=
 =?utf-8?B?RjU0TWtGOE13amRZYVhVODdCTGpnelBmUUF0TlI5Q003ckx0Vm5BNysvYUVX?=
 =?utf-8?B?VHVoZzFZYXhYKzhnTW1jRW12Nkh6bFlJb1crL3p5VExNSVpXOWNYL09BSnZv?=
 =?utf-8?B?UUtFeldEbytXdjg5b2R0anFjSWpqMm9nK3VMS3dMSk9JeGc5WGR4WFBHbGV6?=
 =?utf-8?B?Q1Q0ZDI1S2hKQWhEMGM4L2FxSDJUd3F4VkI3UjBPQXlDVlIzeU85TmlVdmdE?=
 =?utf-8?B?d29ybFAzRGhESVErWmVWNjFISnJ0cjB0ZC9Rckc5QW1mMXJGdHdHWnRDVFhX?=
 =?utf-8?B?SjlVRHIramZsZHUza3N2ZnV2dXd1ZEp4akhzVkdIQ1Z4b3loN1g0SWVoUncr?=
 =?utf-8?B?MC9ZNDFNUjJLWmh2TUl0Mit3NGRCSVFRQnJSMDhrV3lka1J5SFNZR1ovbjg0?=
 =?utf-8?B?ZFRMOVEvamhYNWxsOTZkTDBuVVZCaUNINm5SZEtUZGV4b1lKeVBUclBRbm1E?=
 =?utf-8?B?aUszUGQ2UGVWM2J2bmMvVHczNCtyNWhHZ2l3MjhJTy9LQUtlUXp2bFNSNVFx?=
 =?utf-8?B?MDQ2N2s4Q3ZIeTN2OGV4bWJ5UXhoV0xsZG0rRkpwaE1QdFFvWmxBU1ljUS8y?=
 =?utf-8?B?Vm9HTXdzUUVWQVRJREhYcjEyQkF3a1d4VVZNVFJ6TjYvU3ZKRVdVWTVFQXhZ?=
 =?utf-8?B?U2JELzZpVm9nbVk3WWVXaHB1V01ndWtLTEYwSjB2MTVLZVRNcWF0VFZodzNZ?=
 =?utf-8?B?Tmx5NnNVR2V5V1huRExTbmdvRlp1SXZ0SHp1SUZ6YVk1M2tIZVF3UnBDK2Jo?=
 =?utf-8?B?YkNGUld1UGtjY3pBU0JwNFY0RVVKZnZFdGFVeTU1d2N1MUZLcHhUQTlrcld2?=
 =?utf-8?B?SWNFdTd1QXp1QXZpcnozVkYwcVJWNUEvSjVoQ1NhYXRMcXRWZzZpdkhpNzJk?=
 =?utf-8?B?cWx5L3phQlhxTEFId0ZtS0ZsRDByNUtpdjFNM2xSUGJxYmJPZFBaYlZWNk5q?=
 =?utf-8?Q?nIyEoQ5em3/TXw6I4i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6620c0fd-f05e-471b-84e7-08df2559604f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:29:51.0200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivSo3n9XxXIzpBQ6SJwMDqXEgWm2tMv4PcKRy2FbA+ZSpB5CWWm62DhW0+dTY1DEXBGMJ2oz/GrwKt8BmXDGmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480



On 10/8/26 08:37, Keng-Yu Lin wrote:
> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
> The helper ignores pci_power_up()'s return value indicating that BARs
> need restoring.  Its resume callers restore saved configuration
> afterwards; pci_pm_init() does not.
> 
> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
> After enumeration powers it up, pci_enable_device() reads D0 and skips
> the full power-up path.  Previously, a device still in D3hot at enable
> time took that path, including BAR restoration.
> 
> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> D3hot with No_Soft_Reset clear before kdump.  Diagnostic reads on
> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
> 
>                                     PMCSR      BAR0
>    before the platform power call   0003       f4100004
>    after the platform power call    0003       f4100004
>    after native D0 power-up         0000       00000004
> 
> The upper BAR DWORD stays zero.  pci_power_up() returns 1, but the BAR
> address remains zero while dev->resource[0] still contains 0xf4100000.
> Without this patch, the last console messages are around:
> 
>    pci 0000:01:00.4: enabling device (0000 -> 0002)
> 
> With this patch, BAR0 is written back to 0xf4100004 and reads back
> correctly.  The second controller's BAR is restored in the same way.
> Both controllers initialize, kdump saves a vmcore and the machine
> reboots.
> 
> The same happens on an AMD Turin server with a different xHCI
> [1022:1557]: the crash kernel reads the controller back in D3hot, the
> D0 transition clears BAR0 and the restore rewrites it with a matching
> readback.  kdump succeeds there as well.  On both systems, a normal
> boot performs no BAR writes from this path; the only crash-kernel
> writes are the cleared xHCI BARs.
> 
> Pass the restore-needed result to pci_pm_init() and restore the BARs
> after confirming D0.  Read the power state back before powering up, as
> pci_enable_device_flags() does at enable time: the state is still
> PCI_UNKNOWN here, which pci_power_up() treats as a possible D3hot entry,
> so devices the firmware left in D0 would be rewritten too.  With the
> readback, only devices actually found in D3hot or D3cold are restored.
> Leave the existing power-up and platform calls in place.
> 
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
> ---
>   drivers/pci/pci.c | 14 +++++++++++---
>   drivers/pci/pci.h |  2 +-
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8cc6a89130b5..f34e4d259151 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3181,10 +3181,13 @@ void pci_d3cold_disable(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>   
> -void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> +/* Return 1 if the BARs have to be restored, 0 or a negative errno otherwise */
> +int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
>   {
> -	pci_power_up(pci_dev);
> +	int ret = pci_power_up(pci_dev);
> +
>   	pci_update_current_state(pci_dev, PCI_D0);
> +	return ret;
>   }
>   
>   /**
> @@ -3255,7 +3258,12 @@ void pci_pm_init(struct pci_dev *dev)
>   	}
>   
>   poweron:
> -	pci_pm_power_up_and_verify_state(dev);
> +	/* The restore decision in pci_power_up() needs the actual state. */
> +	pci_update_current_state(dev, dev->current_state);
> +	/* Enumeration has no saved config space to restore afterwards. */
> +	if (pci_pm_power_up_and_verify_state(dev) > 0 &&
> +	    dev->current_state == PCI_D0)
> +		pci_restore_bars(dev);
>   	pm_runtime_forbid(&dev->dev);
>   
>   	/*
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..96af0f1d081c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -277,7 +277,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
>   void pci_dev_complete_resume(struct pci_dev *pci_dev);
>   void pci_config_pm_runtime_get(struct pci_dev *dev);
>   void pci_config_pm_runtime_put(struct pci_dev *dev);
> -void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
> +int pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>   void pci_pm_init(struct pci_dev *dev);
>   void pci_ea_init(struct pci_dev *dev);
>   bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub);
> 
> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40

Would it make more sense for pci_pm_power_up_and_verify_state() to call 
pci_set_full_power_state() instead of pci_power_up()?

I think that would help the situation without changing semantics for the 
contract on pci_pm_power_up_and_verify_state() based on what you've 
identified.

I think it could just be a one line diff then to 
pci_pm_power_up_and_verify_state().

