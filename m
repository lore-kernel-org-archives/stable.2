Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021043BA225;
	Tue, 15 Sep 2026 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488979; cv=fail; b=EWWCgmHQkEGcC0kKMZJ+v0VaT5CSSgcsRstfftBOBYRcT1XTw6G0Y0AQ9nKyjGYywQw6ll+h3JpcZHXYFwW67r9g8GnV71+VPmaD4msa7LLbROh9G7M6NluTGUKa7AnZseIHo30CBGJ38SKudpPVT4I4xCWDhWA/AIdrOIdRwwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488979; c=relaxed/simple;
	bh=t/7mppWEF2dmNmmDlTr8yECZz4rIeyoh8QBvtKmYub8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aAAJ8xsPUbvgZUF0rSyRQm94juygf6y8WWk5yDTZA1MNnA+mMbl4sPJ6lFMnNhzF8l/hxtep3lBG/O0L/DAcstrOs286cBfCZ+fHAOtkJ9+RMQytOFsaEQ3fKx5NYmCyipqFPKFn8mK4skvNlLZbxSXza4Vqy0zcE5i79OX58fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QARPcK0y; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QARPcK0y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxsxzoOh+ef8nv0WwCNY4HTO2DNj/2uLzQhdx+ijboyDlf2RnQgMgI5kZYDQys5pMddOSACzvgCq1a1ZMEA2/TEqURsKj/JdRQG8o8EmYYPSg2nC2tpHmSj8+6nuayb2amORD5dDt1mmGVpR5oIODI4p+0DztWelawMZCuvesqkYeXh1XRi02KTAbki3hzj878E0xlNBl3Xys2Dv23OAjg1fsItoudI70PltJnnJcqbAEsecdDmtZskDWrV4S+pinhs3z4J6XDIWHUA9K9/di5v25SArX7NDZ3cv0go/YbPaE4Fwe1PC879EbUHFeexCnGonDGYdIvnLOsgMlUuxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfOxCoq6hjlnfJuev3I+tSYLzdUN0CTcRjc6zwTeUSQ=;
 b=glABRBwU5NesFOlDIxoVN/yjM47bsETux/VvjG7aIdoz1pSE65Wr7DrAT7d20MeUxzpHuvHCzDJV5tKqiGR/uq2PQtZyuhxEFoV5Cc4lsKyvhsubqSUXKxpY3ywL1aQ05yDWcFuBsgsAR28WqQcQDwCY1GOm+khD67mT6+zNxtgWyDJuhc21Ju4axQqWKAkc31QLwcFYMarQQps+qKylnP19t8EWxjJV/VgKWp/gMjuj5CJuhOj82/jNnj0S4MEJ0N4wvH3AHhDDjbDNAdPXZllOyM0CrNmTL/LOTL0hIFDbKJNRIDv0my8H6VFSki+QhrABoGws2dETbrjyYD3AzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfOxCoq6hjlnfJuev3I+tSYLzdUN0CTcRjc6zwTeUSQ=;
 b=QARPcK0ywgoZHg6GCek6yhamiuXZINtqPStF9CaY/RewEy6WinBLciLVXCwU2nPcz/hRBjWOzY/j4Wbtth7XA4PCBiNduOIyF97qHopI3+boFLfjeAd6adxFFzLeOwmnkBDhCSSTK11tdBPpFXh9vsgKwHDzQiEATQYd6oLZAFpBHM7mHwn1NQaCu6kdWVgxahtFRm0v02063UYaXzw6CQ4NjRYwQpwdMQ3Exw7X97pJ0eLznPsPSBdkmhmlvljiAwlzhYvBX0GYNpUB6CWJ9n2Lfn554LjzZggvHZ8hwI3sTn0PZNn4oTUhR6lZg6v/bKfkgw3rgJrLeTpyVtmHgg==
Received: from GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:273::17)
 by DU0PR10MB7381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 16:16:12 +0000
