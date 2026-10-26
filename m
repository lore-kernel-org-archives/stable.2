Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793014573;
	b=21B9GdTE0u6KuhEFSpc1ME68Kg0EdXSn7Zt8KiMxXuPWWi0tKksa+CQ7NfHyJWQ3YmWj
	 FpEzXNVBIdzMPz6DVwAD/x3m0pdWIVsy32cFsMqm8QqI0amBRJ7YgpI1pSeQa2qPw8Mqz
	 6LKYSNOzmDT1Uc7dY3o2fRS7jUegsW9di762Gd6tKSRyW/pllJIW/UJW3PlOGGjlwyWrK
	 up1CP3ZmGi9bSR/ea6f4rLitdHIPlhXHCVyR0GIUIrlGdYOU9/YdUR5W83A9ATEomGEP1
	 qQMHGs+z/Y2A3ye+CK4i+FLxqJCAr3G2+o2R0fS+ce472LHkwNlLVc2KoAjOX0cSKBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014573;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=0nJ9Xo0tKPcGSX2LTigL66vBx7r5awwDRUPvAwJr8bA=;
	b=u9NTgFPfRszi46HsI63GchzmZAPwal7K+BIc4BRtQkA2en2AatR8KLHE2wXvuP7QsfqS
	 ALdPSTP+He4pP9qNSVcPOJ6zyLy5xQUa29gY3VWVZHxzf/JN/tamZPo3ZBnyZ63llK4Zh
	 Y1E72Q6NhUtzl7OXbEl1pwc96nRZ/IXvuEr51LivYcYVAYtN2fWkmxiM5+DOqc4Add+QI
	 ODIJD8ofIy0fySuWaNjsnQpo/4R8rhrlLpjTXUmscQEmIxRTYJYpB3XUydNaN9XhwiLGb
	 EOsywZtIYFN05B0bJrTg/bqaw7x83Y0ZvFsghTtvz2irD4Gp9UxyGhoROS8DsS4FYeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=EtSwW7NQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.41
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011041.outbound.protection.outlook.com [40.107.74.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FCB606A31E;
	Mon, 26 Oct 2026 11:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99FCB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=EtSwW7NQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS/xywMls58h7RoY+RkWl98ReAvz+wox44RHGVc9qzLa1k+lKXP8Khxgodq7usANLjJZe5JEKkNkLz1GzlmcRQMb0MfRTX1/leZxNAXbnAgFwkTcVf6RY/Ml0luBysgDHRUs7pI6jttXwktR3fAeaA45D8nH7n6lEujh5RKUreVsEWhrvK8KSCM2bZRblfB7z/CVzpQff6I0FC8epc48o3rlzs70uVisWwkslR4N8IXh2/qhlc4qZ5rh1QnLX4RuAHkibMmFXASLpfUzup9UHCsj474YtsnoblO9m8ayV/mNZ6rWni7mcgGRuTPD5Tp12sH3Xhlc6E+Td9T8hqia9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nJ9Xo0tKPcGSX2LTigL66vBx7r5awwDRUPvAwJr8bA=;
 b=eyWEFv7PCjv6CgW+v+u9PfDCnYb4JVXqpCZ1mHtvi6/d2j/Jvnnl/UbOH2Tec/0ml4e2zrRX6P8wGXpLRH46sWn2KEdPdR536k96Al2RKq3ZShEvyj9PR+mLknTBM9YN7XyszVVes5+7eZbfftYXAL41uqMmKrHDn1QHOMWTL/MqVQpIi4BdnUjO62DomkGoDTyoT3C39G9ecx9eCaGPkNMCtuXyHQVzHcF7yD1SZem/e9jUndyM7ADwA6p6fKNIXktPdTlFBpw5GoqEQdY6k1qIPg/SQbrx8dl3b7GkBWs5AdmCm4n0y6JUHW7uryyNhVSzoYn20zXjwh5WjCmW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nJ9Xo0tKPcGSX2LTigL66vBx7r5awwDRUPvAwJr8bA=;
 b=EtSwW7NQOuZQSPf3Oh+T7gW7tDXJY/oZQUmgWv+YwHEXPAlaQyWKseWKRfQtPJW9Z6HAfb0cVoip+qKkqOxvboqyjce9O+Br/3tBVHBgPsaVTASGD4HJbxpgix6kLBZ1/4Kp93mVYmyj9APBX7tN2aml8uq3XwOra/aWduBaokI=
Received: from TY4P286CA0037.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::11)
 by OS9PR01MB17271.jpnprd01.prod.outlook.com (2603:1096:604:407::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:36:08 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2:cafe::c) by TY4P286CA0037.outlook.office365.com
 (2603:1096:405:2b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 11:36:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Mon, 26 Oct 2026 11:36:08 +0000
Received: from [192.168.1.82] (unknown [10.226.92.223])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 88CE13000253;
	Mon, 26 Oct 2026 20:35:58 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Mon, 26 Oct 2026 11:35:44 +0000
Subject: [PATCH v2 1/7] i3c: renesas: Fix zero I2C SCL rate on pure I3C
 buses
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-1-2e76b87209bb@renesas.com>
References: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
In-Reply-To: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793014549; l=1865;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=6HxA+XnsBL9jy7oF3Oo6QfrXrV8psXZqBU5i5dauPmA=;
 b=pjfqeDb6tMsB+wMuLb4meN1z0nRflzaXKLsduVBX5nR7ONqro7Nq3Tt+yjC7hlXsKfyQ60uOe
 3vpTjH9w64UC1poxHafjtnWnvyFnt6sHFmaI2SKp0BuQ/KgpN4oOWeI
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|OS9PR01MB17271:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3f79cf-31f6-40cb-2c59-08df33555404
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|23010399003|1800799024|921020|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261009221227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5xZjo2MdwoXQ8zqsQ4i2nXGpk/Zeu26dxStWIYGZaWpq9nMtdE0yVBnjH4qbN8X5LOE0m+wOIVIFtHTEuOGzgaUqIlzdtERBAswR3ufmDfROPKG2b4ZJbE6tCzS2WKqkiH5ioj9sdRHpSbGnHIw3DW7PABruLQgqsUpV7ZweP0fIiS0LLHHgZLpGUyZG6BAzUEurgJvxkHUUHs6VWDTEHrX6dMvg5+xKjSES4TB4bcYwO2j73mn3R2x75T8HXL1C8Ud6xxgQeojQmt6jq2+i1qtyxJnetP8vljlYfazIWLhGewkLH+H82D3SYkXjpEzyAdmIAfRMJRB8mc7QzL/hrgDs/hpuHW/XpZtUIWe5/WQ7GiDCX6KJOHjXQFiJABVQ2QEOw3ACC2DxamhnU2xPieka6bWhydWAPj3Co4Ql4ArYhi83mrrO5OmkoxW2G3d3z+KYGJwyBN/IhNE1wzVxzgcMbFKUkD7l4U8PPawHp/ebm8uM0RLgniJ9chjUZfZ9IToZmTlSM+4vBLYxJzZzjsTT4JUOHarnZ17D9kzxcl4GdjULqE16xmG/Z3fyWW1Q8toioiVlosDmDjstKZuYKeiUGNu9a5wEyubslPAnXdgSkFeCbYsO6CTt3cd5dRxf/9m5x0rry2mwhMd1WMkDXXPz+xLMPacFMPqFsY2WoDu9WzUYmJBiSvDT48mXsAHqQAhPr5k8wuicGlxRtpKgYnpQF+7bVSCh6YUgWX012iu6NZSgzx7F7dcLOwQKfs7m
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	792MDJYecFHeO0h580niBNouGmtA6On3IKNkOQtjLhzqb9oqYjZs8ANyhek2cMJEC0N72uMCQrUY1SIrfhWjh0Z9yKD/IsQOqzwTfOLQMkbzObiDrjxY+YsUlTZBH21tAbZtL+DKsNUZilOyKasFxhicb8hMehpVISwd4oLy/mUUhWHKF9qS7REKpus0zcQmZvMCxCtSgr6QEP9bE9h5qdFu/sWFhN2UdF1vko1V7eSIXzSAGNQEteebPwNaQjJ5aLebc6bmZez1JPJFKIZqjeg7U/LvHtQcbq91iw4vTKFg4GhBzI5fuNlzf3l8ONd1jkqv+JzpUN4TXPbfQG4hn+R3aWAyNIl4zY+RBqCkSUlA3Mrowsge6VeArV1SVz/oAzTDR+De6whq/RQioSuoP2r5zRjEZCbsy3bi/x/ctkZZYqkLbyGtb0aFytXf1UGK
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:36:08.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3f79cf-31f6-40cb-2c59-08df33555404
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17271

On a pure I3C bus there are no I2C devices, so the I3C core leaves
bus->scl_rate.i2c at zero if i2c-scl-hz is not specified in DT.
Deriving i2c_total_ticks from that zero rate programs a zero-width
open-drain SCL into the STDBR open-drain fields, which are still used
in pure I3C mode for example in DAA.

Fall back to the 1 MHz FM+ limit instead, the fastest rate an I2C
device could have, so that a sane open-drain timing is programmed.

Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C controller")
Cc: stable@vger.kernel.org
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
Changes in v2:
 - Substituted if/else with ternary operator
 - Picked up R-b from Wolfram Sang
---
 drivers/i3c/master/renesas-i3c.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index 8b264f72e55c..78d0a2c4a19e 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -579,7 +579,15 @@ static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 	if (!i3c->rate)
 		return -EINVAL;
 
-	i2c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i2c);
+	/*
+	 * A pure I3C bus has no I2C devices, so the I3C core leaves
+	 * scl_rate.i2c at zero if not explicitly defined in DT. The
+	 * open-drain SCL fields of STDBR, which are used for the DAA
+	 * pending read, are derived from it though, so fall back to
+	 * the 1 MHz FM+ limit instead of programming a zero-width clock.
+	 */
+	i2c_total_ticks = DIV_ROUND_UP(i3c->rate,
+				       bus->scl_rate.i2c ?: I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE);
 	i3c_total_ticks = DIV_ROUND_UP(i3c->rate, bus->scl_rate.i3c);
 
 	i2c_parse_fw_timings(&m->dev, &t, true);

-- 
2.56.0

