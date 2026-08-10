Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E78329C6D;
	Mon, 10 Aug 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377305; cv=fail; b=Dq2IMLqYgJudknRf9w5ocFGXm+oO9vXNkE+jxIUsFKjPAuJhk6w73W5XZW3AjH0o8giAZJrShNWcx1QmwQk12tOcR0pDy9MsNKD94BG3Y8CUPJpQl6oEVfpOfeeDszcNvPXUjv3VElwmviRfG6vw8W2gOv+mmIk/3CJcoM3PxEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377305; c=relaxed/simple;
	bh=PQh23ibvorL2uOdtMTOvSFPsks/MMrMaJDFhY4vOBqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YXSXjp4tMIsk/sWpgHTJNUibqTh1u6V7kf3UmKSYIoA1LSuFdK5ycbYXeXLSbpseoun5u4So2bTVfvFSmFbzlOslIO8uoZxJg1adb/0ATjNypGAVekAVD9ogx9ouDLqgPMf2BYjBP/rpUWCKy1MT+bX3j6fsdKIjeXdPEjeCDOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Ql+bTbmS; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sZdGAcNt; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Ql+bTbmS";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sZdGAcNt"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67AFZCE13208536;
	Mon, 10 Aug 2026 10:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=ivvR72ega+7En
	qX9zz/MhrjalNiJqoIjBJQDq5Rhcos=; b=Ql+bTbmSiSWLGikE0tSJgHnfqUDpJ
	LckCsHPCfErIQ6f8Z6VjviYkEZExBuSyFJ5vSUdJQT7sWzgKP8gs3V6371IcSSWb
	qs4EpuEVLKqn2TYdW23IWJyGYZGrsHQhhGQ7+neyRtpParOwaCEot4RmnFa5qRkc
	vngHNgWPFFnGU1A9x1/2pTiHJWHgb5DRE3ljy82cjwUnwBMSp4BLyW0xspIjfPEi
	W4avM91AqzTwH5JUgZV/Ox15RI52XL1haoPO4gBtf7vHd4m5TOcH+uikJz41YImx
	FjqzzT35H3t3qm4vajnQSSgCrUPPIT2nHr+uk8G+lnX0nJ44EPLibcMBg==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fydkwstxh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 10:54:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9YzDgN9oSUOH2CHPEAeY35HMlpoHWWdr3mYDTR0Mg0bk6OsVOIJSbSQ2GEOtS2jrTXs1/w/+N8DO8dh1lgGdHScBFeVjTy6hDzZO+2gb1WrEDeCaZ2Oyu6BKbNN6z5eZYQFEpfE9bVZQ/lglRZrwkJZfwViFMBrtiPiKasJLJ0aIKs9f8/1kUSFHNoeXL6R41mWmrpqR2IwQtlwWQATxzPezQDTXMYvJDWvws3hkqnGJ/pQRqzDlhM+wHQo8OMWoS4+Dew1KcopLq8UZvGjUpl4xF19N0xRkdO2s64VFAsAoNraFQ2nqXrDKp1szvTzLxCHKzbhZQZCkI7xKeG7Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivvR72ega+7EnqX9zz/MhrjalNiJqoIjBJQDq5Rhcos=;
 b=jiCdcJwgt8laHUGbKnIMufFKgzRulJH1sOcXdS1tfA6rORfOmKPMFd28DL2rYLeD/EpB/am3aqn6fqTNtHb9Tay4XPTHMtSKS79M/yPkhmrTG2bIgVqXggk0Ei/AGtEXINNilseBMR1Pjw/a1GNFdIBLLA4/jUyV0MlGuhUgVZpmrjitexRIAcUVQovwRqKPhDgOcuWrxByn2ZTCk6LKswSTAWBBOuV/i40JfHpXRahY/CSnZnoe99j0PUb1BoCUUlu+SZ7islmzU3LX8Ao3U4LXB98DM8yk70sDTMrChwHigCimLyV5RixWmKKzvkZUrAj1y0krXQiw/qZ+cQjdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivvR72ega+7EnqX9zz/MhrjalNiJqoIjBJQDq5Rhcos=;
 b=sZdGAcNtL+j5AA3b4//0P2ZgivuE1fHdmunZLWtjNe7zlvSPhULWcpqdJaOOOE+fNP2vXCzYF9S1iBBzmS2VX+1Fyk4xy41dgdCkJOxJ+e9rylpQoOApcWBlpeymdTeMSNBLCwbLTIF3PBMx28bqrKZ7pHeWd//YzxsZivG20eQ=
