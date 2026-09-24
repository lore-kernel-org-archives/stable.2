Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255783F7AB7;
	Thu, 24 Sep 2026 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243663; cv=fail; b=qYrU5ug/EGVON6DpCM85+i3txbyTVUUf1CxEmg4TdE4IrcN0q+cXOLRc0VjAd8it3wty8Qe7gd8A3NVsJsY2rcdz+9DO4gOkrRPU2ixAaNmleOCApOdAnAsiK64R8QMqSSQNty9D2PVfb5uRmp6ZXDVuCYJIOcg4xQNNhR/iHhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243663; c=relaxed/simple;
	bh=8R90wT7ahDUUt+0T5Sy5U4G56zpeRI6rEskBlAu/WAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=NMELiAxFnsvXyn7X+dOEi5/u5FT7AGDewAvoyMidi0RV3Auh6RcHMUh+Yty24SAPS8IThjb19YfD76+4u9ESKBM+RhK4w4IsBA+qjl7osT3YXLaGEuAGtrESre7jol8hb2f+rkRnsmKT4e/VZGYPfD6CgHeD0aCJ9qPf13u5R8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=agiSLOHG; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="agiSLOHG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8/V+9/kcY65dU9nvDRo3go52XccJ/7wHtQMCGbXYYZloOXlrh2IG8wNn8PiETIHgWu2iKofRoCsKQQsvBTIScswQAthki+dQ+jBDvcJvZODiuzVdW8HZLFnj+BR3DxLZteTbIjBreQWBtxFLlgqb2SnbYlNBGzWuGG/FBfN6DolyNkytn/2GlgfEtC7F/UErukycEWZS+JQE/BzSJkxU1WaNh5BaDNAgbIlKG1rA4yEsLU3AZfLCmvrprGEEHUX12EOXnyz9DDOsQ4IeLLb2cCzsDOEK0UZC05/LI8HEQVo6DcrxaECwgqf24loGFv/1VEMhVgbGza+lfhFnW1cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqmBlO9+j+BpSs7zQi5+5I9CbI8UN4f/J7FNmwaMTbA=;
 b=ZNmbIQPJIWfdSbHXPzDDOHDbXFYfXy2ao9mfWuUdWcz6WqB+Xt0EgWk2zb7lo51dZPoFFBZRiwVhoxOeT6eT1EVnGq5BZ9/Jpk8Gg7BEJtOwTmLuXw11E1mKt+BjC72mWygQuTwzi3cs7dhNOAnIMoLfzp2og+UMJ+PeXeU3bok9FBtfAtKHE13ZoXKM/qTuluS/o1URdbagC9dLsrwlOQVKoGOA90ofoxTMO9nnJQQE6JnK5WpXlJHx3vGioWqGtie/Vmit5TAWIqnNXST+oxmzmauXhaZEqS8X2pxPYGBlPLbkqT6m0aiY/2qNp+ieFsxvZrS27ufPdWzRQuGSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqmBlO9+j+BpSs7zQi5+5I9CbI8UN4f/J7FNmwaMTbA=;
 b=agiSLOHGQw/BHMZInOZN8a3CzRvpJflKtA0t/RPJGVVgQ4UOf55nI6KHgJvhyDmB8PJplZoJgBYzpzVvf8k2lVKHHiz1+hz1rQjBwz/GJhQP8RF7E5DTQ2QR8cY/IJiukVaYdXLVGouQLExVg2h5XTBjO2bTOjJw8KUTRyT2j1n4/JCFZtHusV6c6fng1XgOxbNM+8yo8XYHxeOwX2cN7+jnwJiLcnWBlx87OdN2U7lhW/exOzH2D0l/74UUiKkF8ZIGNmniiVd9CAQedgF4zstYI+nv+2ApCZYP5xioMA6rxYMpvfgEdTKDimlgL9gRRRNBW+kgzOYX7PwpmBYdDA==
Received: from GV3PEPF0001DBC5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b6) by PA2PR10MB8751.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:420::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Thu, 24 Sep
 2026 09:54:05 +0000
Received: from CPH1EPF0000052D.eurprd05.prod.outlook.com (2603:10a6:388::188)
 by GV3PEPF0001DBC5.outlook.office365.com (2603:10a6:158:401::6b6) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.12 via Frontend Transport; Thu, 24 Sep 2026 09:54:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF0000052D.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 09:54:04 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 24 Sep
 2026 11:59:54 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 24 Sep
 2026 11:54:03 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 24 Sep 2026 11:53:56 +0200
Subject: [PATCH] iio: adc: stm32: fix minimum sampling time values
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-adc-fix-sampling-v1-1-13814954d8d7@foss.st.com>
X-B4-Tracking: v=1; b=H4sIADPztGoC/yXMQQqDMBCF4avIrDsQBw3Vq5QuYpzolDaVjC2Ce
 HejLj8e719BOQkrtMUKif+i8o0Z5a0AP7o4MEqfDWTImoYqdL3HIAuq+0xviQPWZIMJZO/UdJB
 vU+K8n8nH87L+uhf7+ejAtu0XGMImdAAAAA==
