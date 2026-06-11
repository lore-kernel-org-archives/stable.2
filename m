Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869DA4C77A2;
	Thu, 11 Jun 2026 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202343; cv=fail; b=ppf35eLWh4b7DrAjp3DD9yuOk/oqSUpg/G2oXJagI8OMjisrU83tYikT74BoC6LDmOjpufKCouJ+nJ4fgI0f4aAdfMnM4BmBcj1VJ+G9Vuf12aJDIBP6W1Xqw+rHTDDd6pU90q/Hztj0KkxPl7aBKKeATcW3sdyoL8Fb4wTP8zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202343; c=relaxed/simple;
	bh=1ZNAu9r5FpnXakhRX7W7xQC7JLrAfbmcNJY0gxjZ1Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7h8hen+1JqvhX4exHj/bHc5oID55b/CzdoBDKaff7KjZypjp4ty83AwalADEuOsOFaVzfPzBTbohCCJY0CpS34Z7I35nA7ZyChR8pDusTKCOh8+0aoZWq2KN4GlxtqwvLuw6huRX9rPe8pQxdIdVkjsMK/f+JdKc7OnrAcZYfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NaBC/1rh; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NaBC/1rh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jS+OkJJozWE/RQlhTt9sPiMynSYzxuKf1ELCLqBkd/40GCrXk77CW2WaWQKOxOnjIFKZdZAbzoTDfZ9lZK1tcLhCpcXsEDUsaczzbRMBJSJVi+ShwTn5mCFtRG5dUAM0AkPBAZ5/XiemqpEyhCsh+LvUG95DxJ04DYaVRFqgR6DL/G6BrnwSoDDdHNM7+068jvnqT5/af0yCZ80q40TKOBvdjtCDyrG3HS21gnG1thdqJ9DYTIwEeumlE1BKWcbj7VOgnzyrRQUANb5zFPVSjPZAgKHfsWqZrk0mdEAzjDQPG92Bz2sibRTlQYtixWYvFsTklnMRr6cHlMzrSdt+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56vzNDkKwkkmBgAwerTWnQ5VbZIELchO+aJxuHrRx7o=;
 b=jpUOSn6LLAFIoVZoFcaC10lQoKEvVwq9M9IUKqiEVM5qUf8w9swWwd9+PuPQDyANOY9M+TOkUViJz1ScRZtN/LEn5rGrHBQ4jCUc1B9ZouDaL7gtwUp7cZzgqjXW96d/tEJcVzNuF1RXjGUeF36ypK/f+rUpZ85CAJP/IZjYNVpO4KS0te/SdmQBLHmFWnoopLz0rjBmogn9Qanpg/PjHcT4tNGqWLEMyYYqAnaKPARlIpX0tWoTOefhH0ymluqJZTeYQYWsr7AJh6MVTum/mSDuGTkAdLYtk1b7cV6kP8O2tW4CoJMTy5ZuVPgqWnjoNDbaP+xRrbRcLiBysfdU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56vzNDkKwkkmBgAwerTWnQ5VbZIELchO+aJxuHrRx7o=;
 b=NaBC/1rhWVRDlNn9tx476Cy+RyHrkCfEZHInF7Lwq8WiYhSQe8TijH+MRDdMu/Jajkr026dXC+IsWtsGzzxpTaBZk27ZCm5CXwmUucWVy9sx5x6BbDcQl76tbV4IWry20Xemz20/Cv4ZQKJLVWuzA4sQcbMdtgnA+b7ZNNzE/FLXKfc2FhPULj91S40R2JeUSjoFpTaAsWtWU1CJyk8UMU8noRjLly8VB2mU/ilIUiLYYqATb7nXdelESYtBVzKxucyW/dNNqZrQFihs/mh91KvCKt2jmXs7ePftOBeJJGo/WNp79rHLBosSGNXQNiRhpNNNVQ0XACQ4c3W1l82WUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 18:25:34 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 18:25:34 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] vfio/pci: Latch disable_idle_d3 per device
