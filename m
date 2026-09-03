Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56F4FC8DC;
	Thu,  3 Sep 2026 17:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457719; cv=fail; b=RC0izEwZFG7rHKwyRmMvJFkUWgc6cpKD4OHdgoAZYuV6Wwo55kCthsXg66Sl4YIr9lFGAL8Q6I0tUt1nsy+xF1gm0VwkQtc8jFSCTu2YYNtoGwepKfGsu2dekbcC5zE+yVcwuLI5WD+/yfX6/vWVpDMfb0SGuCFryLlKMXe6lcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457719; c=relaxed/simple;
	bh=O7geCZMby9pY44Ym4kPQOYmXuEWYa8CRhB5ejAIxIpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXtxFA20lcTWOQpBX3lNkbb3mK1qBvSgY1C62HQahkC5mq+4O1lhbHbFXFYTR1VSxAbE58TheLfUFOkeuClE7HuB0f8q/KkHrcAb6ZCWZ8PMfl1uvT01WidU8Il67ZLlecLs8k4S65f4S8IqCg5ZOr+AH033Ppw+PAUdQFNSit0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=gSsKHXQM; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="gSsKHXQM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga5hy1jpFPYtH16PtN/Rm4BemEWw9EbUD4b7qtvypDyRcrObghkegDSVoD5cJPIilI8oQklhNHErisgR+ZvHJWRcQW1YHENrCSGEX5gM0OCfYoXkXBiXzZN0Zl3ym/Sp4FxQOHJw2T8lb7L6h/SsgLhRM/hRInO+uzJU3tYqVXoEtAIDxEgQT9rbNbuk0+DSHiPhNfToadMNl+HGw/uKhBG7e9sO5qR+hbzA1ILETZz94oGaTcarlX3Syg8Y9qE24uULg7aIaFYkwdvzTr/AfOUJZhDO1x5iX5vJdbR6T/1a+gKNPJtcUBEHuDhKnh0WJI9R+VuBau7LLP9gIb3h0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/tcpn1I/3+taUekfqNOUlyWpwjPEYGY9FswUiaabAo=;
 b=pAIw7JVOqwzu8vgciCt3o45s9xpQO2A3rXz/DmMBqIfVF/NPKJgC0yEPvIyH4Lkh0H98nzA6viKYkuyH0cdXZ8KKAHjMF/D6apSKl9KsEojL2foehpW7aQe9LHcoJhM7JCEdfVQJ8domxLC42oZCYaHo0/dBjyrFMEa0WC6PqinJo9BV27m3uVZg1V0KjMQBEDK2r4w67g2/maFHrKjqVirGLtJqW0oOP/pN9qOz+ePgEgcq3agIlUna7sZflVJ45xAjxjcbuFVdjh7sDw2XaaVKJ1a0oAW8RcSZcC9oWyWuCZIwRLw4QK05n3tc6peCuEhbiB9Sa7CTFOCoUcVW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/tcpn1I/3+taUekfqNOUlyWpwjPEYGY9FswUiaabAo=;
 b=gSsKHXQMlH/Px5oiX+Arr0XoPZd1nCrvffRMG+HlhTGbefhcMxak6UUxtQRpd9IzMA231vB0/7LSdYaK86jgdgUBca1bt4vFrkXwrNhgdgKe7MqRSZF5a/IU0uWcL2By8Ul9t36AsIIY0Pr9+tzrdmHdlkqW+81KvLrHQJIsKl6SL9A/v8hm8jo0HrkutgWdN0cIm5lK7BTd0aS3cudmGZPUwYCxSRsnDRehNzpJbYS4+0b1ppLq2w9K4xK7wPKBtXEbIanHTKpf6LPsWEul6MZsKNsvcg2Tf2EKwUTdNyqcJ2pPkXfn8yqaUWWMK+2Fvvp1mewxpNMmxnscyXd7zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB4972.namprd03.prod.outlook.com (2603:10b6:5:1e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 17:48:33 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 17:48:33 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: socfpga: agilex: replace clocks reference with clock-frequency for dw-apb-timer
Date: Fri,  4 Sep 2026 01:41:06 +0800
Message-ID: <ead30fce45e7b1e8ea8ed3bdc8164adaa16bf35d.1788457041.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1788457041.git.adrian.ho.yin.ng@altera.com>
References: <cover.1788457041.git.adrian.ho.yin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|DM6PR03MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 954fd54a-b8bf-4fa7-699f-08df09e3928c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|18002099003|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	rFjuZC2o8cXM0RDrisP6ciFIyAtKgKvTDjP2AuI5PKod1mND/KT5cdjC2FrxsyjMb6mopI1Ht7XWVyfubTpPg3dt5Kb3umt4A78nDUH8+nTdwQxjMOpWPJ5f0trWGlFA3vaTJWZM3rj/6bBHtROIE3t621b9fH5xoZ3cGYF6Gwm+XlCH6wkdKMCdBB6r+1uBE1iU9dtYVGVLxO34d/ysQGYuXvXpsL4/LfROaMmeg8edxloOFCUw/Aef9UAkkew9Ae/xkt6ElyAxQZglTZMc+avzDMAWQHC0UrHScDILY0nPnFuvGNgG/uzYMFuqRf8fo2A39Jk1C5jhrZz983p840aWsb3W9KKKuOWOU3PbMbPNCmYXsjb059XhwCnNDAVCUTgxTt+GvPFnFWtatFDrduSdYMU1lugBZlrQW9ri64LsB7gOf6oszOLjOC98kjDgnK7TTv6/bXSLiR0YOmTwp6Tuh6NIgTybumY4fJBhilqEn2sMhkLPTYpAP5m3kUccwwSnW4EdrVJox4gtSFX78eIs+K4gUGM04vH76+w68S+jE0zH/O9CA1eTBeyymGksK+r5xQ751GZnNMmPlzQqURECb9TcX+yJikhZTDjhFDRjyQp7Mgdz/9U6Nzhktl1JtjxVC/ySFUFN2n3SBJZIZza/GKsbbpNDtGPKrt/YZko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(18002099003)(55112099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LX9PFU2xy1rqGLbp4caLcImZznPYKxG57yj6GMhVg5GDyxwSBsN1euJP4WRC?=
 =?us-ascii?Q?g4aCeHf7dkn3uQe/Eg1Y9ByQVkFfLy1J3hKDixQJPa/glrDFTdHtc2/ok76K?=
 =?us-ascii?Q?Kre6OXZSKbvpm49JqLFUx/gEAAWw3e6ZULrKGZtFQbOMS39DCqYC122rEq/t?=
 =?us-ascii?Q?YHJ2eaFzPH0vx70R1Cpvpe3OQ8RNrjTteTfqCAnPVCFTn9Z5s8NMnIYgkki7?=
 =?us-ascii?Q?NOXiakfGdAnecUud9yJne2yGfRgMg14ryGWsSlfVMypf/0b+9tW9/EWa+Wnd?=
 =?us-ascii?Q?kjMI4aXO8iC+/sTbzCrejInvjOBBSsH7xFlaHOwBXLtuIdc5NSAAuK6o496t?=
 =?us-ascii?Q?x0ZM1NFB2y2kHoMkRp651Lg4sUXLtmANrFR6bJvHvvBetRKA6Xw0lcPoUwbg?=
 =?us-ascii?Q?GpDIx0k5/aP80G4KumoeCqN6P2H5nX2quT4wYqe+2NNwnEKw9HJgW8ygNsHQ?=
 =?us-ascii?Q?6VHARf5Xb0upwfnD+Y1yctoH6xx7yirmRZbAkzc4j8+zlOw5kyPoQk7I97ps?=
 =?us-ascii?Q?1JHhnMDGkRkJG3MiYMuh2fAEErrOt03gs3Sm5QazCoZZSaxS2LEVKSmC8/4o?=
 =?us-ascii?Q?qVEoMAIqrKadKU5gD72Af2TmfSPBis+bi5cnTEffSxAb3h+ZxVP5MKUMWqXJ?=
 =?us-ascii?Q?Acv5bEkCVNxzVOIQdPzixPrvRBMeoBHLCAJtRVgnsenCmiBdOb5hfx7bX6V3?=
 =?us-ascii?Q?YXVZNQylQIopQzzw0lQbwXxh2xHoGsvpRiFatnAb99pmz0aDjUwRNp0CLv1+?=
 =?us-ascii?Q?hBMjU7YT5VmhCZj1jiC0nXXDw+7Vwqy3DGT1hPwCrZJ1BjAdMzJg2fLEIjsr?=
 =?us-ascii?Q?jpseOWyClygH+1eKDw+NVVGl+G10lgsmv8dOSAgAhBIac/i89N0Zm9B4+KpD?=
 =?us-ascii?Q?Ez7ga+LrWZdcb+ONl2ZSzTxupbm2oJHrdwM1RgIUQQk4du3bhX1rZuniYdl/?=
 =?us-ascii?Q?lypxunpef/Udy53wLIeb9UBBynAfORmex+8sU/hbOu1LqfUzyIbwhAiNYIA0?=
 =?us-ascii?Q?FeOENJdNbeyBiszJCWp/HDFB5yTA5QWkpJ29j2kyXahVwPjoGh24dY8xxXtG?=
 =?us-ascii?Q?PWxhIsy6o6MO37nTHOQbJVmx6cFcVx14B52qOZyNxtoDpnhzgY0/3I8C/x9m?=
 =?us-ascii?Q?4388oHfjKZiVxr9vaLAfgYB5SExlbyadShpk7dz+top6vGXiEkfs8EsRNMJL?=
 =?us-ascii?Q?5AzC+sLiUHwBO95wH4ibXnjFCBdMnAyy2LkoVkr/myBDpfBEm2UP45NVw9Y8?=
 =?us-ascii?Q?YYf2z7UYXaEiEGV6k2oqPj5Nmr9xk2fPGpO9GeY4OvcVcMocIfDZJ8dUVQ99?=
 =?us-ascii?Q?wnLkubn02D6B7eShsaUOFlTwBVUb3NEhUdB+cbFWYXIy9lSWTYgTjjzIhbPH?=
 =?us-ascii?Q?3MTLwXdQmGahbQdoykqq6geaFt5+sXBem+R29HUGKJWlKbbGLHbS0A7bHyNS?=
 =?us-ascii?Q?ZRN2XXcM5V8q6cNbH9dBE+5LXG3Dy8Kr3Tr7rejX4VYXqQnq0/ppYvEdVzJo?=
 =?us-ascii?Q?ObcU+9nZ4LhhU2aLCU1OM/pOeo+sODT8NxBD4TUBONO7RlmoZBgx8gV7VK0P?=
 =?us-ascii?Q?slmsqAgwLirEBXMmryDhIrNTb+OD1EhZkTIaWeQI/xK9wUBhAcHFyWGHx55G?=
 =?us-ascii?Q?dqXkYTE06LE3XAUJDRyEIHcouzXx/sXxmXGrzBdVqcDE6o8x4sjsBa0YI4uH?=
 =?us-ascii?Q?rSwETA+ubSTxl6y/m48mX34SX5ViW0VcLRLOcSTsjrdBhRs0DrQMpdtVKPXD?=
 =?us-ascii?Q?gFhSzIJYO1oY6BuLaHP4bXGFgHzZI1g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954fd54a-b8bf-4fa7-699f-08df09e3928c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:48:33.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsOFON7WfJF9qp+17A6+j8c20fBvCUTcIj2+unk3XGFy8RWj0GR3vWPHlf0+dPlTXBPX1UPONvYQiY+582zKVWUhT7ubuXI3hJVvbT60EGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4972

The Agilex clock manager is a platform driver initialised at
core_initcall, after time_init() where TIMER_OF_DECLARE callbacks run.
The timer cannot defer its probe, so clk_get() fails and the timer is
never brought up.

With clock-frequency, the tick rate is read directly from the DT node
without involving the clock framework, allowing the timer to initialise
regardless of when the clock manager is ready.

Replace clocks/clock-names with a static clock-frequency of 100 MHz,
which is the L4_SP clock rate configured by the bootloader.

Fixes: 48f36de93a50 ("arm64: dts: agilex: populate clock dts entries for Intel SoCFPGA Agilex")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
index 0dfbafde8822..4ed762c6e07f 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
@@ -491,32 +491,28 @@ timer0: timer0@ffc03000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffc03000 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer1: timer1@ffc03100 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffc03100 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer2: timer2@ffd00000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffd00000 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer3: timer3@ffd00100 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0xffd00100 0x100>;
-			clocks = <&clkmgr AGILEX_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		uart0: serial@ffc02000 {
-- 
2.49.GIT

