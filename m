Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2B40F72A
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903047; cv=fail; b=ChVUF08f3gEuU2EGZspKiEAcfsbNbbGnlXbKdVBu16adpR94Oei5kENOSfHAoVwAPHyFhupOeLoQhxTnF214YBVI15R8xeKUwOViQg8TC89wrS+GP0+ObXsSwffSLrzPT2n3Zm+hJ6MUbzIg5+bg2lAiMnpYSLg1NXkc+hwr6cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903047; c=relaxed/simple;
	bh=8PCyBWvXXYYqrQX6CREVgafZYssKIDZv/Nu/9nIu62w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X6v67ROTR2DS/3LiRtvPKNMEOiQVOmjX0DB0oOlq+IOgckfZRIEpAz2Q8DQmwJZEmhv9wiyFOMFxGy8jvakCKE3Oc11PAiiv2F98Xw5Yu45SmLsyJfz0FvvkHB4Pui58yDVS3Mqi4w1X8IuK0PtOspBczjTDBya1U/HtCm26ekI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2F08it0X; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2F08it0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol/lRo1PfVEsaK4zOPnKk0Jj25038eonT6B8kcP7+A8XgN+KpE+KD+WL1vthofXX8eOfy9VMOohPwtPfQJS9PlrzKIDheM6cfOZeydAqdnPW+XI83B3X3KFOiiW9VJpY7OmwCK7T3sjhHNbSTQPGyzpBfDuBbz+mVCDnKMEwFJX+d8OvP1vw3xI/yGiG3SsI7lEipbonijxHXJsIocAWhID9qtYFBulgAy4YRd8df/tExI3QwVBBWcdXZJaTzmXGPuDirK8pBKT3ME9JMIMKSDXfYU/GRnXy2afnhiJwPe6JXPn4oiHkrcUvEiOGOvcqC0T/Ir3Rtk5YdzWUxreF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0Fd1DXSUx3bC0SrzI+/PLHEV/V9YQ6BAd/YSQdMM+U=;
 b=Z76LmHhUk37/5tikI3BU4qGGg6m/2iHsXFbRMwOeircfR+6ovQRs52ejt+ljpZVJF3mLyd0o95LCVlj+24QOgMKkFh+T0NqFfLCbR9dcOgn734Tt1u7TSRweItUPZZU3yR/tLBq17JnrZVgdjBnXcvZJlN7A2vk+MwQqCLEGukg0C40jVMGPQKGyevr4OUGnHcyfA5uxgUEHBEbjgBwK931vCOBkgLXkQn7rZK03GMjxR65Grd95vWcJtM9+aJptp1KWAYF8fo3gduR/EJoVFj98Wzw6AAIftNgkOneqeyrXfvy6n3kif/N9WLRlpGNXGT0x5ykzFAKg+bQMXTYXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0Fd1DXSUx3bC0SrzI+/PLHEV/V9YQ6BAd/YSQdMM+U=;
 b=2F08it0XjL1bvMiEBKPSUVJykKMuUgwY4QbG5L5fj4W3WuEhyFxgcb229uDAPBH86mHK6QnLM5E0rUsjXmvASA1uKEnLOFPJr2UrIvt3wlhrmbEJgxUnSO21Qhm7xsTnXn/Mgn/x6tZFbrKqQWbKdAl3t8ob6UtLuvdzMh1olvQ=
