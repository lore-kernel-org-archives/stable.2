Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792766807;
	b=hnI5ObT8wDVKQPt9RLlkXYYS9QztQMQWHwlW0y2098fIf3mH2MqWU5MWKSAVF2D3IDVN
	 aRRFzWLOtr3YlN+T5HKktO6mqN/8ns2OLl0FB+347Zm6gAxTLmqCBRSVWAxDKZMqW/Zn3
	 L6uKZJC3IJw+22oPmbBRcQmQH3nY8cd29dSA9qNJwuVYOv8ZNbPbK+uN/GqF8Liwd6l9w
	 vvENJ7yibG2wfgJv77+JRI8KVHetXH0du46B7WJlDlmu5e8Y5nE3rN6vD5IdCP1kwj7te
	 dp3GGR3flV1k/vaSlpuIIuQ0VD0DoJj2T2R2FwNe7GQRw0ZWxi7p0CyLXQxGUcdVtVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766807;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=R45fJ0KpAS9of8xg4TaEtA/zobBkmJQgMIQazMMM4uY=;
	b=5RHIEPWucqCPvHZl6CQP5ToVTTV28DhGFaAWReYq3a0MffoMn8EvnEGeE16hnk5yvAuy
	 jE2ZN3nHB+aLjDdEN3oYDHBhkw5VCAlxMCtZ5tc6b0MP0j9z/4abAxMXyT+6SVGatquEG
	 MMCCKrQvYuARVD0KKRLXfxoUJBDEJcs8Rgo1zQ46SXXLegfJQ60gGAYrPOcXGV29OaF/C
	 Ijql39f+YuISKU2RRhnDcx3WTh9eoaOJuXxpLoPxKkHAtNIEvNIvuBXpW+HnasZPAbmvD
	 HqiJkav3z70DIsh81wxFWEokzMFKLIhysFwYBfMCYl2WYOB6BgpqWVtdBPu9Abgno+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MAiJzgO1;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b="Qru6j5/P";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD2606A325;
	Fri, 23 Oct 2026 14:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6BD2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MAiJzgO1;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Qru6j5/P
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NETcAR3426172;
	Fri, 23 Oct 2026 09:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=R45fJ0KpAS9of8xg4TaEtA/zobBkmJQgMIQazMMM4
	uY=; b=MAiJzgO1ltc5f07RF4TrScEiB3LkwBUXRfOUvx3zLz6WQTi+hKL05MmUJ
	jW9himLvdjglCA2UPPi9hll3HIKCVE7fwyI6kBFpbdevSwce3jtRpW3LGPuwW29M
	t95cImPq1GuEM6y4mrB10P9G/JFeYIRLeq2EmPy6qoPts3EQvEl/gVCUFKRcdkom
	prcCsNCE9jm3+y4BPRtsDbK9l/FkzUWZSzaCfgz0yHAP2tGj0t4qfzaBSHoySRcZ
	RMsiBVj0LTre/fvm/qPmJfUAW0XKfRW5vqSoykiFAWl8Fm3ahGBJw8jcn8QvEwaY
	UeEgflkdWdTIremrtLnfX1ZnuNbJg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hg9d3r2y8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:46:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIbo1SuvdKu40SmGPhKDeQeoGI+IREWPTBEUz+1UXxJ2t02+FhrxIoXIt0cBAiUBkONfueKfBNBT0j04a4+5/BT9ZNbfvk/YZirG3oyWziadntvo4mpxU/32abNiWwCVaKY19wzFueYkM0YwfVk4hUJCVPPlZz6OPjGNPYCrmCD83vxmCpZ6H+0np1MowDLBmdfzO12H2AeI9T5bjFPFTcvt9HikEl9CSGOgfzZUdqziNbx1Ze8xChYrldAvgLrgKwNn5UaBWp23hoJaFUaxTQHTCQJCpGqvcbCUg98MwrKqRVYIOQYe0bt+qSL5ASRxiwyZ/JKqrVoYLGCFpAe2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R45fJ0KpAS9of8xg4TaEtA/zobBkmJQgMIQazMMM4uY=;
 b=zVv3ctFVJ5sF/6gDZuQrxxh9BTnV/JKYkjKZopRV/I1RzxSVMuSKUKD2+qtwNgmptRhBRSZsCna6Bo7EBq51GdQreIM/4UWfrd3tcTIYJlF+vvDTVcBtsBRbKiU6onMaYqYme+D4+X0EMFYzJvHvcx8POZx3E0CIJ8QmSuhprQqepOQjeaVA5Vbmo0WE7pN6LZ7D1zX5XrZMpSxJWwwrXc1RxGSSZF8kRJT5EUclBPIvFEPkhyqvNYEs+fSHQz1g+XJfRO9kosXTRg8vSumPxcmOuYHiXuXhaZv/zQ+Hvo5eNznvaHSCzBXTbuUCElA2eSh5+GoPcGu9hpsiKmMkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R45fJ0KpAS9of8xg4TaEtA/zobBkmJQgMIQazMMM4uY=;
 b=Qru6j5/PXF+jykihFq1Dcl/EkkV8aTobaycNzMUWd83CSAdYErZbkmd6NFYmf0RX1bMdc8kfqAz5uiDFl0YEUi6OMRDVJQeOxzr6T5NKI4kU+fw8QPdtRt3f5ig4YTc5DREdR/d+QUl96yOzCHF7Pq8030DvvAqAFsOcxJYMe9s=
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by SJ5PPF1EC0B6C27.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::793) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:46:40 +0000
Received: from CH2PEPF000166BD.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::9c) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 14:46:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF000166BD.mail.protection.outlook.com (10.167.252.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 14:46:40 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 09:46:21 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 09:46:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 23 Oct 2026 09:46:21 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69NEkKtM3571302;
	Fri, 23 Oct 2026 09:46:21 -0500
From: <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <nicolas.dufresne@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v6 2/4] media: imagination: e5010: Fix clk never enabled without CONFIG_PM
Date: Fri, 23 Oct 2026 09:46:16 -0500
Message-ID: <20261023144618.1652390-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023144618.1652390-1-b-brnich@ti.com>
References: <20261023144618.1652390-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BD:EE_|SJ5PPF1EC0B6C27:EE_
X-MS-Office365-Filtering-Correlation-Id: b200e8f8-2008-4db9-ec55-08df31147291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|22082099003|56012099006|261022105027099003|261022075727099003|261009223027099003|261021121427099003|261022115727099003|10067099003|261021123027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	8tjVPFQESz2bmTpwcZUH5WDombNakneTTha0dswX1EfkuwElrEhlH6dDHzTXsgo57qNOEXZnPtnyPNiFpHfXr2xLO6NP1Fr/f/TSDD9IWIm31/tIlwuygi93lTZTGgna1LvJ9vSa7Xc9Z0hsTsIZ5UK/8pE/2VLgttfvpBogUSkBBexHMBH5sS5uI3IeumVV8SYdNYFje0UBQq6qngtjAdNSwMHmn8N+mB/PI0ETaCmhexJgGNXHR7YrGn3c6XeqVTItMCUTz6NXtg4luRL/hBBGpCMYENseh+j12MiSSpPMPHdx4HGURmXD8Hck3ckSpnaYFj7jsd36oUlaXpi/OVdOe5bndRqCEaNREvePWTVWMfB2B6D7Rp7kF+oOK8pbHqw/iXtwjrAJ7i8H/OF1NqC8pnHZIpmcEqqgFkZMse9f6tfmc1IvRx/c/AvsblrIHk4UldJmyKPyUzbrSL4zHdsrHGmL4v+flbmAxQJLonXbwAgSNywjR11pSCxqmJZtB1mTJa+t2umDlKgpnWwO7jcNy9EjKTVk1JzV2eKaJytROJfttpQYLLVLuXqHieu39BcHOawzeVhS4PKF2AajzLo9UH9BukrtfpGkvcm+ecaEXgNnLX+JOV2T06uBb0R9H1/r7QCzgm393o7Qbs4sShddAmsDlJdlO755FiRBq+GgHHaHzEeiibUDoVsCA+zaWWp0glb1y6qq+NM5L9K6vA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021121427099003)(261022115727099003)(10067099003)(261021123027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AQjDUpHG5F5x8U+k9FVd2Qkb4vsT4ZLfrvKI232rSttkUTkIcq+0ZNSyd4dZVMDxtVChuUWXBxpY+An9/KXsZiLGXGgbum2ImnjSdN3dVNgiZKiYaFpP3KoxJ25fVpv+f3rWNdkIJWTon+0j64e2mJf48qcLSq/uYNiISjkGjatp3KDsPxgF0o1g+rw8dzLVm3ALMHn5GP6S71r5ehxnVKobSYte3IZosVL20jCouHlxvt8Gks7bkVHmAdevJTGy4IU0M26n8oOol7esAdAZUgvYjIcHpslGAUSzqJyAqg5W8RyhikZw1KQbDAXAqveG+29Oq2jxjbPoAvsTy1VXihbM0dFqoa7/ZHG/nZoIcdpu6dxKqEuQa1rE7KuWmTgbzVlTtgJ3USxhlY87GPbReNLS3MwkWi26D7S5v2tm55Bs7OV+xhY8hksKR6ujo/Hl
X-Exchange-RoutingPolicyChecked:
	oEbiz/QgNWo0xFeOzoNGcsiHBZGlhlYMxgQBWn+rBT5Hod2sO08U3ssFtAiDJYj9DWKk0Ue6k8+Hr9ZnWeIBV3lPXjhkJ7T90WUjdcryY+PWVQ89XBLCODDek8vkmpBLksTCaDSDeoJQKVAtWDfFO7s7gN4tSoWl25/cGiwZPnmGOJR6l/okL07ekKz78VNuJeYE/+1Uh+qhGMIXXKRThA5PA9CyDshuWdZRgL2ge5wa20FRSWvPdXGemup9YUD0X+dsei/oeMF5QXYInPAf0ObAFpfu+tQ4LoQ2thltR95rxruF17boojend0id0ujG0TIRDv4LpGctLe9po6ZDNw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:46:40.0127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b200e8f8-2008-4db9-ec55-08df31147291
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1EC0B6C27
X-Authority-Analysis: v=2.4 cv=R6uWitRX c=1 sm=1 tr=0 ts=6adb7352 cx=c_pps
 a=dVriaH61pmWkicxGRshTTg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=zWFe5wUI5KCZgEF_U1gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX8mnoShBY5sMt
 CJbO+bzVMiqDA3gxR2+kTdcCYWybmLSa4N454Nyrbd/gB1NgtM+Z4OnCqYDX559aaSATr/xeeI7
 DFnom9/AaZYdqoAKcWO6vlPS3ElIPh9Jgnni/JqQmqsH92tZ062Axcl9xcixyCNTYk96TBS+jn+
 oyEestSVBtMrPn2llIJc2Sh3v9Ui7hkJpkK8gypcJYoMxSHk2V8Yj/BQkCMtefg374hGsdN1Hqx
 twIbDAUIGH4+VAmj6x3Xr0A9ZhSj3XIea/DzHtnyl4uWEWVTnkeeX6MBrpjkIp9Q0KVYLDLLlsb
 x3BNrnqwxOFJ01/Am/sJlN4Pjj13Mqwxm6SyX+8TdNx4ha1zTTZuyetoUWcJUMRDjmOfYFLGzlm
 g1yPDcO6aa7N1SiFYQdzBVCbHIntAMPr2Cz4s9jq9Qd6iJueazLzqf4JHKgX4jrbE6t7ss4Wn2d
 JvZmyCCstgeT4N4W+Rg==
X-Proofpoint-GUID: igBrvTjDhnNbjkDCRTig7nxx_Q6gfP-R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX4jnavP+ZJ/tH
 J5T1Subks/nfvEDTWBv0h9LFZUziiCvqh6V5xoxXVV/BtXMXVkiphenI4RunK/cvqa9LFrmzEhK
 VRhg3UVm5SGdZWCo/DcZuWSBi9EDaOE=
X-Proofpoint-ORIG-GUID: igBrvTjDhnNbjkDCRTig7nxx_Q6gfP-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230057

From: Brandon Brnich <b-brnich@ti.com>

clk_prepare_enable is not called anywhere unless CONFIG_PM is set. This
means without CONFIG_PM, the JPEG Encoder will not function properly.

Add this call during the probe sequence to properly configure the device.
If video_registration fails after clk is enabled, clk would be left on.
Make a label to cover this case.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../media/platform/imagination/e5010-jpeg-enc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 23d06709a6929..b8e24f816648d 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1101,10 +1101,18 @@ static int e5010_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	if (!pm_runtime_enabled(dev)) {
+		ret = clk_prepare_enable(e5010->clk);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to enable clock\n");
+			goto fail_after_v4l2_m2m_init;
+		}
+	}
+
 	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register video device\n");
-		goto fail_after_v4l2_m2m_init;
+		goto fail_after_clock_enable;
 	}
 
 	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
@@ -1112,6 +1120,11 @@ static int e5010_probe(struct platform_device *pdev)
 
 	return 0;
 
+fail_after_clock_enable:
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		clk_disable_unprepare(e5010->clk);
 fail_after_v4l2_m2m_init:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
@@ -1126,6 +1139,8 @@ static void e5010_remove(struct platform_device *pdev)
 	struct e5010_dev *e5010 = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(e5010->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		clk_disable_unprepare(e5010->clk);
 	video_unregister_device(e5010->vdev);
 	v4l2_m2m_release(e5010->m2m_dev);
 	v4l2_device_unregister(&e5010->v4l2_dev);
-- 
2.43.0

