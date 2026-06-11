Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73D37D12E;
	Thu, 11 Jun 2026 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213766; cv=fail; b=Bzad9RjVF+/aUJO6hslZAAwpLuSIShkJt5EE9ahoJZsd4QXN5Oo42u3bjZpYSQl7p8I2tj1P2yXH3SNPZt7YjnfbiyWex44ZOLvLbHpFrRIgUdRu6lGort0g9Bh6sGbIApJTHzt62/o8qv0sDP2CbIiD8bAhzS7mk/P9OxQ0+AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213766; c=relaxed/simple;
	bh=0BGpSlHscmymKqzx06/7PgZKTbN4D7Tnls5zcHHhfrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJZXctgnPqjH9QNX3o4WzeAs/kFlAkCnoHSSljziStLMrJyd3KJUdKsZDqHZ55VODuyUmgIhj8kGdADJdgM3M3yNcsKE+Hv0Pfrx4iVcZitVs/p5YDdZgWBD/tJjAnWdktsnL8Yj/sQRj+m/OBCT4Fj4vR3X7yAJiOuvu4Y99NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KjbuTyAd; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KjbuTyAd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQxO/y7esYCuwlyyadngF00V339QkxiNlyJ1iTMUqJba2nqOahr6KGQcnKMg6NnJn94JGnd2psoovqquBEk0SUPwsQJ3G/4YqX+WcTX8XR1Z3cgVvOcjDcPpSW42ZIo66NkfkcR0LnYkVqZFE8ZITeWCgCevOfCWZK4bDGQgRXC5e2wZnFNMSk1wK/0I/fQrQBm+MKhCdNEQbLODHOLUEXozKWq+NG1ldeRLu0vC2J/55nKReEc8mCeuEmW19E1yac40VbQaVhl5ZbAMh9cLzleOBkX6BPxSKWKLYP4szggquR5ZOvDbr8oUhTkk1CE9HzmlXm3SxkiOOugbVJG/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7hgrK4Xi9nU+CEo0/70cvvqcMyBlhQEC17W3kCDF4Q=;
 b=KQX18l6sdOti3hAHLay+smqJ0nfakc9FpEKKERHY/FMexyialu2jFtnozwJ0pDsSc/7Gy2NtvDNaO6ZovrAudPsqeSDtKAw9A5GN0bMQDyCbCX3kHkp3drfh7XKnB8vdBRH4udj1edtifxHSnThcTYuNq2V5lIWBJDeHAOG6bq+t8rdizwcpd9GKrq/rdLYVZ7MkcbG3R8C/W5CTMdV0QuUjT1NVwuHDpMbvrPN9bKZUBqwCBYCTwP4urSaO/ozQhFCbwDIM90ndSYtyBmDUdWa5cC6e0pLJNo/9C/oosA+oZoYjenOk/phifuScu45IDEofNSk3u8v4rF8hgPYL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7hgrK4Xi9nU+CEo0/70cvvqcMyBlhQEC17W3kCDF4Q=;
 b=KjbuTyAdGjsZy4cRJSSkPT6AEUpDRavWxGqzoBPzzTYP02CDu9S/FY03WFro3+a/oQrV/omP9csNQ5Zrv+2vmMDzL8F+ZqUWMRLzJabOKbNiqCKoXTc7rJK0U+FwTqTr68dQ1vm56OTT20BwIcsLQeXB1+joPoEsFHhCctBbA/C/MbcfknNPOTbmcpGUTJSOiC43cdEw3CD0LVfraANxKe67eTxtrc6eEdqsOXGLzUhzd6BqJU+svJI4xxsKc263R4Z9uDVFqthaG3AZDJZxy1sFi/zG8fGlmu28a1pGxQnHkqO+ZD8GnUeY6EstQUUcfoMz39z2YW+zvV4c5EQVrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 21:35:46 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 21:35:46 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v2 4/5] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Thu, 11 Jun 2026 15:35:37 -0600
