Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794897752;
	b=Fjy54Um2RFbTKaftidzcwlvlGO8XxM92GyydIJJLk9Zfir0GBcsHiyvc0kw7xzQC4nAW
	 vvbKv4M079VjLDnCVcEUUeQdSs027d1uBG0A0BMLXGbYS/zdh6MKqeXBudNxL5g/PDa+Y
	 HUEDm9fLlY/YsewVpKSveFBUg6GIJNtkagRoSDFNnPxrk08T3R4V4mm8tbqNPboGuqw91
	 b/pbop/r3HcqNdpyMK0s2uK3BFAg5k821t2YoR5+9RRnIY+fD+xfMzfybK2xOE4fHdE2J
	 plqRydRI1POaaUZGjbURl6/EnlG9gHE4wlFqiDN91QH4hxhOJRJ0/8q/ORNMGWoDccA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897752;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WQiT5xVdO1xOhFpbbCbp0ldMZffMEAlNq/1PkKK/ZR0=;
	b=ps/D6bDzJYfQ7+CaGVnOgRfJGwKTA8CTCwdnCKTEHUbRp7+k+baLQD6qAja4nk9Q2jAc
	 PIvmo2tEzdIGNnUE+JVwHeQq5kLRuyp1lClQDBG0FW0AjHiy64RMV9dA2Vf/cijPKBXR9
	 Y22GMcNZvMVf0IaUs7rXtZNj+SFerzdjoQIcNb8PaGMIDJ5eC8vaiRlS0joQ2KCA3MlLt
	 GNLS5NSgy55g8ZlGXOtPdBCiyZFdd5rLjV2jIj3kJvX/fQUBYR0VlAjV4IvXXpV0nBQ52
	 W+idcM+MBTbK9ylSNmG5OCxJg1SZTt+HgFa415/x2j8A2pGelevTb+f3scCKgqgx5/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gi6vfg6Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.68
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD915606A31C;
	Tue, 17 Nov 2026 06:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD915606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Gi6vfg6Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7RRnCE9RH4Osll24cDRrJydlMBxGSKxV2yilpAAZ7OFyptK3B/lawss0sIUrHSMSj2iCdnJH2ZaLd1J1Idhm02OfG/ZC7KesG7WvKkf/UebmTuYi+iXPPxYG2rnrw2fX3A9+5paHrAXU2BXEAGd9wkAdQQV980/7/A6spWOj/wf21TIQPnh5ETlvYgumwEHrDtvK+Je9E3rzySUC7M5Oz9RWQ+P40rB5OnUv49BsLk1K3G1zFhw8HVms09NcThHg1v8jrQK4W/R/nurAkgHom13lrcyvlgNJzeWtI7yjtQVaJtOV9qgvTmb+0RJDLFa0bV/6iSBuu1uwkCucG5Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQiT5xVdO1xOhFpbbCbp0ldMZffMEAlNq/1PkKK/ZR0=;
 b=XwhKlUAgxNizHjptpf2NCqSM4a6euIxYy8CO5kCi36KA8Wl4wEl+FWaniTdzyoWwGVOkDSuPBiCUunAMmCpXcQfubFXKqzIHcuOCHYFW7CmLWoK3e04cyNNOcZIq2eKfSm6L6PjPJxVFckBm6bmHQwdDXyiXHhHvz+6xxi2pErVb8KSTHT48VlUeg3WKAdfdHM1YUwCNbMtWE2aP/+NpVNkHz2IOksiI7dgAQXPpQ+6c4M1+1I9mfSDkYGM/SJ+zmNyatKDdricyDxWBy2hwkOY/nN0prWqD1nfNlxKSpY3w9ZMwLvCo/+DeCiXMxhrk7Cj7ILrjDX/rLUVHwg2mnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQiT5xVdO1xOhFpbbCbp0ldMZffMEAlNq/1PkKK/ZR0=;
 b=Gi6vfg6ZYBrWoa09gYmyamnMLXGLfyMCsotcD2tUG4dgk6xiGiWEVqtu6rxgMcGrYIw1gesZPgZjQRmc22EXiorfllSJYwz3DCD1KGEh3SwhPTMQ9LLUl62BGs6vxrowOEe27CWc+Pjo08mjHbayYAwnas8ZcSAEdMvm3854BEgm8emjf33shq6mXGv02gfVTA+0UX3wYklS4iMxbzWURp+ivz6RfPNpm0wzNPuAdfNXuT6uzjWkLyZgTBCE2m7OlGhlpfraMRa90Q0YaUCEmf0Q7vCANbgwQ+s5viyDYxgZWfZFskCF77oxTcAoAmZJWIYJ8uvtnyAS3d5pe8Lr+A==
