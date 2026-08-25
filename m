Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A448F83E;
	Tue, 25 Aug 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694529; cv=fail; b=TEpLwabd3KGK86vSB1ZcQnx+BxRVd/u1jK8EgDYvw2ePAOd0WlQ/ZYRV4GC/10Ad8HgDayThyQE301blp7Od0lLNpqoFloPPKnsbTsuXBiG4IBPql/7ziztrS46pRB+/zjItTY9y2N7TIgOKbKiqmCP+YRdFFga6ijoJ5rw+vgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694529; c=relaxed/simple;
	bh=evC0p58/wLkjAOKMrb1GYrHRnW/UoNOeqaKgUnb+uBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MT8qZWPNnGMjDFRAiJm/9fs9idw30u+CHQQNF6LEVOvy2csl3PgYlT0cGAV6HK7PNurUiYukPRa3UWDRVioRijBtmVcwi6QhE+n8rRw55lPqPhistHiUX9rQIzupas1ycHghao/t6UuFHlUPIelPhSy/25NaW9x11Z2IuBQQPKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OOWlbItc; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OOWlbItc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHfVzU7Ft0C6ef+B/uethbZNsm6ZcU0kBVrnbF9+vqkaH3zdGk7HJoyQNFClzXZyM6l831jgnr5mGOn03NpSu1d09wkxpUjLx6S1/d6WoCtlwkTK1QHmkDl9H7AO7sIIPh9bHTABPVa/mYEepukFNmU0rlfHX2u6K3DagF4Htym7Oy9+f5y32eDRtt4vS3PY32WErVsdApn9sAisMg1h5ICi1wPMJmPTkp01tHEFpxw2uvAXtcYuCYg7Uv08XGHUBmiF8IbI0HeDf1B0c6zFebWBg8Rjq8YZRprBVxkkh1yUUyq5lzSHuJ4Q9SoL+ekmKXNc4+6mIYo7UDsMsePVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68L/NGXP0Rc/Te7+kDDZLfe9ZyvxxVvf1ZWZmZRoal8=;
 b=KWAjTiSB6T2wm56BHRfv/+4nPXzHzXniGSBpO7OoklYx0ugt1NoleWz+wKWtLJNDspWzV9k9GAzAEn4TKwBiV1sqLn/CjTZ1nIBGlkWzyYg8ovdd2xUomIyN8FhpiXYuVOBB4g/imlR0LHrgOgrD+h3EoiTGzfohu1MLhqGDm0x7XVJUwP8o/UlvLkArFdKnGgfy3LHVorypxvtzNSuISdc7eRSq2J47eIjNa210USOLccfc8qh4q1j4snM7L7UiNj8m17bvtJZDE2AMXDRuINGR0IiRICw61I7GtOyapiNJ69U5gq8OQTNsYGRVPpgncsvsk+ZpRTWvdX6xUX5HUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68L/NGXP0Rc/Te7+kDDZLfe9ZyvxxVvf1ZWZmZRoal8=;
 b=OOWlbItcQ70kk0HOSx9mpPd2ZsqEOegcWiQxLaB0EWCyVdxgyuTuyIW2EoeaxIaR3FYixfS59YiGsa8Z2KzJA4l6+2QXu2DEbPQ6wG8V51GXSFbx0h9iRGFGiRy4N4p51RNAq76WXXoqsxTfvjJa1VAK8/HUYrXbHUVuUKgiC0A=
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 21:48:30 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::3f) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 21:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 21:48:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 16:48:28 -0500
Received: from fedora (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.45 via Frontend Transport; Tue, 25
 Aug 2026 16:48:24 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linux-kernel@vger.kernel.org>,
	Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v3 2/2] x86/amd_node: Remove smn_exclusive
