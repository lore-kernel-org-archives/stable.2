Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8358E4F391D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892219; cv=fail; b=T2A/qcvLxWQwMm8Zmmgu6OssifFT3r64O+vA0B6xHfXhSf58cswqraWmb4JuA3slNt+OpJa9EXfp6iByi3z746uFfT8F+ZE+HH5d2LvriDyB86WEevFCFuauB2Vdps530+tQL7N/CIVE6Ea2RWlN6bd/4w6jljFc32v62p4WYYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892219; c=relaxed/simple;
	bh=WhWJfqZP1rCWCNq9u/2TV6IQp7pFqWbVUkH7MactqpE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pFsR23REearr4eUolYRnUWmkunZiLSCDwKZyjXnSny46otdoAiKeFXs9keq9MI08usR6p1iN5ulI1vUyels80Tj8Dw/qwAxF29SB1eVxWhroLfuyzwiYePufR3nrwIPH2AKrPK/OoXRZ7p81rY7b9FjcMmrLQRau/LrWw3hUwQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOV2En00; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOV2En00"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9W+CRCq/PEFt99xeGu4PsHVwYNLoEJ79DXPTIp7CF2nyHpQRJ85eiwcpsCY4IfkeGDd6Dk7MqucHUBXVzbJOyEvSs1iamEtEqRxtv85HUVYqQ355V3SYm4ZuP0f9FFyHit0iYHC53Hq/ZXkQy3ZK9+6lNna4lSDMIXKSdVuyWVRSHwReJ2T1lCXgtHs2H+AFIrtVL0dyJ21qFElRbVI7V+iBFWCRIxWJsH8hiwcoDw97+YPS4g6mruQ6ro+NeMJEbg+oBWWMmhWXLktM1Mbm54n5Z1EKPKQSOoI0vTGIS8Piy3OhjLgQSxj8szQSECWhZcOTCYo7xGhtJkYCHLFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+r0M8bBMNt4EqtRhPKqfSbz1kbTEYM5l/rmm5izcC4=;
 b=urKuUkuCUAFVVVZRvDNOKW7zviBnqE9QUC4WAVNwRUkXtqq6eRl3eYdDh5i3fdFLMoGWxMucTG4wIZdaxSWwSKwtn2Lw54J095ko9fkT8U9L8ib2JHvXo5idUFRGrpJY2CwWB3QsNxxmFhLKTYrmglU5lyQLbDgz1rZLZqDh155bFBDnozruxmX/b/jo0LSjRvSQKR1239NP0D14wiL8faTjSV9nwGlYZgPPeFZZbar5L7Di9h06wKKwIUEVFWgvRGM9zUAnMWYZJ1wk+sN9iXeuSQtfG58U1cH6opGSzlpcW0Q+AjtfiWZo1tJoOjU+uuU56gZqoZIdHR3wdjDLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+r0M8bBMNt4EqtRhPKqfSbz1kbTEYM5l/rmm5izcC4=;
 b=AOV2En00YwsKRa3MiByqFNfu8CJi5oHwa4IXFZxNlWIxyVduPytogGFqfqjkpuHVgC3MhnFjNk+g3Owsxk8DUdjmq8vDEfGItYnuslDew0hVvHYtd01S+//vtb9ewsWZEND7+lTsVJOGHNR/94Ee1EE0Gp08jgsE0U0aieDEGS4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by FT1PR12MB748946.namprd12.prod.outlook.com (2603:10b6:170:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:50:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 11:50:16 +0000
Message-ID: <9facad8e-6866-493e-99d4-71a491efb630@amd.com>
Date: Tue, 13 Oct 2026 13:50:12 +0200
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
 <2fcd10d5-c1f9-47be-9a68-422f9bbd6837@amd.com>
 <eaa812b3-d576-4d63-a9cb-c7c0ec24f19f@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <eaa812b3-d576-4d63-a9cb-c7c0ec24f19f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|FT1PR12MB748946:EE_
