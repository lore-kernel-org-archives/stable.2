Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0C392C42;
	Mon, 22 Jun 2026 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115592; cv=fail; b=HoiLkssv7nXU2sZa/IeIznJrBjfF4GYVrSAVnFEcNPFW1bbqQm7HmbqGS77G6m/hK6nKczIYNWudYReMrGPG+2ybgDB+AaQBJ2f7F0ca4VkJVzISbt7LqHgh5CjmZyfarrag32PqHjXYRGrDdZEBXhcFw+I5VV7l8qL1P4kbOEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115592; c=relaxed/simple;
	bh=RpYJ1KZGPjwb+MtQxqk6pCtGB3Uw+7HjxvPQf8SpDLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ore8vKVfuBoPUrGjxRRvHN2IYULT8C07eezabegx5dzZllAeOabT5tZoww5rZgE3orSH4sjGWo7E7hsEwZC+9MLG8euUXpdji8HRJjKLfEGQSYda3jRFxG646JQ/j3sWh3e/1QnZjpW36Qc7QFSG1/blXis55np5jdD6DHoJko4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=BAjoWawq; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OZuF2mLz; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="BAjoWawq";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OZuF2mLz"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65M59oDr516405;
	Mon, 22 Jun 2026 03:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=QnOL+vN4sBPUFsk+ArUcmrXVqvyHCy6ZM+qsbeEGb
	F0=; b=BAjoWawq7m7fhU8Tywkrpp20UQqjNzJTW/vY2/yFMO1kAOr6zIGywRVyi
	GAsdYjFGsDYd9ePyZmVLweUMK1A4/uRDoDxhWHBNIEJfFGTwX2+hfG39KYYJ1BXB
	YktA1jNVlUSANNRNA7/1GgYsDn43CupA0GyouRSsyBx8tRTQr6KduQanKtG9Gm6P
	8MQOcoRCVgtuBppriMLdYcmJ9QVdfVprjYltCwPgB+KmqrI4XAhEW5mANo3w62ie
	xmtgClV9sQ+38hEv1ERAUAV2dKbt2yRZnR8I9HWbmL7UtLemg+LEarBuYnb5QDtR
	7yqPDf+cxiR5OWMHfFL87LYuVWlBA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	by m0384305.ppops.net (PPS) with ESMTPS id 4exctn4gce-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 03:05:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHXBjdSPTMtdwbs3jJX3qKj8GurtLFOXM/nirYv0Ru2fBSIQ7cXJEgefz1Fn58ElliGwpGuo9nrBPJ57mhZ6MNUTLH8/7EXA602z2hvdzsc8VENP5nTeqqKjFwYniGs/eVsDQapMwLBCRvvpUXzlsWkmFOCAxBTixTU4Qn6GDqoCzPwc+TWQ3bcBx1Fgjem4wBGFPQiWFs9NJeQEyVlZxNLLXDJl4gs/sutaLvBNhMVZsWBnHhYoOCNHFV+EguAvKs4Z6CQ/bviE/dxkn6H2Vbk+4lVfKzZR/4pbFwpzB7reQt3/7u2FuNiHtUkWEzhR+lJr2bnDIOBtBaeNayoizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnOL+vN4sBPUFsk+ArUcmrXVqvyHCy6ZM+qsbeEGbF0=;
 b=Y9yDSW3/wb0YlsSdkMOKYLvxeCMmp3Wp4WAJk58EEKa7q8NAv/6WdfmADJQ0Jyu+0FN0Co5AI6xs+nxlhSQpfaHa+U5J5hu77RUTnAx5GNtiqn+sooOO4qBxUnF2s/AWypnXJ5UmRfFQ5E3Ooy1veRKSA84nEFh28s/M7I/XtUmj5T4wExFzaAobpAACNVHBdaHxFR2ch9Y+irA0USww6vR1rUStHryTVlyWtTeyY92lpvrwPb01RIdtMqLiac0swCio5Rj9wFimK4mGZjyc2m0OUidyQRqfRrWfsQKrrCXmyxbSaWTxwjzjCSkOqLD3Lj8PteYkODJwXnIOLcxa6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnOL+vN4sBPUFsk+ArUcmrXVqvyHCy6ZM+qsbeEGbF0=;
 b=OZuF2mLzmZwQ1RLnh35otxaUk2S8s2OcPmJgvSvKrbr218v1tJBFqLIEcNM/+iC2HPIzICORZQV3hwD4/jFAXrd0x+arCXqmteItHYyC0bUiAIisuZEaBN91Hr3khIzo37BwZUdYdtA9Hz40CWpgbKbPjOimgL7WEl8CcksM5D4=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by SN4PR10MB997921.namprd10.prod.outlook.com (2603:10b6:806:4fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 08:05:32 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::33) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 08:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 08:05:31 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 03:05:31 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 03:05:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 03:05:30 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65M85PK8068470;
	Mon, 22 Jun 2026 03:05:25 -0500
