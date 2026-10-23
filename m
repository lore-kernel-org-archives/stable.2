Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792766817;
	b=VWsOIuaMugzgeL2MeYrrbCg78hIKuflaIsRM2P3wjDWPSmFCcd7cvvO57bgYMNDfMbRh
	 4c5MrdhxeqHpyMRZWjQloGkiGvZKxNokzq/I0WzmkEFIts0rwR7b1AGyasJstrY9bcTun
	 Sao7PNhGe8WUd04cJP+A5BY0u2iaS8Q+8/1kxMlILJABuBJ7O+POgPUFTOkcBueMPYHfh
	 6S44WcNOIPMZBMLxDXKNpIlykyk6KGEuHkDkzXEeQd3leYHh5HX9Ql0eyIXfVgk1RME3E
	 bnFMC1K0U/k6iwqX7QKAFcsYdTuZFyWlrEpLPyKzM8PUhDK+fUILCaHAlxcJtkTKIxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766817;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/LbOo=;
	b=VJ70EMmMvBGa1xGI2bfzyKI8zJ9BfsCdQQOIAfydUSLCuP3zwUbPskJHN5/PuEpKReUL
	 wl8wuZuWgr/xy/zI4TQtthqVTIQOPYk4/B6ip30eCVKvhk1kq3DUhsnO7BnvYSKCDHJnF
	 6D/ne7BzyghBUEZVRQhcFtDOUqzLx1o6NBPCrI8eH2CozR47p+pz4Uj65fNC36uD84QMY
	 KDif/MOarVe7agRlpFqA3jwC0pjjnUPrY0CU5fD4SlBmkZWVuT8lw2xOrD9+R6SneKUCC
	 diXOR2k+dDeY0As8Zioqdm1EKiJmwKMeOMJTQyXOjcaBJ7v4/LqFn5cJZyMJ0vbS3/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FpuolPh8;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=aiuQr2qI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70DE606A336;
	Fri, 23 Oct 2026 14:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A70DE606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FpuolPh8;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=aiuQr2qI
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE5oZD2786387;
	Fri, 23 Oct 2026 09:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/Lb
	Oo=; b=FpuolPh8thuKZRc4YndXGySLJE4FhviT2QhKu2gi6nIWtRDDsQgmP8YZN
	k3AczGGexT7BH1K+9BxFhPbnDZRvblP9JtNwOPmo0VDbS2HhDfB4YNgFC5JTUqKd
	iGSUZYZOt1zw61Al1TM7Bzhp2n2TAXzLsEHS6Ymu9gwLFazPsQmTsoSyBBszK9Zs
	cyTYAlxMzb5j72888MWOEWHs4cMURllKg8jcr6o+ofBzdWdyZiL1tvuJN4t4veo4
	VPN5Jwz+si4g1siOg+WORyIUKTQlku9vhLDRC5sC+fq4SZ05CdcDU2QodGsABnnn
	gc5sDn2fsCkM9we3CG2KiJSR4/xKg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hfybtkdjq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:46:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTIZR/vxpM9Ph5SOVHqDLp7wEhHaEo4qHq5efRpj933tfJNQ6F84SAAmmTNNdu8gEWBlr8aXxtjkS5PDKmOy9/BreCF7hzwsq2hAaHqHTWEHKlEBgWvkaGl4fFg0SJvRAEVUO2ZVnYixXysZaTaQwVNqpcF1MC1AGMRSgtrx1dl1hm33qXuvGSAI/V/EcV8+a/4VMWIkoxSZe29aDiIymDJ+hI1cCK1FUToOASVoR6v3H/R8Mn7HYtz4r6PYkQlZpTD8+1mslZoeOqKc+FtNcliXEQit6AKs9h3AEEUR4MZIvP7Qif1mPSAukUhWbkd6XJrHhOwYcwc1LBrL5NM0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/LbOo=;
 b=gDAYEHCfWUeAHN2EN3xYizaIXEFOMaOKbxaK5sr6Jf3BsDuEsmIAAUGYoCVJX1ZyB7PHBuKkqCECOaYGvpYsRqVPiTksVf/+deT2nRP1XO2tYa0nCCTWPJP9OID84seV2pehcRTt9RYHPZ+Qt9zCGTeWKvjXJHAn6AgIPlOomNogMUyd86H9y27YraUU9qxcCEfjllP6D5rfcQkUB0FHObHDmkTL/9I6q4vc8njgZn6OX/NpelAL3bBibjAikV6verhDjTt5lsfqFI0QgzbROpS61JoE9wFNkSrxgjEfoXZyWxIuu1UVk6zcEjMmub0gBYDJFR6xUy2wcH2pQkYBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLYtueitTvgi/ZThJmC3uavr0sKKEo3n5/NsVl/LbOo=;
 b=aiuQr2qIO9tavlXAQWxgm2fopt038Q1wBy9txxp4g8AncNn8TiNXDVNqL5KSYqtUsVsPduY8Z/MBYRcIyyrQtntsjtmo9rM8vvJUNyEJtYGyrLpL1tx0avUhFXFgl2ROk1V5ipcaI1ehhSXnGNW4JSpwLO9hvrI4lF1F4dImDAA=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by SJ0PR10MB6327.namprd10.prod.outlook.com (2603:10b6:a03:44d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 14:46:39 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::33) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 14:46:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 14:46:37 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 09:46:21 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 09:46:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 23 Oct 2026 09:46:21 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69NEkKtN3571302;
	Fri, 23 Oct 2026 09:46:21 -0500
