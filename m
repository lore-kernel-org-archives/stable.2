Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2A30216D
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023769; cv=fail; b=eZtpxOsXuqxIzzR+zqKakVbpdww9w+YmHWaAusf14qdZ+Mjc4smzaomIIMxKm3DQXhVKzPI//isdntM9YL7ype05ORryMovnU0yEscued8CuQHCXZINkHYLIUazVXKbc/yVpsvtKafi75KegVSwE7jekcHjFF8icUPWuj5Pi8b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023769; c=relaxed/simple;
	bh=tWRBls0J0wvRTTuEwGTblzrFTvgCXCD9FdSBGsSWbd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aMT033M+1Nz82FmAZ+S2JxVkAgnCglVJNb8Hxfzsg5eHk3pPB9w24ygxHm1UNrkiUSrrGNiJriaKVH7+D7vRymo5ywdFK/3ASrG61W8xJ8bdu75g9vgnWLM6MWCJGXDutfanbxhnuHVqbMwx+xdpPVxveQruNqBFP/+NhsbGWl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B6Z/rppI; arc=fail smtp.client-ip=40.93.194.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B6Z/rppI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6H2L6dNAagiAy8W3R9QEjJsJ4K5IVHh9DM9qFI05+rIJKmlAZmVcWuqPUt64vKxlxDuFwohPtQg84LeHfc6X4XlCfpLeK3mNimotPFSOdetcW2cNPdIgagwly8ISyYxgaHG6kXdFcKu/Dq9kVVHTqYpafg2GT8iletpWK1ZDiRDJsosZWhQWfoDKmkpoLgUZA5Iw3VSTmVKWvNbk1Aas2p9x3fcYd0JKFLFIA4fbw3vNC+kfEYe+yNJyns53i4HFYeofnJOPKBd/6w8U/uiw8OAe66v5IIhmidQM0mRElL5hlii7e9QlGuOy0hWCthvSfNlTCg7ShJSCTkklBguTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhd8ZVq0XJUU6b3rE1k0F6Vbn18g1cygPAvEh67mRSM=;
 b=Obj1QPwkLyWRrvA/JEIExXQ+8nd32UaWkVywu1+bDiFgmVcTfPTRy2VHofp/Tl/mOu9Kmsq/slrMKTfYfuBba/h5AGPHJP+G64lHofSWSKLPG+L4Pv3QgjLMD/wjPPCv19OweoIfYaMbgauQthy6zjMF1qQvVaf8dgtSZLhPIkYy+Nm92Rkv19gNZT6aolQuixiFxBz6XDeuL98L3AJBnaVwjQfBI+m5O/iNWMreLy/wym1b7c5DEvqfTaEpG/H0qz0M0M9Bm+OWfFLrxdPofpAhM+Re/Zo+EqHN6tp3Tdj1Rr2Ciyhb54BEe12T5N7/SFlLAcUvMo5/YjxyFye/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhd8ZVq0XJUU6b3rE1k0F6Vbn18g1cygPAvEh67mRSM=;
 b=B6Z/rppIlON9ZTEhz2B7UA1/n20Xy/HpZz5ow28n7vDaqgScCMHfVP4cdnZZq5yB7opcCJzzH0QeYzXANCzfRQwGIgUBcBkCwNoXj3ajwa+ienE5odIIDoFGu+oW7SmlFof4S3dgzpatspII6n5sv8hqSihJKqScrq9nv8MBeBs=
Received: from CH3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::34)
 by SAWPR12MB999117.namprd12.prod.outlook.com (2603:10b6:806:4e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 13:42:44 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::7a) by CH3P221CA0014.outlook.office365.com
 (2603:10b6:610:1e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 13:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 13:42:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 08:42:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 08:42:43 -0500
Received: from [10.254.93.123] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 08:42:43 -0500
Message-ID: <ac4c0e75-fbaf-4264-8794-d3f86eebb014@amd.com>
Date: Thu, 6 Aug 2026 09:42:42 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1.y] drm/amd/display: Exit idle optimizations before
 programming
