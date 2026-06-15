Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643804071FA;
	Mon, 15 Jun 2026 19:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550792; cv=fail; b=AKDi/Anyo/0W8lQVxzJI9W9xAeknXGwsUnHVzUZ/tLu/f7lppegS21QmVR7dL5gDmws/AuZVgWO65BzoeJlbUu2aUm091+LR4iuI1v1jj18kCW9j7LMXY2szdPxSz34psBhzqLQ56mxXc0JzrJr9Yds4/iTS4e8gJWrva0kEnZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550792; c=relaxed/simple;
	bh=LE9Yi2hs/cWn9EThu14E8QpaEl36q+7C/ewtsDH8YBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MGLyiwqdhwWyxnBtPksEnwrhVT2Q7jje/ZJCL616mSgqm1iK3o5U8VHcRhgTW0IbuCUIpZzpFb/471sE9nMawOeCZwV2JYwsYnQ7l2sCr1j7QSWXfyyRl/ah96weZbLibUw04l85BSamtPVwdok3XplOILV8h5innOv62UAYkTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PKK73w/Q; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PKK73w/Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLsTNhoiYpk5j61vnRUWpkAQUeo6iEEFfJhihSmLMpTAVdl/YrW2kDU9/mjgZ4uNxYXIRc4V9rG7BylxfqLW3ckQOyuqL2wTKee470qLw9mdhbTBzI77m7dZ/vWN9NprEYJ+UeWvWa8NcX/HWGxG4WkfWOroegE7YLnEUO55S4DCMtYjbeb+AxvGyIowza70c8rq/DudXkh8tj3Z4hamzPRnSt3lyho7I4PloYxynSVmlxDLhLYoWXe3fs25H9QjJWSXSUZIiflxang3w9eo2l3ZmCCL53n3/PQAjacyHaampLbQ/Bmywiy3fiHUW8aMAxSeIBhRYxHMI8oBTxWfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usrwZyKxEfXbA3aZ0Cyxi7F7EA9cP1FKeCOT3yhv/Fs=;
 b=Fr0Lf2hJwes/Hn4H2Sm96PP2SHSP6Gtyn4RydGZLtrnFzjq+d7PALmer9Kb8lnxjCpV6eufTtjjyONsLimcIx1/haD7ILAkcaWf4CUb5IQ8YxtPWgvLAd0Gw/o3ThT/CgU1SiQW9P8I7WYRnx3l/cjwQdnrCPhZDo1P8AYpJ6xCa7mBNLzK0qYpYfE+yQgFK+SgIMwhLMPn0ycrNGIpnIcYcRohOeIhvygCIug2evaC1QA95BVvgqepcmsU4fdBeLsPkz4eg5axCzLc+F1EBHlVw0sJQ8NVvZ5De/Ya4SM9LW9gOgNG11ezzRVZg/iIuclZCy/dHtnw/obpOctoKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usrwZyKxEfXbA3aZ0Cyxi7F7EA9cP1FKeCOT3yhv/Fs=;
 b=PKK73w/QTgOjT1ubm7tpiF6AN12AxPsUqymJv5yyIIy09I7Po3Ht7XFrJHnCHjFic9Mz0e2CNeXMvl8VUfHuygXzHT+nfrIPudw3JojCEJDiOFhqgaObTOoJFBnOnDCzaccLSak5x9SIsqmxVZ+4oBMrwfK3BME3V5RJu14Y6iKJNuCn4VHtsVx2jfSbzwdfzVrveynm/dU/Q69mykg77aaHLipu5Ko1ELqeMLZBh42A3lIQxWpu5HNQP3hz1U7UFCBou/tUrL2a071vEjyfgJxm9UXCO04bu4YatD0/zwew7CD38gbldhGNbPVsIpwzkxG3mZQJQcxtKyIcy7KP9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:12:59 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:12:59 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	Yishai Hadas <yishaih@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/6] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Mon, 15 Jun 2026 13:12:32 -0600
