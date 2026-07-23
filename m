Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327034AB00
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836083; cv=fail; b=FWZj6L5LrOsmvViuaEcMfn37ThXYtE4Xlv0fz+nziaJY3X+R/1D+kCXaq6TU1v103wAu84lN+imkkiXWLHwDjVTBpcOgxmLoBDZhT4YY/VouQJMhsohvN0J1gkaRloAmFpFxZtltbU0uJEzXd77RCU5kECgMTnQQxoUj5qrdENU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836083; c=relaxed/simple;
	bh=FzWL6mKemCRqYfHDaFPkh4cgzRSXXEwlBqObjlXmkeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SC6sclCgJSIyPw3vWZlD/oo4sLQXcBBzsjemSSR1ITM1HpyUOcZ8bF42ZIUhNKAgQHx3PoXcC3jBJVL1fOzM5zDgOWIAnNEtQdbOR/8TV9rLj9p+8ORNnaGo1MMIykcFYT3VMFPBRIrdaD/askfYjjRdDM/Wwi76cwdo9QThS9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qypl6ZQG; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qypl6ZQG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxq35+GYOamBTW8vvlbMIHMu5rQydIlEG5WXKDVtsxnw7+aw6f9+u/EVdKAAyLDZswKZHGgOA8X9s2MQ94s8+vTODKyqw2A8BR5GdGWIByzKELl4tm0Mgrpc+CfzPJT/28PhXPHk7hSmoySpza+GmHgRuv0yRTpnXpiH3cOTTSFBSlH255gxlHmu5OHwtO2qo7JGqgBYveBM21pKQSA3/pi0+kn8fDCwJ4BAUtRJ8otlB/QujqvkROvPza8sUWFjQeGSu9CLOKYREkq68//ODQNDsjPpFYgQazl38pVg0kbUD5lLmrkNswtt92yi7filGyUdA9JoyQIJbrSwGgOc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fml1NVitM89eR+iKL8lAmRWVQebDN0uKHO8rO+oAT4=;
 b=p8+SiXdNhUaiOu75+b1ldJjVE+K6/W3wzuEtpvOXhMebV2sOWS+qOnzW1Tw0XCvHZYSj6gnJuMWAGNM4AvAP1TSCbsiZb4lXLNApe5Geqw6SRguurO+wD+i78shU55joHGb9W4wMYNuKjW0p02VRAXqa1KuCizTDNh/YDhBgn+sUprMzvYhRM/nCFiIEDZJRK+sek3YRFH2KD69Wrb1o1aAeoSVY3rsqipFScQ96kfgeE3vW2r+02fQIwhr3R6BcTSIUBRmmRqEfvUSz0zINMBV+/B4cADtlDMt0iP/9GaICFfFxpapXXvQPo8/uw/mQYvlJt1pmznlPAQriKRk5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fml1NVitM89eR+iKL8lAmRWVQebDN0uKHO8rO+oAT4=;
 b=qypl6ZQGGy0Z65vm6qWjRFhQGDmzvIB4ikqHoorFcR8FLxgiMxE2Sxbeq85tibaoROW8QbX83HqEiTn0QGPLR4mTbF00uKVrqySVEPjrbAZaLMja869ghd8qFaN/OJnMr6cF/ouWlbBsEVHHpYoiwFGTkCiLzyeiQdv5c7Kie9M=
