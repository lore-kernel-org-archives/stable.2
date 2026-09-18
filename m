Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657A3A8727;
	Fri, 18 Sep 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723101; cv=fail; b=P7yyNTJJuxPK5r1ps3yiMn68Ylo6ptlqK8NvBYKejSEHRo6JH0qxV+68A57Bsl6hTEVKhC5qc1jLA1R057eV6WEofZQItubQ5Ks25ADJ/rDnNmQK+vnhGCcv2IPeEhUf6qKXLUFe2YLBQj40u+u39qhDskMvZuFgkDCF43NmOUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723101; c=relaxed/simple;
	bh=AdJo5gvPoYNkH+5b0KLoZYxkdHYe8WOvJpbObYg3qSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fww8wJnrYYEcQfzV3OOi064OUpuTbWh3+ujAJtU6IjWIDU0eJ8npo7EERkyacZ7DuT2YcHj8xXUly3gjVby5Wcoz1ufzLSGXVoawCkcnFAnzpTbZjjESGmt9jBSG2pbV//YMeUXMZfA8s3F278IGblDgzkIpYPuq+i7RYeGibhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jAcOtl51; arc=fail smtp.client-ip=40.107.208.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jAcOtl51"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGgNGrq8YxluoBL/bNo5rUZHaLdIcRShiJWtz8ZVL6Vj7VxNwDOBiYAYWFuPQZHQHMIKTIZrA5jRbGtX2XCPx6LA6YhIO6qDGafC86+gPMH3pe84waHjm7tPe8Dl7ybFjFGU7Jf7wC3UnJkTr5gjgSK7+/9LkGy34N5sAt5jDq1LZRjCt+HUyzTj/HC+IRRXSJPNiP5gPFAXNsulwJyaWlOHtALY3f0Xa83a1TJG3SPyd7v7lTdFOR2zi1ARsRwmagGS4cUPUDY/Qeu/zYcl2H1MQxzXhrjXej8bGK/ufpn8PNYqFBN6L3UYd+mXHuoDTRxmFtrEME5d2YSi3Ouqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdgsDBNxPoVU6HlIU77GGKCjjDxysc+gjnJaOniVd5g=;
 b=SkxC6PY8dLNBjGescEZ5XzRgQhBlR0aPGrWluLMCHvB+CKjFsehnlpq6PPZvnoLRIbV6ZuQ0gzuZzvWIkeJh1e5uS0f+DmPl+tnSRlqf3RSI91rapWLBkNOmpD1mrEuuBe0xh7wYG4nFnZwM099goocbwwJh/ihzjwv5wtiTqqmNpeYrhV4FdyA/UwoTTUKRfSzEm0YWSSibmP9WIgRNfrwHPZ9+gQjQdO1VA1X0Q4OKv0gX3AvrOfmu8tnx73sk0iC6mxSjNXMY+oOxqXcAm8n5iYsLJ4EB5F5gckklhRJLNykOF0II1Felqhv68vlaPVHFBVBC5Z4RlNzApnIz3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdgsDBNxPoVU6HlIU77GGKCjjDxysc+gjnJaOniVd5g=;
 b=jAcOtl51dRSqZXR33YR4H6WL+Vrtf1UXZ2kTCNooPdxihr3sa7WDu8u+iljycrVlFsJ+DNC8f6r+P3l5vsRK7YPneRB/m0n4IdzKzaEdsaVQ8u3wrEINVH6qTp4LPnQocVpzvPFr9n0b6w/vHUOdZMukdRFT+aQ313zjqDsiOQA=
