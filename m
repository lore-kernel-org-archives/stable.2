Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804314F0553;
	Wed, 16 Sep 2026 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568020; cv=fail; b=f9bP+9gMipakqJiJyPht8LFPbrIHePQfIZ+n92Rj4MiPasQO3DSdDVfCksDPNWAdBD13hkmbrXCCP1qR8t52qzu92Yznklj9Rcq68/Yzwg0nqM2nCX8QAZtZVjE3GfDUbWNbIEjqmPito/5UY/eiiVpKbt85bZSvCXufenRmq5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568020; c=relaxed/simple;
	bh=1z7uXC5y4x2J29g2i2+1sggrwV5JbsThueUOL8A9yZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=iROk1bGgBv6CCrPfCdqD0CpDQ1yyrcxZhbnoUH3uVFJzPIOEBQkNDPrVVOwEZd9Juajfju4IGf9Y2hhsxq2uGjHj5E5iqkL2olB2QvCD24Cnf7uQE/k39yBwjUnQMhTe6Wo7RzsScim+XtGgaGZnFlsLYvxe5GFc76urQoyf9W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bw85ub8u; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bw85ub8u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABZ4B0qmXl6X3yqg8Pt3HT8PVgYLC1P9T12NcqBm15ps/DELhYj3uVUVuoWNaLt+G5MqEkHcxe9rMqFODIeb4yNpD+WT3z+7YPCRoUKO3NHHXuZn7Rbzq7gFYQngOdQOSb4+ow4Th0Y0NTaXrSeJKC5NLDh0brlr4Va8gkbPFQZZV7XPNXlnPb2Z/5W5JoOeR83VLldUyAAgTwe0kTt3vlNIi2kciASdyrd8AVnzvS5I2GTylchZhXLp16QhD316gvCf1pPfX4pZ7wXUmHpjfIDBLtaM0qu1LNwUCwunNWzMPjUgGdaUkZnE6Ry9Gw8BLqWICp3dJlBfMvYopKJPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=324p2Cfe//Shb2BLQKnxO87X9B2RZ+K5uWEfkM6+JbI=;
 b=hmoTIEvt2v0yHqJt5MOFvOslPhpwvUnStvq0jnyd10uG9UskCTeBzC1e475qeS2x12TTmlsXmITv4lCSvFRgHmyznLkG37f3NmEkN2FhhxwLDt4f6KqDKTgRkAdpi+an58Qzku34dKmOURn8clsM8PLog01D4bY2pC03OkOhs8NSasw8IvAW3t1JCRx+sLVCHLgSSN73wPPpOPgTaC3DraFctsJPg4MaUyn+kTmNgplxbLCByN2zjOW3vL9jJA6v9W8dqr+JVHkiixp28kfPkrOGu19tjxvY2gdBumkQCZUXlelwnpnjo7OKXVx7KxCDve1JowwlbYiHeII7AP3y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=baylibre.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=324p2Cfe//Shb2BLQKnxO87X9B2RZ+K5uWEfkM6+JbI=;
 b=Bw85ub8uz111OQmUV1HDbYvtasVlvPBKVS82ZoLR0eArIoP1F77liH7U4/85xE/M0axPFmRXxCBPd/Kd8wAoWVHgXJDcREl/lgLMc8glPEO+OtF1DfMTsoUcnGMv6/6LbIQm7RrI0dHWOtVodZlfZyQ1JczqGtKqkmEDD03wpUaOwpdG6slohEV1Kf6cG2WPUy6zrfPnt/CDJSxyfrTkXW5B6qYNnCfuthtWeLyRA+hArT31mXVuBMSo+fwBKX9+vjfr4hp4d6pFdGoOkR+A5Lc6ZP8iZVFrLAxVRk/EPSr1EKQLCWvRri5Za7wqWipJ2mKh66wXk1x6VSOHQLWxZw==
