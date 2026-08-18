Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAEC3A9002;
	Tue, 18 Aug 2026 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024726; cv=fail; b=SBO7lS2QT8PJc3s8x4PzSapR+EEim9c7qKC/aP0Ucd27biAA6sWQ0pbBS5h0PxsTVuS1SLJ1GTDng8LVsdn2/fPxki0iMWMvpozAS65QqzVp7Vs+XlqY7qQMd/goMsBPB1x1rinYIUs9dyfwlgBKqvkDJcbTA2KOG0VIU+f8Rgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024726; c=relaxed/simple;
	bh=28/J5EBQeTYnru6MmpL+OuRNcH6d11p98JqlPBrLfZo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lWqudogVaDh66lnvPDRahvt12p4GCye3U2QwhqRNe+fPipW6/gwHd8iq3mbq/EA2YRFAjzkkctuLJcotbZqoN3N/Hb3IkcNuFXcZwVSNdtbbgwK/cNc5cTaC13vLb/zepAV/E4H1ET9qvJ7hDYPH189YyzO5A9RJKsuLL5pTiQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UfwKwpLS; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UfwKwpLS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Inp1LojHR884NTJCp4kOQaqxPGWGVa0S4zzwmUkbfgGF+mBuPEmXpM25JZ4YH5QyqA66fXHXsVOUl6rLEdvGBxV5qge40mtWlDrI968asUCsfQfk3FTM7PqSt6+EkYuccw+6S10alX5HzQPE9KYMOimN1fatp0pn4m2aaQuugzClplE1+YyBL9pOD0ITdqQafcB5shr6OPtKhda39HQ5koIAJN6v2FcZjFbGxrwMXG7mmh/022nAZoAtZ3hu6cKNT8pmEM8kLlpToORSzmLvyWhUB/MylrdZvopbi3oxUUcOBHFnE+X0XJy8Dq5Y6D4K8i3ST5wVJNoVYsKpNsGlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x98i9NQzYmXVPca0Lb8KYWNmyROU6OxRZoG++MoS+TA=;
 b=dV6tUMuJvEhM2/CV3C6fhgx52Wbp31MOloZC1VNj4GSDZd3OD7kgOEFSKvGMYmnhEMH7ezv/NMCkLCNGUvLJ2u8toyVr9OwGVn6nK3GHFR9oGG5Sv3wsvne90n64bUhqTK+UrB/ifiag+tl86bkV7X7QEGw5hAkICliwcgAQl5qS4F7V8b63Gj3ouiF4PuaPMapSxGuUlWIRntZOwMM963xGsS/N5WMuOpAHsKUTpwaj8AHUaf1fmQREacGAwirFM1xQSpM6c1O43azPXjpzQY/n+y/MqIkCAhNMSbxtwgCTs6XI/4vZdIVewQTqy7ZgrI4/yumy3ezsX8Bu5Jpw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x98i9NQzYmXVPca0Lb8KYWNmyROU6OxRZoG++MoS+TA=;
 b=UfwKwpLS89MHLtTDXs3wuIlOKMzONg6UsgBgf9NahJ9h80K9hZE6C6cBevROMQxE5fL4iJMbLAXNwnZdd+TP9lzJ2Zv3cdbIosw/oc7UpWEucbCPpvCcewcUQN0IEnX+e+/Pa3Tyj3FGODsZ0iXYf1I/GhNUVRg/bTE4LO+6Lng=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Tue, 18 Aug 2026 03:45:21 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::87) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 03:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 03:45:21 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 22:45:17 -0500
From: Shivank Garg <shivankg@amd.com>
Subject: [PATCH v4 0/4] dmaengine: fix kref underflow and UAF in
 dma_chan_put()
Date: Tue, 18 Aug 2026 03:43:44 +0000
Message-ID: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDUg2oC/33NSw6CMBCA4auYrh3TKX3pynsYF6UPaAxgwDQYw
 t0tbNCEuPxnMt9MZPB99AO5HCbS+xSH2LU5+PFAbG3aykN0uQmjTFKBGlxjfFvF1sOj9wFCHEG
 VDI0t6ZkLQfLhMy/iuKK3e+46Dq+uf68/Ei7Tv1xCQOBOIhOU61Cqq2ncyXYNWbDEvgAmdwEGF
 AoXJDXBWIruFyg2QOM+UGRAeSVRK+TChQ2Y5/kDOJGkVDQBAAA=
