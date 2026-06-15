Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE2383C65;
	Mon, 15 Jun 2026 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781556464; cv=fail; b=QpRkpFl1e9rM9GLD2luZSQ5iagN6Xz8uZfHVSEP6bIJ5edbaWwqd6Py/EvGRrXv3gmMois4E3rzbkWyuzVAIFWBmrn02w1yTLYwIVhp8raC7kN6nKSfAhQHZFbwJpW0i0gR0VPv6Zq0jwpFfuQ1fPo0pQudEXPV6PH0n4YhJiDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781556464; c=relaxed/simple;
	bh=fiWLQUGZcRcsQ7WTN2fPZmVt9PUvt3R5qw7n109hFxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrtMsRrxF4eF+x939tPUTEtGQKwo05nOP1Bvy7fLL+N4WGGOa4B/p/7anWSoII3gzPKoO2e8lO6pQLMIoeAcyotdn6aTQMpTm1ljk82kD1YILyNwgFLEYEt7tgPogEQF1un67YYmAMK5jpTfuywX5yA6xZ5WUFOvtQHPS4nEvWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kmwI/mF3; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kmwI/mF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiIyRh0T9CBJIDXN9H8Sq/GZWwh2diVFWRPfsBuR9gXTIba1Z0z50HyO2E/3+TkwFzpZWxJXOXyaL/8nOzqg2A17M6jzgpDkXZxQ9MMMUrWsIbDqq7xfC+wzu/dFXryJaEGevg19w8y7HwC3v6C1h5XjjmdB7nRUpCfzqPt87mHSaVVoe0Zbd6IlQmQmdlRe+o14+xIYhifGnC1od0+I7bYLXjujvAX1EOLrqp5Bdhz5ibaiQvZybpLOxd85wWS5nKTTNg9XSSriD8I2IVhZhmKQdCJCbgb0GmreRUTsOUSpXuITSRIz9hR8BQSmBw43zB0sYqHYEhe49nhUzZGhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oZ0jDcs15ObbelhPc5hCjlwyQGcNlsYnVAqkimHPhQ=;
 b=j1Ue8h3dkb7hIVlouGtHTI4XlvSZ78JSYw5ViTTNGkZvQjaN0D0ON0IbMedZO4ORwnjkKKY8qAr2WXjmWXWl76P8SyePAEqDEqw23g+ipv5ghaICDKguTNlyatU91jmgURGOCsIpsNxBYzAgSyrlSKBnrBCjGul5rujTmMyLlHCRY6EEmmfJqdwFezhL8jrRkoYKYW2vqsgdYjhlJrmYq0PLbBXFbz5EG8mLlbpE38jio4NUAW1aG+r4qz1L4QGHbY8vrzLl902vfi0+BsmDW51OOlbRyaVYOTDNb4EvEFOqT48gQqPo7G/jV55tmPzPIVs3SjmTUX7H5TAZNA6rEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oZ0jDcs15ObbelhPc5hCjlwyQGcNlsYnVAqkimHPhQ=;
 b=kmwI/mF3UBlLmgLn1bi7B+HdC2tpXzG/ufYy2PKUrBjEG5dpuCap2lmWxvVBXbjj4pm4VdQ1c5jap24tERHUm1prs4m+vRnV5cZm5iWcneDBQxcGum29oC+HvEQ6m18PYeTlEIO2w2afW7pLjM/7BCX2WI7BEsjI4Z6xMh944JR0l7ota5X+55fZ8S4N5taNU4Hpja1kvOdWBCvL2dH3L9YTVfqznkZnAH+5M8BpwYymYjZDM4QBBoRaf5giLJyPCy5V9YZCVo6BaudpN9rZSzDk8Nmd7Ed4djB6fZz+akzQ3nbzFped5nY1Gb+5ec4R7tcnvq9WiWGRB9oBOQN2/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 20:47:35 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 20:47:35 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	Sashiko AI Review <sashiko-bot@kernel.org>,
	stable@vger.kernel.org,
	Longfang Liu <liulongfang@huawei.com>
