Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F23A9002;
	Tue, 18 Aug 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024736; cv=fail; b=k83Ik6Qy9L0rK3uPXnZC/2UkzjrYUxHZUwQ97b5cmDVzv3LuoHQScIZ+TFbIZYDWYB6zX5jePT1WFeQB+/l+HIr6uod62bHB/Xo70nEUhWCdkjqBFqaLkfvcMUAt0bJ/UsKcvN8CTATssgRy7I3Jpe3I/FzlbZA0bD3pQ+eKrj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024736; c=relaxed/simple;
	bh=Koho1l38UfCu/XdwxrWn8BVFGPIbDQXwrLQ8b7LWG4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mA1zm6BhZqiIJoPEzYM7uz7lh4Lv6rQeXnf9C7yUGQS1uq+A/n94auLs2FcGJS8NCrm0ZDGeNUmSJ6G9Lsjcmra69+1iWu0/GmQZLVqBGDejHZNKYJG52KwvjUoKXgm7AUPsnUHLtQIOkaM8m1s32sbzd/WE2byW8qsxH7XoFvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WhwC4pba; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WhwC4pba"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fq6oGvec1xpEcpSXwKaxZtUM+7Npjq1+7GsFhGEsUfWsFCMsthc4Zb95XUixeJAu2JS9ETue8XvXYIiJAr5GsFdES2zLY2fxvO0exE2YxMhbJGSXt7QwkqroRpKRI3ZmJvYwA7IPVy3YtVV2UZai7cDumHur3l5SFlB7D/6rvRKN3i6qcMPBAamFO/wba589UZcRUn1LQTemmVxgYeXHiX6ka1xhPyMmqgjHmZlBzSVU4XWieZWcrcRr90FROaYAEZ9hgLtjpxikcionzjVyAS3CSQZXdDsiAAK31YtLHrxXzMgoY0eV/0cEYUX712dxOFq7scHkKfC/ztjsQrARmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mTeOThGYZ+ZUWOM/QdPo8XB4vpdK4IxySDjXVIidx4=;
 b=J44OTCL8sgFcNa8/IaMGPaEOSUAphi5+fBBmtEesPB/isCjpk7vC6T5zTdiWaqc7N6gjVAJw+bZ+F81FBtEw0Q7UhRiZK45dqhYzz6UYC95WIZHKSZJl/iI/SYg0w/v2vjcY/00X7qtcuRYmbGYsF6lXVYC+ILQIP1YqY3TRPACqndFMwekCwJ58nseA54CkgBNTe66xdUjRG5Lc6TIcYTHh+Ps4cW0OQWMsPJVp3K7MqZ/2BVyrJJOYb6iJtAj2pDeaYOaIFeRhe9YKsAv3gPnaC5FiqDL7giB7a+hGMrn9I4qanCPm5WSf2v9UqPSq0B2bUrZVdBbR9ZmvGjfwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mTeOThGYZ+ZUWOM/QdPo8XB4vpdK4IxySDjXVIidx4=;
 b=WhwC4pba7Y0IeFTmmelbLWS2UYjoF/tORKB6hb3G2vmdqGg/bFTA34/S9y0j/LX2ZThHTHWWUcgtOXuVwxCWYnm2ZSmTcDOkZDpMuxhjxGRPbvLNWfa4macRC+Rp9Oy9dimAdb87Jf+yGfc873gL+gBqCb6LX8jJIKex0Ucqy+Y=
