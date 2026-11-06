Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.76
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793928362;
	b=jaEVEVxm7ZqpyvArbCX0AEVbt+f8R8u8TtNj9IuYq8iO6SJ3Z8xdiRHM1Yo6uENI3xqI
	 myhu6VoexbUutokGhuaEURkz2CZMYGG/TPXnlnARRTWfdoN8E0Tv6iF1e5slrmDKAXidi
	 UzpWX105Lf56q78WQRKkI/9Jfcaicjuo7QW42Fo/6kBL/hGJAx2BXBsvAC46W1yj9/UZ6
	 ayZEgLxeGduvHHLR44vtKMhjUwSTUnsiHHOu+yB1u+VecM3p5uQVv981b0o9darnPbjyS
	 T1hYSAzXsp55e2c97ytrOEVuDsio5ohuzD/Aoh3HsKLYoGOIERt0zBu/iLecvANbNjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928362;
	h=DMARC-Filter:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nF1NbnWux934O0IIsujFl9xGbyeeKPnw5llJQ+nZFxA=;
	b=kIZKe5x3Ktr3qpB0IRpnp8/fR+IrgCvBwUy0sxsqp4Z6mw2bNQ9HHOS1iE4zTjpiHvFx
	 /0Qiohz/afZIJilxU0E6rlE1NeV7aLDxZoFzDpDmker1wQWSpRPHxSWhp2kbFQIJY8Smp
	 49jqhdfd68wtkiPSiXiY+nOEyIGHHxHrUr0jQ6dRI6JodvoVxT5QXLaUkjbpFB4yMN9aa
	 afvPCxzMdekRSGfksnngNX1AQuNQO6SG9jgDKqyJS76N4zlV4PZ9bGyO3jYAzGnqIeaOw
	 ZMb6LDOsjQYdGYDSubAgzcph7pkMHKjS23u33+w5Oqg/xJiMcFYsV3ZB3eGIb6M73Fg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.44.76
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023076.outbound.protection.outlook.com [40.107.44.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016E606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 01:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4016E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTLD2pLqU93a5+qhQnWQvctngWqsTeDWx11LJrA+wu54ZQ3pqgqI775ibkM0YEsQPi2K/JpROMtUL9AUiPojaakwl60ECRhoCF3d8HRAvPKON6jnWUJV0J+AeAm7UjVkQ2uVNyvEcwr3SrjxKo2gG0ivNuZfbrc8EWeN6TDolnpPhYP8EvthVpFR+axAOgQxPHLt9G29ewmG9XJQL/Yxwe1kVhk6xWgUSWZEi0U60LG9NZwTHooFwbCG1902CyZ5NObgvyv8dJcs+8H80Lhcnr/B3FIpcE9Rb1DN42lmTxn/jYyoWSCrUDwfTC04bc5zTSFteSN2upCvHW8lVtfGdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF1NbnWux934O0IIsujFl9xGbyeeKPnw5llJQ+nZFxA=;
 b=u4pUDJt/zT4czaeuCnmJkm82dx5xNa3N6j2ShoJ1wsD4gVXx0y6c61Io16gKRZkD4LVAqvZFaOK+VP2x8mL9zwb8orwwCJEGDnMqHPV5q0YFvs94UDPLu/dKtNTsR35NUCxHVqqQv1mP4VZXD13OTYMqQscUfKVor20unizUG/CG8B3t+Z8xsggq3sHQum717O7JRmTIyAgw/oHJTTFwX28DNvnRoMzUIu+FAH89a0eFYQOGzkSd5YLt20FWzH9NHDbBhpvIGAlVvbpR/9TNDX6c1j4p5dQuZt8noxEvp8RmzHsmjAtWAJIqmj6PtzkVB/PWp0W0HspFFDHqIDuRxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4P301CA0093.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:37a::11)
 by SE3PR06MB8499.apcprd06.prod.outlook.com (2603:1096:101:335::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 01:25:56 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:405:37a:cafe::24) by TY4P301CA0093.outlook.office365.com
 (2603:1096:405:37a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 01:25:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 01:25:55 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.55])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C406D40920E2;
	Fri,  6 Nov 2026 09:25:54 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: Fugang Duan <fugang.duan@cixtech.com>
