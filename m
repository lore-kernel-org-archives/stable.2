Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809986;
	b=UMT1BDVUYUd03o4Ya/uZdf/Ct6BJtPTKXAIvB9ubPqAumHWqQd5xlmAxFHGlp6ncSkob
	 ASY7TMeJrIwDT9LvnAqMuQ2ON7dDLlqFFl0QlrA210T3iHwj/p4/gnr8r8si1F4vEfBjq
	 C3bqkunQl+cXxzb33qleiP3NwvXapYDQ0oXXvBxRQMs+muxFfzFgpbjWPH4mo13DOCU3X
	 vcOSaVM7ljdAynY8ms6gB5Jk4fwiX8VdfOUBrbNWH5xPe9LJ/qRDgDoYzFjExeSo4icgT
	 Pu+z9qpj0fqBllhZ+Sczdhkuj51VBI6Mtv99VcU2roPTJCP0N/E034fxgJhhcczqJzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CshMbUyMNlAyT1WWRVOnRMAaDIK22P6hS8VTNSo3P3c=;
	b=3WEXUYrgHgOD5B8LH2AeokP+XXRiWEWzKxps//KGZt6Oj+YRcZLLPkAsJxMcsoHuv3OB
	 wwZoEnGzRZH0/JgLooR4ybxBH/BrOAiwwmVadxixswLPeLVyOZMC9m6IKSjnF1LXIkHgy
	 jkrkTZvItu+YK4/Bs7dwnMCFnOyjcJ77Tb0Upq0rJvJJPCnlOlEhSSLsIBWe02CgfnXgH
	 W7EXgVxOjtz3Xpflprjureg5nMph55nWvrtpPBkgDgbDleObgkG1BdVmsraqMf6YtZuRh
	 MwWz59PBcWg1sGX2o/aNv2fCaVroJ/+9bMckrcvfLpMb68sa82KSgOxUZMQSu50mvmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=jUfQF3kQ;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=kSgmVHRW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E6606A326;
	Wed,  4 Nov 2026 16:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 788E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=jUfQF3kQ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=kSgmVHRW
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FhWNj2830197;
	Wed, 4 Nov 2026 10:32:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=CshMbUyMNlAyT1WWRVOnRMAaDIK22P6hS8VTNSo3P
	3c=; b=jUfQF3kQg5x9NlbmGqPkr5wra9+4dYUL5TbFAgbNm1rNy/MS6eaIrc/9H
	ojjs8jfmL+OHKumdOq9SSLPBssYhqzi89MtPexJXb9G81YUFkUDohTovVR6U+wJS
	2tUODMa6p3x0pXe+ZaH13TQmOxFZ1CvW6KNTg/0LHpYigzLAvBa5hdsg0/KnYc20
	DIH83TqOevtMYC5E/OVOjBWD90OFVadfmobjbO3EFc7eV8P9BRulmEiThfXpJYIO
	lBecFe+HK9kvWxP7LXnLwNqodL8+n4c88+oUNOXdXHD85hffF2cpWo0IdkUbTdrR
	8mqU9KuA1di3WTdsnJo0LCEKE7dVw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqu7emmnp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 10:32:58 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBgoLAfpUNr7kFjhVjbtdfTsme9K6348hl38/6LRq4j7JlNFTN6V8kcpLhLIbczzwrw+tFXp/OmsnC6uLZ1xyKA+Bv9QCZ8qUC0yF3nacxyb3kM7eWxfHomdnz4bIlvGGTZbPm3uGuO2goW1Z6Kbjooqq1On/prZwWg09LK8ukSVX1ZTFXf0VXs6UBrh/2hsuU/L4e2w9AfWv5DsfxJZ6p21SbEWCTCrNmlUUO0eRmUbVvazBP88wS5e2RG/PXWCchDuhqcx0eUvl5Cdw6qn/mJ2Y8G7hPxfvW/AqFRywmOzU8hY2oUZmVasCfwZaKShevlmT6JWQRhdJsaz65fFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CshMbUyMNlAyT1WWRVOnRMAaDIK22P6hS8VTNSo3P3c=;
 b=wUUfy0J4rCHpcOuxVONlpmccF8EI4BsAWxlX8u25TPSyZM+F7h2dx7gR+1Q/S2Tyts2ZSFgqwiyoOeIyl0GLcIrIe7jgDweA73fI/WgWVkFW8Tfk9q+M2ntvr7NcFdC5E5QRrDb10HE9PVsdtLT3YaHqwDfVnacUgyXBHAjHD1Y2wKl/63QiNaJ1nzwUX9zCqUsNKc143XOBDLxTR1/HuARilsJSf7/ZV72dOCoc4LcfqDch6irFvwykaRfMbGQ/CrVFu4P59VazJHBUk0dF377u28j1LLmkxgT7U6+ck6r1ibRzJyGoXaktWDBd2zfCI4ojylQRdAfnuZ7Kxh6mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CshMbUyMNlAyT1WWRVOnRMAaDIK22P6hS8VTNSo3P3c=;
 b=kSgmVHRW02YueWXo83TM7mBq5m5FcUynOpi8tepESWFNbbg57139SZ52h5qFWkYbBtgGrAA9j/jTiasAFBarGmJ723yu8xlEaQAXvUKVYu1VFI9SGCC7vvF872WqeocDnv6rkRfYh/pVLsjGDZfTOb1Mz5ydRNjP+5flGruauns=
