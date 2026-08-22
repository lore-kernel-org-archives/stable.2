Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062739792B;
	Sat, 22 Aug 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426553; cv=fail; b=CGLBPROxgvuNoj9hX2JWd4NdhFT69euoJDjgs1993x4TCpdI5aVVRh2pVVzPeaE7DhGEq8JndZsvzr0MhSjXBB81K+B/zUVQfg1pbuWPrBfLrYNSUjV5W2fiksZT3urmnRBIGkCYcXeKt1DEKv19G3SdMcu25Fry0WPApFVxgNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426553; c=relaxed/simple;
	bh=xaddx9darcAdVHfugBdf0HJWW1q15PBK4nA8kesfv6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DUG8qW4Ju4MXrtbEMHiyYmyrq6h8XqNyQmaIlQHjHAD9xzfvVMguh+42AuZr8Ki5UQ3b6BbaVSuMY/R7egwkeztydvYvWKxaadwN+uLN6RTHQnEwCOlBLr+PK+w/1IQbZtuqIEzGi3iB28uc/HCSQx8PtvRv+GsHluStoKmMaR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jqEO3c1E; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jqEO3c1E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ugr1fQmERoqilBbAW1oxHTJLQdRbqfAjb9ArDOb12Cq/emQdhq6eM/nb9wfN+4Xv6DE2G59OiDT+4Hicnf+5Us+2PFxq8Co7pageLkBv8IzDqjRUS0MbK9oVh0BFsCjhiwz/BY9XCTh+dtSyE7hQtE13SCNWs1ujnpHxhPikzgqIll/wKGRgHxoxSjyAbhIQdUeT73fGy9+ge3SPbHK9/oDn/UGvVQe84TAZT5HNMHY4KKAdJSLix3VFQjZh6BwR2cxCV0CwLv2pLrHpyIuGhnTJc0aoTrvHdGzxEZfegCkGDg0U11bVbQ/5ZSyM8H9PZhP7awgjq+CepKeA7D+Ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6F4GljtMV39yrVvUontfkiNdu2jUcNC6286tynCZqU=;
 b=mNeJJdDHqw/ij20oVDRS6ZvrDu1srOBYDeSmbbSrl0qWsyx1zctov8x3FdUmaCHh76VQnNqhQwJgU782MXRw6YCJB3n3gwzxEdI0KY4HO/uQxU3d87Jh2dwxHJLGshbo15PezvG0k1YxtpljY1FwlDEGJseJ+mDabPuZPQ6jbZH3HU+IhNCx4kARk5epsRgw0cmBwYMgIJ7abTbjmA42kjxCk5RfV2WsVHHsJZ8hD2GjxbxaASY+llhtNZbzYSrDj5zP2zjz62sYA/P7gnoO3N/YIka3W29EMjfeZOnPl6IYAlFXKhYZ2xbaJBi2xwFm0qQhpJlohGZbFULVAynzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6F4GljtMV39yrVvUontfkiNdu2jUcNC6286tynCZqU=;
 b=jqEO3c1EB5DANN8s/Wd7X163IO9bGythbPZ+EilcQi865nqe13S++OnZBPI50sPF76L8GfXQz96vDbUajKxfaNBZrbzlTBq8Ksjbe7KHrZVuAkZS2afCukfJCQXlDGWr+1MtwaBwavGxPAUsbvgDJ7zwZOyVTJZ/ZDBS77x+TTQ=
