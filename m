Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AB4CF47E;
	Sun, 18 Oct 2026 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792309583; cv=fail; b=uybXhdD5ad10DUdkbnmn/KpURNmz+QwiDzdGU7Eiz/9bMoIRhYxal9FNLEa0gpFqiNHmU5Hu5xe3D6lmUShHtKmkEDzZtbbIuIOuSWCGWplQygr4sIa8jbPodl4KAl2CR7V+qQ9dPC8YNRSVxhCkIHLWfE8khsWz4hYqFZJRhXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792309583; c=relaxed/simple;
	bh=KAkl97wv2dFAl6vZ81kI8V4pY8uHfeQj4Iw72Bq4vO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y57wcqeo2VhqTTTNBkO1PcNpfhFdYNl3wf+x3kkHKr+LhPvMoT4PxA5SICw/30DdAKx3TNF+qZVYmRg2iAv9G4S+nnv6fRIruwq0Ej23dU7gOcV8VAsGL2GvtZ5mlcCb/dU0hvbbTetDVes5DwmNEJlRNl1oIn3+L/EtoYmwPFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJwDXdTg; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJwDXdTg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgDDgl05/cszD2nWPtP4mfP+yH23rsT9IMjbUzD+xQPKG4UF8+rgSODF6lTDLXhFHJlneHPtGpu0VXsKF6c/uIsfEjQl6GI28oM7hDK9ketiuBbBesXbzB4ygpjPIai2yDiOCSHUOmTlTmguDOTbfGuL46P+7isxWFGBx/XLjs32WXDOWR5pDNvdOOWz8ZjbsoW6JFzjRdV5FosGJcNWyvdXAcFiSDAQH6U/vHG8Xl8yEFwlG/AiaLM2kgQ43TKDG4dk3mBFg6GDBOCDx3yB5gFRtnImWHVI2u5DvM74ugbY5Sm+Xd7z8TXBvxKSKwDAt5j45dIjVHxB8QoTOexWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAc4nd8ZAs6yx/gaXSR0hj/WRnGJHzw7S9ug9Ukb7hU=;
 b=mPQWGIKuk2+GygN0YT2AM1gS1ZUpZ++QKPHSvm5OEzIdyNwMbboYK/qQiA03Km/KGMDjo+F2Ju0GbdMLLrrakp/Q15I+bUJ2LZreNJ7ryHE5jk1/gCpQL0HyjkOTEGFeWtGMP2YVDumwXCF7Qd7cAjWdICuEKsrFUAfOgvs3/UzMKrFbj2ojFdZrk5LOpy1qZSlr8P7u0Ytb6sFSNNbHZ+lFZUIxQJ10WECc6AKAOlEhcZbfJO0RWuYyjjFW57i6cIlPzToVd5VXDyl4cNV87FuuBfGigLntfYQDJQYmz7gxHQUx9x58ylMjYCJJ7cqkx7VuFFfH+XBj7YP9Awvkmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAc4nd8ZAs6yx/gaXSR0hj/WRnGJHzw7S9ug9Ukb7hU=;
 b=GJwDXdTghluN05TZ35PmMULvxiU/N7y12sqUejo/suwRcOZKMvaxdXPYABl/onT6hE8az4USkbzkoP4LStmSPX4I6rOv0ZvizMvVSiEjxOgGF9DF2wfoEn1mm/QvJOC36SJLBPGU5ykRYc8lo4FnnAnYF16aiOtQQJq5i1t+Wgk=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sun, 18 Oct
 2026 07:46:15 +0000
Received: from PH4PEPF0000B60A.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::84) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.18 via Frontend Transport; Sun,
 18 Oct 2026 07:46:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B60A.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Sun, 18 Oct 2026 07:46:14 +0000