Date: Tue, 25 Aug 2026 17:48:03 -0400
Message-ID: <20260825214805.39148-3-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 486ddfc3-9471-499b-cbb1-08df02f29a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VUgJGRxYP6IzdG/JNVLwAjc5T7C9c8hnfru0fC3aCp0cnCU5mGFwOpPZT4xM0wT/VW57hE4hqPpHKM9T12KhBSUcGV5KFCcZ+7YiN4cR3khWgZz3VoC+8etYwv8DqwE4j+EZQXlf8EAiQWjq1ZyGoBvoaPwlDEpELGfxG9UN8JoSmZqila3gRMhQGiLTz8O/AcmDW1p0s8IOjNBx2Vf1H2/qEhScH5TLWjiRgNx5zgCJEshDrvLymDIq1Sk6fMANUostSBmkIC1ufHkfsPpsX2MveGnVRBzQnGc0vIsb0QFYBvhQMYvmi1pav/rxW6lpTYJ8wdau7x9eXNqm3p2lXe6H5oPRE3pDpgWUpk0gTimSu4HxtjCtV8Ie8DsSpicBJ91J9R+9CxOk4O7hKDG3gEfpnOeoEDWuTSZ3qjf5UxJfesI0ec8P6sFV4WyF3SdYOFLf8mjsIjdgN15LYGqY0OOwkyEzy3ZE2Fih3ERFzRB5jXl3yOaTDDYkKouEvM8ayqkrt+4KYGt8qfAjF0R1+/XDWY0ugcBwNjioY4IOZHxny93ojMzvMdkUunjPLDTSIevk4dFlQi31g6psBC5fD+T6T3X0FaVY+KcTBOKoXmXe+hNHtf3BWX9FMpnYa/AgqVwgxNuCo/La5fK1vj7E3xe5xJQ9pIk0WrkW8IC91VKMgyU/sT85XteQLGf5xbpZSLhh3GPf+ceqcFk2p/ONYw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D3rSzBIBiCCktAN+QLT9Z6moT4RK/joKyVjRQsyqxfgJvfjUm0Y5qRJyWJ4cVXnR4VEylpITI5+J+YTu/qRy804ZML/5gRcOBS6Ad2D0SVmiJBkJeIwjov4zd3iUYsoJKDi98ZjQakKw89OZTyzBN5t5bLz9XuSo37sl1lIIiqjuf0ojmEFzjQRn/hA1J3dlRF3GRE3HsIANb2NF3qh2hZ8/pDa+Gts6S6H5MtnbtlCVxx3F/JQOErCgeA8/IiRn5u224d167uEveMh9Ek0qN/48w2eEUcI5L+wNwi5VF/2ZTOio6DVs64Qa2zolOn7GCDkLN7ZIWxw9peqMWK3fUjAofMYw5FhQX2Q7Gw3RdofbcBabQLpGRt1q764hVUxjdvi/TowvrSsljUgQauKAK4Z8DnRzntCJhhSiKkuySfUYlwbQgQOuDsDHBi9Xjg4+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 21:48:29.8596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486ddfc3-9471-499b-cbb1-08df02f29a15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097

amd_smn_read/write() are exported functions around __amd_smn_rw(), so
they are always available even if amd_smn_init() fails.  smn_exclusive
would prevent access to __amd_smn_rw(), but it is placed too late.  If
amd_smn_init() failed, amd_roots is NULL and __amd_smn_rw() will fault
over it.  Replace smn_exclusive with directly checking amd_roots to
avoid the NULL pointer dereference.

commit 83518453074d ("x86/amd_node: Add SMN offsets to exclusive region
access") added smn_exclusive which indicated the calls to
pci_request_config_region_exclusive() succeeded to prevent userspace
access.

commit 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
re-ordered initialization so pci_request_config_region_exclusive() is
called earlier and a failure exits amd_smn_init() before allocating
amd_roots.  Setting smn_exclusive moved to the end of amd_smn_init(),
after amd_roots is allocated.  smn_exclusive became redundant to
amd_roots and can be removed.

Add a comment stating how amd_roots replaces smn_exclusive's purpose.

Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
Cc: stable@vger.kernel.org
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
Fixes is the introduction of amd_roots, which could be a NULL deref.

v3:
No change

v2:
R-b Yazen and Mario
Add comment about amd_root taking smn_exclusive's purpose to indicate
userspace access is prevented.
Expand commit message
---
 arch/x86/kernel/amd_node.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 408b9fd48349..833e5eda5d91 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -38,7 +38,6 @@ static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
-static bool smn_exclusive;
 
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -91,11 +90,15 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (node >= amd_num_nodes())
 		return err;
 
-	root = amd_roots[node];
-	if (!root)
+	/*
+	 * non-NULL amd_roots indicates pci_request_config_region_exclusive()
+	 * succeeded and userspace cannot access the registers.
+	 */
+	if (!amd_roots)
 		return err;
 
-	if (!smn_exclusive)
+	root = amd_roots[node];
+	if (!root)
 		return err;
 
 	guard(mutex)(&smn_mutex);
@@ -313,8 +316,6 @@ static int __init amd_smn_init(void)
 		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
 	}
 
-	smn_exclusive = true;
-
 	return 0;
 }
 
-- 
2.55.0

