Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70F3D3D1D;
	Tue, 18 Aug 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024730; cv=fail; b=e375+5zok0iIDncJRALUyFA5NUyG47uH+mlbKdem6nOr6BbTRUyrjzmpgyaovpUfDgTBlgAfun25rSubJfXtCj3GOuHbDbjN41ioJeCavQmutAlSoWJ6ptRlQXWWDFh9qNG46GHdAf9PncTIuU9fOVXNB1V1La0vE1EVsFXlHFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024730; c=relaxed/simple;
	bh=iS0oha2zcZHPVzIZMM/Ct+KDWsjm2VpilYIPgbpXjCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DPMzJsYJ+4EJAWPaMVd33u6p8b3ix3zNCD2sTany+JBz0BL7ZpD/DWrmk17yYXWYSEpMJdR+WqBfD4RNWIJREGAAU5U3+g4N6eLULrWrCnQK5bIvryyxvXwtrLST1bhoBWWHQrMSC4t1yj/Ccr2KGWIetPofCEw+ndzBkoC11uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XpV6Y5yi; arc=fail smtp.client-ip=52.101.62.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XpV6Y5yi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YsVAtFX9q3D39b4b8CbdezZCtXf4J04tkcNLad4wiYd5lPvZW5JxBRUo6QV/FHIcuFCctXBANtAgYcRs2mphSKnifs1avaN6r64Ut2ujG8lzTD6bGToFNKp/OOLjv+RfFt0Conlxyz7Rqne9sdaRbxwgwoTjXrHHb8QUZxExNx+hA2IqPI2/BSsvTYpS0qoI77pqZeAx7x9nNFH2KeBj0jRJF8Jj1nfL8gSjAlQuv+d567LxGAE7Y3xaolGiFHIuSPqLu5PKXk+afNU9yKlbsy6G7nOMW/2cCuEnndxT9hcf9kk/JL1vm4G+p/66Y6uNnDCGU5YThLOUOnJTdM9R0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1w/K3Hu7YlNDP9/uWatfwHJf7pBCzH2iKmCsPc12cE=;
 b=hIQSnuFSvUXJTYOaGuSf7LeId6sY5LbSdh/Dl1+XsynCOMltLnIXZJciNi6fZY072bBNZzy2RRhHkaoz42BfBtqGRvIldvlrbS1sRXIZ85nbIEdoXNMUP7V6pgLHfMhkNOyd1LVJYjlkDmyUo5veNymCrR0d9dakwaSCCYYNPdAuWaT9Bk7A/BiWh1iU+cv9GLZAh/UMK8cnC6fQ6GAMw2PYGTSuHXqdIjZeeKcdIZTvD2unuDJDCuDGsy/exQkS7m1TPTdDCvgSGHbelWCBNC1HujQjYwqP9jSAzAbI9ICDma9tFSDcZ1WVPU3hwxq/FB58daEFCOCE9B+Qxxh6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1w/K3Hu7YlNDP9/uWatfwHJf7pBCzH2iKmCsPc12cE=;
 b=XpV6Y5yiZY6zIeSpws3p+1fPLmxU3Q6J7P+uaVr3p0lnhWJngQO48tZap0Kjb8TTWPLVMoE883BURS437gV6ordO4UvO3h0G0xu1Qw0LoXyZAKkeCitQoPGpKWau/z/fGdM+THlGp9Cc0L61Hu7DkOmYt3mVycl30PbLJxE6O9c=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 03:45:25 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::1e) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 03:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 03:45:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 17 Aug
 2026 22:45:20 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Tue, 18 Aug 2026 03:43:45 +0000
