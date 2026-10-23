Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792766805;
	b=WIfIKY+YD0KYHvytT5gmylv6KKbSE24SPUPM5PIVG22p27hGFgq4Qndz3qPdSnghAZ7C
	 D16XaD9dHnG2w2ogbuGrB3O3ik+2v6go5lI5HWK6gDgGfqAmR5PBCgdh4hhKiZaSB9TNA
	 YdyzY+SiroxY770asYwCQuKbdW9dBPLkS4CvJdzExvNhWaN8b/m13ab4Z8mO6mzUJ4D3T
	 8IxBhmfxDCmFw9rVt1L9saAYVdJSUkxDuVJPvmzbDxM0TMLGRvBmPM0RUi3mG6CUHUYzP
	 4g0ln8J+QRy1Iw39e1SxkSZePRnjSDOZWs485e+a9v8kLUWsbBWz00hZ/E3g5xukxHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766805;
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
	bh=5bpT5AsP3iVb5AzB5wC8ZOrzfMmFpZBtlzNLGZ3gBnc=;
	b=bMZztoXzpmF/Sb86BtjBXyRYDfSrawXTWP+F58hPyzdkylM+BivvsUkidYkBJESVnWDF
	 NwRuJuzQoPuwwg54mr3bRHcklpHlOsxCfGSaMLEmcLVzkPXQYm1Rp7cwt3oQvNb/YT8Hy
	 S6a1MOqMCicFtZESrU2seEq4z+djbiIgV3UhzuBOytkp5bHY2Q+Ihr3HCnJF7PMSFf7oo
	 TmcI5lA2EoQhz3yu8YZIvXZcTRhDmoXE337tUMOLPGSfhT+R3Axi77UVNED4ZZ+oJaitN
	 a9nT116Cr5gWzRYghLB4avPCi/m7/ge1QQxCBLbrr0KKngwzxU/xncuSq/miT7M+pgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cCsbpXZG;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Lj24d6SD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E34606A31B;
	Fri, 23 Oct 2026 14:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E34606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cCsbpXZG;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Lj24d6SD
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NETeHD3426223;
	Fri, 23 Oct 2026 09:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=5bpT5AsP3iVb5AzB5wC8ZOrzfMmFpZBtlzNLGZ3gB
	nc=; b=cCsbpXZGp+mi284mMKEQ+9FsLLCqsqeeNkksPeYaemJHJLqiPZacH/QV2
	FnUHDJscf5ySIg6kmQlYCJX9dzJ9xBmiA8WQkIMsxbetfl4cUgw43H1N38QfvBm2
	vGwNLsNUk1mkEgxngl9YGVn338vJ/9Rhc15bpvGfYI4zWKFIQJoVJwaExfMye7OU
	99YChPzuSkEUvfo42euNgFWPkOrRbXBBRg2jzbKnrDC/d+bwyfw0LrJ7gO5G9EfV
	A6esbIj+Hwc2Eg6veBVDiE1oGqLakcwxg9FT827gFMXmljoASYmLGzKBV5JzrJIp
	P0vUEBtQYVZ60Eye2KFdCuU9jboNA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hg9d3r2xw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 09:46:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZegqzzkVZa90eHgcR6FvlCH7zBMniyy3Jo2zMPS10LH3LArnOQwQf7geoP9ZZTAct5GHzMqcYuPRL87ETmCV3Og80HfbraV8esU82tyshn0Z0KONHMqITURO64f2zl1tcbh9ASNft/PiW8B3LLsx+CynbHhYKNvZxJacNkKu8RTnH2ST9BXOw142TbHqIk6vPD91OErymtnXVzoPiZ27YR1+539POiAMx5mkGx6PW1aTZrAb8JdquDfLaClLUOC5opH9LG4FI5H+Ma1fz41A2w6kM4MAiDuT+Bk1dpLljiCr7VS/qle454/Ew2eyaG1vzyV8+tzuo+9d2cVU31I89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bpT5AsP3iVb5AzB5wC8ZOrzfMmFpZBtlzNLGZ3gBnc=;
 b=fb+zjHeZzbTD4see3lKyBwd8idGh4sm4/QsJOUm9SyyOgbc5dkm+Tta2rw3ppksGN4k9UXR5ejz2bzeawtuf1xkzcyBLJ4smtQnv/Tm9RD+M1fVWI5CKsIoYzhH0atib8X2Vb7JVNy5Dzj/7CzF6z0x5v2K9EhGboqnV9EkFr7tHS3WfBDbwH11H+D0ltoX6P388jMNef9Cz71HWbSpy47kZoRWmBt2WboZVey9UrAQlYD83E1dcnSu7CuWecKY9nt92IVca+g317geKYEO9snEr9OqiJ146x82hle5kpH76KMCGZF63m71NUJYa4PWtoKIhc+TigizEHV4VxMDIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bpT5AsP3iVb5AzB5wC8ZOrzfMmFpZBtlzNLGZ3gBnc=;
 b=Lj24d6SDU/27u8letWL83vuxaaz+HWLHcyC2dXQFFKJ9j39H5+jDc0tHHVIPz6FkXds/HOhGGmM9K6UyI7Z63V7jCqmDXqQOOw6VhsPE/FgjFDUafDue2SESiUFon7X4WgfuXEkGI8lBN/zkoqef/7lFMGUFqCw0TWzPpDDL8GU=
