Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0AC403E88
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419333; cv=fail; b=UcNXSLwZUlcoEiUjuRHuaamRn6o6VVM7d6KHK/3R2AuYtTI5Zyd0lq20KeGtpLF5Z7TaHa1lY/o97+5HERkuUNQQJxaMzcMGrCVEK628nlDuldaUGd46xLXpdKfAJly09la/oJuBSbi7LM2M8LCue72+Eb8NiO0Q4Yeqgme5A50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419333; c=relaxed/simple;
	bh=XtqiKKN1jHTZ1tW4kfbzfS2GecYADMOQfsetMWXexcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K4WWf5Fo3lQxeKVyy3alduNl5JvIajVpCP1Fc2hjzma1zfjPA1k5YQ0KiFPpemKMyAHQGbvh2BxPAiOqudW3zVGl11kPc3ju/rGvEgXIaRJurHFTY0WApDWoD4rgA8oRHfN/+40NlhVDQz8pB66ZDe7m9zdxGQNLEnVxxe+/eEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GfNLHr2s; arc=fail smtp.client-ip=40.107.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GfNLHr2s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hp1e0PxWWW0c9r5vaS+/4vCyQMJMF3nO/1vyEiONQaRvjLFtDLNLYdF878rY1ZmKhUCFgVdzNOgQrQ1R9EdEiFx1Y8yZJTJl6mbKXCBfs2ccWLarmu6wz0nAAkzO+/B7HpT/8Rlq8aLkV/f33mTNngjrvK5NiaOwfSX3Qmsy/ZDcYxrDR6I2kp9dTYiMcOQJihIIVhvePKg5P+hwYT/RSYpY9TzlowzdUkzU5vVSOJVbpbCCIQeoVv+WTj4/TINdzIz8DgPeS8gTTDfWZvab8LvvdDbaiOVKwzbE+0ktp9Nt1N8dJ+vb4PfwBDJJVpr82fry0JM2nU2zaxieoqeB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+MACK6EFWuaR3VjSI8lStQr/+lCp6BDwSV24ucSJ+g=;
 b=G9CVFoadSV8Qm/jRe/N8Ap35GNfrAtG10ZWsSdy91N89/8knkh2LCk/Bp+xC2ovukXz6y4GERdBOGMQUsnF8KN3lC6AFiVxaGY0Xpee2y3CeJAMtiPQ8e+723rqvztjK2lT53FTu/KI0TX1nOydONcseSVGZqxRenKv7/WFelJQ/ab//eAXzMBkH+U1AwJ/ob2A6+m1YQZjvGzsvqgSkTthLd7beR9BxeakBWisP6HxuAFsb2atKUyDHVTPQqdh+D3ApBFY9/tqCK4mkG97BYk7/wvvIZRV+hciJ3Xl0tjGpjvNcJDMQbIG7eqVDfUZ4Ym1w0bUlBYa23Tka7dbbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+MACK6EFWuaR3VjSI8lStQr/+lCp6BDwSV24ucSJ+g=;
 b=GfNLHr2s/mfC1Dq5nIxA5B2Z28ivuMtXZDma4KDpTZxW72fxZ22M2M1mzCPuhtr8z30hgM61/IJIqOxghrOHfUba4PMWx3gDC5n/4KcfJ71Yydfr8aQ6j7x5aSb36LjoVe7AExFzYinCgYhGefvtjEyi8czA4vhNCxkj6PqVFLo=
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:48:43 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::30) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Thu,
 30 Jul 2026 13:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 13:48:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 08:48:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 06:48:42 -0700
