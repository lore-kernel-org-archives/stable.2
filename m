Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59944317148
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724474; cv=fail; b=Rdxz00M5MoNUkCOaUzbDrFqx5hg17ImwX+S2RLph9k9AAucl5LDsbbXXX6xeSPwfEkMcNPaX4k+bhPD51bQuetfJWP2XL+NVBwVSi6h6DdIUTnvXuRy7kjADDS3I3RPpNnuB8MIF/WYbJ57TvLbWhHCGCuU5SdZaJZMFRv52bE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724474; c=relaxed/simple;
	bh=iml8Pr44cdOIqJyIrLKH8zIaoRKqcao8HKRn9KgO2Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RX5AZFV5V+frDroZ4ouf1sRh4i+V03dp/8uRhjpxtRKGZp+KAfNDd1l4lXtYg/p8F/ZJlJCgL5pZselg6kTURyK8cnhOhAi8/wqil1EZbJyv+axwWMFa1W/ZaUsEshsZkycxZM4YaBaClaBc03VE2dIVsgzOy3w20u9HgUoS3uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KdPblrc+; arc=fail smtp.client-ip=52.101.61.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KdPblrc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAru4QGwENE7I4SISqm5vzBZX3fLB1s6u3ArWF5DKy+t3L4aZoNlkax51/GfpKJncf3tilefq901QhUXGV5nPBoREaMS8T2JXF8Qm9RxG7NsLiYuoT8aIj4/4phzD72DGFzJ1nYYy2VWGpMELf/3qIaLGSlzfl+PGaXw2z+OgjWDHmtmBUaVDM0n5NAQw8g1M+aVXrusBc5JyXboAUBlVvAs6M1/BnI1Tp8KeRfVipLRvMbmzXgkisnTaxB8zLvBlYadZ5D2+OVkGqWuIB42CwX3CPvXiG6idgS7PhBIvyPVtWSAuOJlV+B3qQ9BdxkrtwY0A93Huft+LzESf1R9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IZqJsMcYup5T1J63x3YC2DOjiq0C8Ef0QY5zpeczAk=;
 b=XKcGjDxFe4Vju86BJ8VaQ6WWk8Md8BiBinq9kq5lynBs7uzUNG9m17Yj8kr2EXkh3TuPg9Eh6mkI+ikPbNtlKWdJI89mtcRZWEMC3W0KvcbiPc65iTGc3gRtu31r9gIfqj7h1KlJnZ7RKQ9B5mY8C6xd7ehXyy/LBc35f1UhvABZjiWgxS4bE73T50556JIo7K0i4hQNF2QTMH3QVJw3nVmMvhzvnyQeEsrhGN+8+ehgx0R9Ek4lFIUF6y3StBxw5QdHpPFkV2hCBrHryGLR++rCEPU/kmdj0ehuwfRsET0GyxKt+5kzSZu8Y4r02PSxs5xuPVCnQzwY0LS5IEiR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mailbox.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IZqJsMcYup5T1J63x3YC2DOjiq0C8Ef0QY5zpeczAk=;
 b=KdPblrc+AR4d2O26ygaRp0zzUG1mPKafbFoa89pLeZohHF5AylX8t915wvggtG9+Oovz24sMdcru2Az6B6J5wA936klS5820tbzWHjj3RxNFp++P5cLc615fQkhJpGgj6TZHD4IHVIMumQw5ETtbQn48kWLQ2Evi7BeoYwgJPCQ=
