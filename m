Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DBE47A88F;
	Thu, 23 Jul 2026 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821342; cv=fail; b=Ln9/NshRU3EI5uLnToHh1dqHGkZhjExawrAHenPrhuuTWdbFeQVGLmRzuoKFLuvfUCjJ01TfyY+rbwPkO36DV0kRk6xO/1To2RYoeqobz5lonxdCAI0JyIM0K07dHnRdM2arJCdx6RcTvOVV0iy/IZwASLbFjKwO5wnu0m2pScY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821342; c=relaxed/simple;
	bh=ASsYg4ji2mjH4neZezMsqqJR/9lVVNF6YGJMj0y/JSE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hUR1z2HeQcbmVil9eUI2o2+fPidmoj8SgNPhPcC+nYCRUp4+J2Lfvm5x1NB2gF6aVdcyJ8O3RetqyOJyJoNYHTmaccdK/Qio58CN0MRvrhqba5a57L0tWEMO/EVS5/DAqGXqyebpcPyliZiBdW07eQjohM0deKlEIYX8x9szGEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kYBQSbT3; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tUOEPtpv; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kYBQSbT3";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tUOEPtpv"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NF3lfS2692243;
	Thu, 23 Jul 2026 10:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=lnucqM0a+9EB0
	rBWvZ6D3xneDS1PNr/4BZ2fsRMA5BU=; b=kYBQSbT3qx16a3QXcqt0TLJ2KY5sD
	NyB/U1se+YyeTc0NSIh7h2B3yshgCkp2FNbxF0vIh8GSxB6na0r8qDfU2nT/P4zu
	BwOiMOzzfF37q2GdQCDgdkXb0mnWTBjNo20LWtqF7kPGa2zQ2SoGWM5RCU/pziW7
	McPYHtsfeHegEOOStVuneNnRiRlV8AO4GOTXxDSEsUH5zIaf2yqbwnQ6gavrISRI
	oa2E/GSHc5yhTGadHxWR721GSb6XCBMZecYdanGA8NATQvZm15/45V6ngn+5ndc/
	hcsx251NPnfbHZSCBtLRoZaZBLcLAkYRjRh4JYxRmKHmscK8HdvncfOOA==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fkg7uj357-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 10:42:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEo0pnKijNnTu756wqse+Hw+hnM6kncXlQnMmhmagh2gUhd4jlRYbiEjKMgyFflCID7ZwoVmzfFXJZMm2+WUjIR14Jf4ccISrVXUNT8q1zzS9OIlyEAY5k8QtXBy0V4cj9UALYTIi0z7TYQ3iB0eMWIIX3GxMzWnPC4lfucWs3BEKgha2pkG6B1pnA5AYXnWloOVXcJAp7TJHjBndedbMoDoKjzGSvPCf7Y0KMXbpwchEj7/Hm9lJvD5Ts/qk0h2C2UrVZKFsYyZcspRPUts16ahAbTcfsuxHbpEEg9rjhKfs7LdmZmxr5aAzgA0zcCcwK8JncjlQ3hV/twPSBQv2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnucqM0a+9EB0rBWvZ6D3xneDS1PNr/4BZ2fsRMA5BU=;
 b=JvbKgruA03k8SlDVQegrv89O/cYUuPUZ7Yml0rswg5gbfthMV+1/9p5WNmgBlhSA6t2liTKlFP7cwtVdZxxkMUkjpYOamoZGWXqbB0B5KWieJPblAw7B9ByIjRAYCLclnQj3wrES12MCh/SNFwfVtUdq67CvzgLnUjhcdDWY6PIqEGBPGP0B8Cl0r+sYA4rILYSOSYuZcYP573Ubwzhb70hodqvOp2M70A9EjuKkmk9J6GXTNfI/V74Ekz42V8SYEqN/gZZNv9EsYcKTck4jXA7RInHgjZnWHctXDMa3IE4LaYPOcCVas3Pfbxe3YfgJ4rAoyJ60Ip/Md8tGAetTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnucqM0a+9EB0rBWvZ6D3xneDS1PNr/4BZ2fsRMA5BU=;
 b=tUOEPtpv8TMRMOFzuQ/MuMfJoE8gPC+QEOXz7FY7FK0mMYLhqmK29DWskhv+HzB2IQYfZaAZ3fMcWwKRATL90ttLGSRWAy0G7E7pkU3k8dv3dlYnXq4FVe/wq8eTNistNthVd7YL/hg5cN5iT05Exq+3KzdkK3sG42zJEHNIScg=
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:42:00 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::8) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Thu, 23
 Jul 2026 15:41:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 15:41:57 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 10:41:27 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 10:41:27 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 23 Jul 2026 10:41:26 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66NFfQ9u2002945;
	Thu, 23 Jul 2026 10:41:26 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jai.luthra@ideasonboard.com>, <k-willis@ti.com>, <b-brnich@ti.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] media: imagination: e5010: Move e5010_init_device to Runtime Resume Hook
