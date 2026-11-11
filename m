Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416804;
	b=5W1adTo4VwQlDtwX4r/4ev3hxzCYr+esfHrDhAvJqT94ZEMA8QgEli7JHAAxIct4Yruh
	 Y81vk3MyVR6w2oxfoJuBTa0oeURSgCusso7ogdFp2muFryf2+LbR4vOtF4T5dLehGPlu9
	 aCrG4GQZapRoY6MeFheZR0HM2k4toL497UACc97AyQwesK1rguBVQKd2BSbiwLIhUwzRK
	 z465fUtBLo9fnoo9838y8086y2uGWTa3Y2qP6qpfOYOacyl0rXQAKhbLUFeRDHr5ioUMw
	 jJ4gMr7G2Ez+J7LICvRZdGraHsXt7HfT9nQAS5uFD8iypCOXqlHNd5/3ApGT1Lj2iWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416804;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
	b=NQ/9hEia4HPqdIcUBGAqpPaD3/eyIDwp68Yrhj9Ckj7NbYPz+gHGI83M5IeAKPpJTg6d
	 vXEfzjtrthKTO4qjk8PceHNY/qynerdcI1LEXfIMZEiDCDd+IjCUL+pC9gdiPcNmYl/zS
	 kqbIomDpeF+D1QbkVqEjM5RhfpP2or++KxS7+5e4xkYHop3X/lz6Il4eIzLDQU1I8qOsd
	 JG1t76IVpgRwe4k/1fVCMSG31/HrMjFoWTMzVB0pueG4HApoFQnc1N2Cd5vsul+Jka7Dq
	 dbanBTALVOBPVSgUvaQCF2d0ZIkXyL/gyXr9RFQZWQErU9Ttq65xRvRi7Uz5IX2YMGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aUir5G0G;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NodPnHaT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84920606A32D;
	Wed, 11 Nov 2026 17:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84920606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=aUir5G0G;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NodPnHaT
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF2tB2980992;
	Wed, 11 Nov 2026 11:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbx
	Y8=; b=aUir5G0G3MnImtg5WR/mQSNAbZx+BkrOgVF1xhG7oponjH9tbCr8TiSzr
	/1BgEUywcydQpscE0/2sMmninqrmnfog7FzaHFO7fUUEnlkdN3LIQzzT254bn5N6
	Q1pod6rMrHmejYrHGQXT08AaRJDXcruITVjLYHXRao39Naa+cfsVwPIAm0n7m6Dh
	rn0xlB+bc5IBQydt2Mrx2dMT35iC0eHTKUJVFmGciUNwRn6cc7EL+AvJMD8dWPEo
	wTgBIAfI9RCSi76Ia6dPeYjDkvRWWVcj4Fu0SD0kgT/9uw9Ok699ytpsuJxR31sN
	TU68AEidriQeOShgs7cNv5CkNlaWw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv9pjxc32-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 11:06:36 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FksuSB8NABJA1gAHl2PYaJQL1BMTpRUj/sCbczJ66tjeUGcrvrjkawtyupm2nXsUjZxILFk6hXO1tlN74DT2oNHdl9Zve3n+6R3hCkLhV0tkarAv2WPDJU+nxrPwdKUovk/68/RqRRoUc3BbYfoBFT4ob9j5Vd26zRW2qxLMihf2tWaKAF2uqDDK3wDGk+y8P3OcmflwmRGtKmC8Zb/HYMnHbQstHvCJiUMIvGyWkkPBYvVXzEfnhmhAC/hHD/vVW8sPspYZS8PyJf2vT6gnLIZT8/b1JuyL41AMZlwCRoE1HTR3DQ/c0vF4q644T9FFmSeVg7ePOIaHNyu4BenXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
 b=jdrLLAiVnNU/wC2GqrprVkZSmmWfWqYctc2EWCvjV2XOA2z6UwWe7+EA0MY70WgrewNJRjmVLpM14nS+vwDVhwQ6eL00PfqAQZkuBR4EnCC+LGjnXLEcDetH1SZFuISJIm9RKar2NBeJP/ZfqeydfXHvp7E0WI4AXUo2BUaJXejbdVNzz/WenU1qLys6lwFc12Tm+mXK7NEeyle5obuMPAz986ITGMWL34ZuwLzOK3t+gypwAfvwPf45MnE0MzUrSU6Cf34pVh4Iclc9q/nwwgrgbncryUcS5Ou9CK9DbNYHWmn/r8QR5jWMrWm6KMAMvDkFaD/ZrToQ0oXhz4olug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
 b=NodPnHaTFLH+rfJ3whFJHK6RKc3VsRkjOIPd12ygb8y1cOe/0vBicoy1xxxlbw6n7ByL44QlrYLt8FcqpPIzUL9HjtDPEpIhMc3565YFxDWrGW5X2uEnFK0xvtYRS4uXBThWsao/m9QR5HvkXisE4lghWCSyKwOmY8b4XHw4Bqo=
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 17:06:01 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::7) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 17:06:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 17:06:01 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 11:05:33 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 11:05:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 11 Nov 2026 11:05:32 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ABH5WAq123833;
	Wed, 11 Nov 2026 11:05:32 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Myeonghun Pak
	<mhun512@gmail.com>, <stable@vger.kernel.org>,
        Brandon Brnich
	<b-brnich@ti.com>
