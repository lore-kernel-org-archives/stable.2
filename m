Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6434FDE4E;
	Thu,  3 Sep 2026 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457721; cv=fail; b=dDxOfD1RPOnaJ268h9zIjV9h+SGN8Jkh09KUqI6ImLFxqfF7ManOG6GJN+lKSRZy/txKcBMLVt0IwCn8hwunc5f6xxZXUO5K3BORuP+k86GNpCfg6Gx1QRkqjeeUgCEnpGlM1cbFnU6oOgjbeLTPJ4G3mqJlN9pk2oqehkZFxus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457721; c=relaxed/simple;
	bh=24EE3Ip4zjHo7gdrLM0HaiU3NUlyvbabrbNlePKJbdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IjlKhfeT1c/0niIG8H1hT2Fu+Sec8pT0nw/BVlrMPsMo2YShv38obIdCSWQGB4R7rvQK+BtfQ1puKxcoD++C2k0FcQlM1pnEZP/qy8bGvotyPz7ybyeU7UC6FapE+KbZlvS2qiuoOavnT5CHOJMO5OyNH3C3KxgR9AP2bB14R6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=A4ssdWpT; arc=fail smtp.client-ip=52.101.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="A4ssdWpT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qtnjf1h/dkumpLomjHWyLELMY0cskbG58dahGZ9FDEe7PuYWithwaFKleVE5Bl+fYj8953gi1Hb5alvr6yhHk9+OcS5mcc3uDswvqQrHoHb3NdyMFsufkQvtfTii2granX3HvFU16k8KWqWM5CD2lUXwUtXy4UiwB/ojgi0+J9b8W2VD59uHyg1bImY70q4VSvNlV/2hLbPGnVAwR1uln6nR2N0xWSCyjOkY799uDU632MjUtdIejx9+cRY8wApgmVlOKuJvoQLv6BSIGLUZI08ZE3n66ZfuaL5DPb7WnW4det5If2ZXmH7yfx8bfWOPqO1bQMqq9nwjjcIAhc41kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHKjyuSH1PTR2Oqk1vYZM3bjLuzxmdPtRc5zl3vPneQ=;
 b=qCXtkx6FnLurKur3fmr18dMGdZFkPi5oAHHpxiYxIpHnKi2qlpy6zf1fCsiIq5q4Es5EiJaJq56VNsU/faCBREMzgFp3jnt6hARjtr3e9VPy7jK78X/q32GvS7nAOMYn26lZpahtNySRaiqRPGdiB0OQFaKPASvu1jY4uOpK60CWl6HRPaSRqA06EMyqw4G2EkV2r74Jl5EZ98UV+RCRUb43MvLMkozHmR3mVNYCzvCTrWN/78PBINHBV1sgb8OsLNjiqEFPd2rF9gqY7MEDC9cJ7JI+PmDv8xmsT6Qbear5Yv0/AuzkKE+vQs9bxKiXTbeGCUcqpeCHl/Zo9YT+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHKjyuSH1PTR2Oqk1vYZM3bjLuzxmdPtRc5zl3vPneQ=;
 b=A4ssdWpTa/pxNmZwEHVs4nT2an0nATl6p37Z8c0agwE/h5yX/pQ8bBZxSoX9wYBCowCjv6zF3EnbtuDE9ylA+ftg3TuVcNJ5LhjoTYquuuYiJpo3KXz5dv8bkcJwkfev7IiBAnHuK9lGjducyW1DAMJOHBNlEGT7jBjo5SBnonqZ44G7npZs6kWfmz9zcG0cZVqwSUwW+JcFk7VSNd/z9qokkHy4cociWbl9B1dfOYyb8Uu6txl4d13L11bwTOyE4+pSDb5X9G7iYmZICC0hGsoHcG9BlpGJHabehdIdceeAttcWc8cHEoADe9qm0fK7ID9DwE4thNkdOikIDR3cJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 DM6PR03MB4972.namprd03.prod.outlook.com (2603:10b6:5:1e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Thu, 3 Sep 2026 17:48:36 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::abad:9d80:7a13:9542%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 17:48:35 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: socfpga: stratix10: replace clocks reference with clock-frequency for dw-apb-timer
Date: Fri,  4 Sep 2026 01:41:07 +0800
Message-ID: <71ff1636b37995398e6eddccc77251269cffa669.1788457041.git.adrian.ho.yin.ng@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbec03cd-ece9-4d9b-0ca2-08df09e3941e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|11063799006|18002099003|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	2SyU+ATTgXERf1yfRcpQp1cvZwlUpZmsUVK6V4U20VBxBh4QDITYI1sMNQ6ey1T6cXfgwTnUfv0JdCRpuNJr4fVYVbMSeF4eCzKRKhociooyIVGh68N3YP8aTVobl43DbpC4yFLqm7AiS9Tn69027LQM1Xwl2kSR6Run1p1Y1NY7oIIuj+XZMILJd44CUwHi9PispleMr8N/4Y1sz8PNVbvWDuR2V1e1kb7Eq9XMM7WW82bEwTqitj1cGXggBbA2cYptCfPt7YYxNcL0u2l2ePMhSxxpd+zrDvFmi7FBzqoaqzSKmvB/ViedoZF7UF4Q6PhNPD3qorqFsCLvx6bjyO8EnmIB1co+sMSj1zC30ycAhHuXRwCIAscAMZIILuMe+7eyPcSI8RjJcykqM/WiRd0t4IXLifKg7GcLAIrhgPWzPD5o9e2Wfvoioppz1qGPvycvQ/KK9pq0lS8eCovch2GEctu/wjPGX4q5L2okyuUhVln1Nm1tD8enrTjvtpsk4it0DRTQOz/BP5BdThDHiw1ZfuUGjoNi1XiUm5uc6G9kaHsidxphCE0gQomMWhzdTx8C7sH/KAUfQPo1bihnHUmLqJDgFzWbPUYMgewXRUMWbEt5v6HOE/hr/q5mTKDFoIYVI7t9vdFvLGh4jbP45nKbKYZwxIbDixtMFiNN2t0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(11063799006)(18002099003)(55112099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VrPfwrEeXDmJHMggB4q7XffkhygelTovyF+jIzEC+FaMy9lH/+RnsAEdN+SV?=
 =?us-ascii?Q?jzbj0i2Viw09rwtuWGITrMS4IBkSpG5KOcGJkOjzMtrwo8RL81L4Vic5kzUO?=
 =?us-ascii?Q?0SAmjk1ZiezWFkBGoauFzPvI5fvKz/i/Mz1ep+Lcds7jYAC+i1hXs3BslxZ8?=
 =?us-ascii?Q?uSKyU5CagyYz4NQlxdU4xteXuZ42oExlxxcD0xe5kUja87yu3txMqipRgz3P?=
 =?us-ascii?Q?/aloxHewit5IvoPKvH/xPd8oN4zKLc/0sGu0HLZbyovYtJudmYs+xVrg0sIE?=
 =?us-ascii?Q?PlSjZZBHwMRDRCyoYhrduksB7k7pRRobG3kTft8wBR+06IheD7TzHUVtPKdZ?=
 =?us-ascii?Q?j3SGj7SG+DL8SoqPWkQLvgYna7iFylLgakKdp7MMSrdf7beNqyIgIFIeJa8p?=
 =?us-ascii?Q?cpCEKJZYigGb8uBVzWL34d3sIXg/SZGZIy05qyID/KsZC9MYt76llW9JpqJc?=
 =?us-ascii?Q?VaqYmI6YgrTC1UxfaitI6xNq2qiaEjJ/PVLPvfiDdinY2BWa6+eJ/Z4e9Y8H?=
 =?us-ascii?Q?yXlA8MhFwGkuC1q/EVHpluPoxghxduB2+BFIzn5bBapGXd8VobZF6+CO3Sgz?=
 =?us-ascii?Q?D/PwzARE9qTWwA19YusY55rptzMvAojaVlhnbpXNoR4DXRyneJwNlN0Y8pBr?=
 =?us-ascii?Q?wPwgvWqMLwad/Ea32kvydZ6VLo5gdlj/JHYS3ga+w2FA2WD38CJ0wdKLh87z?=
 =?us-ascii?Q?lAjBkxiK4BELHTqj9Am/71cJdM+RDNLk3MaAGMqx2s2uR4fpYZauifMk40/F?=
 =?us-ascii?Q?9bNqodTIGeUVXoC0nzAYf/ZTtCZ299ZXbQ2uipOA/A5mJ6V2u+6zVDT9nC/T?=
 =?us-ascii?Q?hzNqFHI+8Fo9NDhxrOHztR4zUFGHvDuRaJOPf4+ZxLIJ/hIG/FyBGpy91+Am?=
 =?us-ascii?Q?ns/plo8bXrdYGaGbGXt7GQBSKCm/AKfKfQuJUxHq1dWgwAy7EAkIPI3QUEK4?=
 =?us-ascii?Q?bqpUV1FNZSWdGZUCF42X++x27kgDD5nPZEh+Oaez+6ZoMgHTtwekvDTK70RJ?=
 =?us-ascii?Q?UhL20arlRQv0vj1sV9ZAIWCYCnOyjlUb9x8qsyTb9x5mcZj6U7OFh+VbawAg?=
 =?us-ascii?Q?rrQ8b4oqsVTMD/IkDrKqIgBjBBnicifxDwShPkDt5ntMkWIWCD1rol8Utipn?=
 =?us-ascii?Q?fTrRUdIo1JFB6jaslZ5EKkWHVl2FCpJWwJOKAIsyEBgcpIMfUafAgAjCHAgw?=
 =?us-ascii?Q?787oMPxDaOA2569gtVJ+EkkVMpZ0Rm+ArgJ4+thuK65o0vaIBwu2ONdDkc1y?=
 =?us-ascii?Q?eQ+/8G0M46+hGVlSMCjMdXB6PTYR7sZtXdpT9fx59d6/OW4Ugyei9uAQVmCS?=
 =?us-ascii?Q?NzElRWUE+Mt1gOEJk27deS+KIE0LSXmdr/iGWqkciPrhkMti4SPbqoE1JnTP?=
 =?us-ascii?Q?5Nk/r/jkigWrKbv8D552iXt4ExqdZNhqotrewwAAnoo885SmwuT0ckOa7GdM?=
 =?us-ascii?Q?fvaKfYyZQn80BI6JvLMuL7+rlexg5bZFCMlD/sIhPG2xUjJRWLkOrlH2G8wp?=
 =?us-ascii?Q?3XFzh1uFmTYpeHhz3HQYVIf/IXbzxIyjw5dmfpFlsZ9ApAWtlgMkxzq8Db7L?=
 =?us-ascii?Q?rRzyLXDk9GEGjLacrq1cNG9zoFAdXER1+I9+yGon0VU6efraFmcmvjDkrSW9?=
 =?us-ascii?Q?UcnfO1qlShRWx4Pcc317UtFuew8f4wb27/pKFR4YTsKOrIa6qpiJgZns+gSx?=
 =?us-ascii?Q?1h/eNPsPOO+fqYraeNxRUjVESW2R63VIVycNS+IzDyw7ViHT4WhmVPSgd517?=
 =?us-ascii?Q?7Ezftu/+wBwzfX/sysNteT10wDryHqo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbec03cd-ece9-4d9b-0ca2-08df09e3941e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:48:35.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCqG0dcSMWCMkt2gtZovP8OMl4stRaEhwJziWqEczEOQPaWK5wng3D0sVQ5KfzRYtkzUXQxZxer6z6PreZ2SEldnqNcBvspVZbmsJQQ8MSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4972

The Stratix10 clock manager is a platform driver initialised at
core_initcall, after time_init() where TIMER_OF_DECLARE callbacks run.
The timer cannot defer its probe, so clk_get() fails and the timer is
never brought up.

With clock-frequency, the tick rate is read directly from the DT node
without involving the clock framework, allowing the timer to initialise
regardless of when the clock manager is ready.

Replace clocks/clock-names with a static clock-frequency of 100 MHz,
which is the L4_SP clock rate configured by the bootloader.

Fixes: d93101abe41e ("arm64: dts: stratix10: use clock bindings for the Stratix10 platform")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 0d9cad0c0351..efae7b06e3fb 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -462,32 +462,28 @@ timer0: timer0@ffc03000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 113 4>;
 			reg = <0xffc03000 0x100>;
-			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer1: timer1@ffc03100 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 114 4>;
 			reg = <0xffc03100 0x100>;
-			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer2: timer2@ffd00000 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 115 4>;
 			reg = <0xffd00000 0x100>;
-			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		timer3: timer3@ffd00100 {
 			compatible = "snps,dw-apb-timer";
 			interrupts = <0 116 4>;
 			reg = <0xffd00100 0x100>;
-			clocks = <&clkmgr STRATIX10_L4_SP_CLK>;
-			clock-names = "timer";
+			clock-frequency = <100000000>;
 		};
 
 		uart0: serial@ffc02000 {
-- 
2.49.GIT

