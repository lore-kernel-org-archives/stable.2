Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8D44E66B;
	Fri, 11 Sep 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156467; cv=fail; b=Nn0iq8GPQWpcMRUzNunTGg1himWwbm46w/IEAzBBOgsXEYDju5Vd+b6AxGGxhGVbFqKYwVtVEPy8aE3PCvUZdDoQOi7qd6kAluvRHbZ1WspMZqoT7iJY5BsOFRxj8G47Btxi44uqX1UxwsbkzmvH4pA+M4OLy3jWEyGyl6K2W9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156467; c=relaxed/simple;
	bh=bZMhRfI8MPeBsNRZbUvhcrHyoxreAf2epjeIxq7j5fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXmwoF7Dpta0l1y6Fn14ZbCi0HK7Ft1p3hJKddUloFCFJP6OtqRDerlxRqrjt0Fb8D9Wdkpifdjvc44o0OLlHvb7R2RfP/VzNmNlQiL7sbjdwT7IRbkn8z53aDRmyo4ryCW7P1LRVLIxla2oBvKkLikaw5J6FkWednzS/pNqeXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=oBXTrWiF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XiXZf0dC; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="oBXTrWiF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XiXZf0dC"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BHUxgo2544548;
	Fri, 11 Sep 2026 14:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=9uEdniPyzFTvkD2/bVSs0sj32G2yOg67DWDXTWpKx
	o0=; b=oBXTrWiFalB/GDx9JBdPvHDbzNQZVl/TmNr5ydNd5kfkjiyX5TiBevH+0
	ckyZ4/jWQ2Xo5XdJkZs/6cxL4/Z69AvEhgz3pYAlCsuHm/bCjcjge7TTdkAh0OY1
	LIWPY2Kp0WKo3AJtUzw6W0ipojkV8JucvlV7PmvW5+MILsnVRiJMCl6C2DTu8tfW
	Rm1L7f5D0QnIsMBuYBYHhzjEoJloZWNCRKkwHb4LVOPC5mc8U5RmsVgyHhLGBmCv
	mXD1xjQ3B2iEVefINpwjJUTKt0T1Fms6/h9a5krJynxS73ZyhBOG2HZxqlc/wA3X
	EBMWi49gfbHjJxTrwoy8jZkgaoB9g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gkyw9rptj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 14:54:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlcjleyLquCO5W8aGhfnX2C8AAJ7oQH3YfTtx7ylsvgooN2RljjY5KrnKRBckuMOKE0HQayOkp8GczZ6TQfJtytstrEqeOPGn1VVTL+R4TGsdUBX/y4yumeyjfzzVumECc/Q1mnCSwX/SRB/vgFk6IrQonHFlhDu1mHXeNe2BSS1gXm9LbeicURZY5HIkCP2nNe60C8BTicRxeW/gt9FY62i7s+UIa/GcdRSw67n/SRTvdX7Mt000Nx74wvcGpD22O7dFNm7E99drajeS23kWfGhZYH62uKEI/LZpz/WJAjFsxVldeO1HUvMmUhkHcVinfLSYYmLyi0v1X5QkWFRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uEdniPyzFTvkD2/bVSs0sj32G2yOg67DWDXTWpKxo0=;
 b=qd9aJV0P4lbEY3KTUnPSUjwC6eoenb0HIXFhk3ugIbMk/RGCpJXP9nuDdJfmXwjU5WCGYNn+hIUpWxMSMASNF0f2Cn9bGtzC4szkpF/zmzmJzzTMTngM2zdJiVXPAT8TGJ+k8nOEWicF0niajfVzLx+Om6qQIdzCTdsOlAtSqCizykPHLindbJyVTwFrgzn5RLBZpo8vzGlzfhqL3yQ+JRFuaftUZrn04gz1iAdKoG24fh6WjtsxJWJg8jhrqwWYDspIZnccyzZNxnVDO6yremBEOEyNnHo8I30BtG+8xn2wNYMoORKF12ywhEinlH1RrJIXuGSyMOftFpYSEqDMzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uEdniPyzFTvkD2/bVSs0sj32G2yOg67DWDXTWpKxo0=;
 b=XiXZf0dCwkYbb2w/vWdydJwz4DB1vmgbbQjSbjWxLWY8BeFqswwey/5kIWgpTcAEXMK4zMSYnlIxWeen639PundB8YhRdEHaBdtX+1+ep+3MRX4xKzrbYYZDzt4w6isg7DKSr8S88erLRBAsUwvU8FaW7+BUoe19BVB0tggnQvA=
