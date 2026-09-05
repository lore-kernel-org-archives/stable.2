Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013079.outbound.protection.outlook.com [52.103.46.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825C399CE9;
	Sat,  5 Sep 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641321; cv=fail; b=qwWwaMLv6H0I6vS62fA2tcGteRX19G46BWs+xdj977P6lpDpcXqxYro+uWJq6He8TRYxVI0AlkdWMrp6Td9CRDndWTrOh8SEM0NhSIuH85s4us+wNWnGYI4Y5N07K2eRGnZPsOBSsTsY0AMHoKnHemLXn9Q0pcPiAVRYvkqHmhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641321; c=relaxed/simple;
	bh=PQwIpBJpb/AOVBnl7z52EafA3otH0suhwD2bjKRj68Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kvoVBw+iHSjv8pGgjnuecaVqB7TOZtm9FGBZlUCQrdkR2p0DnLvoI6/quiOcOVjJ7fcHeQXon4pD2Mk1b5qQWtfTtcOCz079k/Gb2ozsHAKtPbg9m+yJ6LGh6PcEnIpGwng0JKcRKzeRbhPRAIoTVimW3ksquwllLcek7/m0aYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=EU0SKtCa; arc=fail smtp.client-ip=52.103.46.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="EU0SKtCa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhhCfnMMlnniPxGtlm5ifUWGEf8P2NPoP+gcwIfHDxB+fT4nax8FwpZHlWBAPHYyPk3r8HVCf7eebrQZ/wlx7wi+2UDB88qbrwFLVMVOCv9lR1G/YPmCeYh3xAor1OmTshYYE5CEZ7m+jE43BTVqN4rWqJbZKCcMrx1tfvoLmphCcG/5tiZWOImAVhoHuh0RR7bQpiUaH5Sk23FkJ3l1ZkMFDZh50S3zehzH9weZupGJDvJVWCDERveq205LyekIzSSO1/8MPf/YHN8aHwtaaCpvI/fjqDJHhETDJka0x+uq/n710RdFHtf+HrvP/9INMazSS8648OAUgbNrrGOYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3w4Yk14nyFFh/brlO5Hr8U1Q7mxP/NsSMl2kOvQtjs=;
 b=ClYuDgRYj/BFBtp9Hn1k9w9hPm47EnMLZgmfCIoA12vbQqTdkpV0JrdXkFHMHlQJOQ7g8dzlawC7SmPIYJop3/TE/SjVnILx25xtzL81nS9vMFuabXKKCt2EiKgx8m8LG4RfxtvaGbBmbB7KcLqRBXXEuL1snYqsjmmW9rSL1kZ7iZIVCQZjLp0I4yHLWUGmpT+Ub7WrXRthX7Cpqm4HnmKMA5wUiWa27WipSkj2eCjWqJyJHQJKUxIqCvORrihIOpMqp2YX6a84/kU0FqFBQsJc1Jnj90QYfYcgDDr1VkhLJPXTIxvDFoI3J4BUvd7kfH0z03zxa6B2lsU1RLoAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3w4Yk14nyFFh/brlO5Hr8U1Q7mxP/NsSMl2kOvQtjs=;
 b=EU0SKtCa4/WRXlJwr8j4IKJOJnXONXJWh4Zm6wepdl6D+PyRcLYG/0hvxNlZ5oM+bKssD8oWoXOc+cvSXKboXFndlShyH96OHccG5Zgcv/JsaiS1LWD41wRG29Kz7G3FGC38uTi36gZMJm0quG3sZcBkIDeO2jPSee56syh+TtHk/CvXNVnP5ctDHB84AwQx+aYo2KlsQUTTbiqyPZrtmJbah16c/+NpyR/Ax3Cy5t3gOs8s0TSXl7tX5EYwpBag0TxQW43KI3jW3k+bYbMEzMrqFvjKhiVq5eJOA4UQMU23uf7aF1u/ZF2vcaiSZ0vREb3vNd3YfIf78RO03MEsqQ==
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:344::22)
 by PA1PPF75DB7739D.EURP251.PROD.OUTLOOK.COM (2603:10a6:108:1::21b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 20:48:37 +0000
Received: from AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352]) by AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 ([fe80::2952:d4d0:4ba:8352%6]) with mapi id 15.21.0382.012; Sat, 5 Sep 2026
 20:48:37 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Drew Fustini <dfustini@oss.tenstorrent.com>,
	Joel Stanley <jms@oss.tenstorrent.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>
