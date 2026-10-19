Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C93DEFE7;
	Mon, 19 Oct 2026 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392589; cv=fail; b=L+bq3bhZoqeHGA9UDTYImLhTuOhtnN/hVKfcSi/xb91AOEeirwSyu8ntvPNzqyvuwZDbP/R2LZHQ+cHtFbgl3qaD+jvvg0QJloiKW6htL6uVJGrO3VLEcxwUZTAzFhVYEuFFLMN9IhPOlazUafFfOy5hdH0eqRXdV7KtWskrBr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392589; c=relaxed/simple;
	bh=sv+pF36Wx3XmieH74ln4jBNaL6l+tcYZlsL6eexnmAU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZiwjnbEiV+/KVwR7v39urvqSpbz0Q0KX+iM6ykGDcbxocekfKhYpbH7pO8CPnsv0hD2DmHE5hmEjPjIHHKY2vrLpWn/WQBtOrrpxP2DCRT0DdrrsIOIysUZI6vUnI7sJVT9X8dnIavVbCfT7lYrPGYs8zbig/3id4xjkaZg6kzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=CV8x+I5u; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=gW8qqy+Z; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="CV8x+I5u";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="gW8qqy+Z"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69J4h2YU2313931;
	Mon, 19 Oct 2026 01:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=sZ7OYMhm7CdgHU3k/gpYaMMuyYgJp1pkFYaO3Wl1z
	Qw=; b=CV8x+I5uf68G+Kdmi9aa5Wx4a/L76np5XwuG5diAQyFhhzZhgMsFdmavB
	d0hK95WNWt8+U2S5SSDYmKVLp0UbJbXSuykGf9K/vmYdvV7hChvuxguxh3ggDIgW
	vEiHzGMcQqfjRpc2+5H8xqp83MhUFkM9yXeVUUEIUdIf3xeXdtTBZ+Ne7fyW/f0Z
	SbNRYjGPa+NYYQZsobVfuvX+Xd68iA5DnMd+HF9FDia8TT0UEhuIIH6sLaKAlj+K
	bs8GirY4A7BAXq7OtWbGRHflfhKV/TN7Em0eV5iCnZRPCoZCkXseV2A6mxPSEP/P
	K3nQ5AIBWq6V4ZDFzrGJvVXazodSQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hctynbt5r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 01:49:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zzgqc3zo6Xp83ztdujPBMp79R7wPZiWtVB2ePKL7EY3c0e+zASVuwBppKctpPTeyyWH4j7b9hpssnu2eM+HYrvN0w5lEEEKjuPjpRwTJPHVuo4lu4MrBsORlkKDoTH+HRnUyGfmg4kOHOMpoNzVdHWEZ3ItTdvZUnrk2iNoseZdS3cYiTu3C+R/WpfkATogK0ZXq271Htgc4ZjfCzcn9taU1IRose7lxHYv2N6nlgb/V5jqWzRUK1iE57cFSiParRLle4hj26ipbdWUa3XCzJ4RMHR7PiaHD/T9scIkLIz2IR3Vr8XeqHuQTPLGONInjQ0nc0yjueaLGxkeXS6mGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ7OYMhm7CdgHU3k/gpYaMMuyYgJp1pkFYaO3Wl1zQw=;
 b=xVfWlHqxIXjoCYn6t+RJtCW58AAbT9iBl8YXGRD2xBKpdyuDebI1IaX5KJ8sZgj0w3bulDODYGMOIXIc9vBTcj/gGa6HUZTglbLM8kNey1gZrhdz41b9EDM+6s13hic32cmg13eBr8mwb94CLv4go1OrE/ayx5nqfedaNSfSdIOlnmFXdZTn4BAG7nFlli2VGcrR1mN3fzRmqe1h5aF0REsnyB3iDY+vXf0w/adwUdq43CXdb8DaOWYizt4p8DtKv6Np0DRIqh8vRxX/Mf2yQNKRvz1Y4nDkh+V0TD6OgcmN6oFajKNEZSGTYyu+H3WFutf6m7vxxfoU/xF5HAtsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ7OYMhm7CdgHU3k/gpYaMMuyYgJp1pkFYaO3Wl1zQw=;
 b=gW8qqy+ZhzwvEaxaJc72EMTp0bPJl0pxk5G1zxnhU9391LrB1WlAEVKqgtsekgnul0qHurJPV7Zw1//EOit8qjGkRq4Ua3FwjHvgi6LN9lWPaArdHRhp6ioHJ0jK5TzIAmrVlvO7ijJwFNILE/QzD5Del96azjfuftTIwLUMDJw=