Message-ID: <77eec634-8984-48b7-841f-298f6828f598@ti.com>
Date: Mon, 22 Jun 2026 13:35:24 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP
 zero-copy RX path
To: David Carlier <devnexen@gmail.com>, <danishanwar@ti.com>,
        <rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20260620213756.87499-1-devnexen@gmail.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260620213756.87499-1-devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SN4PR10MB997921:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf4eb28-ac38-492e-4327-08ded03507ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|7416014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DAsOeabENvtcw9VsgWxoDBRkdu7mj4L2A8O7/Gi7YVSbIp1+nYkKAFjX2wbCnbQ2P13nIL55NRuqn4pYIS5TeidNVoz5Ih26brkKuxMnqK4zbO9hsAnlcFdomWGmEI1060ugQBds0sDg0OdGwgdBUViqNAUM0imUhFkvs6lPD5nnvOcmug20JIog5b4k26aLfK3Ug4zNrUDUbXxjqQx8+fnn+8RlMzDiOILLmt/QLiZctsJnXchdh7fan6xp4M9gel3ySJ5d7BpKNSHg/zXDyvUGLWuR3uwAEehDcCPj3n6DEQbAQiDfVXFUYQqKla1bHLkWiolfgkpetCe9pagX/u1OGpC5h3v/VVGsS95kJsbs3n5ExL63SuqSjtE9HilM3zZX8s0RC5E49T13oSDFGsjVG2bNrInCYEGCzoSaIdW3pDWnMWM1yu1hJdq2jGHX0CjppavJW9hNKlho7C145piCFexYJ0lkeS//6eZ2ezA6pElx4DuS6bdAqr7kg7onL1/gNonPGfX/N9VP12vqeid3GA4SH4ItQfowGZ8rk01RmpWDp2BP/gX9aWxKJwduqfuVupXlTmnn+1E6dINCEO5L3Ja8R6xHMOlO9pz+Sp7n+7EmkdQ4LE4qTScZNHeme/JVl/IaHb1mzOxxCHHDVvz2jhcrmZNy18N3KFx8X1b3egxenFTmNi2bYBEWlXw+gE/HfYIU5HXgSyr4FOg7gw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XVJSxbqqgcbYTxTqoX1rOnsGF5X1GrFtZx3tKWgBgMNjBk6bifO03xQ6bCFp1LakFa5lXc2ZpKFpOQtLliuTXmqBX7k5yxlbd/uUiOiWSyLnURe9TTZn6TVIlwV6kp5pOnAzIaJW1a8lRAGKFx3yUYmNaXKkOtLaMsOoJuzciOUS7OgZCIWuZDXNg1WK81LTMcVcidH3UX7Fvv0rX01qJ4dlyvPehQBCioSqFCcKFbuW4zSVZIY0efa3MhQsISJPDuSwtuTr29Z0UglvzXrskuxDaUdnza7PSQA9LkaopboCcxec1YAtuPZW6HBP3I9Fhy5ZHtF8BDL1bDw36TDac2eIhckM3GXhmoziTOH3oAWx12aJ1QtYPjPblXX6hp8EyaVfm4X75IDjkz7GYHYf2ATN878wsc7cbm4u85YF5tg5o4PZJHYQrNXnrehpgfDA