Received: from CH5P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::24)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Thu, 23 Jul
 2026 19:47:52 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::ae) by CH5P223CA0004.outlook.office365.com
 (2603:10b6:610:1f3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 19:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 23 Jul 2026 19:47:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 14:47:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 14:47:51 -0500
Received: from [10.254.92.129] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 14:47:50 -0500
Message-ID: <476574f8-3bd5-4fc5-832f-e94fe1685870@amd.com>
Date: Thu, 23 Jul 2026 15:47:50 -0400
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
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <66071e47-2743-48ab-bb3c-8a8ae4ec199d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: a53f07ef-4003-4a22-5f16-08dee8f3482b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|42112799006|11063799006|6133799003|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kmHXkTBCo2/SYKPaV/LhhtvbxYhl1fkyMm3QQp4RNiPjS6gdv45NqTFo5o7FwwCQ8B6Wooz9o3eP+tbTnScilEUrL9yfeq5yKIGmerowhnt6ZA2nMzz8diqik/0zaC+Sj1zVUESoiWzEN2yutQWRlXpy3/UzVnZYZxuOlFQBPMJeSixhQWnYS/QpR4dvdbfnGdw474UskSuI2aEYe08E7jPN+AzZGfNkGittt8BF8vKAT8HsBAuwdPlkd391TiVIz4GxVd/+8zcnip/NcadUuR4wuJjd6kKOPJ8i18D9j44kB6PyBdXBNoFSE+R1GHQoQmyHRpS4zn++5mlgmGENqeCPGzTSfH7O/KkIQT2zOEqCmJuUnJs3SRRBtijuJUK+5b/ceNNVgFrJezs3o54vpBut+4d9L1RS6QbqHcoatdFfepkKZo8lwfRv5+Ovb2t1Lf1AxGu+W1642kFOY5E+L5oGsIyd83jr+/TRyNFkkt8cymMJ408SIG6G1DfBh6qaTYdv5+WKlgaKKtruHkibuESZr/gy6yKf5OSMtkuRZ3bGiSTkNIpXMOq3LHw3JUFKn1JqGg1++GYMFjO1KP5pFRadsd0diXwY1qrXxxq8dCCnW1MT+YL9Xpbdh8vH8iyUDpZ4kaQQbWtGVnF3c0oqNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(42112799006)(11063799006)(6133799003)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EzPOtBU/WrcoFz2JMqKCmBzrz11Xs6TBnob5Z+2/ccdnhd1uaQ91RuUi2eJBNSMYrl41bsdvhHxKbjhdeulQHSTjwviWIeLZfPGYUCAKj0GMYUZ3xOhR7R+4UfniLE/Ts4DUioP1U9VzkVQWSouycoZBOr5zbxXSiJE5xVC1N/7iiB4mGovtsmQKJZyYDOK+ziHakiEAXaElIYvm8tsJszt+J8WzaSY5uKRFajkcKNg0w8eCp+MB9hErGEjJj/+0tBlRuYEMKzcRUNFwnSBE9xE6lID6HSKGvl3wfIU9jdzigso5K1q0Ili6HCtpl9D5yP1m6ELlOVmpv2RsNz3X2OWo0Cfx4/yE+9ns3bKlJoHCVNxSeKJDQ0YJeWfhgmhzskOEJ+tRkL3lAzbSsF4kFz05Jq/OD2IEMZ7foCKfjPpv98dy1aeINk14pc6HOkeu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 19:47:51.8136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53f07ef-4003-4a22-5f16-08dee8f3482b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754



On 2026-07-23 15:18, Mario Limonciello wrote:
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> index 05d6915f9a6b0..079d4ccc88da6 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> @@ -287,10 +287,19 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>>        * is enabled. On DCE, vupdate is only needed in VRR mode.
>>        */
>>       if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
>> -        rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
>> +        if (enable) {
>> +            rc = amdgpu_irq_get(adev, &adev->vupdate_irq, irq_type);
>> +            drm_dbg_vbl(crtc->dev, "Get vupdate_irq ret=%d\n", rc);
>> +        } else {
>> +            rc = amdgpu_irq_put(adev, &adev->vupdate_irq, irq_type);
>> +            drm_dbg_vbl(crtc->dev, "Put vupdate_irq ret=%d\n", rc);
>> +        }
> 
> For completeness in error handling, shouldn't you pass up the return code on non-zero?  It looks like it could pass up to DRM core then.

It's not shown in the context here, but the rc is passed up later:
https://elixir.bootlin.com/linux/v7.2-rc4/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c#L295

- Leo

> 
>>       } else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>>           if (enable) {
>> -            /* vblank irq on -> Only need vupdate irq in vrr mode */
>> +            /* vblank irq on -> Only need vupdate irq in vrr mode
>> +             * Not ref-counted since we need explicit enable/disable
>> +             * for DCE VRR handling
>> +             */
>>               if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>>                   rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>>           } else { 