Cc: linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	stable@vger.kernel.org
Subject: [PATCH] clk: tenstorrent: Assign .num before accessing .hws
Date: Sat,  5 Sep 2026 21:48:35 +0100
Message-ID:
 <AS8P251MB00013BD9A093C06D2D60E10EC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0508.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::10) To AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:344::22)
X-Microsoft-Original-Message-ID:
 <20260905204835.31915-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P251MB0001:EE_|PA1PPF75DB7739D:EE_
X-MS-Office365-Filtering-Correlation-Id: 8778006b-db2d-4fad-90f4-08df0b8f0f4e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|5062599005|23021999003|5072599009|15080799012|25031999004|37011999003|41001999006|8060799015|19110799012|25010399006|4140399003|40105399003|2607281247196008|3412199025|440099028|26104999009|19061999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fBDMVDG38xWZQYWgKik6uq6DzGKDX0khX0awBwzty2C/L0xvd8EW/F5wPPNi?=
 =?us-ascii?Q?K+Fi4A8b3dBXRwigkKo/e8FNwqO3/yuAmPIvZs2m/xa98VYn3Drq0hlIvtm6?=
 =?us-ascii?Q?yEbC2GiZMfvU53OtUmB0mtmIE1A3yyI1ughK6VekA8SWxNYi4A3bJQ3/G8YB?=
 =?us-ascii?Q?oSu8vXPrc3ngO9+5/XLtyHzQks57WhSiy8FXhUg3oW3UGmiz/b3BAOhIQ7UW?=
 =?us-ascii?Q?Mk1XnYARDRoW34Xi3dv1K0MVTYP497lJvkyxQDpwkjFt9cJ7FPfyG1QlS5Ub?=
 =?us-ascii?Q?51+PzlO+hkatHk0byximq1tf81Ntjs5IQljULMTq+dNMjGfofr7Zc1a+ujzh?=
 =?us-ascii?Q?zqLE640TywYFh3nGvEhLaU2d3HfEb7R2W4cJsJkFsHU00SkR8KCshvkCav0/?=
 =?us-ascii?Q?EnmLOOS1vXG/YzEBGc7SdWaE2W007YViEyv+T6DDAu5NAbAGbLRWlVuY8Ixk?=
 =?us-ascii?Q?KYG9x6cO6Rj6jFpZtsLaPSHz8dC1f5CJPzIIoro9tEPw4xGlLZe4lGvWlhl4?=
 =?us-ascii?Q?bFrrcECBteO48MSPPBB2ZIBFIRL0j6iq5DaiTWFceM4S46xeyb4oA+iAiq1m?=
 =?us-ascii?Q?UbBCaUqX1EKDw/WcZUYaM66x8CE/y1JJPhT5JbYaFqWT9URweS/St2MkJIkc?=
 =?us-ascii?Q?GVpBqRzU0egRnNt6KJU/4oHN7Q7BUOQ5v870qd9h/dJM63DbbfzQjgnPFN8b?=
 =?us-ascii?Q?qq5M0Af1tiU38jUICGxiDh4OtljUStMLpt+f9iS/U115Lf7RrotREOwBmzDG?=
 =?us-ascii?Q?ac1tphAKDCZg+/s+jNZ+ZXVdkFAXkeTSo9XvBHV72SL40xVgFAc+XVtgvZZs?=
 =?us-ascii?Q?qOoPopIMqMWu6yJ4RjdUJci9UFMVqf59K92NK5FmEAiIk9wjL6uwfMOBvPbZ?=
 =?us-ascii?Q?UvMV4QwRHgV/oMMySBHCY6EJRMqe4hrhfvrpD9IhPn/TwgnzUxvjU5j6Bgyi?=
 =?us-ascii?Q?d1ursvYOmWN3QXRFHQ8vJE8dMpDFSde915vfnHyR1RCa6RKU805yC0z55vno?=
 =?us-ascii?Q?1saI5MPa/sEcz+c0VG3I//mB6AP+4LRQx5XPAz2JC5yS8buKt9aHtS98iRzj?=
 =?us-ascii?Q?tKogZpYEc7FDgSe9YzvE5Kg/LEyz7g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hw8pR8z4fKUM3wdCqFL/rIqSSwFx8DaK1EJRWfaIUEOBfEAkZ/+D7JVN9SQd?=
 =?us-ascii?Q?8TGOEGgzcEE1iuPzYfRhcg04MDSeiXdLuPsIClUOwu+RhhFe/YRQt0xTRqy9?=
 =?us-ascii?Q?CXoLODjwe/z4Yh55cHIM3unQBHG/9AxJZE7ZbC2JyTUaU4+GAvSKA29crCBL?=
 =?us-ascii?Q?zV2cX0KOBA7Eks8KyFF4R+VxJEsRX9+StChV91z0g/8DyYFqlBDs/xiuOaQv?=
 =?us-ascii?Q?mnWp97MVr3wcpoF7XH+cS/4Njv0TXhFK6VdY0tmKt6oGb2LyzGxSge7gafZW?=
 =?us-ascii?Q?tqOI2V79xvL9AymgPY4pSne0hcM1GY7qNpgIC9OA3UKI/9Q05RplQNs1/O27?=
 =?us-ascii?Q?puYE+dPVJmY/ei7vPB9MDkm8CTfxcMXjMWQRX3uB3oSh+/oje95RWq54UFJT?=
 =?us-ascii?Q?coTzKI7Ir5g9H9y8A7mogEsJLNMsMqH1NcAFktVhs4p4MkB0kdxIH+RmE+RJ?=
 =?us-ascii?Q?oRpkCJLL3/3cBdmJF1oJjjrkXsWyQx1GiNld/rw6U5LBgfooJDDWIwLYlITI?=
 =?us-ascii?Q?YFFA08nCCrphYuHZYXNeN/3J+EVaf/MjGQ9XTVY5pYoJLKLCcblDQcytfITF?=
 =?us-ascii?Q?d7OoYaMM3fQpbusunxR6GmHi8VhBtEH2ANzckeARcL4lorSdRiYu7sU03+rJ?=
 =?us-ascii?Q?XXrzrd86bxKpHy/ni8e1Gk1Z4RCscnzdqjpxEBD2kzUMm9Fogeu4V/Mn5hB2?=
 =?us-ascii?Q?6JE8fVWvz5oMzxnjzCvqOfJNpxpnIgClr2TIepjtB4VhzXUF7HSm0w4shsSG?=
 =?us-ascii?Q?WCCk979gfoveixX4J9pnfExTfF5B/zcyI3k4NXGxrAaRgBo8ru0TrWLVmZg9?=
 =?us-ascii?Q?PXLrFUEKXOEuyEB28DVkJLyHs4USByw1N9NEivT7zT28rvtu766/SgnqRU9M?=
 =?us-ascii?Q?nFcz30kgGKvUx6/JNTQ7ltEqLrrs86DJjoyz2bdklSpRA/ub8fsI4+ZELs29?=
 =?us-ascii?Q?7oeBXTZatTfZR5XCktnPE2L/UyOAeHCuls6JzSEzXdi/SfNbh6N/lBJH9pIJ?=
 =?us-ascii?Q?8hOuednyZxZhhDm2Tus/UR9Y8Vu9hWFV3b2o9QMcJYow5JCfPKBjCu0/6SxM?=
 =?us-ascii?Q?7f9Ue6qEMYbFH82Hl0tKugKNG4NARyfF6aOLmuuIIMZhJUmUsEN4hyLTa9TN?=
 =?us-ascii?Q?KZJL1l8TAtkyoN2e7h4+NI+Th8csQ/TlXTWks1o77QpU1r+ITUKqE0H2K9N3?=
 =?us-ascii?Q?0Rd+jyog3+t9BZ56MBAekBaBDhj3dKVf2ARF+wPl3WZuLq4Yk2CfmVl8fGNl?=
 =?us-ascii?Q?23mxHatpQOjbeWoHtetImSZDU8Ns1d20cgorFYCgeVmHyHLVUS88YCNFkwus?=
 =?us-ascii?Q?i23S8j2uhJLzLVBhWRVgQoNTJpk26M5dVib/43grbxlvj/ArVHc65zEI08EI?=
 =?us-ascii?Q?2N9jrgddg6QVjbKZLbq9bypvbafgjWT7iXBkWk30gUI8Sh+9qkOKfsyxs2ir?=
 =?us-ascii?Q?iDbXZklATIUxOuMG15D0PbNO51spc8gM?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8778006b-db2d-4fad-90f4-08df0b8f0f4e