X-MS-Office365-Filtering-Correlation-Id: d06e6d0e-6bf1-4761-0fa2-08df292025ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oxQkW7G5Gh7mRWnG8Mn62mqxyWqrK6A25p5Kz6iiBJP0RldX9hc3LDOUOZhJJ0sp6nhRh2XkCkgFWioqqHiM/vZplzJb3piw0Y4LJiE7a38BgCGg9+Ecowkwc6S3XMTLI1m78LLYn41dwmIMAHKL/t9nwceKTzNVuZRGwqT2C2Bc824l5qQW13hJITJd8TAmGQDxoQzCjf+azpqjFIT6cGu0VLRWIzvKX+9iLbqLsFdUnzNBJ04or27+ldgEzPD84hp/m/UVjJhRUlOMZcF/GbwIznRRcX9Y02uYTBN3WCBfbUwn6IesbW+ydW7C/DIUVrjfHVaF346Lac6wpzrZextgexXnf6BtEvgtwqqC5EapJWAtqlHWy4UJYCIYqoaLbuMK42YmrG1tt71ifk4lxqrd/R06UMjal5pfVQMbe3cQzhUpohYHCCgv3ih+eEH4D6ou7Fs2aelljzOAztME2hrdRq/FuhIaY7mc1Ui1GObtPwnKQa8QFMpwX5JtGoTrP9fKoTPWfSK+oQcLHb6DwTbIwKbMu6RweOdoW7jlFVU//kAr/tG9ar0ByimbFk19eVCE3YNVNxTLuhh78Ci2Wx44TgonBHa9qSQ1wUgwPm4xxbHEwEzzaqLvTWO7tbAU5x+LBWpAPOUMa8YcuqTtFlbJ2Tf86e7NwfQjMmNEO5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtnN1RjTWw1ZG9MTUdQejM4WFVwait5L1BVMUlBUUk5aDk2bUFITUhsRjNK?=
 =?utf-8?B?K1lKNFA1TWJFeGF6U0hFeWF6N1hPL3BKK05oQm9JbHBVdXNCU2FBaVRMN0I1?=
 =?utf-8?B?WE1UNEtHQzdjY3hOYmxWU0V4Rjl0d0RERXF5bHNyZHVKdHZCU3dWNllUWnhS?=
 =?utf-8?B?YktiOEZnTUlPempiM3JscDQrTVRoQjFMRDMwZG1hL3ZNQXhES2Y3YXdqSTk3?=
 =?utf-8?B?QVM1U3RqVFlUd2d4ZGwrdmVFMm5uRy95a3V6ekx2Rk1JY1Fsb1dHQUlic29B?=
 =?utf-8?B?NmsrWDQzR0JvYlFzMnFGUkVTZ0VucVZpYWVFczhWSjJES1dPMkUrd21GZ3JE?=
 =?utf-8?B?OE9MWVNtbmtBL2ZjeFZPZlNmWW5rMGo5NmE1bXloMk5mcnFZbnNFR1pSYldv?=
 =?utf-8?B?Y0F1SWd0dVVUUzBSbUxmWmRtM3ZmVzg5SVoweGh1ZGVMOWNaSlB1WGFFQkVX?=
 =?utf-8?B?WnIvSjB0OWhRUDBDZ0prSmtGeGpGN1BDYWFqcFlhUmdLR0NoYkFaVGZZZ1dn?=
 =?utf-8?B?NzRhNnZDUFhnOFVLMURiQ21VUU8vUkNWOFgxcjRVREl2bmM1MHdqKzNiL3hY?=
 =?utf-8?B?MnRBN3l4dmtSc2pXTWliUERCdVRzRVg3RW0wY2szSVhFSHpxTFZ6Y3BES3pX?=
 =?utf-8?B?WVZEVitXZzNuUUVWV3BWT0JNbG81cnViOGR5U3FnQm1ucVk4bmdaNFdFQ2pW?=
 =?utf-8?B?MHF0VUtvb2lOZ1QvSGZHY2FkNjNiWG5Lem9kYjF1K3N6K3FQclNhZFNBWmJz?=
 =?utf-8?B?WTc4aXN4NUYxN3NYYU1NTlhidHpQS29qT01hbzdrcnZhNWg1UmdLbWRjMXF1?=
 =?utf-8?B?T0c3azVLdGRjSUNZanZWUzFadUcwUHBjT0xUQ3lpY0Mra2dZL0VyZDdhcDJ6?=
 =?utf-8?B?RjVkVFNVZVA4UEd1V25GUEhiYnBqRHlyYmszSG5leDM2NUxya1RxeU9PcGNs?=
 =?utf-8?B?RkJkMFRpWlYwc1B1d3Vkc2E0dG9wZjRydkFvd3pJY1lIbjhxMHdkV3RvMGQ3?=
 =?utf-8?B?eGk4eitDcDVIU0dNZUJ1WGV4TkxxMDV0VGl2T1NDaDlEZW4rRFFUa1BadGlZ?=
 =?utf-8?B?NDN4a0lvbGZxRS9YclgybTZsUjJQM09VZ3ZLSEZNb2FteGF1RXRnbk1tSHFT?=
 =?utf-8?B?d2NBbW5rSU5OdmhqazRpWmVSVVNhb1lIUDdkVmhCRytsZUd2QzZpdTUyTXdm?=
 =?utf-8?B?eUFrdVUvU1lPYjJtUW92eFlFcEMweS9GWHhWb3RITHlGZGozdU9LKzdrbkxa?=
 =?utf-8?B?WVVOVmtpT3Zqa080dDNTbTdzaldRV3BtN2JZdTFHZ1ozQWJaVlBTQW5jUC9C?=
 =?utf-8?B?cWk3TUhVd1VsWUw0WDB3R3pucGtiK0NSZG1IYlFjc3d5NHNMUWNUWStGYkF2?=
 =?utf-8?B?LzdBQmMwUk14YlBDbEFZTWYrQ0MvbnQvUUJmNTVHVEJNR2ZQUVFXUkFDWXdq?=
 =?utf-8?B?ZkZoellQOEZ5Y2c0bVBueG5rUDNEaVk3anFMSVdVc2Vqbms1UjMyeXNRS3NC?=
 =?utf-8?B?SGdlWTk0VXpjcStqV2xmMHB4aDJ6UkJ1YnFxRGhkaUZGWWg3U2pzUXk2RVVm?=
 =?utf-8?B?VHR5dTVyb1lzUWRBMUZBT2JNU3VFQUdwY2xoK2IwdExmdDhFRTUzZE1RelJr?=
 =?utf-8?B?Nks4cGxVM0dnK1p0RzcvZE9DUGpkZjNMM3dLdnlZQi9Ic3U2NE9sTXhRR2F1?=
 =?utf-8?B?QTZBd01xNyszeG9vWkd1Ym9TbnZBOGlWQVdoRWEyR2lUOGFXbXVTelMrOEJl?=
 =?utf-8?B?dFpCMFI0M2xrQzc3V1c3ZU5LRFpvajlaWkZxdis2TUNJY2x5aWgyNnRwQTFF?=
 =?utf-8?B?QjhXd0lzTlhkV3MwR28xQXE1YmdTVnVrRGE5d0NsdGwvU2dYc0FMQWorb1ox?=
 =?utf-8?B?NER3MWdIVFZzSUplYjhVNE9NRVphL2JTZ1ZKK21JK1ZvUzV1VDNTSGZkUDNV?=
 =?utf-8?B?YjB4VzN2ajl1SjJ2WlNSVTZNYnBTT1Q5UDdTYUNSTzNjT3g1Zkc5RVZwWk5H?=
 =?utf-8?B?ZGZ2NEZOTUYzVXVoQWJvK21OYVcwcko0bVczVzBZakhReUtBR0c4RGdnZUIr?=
 =?utf-8?B?UWNLMU1wUHMwK1FlTml4dHNwbUU0NTVzekJhUTZtNldNSlJGWFBheGg1WXc2?=
 =?utf-8?B?VjRhTWJHT0pXdjZIdWtUR3g1eWpNN1h5b01sMThaeVFxdzRtWkJLR1BNN05i?=
 =?utf-8?B?UlNiRnMxYXE5YXQrRTJNckdwd0N3NDZPTmFsT0xyT25EZGNlL1d4RTl4Mk41?=
 =?utf-8?B?bi9nWXRNOW9CeERadGxVbGVmY09nbWZPVVR0S1ZMQ0VaK2lmMDVXUEs0Zndn?=
 =?utf-8?Q?E6/XVKRCJ2M3sjenga?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06e6d0e-6bf1-4761-0fa2-08df292025ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:50:16.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GomrIkGcumTvKv2sc8nJ5eNKcXr+PLiDB73/pcsHnIZsocN1ry/v+/hXIJN9Cxcn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB748946

