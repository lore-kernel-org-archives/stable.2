Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCE3BED4F;
	Mon, 21 Sep 2026 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988908; cv=fail; b=lt6MuKwYhv5hdAFOLnZB/ZyUR8WaEA1+sw+9H7uBBhiTnyCAyEgDydaWMsOPSwMSd+1j0m8TPmPBQhkbA42xfQcMhfaaxo5yJBPIXwZsI67gXLWjPZQmSHOPeeYgFwhF3AYsmgrQws3rQW6sPjCkAiCLm196xx0rLplvLfEZFsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988908; c=relaxed/simple;
	bh=50aFj8XyFq/Byv9DUFELkwMDaLpt9FicW/LoVolsY1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaxMvxHevTE03Z0fdG5UngHVJGynRxS18yu23X7ehCXoEI0qFgoxqdJj9sSLAYYHPmercJWq4EjFoEk5m1AfOAC3o+atchFVPDanGdBvefR1jxvJd4UBG8JFzlWAiYqQRFAHkIEbWHjWHNfMZFB8k0BixELAHSkfUyopUR0uwxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K57biAVq; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K57biAVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj/udurMRmITuesTZyMCR7bvR/yD+Kyx5SjboTqNM5qwbAJUAHP+4bUDlLPquev+YpcRC6DS+as7ILnZh69OyavpEAsoX2pNOl8UTYsGe1jWsSHlxh3tTVBFkJ1anWxEuZp71csPF3rw2WF9vkQaUUtYSezm3rqGeUzO5pfQSqu9hOVZ6mmhn1PqC033MWAsJIajz5zrv2MYUquZSKXYD2egWzIZG0E46rNPG6xviV6/NRL6iVPC6JrmQSlFkRACHbplpwN00Lp+Ae/Ulpm/sF2G7omPtBwk7eNT0115cVUkJIQgyz89Ne+u4imbx18A9QBFowe/P2Fmzp2q1EMHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8q2WyJAT9XhzwpEvy7Z+N2NqmdufuVCA1M62la48vI=;
 b=ou6mG6gfSdzIMVSobPBjzeWEwhaPr8vGEEoWcdLvcG210DfXigiE4JfHPenXYzu6FFedeQHKZDoDxEtc4gylYKZMo5ntGKa9JtIKVWLWgX7jVF7siOC8W6tvopmA+tuS2MmKr6IgYWZbqVW9c8/aPlfvtkWloWxWk/zW0pF85hUVGdKqB/OBf+BmAbGFhARhpPgvx9Js/wq/wr+ySeKOG+XCM9T/Ygee2R4VZ+WY0BvIxv2JqVba8p9DaDGOOmJifRvcp9dU7j6aTThieV7hoU2oYYqT6k+Ajh31bbENUGILXY+u/Xum5jPkFCCpY9Ph1LzRW8Urd2pfB7PInk1PMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8q2WyJAT9XhzwpEvy7Z+N2NqmdufuVCA1M62la48vI=;
 b=K57biAVq1ImMzflbIBJKf4EN7D80PQW6v6mgi/BM1iqSwn9ZrVDqbFkTSy1OVqHQnyhu4Nw2LYMIRXmVF20CZhjMCZKXiv7HLfwYSo38B/WM27xYMqTs/2cw9irVNaFJ0QVB0XJ4xKObsU88mloKvw4s3y2UqLtvJMX+O4vBEvM=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by PHXPR12MB999258.namprd12.prod.outlook.com (2603:10b6:510:3ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:08:18 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:303:84:cafe::1c) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 11:08:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 11:08:18 +0000
Received: from sriov-SYS-7048GR-TR.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 06:08:15 -0500
From: Nikola Prica <nikprica@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <jerry.jiang@amd.com>, <haijun.chang@amd.com>,
	<andy.zhang@amd.com>, <christian.koenig@amd.com>, <jim.chow@broadcom.com>,
	<matthew.mcclure@broadcom.com>, <gbayer@linux.ibm.com>,
	<regressions@lists.linux.dev>, Nikola Prica <nikola.prica@amd.com>
