Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA09262FC1;
	Thu,  6 Aug 2026 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032193; cv=fail; b=ea/Kg7m9/ypvqpCnTNHP7sCAIib7LGc/8cQt++mnGwpG251Q7/l0wdWUEx2BxYLf8BN7ydU0TLxybMtvWdCvUceN085LqLsgX8qKTGLjSmQdNZGLZhpG3tNv2+8/mrlS4lGmPskW+IPmUH3iwAdGcwUcd3JiaEJUP8qeIqBxya4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032193; c=relaxed/simple;
	bh=gQEbXGv7F+1DNfyis9Sy0cGsQPLrqk/UBJc850PHwKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcNp8olKLen/UYIhk3KPUTaN8P6UIkqcHj4xP9HVi/YlT5VmZoAXJNhJS1Gpbc/ahtzOfL5XJyIUVRJwVbH3dwRNidT4jSmwsbbV7gheuX0F3+miGi1GqCjzy+lH5cDxn0wuO7RzX3zAcomoJ1PxOLgGW65O10q90GeNjMrDEHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rajF8R8n; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rajF8R8n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAQ2p/9AZuix1SLkLC4WFxxzIU5GbTPqGHXLz/qPfWlvlIqeNksmGoDiGtvQqg8SNOJzgko4QTyjpEDGcAm+IgyASeQ7agoi9FHgwsYl7EQ65KoeOK7YWA/izLjTYAlRs6oB+vihJEUx3dJ3irUVx2J2CipLbTwzGUdgiZV2Au+M9nVuR3W5jWslxJzwD2qWgYIvYu3jl8SbbFxOTpFypP+deKhI4XgdO80vftekL2+MPT3ldWCne/QQKLWmG3+1Bm/adVdvL8vpdBhTgDoy/dAxLd/DqPE6jPH8K2RcUTXpVqaVBU2PeVIooZpHTtAsDw1w8JCoSDnj+wxAa/5mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmfBYP95tokplULiarg6QmMLra3zMloJlSltyrhjlEk=;
 b=KKwGcDfYxNNTV32ywzMju6h5JXnS7+4yLGPXqVVC6VYVl7Amj8iC8sYJRm+H72qFd3YuVKVHsOX3G4onlBcyZaxuvoLSCyc0XcwpQ/+WD4xtJ7Vs95mTwXRMsYrXv6bTfda+k8qtYbJlQFZWjjE9TtkNKEfbeX4c8Dhu+GU4ES6gBfC3v7osbrqTBdmpyfS1nF/QWOmui7HXN2arR/HDVEmJ2v9sxVfSt85APQ2E23OxG2I/S/cJhlKR2YFTwdMb6UPCSmjOIhelbUlHnkzArstp8thpGH91+gIA73BTE7jtBlX8hdHugBxINPJqMtS29W6ecg/SgVIjhw5qgW9RqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmfBYP95tokplULiarg6QmMLra3zMloJlSltyrhjlEk=;
 b=rajF8R8nKZJvYWOvQRDtna1VtFDVrZLKAMxvxyiaxNKtlJu2OlWIBcV10gmkBc1feUFqBidJLj5l14yuuTv0I9onqtz6Gza+uYikUiSHGcbzu9WwZzsc8oPnuhkUBOyKgA9Tr5Y3yr85NL2wVHNuwpmtbUEmNGhChBPsTo2t9Z0=
