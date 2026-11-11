Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794416781;
	b=VoZu5s3RniMa+uoRdjiP/TFPxuURhk45DynSTsJ7LaMN2UrWvjTfrQ9QuIDyGHBlW3cj
	 ahr5tZfnCpfp0XO4u1O4dZmDxSoRz9ErOAnak9bsnoDlr65HLwMDuYoSINnog2eGc/3JY
	 TncOU+JCBOYJKFyrwk2K3g22Gq80+0X6dQWpxvxDBe2IDcNR0JTCQR0WqKUpkeJ2bBL4v
	 RKnz2DoW8SOVl7k6kDVpiAVCIA6tzSVYw7wsZZ5GxLm/naFBH3ioIPiQudF5GEaNIGQ06
	 DrdW7QIdI+3joCWj/C1KqTWNpWJQSJosqzsRwl+A4PNNjXEpj3xqd9+i9C8L99pu1tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416781;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NsvAB9va3DlnTnlvM/tgk48YZ0KFBrWyE6HZUioLUjQ=;
	b=t4qd2ilgjhHMuvZroMMLo1ZQqLnLv7sSPpxq4kNDo7UkoVmw3sxncJzcSNeYRHrC1wmF
	 ik1HkZ1OCbjpVD/A/0Cy+hD2XqTQmp5f8moIG/XSa8PqPLIHBa8tR5WmFiXYbOuWyzqfq
	 dK25eFj8jqx1Y3LleLI6Whlxpv3j+S/pbCmCM6Q40bTX+ePjf0jj83fjp9Z46ZiSOvcTs
	 2dHj9fXotcm0PH2bxcwY5rBd9Re/8cw974aNYpMJpqmKPi1tvWHhwedu8EYxEe2CI4Yzk
	 V6XzIuj2FgjCFfNy4KBqCMudDDr2nDwTbQlIpr7RDXBLWCXJgfYhNGuYfdTOjChug0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ACA16U1B;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=efykxiD9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0546606A338;
	Wed, 11 Nov 2026 17:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0546606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ACA16U1B;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=efykxiD9
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABF30Zb222077;
	Wed, 11 Nov 2026 11:06:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=NsvAB9va3DlnTnlvM/tgk48YZ0KFBrWyE6HZUioLU
	jQ=; b=ACA16U1Bv1snjUodq2bhqkTjFvVpQJ3Xdbln41p1lHMjsqjR1wTlqQrHs
	z8HLb1Om+I19fDRIeK+wlCRVqEFbtkztpcdeR3BJ6vGj2x0gfsm5guQxdcJNeDwf
	X7s/05JNBj+CiMvXe1u3zR47BglAgr66JCuNPXKrMqV2pzVHRvRMhbWkage+/Sbv
	k3WBq6HFmEOvMriEXYmT6ey4295+ySrWVmY/G98IysAoFNUJjPY2NuNk3Z33yffY
	OJtlnjf04Hzi9HdzIHLBPGqre+I4bOjYpcnvJbeRTVTCzxEadtSfrB1kit+zSFiA
	/VL/DE9FYEm5ftMIJuRFDHwCLZd+w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hvgsym0n0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 11:06:09 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2axSRtHAZVH1iljkal4saA0LiJprruNC2+KhgBIJE6kAbsJfBiwW0rFN6uFE2SBkLMbYy8ZSvmC+EHgGBBzzlXtvjWtVyluz31ov1Xk7xazBwy6ZddO5KhLNZkNR163NWxrPZxh103C9e3BLuRXrakrb5gZANEQfpDa6mEghMKj/Dn7QOuyNnrad3vJ/bVkYgOkT1RQ+URL81Mbxa7Up/NF3LACdRo5uxDMlSxxqr/IKrUPhhaGWjC78ZK+AEhm2hjSyoMMDUOO4uyPgbo6hkapfaI72BXHJextzn/rlswi+3KTrNUUtfy7/KvPjkQB2uHkHfmojqOjOAso3ygokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsvAB9va3DlnTnlvM/tgk48YZ0KFBrWyE6HZUioLUjQ=;
 b=hg0P+PVzS6zrXm4oCJq3cO9PrqZURIcWcPMvDdMl25Z0kyojYkVU3tbxKPz9NfVIV0sEzEDU6gT3nu/9OIp/aiXZNTfuqzOwXB/EoIHXvoueJH0ZgN0QiWPANHftX1oxwgbwneQDt+j2cETrP/NpJz9KI+pdpvPTyuoBAP7LALycDUGHtjFQgmsBn25IPa7WM/7sR2eXdxPtGekaOecuwl/v4dzzSdoMiKWR0G6iB/JBlK4WJnb2vZyfnXB+5rVUH5LXIZq/D7dQ0MQ78Xg8QqJ4jO9gWpOVJ6XJB9b/Uw+06X8sKfPmLuIjKFlq7jUeInXHTeisB4sb2Cia9QbFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsvAB9va3DlnTnlvM/tgk48YZ0KFBrWyE6HZUioLUjQ=;
 b=efykxiD94OI8gEBw5oIXKjXfrYHNTAP2/U8k8sMah3ovVSP2YIPU5nYi+Bft0/eO0S9RfP6x1m7vLwd6UGnpHnjhsOsXWLXfrh2YFeeaBXnbNz7SGAI02qPjgCPTwEzriBOXazheuCl/zkXIyLa3NfQ9sqXYwoHHZI6cVTAOKBU=
