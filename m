Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B723A48D9;
	Mon, 31 Aug 2026 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211999; cv=fail; b=T3e6mzTPw9pVRLKp6NE/dQ9bqCjy/ETxuYlIueUTeLtQi8KqBwGezc+SSUt4gBop7KQog8wuZ5rtEu+LunpdJYOIS6YRxShhdUcMUaUkFd8O0I2wPTQv/RJKNbK5G9dmLxBjnk6DABvRXcDIgAmTdawJBWy0UJT78V1NWDrt5KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211999; c=relaxed/simple;
	bh=ZlFCEZ6SdXqtbYIV+Aqdb3OJwV5IzF3fbOCfH8BBthE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vohk6FZRpYy4sU3G+Ghj+h+D2Iv/t9MupZXcyllluShUzVBpisExy8AVCuR92CKDp7xke3/atuxMUImaafrGeQvHfQJisaHD8m9PghKa/ld7KY1vPHgLK1z5Q2JmLMyGtBX5+2wwANjAxUlitGaDcL+aPH7p9iHufIAxQqzYu7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=k25aqiKU; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MIYtq/J2; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="k25aqiKU";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MIYtq/J2"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VISV7j1813506;
	Mon, 31 Aug 2026 16:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=c8zLhN6wbKbmb+w+n88Dr6k7xVATWWufmipUecH+n
	YA=; b=k25aqiKUK0FpT1GqoL11dq6i7WvgWK+958vAFeQMUEV/u8WNhVyZoSPxw
	s1RlRlhIiXvOriSjzuU+smpvmAscHb+wphV6OBmx8hm8HrBvfGW8mm/Z6Vlphib5
	LsH6ROQrzrbcDQ1pPAITdjW8Z8vhXb+4wOH8y7mrvabBgfQV+TUcah2JlYuVWhEz
	Gq3OpOS2trb+vAIurIIvXNTj/QC4vw/rjeONqB9L0CtmLIm1t011USKLcWmTk0mq
	C9zYMIT5Ftq4rNtW+HBgtSMBphCTc88FLo0fwmqww6y4Jq3b9xr5M51fJICaLT/O
	PncDyz4kwnj0wHE2Xb7vhdv555yZA==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gcet48ttm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 16:33:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6TzFJsLlRiQ+yIj1yPCh/2+GYq0AhcDjvbLFNycqk33EByPY3nAKqmba42YFYQcflPL2mSFvTNqsh8Y4aDUW8pYVfc1L2A5ZRyIaNVISKaFif0ZnB+gIiG/ipMoyVoe5ubEZZ/BqHqWV+8Q8P3f5aobO/moDGCSdjT8lb5hlTk+V8Cg+6AVAK8AmvfGeiEkCFRu0KoOKBYRNNIwVudwSunNuY71pPerv3AFUD8B1ytEr5fMszGIHtDT03xB+mUh80prkLmdQw+aOv0eGNL6X2qK8c4/y53kjZlwHjDmYP+bgI4+8noC7UOVYVXDTVKem8vGfzcwduJlXIEv69fqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8zLhN6wbKbmb+w+n88Dr6k7xVATWWufmipUecH+nYA=;
 b=NbIXS3VhtPD72fmYKrGh8gIGHENEotkKGHx/t/+KrFGhnJL0V8ADnc4r8+x2evZuj/cjjqVcqN7SYEBofd/aGihbCI9YY7RoZtPcGr56CWmOlWsIt6Mg4hTX12Xi65/yipl6M3b9wqqguHLcGLxVWrxmnAer295pEtpjHaCMhqOomfau3trENtIIxBf0/EqY719Xr7XH6Gx7Bs1CzJ42z+heCTYhp+diWir5BOSjbPqgOpT5xZsZwcNvO8tv5Mu2psrKo7cNNrwZo/yKWYBLT7lKYBczcyLb6KwD70eoXaH2wLapUf5FaULG3pAqdl+r9DFschIhT+yCHI4CFKMXqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8zLhN6wbKbmb+w+n88Dr6k7xVATWWufmipUecH+nYA=;
 b=MIYtq/J2ySkmS3sIgZfrxn9I0r+5jkpWawg79L1WoEl7dIaC2spT3AtNLfCoUYN5qacilTZyUiC3bnFDp76EWUvGGV6+VxMAoTcLrT9pfDQuEZxjbM4E+G/lKnbVIOUtjnwjECMF15qbr3zmyhQ+4ufYxaEQuqXQ/XuIbz3dNuI=