Message-ID: <20260611213539.4100590-5-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611213539.4100590-1-alex.williamson@nvidia.com>
References: <20260611213539.4100590-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:44c::15) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba29fe7-1d5b-46c0-a0b5-08dec80165a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	lfNVT6drQHOF68vbaCiXufWwsso6YrMvLq+HMJduUCfJq1WQh35CsbgHuQ65qvUtDy3XrEehZT+lzeBNMT0x9R0w0e42vSO0+dPqq4sHjALuyrs2VJl+Cb2gdybV3fWaXUgALKoLXaOsVfvdluI8PZSRbiqw+ttqk0onwWULHPXD7+znT7tN2bIZzJt56Xe+0RTSqrUZet26HMuawAzu0kyIZvDgVDNt2veXkmyOkvLIIRlp4j35k6XAkqJty/WzkCm8bE7iTeoS2ElXl1+LBi82FuvLX4mG49ONeyNRRcTrlwNA0WbJ9J+Bz2DXxAokLNvVie+iYWzVgEu++BJYRVTlKZXKs0OPvSww3FOLhEpmaIEGarh/y8U0ogJJ7K8Dl5vXFXNjHI4c2wOV4HqefhPNBvqycz7qVbb+Th2kAkrZYz6LBdtD6nfRp7rp0bKvtUI2Fgv/FUnvJwqoP+UUb0jctOXTAWLnPXnE3ZZFElfmZU8zjimv4vWOsdLaRGB1tnsKwhrWPd+V9+FB2BpWKcKR5wn4+0aaCvZ+Qp8Wbustutr00X202HdiCnvYs5FG2IMyLGeyjsbnUhIUpZOmUq7Y529yVySielvttKOuZP5zSDgrkW3hMvy/EI4g1hyBcxOwZxTcr02FGb1Lj0reCn3U+cIXQD2VlDFQ65fGvC79KL/8ymcgFiNtq0pMFq27
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8tmqJLv7fdB5SCpbQRgCB1lZooWevNwT44Ww+louasBiUPFaRBlW8e3s2FSe?=
 =?us-ascii?Q?HQqArdZez+RjR+p5mV0gFg9lV4nVH4qtDwMycPByW6UCc8Uss+u0ub+L638u?=
 =?us-ascii?Q?RzkKHQMTZxIdA20nb9dz3wB1T0cJJBl/pWQ3cuPIyi44s1Wt4LXVJzYKk7lB?=
 =?us-ascii?Q?dAPN8Kip2WmVEpoFTDzQOWON3GyUM8poGoSRQj0jRZvcqtwWYTES86EOd4ET?=
 =?us-ascii?Q?sxRWyTGLrSEbq1YtaWjIPcLGBNKAG6aXUkosk4zlfU0lcJLLEv4SQmyLBXyW?=
 =?us-ascii?Q?lrtaSJ9wFCsozpgVxmHPBj+KT1FdFuFSf1s2UlyeJd0e4+ZAc3HQz/yx/xqH?=
 =?us-ascii?Q?fWAYWvV/BzLak3FJug+uR4tByPoEFwPeDm/USFPVDZH3dX3R3LOE9smp6nLp?=
 =?us-ascii?Q?bagdkskkQ8UtuX4FQ7AB7fVsupDOg1jkYO3QWkH0B1d35OOenP98gjG0/HgQ?=
 =?us-ascii?Q?solUDkQl7PhlzvTLRF7aSuzZRfFkbtnikb0TH5h9crzehO5OLBxsJDC1pdPO?=
 =?us-ascii?Q?fqHwE7votsSRKgQxz+110rq3hCS+bTx8IMEsmCx3/Agbbyb1lm+U+ckJfJol?=
 =?us-ascii?Q?9EkXHfUemp20G1ozbcTVFvIPSHpjoV1xtN10qNVrFG0xkUdTcXXbJuUh/vjW?=
 =?us-ascii?Q?5shUlqH0ks305dw6MpsZHTScOrhgX5Gv96XL6M/9YBCzqN2fkmkcd+hAJrfG?=
 =?us-ascii?Q?klSMn93/nDmxxoUoTaaq/1JY++9f0kmDg4Lyda1BWTmJ9BGxhQspXB/A4Jmp?=
 =?us-ascii?Q?NsyfrsRT3CJtvxsa8dWz0EM20+iq1Gzu+6zhUMcE4ZGtO4sszCevByvajlyO?=
 =?us-ascii?Q?I38ONkh9r4VrmzPWN3WifV8nEC2H5KiQtqu4VxbODBAC4R2O6xuVEHv7dBHS?=
 =?us-ascii?Q?2HfH8FhiHZjv9Mdh7q7JTbCKLFFEYpgJ6sZoiB1wOR1xGNNJzCGiWC+45x37?=
 =?us-ascii?Q?tEeTL2afSECturjLrt/DwdWx7k5I0TEVzaHdmyZ1Nf3foBmje6DQLhBL3XLA?=
 =?us-ascii?Q?OneCcL1TDvsLPup1d3uxGJOrlTlycwmNv1OMk4ZPCBXoThfGNIKlu45/bqPm?=
 =?us-ascii?Q?wovYzdpIKz6lNirUB8z2HNzQCEfVdFrdsom9VeNRNocD9oiHeGy9s8P9xQaf?=
 =?us-ascii?Q?GdWZqW5dcJTS807T4m3RBDThzAcZaugbUormDtK1ICa1WxWwvotFZ7Ul+eTW?=
 =?us-ascii?Q?Z7aLDRycFhesZWah1d4Nw3hORcP+IGmQHyrg2AzJ/fCGWQ6n+jF6b/+qHIbv?=
 =?us-ascii?Q?LYQkgKMfLv7G2USVX4B+Oj0qfd6DNMNpFlx1ZYIowBduafumR0fpvvZylRhU?=
 =?us-ascii?Q?LiIXcIKPBUo1mZhSXWUjpdVxV5C6jFm+cwJCLT7Pb83/bfFtZT7EgEM7EAay?=
 =?us-ascii?Q?GBzoPOpHJb8ek6xY4Hs+At/l7KLWi4qP9YQAWinRE66j0mdWPFu9kA7R94bn?=
 =?us-ascii?Q?U2APPSBgCAl+8hX6xndyjg0Da993/hAEliivludFuam31NUtkL+AJ4g4zIHJ?=
 =?us-ascii?Q?ZC2kFy0mdaWolBhvXAn6PlzjIbhBzJUdRcJJs4ALb53uXE+BKkvZiKtKKfAu?=
 =?us-ascii?Q?B8+PeCVxynG2B7UGgKdTjdCZQyCXWVz4lAGXBsy2a0vX/s5llRw2QkfkntxH?=
 =?us-ascii?Q?O1TsGkw3oAMNuhqYR9XX2VUqvYVbguPiT0keTmKysHOIEnVd4WUoIJ0zcd/H?=
 =?us-ascii?Q?jMRSmmXB8atli8GOUsMSfP4Bp9I7W8Nnx5XAwWhhxZ2ne6XThAfM1LTGWeiv?=
 =?us-ascii?Q?GKmkkXoSvg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba29fe7-1d5b-46c0-a0b5-08dec80165a2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:35:45.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhQYMlcZP3v8llUXVPplnC1ynyyjUo9fPHB9RGVsf2gJQWlxJk/Jc5vLkJYu7hUBlA/ipmqphy//JWJa9tr6Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

