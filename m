Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7AC1CAA6D;
	Tue, 21 Jul 2026 18:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657896; cv=fail; b=NUdvpNDLJbhGyxu8oZiaz/3+Opnk2r00Kjw1pg4dCF8PjVh+VCkavtXGEdmGMGpB4DyMvmxdKXxQjzVJwpfNphpQ9Me+aQi/x0GC4oAGuUW7cmGlCf8qB8sGDBvVJsLm+MFlrcD+raHx4lz9iQ2O23Py87W0NEbX8u7ebRD+dtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657896; c=relaxed/simple;
	bh=DnNjah5xpHPuePsaoUk85vnKR8MuqksnirDEOrfmJuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDsS47aH1l7wu4oPT6kR2RKy10hFhsGeIfDyhKZJzPGO2PQhYlJuh6mDkaJuDcrv6Leix3CEsNSmPhC0Oz3utNrl3WowDfVSN70cBYjR8PODN0wDwavHYNBuBBbZYcz8RY7UTBI8Uq0+ngp2rr2oJorwzEKjy3XfWTW3URmjAFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bXnpQUnv; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bXnpQUnv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go63N4OFVviacPAdHb5twG2FsNi5pnWCyO/iP9HGNVTfwHajYmZ34Q1dG/4UIjbczkeOcebl+9fsMJ1zajFdJyMGmtZyVBxdaDGlRpflMb3GpLZZ+FxNl5AlzvhWwL5wNfbJT+C6qRCiccnYtX+AjEySjcQzNmS3EPOmBSfE+9qpzdbOjfoDzJ+Pjs758KrRy1y4YMatSGSk+UK+LseSH4BoVur6P2q5gz7kEJ2Ri1M28ITtwgZPN44WHFRAd+03Ao4joSuhxIB7yU9CW1Kw/oQkAWOrTxoVqSAeAQ4NdTagXoAJg45dcfLFrEdvqnK9QXcDZILA53k0RMRcoo2bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0chq/1njpj9Rzwr2MzgfXVVkEgQwrfr6HOZvEIEGgQ=;
 b=aaxziu7e9uD2V/NgERlxAQnaq9qt8auBAn3DN+Zgeu5JrbPVAkViZw3uV9E2Gfi4oepdIFyvFfOSo45gTLnAuGAMn0iD0X9hiy0y7fKs11VfGsxJMAytIVB2/QSxaszAc1Cc8r4413/46H8BJAXflNPHNA6bqQMHxLNYcp48duPUMUJ/IHOyEUK9NI0yUrX5p52o+4Qrc4zjMzzpRAH6OVrIdZj9kypPvH1jbm6rDc9f0YeM4cqYqctjcAbRMaQroNyssqxfpstAyUSpiXnfJUjzfoDw7teJMOVCMKE4YCfzpPis49qIQCfmOln9zmc02zUWOR2uh23Aaean1X4UQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0chq/1njpj9Rzwr2MzgfXVVkEgQwrfr6HOZvEIEGgQ=;
 b=bXnpQUnvp0dlxoZRqp6U/NuRxJW/74IbCV56TtKfJmK+k1Z4pkc5w/HXweBVeyfkv3CjKsovfcoxgMnDOMW9BPgmLhb7dgKriiG3h8aSY9llutDEA7daeWDHO1RPp/ihJfBykjgcwXMUAFnd6uTW9l9/UZMuxZvAHbuimJE3s84=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:18:12 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:b9:cafe::16) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 18:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 18:18:11 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 21 Jul 2026 13:18:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:X86 PLATFORM DRIVERS"
	<platform-driver-x86@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/6] platform/x86/amd/pmc: Fix msg_port restoration in amd_stb_debugfs_open_v2()