Subject: [PATCH v9 1/4] media: imagination: e5010: release m2m device on probe failure
Date: Wed, 11 Nov 2026 11:05:27 -0600
Message-ID: <20261111170530.809226-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111170530.809226-1-b-brnich@ti.com>
References: <20261111170530.809226-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: dc480307-9bfd-4f9d-d8bf-08df40161026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|261021135927099003|261022105027099003|261021123027099003|56012099006|261026121527099003|261009223027099003|261022115727099003|261022075727099003|261102123227099003|261021121427099003|10067099003|261028144727099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SuH6g/Av5ZLfXuN5UV9lCvyXtVil+lu0BnwfQOZc9V0+oPSNc4jMU99wgceqYt9kT/QWe9diUIzGuVD49IxcnpYmTmX4q1AAqfR5MAFMNzMcOXu3UjjbuLhjRKNOMxupg08T8rcOePy1aM8smBikjlAMhivH9rYTfoxqqAU5IirbRUf0ZfJFktA+FvQL7f14UC3qBANpiZj7ZlNFXTEJcEIPP7Ky3/vY0SA2z3bZlk0WIHRQdh+mvdldguCeC4nmiK0A8WHT85fuH7GVpibKRceAE7Ag34yXYqL4cUQiYVGaF0fieogGbjwZBWy6Gb/45wZQApuFNsKCIeA1sT5ffYreiJmp/XoPh1/+yOQqrmMwjMcGxguGLRAnW6c6Zft+nEnCB8t7bc9i/An5N5+Vx6A2yEZMwKqUaElIr/OOkjVUdeGa4pHlTeoIicNuhzTztR9jcMSI44xUYmDETcnrXQZ6bdE0iTVSzAakFnD/VHaeQmHH8MrvAzoRRyebH1brz5GXAeace2mDJkLi5HN6oKR9Pn9jwW1+4d6RTqqK1JYSj7fZ6ttipxifYUOUC0fniCwMfCs1cY+TVGHx15Tfv1tzKbrUGQEh0Lz0x3Kg7YohK20kBGtmZdPKRIAy/3Mpk6DJaSbq99AIVbuROkz0S/t+R75RTWClxCtyMdh8NAcH1dI8nSfRlTXfKbsCpdig1Y3XndWvuFfa0z/Rmq6Fow==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(261021135927099003)(261022105027099003)(261021123027099003)(56012099006)(261026121527099003)(261009223027099003)(261022115727099003)(261022075727099003)(261102123227099003)(261021121427099003)(10067099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EKfAoJmhwFmL9IVjUw7guBqdOHNmD2Ws/9nSZ7jeX+ETKt+S6sBdQr4HQaNATIb5W3EtKp/g9l+aHLyT+ye8jDYZkV7AdF0hZMxgFv+sffbs9FKCwbD9uuDuKq0VPTkySA1ELl+IkLCZcs8H4q1LWSmuh/5JN9qfH0Ja0MuEk/mP7JJMwLpNHVayD8rWotiMgaxxJ85WsKgvRsngL1gf5KVsp44ARW76F0hyhFspaAoi12xAC5rV/nlepL4yuIoHEEdAlcHKgyeAYRXkQneZlruSCnUiZStB3d7lzz9IwY7byGVl+pw+cj8KVKtW7SBRvrMp4ccoOuvcL2b45WdRyAnUObV28DHgnAFZgpcXy23WXy2QHouiTEWPj+Fz1cXXQZ+wMHlskh8bHLTwXk8tKyXdcB10fqPySwnnbPzcMois1tpotRadeKi0eZLQr4eo
X-Exchange-RoutingPolicyChecked:
	kcovE21AhkNMb7P6DGKleyC2QtIWZ2TDcO7fD9j33RMOl/Yhl1E0SV9C+XnBivf/ZKjUCnii7oJ2Um0o+t4paGIt4Q3lvkuPVzbRT6u28+o/xLOcw5sNyKkSC+nYPRqzrIuKw+b9JvQAX/5qpkCeDXD0wz/IikEjHZIBMvlALAZLdEz1yM2P8VinaJ1mSHhANwLEa1GlI7nivX3LoQ6SBSZAAu3nXBQeYHfVK6swLXB3Zp78vc9DuoYK08M6mVUclEiUmKP5RkK2KB3x6HLOHaDKUEk7+5g1Wpj6QsUWZ1UzF/hcdqFNjlg7tLpniFGgc2J2c4uz4z9BNEsnOAU7Xw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:06:01.3107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc480307-9bfd-4f9d-d8bf-08df40161026
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX6hqhcQ5lH/cK
 HC8niPiIqXWjp/BPBONJxbQ/XGelJlUp0nONQQuve0npXTSTkdSIz23JESkMnyWWBeld+XQh3PV
 WOFeACn/4K+8X77UFZaU486Xgxp2nSJawPxddDsosBBf/cr3urzga5SgVK6gcvx2/lR0LaHJzGE
 7huV39S9OfuDDuTgGHY7TxQMOOJpjYrLArXpD75x3OsNtRMMcUVysWCjrESxLsopZUhyKHkNapl
 5FIiki/HIf6Rad0j8hCrbwnkEDJIx4h1fRVgwMrPdordQTymCXAEBehUc4V9D899z9oY+ET58xa
 Ri6H+kPS5u4lHZZ9u/7Wq+EF/IPzpvRjUdLabIU9cr9X6GIg68gXi40GC/hYtbXyoIS2vakKpyX
 XLMgzgBDK1dXIkjzPK18AtHT+gpiIvKkBoeutVlyFGLPFR8cVs4qWV/LqpY+bZaKBbRNuGif37H
 YzTJ9Ntjym/7zHHjprg==
X-Proofpoint-GUID: 9BA66kwCVeITICrMnWaZ8TU4MYzvhdZ-
X-Authority-Analysis: v=2.4 cv=ebOo7LEH c=1 sm=1 tr=0 ts=6af4a09c cx=c_pps
 a=n1uwvu+HdmtEBt1mSuDWUg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=gr1l5o3e6m0uxnHE9TMA:9
X-Proofpoint-ORIG-GUID: 9BA66kwCVeITICrMnWaZ8TU4MYzvhdZ-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX+UM5ZN1OkH5W
 JWW2avKgoEsAEFWY4EW6RIt20tOB8kE5veYk5I/op+J7RkOjpG+l0NwAvA8TGpBOPqftAZSdVDm
 MtaZyuPCFEjpphfz4feFy6W4knyweNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110067

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

