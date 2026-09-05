Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011027.outbound.protection.outlook.com [52.103.33.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB94165F1A;
	Sat,  5 Sep 2026 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641311; cv=fail; b=FieL0IVLIbKRJlfPlMlEyBlsdh/sbl9r1r9OKXlzg/kHfy0oz7wMnTqjgvasG80APJ88p65xCCwrMfUsvuBwD3Y3v0a9NDSfWXzOj/SrK8DhY+lhpjY92jsr0wg/q72V45S+WCToxKzCY7S45fweYcTdcjC37FTTIwr2pTf/Z3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641311; c=relaxed/simple;
	bh=dBLInmhGj+Iqn6kMsVQHFUqEzf5xMCR5ZnTI50DBn68=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tIbdIhtWrKGWEMQHiXsKssUm3T9cdmCjJ8V91ARLu9CVz+H+cGMpQbz7ZLOGFwiMIyQO7wXUPdbvr705J7g4AqR+Y9P1AWbxYY143OX9I4miYO10WBhEaeuLViXecSwtzTBmHz13InrEd8GAWQqm62WkdnsfV4Ya22EGgB4+5y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=Q5r4ws2l; arc=fail smtp.client-ip=52.103.33.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="Q5r4ws2l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UR+JksQYs1zujJpKp37g+sm1/dNwcaiaIb51nyEdnqeeeStOIBMQLBcF9qvFq5NSNjbyCLLyoLY2qYYzD0CcMP9kCfPq+fI/bcvPoVMjt0BSFUtlHkQ+RKtgH4yEtZu8g2tWdUiHWqQeRYkNE4Fr8CSdPA43+eZrwFE81mZaxwqz5O3K3kdqOkYkivVPqRqZoJclO9xuBSVfZngRgGG4zgrHa0ZeE356Q2LlKIqa63SVIiVXc5nor1upzEQmbCyDLXlW8d+9QepJMjMoVcmcuOIVvfdIEYkwKaXSh/3kyg+xRDjhWTzNbbme4PSi+TscxAZESnJJHGNJN+jPGS7lOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHlqTJzfmIFSg2SFBBv5hNnlEu6EjO6pelZabO9AH4g=;
 b=hXJVf5E5q+HtnMybfWb0gc6vDAMyJV3iaAdIQW4iIK7pgBjTn6GrEvAvuCfmBVUybpP2sF4vZvUaBkBDW5gFjbEvhQH0d2Pmd5IRResfrOqJQ8dLsf1ge5Cr8R2b0xlVR2H/ui5PqewuB4BNRqf+Uux3kIvSQJNMRd5q2/amwA4pPDEeBTp8ZCr8ugqkOoIAA4lih71dvknH1W4D8SJuve1LDUBozfYFBAsG7Ejyqh7PPUq6650dDnXy4GMLXjRTlpU4xysgJ/E+GeN2z1L8Spv8N6TJhXg63aWIsBkTTNYVfDkatJIx0nBgKYvmCY41DX0bXc81B1ODmmLzTAbacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHlqTJzfmIFSg2SFBBv5hNnlEu6EjO6pelZabO9AH4g=;
 b=Q5r4ws2lLK7C55PxNaA2Cokb6xnCj9rjhNjDzByko3heTTDcRNBVfpNhOIzb5Ju8bE8FV/4+yVVq1nW45OVKDrYjt1oFkovYUehFIrqySN3vH3zmTQt6FpDWXIArT9K6W6in3/rgAfi/gHkOZV0q8gcnuZF/IOIVel7QG1v7tQN2QqCU+FdzVEKT5GQLpJFX5b34MnrOQ3XorFCsSl1+uZCyuZiFYILSKDWOTGm1v60l+HuNwiuuSSI7HBT1Emee8wE5pyv46lFj1rI85RovdaDA98lZCQW3bL77kl1CzWqsQYIqNYh/D5G0EviXBimbX7C4hiCK8enMUWSlrMKFXg==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PA1PPF75DB7739D.EURP251.PROD.OUTLOOK.COM (2603:10a6:108:1::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 20:48:27 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:48:27 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] clk: qcom: ipq-cmn-pll: Assign .num before accessing .hws
Date: Sat,  5 Sep 2026 21:48:25 +0100
Message-ID:
 <AS8P251MB0001B905088748016A0965F1C8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0520.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::16) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905204825.31862-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PA1PPF75DB7739D:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c185ae4-f06a-4e75-70fd-08df0b8f0967
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|5062599005|23021999003|5072599009|15080799012|25031999004|37011999003|41001999006|8060799015|19110799012|25010399006|4140399003|40105399003|2607281247196008|3412199025|440099028|26104999009|19061999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/DBau5t31doa8F2pZ2Wy6+zEGFU7/s8xD1CWB2Ll2JHvT9UuvsXJ5r/NsGh?=
 =?us-ascii?Q?fVhau/eSRRveZC61W0Ctc56vbu8/0T9ygCiCl4+2Fa9RC8EzOBY0V+lxS4gL?=
 =?us-ascii?Q?hfsqjCrHfBpjr9Irj74n2lekvN9snUBjoVHO8l0A8BL47yewnBBUNO5+KIMb?=
 =?us-ascii?Q?S3P6FP1Gb+LB5YVgO0MC2CihQY07AUtGkE5i4AzM8ZfUpcrY+BdsPeuGd6wc?=
 =?us-ascii?Q?akBnSTS+d3FhfMZdHwjzjTlCvubcdNdLUPta9wJLKOZAcCMysnk4UVMex41w?=
 =?us-ascii?Q?0rAA9K85rmo9mzbFGPCJO5AmMAje+HkAxlwttKag3GX3yLVzXM7V+Ncv+T2i?=
 =?us-ascii?Q?EWMURhzhfJu79Nz0sdU00bwD+y7AuBiG3ziPHRPfF0e540bwA3KLV5fq29IH?=
 =?us-ascii?Q?vbdlV5eptLDQO/2GxJEln4Zua1+OwGZDLX3zH1Hde1VNXiCvSn9TJ42JcUZr?=
 =?us-ascii?Q?80prtnmjXBYLvD48v18EbX2y1pEJKrhpdBqZ09YvDdtwY3WGyn0TtPEf3V08?=
 =?us-ascii?Q?e0Yvi0/BDklDr8PTF46yrN+YeRl9Kx96mfxojagYf5il5fqKr2cefvwG975d?=
 =?us-ascii?Q?pdj5J0QpNi7nuEBROm6AKQtfP5cSnkkOsEA4+Hj9S0y3nFi6xk3gkWYbFz3z?=
 =?us-ascii?Q?o/1GMgQ+hfUlp+BOEU+qMWpUgWM8+c7meo6WQTqWKFS+rv+f4m5dQ9BnD4Ay?=
 =?us-ascii?Q?JTf5B7VNcZCse3t31tyQ3Y6ptCiql/cJpCCb4sX5JIRepi7AnJnYPrvUs2RE?=
 =?us-ascii?Q?KIFoZzDb+97GPgmCzAqkbyswtDSpV8NQq4RzN79CcfkuYzuBGOgGFvNVpMbW?=
 =?us-ascii?Q?2LiY2SN+yFWzCs5u3n9JK4SY7IQUq4QWNp6qsk3ONY55hCHq5AL02pBCflbA?=
 =?us-ascii?Q?OBauj4r0gE39J3Blfa7u6cj+D5vf+iXgNEZGiGkz4sVdpxo2f09vkZC5HY/a?=
 =?us-ascii?Q?4dSFT7ihSEpGwG66avigKtOCF9GIMr9RsOf1CiHOA2Dvfn+HtihnFY8aMiDQ?=
 =?us-ascii?Q?cD8wLMc+IRHm6X4qdinTsuHovv4MQWiUSqGKCTzo5tlaSFAQqZElAUaD/3sU?=
 =?us-ascii?Q?jWUGu8GNb6+wKeF38yBCROH4nQ1Yt53kLAr5pXOJ4mvRWtflQ3k1/3OP4IK/?=
 =?us-ascii?Q?7KRoiBK8qZ1c?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHyXMMFtY9YETaQNh46B/XH6imWTyR/zMtndjIJSyBB0VGcjPZKwGg3nUi6Q?=
 =?us-ascii?Q?l1kcc3yhnWq170LOjcn8rKXRNqDhWhJDFCaoSnLD/mPRzqOWwZWUO1VBECXE?=
 =?us-ascii?Q?8sRBwnLHqSXMXfryqhdkFi/bOVbUn7IiE2VcMLEWwhcKNzUGIpFsP7ed0Gns?=
 =?us-ascii?Q?3jFrLckSz2BcdbrAHsgJ9pM3e9cM5etmnRNuCBY4t5ahadMN1UsfcTLL2Taq?=
 =?us-ascii?Q?QtGrHCg3HV4alnZvMo7JO20naozRUIYtqaHUSXCjIx78m+MU4+AG3hzsqoo1?=
 =?us-ascii?Q?IOJR6KBKSj5Ur2Bs7GSRUdX51XlAiC+ROM0BxVfrxe9wQn2uo5WrddKEgdXh?=
 =?us-ascii?Q?9Zx7KzKtUIgUs3BkCR9uRbaqJj0svXEz2VAWS+Opa3qgXb7lL/JhRB8f9WHt?=
 =?us-ascii?Q?MfzumfQTC9uJf5boGdbC+kE9xwnGOXKlel0cc1xrXijCSfAXp7d5U3fZE/w8?=
 =?us-ascii?Q?lnMDdvOjOeldsFfl/PSXBQVjVH0KuQBUJBCPZYy6EAcQNsDZTufKXsB2VpEu?=
 =?us-ascii?Q?VJqMBH4MvcJhKKJeisvp585aI/9NZ9Tp4U1stpwEs/T6BHIkr+LcLu+/zNbX?=
 =?us-ascii?Q?qz4mdl3L167swaxoUfV7TaL1AiSBit13Xd/ML4Nj8ODOzMwbHMmS20jqY+fD?=
 =?us-ascii?Q?35uYT6qiGFVW1F7GgwRylG8tKxrNQO+xIofX3BrYVNZkXnKCDp1/8bt+Nhii?=
 =?us-ascii?Q?KpnKARSTiLAEB8O9LVJEXi3QbS1HpD0AvgEeTNAj6XD+KqH5QygB6Eqzwr1+?=
 =?us-ascii?Q?0FUq2iiRfO9VkbBZ3QVegJXbsED92z9YrA6JUIjsBn3kmYSt/ZdSPqiTL//3?=
 =?us-ascii?Q?5sJLP3xUv8IUO7NxMWFVaDD3KxRPZR3LH3DV4rC2rqI0ihwQz5iooruTRB0o?=
 =?us-ascii?Q?vsNqoOFr/raqRiYmZU0bZ9PMZAUSSWoQZCcamXvJttfC2GG+mBWtGnCjQTxT?=
 =?us-ascii?Q?al3zYrnQJaVksYaGv9r9oP/9OvXngEajmw8F2uG/dPeg8+2WYlirodLVenzh?=
 =?us-ascii?Q?0TXAT1+2jUxPg1zYOAupTnsT32EJezOzfNuiQP4Gfp709zFsIr6odN5RUeus?=
 =?us-ascii?Q?BoM+OpYnksKtne9CAhsbmm1IP/c6Yz65CiuVnJtjceeY3X1BL4j3RAdzSgeG?=
 =?us-ascii?Q?wfEayJrdVzjNLx5SadAM/cZRmAxPuCuLUNde7qp62gkivtF9uAdOzOZQlAN3?=
 =?us-ascii?Q?KHtVysGA1cng4bcNbApVt7Zs1Lf5SCIYfkp2BUMHLe4RvCTurxpwoyBvFmzt?=
 =?us-ascii?Q?u76RnwqZQVOuJelTMK4Gn7iF4OKSswhLk9FajAwdT2yu/GJRZZQ0JV+PcIsZ?=
 =?us-ascii?Q?mgyUNbzn9W/DPbi+n2vzXoCmSiMm2m5IMZFB1XzvjFiJUHpcyeiFeP9g7K+N?=
 =?us-ascii?Q?yP22gGe2ZKbFTek3QWtHTqb90cwV8QnaHUdrAVLp92xwdqlip/E6n6TD8KOm?=
 =?us-ascii?Q?dZ8fUY/WpVAYIfsTvRvLkOeGdYhMFJza?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c185ae4-f06a-4e75-70fd-08df0b8f0967
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 20:48:27.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PPF75DB7739D

