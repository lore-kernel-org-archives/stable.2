Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C21C5799;
	Tue, 15 Sep 2026 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488669; cv=fail; b=XyzLwN9VrZeDNaGU7PkkqnFjaY9mmbhnBc0HqvvF1XmMOmRkQoHGyEvnNwS5Gjynxkai1pnquDh+LWUsRjpBOvXuydVyZBxrEE6lQA8ROMzEAa3zfZybrvwzJGZuDhUUzQ+F33j7Bn1llQLwypbJA8PMaJzRfuMCuPCgU+/Zk1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488669; c=relaxed/simple;
	bh=ruuFznaOzop1h6oaE/qXE8d4G7DxaMMrQFeVlRIGSsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=afzOmSleym6SCGerK3DwASBXP/7FFDgTN7WoR/m/XCf/atwF8XmKj7670zCNB3l0elvyIymUuEqv70EyvCjtRMZKeuwsaYQi8fkIAxKmn+4C6xl1x77mwuS258plccpsRFhrsAECYeTAIPiPFDcGv3CDylgSfvUTWQLVD9W3hMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oi3dHOJj; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oi3dHOJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHz8PXKdjelDnjPN8MVNIf0w9HRvKSnNLV7HD6eO/JbMvQkGVEkLP29KM+zT5L9If6qmtE+E6Rvcd/I6FKBrODdRxfqow5Q/RhLv4yE5ltW+oRWIZ/aTRIhElM3PVv9aryFOBJL/phK88AWpILOOfPH4MZku1ycN3wY8Ano72W6PeNVp1Qpa3DvW7Z/93YddUo/HS/4zH4YXpKYmOJmPrtNPdcl/xGtvhUwFQ0jnlmQu/wkO2EeMdfjMFvUKAuyXLOywRSNhAgqUrGB3EBhnYiwJ80PE+S/kRMuwWcCBIR108sGUMoecbR1ypHCBqT5Qhw65OzzWTCsV+HYYY4vbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkZapNMOkbsGJyBzWVyHesbTpXEkN8djukdijZwoVOY=;
 b=rHVCWxmnkTGDKgFymFVJCFgT+YFPDuwChOIOPAGX3SnSISlzG1iElmnClP+bZY6gv/9Ng+p6poDyis1KYLAmL0pKN4mae9Fneu22OjFGk7vhMijCvAPAnGYQmVRqrB03NLUeZma82sNi7eBsaMeqRtFFVmgKYB/gcyluLtavt7+Dd4RZ/ML2uzPlVt8wRxEq1a3UoqyMuoMGqUx6BAWVDNtsX+DPwON/P4FimAbTnZn/AaErySzemP64HQHTFgYECBLXUAdgO77JLVMboFvQR1kKhyIbhLqiQrnyJ5VMbxfJ/Q6McT1TywCqf/ZtCvCUuSeDaQ+9+GbTm3/DJXQ/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkZapNMOkbsGJyBzWVyHesbTpXEkN8djukdijZwoVOY=;
 b=oi3dHOJj17Ae71dgtf/opBkb0mUAjcW1BQRJojCNge3Kh9s4hVFYDbnwlFyvppas3N0rcb/qR+PoFB5rD2JIpVscTa26920aaQ50XaQu3CDytp9jm7ipWMgb2SpCxzQZcB2q8cIqjnxD9EPIVvSD64tBYdlW2NANbqVJaYZqssI8BmG9pGe9TQ2fkcHm0/04waVnEdEE8IytSCfsr0nQxzKksH+JFH/WcsvjjJXX/wNslUWAojfidK6LkvuNTOnexsBVXZdTw03jDGYHGCqWJklz+SC651qw/QHOj+rnQB1e9ZOQh77BidFdZ5lYp/D7ZR3DNyEpY4Iw75J/eseJcQ==
Received: from AS4P192CA0013.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::18)
 by DB8PR10MB3690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:136::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 15 Sep
 2026 16:11:02 +0000