X-Exchange-RoutingPolicyChecked:
	fLoE1zBvJUg96JOdREE4eHZpfW4ajePzmPO72sSRgMe7UCHkGfwEaOQBjM9tQuoxdOg5oiMwDMal7W9Qmp0Nxk5MQtkvJQ3kURAdk/SlZLQIFByaIFEjm10qy3Kbsy62mS/RpP0zFXrPDlEq3rSWS+eYWitwIczwbQjozYmKWEe+N5EUTarKarUwEpnnEtRsNaKW/Zhd5uVxgwbr7qdrfyi7A+hsD98GJDpngaWv4fQ7m3aP+tpgL1N0agMAT6GGJnHo7JyTXlkxykxpabe4WKCRFQnkYZ/0o/P71/fCVs4ud/3ulUzdGu+btRR1TOdQzbVVLS6ZKVNlEUk9GDQ4pQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 08:05:31.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf4eb28-ac38-492e-4327-08ded03507ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB997921
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX1KWIr7TKCZS7
 2oAG//lzxU5OjWx89BuOLMHS70OuLHFbZGhN3JebnGKY0HBV+cpIlLWWK2BvanujAO+ziw/8Nci
 eWwNgjINYkam9IDb15AhJZ+XqYLJoC/Q5whOYCPoG1YnqPpxPAuOpgkj8l0V0aoEM3+GRk7alOX
 3Yg4Kx10ANNHAz7jpMC+chWXmmzlXvlX6RU5AFhUPC4e/lwhJjeXxWKLFsGOGBYAoETZEq2hzKn
 cW9tokZavN87goDvPOCo3kf6o6tOcU/vyilKgsAxbSaP6s6OVwiC0A3Y2Bwy3rLGHNfWFCf2hZY
 swUZX1GWzo4dcr4IooAccXx+LSHi0944iE5qzGI5GTgIVRy6it9vWFDAeBEnT7S5KpAWKOKDRKh
 mrVnZJDsyWkQbBxqGr2UMxKzmBHHVzrA6hL7MH0hKlLsgnnUayiZyrJFWib4aKxJcHHEuSr0o5z
 77VKZ0q6vuzknUYcwlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfXybZOJbPzuzgG
 Om+3l5VGJguZOvsgSG/rfMTNjTjBM6/RnsjJ6eqE+RVgj1BJlD/4MjCa0kzzBx5Neu6+Ftb8vgc
 tQhjYeuUaxZEdyAYtOy1/bbSHUIBfag=
X-Authority-Analysis: v=2.4 cv=L4AtheT8 c=1 sm=1 tr=0 ts=6a38ecd0 cx=c_pps
 a=wVrytDogCwW2gNy9sPioUw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=YPC9vQ4UZGf91Pzf1-8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mUumAGWPmkaWc2z1wLb2ThixXBrmwQPs
X-Proofpoint-GUID: mUumAGWPmkaWc2z1wLb2ThixXBrmwQPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078

Hi David,

Thanks for the fix.

On 6/21/26 03:07, David Carlier wrote:
> On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
> buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
> fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
> as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
> page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
> the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).
> 
> Pick the TX buffer type from the frame's memory type: keep
> PRUETH_TX_BUFF_TYPE_XDP_TX for page_pool frames and use
> PRUETH_TX_BUFF_TYPE_XDP_NDO for the cloned zero-copy frame. The
> completion path already unmaps PRUETH_SWDATA_XDPF buffers.
> 

Is it safe to unconditionally unmap the buffer for the case where 
frame's memory type is PRUETH_TX_BUFF_TYPE_XDP_TX? In this case the DMA 
mapping is done with rx_chn->dma_dev, where as in completion path we are 
unmapping with tx_chn->dma_dev unconditionally.

> Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 82ddef9c17d5..302e700ea17d 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -804,6 +804,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
>    */
>   static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
>   {
> +	enum prueth_tx_buff_type tx_buff_type;
>   	struct net_device *ndev = emac->ndev;
>   	struct netdev_queue *netif_txq;
>   	int cpu = smp_processor_id();
> @@ -826,11 +827,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
>   			goto drop;
>   		}
>   
> +		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
> +		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
> +		 * page that is not DMA mapped. Such a frame must be mapped
> +		 * via the NDO path; only a page pool-backed frame already
> +		 * carries a usable page_pool DMA address.
> +		 */
> +		tx_buff_type = xdpf->mem_type == MEM_TYPE_PAGE_POOL ?
> +				PRUETH_TX_BUFF_TYPE_XDP_TX :
> +				PRUETH_TX_BUFF_TYPE_XDP_NDO;
> +
>   		q_idx = cpu % emac->tx_ch_num;
>   		netif_txq = netdev_get_tx_queue(ndev, q_idx);
>   		__netif_tx_lock(netif_txq, cpu);
>   		result = emac_xmit_xdp_frame(emac, xdpf, q_idx,
> -					     PRUETH_TX_BUFF_TYPE_XDP_TX);
> +					     tx_buff_type);
>   		__netif_tx_unlock(netif_txq);
>   		if (result == ICSSG_XDP_CONSUMED) {
>   			ndev->stats.tx_dropped++;
