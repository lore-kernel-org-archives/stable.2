Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5914A4CC;
	Sat, 22 Aug 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426544; cv=fail; b=dtzGoIcqUB5Voaquu01Cu6MA6tLZKm2Tkg1yBUEcfLwUxqZKR7BUO8KHyvSr3AEgYSfX0oZkGapSiPBIfeqNgkxHj5EE+GlgZKsiLhQCAnwScwaSN2xi9aN39NYvlVqAvmxYQZkSQPfJLWP5e0a23Bik1Z5bERPbJWU+VD+DE8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426544; c=relaxed/simple;
	bh=hlsyf3j+P7lpKw+7pYO4vG8Yav4CqXH1vos11c5536U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QDvVvrh2r6bZyDZOQJG3qNUsyOMtEuk4hKIgc1hojHFk0NoPhlWSU7PGcgj/UMWNUdiMHgVmwpjNQXb1j98oHyMNwkuWIyFWtBt0LyvFVuT+TnM+euqPM6zgcS2WreRAOG464WMV9sxLlF4l3lOxPgSWlzCld6w8LnM16X5TZqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hir9uj5S; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hir9uj5S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wp2nUSXwYFba6JgagodDGNsf7Kk/UT5qrQbHpVIlkqCZK1QmzcZKako/lo8zohVESYtc6n1gCYi1sA12cjYQRJ4jayennEd2OC3MOqYEd2+4JRmU3iXU/cthwA8LmxreZgwVb/kAGUeBrQ5bkCfwMHaJsoa3s1mSuNVBqbuDALOb93I22VhH2QtCwzv9g0LmhYyBYmioSnbLBm+riDZf89C8fblveQ2ZxpEXnfEh+tflG8tIyacmZHNX7Cv1m3qlbAVwr7RTlr8q9PR7KcijyGdsoqFlXDlpCEtn3OA4O2IjpyZQrODNJmrnitRoZ5OgAieyp3PG+tAmSB9fe28Axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFClWmvBuJa5Sezv2T9fA3JCEBXS8r5KDnUdwthY8mY=;
 b=MmbPyrvdB0TEsFnsc/MfNQWxaENuoBxXFJoX8vPRmd6KL7PTV0Ta9A4zeBzOpSEzNkBRY40tWesKgQ8AXasZTzBfnWHeqoANSgIK9Fgpi8NcBmMfOPLCNuXyReSSNAWU+YG0uEKXXRjNrWiBEShQCLhDHG1mbFhT24+/NzecD/n6JHVo7xziOVWFG+lnZclGWA4lnUTTmbGvEVSFoGZFyBJvnrnkl9Lqnk8ABUQvvG0EoGP27kPeoZpbcMaFPgNpQ/3n2zZ31wc7HjxFkeG6JsQfktPxt31dDj+PKtF0O+iHVNdoJPQwGhMn/eLMnwpbQs0STxHf6mgV2w4G6gSI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFClWmvBuJa5Sezv2T9fA3JCEBXS8r5KDnUdwthY8mY=;
 b=Hir9uj5SViwYM3fd1bbOUrhRHidb4DRGHJhzOKAepBaJGJiJiOcIX9/l18CMOJA0IShvGQwr+x65TuMLK22pwoyIcAirm0ntH+72MrjRSvHz0hHIWmyR6jTCmNZNyQHIpgx7wjOZuR4TNxFz6SBgrgGqfDLiojseLNvwDluDJvY=