Received: from CH5P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::19)
 by SA1PR10MB997653.namprd10.prod.outlook.com (2603:10b6:806:4b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 19:54:07 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::9e) by CH5P223CA0003.outlook.office365.com
 (2603:10b6:610:1f3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 19:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 19:54:05 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 14:53:21 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 14:53:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 11 Sep 2026 14:53:21 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68BJrL7f1697238;
	Fri, 11 Sep 2026 14:53:21 -0500
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo <kristo@kernel.org>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Jared McArthur <j-mcarthur@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Set ACSPCIe refclk to MAIN_PLL2_HSDIV4 for pcie1
Date: Fri, 11 Sep 2026 14:53:19 -0500
Message-ID: <178915639330.2344541.14495562225044275413.b4-ty@b4>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260908185903.404451-1-j-mcarthur@ti.com>
References: <20260908185903.404451-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|SA1PR10MB997653:EE_
X-MS-Office365-Filtering-Correlation-Id: 52ea75ed-2e8e-43fe-a34d-08df103e6f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|6133799003|10067099003|3023799007|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	jfpcSPwhOgU8We4VsAzaS/GpjgbI63vWKecKFkr1JNUxA2W9bEfuj4E7Stt6UcZGHarhRxvV5WgzfOxv/GjAoaOBqYWWP4d2mk4pr4GgR/aoP3J3E55+eWCITvnDrmbXAR9fs63vmNc7flq0anT/22WREn/zNvCDRAQB1UyP18SiDRHloNFIKrv1oy+xjPaho0m07si1qNb5dH3RtEXy8Tl4nSLRJC8dAZOe3ie+/u9kZPh61TCc+YqzExVV23j8jExWxpGcsdFM+lixuRV0xfbjCJE1mNRtfqj7NyZjbHeldw59Doohe4P8fZKXUkoQtzOn9uqTOInInjQslV1cQenEUlqijTxrtKAjGHok10EeHGZXu24QbVgb1YhxKssnIZ6b/mTiJFd3EhWgHLPhahnlNXqzRhc/M540RpMvCfF5bGU6IC8PnGT7P3JH4DF68wBY6jVPxgo6seaO9dPwYCnSU6np0W/X6B2Y130fAI67DWapqzifPWzsYtIJiit9IyA/0G7+o8Jcj4nsa5IgIMVYMn9LTriDKmUjqLEAU5eBJpBuasyeJVIt0TnRhIuGORfk1N0MTUdZ864NbqrMT3mv/5kr7MBnZ923ftYb6zESQN+UVcma2vxynkhfiib2FEHBoFCaTsBkt4T1u4o0qr4M6uwPQkqhnjBl8trEW/r5IyBwnolFsNx63kn5bkaKpvuKt0NNqPoluuF+jxdvKw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(6133799003)(10067099003)(3023799007)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VSe0CpMntvbJR98t9Zluc+pE1QlJ/PeXRIdtN7urCCkDNuF+cWz7YRI5r/bIpBbxzNqWDvmX4KVmG1o6RaAeQV2iGzxwI7QGTqpriHH0lzNWrBUDq8uz6GGQkhFVE87K4kqANlC3aDwZGKutpukUMhhnXgDkDiA/KySy04t/ExHG2qzMXV6AJ/98XcIdDnGlHz53eMvrr5+PiBiTcTFZ27r5Ha+fI2fLqL5hi/ztJM7l49GBVD30uM8xcxSXtoYLL1G3RdEpmfjovcVnRITxJU6pWdr1yceeYxL++I/HI9JUgeLjSayP71l8uMqz1LqrRJLLRew7qEd2OOnO3fD1Dd7FVTH85iC/HYTeJO+bkze6OuDweo/M/WUfr7xpYvKo2lS0aM1eE9e4HV/EXr+afL2xZ9hn4evQbefWED04IrvkL18/ZCc4igHvC1yjMWru
X-Exchange-RoutingPolicyChecked:
	E2JoLiQzIdz74FL0lz0aTX2IDbIAVGVUT3rfcPSzRuLxcuNybRbqT/uF08KI+ho9poFihoIpeGYrV4M4oZEvrM9mPivYQJ8jREkMJYVzR6eCT1hXXTO3YEbKOWjotn0RdLt4nf2fyhArsQU/uEmD3kdh7PtTufQKNEGZ9JdoymUVVAd5iqe5CZ5kahHFOxFqnLBDiNpzJOGafRWfqTVdyXnHQXEzixlSGVekmfhkf09LXXJQZshiAFjekM5l9ORTav5Vw6DqvAaP8U3zCO4lywz78883C1D6BscCoDlGSYiD7eH9eb3sCH6akwiaQLDqAmDURMkV1eL7xVM0yOYapw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 19:54:05.5092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ea75ed-2e8e-43fe-a34d-08df103e6f97
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997653
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI4MSBTYWx0ZWRfX7Bx+plU7vLRb
 nmLp1N3A+wYpzCo77BoE8gSuaI3/WMKb/1oMKo9b02u2mlQmSDrWiZC3YcaifKW068u5uW48X1D
 X1IcovLuJwX1HJNl+v0PAZOgLExKuxY=
X-Authority-Analysis: v=2.4 cv=ON6yTiaB c=1 sm=1 tr=0 ts=6aa45c62 cx=c_pps
 a=xjw7YmzweVlW3QpdpNkTiQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Ms95HSm5-DtX0BCDy7MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bx-1iQUl53_5nCyLyvKO-5j-X6psk46q
X-Proofpoint-ORIG-GUID: bx-1iQUl53_5nCyLyvKO-5j-X6psk46q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI4MSBTYWx0ZWRfX66u9rebJ5kLn
 sCudBQq/VvuWDLHsiir1ktKb8ch4/o002lJUPlmrGIdnMecfhLVFi32XqowAm67+JhDHOJJPfCY
 XwlqiNugL2cz0Gv3U4fv4oJQBCVYzcFViOaTrr1qLNN88/4vkgbq0pAgvvjtjlpBNIYpMMDV0YY
 WSvCgKuGrk69vW3Xw+gYnD7/OB3HaBR8HdPhL/ELwr7rfmF7IB0EZs8WfV+aDNZp7kCjOp6lbOs
 debjD/emwSwCbUMsImUQm+IBxnerWzuQPOy/KtszGJZmiABZ513eis2LbBVzvdtzDk7HcdeCt0D
 XE5hn0LYkM7Q+EpXMnxMmHyGG5Aifs3Z5jm/cQVjBU0WwkBlD69AnpHtdVMFZEMxAjbTLiDQi8O
 qkXVklz4DRJYWMSk+2dnnr/ARiy0dDVG2BnoM9pQL9kPrzmTFuA8+BWbKJRT9CHGVzDk4BB+wfr
 tRxu1i/cncGWNu8AtaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110281

Hi Jared McArthur,

On Tue, 08 Sep 2026 13:59:03 -0500, Jared McArthur wrote:
> Commit e3dfcf482d07 ("arm64: dts: ti: k3-j784s4-j742s2-evm-common:
> Enable ACSPCIE0 output for PCIe1") enabled the ACSPCIE0 buffers
> to provide the PCIe refclk for PCIe1, but introduced a bug
> where the clock is remporarily disabled during initialization.
> The ACSPCIe reference clock is muxable between multiple
> sources: SERDESx_REF_DER_OUT_CLK, MAIN_PLL2_HSDIV4_CLKOUT, and
> SERDESx_REF_OUT_CLK [0]. On reset, the refclk is set to the
> SERDESx_REF_DER_OUT_CLK. In the J742S2 and J784S4, "the SerDes PCIe
> Reference Clock Output will be temporarily disabled when changing Data
> Rates to or from 8.0 GT/s in Derived Refclk mode" [1]. Some external PCIe
> devices cannot tolerate the reference clock being disabled and will
> therefore fail to link.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Set ACSPCIe refclk to MAIN_PLL2_HSDIV4 for pcie1
      commit: 7e4b4f799bd043cb5b30176ddbe690a0fb5788bc

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

