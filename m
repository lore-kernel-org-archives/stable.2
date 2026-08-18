Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2393BB135;
	Tue, 18 Aug 2026 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024731; cv=fail; b=t+e56aKuR187cvkrOdAV1APiVjkI6bzEz2qgv8QxBchL070GvY8DpBl47eEAFiWABpQfhYiWlbuE1YDJz7Sg5xpWu/93OMqydc5FF9ZiYI53ozvE+Likx2SZIr7aVkYzNkqVozt5VjAUmM8AS0Gn1CMJjFpdjTQCzR2hmXJYd2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024731; c=relaxed/simple;
	bh=WyK1bhlIzw10xQpX3eRtqRomlgut0wJwNB8bjK+3rHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BK8u+gmyW9gPUHv+LKblrwBfmJzl0Me5q9ZaIYWzhBwMDXvM2iKe8Ra2rE+hbNO4B5PFX4BbWHhXZsG6+lhI8vs6Y4Rb61VXTEHOaTkMtMHDFvnoC+OCQ7k+1llAB6AO8Ia/lzR9lZP3Gpv/dE7WRvcxIq2CQfPXD3NOoaUb3JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zzo+SD0I; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zzo+SD0I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdCOBXScrSpPf5GtSHzU2w+/bVxv0/UgfnMU4mfrTteR7M+q5lCioC72Rxpuuv/Iqu0BB1OSCrNR48U8G7Hc4N2lkMDnoba8m29NpOMU7E1Ue2/heTrDRZtx7t0JxZUuLC/KnpN6MBVLAdWp6J7nVv1rXlk6ufr+NurIvyeXO7iPqON5qRR5FEjJGP7lHUTjS+e4cYQTTjFoKiifJo7qEtzvvD2ONlSyp1MxGcAj532ICy7ewfJRIj+qkdCjtDywrCYloBpHdsgnM2DXQhZnQM3QeyD4GkxVo45+WPpS73bNE7U3TYeFLO+SPCY17SqpFoRrEa5O89VNQMFbMEcVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvpx0vg2NR2k8GsnKWLbtT4lztv6gk0VaVtXE/IFQM8=;
 b=cfX9E87EMP8Gton4YWT26ST9LPehbWufdYxcKvHJ7RvswsAkzv5XIK075tdkJPAu9wMPnRgb+Xk6d6tZ74XeYMm43r1x57E/NWco84+cwewgvFPI1StWS3mYuiD1oHpIXQqflscxRoyVWZjTuDHIHiwicdL87+NsNgOJgauAr2gMFHYSia1ILSPtX6rQeoAcWLFLNv1Srb0EEhKLrNEWQOr0gZE4DFstC4ZSmoVFDLwT9hgyAltmOVw30tocDMsgsJFzh/M5a9TItHlVnrlba55H1dxUdao0EStF1OqnosxuVjHNajVxS2jg5jGrXu5klstttCwcq6Yws1gQEf8INQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvpx0vg2NR2k8GsnKWLbtT4lztv6gk0VaVtXE/IFQM8=;
 b=Zzo+SD0It2/FqInsO6xcGu/e7yOUHqJ63ghgkIw76+BYdK5Isephv2o2kiynqGaAxQ5HJdYv/GhPONbuVdYFBF2semsVqkM+VyWFRmItxSmkB3JdNf/gixVTjGWJrtjXfAoYezFyKEAczvQ0Zu35llW2xcURIvntK1l8pezFPAY=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:45:27 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::48) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 03:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 03:45:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 22:45:23 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 18 Aug 2026 03:43:46 +0000
Subject: [PATCH v4 2/4] dmaengine: Fix device kref underflow in
 dma_chan_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-dmaengine-kref-fix-v4-2-c6ef991462a0@amd.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Frank Li
	<Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787024717; l=1590;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=WyK1bhlIzw10xQpX3eRtqRomlgut0wJwNB8bjK+3rHk=;
 b=UpYw6uNXUfg6ea1Mtmu5CQCcTS2RTx12IM/nV2Khqjaj3aEujOGyz8i5jgeKC9mOQA/gLSbzm
 H7hJvqR/QqvB/cDJ2R57hpZcvN60ZHxW0XyJ+tVpliv3kePxdV0n30b
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: d8bee9b7-bd03-4154-851d-08defcdb242e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cx/d31pDctgQ3r08fh4JDvQ6a8+B/5ZDPhtytTSuz+nlAsNJldMEqp1Fg+hG+R9ZBAJUjAQFs+vOUA7NLtu0UH67rtLOKaOX3U6SU6JWpuSeHnVwrBUxbvsMwSUVq4fEWTeTc4zApO4BoWW8/uHUpfCmkUoMCtk4vv3GL2/M9XIBhdPnrprcMzV5g7ZSDJPsrXmBAmGZwA7XSXS+d1tbf2Ur0lpXH2y683jr+2dXdCPz27D4+qFbDad+2/hhCvw3eptc9UoOFOvAhFFq1xSoK7EzjjkPB/udfyJpJk4oUfFs3gYFcfP1/f9qWrxMcH9ynoHoPL8b2RKVZthLuFM0E7o+Ns+SF+fvKjxbnEH3tCkZgt/KaP2WCtzLN/nnj7K6hbtl3+kBl+WX8v8r+7kDOe3HUtQmYTpow1EpmF1stq50exSgApJv4k3gza/wdF+GZLb0FHE+4sbUk8rYUWmhpZ8FHUhD1lD20BVBPT+7XRqrJfCEQ3VxRrms03ow3AWDoeBayedSqJp/AWA6jjv3jeqz/xouIpW03kEuN1ppLIvkcY6hzLghOnLjdXWPKR6PgO7LtFs9XiVdMv3MP6fNk16LmzebOv16hKpePTgc+L+0d4sS89VpPw9+mGtudbUvJoZVY1GqyFSx+nZSFgCNHiHVQ7zZeCsh2QhoEk+JNAol+P5t9sU4MbOUrHtht3Ey1TPg/baxssT3T8lmXAx8wQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QBfZvZXsX9ZPjxk9fWeoAv+gSoHmfTCZoOBb0TnMJKUZsktFKTXXs+Gtu9WNB3uHe5r3CUV1DIAnUfC7pZKSMPLTLlFTCsse5NsgyZZPdcn0+r/KUvqvhNh7vAicYwNQaK9kTCX7Sx53WrUIODgz1BIr554N9kk24C+taMMT+4fT2KtaWm7+fJzB7VegIDSwNL5CIljE0t/xGaAdGGsylUgPfz9gBdjp+hiBtn6EsLaM1f+Xu7ZtNq0sxv2pn24rIn63kv0Ix8/IYI13NBecQPr22yAFoBjv4ZTKJiIQlBBh+HZXUITSAbih/aV9SYDYU5GD5/HkfaNK3QKd+10QrAp6LL8knYqebSOFCT55pydqq7Pa+XYDrB7/sNfsPS02yVrS4JmDh+OqcXzfAWp3pIX5AdxIMxMhpOxvE0sxVmqPkPFt54oCc7A9AwZXVsT6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:45:26.6847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bee9b7-bd03-4154-851d-08defcdb242e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

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
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 77638dc16e71..3ae53e11e54a 100644
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