Received: from SJ0PR05CA0166.namprd05.prod.outlook.com (2603:10b6:a03:339::21)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:32:51 +0000
Received: from MW1PEPF00018891.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::5b) by SJ0PR05CA0166.outlook.office365.com
 (2603:10b6:a03:339::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 16:32:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MW1PEPF00018891.mail.protection.outlook.com (10.167.249.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 16:32:50 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 10:32:19 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 10:32:19 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 10:32:19 -0600
Received: from [128.247.81.105] (hpz2.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4GWIsg2512319;
	Wed, 4 Nov 2026 10:32:18 -0600
Message-ID: <73cb5f20-3b83-418c-a388-24c5f3b51258@ti.com>
Date: Wed, 4 Nov 2026 10:32:18 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] dmaengine: ti: cppi41: Fix suspend/resume issues
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
        Vinod Koul
	<vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Tony Lindgren
	<tony@atomide.com>, Daniel Mack <zonque@gmail.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien Panis
	<jpanis@baylibre.com>,
        "Francis, Sebin" <sebin.francis@ti.com>, <stable@vger.kernel.org>
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018891:EE_|BN0PR10MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b64259-b05a-4642-93d4-08df3a9144c7
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|18002099003|22082099003|56012099006|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GodNhe+eq1rNLLLRS4GvKE1wqA/6IaccoDDvW+hLwCT8EPps7Llq2iicfBMv1JOndU8VB+3RJPmEcBNSLDg9sGiQzDUf61zKd5DX3M723kELdobsSN3bMohkGhSM9r1hIbWNgACbn0Bh5/h6qICUUW0lgdKoWN89gP3kWiDaJzGZ2rEVRiKbSwRYmh7fsfS1ey5JilBdp0oyWwipa2syDyq8gbA3venoB4K9z9p085bl23oaaYcz3j0iT4IpDNwu5kD0AxDPdGRFFwGCg8qfLGc0Q3FxUc1XNMG6s0FDmd3tGaNra+j89ElPK45zi1KT5fK0qdgAnfiNDsNJoJs7o8sTurjLy1KpYlOaOMgwajcik4rqLIbP/X7UNJNYXnJYFGjsJEGuPk5gOc6PhN3cs5QJ/Pu2FTZTaMVCfsVtWUxJeLD9zHc2H4e3TFZI9X3PSK2Jw/eP/ErlLYuByc+g3UYrvL0MLFmcvE+2V1rnLTu8WpriU8nLRqClAv/PCBnLtkV1yxuUVSOksf7eQHv1ld38Vwu2v2/t9jqKxv+miCbK16lBhsZlm16J6V3kJZVdQe646bp5xxU0lxAinUkBv2+DppQm7MY6cxaSFwQ7CeLjDswQQg7uiykmI4ReH7A8HoNI2AKqJxYRbfVINs0rI/Up/u6LGnQyzskovO3YlH7TAZWXjfFuVdsOf2r4XmS9x99bBxOLaxCI/EPFZ+F/1w==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3MZSiw9KUn7Zq2h/EoDfaucZViGxYKjRptbgs59qVqVZbclnr4Dixzy/DoAQKqC3mpcArfTrDIJ+eAMZOR9BJjAgALO/q06eKF4HkCnKjLA6oyGgyql8qDjI2dAfCl5TDlNoZndT9G0WAx9QRlqLCDjfZzmYi65prjV1BsIdikidID2a3PdFcAhTu2vqUTNTK7ySBmn7Vaw05YGCMIr46hKrDKqSfxiJ3JiTJDNyMv9EzwfPnr6lOXtQDVPf2mJXanZYRFzu/U3NvbaH9+Caq88JAR0P7d2owpCnJgvMKbZzQ0wtqdXASFnl5iGbBmjso22qDOPpMVIm4hd37VMCR7gS/9KAaCatVg2Ei5yHh6uWvW5jlo+Awjra+pkDivRXDAnUQ+klkuxfT13dBArHfMBCZd5EnyZAQznbDXCuowUtcoZIyNJBv4pHaPGz4W1X
X-Exchange-RoutingPolicyChecked:
	ujuNZdtOkknGzSmyc0/3kiyo9h1/jBlKYjN2/9sTFu5KmnnpA35sZl4Uz1NBG1DgWlFqO/U1EVkgKYyLDRf5ermCQvXeQjI3BBKdNHbwGKbItEbKrOFMAEkRkpqQ3o3Iib7nvVynyH4zl226sqFscHe1JAPsWzdFsUDf4TPBAQAaTd6BBIIqpY4G1O39STfSTKVNZS9r6TMTNX1nj3yYgquLh88ZCqu+9mKlGWMdEZP3VdwUByXt874Qn2XhZIFv53FJZSUmkfZnnf6nBGs3hZo9m1LQuf58Rw4w4fXi13aY2rPx6CClPrNmM/MS6Y8rNDZ0dNChxVxLTvARBcP7dQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:32:50.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b64259-b05a-4642-93d4-08df3a9144c7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018891.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX/xSB393L5ieR
 6MZn+6JBXGIQhHU68yj4gI5GMa1IyzSvjE7yFA0xEdOkEX6JVMdgB8B/rT9WGuWnnMZ9t3kTDHq
 /Xd2cFYK7BYRff5ZqxrgZQGsBDdQEcg=
X-Authority-Analysis: v=2.4 cv=fPusTpae c=1 sm=1 tr=0 ts=6aeb5e3a cx=c_pps
 a=4hG4CnY/eg4LDOVkUp5rMg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=HDVS9C-Tl3C9_tqXkwAA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: 6cOF5TR7GsV4OMnmpxo1Fg41Blx5df7j
X-Proofpoint-ORIG-GUID: 6cOF5TR7GsV4OMnmpxo1Fg41Blx5df7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX1rStpR3YLqXd
 HtNbPuV5vmSC7tSUnuplKt2/fsyqEZxQVlQIHZVp74DXgLm7KZSIBUXLSdl5CMgK3zWO+pd9M93
 DemPIPP2GSL8f1biHVdZ05DyZbZ6OpF0LXiwnyDih9LMwqbDf7SkzOCewUALBN/D2IY85cCpaeR
 4/4t2+M7pWvJBo6LTqrH1qPGOyHtgQFfhhTG/O7U32zYp9T0DljG1OmTmvjy7zyOnuDh8R7L/md
 vyGGXvKRpM5N1v5or7aAImbPZi/rN+ndWpDRH/JTY2AO/TW+nlQiDOROBe++JNmKqf6NfKNuzt7
 6JQJDJ4VUdmqNlZ9rHyEcMw9lnrKMWzpllAzoGen53LVjn/ENOkoo8kRIjlKqP5J6Lot/vt+rmW
 5MlLKNZoYwtFxVUnD0qg7+Uu9wrKa0V76GQB1XNKL8yLkHsZcWfG/wbPurGLv0HyGNiJ0D8mP3c
 kiupkLr4B9cFzxJrNJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040065

Hi Markus,

On 11/3/26 1:37 PM, Markus Schneider-Pargmann (TI) wrote:
> Hi,
> 
> there are some issues with cppi41 regarding suspend/resume. This series
> fixes suspend/resume when the device is currently runtime suspended. It
> also fixes an incomplete restore of QMGR_MEMCTRL during resume. To make
> the restore on resume more reliable the last patch unifies the register
> writes for init and resume.
> 
> I tested this series with am335x-evm
> 

Thanks for the patches.

I was able to test on multiple am335 boards, so for the series:

Tested-by: Judith Mendez <jm@ti.com>
