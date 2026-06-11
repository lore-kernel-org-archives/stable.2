Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB107378D63;
	Thu, 11 Jun 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213760; cv=fail; b=M8XHYAjdy5PXEMR3ceBY2XyQHekCV56uU99NzF8lI8dijUyYzNQCoGtW+Hpp0AjvZpQvXM+JlwFPm8w8FYgECgot8CinAO3+VV0pnAg2I84wfuYpjxcB52dIwN8FU1Jy00C6K/4yXkvfcywJA6t/j0evWaMaYeKoeT/HYhY3nWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213760; c=relaxed/simple;
	bh=f2XM5hK5GIcSUc4Jr7BC7Rw/4B0ABtuIt5xep0WvPdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KgLSRvxHBVxw0UpRO/B397GrMACL7Za056AUWy/CZPQ+SOo4tSXDxrdm/l6E58XCmsLiBRcXTvdaGD98H9gp9kcIrA+q3auzdn23FMERePtK0HQazuPgS2ZRVddTHXbYAOeTE1IFysl3BAi8JWwzOB9JOd/zkbH0q0mGNP2SQ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QHwpQaAy; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QHwpQaAy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAiblzV48A32ggYRIv5Bc/Q1FXPqG6hxI5U8KQIhICmIZoIqXcR+Xj86vPhWnI8g6b82nuN7hvAluduVWZcVCzC4vcjYXBbsVsPen4d/SBxH8nL6QY8H6mvIWKDa0JqjZtLLDA+Y3z6yg9TebMRYBKRBeMrRUf/zBEvut4gKL7G+8dTf2iLl1IknK7vy6iUnzGIRTxSDII5rJ04FVlVOw3X8FAu8VWcBX3Jra1ghCg7zDsPcX2BoW/yFmWPvs5B5LzPNuybtdmnnBS6ly1q4B/W/OHik90EFyNWQeQl7gUN9fHA3e6y04q9YaktDr0+OX0dkkCBSAUnBDWUn3/Ks7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0w7xDb6IfdGQMUgMWvcF8IJyeElST5qx42Swhuc/+d0=;
 b=fDya9vHRb56u4sqcBIZ9hfYEpZI1Z7KRTynyLacelENWbK6JmJvnn9mwaLKm8YOKzmM03J0XCMShMW3XiG/HA9l1dyaTX6q4RHIksx7frwgH6cnJ+7pgWHjIT0feMMfuIN3NcPZ6eOZIQ+8JIbGKsGeSswkq16y6LCF4AAb+myV4zRAAHuy/AuJQHdflMy66J1Ew3M3yRUbpvWfUEYpaoT1f93KfCmOviky/ImTCeseelxDRl+Rl4Qzhfe5u0Mq8NBWdMgeZtReyzsncL3P/yF6JVBDgElqybaMqzga0R8yavLWwC29WU/0dN8fvFXTMNYCEMB1ETpuoynKb8ah1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0w7xDb6IfdGQMUgMWvcF8IJyeElST5qx42Swhuc/+d0=;
 b=QHwpQaAyBRPtZ/L88nzNzAhZcoenWhRLWtuQs7+28511y2oz4HjCz4hA2R5RDcbuMWjXZuS40ELFCmt6SBxzpq6Yk72FJvsc80X0/Q8ZCLsZPv1GfhiecNEGffPwxOdJZ9qPPvjCBv0Efdf60dRwA9I8D9ZWonjn9repBuGGBw8R9drW8K/xYNx5Z/7zYal67aomRFZPb66Auh9CxGAa5A/O/vCCkyFqFRCYKVkpeac0SLavpyUFE2xKr/SLkq/bkENNqSkq0VsFljqtlfgYJYk6Z76LQvRXTrr0qhOtqQRu0w2KfmRqGgm0vcCU4WU7CxlgqCYNTkW5r2CLf8MNdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 21:35:45 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 21:35:45 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] vfio/pci: Fix racy bitfields and tighten struct layout
