Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843D3DD86C;
	Wed, 16 Sep 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567824; cv=fail; b=LRL3IbAwEDKlNrD1pBaB5phtpCZra7OFbcgXZRpSFZDOtpv3KEL0E6lGHAqrCq+awuovZ/wmv3hvz1jizDpGDc43N3q2JIrSvqtjJhdlsrClnHUX8Vvup6oz3a635hlPjTw6Oe/CZdamk4+/9LBkLdIjLFNhwtV33SALWgUZFW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567824; c=relaxed/simple;
	bh=vf4wxIOB8oRsm57VajMUc/0UPX3BM6guZcChCzDDFwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mGIXlV/eUBqOWK+/kVncfBXY1vm3S98S8w4ICY5/R9lSLuoMbPrWzoPF44eJrNdp2BmM80ctm19w/OEd7w1WmqrQvxmtZ9Ue1cGaToNRC4q53APa3h5EnuxVd2WnCK8oDk2qXTSqY7pyVcHun+qIKhEhBHxxKdHFwF33GgfOKhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ao0EdDaT; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ao0EdDaT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FapH99GqlfSzbird6VVC2ybxsxDLSWCv9RFAzNPdsdgnWcEiW/Th28cjX9v1dh44hGCJSq5pzkSkwYXxnVJJTNgY9Mucv7mSTN5aFrLgiLxqmAAYEMAfjBjSyl8OHGeujNFOzwKwm8EXxR0BReJvPpnHwqx4y8Q07NI/k5o7H8NYxmYbXcy6bGLe82kA2jlPgy/WXB2qRtbnEjgZtX0os4hYTgpsUP2z28BQWnpBVEmi0sPGGJaKcDUobrDc1lf23uo6lyhUu0ql64wiPVUfsOn0QkJ6nkZGylxUsiZ2YA9Sv63VEwqinDH/lw8DOb9T5P/mIFnOVJAAz/Z2d02LZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mO4UNJQQbgupWip3k39272CsEjgUu0GdsgA1Bu47Ts=;
 b=MfZrFx0CEKRDKmxVfRBJaVUVi2RvODWhEGTBgQ/Is+ukEGSktYbp7kWrnpYJLRen86zxD1wjp4/Mk3dhJVxO/Ved18XG8B6JNn+JRqgp9DgkliW724cJbsZ4DreBCVw6KbyDvkpBlEQHTx3UreWjHBMbVUdzZDiRcfVdrAYlCswWG+h3wlRN6QmnNxXj6K2AkdsmJ2RV3392RMGGg9Wo77JvitcU8nZoG7zcwtngdwDhQgsjNSUQoQxIdvUU46p1NYNj7Sz+TCuHWoNAILEYnhLvfc3t/Ul2Nixmh6qVcKjZa25WxyMTDhFHcM8yqAKJ6iNRUUrHsOAGHHhQ2vioBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mO4UNJQQbgupWip3k39272CsEjgUu0GdsgA1Bu47Ts=;
 b=Ao0EdDaToSN7wITG6RI4V4ZxDFK0O/+xpbP3MbxHN3tLOsfGNH2Uq0XCf9zr94meE3z7fmTaV2z2qZ5QBw/VOUSSXxhkLLH/eDlKcoUgk4QQdYWEmyiLhQ6ZLW0kAcWlpaVeQCNzLNdX6oICAbGVO1qm2r+6z7DtE6jIMyTB1PawCX9SW8QVQXGgA71wWxUKZxXhnGsyZKghxItlDDGkahNIiEzarLnZKLjLh6LA8O820l/zQYw5MrnSodZIOD2CJLUW49r0cUAoT2OShmNsqjnpebek6CUc2cvJI5Bvkl9f/p3VXvAfcdx1vUj3VaT2xmOHR3XMPPgJ/CniSnkwIg==
