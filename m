Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FF448AE0F;
	Wed, 16 Sep 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789578952; cv=fail; b=QtyarqmZw5fkBD5NLTUT+kaQ40vna4LrGMXrpS8AgCTP+a2RFRcNlS4a70qkNb/vsvmJTM+w/gWqFHEBR8uuQ1TBrp+ws1M6pcvxIxb0139DcS0K0y7LRYQu9qnr3LHpfnR3cq+Tuq1cJ96WnwOuEyGRo/yDNeVLinqH/vMgbXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789578952; c=relaxed/simple;
	bh=rH89ZmPrt3t+jGRzKovesa5Fw+YCocLe5Z6lN62L0yE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=bkQ6RHhtn/qdvgzBsXB1NkZMRs/7edFdkDfXW8HyRG8M3cB4NoCk72WCoubcXSA36ubcYkn5pRdYYkk2I3ce8o/wn7YGzg7wOBIadax4IKudkfgX+6R1mBi6K9UWQxr9GKv68R/Cycu6c/ZloLx6HCAjO0nfqHEAwecNmy7ZND0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OSPKuZHZ; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OSPKuZHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj8M1p5YEF3LDtPJkzUYYyYfVS4MUmxBeReWI9tj/bulOliRrns7MfYItg2l0NtcWZkYylmvB0YkPSRNTVkKPS9NOPcpx5j81H7FTLRN5O6GvLhg1RPOjtn5gtDi0T2EXKIVDhbSrn8EqK3x6/kAysFSzG0RsQop5HZBbxlz247W3Gq3th24jf0brLTp9wk0yomCfKuANeQ29sTIIoiRuYeKZU8msChAFOVjH2KPqV6cuaVJkuV8DmbgyKkAnrXzqi7JLAlyI3aX2n8f4X1G8QxDoY5sFzDQhjnThor+tW2nacvn+9rAfuE/Hah971lYeuP6Qvlfzr2ZLrl9Aq315g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqXjQQYkENBzDKK5pauJaI254SyX/5CgQdOn+z4YrZo=;
 b=UzMCgojvjurKmRK9A3Oa3RX3jxZ56J04QEgDmi+vYdgbubjabMMpva2to4Kq+PmLH065YUFFgwvxR2QJc58APmh8Ul8QXgaKuU50Cc2bpgf7aupKeAWn3J0ZXqHEy+6rJJJj3FEE4utb7irn1J0MHLDJZu2PK0GaqFOR7vy/WVj8jEGPKyHAQxIluunfdkwfJvZBlCbW05MZ0zGFq7lNVzC97xeZp+wEJM8xPeqsyrPuVddSbg+BYPKgnKNWRMNFMCuVsuB61kERj/v3A+gNFKAO0kdq3K8yhflZVURxhdC/SelCnbumqBSCcWOkiEX2SVoRkdE4t3r8K/PhY+dhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqXjQQYkENBzDKK5pauJaI254SyX/5CgQdOn+z4YrZo=;
 b=OSPKuZHZ+RYVSQMks1ZJXJRw6V5HwD7207fnpbEGPAk8vwN1hCt1ikTgD3fqJYZKdC7jxMoI2MLbyLJSCr86jC1H2Z8DwA9IvBAoRsFvTVi3Kml6GPm3LV3nmJ95s0LDZkAbT7tYGEB3vIjhyizu/853LAc0IAJWdLc+1HXVasZ1TeETA3UQILV/+EPzBebL5NgxOXGs6UNLEDq1vj4s7jCFGkm785YGARHBpRT/6zKKCMzKqoiIZ3PEf3TMN7NrcVGe/vJGZ7J18bDzxFqPJdmNmX9s8+0QLvn3siKpEXaoFD6qg03QZ/8gsBB2SPFE7nyx5NcVOzxk/W5y7saX+Q==
Received: from ZR2P278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:50::20)
 by PA1PR10MB9385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:15:46 +0000