Received: from PH8PR20CA0024.namprd20.prod.outlook.com (2603:10b6:510:23c::19)
 by SABPR10MB997940.namprd10.prod.outlook.com (2603:10b6:806:4f0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:46:36 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::1) by PH8PR20CA0024.outlook.office365.com
 (2603:10b6:510:23c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 14:46:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 14:46:36 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 09:46:21 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 23 Oct
 2026 09:46:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 23 Oct 2026 09:46:21 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69NEkKtL3571302;
	Fri, 23 Oct 2026 09:46:21 -0500
From: <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <nicolas.dufresne@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <b-brnich@ti.com>, Myeonghun Pak <mhun512@gmail.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v6 1/4] media: imagination: e5010: release m2m device on probe failure
Date: Fri, 23 Oct 2026 09:46:15 -0500
Message-ID: <20261023144618.1652390-2-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|SABPR10MB997940:EE_
X-MS-Office365-Filtering-Correlation-Id: de17b463-2c45-4a52-e576-08df31147084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|261022105027099003|261022075727099003|261009223027099003|261022115727099003|261021135927099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	isE8WNXO4+k7MJ2EEamKJSrSi2WkjNlnLQ+xmeDrCWjIX3+ip6S63KmJwlQW+/0HHt2KiKzvzKCycCZeXXPoe4SSCuvcs1rLvWQxfi/XV+ZaczSpTQ+ls1UVrCeM6+5DtF4x4nMJMdpkfF4huxenoh4c2XjzEXlHJiQbGyozUoYXyPOmXlR/XKQ2lPzNIQ9VyGFKQ1M1L0uNAlWRDXQ2JvauKkXMPtdFw9FVG9Iuah0/HT9uI506yrQdsnSME6fmjG0kqD3Opado+xezC+Ub7+EQfot7o/AV6uNMnMUbUZvGlww0Xic24yIZi4x/J7sj/z6bE+1qaUCOLUUSmDuNKenLCVpekAnRvFb3ubK3Ar7W0y8N2JxNt0X9KU+PgliqabmjmTarldZ8NlHWm1RdPdMP6yGo1EWt59TYZXfDmFegRbTPt3r43BH165zzyHSWzlVEZVAL/d8Kh78e2XCoL2lNYSQnl3uVcKW3CsfT1d875W02/fW8BnqOh2858ct4hiW99KRzJ/Ac/7HtQb/46v0+22n/FsFvb9VGivF8FaheiYz/1RwiRaAvGiC7olEyv6M8ZdWjlybwq+UuhEvsUWKqcW0OlbFEmsw+hvB7w481joFK+lOFeZjrZH7dpe4YfifphFkiszeS8TUS5XcQ/nIXTaxZvz8iR8bHqQjt7B2PfQ5KFA4cECLIl6HXijTlRS45rDbpaahOtX8YZ5xu1g==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261022115727099003)(261021135927099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CWcewXCJxVewudXOUSvpLH+0/C/4eX/aK5wy64NgsSDMmCwx81wPPUJqiFPejRroD2NyQV8xQCKlu+BZVtFZsqY7OrN9fEzo4Xcfpemrzz+JgmXjnmkBrIgOMf9ov8tOryvXTwD/JcEeL7qD1NCkddHjdYbiqK62t+W35XUJvGrwVBSq1zPSNNPMFf8RW17PlA2kd0ws+nyPY8G5b1zIkHBM1y5K8yxN5v3biEJ1l64tnWu6z0cVOnp5DKQeMtAhIEWMfQnWgQNjb6KQeCtZ8PxIxzyWAIcydISjOe2eXifz1T8GNGVjj6MOPKBn0cgQIBJ3kn9/ypm2aDVO7TELL+SNHK6Sn765Opb2GJf4OaoeEisbTObluDeUbW1lz1EBF76VQQBx3SohxZ6mmax9XxShfCBlcSQSVmsNbOThu9v9vYVlLaX0tt1b3zKI+aB+
X-Exchange-RoutingPolicyChecked:
	sQ0qh5N4U4iFDeInEbC6pUrZv9m90gmwnp6aioTTyoS87IFroDmHJMz8Sg1+8iZmIN03FnSmVuP6p9BlEvdZhjgsO9gQHzdOxCmcbLmobo8KQO0fkc4P2bOG5Ku7JNQI/lQ07/ncVpUhbTdyCHIzbfhJkiyFV8P7U6EPPRyK1VZlfudZDZQHvJzn1hGH81ByDH9aifkIBEiJM0OADDCCjN23LuiG3hepnkmFg1arZf+YzSKsIUBPkQESMsydqlYOmlE6xgF1lmL5MLzsALLH3mpVdaR4+9Bvfskfu8LnEZES/lRoldQWY4pJW8zB0Vh23nt29Fw0q1dcwOGb5/tIkg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:46:36.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de17b463-2c45-4a52-e576-08df31147084
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR10MB997940
X-Authority-Analysis: v=2.4 cv=R6uWitRX c=1 sm=1 tr=0 ts=6adb734f cx=c_pps
 a=Y/Y9x3HtMOqQL+YbCjVQEg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=gr1l5o3e6m0uxnHE9TMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX3gYL5RalYi5H
 DFFmJ9Tfrw5jJtebl4HJQH1mePlY3hvwbhpixZqDFjaerN3ssmde1YtmFwLBeWYIRBQmSzhGe+u
 BsIMcdUqApBDmUxkZQ22rA778R7jz9OPu88nXTTnTvucT5a/pWZibaVDL83h0SivPrADrZG+Pbw
 89CMfLpylMH8ONfYxFcm4HFvzMyYj5o3UMwlraWASI/XQHapQYZSQHSdQCJq3l/z4i75xIgIhsZ
 +TLv2g/Q7Y1DS/APbGlHJ6B1HQ4fk9gObnfmghE6mGXeN7OwBQ+NvpjQ/J8EQPugL7sZI81WNLt
 EI+HPC0Zt9ii3ba2dMJwVl9h8wPCR9cFuswlTTy+Q7ezQPKBzbcJqa9t5e3Jc5jhieD/zai2Xk1
 F/1qlj7UsVPVdkmphZwEgweK8XjcYD4OsoyLHwI5fb3YZBhhs6tYy45xQucIL+Mf9T9ItYNfDmC
 X9tdmxrJvigLb6ohgig==
X-Proofpoint-GUID: jNAbUx8uZo42H4DkkQcBcn5YB44Ln-1e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX48DG9fAgNWdU
 sOq2uvgyeogcCKLdygu3JWJR7ggNSZ1cL9mIEPnG2lH3TSJ0QLaHwclKSos4yvac2F5LCVfQpKe
 Gr9SPucAtMifgJmkax0lOrEfEvC2YBw=
X-Proofpoint-ORIG-GUID: jNAbUx8uZo42H4DkkQcBcn5YB44Ln-1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230057

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