Received: from AM0PR02CA0110.eurprd02.prod.outlook.com (2603:10a6:20b:28c::7)
 by DB4PR10MB6264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:380::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:10:14 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::6f) by AM0PR02CA0110.outlook.office365.com
 (2603:10a6:20b:28c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Wed,
 16 Sep 2026 14:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 14:10:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 16:15:44 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 16:10:12 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 16 Sep 2026 16:10:05 +0200
Subject: [PATCH v2] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-adc-fix-div0-v2-1-f702d3ed782c@foss.st.com>
X-B4-Tracking: v=1; b=H4sIADyjqmoC/3WNwQ6CMBBEf4Xs2SW0BBRP/ofhUNqtrInUdLHRE
 P7dgmePLzPzZgGhyCRwLhaIlFg4TBn0oQA7mulGyC4z6Eq3VacaNM6i5zc6ThUaqk9125jB0wB
 58oyUs1137X8sr+FOdt4cW2NkmUP87H9Jbb0/6qRQ4dEZch012mt/8UGklLm04QH9uq5fx3Uix
 bwAAAA=
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
X-MS-TrafficTypeDiagnostic: CPH1EPF00000520:EE_|DB4PR10MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c630584-d788-44d8-95a5-08df13fc39fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	2TuxOsb6TsNlzzjHkS33nPx29vb6jCYnQ9LWDc7Q3Mjq7Ia9TDQzkxuQ1VALlN2GOdQkt2hg736aMlcmV2B35/gznolAe2uL6YYp0UgfqrbHOFtvoGWVZ9vgyhb2ifKVsIbRPT6ZnuvAQg/3gyaju/RzU0ZOaVw7AWlfBwH8l1zLwr2+U8ymW2jPVAdddxJ43xuGJjhmm/Ks7ADnCgXGptI59Z6MbYK6GWWx9jj+YR0Nyh5M/vVtBkNc/aR7lmMSpoz6bzsEPG6gQ1yOx22XbWiHwD5m0lOITgR5entfX1zK1pilBflLfTe1YcTvc0T6v1rSjqAsT1frshPdSOU3SInIhhCpIFWP8zcqK0eJkN+OpEcvkTx6+8SHg2+4WLLUcCEQ6moLWMZu9wZUkG5TRVpGn9l/+nitYlYtgpgHTZWiuI9ixOeEVyYKAfES7saIA4kPbbLxBxKM8Y3YADRvTPIlq6Rxw89a7uFvOK+SFqGQ3SVUqCOrHoQA8uL1XqX654ue2IARuN4bvCcnxMKTWsFxioymTUgER5bIJzTbuhdVlbLGVUpE5eFNBjEi1AftHA+GRgVlP5kCQlmMmLvelmpYnTXtbYjlGnQJjuqp7OKVDGm3y/+kvbViefOFT3iIOOKUcnRtu3o3M/7fiDAEDw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P1b0+LlCTrvZiwpWRl3qQEmaAKOvgSBBH7iZ2uiUT5hPG+Bh4vY74d0shBTPEbf/9bRLiS7B1dK1klMUDwOi6EKImU9VqB4JaKoosI4XbBAOYWh7Zb4bdQ+ebDqvrlZfBpJ+u2F5l0YiSURehFxSMioQ+YgZ1Haacc6rGz01cbLRzu/SPSIvYWM0rY9uY4obWKNXENKGqZpBmzmk23DvZX36AAg/VeyzHz+v+TWV1iWbgFNABILuzr5Phxa0gKvClGzSSe9y01fcdMT8Xtz/lIW5X1Fu3rcW0UYfsKYlLBQVBVgUK8ADv5awurIlYvpMhODH1Aes7hj4lmuq9eDqcBbDfhkub4hXBnnjulYnaS68p+Jma4dC9uurRCCJ+WNFKOoJm/ENocas4FfecqWtWrXZUduthri/KHeGOmomAy+GJXJ6l4cHfp/D2OVAxFEQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:10:13.4473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c630584-d788-44d8-95a5-08df13fc39fa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6264

In case the conversion has failed or returned zero, processing *val
can lead to a division by zero. Need to check for errors, or converted
value is zero, before processing the data. In case the converted value
is zero, e.g. the Vrefint channel, this should be considered as invalid
in all cases.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260911161555.244F31F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Review comments from Andy:
-- Correct commit message: single paragraph
-- Use a temporary variable instead of *val to improve readability
-- Drop ternary operation and use simpler conditional checks
- Link to v1: https://patch.msgid.link/20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com
---
 drivers/iio/adc/stm32-adc.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be..b9468b9e560a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1609,8 +1609,23 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 		else
 			ret = -EINVAL;
 
-		if (mask == IIO_CHAN_INFO_PROCESSED)
-			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			int vrefint_raw;
+
+			if (ret < 0) {
+				iio_device_release_direct(indio_dev);
+				return ret;
+			}
+
+			vrefint_raw = *val;
+
+			if (vrefint_raw == 0) {
+				iio_device_release_direct(indio_dev);
+				return -EINVAL;
+			}
+
+			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / vrefint_raw;
+		}
 
 		iio_device_release_direct(indio_dev);
 		return ret;

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260915-adc-fix-div0-ae38365abfeb

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