Date: Thu, 11 Jun 2026 12:25:25 -0600
Message-ID: <20260611182528.4004073-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611182528.4004073-1-alex.williamson@nvidia.com>
References: <20260611182528.4004073-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:930:13::13) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b611c84-c598-400a-bc51-08dec7e6d3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XBW4AK6LcTfqr13Jc92zfYdRr744mLIc7fMIvH3qK6W4FEoFCW1nICsOxu/kYhO58jcOp41WbvM9zZY9Lhv3cqhzJIo7e7bNOD8F3VGbDg+rCMZejehm1q3kp/XSW2ZcSidRSpdUa8bherzOy2cSSyWzJL6WNWRYdZI7jB7Mn9RvCKYCoYEfC7+xsu21VbuHx5At39ADu2qmcf9usvwDAmdUtCkIqqEgnI6TNMibZyoe9er/aVy18Tw+h7Ic2ig9lVpMVntTA6XSKsyumuvU71+f3cwss1NLKVk5CRP9o2UhBrqo0Ip/Jj4SkZGeUdNgYPcMNDgSaOANLzu8E9VayVxJ5RCR7JsXGVHDrJQvVuBvWZn9GNK9MWMCHnnX0wtJk74ROtwvJBDlRm/734emiz9JtHcnCeGwHmFyvqZmr2kUS9mR3qf9UpX5q/cPglbooQEWV86v4XB0v4kZsVddlJIpLvS13YQIbRiZhMNCo0WsrMPvjdOWO21OoSo+vVqoVXmjo3BEcjPlxC/7C9s5I6pAYCa4YxiQooD4yfFcNIK2eYGkFVcQyfA4/uQMbiNVWadk53aChXq6mw6xDCiJ9qtthZtPa8eJG83rCtz3Mu+4HFfm+TMUbTGFlTCmbmb57lnJJf1DPY7UfB9RIriVs/UGOag6IInztu759P6ftDzOopdPPZfsFt35OkPhxzoX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YhQ3VOEoHXeXykQDqkKyMXVMnOazoakk/BaT0xJ5/Qx6EyXZp/d8iAtAPmJp?=
 =?us-ascii?Q?7gICeZu+OYIomrsk0bqgUFCe3kRvtyuYzuM+uv76aO8+yM03XYOclG+7UeX8?=
 =?us-ascii?Q?5Wcn1tslO3RStx5w9eerInZXWvmnzERRDokQqiSbbXbeQPqGC1JgoO6YK8/R?=
 =?us-ascii?Q?/y5TpDBG80WfBodkmrtsX389cIs9jwK8wcqHNmnRU1YYVk0cQROoBPDUgyo0?=
 =?us-ascii?Q?ibAAvUNSoEMzTxRJPZgZeiA54RsQxpkOusTn/rgD1boryL/+fr74viyoJgCv?=
 =?us-ascii?Q?0LAlsrMxgN0XqrLex6gC3r4lb7d5Qmd9yRgA233H978Fj3p9h+CVGfYYRfQg?=
 =?us-ascii?Q?LBAea6eOR31SwE71cpVM8h/GqjQ5h0AKpgEbxhTyWVVScg/70GmJB9uPq1rS?=
 =?us-ascii?Q?ustDubwBF3FkpVhQDJQZywdUqGcSe3RWDtBPloA8rKLGV5YrSoQr4Dawqjne?=
 =?us-ascii?Q?D163DgwgQD0QPO9yCe7hRuKMr/Gv34NzmtZmpFQPLtJjj5tyE7A8kubzuR+g?=
 =?us-ascii?Q?C6FwDN7h1SMUVXwxbtFFMPt2J/jhzJ7QxZ00CL+fKh6teQ8A0JVSVHni2baZ?=
 =?us-ascii?Q?XoPo5/MirCtyM0WsscVE2Kpv5HsYpUC44GKrNi0JmB2dlkoCv+FCa8iPUEv9?=
 =?us-ascii?Q?CAvZ7EhAyBDtoy+lIk3z6pt4btqBpS6Bx9t9elc+onCxdYUUfb4X5Al6Dmyz?=
 =?us-ascii?Q?DQvUDBXUlpaLQSGflQwvDJD8g6/JbRFkTDoSJ9wOTcH7Lhmoip0gv1rYeAIr?=
 =?us-ascii?Q?4Br8UVJpeYnsd3k2sx5C4fDzwciNYub33HCwQcbh2c4LAQo/uAU9IrpaSNnn?=
 =?us-ascii?Q?WV7kacZOYpaECI9WWKRiqxsDkSZvMKkQkkzPVN3FtNWpT/+4SausZ7km34ce?=
 =?us-ascii?Q?hlxb1hs4v/uBRCDW3AX/iXaqsJeiVFyW+633ol4C0HclIRmjwu0fVFItcYVG?=
 =?us-ascii?Q?wOjk5N9a67OeqmVnlhhm1mnDQAhLUBgs/loP2Rz6OJE6uOhFUTLYHkstzhBj?=
 =?us-ascii?Q?sXaWbGS1YJvebPOr2WqRSx4XnaotVTuN7/9y+GxJ/R9Qzbb9DlIy89LMnRTv?=
 =?us-ascii?Q?P23AucpcLyshSkPvtdqxB6jsDGA28vBaZHm77BjxWd0AMeeNlYHLcGFvdrAn?=
 =?us-ascii?Q?68fiR5wO74gW74E6WK0mUM46n4Vy5tylEDCGpH0IFG7QeMh47pVWpleYqWVr?=
 =?us-ascii?Q?xb69tw0+EysmCxXVe5ALSsoDmnbPFx1ERUEvsaQ0GRUUlNvbdVLD3IEIV0We?=
 =?us-ascii?Q?o6k1+saLBcodJrKtF5YVfDX1lqq8l3f/nGsKG049fUQr9kZshcuvqRlu654k?=
 =?us-ascii?Q?5vlcvqwnFa+oO10Fl+3SjEJgycQEKb5e7B9flBY1Cdis+HPs432vstb/L/JF?=
 =?us-ascii?Q?PEnEk3rIlFgtixD5rFhRFQmnYiVaKEEKhEGxAKrNlDcHK/uXgdIA7U0i381c?=
 =?us-ascii?Q?o5IxD+gsjq5ynu2aNZLg5obeR/Durt8yPWPBXjnEu7W5BR9XQ96XyFsqV56j?=
 =?us-ascii?Q?hT9Xdxs+kT+oIsCh1+EJnX8uoG74d4pq/wKmIBHUb5QrEKHRwzPpujXYvyDq?=
 =?us-ascii?Q?BKN5L4UNfVufI35JVU8IwTHtNSo9OEOSSTHQXdQavjnI/ITaj69OvAY68Kn4?=
 =?us-ascii?Q?bYazoJ5Ddfv3GYXcReQ1MQBOUx1KEHsWCvengyotJP1YnsR+6A2hEIqO52Ks?=
 =?us-ascii?Q?+oTh1HlURU66dgS0EJVNjVCVezCItfh1RBNz6clOmpY8Xkj2Je41eov9dQEG?=
 =?us-ascii?Q?d/mrdoQP0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b611c84-c598-400a-bc51-08dec7e6d3b0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:25:34.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mCTRBHyy08GBFvlRXlBWz3b0CIHNDssE7KScUiYkEbi6oMILjiWOZjj+KPPiiBkbDX93Jru0UScZFco7UadFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579

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