Received: from BN1PR14CA0010.namprd14.prod.outlook.com (2603:10b6:408:e3::15)
 by DS0PR10MB6125.namprd10.prod.outlook.com (2603:10b6:8:c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 21:33:10 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::1c) by BN1PR14CA0010.outlook.office365.com
 (2603:10b6:408:e3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:33:08 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 16:32:45 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 31 Aug
 2026 16:32:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 31 Aug 2026 16:32:45 -0500
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67VLWbYc1545515;
	Mon, 31 Aug 2026 16:32:45 -0500
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Brandon Brnich <b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v4 2/4] media: imagination: e5010: Fix clk never enabled without CONFIG_PM
Date: Mon, 31 Aug 2026 16:32:29 -0500
Message-ID: <20260831213231.2125544-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831213231.2125544-1-b-brnich@ti.com>
References: <20260831213231.2125544-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR10MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f987b5-e997-4fb7-1109-08df07a77333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jLZtbySZMtz5K9e8DzpkkOrHomq1+p1deLZhse48WaQjM4v5+k2+yJz/Lg0H5Eyqp0L+fF1BBRvXZ02M/6nsdUJHiM+N1q25HuEuc9sbaMOAb593w/CAA4vp6mvQZ9T9mhf7fVOIO35nE7reiDYS7OqCfo9xgwgii+P0Z4ndjOzN+gXkv/YWtFgcDvlpusx0kuKQBAdxRfMUQofj3scewKj9F47y8RUQpHvFVpntOUkeYNB1NmeJXeUVjV2E4VfcOAjw/kJr5+3aYa5AhMuRuT1tF1UK1OmfUc3FRP6CpUFTa37Nrx5HTiIalJFJioDVexuSijOA7Hhkvb4nk9nC9EN8h5Ln9dWyNdKZI34Cv2zot70zfrJvbV73ggzN5OJJ8ufI8Gpge+xKmRDYRTggS8eh501UpNCajsjxzVKZiSNPHoZYKpzSpFNkyGhL0tme9ffa5KG3UEdk5zryApEm9bvTRYYjQSquMgvWwwW7ZfeB7WIs2tkM8GM4v6ePOXuyQO/aN1z5bRTgsC+Z8vbPGDAJQSi2zLOrvSivH7YStNoaW6MgbQPIpFbj/ZywkN+38bGmTJH8kO2m3Hk4a/uc3xYTbycMz54aipSNIIliXrNx5a3dnZi7/a7XZ0NLfxKPxnYJ28w1qkx9DzUzpQmcVr81GBTkdG8nHql+xP8mFmxhePGdgZ2g1Hfhkid4ol2c6LoKtQcnfnOCgJIoG0pP+Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RD4EqCHZSBz0ZEUv6Aet8GabEs4vWlGsQ0Dh0+lxzThiG1i/kWyc5j6pCGsJ9c6lDvxBlAUrMRyrj7X66g/RKUOr3jr6j344axcg4vORmK4u3t10Z2M5X4Fgu8p4WHKB4C7Tfalm5vlS5abGH17XZtVP3Z3zsEGI0Z3yLNZYYoGV9ang8SCHUWBk70eX6PF2QU59shE19tIgRDTkra4j8HWo5NP1BPFX7N41z47wGxCyX8NDUBo1k0tHA9peMMJRxlFo+0x1UwdV4d73xjsEi0zzY1pCuxfG9LlHqgElwgZLsS0IDiNAKnKKYUprGWomSuSOs4+T2GUXP3+ZO8OGW61XQE2Y2Ulj8uRouGQOH/cs6AXRkyR2Pcl+vHEu0ZDVz/jfEcXPsBRcU11aXQsxM/R9DimZyP9/XF/kcfqbsLPmsz0JwbMblRNgNCkKxIKZ
X-Exchange-RoutingPolicyChecked:
	BkOPJr8bgIMU8vUORRAJlvESXtmnisrsu5Sz4OWcG+gYH0aYJrbOmuGkv6tSrv3vr4JbRsMMltikSYWSgQ+hgkeaNHVZJ8KTPoE6+K5Vj8ZcylslWgxk4YpiXo/UWpk2reFJiOhDYMvnH3cAG1HbCNQCH+nT6826cBbrTyiFrEeU8CwDgPb69x6ZRL38Q+YyMvne8ZlH7QoS5pjQk77yhilNTg2a1qf57R3KxVswTrJlWEJ/bRnL2BCws1J11eoWFMBiZbqVzUI1NfYg4yQDMIe5tPwQaZnkZA+fjJz7l3oU7tTF+wKdtjX0tjoCklUyCw5gLoGn4ErcnJutu3FhbA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:33:08.2416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f987b5-e997-4fb7-1109-08df07a77333
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE4NiBTYWx0ZWRfX7m+dyoICA06G
 1bGKM1n1ZvoATC7mcEv7JIUT2/MG1djA2HE2kaUY7OqagtcqCgl4lnTwWP+WWwwnykW8FQYr287
 yA/gvIY3UwodS+2XMjRe07EOc6QX9aZc/zhQAz2D6Ht351z9EajMqvkbidKT6iFhzcwC27Edz34
 t50EMtmAEriv5LqVzVWW0CTYFp8krOPRcGcLsVWpAhHd+EsL0mu4JL6hpTDWmJ9qD6oSpGTwsDy
 hJ1RLzRQGDTx7AAzx8HD9iZM6ACVjGA7jygkYSKRQob4SFXGpPzN5DM+di0Os0l8dHDDuUcEF6x
 Fdc1+yrx5OZKnTtK6oJetoPlV7ka/XZktZE/anlWmN+54dNUeIXAzf7kEeGDya5rWPMvcKm07qY
 7rJCHsR9eGEtIikql5pmWMC1Mi7QRTWE8i8s3/Ld5UYNB+v1SGLqANd6Y+/xYkx8TuvXEV8qFP3
 xMTg1783IMgbUyzr8AA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE4NiBTYWx0ZWRfX6eOCUzmocvwN
 bHwB1UBj4Ac8xW1DU7zQ1fS4OhMGUgGSxJb3HcJ0BT7fWaQ10okKF6fL52X9dtUbQv6prb/XTkj
 iOWj0orOJVbk0YF1fR0XZP6fO9arvFY=