Message-ID: <20260615191241.688297-5-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615191241.688297-1-alex.williamson@nvidia.com>
References: <20260615191241.688297-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::14) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b88a10a-1112-47fb-a06a-08decb121d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	/8XozXtPsMRrHXsSlg9OjSZ9c7vurNluLpZePd6iojDUXAXpEwK6bDqFv0RtFErYtO3yqqaTfmzf2GGoLhmgnVbY1PGtPXd7oQw9dWkXp5TbkbCXAWz2JrbtrhZTV14tg+4liNhWnMMFFjRbt5K7nX0RNcNOsgNS8CROVFeBwHWTKPWFzg2HRDCeilXanM04aPUQHB9w8Uju7MGDI1m7daSaNwI4GVF4TGnbHzNvbvDHdSt8YeblHmE2+qS+ol7LWKlNojK/ZXxWnmxx0JGPOdIHIJC/yBvtB5/An0zV8Ie86OCEbevCrfD11co+RwinUmgeHpkaeuwgsMd6R2++GYa/Q37FH7RnxRUMFCgo3bmhjos3xWe3pg4F6dAlVf8tD7Bvlox7NvUKI5yzOt/fjZz0owBOLKqkhvyVu60aZA4M9eK3g/mCO63c33zK9IYfdwWhMiQDQ/QgwecEcomC/oipHOmVCwkYhNT2mwLpykX2eLrjIYjDSwHmT6LvtzWL/aOcKpEUpNzyRK894g/EbYSZTAiD1fFvRIWqu1zBmxp5kioFVuhlOQUCV5+gLwb2x5w1NNPhzFAigEfw0IP1Mk9SUNe5cTjAR0HcaNTDYXvUtN9K1G6l2SAEx1IiTEgqKou18C3YuaxT3TPTOO7x64muEt71yJ0JLsDAIhna43L65zK+vDHP0u7tYnmcWIsT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqJ8JIUQImnjuiIwFeZXOFfoRUmX4UzTmQFBxjPv6WlEQ0GKNF4m/L1Fey28?=
 =?us-ascii?Q?sbiPRF4Sq1yQTkqQEY+2hPkkg5W+JCy+O8iVn7Fwv7amNslQvU1p5GcAHdQp?=
 =?us-ascii?Q?ck7hBl/Z0rFCgJfE3dJnibyFlBUTeseAunLM9GiH96oYWSLMTiK/pxwCdOX1?=
 =?us-ascii?Q?egCbf/RTqFLhVtnI2NS4Ejrwf1KhwURUlHiZ5FPs4l0iuoAeEQh7wbMdGbwN?=
 =?us-ascii?Q?nBUxGBpx5fR9lbc4OHvxSh0QMP7j3+RPOYTMO07aWllZtnBBE18nbfwcS0Ik?=
 =?us-ascii?Q?/DNEZ12eTIuLB1/pNZcCRHhg7roISwOrHaiw53ajqet/4F5D4gE1oJEAYrow?=
 =?us-ascii?Q?zG0jyRD1uyN4T1MB/3x2RazlKkXq0XkvggGWIXWUSUY3Cj0HKCufa1i7d1gl?=
 =?us-ascii?Q?DXr+ik8uM1uE/JAuzGRiR3FMi25LrCMfmZilMJ4ISOYB1a6hi1jGmLrS2koB?=
 =?us-ascii?Q?06SFNpJUcw43BgZpgnswz5+cCie0HCwAxKbiZ6Q0X3MAKKCILgBhcT1UjIZT?=
 =?us-ascii?Q?yqdQXC/1Iws2wSzPmu3Fa/2PR/V4916TMhtenYFfp3cFZwi1+0tNBOcw0OO/?=
 =?us-ascii?Q?6XQEK164BnOY54TBXI6Ggb4q2023x0FFgFfp9C00DA1Wo3aO0tdk58BsAvCt?=
 =?us-ascii?Q?XFZVtjmogQcCUuVog5qbbQD0sHRoL5dapyfclsBszSUkiHouoDq8Kh+h11qL?=
 =?us-ascii?Q?XwFeMxhjT0wK1ViuooyvTZQ+B3Kulmacc3i/k3RKDvi7AZ3iQhwA9OKH7UQH?=
 =?us-ascii?Q?KdTxSg/XCRYxL7GF9Q224p9zzowJ+T0WkRARo8HXwGxCdkc3fIbYVTOrLZuS?=
 =?us-ascii?Q?HGzS8WH979kubckJtsuBgDSB054MQ0cL/3IC7MXDg1iB8pzk5Cdp85LGaMyo?=
 =?us-ascii?Q?KmNpZEfOUA4ZDC7nPiMjb6peiPnbU81A+R+Wsr6zDzFcF12bwzYFzkGAhewk?=
 =?us-ascii?Q?4I4fUWG2f2u1BKyxpTGu5sSP1/kYdrXAVKMg3lxaQwtoI58HEH/sOpos/mvQ?=
 =?us-ascii?Q?X4lwOYBkqoc4g7RIiNvcq7RdIIDcDhTW8qDuy6+8MlDdXEgp2T2IGQAIxZ5B?=
 =?us-ascii?Q?UIPx478+SZ8xMxSAKZxKZh9UC1QAyqZPtL/2F/bVf7G/dzDbJWcoUl3MEtio?=
 =?us-ascii?Q?DPD8z0zMRPqwQb3MFb4sXsjpY9FMVYs/K1idMW1QHz+B0xkwGtZBdNIqvfLN?=
 =?us-ascii?Q?SbHSj6VUKFdXduNT2bTfWjQa+T0aDRP85MhciCwxfnTRlt9hDwa5prm/7NR7?=
 =?us-ascii?Q?L1M13ra8H13qQRUes+NE7MFA2pJ7bz2jg3IaZVfbU/rfpNYl8wEQ5I7CcyJr?=
 =?us-ascii?Q?Hb8WNn12zHhqTTFDkc6ERYWIMPsHxDwrirJ+e3YQx5/xbZtD3mzbGjlvRYEl?=
 =?us-ascii?Q?654BIkzospasjneIgI8v5t9amtT9WwPlli4VWNvQe7DAGdivmLBJYlN8UZEW?=
 =?us-ascii?Q?78mbxcFIm+fo63z1i+Y6FtpuU7tEUEPo3kxIqy072e2AUAHvfcTYUYb8JGgj?=
 =?us-ascii?Q?9RzCkxZpYhA+eoXzHwGBtOQ7WhNfBmzAZ+nHKco92IFYORTaiWuFf5VI5L9q?=
 =?us-ascii?Q?wpiDBV4B+VGXvuDDr6ckY9ss44bQOMvrrxdzmfdgykbYzSt8f4V1SSWzQwb7?=
 =?us-ascii?Q?DjHl+N8tPyQQ5G3Oy7Yv5B/VAQ5t08AXqpqbw2dwSHWyGv9JYZ0/UrrdZTxM?=
 =?us-ascii?Q?fJ/cFNNC1A9YFKtFC2+GzGFq3hX+rwnRCNQiPnUp59dKwZXAeTfyl04Rreix?=
 =?us-ascii?Q?IsMxH9zzeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b88a10a-1112-47fb-a06a-08decb121d42
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:12:59.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIyX8vmex8QIaFB1XGL21TR2XTpRgaeVJxAcb/IXmrfxB77R9nCAazZre2o8It+B99VK8VflgEkFatgOkfeSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

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
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
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