Date: Tue, 21 Jul 2026 13:17:52 -0500
Message-ID: <20260721181756.143084-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721181756.143084-1-mario.limonciello@amd.com>
References: <20260721181756.143084-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 3316c815-b4bc-4371-eccf-08dee7546c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Qwf0WDRVQIrTWdixouAyW4pip7LLglr/fc2iF2HDUbF0/2AMGphinMN609xKgZ0lqUBNWU3Ob4FId1zCZ7DB4oERAINDfQi1kw4YKV5n1uKzLJ6XxJHG78H1K+NW1xKhn6UAhNI+00Upo/XMJMTfK60vqGuqbLsfAdDg8V69csP3ceDNS7MSESKpBHAkABsBmOYMeif5fWxShRSdDMLyGknEfl91e5C0NzJPxkMZbgpL9XZmZA0LIdKo6RfADd+SAnQbNilJoDgsNZRE9ZGZsSS7o5ZMbhF3w1SYwomI0uKl382FufwbHM36wKxyyOHh/hdYHfNpCEtPmlY9z2GrQzKFq3Utn4hphMexVc7odzXzmI0aPv4+JSwUeiGqCeb5C0Tk1a+pHBoNJ6uFegnRG7GK3iOV+Ir4eWyNPPSmlFamyQ8ia2Bv/TcTFBjUNSKUPSzmq9i8ocluEeMbBdtwpJUG6Z4cjYx4+rQZ12Q2Isrm/e6xcjhbDVcfVn1fECThQw9Se6gXJ77yc2g14DwZ/W1eSsXlzHCcoh5iBOvU2MHW7rKwjrWF4fJMBdqnhv19o4f7476fYm2GdYKsu47j7lpO3MyFKIs/CbjOfSxKkPqlqBDkIPPQnutqHhhPHCtpdDDdqaZZT4/u/gfv9YSceE0+6obDJLlsxOpdcbi4wphWvp2CyvNkIFSVXNbf0Vio7WRfJ4TPWaciBvv6kp/t9A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XaVNNfe1KDCKkjaEQdwYesHjVyitwHk+/C3ZMMlw28XNSyjQ4AzCNiPC6D6hvLSyqIVF/eQEMyDkdkdccAAvQLeXS7xQ1RQaVYZLvlyVBMVh+zId5ckR19wMVSWilXhKnLMsjpP/Rx/x15nUUCq+b96DzqeeXry1OWVMPFMqWJzedMQzgtx9GnVLsod8UHeybgb4OeQYl6Vb7hVZ2NRklyGyTmd+NIkBrLjoYXxyxRpvY+VPfCCwJz8XDQ4+V6gngmxqxHUNLHpAz3JvoryxK30aCeZLIpuPEh1nRT3NGo3Jpf+IAq8YoaWiIQcXGLGOIRNvdRWkJ2oriZIxUwJk5YAJmxICGMajlKd6rOeZCcNDJF6ZOEQf/y7dHoqVRz/l7+tpV3DiDB99xo+jXjLQD1bi0Ry+HawW6TAh78YpUjfqADcSsKKm5Iv0qamu+7w7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:18:11.6282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3316c815-b4bc-4371-eccf-08dee7546c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753

amd_stb_debugfs_open_v2() switches dev->msg_port to MSG_PORT_S2D to query
S2D telemetry but only restores it to MSG_PORT_PMC on one path.  The early
return on the dump_custom_stb path (and the error/allocation returns) leave
the port stuck on MSG_PORT_S2D, so subsequent SMU communication - including
the s2idle prepare/restore handlers - is directed at the wrong mailbox.

Consolidate the exit path through a single label so the message port is
always restored, mirroring the fix in amd_stb_s2d_init().

Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Closes: https://lore.kernel.org/platform-driver-x86/54655f38-edf4-e756-e24c-5f4cb041d63c@linux.intel.com/
Fixes: 2851f4f8ed4e ("platform/x86/amd/pmc: Define enum for S2D/PMC msg_port and add helper function")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 83645c0a8d785..90b8a5cebfa82 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -157,7 +157,7 @@ static int amd_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 	struct amd_pmc_dev *dev = filp->f_inode->i_private;
 	u32 fsize, num_samples, val, stb_rdptr_offset = 0;
 	struct amd_stb_v2_data *stb_data_arr;
-	int ret;
+	int ret = 0;
 
 	/* Write dummy postcode while reading the STB buffer */
 	ret = amd_stb_write(dev, AMD_PMC_STB_DUMMY_PC);
@@ -176,22 +176,24 @@ static int amd_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 	 * the enhanced dram size. Note that we land here only for the
 	 * platforms that support enhanced dram size reporting.
 	 */
-	if (dump_custom_stb)
-		return amd_stb_handle_efr(filp);
+	if (dump_custom_stb) {
+		ret = amd_stb_handle_efr(filp);
+		goto out;
+	}
 
 	/* Get the num_samples to calculate the last push location */
 	ret = amd_pmc_send_cmd(dev, S2D_NUM_SAMPLES, &num_samples, dev->stb_arg.s2d_msg_id, true);
-	/* Clear msg_port for other SMU operation */
-	dev->msg_port = MSG_PORT_PMC;
 	if (ret) {
 		dev_err(dev->dev, "error: S2D_NUM_SAMPLES not supported : %d\n", ret);
-		return ret;
+		goto out;
 	}
 
 	fsize = min(num_samples, S2D_TELEMETRY_BYTES_MAX);
 	stb_data_arr = kmalloc_flex(*stb_data_arr, data, fsize);
-	if (!stb_data_arr)
-		return -ENOMEM;
+	if (!stb_data_arr) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	stb_data_arr->size = fsize;
 
@@ -214,7 +216,10 @@ static int amd_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 
 	filp->private_data = stb_data_arr;
 
-	return 0;
+out:
+	/* Restore the default message port for subsequent SMU operations */
+	dev->msg_port = MSG_PORT_PMC;
+	return ret;
 }
 
 static ssize_t amd_stb_debugfs_read_v2(struct file *filp, char __user *buf, size_t size,
-- 
2.43.0

