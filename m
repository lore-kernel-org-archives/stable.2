Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.117
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794013820;
	b=cx6hGLCSkpnRcEDqne7hLRb7jY8/P7VnaHMffayS4n+GKEkZuhfsXp1i36SCsivi8b+8
	 Bm8wfUfOURR/VoJt9tz7tzAKWDVN8XAavSTeGZYdp+JHMTneBEWRSJI/NGdXhZFom6FNe
	 6yOpY8HvcFr3q9lo++iq/x/AzciXJIBlRRjp69Hq2PGEynMsRAuAIJtZu/JkI2+GadNw8
	 XtI7thMPgxMQ6r7XKU1ihXG/UYsrIkeSBu0ovHMixpBYQddapBWtrHB6WhYnTNXlYSAN6
	 nCb4YacKyKR5ue9wcnNX4ghF62sOJiK6RFyGnwPMmhXMMHffw3/84X0OlznsDma0nKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013820;
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
	b=rz754zU3nQiyPSFJv8IjwkE33Aj+CiljGSgI232VHRV8HaPF1cUAuPFliOtUug5cOZ8g
	 w4zVKNXFkkPIbNY2qvP7DnVpxlVNAowM1QX/8Eqbc/15ftHIbIcESekvuYM091GFw4+Qu
	 aOWrBulf+raHnz3pI9bG+jrt9j9Fh1EJMaSgKkOO5X7gBTZ6zBFXxtO+0hJt2eMTN2X15
	 e6mb0XZ86HM6gUYMN+xSQzCWxr/Rab5LXHQMcfZ99DhRxBmJnZLksr67UJmvD5xup0xQG
	 xNF1WDdiAodD256v7Sf9FhfcOScA/uxlwcZUspIT1i/Hz+4wnVqdw5mDxgLLpU1tAlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.117
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023117.outbound.protection.outlook.com [52.101.127.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41F606A32F;
	Sat,  7 Nov 2026 01:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD41F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BhGnnyi7xacB6tCA95mljpvd3umOVUQklP/N4sFjADPOJkwRmoZV69OquGXJNPufDxCrBPhxuXEms1PhofwCq0JzJrp2/3WWHq/Lb3gY5RtlyjK9t4zcSI2Xu1d5ZCp5R8bzGHR8gt/mipcgDrB9o+S0S3KGpRkLuLzoNXnN0x/Sn1w1AVvl1stz/vUlzVG+raKCz+x82OUepuFL7ZJ9KIPzIeaLhyh7VTEIAye7GOWxjtmoJidxmcSY4xAcB92WxaEyQ+rfaahi0i+bEG7BT8EiYJk7QylkQem8vVQQF0DM329SJTmbPNOB+bTACNnnPR5wX+wrouztN83jCFmk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF1NbnWux934O0IIsujFl9xGbyeeKPnw5llJQ+nZFxA=;
 b=Fz9YMC/c21nn1mLUbMcU4aUetbZIDgbo5wa00Ho2gfpKI4u06lk2KFHX/sjfmqQQrlUOpB9F52rSYLnfABa68vQadeHah6fyDlGs8e//9vYQEA0FruQ1NinFPXhm1BsP1pkBqfD8sI9oN2K64yZXRzdSImOydWfdKnvWJb6EnNPTNdqEaeFVNDAvg6CGBTTiCC54mJHrtMywVLWhtpZvvciy48SyK6AOX/helD4YI5qDC8qyRcNdVaXAXp3l60zF9h3qoP6U+65BJhKcPiXyZhpBTlvPIIWVEWgLc4L9kzenfALBhq/GcbtSjpmkOVU3aIMSZY5FTMu9GyjopLY5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::32) by KL1PR0601MB5535.apcprd06.prod.outlook.com
 (2603:1096:820:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Sat, 7 Nov 2026
 01:10:14 +0000
Received: from TY2PEPF0000AB85.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::f) by PS2PR01CA0044.outlook.office365.com
 (2603:1096:300:58::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 01:10:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB85.mail.protection.outlook.com (10.167.253.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 01:10:13 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.55])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 10BF040920E2;
	Sat,  7 Nov 2026 09:10:13 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	gary.yang@cixtech.com,
	stable@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: cix: fix I2C bus address and size cells on Sky1
Date: Sat,  7 Nov 2026 09:10:11 +0800
Message-ID: <20261107011012.3655873-4-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261107011012.3655873-1-gary.yang@cixtech.com>
References: <20261107011012.3655873-1-gary.yang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB85:EE_|KL1PR0601MB5535:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11a8199d-be37-42cd-d45a-08df3c6be0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|22082099003|18002099003|6133799003|10067099003|261026121527099003|261102123227099003|56012099006|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	0+OwgyFN256T6wMqvJ5k8i04yBHNQWLSWXcaNMc49dTolqKKbok/W5rG4CHJTb5Hdy1C5kx5z+vjf6fh1UiUuRZSioJe2DUb8WJPRxjjCsZB41DsjI/uQWaWv0MyKt+FuhEonAyCFr8cPB4Md7WY+l87ItPFxGpEjoROhSJFY4TQusYdOhl1+Pu4Nwl/c+4jnteIKik080quKNaMVMbt2I6hs2rQtYWIgNYmalhs74/i4IlAP8NPE6Q52+R49jDPrn4WD2lf89HZYBW9yr5D5hNR+6yWRSOEcmaxlyV2q6g6Gq8pZh1n5XP4rNTeJFgw+51rz3DHeF8ejlSiSlYmPZ3M308HiQ7vidwdzEA79VDo0Dj26KYNdyZrugR0JcoDbU8XsCUzdWD4HIzkq5oYGTAl3/0BHf+K8RTFJyckLhaGEbntzM3px1AgzxTU+FtrVvCwHe/BfWaRB9paGPW6qTQqdHdqb2wIpjNTqMJYiL9W8Zio5WMlS6ZszKxpCASofGxL6tDyxzkZPb1VWJVLc+eU1Th8e3FNlYpWSNqYkYQm09LGQEHaMnXgNwTEB3o1KnNBIXqg7tIeG37/jEV8xVlaaKbOCjVQ9clEr97MlxtOiVOt2c/cLowl4TJ5K4YLjdhAtolD99th5djAErjow2UsnKZWNBn3CsM7boUesYtJjoh3Oygzg6xKaua4k0w+
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(10067099003)(261026121527099003)(261102123227099003)(56012099006)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WvKJ6g1mVigJE1y1i+30pgYQbfGC5NsKZMqqxxksgnbz8jH0GleWnmHODtAEUB9WxmcGXvcnu6vvnf0VOcqtPyEh1HOZ8lK5+oFZwuLyA4nLBamp854otRWHz84A6fz1wFCB7JYdLXBDZcikKfL83+lGOqnhg7cxx+HnM4DdbLkCXB7rJ+/6XMnWLQqHVHNepMWGyMnY3pgnN6xdwAKgzuT23oOnxkTbB+psZjFJXroOqZ2ruvQERdNw93duGUBJ+GJ83BKePiLQKglfS+EFLxvzTYIT90V/AAYMu9414pSYlfQMqwGpdcNYJ/JNQWXr+MkL+VSh/wAXB3oyXcOOtUNmGDjts47edFsipXlvDI93yQPD8a2pG+rhoCdIxPMZgiVzijqMWEnU9+5rhlem/Hxsp2j/bygn45rCxPsSB0Jo8JMQtPO36yUovr6rAOV1
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 01:10:13.8986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a8199d-be37-42cd-d45a-08df3c6be0d3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB85.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5535

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

