Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200826299;
	Fri, 11 Sep 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165505; cv=fail; b=UAURXeKqseesc6O3nbD/DSBpkdoLBGaOMAbdzLpclo2lRptD7cUaYrQBOwjC3pNCWq3J0Bq11DttutsHhhjlKCSXm3Iby7+d2tMVtoq2EezA5QnnWPYFcxXnV0Cn9X6FRtYlSR7WaTA4U8V5d6TIBL22auaptTFJBQSn5zEXEHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165505; c=relaxed/simple;
	bh=wD4Kgx7Z0d2GwIZSUVvbcnhGEqfAYELSb3xDSOuUYHU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGEygLDDyWd7vJbY1A6R4sdYcU4kPjFzHLGm317Gve+Yf3APPwMieGcmbJOUYbo9MRbhomyQzRpYNP5M8VJeErpp/si0w7Mlta/+xDhvMVrvkhb9BF/NI8Z7El58S/Wul0xvLZ1Bgz7Jffp0gy00kcTHCiS/zIKBJnpn0EQC9Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGx+G4aC; arc=fail smtp.client-ip=52.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGx+G4aC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqKs0c07H+J8pSlTjDiWf5c0K2AW8SIrPt/9DxXGI4jxWqwhGkLK3Zn/5rS0T26mSt/bQMu+xLAHleq/1lw1Z0RxCv9ePA/Jrl7FRA7mtGWIrNHULSP0uP9Y3/y+UUd6gDwMfGeu8NrL6JE1lYTvNrPWYG8wsdl9j1DBT5Iufwltz90GDGDXt7bWSnfUIcmEPVK7wUTkZuxZaHS3KQd2DJIujTcjVrPdLWz8VkesoKKxs3A0sdyc/DZNcts3iebxY7ook2QrI8C1oZm0kCYy9IFxfXQFm4cVoYj5TElOaGbIQFhfLFNX2yXnVTSR8YJBu0evjH3lapX7nlYKOXGsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIDOEICOt4x5hTo9wOxCSTq4RJfWI5CvqmdehNQoNPk=;
 b=ckQ+I3h9+rLC74G8BkNIA+hztJSxN5TxRIx4olA7jfk/wWb+Kv/MGQ6HAGDqCHRajUAc53oRG5RC2cnSKKN0qJHLuUvegnqEn37sfKvr/FkYrYPsM+qMEq2Khg277nXjfXTf9zlFh3XtNunUyClv1X2pe25e+8bhnx67MmUFGY1PoCPx4xtla7JAJCta62DMrPjr/+XKzXcywySGQxcfbPlir+Sp80xiYtIDmNldHj4xV2Aw8oKpWDtfNJXeGDoqCIOZRDTgj6FaRgvJxNAi8V13ucQZHdotYaE9akYD92cp+eSpLSvi8e+cPl0NUDrWg0o2Neb5vaRSe+rGaeGL9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=uniontech.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIDOEICOt4x5hTo9wOxCSTq4RJfWI5CvqmdehNQoNPk=;
 b=pGx+G4aC0jprbrsZRCQCeTlvONygUrYG3ykJoyZKoJaEDDpDoolwVg4mwjBcNis4Wc5iAjVVsehRdOFOV/jT5YsUrRnv2MK3HZ8s8ySl+XDGX6buwiD5jO9VKLzgy6y2PcfLY9VT1ghCfb46wxcUAeevM1Iv+AUNg23GGHh4cfRV+favPZ4GxvzdRiZ6G87xrDmmjwMiOEf6yAK1wWLPW4It9EULYrqj0dDuFFTc9TyYSpRMc0vBTnzoeoCNYtUU7hodqNf5UeOup8zyiwwhwHU3jqcWhzsSFxAkeci3LJ2vEwFJej/Xg2h/QWgnao8Alag4uCX9YRpMtM9B2bBopw==
