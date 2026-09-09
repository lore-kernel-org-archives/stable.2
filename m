Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DD1556BBF;
	Wed,  9 Sep 2026 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958048; cv=fail; b=ICBLeMkpmF5WHD25gGP2EWCxH4A2RiMbNzK4f8pqLkIQuRMT1veGG7uZf7izeGpP2+VGCAsJVZnaz2jQcV3vzR3QHixMdYg6+MhJiJKpvQX73YukFLo673LDMwx32iktmdltmIpcYP3pLiUWHCSjC+m6IU3V9HMbETcdMKEkdzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958048; c=relaxed/simple;
	bh=1cWgm4Fekf8L/+veOFwBI9+wcD8bO+PDbtPsuY1+6TA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bh5inbODuTfEwd5AeXdpqA6dC8deZXB5tE8xQOddNaQap1xXQvqo4FJD3SAf/eIBjGk7mYSTr+EgnfAxuKEHxD/pPekewkwvoikDMkTiZLWIn+2YzKch+aHNw2uuvIEpGV3bXIFBh7+8Sxj0wgIqdeCwhBUdoIH03NDqiIWQ74Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k2UiGHS/; arc=fail smtp.client-ip=40.93.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k2UiGHS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSvVcQg718x65/jdCaGyY4a7auI106xse8oa8gDnKaHvuprGA9QMsUHQISuvLZZOYKRqf3Yor+7wB6vWV13Un1seWSN3o2EY1OjYxc8yxhyz2i5RI4DStMWNt4yY6R7kYhVGjayMMaWH6ztuKfZpUt8/vMY7Hr+L59I1zjlHlPrtsCgNdC9YU04anVC2gA1mo92QykquRtB0QfiLuaembZ992xuApuf2MpNwjcrK2EFJ5teKQo1f38OPLfmxEqKi0JgzjvA8u7zzZMnFK3quR8F17MalGBgYRBIvKDQrAa8VwcMK1z9wGU1CdCAJ3o6jyMgDfuSUToiNSa9mxQvYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKPUCnTDnE7MsNRnTEJWqd/k3R0DpObTpblSDGshSUI=;
 b=xYBBG8e8wLzMSx8z97zL/MwMce+D0hc+GlqGAnOrQNsKy0pAIFACe911NIhBqqd4/iOg/hIh+xZzLThUk87o/pKpEfNuYX+WLdmaShFziqWqmIxmN6YWy1ka/VxPR0oGfX20WFGLFzFYR6O+cOYKOUurkLetHHIyPucV8VbXqNSnpexUn/im3vmef1aUgIaQwL17VQxNHPPIObmVNCbM/sEMNC1Jfurs7uTwQMSmWv17oYV3ju6WOksL1YNW7etLGAZuRIGk97ijSFnj8b+QvHt30+8TN82eRYTR72UhzBGjVSMEd+cyHDqGSRaiNTTE5mLoH+nX5AobJsXedsFtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKPUCnTDnE7MsNRnTEJWqd/k3R0DpObTpblSDGshSUI=;
 b=k2UiGHS/eOsFO6c45IS7wg3j2/n/Az1J5Wwn9QeDbgngMwW2BTM5Hrf9go2C5ZeJvFZqRLyLTr2/68jc9m1jLroMOaEbn0xLuVMrODCa8i2x3fudskQ5XLoYBHTuM46+h7UjRwUw9mVv/3n8I7l7mu1ICuF9f442Vndt7IWIhvANm9QVtgtnzj6sX/mV6hhWxpMwEKn27t8WP31jHKY/oObyMxjBT+DnqaTuz9Stl7MXaePf64b+Zgkkeyuk7a3QPzp4pfkU6evPUBnLkxz6akfrw7ges+85Ivi2XnZ4b8P/XlEpxtEPB0cLWRKnVNpNlt73Nu+qqetLq51uVyZZ1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 9 Sep 2026
 12:47:21 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 12:47:21 +0000
