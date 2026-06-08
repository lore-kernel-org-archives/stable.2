Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9738D3FD;
	Mon,  8 Jun 2026 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958613; cv=fail; b=W5qoH0Nqw9rmDhgEDU03koHAG74okYE6yMA11GJyomiELteTsxyW0YlDSZn4s6B33eOLYwI6lPI27jFZW+9F65itvFpQx4FrhejHLmjFqadv8eLp7f1LvqaiKVcB9GKoz4mUHoRpSsKh4w4VqKqrFEH4Vy8ds/PY3JXrs2sdb2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958613; c=relaxed/simple;
	bh=WyPStKADCI5Xb+NensWdEil/9FEaFGFUUAJJONo+jJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bYJrBhBNmAEAKjjGh6VTXY+FwXR3us2KgZSi+oNQFV+8bemMucMsFPoGsqvsSlI5WelzLLH6bqTG9+gTvKM4amlrxqnfPCrNrRLNsDKGVAnuapqpPAbZhtxsaDVtGL1TP7AKwvSkkWtBx8HkJRPjadg04E0qg/QjfO0jKwWw9z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UWYiTC5A; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UWYiTC5A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTT6rLuXTYqGsllsTZWhUrcGHCc0MWlBIFRz6fMnbsbb/fRi/p331FeVH+H7toe+A+H2L2RWyBhlb2afINMV6qftYxUU51fogCrxj2guDU78XItZM+5xwqNAyvHJczf3XWuOUOny3I/M1BXAYD6o5BuNdSu9GNpeEWrm7QxusesQMJKWP5NySdbqppZWrcRh2Lf32v28fLN1zB2ZYjFWqUqnVSUWkT3LdlzEr4dpeGZWEgJtRjGd36ULbwl0xXlc1Hau49SbM2sTZ2deAfasUDRUpvsZul5Uv4MnmL8j50ft45d6+ZAJkLsVWwk6fwKQKiQ/AvhjgdsanxEvlNvdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FN3ot/bW86iUQMA5k5anMovfjWHZQm8P1bSNVeIRXI=;
 b=qy5Ey1AlIAWtAT2edLUZ8pi3vBcYUR+L5vNvNKjS3x8xETN7qoketCidhlCBEhH7ctmeGcNjQdRqhpwFYGWD4+bobyrj2v+GEDtZHTC0LzQFlciaF4Bcr0aNnE6+DlVRSZnASxR9ag+rZ5ypz0sIr+edLKQfOKxhjLGJaCsU7FqAhQMppSERR8IIEyyw3SVE9PsnKFgr97co0l9wctXURWNXSNJoDeAeOkO+k4HyazAE4dIppLuKMZTNpFhG3yT58Jmsd/YHhlYeZDzgt386dmZjeAqR+7jMyPBRrcb+Q/RbjpHR1bxS2L+OrQKmf6CaMlVJDQ/APByU00HGAeGVwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FN3ot/bW86iUQMA5k5anMovfjWHZQm8P1bSNVeIRXI=;
 b=UWYiTC5AH774Dc36sc6spl3s/Qb9G6HGa6z3rA+tiWOQeoVIzwEoXyD6Ksx+cDiosdJVmNSxvoESVq4U9BKmDdOHjHbMHSkypajt1o0ycBjYaX1zfqnr57ebXlqV46EhInL4ghKbJ1eTxN6itIoMin9arF/s1s/FoCyrrZg1+WI=
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 22:43:25 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::19) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.9 via Frontend Transport; Mon, 8
 Jun 2026 22:43:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:43:25 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:43:24 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <djbw@kernel.org>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Benjamin.Cheatham@amd.com>
CC: <Smita.KoralahalliChannabasappa@amd.com>, <terry.bowman@amd.com>,
	<stable@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH] cxl/ras: Fix match_memdev_by_parent() pointer type mismatch