Received: from CYXPR02CA0056.namprd02.prod.outlook.com (2603:10b6:930:cd::17)
 by LV3PR10MB7916.namprd10.prod.outlook.com (2603:10b6:408:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:54:54 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::66) by CYXPR02CA0056.outlook.office365.com
 (2603:10b6:930:cd::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 15:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 15:54:54 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 10:54:54 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 10 Aug
 2026 10:54:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 10 Aug 2026 10:54:54 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67AFsrGQ3441469;
	Mon, 10 Aug 2026 10:54:53 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jai.luthra@ideasonboard.com>, <k-willis@ti.com>, <b-brnich@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] media: imagination: e5010: Move e5010_init_device to Runtime Resume Hook
Date: Mon, 10 Aug 2026 10:54:47 -0500
Message-ID: <20260810155448.3628054-1-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV3PR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: f83fdacc-e33f-4ec8-998a-08def6f7b897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YQ5s/7zaTVNM320HSYlr01qpdRWtkM0+IQ7hzqfL6XkMD32bY+xeJOCSumuZmQKCHgNWgxVXVItCmwK9my8vyQTMWjNNSyIoc/JzgxmhkHqRmcv27SakKttfWI36cNxiL5PW8Rq41zuKOwTB5/KUjBh/ceEwm9nhRztRbYD8Ic/tvgiqHu2G/g0ZiTDsYx+9sTUTaD5RjFtO+4D2MDDn6iuHKcxgovXycRIXIGu7Ikks13N7T26+yGA3xboGN7R1s6o/zVZboTy5NZtotXcpISbt5WPc55LEyhZvaZJKhg2yxlqFp3jiZjUm60AFcRDskn+0jUnjBkrNRphK4VnyNVKne/Lju4LbClmtyIL2eLUHBkt4HVXYuzzt1zWPwK7QiatvAf5fbItHCWHFbTG/ZtTVj9TyUdoLDWRbfZl/Is9QUcgijg5NMr/cQt7+An//E9JLlRQS+ovsnw+UKNNreyNQHtprIiuFDCHrpuQa5XqUfjT5WaZmwZi42qfti46chCyLRsdP/SiBy5h/vWuIhddipg2kDoZgUUO8auDG9B6oU2GqJ+dUAk1Mr3/CPiNTDQ4bZxsaVcksb1JTb2Sv/VKAUfk0Gk9ETYsQvUULBWumT0vFIi5ml8/8iXxEy69j5uilQyW1Gz+ppWZi0+in6nLEk8iMTCw1Mu8HzW/FKjzkcSlWPeVopKWOs5CD/fIHI79yWemZhxtLp5LxTS6JCg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Eyqn8QgQKUZqnLuqYjKfm1eCIFHKNTxoSGbFTBDP8hX0xpkK+KRu7y14WrahXDci4BdUkW0bv66KcgdAIGoYS39CaWJ0Oc4TRb78bF320XiOvJg4iDyIeYP9yRvQr1Nc027++/bOQl/gXPIuZyrXA0I6C5NIJ365XU9k+FA7gTsGu9mxJEz1Rc0oI+jGdBVqjD9YnyXfE25I9J9FU+heqX+q7qzRj9Jvx/AuG1UvwYtC6hjWnj/2R6+sqpRXBw2+R9jSlkt4u4+yTgbLoSAZaeYkJq/M3hKI4DumImz7MxAv0emGLcmYFqCimoXLx2aDwBREF8yyWL8o18BUe/eva/IUlfihIMFZLknvJrhnIRIEDzz6EDNH1+jY1mAF5+2lL7N0T1ZZnzBWmi7zctmYtc2GtHhHAOgTZyAnScgLwTfNp+MlYf6JzwvmYrdURDV
X-Exchange-RoutingPolicyChecked:
	beMl2vXBF3qdn/nHzQw6TBBfXxa5PNvQa+8olGRDpPRn+ghX6SOAZaXzXq2fZCU+I2yhpafCTtzT5+bM7C8OB82CJ7l/Hu4nCVgLoozHsnOhl0TskFKw2hLNzgED92kqytCmeFyMap4qdcqimtZYoATYFx2WqBJKYDuEf+Uiztrki9Uh8kjrmsGKPej+D8Vjpt2yVJ9XQI8+kR8cbR8vspxenq09nS0+H2oLv2n678o40Xi/bqf1/RwkyET0+fc0GdK5mk7UnSDuhYlBZUNDF4SHyWypvNcxykDO2JX3uwVYh7yW34M9KsXpwnU0H9b50+3aRHvwBywKNqtwYdAmfw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:54:54.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f83fdacc-e33f-4ec8-998a-08def6f7b897
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7916
X-Proofpoint-GUID: 5w85PqlAQzuWHdKa0k5FFat39Z9b7aMm
X-Proofpoint-ORIG-GUID: 5w85PqlAQzuWHdKa0k5FFat39Z9b7aMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNyBTYWx0ZWRfX/NHTOQ1aygS6
 m0+jbbFZRGnqPMwvdY9Y6t70zjl+9CuM66o2FFlTfBx48GdbofNacF51QJPFTC11aYqUOLLLOgw
 M8Stci3LcUYp9N9axgUMUCTFd7BFMkaKd8Q6nzftas8mwBx4ef1TJ4Ot4gXGuemw5msJ57kFEQ7
 q7k7klqCZ05OaCXFklePuZ00v8gBdCmCdcmWCWq6eKHJ4PYoWcWsnwx425WK0loYPAgBPxOGzgv
 TiYlLSXUwzLQYRqDpo42JvNScB5NLVJp+4c81k01aTYRfO1m4T8P4Lxrx5e+Isz6MazA8NOoOnY
 s18kQ4yOKDUN5MU2iPfTtb96i6xwYdvQJIvvCxDUtiZOhjE8I4m14a3gTj4k3/pKm2VACEZPzHa
 pDpDAUauIwZY2bcSERxJGDIOasQZTnsXnBOyH3vIEynRlMkmIEI+VfQNsl2IBrv20s+y371Ge0W
 mxK2G01Z7rGJttS+5gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNyBTYWx0ZWRfX0sMwXt5akek9
 c5uhSCXclcLgBuat6iSr/iAt2487fbs0lbXL6X2SN/mrA3tiGm11FnSFYcx1ngD51hHixhn9lEi
 ZXn3lo2sLauIa9W/aZroCrZ3PkMij4Q=
X-Authority-Analysis: v=2.4 cv=F8FnsKhN c=1 sm=1 tr=0 ts=6a79f451 cx=c_pps
 a=LBR8CsJoUNkXwF8+XrmcNA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=UlmMjaRoNFhtWZaF8JoA:9 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100137

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device attempts a write to a powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/media/platform/imagination/e5010-jpeg-enc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 42ad9ee3993b4..2b98d230429d1 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1501,6 +1501,13 @@ static int e5010_runtime_resume(struct device *dev)
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
 
@@ -1533,12 +1540,6 @@ static int e5010_resume(struct device *dev)
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

