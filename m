Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012062.outbound.protection.outlook.com [40.93.195.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26858262FC1;
	Thu,  6 Aug 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032254; cv=fail; b=hf1tQqLxPApxBmokEk2XD0R/iQ8c8F2Uz0Z6wdHSZQnHwxDrNQrjFH91fs+kAeA/ttBT2oHboU/Nbbwu9aRKzNP86LV8nexNaTcSW4r1yJ5DlgfRR/6aSB7CV5JCwXAcc+RhboNxVy7kiZGURYoNyfWX9n+ddO+X90DXSPY7LdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032254; c=relaxed/simple;
	bh=0quC0odmP1sSMAe33l5hSZrITEUjMRE3qQiqPRyAwqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jiycf38cw+4658wzaqbmsV1RtR6SbmdFtlP0o/2E0zi8PHjcXy/QOEU96nZ/h2spApKOdXLhSG5vQqeBcNIES7faf3BB3hhuaJ9r8pKXDbO6OQh9czbf04YctryGVXoC+W2xegaMe1BzLgfAwH//ooSssnInVcUlsKV2j9vWJsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b8kYmYz9; arc=fail smtp.client-ip=40.93.195.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b8kYmYz9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxpTzSCoyzZwjSPi/bbh9Owqp9UHyABdf09g6M2/LZYG12H3J9FJk2sTA7b8utQeHSTASjd18DPYi1ODlI4Z2jlAphh2PKh17arHsQPgvNBT1TVTP71pYRbdYd+AAh1LPkffZDZIdP4OfnM+LRwiJHO+PSP1jhz4FDhGGKrEnno2ba9mJ6SInPcKTj76OqKhCIxZzEkhXnsgT2B2TSECEfk272BAL/qf9PwELiFc3uI2DXxsdRqOkUWOrIJ8aHyCuLPnQkTKKbC2x9Qs0taEULb/89mKi3trsLsErnk7Ui64Ujq4/LQmwv/qSRumjkaytblx1QUwTU2h/I0sQC5aAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGZ3cVJ53jmPNyTxZfCRYDEvZAtjgF6q+WayMujKCRI=;
 b=a+remkSO99Rx8+4fqExj7T3V4hHO2+UM85ZLeLFT2uOrl0rcvjxFvGtf4Mt4MI/FWyRQkuy0x9VNWezw+0RizFmW5wGIJ0pj4O9fuc+TXROMTm4WcTUlrZRmcNVL5EZG3ld/EDt0aFjaEi8izulSZSqeXBDt/0ofm3vHR/AmmsmCY3xVzLt/Ln+bSfkApWdGQiwhuCvaA2+BwmM/x9X7mfBi22jeXyr1NnP20EnBk/ww9yTYUVmOqOHYjoTpuqNf0pK2MCEllnNajlvyo3vvz1NJp9B4ptrif6zNeFPBQkj/4EVH1UO2yrQxCdPxfqwSAcwWwo+8HM5CuDiakycMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGZ3cVJ53jmPNyTxZfCRYDEvZAtjgF6q+WayMujKCRI=;
 b=b8kYmYz9NLRLf+u0yTkQ8tBbniTQOsIrTQ4sYUdz7iT9wPLKGDKGGyEa0DA9hY7sztTW/Fkn385qWNFAieB36RbEgaKqQZScR+usnVmHxRE7YlehkGfVVKBxhg26U7DFMTt5L6pt+wBjwBh676g5sSOZnNcYWqWiEptJqihFCg8=
Received: from BN9PR03CA0500.namprd03.prod.outlook.com (2603:10b6:408:130::25)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Thu, 6 Aug 2026 16:04:05 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::1e) by BN9PR03CA0500.outlook.office365.com
 (2603:10b6:408:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 16:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 16:04:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 11:03:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 11:02:09 -0500
Received: from fedora.mshome.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 11:02:08 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linux-kernel@vger.kernel.org>,
	Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] x86/amd_node: Avoid divide by zero on virtualized systems
