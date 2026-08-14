Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79303EC685;
	Fri, 14 Aug 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743809; cv=fail; b=GgOki2e/HVJ9feYx4fKSHfy7X7lFaP/s0XK8J0n6X5Sy6zlXxUWqUZz3tVSz3wgMVaMuBM6k0B9vhOaGF9BIpHwRRviNBAkXZvAduVnNDgr7ockRONDeSA+DNGEfEZEIug80RYaF+20Rk3B+x8M1pWkQCxYPVL614M5c8qlHgGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743809; c=relaxed/simple;
	bh=u9AFVvEHM7Oa60FtMHX0yn2iXevigDWq7+cBY3k1Fb8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RR7YoWVpUtDuIxCX4URv/U0kEW/RB5ZpX1s0vZj+t3Lg7QRXKIB+mD5SMXQxPjZLCd140lyyjU5IwfFpjljlmg8u4ClxpGNO4Xj+r2/XcJHfsQj93hYG+rv/GXZWv7ybPomD+TAj/29pnEzkE68Bo7Z4LvT58LbxCOFwV8K9K0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3a9LiPTB; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3a9LiPTB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND5sXj1wpw1KOJowPmZE5vqrkh7Bsz06/sWyYNjkiRvWpDVN4zMEr6YKj/KTO8+50xl0+EQpdJF24MPuJpciX3d+xKwQm/S6acVzIa0NgC9qi6DFZRPDnJgJh3n+0mcoefGXV80TKE8yyg6P136gqbtVwipNHXoKkYHfOOLxwWhTGBSFXoMsYEsFH+kGpntvdv0zDhbg/XdTnMLY4/Q3jD6kSg5iowCgEbOy+VMfGjOvmHi/7KamZMo/MLpsTP05uQ9s9Pex0o3ZTq62VWzJRQCFh7wvNAmLmWshoutbc8urx89kz1zZfVv2TYqHByG8pmPIFdZTcBXAELMMM+yYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RSv2dgqxcCukVPoBEz6jG0zJR9KiSqFbYPgKCPHrRI=;
 b=pL3sMFRaIhEudvUOYqpJKUbjeRhCfx6UWqMZsVQZZYQsZglFsXHwiXmUKKBVpywtTMGzLqDKBNOekOaT1o2Z2q0z05GhZYtX6gSfy/KyDdO1jJRo3277VlOWul7LLzrHeKEe7Pe4a2Xlubi8JJoZjuiAAWQIPWc94pEP5VoS9B+4JBjMPNd22nUBlFsomJ1UoMeQOq0j3620jVS3e5YrIHsZ8kbWrVsJI+Ud/0c8gcY5iMAOMq0vAYAVnT3zMU+L3IGXn8i9VhRa5NlJom3qojbMVA95yRcC3HW4H7eS2/h1eUxrDgFS+r144HNDMw9oH+BTXvb+cl/KuUKV6niyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RSv2dgqxcCukVPoBEz6jG0zJR9KiSqFbYPgKCPHrRI=;
 b=3a9LiPTBQHh/u+A/Cm7yOwZM7bQZ8ZtfaLhIgwTkcDvfGg6DT1BZmKBqDdw5qyav4YXMbJs/5jUf6HkEKWCZtVhmYQD0Fb3xi5XodQjHwXZTzecuPdLMKOgAgWPi25O7cfhbMJ5UbG6nb2+ax9UHttIOR1IEzorAIDrgNKEIRKc=