Received: from WA1PEPF000099D2.eurprd04.prod.outlook.com
 (2603:10a6:150:273:cafe::10) by GVZP280CA0046.outlook.office365.com
 (2603:10a6:150:273::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF000099D2.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 16:16:11 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 18:21:40 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 15 Sep
 2026 18:16:09 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 15 Sep 2026 18:15:49 +0200
Subject: [PATCH] iio: adc: stm32-adc: fix check on internal channel
 availability
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260915-adc-fix-intchan-v1-v1-1-761a1b35001b@foss.st.com>
X-B4-Tracking: v=1; b=H4sIADVvqWoC/yWMQQ5AMBAAvyJ7tklLCL4iDrVdrENJi0jE3xXHS
 WbmgsBeOECTXOD5kCCLi6DTBGgybmQUGxkylZWq1gUaSzjIieK2V8BDY27ZmoqY+kJBDFfP0fi
 mbfdz2PuZaXtPcN8PoBPj1XYAAAA=
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
X-MS-TrafficTypeDiagnostic: WA1PEPF000099D2:EE_|DU0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: b6eee13e-4c5c-43f4-c7f6-08df1344a870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|23010399003|36860700016|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7Diy54/Qs7Z3gv9ct/wZgbbqWyE6l4/NW34jrNQk511mPcaU9+GiPoBOPTGU4h61yQSxqTiJhGMBymX8wd1UlFsVJBBg1+ocfQ7YJ2W2NLSDunGgvbyfvVq5ZyZ6quq98yIUYM6BwkTgoMisMuhjGrs3/4u7oxefXBHfmT9CqXB0f65ZUrLSs9DclRdBYhEQ80cLmYi7IGd0Hw3eyRiBlCM7YbyotK07KsmT8xY+eX5/Mn+sgubnwvFody614WtOWHNQJg7H16vEi9LALXK13r5w8B+aBtw4rkJmgpK9m5qjK17T0q1PgKt2SvrAvMkPpJOFyqmHeqU7jWwD8d+qnd/tleC21PRqniWbgeGfZjdoEZ9fYzwINUyB8QsuG5+qQd3TmjITVzqDFe73zUl+Q32B5b/gNMWrFZm87iVLUxw66MgdT553dBmlP9OvI+GCjbShsCg3jtbdO1CWnVbfQvHusrcjmaaaJ5niMK/7L+W5212iec6ENsl8BuhfG4TZDOEP6RaTtpWtt9pJvhJe0uRfXErXZb3ll/NN/B4/fq5vwnJM3ljbfb02Fe6IVrJiKvqZMrBi+iZl2jCzF65Be+XiBU9XEkxqCD/JXXybmZApFfA4lg8cMnsJkVfGn7kTTQIkAfjd7vbNaUsZafkfR1qVeNTlkDGP/z4Smmp1gRJQbL7Lw/ctzGGZBSd6jsEbE7EEfkobIAV18RLxxfde0w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(23010399003)(36860700016)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tjo4EfdeWqVdKvsP+59ypwWXc7sbXFHPLMC/l+PcFmhsDBONne8bP/Efs+zFVmm8z5gEBSabuW8kIdhxrbKGpJWgExWMwlYV1gpboI2QoDe1rA/70jwR/4ckuzU0gqcPYVIH6seLE9MeoZRxCCh/30YU2mxwHiQ1QALMkVH/lEXaZVsDg7cF1RLzau0b+l0qmmZrwlGVOypc5SbgdekjLxmKpEdvuxStPKsW+N7a6WcpceYMdDpwQYscsDZkTPiWcoB1NeSYQnIgTKljbbsMj4bLTPWdH9geDszzhhOodYxI8Dw9bghqWjZBPkH8vF2n+eA3LdAgc36PP6H+sbm+DOXaGdPldh2yQtzO2PDbC1EIdcq3jQ//W7xn5i1y5mwBSLImBciajaJhrk9Dne+2LCq/+6zFTMZLZD6klspqUn99qR25HCRR1PZyHJMkOxz4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:16:11.3537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6eee13e-4c5c-43f4-c7f6-08df1344a870
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7381

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

Fix this by returning before a valid int_ch is assigned.
Choice is made to just warn about the channel name as it could
be confusing, rather than making the probe fail.

Fixes: cf0fb80ae167 ("iio: adc: stm32-adc: add stm32mp13 support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260911162602.D323F1F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be..87fafdd4698b 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2259,7 +2259,7 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	u16 vrefint;
-	int i, ret;
+	int i, ret = 0;
 
 	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
 		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
@@ -2267,31 +2267,36 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
 			switch (i) {
 			case STM32_ADC_INT_CH_VDDCORE:
 				if (!adc->cfg->regs->or_vddcore.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+					ret = -ENOENT;
 				break;
 			case STM32_ADC_INT_CH_VDDCPU:
 				if (!adc->cfg->regs->or_vddcpu.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+					ret = -ENOENT;
 				break;
 			case STM32_ADC_INT_CH_VDDQ_DDR:
 				if (!adc->cfg->regs->or_vddq_ddr.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+					ret = -ENOENT;
 				break;
 			case STM32_ADC_INT_CH_VREFINT:
 				if (!adc->cfg->regs->ccr_vref.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+					ret = -ENOENT;
 				break;
 			case STM32_ADC_INT_CH_VBAT:
 				if (!adc->cfg->regs->ccr_vbat.reg)
-					dev_warn(&indio_dev->dev,
-						 "%s channel not available\n", ch_name);
+					ret = -ENOENT;
 				break;
 			}
 
+			if (ret) {
+				/*
+				 * Confusing channel label matches an internal STM32 ADC channel.
+				 * Just warn about it, as there's normally no restriction on the
+				 * name but that's not among supported internal channels.
+				 */
+				dev_warn(&indio_dev->dev, "no %s internal channel\n", ch_name);
+				return 0;
+			}
+
 			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
 				adc->int_ch[i] = chan;
 				break;

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260915-adc-fix-intchan-v1-3deda8cecb50

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