Received: from MW4PR04CA0113.namprd04.prod.outlook.com (2603:10b6:303:83::28)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.14; Tue, 17 Nov 2026 06:42:21 +0000
Received: from MWH0EPF000DD310.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::97) by MW4PR04CA0113.outlook.office365.com
 (2603:10b6:303:83::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 06:42:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000DD310.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 06:42:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 22:42:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 16 Nov 2026 22:42:03 -0800
Received: from build-akhilrajeev-noble-20260927.internal (10.127.8.11) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.57
 via Frontend Transport; Mon, 16 Nov 2026 22:41:59 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <james.hilliard1@gmail.com>
CC: <Frank.Li@kernel.org>, <akhilrajeev@nvidia.com>, <digetx@gmail.com>,
	<dmaengine@vger.kernel.org>, <jonathanh@nvidia.com>, <ldewangan@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<pkunapuli@nvidia.com>, <rgumasta@nvidia.com>, <stable@vger.kernel.org>,
	<thierry.reding@kernel.org>, <treding@nvidia.com>, <vkoul@kernel.org>
Subject: [PATCH v2] dmaengine: tegra: only advertise supported pause operations
Date: Tue, 17 Nov 2026 06:41:42 +0000
Message-ID: <20261117064143.4024726-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109-submit-tegra186-dma-pause-caps-v1-v2-1-accf568bf0cc@gmail.com>
References: <20261109-submit-tegra186-dma-pause-caps-v1-v2-1-accf568bf0cc@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000DD310:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: af4f07c9-06a1-48e9-42e8-08df4475eebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	UxR59Z3IR2fxAf4Nn/Sc6afXiJSkXn9ULbFClIhpHm1rzmKySVkhMaEZ9Zo7J3+B17oux3Leua9CYPBrbxdm2eAM2cvGK2vGKdirjUux75QJ2ey1CXLvdGD0bT7CHPdTYE31JvMPetwxPjjYjoaZUGRw1YbzIoC3reTVjMl5uiKY2i9sk8y6u0Ke4XZU01De52yLhGsKC1ra6F7Ob5KYhZNtJgbQ1Y5bOzyRhnETpOaaGfgf26B1IpUvY5d79A8bLGrWXby3Zc+mDItjCgQIWxco5BqstJ01JPNiz8MnwqDUPsO1ntOzUbqUlH0Ei26gGPAr7klS0OoNjDrSH91DdJYtoafLHW2ChDaB+Bb6jKts05tGKuRaPCgjQTdlfjGFtB6L9pduqn/mTJ6TptELbfo9wWldDPMnvEQ0iXlCrbpgjmj+AjcPB7WjpC/qrpDNDPPqw0wod4fihrFNT/IDgfEHWPEHtW3pdocjau33sDq2b5Z1wb3H7N90EUcMVHTOsZaHjeo/hiFyyHLdgovVgLpii9CV5aHrk4Pfds6oCNUEWaA/iG5XIWVZDpwsrKu+5H6733i0mAXaozvjtQ2mvISxd2QYI+0LKExvmwTQBBCyUgZ9ymFKMRObnYD6c7nPQdPN5LA+XF3CvbQ5wY28e44VxY4PohTvZmkytOd6WZFyTq5GXCcSwsiuhdqcK+hPYRvxwjQ9KX0KhzRzTD8+cQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZxOWg16sbrEpFWwwC+1/Ubj6wMpw0Of3g7ynQekIaSpUuc6bf+kb0UAy7lg2wUP0PbTawL7CLfWY64ZFGaH/gVe0gwXoN1daz+/wkk1gNZ6blM0ncJzsljbfPKKSfbUhiDTt7BwGAQle+Pe2ljCk3Pmv/TFSYPdfQx9y/PJxpLbRGFb1zmuB1qSb2x2lxY9rGWijxLFHf7Ptj5/W5Vm0hQRxvsL0kysQ4i/i4zjzdudGFmZxPCF++md6heueqmxOWO9JDdJtc0ZX7GLRRjrjRs6FBwgQiRm4OV2Lr8DVu1yoLSTN0sk4cytHVHz0wZmSXFS4qIqpG4XCY4sVRrBH+k4g4qx0MKVO/ypFtCh+7ZvrJhcdkoP2GAUrympauaiKwGMAuw7mTuWRiWp4t8+1y0ab1qk30ErpmRjbyO/Zr+GZKgIoYf95et8fH7Ge1Lk5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:42:21.6487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4f07c9-06a1-48e9-42e8-08df4475eebb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000DD310.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135

On Mon, 09 Nov 2026 20:02:14 -0700, James Hilliard wrote:

> Tegra186 does not support pausing a channel, but the driver installs
> device_pause and device_resume for every variant. Both callbacks return
> -ENOSYS on Tegra186.
> 
> dma_get_slave_caps() derives cmd_pause and cmd_resume from the presence
> of these callbacks. Clients such as generic 8250 therefore accept RX DMA
> channels that cannot satisfy their pause requirement. A receive timeout
> then reaches an unsupported pause operation instead of being excluded
> when the channel capabilities are checked.
> 
> Only install the pause and resume callbacks when the matched chip data
> advertises hardware support. Keep them available on Tegra194 and later,
> and remove their now-redundant checks for unsupported hardware.
> 
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Reviewed-by: Akhil R <akhilrajeev@nvidia.com>

> ---
> Changes in v2:
> - Remove the capability checks from the pause and resume callbacks now that
>   they are registered only on hardware that supports them.
> - Link to v1: https://patch.msgid.link/20261108-submit-tegra186-dma-pause-caps-v1-v1-1-9cc9b17a033d@gmail.com
> 
> To: Laxman Dewangan <ldewangan@nvidia.com>
> To: Jon Hunter <jonathanh@nvidia.com>
> To: Vinod Koul <vkoul@kernel.org>
> To: Frank Li <Frank.Li@kernel.org>
> To: Thierry Reding <thierry.reding@kernel.org>
> To: Akhil R <akhilrajeev@nvidia.com>
> To: Pavan Kunapuli <pkunapuli@nvidia.com>
> To: Dmitry Osipenko <digetx@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index e76c58f213d8..bd606b71e714 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -419,9 +419,6 @@ static int tegra_dma_device_pause(struct dma_chan *dc)
>         unsigned long flags;
>         int ret;
> 
> -       if (!tdc->tdma->chip_data->hw_support_pause)
> -               return -ENOSYS;
> -
>         spin_lock_irqsave(&tdc->vc.lock, flags);
>         ret = tegra_dma_pause(tdc);
>         spin_unlock_irqrestore(&tdc->vc.lock, flags);
> @@ -445,9 +442,6 @@ static int tegra_dma_device_resume(struct dma_chan *dc)
>         struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>         unsigned long flags;
> 
> -       if (!tdc->tdma->chip_data->hw_support_pause)
> -               return -ENOSYS;
> -
>         spin_lock_irqsave(&tdc->vc.lock, flags);
>         tegra_dma_resume(tdc);
>         spin_unlock_irqrestore(&tdc->vc.lock, flags);
> @@ -1518,8 +1512,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>         tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
>         tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
>         tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
> -       tdma->dma_dev.device_pause = tegra_dma_device_pause;
> -       tdma->dma_dev.device_resume = tegra_dma_device_resume;
> +       if (cdata->hw_support_pause) {
> +               tdma->dma_dev.device_pause = tegra_dma_device_pause;
> +               tdma->dma_dev.device_resume = tegra_dma_device_resume;
> +       }
>         tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
>         tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Best Regards,
Akhil

