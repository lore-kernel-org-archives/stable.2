Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDA45C6EE;
	Mon, 24 Aug 2026 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587227; cv=fail; b=m89G7wpoHwetbAVEm2C4wuMSZ/OCUFxxGhu7viG6lZCS50UFRUT+a6Zd49WKMb2u7pKYd3L3BiUemDhjG+lCDuBvugV25hWBZFwHTJ9Q1r9FJTPJcW3S7Zu0N3iHLVtj+Yj8jxd6TiJ6ReKlQR7c+dS9KOs4/FdAraR99+Z8fg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587227; c=relaxed/simple;
	bh=9zVXBnewT7/ammwMaZHCSVCFSZ8SDtCQYHYthk4goWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mEi3jRNw4U4rGLNw+/izFMwU8NyBtM26uaGVcpeE95PpjW8UrJM6RPc7mvOpZeyudCfAjw0LlSkpaavLDY7aM0tHhzThxDh+sZk1R42Vy1CrZvJcFvwUSBZMXot9LCRCqX5mnYLQbi1Dy/GVS1MUxn6jcGGL+sOkldz9ETm/k8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E9ohPGVV; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9ohPGVV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvr5y4gvWit3uJFkWkmupUeTRst9M69zaeExrL+JvCUC3DA0L0ln7sgMTBUYqLWLdMuiJc3UHAP57TJL3cYZVoSu5jtC0Q7D3xYvuQCCbJqMZ1vTgcQpHKvjHYHB1sDW9FoXgGk8SfPqOA+uE1nrT7WlDWwWggYXFlB1R+KBTYmpch24OY92WSndtxdEP9tF0OS7WwM3jcG4soKJZqAUH8Z15pR4kPHZrGfNL5Ddi9F1JEDcZYPzBki5xOphpNbT7/WZO0+P/sN/9ofZ7lOtx2rS5r5BRygZLnk10NZZLvMtKU5VAvDPG9WhC8GKYg+yPmKEyHE+uBoguefwC7Inyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8C32tfkoD0u7LZKrSVZxmXW7MymW5keNiUzcZHl/H0=;
 b=gdz2RagEyEZCcyAYzafJlj2xc9QTZct0pJAGT6oKzkP+DXaTaya82wqvLW/oeqBKTivO22lJxB88StHcB59Ed/rbdMcU0m77GS8F2cqgvs00SzfsdV072iyupLqxgsoNA1/bqOm2xxwggg5ubdXeVkh3QngmdWE9rJ43g6/NpXJTPR9E26eCY41O5q21Tn/LHCdS/vtwUqOIdfRrnGhKainEmRbfMgBg9r7Gpu+eg1PTURTBSxB4GI2k59nbEcvyr0YxZOb4lxQxWDEJrBlHpPg0V0fEe4pbIj7ewx/7xjyP9dxxSbmWpL9+FD2QMhW77zo4RV9aLTeUljh+Of12GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8C32tfkoD0u7LZKrSVZxmXW7MymW5keNiUzcZHl/H0=;
 b=E9ohPGVVfL1EOm7/FWn6BlxNWxUkTbV59kYfPSuCoQQRPgsWObiN+hyEVjeh9kytbImzkSpA6epkWQ/JcWN3WS4E0ntauZLB8XQSG8QZWiSK+lHg2Bxtlm+VoEDKJGv93+afhdRDklmKevm+aAn13QzgIqpDdSsw+d2iT2aVWkHhPikA2mnhBeQrKzhGLQARJDqdfVkDxyUuIv9bpCdsZb4rH7IkjmUBI7Hlmb9/n7jw/ArP1eC6GZIBs3SCXzAOavOzNFochmxXiYybQLi5WVBurKvDWJfQcUo0g1yuQRSIdHcKbEtwdsJ1FZvrtRd1YifUa8g0vSn9rYpFQbNAtQ==