Received: from DS3P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::16) by
 IA1PR12MB6433.namprd12.prod.outlook.com (2603:10b6:208:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 14:23:59 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:8:45f:cafe::a5) by DS3P220CA0002.outlook.office365.com
 (2603:10b6:8:45f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Fri,
 24 Jul 2026 14:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 14:23:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 09:23:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 24 Jul
 2026 09:23:58 -0500
Received: from [10.254.92.143] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 24 Jul 2026 09:23:57 -0500
Message-ID: <21c843d2-a8fe-4e50-8101-a9b1b337eb80@amd.com>
Date: Fri, 24 Jul 2026 10:23:57 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix flip-done timeouts on mode1 reset
To: Mario Limonciello <superm1@kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
References: <20260723180159.52121-1-sunpeng.li@amd.com>
 <66071e47-2743-48ab-bb3c-8a8ae4ec199d@kernel.org>
 <476574f8-3bd5-4fc5-832f-e94fe1685870@amd.com>
 <85f87f21-d04a-4d27-ae4c-9e0cd64517fe@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <85f87f21-d04a-4d27-ae4c-9e0cd64517fe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA1PR12MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: ac31d67f-52ec-4fd9-2abc-08dee98f3408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|42112799006|376014|36860700016|1800799024|82310400026|13003099007|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/B85OgcIgoypvEBd2+2uGFqFz8UtiWS0naMQDUaLn6SSTTbfqiYEG16JWuNS7jGh59L5k+4yBxYowPzaYyoa8/rJjvLE7PWuZ9OoY2d1PC15Re0FR7Hll/1EwLjsGlOUo1b/XmloLHR8uU8gZtkOrIznBz4bmdaS3gT3TtaflKlMlW+GmlOcKQUXZXopnv5gfkrvvhtmuDOsLPqAatiY2p+2Ku4DyDECO+Ui/5c/4gI42V0nnn+x7pzXLI0K+7KZ3Cr2To09ea+7Nk8O06J7pitYcG1Uj+zG7ZhemsLUn0S5RCM+nVIRxzjUvEsOdnMm75SYKycM10tAtfP0crqfPk5ff3tb0fID9u1TJuDJOVQeBIr2NCm4lmjUSFt14pQs8qCk2w2c+0eo1wLhe+4oc5C2iiJ5MOMe955rfVL90FdMUvE+AXLeNWSCVdLgSrtptmKUGYQt+snX0qEDh20eDYqBBTTZEcvL6jCoU4IOgij3fQaEBRyLp7S6h4iDJZazVGTfs0EU1O5HOCMqebypEgbPFw+8w79/nIWnSWhF9WpH8IpcXlZl8q67bP7xqkp35JUJ6zDTPddbev7RAt+YHqrjPdUyGAYyzE7WPHxvNEGQW86DFRw2ePJxweIaKZ8VFd5wQxnT9WGg5NY7Hjmshw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(42112799006)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BPMVNtgVrmykNHwaCp0I2aXHm6EUPjYlkALVYaUIvuT9Jy2yAOtEXGy/NvvrqatjawvvPiRSBiny16eiNXH1ORAQRWUOaYEa6rGVMrYyPH7GY9+4uQObPEMJswc/utXBXYqHg4tvX73yVRWdPjtvan/AnPVCydIbDml7GHo9Jo2GE920wLm0o8089spI8Av9eQ518XtygN7kMB5wNbtWrs6gMtKwxdJQysZR790vS+5RK4c9Z3jb75nuLdq8is0MkTMKfv71+vUKUofaaMAN+3qRKQMydpkA9p18BAsCJVUrFSZ3CyN+S92+BR5THBZc6VJ3rcviuRY5V+SjkXwuPScwV5VbT2RDrG22cQa/sV9EYF1crHgX8/ptHV/HkrNiyCgLUBGbU2HjwhwBigc4stjP+6Y7PNinWkJCNNF+rGwCAAU3GnGvp0y2uHy5QRZB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:23:59.4859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac31d67f-52ec-4fd9-2abc-08dee98f3408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6433



On 2026-07-23 15:55, Mario Limonciello wrote:
> On 7/23/26 14:47, Leo Li wrote:
>>
>>
>> On 2026-07-23 15:18, Mario Limonciello wrote:
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>>> index 05d6915f9a6b0..079d4ccc88da6 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>>> @@ -287,10 +287,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>>>>         * is enabled. On DCE, vupdate is only needed in VRR mode.
>>>>         */
>>>>        if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
>>>> -        rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
>>>> +        if (enable) {
>>>> +            rc = amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type);
>>>> +            drm_dbg_vbl(crtc->dev, "Get vupdate_irq ret=%d\n", rc);
>>>> +        } else {
>>>> +            rc = amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type);
>>>> +            drm_dbg_vbl(crtc->dev, "Put vupdate_irq ret=%d\n", rc);
>>>> +        }
>>>
>>> For completeness in error handling, shouldn't you pass up the return code on non-zero?  It looks like it could pass up to DRM core then.
>>
>> It's not shown in the context here, but the rc is passed up later:
>> https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c#L295
>>
>> - Leo
>>
> Ah got it, thanks.  No concerns.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Merged into asdn, thanks!
- Leo

> 
>>>
>>>>        } else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>>>>            if (enable) {
>>>> -            /* vblank irq on -> Only need vupdate irq in vrr mode */
>>>> +            /* vblank irq on -> Only need vupdate irq in vrr mode
>>>> +             * Not ref-counted since we need explicit enable/disable
>>>> +             * for DCE VRR handling
>>>> +             */
>>>>                if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>>>>                    rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>>>>            } else {
>>
> 