Message-ID: <6a430d55-72e8-4333-b369-af215c9f0c3a@nvidia.com>
Date: Wed, 9 Sep 2026 14:47:16 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.1.y 6.6.y 6.12.y 6.18.y] net/mlx5e: xsk: Fix unlocked
 writing to ICOSQ
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 netdev@vger.kernel.org, phaddad@nvidia.com, Paul Saab <ps@mu.org>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>
References: <20260909100310.1941561-2-dtatulea@nvidia.com>
 <2026090925-myspace-precision-c68e@gregkh>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <2026090925-myspace-precision-c68e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ea4ea9-6337-496d-ac99-08df0e707d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	koE0pvQY/ZaWlodKwL0vDnhPP1kZa5/NtN03wMbBEppo0KRnrQ5yEKlISyAy2f/eBktiN7eaz5Ya0kjMF7yxZPcXaPOxNUWBhddGa1gaSq+4W7BDofGorlT1qcptHjioO8pBtGhLLMe0Y2k3RIJcDk6ZRbRkIEyUkFkaPnif0SqOHMwKyynim86eptu452bnbZx6X5Vi5I27p97HXvxxJEC4NLCXstCy315s/Pa6B8LYHCSV9OcHvIMzMmeH+EYJIdbMHIIpMihlSXRitmLChzKEMdL+Ptd/aR6UEkNmRtC3Qk4OEyEojYs4cFzb5EZEz4mtMzWaCYauyxrRXZlsW1UYqoCGlQb6ZnsCTTep5/FF/6kdFjXNpyUeh4VEs9pzc3RMDtoDQTX7EQbe2L+FTTaaaXt9ha1/nDbWXtNrhxLzr238ecsU7JsqzQPr/7FdnUtxHEbrl04R3Ao/2+cxPdphCcUJKXYFcS27B+cd7AataE3ybZTcGOnOYW7Yl6FEQKfNO4uwFDZfsyE8Vod/WFXx64Vwm6bxlM1XDj5xv1p1YlkA9giLj51IZJ85I9mvs3xy9qL0tpdyghf0FEE0N8SSMk2R5x73CTQdPh61kMt1iWJmfF4y2FanXEYe4LSPFCLDnoSwIxTwNOKc5j6sLGAiY5DAiE3e+CUcc/zIBvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0RQbHg2KytYVjBXU1YwYUFTcTk2UHFjS1FMUHNRcTZtZEVaWDB0aXZ3ZzJD?=
 =?utf-8?B?NUEyTzZzcmNHYTNaaTBsZG4xNEtxL1ZjdU9YcktlZzFRZUd3TklTZnpiellx?=
 =?utf-8?B?ckJFWlZKSG8ra1ZBQTFyMUtqYnVqNzl5alI0VTNoSUtSRTZxV1NyWTlSM1d2?=
 =?utf-8?B?TVFrR0I1Vi93Nm95dUNDYXpWRUlld2Z5Q3N0eUxjbnYxa2VxQzRvYjdHU2Rn?=
 =?utf-8?B?ZW5qMXI1bXYyM3RBRHdBelRHamlVbGNxRUJwUWFnY3YxekZ4TWpSWHUyMW1Z?=
 =?utf-8?B?c1VDZHRVVDdPaHBEazM3MFV1ZVJCTS9nZXArcTVWREV6Z0pFWlU4bWRhRWVQ?=
 =?utf-8?B?bFM5NnNFSm1vVXdGUW5tY2Y5K0ZEOVcxTlg2MnhZYUg5NjNrMjBXUlR2c25Q?=
 =?utf-8?B?U0tMQmVmdTVFQkF1NWhlZkNrdnJIWlhxYytzcERRVmJCakI5OTFnYWJHVEsw?=
 =?utf-8?B?VnYxQ2VmR0RSSDQxZm1rSHJZZEJFM0J1ZDNkYVcvYmh5Tksyck5ybWNZMXpq?=
 =?utf-8?B?eVUxQVl0cnJIcGh5WHdlaEdwR3V0cjNISDd4bytvdUZpdkFFVGRJbUFYTEZp?=
 =?utf-8?B?U2F3dEcyNWg5cnZWN0hlci95NDlpOXVpSDIxWmhVS3dQdzE0dzFZUWVlUDlx?=
 =?utf-8?B?RS9LckJENU1Kc1JobW5nVXBtRER0eTFFazdVc3JJUktHTFcvSzdiQmJTQ1Ny?=
 =?utf-8?B?SGhQVUx4TXB0T1F6blVIVi9QSVJlY09NbUVaOG1rbVR3RjJBNkhXTHVLeFJ2?=
 =?utf-8?B?NHZmbENPMlFNcWozT1E3Yzg3RXg0RmtJdWw2OGo3VFN1VFVoWU0xTDFYMkpv?=
 =?utf-8?B?Q0dDR3oyUWJJcEVhWXBvWDhIMEhobG00ZDZyTGJ4UGtpa2tHT254dE5ldDdm?=
 =?utf-8?B?R3dDVFJ4LzRoNlR3ZFVmeFFCemUzdlM4dmZ6d2YrZjMzZXZtZnZoMEwxTFNs?=
 =?utf-8?B?YnpWQTNWV3VVbzhKT3JSK2RtRXE2Vm4vazQ5ZTBWZHFvdjRyT1ZjWXV1QitC?=
 =?utf-8?B?YVVGa0R0c0tRSlgyeVdoa0JCaTBXSjNyNzB6R09tR3RySnptRVRkNWJSL2kw?=
 =?utf-8?B?a1ZQc0xIYndhaUw4N1lQWkxCdGJlZnpHbndHQXZNbzFjME12SU1JdmhzYjIy?=
 =?utf-8?B?VHF5T0RlQ2tBTTBSRkFacWMvSzRweUZmcndNV09OYi9iOGdDZE9sZmRuN3RN?=
 =?utf-8?B?eTFYT21NdUxtYURueDN1VmFTblJUY28vOFNGL2NielBuM2pDa0VFM0ZQWDVh?=
 =?utf-8?B?eFUxYm5BelVoN2dXZ1ZneWRMNHhqc3U5VGNJWG1qcDA5dThMU1JRbnhKV1F1?=
 =?utf-8?B?bVU4TGhwbytRK0pMWFpoMDhKM21QQ09aakJMa256b2ZZWEd0ZUFxNlF1RGJD?=
 =?utf-8?B?ZnR0ck9UUzBQcDl6UzE0MWV6Vkp6cmc0K2tmK0ZuRHBoRFJFaVRZSG5SM3ha?=
 =?utf-8?B?N1NHb3BpK3RuN1JSd2VnNE1wR3FXVXk2cVR3bzI1RFhSYUFTZy9qSDlzMUlC?=
 =?utf-8?B?S3VRbnU2cU4yOTg2RE9lNjNkTXcxQTB3YkhhajR5L3dKL1l0Ui9aTUZ5MFdK?=
 =?utf-8?B?M0F5NEp3V0pmYnRoeHVweGNsay80MkFxYW1NNkNEUlFBYVFCM0ppTkxpYWE5?=
 =?utf-8?B?OTFNM0tIb2dRbC9HWGg3Z09kd0kyZ1R6MmRLZkRzcko1aGNzdGxQYzNCZm1k?=
 =?utf-8?B?b0ZicnRweU95QUdVWnk5SEwrRUZYcXRMd3U2aVBQUXQvcFhuV0FUR3BYTm55?=
 =?utf-8?B?Y003T0szUExFWFZ0N09mTWIxRXdnSDhYTDZYSTV5bVJzeXdnYU5qVENXU3lV?=
 =?utf-8?B?T1RlNUVaa0U3UnpzRHpuVEV1ODdxM05aUU5yRDRBVkg0Uy9qMFFnSEs4MzJV?=
 =?utf-8?B?UzVTQW1ZTnBtUENhM3NaVmlUK1kwaHhJSm5pb1VCK3lUZGlSZ2llTy9XQ2o1?=
 =?utf-8?B?d0Q3RHJsTllrNFdYM09Hb092TG04NElyaU96dFBWc0hWekFtQThsczYxNUk2?=
 =?utf-8?B?YU9YeGUvNkp0TFJFN2gyNHFmeDZLbHRPZlJIcmZzdVFMWnFLelBGZnFWczNv?=
 =?utf-8?B?a2FWY1pLM3l0aVd2Zlh5c1FRaTliT2NnVElWNkhMOTUva2h5TjcvOWpBb0pR?=
 =?utf-8?B?MG5pdHd2cExqaTBpaWoxQUlrVGJoMlpsMGdtK2JSYmNJVDdKSWR3bmp6eTRC?=
 =?utf-8?B?ZGhVd1VZb3BudW8rM2RjclVFbjEwcVp5bzJwNFRzdGo0cTNxbXZ6SGY1RUZD?=
 =?utf-8?B?aGlEOTUzTVZqMTlONnJzTHRFeGRuMzdFNklFMUhyUmZJcHVsMm45M3o3NHVC?=
 =?utf-8?B?YkVlbmJqOEZWb2ZydlZ5K2ZQOXp0MWlDSGpxWEtmakxLaEZjeFdWQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ea4ea9-6337-496d-ac99-08df0e707d24
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 12:47:21.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEjFQcvcZRHRGgjD0ydGoOoJPklH9N9YsMKGu/D0ZH2LeXxu/d7oRbxB8SKQmQdyUcrIQu+Vdwsg1coXvxh76w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473



