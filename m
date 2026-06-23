Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326967081A
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244882; cv=fail; b=ns3/hSnyPe+xSaeF++LEBYOJVD5uM6pPNk3DV3Ee/YqHsdOO5W0gAle2mZM9KDs/oX5o5WXChcwgTDKB9/XLGgYJNCSVo6p6HKOl1msg+iWluJnazEOg3WBD+zwnXicQbzqYG8a2zHhaL2EMv6TxKH9XA5PgyXCpm41od5Hk5MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244882; c=relaxed/simple;
	bh=LaqJo6mKwRcSAavNQgnbGkNZGYIAru0q6r9jxoFHQKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ICtmFSl94csrnysmPY8R+uDMy5lyy8ivLXTDS86VYYkGw0hv3rxgLQrBboHW5IfY5pN5fJ1bPaW9N3uG3hWs59m0Z/05VyZn3Y7DfWY3FP+rx92OUD7abo58/i11Ad4UgJfRaGtbnpuVTy0tB+fz7gr4YOhsSlqNOPj9xnVDb5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o9c4rbnE; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o9c4rbnE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5sID94YClShKCYdtAbSPr+RMqNxGojHQz6aihOzb40Ba0ZgKdQHP0k17v8iqq+HsHQ44Gg4vWc5dc2JGKNHElvKYXbColyHeiJ2Zd5NJmWk8oeM6/0yWJn2k90+W/mobnLHplmVICmQ8iItqatloPhJhDo35WqZKnRpI0zAf4rYudmmTRylJvccfNYxyDgcrbC1WQHRnoYvFmvXqfPSFiFiKjUOMQezWiuVFoQZVO2L+vcESVB/B8fd4VD6FFV5z5TsECVJVcsDxQ15kqPlr+pTYfcsdtEIBVbUYJ5TdFLvI/+f6Zjc28r3TXge3T4OSOtf+urM89shyxHhugRIDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Blzrm04inCQ1UuXoOb7ZtN7oNdK17sVNVAIZNEKWusI=;
 b=Qdfn78rkN6JNtUxNdDY0cwxzA9XtA/I/PrqAEKzt72npbPOrqjFX7X/yLPd+c7Rkl/c6BqSTPsijkfs9EUepr6kWPtj4ti0cdMulbS987qiv6szXIYOW/0u43SRE/uCe2m5hg+7JKXUgEqebgbAWSWOTilwsNCVLb3OqZT3qR7KKAKxkyzcn/poWJt5M0h/1u5F3bKWDwvvn5vZo4eLEdB+Oncjllu0bXc4wJXr3kkR7w91aAQcXPTH9u4DODpKVSnidr73nWRkqFcZHBSO9Q4VKPADs2TRr8dWDsV7DHAYRihLuyFYHBBnXiNUpjrM3e4zJydL8SLVmcdq7eaRtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mailbox.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Blzrm04inCQ1UuXoOb7ZtN7oNdK17sVNVAIZNEKWusI=;
 b=o9c4rbnEeLZKNM/dkiygo7P2ps0CfH/33AqaNobI6x1F63LE4/IJSFjen49jw1YkliXhC95jUDuBaCb99HJlu6Vztmlqlkw+8hCBqwHL3MT2xIIHsodzuSyf+8Xn6hCtz8nSyB89ECstSwHpiiqMxZX66+sbDq+50r+dt5mhYQI=