Received: from CH2PR11CA0017.namprd11.prod.outlook.com (2603:10b6:610:54::27)
 by DM4PR12MB5793.namprd12.prod.outlook.com (2603:10b6:8:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 16:00:17 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::f) by CH2PR11CA0017.outlook.office365.com
 (2603:10b6:610:54::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 16:00:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 24 Aug
 2026 08:59:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 24 Aug 2026 08:59:44 -0700
Received: from sdonthineni01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 24 Aug 2026 08:59:43 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>, "Steven
 Price" <steven.price@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Shanker Donthineni <sdonthineni@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH] irqchip/gic-v3-its: zero ITS tables in the shared view after decryption
Date: Mon, 24 Aug 2026 10:59:27 -0500
Message-ID: <20260824155928.2396620-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR12MB5793:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a82cbc3-af1c-4227-4721-08df01f8ca83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|10063799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	v2BMQqv/UsQFY87xjOwBYIY1xcrIOx12PXMoywuxdNfyb1w9lmtq8Z5T7xoRhXHwGgDuWrxzqc3zF4v5FHi5YykmLyYHuxftgdT5BHkDhTvkTInM4Sa3ORJYYryB3FX53PjKz9S0FZYqsXZnduzrEUdtXQZ5NsjgYtFAMMhmZwF7v3oOuAIA+N0ulp9/q4MLJLtXWxiIYbGvaSKO4m62vPgfWhdeOHcY63n+mhogoFNI8F9aVJWF7yAatvuf6y+oPEbqpF0pet54iZ2OpkKdaHeawKYhCrznOmER0xkd3FU1oifWGU5ecYmJnm3Fi0cCmWUwEuIByijkog2zixwdedkUEpz6GMLBmXWRXX5au399GfhI8Xqo9gfnPVlMQCr7ZK6DvkuZl2kly8Ylhwz0xVuCLMv1qXa5M5RpdjavxKnjlq5HrbIeO7C3xa8pX1/5n6zr5IPVeb32WEF6SiFOIsxC/VRxVhcJ5TcH7qgFTLGJEa9ok0bpOoB5aNAJB1yZHU2EJiepix+UycYKi16BWlfDql/4kgLywV00XqJg2WNYnSJEIiZ2N5yaJvZcXw5DROdgX5cKBqko1fV3BB2IHlviNbADmpHwNy5Qu5HHOYCUx3tJG5U3mGGhhcD7a7wzSf2Di3SokzeeXVL5Dqn/0pnKyCfp/1owOYYs2Pi1680/Ra7ttEBVZHpHoSBnLyx/r9iMh/cudrpwXImDIrjQkQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(10063799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/6BIWFFzraKf+Bm/sZ9/fw6Ea2WdQqDucLxV7uYipXIuJtYrRl8z5ZE826D1FZT2pPpXGZjse1RnckMR0bF/BUe2/OFdJ/HquacIwphLjnuDz9c6T5vdcKryhAn/D+M3jmA9Mn2y3uHVV6UXbtcC5ArxjPxU/cJQSbosvpr6rPHeyPeHwMzBa3S+Q13IFh9a5HNVMcoGoae7kMhV6O76aeYckENVGXbgwvELLFQ0zg56lQo0auImaMJE747RyXgbyB/E0zr6cIOVBScg+JckWVBkwc425zYBQm80Hn9BLY9c7L1qaWn/AUbTXk9mb+VzrRxrST28ztTaLFM6bWlzDKpAeMBXeuNbTWMMohxc7UnTwoItG2ejWyP1Ww6NB42FFYRBNmeR2uQQzYAckREUx6McaCMrgLWPX4yzmmiKd0rl5OQDLYcRVes/O++QwPvO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:00:16.9584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a82cbc3-af1c-4227-4721-08df01f8ca83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793

its_alloc_pages_node() allocates pages, some with __GFP_ZERO, before
calling set_memory_decrypted() to share them with the untrusted
hypervisor. In an Arm CCA Realm, allocator clearing occurs through the
Protected IPA.

set_memory_decrypted() changes the RIPAS of the Protected IPA from
RIPAS_RAM to RIPAS_EMPTY. The RMM architecture requires the backing
DATA Granule to be wiped before it becomes GRAN_UNDELEGATED. Wiping is
a confidentiality operation, not a zero-initialization guarantee: it
may be implemented by changing the MEC or writing random data.
Consequently, zeroes written through the Protected IPA are not
guaranteed to be observed through the corresponding Unprotected IPA
alias.

This is harmless for tables that the guest fully populates before use,
but the GICv3 ITS indirect device table is sparse. The guest writes only
the L1 entries for devices it maps, while both the guest and the
hypervisor's ITS emulation rely on unused entries being zero.
Unspecified nonzero values can make an unpopulated entry appear valid,
causing the guest to skip the required L2 allocation and the hypervisor
to consume a bogus pointer. Interrupt translation then fails,
potentially hanging the guest when it first uses the device. This is
exposed when guest_memfd reuses the same backing Granule for the
Unprotected IPA mapping rather than supplying a fresh Host page.

Strip __GFP_ZERO before allocation and clear the page through the
Unprotected IPA alias after set_memory_decrypted(), so the requested
zeroes are written in Non-secure PAS and are visible to both the guest
and the Host. This also matches dma_direct_alloc(), which clears memory
after dma_set_decrypted().

Fixes: b08e2f42e86b ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")
Cc: <stable@vger.kernel.org> # 6.18+
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6f5811aae59c1..a62abe8bcbde0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -216,7 +216,17 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
+	/*
+	 * Defer the zeroing requested by __GFP_ZERO until after the page has
+	 * been shared below. Under memory encryption (e.g. an Arm CCA realm),
+	 * any clearing performed by the allocator occurs in the private view
+	 * (the realm MECID/PAS). Once set_memory_decrypted() has run, both the
+	 * hypervisor and the guest access the page through its shared
+	 * (non-secure) alias, where the earlier private zeroing is not visible.
+	 * Strip __GFP_ZERO here and clear the shared view after the transition.
+	 */
+	page = alloc_pages_node(node, (gfp & ~__GFP_ZERO) | gfp_flags_quirk,
+				order);
 
 	if (!page)
 		return NULL;
@@ -231,6 +241,15 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 	if (ret)
 		return NULL;
 
+	/*
+	 * If the caller requested __GFP_ZERO, clear the page after it has been
+	 * shared. This is required for sparsely populated tables, such as the
+	 * indirect device-table L1: zeroing the shared view ensures that the
+	 * hypervisor observes zero for entries the guest has not written.
+	 */
+	if (gfp & __GFP_ZERO)
+		memset(page_address(page), 0, PAGE_ORDER_TO_SIZE(order));
+
 	return page;
 }
 
-- 
2.43.0