X-Proofpoint-ORIG-GUID: MK-d0XO1w-IRAUILTbW3CwogMDlg4P0O
X-Proofpoint-GUID: MK-d0XO1w-IRAUILTbW3CwogMDlg4P0O
X-Authority-Analysis: v=2.4 cv=LrSiDHdc c=1 sm=1 tr=0 ts=6a95f319 cx=c_pps
 a=QHQ/c+VJRs0sJIezHEQ2hg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=-BWrc3HdS1PG3WIIs5UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310186

clk_prepare_enable is not called anywhere unless CONFIG_PM is set. This
means without CONFIG_PM, the JPEG Encoder will not function properly.

Add this call during the probe sequence to properly configure the device.
If video_registration fails after clk is enabled, clk would be left on.
Make a label to cover this case.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../media/platform/imagination/e5010-jpeg-enc.c    | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index d3c11337c815d..e98fcd3fcd9ae 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1099,19 +1099,28 @@ static int e5010_probe(struct platform_device *pdev)
 		goto fail_after_video_register_device;
 	}
 
-	pm_runtime_enable(dev);
+	ret = clk_prepare_enable(e5010->clk);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to enable clock\n");
+		goto fail_after_video_register_device;
+	}
+
 
 	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register video device\n");
-		goto fail_after_video_register_device;
+		goto fail_after_clock_enable;
 	}
 
+	pm_runtime_enable(dev);
+
 	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
 		  e5010->vdev->num);
 
 	return 0;
 
+fail_after_clock_enable:
+	clk_disable_unprepare(e5010->clk);
 fail_after_video_register_device:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
@@ -1126,6 +1135,7 @@ static void e5010_remove(struct platform_device *pdev)
 	struct e5010_dev *e5010 = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(e5010->dev);
+	clk_disable_unprepare(e5010->clk);
 	video_unregister_device(e5010->vdev);
 	v4l2_m2m_release(e5010->m2m_dev);
 	v4l2_device_unregister(&e5010->v4l2_dev);
-- 
2.43.0