Date: Thu, 11 Jun 2026 15:35:36 -0600
Message-ID: <20260611213539.4100590-4-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5642a0b-ee4b-47e3-dcd6-08dec801652e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	y0qfT6B+sniaRb83RUTZrlL0THU0nGDCA1VjRQrKwAA4vvYYl1a3gVA1yFb/QWbSltfAzE0g8nvvotKD0qtl5QOjL5nPJb93keFu387mS2wz7kKRor6seLsfpS+GCcfOd/3qugA1rF2xoNA9eL9jKbgE5Ri571hJnangD2le1wAqDtrqE8f1eOjQOkpGkEij+5Q/BU1cMQnmOc5/2hUd+9qv38BdymiYxT1eqxkh5XZbeucYQiw+EhA3hKkHUVgg3lsb3+lPbFaiCdqOgD51HRzA+mD9LlINlQHrZ+3vhuaeMzbErsxB+aPo3XPNPzMSJrrwpbRQe5adCjdrq9/WbkPUoHjoj8oZunhcTsmy8kORnfJigCc+O/QQnAfRoQKiiVxaz1LVNLu8AnW3f4kfV2NmTMCxqyw3OienI6yWQg4bzZvwxWClOhMmavOAEsq7Vm+3JEEb4jWXutvPFpVbqn9QChDkPYaoS1ulOKkBIlmKbmq2UsMIHfDjWpIS9g2LAo47OnOKvgIUMZpnKYr4A/4mqjW9REj2fj6ploFZV19KFtYz+/KQIejvyEL2VWNmU280d8KEwZ2HZxECe5bMWVfLJEL6Q/1h3057vr4f34ziiXpOSbyGwtyA4kLCo95VQw8AGBAX5gg4cS78a+v/ra4fROvHjh+ejmcngonPOal0n4Lj37DNKtDaMnZBIdwpw3nqey6pjIO3jRoZ0vnTXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMPSdumflmkw/fpx3TaoUFYJgViGw0d0lCLByrXE0gq720OJL3VpjRgLjcyP?=
 =?us-ascii?Q?eQNq1vuplIoYKJnLWwVBL5WnJ/PhqWr0YJxTxT5AVb++NIGyG3TBvgYirvqs?=
 =?us-ascii?Q?M9P92SpPdhmIi5Xg6bwXYjcNeU7G92kW2TI43nGTupSv0oOtCD2lH12QQz7l?=
 =?us-ascii?Q?HlioJYaa0eOGg8aSYrU1YwBSdOMSDPSknElwwApDSpxotwTQx0wAxPrY1no5?=
 =?us-ascii?Q?haolA0FUyI9G2swhKDJV0uWWpzYE9lu+AnJnaRzQSLp/dimzk2dx7T2hrQS3?=
 =?us-ascii?Q?zkwXsFEsEM8PZW6zCXJkjigmKsIz7tiQu1uLQtsBC5gKN8HN0WWa1ljCHUyj?=
 =?us-ascii?Q?x2Aw3pPr4YBr/I1dHFNe+yfPxZOuGMYzQ60b4UbTbwLzehtiWL+/fupcObLS?=
 =?us-ascii?Q?flWaL2B5knGJXyQqs+2KjwNqQbQWBgrKoYoRG02jA3SsPd9VgSgJPoOIMipG?=
 =?us-ascii?Q?ZOf+HyYuxF/sy/+Eggopixa/cpFDvBauBHbg433f9WB5OS79txgFy7epdATp?=
 =?us-ascii?Q?T+QR/HxskxXLK0lFcwEW9phx1XPBIUpFkxxATVMzrS9hkrCV/J9ipjl3nS01?=
 =?us-ascii?Q?GmXsmjO+ccOkSgmmtXVXGhKZB3VEcvnZ9a4mxayd60yaCrv9YpTGoqnz5tzd?=
 =?us-ascii?Q?MsFZEe28ghMv0hJZ0VXPx4e/Rh6ekc7L2oNpoOfbdRuvynoF/3TF1GkygLMb?=
 =?us-ascii?Q?XQee+TCoiW5G3eZhYRwP9RoBxVIjhMRW7ZyyNSCQXB8Ys4+jklHJbkOtZt8O?=
 =?us-ascii?Q?bnKb7kLG3xpZ6a6K8Ld+ioZkeY0pyMJM8uhPLrdWQ4Bjj4Yxdf6xpWxGmv9f?=
 =?us-ascii?Q?jvlxEzARgseH8NQfhJ9VYsw8FbkpRVJtt04QTYejKB9y8+UO+WHw1b1s2Ph9?=
 =?us-ascii?Q?32PlZEkq8xEI+znIkHvTSz/hD/8O0ED5u0p6RLnxtSaQV/zvGYIIpj7Xq5BH?=
 =?us-ascii?Q?UfV9A22bkHynu8EFd+fGTGnqm8RjTEJ+oODGcDJSMvJrD7XWgQhVZfkAvMBD?=
 =?us-ascii?Q?MgQKpu05ygCeyL0gqDKLObQH8VuFrK7FaJ/ADEQyPavjXew/kUOw3HeiYFcr?=
 =?us-ascii?Q?sqjxvUZOUPAy1CmnZrMWyaVsxfla7xP95kemiV3AkxNgEmfnDNd5PVUDHSoE?=
 =?us-ascii?Q?/niELMsNO1mrmpqAiPFAzr680yVFu3yVVyNS28nAhyxumCajUHTFXOKV9h6B?=
 =?us-ascii?Q?3z2RpyNfMx+lhGfV/xlGZ4NkXH1ZBnip+madlqhF1xzkSzY+ncJL/eIEbmjG?=
 =?us-ascii?Q?DaO9YcwIons/LSDRQUGzng6UMVDCfWVd3STHu0KWnQaP5AADLHlE/sv4gSgF?=
 =?us-ascii?Q?MlOhkLMOCaqnDCyBlo/fBA5n7A7xUJCser1L36gSDOymxJpP3NxQP6scxIT4?=
 =?us-ascii?Q?5QQ5LfwRDHtJCSUBwgJV/ZSEyY1bLyuAaSddpzJpJ0IBsPMc0w0ZUaXaXmqM?=
 =?us-ascii?Q?vPzKfDqtKG+q0RplwGvJnNf0zkOKO2DLz9zcE4x/FsL1wVcII58Z6Zmu/Yu8?=
 =?us-ascii?Q?8lfWDSjGaNKBcGJnzM4udWDDPuz0mZb3j/KXm9Ykn54bdH4mnh7EdugZdR3H?=
 =?us-ascii?Q?DxsMjEOZqBJzkNk5/snN+TF2cRi+sm3LrMzJGJtcpkQL3DbCK5kD6WaPc7Ja?=
 =?us-ascii?Q?KJTkURp51dZSrFi/cFE0CRJxJWhHC1lbMKdRiuSw561BUsjYZXumg5sLzcJ2?=
 =?us-ascii?Q?ZV+dDhZD0J3UeQ9+yCiN0GpNpzpwhLYUM76EgiPdWarOXFOiISMKr5Tj8cTK?=
 =?us-ascii?Q?Fs564UE/BQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5642a0b-ee4b-47e3-dcd6-08dec801652e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:35:45.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfoClZ8hlvOwU4RNHRrtlezJdNjdpu4tNDAZ0VK6ULkhYhCfBfA+VtHnm7bpLK0jkoekg/WvmwYICQqCI8ZFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

