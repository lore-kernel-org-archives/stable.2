Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347D414A08;
	Tue, 15 Sep 2026 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492256; cv=fail; b=IQ9bkGGDTujpGMHiB+pCYWLyEM0AbkgZVMq5AxsTYV43nrw+Cr17ELdiPJ7UOUkWhgEEd6dkm/9PV8YsQpuBXW6F9wPRtkfBxfajZuxMbpWS8ngFk8XWpXHvcwtMOMFN2smOz6yGfVX0eAmkcAKRh3uivLskn1m0ExPOybj+MYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492256; c=relaxed/simple;
	bh=obd32Atvfu2NjZCYPrFqKg6NlKOh1Fc6a7a118NHOFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imfR/gxtGz8k/Z5skI6Asmx8Au8LdJeQpUpFF7O+ngOQ2jAzDFFOX7Lf1c3H5Y0E5v3azI4KvHqAsj7ENkiLgKwN+BEuCm5KkZ3Y/nWoLWMnWZfz7P4uSnQc0uuUM6bYtM2huMG/15mk2tYUS11jfOZnXp4iac2tIzMdW1MEZ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFSY2wTf; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFSY2wTf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+gCexANnBx+sZMyfD+o4yRJwxsFIRZrU5lHun4TAT6DYcDrgC22UDtzYcIZlvClGi6R7gRGxJr9J8MQo1fw0klznLPJijT8lFBIFNUhpPD3b0cudBvIJStjjDJFj8jasPsjTtCYOE67Q0l6RltK4z87RSnbRrdqLUAIVWs+8DRRxrmzkUvG/R6nwgXXN+s13koMSLOJoKqQX+nVR9YSRcwm4fmfOWxFPbQfLKEqsSf07JBLSoEO4eXnW61iIR4Lt5L+Jcx7gtAmAMn3Iqv4oW3nun6TjUr40iCL8FczxKxXveKZRnTQwzfIw9+8kMs0gs2e+J1k47WLREYwzzHCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5OktB7m5prwPLLV8xg1WCDFFQEbEETphzA21HYPdHY=;
 b=WIZ9ihL9WqbgahvcvzBuF29u7Ir9JzW8kfvkMpKlj2pv5TXFeyAuOjq/ZOTxWjo6RKTq+DUMdXPCtqUGoNkXiAIBzeKDyhHWD98py3z7LAu6y8hAJX6X6m7O33710QD39IIIHZ4gFRgO6O3rMLyW2kNuzouUtAjSkuVcmYxMNo/UiYuXiZu2Q/HPF8JETq58YyR9wHLaFHkrvpY7kBnZKdUSO2BRGI2BnKgZCmCw1csrg7w5XoweTw7cqI0UlaQtZnMD5V40mi7KbZITCiS7WvO9LOdtpo0uW3j5oxRmVq4psbeLSPTFJqAjK5Chdnl/GbJPwMlF49HewDKtdX00Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5OktB7m5prwPLLV8xg1WCDFFQEbEETphzA21HYPdHY=;
 b=jFSY2wTfUOUur0FmG5MJBeBbDNEUtfTAN71ashgHPmDK9L24xj8ZIvkWkgRGT2VG9I99CoFQduOqs0QKPBujRb9awQ01M0gp6ZQEa1PQDL0sMMMF0APE2WEncfUgz1wshFvKTYcJQ4dLiHBKjODBfSrjUuikys1/ZsQK/u4OFMpvToI2vCRcnLyjwRX5g/XSohxAvGTkuvccPFc9GQXhxrdhlEc+Ef2Y+Su67xl/SUIM2m3TqLVfYk227JxhmeE7AuztDzYQgpo6rJnJBnpcd1SvIGKkO0BhremICDsvdiFnW6ouVO1ReuJhgKBh4kqLHS/21Y7a/duPcV2cY7AXhg==
