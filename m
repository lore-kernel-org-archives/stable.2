Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C9B377EDD;
	Thu, 11 Jun 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213749; cv=fail; b=Z0LghgW36+HLo8Fw3olhmY82pGFdprb/Hv4oFGWP0jnArkUuCbnmM26QYZEs44tMP6lV2Nl9rtteOgiyNHo3auhLOKLPB014h/fJSvU607gnRX3VZ08z0+WACdRRDz/Sr9e85ERs6QMTP/3d2nDCzKHBEhLko/DHgK1FOYRPn3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213749; c=relaxed/simple;
	bh=1ZNAu9r5FpnXakhRX7W7xQC7JLrAfbmcNJY0gxjZ1Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSTusldNZayR0nxT085pDwJO9ajPz59lxvWYfVdQzSlmMl4dD+URw2DrVgBeOXWpqViNwhFZkzi7p7Igm+6ohUJN5xCSD8/ihGu+8v6lbVovoQXQ+D0Ju3/3eaNBIAE0vOehIOQl3dNzEG3KXzZAams0gm3In6klh5FYjjr3Pos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=driJiw2v; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="driJiw2v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6z5J/a27yZJxisEn0DWJ3QmIKFqYsXAYY0ucirRmV0LxcAyoZ3MhgGt64MrahbkgCjcL15NcqS/Iy9C/qECnslt6A+jS9ZtSnBr7CXrGooJfSKVIu6jbwkHGLx631eirLEAmLpY5q+8WIs9jjl7qJBmn+KkkYS5z6zQoB+O5k4K9CjY0taewah1ZQSSRve9F42kGHA+0OnTdOAXv1XJT4T1+qc68O9ictTblqyaxU1CeV/IT5xSKhD0gIfATg4Gq2QvSVS6zvkMmpKu2aErbLE7OIN7k9msgb3CpKkJup8tLKZ7yoX8PwQL1Cw7vgfDGtdbWxw3wL7LdMF2j2x7wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56vzNDkKwkkmBgAwerTWnQ5VbZIELchO+aJxuHrRx7o=;
 b=iTBn61+ChLdoN515Z3RDWbhTqnuTbWYC+j+28ql3Wyx7weVdvvKk3D8tga4uWl3zxOppC0raSuNMWImLHsiN0OD1W9wU3JmXZId1A1K2kmwPjr+w4rVDCC9cmWdpBj26DkLla5/r5MyugD6pVoiNEClnyiIB5VL1RRIog3/BWrMhm+5V9Ntp/XupzdOD8tYDvD6s8Enjl8TtHOJgRBubz/D0nz2WL5DrS8tUyRAp77Ryyamq7JE+JPUtpoRLNEtMukThyqZhk//nynJ+ucNgkHPi/tmoq/4YtdPjzcodkHSrW0NYpqNRSZMfayIUsf1W+SATGgPVx85dZMGtErmlEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56vzNDkKwkkmBgAwerTWnQ5VbZIELchO+aJxuHrRx7o=;
 b=driJiw2va06fvgn9z44+26noLQUvrKsCeR65mO9EOYVB4p+uUJMJMTp3KH6IB23pYHur/X/STP/KrHU9hkfsp6bgIAq3ZcpHp/AnyGdEelfBYIBTK8c4kq0m1zap/LCtmcNRyUHXFvtSdEXOTbKOb2P3MBGDxFJCqhyQ4WKYMj7bMnH68OEQfTKpFiFxx5mmOZXm1Vr27mS6MnnMXST2w4UzheIrD+mVFcU1NjJZcpfXOUZytTV2ksuH0Ov/zwNOW0wJEMTgynJxzg5dDIGnNrvCguFYoZnjDW6XaZw67kJUG9o2B6mx7qgl+ZEOgWVaQuxSk+MCozq9Gv195H0Tcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 21:35:43 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 21:35:43 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/5] vfio/pci: Latch disable_idle_d3 per device