Date: Thu, 6 Aug 2026 12:01:57 -0400
Message-ID: <20260806160159.230453-3-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806160159.230453-1-jason.andryuk@amd.com>
References: <20260806160159.230453-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: d900b567-8328-47b7-9933-08def3d45715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cKJzIfftjiM8wNO0glP4RYERLic4zAsjjgJxuvqfOOnOpLHKej+EIWmwYHpWqvVK5X6r9bCyBSg1EFToa5yke6WLwiZAT2Fh62eKh/I2fmXvmx00Lfdl1zqSEbGxx44Sn/MOj3/PNmly3aSeY/E4D7NDyZxcGRnnD702czgWaNf86ohU0Y2wg6VExgfbH5eU9gOmw2jn9vogQB9oq/z0xBVkx8S3eOFFc97Rtt/QCr9XDVKEvrJJNaqYqeu/SEd5RQra4qsmSCcarRhvqewYxiuDKcS8Ce7CkGria0oeVDwMydKxXngHvsvDK/XxLlFAaI8HzJYuQmBHj0yTwEKgaYMeWmZytPiHwKJjN+McLQRQe6N5QHb4Zm49qdxkJuHT5rpwPBbsS53fd7x2Zp09QahItt1TYhOb3udQePNWupbHIOJBROTSV4sMgcC3KHmSodyQlaJxj7IEyCFrxRg3M2jRqEvvnDhx1Gaw3vN4MpanSbp7PKMTQvK0pOFT0mLbd6JMvz/EhdKwfizcy11prad/VbYNHJsgaHlZ34Cf0tdlq60MktCuPyneufXIt8uSAVGg1R+05NF6RP/pQI5tC2/UzC1qh9cRI7IMQ+HZCzhWX/i0nCIGii9UcIsnk6Hz/pvm0aqghJ2z+NffYBBoYzPQazh8mszYVujMCZRqarIWsEkUJq6+jddpdIWK6wwCz7ZE7VaC2M87ZjQC9vGwVw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wmWoHmTWATec0oaMo1O7QKb08supNYEgcaETm4fNmvLBng0DwruYHh+qsqdYLWzTZuIB672aIpkkrRMg0KaBXPD05eJH0nwxXj/IrFMIBs8YRUWhYgxoSFRyVQozcwtJrnDBitxoPLVscc4EI2ZctG2+orJpyU6CSnhg6Nb/YL8hY3i1q2E4EByPCz6/8YjZUhe7CMba4Hrtf0jqrLABe32OGLhdh2ACVssrXCjdavFOaqmGTQyeZ8B9/gv61aGp+VvpBt7BYQexkPf8cq27oEN33SSWw1k2ux3+MIyGLKquZMVA0GQdXVjp98+DzaGv7oaTyWCYKYUP0ZA3DjOZ5JBL1r+hsU3g1VeTdI6VK/vsA1QWMHNATj4XdizAswWfR1rrR2Z7XROk3t9Qk/jL9QcxYOzmflWNVXQTtKVdwoj+h/5bJk16leMrleYvWk6h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:04:05.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d900b567-8328-47b7-9933-08def3d45715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887

On a virtualized system, the number of nodes does not have a
relationship to the number of roots.  A Xen PVH dom0 can calculate
roots_per_node as 0, which crashes with a divide by zero in:

    if (count++ % roots_per_node)

On a virtualized system, default the value to 1.  The issue is seen with
Xen, but it could affect other systems.

Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
---
 arch/x86/kernel/amd_node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index ea553267e5fa..c5025e5291b6 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -286,6 +286,11 @@ static int __init amd_smn_init(void)
 		return -ENOMEM;
 
 	roots_per_node = num_roots / num_nodes;
+	if (roots_per_node == 0) {
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			pr_err(FW_BUG "Error detecting roots per node.\n");
+		roots_per_node = 1;
+	}
 
 	count = 0;
 	node = 0;
-- 
2.55.0

