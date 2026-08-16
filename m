Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CD435A38C;
	Sun, 16 Aug 2026 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786895397; cv=fail; b=e+S/X0dyZdfB44WLUTBpe8z33FXn2afyS16jOtdORAWH7NNtara5Ixo4VYJhWixMo63G31V62wG6zJRXUn3knIP0AdPHjHZTdO4x00wdt66iWEMtYJibIsSm9zeVJMtEp6TLmxyvQ4lfrTvxB70bwTHLpJYUrq+PY24on5CsW5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786895397; c=relaxed/simple;
	bh=jxiqrS26nswZvJrOzWQ7M3DiiuDTx00kRIcfIiYoFUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NinwRlvtFKheZa4+EFSxn1ambdLBLOgQD7m6HSiXYTZ+R/1EGWn6202UeO+aKA9P5i/mdaWuHeg6goq4ZIz7mpPCRhDFTva/NMCyzvSIiCLgn6C5FUtaOEIzSygySu2LccqbediFD609aYWs9caKPrlposOmxt1R5itAhued8Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RaD2ZIL5; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RaD2ZIL5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD+/fJQX+YM8pxJ1+nFO3RLrvKrg8TgYTEetdowN28AEuHvLJ6efYLytGzSbnviauH1NSE0L7M0uUQ6Sie4A7iWZxXmQl83oFV1U24wX3166+0+Xa1O5EAWH8+3jjl1RHgNSg2H8JS/cXOZ9+cRxs/w7Vr6qWnWryZdGymzzcuqciE4qECACbtoWb26vbNgWk31t9aQsFGaw/4xkC8U2Jy1da74V4avk6rr1d6ETWx3iB1uoZ0X5aQK98BShI6RfeUNzRfELcCoiWHcuqYqULlveUR88MHFAu7bEjhwMhp8i7d37kCC5NZvNdyrxKQFEpqQpq6Vht4nhUzHiTeFewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j/8RC/1QOjOmvJ/5FBPVw+5X39jsQAEIkDBQDOwXPQ=;
 b=YTF92i59MPYjAYE3XsjTluJK5IDRcWeUxn6g3Pm9DQ/rIoo2D/cpVd1mEQtwZ8oI3ptFmp5CxRAPfII+kIcpLAuILO7h3aCEUesW1WWDEisN9m85QPW17Mm7rj0ZtVdjLjJeprEgMQNFdU8AKN6c2fi7fCFpHyi2rmyKaY1alSfPShZaj0iMbHQuxjfG7LOGz+g29yX8PeByNXGYKqehaQDFPTk+zpsoRJrPgAupobrxte+2E4AcdexgoAJxQTD3gyzEEDZqJbe1g9mo4ANxGhW8intOj+6WVSk4jCkINlHiogUk4MEMdFuvD9SxGXZufQyMTGJOzzW5s2WYpNFuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+j/8RC/1QOjOmvJ/5FBPVw+5X39jsQAEIkDBQDOwXPQ=;
 b=RaD2ZIL58pY8Ik0hb2cfGiAVx3IrZInE1tHPPLjOsV7XyHrFoiM3PdFaEY/L9lvssn7yaawzw9p0tuP71z/8kACy25+BPwMPZTuEa1vHjKTH5RmrpK10o2fPRO4F5JIow6oXxhd8vw/6g64T2N4UvAGIljCLExRrcGrhMbE4fA8=
