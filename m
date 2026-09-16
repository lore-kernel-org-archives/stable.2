Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085E3AE6FD;
	Wed, 16 Sep 2026 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579133; cv=fail; b=Enyh8OUkkMt5UdzNH9dxs/eL731gM9Y17Rzl07g1876QvIvKndkkFQUGJ/bqXDGAVZFzuW/nsNt4pu1rLRA2fHUit7tR0yXbQrMeAox93Q4zIDb7bTgIO71TPtWPKehhWMXf92alFeLjQXpurAzdg9fpNm0j5lPjk/9r8LMI6RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579133; c=relaxed/simple;
	bh=XkGWxNpc1KR7hfMOJgCafYsGMJlhuBTMGVLGbTyQmNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=N1Vg+0AhnimfmgwD+k8IFa0Vkw+aSa4HIHvBglwxZtQFCE/HlVyVzgUX9pz37zVxT2Z51wXw+wFGHkyp/NtTxvS8AQxQ7g8JB6GLEQgHXhhljM57ip2R2+StzD/2I7ZyMV/hhOFPowriWHXlG8XekkHkAqfs6t6SwrjKQ/X5pIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=T88UEuiM; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="T88UEuiM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldDF6thAICo5/1Xu7YOt3VkEUSiZ+sIKRHLBZjAk4EZ662DmxexMvkFLrciWt7EYkMZjexoa805iXIEUeAriDrEHih5rk5WdY/njTJzI3twXG8neOikBfqHqtYA2YMyR4D6vKGzXnKRJ+G7e9DrySncq5ua3MoTyXW1cLclyfCmZTnVDkopMnJgbHDHlt9o0sSGd7e9I0qyJpW6Np3klhpEugWhl4hh/S4FaZkBJljrIw32nHjM62rzhHhy2oa5rpl2+ONlCplKoeSVXvXJCBDHLayTXCK9NtTNlShpe4EGYopldLus0o+kioRSji4fOkLUnkb+ATsvfMtGN8fLAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYPgihDng5OCKuceMHWgLUI8Nqzp5cD+eH/JcUxG6I4=;
 b=BvZn9lnBYtHQ0DYpiCUZ3I1JgDrNx3FnlPVFaG0Hp/Q+hN3GWcISFv59mXTiaXc9xvm/XIaiv++OXgYfJz92lu2kKFFvVnWaja0NrvgR/VtieQxElrSDgMSRTi7uWW3xwJkObHz3k83+B8pJWxlwEUUo38BOALFXdTGfzXYU4YH+8+XnS0W2/zEBJwj2aVcehZjfmXMPPSP8Ho2WA4naW+Ys2ZjEWgP1eQFbuSVyniQIGtu6DjsxD8BkkO4Ow9vVUiMS3FpTSZmZTcJc6e6R+1nuWHt2OXIIP/SVjyIbGQqIzNbWvp05AthXBGLJOmBwY8+XGhKRpVmi+sj0SCnitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYPgihDng5OCKuceMHWgLUI8Nqzp5cD+eH/JcUxG6I4=;
 b=T88UEuiMR6dVYPbMauQrN600WarCc8DgLeYsA0zrhBEntuGbK/3BkuRt9Ad3wrGlL7lgQLyHoR9jSI19Qa3djYtgOY1Hd3lqimsYPHVTVVSN+RcQ2qLeuKmN72RUHC3N3SO58onAkNP24408CQWIlkOCqr2O3mpFxuFp7tSBQ7y7UQbVHmXpVshPsPAdAAQQ0w1kl04y4+S5IV83u1tXQYDCRNEFJ5O6hXEPAsP1n+t7XK35FEerjmrBkPmWFWLptz3lKDKZVvmSPuIm9kcMX8Tw2nj3WdyiI+AemQC/+gf+JfNiJ96CrV+o/qGlKKFNWA2kuv+17zksRJ2bQLubfA==
