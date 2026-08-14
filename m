Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED83EC689;
	Fri, 14 Aug 2026 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743816; cv=fail; b=ctE8BPHtQoSGkZAlagQ+KmAOWlv0H8Lnic1AZJX/mHkpU1MtaXY3T3ti2cIEiS0bGKwrHvXVFXxj8y1PsW1Bkzs0dJLvyxk3v83Hw5scKri0P+wqoigy+9G1DqvBWeK8by+bSTlykO314dk7wORPwmZfHGvHGjqK7SIsnxpJS40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743816; c=relaxed/simple;
	bh=uB48pErrVRuOS8c+3AxSza0mYf6QJ7raXusPA85RRoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+wJShBLdW2usUVZwsz1ZcaBepNkcLlME0Ulot6opErKxf1qB9ZvgIA3h0Roobexultn0dBcL2ZQO5S6Nc7T+QcEpvE7513fd7cqYJ6yTVhDtjUD51j5T6gvfVKU61uVEQXGRN9cT12pCQ7nIWbvXbzPFlBwPc0tLxyDoxHlTUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxGthUVW; arc=fail smtp.client-ip=40.93.195.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxGthUVW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PvzH61F8bMnKzFGLpVpe1PRNAFDswXPp/gTJVHyBognqyRrFv6lBCjVbrgd1nW/Wk0YvWfjclmPxhw6MbjcP5KTsMaXcr3EzishIG/1/QOUELtDtcsvucOGWExvjdw+xhbEOYsAk10x8LFDFR9Y1ykvLnNW49f+xRfDPbwbrP8lydhZDb6oAY1Rnex4718SFoXCYx1XCiKTGsMprFb8J4K1v90z7TV5AVT8mbcmIon7TqJrUlejQH9As8kny7LnvN/19ZLaLUvRj2EyI+qAHqi7VxJ19vsDteHLA4b1T/kta3+1BcBaej06JKHko5IpHtcg7M0yGxZHzdObZkg9jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiTFlT2xKJ+CHs8iiqmK9YZgLceRB0Nsf34CEDPGWS0=;
 b=TNhto1EfIgvZv73QFv6GTNbJGCWVACPcczUD5Kc9SPn1biLbPgseijtgZunvKOVCpCBTKs0Ti7YDHPI6hll+2d8M/A/p8fSe9/LnHXuMN//h1vNTS09rjtZDzDSF1ddI4z2hQF7usovgcqQnLC507zr2rIoxPq4KCWNjZfuhQsBcI3pKGV85NSnjKUojzkJd4OMFhNT67f8o72gbFHq8j3Z0AwRb718PQ5CuBg0ZPwnszI3yYQrPV8g3VtcgHl5i5PAf07wSFp/M0Ez+86zIFmzJelG4bV5jXOsD6/ZYUpvSsF62R3Za5UpjtdTm4g5CYz4TEVMXtk7RFRhXjMxjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiTFlT2xKJ+CHs8iiqmK9YZgLceRB0Nsf34CEDPGWS0=;
 b=bxGthUVWLmzGxRfMWM7+LfMdSZ8QHNMjHPXkfmMLN2N7Sm/ErS9OVoOklEqzl8TCNPCpi5HfrUUjECF1csPaUcepw626yF22Uq2AKXiFwINSYgjuO5EP/FGpBfsvIcsrnxX9Ao6hfOkJvkx6PNmVSwIQRugonnzfKKdIGh7EJVw=
Received: from BN9PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:fb::16)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:43:27 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::26) by BN9PR03CA0041.outlook.office365.com
 (2603:10b6:408:fb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:43:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:43:25 -0500
Received: from fedora.mshome.net (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:43:24 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linux-kernel@vger.kernel.org>,
	Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 2/2] x86/amd_node: Remove smn_exclusive
Date: Fri, 14 Aug 2026 17:42:53 -0400
Message-ID: <20260814214255.83127-3-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: d1840b14-65a7-42ef-774a-08defa4d122b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|22082099003|18002099003|11063799006|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	kGhz84bAmt7KhfzIE7jIAisAay49Xp6E+YNlC/k2O9slWie+ku4KLi5QwM0CLS48aKMqw6uZhqMUemPyP4G0UjdADmX6grJpF9HGiC+LINHek7CqMBnkkOIf/9H5neBv4rzSTye2XD9E4wNmbxy87X4J793Bu42WL/obYsBJanrJ6naOQhF8Fs0UkdciKWELhNs9uqAdiWUeWlGOmMeFflb12Ixz6VNlqNK8Vs+DjT6RG/7lz7IYQiCWcAz4CdHvaDrZ+yIAJnHG+Yqz7f1Dn2Kt7AlyIZtOiWucPTOSvAYBKFj2R4QMXZ5b0JaosYRaHeUhJrN0J1xQfLGoRpILNKaEEc6GxEIhT0H0xrazQRgmNR9AGNmew/f6iA9w3sr6BJDfrF41ktx+eApBWjnhIfJYjmUj6/LGXylrWbW9RZx7loWGk1nhijrsV+mDwu2+0AF5/wg2Kcm7102D6s5HBaR5iyMcmV81+09l9VzM2zb+OMUxs4tqrYn2J2Sz/PnEmOLg9q+B4VAy1umT2vt4rys80mmcvZvIleYvCc5s92+zMecJjfldzVpo8oU/SJ9SzEkH4r5yIqIomK0eWEg49cvkePfdBCHWGZQd2BtO89Ut8e2LNKza/qSSrNCU8yldbj3yPjTWsCsPrgbUQFnxHezU5DwMYEzx2sBJvZGEiswJK2A2oBLjBmbhS8t6aS+I5ZVKHMMRYE11l39E4iO3kg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jGzkZRg8AaoUUwdIKvpxejFX08/6RlQLeOABeqHshxR8YT6JYqy8g2rfe0OfHPMSqWh/lZo+QK+KWAT0gfhj6MPm8QZ1om2/4rkjsh06VTWgdRrKK8rcWhQHl5A8ipAXKggnnmXfmr6A4e37nh34Dgdbzl+MuJy/jJhdo6n3Od46m0gt+r95QtmSu+AO4UquM61m4LfqpbiR4K6N/moyc+geZwyUGXtG7i/z6ny7Wsz6U/+PI7lWdG/whSkxV+nZY5pUVM6gVylsqiz3+s5WDyv1yx1V2XLAV7P3QLv8cM6nF7+dMZfnlMaXUvWdq2c2dD36ZePDCVo/ZYLh8oINdlvCK6In4fef7BFAa8FQRc/nH4zhgZyBdaeAG0OQz8hzM7TVqJ3QTnbBMxAKqeVgonYL44Dq5ynvsl5vc2e3ybbredd+LBLO2BtatXRovOTQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:43:25.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1840b14-65a7-42ef-774a-08defa4d122b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113

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

v2:
R-b Yazen and Mario
Add comment about amd_root taking smn_exclusive's purpose to indicate
userspace access is prevented.
Expand commit message
---
 arch/x86/kernel/amd_node.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index c3e214925d9c..14104f8c5d64 100644
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

