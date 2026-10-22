Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792696567;
	b=5g26eSodbzkaYmyernHtKH8PnpdvwSubDIdhxqoGfCK8rMsPGTuYzRz1VunxRxGMTn2G
	 IcudSxxlaBb/faNpYWWMFRb47SdST6L40YcT9r3Tzp6f4o/QUboQrRMFzlW92gTghtMAF
	 RWuIz2ky8ub4Rfd9+L/VoS5AlO77xAe9u1o8kSX183nfgdMqOtFJFEN2NFhO6SKEe0z8h
	 7dmSS57GdWUe7T6OJJJczAUU2An85Ws/EAJ+sxhJAEQqnBLncFJ8xH1mtatCxT6AZB7Gr
	 1y6DwA8QtueY3VO/2oGJAwI2pmomIDO90tW4NzVeV6CysmZDtwp/lTzTNqT78Azhb/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696567;
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FeLmysmKEgLN6mVCGyBGx3ACHG5Zp6fXQh1F7bQ2A2k=;
	b=CO3gxJ7eluxLN1OceuHTYF9tuAyyXd1sf2ZJ6xNZ2gAraMwmX/t3surCkaYkzvjpv9NL
	 wpjEXEfhGvhfo0clkO2f1SFFolqtS0Jd4f1b3MyriTVokL+Rg2ZeWFEHSseDFzEXoG5Fu
	 BT6UriuoW3uv+L1rnbvQrVIrJSGRh6/ZafKcPE3OXlHdfD1xhVrf8ZnSsh3/vlwhbC5Wb
	 ikOTn0jlbkcyq4XudfahADD9t1Lh9IACgUbIj1h5TwycM2D+GHfzT4/3WEYnyYDdc/wwu
	 6nZU9Eo2jX7UMrKxqw1Gn0M4pnn6Pk8xKZByrsrR8CAtQuh0Uojzxe0ERqJnT0mb+kA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZtdTCIbK;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NVzvfXWB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240B606A320;
	Thu, 22 Oct 2026 19:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8240B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ZtdTCIbK;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=NVzvfXWB
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69MHsY05827038;
	Thu, 22 Oct 2026 14:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=FeLmysmKEgLN6mVCGyBGx3ACHG5Zp6fXQh1F7bQ2A
	2k=; b=ZtdTCIbKRABVGqe79R825q7YD6kya+zGSrLyey0VISwEjQv/U22Ll1XRY
	hLBPOd0UU4fDuVN6PAp24ldU6z89h2ZAVf/V4EKtKvtF7UIDjOmip56TCz4EAOCz
	l3WCJYPyayuhOTgVcQX5zB+8RmbmPRO6jJ21MGjsxSQv3qk2dAhsHiUoZotzk/5T
	1C6VWOvWDr8FJALcJ1/zgNFHBtaIjdyM1nShlbx0zIFRQ+yZ03qIaRhQjNIfy23Y
	fHcF8qA/jK60Xv017MBI9a+YwlMFYoZnd7ablb4H65FCmqnwHGf+198xfIBgKpxP
	jzzctx5wNANhACs21hUXzty90BnMQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hfmg21rgc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:16:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQcDIovp2/hFEUnBZBqCsjBWvwK2yLB+gMfGA4JrhyoZUr5DqDKUQjZRn/sxTr7dko3ud9SVqoOfxe0STx6xwRKIspPPHS069Yj7kemfba/qnySocEeYRdZRuMrT7wm2FXFDtXtJV3mQlwfqKtZk6U16NNe34FItso/W7IJVy9WYcjHZ2Quc1HpK+QjfEw1VSbwvSMfCpUxMAOMi9gyxY9fxCP6cKx/t1rqrQAD0TvNKQ+au72eQsD2f3DyYIsEq7k4/lJNzJ2BGhuK2ILJH0Z9HxvFxiiiI3rn3URrdN/NuD6r/9upch3DggiD2Om0CChh3zYtM2ghsWC87YaL+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeLmysmKEgLN6mVCGyBGx3ACHG5Zp6fXQh1F7bQ2A2k=;
 b=uPhIEie5wP/dsQh7o5KJz83QOI+33Xbnkl4NaJLNVkkduQT5UqT0SP8CCQd2a7UYM3EpN6ssN21+4o5zQkt7KeJwZOdN/Y/pmoXeyzmD7Y0DfA6WWnBc+OvTS+ngQ+x99dYdOoYMTfhqnw9Ke00p+1333+SHFI+z5L+V6vDhrzjgt1X3RSTWIcDf9WQ6jX4Qc5j2MDP1gPuuyXvoB0IAqmCKn3IkDbWaM1XtPzSCSwTmQFls3pAUMQeUPQRoLpy4pemSz2VnLuFE6uWxqzmUAf/x3p1nYYL5BEFOQ2YikUuFipyHpEb5pau7dvLUPqPiOH5jkSiEQ4oJV7E9NBoo/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeLmysmKEgLN6mVCGyBGx3ACHG5Zp6fXQh1F7bQ2A2k=;
 b=NVzvfXWBoM3iDzcfKz8/u1DfuDVnNc5zWD8hN+N6xNjDlQGMSH5rd+WG+YwXaU/7ESAPreQqhMWk7BxbQULep75Eq0GQTKu8rPy6LTYr8f5ryAJ+5wyAVJioveH37Z9rCVPmT/cJ1fSG+0Yq333b35mzmuxYRJ36C9HwCuNOiGM=
