Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793877342;
	b=C+Da12N7sVs3HPl8tq8hVAo1KRz5/GOt4NvIjHhKLTjI9FvCJcBcmd7K9ZCPesce+TKM
	 rTbzoCO6Y8ByfcABHIhAr0gyRZKLkyyxEGa21gfxfziWSKwm7OJsojnW0RCfiyO/9SbU1
	 2Q7mZHdLQcCU4dmN33GHC/nZCKvevOwbIJ+xbancGlENmO8ZTllDN69H/ziqTOsyCUb+t
	 VAJ++xtHZmlSC8FSoO++pzA4QEakYIPMFKNx+wrDstUR65cUHP/3bUn+20q7+gx65y5eR
	 xIFO3RlfkqLWFXWQvfv8Pz7h5/fa5T+zEzPC3emPmBNWo6XiB1iw9R2q8xN6liH4rng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877342;
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
	b=U9Rcp+HLUL/XqayKRWiT32M8GkWtAoW673CxjkwjskRWwcZyGjsLyM41ufFC/zBiT8OG
	 Y8yayCuDmOZGqoLt1NEsZhEA9MW1HUcRziKfgmyBD2a7eojZ5YIH09vlE9xo5KQhfJqbA
	 PgsYNlk29fjzuDR4HSjVp8UJU8VoEtKKRTi1H3a0Yg+a/mH3yvq+kceSwiqIoC55rjbLf
	 BkIAGbhBXGo6C9EnSggIwLCY8QCTdWvdKcYzEsFYqpCVNyUmWFQXPMMohUpEXnZhEKXMq
	 7LyOxQCR1yVyfbuGvgSGDkPDLDcPandqooZC8oX6GIQOBvG6d4l5i3qcj935JCjrW8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.138
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022138.outbound.protection.outlook.com [40.107.75.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D3606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 11:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D89D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3PJH8nmpNuY1hryyEI0UwAWUQHIkOx0pDUzGMvSIOVzS2OoaxAWIulIkJxEZ/CLLZFmeaR8eGGK8TpN6n5y6XE5xZMoMJwRZviAT4MHkPHJYN9avvYd6p2j7gEsjKdtMt2gcj8xtkWSyNXqZmWfX+6C7yML6FA4ae35+dwY4YW16lJz0jolfCUJBxvOU7Ce0GI2ix/7xyqBHJV9S8vU0QJeGpS8OKSU/J7I8IhSKki8uQn3GJlje3HlWkpmcZnMSmQh4m4LZgeHAqNjK8yspb8hAoqZbZjX13kr7BGyUQsYamAyycVHpezks7kr5XmUzB+1B1aGHS33sFvDPm+wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF1NbnWux934O0IIsujFl9xGbyeeKPnw5llJQ+nZFxA=;
 b=PVmfXnvdLXIbISGsSaWdi1Qhkcg1+oMdC5mh/7+/59wW50Trrbwaxgtj3M2NN8DRWfDxE10OTfmJXGxELoHla1jkZGyCyeSxStys3yaTM9k3ApRkqBxNsCIiOA2W1xlsBx/cMhluNuh84rt78afIa67O0r3v5dbBPS7DrIEmQU8eQKDKFYVS4JSIJxEyG0XAsDAsUiXrDCvLvdY69OVMBiVaNAw/PBLdvOAD4veAod0IFGDGoSwlFdtb5iMPJ18x3d6iQlce4L+eFA+Q01UcZ0YeF0q0VlRRVKO+tHe3o7RPyegqCBnhxdPILUzUdASeDuiEeq6UzVYXY3Btnw7YWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0015.apcprd02.prod.outlook.com (2603:1096:4:1f7::18)
 by TY0PR06MB5458.apcprd06.prod.outlook.com (2603:1096:400:329::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 11:15:37 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:1f7:cafe::9d) by SI1PR02CA0015.outlook.office365.com
 (2603:1096:4:1f7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:15:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 11:15:35 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.55])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id C431F40920E2;
	Thu,  5 Nov 2026 19:15:34 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: Fugang Duan <fugang.duan@cixtech.com>
Cc: CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: cix: fix I2C bus address and size cells on Sky1
Date: Thu,  5 Nov 2026 19:15:33 +0800
Message-ID: <20261105111534.3290756-4-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261105111534.3290756-1-gary.yang@cixtech.com>
References: <20261105111534.3290756-1-gary.yang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TY0PR06MB5458:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c9b168a9-8931-4dce-16ca-08df3b2e1da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|56012099006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	8leWPw2tOXdlYsd1VFbrK3XJIz7AZ8kGeYmfg7SOf6tc2/LZWz8DlrgVgbrWWWIm/RZWA8fXmBYd2AX6T3smCjpwnhSWx4s/TE+V5nZaycajmouSyUF5vaQqxBA++5GJvKvw4XFYonvY6b+mnwwJjSmWCwRo7Rk+ZV4kk+IWyJ/70POLwyvJqcGDQloZZmwWsanyZ5q7hmZ1+CTIgjWcdF2OLJkRjdX2l37aWUcLQBT4TTqKJTuydOOHUMz//7iaLVNdWNZEHiQbyC4D8O9toQRQ7rUk47vE+iZ8sycUkfH+LwKIPhwyhGcbqZ5sEkPUzrLKAPz1qsQp/yul8A6yYLCEckeIaKVQ8gI8en59lzWy8CyQD+R0QjhefxinPTrpru3nK49f2vFvW8LxNMT5txJOVnBLBVfp0Kcv58vHH6165L5GmB1VcjkhudcQzoqzfsyolVl6mZg9hhXLUJ9XaLK5f1MVoGnhU44Mn7KrfqA0EZ+BDlyc9Nt/CulbsFkk9//lLYpEKBmG0MiGfVFGzE8mmPz5UsMMGBfiNE+gQb1Mt46WmQ4V/C7AfwrqSTHM/MQEFt/OvawDjUbqMYLgQO0Ix05zI3N2J9Ch21sPKrTgYlIF72oGz3+1/rnAzg6a4We2hMaCVl+COSN6MD5a1apCPFKDXlu+emJH5JHuoAs6iyJuwh11oxUEQl/N+0fO
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lGsRwv4vuKYA/Bl7xPH7/Qirm+t5zB9B59DDyoXRJbAgdySidlD9G2tYVh3BMIDxC5An3bqVQ0nrSDm6Bt8JapFHKXQHgCDMSxaZ84MaY+wsHuCy7yRe9f9H8hNI2UbjXVokHDfe7lAFScNZg2FJUYrJELAKStmKwkzT64sRcn95yJ3oMlDndZZnY7rp2iSrwnsXjjLKJombAsy/nBpbc9Bi7fkKWOKwmlTNkVLRasu5SGejlYhBDt0Zfa9J/vIW4PQvO9ojpLoligQv7x1ahgJHnt9ftqD8C9t4906cdYRk7kYX8dwdxQ6/o1VuDIdZG8OKEX8iC7uzU0tGZt8nomrMguhWsX0YmDsUrB+kqKnJpRpbAF93hBvR6KLzmV3KIvri34G0A7PfY6ZNrWrrgK9BIKTXnFGZhWI8ZmgWHuOIfxiBkVfJ1S0dW7sNGPqA
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:15:35.9920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b168a9-8931-4dce-16ca-08df3b2e1da2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5458

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