Cc: CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: cix: fix I2C bus address and size cells on Sky1
Date: Fri,  6 Nov 2026 09:25:53 +0800
Message-ID: <20261106012554.3394587-4-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261106012554.3394587-1-gary.yang@cixtech.com>
References: <20261106012554.3394587-1-gary.yang@cixtech.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|SE3PR06MB8499:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 78ac9ab8-c4b2-448f-3c0d-08df3ba4e7ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|18002099003|22082099003|10067099003|261102123227099003|56012099006|261026121527099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	YgYsxbrbWBFvI5UcQzoFUjZsfLf5ngaWy/snalMoh5MarXr67BTtXQeeI0OP3L2ReXqLcill7NLnApbc7tiOrAPVWIQuXBJNP+CmLOfDd5mx5GhrnmZLzHsPo99dsaHINxv58WabMOpMpOJq+O4W7SHdZ+BIqpfbVHcoZ5xHldV84X5DWFN47HKOztOLXew8SS3oRWbJSVA4lO/si7MWmDDAUHHOYuZUk8yOGB97c//Rxput6GJLTiDxbs+WIu44DGmQZn/HHsBd+4UkhbkU1bTRwFnT+wP+mUdmITR3RFTf/Ko4V3hYiLT6pb1xvyEjhjKtAyfAP77NflMPafmA0gehhwWrl6sKKQ2NP5gYxgjMiSr+ljLSSpGVIZq8wV95/u2EuePcOCvjkRsZTYbJsajeW9gfMSL5gQE24xn5wxzSY7D9fWs5dVjtKjffHRVvCUL3teHZ9Y2WAPX02F6XZyWcAEszbYSwzPcNfcyXOaKNAe38qWrJg3nzACg9GlRRHAoHV9ZDlu3Vvp2q6H851NwxrHt4Souh5dLT/4VThfCc0VlmkZNWOzI6phtffWO69M9JkVhZ9YhGrwQaoD66VXH30bwYq+tqPTvRLZMQTctTKns6UjBU20PlNm4uc942P64xuC/r/NJXYgVFQXI+6w/ICLQ5f8XH27RuJq6Fx3QHzD+zcyozO0R1jiIkKdrj
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(261102123227099003)(56012099006)(261026121527099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SIO51e+6nAjMqPCMDBFDc/QDd+RmFnupZDeKs+2YJHhmZ4BF3gF8558cvMPckaPrp8eXTtuVwmTM+nJirPZQslGu2PagT6FRE4SPWO82VjmOFJkHHmkA6aEF3TNvUcJBH3NQqckI9irwskzo3J3W1ZjU1qt42/5tu3qiI4oeE4+VyQwzCURhkvVGt9caD6KYNSHy2NhIJAwXOp4visymF8O5iHwbNAOtO+RO7u4eZYm3Rbe82wgBknnP8uy/Wtq0T3Y3igIL7LT95E0XQDrWJi6jQSu2St52V0c7zAHKuW9/NUr7kZ87F5mIxqsMB/35YKxudstIM81jDVkoHdocSly2UOJ650sPnybA/yEzFwG6ag+C4weQ9m6ujWn4osZCKcygKSgxuJzc6VV1vu0V+QZ/UaLPLz8dddICcmJChb2D9dfGD2J1xWZJS7ob0fBJ
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 01:25:55.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ac9ab8-c4b2-448f-3c0d-08df3ba4e7ce
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8499

The I2C controller nodes inherit #address-cells = <2> and #size-cells
= <2> from the soc@0 bus, but I2C child devices always use a
single-cell address and no size. With the inherited values every
child node triggers a reg_format warning, and a device described on
the bus would be decoded with the wrong address layout.

Set #address-cells = <1> and #size-cells = <0> on all eight I2C
controllers, matching the I3C nodes that already do so.

Fixes: fad32e8ac460 ("arm64: dts: cix: add DT nodes for all I2C and I3C ports for sky1")
Cc: stable@vger.kernel.org
Signed-off-by: Gary Yang <gary.yang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 0a820f45feb9..a18e8fd43fcf 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -290,6 +290,8 @@ soc@0 {
 		i2c0: i2c@4010000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04010000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C0_APB>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -299,6 +301,8 @@ i2c0: i2c@4010000 {
 		i2c1: i2c@4020000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04020000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C1_APB>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -308,6 +312,8 @@ i2c1: i2c@4020000 {
 		i2c2: i2c@4030000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04030000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C2_APB>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -317,6 +323,8 @@ i2c2: i2c@4030000 {
 		i2c3: i2c@4040000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04040000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C3_APB>;
 			interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -326,6 +334,8 @@ i2c3: i2c@4040000 {
 		i2c4: i2c@4050000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04050000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C4_APB>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -335,6 +345,8 @@ i2c4: i2c@4050000 {
 		i2c5: i2c@4060000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04060000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C5_APB>;
 			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -344,6 +356,8 @@ i2c5: i2c@4060000 {
 		i2c6: i2c@4070000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04070000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C6_APB>;
 			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -353,6 +367,8 @@ i2c6: i2c@4070000 {
 		i2c7: i2c@4080000 {
 			compatible = "cdns,i2c-r1p14";
 			reg = <0x0 0x04080000 0x0 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			clock-frequency = <400000>;
 			clocks = <&scmi_clk CLK_TREE_FCH_I2C7_APB>;
 			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.50.1