Received: from PH8P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::29)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Wed, 17 Jun
 2026 19:27:47 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::25) by PH8P220CA0023.outlook.office365.com
 (2603:10b6:510:345::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 19:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 19:27:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 14:27:45 -0500
Received: from [10.254.92.203] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 14:27:45 -0500
Message-ID: <7bf196dd-c43a-44b5-91e2-ee7ab40fd6f5@amd.com>
Date: Wed, 17 Jun 2026 15:27:39 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>, <stable@vger.kernel.org>,
	<amd-gfx@lists.freedesktop.org>
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
 <a74f1233-d63f-4bcb-a379-3c9a6332cfb4@mailbox.org>
 <75732f3e-8ffd-4cac-b205-8f6cf705daab@mailbox.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <75732f3e-8ffd-4cac-b205-8f6cf705daab@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: b511e141-78ac-4d0f-dc26-08decca682c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|32650700020|376014|23010399003|82310400026|42112799006|1800799024|56012099006|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	nW5VicAudmPKc7FFfRNQU+rFAES0eoxlc5oYjsxp7UZV3d+9Pih0WoecgvgSw5gA3/6UGiuW7vwRbvHBT3AbOnKPVyZ49ZKm/ixBrOvP3ykOE222576cIfWLJQnNG/btMeLinn8vvT8+VeyW/zlVmSowcXScpk0RjlZ2wzP2IaVKSbLuAmpesBt7XzGAqi7qAWUscm5a5YeajFy1NTd+KpZ4xr1/vIWvnFZytgNFQ7mLqXQtAxh+LrYT9rAl7giIp5WfJ3Cfc4kgVJufHKLo5Db6eh+qwhJPxtjWVo1qqTtxKC/7mnQk0KsnS6UAoOdpQwEwPtZkvuB3ZkhHlvFuc0gHXmQTV4CI8chYz/QW30+Lc8g2mIT90kKJVu33K7BM/x1Ke8BaSygX7ewcMTBof1NNbWohlyfn9PU3my+Djz+QkpBGzj9oB5sxE7VNK4bZb33QZtlE/vjdrxcYZ8po0W28MYh+om4F9BGjIjwvw95vylvR+tTn8fae7IGROCOBIvf+Tr/j/6mcXtEK4GmdQsM1XT9p4gdaypv5YDvJ3rWADs17ohmPufmwmENcNmzIeJdJ38E0JLrIHi39o8kEq30ikk6U5piAFZce6r9KVgs7mvHHHYBlrsxdSLG+MRJj3nLig4vougeD7mfAXkAsS5ooycXEVwkBphoFQMSsL+uox2NoJg0O8fEVjFdmX+KothvfiPqeR04NyUrEDWsGh6e/mcmFqvoR4gw5qR+9Gss=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(32650700020)(376014)(23010399003)(82310400026)(42112799006)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FKahdwBIVI3avTxEoDJvhxFG6427/UCTParYR8egpcmgmDs52sAIVYxXF7AkLI6zBjdqclIsxKi0FLdAeXzjMfpV1EUjctvYAU0k5DEGhMjLLbcyujBFvorOcpONNo73rak/+SO0KiID9GnbjTwoSGLoaa1SDrrtPHCuFNc3l6sUEIY22rWdz3zyFyH4uP7e/6brdOt28KEEFNC4G49Nf/9W49kyNfB+zRHgGKflV5HJF6MRxkVSwabuyMdYWIKXuVbIuznadjbclSxigepAXl64HHfl/4hIhNr4cg0VNksA5hauCwbDOkhTbkjvcXsiMiRl5922wmTfq77ZUnPvQiqwJsKVDOimpuh7wLBbV+diRDlOEGeMAxjq82UqtPLnFPf/xL2kLnNtmvDGBhRq2cqTvjZ69Ts+n3iC0Cfb+OX43VxSp6Srw7RuLJXyxQTg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 19:27:46.3007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b511e141-78ac-4d0f-dc26-08decca682c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

Hi Michel, thanks for the review!

On 2026-06-17 04:56, Michel Dänzer wrote:
> On 6/17/26 10:07, Michel Dänzer wrote:
>> On 6/16/26 22:18, sunpeng.li@amd.com wrote:
>>>
>>> * Add a flip_programmed completion. Arm it (reinit_completion) under
>>>   event_lock together with prepare_flip_isr(), and signal it
>>>   (complete_all) right after update_planes_and_stream_adapter() programs
>>>   the flip. It starts in the "completed" state at crtc init.
>>
>> Is the completion really necessary? Wouldn't moving the acrtc->pflip_status = AMDGPU_FLIP_SUBMITTED assignment after the flip programming suffice?

I think this would create a window between HW programming and arming acrtc->event and pflip_status, where HW latch (VUPDATE_NO_LOCK) can fire and run the handler:

    Thread A:        Thread B:
    PROGRAM(flip_n)
                     LATCH(flip_n)
                     vupdate_no_lock_handler(flip_n) # no event armed; skip sending
    ARM(flip_n)

Ah, but the flip_programmed completion has the same issue...

    Thread A:                 Thread B:
    INIT_(flip_programmed)
    ARM(flip_n)
    PROGRAM(flip_n)
                              LATCH(flip_n)
                              vupdate_no_lock_handler(flip_n) # flip_programmed not complete; skip sending
    COMPLETE(flip_programmed)

> 
> Or even just moving the unlocking of event_lock after the flip programming.
> 

I initially thought about doing so. But the possibility of update_planes_and_stream_adapter() sleeping made me think otherwise.

I suppose the worst case scenario with arming acrtc->event/pflip_status after programming is we deliver the event a frame later than it needs to be (which is also the case with the current patch), thus stalling the next commit via flip_done, and making userspace think it missed the programming deadline. That is, if the exact scenario above happens.

If it sounds good to you, I'll roll that into v2 as well.

> 
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 00f7a3b445ebf..571198c46c0c2 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4384,17 +4384,17 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>>>  		 * from 0 -> n planes we have to skip a hardware generated event
>>>  		 * and rely on sending it from software.
>>>  		 */
>>> +		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>>  		if (acrtc_attach->base.state->event &&
>>>  		    acrtc_state->active_planes > 0) {
>>>  			drm_crtc_vblank_get(pcrtc);
>>>  
>>> -			spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
>>> -
>>>  			WARN_ON(acrtc_attach->pflip_status != AMDGPU_FLIP_NONE);
>>> +			/* Arm flip completion handling and event delivery */
>>> +			reinit_completion(&acrtc_attach->dm_irq_params.flip_programmed);
>>>  			prepare_flip_isr(acrtc_attach);
>>> -
>>> -			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>>>  		}
>>> +		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>>>  
>>>  		if (acrtc_state->stream) {
>>>  			if (acrtc_state->freesync_vrr_info_changed)
>> 
>> Pulling event_lock out of the if block doesn't make any difference (other than locking it unnecessarily when the block isn't entered 🙂, does it?

FWIU the crtc_state->event pointer itself should be guarded under event_lock, since it can be NULL'd concurrently.

- Leo