Received: from [10.254.93.7] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 08:48:42 -0500
Message-ID: <3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com>
Date: Thu, 30 Jul 2026 09:48:36 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before
 sending event
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
CC: <amd-gfx@lists.freedesktop.org>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>, Alex Deucher <alexander.deucher@amd.com>
References: <20260729173742.950965-2-sunpeng.li@amd.com>
 <20260729223316.stable-0010@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260729223316.stable-0010@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3e345e-e3f3-424e-02da-08deee414531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|42112799006|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h+0fv52cUkawSSzmcQ4FB1CN7tzYBl3s3JefkIawtm8K7eJbc4G+Usugkv7FJIj1Bypp1a2hDlYvdP82cp0d9/J3sKVn2K6e3/OPsKvVl49Yun904yOOpWq0a/lo7LwAr6515JnZIPrpfkOZjnVP7vxAREFQSF8DAsCMzoYA3V+m2QRnxLukdvmlP3WCGj6YjXMNbIHQd1mhdMK9BAjzORhqzJgWkOVYyChwAQvoIZgiFevQ4oK3AmmEYza9uWpxGZSmdipq9q9oGnF7+TNpPen5oyrZMz9nmoRka3iNHRVk7JUFTDgk2RXazaxnev80jmCIuyp4dZcrTy0SJXTyawLxIAqw3CAVqWK3nfWciDZjZFtB0G8hjsTY2krYpn7nmDTCF0tw3mRyjMrAIJEIwadTd8BieVcLYkAEdejM87iEjezRRhuTlsIMvtltcQf+k1CrqnKL90f7OfVwBtHa0v+FeeN/YTtPWQn3vjfdTA8MAyURMFC9NzCBxX7tE0KMHgIw13PAG/+QRh8JRLqA0Queq21Yw2NDY2WezP6X5gU+dlCM6aQ45hqFmX8I47HHRFEWTzulGjaq6O5L84J490jqpGzIuWfwF1T5FFhAUksYqt4uyKzeSwx6TxGY2cdn+KZ2vCmwHGfUU2KSYe91yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(42112799006)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mG0owjadOBrpvcmqkmpw+Wl42mYj/kK/PaJiAm1ZiEoZzN7DtKyM47Hc5L3ZndBRNiij4PPHghHqrogcQPgW5YgqI+DllyXMma61UFlKjuMLVsh2MI3LUQBHG76ujdUy7RQw+1UXG6gGIVW/Smem6V1Lo2PK74rnRBmjTZhSW2IDvCETrQ0gNQ5Fw6B0tCrB4rbpaBoEoTsGwkbKpYLM7wNljiKOztq00W1rSJYqdJjzShj129pkU72SWZZAhlqsh5m6n6oZHUGPTxrD859pKxAz4EJMDl1CN5JWXq2B0shUT+HYhv1RmoA//pjDwpB19x+DfBbeaRmXvmXgvY45c7+H/EwNl5Un/D5SUFNWlslEPvbaQGeAlb3awhCtSBB+audlK6IuOsEhRRxe8LSdsLfBbsVxQtPVkQvZH2wlMIGq6bui7llB/yMKhae6xYIR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:48:43.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3e345e-e3f3-424e-02da-08deee414531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108



On 2026-07-29 22:40, Sasha Levin wrote:
>> [PATCH 7.1.y] drm/amd/display: check GRPH_FLIP status before sending event
> 
> Thanks for the backports, but I'm going to hold both of these for now.
> 
> There are two unmerged Fixes: patches against 48ab86360af1 ("drm/amd/display:
> check GRPH_FLIP status before sending event") on the list, and I can
> reproduce a flip_done/login freeze on DCN 3.1.5 with 7.2-rc4, plus there is
> your own Cc: stable follow-up on top.
> 
> Could you confirm which set you want stable to carry before I queue any of
> it?  Once the follow-ups land in mainline I'm happy to take the whole thing
> together for 7.1 and 6.18.
> 

Hi Sasha,

There are a few more fixes that merged into 7.2-rc5, with one that is still in flight to mainline.
Here's the --oneline list of everything:

In flight to mainline (SHA will change):
    18e3dd9ef45c6 drm/amd/display: Exit idle optimizations before programming

In 7.2-rc5 mainline:
    fbbaca9e20873 drm/amd/display: Fix missing DCE check in dm_gpureset_toggle_interrupts()
    82730dba0cf9d drm/amd/display: Fix flip-done timeouts on mode1 reset

In 7.2-rc4:
    f39283eab44fb Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"
    48ab86360af11 drm/amd/display: check GRPH_FLIP status before sending event
    8382cd234981a drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock

Note that the revert target for f39283eab44fb is not in 6.18 but is in 7.1.

The flip_done/login freeze that you're experiencing is likely fixed by the in-flight fix.
Link to 7.2-rc5 rebased change: https://gitlab.freedesktop.org/leoli/linux-asdn/-/commit/18e3dd9ef45c6d1813ca1b629e294b151d38149a

Thanks,
Leo