Received: from BN9PR03CA0726.namprd03.prod.outlook.com (2603:10b6:408:110::11)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:43:22 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::76) by BN9PR03CA0726.outlook.office365.com
 (2603:10b6:408:110::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 21:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:43:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:43:20 -0500
Received: from fedora.mshome.net (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:43:19 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linux-kernel@vger.kernel.org>,
	Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] x86/amd_node: Avoid divide by zero on virtualized systems
Date: Fri, 14 Aug 2026 17:42:52 -0400
Message-ID: <20260814214255.83127-2-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814214255.83127-1-jason.andryuk@amd.com>
References: <20260814214255.83127-1-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd3e272-1cc8-4c34-333a-08defa4d0f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	grq/LEPxbJ5LNrKv2pZUz6HXUDE42mbzCbTSpd+cQKpLxRqzTo06ztgjV1kK+hjZTOuycwII75qWwAYDhtmoiA/VrsvmYXQbZHnK+exA/k7a9RuNDOwW9cKOZPdZgxmjn4BgI4br6SiCg5s9dsvBLMeYV/kHR9yQyL0hCF+oYo+8vepO/JkHKNitzX+DCGEAL88HKo6v3WRhCtPyuoJR7d/Sk/Vu1HwALA/I5nrijF7jojMaXtu1eyTVMZhsOFsP8NiqnlKkf8yumnSyRjEA0VFSMkXqjlHsZCt7zGtbzWNFcbsyZjabNq5eIi2m40y7hKnnoZxuEALNskcLuuf/i8wJWaNJM4C3iWLpUS3N2y2Xu+MPkMr2Y6mZj4KW2W8mpqukxN9F8k5Ezc5/sRLvMTxtBTr4JSavKEvuQayqaxEREJ2u3nymE609Ca4C3By1uO1a4untrx05p11Du2h0wtGHM4LvjtZwE4OVjn/GRPnPEP0TwWWaeZoUy+0EL/6497ZcGkSwUB7GgQ6f0J75DySQjLhmp7NwA2P7CAMk3Lb3gmYQjqqZPJ38AGF22qswblpzYaXSMRyoIZGi+txsRsb6EdpmLouAZP7b/s5CahcoBZOBmRRk8WkFfEaLooBB5CPNriul1Bqkg8XNnwJK9CSg/Fz2L42twOPLbmQ4vG6YW+8OU9JDV4YgmiZxaNt+hV4BmzzmQwzkoeIe4y1FqA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pCVt24Ugxk8i5dJXoBwB2L+TWX9y1qPCDqydsfV4KENH8mNdp/nHr1TRT0vWoj5+Dk/ibwhJagqeo9ADgE9xZsIh1BHOIWNFTQewYJm5hw+Q9LkeNeinEJfk+MHBL+8NiJsaL126xnXBQm1vUbXMcVvfg8woCSv7hfQPFMYi7DXnm38WMEEVltL3jsfvw+IMhspQIlDadyDBbDKUaChLFa5G/S6MvC6NKggTaO/ZQ/Bv+Ijn58HjiCQZb9HPTVkXUi4aakvwCPCi93vS0vDaw9VFHLH/gFlbUMl2GOGM3YS0toBs8FCTlB+XVSrls3P3772+8af5vEffhSqNrz1iPWl0bvpcpDrOvtF5n+ewJbea17tPC/v2zNfOZ9ffSZgdLnR/utq9pTB3AD2nqxF5BYw5I+nJ3MFA0mh1b1NZRCxEHSRvJC8PpyBpOEPvlP4M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:43:21.1519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd3e272-1cc8-4c34-333a-08defa4d0f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814

On a virtualized system, the number of nodes does not have a
relationship to the number of roots.  A Xen PVH dom0 can calculate
roots_per_node as 0, which crashes with a divide by zero in:

    if (count++ % roots_per_node)

The issue is seen with Xen, but it could affect other systems.

Change roots_per_node == 0 to 1 to allow the system to boot.  Print a
warning when this is performed for non-virtualized systems.

Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
Cc: stable@vger.kernel.org
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
v2:
Print as a warning instead of error
Use "!" instead of "== 0".

X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
---
 arch/x86/kernel/amd_node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0be01725a2a4..c3e214925d9c 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
 		return -ENOMEM;
 
 	roots_per_node = num_roots / num_nodes;
+	if (!roots_per_node) {
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			pr_warn(FW_BUG "Error detecting roots per node.");
+		roots_per_node = 1;
+	}
 
 	count = 0;
 	node = 0;
-- 
2.55.0

