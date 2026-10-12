Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DAF372EC0;
	Mon, 12 Oct 2026 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824964; cv=fail; b=TRHjyMrwei87P1lLYbvYprc4u0ohOyxtE/BYASxVwu6SdROTA7DN90iqX7us7SHTC9dlSR6QwCcShYF3TKRQGENWGIFznIiz0A3RTO3LioZ7XUzwP74v8foigvCYojrYQ+guubMjrTvISvTvb41sHbFdKLpNNCcANMc//OqIKp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824964; c=relaxed/simple;
	bh=RnuBUNqzuZr8KwwWaUrLOdH6lB0ePsNaTH9aynIlass=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jNsLu5Rp1U5qkS0/k52A1O/9RKb11+wOYwhw/v3mX243rcFm8o43z1GvtS3ch8upXgB1AsE89v7Q6A0d7A08rXzMEasUQcjO5wIhoi+jVr92GKqniuExCWKZ9mx1ktDJ+MRwyMc+lxMwYgiv35KTROrAvstL/4o4CqhjDC8Out0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e8HBBF4M; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e8HBBF4M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atM/Lc5Z6CouNdWMLXVbIGgowpaVDwQoBYm8Epv3JElDIH8qVZwPuSAeU0Ex4JKZIxXpQwE+Qx89DdcGz2tiJgJ68AWD7uI5Wz8D4979U7hbvIvsq5Qztpff80ItXeDa/lXhnG38gZXSuxEgYkfwnO9UQIqfChic5tgbHLCyuQMx6fqUOzNO/FOIYibMo2dwQfpdXBBoylM/dgHbmvFe1+qt6WBvmUbeJTVfN2cLzxkej9VYy8Pse0l9k6Wwg5JA1f3c5DWsbAzG2GH7ky8dAxfGmHTDKb5skXk0sMoqz4u4ErZOKSC27s9sob7Fl4IkrbgKyPDCPasfIDEG8ECcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a78GyJlxxsVMzxzYrHbGSQyGFFR7+Vw8kmc/8FmBqFs=;
 b=rEeL7ldhqkyO1SuT+hvUnCqYLsm3UmDgjAf5YObh9wk18l1+r7pnNT9T4dO47lB3O94eGqbGqETbV3NyfVovmgUUGrWUHkD9/hXUMMyv+vnwDZzpJUKrmLxtOcXkAlsvqpRQOU7DTPirHJHMMzQsW/EcfFOUqXYbJpDjVFBlD0rags1QasO/vVEIs3PDP+QMozpikyI9oO7o28YRbOdmwM315M2pRwLh/RqBQc+X31z+MtEwn9QOLxwrMp/EZPYZv95u3gsbMUfIlao0IlaoXFrS/LgMBS9TLRkA6tMaOShwb1/o9yuTT0xPHWtZ4mdJXNWuLQE5TJVhqxp+9Mz6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a78GyJlxxsVMzxzYrHbGSQyGFFR7+Vw8kmc/8FmBqFs=;
 b=e8HBBF4MFmQvf9O4/QCcPA+aLnYsot+N9jEsplRiII54kdBFnND1O2+4fZaxix+z5Ym4YsFS1iI5AvKpasQOvDHRFgW4Fq2LnV88y+0bKvMMlyJsLX94DfrwWqsbcGSBxx59eNvBzqKBLQEqh4THmUltmyIxJ7L02GPtUMW+Dyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by BL1PR12MB5803.namprd12.prod.outlook.com (2603:10b6:208:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 17:09:15 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 17:09:14 +0000
Message-ID: <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com>
Date: Mon, 12 Oct 2026 12:09:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during
 enumeration
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Keng-Yu Lin <keng-yu.lin@hpe.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com,
 s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com,
 zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com, stable@vger.kernel.org
References: <20261012104645.975190-1-keng-yu.lin@hpe.com>
 <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:610:4f::40) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|BL1PR12MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbb265f-642a-4134-775e-08df28838aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|11063799006|4143699003|261009221727099003|261009223027099003|261009223327099003|261009221227099003|261009220027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aAgLSaWoyrVTHDRMAOQASkF2xmMUMTQynEPisY9kBoDBqW+A7mB+b45KK4i797klYbSFnqqbeu+TpoKc/BIwRbGnP/AEDz8y5rHBOfIjKl/FVFkayBzUdVyiu5ZpVcd0sme8fP1h3XmKUAl5yzjgQjQfLMTW4UaiReYqUaHHWCxjjgviaXfrbra5ykvHg0AJCFMWdc8D1qVo44qA63lthzW9B/xd42sRrAKwCxMOMUdMpLbAozDnpV2KTfibdAi6dsr0QQpQv13+5uoWSZbdGbzXRFLut5KzT1WAkBGB1m6xd6Mnhh6tZUpZzISaqvuHQ2d5Z/BVlfiXsyZqoWM4qPdLlWQPdDE3sdS37ZzAAT2WPpzHWCpc674EFkm8UGvmN4MfS+8iP9MueHAYstJEyeUrXkEZqukDtaEaCWqAA7hL/nHx2UvTK+KFGHAR477GbMpIEMc60Wyf773+FFXbiOsRtZrNT6yZtSQm3y6lo/yZhRjIG9fDqdR8bEBTxbvYjsVl2SXmxeqerwIlKhg20Jmr3x+5E4Zq3dTHSvgiNPt0YTKUJtsDcWqf/26YhTeWqJIkyDM9DowumcpKwYX7f1S3HEu3R5MP165ssPY7PkeB5XHRPfHwysyxv5g1sRBw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(261009221727099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009220027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWV2QVpEUDJkcVhYc2txLzd4emZNSG9PTnlnL3lDRis4M3FETVllV1hnVmtY?=
 =?utf-8?B?dnFnTnc2cmJoQ3NvUzdnZUVvQ2cvKzFoNDRybG1DZ1ZFdW1vcVROY25BU1Ir?=
 =?utf-8?B?WkVtdlBkdXlDZXZ5WXlHNG9ZVmh4ek1jYllYcVJkZDBTVithL3c0bEJGL1M0?=
 =?utf-8?B?ZWZXdjFySFFzakk3RWM0eUpuZGw1Wi92anBSMjFXbURtV25aL1VyVVVlRDc3?=
 =?utf-8?B?TUl3TjhmbWVCSmFLNEM3YU9tR2lNNlFMeFhCOXF3SUQyWWR6TGNFTnQvVHBX?=
 =?utf-8?B?TzBtRTJGalR5NGNnL2k5bTdkbTl5OTlieFNZdHlUL0dObGk1SnUzZUJZSXVR?=
 =?utf-8?B?eWplWDE3Qm9wTU1vZ0hnM1VRS2VYN2FWWlQyNnc3KzdLWE0xUDE0YkowVTkr?=
 =?utf-8?B?TlY0bmFRUXh0MWo0SjUzU0NXOXRBQTNhbjVSSnhRVlFxWkxKTERIeFFFVmpU?=
 =?utf-8?B?OVV5MVNVM2pQSTZ2TFNVMTVkenZmdTZraklhN0x5QVlmY3hDRXU3ekdhTHpl?=
 =?utf-8?B?S1BrWWdqdzRZN0VsNEgzWFVOQVFzcFExQjJVZjhpZ3A1VEZSZllncHdNckw5?=
 =?utf-8?B?SXJ2RFlDQkxxUlEvYzB1YnY1bmw1YjgxdEQ4b0NvWkRodjQvb0JqaWRSSGhQ?=
 =?utf-8?B?WFplWVlUUFFLcllSa3U1NjA1eTNMUDBHVmc3Qi96SmlCM2tQazRJaWpIL1hB?=
 =?utf-8?B?NWV1eEtCK1Rkc3J0eHhmbzJ5ektueDAxc1BBbHBhSlIzZ3RKaEFXbm5WWkVx?=
 =?utf-8?B?T0tsenlLMUF4NkhOYzFpOGR5V2IxVUxnUDJQbHZnSGhBQUd6TnRhQnladXVQ?=
 =?utf-8?B?YTVRUEpHOUFUMURqNVZKUkgvL0lHUW1ra2lwaTBEa1FZNERScEs3OGxQUms2?=
 =?utf-8?B?d2VmT09yWTJWcmtVdnVOajFJWnVGUnIwUTdoUjFCQkhPYlV4am04NEdZcGFq?=
 =?utf-8?B?WC9TYUg4bjlvWlNxNnFEeDZTemVvUVlJU29aclkybko4YzFMdzlDcHlua2Mz?=
 =?utf-8?B?RWdKQVV1TVplZEJmbVhSbEgvalpsZFFFQTBKUnhnUEVyWHdjNTRFd2VQbytF?=
 =?utf-8?B?WUowMmw5eW9oWWRFSGxTQ3Q5cTIzY0toZVc1blIvT28zK1ZKY3ZSL3dUUWRF?=
 =?utf-8?B?aTRESi9lejdRSjh3dWNQejBmeHJVREVHbldVdm5zTUxjc3ZjRTZxYllhRWxn?=
 =?utf-8?B?N213bWtxR3NqODlLWnIyR3ZEYzZBODU5U2IveGVIWnBtYlpueldOUVdzYnpy?=
 =?utf-8?B?eTlnUnRTaHU3MEI3VGg3NmZoeEVPWGQzd2NPdjM5RTYyeVl4R2trZTNyS0NB?=
 =?utf-8?B?ajVnQzRMVEYvblR0NC9yVGp1S3J6WGhXQWZaaTg2dUlzUUk1bml0OUtVQ3Zw?=
 =?utf-8?B?TDVnWW91T3Bma09CejlMNjRFeXJLNXl6RDFja0dtVkRrYnl0K2p5dW5FMVc4?=
 =?utf-8?B?YTdKMkRsWmxXV3NRTkdxNFFETkJZQ29KQVJDUHdkc2RxeVo4ZmhMQldxUlJs?=
 =?utf-8?B?V3NMbWFPbC9ZS2gvTHNjUkdhZWVBSVEyWnpCRFUzaTM3MVBobkxNbGtKb2NS?=
 =?utf-8?B?MWMvM2J1WjlzZlhmekFoVDBnZ2JIb29keWNyVkQvVllKSEV5Mm1ueVFMK1Fo?=
 =?utf-8?B?OCtldmc2b3hMRmxWMmJNbDFybDJka3lLbS9xRHhWWjI0MzdxRk84UWd2eFVr?=
 =?utf-8?B?MUlPR1c2ZTVvRnAzbzRtR0tIS090Qk1xZnp4TkNkTEE3T2lxWnpHRGhiZ2RR?=
 =?utf-8?B?QmdXcGc0RVp3SWRRTkFMT3FPK1E2U1F6cGZjVE9SVlJyZWMxdnBqSm9Yd0Nz?=
 =?utf-8?B?ZG1vd2ZpcUNWM1lwMWREM3VHNXpNL3hWa0J1ZTNWVEgyQ2w5RXpIblZrbHVr?=
 =?utf-8?B?Nk5Tc1dNK0lVS0lJdzNDOU9iRGZNVG1PMkxnV0NlT3dZMDR0djhRTnkxYkZQ?=
 =?utf-8?B?WUFsVHl3UldXL3hFTVlxRTBGWmxDNnp6TmpvNlR1S0hpdEpVRTFaTlQ2VkRy?=
 =?utf-8?B?bnYwN09mS25pOVJDcWtGV2kwcHI0Zm8wTjNmM2REQzRDSkVSVGd4WDlZcEVK?=
 =?utf-8?B?K0RpWHlBMXJzWDdpMFYyM1hnc3BWU1RjVWYzcWFabmdrbEJyOEx6UlNEV0pD?=
 =?utf-8?B?M2VhWmJ4SFovZmtWTzErVVJlRXUrQmV4c0J5UXl4UmttaHE3ditqWXRDRmov?=
 =?utf-8?B?YU1SZzNJaWUwZFgyS0FhbjVWYlQvTVFoVVdHVFVVV3puRFNOaFdrZU10d3Vw?=
 =?utf-8?B?bHpmeWRYdlNtdHhBNFYrRTIydnNxL2N4eENNdmo1UlA0aXJRMUdleVRJTlEz?=
 =?utf-8?Q?SUNwKhxZP54HfvIpVh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbb265f-642a-4134-775e-08df28838aed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:09:14.8576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJnU5J98JIpSqdOwR0v1LODGEag+JPzSSSr+4nxrZOE4sKTce6GuO0aKnZ+H3MrLWBlOjz9Wyhi8OvqLfSyGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5803



On 10/12/26 06:34, Rafael J. Wysocki (Intel) wrote:
> On Mon, Oct 12, 2026 at 12:47 PM Keng-Yu Lin <keng-yu.lin@hpe.com> wrote:
>>
>> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
>> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
>> The helper ignores pci_power_up()'s return value indicating that BARs
>> need restoring.  Its resume callers restore saved configuration
>> afterwards; pci_pm_init() does not.
>>
>> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
>> After enumeration powers it up, pci_enable_device() reads D0 and skips
>> the full power-up path.  Previously, a device still in D3hot at enable
>> time took that path, including BAR restoration.
>>
>> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
>> D3hot with No_Soft_Reset clear before kdump.  Diagnostic reads on
>> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
>>
>>                                     PMCSR      BAR0
>>    before the platform power call   0003       f4100004
>>    after the platform power call    0003       f4100004
>>    after native D0 power-up         0000       00000004
>>
>> The upper BAR DWORD stays zero.  pci_power_up() returns 1, but the BAR
>> address remains zero while dev->resource[0] still contains 0xf4100000.
>> Without BAR restoration, the last console messages are around:
>>
>>    pci 0000:01:00.4: enabling device (0000 -> 0002)
>>
>> Restoring both controllers' BARs gives matching readbacks and allows
>> kdump to save a vmcore and reboot.  An AMD Turin xHCI [1022:1557] shows
>> the same BAR loss; restoring its BAR also allows kdump to complete.
>>
>> Use pci_set_full_power_state() in pci_pm_init() to power up the device
>> and restore its BARs when needed.  It already checks the native power
>> state before restoring and updates ASPM when link state is present.
>> Leave pci_pm_power_up_and_verify_state() unchanged for the resume
>> callers, which restore saved configuration afterwards.
>>
>> Read the initial power state first, as pci_enable_device_flags() does.
> 
> Is this really necessary or even useful before pci_set_full_power_state()?
> 
> pci_power_up() updates dev->current_state regardless of its previous
> value AFAICS.
> 

To add to this comment; I would expect that if it's an ACPI device that 
it is currently in ACPI_STATE_UNKNOWN at the time this function is 
called.  So it should be a no-op for those devices.

I'd say you can just update current state since you're forcing it to D0.

>> Otherwise, PCI_UNKNOWN can request a BAR restore even for devices
>> already in D0.  Keep the final pci_update_current_state() call so the
>> final cached state still accounts for platform power and failed config
>> reads.
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>
>> ---
>>
>> Changes in v2:
>> - Use pci_set_full_power_state() in pci_pm_init(), following Mario's
>>    suggestion to reuse the existing BAR restore code.
>> - Leave the shared resume helper and its interface unchanged.
>> - Keep the initial state readback and the final platform-aware refresh.
>>
>> Unlike v1, BAR restoration uses the full helper's native PMCSR check.
>> It also updates ASPM when link state exists.
>>
>> Tested v2 with kdump on both systems.  Normal boots made no BAR writes
>> from this path.  The crash kernels wrote only the cleared xHCI BARs:
>> two on Venice SP7 and one on Turin.  All readbacks matched.  kdump saved
>> 2.53 GB and 1.10 GB vmcores respectively before rebooting.
>>
>> v1: https://lore.kernel.org/r/20261008133708.947908-1-keng-yu.lin@hpe.com/
>> Review: https://lore.kernel.org/r/04f5463b-f123-4079-9286-06a241976d3a@amd.com/
>>
>>   drivers/pci/pci.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8cc6a89130b5..d3a5871e1b36 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3255,7 +3255,9 @@ void pci_pm_init(struct pci_dev *dev)
>>          }
>>
>>   poweron:
>> -       pci_pm_power_up_and_verify_state(dev);
>> +       pci_update_current_state(dev, dev->current_state);
>> +       pci_set_full_power_state(dev, false);
>> +       pci_update_current_state(dev, PCI_D0);
>>          pm_runtime_forbid(&dev->dev);
>>
>>          /*
>>
>> base-commit: 7b63ef2d55f24519e7e9e5f4d15dbea03f126e40
>> --
>> 2.43.0