Received: from CH2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:610:4c::22)
 by SABPR10MB997916.namprd10.prod.outlook.com (2603:10b6:806:50d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 06:49:23 +0000
Received: from CH7PEPF0000001B.namprd21.prod.outlook.com
 (2603:10b6:610:4c:cafe::47) by CH2PR10CA0012.outlook.office365.com
 (2603:10b6:610:4c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Mon,
 19 Oct 2026 06:49:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH7PEPF0000001B.mail.protection.outlook.com (10.167.244.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Mon, 19 Oct 2026 06:49:23 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 01:49:16 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 01:49:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 01:49:16 -0500
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69J6nBfw3216444;
	Mon, 19 Oct 2026 01:49:12 -0500
Message-ID: <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>
Date: Mon, 19 Oct 2026 12:19:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <netdev@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Keerthy <j-keerthy@ti.com>, Kevin Hao
	<haokexin@gmail.com>,
        Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann
	<arnd@arndb.de>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
To: Karl Mehltretter <kmehltretter@gmail.com>
References: <20261019060430.33254-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20261019060430.33254-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH7PEPF0000001B:EE_|SABPR10MB997916:EE_
X-MS-Office365-Filtering-Correlation-Id: 283ba982-09d7-4210-e552-08df2dad1c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|10067099003|13003099007|260925021911599003|260925022911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	1o/TpCRjRb0X/icbB1SbtweIrLbyWpOoJakzNdRbJ9ru+PFafw5SPSi0roakep1xOYpxvWW/OO2uIs6EcmulV3mTdqu6K/FZsIW49Li2bteC936ECYtGBDnzGkKcIv9e1XtirGirdgeuYDpZD9c9rtuNzBm9uc09biUUw1fuOTgmOj8o3TYQTR8mhJzhNFBPQhsQMiYdj5QZa8f9LZLBHXtpfRShaq2z+9rNq8eatdfMke7UgHMDiYRbbJqdpw4bXwhXyF5dbuWly1WHelgigBt+vp3R+NkIjGLxsy0SlqSPA2Ctaktx2ffo3hKO0LuM8ymD3kUlaWDFp5OKw/ptVV9E5e1OIbRmC7ynEAj5nwxs8VQqqbvia9XK72BmR/pwUp/iExR6YiTSKZkbmRS9AZoQSfDGponpgVOG4pBbEhL0zHLHvLBytD22q3t5YMIXfZL1a61WZYdi8dJSUUdd2uR6oMxQ5EVmLifiVjDCixuH3+LlE6NkallNQ8zyYkf6vFTbCGxQHHrm3jcnWR/hlV9uAqUcOTrqnCKzeOWBWhK//w6ZHSjyJ1iCGm4Qq93hXvUq3bJiVPsbcZzWdeeAzZLUtYx9Pd/wQJdFww81uK+c9XOb9Qp6L8Tw/mzX8ct6mkU/mFm32zfxcXUpAb8puBv7bgZy7O9ZO1TvSCaFkJc=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(13003099007)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i/0OiTOphnF72QWj6zAWhVOB0dAHLgQ+tsm/QFGDCfBnWjlCadzXjVD9u7GLhz9DCQubPFkPUSnvsPJwMTyXhE7/6Vw6DFhgaszuyTU44IWZzou0hnsExSxWLhDWlKme98x1HeOkOEApSwu40JGwMIyN1D3E9OX8ImWfGrV6P74u3NVaOZgKKhDTrr6z1kyVLsUs6JEV0F5JvXnPtsld7kA5feCdTm2hsTZLGBAKCULfPcflBiVc7PsnupC8BJllwb7/rXweKCr0L6Xr0n6LgyoDzcQ6MvN5YyN7KhcGPtexqZGpTKr1N9KRc3wbwPxmYT4NvnIYbnCVIlvT7roYxt2AVLaV3wHvryVD08Mjf1PffA4l1fU2/ve5aD/aZAV+txRs8AFulaAGZlWEeNsPdcKLLWpd7s+13uA/oFVY5GBwLF7rUDuFRX7s8SuQ3wIe
X-Exchange-RoutingPolicyChecked:
	la3ibHKkW33kedu3kiJFLEazD6zRgj+DMjuEnHKI4BVXZbpMF5gLbjw+aP/O1bLT9hKvrilxpasQl6FPnE//6MZ/IJkfVdnTh2P3b45BjgA/DljsN69urnsjqoaEpPYpvqtkbBPIT1KbLzZp9cN31qZ4D/31fWdwNYhR6G6xK22Jme3kcDOGz3+yDpyhBDLDc8bcpGEWGGqEqrisBK137YoPbdShxbBwGUoyG4QpXru+MRlgPhVZ1id0XuBZO51iaO135pP0uIA4F2NWuv1CuGK3o/9z3I6OkWV6/tmVfS1Z+yBqHgDiZjKPfbEzeJaEFsGwA9VfqiCv3Dan6MJQCg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:49:23.5039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 283ba982-09d7-4210-e552-08df2dad1c38
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH7PEPF0000001B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR10MB997916
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNiBTYWx0ZWRfXxt+4ZR/uRsMc
 5PR0XP0AoKaLLCjxDvMRY0HpyyYuWSxmoIqWJ6Hz0g/w23/LyawhU85PfmVx4cjETLA4jbxjce0
 TGwBnB67G18Ohnm+hlG5V3MyIjqi+MJH7ftgx1AQGwJBChtLcbJiN3Re07OlEo6kXfmRITeRNvf
 nca1gUzRUdcDhfYgd5WgQXmYP9xbAcNbNviVPYJsSY6EUinjkO6D5PEXxI0drL2ztKVHoOISO9P
 MN8YKbeLIzJ1TSISXxgcTsG2Nh0GMWFSFQ9f/EXKtLOqHjklCTRxusxirFurKt85UGNyI55Lgr0
 ZDbdiKBiWDIUxLsFoVhK9Uc6yAuBJ9TzuAggqFbagzRurEhZ6AqqNjc3hhJGyXFV2I+Bnqydc1Z
 5QZ4qTxUdO/cWymaVfpV/NjNxycoiMaqyPsk3rlbjNrSmLGnsoWYRyHyL6wAWcSJPv/01e0nM07
 AliWRjiNGehaLVBsRDA==
X-Proofpoint-ORIG-GUID: SVWneF1lO7aEAsl1AZOY3t4uFExeX9EC
X-Authority-Analysis: v=2.4 cv=afT0Dhot c=1 sm=1 tr=0 ts=6ad5bd76 cx=c_pps
 a=G0fLBfPV4gnnEhzimi2a/Q==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=D5zMYZVJ-7gA8VNtkp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SVWneF1lO7aEAsl1AZOY3t4uFExeX9EC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNiBTYWx0ZWRfX8YU7DDaTRS7S
 7nwXgtP1qbpwBX0tVTtl7Ih+cKidDj30VQXM96tYIOGpWCn4ajKcIFIQtfWds4OxhZoaqr8V1hi
 xVPtHokop4h8qyP/RTX1mT5PSgtuRxc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190026

On 10/19/26 11:34 AM, Karl Mehltretter wrote:
> The legacy CPSW driver registers its netdevs before requesting IRQs. If
> a later IRQ request fails in dual-EMAC mode, the probe error path
> unregisters only the primary netdev. Devres then calls free_netdev() on
> the still-registered secondary netdev, triggering the reg_state BUG_ON.
> 
> Once registered, either interface can queue rx_mode_work through
> dev_set_rx_mode(). The error path does not drain the work before devres
> releases the netdev and its private data, allowing the worker to access
> freed memory.
> 
> Use the same per-port cleanup for probe failure and remove. Unregister
> each netdev whose reg_state is NETREG_REGISTERED, then drain its
> rx_mode_work. The state check is needed because cpsw_probe_dual_emac()
> stores the secondary pointer before register_netdev() succeeds.
> 
> The workqueue lifetime issue was found during an LLM-assisted review of
> the 6.12.112-rc1 stable series. Inspecting the same path then exposed
> the dual-EMAC cleanup bug.
> 
> An instrumented KASAN ARM kernel and a QEMU CPSW probe stub reproduced
> both failures by forcing the TX IRQ request to return -EBUSY. Not tested
> on real hardware.
> 
> Fixes: 070f9c658a59 ("net: ethernet: ti: cpsw: Push the request_irq function to the end of probe")
> Fixes: 0b8c878d1173 ("net: cpsw: Execute ndo_set_rx_mode callback in a work queue")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> v2:
>    - fold the two fixes into one patch (Jakub)
>    - share registered-port cleanup between probe unwind and remove (Jakub)
>    - check NETREG_REGISTERED instead of adding a local flag (Jakub)
>    - add the requested discovery context (netdev bot)
>    - rebase on net
> 
> v1: https://lore.kernel.org/netdev/cover.1791035789.git.kmehltretter@gmail.com/
> 
> Tested:
>    - ARM W=1 cpsw.o builds with TI_CPSW=y and TI_CPSW=m
>    - KASAN ARM runs with a QEMU CPSW probe stub. A test hook held
>      rx_mode_work pending while the TX IRQ request failed with -EBUSY.
>      Both failures reproduced without the combined fix; v2 completed
>      single- and dual-EMAC cleanup without KASAN or BUG reports in two
>      runs per mode.
> 
>   drivers/net/ethernet/ti/cpsw.c | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index aa3531e844e87..01296c0582bf0 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1524,6 +1524,23 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
>   	return ret;
>   }
>   
> +static void cpsw_unregister_ports(struct cpsw_common *cpsw)
> +{
> +	struct net_device *ndev;
> +	struct cpsw_priv *priv;
> +	int i;
> +
> +	for (i = 0; i < cpsw->data.slaves; i++) {
> +		ndev = cpsw->slaves[i].ndev;
> +		if (!ndev || ndev->reg_state != NETREG_REGISTERED)
> +			continue;
> +
> +		priv = netdev_priv(ndev);
> +		unregister_netdev(ndev);
> +		disable_work_sync(&priv->rx_mode_work);

Although the above code is a refactor, it appears to me that the correct 
sequence should be:
	disable_work_sync(&priv->rx_mode_work);
	unregister_netdev(ndev);
RX Mode work (cpsw_ndo_set_rx_mode_work) does have a 'netif_running' check 
so it might still be fine if the sequence isn't followed.

Please correct me if I am mistaken regarding the above. Rest of the patch 
looks good to me.

Regards,
Siddharth.

> +	}
> +}
> +
>   static const struct of_device_id cpsw_of_mtable[] = {
>   	{ .compatible = "ti,cpsw"},
>   	{ .compatible = "ti,am335x-cpsw"},
> @@ -1764,7 +1781,7 @@ static int cpsw_probe(struct platform_device *pdev)
>   	return 0;
>   
>   clean_unregister_netdev_ret:
> -	unregister_netdev(ndev);
> +	cpsw_unregister_ports(cpsw);
>   clean_cpts:
>   	cpts_release(cpsw->cpts);
>   	cpdma_ctlr_destroy(cpsw->dma);
> @@ -1779,9 +1796,7 @@ static int cpsw_probe(struct platform_device *pdev)
>   static void cpsw_remove(struct platform_device *pdev)
>   {
>   	struct cpsw_common *cpsw = platform_get_drvdata(pdev);
> -	struct net_device *ndev;
> -	struct cpsw_priv *priv;
> -	int i, ret;
> +	int ret;
>   
>   	ret = pm_runtime_resume_and_get(&pdev->dev);
>   	if (ret < 0) {
> @@ -1793,15 +1808,7 @@ static void cpsw_remove(struct platform_device *pdev)
>   		return;
>   	}
>   
> -	for (i = 0; i < cpsw->data.slaves; i++) {
> -		ndev = cpsw->slaves[i].ndev;
> -		if (!ndev)
> -			continue;
> -
> -		priv = netdev_priv(ndev);
> -		unregister_netdev(ndev);
> -		disable_work_sync(&priv->rx_mode_work);
> -	}
> +	cpsw_unregister_ports(cpsw);
>   
>   	cpts_release(cpsw->cpts);
>   	cpdma_ctlr_destroy(cpsw->dma);
> 
> base-commit: 7ec48f396a1d89532c0537bc38b408b8c31ee37f

