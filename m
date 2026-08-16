Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369F3BE15E;
	Sun, 16 Aug 2026 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786895387; cv=fail; b=X08Gkr1Ahi87kKar0LAtbUg06A4yeblHMRGULPKNB4hwCxAGzt7L3uT1TJ2BOvBXoGh7O80e8fpzWNJh+/s0MS/PsoDVnnK6Viyj+zFp3PwwO192IB0n3YNGYmYIN8jc2boTEDF7ldjmNF15obR9Cll51eWKShDAnCPq850U45E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786895387; c=relaxed/simple;
	bh=KaZfgW51wL1OOUYVbCzQqdEmid76AtTqxn/a+5dH3UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UxVOcnO0MLF+Nd2RJumuZJ7k51gnNSmzXSqbBedrARdZndwtr5HynLFGwADPUwMy8sJYJ/dOjtr8vBeyp4lXOS4cUL7PeGAODerallemqsMfYIaenbRNYsMLpU9HgyVV8Iqdn1RyZS5kEtK+h1mEONzx8o41+fW8cw8cciGV210=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XuLMU9b9; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XuLMU9b9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flp+WMD4C9cWwtSvecn45gVG2DgtfMMoWoX9bWb9vL/ACWWoxzoIPbiAOl9S8FPA67HceP8rHf+0/oRirEMHwA9+rpJjVY9oMGa2CKnYNmvzdlfJ7LX3T/D7tbgTSWBCXuDrSLH+UDWDPImc18S1FfcRsaungD482+7xwAKG/hMf0cFYuf6IgpzTv8SXKRnsasi1bEwF3H4Y+0V9ZXpOo4MLc+Me872KdS2mFp20XmRPkOmxZLV7rvweFhHeu0edRQMJ8K232qM8FhHPyvA6M4CE6LPDJlf5x1kHuAmjWK1cU3q/pwKBBpRnv/W50ldtwNlWazoEPyHdeImOt6FRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS8wQOmMlJglwfw0HbzI1QjskZj4yZZzJ3XU4zwacN8=;
 b=wX9vqkW83sQrA9cXCV+wevwYO1+WKvag0EbiwRzR4di+lU46Rvn9wwJ4cQbHBh2Gw/8yM+x2kwj5KUZ/NXj/CJeJWfikvgtAmvuI+fUDH7KtkI4cwKngq5OXm2WIsHwF4Jv6wRGfLZI8LEG3hqy0cjCNWZMMg2eebcfIyyDRT/NisKi8pyOuhRb8NZwak+VtSddKBUeRXfYUWLwYaW9WlLgnQcU17T3HFduuDNtzgcpcLXQ7pZssGyUbNk34iJtuyRaQ7Cjpu8z1CyVi8vKfj5ivjezg/+nIa8m60epFeH+1uDAYRlLO+AietO8pOR4JLVxCEvzgXO3uyFkVK92ShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS8wQOmMlJglwfw0HbzI1QjskZj4yZZzJ3XU4zwacN8=;
 b=XuLMU9b9Iwt5smea/3Axs7dmXOWfUZ0BTp/3LK11mOdRxU2gTDtQ6t4gDasqQitYwPr53DAqp6FM5+/lnP7Jrg0d9Gz4NYcUfZujad3tU5ziKKD+BzaWHffpDGuAQsAkkxS7za0Idd3lloXoqBclik+2t5lbU+wttwndvon1vYs=