Received: from MW3PR06CA0002.namprd06.prod.outlook.com (2603:10b6:303:2a::7)
 by IA1PR10MB6145.namprd10.prod.outlook.com (2603:10b6:208:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 11 Nov
 2026 17:06:02 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::a7) by MW3PR06CA0002.outlook.office365.com
 (2603:10b6:303:2a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 17:06:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 17:06:02 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 11:05:33 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 11 Nov
 2026 11:05:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 11 Nov 2026 11:05:33 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ABH5WAr123833;
	Wed, 11 Nov 2026 11:05:32 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Brandon Brnich
	<b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v9 2/4] media: imagination: e5010: Fix clk never enabled without CONFIG_PM
Date: Wed, 11 Nov 2026 11:05:28 -0600
Message-ID: <20261111170530.809226-3-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR10MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: f879417c-ea68-4073-b997-08df401610ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|261026121527099003|261102123227099003|261021135927099003|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261026140227099003|261028144727099003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aCbVIsNLJCe7sGZdvqRY9qtPT7nj9kSkM5wbxVhUrYelNNOpD+7V++vo7ytGZX76OE75U9creVLu5mdqF916jxf5jUBEkJ48+CTnuR3AndZWjAeUmdFH7hN/zyCQ5X6LNyo33IpuB1TXVRcWFm2RFkAUH8IV2LxjADGJvSFpGN06UAQoem683PRCMnNMMs1Wb5UR92aXXtu0ywVw2I6DNznSqIbKXvqU0sLkdKtYD8UDwPn7np1j3LhrkLvEsCN3MO38Pz4nuZivWa11UhwBMBwKBLtHzrnUTzlfuITnQXAB4Rs+py+UjDFZDXo/thl1aBJ63ornbXPbe5N3T6AKX5RHlehh31OEry3mdf0srBY4LpKFi/CSjnyLM2rqZQ1PWCCM70hU9cP3EXaSLgBmGnh/wRLUFLPHO3FhNm0h+g4Y3xiPyfcYaI/MjmWJ6TMN1Dm5sGjo1hra28MuLy7AzZMu8YEUWrsN6R9GkR3SOa++Z5NHzHtZvT3U0oUNS2JAoooS8GvNeKAOBozI77tPZxeCZTvcoDyiSrx7Ly36nMXdP5p9uoIzLOfVFp7viz+AtGvhpYgtECqBElXL3yoyreEbWAj9jK6/Y+QpZVvwsd/8k54fVlFe1gr9xaLrc8g2iNNl0Sd4Xwsg14zQODgp4X+8NQT+v4+Kj1Y1BDlHUAtHJh35HnsebChy+vg9dWbAFLfwIqjUmx5gQGKeb+2ZGA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(261026121527099003)(261102123227099003)(261021135927099003)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9KwnAQKSRAaFT5Cp4QxtuITVcpZHIrtvfcf4+QSYdjjijvu+shaPXNmUjG4IlS/u+FkBX7jfUoBrruBvX6e+prE3f9PjzU55EIk71P8bq0Q7jArdEvvyxzbQstaxldH854KghkxXfif0OVcdR5WnYfD86z8d3H6sU20Pers3N9ctBZEMgLUJYhuNhCeQZa3qP0cmwFNMoWRINXvLgHA+DIDeC27Gbn8ICdPKjWTPhh4nkKRvfvQe5Ib/gb0jpgf+4fGkD0MFo5MXMkGQTDiV/7WlXd4AcbaCzkWWA8tehTqzhgO6Riastucwmqt2nT7jTRLmYyJSRcmyvXmdW8xcAAwYVro1bNe1kpgu9hW8Vf6sgTGKAAcdGKDMiLuBA1AULOPrSYGoQ1D7BKV+28xa3yO2rbaY9wnidNzYpd2FhqiBY+ZtGk67j8R7Nngzlx5w
X-Exchange-RoutingPolicyChecked:
	imk6uATCOf0WiQcbW4fuOKqg+lxfEav99IPrAuz7vj5W/JtEIXxNQLm2zH61eKcWOohQcI34dC2mriJX13G4N479SBFD33tVa/GGZGaygwVU7WYuhk4ynKLHtqBHpzvpMzYO/tUmrsEVbRudfLrcj/z2hSfNElb69styDp4u8cS1mLkxmIc+K0xJcn+86YJ+SkwjFJJMD6QpOgrwNMbWWwAn65niTbF1qLA0p6asYFb6329P8unrrA/B7DfeyBSugikOhlLtSYJWsofyrooYRA7/mWkEin7/zIxpHDvvjqoil2k3WekPGm927LU+wneW77TLT+gs31o8bZWlZ+/0Kw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:06:02.1735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f879417c-ea68-4073-b997-08df401610ac
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6145
X-Proofpoint-ORIG-GUID: swCoK2jcedas2CqceGcnJhwAHpRgL5Km
X-Proofpoint-GUID: swCoK2jcedas2CqceGcnJhwAHpRgL5Km
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX2k6j/P0zfOJ3
 eU/CCb9gdRVCudoDO2pE6aM4IDR/cJLXbX993DMjFzwNmvi/LK211KHbqDIbnZpuYJigFpDQCjy
 8Cgfutk8xoLWxlZ6zS3wY3IRE8Q2EUgta3+tURPh0MrlmAYavHr4BhhAElD6BqZeuN4tp4nmM13
 CsDVIHyRyye0FdLss9TAR894PgO4CC1M9Bpb2uonF9Tof2hGqiMnC7/R4NLF9R0dPVXR1f3ZxYk
 RhkQmLN6CGFXb+yx+hu/BkwOoKDsvJMsAxuyu2UiErncPV7g296y6ooIBQRzHOeyE/0OK94OXnY
 +c+yYq5fbWLdDJgsHpyHCd2fnz1xXelrgCvp4+4wb6eqxKIiJ602BQ4AcjoiXR4p1r3++3LGY0k
 2TM05/8LO9l373jqJ02EYS4o0UjxiFHC5yINkMYAsTBi7ic44SmQAGsc/yzLNDZuQAenV1iBEJZ
 Y97DoF2xYHAsXUVQLyQ==