On 10/13/26 11:40, Matthew Auld wrote:
...>>
>> It could be that this check doesn't work and because of low resolution and/or not busy PCIe it somehow works, but that would then clearly not be intended behavior.
>>
>> What could also be is that the frame is pulled over the PCIe bus using the SDMA multiple times, but that would then be a bug in userspace somewhere.
>>
>>>> Expectation is that buffer rather gets moved from VRAM to system memory when mapping the buffer with dma-buf, where it stays, and never negotiated to use p2p in the first place. I don't think p2p is really valid here.
>>
>> No, that is incorrect. When P2P is available it should be used, it's just that AMDs APUs can't scanout over P2P.
>>
>>>> What happened is that user updated their kernel and due to the MOVE_NOTIFY config getting removed and enabled by default on newer kernels this suddenly started negotiating p2p for things like the window buffer AFAICT, instead of moving it to system memory and keeping it there. On previous kernel versions the buffer would just get moved and pinned in system memory. From user pov this is a kernel regression, given the perf they are now getting.
>>>>
>>>> On AMD CPUs you allow p2p for everything. On Intel iGPUs we currently ban p2p. Maybe there is bigger question here for what is the story for p2p and iGPU? Should it really be blanket allowed like this? Should it not be opt-in with some userspace hints or something?
>>
>> Again no, P2P is mandatory for APUs. We have basically tons of customers using that with AMD dGPU and AMD iGPU and that works fine.
>>
>>>>
>>>> The other important part is that even when you move to system memory, it's no longer pinned (MOVE_NOTIFY) so can you now can also get violent ping-ponging, which is addressed in the first patch in this series.
>>
>> Yeah that is something which we have seen before as well. That should definately be prevented by the kernel.
>>
>> Does that patch help with the performance?
> 
> Mostly it's p2p that is the big killer. Series gives much as 10x FPS jump, if we stop negotiating p2p for the window buffer and prevent ping-ponging.
> 
> For example, in GravityMark,  we go from ~18 FPS -> ~180 FPS, which matches the previous performance the user was getting. The ping-ponging hurts, but from the reports it looked like it was only in some games and not as severe as p2p. User confirmed this with CONFIG_PCI_P2PDMA=n, and that fixed most of the workloads. Adding the ping-pong fix then fixes everything.

In that case I have not the slightest idea what going wrong here.

The only difference with P2P enabled I can see is that the buffer is pulled over the PCIe bus by the iGPU instead of pushed by the dGPU.

As I wrote in Thomas reply as well AMD uses exactly that setup with an dGPU and iGPU in the infotainment system found in Teslas and that works rather well as far as I know.

Regards,
Christian.