Subject: [PATCH v3 7/6] vfio: Remove device debugfs before releasing devres
Date: Mon, 15 Jun 2026 14:47:00 -0600
Message-ID: <20260615204717.735302-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615191241.688297-1-alex.williamson@nvidia.com>
References: <20260615191241.688297-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR22CA0021.namprd22.prod.outlook.com
 (2603:10b6:930:45::22) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f52675-ea65-478b-95a2-08decb1f5408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tbScsTMjDvAPCPuCxL3rJFnE39I24r3G97ts8J/3BlgkV5CEiHWNMQGSH05mJ+aw/X6RiG9bQyLtE7gvPF0bGrZUXZzGsSSM3lKtRO0UlZkkfsjGTax5AMryuH0Wca/LgczXMp2YAjNpI8lzKmiRkYfYtSyjlnLuiY8rVmNQxtLwLKvPcb75IaLluw0JCDP1JCIPMPySV/ccta378/DNv0aLbLSCQ1Dg7WfpnUHek1wzWJ7RS4AMvk1V5gOgCbQC84jigUa+i4eGAqC9OUORtMbk6xU82uqP2hcValA2BO4INR7NhyAFw3FOZuYBRiqL/fuyziBtEfWrdBmIRfRqDZ25Rosz/1G4F3/gpu4hRlpG9Ev4bqvtH+oPB2uC7ndY2wHYLpjOdFTazzySsdos5X6X4QZs4nhMg+1NZPPKSLH9CWS4ppmGMl3Mjzj8gEFULIgjuB0I6kkyeitzLgP/vJIkmrHXn9J1MZFUq2uubS9K3B3lSquxWusUGdizdnoRxgeLa4xb1I42CCx8r5NkqpWccPaVNKqQSeGTG7bsMPstv3B9Nq9NKD5v1Rjyaok29kDoOpZElT1p1D6ByEm5+T7RzrNR042xLTts70nYeBpj9qPsE63Wp0nETWJlr1Evqcfrf1vZmTHZZca1MQ0wM6mkt2QJn4XIILkts7A30h1gWD098uVmX5M7gixg7OChSEIyjOFbmROfNPmUhhM3FA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y51bW2ODk3lMgK2Ucg3g5fAJgWVD+y0RUEa8Vk7BOsyzKCHqCOtRsN6iIIXa?=
 =?us-ascii?Q?j619gfCMbZsKO758Mr+lq0ZSt0iexoCexvYkjBDinDwkYiM64307N6DWpRvo?=
 =?us-ascii?Q?w1+bYu4uwue7BooZfpMyGZHBsPEzEuIiIme/BbEYUXx3k8UFlLAtJfBMs5zq?=
 =?us-ascii?Q?ORWb1Q9Qk2wudXWdD3/EshLyGG2WggtfiyEsr69reQWEYA4oqcBPsS8LXl3n?=
 =?us-ascii?Q?I4LIo4CjvSovdFzptiGn6O/i05YBzIEX801YAUl4bV/cxWBmEwjEwPc7MbMT?=
 =?us-ascii?Q?QUUCEV9UT+rvDtxhhYRf7vtBTEnI2Nra90jacnv3wjE24TIpUsL0of5PrP4Q?=
 =?us-ascii?Q?zCrYNJkRpdtBSq1HMZdaZWH2CFBWK5jCp80f2r323ZSjjb7WddEhqm/7BPt9?=
 =?us-ascii?Q?U/ujdrBs0rYrZLpEblJ1SKewYbwGOHnDEQQ4oBRv354QtNJZqrivMGPWKOyY?=
 =?us-ascii?Q?cHrpRccW4K9z768ic16sfV+Wb2ebcp5/fR/OAkx2yWkWxgk5Lr9c+R4apA1w?=
 =?us-ascii?Q?WQZXUh27adkjjGgGMNbXuAk/MqitYekGToZKNrokO61Jl6NP2xnZg1Wo8pM7?=
 =?us-ascii?Q?lhMzE5ukbR4+XRqjh/pnIraU0Lcpq9kfsjqxz1xhaF9vhXBOxcWiuoSYLOEJ?=
 =?us-ascii?Q?wn7qkRZyAhD+APi6eHsioY+Rn69jwgO4NRL+YHZ0OLtPAC1/8SETK6iFVTMs?=
 =?us-ascii?Q?4AVvnP/GLUyp4gNxGFHALQC98Eh7y8f8qr/9nBX36mEEAV2xieBLtBNl+OYe?=
 =?us-ascii?Q?y53PFdOZJ3mGSOlHFtRUJ0Jny5843VpMbuukDoKEFSt3FO0cT1kw9eE0zAs4?=
 =?us-ascii?Q?4WEOkWp6ReJu2rsPai6y50OQB84bbEx/Sr+m4XvL9IeKgsGW/OyJXaTlm/GT?=
 =?us-ascii?Q?0ga2EZMZWfaP3NOipsWphYuqwENFfo9PYi5xTW1JiOtVSIOl1SjRkDxC4rt6?=
 =?us-ascii?Q?tHjUo9CGeAUUHcELGaQ008I76kV1ldhfncFVQwC9soGNf9WHj1i0EYO496Ww?=
 =?us-ascii?Q?0gw6MH2zMJZ6aqGfwhaGfGMkv+/b3h5XN0SG7xCI/3dPjq+BYTR0KQXT4OuP?=
 =?us-ascii?Q?K5flq8zDF2iiQ/CzNC3JaUA4/R7f8O8ABtpYthWgvjq3fRI0RN/q2yUGXWC+?=
 =?us-ascii?Q?Phq3ZZY6mT0WWUqUHKb6rNahG59bulBRrnQEQkPCkli6MiyfRaYYfw6gjSkp?=
 =?us-ascii?Q?WRbd9y0oTwECuu8OlvAeUliNlrg4HIu8HzpUwuy6nAN7jF2GXX52OiFUII4T?=
 =?us-ascii?Q?WUxH4pjEDXTm2jslkO4muZgXf3neXP3C1RssxDtnILP/h/RADIraRLcWMvtY?=
 =?us-ascii?Q?YATQJzYHlRqvIMzCho5Wrgaf8wgICM05dAeLkiUG0rYMYOPyiZDnMIibM13I?=
 =?us-ascii?Q?LmdaZN1qzAAlSNn2L68GcABx1A4CgUfKAwn+AveI2Y38C7DY62+GC/99YSd1?=
 =?us-ascii?Q?/w9e60igCYWGqjcXe6mUkykPNh6Ocph8sSEfreVZg+F40g4ajsBLRPtjbwK8?=
 =?us-ascii?Q?WdFiQOZUoaOjeS3uzvDiUYoDmvRXEVKSaXG1jERx6wr7SQILxpvFXP8IZAL8?=
 =?us-ascii?Q?RlkEC7aOoyk/pcslGdUytpaxFsardp9bnIslmLOIJvaHkpeuej5oaGPe9PR/?=
 =?us-ascii?Q?ajQG7XkKXlDSifzmmzmPivlAs1Z5QThaMmVwV8UB52jbVENGZh2dj5S+DOP+?=
 =?us-ascii?Q?M5hbjZwcrUn9fFw0yNrVMovnmv3ndJKjzC/GXuA1hsHhUS39yzyipg9aSa1S?=
 =?us-ascii?Q?Yyhtnx3I9Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f52675-ea65-478b-95a2-08decb1f5408
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 20:47:35.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnHJ9qz08mKOB6QkupROAGjMf4SXLZmTSIv0hw7u3NI5yMTVUckk81CpD2xE7SNL2HnGPp3TwU5D3voDlGzAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009