X-Change-ID: 20260518-dmaengine-kref-fix-7b21acb09455
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Frank Li
	<Frank.Li@nxp.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787024717; l=1381;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=28/J5EBQeTYnru6MmpL+OuRNcH6d11p98JqlPBrLfZo=;
 b=HlTNJ0cNEw5PQwAhra4uSLasFtQQhHmLbDIvlcHcBGSY7qA0PJ91G0qWN6kIAOEa7jujmnF4d
 7gSSFgYvIl/Amnj15l5v361Y9WF+jW8D7bNY7fbcrSN55alpeKMx2c6
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 026d6053-fc22-40e1-d97a-08defcdb20e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|18002099003|56012099006|13003099007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	kBI5cHmmdvA8ehuJWKlBhakwkDs6rKPD/PQxYq/QGd0z2s2zTM/FZ7rGZerasFxMN/OhFIJftvr3tWZSYraft1H0btp8HeAtWc0YKGxGkJQoc0R9JP4kn37pmE8MugRKZWbLvc/1eYaMwMsvMhMpMh/zwBxPrDI0/oVOCCZXu2z5IdenS2/J8Qz+8Br2pnAuOB++TLFirJ2wUS3qjdd+/NXdDPOz7Wq3srrom8DWf0rcb2kEe+nOcx0y73nNc+5fe8M3NTgB5lWwvCCGuYbgNduZPXKnCvjcedoLdF62Ld3gPbk7a4DCN+2gae3vha49B+LUlxCZKEQxpBuv26kYXC/vDe5RIVDJzD5ydAcwQhjO9EZgYiVD4HQICMMdXOVWpSkG+VltARqCWxI03tE9VK5yFhsxfs1htBYjyxr/hYxCQjGs74PHUEPvhc4ipYMUoDyZbZ+YvShVf4dcp6/Q7i0M4VDgV13B5tJ4rzPVCpksj3O/GJNeaHbYkbef4wwmVFDRCQjBKodgZPNCgqN/ah4G2HMNVztAzRZK0BKKLESCgaJFt3LZa816PPp1s5IZayYNAGiWduLnIfqWuJlJU97ZEKoyB6Pl3fu1RFbPSMbM2Z7ViTQEXGMkmQM1N7BVuYJaaWh46CA9PxPf7z1H2/NZjBxD7bzreA4Kd80sljZ67zqCs200a8NYa7s5q1U78wvL608yLjy7bdlOZmmTZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(18002099003)(56012099006)(13003099007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PukXVHZwbd7Ms8H1q9LojX3i0WColNIe986UfUZz00alJEKg/Rf0+DhKCjaHK/0cpUpzo93X8WYBcYy9zsCwdzuSpqs0X7IcvuAk5Tn0PZ/7517aoosczuVQynRrGzpyu+EypjAWCcxsQtjDxulaaKqMOiLACF0tqNTukpi9x9QS9Nz4zIuBV9C956ZF6ESbe4lNXjOCrSv6E/exNbWM2xPj3jum+fpBG99Kg52WqOYLY6G/0qwduQWpLcE05KIkrGtew98g6IeTKxJnkLlfyiuntc2YTa161/GkLXtkwUgAOzqgzPMO3AsOWmwFIxcV+G1BjqOyeH31chVpxyTuZJxwzh1jjK5m50BpG8aE6qJuCX+WxCUzzqHD0GXvEvyPvuxPgVneg18tixB9cks+4lBcBb0/dMN21cFr7BaSVVw7vGt7xDf4UDHz8MpcGMK5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:45:21.2250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026d6053-fc22-40e1-d97a-08defcdb20e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

Fix bugs related to dma_chan_put(), found while testing with SDXI[1].

[1]: https://lore.kernel.org/dmaengine/20260605-sdxi-base-v3-0-4d38ca2bdffe@amd.com

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
Changes in v4:
- Add dma_device_get() helper (Frank)
- Drop dma_chan_put() move change (Frank)
- Link to v3: https://lore.kernel.org/r/20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com

Changes in v3:
- Add patch 3: add synchronize_rcu() to wait for RCU readers to prevent
  use-after-free. (Sashiko)
- Link to v2: https://lore.kernel.org/r/20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com

Changes in v2:
- Add patch 2 fixing the dma_chan_put()/dma_release_channel() use-after-free (sashiko)
- Link to v1: https://lore.kernel.org/r/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com

---
Shivank Garg (4):
      dmaengine: add dma_device_get() helper
      dmaengine: Fix device kref underflow in dma_chan_put()
      dmaengine: fix use-after-free in dma_chan_put() and dma_release_channel()
      dmaengine: wait for RCU readers before releasing dma_device

 drivers/dma/dmaengine.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)
---
base-commit: 0d995da5fb97e8c312834575604d4423eb6225b7
change-id: 20260518-dmaengine-kref-fix-7b21acb09455

Best regards,
-- 
Shivank Garg <shivankg@amd.com>

