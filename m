Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26534B2714;
	Fri, 18 Sep 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722765; cv=fail; b=eMLKVpG+EJ5+F64as075w39QxozWvcKelsk9PAs/lPFq3sXk4y6/ne9fODjnQt6aDp+W7unFrt4LI4EoR/TD9mm2F4Kxn+VxmCRPLRLjPR/9/YnxETKrOgWm5OYIah89vsiCMLTZy2CSISNbcTxMXx/LDT1XbWhePZ2Xrp6d6QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722765; c=relaxed/simple;
	bh=qdrcWf1iIS5UPgGvb1m7OYJs7TcX7BdXBvsKJNMlU7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CIxFBknPZS0sOxaIM9Xxuumk1z58iUNYkGBEZCYzNnL44qD2qpUOrdWfON2XIWe49qdqU4uIZsA2+Bb4I4+omUTiQYa5FGSYrViw+r6QDWFAPfbCiSFkP8jr97CZ/stTPL70jdKU4cTAx0qqWW51mRCdPv9yFT6+XVo44IdmSeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=IaxaS3yL; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gJ2t5pp6; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="IaxaS3yL";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gJ2t5pp6"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I6cqb13509542;
	Fri, 18 Sep 2026 04:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=YI8WcpGJdAKEeMXJ+hu8TElQI+8e9V/xrvOfMu3DG
	hM=; b=IaxaS3yLwzuPbQO2etKjjU+XC8wpNYAgoedSKefwd6nUy/GCGWHg4IKk8
	XfcivwE0jp6af6E4JNVJEajRJfAuunEdjBujQHuDu2oxRHAa/OhHObneeIWMS87Z
	W1Z3TUgBMwMh2lJljOBqtugfzXOtwCfh1R6IojiAHAnXJROW/Iy0Q4D9IkrhOimC
	c+xyl5SKEHUA1+zUM2+3+8zbGOTTNYCnPOT+CRY0IQuOFBw/NgzeAZ5ljuZXy5fy
	i6HRB3jdEJVtd91Oz5OQaklhpfX11o/FdgHNwSQCVbVRtgR35sIMH40khyhDdKth
	p+TybDnvyKGESfIZwlv9JAqrwcwWQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	by m0380145.ppops.net (PPS) with ESMTPS id 4grx6d9m48-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:12:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMiZ2HTjcfeygQmyi3dTFnHeDejELjw20JoZhua+Z8zczzGlhoy2GEVeHsgUxHOL4VSMIydlM7kfxjZRDSPGRlNDvsZdTGMRb1PmpItiqEvXtk/xMnowNL71uEKZWR7I990paWnBEt4JJ7f10f3C/UWgKr/ePK6TKEr4zYRaLYaU7B7OrpzVhjhsEfvRSC6sYS+IMSQfGhxKM69zE3QoNj5fxFTuENUZJZmwFzBQhvLjcVKMi8qUnjXHpfOC1zcScQEyjrOXpQasVbTzdMjxTi58Tp9xQmXIYc4WGcP9WVV8KfH53Lgw410b+5CeOQKjmqPd/kYx/QQljVR0cB2lLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI8WcpGJdAKEeMXJ+hu8TElQI+8e9V/xrvOfMu3DGhM=;
 b=yYegq3nb5IGdk5hC7JFq0Rn1u45lK0cmbPOFliSYH/8qcL/FleR4bHf391yJHqYjglIJPyaIgR+PWu3NNOEGhEPmtQqGyA9bNPgUEGtFx7VwT94xWB6WkV0c3EOwz1FFQVTvsBa9zwrjXO4i2Tyd/ZV5/O6AfGlptWJ3h2zrtwT4sTlS5camvpceYZdD8vD81IgA3x4Jje6VdjLyG5jB5SaMbD9OzDqb8+0xbXIYxqf5V2paSivLv/k9tttDaoSI2d6mBm7D9NwLQMWbrKEpLnnEkD5MSXnJ0e2oPFIetHedEAbmQENarMkZO4CrtjEeCV510pVfUBXyzzwWQtRhBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI8WcpGJdAKEeMXJ+hu8TElQI+8e9V/xrvOfMu3DGhM=;
 b=gJ2t5pp6U7KbCu6FHUSrWDtt0wI1W97/RPhey813kv+OjEbg7elIFsBxlzQBy8x5ssGTczD0fBV2EE9NfH4K7M6GEU+MEKgNFSKyB2Wmy39qqdaPo/Ol5bcybxqLpgC1/511cd93fFIFziobU3O05T6pZ7Y7hTu0Tqef12YHU4U=