Subject: [PATCH v4] PCI: Accept AtomicOps already enabled by the hypervisor
Date: Mon, 21 Sep 2026 13:19:03 +0200
Message-ID: <20260921111903.978687-1-nikprica@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3f5fb659-c7a8-41cd-91dd-565cb46c0165@amd.com>
References: <3f5fb659-c7a8-41cd-91dd-565cb46c0165@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|PHXPR12MB999258:EE_
X-MS-Office365-Filtering-Correlation-Id: 432a66c7-12c0-494f-2ccb-08df17d0a434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|10067099003|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	6qv6bj0fBPGD/Pv2k7c5zXvGcEM/h+9KJm6CA9w0pa4kaY+yjYhTephq56v4mVGpGZ60lnFjrgReN0DlYtGWmxoDhA6THuVgYxHQGChjgOreV5D9cW6vHAQ+7VH08+DGxY2P5t8oSg7qAaRxqXtpcy5sLqcLJeHPtE4SGNTS3SFw/DYOaCbVS0VakSlTwlOHuZ4SMXbqD6M35j3FJJ0TF+m1xsoWdtB4REQE7gRF1CRt1nsCTTBEbIIwuvISJKptFM5qrXgAJRk7VJrIoOvDIjcS3HfcHQYEkfz4Al7enbXmGeneX1BmmExFbMhrqHHUDfMcDbwuoNwzX41wmakcgDP4rectUEWKY7uFxOtNqAXJyra+ffiXvIctkg8xK1aybVPxjAJHx/+nc0mgKBQeuTn1fLQCHg6TfYTs4LuO11dQuU5qUwZ+6ON8qpsFvUGVAQygzXRt2fMowxyP55uuC+0VfSiwc7ifYk0mPduIgdUjb8oAeqQQ2yIOCG5cw8/ShMo0U3VfKzJQWZyOQS2kNwSKaE/ocwld1RIH72Qc/cRJr10Ed0o8ZtPWtI2YewFqFGaODdgiS7fjZfRoU5ZJ/ZeqF6MYJgAIM5HSvgMq4qcXMWUCsrxbBhzHJNdu/otggZMOqdwKuxTb/6t64bRyt60C6w9GD95flSIcCHvpIlMaBLli+OKkZFMZeMiNUDnQ1M7Hq6wiDebWLEs7IzqoWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PdE/6cXgCJN3jCIVKZ8sc4dyHpupFH+9v7ur5osCHfT7z+ND4KYajDdMLr0B9/Q7A1goSOOVdWrOiEgHOrsWlmPcsd4h7NwbU/9huj1W/3beYfgMGQbL+1P2vxYsHG1Y3xHKaw3dwXlH0ykvy7nZF+fdWxAiTiDDTjUcD+x2NAma7H/eRgI9p6vUuD94f1G2KmJTAOTXrg8IBlUgxu2NI6WWFRe3sPyFtmeRkCeIOC1J2wpWZzFMmZJF5aNRi5NeGK/GR7NGgkwmOWrxmOV4IzeiQmPz5x1GPXCtznFegupSkYsP37t9y4wFqRLuLQz673RDYxK8M/ge/vHsPv7dZ9wKzj1e8fcb5zya2HdMqgxpOPj1/W05Lr7ULXCYGwpSh4EhAVPPtyhjYPs3S5jGOVJGkVCqEj53ZKtEPH42T4eATd2O/SegmcQQ2E5ZZ0C1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:08:18.4067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 432a66c7-12c0-494f-2ccb-08df17d0a434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999258

From: Nikola Prica <nikola.prica@amd.com>

pci_enable_atomic_ops_to_root() currently fails when no Root Port is
visible. That is common in passthrough guests (ESXi, Hyper-V): the
endpoint is assigned to the VM, but the guest topology has no Root
Port above it.

In those setups the hypervisor may already have enabled AtomicOp
Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
treat AtomicOps as already enabled and return success instead of
failing the Root Port walk.

After 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port
supports them"), pci_enable_atomic_ops_to_root() always fails if the
Root Port is not visible.  On systems where the Root Port is not
visible but *does* support AtomicOps, this is a regression: prior to
1ae8c4ce1570, it enabled AtomicOps in the endpoint and returned
success.

Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Nikola Prica <nikola.prica@amd.com>

---
v4: Updates commit log to make regression point clear
v3: Add Fixes tag
v2: Be more strict and only apply logic in headless device case.
---
 drivers/pci/pci.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..62729ade496f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	}
 
 	root = pcie_find_root_port(dev);
-	if (!root)
+	if (!root) {
+		/*
+		 * A hypervisor may expose a headless topology with no
+		 * visible root port.  If it has already set AtomicOp
+		 * Requester Enable, there is nothing more to do.
+		 */
+		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
+		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
+			return 0;
+
 		return -EINVAL;
+	}
 
 	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
 	if ((cap & cap_mask) != cap_mask)
-- 
2.34.1