Date: Thu, 11 Jun 2026 15:35:34 -0600
Message-ID: <20260611213539.4100590-2-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd57bf4d-5ab3-4ac6-b82e-08dec8016435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	TOs7khqNoucvHtWTFs18jvMWiId9D8S0ejtX3Y+rYFxBT0lHdciyRsRnnrl4ssY0QYGrLDsGG3BSXFzfKZrA105mMMtS+e+XHV1brB7ciqLy0x63VjCsgFaP51MJ0obeNPXwWdJUu7XhJD2XhPMA6kLuyHMd/p7QeWy8HohprW6JuJy80r5uc7ROAWQ5yyteosvWFzePPXqMJppQsTyhwrZlfSeBatydMk9eACYd/yTNeOE00m8A6f0pcc4JIGo6FDeKyTqTRoNiz7wkTmPGFRRs/9UUeRhbULbDVkhN+GMAeGjCB7fTYcidBs58CQ03NEAqal2f6gF9AVoE7tHYNcCoESNaQSKTP15HTa03sGfmTeWhCowOcqt5JCpOGJvzaM2bhfBLzUHAD7F1rXvg77JiaoLpczhsiTr6OvRL0+wQ1W/nbIcnNcJU9KV26GpErxTcu2YlWxX0g28n1K3e6pJ90/9SQmlbtzZBu0IVPwJEw5m65omV5Xf9gJm3J2OKX/GGL2tNyzStIxICvDXX6mKF5bJg3zSMYwbrx4V3pbAcayP6BxX3aDnXSD09SYHXKj18TRwYiTPr5TsE0rDnpEU5aA5SHvkI+6mx5yqC+Ts2NLpRdoRCeME1caoyG4y6H5mcikxzc66FPgMVMHMcL62/ImDEeXtyzBVXGKNOTnBHJbxBWXBloiO4uUTQ9YCb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W33CoAz/LtLTsHG2SRNuZO2UPQ/1HYFFtVXEN3Fw3wbB7vcYjIYL2h0Sa3y0?=
 =?us-ascii?Q?MT0m25yGeOpZBdSw/mgvF5amMsDhZLlWaaBnkb1hJpnmjcWy+PXTAEhxDl1Q?=
 =?us-ascii?Q?g4ubE1gpWhURf0apjmRsB2f4ZB9ymNZ99DpCXuSaaYE9gAZONbyHKr+ooYgU?=
 =?us-ascii?Q?aaSceM8Q/9qEKqKkNjJoQf3jqfGZXmqgFkRc1W/LGM0k0kGL6oHZ7JWLvGPa?=
 =?us-ascii?Q?WTcmDRjgJ4A0s8WRkk7PX+nU0QOD/uCCjzOpquycNNxUYxwVo2BnluVJdsuP?=
 =?us-ascii?Q?Lwf8FmjCf/qOh9WLz3Cq6H59LdYswdm+RN8VP1vUVtOaxNxlA6O/WnCh9Q7I?=
 =?us-ascii?Q?knMoc6IAX+1SrEaaJZDRZSUJO1ckYbZ8lkITdmHRcVx3ktarZvqkNdkfKWel?=
 =?us-ascii?Q?7rlibbt2EAbip7rsC5jsy9xeqIo067c/e8OEl9CdEQiV9jZMxNwtYHeskRC4?=
 =?us-ascii?Q?xWnk9gwhHaa6hdXF0nsr8ro42KgEJmiORm4DNBjY3lw4ZZNOR+MGVkgi6rxB?=
 =?us-ascii?Q?2s6PRaJYmh1m6KxI+EBTByI+aGwmXsbqHHpZtYwg8CIPXAdu/Cb3ZcPTUFtT?=
 =?us-ascii?Q?bVnj19nLJsEQpM/tzBfYUi4FCDZ31IaA1FAojS4oXedGKD3DyQ1zjznlHRma?=
 =?us-ascii?Q?8xjXbcYjZ0lqJMxIy0VoeXWiqC4845HkLcyLL/8jJZfs/yvyQkN21l2UADA3?=
 =?us-ascii?Q?mn6+XqUIunY1b0BSYSDdwCnpYmExS06WIdurlvwvBKXoWcJhU+VMI+jLHQdy?=
 =?us-ascii?Q?IZARpSR9xciKh9rbt0hM1tldAqRq8TV04KAJwxjBlIM3hhixahdyHgXOiTLD?=
 =?us-ascii?Q?+L6Vt02cRsLSX4Ec4hgphPP48cX3CRTtnt+j6aMTUk3bcTK0H2SGLjtlooOT?=
 =?us-ascii?Q?ogStYfKUXhWrebbjnJwluBCXM5/NSDI8k/Z3CIFrG+wvsQBHnjrN2Fo5OjAA?=
 =?us-ascii?Q?Wh8/PmhHI+KOjGN8uILZGZtnB8Rc2sr9bhVPcI7Q2MVJPRuqCNsdfFq+uFe/?=
 =?us-ascii?Q?zseGKBcTwS20db3xbB1R7W6p0ODWJh5Bq/2/ZbBJi6/T7TdnkE7KhXSOzkWt?=
 =?us-ascii?Q?zPD5uHiMI5a8C1LUViP1g6NmmYgVRR8F2zpiH3wtSRBNRc3KpWySkY2UzEBv?=
 =?us-ascii?Q?UdndrgrDUe69p/LMUmw72Cm+G6TJ8NAKKPySKWMPp17+AiRDxU8p9BM3w2DN?=
 =?us-ascii?Q?VpjC2NQOxvedZ3UF8E6p1q9Np4SpG9RW7NIpYKvIIsZ/pstKBeMKIPcYh7Ah?=
 =?us-ascii?Q?9knrARKfqF5hKDNnn9PGB5nTCSeknrlTmUnpGyb/QpD+fkJBKq4Ul23eC9sP?=
 =?us-ascii?Q?+/mM44j8VMwP74PJvnLyeczZG/7BVRQ4ZOng59ZYAr7uP3bnaaYhOuMGZnpB?=
 =?us-ascii?Q?uliwaSSIn0HDA3/5wr2BLvVKVLpNHySRFpSuVUOuxsYIFAp7GA66VFVVJWFH?=
 =?us-ascii?Q?tWlXDJMi09UhgUPlOyuLUuAwUJ9P1gh/6ViWdkrX9J/0cRIHTMa+R3txJa/W?=
 =?us-ascii?Q?R4yFwu1GeGbVhT0PliOiKtOpLAYcpruHFUPx+3BSeyXa5TUVve30qnWh769D?=
 =?us-ascii?Q?KvgXvhRvpx82SSeDFN/HnNFwjWBOrP1uZyQPTyc8hJTSGfDoufNMlOWFCxSU?=
 =?us-ascii?Q?rKKwZFxRXqSYGZGVinY8SnGmCoKkySN8B46JtnpFjpVmGuiWPkJ63JsK4yBY?=
 =?us-ascii?Q?+3wCD0WJ02BMfLvx/aZfd8ocg0XkkpfI5/JvJksV5Ql4uzcPqWm8jJZbAyXb?=
 =?us-ascii?Q?JzZnW+Kj8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd57bf4d-5ab3-4ac6-b82e-08dec8016435
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 21:35:43.6023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plPsrMOMzujVQJQ0NisXPRlDmQivBS9xTA1vXxDfynAUshIe5+hAGhLIpPDu8R/Tq6k8JO+iKFSnCtqvi11/cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706