Received: from SJ0PR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:332::18)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 20:01:18 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::3d) by SJ0PR05CA0073.outlook.office365.com
 (2603:10b6:a03:332::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Tue,
 23 Jun 2026 20:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 20:01:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 15:01:13 -0500
Received: from [10.254.92.157] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 15:01:12 -0500
Message-ID: <1c5c4b76-da51-4329-b00a-cce8094a9a8a@amd.com>
Date: Tue, 23 Jun 2026 16:01:12 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	<amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
	<xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
	<matthew.schwartz@linux.dev>, <chris@kode54.net>, <stable@vger.kernel.org>
References: <20260622171752.73374-1-sunpeng.li@amd.com>
 <20260622171752.73374-3-sunpeng.li@amd.com>
 <f36d5096-b509-42b7-8a11-423c03c05919@mailbox.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <f36d5096-b509-42b7-8a11-423c03c05919@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6b8b51-543c-4cdd-cb07-08ded1623099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|42112799006|23010399003|376014|7416014|36860700016|32650700020|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	rUPN/F6KcdueUfs4l7qm2didBdnMt2zz2GtMaX07GsE25kWJBvqcQvnNynBPSLuOhVlNHrjMuybAdyfRw2JmbRGHFxDgbcxXanW8kQ81eZul2M1Ab/FUweuqgedjBg1pjeoZm0Ff4FZ4toXaMSLQ8A8VcJ9eZyOcq83jYkYJlhuXlooK8CvS03ANd86H2+GvraVkUleZadH462McgD6du+HxAUKXUz7biSR1U+Vm4BotlkRse9BqOsiRkhR7Qc1ZNhXIIlUUeLTf0nH7WvF7J6ZiG/JEHrCT0hfQjV8ywpgMCv8pYFPmHIbZUwXF/sOAuPKdGRU+NIK0NDCBCCTFAoi2jgQWBOGucyBXYHri8uVgrkByddgN5BBUda3tdsCN4dmAWSeReFeXM1SzkrKXbzqjQ2Fy8v+IVoQZlf8qUZT5OvyDXfZ5KWNNa2pNlrAOKVwr9BJwZy+KhCapl3o9yJFOIGXNcpTWSH/0bReMsvoO35dKshlHnZPtoXF2hmtM/clqzx/yMQWQW3FVC3PNVvLK8Fz07fWeyHSyZuXFXGlcOLMg2NQGWPngtJyCHuu9R0xAtlq1rODkakHJc1WiYztgZiUj5zIZazM+Z8VgDV/9jqvMEKmjSc+py4OXu8ornzHSXet2DKvkgrZfRkxx/RLbyE5CJoX5yfzUgJlKJbZDkIzxMKXiiIWJpb7ulCxeDaGDrX5XR9VyeUPFstcdNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(42112799006)(23010399003)(376014)(7416014)(36860700016)(32650700020)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D2J9b83k3Rn/aPlqYhNRHa7MLCNX354VQS+g0B8HPJwzS6gUJ9oau0hpbj95kYjllqUEor5izePT2LGRXwFN/5FTxv+nC/t2CZ6648lJfUYvHMRTJQoXXgzKlBXAXW9IYWO57vc0e1Uc70F4MRv1rva92IwfS9AbqDa1cDT4J9XrBciMNNwRU3PhZ8FybNduG0XORoDpR2yXt2XQk/Lf6Fkv4/qV505bQ/+rrubmsM3VQ0HD0AmAph39u+yA76ldg+JNyOaeS+eLSBflfWUGCGC9BJwyXmsRhuCHRYyh2GdN9esI9kh7VwkIDs24wni97f3TnnU28Ia9HVYUKdVEnCJNan+w9ZMl25jkmTjF0x6sNaWJahH5co3zxKWWvqf5SGSxcs+xfgIerPKqbMYIdtB391aGdz+rSDJijcMrHLwzY5m21XTdB5XYcAV9FHuv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 20:01:18.4469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6b8b51-543c-4cdd-cb07-08ded1623099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137



On 2026-06-23 04:28, Michel Dänzer wrote:
> On 6/22/26 19:17, sunpeng.li@amd.com wrote:
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index da118377b73a8..732ddafb5cfea 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4135,6 +4135,28 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
>>  	}
>>  }
>>  
>> +static void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
>> +				struct dm_crtc_state *acrtc_state,
>> +				bool pflip_update,
>> +				bool cursor_update)
>> +{
>> +	assert_spin_locked(&acrtc->base.dev->event_lock);
>> +
>> +	if (pflip_update && acrtc->base.state->event &&
>> +	acrtc_state->active_planes > 0) {
>> +		drm_crtc_vblank_get(&acrtc->base);
>> +		WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
>> +		/* Arm flip completion handling and event delivery after programming. */
>> +		prepare_flip_isr(acrtc);
>> +	} else if (cursor_update && acrtc_state->active_planes > 0) {
>> +		if (acrtc->base.state->event) {
>> +			drm_crtc_vblank_get(&acrtc->base);
>> +			acrtc->event = acrtc->base.state->event;
>> +			acrtc->base.state->event = NULL;
>> +		}
>> +	}
>> +}
> 
> This looks like it can be cleaned up a bit (feel free to ignore though):
> 
> {
> 	assert_spin_locked(&acrtc->base.dev->event_lock);
> 
> 	if (acrtc->base.state->event && acrtc_state->active_planes > 0) {
> 		if (pflip_update) {
> 			drm_crtc_vblank_get(&acrtc->base);
> 			WARN_ON(acrtc->pflip_status != AMDGPU_FLIP_NONE);
> 			/* Arm flip completion handling and event delivery after programming. */
> 			prepare_flip_isr(acrtc);
> 		} else if (cursor_update) {
> 			drm_crtc_vblank_get(&acrtc->base);
> 			acrtc->event = acrtc->base.state->event;
> 			acrtc->base.state->event = NULL;
> 		}
> 	}
> }
> 

This looks a lot nicer, will include when merging or in v3 if needed.
Likewise with the two other comments below.

Thanks,
Leo

> 
>> +	/*
>> +	 * DCE depends on a combination of GRPH_FLIP, VLINE0, and VUPDATE for
>> +	 * event delivery. Only GRPH_FLIP handler can send pflip events, and it
>> +	 * only fires if HW latched to the flip. Maintain legacy behavior by
>> +	 * arming event before programming.
>> +	 */
>> +	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
>> +		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock)
>> +			dm_arm_vblank_event(acrtc_attach, acrtc_state,
>> +					pflip_present, cursor_update);
>>  	}
> 
> Coding style:
> 
> 	if (amdgpu_ip_version(dm->adev, DCE_HWIP, 0) == 0) {
> 		scoped_guard(spinlock_irqsave, &pcrtc->dev->event_lock) {
> 			dm_arm_vblank_event(acrtc_attach, acrtc_state,
> 					    pflip_present, cursor_update);
> 		}
> 	}
> 
> Nested multi-line statements require curly braces.
> 
> 
>> +		if (updated_planes_and_streams)
>> +			flip_latched_during_prog =
>> +				!dc_get_flip_pending_on_otg(dm->dc, acrtc_attach->otg_inst);
> 
> 		if (updated_planes_and_streams) {
> 			flip_latched_during_prog =
> 				!dc_get_flip_pending_on_otg(dm->dc, acrtc_attach->otg_inst);
> 		}
> 
> 

