Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326414;
	b=bvw9gVcmunAw4vP1wS/0PlZbwthq94ryiKBGx9FMGDc0I4H06a1HqiN/ttOl58PezqGD
	 x4MTYE+ohFQDLlWDVY+TFvAIPpFNyBM2EJWiVHyscFbfqjpmhn/0BJRu34ZzTPHXPi2mv
	 l+PJAnQlEKUmJcGBQciFPORPh48HCJMOVHuLV/t8Gccw3tyGvCjz5f2HJo4JMbU6tw74l
	 nRRLMTegTP/XEFED0PLFsRq8sA6yJcs2nmWRdCqcOTfJ2pohTFdyOk/WzFHMilWYe3REN
	 dWtME+AcXCUAfUVBpF+arf+DLn7ZL+Dx1zQNWPeDwCbFtwwSZqjP8KYtFh14xQPks2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326414;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
	b=mhBzoZ7luTOca2lz3Aa6EAEClYH9yWqpBExVkNtcWZDI51ApS1V7H78yYeFr0tTzgAPU
	 iQofwDXunxWj6/4+EAXw6Jkm2DwYdflbgBf7TQOIm6nzg/0OJDeTxFo11FhUXa3wwtHhc
	 RGUJmt863APMC47Tm9e6tK9iY4aSkRVV/xwN2eJB/yXdIbfPSkIrCgp69IRlWfTXKdpff
	 Hx5gvsM3edzLV9BJM+TKHHcZr95JA8UoctPyRWwp10PoZiN4pHupXdZ+XjOAVR4CxJRAe
	 x8SsMyI4Nk8LAsnUisTPM+awIvlGRyQ8XqiEUgFEWTXCBj5kGqKFsAYNoWG8LyDE/cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EynmnP4d;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DZ8fKmSI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF63606A332;
	Tue, 10 Nov 2026 16:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EF63606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EynmnP4d;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DZ8fKmSI
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAEwGRb1618160;
	Tue, 10 Nov 2026 09:59:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbx
	Y8=; b=EynmnP4dZOKKdJqrG+qUnO+e1kgWxtlTn0RbQl25NIB/h1ta6/9n5uccT
	Ht7flLCz5bATfEZGOEUu3I7NueQojyW246NnnhTxHeWct/xv0/XpsHF6t2qKURu3
	Ie0krjDVOAo4hRiaYs91wT+dET/1lWBpxr/cxLXZQR+Q49KqhlPM6f37VosSN0t1
	lASm5YZ102UiY1y7RMcZDYViDLng3UdFeXMFKreZPGiKTmbY843CJFG6A9NtqLOE
	VmavKv3Cerz0M1h6xNVY6cwcEch8DNwgvB7ldhcdZCR6O69pkICjGGwOEIQAcVzn
	27ml3OZLi/sPx5p7vCYG2ktn/L3LQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0kst1cf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:59:31 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA4StX9aCjs2jcSckHaI2coLmaiUlJyIN8ONl8vx4VJNO8U3pQ4idGnLHUvmnw0ljqMgDWIqH3DMM1ewacLPiYR0Fw+mEy9MCIVxVGCC7/8Vl57StpMv77lxtVT2llva8vnORPGKkunsY2UQlU8XyeXJKS4An+WMyGuLCz5VeTDhp+Olj6lMDxt6IABdRlhK84+cWroTHSS+ZI9BreaJfiRAH+n3yUGhsCwuVPhxzvx7fvAFF/YPNothYLJBFMcFjb0V5emipFBGmOoMgAqq8UjfXbGHEE8RQGwfMnC9NX4A6E3KiwC0J2iKMN0ycaLRaCtscAkj5cmtBY3S6/JX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
 b=bB63PhUdSwzFi7JEc5gycKFJtLeo9EgQ1t/QoOEJ6gdR3tFYhG4s77PBd6IFlsoSXoZ6+B2CyJ6XK0koduMfCfFje3hE9ecnzga0VAW22E4APvdRrJAjZNsIBRIAJ/JFec+mTDVvGda+mfXhLnFZED1kZS0h1N91H/+wahw9zAumakwQEN59WTcxRawv0cPvUFQiGahI95ymsaZnj2OHvfI2y+WBA7AXUs/ak1SEDpiy5YaeODaz4NCeLjC5IvBSckXoFOoJ+Mp7imhMnh3DbGwSyMZvzGeKVi5nHqIGxdpDO0t5pxPmyNGoHpQIsacQ5NTOfZHrLjI6wBplvqFK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
 b=DZ8fKmSIVDKDwWo5Ch/wxouFR+fkUgr4LbatWGFkIVKW2qA7zAQk7DeFkhDN0kN5Iak6raf3MRaf/8rzQWr8bKTDYktOmoj1apGeqsz75i7Z+ABd8VqMp9+DJQmffitAchnaMVR4TDqWKLLWUofk3jJOIu/TRJp4vfQVA3drd4w=