Received: from BN9PR03CA0195.namprd03.prod.outlook.com (2603:10b6:408:f9::20)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 09:18:13 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::58) by BN9PR03CA0195.outlook.office365.com
 (2603:10b6:408:f9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 09:18:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 09:18:13 +0000
Received: from sriov-SYS-7048GR-TR.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 18 Sep 2026 04:18:10 -0500
From: Nikola Prica <nikprica@amd.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <jerry.jiang@amd.com>, <haijun.chang@amd.com>,
	<andy.zhang@amd.com>, <christian.koenig@amd.com>, <jim.chow@broadcom.com>,
	<matthew.mcclure@broadcom.com>, <gbayer@linux.ibm.com>, Nikola Prica
	<nikola.prica@amd.com>
Subject: [PATCH v3] PCI: Accept AtomicOps already enabled by the hypervisor
Date: Fri, 18 Sep 2026 11:28:57 +0200
Message-ID: <20260918092857.648810-1-nikprica@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <97aa96e8-b553-47a2-aeea-e5d830ab0184@amd.com>
References: <97aa96e8-b553-47a2-aeea-e5d830ab0184@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ab5ff1-d297-453f-29f4-08df1565c3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	HfkzQIwfiCxBw5GFVtCcHL41eOd9xdC4TsYNSAjhuiugYNmeUGdNlIDmmD7BO2cCU2rmwc/fgOxUj/3FQZAw3VVfNPwAYxbVp/dEpcGx9YS4bLtnG4RbYbQfbJBfsIlxTUmvUmSOjU2Q558g85e/OG/9sxoxsUDPgwiShvJK/Evj5oWmrTm7oGEv9qziI8em296ekjvgON/WXCCV3kPwLa9bM062Mvc5e7FOOKLHAA6H/elKVJ+fK05Tds8S3LGDqTq5DFeDg6eIPzBVDscrDnyzvs6iAPYwwbtKZkp3cCTXlIWQmqasKq0ps5UaUM6YipEBl6/V3QCurbe/P2PfV2sCxXbbNQjTjthDiputct33XhgUxq5CPxGO3UH32Uc49j7DcLD8HIaQODPkARNyRtODHll7SCR+dhH4EhncP05noTCIlYdzPeQhE+Ou/+U7+Ve7tYK/aUEq7SGL/b4Fvv+Ny5rxpIadQZhi1FtdnA8aW0rpG62locfqIlOF9nHhFgcRFOq9sNRpt4288egjkIjRSZEGgRz8Zw6T/Hp3B/4z8WtS/AuiynjH7pb0Sb7/yZuQwhXQ3wNMRcOpNHA1NDxRrJRz1jPvS0McAqOrByVUWdnk0509drzJzX7qM2QlNboGrDErjhLX7JfA4wQJgC2C4/t2RA2wxhlIBhNY2VP5kmnSM1Z2M57O9Q6qJSvwMt5q12bv2sTJJmmIQESZlA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5eTHlx+vYkhPIEk0w7Rd75LP3mfyccsLEwt1vmQMVRyrJ1N5QtgCIJbOm0yWTT9HTWX5WMUnQUqmfs5vbaxKnYS4yKWRi81qn082p46h/KeEMmQjgp7qyMkELUG3j7/fLwAZkTw0NmRFE1Wamc920CHBhQkSteW1+/GGtPqOXXO+vuIg1z4lqRzxWWBSSQ8qQcT5XHBmhXUYfH6dFLlqkRvgVcNTx5Go418n9diQXTKXinVEELZQAmHVsDzOKxE663uC06CIxFNgUGhnEzJTfl9jbo4634OtiPANb9Jj+vjwbTzjSMib8ZCJXkjuKCjiL4mbXd/kcgbgwbKJqUghMAbMYVr8M81C2D1WJtLfXQC7W3nytDtXXA9trdAyTVXZW2EYAkgLI3eLzAH70QmIPCapnVf2VMENqWyoDD8hb58vfM8xOZpCYJ4G/nBREq14
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:18:13.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ab5ff1-d297-453f-29f4-08df1565c3e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268

From: Nikola Prica <nikola.prica@amd.com>

pci_enable_atomic_ops_to_root() currently fails when no Root Port is
visible. That is common in passthrough guests (ESXi, Hyper-V): the
endpoint is assigned to the VM, but the guest topology has no Root
Port above it.

In those setups the hypervisor may already have enabled AtomicOp
Requester Enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
treat AtomicOps as already enabled and return success instead of
failing the Root Port walk.

Fixes: 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports them")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Tested-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Nikola Prica <nikola.prica@amd.com>

---
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