Received: from SJ0PR03CA0248.namprd03.prod.outlook.com (2603:10b6:a03:3a0::13)
 by MW4PR10MB6630.namprd10.prod.outlook.com (2603:10b6:303:22f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 09:12:37 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1b) by SJ0PR03CA0248.outlook.office365.com
 (2603:10b6:a03:3a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 09:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 09:12:35 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:11:59 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:11:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 04:11:59 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com [10.24.51.87])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I9BuLc504834;
	Fri, 18 Sep 2026 04:11:57 -0500
Message-ID: <49db9182-8129-4f5a-b355-be8dcc01c994@ti.com>
Date: Fri, 18 Sep 2026 14:41:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] media: imagination: e5010: Fix clk never enabled
 without CONFIG_PM
To: Brandon Brnich <b-brnich@ti.com>, <mchehab@kernel.org>,
        <hverkuil@kernel.org>, <sebastian.fricke@collabora.com>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20260831213231.2125544-1-b-brnich@ti.com>
 <20260831213231.2125544-3-b-brnich@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260831213231.2125544-3-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MW4PR10MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1f6526-2690-49ca-d343-08df1564fa87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5A5+3Qm5hiRPdp+ekFYT37EnxdtAjTynuYDg89Epq6N1aWyg+BxlRkJp6fcKFu+RM30U2A1jzdwGD5kdOtaFZ6o3KFK7O5jAgqQi9ugwoTJ4IiC/rbmew21D7CaQ4hTHQYtbToc5AtKJIV2SHGahZ0/+pzXVis0quJFDAF9QiaUQlq3MFcBPJPrmfeYgkumjFMh7LYltnYO5JxeByNfwyy4ovGuSYYYYfYoct5uT7Uwrq8Cp5/6Q4HHJZBARgcNH58WTQXncP5byZw6jxRYvVxLr5x/pdDIGLIqGtN3BwyhgLZbU+hmlpUHYElkKO75AfY67Oo36zkPeEXYEEIlBK+axrMuK7+B9R9i4S2XoB2e5RTkYY9HWT3Im8CvoievdA9o4tFWaIMXSwM3AE8PYd+VtaXQD9WqutyfipKG7d4pB/RWtyave6MI5rGb6hcoihIsJNCYC/Y7wBzhri49bHJ0x76au53swFWkRYZe7mU37cohvUyIaWm9xWOsvi9akmLlFPt/ArudX4u4u+EpIQOuUupIufFjbioBnqTQi+7Qf2kf+hBC51kp8HPNgSrp+ncE7p4m5cxcpudh6xQ9pEBhI934RMGMLIZycNlz+enkdP+eAJC2smVTYDDzXhRV1hgCJcUGV5kBnpe8yLDUPaaRBt6Sp41GrbWdpwg9Z0jeTu8KESGbkFgmp5OhPPk6TzgX3gSKocGocf54lH+DxXw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ml2ONUIWM46/TZKedfgOUOSgBm3fQADOTv0L3kvRTkmY21WZ3bf39rl4TKBijz6F6Lp5kq7fJ5XAl1AxLpTT1K28QB9EZkESCDus5VZTuA8N50ydgxGPXHjj1FSVMgAdidg7k7o5tIxyAmIa73VB6pSJhq4nOmp/XrBTlsf6gQt3KgSPjuBnyHvAoFUi4diS99nspUbC0gdnhLEv/qYCoPUUF9VuSXOAQw4MYuEn8S9Gosq2NOU+eDYXnnCd1EdUFgXiKPeWx4LJGSDEiGM+srDJ9RxULAkiRymngXBH8Yj/lST2yqZU+MFJdwUcYUWITW1x9Xpg2V7UQDDdO+fLPNAXgWHDLlvBE57/YJLeyacqTie1Z35ylgPqp8AggcrPFm0qUOjHowZsXy1TGq/ewlZ67TPeB2X5ze9147QbCwY4bb4g9eXZtAxfRs91K8rh
X-Exchange-RoutingPolicyChecked:
	1lLsXQ/+MJo8H76v0TzQlRS1qbukjhGbGaz79s66Uiurgs26DE05KhIzVJdMjpbsa31WlYFo9yme/Y1UD+TIl9090wfXX/VXQQh8MQ5ZkfbP4O/RN1yWzTFLuceVtDhI1lnRKs8sUBD+Ig70Idy4PU3gTHHfMf9hGxc53UYGBjvZ4BezoJIMJ+8PyX4F1AHJqdxtWrlXOKMCZ63PPFNHQla6nKbAXkMFev1QFLzw2Pe6IvRV1TdkUjjTmYMK2D/42sMUy9GihAYYkHv1FHiCBEhQ5c+8LAZXMVSGH+BVjPlHaG3xfgbpmtN8hfXGN23yYc3T5NjAKth3SRLFaBOEbA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:12:35.2684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1f6526-2690-49ca-d343-08df1564fa87
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6630
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyNiBTYWx0ZWRfX9vsUZg2P40pH
 y/c06yA8iznAAFFDd58HiiBvXJVEdbmbXM75w1WAvr8qwHcUPllFh7rBQVBPJEr7hmhRAcFevPE
 SzR1JgHhVskNU+1Yr3kLp164o8Eewj4=