Received: from CH2PR19CA0010.namprd19.prod.outlook.com (2603:10b6:610:4d::20)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 15:49:45 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::c) by CH2PR19CA0010.outlook.office365.com
 (2603:10b6:610:4d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:49:44 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:49:42 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 16 Aug 2026 15:49:27 +0000
Subject: [PATCH v3 3/3] dmaengine: wait for RCU readers before releasing
 dma_device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260816-dmaengine-kref-fix-v3-3-7e76187145df@amd.com>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
In-Reply-To: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786895373; l=2066;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=jxiqrS26nswZvJrOzWQ7M3DiiuDTx00kRIcfIiYoFUI=;
 b=/uuSh1RH1PDp9cMe4PWWLC4i4eMMKTPkz40gBC886+brLf54A7amVji4RaYZuTclD4rLkDmtU
 V76zdRHu3cuB/J/Sb4nypHrJq+ZY1pizk31kdmlPVSLrv7Q/1A/ATUJ
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 9289b9d5-3c41-4284-b15d-08defbadfe64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|13003099007|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BPRKIJRUhnhYFLlAP/BAW6UWznHoXTc37T/+JP6BNs5FbzU9qfi+gsbvDx8jfAZ2kOfxY9UrJIIe3InIJnMkGUe8mBfPaUjh8Gf6p6l6ZKpjQQ9ft8P7riVbrMbFd71+jwzstfxFxbBlVz1LlDmiU54UEncjqleKIgx9+A8dJ6pTAYYZL7MbmHwAVAhLQ67H3HaHyDSfZDXsWbxDV30UzxW9RjySJYcYozT7b+du71ygSf18anPIMfqVVdmlUHBkucUYB1jH+Q3wXuOuu0ZeZI/czWJDRc9r+ZLP4zVsjwLZon/kNUYk56uslHZk3lAuKvHn99wW8NCHLUKCYU9Jp/WFVtxF+dBXZYqSz8R+kTphfcq8OOmBBgV16oMshKA2v4QM/c4R5+DcTH6Gg+beUQmYMCPbIqs6p1bqP2ydCZytHnW4EozUKtnidMSIdl4bZsaSZOjcssTCXo2BcREOwGAgwDRPfCckFffrDA3Ly1/NJROkqSp3Y+yE3t6srYHMYSwlQP7r8Bqz1BXHV5LB3+ni2TdSSChDn2SCYqPks5P05eikblIEzzYwzqb3Tie0m+NdHNODL9QMaFb/x48PAiF92hkg3PLnO1gT2L/OHfnCt9L2QZJGg+E2SdvPqFpFAIuyUs1PSI5rXxjfzBpDXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7sHZt1VHiPqXaZon9jt/800L20+HQmOZdWnU3n0vh80S/+8yDtGmyWLd1a+aQ2OuCimRyurejlzEqg7PbCxYv/n22vwD9j4NrqcDkOjmJrnpqJN6apwJma3C4L+JZu2nMCHiDwMSxdmsjVTNHFtnnHk9QYEimy6pU6WfSjRI39d5H6U4h9igwZJQyObHNmh5y/FoL/i+eQQ5LQpbmtfqVrF3uKtPvosuawjpMu3nBGj7m0oCM/mgp/XaXws3u40tQfHFVpHjlPRDPysSQlbmPZJdSBNBqotrh5JjIwdTilsHJZaUYbZogIVMFfY8nOV5ihto+xiZBvOuo9kjtTdQi12Sg43pe87mJKf7i2qXckueUwycbdWgnlYQuwPeIlIXFTP4E4G/PQOYpnNrk8RiVWIqGc0ukdOILLV0olGA/DZ1g1YbuWBEr9a/quyxIxxG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:49:44.8568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9289b9d5-3c41-4284-b15d-08defbadfe64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662

dma_issue_pending_all() walks the dma_device_list with
list_for_each_entry_rcu() under rcu_read_lock(). dma_device_release()
unlinks the device with list_del_rcu() and then calls
device->device_release() (which in many drivers, such as plx_dma.c,
directly calls kfree()).

Because there is no grace period between unlinking the device and
freeing it, concurrent RCU readers in dma_issue_pending_all() can
access the device after it has been freed.

The lockless walk originally relied on clients holding a dmaengine
reference to pin the provider module, and therefore the device, for as
long as they might traverse the list. Commit 8ad342a86359 ("dmaengine:
Add reference counting to dma_device struct") decoupled the dma_device
lifetime from the module reference, so the device can now be released
while a reader is still walking the list.

Add synchronize_rcu() before the device is freed, so RCU readers are
guaranteed to have finished. Keep it unconditional: providers that do
not implement device_release() free the device themselves once
dma_async_device_unregister() returns, so they need the same grace
period.

Fixes: 2ba05622b8b1 ("dmaengine: provide a common 'issue_pending_all' implementation")
Suggested-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index bf491eb10596..29b128aa0bea 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -429,6 +429,12 @@ static void dma_device_release(struct kref *ref)
 	list_del_rcu(&device->global_node);
 	dma_channel_rebalance();
 
+	/*
+	 * Wait for RCU readers (e.g. dma_issue_pending_all()) that may still
+	 * be traversing dma_device_list before the device is freed.
+	 */
+	synchronize_rcu();
+
 	if (device->device_release)
 		device->device_release(device);
 }

-- 
2.43.0