This split takes a binary approach: flags that are only modified
pre/post open/close remain bitfields, flags modified from user
action, including actions that reach across to another device (ex.
reset) use dedicated storage units.

Note that the virq_disabled and bardirty flags are relocated to fill
an existing hole in the structure.

Bitfield justifications:

  has_dyn_msix: written only in vfio_pci_core_enable()
  pci_2_3: written only in vfio_pci_core_enable()
  reset_works: written only in vfio_pci_core_enable()
  extended_caps: written only in vfio_cap_len() under vfio_config_init()
  has_vga: written only in vfio_pci_core_enable()
  nointx: written only in vfio_pci_core_enable()
  needs_pm_restore: written only in vfio_pci_probe_power_state()
  disable_idle_d3: written only at .init in vfio_pci_core_init_dev()

Dedicated storage units:

  virq_disabled: written by guest INTx command writes in
                 vfio_basic_config_write() while the device is open
  bardirty: written by guest BAR writes in vfio_basic_config_write()
            while the device is open
  pm_intx_masked: written in the runtime-PM suspend path.
  pm_runtime_engaged: written by low-power feature entry/exit paths
  needs_reset: set in vfio_pci_core_disable() and cleared for devices in
               the set by vfio_pci_dev_set_try_reset()
  sriov_active: written by vfio_pci_core_sriov_configure() via sysfs
                sriov_numvfs while bound.

Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Link: https://lore.kernel.org/r/20260511221609.3837652-2-alex.williamson@nvidia.com
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 include/linux/vfio_pci_core.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 27aab3fdbb91..985b8af5a04b 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -101,6 +101,9 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_device_ops *pci_ops;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			virq_disabled;
+	bool			bardirty;
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -115,19 +118,19 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
+	/* Flags only modified on setup/release - bitfield ok */
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
-	bool			virq_disabled:1;
 	bool			reset_works:1;
 	bool			extended_caps:1;
-	bool			bardirty:1;
 	bool			has_vga:1;
-	bool			needs_reset:1;
 	bool			nointx:1;
 	bool			needs_pm_restore:1;
-	bool			pm_intx_masked:1;
-	bool			pm_runtime_engaged:1;
 	bool			disable_idle_d3:1;
+	/* Flags modified at runtime - dedicated storage unit */
+	bool			needs_reset;
+	bool			pm_intx_masked;
+	bool			pm_runtime_engaged;
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
-- 
2.53.0