Received: from AMS0EPF0000056C.eurprd02.prod.outlook.com
 (2603:10a6:20b:5da:cafe::1a) by AS4P192CA0013.outlook.office365.com
 (2603:10a6:20b:5da::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000056C.mail.protection.outlook.com (10.167.242.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:11:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 18:16:18 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 18:10:47 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 15 Sep 2026 18:10:40 +0200
Subject: [PATCH] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAP9tqWoC/yXMyw5AMBCF4VeRWZukSAWvIha9DMYCaWkkjXdXL
 L+cnD+CJ8fkocsiOArseVsTijwDM6t1ImSbDKUoa9EWEpU1OPKFloNARVVT1VLpkTSky+4obV+
 uH377Uy9kjrcB9/0A4j/aR3AAAAA=
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000056C:EE_|DB8PR10MB3690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9742d94a-a284-4fcf-7f92-08df1343efd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	xMRlDzxKnN7NLBmc2zVifCPsX1PV7vDwmoSDvmnlDAWe5y5Sglo9o6u5K1Ql5CNrdqqaInB9UCBIh4Fx3yoMgrkENIBoM5PVatXN3pjdLmS1c4RWwDaAkxyencK8l6/t91hPOrNQ6DOIPuQhVu3sg/uX89So47tmULV648WMt99liOHHpDUXvVvrbgKg3yvtzk9jlvdUz0St7DcIuEkR5UO3hDnb4k5n6ClKMxvEynnhxZO53Ioj4AvLqq0TJQviFfVdzo5li4ZhJXQCxQ7tYnufgXTlo2JhuD4Ozcf00DinDRpnftGUqomL0EGAI5ITt9GzhguF4kczR3JZu5d1eziAsol46Ln02zqYgnlZx9T18l7/xN7C0TJiW4/uaZhekYdwWYzDxyxigK9bJSqfCt+6O5A3XfzBoIiTE8dDLnpZA8IvpNRZzeHkOEU0q29r3Lgcxu17TnQiANWIg1j49fbGXkMOlgUFwUWJgnvfK46U/eT02f8yCnrDlkEDVQN74QtuZWKaOjFTfePkueT/fe4MvP3zDoheGoDzM0GyDKUa2kamEAyyVsDKb9gBgRbGwiUbE3KyzbwOZ/q2ErVueVStkK3HyN0AJaFtVLKo8z6086gvYWuN0IniOJqpfkbj3ZD3HXVv676y2xvOlgDPOtRPLAJTRYlajeFW2Gbw44/qi6vm3W2psqA9VrjluPe+1dUPfjA24YiRAOn34ag6KQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OQtgWArp9C1cON3dheh2DwdibCd3o/sSVdx4hZymRGUpXFMgdtombyHe226mSZ65D/pXZ9aY8MiUvGX+eBDoCE7p9dw82eA8M1T9IRa1+MAiYcz+WN0/kLLSBcBFQNFZfa567MVHTc/D2oz/MFFUXOUiQnvSbsdha2M0pxi53hdobNcggc6/nBqYjR8jxKCFq4iFhvH8+d2FQWjJQnZXPqe25WGyYpP2PkVytKDG4mfys3ohbC5UOL6oyPs3oYSVyISQIukC7XzBpEVz/sHesihBFqieOQW7cW2yzeIMM2wNfnIJP+ACSuriK6a8zUOko5oAKQ5dIiHIWvj+MrlRtfunvXLG1619O0vD7tD+8e8mEKCa7FsVG8jJxei2pRv5rBjOQ81JWeFCKUtpx3vGI/u02QSzKkJ56sgD1ZJmnC2sEKJibJrB/1b25FNcuLYK
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:11:01.6553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9742d94a-a284-4fcf-7f92-08df1343efd7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000056C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3690

In case the conversion has failed or returned zero, processing *val
can lead to a division by zero.
Need to check for errors, or converted value is zero, before processing
the data.
In case converted value is zero, e.g. the Vrefint channel, this should
be considered as invalid in all case.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260911161555.244F31F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be..d290c5a8f86d 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1609,8 +1609,12 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 		else
 			ret = -EINVAL;
 
-		if (mask == IIO_CHAN_INFO_PROCESSED)
-			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			if (ret >= 0 && *val)
+				*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+			else
+				ret = ret < 0 ? ret : -EINVAL;
+		}
 
 		iio_device_release_direct(indio_dev);
 		return ret;

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260915-adc-fix-div0-ae38365abfeb

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

