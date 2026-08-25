Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB103E3D85;
	Tue, 25 Aug 2026 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694518; cv=fail; b=KLw5DxsHAidXPusivxciTFZ3qoCpVdiniVFipEkY4K7QvDHW59wNeEv7E8Wmzv+NHKkMd4voNNtBG4YYBnXo5UX3x/bmx9FIqjt421LQ3u+0xyhh9NKuJuCaHkmHhPaj/oZmooo25E/I3NIknM7J5Bh4R21y2RzgYfZm61Sm6ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694518; c=relaxed/simple;
	bh=IDdzW80CJ3Nds6j6hiTXnTtJzGpWqtQmUyD9+7ir7Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSmz0OWLA8rrtxkK8C7cwIAVEhsIxl60MN0VnH+wuGdqq3NVGR0zfcPE1uZsr5UzpgF+k14AmWNgnK2Cmmymt5CbhMMtcfqNtHh1gcoLefD3fOYKT/kqBRlFgpQFf/t15OO/w2z1OaK7MJH8ljZ7Eq9rKLrpqISFfWJVA0DNyeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rj1dFxIX; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rj1dFxIX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZajTT4OCxJmZinOCIyqjc3DM/V1loClef7bXRCaQFzPKHxisqOjFAgRw4Bx354ZIbEd269AwwUUOqTt0DBPWHILKFm8oLDqUY2nkfxwCDa50fBMzEJnhqFiY13C4cmK2Vqdd6Txs1CNDl4OBV5w1+LKfOmHWYqGokS8cSKdGc3qgJmTYXJXx42FQt9dA9jSdY7Mlw6+e44UPN/cJ5gpneDKXugmfyMdz8XwHa8YzzzFjiSSDngJx0a8uU9tMYMOV6RWh6ZafZ2ny5actFNfA8ZPgpxpTYv/XWhJkYHUSsj2zOl8pacTNGKJ+kuUyKrKoyKNIJnFL1e5UnofN9SBp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WPkf9Jh8roJ1AIU9yH8Qw7Z4c2imYN5vWEZyHf33cI=;
 b=WP9WfbJtMwQcg3WNj1oRaNnlDDdQpgO+2CkpptLmKkY7GIkQ6lizIkzu/h84k3KVLVBYmyyr8Vns/k0TWjzlsNWSYA9shGOxbCS895sSNoovW2yJ9Iutq9nL78c1QK4EuzLJDxleQChFzdEE2G0Ag8aC5b1bNE1qP6XZgj2WP0SMdwfft3463NMmWmTgQZ6ePFlzZTTFy09rOMzC6qk30cApvwL7Pkc+e85FoCc+Zpa2nzDg1We2jwv/Yn52pbs/naGjYHff+5647rfEI0e2VIDoTE864cJenKB+ERvOYQGGVo0RCSxmJBXT5EvsmqcqMIxTaUq/44r3pJmuP5rYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WPkf9Jh8roJ1AIU9yH8Qw7Z4c2imYN5vWEZyHf33cI=;
 b=Rj1dFxIXTIQxwj5kA/fq6WCNhWR684lEiWfupFlM3RQUzDWqwLUOX99g14y7AtSwY0EoKyMtffoKiw85mDVPyLU8lD8wTChFUp+aEM2nbeDKFLgwUL8lxhNwGn6+bUCSDpCrHUJ1TFlg0ASTCfDIumD5mKKIeeODUlRQ+PykqEU=
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 21:48:23 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::84) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 21:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 21:48:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 16:48:22 -0500
Received: from fedora (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.45 via Frontend Transport; Tue, 25
 Aug 2026 16:48:18 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linux-kernel@vger.kernel.org>,
	Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] x86/amd_node: Avoid divide by zero on virtualized systems
Date: Tue, 25 Aug 2026 17:48:02 -0400
Message-ID: <20260825214805.39148-2-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825214805.39148-1-jason.andryuk@amd.com>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d2726a-4bc0-4186-909e-08df02f295cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MinabvoZEjpY7j9pT4LTZ3tN4dO6EwaH46lZGL2sMkcA7kcivDOIOdOUlCY4QtwMFz9b1OQmJEc9g7MT8ABXgBRRx1IgdKlMnGH2OlWOFZmyZI2eZOuUL9sYJFhx/d5RCCe4SbpDXqwRmzR3lXZiNW2tKcAxsd5e6FA5XzglnHsawZOwf4Br1VpocfID7lsVzP9eo9T48s9XDiCA1p5M6hNGAFvvHFLzdd9+7B3jzb0BeiCdWiTlDLjYZvXKCo6iueIpl3KSzbzRgtvZU7Ltep2o2FW0V1Wd/UZgsO3JxNUt0t7k2HPKY3duuWqagH83y/FJr9obx07K+WiSH8CCdjWyrtu1XMKMetYMeurpFTpHnaus+N7641VQsyZMMe7Wd/BbJ909JRtqDz9Keu2FdpbITQ2eW7nYnK/BXCC4D3IjOCgJXPssMGAsBIIANzVTofKZ6vITL4SKoJXtwt6l5huLqjKVcMMKWnvRQx6fZqJMO49VyPqWwelMzU2FULj1223GwmwgXkW0o7gZPpIQ7sTZKqrXjMITNku2oTi0xcn4Gw63/LRtrGDWbbnf1QTa8Bizb0w31d0YRVqqqwy9Z+OGo6wcvQBa0/YgEUcJOUqDUIGZrVxMuyhH5CPX9iiBJubhKNFSP6YyyexrUZ1NPHwXDaHWhR/DMfUE9U1Se6sdzWDCuD01HS9QlwpTWPyBxFe+cILjctHSx1r8JI34EQ==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ts/G2O4ot1+fd3M12XB++z0GYjBXssvxh00ewYbTyoYPL8noBj8um7TGEDe//UX4Urtqg5LW+FNq6KcRCxaMc0RI5Rb2oAssH3oY/4+Dq7/LHMizHkZuBQJtTtkmQJ4d/+mzg6BccODzBiUj2TvIA09fh/WuejOm3kD2TbiuO5CRwOU585m/q2A9X+2toiLbWOnEBEVO2mga3fV8L8+8zvZ8Tbm2880WrePlvHy3T7rdOaQZvwRTchMnPcaT65Okn67NZ2ZmBK+nBOFAu9m0OB+kHRCGfPNKLTK9SvqHs7ZaEupCu0tQG7OjHGHw0eJzuzHEJ6r4LkMPoXBcucg4siISFPFa989qtUf0Retj114GK2q3NFjuloK3qud0clCe7tkJbXM9FjP3DYtTHf1/TZSlddVTZ5VDIP/MU6XtOe+G0MC1Dd7t85ybtQcEhZcw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:48:22.7165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d2726a-4bc0-4186-909e-08df02f295cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630

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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
v3:
Add newline to warning.
R-b: Yazen

v2:
Print as a warning instead of error
Use "!" instead of "== 0".

X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
---
 arch/x86/kernel/amd_node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0be01725a2a4..408b9fd48349 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
 		return -ENOMEM;
 
 	roots_per_node = num_roots / num_nodes;
+	if (!roots_per_node) {
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			pr_warn(FW_BUG "Error detecting roots per node.\n");
+		roots_per_node = 1;
+	}
 
 	count = 0;
 	node = 0;
-- 
2.55.0

