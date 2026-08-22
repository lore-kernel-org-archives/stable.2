Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158D399001;
	Sat, 22 Aug 2026 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426551; cv=fail; b=EmJ8c+8FBWOYEOD23WuNIncmx/b+dSQxg/UCILFP1WcgZi5rxcHcqGget8UakDxnszF4kWyQVMGLBjQDmFGj+z7L4fm9hkxzrFkPwLZd9YuNA2F3YpE3j63kgklFNs/fd6a7wlzfQG55L6xWKr7G6Jmbze7TYdSP/2RS2jdwNDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426551; c=relaxed/simple;
	bh=UiUCtXvQIMfoyyI7A1JkRSEb8TYGQYCOz3ZIZD85bdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AcKKYQH++Z+gEdaDFJVJiAP6O6f1jW2KXFlZiTkLXweD4C3FqTM7e+pmpx292MTGT/nxvh/Qd0NA9YrhX4bpW0lCrnFlkqBoKe+BWL0bAuecTR8ovbOWjF2jU8wfGNciSed0e07uQO4LTjvi9YROtlJTVL4x0kVbze4TNwwyKzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tezfSrcS; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tezfSrcS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSCeedwTTlMwilPHiigb4oBFgyxOPlIDD+Cayp79pw2dfKsLCoZBlokKdWwvHtloARLRRRDpHNvp4W1Bx8UFAD+VrB9d8kYRc6+9fYUko0VHXjU59Kr5cc2wC2PnDr+W5II8+fZlJE8Llnsp/Y7pisBep2zWiyXvMgXylTs5DEbM95SgCp0HS/o6t6/3z5PxHE5x19cMXlFrvHRA4RaW8omjzk2EO94tnlKI6FtzsT1XpX03Nu3ZfpOu6MV+XoMkWUoXYAiu57opf55fgbxG55n9hhUNtXVpeRgqH3UdDs/kn+zJJQ48ij/ohO+FrDGqrGtDCzgLvlB5VOt+0a+I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/aLN2VraXB18C7YtbbPaFoeHd5d1nWQwZdXma5fsGk=;
 b=r70E1fBA8Qm6fMXGGdwFeAZrQrsaT8ug3siALUV3dUL9qNRAyi1RXAGMayWWRq8XC3uFXdRWGs3+lKyUqSUJ45SERIDGffySurI8PKjqK15fCgpwYUrqo6PVn6so5pDpo5kupC3pqiHz40KHePaF2LWgkAtcBHrLJQRN+0fE7V745eORqcOvq9ZjUR67nxmjG6nl8yVnw70N25PLS+ZpDvtqxpybjE0PA7z2wDkFVJdSaYag+lfxa5yD4TeU2dzgFzMPdyQ0Lj85bDRWFo8GDs/7x01kJxrfZdgybSW7poXWvG17qrW/Wzaugk2gx+mE2Z6MYPFaZ3a3h59wPzlC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/aLN2VraXB18C7YtbbPaFoeHd5d1nWQwZdXma5fsGk=;
 b=tezfSrcSLA90xrYxuifSVc19CN5p8BANt3HofkGLjNcYdE7GMJi1i150PjerwDZ6jsoSYPVxNfGZbOuXf57pZf0xTQdS0obsDSqYGrCPZxcFzL4E8fTzJfsWcn45cWEIVLVd1Ow5uaj0EKZkEx1lSJZmNwHOHdFmr27A09in2xU=
