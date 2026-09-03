Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27934FC8DC;
	Thu,  3 Sep 2026 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457713; cv=fail; b=HpJFqoYRh/IzIhS4nv97as6XKyBcZv4RKPv+l+iEhxHEJ9GoPvwH36gTe8HIwbyCSLc+/Zk7xnuhP+JI0TV04lgpXAQjFz/8NXqqKExZu+5bNu/Qc94w30S03DUVJ5rqSVgnvk4eBNIGyduChqwNPCWUThLIEcvCWxN4ZPrB1zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457713; c=relaxed/simple;
	bh=7pOy5aLTLiXmq9N7QbGgBPzNTWmTmIVP55zWc1mapgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GGI+zxEBVu+jXibLmyswrt8dyrWd7naV5rd5hb8R7owZgx+JCdGhEkFjYVmqEtuVIRHbqL+8EJg19TWj3O0J9ZQeOyFz1fl9V53XP7gBTlwAghoEtnXO8BxTS0hK63ZkksJNGa10gE3gpAOT3mFlMl+b4mMZDxLNUeSXGu5pFcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ugNdSXs5; arc=fail smtp.client-ip=52.101.85.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ugNdSXs5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0TnPxk3kAx/q+xOOoaYxC/+2+YQHRbAPUnWHp1bmIq0seS/Evib2JA0Y3oVvH04g2yUeJDc4+rVrygZNtRy6ZFKFq0aHMxsUG+VA7cwAJMkIKMo/4TtL/VM7HUihL1kBm4Wr7rkQWODwB15FPAbhwTM8A8fVJxETR+dFcSIs2YEuYirdtlBt9Qm8sSv1QTKrFVcIybuNNu0crKFRygykNM2/jRsd4JUTPTM+m+EvbEyA0l7iAbYzxc+EMksnFABggfCBXFZdnD7vzIRogbOnOLRcYBwajsTauxacrk0t/dDZxXskg6YPEbpFoI0EKHMQ6BPuXD0aw4zOFlR+JdFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZ7cZy7WoNhHwQtpccNM9ijWdMDxrqP/rp5wd8W8Lbc=;
 b=q3V7IzOSBkwATmKkCjb6dtnocyKeZ9v/SQFsTXQa6H1lj3Nr95fbOE3idPoBbzW/tHoZq4JycVIyyxirTjhMGdvEscOUYgjf+mj0hszvokxiNbP8k4B8LF7Z+J7xe7+y3+/mw1J2VoLxBSlcvKhRXSDa6CP7AGaadX/3Mo3qTUQNdlpHEvPeeBjqNW7tUFMHWn8LZlO7uLxNnmTtp/yxp0n4far3uIGl59pmKviAcWao9PPEgE/ryD8OZloENQYFPvQtKtiPwCK04VmvIYRQQsQOVmSMMxRpTbWRhQ29eWwfnYdgyrecf2bYEr3uvZ2RzVLWaOg3gkF1/asiQUbbiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZ7cZy7WoNhHwQtpccNM9ijWdMDxrqP/rp5wd8W8Lbc=;
 b=ugNdSXs5SL9ZpcIC7cSmP1pO0LqF97vtCbJZQenscAvO3RkN4bk19FBdeZLaBlWJ2tIbwLjheVip+iXCgM40ypooq/Tay2Tc1vfouVsyHvyoJQ1xDvJtejCwVMrf37LRBlTYio5etqYoqwAWJU/gLyzwQYxcy6beFG+nogc3geICHR403mETWXz42Wo771z0BLMH8ZeAv+yWHudhg6FhQB46VxJPW3R+P90l3YJq3G6KFOPFGyYlVx7xdfN1XdFn2rR1k7e2bYK8Xv933BONLgohloChnYto1CqmUCfm4rU2TggF64sIxA6MRuobHC6NfZWfj5dsk+4fXEivYCudmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB4972.namprd03.prod.outlook.com (2603:10b6:5:1e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 17:48:30 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 17:48:30 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: socfpga: agilex5: replace clocks reference with clock-frequency for dw-apb-timer
Date: Fri,  4 Sep 2026 01:41:05 +0800
Message-ID: <6317aa2675ab36ec1dfd881ae7e95d1f3378aed0.1788457041.git.adrian.ho.yin.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: db0b4280-8f39-418d-f133-08df09e390c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|18002099003|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	LeKbJccIUXSzptFoXeJ1iHgDkM2+DMpJxTNv5pxqIOOq7wvekm17H7U2twvH8yXdLv9IHpwc6EqgfTC61p6UPaVNLMjmVDzXL5k/XY7azKXiH2SuJljyvF/wsRCl8NYZO0kxGNoa5y25UN9IqCVo9coOHbFF8TvFQSH7LXTDHZavcGZvelAsp7X77wq9w06XQVbRqpCubwEW4AIdV2FTTB/kWDkHs2PU2N/SubFBXAn4A+Om5POktDa8wBRBhEeJpamjbFYNfZRxCKKoRK0Yb2W8EWfuaIjADpgVjxeOltNTXdbtnAd6yoWnDGMgDmrRNkP7twgEVwxml+a90GZkWh3+v8reSFGC7TdtwWYcIQj+rbszt0AFp4g/IFNLVXd+xDODXg++80+2Mln6zwsiRbjpOvw/d6a6pWlT+gwIpnSAasXv9aPbrMF9lPrNjaJ4cuV1asM41Giil+Zp0G2/CnfD/rrc7peNIuX4tDwt4O8rNlCMcVSvpewEgdMlqfFHBZzktMktz/+gB59k1wphUlJM1uySN2dSODnrFzXVjDH+sNOLny1VLhcwuB/y3ogPstO1BreqogycNlXICSnkFz+cIOXrRDYgWgWMJqMnVAkIiXaBuEIBCp0CJyf9U6rTLs7FzMrGhtEKDhfeIcuu6jJNh1hPIYDiMy92sCOgkw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(18002099003)(55112099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sShc9OxQCdvoVVE1lOh5kTSL/UusGJ9ahKPyNzW3ZBwcBQG44smnRqXsw/bv?=
 =?us-ascii?Q?lhgPJNMGazDyf3VwKxU34zGhSZbuSl6JbroF0p3XYdevOfeGmSh0TA+beccE?=
 =?us-ascii?Q?CLynYGjJ8whFSQkOsg33sahAQFtRdubSy/xF5ZrBIb4glYibX0OUfSQBPwlU?=
 =?us-ascii?Q?gpb6dWAo9hDcnILvYjK8LdyyhipxHGMfQOOgL2aV63yODDzi+XhSHWyTS3Yb?=
 =?us-ascii?Q?h9RD8o53uvNkFHRljTXgUUU8lE3KnEq62actPvt3+S/4FnjMlPy1bqiYcBdv?=
 =?us-ascii?Q?ZLBqdQp2CZ3VCtNcnGCBHofiHm+wanzIAs4HgJlPLgMjF3Y3jSH7h7k8jwGu?=
 =?us-ascii?Q?tU6JiKloeEx1ZMVF4kuiq+rfkMvUlsddMBqz1t0qMTQ79RI9uAaY66imjRxb?=
 =?us-ascii?Q?gtJZ+7nJWU7L4ZfC3ZhYi55dT8sRymgpMF3hcW0nr4yXdaCgJlrIA7YDfMIc?=
 =?us-ascii?Q?RkBbvAnTZ3nkjfbbBwdDoRSaFDij48JAZ5m0VegBx4K5ShbIlz3q4UchOQ7q?=
 =?us-ascii?Q?wnjxhuthF/aRK3jUORhX17LFpbzVwoXCVENJJ2mSNXZ4sU3UChOmaRrkI3jr?=
 =?us-ascii?Q?zGD9pbxvat0qqkN1nkjDYxSP1snI6ZVddh9BPumRPtLWIhGygzx+RYdLdnzp?=
 =?us-ascii?Q?X4EuEzlMxiMGPzIaqcgrzbE9gBbyGpKFtjLWUGdnYUbKiC5SJl2fQgORYATr?=
 =?us-ascii?Q?5EkGUqn3E6q94uAxfUayMTPn1rcE23+gSGFkQ0JZbV2a/My/tcIOLhyGUc5w?=
 =?us-ascii?Q?cs67Z7WTE83ZoIhADaA2v/2HAXKuq5uaONH5ZXsxjlT1pHUpKxaDcCZmojrK?=
 =?us-ascii?Q?ijoqCDPzwkSDIeJA/mbS1F/bnWDhsj16uwUbvLfrlroQHRB8v4vbuX4J17Do?=
 =?us-ascii?Q?VTVzbGPs4ClQTvSj4EYtVV8cQSyfqTtIUWRlcRMF4bj5aKLjpnkyzsQMYY1a?=
 =?us-ascii?Q?PsQYhddmxl2nH6cwOLdezUBjUjkqG+fQN6Br6CfxY1NR54tbQG42GWUN4pCQ?=
 =?us-ascii?Q?eOPduByZH9hpbkL/sFnAxPGKLHV41nF0k5eg+X2NMXK15dKLUSZgi/QRc3Gw?=
 =?us-ascii?Q?xdooLOolBUr6Mu+MVbUQV8WkxJHe43xy9U6s5l6XRy0slqGnOQbN5coYyskO?=
 =?us-ascii?Q?z06Uq6CiZT6Zikr08sBZEWaXpaF5nBRlOZrDnmTkYjATorH5BCHWDjzbHKtb?=
 =?us-ascii?Q?M4Q4O40WtDCWwR7uiD3Y1SKxNjjZsGfvKEoOwc4ACEZQR0pbGmZ3sqR4jQP2?=
 =?us-ascii?Q?v7RbYZDnb+fRAkSY9aeX0vkDsJMF96jvW7MXKUb8p6a7ayHIb9UZS7jfTwlU?=
 =?us-ascii?Q?Z7Y4/UyVWiEln9s4mEKw+R7VtFJ6zEKrcuOKmNVmm1bJwxf6Eh52PAozmz71?=
 =?us-ascii?Q?e6bUTNfw5C1O3/V3nuRL0oKOVOpl0sXz7fUHQaHSJPZBcdcI+/SX7uk4xRQY?=
 =?us-ascii?Q?jYKvXUTH5aFpWJ9JRsZDU+SOt5I+MmUrULf9LmnFUCFg8QohQ29WQmbVOpmZ?=
 =?us-ascii?Q?xa7ZqZyJ1Rj9Coth5aULnBspco6pVST5ol6enJHOQCuOTu7wFqENk6QvfT2D?=
 =?us-ascii?Q?B6o2a2KjHKU+AG/wfyvL4MB4wD0srmo9OEkvUjIwEwG0qXhKQgE4yNUtjBmu?=
 =?us-ascii?Q?ObsFsOka+Ia0t4Q1I+3fJfQgO4wjCk68tKBuvglNJiTDliNeg014JV0szfng?=
 =?us-ascii?Q?j8XsAR7kPtiUlhuTsp94jS6v9kloNv7hZvyVM6vVZv2Ar7H17emlgtwxZIGW?=
 =?us-ascii?Q?cUil3HRAXRsVOJK8EGWzn29/ruSVo7I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0b4280-8f39-418d-f133-08df09e390c3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:48:30.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPmLrfV92KryBVVqLdS8S5BwxQT0AO/i0SNu8VRdeTZT/L+tBuNwfZcygwpcfU1p1QZkU46DuL527OuLxJTXVwn39bNg9btdWeYMn/zyX9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4972

The Agilex5 clock manager is a platform driver initialised at
core_initcall, after time_init() where TIMER_OF_DECLARE callbacks run.
The timer cannot defer its probe, so clk_get() fails and the timer is
never brought up.

With clock-frequency, the tick rate is read directly from the DT node
without involving the clock framework, allowing the timer to initialise
regardless of when the clock manager is ready.

Replace clocks/clock-names with a static clock-frequency of 100 MHz,
which is the L4_SP clock rate configured by the bootloader.

Fixes: 2d599bc43813 ("arm64: dts: agilex5: add initial support for Intel Agilex5 SoCFPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index f54767d1526e..f5bc37fa8583 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -429,32 +429,28 @@ timer0: timer0@10c03000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x10c03000 0x100>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer1: timer1@10c03100 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x10c03100 0x100>;
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer2: timer2@10d00000 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x10d00000 0x100>;
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer3: timer3@10d00100 {
 			compatible = "snps,dw-apb-timer";
 			reg = <0x10d00100 0x100>;
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clkmgr AGILEX5_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		uart0: serial@10c02000 {
-- 
2.49.GIT