Commit f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with
__counted_by") annotated the hws member of 'struct clk_hw_onecell_data'
with __counted_by, which informs the bounds sanitizer (UBSAN_BOUNDS)
about the number of elements in .hws[], so that it can warn when .hws[]
is accessed out of bounds. As noted in that change, the __counted_by
member must be initialized with the number of elements before the first
array access happens, otherwise there will be a warning from each access
prior to the initialization because the number of elements is zero.
This occurs in ipq_cmn_pll_register_clks() due to .num being assigned
only after the fixed rate output clocks and the CMN PLL clock have been
stored in .hws[]. If registering one of the fixed rate clocks fails, the
unwind loop under unregister_fixed_clk reads .hws[] while .num is still
zero as well. With CONFIG_UBSAN_BOUNDS and a compiler that implements
__counted_by (GCC 15.1+ or Clang 20.1+), this triggers an
array-index-out-of-bounds report during probe, and with
CONFIG_UBSAN_TRAP the first store traps so the CMN PLL clocks are never
provided.

Move the .num initialization to right after the allocation.

Cc: stable@vger.kernel.org
Fixes: f81715a4c87c ("clk: qcom: Add CMN PLL clock controller driver for IPQ SoC")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Found while auditing the remaining clk_hw_onecell_data users that assign
.num only after touching .hws[], following the fixes already merged for
clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
were drafted with an LLM assistant and reviewed by hand.

Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, via
COMPILE_TEST with CONFIG_IPQ_CMN_PLL=m. GCC 13.3 does not implement
__counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang 20.1+), so the
build only confirms that the change compiles; the sanitizer path was not
exercised. I do not have the hardware, so this is not runtime-tested and
no UBSAN report was captured.

Based on v7.3-rc1. Checked against the pending IPQ5210 CMN PLL series
(v3, 2026-08-14): no changed lines overlap, and the fix is still needed
after its first patch removes the unwind path.

 drivers/clk/qcom/ipq-cmn-pll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/ipq-cmn-pll.c b/drivers/clk/qcom/ipq-cmn-pll.c
index dafe8c1738d..a9abad9ff4e 100644
--- a/drivers/clk/qcom/ipq-cmn-pll.c
+++ b/drivers/clk/qcom/ipq-cmn-pll.c
@@ -380,6 +380,8 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
 	if (!hw_data)
 		return -ENOMEM;
 
+	hw_data->num = num_clks + 1;
+
 	/*
 	 * Register the CMN PLL clock, which is the parent clock of
 	 * the fixed rate output clocks.
@@ -406,7 +408,6 @@ static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
 	 * is configured to 12 GHZ by DT property assigned-clock-rates-u64.
 	 */
 	hw_data->hws[CMN_PLL_CLK] = cmn_pll_hw;
-	hw_data->num = num_clks + 1;
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
 	if (ret)

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