Received: from CH0PR04CA0082.namprd04.prod.outlook.com (2603:10b6:610:74::27)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 19:15:53 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:610:74:cafe::45) by CH0PR04CA0082.outlook.office365.com
 (2603:10b6:610:74::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 19:15:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 19:15:51 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 14:15:07 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 22 Oct
 2026 14:15:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 22 Oct 2026 14:15:07 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69MJF5iW989659;
	Thu, 22 Oct 2026 14:15:07 -0500
From: <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <nicolas.dufresne@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v5 2/4] media: imagination: e5010: Fix clk never enabled without CONFIG_PM
Date: Thu, 22 Oct 2026 14:15:01 -0500
Message-ID: <20261022191503.1025072-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022191503.1025072-1-b-brnich@ti.com>
References: <20261022191503.1025072-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: beb738ab-8354-4017-bde2-08df3070e31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261009223027099003|261022105027099003|261022075727099003|56012099006|261021135927099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MyiyM9qReekZiDfNRi6KDLLQGSn7IixohcKJqQsHzAMF1ESXXKSdvnKQ797l99o2jyPEyb8BVC4HZr9XJd4oDv3ih4Q80XS8hImB1Gz1c2q6frShioRP0sVfDAl7A0qK71Z1/vvq8bNVQr1QAuS+VubPko8Rpwht9BtGwSgFjiXUlhIoboL2jx8tXnjKqbqdlbX/aY4wIwhGB+0+e8C924piXQdAxMaRIRYF4zDegpXgJLaegN215OCyXbpyLgw6YV4fD+ckXiuIMeXKvLtc9iddL/ZO6VMq/0bQYKo/gu3ubs6S8LeIayxM/PfebU3QcLW+xCtps3c9z+/gt5MT1Je4qJaQdqHQAAw0aPa6ryqZud/pj/Z4AvUAPoMlTFWayA/igXm2WIC1Jwl4hVMkOE3ifLUo58qVq4bOrrX514qvp0LDbdvsMxW/Iwj3PV5C8/u5d/h+vmpYq8+cXZU07hGbL0oCEmqIUz2rtMYOQHncvrr2Q/pD4r3DjlxjziVD1eMCspii5qPumt793xSudKvlQXODbe+Tgt6l1BHBJfPaSwST7oIi0TTih2L1/8dN0akJt8FtW9v4j4vqvEc1D9TruJNVp153p34pO7g5kSXeH8JzBkyPPEcriBfs6Ns+XTl1ENMBUGhfaTEQv9DSuoAgpUYGlfoYO0Pq8R9XiFg7eYENw0Vxs6fgZpzZGT05ZNq/2UaBELBJpGoqFjro2Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261009223027099003)(261022105027099003)(261022075727099003)(56012099006)(261021135927099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dnde5vA6wPcNDSGqa5x7lalS2iNMulWKfKpePeM9seZIZBIgvsudyPmZbJgIQ38o9iZ+/ibwpl1fGWYw9vKQbrcNXpMXMb4+pEz1mPYAIQN1gHfrTSvh7PeY3eF9O3Swpq4GubxhryH/rZk4CxwXxkhbn/RLI/KOOq7vEC8kD9r/8qyel0/uWeWpq7Q+tqAPZGCa96a2j2qX7FF3tYRXhJ7T9RZEU7Iz/b74DpTVwbGOcxkkLiye+4JdqpFkS5scLCxI20gynenO2AISbnhQtghC7Cdh9sTq3SkviB0UOsQkBHcxPizL6B7dxEhEaCSSCHYY/JXuuvZUj9IiNY1RcSFA625ub3Sgq9nvW3XihUJ3V/u3uxMvlKoT2FO27915zsmwwax0/fvC1/lL08Izt3g+I8e2ST0HNjKbPqOfVdgt9TdzP/HonqjAjGZhTts8
X-Exchange-RoutingPolicyChecked:
	eA8FjaEbGY4RcePXfxMbCdw0aF7ovoB/K7HPoTDUYChf3vikD3RczBmiTe5nsh+6hjgn5/4v3XEIe6fdQ17jDLPcIsdCaj21VQK86NRsqQ8XUgR4yEnSeSQMhpC0PijHKiLUFjbDYPXjUP+2UmDlxI/4PdAwfdiGJP6qi9xFAhDijERjsaAMEhiq+KpY46y6/u2cHt0MVhld8DR2jeQjluBWUcWb9FXwq6TmsSqGxal/COdU68e577+gIEPFHj8BVc+3hluzgACvO44D2MIrUFbMw0VJQXOdmd0CvPRyWlVrLVCnAaGwQxxXKEOvj29UoP/3nXaC7UNYd7bq9Z9CDg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 19:15:51.3386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beb738ab-8354-4017-bde2-08df3070e31a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfXye6ObLUieewd
 KBVF/76Z2spkL4JQpG2ygl8noiKnUkQuB+9+wXyJ+T7q3Z8aNScQG6/2ixfwvyUayiTwoFvKLhc
 ItBsxI3BVma5+xCQUGdolpNl5faNdpw=
X-Proofpoint-ORIG-GUID: XCIFW5TEm3ROepwqE6Qe1UGc1w7HNr4z
X-Authority-Analysis: v=2.4 cv=XISl2ghE c=1 sm=1 tr=0 ts=6ada60f3 cx=c_pps
 a=+LMkLzjU88PdHoliF3eHPQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=zWFe5wUI5KCZgEF_U1gA:9
X-Proofpoint-GUID: XCIFW5TEm3ROepwqE6Qe1UGc1w7HNr4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX6unHBIPpnLRH
 Tvkzl/Fkp/yhaXfHlkiB5ALJZVTsgdJXJsp9aCEpTll9fmnHfWznJvTrTf14vjGxiKisJeZOM7y
 qMumjdEAy/GHR70z/21HJw8Kvx0OQGF5p0MoQuhHnYI8CxS1wtzeDuKvxXkuvURWzLVXtD+95Gg
 4DM3CvZHiowwWkkUxtPmafViDNobH6lVmy+rXVzEW5Suk9XGhEQSKAnCHbXLM7TmZk0hOZQItGQ
 FE9Zzi1SFGJl+088NV7AU1hUxegZeQhzbbyLV63LsrEOHUHGZm7qMmtmtQEOI4o0j5NEW0FShXY
 zk8RWpiTQQmpI2stGZ+Kk0BK05oWmJ9QxNrV3IRZTafp1HlI7NruIZhBqsvRVZ/G/8VwOPld1Hl
 aHwRk7/LqbODoIWGWiMgh/H60Q92yCJtD7tgccB4xVP7JjFHafZzDch/Sm4TjFIzFXi8i7W06/S
 z0Ps/Y9VI5QiRX5+vvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220076

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
index 628d3ee35fb83..b8e24f816648d 100644
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
-		goto fail_after_video_register_device;
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