Date: Mon, 8 Jun 2026 17:43:19 -0500
Message-ID: <20260608224319.587614-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: acb7408b-a1a0-4e96-4cf6-08dec5af5a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|921020|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	AL/+6b2m63HJoqx18jM0aO/56h1EOajOg6NhRGoCfWLm88c4RwuqbMHtcEBGDhsx6nVPxfY7H0ix5QDoJmP8hbfBItnP3WuRdJlPyH1CzaLCiO6nrJkWre5DYFZMMSWMqpAkU5QuwIs4EedtHRmXcGetX2pGsKgnzSmc7YaDW3Ou0KTfVkhXWw29oOWqTaAn9FL/9gB0+oe6ryF2Jy7y/47j3CJGPYZiAgA9g+/fIP4whb/kbqIou6KhP1jdBELYnhhJd6z8becqeCZN7R8bhrTUYjYO1WYv0piBG/X6FmybJsiPyUaIypPzZgKVr2jNlDLl6v8Zyh6bObRYWo3ns168NXFxmrK4XydhwDzUksihssGLoIikLuIBr2uPfa8KXzWARjcrUxXDkXQbbBvbRDCWe0KsUJQC3mWtGnNGsQxmJRSOAJMqBIXVUoU8eN/pdtTCwcD2Xz9gNS9WtiYoQ/fezls3r6GCoHGBNZRsjLpLT4pOTh3PGbRIK0QpVr/KpPpZHqY64CGJX2A34I49JbJHguUoRxYHtYj3D8259z0kUbX/vBWgW3I+b2fgVHeULYkIXXMOyvbeyCu+TO4WyoGJvYCQqdW2BB6/ibfWfooKZbTc2YGHoMe5KhQg8T9wpquvg2vegbeMDKloeEqS6kPWh0cZhKFEMegioxFrv0128yk2kTyvVAio+1AiN+4y3R4y/oWa+QDcfMfrS2/sTp88MQxyfF6EnfOXZ6G6Wys2w9DHBFqmSD6owszZjWIWyigyLoHc7H2jPq+hSbzSPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(921020)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6YHcHAgjvdVZhC+586kR2tIaL5JOduBkfjvjf9XGx35SVL8W/0H5CGHjQJNUrrqzh3BKWtRB0rz0JhXlgwM8s8/0PakFPZrxM3+wUDCsTMyC/6wre05ZcO5w1biLSpqxZP7tUekGcleg/N2ZP/Sfu/Q+5VObQE9smlsXhltBaN5mWLFgzqpShtToLImqyuUwGauPfM4vOS5NW8TYvqR7MDOEvFvjdbuTlBCQ25XRebAkaeVzWOm6G+pAWzOvTlatoK99cfs+ZPZS5cWFSnsh2uj5+Ru66juTvwzQbO3SFIfQ2FkZwbLabxVJhvJaJl7bO9Y9VhDfDagF2KioJ2QNKStD66ZD46usXH4CtirCTBhOfZ22WTqY5rXbjiFoTaqrY76OEFEOlXMv/9i6zm1cork4uyQLHWQalg2kckfiScTqtkVa/qZXZQ391Gi7C3of
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:43:25.6152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acb7408b-a1a0-4e96-4cf6-08dec5af5a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

bus_find_device() passes its data argument directly to the match
function as a const void *. match_memdev_by_parent() compares
dev->parent against this pointer:

    dev->parent == uport

cxlmd->dev.parent is set in cxl_memdev_alloc() as:

    dev->parent = cxlds->dev;  /* cxlds->dev == &pdev->dev */

So cxlmd->dev.parent holds a struct device * pointing to &pdev->dev.
However, bus_find_device() is called with pdev (struct pci_dev *)
rather than &pdev->dev (struct device *). Since struct pci_dev does
not begin with struct device, the two pointer values differ, causing
the comparison to always evaluate false.

As a result, cxl_cper_handle_prot_err() silently drops every CPER
error report for CXL endpoint devices -- bus_find_device() always
returns NULL and the function returns early without emitting any
kernel trace event.

Fix by passing &pdev->dev instead of pdev.

Fixes: 3c70ec71abda ("cxl/ras: Fix CPER handler device confusion")
Reported-by: Sashiko <sashiko@linuxfoundation.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 006c6ffc2f56..7ec2dab152a7 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -94,8 +94,7 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 	if (!pdev->dev.driver)
 		return;
 
-	struct device *mem_dev __free(put_device) = bus_find_device(
-		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
+	struct device *mem_dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL, &pdev->dev, match_memdev_by_parent);
 	if (!mem_dev)
 		return;
 
-- 
2.34.1

