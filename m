Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.115
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793769062;
	b=ILI0Z7RRZSW/mzeZb4uMkfXFsSxZgsds8AVv8gUEBeKVDf+24TKzJllaXfJMd2BAfjkB
	 XHIhK9SclNVEKzcXJSa91Ejqw2OH1+RwR4mv5RTbvI7AC/yM7pFNUmtyOtKlRXZrke746
	 qXoC2tA9LGQzEcUuQpQXs0B0psfw4sNX+eGXJwPHzzk8bFViNTkORwnRX3V9tXp9S/HRW
	 KvAX5qcsYYuzv2aLQqjEvQN5YTIFWkz75lfpkqpqa1DGZntgP18lTYJG2YBctH6i1w39z
	 MdUKz4wsZcftyVKY51OmtmtAdvLip8wOGydvBt40kku31cRjZp11UoaaBDeRKjxewDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769062;
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
	b=JZLDdY2bJPi3QRF7ZOgUBdqSYcUHSdEiHMn7SDdW6tXT214dI/wC0gDwyIphua4GU8/y
	 YjbTDyGAtfrUjJgVeGvuXX4GDpn0g9CMoG92GpYSO80wYELdhbpf6fSE5qAOI4nC1V0SA
	 I/wJlGXzfMsj+R1GhtlKoSJOpCFRoWVUHiQXVMD9yI9V9IknPU1vTv8BgzP1kjWBqb402
	 +K7hTcifMZYdzg+9nY81qCxJDe73ZYiPrAOV9m3OW+lBPP1axuiPgdd0Bc+ckiC/mI7Jt
	 iCZ77Yt+VPEdnw8jw9kVTH0UUfpktgSmQomV/pzLnx7VwE9/4zf0aHtyuXYsyXU7xxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=cixtech.com;
	spf=pass smtp.mailfrom=cixtech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.115
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022115.outbound.protection.outlook.com [52.101.126.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2875606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 05:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2875606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjbjcvDvm2ON2OjThmF9R2nzIAQ6FxMp43uX9WYD+hagA3f907K7tO03O3pzkDNYIdMmT6wDoMO137zGCo4VcBZ4c7reV5GIbhQ2ejNqIdvid8OWTRW9bmsLk+dD/QMbyTd97EKvQlpirdLV37P0ZCyXYUaX2/2XcKTcFAfntYP37K4J37JgnUnVyT7HrZJsr2myJOPLGexIybjxgL9Wq70J+mQdi/g/c7UuLGAcTjlo5Pr6uJ9WyKob93kgGk9xwDWX6EoCqDLaXY8z004wN4P3AZrXuGdQ6YkzHHPO5GqlaCg57JQJvAkQv92vHsJF11wouWW75halIxvMa4oH0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF1NbnWux934O0IIsujFl9xGbyeeKPnw5llJQ+nZFxA=;
 b=aPX1eIH4LC/z3DwpNBbHVIil2GhLURU3gFfpKQkmLg/X2z9QEorc/pbxEbJNaI2mE4YestWZ5207pMFlTS0UhmK8urZTIrXciyrc3wVla7OSMgKJRpXoM4Uc40HGVdZVLqKeogteBvhl8kHYvZIUrnCIDoPK1ZkjK2KlOqnkNsZMCG7pJFveTMI+RiX5f7ac0//CHG2yPQu7d4I8JupWP7w3nImEzoVxTQrJXtPtC1rKxQxULg4FpVvrLE7DJrs33n6n/S66092pqL0HV6GCFi1LY9sJX42C9H7Ud3t7fY+J7j+CVoPUGSpTi3X9LDgEhw3SaEQszpysSa1wS9CNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0040.apcprd02.prod.outlook.com (2603:1096:4:196::6) by
 KUYPR06MB8482.apcprd06.prod.outlook.com (2603:1096:d10:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.9; Wed, 4 Nov 2026 05:10:56 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:196:cafe::5e) by SI2PR02CA0040.outlook.office365.com
 (2603:1096:4:196::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 05:10:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198) smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 05:10:56 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.55])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id B716040920E2;
	Wed,  4 Nov 2026 13:10:55 +0800 (CST)
From: Gary Yang <gary.yang@cixtech.com>
To: Fugang Duan <fugang.duan@cixtech.com>
Cc: CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
	Gary Yang <gary.yang@cixtech.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: cix: fix I2C bus address and size cells on Sky1
Date: Wed,  4 Nov 2026 13:10:54 +0800
Message-ID: <20261104051055.3020004-4-gary.yang@cixtech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261104051055.3020004-1-gary.yang@cixtech.com>
References: <20261104051055.3020004-1-gary.yang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|KUYPR06MB8482:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9ed6e27-50f9-4be1-4af8-08df3a3201f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|56012099006|261009223027099003|261021121427099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kE+0CCaqNJFTCISCTp8pda2YihUXKmnsL/TxamrHnZWTJFQaDwJrWbpc3yTlRjcfDbJnhnCg096MRj2UFesIQuGzXdxCXnEDBUEkzDZ4e1s0xH9FRzxLJrArd+oDwwGefIZa5av7TZVOliTe0EzpTPujoIQn31OdvKFIqo9IDH1Xn+s7aHliyKOuT7NsKM3w4lScjp9SRflAUOEfLAN+NPYAnzprsdmyLz6s1CWgGaLagPuARu/U5Wn4QuWOPaUIiEGsKsad3/LTujxr1WE3tKX6CelHO+pPvhGXJxB9nH2LjYfUKn9BQ4MYK5J5EovtXx7Vl/l3Zn5Q5eltDvG3svHjJ5A+rjZ+k5Vz9VTY1DLl2PfdPiAIhLa50EMwdBHGvT9wW5MrPyEMF3mauCns/QtnVdKZGueMO/JYSCC50iQ6CuXb0DzsQwsWfMrwzznqoBfQzP44jRhmF+ClDaIm/klRIHcQRTH+0/fbaG++3d0kISN6NUfo6d0Jwc9Y3iM0tVFQ03ozdC3zfFkfLL0Glb+e0aL4lDjmDyi6nzCU77AmBFiqZzJLkTq23DS6VRvTZx3wOethyyTIvsNeEP4XrUG+mUi6YF3Rnz2ae5wV7GFHTGV1D3AjKmx30qC1LlfClsWJfjzvccn10Y054GhQHlWx+nH5EAHy7/t2jAEwddGNluFqD2LXhhbwfP89Jq/j
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(56012099006)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yi9EqJWRx+TlJi8c/5QMKAbDQsQvErLKuZu1V3W2TclKuc5W10P7xz7x54QqrMANVFau8VYhMWvJrtE6uMYU1j6emxzpYYRcvytDlrK3gFRhTGclAZ3Fm4qPC8aR1jKkCqsWBxSUihFeNkcLvuBrSW/2HXP/QJ3oQItdjps75bN4NH2cvGgOBSds0cj0HY6c4TBSEXasFV4QsPOEup4VVd7JLN8bp1rUHuXSLSu7h0T42tl+33BiLUBnWU52i+9nc+zqLEX8Z/SvhlhKsidaHp5pTWXmEw7DOJ/u7h9dZbx0ezPpkS0OCAbON0CRWgZb/uyiIgAl5zDiMzGyjc885NXEF+eT21CqW578WhErLBx/G0BRkUe2U2EnzD6XBgd+ljcWShMFSRBukRJeJxz0n8/B8Rnn7KKfzj8JsnTYPpRWY6sKkzd6qrf/v/fg5GiP
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 05:10:56.3577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ed6e27-50f9-4be1-4af8-08df3a3201f1
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8482

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