Received: from sunstone-2e07host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sun, 18 Oct 2026 02:46:06 -0500
From: Akshay Jindal <Akshay.Jindal@amd.com>
To: <iommu@lists.linux.dev>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, Akshay Jindal <Akshay.Jindal@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions
Date: Sun, 18 Oct 2026 07:45:49 +0000
Message-ID: <20261018074549.1493086-1-Akshay.Jindal@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60A:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9f6dac-a265-4771-7f93-08df2cebe2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	pSFROKchFGmCQyd78FfsUtd7O2tQgmXpd2BD+vRW3mSiqo3I4DqnYSK6tEM1KOLC6TLIIZ18ZoZY2G4VnWBXnROldqcbE1SYVLJ0P55HC6IqeMOMUgDUrFLpQceiKVnTILqqWOE+8Mk9Osv+Oy2Vq895b0sK1sQ+bsuxjINd5ZqUvqC5LfOqDoqG9gTb8LydKDMrrQFYlatzhIqLPdrcLdTxRi34XLQ+dd1fzozS9m7iJsZGgKeuWm6lNJIxxIuUe98UiRxAfcr1yBLlebffpp8agXq+aXEzmsqApvIBSkfMKpWB6IyKvU/r7HyoWhOPCz46Jeer3p6jbPWJf1pBzpN07+PMFelMd+4iEA/9cer9sZlZOt/Cn+qI6w2ZYpASjxj/jgVzq2cS6gr3D6lblg5T7QAgntbBC6V/WD0e0BsdgxeC6CGEvb6F9XCJS3gLnfZfMZfamBwB5lwjLz7PshpSkEe4ctgbbgNENCBIZZDklNby+sAIdsYobaWnTzgoYJin4Jwbiqj30zaASX4nCs8krG0VHf/JdAf7XHGK5/iBEY7WFoltfskaAJbKADno8x18B2Mot3st9KoVaigjd4y0AFCAKIv4isO41YNys7mnv0BPq0qN/kBp5r2uz9X/JtTHi5FJTAxypqXaPTKmskyFSkm7IBodBcFdaxxlXNuDm9jadAoN4uShA9+jh2GVQxBQmrkFECKpTgIofBdQvw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ySmszDwPvAX4kbqZx5FiYXckV6WtBkgMHGALLP7iuO3ii3wlcrmetjJfi9R8cFM6nhSqB6lv5sfx/ypMO3OEL2/S13Etkv9z/9anV78xkWz6ibVFqkfpRs73/pIiGVq1pXMmgbi4zI79ORXDVXuW4HoQeZ35KRikrh5H2f9p549Bg6kIqvIlJfcE7wxNhxDnRrSkE4Y0urA/5aV6nT0Gnp9wpNNmzGjP0irx0QD1UioJ5EPMqe6as35F9UI7pqy7Ha8NzCxRBwmzClYDu6+VDr+RNFu6EIUnDEQKRP4iaNhroab/dDuqpWDnvkXxUjxa/HYQdkDZLUEIEyro5riyHh1rKJX98ac9oF+XWkEZTsAOOXrGRM2CpWT8+ofc1PYmr1+U5SUWMIrEslMQP+peNsVBdk3zMBgjTfrd30N/GCi1cb7VlvSlqXByqZmsicAt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 07:46:14.3551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9f6dac-a265-4771-7f93-08df2cebe2d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842

init_memory_definitions() walks every top-level subtable including the
IVHD blocks (type 0x10/0x11/0x40) in the IVRS ACPI table. It interprets
each one as a 'struct ivmd_header', solely on m->flags, without first
checking that the subtable's type actually is one of the IVMD types
(ACPI_IVMD_TYPE, ACPI_IVMD_TYPE_ALL, ACPI_IVMD_TYPE_RANGE).

    if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
            init_unity_map_range(m, table);

IVMD_FLAG_UNITY_MAP (0x01) occupies the same bit position as the IVHD
flags field's HtTunEn bit. Unlike real hardware, QEMU's AMD IOMMU
emulation sets HtTunEn unconditionally (flags=0xD1 for type 0x10,
0x11 for type 0x11), so every QEMU-emitted IVHD block is misidentified
as a unity-map/exclusion-range IVMD entry, which subsequently results
in the creation of a bogus pci segment. Eg:

    AMD-Vi: PCI segment : 0x4000, last bdf : 0x0000

Fix by checking the subtable's type before treating it as IVMD.

Fixes: be2a022c0dd0 ("x86, AMD IOMMU: add functions to parse IOMMU memory mapping requirements for devices")
Cc: stable@vger.kernel.org
Signed-off-by: Akshay Jindal <Akshay.Jindal@amd.com>
---

Testing:
========
- Reproduced via amd_iommu_dump=1 on a QEMU multi-IOMMU (pxb-pcie)
  topology; confirmed "PCI segment : 0x4000, last bdf : 0x0000"
  no longer appears after the fix.
- Verified IVHD device-entry parsing (DEV_SELECT/RANGE/SPECIAL) is
  unaffected by diffing amd_iommu_dump=1 output before/after.
- Booted real hardware (IVHD flags=0xB0, HtTunEn clear) to confirm
  no regression; this bug was not observable there to begin with.

 drivers/iommu/amd/init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8ec8a6fccaaf..00e1d0be749f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2716,6 +2716,15 @@ static int __init init_unity_map_range(struct ivmd_header *m,
 	return 0;
 }
 
+static bool ivrs_block_type_ivmd(u8 type)
+{
+	if (type == ACPI_IVMD_TYPE ||
+	    type == ACPI_IVMD_TYPE_ALL ||
+	    type == ACPI_IVMD_TYPE_RANGE)
+		return true;
+	return false;
+}
+
 /* iterates over all memory definitions we find in the ACPI table */
 static int __init init_memory_definitions(struct acpi_table_header *table)
 {
@@ -2727,10 +2736,11 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
 
 	while (p < end) {
 		m = (struct ivmd_header *)p;
+		p += m->length;
+		if (!ivrs_block_type_ivmd(m->type))
+			continue;
 		if (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_EXCL_RANGE))
 			init_unity_map_range(m, table);
-
-		p += m->length;
 	}
 
 	return 0;
-- 
2.43.0