Received: from SJ0PR03CA0149.namprd03.prod.outlook.com (2603:10b6:a03:33c::34)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:45:30 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3) by SJ0PR03CA0149.outlook.office365.com
 (2603:10b6:a03:33c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 03:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 03:45:30 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 22:45:26 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 18 Aug 2026 03:43:47 +0000
Subject: [PATCH v4 3/4] dmaengine: fix use-after-free in dma_chan_put() and
 dma_release_channel()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-dmaengine-kref-fix-v4-3-c6ef991462a0@amd.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787024717; l=1879;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=Koho1l38UfCu/XdwxrWn8BVFGPIbDQXwrLQ8b7LWG4s=;
 b=tXjLUM9a/6QI4iDCvQ4OSWRaohI+PjGMkY3xYVpUWJcogZiQ5HEpJ1dDjLL8j73iSJfpNMI4W
 0HJEAIv10iBADyd1S/vDD4N5pzq1WpRn4iLwAlZeCin+F38F8Sf4y58
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a6d6c8-42d6-4c5b-be64-08defcdb2636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|11063799006|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	03VxXDAcnOmekg2LyeDtmRh++SXQQXVSWvfwsKheMsqduJofi9gNQNJSPzdKW13iWbXFpZqZHeKdoYIVtnLXk7A6FCpqr05gnCiwm/U3ukO94OKaEcqqkalpA7M8jRN5ZaV0ppDPH3/Rfr5pbnD4p/JIGfvXK5lAr1luJVhHgkfxbP4JIq3AKvEx6uG007olCJV4B59Br4c6MPhL0XI9d5cYdw3vfph3f6OFwIyYLBpo6NPLT7blSehhdSeMSSjLI4hh/Dc+KhbJ/Qv8h03jvbiiKrGo3ZrwoE4n12WlZspRiRyrT7dJ61zS7xWQQfq8jYauwMV22GcYZ9L5x5LFbbW3OC5HdAz2eWU230YKNXrsrbTrZUurtDoHpWL5M2MGgBTXPUJ9VZJOjjJW5ogaPXH2twfGOvKXTAlY+m3J0Ld7mYEPeVrP9i/jglAkSZLkMzCWpD8yX/BsFHAYsQqIZsNGpdT7OTv5JbKTkQ5ORv1XaGTddDXmDgg4HFlkQrWDR9RCV1d9A3JFxIxcwwJFLXQT1F+Wl9V5pbificKrjHZpZOSIa6pCwaXBIFAgeHNhdGTtVOWYPe4vXQWL0k0/rNIEi+QQQMUF3ukhTGH1YHPFg3E199FXHpbGf96OwIUDAQRUaQ+ufqgIMK16jB+Btw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ozu+CaLCOggM02gaZsJi/Q9QO4szbg8G0YHDhQQJ8qQFTWUBSD58xftm0Pmfyb6Tj/4E6SFI+oK5oNoVpxAQbotxO5lEBiDWfHT5T8smmXauEtTDYkAfAPQRs6arSlj+FFS8CMURFMgm6sBQi1bsOeBFJyhrjZZZAa297menbdeTAEydoPi54gccJfF/KOy/NKevpo96AAZnfZNtbxvw7HjQJOF9W9KNLnfdzxU3khKMjEUuo288dMT+FkDmTUEahER1XwB/YlMTWaDUiKt52DegHiM7r87KSrjO8De8pilu3iY8KHx8jtrs33QnL3IVmGI2dbTeh0f0SRPdfhDWT+AdMgEMpQS5KCUgpzY8rbxvJE4vgIw6e7uJSaAyyPIqnllqrokf3Jc5r0OXzq1oGnj7uaP1u1KZIssaRNMgtkfLpQz0VoLeGpUUIhqDxe7q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:45:30.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a6d6c8-42d6-4c5b-be64-08defcdb2636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249

When dma_device_put() drops the last reference on chan->device->ref,
dma_device_release() runs and may free the dma_device along with its
channels.

dma_chan_put() then still reads chan->device->owner via
dma_chan_to_owner() for the trailing module_put(). KASAN catches it:

	slab-use-after-free in dma_chan_put+0x3e6/0x4c0
	Read of size 8 by task insmod/6319
	Freed by task 6319:
	  kfree+0x225/0x470
	  dma_chan_put+0x395/0x4c0
	  dmaengine_put+0xf8/0x160

Cache the module owner in dma_chan_put() before the put so the trailing
module_put() does not need chan->device.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Suggested-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 3ae53e11e54a..d075051dd187 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -500,10 +500,13 @@ static int dma_chan_get(struct dma_chan *chan)
  */
 static void dma_chan_put(struct dma_chan *chan)
 {
+	struct module *owner;
+
 	/* This channel is not in use, bail out */
 	if (!chan->client_count)
 		return;
 
+	owner = dma_chan_to_owner(chan);
 	chan->client_count--;
 
 	/* This channel is not in use anymore, free it */
@@ -523,7 +526,7 @@ static void dma_chan_put(struct dma_chan *chan)
 	/* This channel is not in use anymore, drop the device ref */
 	if (!chan->client_count)
 		dma_device_put(chan->device);
-	module_put(dma_chan_to_owner(chan));
+	module_put(owner);
 }
 
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)

-- 
2.43.0