Received: from SJ0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:a03:39e::21)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sat, 22 Aug
 2026 19:22:18 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a2) by SJ0PR03CA0286.outlook.office365.com
 (2603:10b6:a03:39e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 19:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 19:22:18 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 14:22:15 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sat, 22 Aug 2026 19:22:03 +0000
Subject: [PATCH v5 1/4] dmaengine: add dma_device_get() helper
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260822-dmaengine-kref-fix-v5-1-d4a4ee47d927@amd.com>
References: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
In-Reply-To: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Frank Li
	<Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787426532; l=1311;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=hlsyf3j+P7lpKw+7pYO4vG8Yav4CqXH1vos11c5536U=;
 b=CsWPKRnfc9176OGGbUjskMHIt3ugwbexP9J50FJNvy/rzUS7mR/z4Jzln0XvjlLdnN4YfenjX
 NbOstzER8iRA2rdkuKqBxCu2VBgtBY3HFrtIzdpeqQu4SpI34rBqulp
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: 235eccb7-6cad-48fe-9c2b-08df0082ae60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	G/iZP4JsJn4gic4FH99zY1ZpCsJaK2Q3K9boQTj0AMix7diYyLP0OJ9p51Qp8ObAXzBULjiTk/sPCDHHsXcTkJfSq5ZxghecMwJ/nqAGrEPQoM/qrrwfzCFvdMXFMQjzWjEE/s5Vpbt5OsEIBECo/iW7uro6oE1AAz6IJUKw5OTC/ViOFDcqwgFHSwXCPZBb0vl8a5pDQHYWO/azolkeq1H0mJu3QSqbxsUKnHkY+gFXxISu6hbLQ7BuvPGXVpsH8BRFVtqzog38U743syPN5Cw2YbQkB/LNCmsCDN4G7zIO1vESIuxfgji21T3/NK710oJSuXeu23wORPZkPiHbV6k+PkdkVXIjBNzs0dMoE3YkvcZswFVWI570cHjn0sIWaPgsouvxEU5BB7wBAWI5solAVLnvkEH1x5u37X5o6SvxM6Y33p7U+j4C60wOyLCPL23FGMo0Ez+cC/OabYiaiJSpaH9G+ufXriG4zrBw4PtXaiGod7s2GyfklQPd56eljPE4DHAeCmfrZuyFWaiG/7f2Qsvehw1aovU8ivn3Zp5Z2KzzSJO58Giyzv0x4qEQaybm+z+C/pW6wIFugh1mbCfwb8+YRbcOFMvZ5R4GJ3FU49+Z8bIQcP/UjUio3wA3aCZY5RBmgiRhl/IokSEJrCXYeK2iuTBtQ7bo0ohXcQrqJ4gQCc4HSHVQAXJ5cwNQjxGpulD1XfJLcnbjh2b7WA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XbuKqlpC0Zsrn7KUYjEd77w8VpRwmPsK7TptZl02MCV3IYaVvTY1i3Q3g8w31J3WSybpegIoKe7y3Ip+LLcgd22WiSivcOemO3kYrl7fioXX3lx90amcApClcytYfHYeWL29y106bYivQoYreNsSp84kUj8+yv1N6uthCC9wF3ndZAooRq65TsIFc/gddicVNXIOtNzyxQDRbPDJ+O+4aZ1yuQ6SdsTeJVsrLzxZosBnWOsD3cWFljPRks7wQj65T/sxq6j7FwaV1a2Z3tTLfb67MFnl7TSUNmKhs2lChf8pFP/IrN8Jd5ghhG17xGelH1FRpF1Rvxfph7SGU7Ti4jNN46K51In8BulAwul7ShX9CEJzsx4N++IpcuPOyv0rEnjSD1KQqb49r+az3u5g6J4hMCex1MdTv6U5aOkVw3GGCOJCrBycXURPXP/hxs2P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 19:22:18.0505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235eccb7-6cad-48fe-9c2b-08df0082ae60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

Add dma_device_get() helper to match dma_device_put() to make code
symmetric. It wraps open-coded kref_get_unless_zero() and asserts that
dma_list_mutex is held, matching its put counterpart.

No functional change intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9049171df857..cb3b7bccce1f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -433,6 +433,12 @@ static void dma_device_release(struct kref *ref)
 		device->device_release(device);
 }
 
+static int __must_check dma_device_get(struct dma_device *device)
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