Received: from CH2PR14CA0031.namprd14.prod.outlook.com (2603:10b6:610:56::11)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 15:49:42 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::3c) by CH2PR14CA0031.outlook.office365.com
 (2603:10b6:610:56::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Sun,
 16 Aug 2026 15:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Sun, 16 Aug 2026 15:49:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 16 Aug
 2026 10:49:39 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sun, 16 Aug 2026 15:49:26 +0000
Subject: [PATCH v3 2/3] dmaengine: fix use-after-free in dma_chan_put() and
 dma_release_channel()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260816-dmaengine-kref-fix-v3-2-7e76187145df@amd.com>
References: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
In-Reply-To: <20260816-dmaengine-kref-fix-v3-0-7e76187145df@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786895373; l=2698;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=KaZfgW51wL1OOUYVbCzQqdEmid76AtTqxn/a+5dH3UI=;
 b=UdeL53r9xNWX4ZTvVZD/dYXUvemfJpST9mQtofIXMbEUBc/RtMu3I/CbGf1dTQTUPBgtyZfn2
 3Ld3oOF6V3jA5gfi1usMufp5hK/DgeR3lvQYVvT9Xt1R8MBiuKl55qZ
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: f98d16b8-b1a1-4f34-9fbd-08defbadfcbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|18002099003|22082099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	YAozcXx0ib3wuyD2yUTL7zYhhB5ikfWZrF6XJeMhEoFX2MH6FPPAkhrT5OZdYbazQrK0sa/IAsx8LnObrlxqt514tKBmM6c8urvl7D3DLReGohCEZJt6OyvsGqxNSSW2ih1Cz0NIZ/QbAeddty4cXjMSibQfZv13zaNN6XaSn0dwjEoH5FiFzZrR3uv2vsjs5YHUtTlhh+NemYsDxZFRZzHIaZMa/xT0/GgcDSmg86nKP/nTInuUJOr8/wpoQM93+pBPcpiedIF+QXuEQHnzTRw+yZabEsXPxlHOb+EdXd48zDWMohu1bngQZdph+62eNG0TphPwuT4LGmOB30jdl8XuRDg/FQxhqK2+zf3Ap/foou5NUlV8Ylct4cQGYapg9BYfhi2QuowXrFzfFrgMgkYi0PoSZlYjVCdFbKhcLm3OulUefNkrVd4BiOcif0hL8rkIhqaJ0yhjczO0qXAQJ2U/Q4+3uGvKXoDAmbCQtfj+Q1vjCLdnZA1Fbmpp+4knse9Jxx50RdOLm6wvJiB6u6XBXCDaTLNfgtboz1H3BVTAMsjjicKFIW53vlBUBe87Jk8cWZ7mu0y63s8nEspm+KRYJKC2Qq+E0Tli3/X1UVqnYAmWaDOFI6WzDLNM4+gYAjtWFGtaby7Xj/CXq7TQHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	V6I1jsS6BYAOKQEdPwuBU5K322GRNAtnOTzW7hOj3Fq/dFoOv58F6PsbLxC9v9+79OBBH4BdJoS1ixtVG9fUYOYWTYVa6mpL7K0kCbrp/aNlKH5m4KsH+pu7bGRAGymPY59dm9afqB1gFiD3t4csBpwqwmHiXhAn2EdDUuIeHKgxABDaGhyoFfOB/zj3eRMf5BK3tVXNwNTyIm1LFtKOoZdyHSQ8xjxGBK8Yivayrxmp2MRUE7TosVrvxifgr9K8dsMAakBwNZj1nbajSWp4BuM2BKOxZQtbqw0a7/Ex8AQLmHLtLFhRUkgx/5Mc1kILeIO0gGo8hDPW8+mrwtofm4aMsG6JZ2GjNEr2a/3PW3rvW6m+cCgRA7Y7taXbjxXnCDIqC/J7cS1kNpZ1WlUgGIDbv8afCyrF+/+aWbIeb99j21zJBN2XMAexwSJ7Yc8M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 15:49:42.0851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98d16b8-b1a1-4f34-9fbd-08defbadfcbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

When dma_device_put() drops the last reference on chan->device->ref,
dma_device_release() runs and may free the dma_device along with its
channels.

Two paths still read that memory after the put:
 - dma_chan_put() reads chan->device->owner via dma_chan_to_owner()
   for the trailing module_put().
 - dma_release_channel() calls dma_chan_put() before reading chan->slave,
   chan->name, chan->dev and chan->dbg_client_name.

KASAN catches the first one:

	slab-use-after-free in dma_chan_put+0x3e6/0x4c0
	Read of size 8 by task insmod/6319
	Freed by task 6319:
	  kfree+0x225/0x470
	  dma_chan_put+0x395/0x4c0
	  dmaengine_put+0xf8/0x160

Cache the module owner in dma_chan_put() before the put so the trailing
module_put() does not need chan->device. In dma_release_channel(), move
dma_chan_put() to the end, after every chan/device read.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Suggested-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 516d6d933208..bf491eb10596 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -495,10 +495,13 @@ static int dma_chan_get(struct dma_chan *chan)
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
@@ -518,7 +521,7 @@ static void dma_chan_put(struct dma_chan *chan)
 	/* This channel is not in use anymore, drop the device ref */
 	if (!chan->client_count)
 		dma_device_put(chan->device);
-	module_put(dma_chan_to_owner(chan));
+	module_put(owner);
 }
 
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
@@ -916,8 +919,6 @@ void dma_release_channel(struct dma_chan *chan)
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
 
-	dma_chan_put(chan);
-
 	if (chan->slave) {
 		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
 		sysfs_remove_link(&chan->slave->kobj, chan->name);
@@ -930,6 +931,7 @@ void dma_release_channel(struct dma_chan *chan)
 	kfree(chan->dbg_client_name);
 	chan->dbg_client_name = NULL;
 #endif
+	dma_chan_put(chan);
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);

-- 
2.43.0

