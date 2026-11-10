Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794328406;
	b=ApPG/FPE2lX+85KO1qgc80lyYjmxsaodhb629jeChm1643Q5nMX9x8g0nf3Km4qZ3w8Q
	 ljZgrhrBzjerLF37kX5LzbqUPaDQoh1XrXPhsmbh9dMdnlIhLv+15Vmtf012+zObIuVg3
	 ULpH6sXzI50kpkeaz5ei83fhH60JptJ/0SYvLJBJfG7haTOHhv8wUmfMg7Feyfals0z1D
	 sLKwHRdcK3uI22cGsPm3ZEMj1VSkJP6ulgdYk+mYHNCegtnWZTH9hQ0TWpZpicf56L0p6
	 JcsXqjDGkghW36RLG8xLJAGBX7A8Xf5dK9ZYqde2dniyts0v8GN/LkIhgTRmWXoot6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328406;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
	b=nrBaZY4yjkIlXu/mQN3GEUijU70EnaI6+LTVznYpsPCKxrrh9dhSTzDe2kt6EO6TPI1d
	 OdlsjhLXfZ9SXRAH2+eITUFUeKlMn8X++nyNuGPhvX7DVtHDaaxXbwkdntMYNRB2q7NHB
	 45D5/0NdYnvYlzM28Z8joWQaSnRZdwK8ew0OFRO65lPd8PFPYx6D1/+66VNpsX2tWX7zR
	 6k1a7LJtkj1LgIZuCux23MxffSO9nFJweFmT17a9vZJfbK9vKO1YMrxHjTR7Aw8MbBq2u
	 RR8A14fLGGPo/RpNDobnC//DnF7YbLPVyMF6+b5D6hnnuJBk8pxcUOhYsM4X/ubtG3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hWbxWQxS;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=sGd3dRcJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA0606A223;
	Tue, 10 Nov 2026 16:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9FA0606A223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hWbxWQxS;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=sGd3dRcJ
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AAEw5Qm2016011;
	Tue, 10 Nov 2026 10:33:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbx
	Y8=; b=hWbxWQxSecEGX9qmobpQSU5Q9ze6RPj8fnH+NADpYTTb1BPBouRmeWOc+
	OA4qeXzxbNQFTzgXPKw9xflQVVA4koA5NNFZDu6z0vGQXIvSWobxHQdVpANtm6zK
	vpec20SAvamWPMUq1njTzLmyQyr+QnRUlqVP/3ASSDHR/t0TTA9r9Hwc0wGeGji3
	akoVqIVoHKhi0rjAW6udWuX6xP/WI4mTkefn8k1fa/REO3WlhPjNEmGCpM8b9OM6
	iGPCC524il/dAHAENVcsvwhAWQkTfM3eUNR537J8ZE7cHz5+4WxWpaOa2K+cbW1+
	sTdeEhHrEJ7m/5NI8udLQvUkti2cQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	by m0380145.ppops.net (PPS) with ESMTPS id 4huxnx31j8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 10:33:15 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhtllf46I1J4YtJ25n5/wTh0toRGdT4G8GpXSkPxBdRDqPYmCBFSbJVe96knH68j/mARqXNJdQ0a5TbT/uvU2Xy6XiaX7DIJgZsbqfc2lKTrm3rXBnqiBla6FgnrcUyAsfNVvQ5l7eP1KNryljBZIW2UijkOvTcKLT1tmr9w3W0MNGDkmq3zgIiOA8pdWgNbpEqNhIGFMNvK7GdxxVemx7cko1uibQWg73X6XWTvOLSwxVEXrlUk0xIzbMcW4QfpcYuDvroSLKMH2CYDGWjF3JNENJ/bVX4udPBOUbHKdcC3IQhZgAgmElGu5CWcjrVhmBriEiM78+IgSYYVjZqqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
 b=tZZ9YrwIZ30Mx0X9iRVMHjSaoOhc3wSXiiK7R6nUwRDs92RfjzAElMWT+44+SDQh+H3LoFilXRwRXR+9rtD6SBXsnoT/9ddZDA8SXV2SVW3kT0P0r5v+6MKO1CUvRZQn4knp0Ie9tlsdKanr3mPijc6Hy8H+Z9kL3JN2XyU2zb6+htVLd/jGaADr8sF8HiKjh53K4LagwIMDBwtZNXmcRZID/2/ztP0tkFGvgVM1ll36KTG7HfqoJgPBkv/Io7DKlQGQXydPlEKEEQIAp0zE18RyEblOiozF4S0bivuvzT0SQV4Ye2CMQlunmeyY4N0cOVxBcsgLztHDGw+FgvbaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOdGZDWGuP7lsiQ+IZoKV7uFiqyGTz+WicBvDVNbxY8=;
 b=sGd3dRcJEGeN4iVDoaUInS2UpbeLjmp6Enu7rOlUvlLZx1DPvzSQueFc9i/2aQ2iK2+tlEb4x4dVf8+7Cvt0344073DWeYKylv1Bb7XP25lvSuTnl/TgQTIJ4yhVTM3UJeE9IjpDzO2tyHb5w2uQPLlEEQvyi4E3oPxugVmh/0s=
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 16:33:10 +0000
Received: from EA8PEPF0000000C.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::35) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 16:33:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 EA8PEPF0000000C.mail.protection.outlook.com (10.167.249.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 16:33:10 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:32:50 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:32:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 10:32:50 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAGWoH41141135;
	Tue, 10 Nov 2026 10:32:50 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Myeonghun Pak
	<mhun512@gmail.com>, <stable@vger.kernel.org>,
        Brandon Brnich
	<b-brnich@ti.com>
Subject: [PATCH v8 1/4] media: imagination: e5010: release m2m device on probe failure
Date: Tue, 10 Nov 2026 10:32:44 -0600
Message-ID: <20261110163247.48712-2-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110163247.48712-1-b-brnich@ti.com>
References: <20261110163247.48712-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000C:EE_|PH0PR10MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3135f8-f2b9-4765-4a7d-08df3f484ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|18002099003|22082099003|10067099003|261009223027099003|261022115727099003|261026121527099003|261028144727099003|261102123227099003|56012099006|261021135927099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	ZYpMfpczES1BGmQoVH6z+qsQD+NB/cBpHz0tVnC6FAaqMQbjouqvQ9OaCE70UjAVtsx2D5qFBEZn64HsyDUKn3kt2Nsap7I4y0Rx6GjxQobqtb4ho0JfWegrcs6LJzaY1UVhERnB/aB5vAPgsy6JDCyQMQpiDGMNS3iM8rFWYXKxj1y1VVvIhDLQSBehIrgbjnSGgcfczoLCQEDHAVZy6aEpjnBxnpBN3JdAlkEFa6dOXuw93hSGQ3UCYsoGzfYmryFyGGsPrvVfOnozQNMg0f+JLZFJ8Urqm0IHQG7ocoL1eNbmCPtLqnoV+F9Wy2GpiyKl13B1HBSlOn87MNx7Viw0TO9DCgFiJeDiOBA4k2c2ytHxBZHMhxMgUrYK8dD2dBwKFKGyvGs50pNVkaMbpYIVMwmIIBhesKd6W/aGsVQHAxg6D7SbHWKWclV5maLrov5TBZ2Xy6CqlG28HsFhpzOPK5MBhKPMV0+Hn6LBG7Y1bSwJxdSwabPZx1a4+VvV2VGdfw+RwjeZt4gDNBlldSlN00VqYXV4W2i3ZmTiyHVnOxAOClQGhkzX0BF2orFxTXHcFbSqPYpnUH/kEdVm+IQfH06urIuTZ5Lb+rZGopQpMkqFfBPUK8IIf4plfYiunW2TeG6c/BFPn6vR9aiP4gPhORmSjYQi7elWxUBKLmELGACQa/bTbW8N9lIshqi0ezBu94+ynPQbZm+xzPUilg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(261009223027099003)(261022115727099003)(261026121527099003)(261028144727099003)(261102123227099003)(56012099006)(261021135927099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xvgOeDS/Oh/E9dvzHmfIVZL6Nx6FvsjtQaO5Y+TW1oAWon5K4oa4JjNsFfxVH59WMh2BGJKuzEXyab+9XduK3oZ4fQneKkU/yNafIGQZIevyCQ5ala+x6brPChNUVwwExEVPRzv92cHsKIqB8pSEylFXnASIUFkLRD2sOoxx6iE2CZFsbPfV3AUGcRu2luX1Gi5lzVI/ZJn6WIkFC4LHu7cmvGAwxSvl/RZ0dlKZTYL7Mo673BSdVDtvoxhV0GcSTSW9VCkqDCmYNTLsCX942Y3pStYy3fkv5KClaxrHP97NNmI15gMf4r3WPZq2mGN1a8ZWzlbKzwkXCgSkbDxF8dorgYsbItyL///cq+Tk7QpND0DdYzMLDUPfKDnPwykAKz4MThjF4hkd5MeM2r/l0JvroyI1xHXLUxND9kwkKz3x9rize1L2WUcKaIvQd57G
X-Exchange-RoutingPolicyChecked:
	iSKMjwGarY18qDagDKDnhevamcDtAiNo2CxfFhqa+pGtd5qDSdAbd4Afi8u/98I/pMKRsdDpXG1DBuNRoyR5n3p5ewkWZB7WsSDO1p6wHJzBzJoBMnyHvoCXMrWQhg6R+dwqhMLIDWLuorAQpexLFTwSqTsXU5GxjNvDvQ0f4RwY9u714jXvTxFYkz6m6Jn0Vc134dnhBfVCghkZ5W9f+O1+VOL7h3Q3PtSMHVEnLWknwEbeQb9ITXHKCrxVuvXpHXAAnWhcQ0g5esZlXTBDuSEiHM2DkZ9asqHswrQm8uVjnCvq2/3etMMM9DAHIc3HCX9S6JJz1ROZltdS8ujPdQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:33:10.0791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3135f8-f2b9-4765-4a7d-08df3f484ecb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	EA8PEPF0000000C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-ORIG-GUID: p_1gXyMyNoShGvL9VL_kTf5Z6sqwuwEd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfXz2AWWYubGhTA
 OE+caltcNq/SOpdclk1xFYUsa2UKS7UNhYACPkO43GmGQKkO6ZHoZisqeci/iU1wn5pMU+2Q7Wh
 fWaJNNW1Eu3p99KxnRkRwhQCiM6F47M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX8qSd3QSOqA7x
 x5Cph1vHf0kAZLnzyTsEdXfyGKLWOnKj15Cz5FBJFmm1T8QWcXqRroS8wgebZ4wuiisgjUVwkML
 0uUoMZx3Qr5N0FeiOAufZAm8P954nxpY6BW0qi6IfJEmeEvm90SxAWLCQp+z4kPCYx4Bb08w/AV
 Vxsk2SJfHEqIWFSGAN4/bn5JArByC8FP6QIeYpL4+QNSqw0tNhfty3leNUrp81b+9NwfHp2Xc0r
 V9wZS3V+5sloOz8KXxuLzWF1p7NE1HpU/YHPHrimCCnZU1LxI7i/rPfAv+XbH/1KV3//+KVVI57
 l9lwHQeNIl9HSFgXAi1+HunBX/uE/gMT/OF17CMCwO0E4g3UGl4BRu15rddvhgcs2NElcm2iAA4
 EvoMMGSlpXk7xLLZd0Gvb8axluJz0uBV/425dSlClQDhJo6ZvXpKYbd+Mxmllmn+ef5mokpcJZ4
 Dbkf5th9uNPzu0cn9+A==
X-Proofpoint-GUID: p_1gXyMyNoShGvL9VL_kTf5Z6sqwuwEd
X-Authority-Analysis: v=2.4 cv=b4cncdGx c=1 sm=1 tr=0 ts=6af3474b cx=c_pps
 a=kwEYnkRUmkAH8qI+i8sEWA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=gr1l5o3e6m0uxnHE9TMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100065

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