Received: from DUZPR01CA0118.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::29) by PRAPR10MB5177.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:29c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 14:13:32 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::8f) by DUZPR01CA0118.outlook.office365.com
 (2603:10a6:10:4bc::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 14:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 14:13:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 16:19:36 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 16:13:31 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 16 Sep 2026 16:13:23 +0200
Subject: [PATCH v2] iio: adc: stm32-adc: fix check on internal channel
 availability
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-adc-fix-intchan-v1-v2-1-ef70baecd082@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAAKkqmoC/32NywrCMBBFf0Vm7ZRMS+tj5X9IF3lMbQQbycSil
 P67Sd0Ld3Pg3HsXEI6eBc67BSLPXnyYMtT7HdhRTzdG7zJDrepOnahF7SwO/o1+SkXAmbBx7PT
 RsjWtglx8Rs7GNnrtfywvc2ebylIxRi8pxM/2OlPx/h7kEB460mSaVikylyGIVJIqGx7Qr+v6B
 eRri5vIAAAA
X-Change-ID: 20260915-adc-fix-intchan-v1-3deda8cecb50
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|PRAPR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: db68f70c-5e6c-4783-1562-08df13fcb057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	LIyPJ5uk92MmTAzObPSTJsX55pBYOD9O7B61Qgcd/A0vrQdHLaL9xS6ScW8hJ5S93V/dXbu8ufH52vPpQekFLvnzsbS6jCD/4FLfmBwCpJ4LiDwjCLdeEVrxRQ7SfuirtArgYUgxVHxLfF4ijRGlAjdJqw69I+UBzTMUlFexja6THQIxuOAn538M8xtWLKi/0THK790GfRd4KUNbE0z4vnOGtysoxup7veMYRqKIBxBv8Zdo5Y7gTqPPUvCEY8YqAmDbo/fYhKaxruHRgbzt3QcImIsFJnNHyslub6HRDU4HRRCnn4wumoDFDWWceSv2XDGNfeEg945pL/ITWp0cHlR7MWMUaDdMXGCP3njD6MQHnLZmwVc1b80gZUlCkaUrxXPg3s53mhg0YWOlaS27yPwH2RutvRwQsjf+M7NpWpmk8Pgd3R7ReDabosIZ8ChzFtmwptgH+DPUmfulXLvb+MtZaf0MmkMIaOS/T/EEizIw5lfFRq9Y7OUuJjy7sWwpa8JiSwcRofkz51Fms3UGLVVMnEGJVammkoDuvf6htEhZlDDT0ZOkyNfRmRrxfiK50xHDCtVjISH7sIJVL0NeNfUvo3xUZ7PQ8HAeuMvUFiLit0RHUZXbTV8mV1fBhVdY5NvQiO66nG7WaFVvYgGKypeShmrthK9EdwlX8HEJ74c=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aesdlYevOfCcnZnyUivmtJRIgO2b8h2qIzl+r0TjX/VQqK4Cq3rWHO218WkqM3iAJEtfLq9G6hvWLn/uUUsUaSClBOlvcGGa44YnW2MGgGMg0GEkAkbqJJ0uVNMYr4sRVcn8fZT7AXp63tY+pdwl9ILwiJG+e2x1Si3TfjZyyO2MYRI+MmCSCP0AMxR6OWwVl1nluI+XMveRhdMhJ2noeZK2oWJB1NWgLNEe4P7SOvN3578ocxa3HvuGlSShTy4k0IZTK1geevKtkWlF4nq9dGM0Bjga1EkbNAfltmMFGUHiT9KYoVep77ZXn5WYWZMwq+ShDLLRCOVesSv/U3xi3LiWaUWe1g1spLCuraczLUjQx6fGHWyH8wZorpBIgkA/iCTnh8GBVtophIBnfPPaFy6qZRW8PO8Hw4/9iWVo47BgPAKvICGVcUXviMTgV4NV
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 14:13:31.9816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db68f70c-5e6c-4783-1562-08df13fcb057
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5177

If an unsupported internal channel like vddgpu is requested, the driver
prints a warning but falls through and assigns it a valid int_ch below.

This causes a problem later during setup:
stm32_adc_int_ch_enable() {
    ...
    case STM32_ADC_INT_CH_VDDGPU:
        stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
                           adc->cfg->regs->or_vddgpu.mask);
    ...
}

Because the register offset is uninitialized (0), this performs a
read-modify-write on offset 0, which corresponds to the ISR register.

Fix this by returning before a valid int_ch is assigned. Choice is
made to keep current driver behavior to warn about the channel name.

Fixes: cf0fb80ae167 ("iio: adc: stm32-adc: add stm32mp13 support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260911162602.D323F1F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Review comments from Andy: use bool flag closer to the channel
  availabilty checks. Add a default case.
- Link to v1: https://patch.msgid.link/20260915-adc-fix-intchan-v1-v1-1-761a1b35001b@foss.st.com
---
 drivers/iio/adc/stm32-adc.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be..b77f39f305d8 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2263,33 +2263,37 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
 		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
+			bool na;
+
 			/* Check internal channel availability */
 			switch (i) {
 			case STM32_ADC_INT_CH_VDDCORE:
-				if (!adc->cfg->regs->or_vddcore.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+				na = !adc->cfg->regs->or_vddcore.reg;
 				break;
 			case STM32_ADC_INT_CH_VDDCPU:
-				if (!adc->cfg->regs->or_vddcpu.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+				na = !adc->cfg->regs->or_vddcpu.reg;
 				break;
 			case STM32_ADC_INT_CH_VDDQ_DDR:
-				if (!adc->cfg->regs->or_vddq_ddr.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+				na = !adc->cfg->regs->or_vddq_ddr.reg;
 				break;
 			case STM32_ADC_INT_CH_VREFINT:
-				if (!adc->cfg->regs->ccr_vref.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+				na = !adc->cfg->regs->ccr_vref.reg;
 				break;
 			case STM32_ADC_INT_CH_VBAT:
-				if (!adc->cfg->regs->ccr_vbat.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+				na = !adc->cfg->regs->ccr_vbat.reg;
 				break;
+			default:
+				return -EINVAL;
+			}
+
+			if (na) {
+				/*
+				 * Channel label matches an internal STM32 ADC channel.
+				 * Warn about it, as there's normally no restriction on the
+				 * name but that's not among available internal channels.
+				 */
+				dev_warn(&indio_dev->dev, "no %s internal channel\n", ch_name);
+				return 0;
 			}
 
 			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260915-adc-fix-intchan-v1-3deda8cecb50

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

