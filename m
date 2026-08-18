Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A32580F3;
	Tue, 18 Aug 2026 03:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024739; cv=fail; b=WEjroHfDfLnz3qPAH9z/gkC/9OPy6qEQDb3vlkXPgrK8b7BaWd4/aOVj6v22XZ7zDwPUe395ToDXtKWuddRg+w03YopeygH+RZWBY/FS1UR6HScoUouEp1kpMP9mLUGERXnH5GT/OwbgvZdzCAGExwRaa5myV7zbfhiqUUmrxac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024739; c=relaxed/simple;
	bh=YSi7IKhN/NuaU9uIMzm4mjNfAyb6F+IdMO5AYQrzNSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=snA4aG0T6hjaf4ncVXc7auiTJICdVT7DXbmKMyIVWVH7g5AoxOOeQAZJ7ZmDyr3yghOroAck+L3JDqhMqAWBDjVGKqO7LJBy3jv9RXCS5zQwmKu2nJP0DtQcvOfVbjhOrjsA8KoDoX4SyID6ENwFcb2XLd/DWo6BwI/bXEhNl7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=phFSC19e; arc=fail smtp.client-ip=52.101.43.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="phFSC19e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUrlNiGNouHeF4sOK/Nf3P7dG5c50SBHWeGDAdJ2l6HZlt4tv9ztv5VMHl/uJm9p+zyFJxzNxFT2VLGyXGycKTORp6YH1X7MbFDJvbrsALl3OJxZl7St9LMewxwnU9RIIsT9WMRLvQvdbFUCRd4wLpbm9tdl/SV0Yk2uJ+Srcrx9ZcNqpvGUmTzb3yZM8r25xM1i6xELlkGnwj7gBwj9sRafW/KcRsQu1ZTUT9+VzNetYFaqXXbbBERYQ5DFErENQHh764q3NxJvcFmbmuWsE0MEO6yby1I3FMyYcUyUdaJafhpN+d2U3k1AyK4FEA6kxSnsxQKPfilkAjDL4rBVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er/FC18Ife5rc86z/dqS3QETqhGOoESpxq2UlLtMAJc=;
 b=WqirOYCZJRiU5pDnqaRHeQNo77L9tOfI9Ia1B35vAgoNe2C7qfx3YbCsTPWIj3QwnJQqS3JFDURzxxa9WB6HCsj9cTMxbe9Motg/Gg0tPpEMmSNEovSZGuKpd0TvMYwlEJq8iJKSA4XwuX/CcZE1OuMQV5aTEEwQ9B919Bx5KHK6pcICGO5EtBVgIFA+olnOIwreoWJ/3/MqQH1PeN81fmXNdaSuZhoxmDCJlqfPDHIduTvCWEfEpCTMdogq3T1gZzMQOD5PIbENjXzlpGXK8361jBdgD/TetucsPWUwbYiSMbxTEepKcKB5MfrDGIP6dofYOgaB+T/QN6p+aO7/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er/FC18Ife5rc86z/dqS3QETqhGOoESpxq2UlLtMAJc=;
 b=phFSC19e9mENQCeLO/rcbdc8LkNMTQ6v15KXrhJ0JvYU408RoG7klRx2h8AvbseUjMFI9ULzF4DD2chCX9Cs0ZuJW3pf5eXaxsmHDo2Vl4/RxtCmDI2L1nwRo+h9PMsOAoW16eBSeJXbe8wzPGA3Tv281cn+8y9nqUjkkOCcj0M=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:45:33 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::65) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 03:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 03:45:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 22:45:29 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 18 Aug 2026 03:43:48 +0000
Subject: [PATCH v4 4/4] dmaengine: wait for RCU readers before releasing
 dma_device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-dmaengine-kref-fix-v4-4-c6ef991462a0@amd.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787024717; l=2108;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=YSi7IKhN/NuaU9uIMzm4mjNfAyb6F+IdMO5AYQrzNSw=;
 b=nx+oNDkOBSQrK5LRjXfDxgSx1ZjKYerrcrf/3B2Glt9x+Y5NAzuMhEE+X9Q0UD7mMqkWXT5um
 Kp8tvleq+2XAT/0CHqaEY+MBlWT/WJc33oPdPRxci4SHqUp7cV9jsCT
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 252c88f3-66ac-4ad1-1671-08defcdb27eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	A249YBe6HjyexGQFneNzo4kAuQfKsp6mk8C/PytDbg1CYhfVg/Ytb1X66PVDHUAqr7Vbj3fyYvLk3IL/osZ9kg+5K/Cu0q19fi1FxMuTCmPX2aeEpgGLbcLqrd3itGturZGzKIkEcVKDoWU5iJ3fWLcwVf7X/KZAFUeZwLd+j2qUZPjSuqN5a6DVWqcmt7ciLvLNG5bLx5Pk9oFWzxlUn4X9IKXyp+1uZKh4mVYckiKbmYvnXDLww6Z83cioQsitIFR5TKzK7E9M4Zo1eZ4oPI7Y/aPf8zjQg/6uRYJ2nb2vDyLaXiKAFxQT4X/+V8LUFaQG/pomllsnznMpuNKhnnjfagmaxf/NDtqfnQIXKP3KcxxsFKN5Ap0PB418hk6XxpwmVWJai9GQbCNwprYOaCTLR/SwknmHtbndV6qSVZ/oMqBV73503HuaBf18B17HFZRwTBECkhmjtsRESgQ9MxhkERkViqr7/a3E1ItlF01jSsEk/Boq3jYYAeI69sUpNtoZYgebVsJozp8h944upq15TmeyyxJZrqG7POij42/wGOEvA129v5QPjtHgrMQ5AffvvMygQITXZ5lpRRNCUjRVoYxWT1E3gE59ujQ8/9sRLBujmGzt4uxYtDuE+M8NteTKq3xRWE7qjMlUyplA5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cIngy02xFzEJ20eyWA8KsQfEKJwiKbq6RvP+286pj2ei5OBZSjDmmGL7Y8xlFE6JHC53Dh5llT/P89xXBwQHNjgQ4ZGrRo1071+JuKm4gT2NT1ocK3hm542MlO+N8GrBbOTpUfadGadYFUt8Qa0q7FrIbpNB4iQxxADdy0i8L5Zu+2DWQHabDAiVxxiRr0yc9AxEL5sUQM42idCHYO7Ll/PKwOPvFCE88PCRgLe8I8JN4e0RIFhgydn4YEyZfeWD4Nn8yjAuOcACZmWEWshh/rRNMKJue2DvOQAcpL+a5d6MmEB89+cjROk9tF9uwj0wOBrpPkOrre5wgnNHm+181Jg7vyxvcajUrURdMiwc7htHse+QuGBvUjZ/t6TacZjbgBlTeGfqfKB6KEhfCWXTp1Pb3uiNyEAhaYl+doXqh2DyQ86kEahbS4mhUZIY73gC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:45:32.9661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 252c88f3-66ac-4ad1-1671-08defcdb27eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index d075051dd187..604c9af19936 100644
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