When disable_idle_d3 was introduced in vfio-pci, it directly manipulated
the device power state with pci_set_power_state().  There were no
refcounts to maintain or balanced operations, we could unconditionally
bring the device to D0 and conditionally move it to D3hot.  Therefore
the module parameter was made writable.

Later, in commit c61302aa48f7 ("vfio/pci: Move module parameters to
vfio_pci.c"), as part of the vfio-pci-core split, the writable aspect
of the module parameter was nullified.  The parameter value could still
be changed through sysfs, but the vfio-pci driver latched the values
into vfio-pci-core globals at module init.  Loading the vfio-pci module,
or unloading and reloading, with non-default or different values could
change the globals relative to existing devices bound to vfio-pci
variant drivers.

Runtime PM was introduced in commit 7ab5e10eda02 ("vfio/pci: Move the
unused device into low power state with runtime PM"), which marks the
point where power states became refcounted.  PM get and put operations
need to be balanced, but the same module operations noted above can
change the global variables relative to those devices already bound to
vfio-pci variant drivers.  This introduces a window where PM operations
can now become unbalanced.

To resolve this with a narrow footprint for stable backports, the
disable_idle_d3 flag is latched into the vfio_pci_core_device at the
time of initialization, such that the device always operates with a
consistent value.

Fixes: 7ab5e10eda02 ("vfio/pci: Move the unused device into low power state with runtime PM")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 30 ++++++++++++++++++++----------
 include/linux/vfio_pci_core.h    |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..9f71eae0cc94 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -538,7 +538,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
-	if (!disable_idle_d3) {
+	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
 			return ret;
@@ -617,7 +617,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 	return ret;
 }
@@ -753,7 +753,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
 
 	/* Put the pm-runtime usage counter acquired during enable */
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
@@ -2144,6 +2144,8 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
+	vdev->disable_idle_d3 = disable_idle_d3;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2239,7 +2241,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 
 	dev->driver->pm = &vfio_pci_core_pm_ops;
 	pm_runtime_allow(dev);
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
 
 	ret = vfio_register_group_dev(&vdev->vdev);
@@ -2248,7 +2250,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	return 0;
 
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
@@ -2267,7 +2269,7 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(&vdev->pdev->dev);
 
 	pm_runtime_forbid(&vdev->pdev->dev);
@@ -2429,6 +2431,8 @@ static int vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
 	int ret;
 
 	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
+		if (cur->disable_idle_d3)
+			continue;
 		ret = pm_runtime_resume_and_get(&cur->pdev->dev);
 		if (ret)
 			goto unwind;
@@ -2438,8 +2442,11 @@ static int vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
 
 unwind:
 	list_for_each_entry_continue_reverse(cur, &dev_set->device_list,
-					     vdev.dev_set_list)
+					     vdev.dev_set_list) {
+		if (cur->disable_idle_d3)
+			continue;
 		pm_runtime_put(&cur->pdev->dev);
+	}
 
 	return ret;
 }
@@ -2552,8 +2559,11 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 		up_write(&vdev->memory_lock);
 	}
 
-	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
+		if (vdev->disable_idle_d3)
+			continue;
 		pm_runtime_put(&vdev->pdev->dev);
+	}
 
 err_unlock:
 	mutex_unlock(&dev_set->lock);
@@ -2599,7 +2609,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	 * state. Increment the usage count for all the devices in the dev_set
 	 * before reset and decrement the same after reset.
 	 */
-	if (!disable_idle_d3 && vfio_pci_dev_set_pm_runtime_get(dev_set))
+	if (vfio_pci_dev_set_pm_runtime_get(dev_set))
 		return;
 
 	if (!pci_reset_bus(pdev))
@@ -2609,7 +2619,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 		if (reset_done)
 			cur->needs_reset = false;
 
-		if (!disable_idle_d3)
+		if (!cur->disable_idle_d3)
 			pm_runtime_put(&cur->pdev->dev);
 	}
 }
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 5fc6ce4dd786..27aab3fdbb91 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool			disable_idle_d3:1;
 	bool			sriov_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
-- 
2.53.0

