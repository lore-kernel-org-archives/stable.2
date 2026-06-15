Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507E3AE1BC;
	Mon, 15 Jun 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781550786; cv=fail; b=iT+ipKY+dTTMB/qXy/JKUvthEqPZACQ2dN/h1L3oRm7PAoz66n+k/qyfPpO9laR/nT8ChsnSTPmIQmpON04PoRj0+cD4LEmBMnCR7g3vY22DkbpnErzUCCcxQ6gEiwJGFGFIo8Y3ogwKskZ80j6kyvIz5D03qivPAlbwusGUwl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781550786; c=relaxed/simple;
	bh=7swQlmJxDLwpSYg03l6xkMUVLXgHESHjn4lZ8l2lPus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XI+39fh61WLHR6xuseZTHcamxPzooQfAHFKCD6+UdVtRk6oQFMOvD2GvyoCB6pVyRtKEg9dWSEZ46BEtsA2gVhBJnJIpCp6PFa6ujGrsxIrxrc7UWkj3lxGB3bZUjH9/CU6kIf6PUafBLFyT9iwFGfwgXmRQEj0qPQKuX3wY/mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SOcMbH2L; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SOcMbH2L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPm7v/umZg1WDMYJQzG3AV2McKrScJjPHSqxcLbQMPewUwUK8aPBEywjw0KNqMXPqdNRTjuEhGFVnBPwBtl+lvp8xprmUL+NlTynIUYAoZvnrMY/M+VOWigQSVjEugQZX4yN6KdG2F6/Qlu0puNrTJG7eIHs1PDd/BJLzQBg8j2Zoibg5K8WdByfSlR+Ak9A4/JQyXeMZVpiiDDlWquh6EhaglYtiQ/nXNEZOepNGAHJcxuXfS5jywoAUgfZM4oB1sFmRqDU0G1oRTxo6fSKyaIXbAomiybFFhtusi+Ivd2aiVFcqTv3Dta54+rJSpcrei9aNIed8onG8Bx9F80IDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDnfpP6kYhr/c2Ewta5YY15fPphea6UIxnRZvJOteuI=;
 b=x/H7r/29L5FG8l+pc3Lux8yog+WfPH0U7ZXJt2GbhxopkI1YwikvsLXyxpMiVdZ/KlvNnYI9Kw1SQ0v8DkK0im2Wgh5XgVqs40HadQiGyrTBXg41emn+mbFncq1uHR46TmmAmvuHWtUL4Ova9XGfrlaWD3D+1eAXFfEZf22Ix62VvxV2wnO6H0I6YJZ1QS3TdhtXApwhuQA336aDhTnFKovTojCzVXwznjqpr9b5346zzo1FP0TurFUkoqbXuLEiCikMVlO+Ofb/kPVKik4kcLqPKvvSx7mYHjOiuHbfvlpmuPHq5cJqfhG2itiWrGT4Pbs07ORhg7Bc1MkBacUy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDnfpP6kYhr/c2Ewta5YY15fPphea6UIxnRZvJOteuI=;
 b=SOcMbH2L5tnRWDV/tW3Sm8qhenfxCfxOiJUN5W4lyEpNYmBbj45EygWZ2ajk+fOxovVh9sB0Y+cOAQfABcR2sg2MD9sNxnR1QgDNBWVlHBe7F2HFx+fnhU+sFQW/zt4tkIGU9YPBcPFkPD8xOIL4Dboikr/ZYxfUXsyrIZ/Qb+32zcxzMfDKlYdBhVfUtutWrxoFNDmjUQYI+NNtifkP9tR08QCb4A06EX7xoiRKBEE2Yris8zxyZYobLnbyphPeL6q6Xr0umC4wz88vrg2hfeOsHW22zoK8fJBvRDrcX7wNx82xt1Fv8urOb//6gv3jU8A4l56kqbCCrlWdxHyHDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 19:12:57 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 19:12:57 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	kanie@linux.alibaba.com,
	stable@vger.kernel.org