VFIO device debugfs files created with debugfs_create_devm_seqfile()
store a devres allocated debugfs_devm_entry as inode private data.
vfio_unregister_group_dev() currently calls vfio_device_del() before
vfio_device_debugfs_exit(), but device_del() releases devres.  This can
leave debugfs entries visible with stale inode private data while
unregister waits for userspace references to drain.

Remove the per-device debugfs tree before vfio_device_del().  The debugfs
view is diagnostic only, so losing it at the start of unregister is
preferable to preserving entries whose backing storage may already have
been released.

Complete the teardown by clearing the per-device debugfs root after
removal.  This matches the global debugfs root cleanup and prevents
future users from mistaking a removed dentry for a live debugfs tree
during the remainder of unregister.

Fixes: 2202844e4468 ("vfio/migration: Add debugfs to live migration driver")
Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260615192725.6A2221F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Cc: Longfang Liu <liulongfang@huawei.com>
Assisted-by: OpenAI Codex:gpt-5
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---

Avoiding a full respin, this is inteded to precede patch 6/ on commit.

 drivers/vfio/debugfs.c   | 1 +
 drivers/vfio/vfio_main.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/debugfs.c b/drivers/vfio/debugfs.c
index 8b0ca7a09064..8a2f1b0cce3f 100644
--- a/drivers/vfio/debugfs.c
+++ b/drivers/vfio/debugfs.c
@@ -97,6 +97,7 @@ void vfio_device_debugfs_init(struct vfio_device *vdev)
 void vfio_device_debugfs_exit(struct vfio_device *vdev)
 {
 	debugfs_remove_recursive(vdev->debug_root);
+	vdev->debug_root = NULL;
 }
 
 void vfio_debugfs_create_root(void)
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 5e0422014523..ed538aebb0b8 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -406,6 +406,13 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	 */
 	vfio_device_group_unregister(device);
 
+	/*
+	 * Remove debugfs before device_del(), which releases devres.  Some
+	 * debugfs entries are created with debugfs_create_devm_seqfile() and
+	 * therefore rely on devres-managed inode private data.
+	 */
+	vfio_device_debugfs_exit(device);
+
 	/*
 	 * Balances vfio_device_add() in register path, also prevents
 	 * new device opened by userspace in the cdev path.
@@ -435,7 +442,6 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 		}
 	}
 
-	vfio_device_debugfs_exit(device);
 	/* Balances vfio_device_set_group in register path */
 	vfio_device_remove_group(device);
 }
-- 
2.53.0