X-Authority-Analysis: v=2.4 cv=SpcFe/O0 c=1 sm=1 tr=0 ts=6af4a081 cx=c_pps
 a=JPuSXJPnATmcGobPKBfcew==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=-BWrc3HdS1PG3WIIs5UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2NyBTYWx0ZWRfX5/tZIax2imPh
 dwn791Bkb8W2s8ZP6quZqorAj6fw/2Qthg15MKiGeTIbL2N3Jjdn6n2KecOSPU25Etsc1sw3myS
 0JILApnTGg38CXQec2Qmx7FwRfVHaUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110067

clk_prepare_enable is not called anywhere unless CONFIG_PM is set. This
means without CONFIG_PM, the JPEG Encoder will not function properly.

Add this call during the probe sequence to properly configure the device.
If video_registration fails after clk is enabled, clk would be left on.
Make a label to cover this case.

Update e5010_remove to ensure that clock is getting disabled in the case
where e5010 was not suspended when remove gets called.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../platform/imagination/e5010-jpeg-enc.c     | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 23d06709a6929..c9dc12126cf9c 100644
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
@@ -1125,10 +1138,12 @@ static void e5010_remove(struct platform_device *pdev)
 {
 	struct e5010_dev *e5010 = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(e5010->dev);
 	video_unregister_device(e5010->vdev);
 	v4l2_m2m_release(e5010->m2m_dev);
 	v4l2_device_unregister(&e5010->v4l2_dev);
+	pm_runtime_disable(e5010->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		clk_disable_unprepare(e5010->clk);
 }
 
 static void e5010_vb2_buffers_return(struct vb2_queue *q, enum vb2_buffer_state state)
-- 
2.43.0