Received: from SJ0PR13CA0194.namprd13.prod.outlook.com (2603:10b6:a03:2c3::19)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 19:22:27 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::55) by SJ0PR13CA0194.outlook.office365.com
 (2603:10b6:a03:2c3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.5 via Frontend Transport; Sat, 22
 Aug 2026 19:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 19:22:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 14:22:23 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sat, 22 Aug 2026 19:22:06 +0000
Subject: [PATCH v5 4/4] dmaengine: wait for RCU readers before releasing
 dma_device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260822-dmaengine-kref-fix-v5-4-d4a4ee47d927@amd.com>
References: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
In-Reply-To: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787426532; l=2079;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=xaddx9darcAdVHfugBdf0HJWW1q15PBK4nA8kesfv6w=;
 b=NWq/cpEP4qvVM7Jq5FO+NAZJx+9fOlrBfiefbcsOXHD9wbEjGnTrlYWq0DTcIqNmWIR/U3yxu
 Fe1bGr3IrouAFd4Hl4TFGYgMFUOsMFu6or9P8hKJ8WpHJByL4Kb5Uf3
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: f36ff150-c11f-4a99-b658-08df0082b3b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|22082099003|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZK18RBJ+0+YELM4TimoV1AtAgTVYsy7RWNaNO1oNnEDbshZ1sVswywwRPbE3OSl4tN57+jlV3F98aERltzQfRuWa+xj6UgiVnOA2IL8bX0cF9OUol4yBx133J4AOIol1qEo/ftgTauSOjx7VGYcbxVJ1G6u0L4aCpbftvrdeczhA1ms0iR3MYsLK0um5zBfSoSL0oRD7pYyW4vBcZyZanEOwQGqTXY43LGhkgSqIUCtp1TLfj3BAhenqvUrqQbpvjoy/5ddOaL0ptVJBRi8LmFeioUVZZpClcivWns3K2wrGcC5Zxfn9FEPUCog3I/RiyV7I4/1q4qJ9UjH+2TwGqUdecZUNCasfBjwK3ZIi8KyK4ofcAQvF2dCkzVoeuqKhHdGIFyM98+mOeLw+26GkeGdNn0CjsDIVVp9hEJ/wOOt5myDVYNRbJMdS8up7Cw9bkfJgkZc5S6uxjmpOZYG7VvK3GV/xIa7yC4bfCsrCgzOB7GxXgMtqT1Wnyt7c4pTsHoGv0fVrF/K1lap3LzKk2f4j1EqTJHSCwaU4mgj4LqVuqYicwDY0tpXQUEl5iHZpIODJTse2a9BTNe4lfUomYF1Qpys7icmf8e2t53Ljw2kJlGAWKr52P+h9CP5iC+aqbOKfQMCfXMHCZymDOvBFUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u7PZQ4vapYiiPjIVH+bDnYxsvf0G6CQZa67iWtcIjruljAOYHpgpGOQW0cqyM4KTPujjjXdjgDmbO2aUnN0COSTKxQj8qzwV8Fj+cGZa3sUcFpOLpO9VZAE5+d5UzqdLh1fogVi7mIR3NOj5DF969ybAN9mi93XtZEaEghw9DXDXo/J8dK7yvdn66iV0Gk5G2g04luuQR9An/0GahX+mrSPPogCem4FsLmkz4CbwJZfYoehfVS/fDqoaxn3d4XEvsavbUSS9cBB6ZQX1WizZTBlVYA8gRcxxrO+NZdtI9WFbECyDg156DM5vCHozwCl18bJGQSTBIFclOphZ9omyuAY0Cl/utgd32/LCz5FBsZ0EptRNqAIHPlmK9Xbs78tRiutwxvxODkyYXS/n3vhDfCETBePJI+RC/c9qUWuq3LHAcnS+8psAUupYNlKHOapN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 19:22:26.9159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f36ff150-c11f-4a99-b658-08df0082b3b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

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
dma_async_device_unregister() returns. This call will delay for a grace
period with dma_list_mutex held, which is safe and only teardown path is
delayed.

Fixes: 2ba05622b8b1 ("dmaengine: provide a common 'issue_pending_all' implementation")
Suggested-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260526-dmaengine-kref-fix-v2-0-3df60afac01d@amd.com
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9214b9272a55..f9bc3e69fe58 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -428,6 +428,7 @@ static void dma_device_release(struct kref *ref)
 
 	list_del_rcu(&device->global_node);
 	dma_channel_rebalance();
+	synchronize_rcu();
 
 	if (device->device_release)
 		device->device_release(device);

-- 
2.43.0