Date: Thu, 23 Jul 2026 10:41:16 -0500
Message-ID: <20260723154117.1917644-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|DM4PR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c87c2ef-aea9-430d-8a49-08dee8d0edac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ozGiDVbOGMa6tTtdG7gYdlzrOF9YCGfJhTU1srmrLUz6QrFHeJZrF4bvPOkK1qHAGa/379SGBIONu4/sduCRJzZZzjmclhkVF8S8wf/DwhvKvVrPwMP58Kk+nsbP5CK++MZAISTcRKXKsecfVl/3XwKrfuHCzWPnAGsKJBY3smzWh7iGtBVlb4VO9KHfb3n2WJWernW9sCBs6ARvngA4mk8G+6fQBIrTzAU3ArF/+YZYsekF6SGKYIuwQ2kSH4JKMk1w5O0Lm2wb97Uv/5Vb2ZyWpxaz+gDrkZBLX10GqQB8zNo8GOy6a1JlNB8zTy+JqoypXuetDTs0t5vIAec9df4FvuXn76ihh6XDso4mB7crEyfm3SIdWgA4eo7oSoCI3a/dPEKGoFw1ySYWp9C5Bbz/zSgn5szThmWS+bjK62JEcLNCG82IM1RphNy0b+Ibymw7Tcf/BuNq8jHrM8Zd6lwG92EtIwioWg/SZMugLaC6C9wV08C1hC8E/Vys88iVxfSaXPU+E0n6E6MtUE7zMsjOzwaoecFB3gChF6SmPm+nAkH6vZSfesSPrrGRtsWQC/k4XyVJVH8H4UKi8ECCIYNdrekOO6yPBMWWhZ/b5kRpuVnJ7Ql1uwWOVIh9oT00vjQAcXwmnWtTwNdAVwiQSssX7TFnsz58ESoiSDQFA986fpJjjvjO4GVsh9JhtXUr+Utx48rtSyYEJCYIRhFDaA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FteTKYwU7+hFcK7oMWKXHz6h6Ox+mCKbFfzz3LoddcxRmmMKjdw7PuJDVAGooSDvdYmgppeQ9HTIxo0JkdZ1BKlQmuGKrwGOY1wAoMT4DvPTisRtUOSKCIpbSeh4nEfL6BM9HGONSEh1OxN+43gaAWlKu/0+Pv3dhPTtZFxEB3VuFHGtr5zlMTpDTRvXAKqxT9E6Ql+EKcR7slYTJKPYRZs0bnSOvcN99RYEn8YDFL6DFTDWEna4+Gy06u1+Us16t1N/7xEPlGl+S4/QhU7qQbN+FHLvnJrtDCC4aaeQawDFjV9LcrHO81tEaF7DKy+qHds4tBHpOYcKekbl0FzgtsF77kY9sA6ZcO/yryON6oxodeEn8oyiANIeXlx0VZ0nzaPMJaZiChPZ7nNUEu2KRpk5xLVA/N3qqnGqHBpEZ4i/9jZtNlqw4lgvQdjCJX2u
X-Exchange-RoutingPolicyChecked:
	XlpTYfRK4h6p8ISTolECOxYSZqfLoRee/zPnFNrAbcxQMFF6GNiX5rBhG7ihwKDl7h8Yj+7+ADYQQYHNSQXBcdgHav9Vl6Kt2E27/19kL1AWpDrfroeXhSE4+KAUZeL4ZDWV3lneq3Ll+KMhfSimUvIrOTJ2Wwar7zIDgPvfEPH1pZK6VJlu1PbAHs8jwVMbXj7lYcp0E+6l8Z5D1CEbADXl44tjD3FyY/bgu/rGzv6gGE4kqhyxLj0gDlp5jx/qiZiTCckxPoezQ/QWNDjwsnkmR6YFFhd2z378TTnOtD6AVw4CJ3cfPhOuMZ/noYkSfMZ6V6QH67RutfpoZxd1cg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:41:57.0307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c87c2ef-aea9-430d-8a49-08dee8d0edac
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6839
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE1NCBTYWx0ZWRfX9Kap+IEYmH50
 NBwM9jHuGBnRjm7rO29YZ4Xs8RMvolF1gtODv3tz5FZwg4rJyqVMSzkwfrccn5tPE/sczhdcjlY
 heukoxUXhoMXDSrIps3XU2EolLcJfAg8CINAfZQuxRl0pZyUphbpZJDvo8B25rja987PipQuLh/
 zZcWE37n8cEHdYKdwxFJVOH7DuYqEwyFN6CjHM6063rW6Inx2vc/BSiP2RxgTpYHuhsrnlPO8TU
 CSfSIFM3dsV/6kPFogmDz6WG5un07hIqW4Dfu5AwryrMVYOStmD/Wiolg985j/wNJy8B7q2GKjV
 Z0kSxh79bkuMZhsV5lbjye7k+MrS6QLqs2fzb3iZBpRatTLv/Gh8oelgV56ZEFtpHfCFKpD6+P3
 wh3n6PyetWLpLgu6SDX3Y4CHum5ZfOUWY5EPkPDydrB1CFGlTxCqQ3jmX8KTiMvv2uWHL4/ZVo6
 kENIFFcXZTcR0gKhUKg==
X-Proofpoint-ORIG-GUID: DG-aBrOIoP1bOaocoyYl9_zQ0gwe0rB8
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=6a62364c cx=c_pps
 a=boTDQTO5XcRoDQ12XycLVw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=UlmMjaRoNFhtWZaF8JoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE1NCBTYWx0ZWRfX+ktDt+GBE2ot
 lEo7OCfRWsWi7/yDsKaKrVE4JFoO3MseY/GjLLyblARG5XKsyWdynhI6L6HBCcII0p0KoKyWe1L
 zkmiQOL08nWypQpZPb3d69EOHCuaVno=
X-Proofpoint-GUID: DG-aBrOIoP1bOaocoyYl9_zQ0gwe0rB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230154

The PM framework skips the runtime resume hook during system resume if the
device was never on in the first place. This results in a crash when a call
to e5010_init_device in the system resume hook attempts a write to a
powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
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