Received: from BL1P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::8)
 by PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 16:03:04 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:5b5:cafe::6d) by BL1P221CA0035.outlook.office365.com
 (2603:10b6:208:5b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 16:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 16:03:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 11:02:49 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 11:02:06 -0500
Received: from fedora.mshome.net (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 11:02:05 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
CC: Jason Andryuk <jason.andryuk@amd.com>, <linux-kernel@vger.kernel.org>,
	Penny Zheng <penny.zheng@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] x86/amd_node: Remove smn_exclusive
Date: Thu, 6 Aug 2026 12:01:56 -0400
Message-ID: <20260806160159.230453-2-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH8PR12MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: c68f2daa-891e-4f19-753a-08def3d43150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zl8xL3cRi5heZWHtywgmh0G5iZMqtPI1HBMbvqaFmzW6UdjKDf9697G/pJRf9jRFDstQ8puYiQtgyOIjI4d8Ls4ZAiSnsrGdSs/PfU2Otl3vmXN3XkeT8Yb0o2TUSdw4xkxHV45WTL6xSguwdAE/WtMzeKnM292CM4vKnu0a3/6V/H08IG4TmIvtzVx/z/4jvW27FHO2AeeyTP1S8ctws+eXo0iZHdZo7gS4jO102Y0TZaaYqso2wZVXZXyixwUW5evPMppJlstKiO21bl2YtWvAcqMGT88n85FHpZTNe+FGvLcjb9ZENgvMYTNJwQTXkJu+g+35GjTQrdkax/l1DvlYAUNxXnRMHi22+nfKH2S6+RnjY0QCtXdQNL8JE3BS33xLAwavd89WeVbJXu97XyYM8UcNmuGJnbzsEzE+LPSsLf7L/UWWth62t0UaxDkFSzFT/p06D3D8z92vKS0xz5VjGG1XgN7RDSe5lab0w1alI86vaYokKNPsVF9zPY7fSmcn82vIYrHhNSHUWvApUNk71O7VeBJxqnAv/AS7wXZIM4OzAHA2shEwUDd3qI+LpLDXvM15FuWEKIbYWpk9eMdLovlPEOo5n9HjCLjZJMk5XyRKJMZThSZpWhKN43duLkvpbnwHGBh1erdNtHzH7k3S0CxN37e+DeyvkkZhRwcP0+M9ZpU3HawtH+ShBRdRn59SoEXLpP+gfAuh7CcfvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ddIISs/sEv7OkHAzDzBxTa0TjmAi48xFFxcmlS0OmXuccrrttYGUB+xQcMYSSWRhTu8e0AxwDTa0i1LO5QuLZ9gcWaHS1Yfq9zJX7FA66SjqLJ9tKWKaM6NcCI1n79JLAYYNSufuraB/bu/icEpn/Rf5G+NPHFRHLTVsZvaEHZzn+DjR0OTPXnyDaic9p2NdQUm7tUDPheTSdRjUizRfe3lF6hALrL+XRsyF/89tylN5FTwDmUgPqhxLr0kWjoDBUbR4e4YAUPBbnUsJWVwJ8ILMgnKh4tfdgweOra0r1Ke4h6Vv4E30y8xUcw5NaSvsYrlBag+7ldRHo0O/DAliRxblGShFZkenk/WTIRgyXSRHffr0uy6av33Mq0vqEjzeZO3tjkonyeFi9ld0YzTVb3UgATGuodD0rCABJK7kPHzbVy2fHavWPNmxeAOyZQe1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:03:01.8705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68f2daa-891e-4f19-753a-08def3d43150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110

amd_smn_read/write() are exported functions around __amd_smn_rw(), so
they are always available even if amd_smn_init() fails.  smn_exclusive
would prevent access __amd_smn_rw(), but it is placed too late.  If
amd_smn_init() failed, amd_roots is NULL and __amd_smn_rw() will fault
over it.  Replace smn_exclusive with directly checking amd_roots to
avoid the NULL pointer dereference.

Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
Fixes is the introduction of amd_roots
---
 arch/x86/kernel/amd_node.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 0be01725a2a4..ea553267e5fa 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -38,7 +38,6 @@ static struct pci_dev **amd_roots;
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
-static bool smn_exclusive;
 
 #define SMN_INDEX_OFFSET	0x60
 #define SMN_DATA_OFFSET		0x64
@@ -91,11 +90,11 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (node >= amd_num_nodes())
 		return err;
 
-	root = amd_roots[node];
-	if (!root)
+	if (!amd_roots)
 		return err;
 
-	if (!smn_exclusive)
+	root = amd_roots[node];
+	if (!root)
 		return err;
 
 	guard(mutex)(&smn_mutex);
@@ -308,8 +307,6 @@ static int __init amd_smn_init(void)
 		debugfs_create_file("value",	0600, debugfs_dir, NULL, &smn_value_fops);
 	}
 
-	smn_exclusive = true;
-
 	return 0;
 }
 
-- 
2.55.0

