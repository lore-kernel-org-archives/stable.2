Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626676;
	b=Eo6+glB9/3uhQT5iJvLXLa4ms0ulCqhBGEkIjufv4Hyr6yqECmvOgNokNBG1jRVLc0Hu
	 F37KIV8tYAZUQfwrir8+lkV5uEZtmA9WWocugzN3jgiH/R2Pt5+ltKBSBMOOhYF7EZQH1
	 FoUWidlYaxxiGA+Qo6sjimSNGnK/PL/x0lPS47JdHIDlcWJqQ/R6nXJdXr2/CdZOHxvO+
	 eLulufmXKQx0XWFnTds0/SiKUFZN+NINtN1+h3y/IFcuARpqTNc6qbu2k1bdzfqIkJOZV
	 lhpNt1QEQAqZsRy7lVAhNhZbB/e9OoU8c6FwmG6qEM8del7MynztM4Tqy3SQZVODLSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626676;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NnBxvN4xGd6+68RytWbF9FHJipzxf2QGAPi8nPwftyA=;
	b=eK5I0yw/v77xdqzNqDxsg8KXj2qS1GOPBMwWa+iiQxyHfYZDLwBl4OyUky/htXxGpe+A
	 GLR5TqrApkgW55xcOLn2zH4TVKg9EHaAgvw2rm+48+8b2Pg6Elu6lKbSiIIyL2nfMXAWF
	 N3s9DDsATbFzXQ79MpWNCBQy0G7yLqJBCSA+Y1N2FTac6c98ydzhYrdO06JZeMUFMpxNa
	 fuq0tLF4B9/Mrrgavk8b3VVTCi9ykL8/BM8uXUNyvuzfc11s++FGhg2zsxzhPmGwCC4Ue
	 xaGb2FQQrKlC9f0Pdbo6nIP5H+2KxAQX5P549/Dk1NtM87UkQsV+ixQ6+cXC3JmIT3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XTg2RDXL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.63
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A05606A329;
	Wed, 25 Nov 2026 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A05606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XTg2RDXL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyx2gzjGAMlms1nm0vOScQqw7cSiZljlezmk21uaZ8kCogF8bgcXv/yot9XhBer3YRL7Qur/C7tfjBY6quwxCqbk+wHaZDBklBgoPqMsJjZvHEIgtFwifxNrsaRYTve1D5gJKlkcihKHyH61VF7ybKzg9iIjFwPiGRx/+juQ2avOU+8k3su5gzCDsPb6DyE7IB8ZlI6w2yHs1sAlhqqLTkYhZ+NwS/rG8pgjmS6FIH5Fn08Rt+IljDaocqZ1sjwqiw2g5pSVplgkTqo2ASsVIVP3b4DtlSLVqSeYpf3hn0ptfzYuZPW+C8lK92sjcVoifblOy96N2RHTxwWNn7J38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnBxvN4xGd6+68RytWbF9FHJipzxf2QGAPi8nPwftyA=;
 b=vo6lwWYtUYuXI2ITCo07lc1cOEqifsdQ4XwiMo8UXsnsNqj4E9JAg5icJg7PHsnQKuR18UmUT7CSgel3T8TjJzJdZjw7YMpGaev37dTHFH13Zdaohyl6Ml5VxrsM96CQdXoHiTKr0tdoLwkxD6KoKuKnKDTD/rAC/KP3GW85DKhv0rhUjqE6NByF2knFutreoONyzdRjyM/Q0ISTHuciBN9IAB0wTSG9uVgqHLIoJD4FnvOa0x1CLxla9e4IkRbH/DYJ0dzAo4af1lYrnbrKX4kOjBY+cipQ1tZRN4UnTlSw9Tu7JMHvkF56lgY3DlKndp3WMArrgwd9kvV079dgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnBxvN4xGd6+68RytWbF9FHJipzxf2QGAPi8nPwftyA=;
 b=XTg2RDXLmYTgIDZNf1HzcoPuBzvD4If2Y8YkcnVMctBlQyd57ZCxy/TRhSve92dZ439Pn651bHdNIpZqBOCYlursmsraVCOK/Ppi1CWT9b7g23/WnxNN4MY94N6ZLuArdz8jRTA/5c/jaX3mZDPdBGrw9ojHpy1aynbEMzgGmh8=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 17:11:06 +0000