On 09.09.26 14:21, Greg KH wrote:
> On Wed, Sep 09, 2026 at 10:03:10AM +0000, Dragos Tatulea wrote:
>> commit c326f9c68921e2f14dfcecb2f6b4216313d50248 upstream.
>>
>> During napi poll, when the affinity changes and there's still XSK work
>> to be done, we trigger an ICOSQ interrupt on the new CPU. However, this
>> triggering on the ICOSQ is done unprotected.
>>
>> mlx5e_trigger_irq() is called while mlx5e_xsk_alloc_rx_mpwqe() is
>> running from a different CPU due to affinity change. This can happen
>> because IRQ triggering is done after napi_complete_done(). At this point
>> the NAPI can be scheduled on a different CPU. Like this:
>>
>>   CPU A (old affinity, NAPI tail)    CPU B (new affinity, fresh NAPI)
>>   -------------------------------    --------------------------------
>>   napi_complete_done()  clears SCHED
>>   mlx5e_cq_arm(...)
>>                                      napi_schedule_prep() sets SCHED
>>                                      mlx5e_napi_poll()
>>                                        mlx5e_xsk_alloc_rx_mpwqe()
>>                                          memcpy 640 B UMR body
>>                                          advance sq->pc by 10
>>   mlx5e_trigger_irq(&c->icosq)
>>     wqe_info[pi] = {NOP, 1}
>>     mlx5e_post_nop() advances sq->pc
>>
>> The obvious fix would be to lock the ICOSQ. But the ICOSQ is expected to
>> be accessed only from the channel's NAPI and has no locking. Kick the
>> async ICOSQ instead which is always locked.
>>
>> This issue was noticed in the wild with the following splat:
>>
>>   netdevice: ge-0-0-1: Bad OP in ICOSQ CQE: 0xd
>>   WARNING: drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:826 [...]
>>   [...]
>>   Call Trace:
>>    <IRQ>
>>    mlx5e_napi_poll+0x11d/0x7f0 [mlx5_core]
>>    __napi_poll+0x30/0x200
>>    ? skb_defer_free_flush+0x9c/0xc0
>>    net_rx_action+0x2fe/0x3f0
>>    handle_softirqs+0xd8/0x340
>>    __irq_exit_rcu+0xbc/0xe0
>>    common_interrupt+0x85/0xa0
>>    </IRQ>
>>    <TASK>
>>    asm_common_interrupt+0x26/0x40
>>   [...]
>>   ---[ end trace 0000000000000000 ]---
>>   mlx5_core 0000:08:00.0 ge-0-0-1: Error cqe on cqn 0x548, ci 0x2022, qn 0x8f4,
>>   opcode 0xd, syndrome 0x2, vendor syndrome 0x68
> 
> Why does the changelog here differ from what is in Linus's tree?
> 
> Please don't do that :(
> 
Apologies. Will fix.

>> [ Backport to 6.18.y and older: upstream commit calls
>>   mlx5e_trigger_napi_async_icosq(), which was introduced by commit
>>   0da1dba72616 ("net/mlx5e: XSK, Fix unintended ICOSQ change") and is not
>>   present here. In these trees mlx5e_trigger_napi_icosq() is the
>>   equivalent helper: it takes c->async_icosq_lock and triggers
>>   c->async_icosq, which is unconditionally opened, activated, polled and
>>   armed for every channel. Race B of the upstream commit message does not
>>   apply, as it concerns the sync-ICOSQ variant of
>>   mlx5e_trigger_napi_icosq() that only exists upstream. ]
> 
> That part is ok, but changing the overall changelog text for no obvious
> reson isn't ok.
> 
Do you prefer that I drop it in v2.

Also, should I prefix the next patch with v2? (First time sending a stable
patch like this)

Thanks,
Dragos