Received: from ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
 (2603:10a6:910:50:cafe::f) by ZR2P278CA0014.outlook.office365.com
 (2603:10a6:910:50::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6B9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:15:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 19:21:50 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 19:15:45 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 16 Sep 2026 19:15:04 +0200
Subject: [PATCH v3] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-adc-fix-div0-v3-1-bedf027a6e7e@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAJfOqmoC/3WNzQ7CIBAGX6XhLA0s6Z8n38N4oLBYTGwNW4mm6
 bsL9aImHif7zezCCINHYvtiYQGjJz+NCdSuYGbQ4xm5t4kZCKhFJyuureHOP7j1UXCNqlV1pXu
 HPUvKLWC6bbnj6c107y9o5tzIi8HTPIXn9i/KvPuTjpJL3liNtsMKHLiDm4hKmkszXVmOR/jU6
 x8dku4aAVahbVow3/q6ri9QjsA4+wAAAA==
X-Change-ID: 20260915-adc-fix-div0-ae38365abfeb
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B9:EE_|PA1PR10MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: e23294c2-2efe-4f1f-c5af-08df14162559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|7416014|376014|10067099003|56012099006|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9ECKXeubp+DMJaSwhmw7ZNXcmBLurs8bYoJwChKZyugiS1HGtu2211UuOt5vzx0SkWsUl/bIYfSysbDknCxOrqZppzEvndHYhbYgVq0Ijh0DlnRF1lOunbS5NH7qE520YGalGClxdk3gZTkd7g7TwJ3A3tIXfIL/fwXZBywFPBpki/wCYOKdZ4Ro/2nIU/VD3FDJRuqq3XbPgjna0c22u5cBmjRg8OLomF1ph/gj8Bp7C7ZDTDaVDF3sRoUdgib9AspqeNMEUp4Gf2V/O2+fx3rPfLlTwqWRmkccA4SrTQNUnf9B8YAjuQDF/hP2V/7O3qAlUnegMYVJDywVDkIaajRy+uAJJbkqjumCOfUxmvW9N1QpBNNX9XZKWvfNLhxyZPNq9BGRT1EVYzIOmkD+XVYFhc5t5tZm1HM3UtYW5gDaevJOUI+o9gdsbqHWRRxBU+41/C2HAT29RPz64b+9jAHimqdI8l1RfG5AfFPZuTpOLpMI7KwGWVW9TCQerV5yuHDHBsxVsBMWsIQwKU8xgHcyA0X35VIXJl9IR5Fk5XpSH4v62eGnkSnpaiXudRMhxCsUn8hlhsB1x5/KTb6cscek4p+pRx6+WbNeTaoZOMAXsQNR9kX0tKKwttI2Yx9FAqt+95kiNV9YGPIdf9CKYw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(7416014)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rUW4yszcqewe1UCh5ojTANplTMmU18ZDTzjgV0pW2SJ4V3ZgmndPmmIhjv2/1PK2tGQviy0XEYI5Dc48IXQsZ7Tl/ZqgV61iBneSB/rvQBt+cza5fyc1USmMkgpYfdkDOOEryml4qyQpyr2+Ob+vzrIWfaDB2HYI7afvuOyG6E9viPrDMfTo5KDASUnpoBoz4P8m6xRi75e1yCXU9eh+uozOxZSO6KA5w4SwJWaYwG9VpUsjNtaZmWKc1iLyKeCir43cRrVjnGDV2fUN5kEnZoGdr5qQA+QHdysgnW1VmsUzB4l8jPTKcmULb77JnBeewhU+YW6xvUsyto2BHHyxRQlyGTJDdc/E0uCwhRWxg0qp0i9PyQT6lfzLcRdnNQVoBtJ3kJv3So1+b6SEtE1QBnd2KYPW7lbtkaTLCgjP11z0ECupbzweZOUNhhzgwU4g
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:15:45.7698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23294c2-2efe-4f1f-c5af-08df14162559
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9385

In case the conversion has failed or returned zero, processing *val
can lead to a division by zero. Need to check for errors, or converted
value is zero, before processing the data. In case the converted value
is zero, e.g. the Vrefint channel, this should be considered as invalid
in all cases.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260911161555.244F31F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- New suggestion from Andy, to move lock release earlier, then return
  when needed. Drop temporary variable.
- Link to v2: https://patch.msgid.link/20260916-adc-fix-div0-v2-1-f702d3ed782c@foss.st.com

Changes in v2:
- Review comments from Andy:
-- Correct commit message: single paragraph
-- Use a temporary variable instead of *val to improve readability
-- Drop ternary operation and use simpler conditional checks
- Link to v1: https://patch.msgid.link/20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com
---
 drivers/iio/adc/stm32-adc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be..cac9b18770a5 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1608,11 +1608,16 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			ret = stm32_adc_single_conv(indio_dev, chan, val);
 		else
 			ret = -EINVAL;
+		iio_device_release_direct(indio_dev);
+		if (ret < 0)
+			return ret;
 
-		if (mask == IIO_CHAN_INFO_PROCESSED)
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			if (*val == 0)
+				return -EINVAL;
 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+		}
 
-		iio_device_release_direct(indio_dev);
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260915-adc-fix-div0-ae38365abfeb

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

