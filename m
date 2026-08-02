Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020143.outbound.protection.outlook.com [52.101.152.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B58519DF62;
	Sun,  2 Aug 2026 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785668130; cv=fail; b=h4P+hGKg07npWWj+PjvWbZOR2rnw7BJSaQ/3tk4eed+px8sdWnVCq1GLochy0QX0jxmY8XsPlCrcx/e7Co9+3ymZe7cbXejJulAOgPmmvW8J2n4mCyKhMI9j2IGjkRKldi3EnOW4faFe5n6dA9ocGw3pshmMDsnLEAzSdTt2EUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785668130; c=relaxed/simple;
	bh=eX9GGqD5MKGudQ8LvFoWGZySxHvdndK2hSfrSkCfqAE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=HjpevTtuGXsWl2tf/kfBR/qsnlVFxyR4Z+NV2Bc5RyS3zKfVFW37ClAZ5jU0MDaP3m9k2wGB/J7mUNVpvxoJnxks14hj+Kf/3caZvFdHD6L1OPipw5hpPLh0753XKiKAgMzMKCN6wMRdKFbRbtEXrpe17COAhKj21SIz0IkJDwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=52.101.152.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF0moSV093jkLs0C+5os2/Qar8izlHZjs80WW2GRgiWNfAIhDt4veE1v3vvNyTIXMJO0/pGBELOG0qFsoCf9qJvCU/hvUZ9Jns92JedcPfAMh+AMFeA7WJ+TodIYQr2+7MPC1O0nKuBpMv+KrZ8HiuHYhztxdGe0pefEsYXJk/4aw+3KPtJ6YtZrTAGRR2rpkNqsP/MBTjOUyZJuzTY1QyTmZK3hnwHrhq1q/kOcxtqshMBGqM16n8vgStuAVHlAYqY0ULnq9uOA4U0GzJCydcJ0byxvsjXvo4MJDvs6cnRjk3vV1fzzpRfjfUgCWTD2CXVCRlDu/eMc5+nC7o2vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8d4MflChzYxgs+16eeEucZVBN7Rozihw4bYXT1KIOE=;
 b=aGUgxstWQf4pyCcg5dhgu0h3neYv0Wk3vA2U5kdJb8uWW9+wfkSuWPVE3IIE9nhtoE+X4HPAaUNGALIVkGKj2arazXnVEkrolUoHIxzPhXmzvBhKk3JS4lhzIPS8S2FYK4RsE7BWaqwrmIH3ERj2T64GcK4MKTo8YL56cf7sm9TxmnXqCWZBgCJIHSjXfWL0UUO3OO+D3J4Fi1SurkCbRuU8J2k4AyMJePqihnzjMqzC0IEtuB4HsdMKipVMjx0LOxhDEW0Cww2iE7gi3kz+WNTkVliO/d8EfZz4a0RLUHtHr0uft4dJhOELMA/ji7DsPX1+FyTzYdZA+us92aR6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY3PPF7288964DF.AUSP282.PROD.OUTLOOK.COM (2603:10c6:18::31a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 10:55:23 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 10:55:22 +0000
Date: Sun, 2 Aug 2026 10:55:03 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, rudi@heitbaum.com
Subject: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name
Message-ID: <am8iBwJSEhYhWTqk@6cfee64030a6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWPR01CA0178.ausprd01.prod.outlook.com
 (2603:10c6:220:1f2::14) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY3PPF7288964DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 027eb8da-24d1-4bd0-4778-08def0848d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	AYw4At57J9no0rNxxrGEcoevQ4UEkyXbQ/iYm/tFEoec319icJJ2WwULlq8SekPcO8zO6D2iAW/F0uXyE/Y2LWCGQERKNSe6ghOiHk+myj7eegMnaMUv1gQrMIO7Q4DL3BhXAPK5wzIxRD/z3LCUPW9LkF59Gfd+AMmCdQWRv2s2CqgRE5Ai2tRgHqW5hFCwO5uGytIRqjVDqhLeSn/G2WgePwYyQnb28Ko3/8C5pC1a6s1Orw/lYOUtiOeDGTWUPvdbdu1wHGEzwc7o8aSwTiWOsbCxrZGuzUzoRj5NOBAPhbsKbgHGwF41Nz0T0hWigm7OTYYOC9dAB9gdmkQp2vqB3m8g8xPAiK0wHTCzVOZ78nbeHFCSRlEtUrSspbdbT4TKc+hlPrkuyfafmgtXV3EIWA8sasw5ZOEZXbQIMRG9FPrHiYI6YSbsAiR3NACfg9OzEmzSbCt7jQG59HxzFAR047eCnWYhkN07QvZrfGTcKyf4V77isaNDqtBjf59xLwkAOirSlJKB4J9YDB7ZUqQDEVjVRwJS6ILIkoD8y3jA7fH3Rv9b1Jc5AcvuR/N/jF2pTbRR9ldeXEyZU3mU3JTdPqbE+cFg2kEfOn9LVjBqCC26nvOthF3mdIBV3CSMluFpZbJ2ao7D5c1bVbfZNcZxR/1XuMBUHeNboeO/gaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/3bnuCgIb7QERcFjxdnQFytsMG+egmGAaNqhfVpzg3j9WCRNwIbALZ/DumC?=
 =?us-ascii?Q?ONs9PT5yZYklrupPSL5UiYOztthoKA0s+qpftEdZD1ZdUV9SlTBe5Mbq7LnZ?=
 =?us-ascii?Q?5THzDcX4x6uG+Qjm1V0u0SA2cR7PS9jdlofrVE3tPIsee8Ylf53WleovGxgj?=
 =?us-ascii?Q?dY1Xl3Z5nzJm86o4ZcPBTRxJ4hf09sbCtZ5In8UwnWF+zsVqVsd+JuGELoth?=
 =?us-ascii?Q?wRpL6pFUc/FWypD9cYFYgZwmFt653o6Qaq6kQz08Kl7RpFWjb3DfxVhprQzL?=
 =?us-ascii?Q?mVlv61R6R9TNWA/jYClgVri9f7ofR3sAx8nYoDX3ANPq1aIW+YGZ5HrMtViy?=
 =?us-ascii?Q?O/LKdPSibfXZDXzy1sDUpSiKhsJ4gDgcNHgQMhviuke8+33bBsmjI6Z+4uCw?=
 =?us-ascii?Q?Yc4r4dR3TxKZykLAcwDCWV3RTGRdAsH720qHTmKPcBVKAghlLmf9ec77ESI2?=
 =?us-ascii?Q?xD+uFsixJVe8Jwk1sD8XWDdHYHxyKidDI1cVQo8MykETQZBc4nGR9RIyPI4P?=
 =?us-ascii?Q?mpyCL/mNNW8i8evEgao4DuaJeq0QGvuRwHONzIZDxI43d+WEz+QxAdWKDAjS?=
 =?us-ascii?Q?WZ0RKBgHspEtst5i7h0nV0ssjbjeAZ3uSjBkSbKn38hp+3wP78cr3sHFL4Rp?=
 =?us-ascii?Q?YITuyE4mSIGR3T0JGvefhbHa3z3h7iAvK72MBE7oEhbPRyaQTt7t17HmjXAn?=
 =?us-ascii?Q?kunsNmL1tlQAHhMZdI8bWSKvQe1kNINiXyNdsuZO/SLEqYjdxNfGZNfPaJmN?=
 =?us-ascii?Q?Cw4ZZvBvTakpSgmhKtlLhyPxKtMNAq9IQTh5Md+C/XY83/IiQXFU+yxbd+8C?=
 =?us-ascii?Q?xWSC8mNRk+YnhvtPa3X5lrYhsAfhjrA2dqK9Eg23bO5mb/DF0weJ5lKm2C3m?=
 =?us-ascii?Q?e6csGsvTUBd9JWjaapmfVNvPmMj/BCip5EgJvwHb6QgxadZ8NkPVqTNjHYsw?=
 =?us-ascii?Q?5YNsDWYtg3zlEUwcZ3+ebZzAJgjGUZA8QDqYnbygMX8At1admGEKUd8DHi5n?=
 =?us-ascii?Q?AK5EatQglGGZpsYTSKSMXpsqe4GEIcI3d02nS56QwnOfIHgq288m2yFgopVW?=
 =?us-ascii?Q?kEs9xz3pXigJT3xwHBJeBUUmA3+M07ShYBRtvVo+bDpWu5yTmMvdAtsd/Nm1?=
 =?us-ascii?Q?nz/C62pTTV6A++TsRRfOsUtfMpJr7nuqSM8i64EjYELoLmoOws9MbWbLYYMu?=
 =?us-ascii?Q?oPT1E+hp9T3cgWxQ4z+dUgda1L/+rz1gtGbldPy2srb1FptG6WupYsAlu4Xc?=
 =?us-ascii?Q?+IQ3/IXl234pKWWeav3jDpE+DMS5MPmulRz/LoBKuxPiCR7Uel4pwb88MQbf?=
 =?us-ascii?Q?w0YndYePmB2AW9EZfZ+J3Z6as3K3iZN5XcP9ygqW/T++ehGHtEScyIoUCdd0?=
 =?us-ascii?Q?h/pvbZGA7kbn4vxE66LVMH0DAIKIaAOX0wMq9rWNuGOEJWNwYV/pKmL4KgLx?=
 =?us-ascii?Q?DM81RSEk18pvWHYMgRJuWNd6moUZdqaZgzVDjp8GbGvQIU+EBSi1CCprYLqL?=
 =?us-ascii?Q?YMcHUeq9fkXJaAFlmt7KKF06K8cMs4hI2muyY+8YBcRuSLpZjoxccCZBJUuD?=
 =?us-ascii?Q?SPcYbqnhn8W56JxWGVF+WrKXxAoW5Szb1cYwfmjUnuw/RoQMz1ONsck7ye+2?=
 =?us-ascii?Q?Ma4gswVh6ivsBqNrwQG6vLWZ8CY3Z5mzt+57qPzZRooo8HspUCoQp7/XG08S?=
 =?us-ascii?Q?tLzZGd19rSp9NGf1nVB3CfJSNnKr/gY0PpUTOPtHW5SSj9Ej?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027eb8da-24d1-4bd0-4778-08def0848d1b
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 10:55:22.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73TsI54idim1caS3KWJPAYYsEy5Hxq6SWvGws85AMKFWFppEq1Vis0VYjnt5M07lIWChZfLxImUB0MzTjY7GlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF7288964DF

of_clk_bulk_get() leaves clk_bulk_data::id as NULL for every clock that
has no matching entry in "clock-names", which is legal: a node may list
more "clocks" phandles than it names. The extref scan dereferences that
id unconditionally, so such a node oopses during probe.

Check clk_bulk_data::id before dereferencing it.

Fixes: d8574ce57d76 ("PCI: imx6: Add external reference clock input mode support")
Cc: stable@vger.kernel.org
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f7389b5437df..dcdeba1856f7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1831,7 +1831,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
 	for (i = 0; i < imx_pcie->num_clks; i++)
-		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+		if (imx_pcie->clks[i].id &&
+		    strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
 			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
-- 
2.53.0