X-MS-Exchange-CrossTenant-AuthSource: AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 20:48:37.7059
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
This occurs in atlantis_prcm_clocks_register() due to .num being
assigned only after every clock has been stored in .hws[]. With
CONFIG_UBSAN_BOUNDS and a compiler that implements __counted_by (GCC
15.1+ or Clang 20.1+), this triggers an array-index-out-of-bounds report
during probe, and with CONFIG_UBSAN_TRAP the first store traps so the
clock provider never registers.

Move the .num initialization to right after the allocation.

Cc: stable@vger.kernel.org
Fixes: 23c8ebc95284 ("clk: tenstorrent: Add Atlantis clock controller driver")
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
Found while auditing the remaining clk_hw_onecell_data users that assign
.num only after touching .hws[], following the fixes already merged for
clk-s2mps11 (3e14c7207a97), exynos-clkout (cf33f0b7df13) and
clk-raspberrypi (6dc445c19050). The audit, the fix and this changelog
were drafted with an LLM assistant and reviewed by hand.

Compile-tested only (W=1, no warnings) on x86_64 with GCC 13.3, via
COMPILE_TEST with CONFIG_TENSTORRENT_ATLANTIS_PRCM=m. GCC 13.3 does not
implement __counted_by (CC_HAS_COUNTED_BY needs GCC 15.1+ or Clang
20.1+), so the build only confirms that the change compiles; the
sanitizer path was not exercised. I do not have the hardware, so this is
not runtime-tested and no UBSAN report was captured.

Based on v7.3-rc1.

 drivers/clk/tenstorrent/atlantis-prcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tenstorrent/atlantis-prcm.c b/drivers/clk/tenstorrent/atlantis-prcm.c
index 6d4386eeb7d..a68534a295c 100644
--- a/drivers/clk/tenstorrent/atlantis-prcm.c
+++ b/drivers/clk/tenstorrent/atlantis-prcm.c
@@ -796,6 +796,8 @@ static int atlantis_prcm_clocks_register(struct device *dev,
 	if (!clk_data)
 		return -ENOMEM;
 
+	clk_data->num = num_clks;
+
 	for (i = 0; i < data->num; i++) {
 		struct clk_hw *hw = data->hws[i];
 		struct atlantis_clk_common *common =
@@ -809,8 +811,6 @@ static int atlantis_prcm_clocks_register(struct device *dev,
 		clk_data->hws[common->clkid] = hw;
 	}
 
-	clk_data->num = num_clks;
-
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
 }
 

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