X-Change-ID: 20260924-adc-fix-sampling-526f0f26829b
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Cheick Traore
	<cheick.traore-ext@st.com>, <stable@vger.kernel.org>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052D:EE_|PA2PR10MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bc4608-af7b-4de0-14b2-08df1a21c4dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|36860700016|82310400026|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	gWyDCwmET2vvI4tuvzdwHo9JGFdgHcJtZQRmBjXjt1tYhj4RGOjGQpiJ7Zlq8LxjodVjM6e10Ed4OkUfnJloxs1MUUjvY2Z1ZFIHuppcUQ/iXSU7RPcKbU1rRnReRBidzt3ROuRbQtRY9Dc1OVVSEqwPGttBBI1tdrbPsUpg1pJU63H1ImtdLhMy8CrAY+tsfJZcHF2oEokVvnzJCgUYa0YhQX7OJ2teK2TG701OzBmPKGPw8EUnqHtw+AcooJm82aHCWegpQbB/cfLk5ZhBnmQtTdVeWfiHQa61qn2pPzABse8DwRURfzMrz0todyauDQgoUsw5BIOEcHAoI8jX6DaqNTddenrLqdWscPShQ94HxGmGR4EBvz2if/dCOo3gcUk68pup9Cbnw+/TGiz/0EIexuUP7x557rnsOD+eeabrVgsIeZux5qbSsRrtKsfXFh4YUsZ0JU+KpXQ3rQ5tVC10vYIAf6IFQ+qeJNccYwr2YqRjtmYRj2z03T9MRLG7ODZtINiPia2C8AX5tx3lO1xqOOuh0GeH0WQ8cYlXtXIrG7gp+C2YcfIs/nPgyoIeAkIPCQsFLx43tZipa0r/wRnq2SYCxiW/TtzdiF+j+qXYBnraEEUm7HkUJU71BLovHAcK6eN6k7gjdd1MxLXXTzKFYxDjk0ewhQf0+Y+G6v+FNfuGke0kY1obYdHXMAQJRwX0T6aa2fHqYDh16c0zxw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SJ4Z4VW7IjoSGIW0kRsaw5jWgmQh48mrKZwcoZHOI+5wnRTEj6Yi20jNwoDoziy/CZKIShDT6eICn8ezF5gXKxj7YDwu0o9IMf31KU56NE7pQFwMS/P7fecAVl6+Vv3qJB6xlPCFUuSiE590VmT/E2Mn2tnBZ65dXNzUEPA2ZnQhzN8V0Vue7wdLvJkG/2wTJJCVkJONk9XmaGhVquqGunO5VQWESgNoeOJ9BdEQRO9+p1/8wK6/v9lxKzhiW/UebcpMeXj/HFj/wLxr8BZOgMYLeRd9EIa7e/IN7GpBgPxwbWRfYathcLtURgVj7pBqKxYaEg/sjQgA/FraFxI1UBGkMKI3u1fdaBXvHkfoK480nNMrI0jofxC61EkjCJa1dCbIO6p5O+ncN+t2+Ab5vSW12CqISYyP+mNSP9u1XdjSiS719SqGXvLsGUN4aLGB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:54:04.8007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bc4608-af7b-4de0-14b2-08df1a21c4dc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8751

From: Cheick Traore <cheick.traore-ext@st.com>

- On stm32mp15: vddcpu and vddq_ddr are not connected to internal
channel, so their sampling time shouldn't be set.

- On stm32mp13: vddcpu and vddq_ddr are connected to internal channels
and the value for vddcore was not correct. Values from the datasheet
are 1us (e.g. 1000ns) for ts_vddcore, ts_vddcpu and ts_vddq_ddr.

Fixes: 7cb2303dd024 ("iio: adc: stm32: manage min sampling time on all internal channels")
Cc: stable@vger.kernel.org
Signed-off-by: Cheick Traore <cheick.traore-ext@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 90f0e257e6d1..b024326775ae 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2734,7 +2734,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.set_ovs = stm32h7_adc_set_ovs,
 };
 
-static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
+static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 0, 0, 4300, 9800 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp1) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
@@ -2756,7 +2756,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.set_ovs = stm32h7_adc_set_ovs,
 };
 
-static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
+static const unsigned int stm32_adc_min_ts_mp13[] = { 1000, 1000, 1000, 4300, 9800 };
 static_assert(ARRAY_SIZE(stm32_adc_min_ts_mp13) == STM32_ADC_INT_CH_NB);
 
 static const struct stm32_adc_cfg stm32mp13_adc_cfg = {

---
base-commit: 182c47735554925da9605dc9dd90a8c15a1bbae5
change-id: 20260924-adc-fix-sampling-526f0f26829b

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