From: <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <nicolas.dufresne@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <b-brnich@ti.com>, <stable@vger.kernel.org>,
        Jai Luthra
	<jai.luthra@ideasonboard.com>,
        Kendall Willis <k-willis@ti.com>
Subject: [PATCH v6 3/4] media: imagination: e5010: Move e5010_init_device to Runtime Resume Hook
Date: Fri, 23 Oct 2026 09:46:17 -0500
Message-ID: <20261023144618.1652390-4-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|SJ0PR10MB6327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb5e202-40bc-4865-b845-08df311470e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|261022115727099003|261022113327099003|56012099006|261021135927099003|261021123027099003|10067099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	nFgPBZZ23CcHvJa17UjWx2ytG43kRGCB+CRCBKXTRpw7sY3tXcsA/He87WOWETTs9+/BiDwhghA0Uu4Yc7mZT/cAXKC84tbWHqFmQwvckCRuWYl75wuwRNMQWbE14xzmgxrhEZkk0ECAv9HiWnbggrOiZU/pDBnihTcSyG/2SPJ62bbUlyHWvh7hKFSaur/jlc5Rlh/tkcuZXayBsKP52J4KItvPtnd7kBdHPjYm4Jt5O7iDeBLr+LZOKzG/f1xJPes4v8tsk1dLUdVP86d2q2xODQkijInesAsXQ+C11XRju46LZZp22ng8fTxgEvA4Iq3rBIouQaEVaziK6j/WqK8aQSyqnO01zhf4/iqoFHCpbAgoCVfqRBaYSDTIU9oVryF99U6TMDT4m9AdWJv+5bUJj3rdkmT2UHiWD/LezUBYBrhwkrT/5FlYf/fteFtbfNgypUIwlYG11jy8xqhJX4UiFvhbyWutQbq1f3re01Rz5BzOrSO4R7VX2fMPUYwJLFhGZ28ZDqeNxk8ETbYhlT2lgoa9aCkyyu9BbSAFq7mjrPTmAlQb6nDCqrkQMY9UluVfOEkj0f6ylT/oHIQXB1HKp5PgVGgbbjE0Sn5KEw0kaK8ZPu2OPBq4Z7Yy7YFY1knb0J55xXTW+1caEDdhcnQPBxOy+MT4dzFACPs0mXvi4zTVVdpcVLxqK3q1BlSB3MOqa44/vbNm15snusykyQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261022115727099003)(261022113327099003)(56012099006)(261021135927099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sTd7l1aaVX2V+Gdfzv5TchyzcqnEaHaopSmIINjsYZGQHc8TN+e5CiwMjsPhmnydjzRq4/Pn4jVV4Xxw4Mun/g2ZTshiNUQVGPQNzKwth/lM15dgbQV2qc3eDiPuUM5PQDSyQQ+CX9ghJ0w3iE9eNb6ICFpw3tVA0W8EfPxsDRKLm8y2geSyDyhq/eLEfyfIs1hyDJEX62AZ33pM6heRa387Yi5+Be+wj/CenRFzlpQaHEAZ5qM887zhQJ3sitYn1LUzBTWe2DiwyzExeT/q93+1VHgoKct361yC3HC6LyWoVC1OjC5zz6MAww2oIE1zx5p3T/93CRCR27EwfdQGoomrHZ1xRbokHQv+YqQyd+KEE/NJcHoHdOYY/FzsoamPTgomyxDPXVp5k7eUFgORHdcw6QmddHzmhz8n3jkSC0ZLRbsWFvY63BGyXdtl3obW
X-Exchange-RoutingPolicyChecked:
	Ki/5QhVSXQ76/9QyevdTdqRRojh656MgLhMeBnoBR3z6e1Y94KcQEbBdG8y9krwsnxg9pt7ODpuVBDmLuO8O4SbN6zQy/vCoVfiq7B1b5CwoZDMUw80KEtCiIPjQ3LopnpHF2Q72TeLKUdfpUMcueiAwoDSeXxpaHpbCsilHt0H0gLHApouJLRAyPBBwb62dRLBOifnapmi3KcsAhGUrCIebJCGC8/oQLBNPjKU6ZhUOAPV4Iq+Zhcs1sUakFrV4TQtta5riYpkLm+tdlxCnM/6WGaRnTu57W+pw5hPVyitFa301KjyyBjhkiKYRUYT/b5LxNU2sO/nKHhS+ecOLKA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:46:37.1672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb5e202-40bc-4865-b845-08df311470e4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6327
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfXxLpA1FlhiFBZ
 QBESxtVr3MdHcb1OlFrqZ8/HX+W20bOky3X7Q2rFJ4m6sZ+V4HJGtsP+2C4kwqXbrOyTZlbLCmR
 uDTn7d8y3U9yZmGChTwFrRxwLB35PP8=
X-Proofpoint-GUID: c8UAeooXE9X1fdikr1sund-Q_j61lwyo
X-Proofpoint-ORIG-GUID: c8UAeooXE9X1fdikr1sund-Q_j61lwyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX4snExWSfIfFN
 EM6ajdZxc8W1IpRiVjQozobABVvjevmGC7e08nkenDDmz8jdsB0zfXYnD/R32kgsoKg1vWddBbS
 xET96kTgc2CJhpTnLCMUfq+TJlBuar+4IsGF25umMuo/plMOTydOKS2hujToI1ggr/RaUabnVO9
 rl7rv5fewQd5WKUx8v5Eue0NJPrkzrt4R44VzaFpkelH+g1xf28WDf+lq63AJdO07NGBRyd3bAC
 KUrdOFeTQBCtKNI+mudU2w4kgKiVKCvaojJH/u95QYLr6pLMokm2566KRiiUzTufDYWHsNEfRtJ
 yXdhI008G0XWqwAx1SDLrRqFeR5o3YE+HHRlVX0H3HtWyfqdBwIrYhlzT2VKliMHpvtRznIedQb
 iAF/JHMraqhuIwdLIF5S42HTnBDKedn2E1aXK9Y8lTNuZRClxqWhwSE3S45WXRH7epV7adQSVIB
 trpULJ6AFWsNxe8MbuQ==
X-Authority-Analysis: v=2.4 cv=ZYaIpcVA c=1 sm=1 tr=0 ts=6adb735a cx=c_pps
 a=+Z8LngAnY8uKoQL+MiJmWw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8
 a=UlmMjaRoNFhtWZaF8JoA:9 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230057

From: Brandon Brnich <b-brnich@ti.com>

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device attempts a write to a powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index b8e24f816648d..c25ab9627518e 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1516,6 +1516,13 @@ static int e5010_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = e5010_init_device(e5010);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable e5010 device\n");
+		clk_disable_unprepare(e5010->clk);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1548,12 +1555,6 @@ static int e5010_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = e5010_init_device(e5010);
-	if (ret) {
-		dev_err(dev, "Failed to re-enable e5010 device\n");
-		return ret;
-	}
-
 	v4l2_m2m_resume(e5010->m2m_dev);
 
 	return ret;
-- 
2.43.0