Received: from SJ0PR13CA0189.namprd13.prod.outlook.com (2603:10b6:a03:2c3::14)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 19:22:21 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::97) by SJ0PR13CA0189.outlook.office365.com
 (2603:10b6:a03:2c3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.5 via Frontend Transport; Sat, 22
 Aug 2026 19:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 19:22:20 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 14:22:17 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sat, 22 Aug 2026 19:22:04 +0000
Subject: [PATCH v5 2/4] dmaengine: Fix device kref underflow in
 dma_chan_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260822-dmaengine-kref-fix-v5-2-d4a4ee47d927@amd.com>
References: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
In-Reply-To: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Frank Li
	<Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787426532; l=1642;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=UiUCtXvQIMfoyyI7A1JkRSEb8TYGQYCOz3ZIZD85bdM=;
 b=rNtsNNwQiQ9lRVAQ/8PtBe/+63Pj1K00qQJkPpSh3riSHmNfUfMePaARwwiCRpzf1sa7yaRbX
 AOJPItzCVELCs8jfSE1NVO8usJP2a2a5beomywb4YiSl1tczU8e1+KU
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 49cd137a-66b8-4292-2098-08df0082b009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dcgjobBLT9wasnuMB+vxK0mwRbZhvZxazkvQw0KgkD7oS5IAMXYzrrOI2CC4vLyiQtOmEalhTfamRGT93fH/BERaDAlYxkWKiuP+9Map6T1tpkAUVdStplgd69eEDUW50GyCU6FoW266Y45U2ZFRRzCRVW5o2ZStzFu0UeyHnTwqLIIDPsEGrPh4CahFD/A+NA00V2MXwvvBH+f889UjpayuRFtDgr1lj0xdTkXB1yhnefmNUEvQ+vv3BPiZy6qbNTaS+lCwKvlzd5r2A895PfkJOpLBQXio+1NOm05xr7WtVwHZb6hqPZh3jpmpS7WfByOhZMW1vZih9waX0+8ebeB1rBuTvpdZGtUkhNbfYyGejs+hBAcXpuxP0yR9zGSSPzLhvKfkFtM3n7l4BwctIvH2tgy8PddGXStiAMS9x683zPFPsVlcU6YycvY/0QEpgiQ5aaoOpORiLlMlEWGpW/6OcDanobWIx/B1BNpBW+ZtQDVPT49+3wjhAdnNuFH/XpqwD/RqS4Wc+1gayQ2Amgq2GvS8bI/6Z8GB/JN56n1d6VMYxbR88KLToFocv/Ce4ILCiCHGpEiBbXex9JtGhZzH1YHT0yuQGBzfvUbsZsFjNaY1YdjeDjs9HkP01lNnhNIGkmLzsb3ITdGZAuMiThgRjCu9c/mxPEnjQhvwESEshhN8Ztok52zrEUmDJxcsxo2NRu9BH7IwkRaekykhFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SKVjekDrADMoBB/FuSkcMIaTkZ0KwqaSP+lqttzR2Uf17kAJx2sZdFinylUn9Swajht2idB8dlIsmCDFcQV9u0X7vuuSt7pCEwcLJfFRG3BqtJdjs1/r4nkJ6wJ8j0FHxYkj7/YuST9cYQ+uTdjg3gDgZK49qq8uABgCsjjVckYE3FVBMFq73QHeRAMiANDxwSxtPafAZ/23djvTVAgK0wO6Wy4YSDuTsajjZWQE0868g+ZEKdft61cq/tkJOYPbUeog4jmffYKyulaU7Tr3OX8XxrNTzuJAhfgqXuUuu/1i2pgYbkJflVOxUsO8TjA9DI0Fi29DU1cgCrMgrhP0B7xRqJ9LEJuyckuUr1FO0HpL7r7xEmaFL1UAuwLIuuZTEdQxe9PsQgLBRXenSxpZzgo6tx6nb31I6GoPQvDJb15sbm6D3h+lwXDuxGTXhCbv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 19:22:20.7776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cd137a-66b8-4292-2098-08df0082b009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

dma_chan_get() takes chan->device->ref only on the slow path:

	/* no kref on fast path */
	if (chan->client_count) {
		__module_get(owner);
		chan->client_count++;
		return 0;
	}
	if (!try_module_get(owner))
		return -ENODEV;
	if (!dma_device_get(chan->device)) { // calls kref_get_unless_zero()

dma_chan_put() drops the ref unconditionally, so every fast-path
get/put pair drops one extra device reference.

The bug fires when two conditions hold together: a non-private
provider has a persistent client holding chan->client_count > 0
and another client cycles dmaengine_get()/dmaengine_put().
When the kref hits zero, the subsequent dma_find_channel() returns
NULL even though the provider module is still loaded.

Fix this by dropping device->ref only on the last put, matching the
single slow-path get.

Fixes: 8ad342a86359 ("dmaengine: Add reference counting to dma_device struct")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index cb3b7bccce1f..f2760b039d93 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -520,7 +520,9 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->route_data = NULL;
 	}
 
-	dma_device_put(chan->device);
+	/* This channel is not in use anymore, drop the device ref */
+	if (!chan->client_count)
+		dma_device_put(chan->device);
 	module_put(dma_chan_to_owner(chan));
 }
 

-- 
2.43.0