This split takes a binary approach: flags that are only modified
pre/post open/close remain bitfields, flags modified from user
action, including actions that reach across to another device (ex.
reset) use dedicated storage units.

Note mlx5_vhca_page_tracker.status is relocated to fill the alignment
hole this split exposes.

Bitfield justifications:

  migrate_cap: written only in mlx5vf_cmd_set_migratable() at probe
  chunk_mode: written only in mlx5vf_cmd_set_migratable() at probe
  mig_state_cap: written only in mlx5vf_cmd_set_migratable() at probe

Dedicated storage units:

  mdev_detach: written in the VF attach/detach event notifier
               mlx5fv_vf_event() at runtime
  log_active: written in mlx5vf_start_page_tracker()/
              mlx5vf_stop_page_tracker() during runtime dirty tracking
  deferred_reset: written in mlx5vf_state_mutex_unlock()/
                  mlx5vf_pci_aer_reset_done() during runtime reset handling
  is_err: set by tracker error handling and dirty-log polling at runtime
  object_changed: set by tracker event handling and cleared by dirty-log
                  polling at runtime

Fixes: 61a2f1460fd0 ("vfio/mlx5: Manage the VF attach/detach callback from the PF")
Fixes: 79c3cf279926 ("vfio/mlx5: Init QP based resources for dirty tracking")
Fixes: f886473071d6 ("vfio/mlx5: Add support for tracker object change event")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Link: https://lore.kernel.org/r/20260511221609.3837652-3-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index deed0f132f39..c86d8b243a52 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -158,26 +158,29 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
-	u8 object_changed:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 is_err;
+	u8 object_changed;
+	int status;
 	struct mlx5_uars_page *uar;
 	struct mlx5_vhca_cq cq;
 	struct mlx5_vhca_qp *host_qp;
 	struct mlx5_vhca_qp *fw_qp;
 	struct mlx5_nb nb;
-	int status;
 };
 
 struct mlx5vf_pci_core_device {
 	struct vfio_pci_core_device core_device;
 	int vf_id;
 	u16 vhca_id;
+	/* Flags only modified on setup/release - bitfield ok */
 	u8 migrate_cap:1;
-	u8 deferred_reset:1;
-	u8 mdev_detach:1;
-	u8 log_active:1;
 	u8 chunk_mode:1;
 	u8 mig_state_cap:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	u8 mdev_detach;
+	u8 log_active;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
-- 
2.53.0