Received: from BY1PEPF0002696A.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::c) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002696A.mail.protection.outlook.com (10.167.244.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:02 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:01 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:10:58 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v6 01/16] iio: adc: xilinx-xadc: Correct write edge in CFG
Date: Wed, 25 Nov 2026 22:40:15 +0530
Message-ID: <20261125171045.1246381-2-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002696A:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: ea722a1e-010d-4f1a-f20a-08df4b171779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|22082099003|18002099003|11063799006|56012099006|261022075727099003|261026121527099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rsUNNy8xWZObyvWsJCB6ap3x8EseJG3J0j6Shs1YeRbylLbA1AWi8O8a3KgPRSGYHguQ4EppxUdtSPNk2f+T52VhVoeqEzGhacbBDB3Xw5Zk0m+wtO2cDHyRgK/8xHWDgKz1xgqKBd7N6+C2OcRD9bso7krA/SGpwJItKGoOnkeJ5mIb2iMvx0yrTQ/bZgMb3cNBGcSwRHknJIODHCxrioQ/Tx7WvmuUSO5FxHmDKxItNS4q+mn3tLwnh8CaBXugJF7dUGVSlCp6MDcPWkW8R9QlA7+oLj4nIwHX8GlP4UqjSqhsjOPHUjKDLOpQKtBXaD0QIIZZu668p+dyAt6+w/L8ZcTkQ3aNZD6Q8WkrS+KYiYAytkM26xFARYqI442m8XXGdJRl9U2kFC3jUm2pSGDS+aOn/z9BkyqQzVpwo+WqMFhJDPPwh0uC56b9KgXJrdiE0ZrjQRpWJRcRDWGECurrBwEfMt6EObPp3jTyVibkxN9bi5271jlfzn5ggF7TAUCmTwPkfmC4/z1s1E7fFkR2K/4/kIDTOAkGvje6RkoapZQjpqjX1ob/hLwMwE0XVswD4cHMwlL8cDM2vK3s2MpLB9Mm1E3FTgxIyPH0cZrRd2ewGAta28XeieHrXRtKpDAEozqzpyC+Yhl9qN2CmZXrUIrigyYavROEmYpI/jgdQrMNC2VpkTzJCsu76vn3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5gGwf38Yg7JYrgRKxEfC2cbrt9jMe7GupGF+CocxzieyFl44hxqg8tiLwIiN6MJLVBDtCvHw3P07jCexnC+Xt4EkKCyQWAIg8+Mis6kVLf1jyaV3R0tLBUvRYvLe8iPnEOQ5vTvVDN5EcqMLdL5tegfL49vP10tJDOtcmaGVVk1w0xhXzBcslE5K48wulBYzAdI7dDAhl3OconIZr0stbYjSo6ML2XI+mewmohbBucweKqyyNGGfGokeBNLvpDC7CD9+g1t36Pu06bVc1n7rkEGX9RJr9EK21AQLNDsWLmEJ1JB4kKnK6yEnhY9sjlSmrUnahb55koJUjPptbAIeW52T9em71DmsyWQeYFsnsFWBB4d6LEFiUZO3MpYlZlYCO/bIIvtbQ2S2OyAjJ9MGrq3A75DNOLVyzlaLH1PUlt8uOCMR00b3ys1WGrlV/brs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:05.8997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea722a1e-010d-4f1a-f20a-08df4b171779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002696A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

UG585 describes the PS-XADC interface configuration steps: REDGE is
1 and WEDGE is 0. This is consistent with the XADCIF_CFG register
default value.

Configure WEDGE to 0 as specified by the TRM. Abnormal
XADC temperature readings observed on Zynq-7000 are no
longer reproducible with the documented setting applied.

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
Co-developed-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/adc/xilinx-xadc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 66202b3a3abb..222571e75cb3 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -390,8 +390,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
-			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+			XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
-- 
2.34.1