X-Authority-Analysis: v=2.4 cv=Cswq4X4D c=1 sm=1 tr=0 ts=6aad0088 cx=c_pps
 a=EZwmcie8zcfNvCQIxZ7BwQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=pbraIn_b0vyewlqHF90A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyNiBTYWx0ZWRfX2LTKWq5QSOjb
 lAeCcDgTL2wKaNJXFfilco6WsHuYSIdsbjPZX/pfEG+QyWy9E8pxEhlgm/qfyW9mEccbID9mzW0
 2LdC22s6GvwcgJoONh+S39NOVX5tXrkQJmtP3M0F4ntxupOLuz6SWBfknqFOix0bTA69nyrO16k
 JhLl7VLj5ftqR+o+KOY3yD5o7gi5U6xMkPQ2D5FlWMe4obTYnA2y2bmncvgkVDUa4tPzBDjgCmg
 cvmsfITZPPXoGWdzP+0PjQBq9hfaYQn48yuae9OLslFLYuMprzrVRBiZRK/gw0W/ex5NPSRf68D
 aUXVEMC3OZzRD7IP1o/g2pDKliKaFPHP9Je9DkQomdnBOt3zsUXuQBHa7v4FR5x7kwpf9RBPFjI
 KeGOz7ORAx5Lw4B9FjOf3YDc06/DtYCIOXkED8nOSNgE3EIlWI7oH3lBHhC9wzWRmt8LzruNsdL
 UL/rmB2POU0suq3We8A==
X-Proofpoint-ORIG-GUID: rpjyeEPauoaQ_kM5afJdodmieNNyalI1
X-Proofpoint-GUID: rpjyeEPauoaQ_kM5afJdodmieNNyalI1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180126

Hi Brandon,

Thanks for the patch.

On 01/09/26 03:02, Brandon Brnich wrote:
> clk_prepare_enable is not called anywhere unless CONFIG_PM is set. This
> means without CONFIG_PM, the JPEG Encoder will not function properly.
> 
> Add this call during the probe sequence to properly configure the device.
> If video_registration fails after clk is enabled, clk would be left on.
> Make a label to cover this case.
> 
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
>   .../media/platform/imagination/e5010-jpeg-enc.c    | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> index d3c11337c815d..e98fcd3fcd9ae 100644
> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> @@ -1099,19 +1099,28 @@ static int e5010_probe(struct platform_device *pdev)
>   		goto fail_after_video_register_device;
>   	}
>   
> -	pm_runtime_enable(dev);
> +	ret = clk_prepare_enable(e5010->clk);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to enable clock\n");
> +		goto fail_after_video_register_device;
> +	}
> +
>   
>   	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
>   	if (ret) {
>   		dev_err_probe(dev, ret, "failed to register video device\n");
> -		goto fail_after_video_register_device;
> +		goto fail_after_clock_enable;
>   	}
>   
> +	pm_runtime_enable(dev);
> +
>   	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
>   		  e5010->vdev->num);
>   
>   	return 0;
>   
> +fail_after_clock_enable:
> +	clk_disable_unprepare(e5010->clk);
>   fail_after_video_register_device:
>   	v4l2_m2m_release(e5010->m2m_dev);
>   fail_after_v4l2_register:
> @@ -1126,6 +1135,7 @@ static void e5010_remove(struct platform_device *pdev)
>   	struct e5010_dev *e5010 = platform_get_drvdata(pdev);
>   
>   	pm_runtime_disable(e5010->dev);
> +	clk_disable_unprepare(e5010->clk);

I think you should only disable if driver was not suspended as you 
already do a clk_disable in suspend path, i think it should be :

         if (!pm_runtime_status_suspended(&pdev->dev)) 

		clk_disable_unprepare(e5010->clk);

Regards
Devarsh
>   	video_unregister_device(e5010->vdev);
>   	v4l2_m2m_release(e5010->m2m_dev);
>   	v4l2_device_unregister(&e5010->v4l2_dev);