Received: from BN9PR03CA0253.namprd03.prod.outlook.com (2603:10b6:408:ff::18)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 22:24:55 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::19) by BN9PR03CA0253.outlook.office365.com
 (2603:10b6:408:ff::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.8 via Frontend Transport; Fri, 11
 Sep 2026 22:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 22:24:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 15:24:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 15:24:35 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Fri, 11 Sep 2026 15:24:34 -0700
Date: Fri, 11 Sep 2026 15:24:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Wentao Guan <guanwentao@uniontech.com>
CC: <sashal@kernel.org>, <jgg@nvidia.com>, <will@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<skolothumtho@nvidia.com>
Subject: Re: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during
 devm teardown
Message-ID: <aqR/n+VtlgpjJrAV@nvidia.com>
References: <20260910065429.1703706-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260910065429.1703706-1-guanwentao@uniontech.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: c1446d86-e23c-4572-8bd0-08df105381bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|10067099003|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	DClE4X4qXMNVE2R1X4cETnRrslVMjraL39BpzUR11SaAafXnbBykMVsWRmB2+BImluS2oTcTnjw90+pa0YdH5iClN++ps0/pKW/bzRtAFU+VW+fYjVdsvCzT+8kFDE30yBctmzjiCNc/5O0mWovgIkdayZsGeYAowrnnzcw+QfrgKXiSYKvfBPN6vJSp5kqUPji79ZUm8CzPkqont3ttQtxUpQMGzaJVKncKv7C9CNpcLwyoJML+s4kkw2Jcnm+XYa1iLkdHx0VDaDVd4P+jA5kWHuIgn/ouIG+epIzY1rltBieg8M0iovqDeVpVY3IOKnTDPHMW2VNQ99cIrlaJbnImTauD6/QWIMkhS7VoFvJFheKp/yEJRX7R2xhG9N9bTEqm1camPkRCnKUQyahDwpF7pmi1qxLwOZo4ubDSPu4qAQPuKGgO7bqvbfexkgfmjyu3nLCgnZ41RWHU+W8u9i1gV0cQlTYopsVxHJ3byCNyNzB8no9DgCavWTI3OFZ/cvY6xIoSRYo9GC3MRF4Hvr0K8Cwi8ncc0WsceyJfoUvLIgwHtRHhH4PxOQd/UEJ/ER3d2G3yOj7o4RdsP85ra4x83IfNesMf344CAKu0NAiTaFAlLsa+PaKSLC9Crw+iVh685JV3i5vYS/hQ5prOKT6baBt1XxshLz0wTIhWtV2QaVqrpKORsxqpSmWdfjv0NrC+EiOD/mdypWcqXnOKMw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f/8eI8K7Sl3tIBj1hCC2PQcGOeI2x26p3eXID4jOWJpCx8wXnhiOjbbdyXNYT0XoM0U/to7BcpnUV3TPsESuGZJlmJYfyqCTfSxTavqk6Yg4OQYcANqwK7kuHVyLv+ksUX+db1YmY1W7OiOB6hADebNt+d6mFkLO8Hq6hYhqRoL2cIM5do11TceQ0OdFlKzBCWEbtgtH1Q6gzWMPgBl/M+CeSvUlf7uw0LUNhu0Vh+OVJi1hCKWZ9RgaE0wiFnFl/tlZCfugQEHY9BZIO01QdDMleAOwP82ZbuZMzpSgFDo2e0I+E1dmuruMcWmbZ3UGjdLyU33ThEToFf+ei1LEPoSXTI3zkh43sVZ5ruZWtpouwakWet7K8+tYbYawENturxza9R0XsdI0VV+guaPDdk/SLOmrSe6MlMpkmZuOrNTpzw6EB06FgepPkPaCy8fY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 22:24:55.3097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1446d86-e23c-4572-8bd0-08df105381bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

On Thu, Sep 10, 2026 at 02:54:29PM +0800, Wentao Guan wrote:
> The Tegra241 CMDQV teardown fix moved VINTF hardware deinitialization
> into the implementation device_disable() callback. However, its stable
> backport preceded the conversion to devm teardown and could only invoke
> the callback from the shutdown path.

Hmm, it did...

[correct in mainline]
git log --oneline v7.3-rc1 drivers/iommu/arm/arm-smmu-v3/
...
9ff145a25c5c8 iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown
2bd22a0d40503 iommu/arm-smmu-v3: Manage teardown with devm
...

[inverted in two trees]
git log --oneline v7.2.5 drivers/iommu/arm/arm-smmu-v3/
...
78fd5a2d65f35 iommu/arm-smmu-v3: Manage teardown with devm
f9b7375db3b36 iommu/arm-smmu-v3: Add HAFT support for SVA
5994617e09ee6 iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown
...

git log --oneline v6.18.51 drivers/iommu/arm/arm-smmu-v3/
...
2235eafda9b3d iommu/arm-smmu-v3: Manage teardown with devm
d903d99ffd22b iommu/tegra241-cmdqv: Reject a vSID wider than the SID_MATCH field
d2ab08437e913 iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown
...

[missing cmdqv fix]
git log --oneline v6.12.109 -33 drivers/iommu/arm/arm-smmu-v3/
...
981686f413776 iommu/arm-smmu-v3: Manage teardown with devm
...

Patch itself looks good to me for v7.2 stable and v6.8 longterm.

But v6.12 longterm might need some extra fix, Sasha?

> Now that arm_smmu_disable_action() manages normal teardown, invoke the
> implementation callback there while the command queue is still alive.
> This prevents the subsequent implementation remove action from releasing
> resources while the CMDQV hardware remains active.
> 
> After ("iommu/arm-smmu-v3: Manage teardown with devm") merged in stable,
> now keep the shutdown path consistent with mainline, where disabling
> the base SMMU is sufficient.
> 
> It is a fix for stable tree commit to aligned with mainline, so no
> upstream commit id here.
>
> Fixes: 5994617e09ee ("iommu/tegra241-cmdqv: Fix CMD_SYNC use-after-free on teardown")
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

Acked-by: Nicolin Chen <nicolinc@nvidia.com>