Received: from AS4P189CA0064.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::24)
 by PA4PR10MB5682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:264::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:18:46 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:20b:659:cafe::9e) by AS4P189CA0064.outlook.office365.com
 (2603:10a6:20b:659::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:18:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:18:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 19:24:49 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 19:18:44 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 16 Sep 2026 19:18:38 +0200
Subject: [PATCH v3] iio: adc: stm32-adc: fix check on internal channel
 availability
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-adc-fix-intchan-v1-v3-1-b5f05b86bc60@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAG3PqmoC/32NywrCMBBFf0WyNmWS0oeu/A9xkcfURrCRTAxK6
 b+b1I2CCLM5cObcmREGh8T2m5kFTI6cnzLU2w0zo5rOyJ3NzCTIFnai4coaPrgHd1MsAk+C1xa
 t6g0a3QDLj7eA2Vijx9Ob6a4vaGIpFWN0FH14rqtJFO/vQD7Bu1YooesGQOjD4IkqipXxV1Ymk
 vyMtD8jMkdw6EArNBZ6+R1ZluUFYL8+nw0BAAA=
X-Change-ID: 20260915-adc-fix-intchan-v1-3deda8cecb50
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Sashiko <sashiko-bot@kernel.org>,
	<stable@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|PA4PR10MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: c148b88f-3d21-48a8-f927-08df141690b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|1800799024|36860700016|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	XckR9unBDH9NUMWPKHoJWJv9bE0/0/6zNTgoEpHPAA7Mw2iGFPUwCsfD/r/SGSEUhWUi/5TCtDuBX6a6Ly3ptXxTfEoWCrNRhZT26UrsuH5dLb2LP+pq2z651v2i9VhMm4psSPQgGzrzJPWSQnsZom4gsZ8VI3wPm+54Rb9vacc0gFYOgXxBTGH6XPaUujDXfnu+K5x5ecz9LQn5KJjh5vabTCzFoNMfu2nQdpbQL9yYXRX7D2IUAclCKGc/eEeY1IrNWFGNOkY+QLUHkzussSqkmZCAh/LXwdpYrvV2mtNtMCPP6HMLnz9547FOMx9I1aUpjHWs5LL37JcxUVyO2p/Z2txm0aSz9fvV/RSRXIWkHlEeGS4p/AsTMz2JRXtVnepvrwGQcP89of4ZqlJcg6iSjrmDM8TCoKNqoH3no5lclDS0rrLhpuiFFMP9doyjhaPpAa4kO9YHlomomaMHM1rdORG4MomtDPSqTXZLe++3dyWu3f5VAWq/8+i61jC4QVHsUSlznL70xW+jkiIxelmjWI7q8MpRAvlVYpBgaDF1qniJRmZz7cRGIlAsT0Gt0F2bTYaBUSrLgPsyG2qgHSXwZsPnlp/5SNazA99i7f5GYjlhlSxBOwKMxN/lny9Tt1C2qBMfisc5cb9aLfeVctqT75bWYemQqXB6bP+Fc3k=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RbpFfhxsrbkDW6r9LeT1XWR2lXMLHMoHApptmsFP3LNH7UIspgQw2S2BSmHaQRuv6bDPQFOKmh7d6xXFO+BjucT2ux6bBwjqBsrfBdgAdB3EARuxT7uRMlLVC3FGgApnHrU74U5nJamD+MFDwFYifAxrCn5kwGHPjlHFbIIGBxK2SToazdoVCXB8nViIcoSetZWiVS7ZrQjrZdAUUV8BOpOXdgJQ06oyyiZBykQgMK+Fnv7/RitZujOJQMqRePAFexBQF26AQCAOpMvY86p6nfX429UATRM4KbULNPv0Z53Jo1tA9ABUhr/DMoHwWY+bXlqxy6SkDvUYIROWG3WJ5ZeGg2ob3d+/75YAyo9JQSIn/VlF9WiwQ+2s03J9czDjN9X1avoNVWazTHrfxafcYfVBJwATJKoOi21DcdOEWshESedJWMSJiaXgNB9aWEkO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:18:45.8182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c148b88f-3d21-48a8-f927-08df141690b2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5682

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
Closes: https://lore.kernel.org/all/20260911162602.D323F1F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Comment from Andy: use Closes instead of Link in the commit message
- Add collected Andy's Reviewed-by
- Link to v2: https://patch.msgid.link/20260916-adc-fix-intchan-v1-v2-1-ef70baecd082@foss.st.com

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