To: Sasha Levin <sashal@kernel.org>, <stable@vger.kernel.org>
CC: <amd-gfx@lists.freedesktop.org>, David Weber <weber.aulendorf@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Alex Deucher
	<alexander.deucher@amd.com>
References: <20260805163314.214623-1-sunpeng.li@amd.com>
 <20260806021809.0021-sashal@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260806021809.0021-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SAWPR12MB999117:EE_
X-MS-Office365-Filtering-Correlation-Id: e5af3f4c-a1fe-41cc-5977-08def3c097fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|42112799006|82310400026|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	U9hkoa7O2pSBMMFdQGUsFTz0ZvZp6f8hkBax7XGJU/i5ayiJKnqOCuYE/CcML0vppeFMwXhWwgP5tPXmUC+1uote9nYyEL54nuVSqRrpzwF0jFAtEd2C65jTZGcFRwAVzv1TsgxTn9xQadP1E3nlRIZh8bP+BgQQBfjQlvfGQIBej5ZPZIw3MuN+J4G2aby17KbNT0fRADhtuyI526xn5KSXMDPXucTq6Z+lv2Mw9NfjKT8Z6TXK/vcpa1EYXLN4HxnQTMCO+kKxS4zVoQResnIW3sPhNQQ+ooTe6fMZSigub3KjGF4XXdUiQaBefO5ayE8VqvAHOSMO6TYrL1edOFT0TY7+l3R4AZaK5WXnheyGe0U0zNQi5VkSN88tU39NNK+uqZcnwa/IghSjsKFWkCIHBTssJ+Yy73DpPE6e7+gqwNtdyeyJNzjDxHu0hGtO6CIM1rWCKs6jv9JWhVeU9TRDJLnnkzzK5MCEiRjzY/EKf+tAMXxuuOpICcdU3YeVAlbofdhtBjMkTLza3j/NjlSKrazo2nSUtm7tAXAl4wnKg/0MOykjzVrCfB/5qn6wGyLxPHuC8WOop+grSdk/9Pv7O1dUFdmaAj4DlE4hKqN0+ErvsI1ZM7TIN6ZK4emYt7vizOcaewni55l36+iI1DnFM0E3Na9Wwnd6U6RLi9Xi84Hoq06xgeBpg9//APKeJf89BGe10fRN0bnQAvxRug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(42112799006)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0ps2U9VfegPlPxCpDEUB6UmbkclGVkLWZ890RDD8eHy44LllfhyqAb3ib9cOJ+31Oz/Hh8uQznuHf/pWbF6UCy/M3znmWN/ID7bIkm/SWuycdS1yukoQc3svsS16gWQWaIr/5tMLu0oYsvUkYVxc8mzExKX8pQjKmv1H9Lqpthf8wRTxjaOlcOgzZAU4Vf252B8nXqDpw26LjNVNEE9+xJ5olNbZDLK4cExaPa4AObyUGpnJ7F/BmzFI9hfVBNmUvE6g1hh5mxfH2XfzUqcGctmRnFdBKK8ltJJXikbpBYpJX2zfjqMCaDG3JHGvTsScHdAr+6SjzwE2gPHGNpxdzKE2PbGhAUgApSarecYm5/xN0FBGgN1feCUNoFQ8oCWZKQE7rxOn9zCQTpQ05SJ5jTQzjE0BIj7S/sibsZY8aGaWCrSf3WTL+1kg92l/9bPh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:42:44.1841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5af3f4c-a1fe-41cc-5977-08def3c097fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999117



On 2026-08-06 07:36, Sasha Levin wrote:
> This doesn't apply cleanly to 7.1?
> 

Hi Sasha,

Looks like the tagged "Fixes:" hasn't landed in 7.1 yet. This patch depends on it.
See the 7.1 backport of it here: https://lore.kernel.org/stable/3956c589-2fbb-49af-b0bb-8aeff0cd56db@amd.com/

Thanks,
Leo

