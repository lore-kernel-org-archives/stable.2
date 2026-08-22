Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013045.outbound.protection.outlook.com [40.93.196.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84405371889;
	Sat, 22 Aug 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426551; cv=fail; b=aNcIwa0drM6GNG77pWMB642R5Glza9idt+KezkB9JrpIbibCGIop50uwUHHsKPvMfbLEOOmvFcQNOsG2bHMv3ETA36VpIBd3lBgByoeoAKNlgHmLiCTj48ETRnkmWR67wCcYrBVjZ4bBiWsf9+GEv6+oJg/Y/LDiOJerPiCgsIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426551; c=relaxed/simple;
	bh=QMCEnZtwHAzn8E8PmGPgLxGc/LdJXZ5sh7KxsGFDltI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=etjS/UQuRorXYkSjEkFaXIcB78mCJezbnxI9c02J2+giB7xIWK5RbCGuyURBIAw+VV+IA3TqcaBjSI3Rkumnf2PNjMaZsCFxptNibPwA+g40kh0b0Df+1HdsOacqm1NqfuGJBktGG1VQVA0YzWMGFgs/9jQtX4X3nV3rvYc9Iv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WMy3YDwY; arc=fail smtp.client-ip=40.93.196.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WMy3YDwY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S67MZ9YVaLSLQq/qQJzzqs19Te3n1bbrveiCb5CEzw49P4d1zxqV5lFoj1uJXMNkxt0lDiU5pQzIz0PGVIVhgd/ca5Xm07hT3rS++VWDQtZVkXw97nEXQCALaR7v2uD9ScvMp2NTr2cQTLV308lBHa9ddp/AgDNmn87AM9MrcSVeE7iAOf1fp6CkSwYP/Djl7w4xEfawFLGJXfDjfg+TGVscPkH9fz2btAuhDqiIcO9BvGkG73DZrkDJXanMwf6iEjMcbuhmu+OTPiaD6JZ0jPFAvfAKIZ3d+SuLUq5mK7mOM1INiOIrxltciLrjJhOGPEZsOxrYuDN9IvDWJo8igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy96uA5t8b/Dz+vwircQMucuy6dCm6xA+Zcy7X1ePDk=;
 b=C0IO5zrl6P7EBZSjgt2gjSUY8912crOa9qt1kRoOboYEKDor/+ZN29X8asmbHPygfBT/zgFChlR2AiwxKK4Y63rfiPg+JPuuiQP4KGhki9HHfKAltFp1OF69BJl0q9AXoFO/A+q8ljwmMR19Vq977a6NPsUEAD+jMIH8gL7XhnUX1YV8cpCBwQHeuOEc42AnbF0k9ikrxvnJwicfnTE0dvPnRYKXqjXdGHlcOgM35ioRegnFUuTk/g0in1MWwC8NoBy8cQ2Unj+gW2v1d8t+tMFj7qw6aUjj6SHjS8vjbh5EHC7KU33nKitS6SuBmHf61mYhng9PKhGrlmSkydf/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy96uA5t8b/Dz+vwircQMucuy6dCm6xA+Zcy7X1ePDk=;
 b=WMy3YDwY+M1PhNJtYqO0/T6tusQoXwu85fR4TfoEX7Ry7GrA08lfnzFizwHEQerTyHdCZEMMCY+KbN2+p0lLSxhFvowO4uICo0YpOb+0cGCpHQbmmP6S8CM0CUPUZWcmf3fIdkmVt3LyqlIzVabY81RT1R9ccgzTahWLKenFxMA=
Received: from SJ2P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::11)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sat, 22 Aug
 2026 19:22:23 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::35) by SJ2P220CA0004.outlook.office365.com
 (2603:10b6:a03:5da::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sat,
 22 Aug 2026 19:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sat, 22 Aug 2026 19:22:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 22 Aug
 2026 14:22:20 -0500
From: Shivank Garg <shivankg@amd.com>
Date: Sat, 22 Aug 2026 19:22:05 +0000
Subject: [PATCH v5 3/4] dmaengine: fix use-after-free in dma_chan_put() and
 dma_release_channel()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260822-dmaengine-kref-fix-v5-3-d4a4ee47d927@amd.com>
References: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
In-Reply-To: <20260822-dmaengine-kref-fix-v5-0-d4a4ee47d927@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Logan
 Gunthorpe" <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <stable@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shivank Garg <shivankg@amd.com>, Sashiko
	<sashiko-bot@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15-dev-47d62
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787426532; l=1931;
 i=shivankg@amd.com; s=20260518; h=from:subject:message-id;
 bh=QMCEnZtwHAzn8E8PmGPgLxGc/LdJXZ5sh7KxsGFDltI=;
 b=KgjU5RuicuFEyYxZ6qd5M4AyXQot4ng0gZS+uSFvEHOCqBaQ+uDsPDERHc+QA7hoXtUV0ei+7
 FpthQZyyG8CAo0+qOeMlpR39hLdT9d/VwK79Z0pcL9pinctO93W0ptv
X-Developer-Key: i=shivankg@amd.com; a=ed25519;
 pk=2l2QGTeXuGkZTtfmx0nPQU8iFZfjYmX/ymMojitevx4=
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f6646e-646f-464f-3072-08df0082b1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|22082099003|18002099003|56012099006|13003099007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	hHIcwJwPdjl2aAfRkQZ3yIU0kCoOLFsAO3AjaIkHqlYooZ7ieFBLV9QcFxJGzA4QBOyuvls8MRKPtMpEcX1GB//3qMeUCBH6MUAHcAHFd8lKRoMQBpmZNgZ8q5HqW4P3kE4Ow4bL5YM3v7gP+MOhsxwLLodjG9ygM62p3cYs4vInnNm+c7y/ZcljC364LTDlrVzpE+zA9yj9CGdEqlY6C04SixTTZVMrsLknTCCXWjslVEft+MpheEA8XfF8K1uiRyRzNTLfF96yIiwj3uIEl3PvbxTAFdXRureQxWPGYLzMdid6Mbn7q9Xcaq9xI7miv2AIRn24QoD58mZ27sDS70vrxcakIdtTHN+TfgaOB97auckuD8Q3T7MctQp5Bg54UoqKpmfmEiTcj+bmjrB4yJOJ8iSeRsStrvM+uFmjeXNtPAI+Yvv0kro4DqIXwiRoeEHbDKY2bjuYYU+dFT1mt6opHaSDt7gUZluNcuQRikX4sAJmWb5JTJhp4CJY6FOdXrIM9VNN3Qd0rK+rI7QS8eVXa7EMjS3hJQQmH9+3d8GuPjAXIOejqREeaIQ6YdvHdd77X68yLB3bGeyv+ly/sdBNDOb00wap3p1HX+uS4Whd+EIS4+ogNp3yLthR6CgUI2JAdknJyNfhvWyzRSNh1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(13003099007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M1KpWGkHUVH85T0eEVtau13yvDzI53MAXM9EakhMDYhDkx/vLjex+uhIsDz+LomKXHHiaArsJnHX2qWmzH5B7NZWRp9CC/MAu6JS2WIgUcmmkOUCU8NpybY4u7xoBhi8too4ZQIc8oVdkjaxwFgSolqBVBdsovKI6q6xc3yf+wV7oHu4r4irk/0d0fvveZhfeu5i1aOvUmqiYRM1quy3YuY8qkaGMveMc4cOAPGMx+Ca1xFYZoIHliLouwe78aPfl8paDcoWU5wFeQtOjWw34eiHVoIIKvVJrp+bNpJ+j4WcAeJmKQoOZyiSoc/ESKCi/fLVPomMdFx6s3FFpCIUX27OE8YK3T5PL5sCUX/d22OdOO7f+xJH+NHt6piIzSihyNhGgYtZEr2QATqM2+s7hzmivXWPfZ1zFHPAEMNn5XmrFTWl2qNG6sRSSq+g86lj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 19:22:23.5364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f6646e-646f-464f-3072-08df0082b1ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 drivers/dma/dmaengine.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index f2760b039d93..9214b9272a55 100644
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