Subject: [PATCH v3 1/6] vfio/pci: Latch disable_idle_d3 per device
Date: Mon, 15 Jun 2026 13:12:29 -0600
Message-ID: <20260615191241.688297-2-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: aeafa4d3-ee8d-4c81-7543-08decb121b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	jCUuJt1Gw2li1v69yKAanjGZ4MXd2SMsTQWe7b5tYXHSgZ3NDxIbui5Vird5Q/i1pUieepDz6xzwy/OItKsIcB0Mfcaw1ewyJgVMJK82y2R02N+NRbp0r+hXhJFXs3m7MuAwrPSUgTMZfVKUu58zhWfrUIczBlIS42P2iHYVGuonBCFLksB8YlZU38feZz3Obe4sU4DitRCpYX173SfvcHMIEwaafEp8UobTU6uSzqkvFep6sYB3QRfB64qxblm2djh76dfdysWBp06mtKvkXFpXfpLARD86Nl0DDVgBbUpiQi9EGVFowGk8HA/Nn+5lr6eHjlbzWI3Jg0xKnDogcCoyyHRkzj/PaLq8BuNMDi8ZioQt3jvoEYML2wztyNgnhSCfwACspUjuaiAxpV6ydTRf46/oI/7xvsXfedAVD7diTbK/4wGkN7MvWpv/J1BK6a9Bqt3l3JFlkgk0pI3DPxixRMxTZnSK/5NgW4YE5EMHIRMb3/Cxj71zDZoWwSG9UAKL+DOBddmq9BpcZRz2bkxfOxh/O+GgsCVcWBP0M+K6XYvUBgl5YRkKv+R5yd537hIcht1UDyjq4qQ+tsOHD5EfuNPsUtXYUpBRaTnNIMTpK2+NZeQWen4sOvWVhUCpIEaVqcHhFfG6BTZj9wutNGC1w9hEgYlaTQj5iKh2uoHrYYrvjiYXSd7bs6bzOCHx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40wO/M/F/dZZ/G5W0ILHiOJs4EmilKrX6SIGg1DrcZ3hDkCwAg5WwALpFwwD?=
 =?us-ascii?Q?qAonlVJ3xw97N3W3WqmFHxDh4uXEhuUUVdyhWyRk6GWrz7DPMNuXFssBn1JD?=
 =?us-ascii?Q?IJ8+iCzoGhqAdZRW3S+5s1z4VDWVBQpnZ8v7NPDQ9v2z8kJRB9hGIUo8yIG0?=
 =?us-ascii?Q?ve3enE/qWEIdswpfkUJOC22m07FfEC5Qbc6GP0HuiJN9b2ZZcVjgxubymwmP?=
 =?us-ascii?Q?K7JoM/V326gh3A7YVqq7gLSlFZhLCUKAuKzSSIZsIGdzM/3l7BPFV5ADNz8/?=
 =?us-ascii?Q?RP/mcfcEyF3WtB7jrpqSafsM5y4/M6mUmaIo3Okv2ilfNOsQopNyPwlsd170?=
 =?us-ascii?Q?5qh4h3apaJVrzyqGbEfQcSe0xyoV61JhZ9TL0QxdB3R6BAiyFjc9g0UcoZS9?=
 =?us-ascii?Q?UZxs/ttkH+5zG5kaJSCjnSHwN9DsrEBqyESMr2lkcDq+3eaKy50kUNETtAzN?=
 =?us-ascii?Q?rDR7TdLE7DC7IEvZqPeWtAcGImfwhw1cQKfH54UZaPlpxqo/BghGAuU2D1NH?=
 =?us-ascii?Q?Pzsrfp5oeBnF0TNXMTtpr57uEeXnAPY+t+kqN2lQg+Zn7HYfysRejoymNFpk?=
 =?us-ascii?Q?fKPhzfxqLaOoHVnFsnDx82Y9TKx3e5jvfVdMSR1JOzM0cExNFHLE9fwfl1XO?=
 =?us-ascii?Q?+nM+QsGOXteXTeL3n1NLA7QiTZupNk5Bzwvh/xQUNJOb3Hk2SdVYFUV2Ywgk?=
 =?us-ascii?Q?2ecdGXFfq0ej/sQyGcpxWHPO7ebqZ6NrHKS1PgwshPRuBQwbE+fWWa1g71ES?=
 =?us-ascii?Q?lb+kDjbqDesP2cE3DrlXhuaUl9Zz2RoXNX5jdfL2LZduev9OU7f/sarYMAOC?=
 =?us-ascii?Q?aQ56//ayAW29h7o58Fg+b7DKbKphvlQdfoNYgDJ81C6KbHTwRHoA7S4StwIZ?=
 =?us-ascii?Q?IdhZjk71vuYJpBWC46tgaO/pGh7Q+ZEjjedlbRWVo+OBffarMgydSG1jCRJk?=
 =?us-ascii?Q?BI9p34i5jUoPNdmKgNq4DcxD2OqwkgNEYdAvwY7Q807yGMR5neWlym/F9gsd?=
 =?us-ascii?Q?+sFoUKhJomH+SmN2FQMtf8BiajeF608qeVnV0zPdFmtFe+rZ46CFISemlrgv?=
 =?us-ascii?Q?QU9neFi7XdSmV2KhY134mtmjynwo/zqmDQK7nqnAtAYNfQI7TfonfwAea9mP?=
 =?us-ascii?Q?zbaGGEt1PkAZYnKxZFZDs8JHSA49MGDvryVoN1JIynVllwjj22lkhT6pZGvq?=
 =?us-ascii?Q?qRZKMgdMOm+J1jzkxSpAS6MK4R1Aqrxo7js8+IKaFoPuxM8rimiEWMcWIoSf?=
 =?us-ascii?Q?pyTAENvktJKMZhg30WOeO0XEIqSVy4D6dW4/Jfk49DhP9zI3G1Hzs9faq71U?=
 =?us-ascii?Q?BDDGhCgQNLqbdUsOiTpp83faRHCCslCM4NX3XVcISNnN1j6n/o/aPviGOBJC?=
 =?us-ascii?Q?+j8cJRhXbu3MWGxmTou6vZn1Wtz0aL7KeoaanF136svE42R6KxSFx1lFpQkH?=
 =?us-ascii?Q?ZIhFd/ATQS8d6mRdF4H64uJ05aBbVs6LuruQ5Pc/lIkFi4qee5TqJCv9g1Y+?=
 =?us-ascii?Q?LpWMV0bJph3a5VR33v/LUVVmzovK4J47N3sF5C4KmOenMi8gzyExKNTJcR80?=
 =?us-ascii?Q?Y28f17IKU1uV0g6vXQ90SaLcnc0aWqBOofyvCJhp120WJmnpfV9TtM9My3+L?=
 =?us-ascii?Q?jCfcm0h2tnWqMKuUfLz70XghyWMXUfuuMcp4DuNKt2jow7R3gTCqphB7t7Pg?=
 =?us-ascii?Q?Ot+wzQtzwoEmgb3L2vY3Bejrh71TKvQIzOxFalLG+M8pU/nmIcDd1vX35V5/?=
 =?us-ascii?Q?eVY4omBA5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeafa4d3-ee8d-4c81-7543-08decb121b9f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 19:12:56.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBMTZOcQQLC7DPgl66MMTeD/60WAel3a4gKqTHwwGwaAwDqBJNIwUptqzKO7KDj9b3yjDpxdaCM2CMEMX3PEow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775

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

NB. vfio_pci_dev_set_try_reset() now unconditionally raises the
runtime PM usage count around bus reset to account for disable_idle_d3
becoming a per-device rather than global flag.  When this flag is set,
the additional get/put pair is harmless and allows continued use of the
shared vfio_pci_dev_set_pm_runtime_get() helper.

Fixes: 7ab5e10eda02 ("vfio/pci: Move the unused device into low power state with runtime PM")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 ++++++++++---------
 include/linux/vfio_pci_core.h    |  1 +
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..f8d1755de2ce 100644
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
@@ -2599,7 +2601,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	 * state. Increment the usage count for all the devices in the dev_set
 	 * before reset and decrement the same after reset.
 	 */
-	if (!disable_idle_d3 && vfio_pci_dev_set_pm_runtime_get(dev_set))
+	if (vfio_pci_dev_set_pm_runtime_get(dev_set))
 		return;
 
 	if (!pci_reset_bus(pdev))
@@ -2609,8 +2611,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 		if (reset_done)
 			cur->needs_reset = false;
 
-		if (!disable_idle_d3)
-			pm_runtime_put(&cur->pdev->dev);
+		pm_runtime_put(&cur->pdev->dev);
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