Subject: [PATCH v4 1/4] dmaengine: add dma_device_get() helper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
In-Reply-To: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Frank Li
	<Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787024717; l=1247;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=iS0oha2zcZHPVzIZMM/Ct+KDWsjm2VpilYIPgbpXjCM=;
 b=QE8vdqk21wRUE7sNTMRg3BKSqTDGbjb9FQtrQEHJBCwi6UCwt2Iq30jsFg8/lyqOCgmrWWN2n
 voLBZkw4T6EDlEDI2+EEGk+HtkuNUs6bcSM/KZTkUh0dNYaKRR475Ke
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbee552-393f-4d52-ffcc-08defcdb2345
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PpQX/S2n+CM2jaHoJSIs2R233Ur4mlc/Axc7frZ0L3wQk1gnNFbfUkOOqnbM+fqw19eOwCadEXDMw/jXHLdMSweI5ZentU/5rx/xJlP8Xnjk3tDQSQ+8+gJdW+2mC6tGVkmPWK+K1gZlh389nj+jXqssoF2/qCIwFDB/d+viS4AoLslInr3edG9bQnISKI5S7JpY3eNGkEPeDSrCddjhrdUUMvF+xjhGxJzOPehBEh1IWiZutQrBDYZ5VPM5g/+Z2cWyMl4BK8uHVNW2TR3M5RvCdDXRjdOn04WAQSqoueQCLgVgTluwYrsovnXSbCKbg/a1mmnqmSE/Nr/G5SydIwMLrJTAnMgqZJmuMJaaqSJstgZ25uyv1g0UPYYBtBcBWCkxlCnWq8nWWrTrWNLT1jQMwz/w9+ZoSPxOtHNGTHwPsXQ30Qvs8EqjkWjvwPk2hJC4ysKbHIYgQ0Bbd8+2QSEtshMKbj4to7p4+gbk24bsJgRtYd+T7vL/xosEdQQ5QLa3dTFp1bOJE4a+h3OGdeEOHmwEkPBGVDp2mvRrBHym9PYoNvTeF9hv/tc5FsJiD2GrPNOYALLRa7qG2LhVm3sNouMSSAiGATgT+KwrEELpBR46fkK2S9+BfFVBvbZNL8ZlHF7KBDAziWNz0DxBPP2Msbev1BpCKFc6hft2+jtWKuf/CjN5fSkiwWfi1bDi1uf5cyTCEQZIU3CGOue1dA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YpK9I5+h3aGcAoOAIEVkk1E2L1zQ+c6CFFp+1yiBu7hY6WK2DXDCYj1Q1JdgDDbl5W8xQojH+vGniTdZEeI3aIPlVQ0YWpmTd5BjYBvD0fsI3VrzutGgJOgO4PxOkWC+gxIdPRSsbiGg/xb7yIFX+QXgh7VsEhORwsEvKXUc6GeJY7v32ZKUGeZBXfn5K1GgULun6YSgAhbnYYOIVIhy04aefS4pTfHb/EnYVs3kOy3dNSU03UinaQVoTgdtKiWmyPtwslaekAhiyLODZc9BIcr3ydmIhn3nWd34eU1FtJc0JKO2pQDXg4plesj+dGSFj/STVOQuoM1a8Jr3kTFifY58Ct8j3uB7yBLvFQdzmrtCmCHK+tw1MexGtxqbOEBOtuIYtfxt6p0muUMWsVqGvTgixDLzrlr6slchX6TSnMwZapd8TFMLjEic96emQICp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:45:25.2357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbee552-393f-4d52-ffcc-08defcdb2345
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779

Add dma_device_get() helper to match dma_device_put() to make code
symmetric. It wraps open-coded kref_get_unless_zero() and asserts that
dma_list_mutex is held, matching its put counterpart.

No functional change intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154..77638dc16e71 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -433,6 +433,12 @@ static void dma_device_release(struct kref *ref)
 		device->device_release(device);
 }
 
+static bool dma_device_get(struct dma_device *device)
+{
+	lockdep_assert_held(&dma_list_mutex);
+	return kref_get_unless_zero(&device->ref);
+}
+
 static void dma_device_put(struct dma_device *device)
 {
 	lockdep_assert_held(&dma_list_mutex);
@@ -460,8 +466,7 @@ static int dma_chan_get(struct dma_chan *chan)
 	if (!try_module_get(owner))
 		return -ENODEV;
 
-	ret = kref_get_unless_zero(&chan->device->ref);
-	if (!ret) {
+	if (!dma_device_get(chan->device)) {
 		ret = -ENODEV;
 		goto module_put_out;
 	}

-- 
2.43.0