Received: from CY8PR10CA0026.namprd10.prod.outlook.com (2603:10b6:930:4b::29)
 by IA3PR10MB8250.namprd10.prod.outlook.com (2603:10b6:208:573::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 15:58:57 +0000
Received: from DS8PEPF000000E3.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::92) by CY8PR10CA0026.outlook.office365.com
 (2603:10b6:930:4b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:58:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS8PEPF000000E3.mail.protection.outlook.com (10.167.23.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 15:58:55 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:58:14 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:58:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 09:58:14 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAFwDIT1079577;
	Tue, 10 Nov 2026 09:58:13 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Myeonghun Pak
	<mhun512@gmail.com>, <stable@vger.kernel.org>,
        Brandon Brnich
	<b-brnich@ti.com>
Subject: [PATCH v7 1/4] media: imagination: e5010: release m2m device on probe failure
Date: Tue, 10 Nov 2026 09:58:07 -0600
Message-ID: <20261110155810.18521-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110155810.18521-1-b-brnich@ti.com>
References: <20261110155810.18521-1-b-brnich@ti.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E3:EE_|IA3PR10MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: b33b251a-1041-4b96-1e4a-08df3f438638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|56012099006|18002099003|22082099003|10067099003|261009223027099003|261026121527099003|261022115727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261021135927099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	lyZZHedStVovdiw1nFpYAyeGmBuFKUbUl1pJer2kVk1J7xzfl7hk+Ty/BD/eK772jWQA5Thj6byuiN6iVGZEcgpxuSJ9/bE/Cz+72zQ7lnnHHNo7VARcjg1REV1MSM6tqVQuakkkRwY7EMxUcCgT4UlbpfGfghpXZuWaaxnAjCuTQk0ETSgm02b0780XA8KGLRCrG15p1mRXkWEhgGZbyv29/i01vMCROlUwcOQHMwiurHRIqwGwiUEwWU2lJ70r5IDZ71YcTMnzyuXAWXgvVS0u9N6R5biNKxuTXq6iDyWxRvaanXmRGCHKMjVglInrYCGn1VpkSagRzIWuYLFkhP/UCghFZnh6JwmjpwFQqm5nxAZBKpzHOOsXsQOvxhJh/PEuLpG/smK9dW721k/TM/AirvzQrjSVyzGIZP0rWkRMALDtfxAeRD/BYEqUJSMojKo2xEnDT7NcfhChqsEwQh7glrmxUPSBVMEYacE8ebVl4Ev3To23iYD/2WnhpgPs7tApzgLELGWh+ACRd6rhQOf+g31FKM3e2whCIHYF0xsTWTIsP+yxI1zkWJu8mKUSDT7XAG4OAQTG5G5JnA80bw1TxKKiYQRr49Kv+gIvvR6iUDMoyS93rJLgImewv4fC0mZVGMLPhDXsMOTRn29keI7Fprm1fzE3ubstMIZUGm1OmkUHF19XgDHsEV3ckkC+oHS4TlDTHkPinX+RCGIfQQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261026121527099003)(261022115727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261021135927099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yx7unz4mb3u7KW5ZIYEzFD3PrXwlAuhsFjKbhT7oEToZtWBomZDIjXFVfUfLK1OLZ/7TMsbpIXSJd8pAeKgxIXvYjlYS736YWjcpQKEG273ib38mGVW3Y5Ki+ISXOJS1PeapxGof4PcM0AOsSlScE+XEC5SyNDdXQaFvWVOu/qs98LvVvQyTTo3ZcdLh3JsYXuzrHQqgO3cqTTUAXGLifXXPt1xR44A1rCzjjJp5363L34/mTEEDrOLFBW65r8WxB/a4YwWEShxAfgaO13TEV3WftQtdoiDFacG7vRrBEqHC7323vMRLhE8PGG/IlieGxo+3O5aZhb/RXMWkDFs90W9IS8Hri2lyS5jTcLg8b6omiwQtBFHuK4+1rpZr/Q2uJZrb3rccH0UuOPPJAKlocJjsqQ/BhJA/zGkqSsINFBVJ7qHYWA5QgxxRpUllPnW7
X-Exchange-RoutingPolicyChecked:
	TnCqLWrLqdeT60Ykt2Xf8vDrFx3mEjaNW8XMVzM++XMo7snvNOw/dUBkl9gL8BVeEHwW6YJ2ZXYCJ6CS+bqpHdCVfr7Gbt6gSTAtHJfC0bJEgikF5DRAMwTOMc9hKUB4Jo9tY41IF4yDd3c/f2h5HK6imWWbBZC/CliGst80Eepp2VUjjQ32TyZAweVsOP+S+aWsdc9klm0i0/Hyqf0ej0/6e0QEbg4+vZ474DtKHVWVT8wFE2drEn2BTJrxIJAFN7iCu2anqC1b3cJ70kGaFAQO4r9Zh+rdMAGcaBtHCKf5tudUTsWNYsAqY4Bh334owb8VmEulZ2BQa+BFZyUQ3Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:58:55.6087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33b251a-1041-4b96-1e4a-08df3f438638
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8250
X-Proofpoint-ORIG-GUID: 1sF4AXANZ0rD5LHoZBkyCMkdABHa9RdJ
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af33f63 cx=c_pps
 a=Sa5LwqyZh1jbhgnehO2qiQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=gr1l5o3e6m0uxnHE9TMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MyBTYWx0ZWRfX/ba6Gqbdu7MT
 UrM0znWc1zs7P/+1/tlRFs9/jPdsiVDkBgBPbZwtMt/l5nLa6Q5ri8rJD1HY/Qpj79PiwYVeUKf
 l13oOekcGEO4R/vStl7cKZZ8EE2pQRgTVw0BR6DE8farRKsFZ5OxaHk1xAUKXq17IODnEjeFxnI
 nogqnxBsA5767FJ2G19LNzY0NhRBNU+tUcjiXfXQfLotnTB13Qzj/MERedgYPPKSqSFrV4VGmmx
 r/ovo8kJTMLm41YxlwY72GbeLsvT9yUKRRlPqoZTVEfiCfVrwsYyZl9fULkvMAjsvT58kLUUyze
 qVCLwDHGq4L1/kMuyJCB4I1UKHmIBBuMjPe33o5mF6ud9qMM4Z3lVHOhVb6g80hGOiidA0T1AFe
 6V09AxIrzwcLbHChoAeJWH3dQ7yzvByy6mkO1qEVDLSiMVJ/sm/H36plfR0tbjTrUdlqCnZ+cD/
 QqzsXVq/poQ3Cql+xjg==
X-Proofpoint-GUID: 1sF4AXANZ0rD5LHoZBkyCMkdABHa9RdJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MyBTYWx0ZWRfX3NAIACPyO6Kn
 MTlzpvBlvyAbZGYMHWPo0PAHooEEzHIN7nak+RmPy9kK6NKeM7BsfhLkOrsKrU5wCroAQK3pqnL
 0KB/tL/28DyMpIcdC/1PhRQKEynoRIo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100063

From: Myeonghun Pak <mhun512@gmail.com>

The probe path allocates the mem2mem device with v4l2_m2m_init(),
but several later failures jump directly to the v4l2_device_unregister()
unwind path. Since the driver core does not call .remove() after a failed
probe, those paths leak the m2m device.

Route post-v4l2_m2m_init() failures through the existing m2m release step
before unregistering the v4l2 device.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 420cb8bfdb12a..23d06709a6929 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1072,14 +1072,14 @@ static int e5010_probe(struct platform_device *pdev)
 	if (IS_ERR(e5010->core_base)) {
 		ret = PTR_ERR(e5010->core_base);
 		dev_err_probe(dev, ret, "Missing 'core' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	e5010->mmu_base = devm_platform_ioremap_resource_byname(pdev, "mmu");
 	if (IS_ERR(e5010->mmu_base)) {
 		ret = PTR_ERR(e5010->mmu_base);
 		dev_err_probe(dev, ret, "Missing 'mmu' resources area\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	e5010->last_context_run = NULL;
@@ -1089,14 +1089,14 @@ static int e5010_probe(struct platform_device *pdev)
 			       E5010_MODULE_NAME, e5010);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register IRQ %d\n", irq);
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	e5010->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(e5010->clk)) {
 		ret = PTR_ERR(e5010->clk);
 		dev_err_probe(dev, ret, "failed to get clock\n");
-		goto fail_after_v4l2_register;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	pm_runtime_enable(dev);
@@ -1104,7 +1104,7 @@ static int e5010_probe(struct platform_device *pdev)
 	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register video device\n");
-		goto fail_after_video_register_device;
+		goto fail_after_v4l2_m2m_init;
 	}
 
 	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
@@ -1112,7 +1112,7 @@ static int e5010_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail_after_video_register_device:
+fail_after_v4l2_m2m_init:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
 	v4l2_device_unregister(&e5010->v4l2_dev);
-- 
2.43.0