Received: from CH3P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::7)
 by CHXPR12MB999220.namprd12.prod.outlook.com (2603:10b6:610:2fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 17:10:48 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::ac) by CH3P221CA0011.outlook.office365.com
 (2603:10b6:610:1e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 17:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 17:10:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 10:10:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 15 Sep
 2026 10:10:22 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 15 Sep 2026 10:10:11 -0700
Date: Tue, 15 Sep 2026 10:10:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Sasha Levin <sashal@kernel.org>, <skolothumtho@nvidia.com>
CC: Wentao Guan <guanwentao@uniontech.com>, <jgg@nvidia.com>,
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during
 devm teardown
Message-ID: <aql76pp8QQ2XIVcW@nvidia.com>
References: <aqR/n+VtlgpjJrAV@nvidia.com>
 <daily-reply-0001-re-arm-smmu-v3-devm-teardown-6-18@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <daily-reply-0001-re-arm-smmu-v3-devm-teardown-6-18@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|CHXPR12MB999220:EE_
X-MS-Office365-Filtering-Correlation-Id: fb29d263-7c2e-4046-d0a5-08df134c49b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PPFA8hUAte4DDEe4/Pdf+7BUM4eeZ3ZLabNdkTeYlh8eBspZDr4/cyKNobOqYpDsdtgo3X08D9/M4FcaOWbVp5L2PgOtP/fh08JnCZpdeR57+/dafoaeqrvvCApzqpItl0uMKUNsIXwSUUP2sRwrJ6ZSuywVuSaYooQGfsg1W3h8kkdVb3dDdmQeL+ZN9zBVooU3HyFRnKB5XeptqbVS9RgUoCeue/p4GQDZPNJQJnO8YnntaAdvws+Lt2/imjOdY36kQeTRNNj1Ma46oDTYxiZ6Hr8jZcuU/JPwuiRoHw5B3tSu1Ye+ADHpjhSOI/D0i9zwSgKJb9lMd5NvjpxmheAEpSytR8Iq8IH2AhOjtV0PnV1Q6X/WCDukvIBf53xXGHkqUolTtHOFFfa+ns/I7zTURRp89jJ2YVtal6Z7wLkYNh9JtZCgy9K0Suf6l/Vs/TgRr86AVGIAPR7wmLagPWgrq6UqGP/IXz7gZmz4LcdODGabivbCMVUcmKZ5DzOy5hFBp+80Dfc7gv9C5iy3G3M1P8IA7zwH83KDX08VY4ZpR9lkAXiA8ba01wdAyN3Ab25CGpokQ58QSfZC2ihoXmbSdC6Alo4fUjd9MFHvMmMZVwZ2FZC7ltZARBmPqW+pLL5icR5QHy/VCFstplpupnromJz1SpzxZyPSmWGDew9IIKAvl4XJoguXi8pF5Ia2qfrtOmq9ZI7JKnqhltEFfg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9TOQA75yDUSBtKtoo7HzvxsVqA7MZqs2C4k5eFsKweWJjjETDcbmj5ZPR6do4W4FR14U6DsQtF50+7sWQ5u3qv9zCjiSp2lE309QCBtAB/8eg0hXm7GLRAeMQvQnD2PQivamH8m/bBJlFe+2xFgCjLsIXmoiMhMH4SXuxjL6i/QigWW80fWq2nLrk7094ke5YRS1+M1TuYz33DupRF2XpxWzOK3dqJNc7GTG/C4WEQYNkO2kUIa3tBNx6MrHfo6HkhYDP97qTL4hkKPpfNi2ZmQz2H/SbcqW4J+k8p41vdK0mK+z89/PruG2Vq2kBe86oIOVqksokTn2lhU6PbgnGqPWtl/DF9BMZRHq677Pwtv1gh4/aIp2tSNh89OqBoge8lWxkFiG1YB/dEieeuG/VGbhcBGR6VnNNXztGqXWPjDwWlg+XJ5Xvn05wZUb8i4i
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 17:10:48.3865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb29d263-7c2e-4046-d0a5-08df134c49b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999220

On Mon, Sep 14, 2026 at 10:03:17PM -0400, Sasha Levin wrote:
> > Patch itself looks good to me for v7.2 stable and v6.8 longterm.
> 
> Queued for 6.18, thanks.
> 
> > But v6.12 longterm might need some extra fix, Sasha?
> 
> It does, but a different one. 6.12 has the devm teardown conversion and never
> got 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on
> teardown") at all, so what it is missing is that commit rather than this
> ordering fixup. It does not apply to 6.12 as-is either, because the
> tegra241_cmdqv_destroy_vintf_user() hunk has no counterpart there.
> 
> Could one of you send an adapted 6.12.y version with that hunk dropped?

Shameer, would you mind helping backport your patch onto 6.12.y?

Thanks
Nicolin
