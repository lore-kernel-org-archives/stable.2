Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287323;
	b=gsxgpIOsNpVEApwp4/8mSiTX/OcM9vWWXRMuei1T5IfjewY1gufBJW8YaR1Aom7fwhni
	 MAZt+gAfARaLD05ibehsx7DQ2ntkiimEnJfuOi8ieLH8PPRb2n0SYhdcsFQ89h6BRR5T7
	 lrAAPHy8+NawDP4X+y83M+O3/nFVdfsrtz4Yx5UN3IBkyS4ujg577jAFIvq1mOwis1cyz
	 Up8ikH1yMsPeGQHHnQW0epqLhJxZEnPFS226YPLP3YJdH35qpUwjkdySDMASTH9W5o778
	 7KGeKEk9EO6Vc1hFBTd60BPJwmUW7bMJT2whEqdlD2qOw+55vW18XIznx3r7nDwnr2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287323;
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
	b=gBreJIAjHisL+413m/5IwomcIs+N4cPS2Ylstn8W8hFQ8nNxGJhHWzICdjY0Ejyl3/K7
	 x8VACAht/UI6zPOfnbcZ4IuwWrJ/ODnDynN0rGpovPnrJcNJ6KR55w2o+p7EKRPeH8/mG
	 nXYrqkv8OiiKHqSckPcoWTqrcqUCBj9KWM7cRARrHnkUUuWpB2nkQH8esiBZKpk6JwQ9s
	 QewakKSaQ9LU2mZNttPgfFeFAGTf4gIL6tdDUpbhrHJoSBjkDA00Es7k+yp73Jm8j1nZS
	 7SUsTKwQzW9u62e7DODPIhID0OOiYUS3JSk0PrMdySwfINYo+LJZU8E/Obu8Fp/8/Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Aa3tp6HA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.54
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013054.outbound.protection.outlook.com [40.93.201.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE20606A31C;
	Tue, 10 Nov 2026 05:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Aa3tp6HA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO2rDaKtEjGLHhVjJqsoiaLSDqw8XSCOjv5SfVPHDhPV4urM6siOCnzUl0JFV8U06O6NM+EBSHauSpRcdft0SAOceQbVuKBqckr4bm5lwUA4iNkzLwNam5tdHdfVtiPghkH8afrk6ZqyMv5KbQdsu7i10vpHm+gh6vLLEC4e6gEQ7MA4YFp/RqLWxbaLCH3WX+zC2ZVVLBHOlWHN9qyrZNzgObjNT5HxpMpIvXnH/DSl8soDHIV6xElKEdQ7ShD36Y+deoAv1w9YXnXRe/2UzlqZP4Bx/c8byMSfv0KI2/B76dZUYUhxunfFdY99s47Um7OOlkO+0MGUdtoBQl8W4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnBxvN4xGd6+68RytWbF9FHJipzxf2QGAPi8nPwftyA=;
 b=D4fOhRS5pgWKytNu5I4YiD+WXCGym0W71f3HqiuenkSe7uIke44l2EnHgPa0vfswkpNk1s1atdiTt12FWQYdw6haWJMDo6TFlUsIc2Kn1bLfh1Xq39k95qK8n4Rdc3fr1l8zdS5f0TP07j52v5Ef9gW5Qt4XqjrDunWdCi3vCuY8IWFYRM4AaP6kIKnwvBBNEz9x256AIeQTUhF221hOm+OuECm/wStggNOyuf/pzDMYTLRNyK8YWIvNEM2dN+UgsjZgAlM1lK/VJ2OfY+27OM9SG1hIljeM704CiT71d7nv/q+wnOgaZa0N/mPXFONIh3z2RVIFC7gOyV0/dVWglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnBxvN4xGd6+68RytWbF9FHJipzxf2QGAPi8nPwftyA=;
 b=Aa3tp6HAOmkuX444TLFr5n9kin6cN1I6KS2qMOFZOcQGSoEINkxwl8Ny5VKJt+hcBe+VDOw5gOkkmnXiwPP49NE0H3qy1M4mjh00mthiXrbT7tWiyFRdOJ/1IZNCC40TLnrNlIk6DwsWmz5IfWDK59fHTN2+NlT9XVogTcGLVRM=
Received: from SJ0PR03CA0178.namprd03.prod.outlook.com (2603:10b6:a03:338::33)
 by DS7PR12MB9042.namprd12.prod.outlook.com (2603:10b6:8:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 05:08:37 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::1d) by SJ0PR03CA0178.outlook.office365.com
 (2603:10b6:a03:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.11 via Frontend Transport; Tue,
 10 Nov 2026 05:08:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:35 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:34 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:31 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v5 01/16] iio: adc: xilinx-xadc: Correct write edge in CFG
Date: Tue, 10 Nov 2026 10:31:46 +0530
Message-ID: <20261110050201.1850399-2-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|DS7PR12MB9042:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e955b9-9670-48fd-d520-08df3ee8ad29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006|261021121427099003|261102123227099003|261026121527099003|261009223027099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	UqpBQvtwmtiJipkImsOaeLgg8EjnS3jO7xxDbIsMRTHn0+NTOEX99Rs5R8Q8atdMIjxfjXy4n5PHlALtQNH4OZQ8EibohzBOXmNrQxaXMTI0ysSFl36GAngrGPrhZj/mm1pcUDqHbb2jk5ZY96OU5lPiw1ueh/0vnOvsLyHvbjBwKZe50uR57WPHmnRk8mTEhNM4wLXnfyaDA60c7k6oOmy0Eddg+TlnwrPq4BVeMPMrxihMhFfNwAT3cXMtE51G8xxIhjLc++PtoBRg/qg30sZcmoBesGA9wPlMfS4tIdP4TShiOhEVg6TLWYYFTArSosL33q2zkSx3H/J/pjTAupuI9XGtbz7uixDSXFu4ntqDLMpLcC96Lcd/war85d9257Hj9NXfV2I8s72gnX4ZJLQA1J3SEMSZHvVJnDW8WINUtih1D200KB9CoBfuiYTufqrAcC3BStRy/BiPDrk4CAH3sJ1dxIiDfrrR/XnDZoB4VEh+QInCVnXGPrt2CY4auqtFVAFYu1NR8x2CW+/Mhp/fVEqByDQr+5QxE6j//YhsTd2LX0TkFkzm9MvBc8EwDkBzDBMKEHKTmZ36bl/ElJDDTeZOjjXPm/KCty49dl9MwrCQ3qAhKGQnhH+URd/rNn6+WAxbvm/35T0cxj/wx6zSQu77hvMmXwLrO0qvzC5X0iC6EWEcbCQiXd9DOu2F
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261026121527099003)(261009223027099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PwHit78sO+v4OGhYkvgCyND71SquQpvvb5TYJGn4fr+4xRXT/qCwMvB6cjZ0g4902bHuxMzaEV4SE3rYM0zZUXPMioeEGTOFM1iv0bmD5lHTgNrGfjJ99sEFu0URR+Mf4IoEu925wNPpQD8TxtJ9uAP5RLtJT3ZU2bF8Z+zLAqxV13QKtgSInifL1qjKxmxmHT5q8ApV12UVdGVuvlexcsjWu8RttoVFGvWW2rccuhs4VaZYT5n/3Mhuh3KI4MLCMMish1f/tS7AJb57Eov64Pwjfjmh6HLj19/F29+FfVCu0HsoH5nRHzh8e/koO6elb80gAhdSa0C4quAJcuB6IA0IOLyz8oa8+Q75zg9HKexcW9CjPwmqpNaTYRLNeILmAQud9OICm73dkwh5BQ0jk6ZpxsVVvRVjPZwa6207HeJuUe7t2WjAMZX/YCtRFQQV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:36.7432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e955b9-9670-48fd-d520-08df3ee8ad29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9042

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

