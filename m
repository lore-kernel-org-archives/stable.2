Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569313D525E;
	Tue, 16 Jun 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632897; cv=fail; b=jKRw0nLngazxE6vJuj9TDeccRGBE5ieAsTzRvnU4T36Kr+tkDlxzaqnjlVIffVbV5x3Qu/Wk0lc3xWJkmPOVnliO2jrcIrgcH+GzKq4sASFBt4v+dhGxR9ZUT17WV3padTi26v2Xx54P1OQNUcLxwrb4rLcPbj942JF+zftbKIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632897; c=relaxed/simple;
	bh=h4JZp6cbAH0YObXePmyfBKKRjeOJtaIwI6VULW9z32E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l7VUvxr+gV+mG9ww5dC1F07ZI1Fgm+ec7ghrb+4pmTtyrELP1eIjEXoClrzIyTDm3slFsWtlpDYnzWD0YAYyibwhzQoK0CYn2L4b7JKSvnEIitK7oDNM17Qsawdbs5kPQt/nZtbnQE/pDhVSjhFNMrKqudIXYojx4ZaHTwuTSc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=gKxyzKO3; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="gKxyzKO3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIjywIemDMxiPQarjUUwOfQA/QL7dJBZk/TBx/IxZvDXBWnKHhHhyiCPeM9QVIfv1M9uPQOd8cJNw7T3ytuV9bBOVcEneId/FAKmuoiIOPrMXKBUnDX53rvHV6Eoz+h/dxI4lmlI1c2iRPscA64gVmNY8szJcbvgKZofdxFc8A/yX/nhAHpd1l4ZQirOZydq73ot7QtFzSve4ynZ/Ha36jlCZWX33kyPcfGKu/XJD9Bakcsy/DV7Ccy92rZQ4+5htEypUGliV0uAx+xIa7phalZu6G4+UyYCLeeXsAYYegVUdrFjt1oYlUqsFpXG5UCHH7WebIanAf3XutQlNPryOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBu0ZPDJBy0+2mu5zx2KdQS7SPIs5BXd6weq4EcvdiY=;
 b=chFeN0R28qSUoYKpWXvBMxQh09yv5/KJtBf2Ent13rV9Xqw7HLFfz7ZP5tpnKjAnC2AjxEG5M3dCHk6LQFwF/KwFhWphR1lrLGl7RuTdiqN7ug/7PdBliAYSVxcw7REOmk2UprrslwtvGZtIKEFOTFDqPBspvUZDa818Z4MNB6ePaVduB4mxerDOPEnE5crWYWOdKC3X9+WSGlXSaDIAVZa1YS18YYegrEN5f+roJzex9tDvwDw1BwO/y77XACVL+D5NWlkhj7lZwcsjavNnTZwuO0rCK9ZDGrCfuMkWm8WBPD6G4hKgOGk4f6KFiQVgiLt1gqEK/oSPWjk6cCcirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBu0ZPDJBy0+2mu5zx2KdQS7SPIs5BXd6weq4EcvdiY=;
 b=gKxyzKO3jgcdaInGQosIxBi/YtA69ReeX0wd/YazaGOqhfc8WRyRKlg/rNa3cjFlTG7nqNvnvFRTFVxoAi0H2RScFJK+UUCHqhH+drgrXBl5vBB9269c6saOiG/QrSlY4PJdQQzEoC6wJIZP4V1+4DODg1X75K/pWpo9fC21LZ4j7gOxj2uoitW0vOtju48ekgakkIC3xMPjhaaX8YmZyykR1jIwRFsC2BGfkFf1pcBrdwv+5YWfEsX8JjFVfU8qe3zZPudJ8w9be5Rv96C8qlEC4Ec8uz4W8KjEsORbFvmaYWMqKJakWu4+pdLWb9LtBITzZNsdRhySFAs9hbFPsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by BY5PR08MB6181.namprd08.prod.outlook.com (2603:10b6:a03:1e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 18:01:32 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::4dd1:e1e:56b0:b178%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 18:01:32 +0000
From: Anthony Pighin <anthony.pighin@nokia.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	kvm@vger.kernel.org
Subject: [PATCH] vfio: Request THP-aligned mmap for device fds
Date: Tue, 16 Jun 2026 14:01:29 -0400
Message-ID: <20260616180129.160016-1-anthony.pighin@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:610:5b::19) To BN0PR08MB6951.namprd08.prod.outlook.com
 (2603:10b6:408:128::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR08MB6951:EE_|BY5PR08MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: bac2d303-d1ff-4db9-ec37-08decbd14c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ruTqh3ZBA282f1YBCBHB7V8Q1bq0m5StysBBKl2gr4zesuakno0PKtR1VsmX0vGIDjqXbyz/Xsk1WK4vFKhWs4hF6+f1/Pe44W+3RPPwxIAthnjX0pk/xpI1ZUBQ/hWZYgndn4HE5sfMacz1InT0BA4hzJJfHMkMrNmwt0xC1W0G823rKE079QEmraZO0vUXIKBB5Hlcaws7tJ2qHFwRptq3hEi29UqrdrjSY7HA97cqN2bhb5rOnmkbDW0pwDzokiqp18MvzyO06ZuhErcnD6IHPrt8GTwzsqfP0AvuWP/E4Tl3s+VPffvrk7lVHVOmx41zLoYZ4mkXh1JvCFTpKZHUD7lKoFackz4MjfUNh7L2R5En6g3AQWjZSz4GCvCD8F/6mStspJ2Q65Ma0ZS9M+KtARnLzXSV0+EMKjV6PLXU3DmW9A6T7qkjptBn5/XSeUHMcjxou3oK7+60mymkbnDkDEhrV3S5BKz9vMsMOv5496LxbtU1pybYhq0GDWjz2TkUD10P8kihGIHMyd/vikP1Xve7g9eK8NyEPK2njgiX1z+ZPaV2YHAJHihgXsO2JxShu5W/+S4SeGe5mhKipM5Mk0akDJGR0k/PAlzjmS63hvuEmPRHMBl06pwhO3r7EJVb4IhI+bZZ1oG7JjNR7w0pUm63ekZXTdcoV3vuLjO4rkap+UhWtLuThGdH7xyq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR08MB6951.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?en3XM9jzVcNQ4QFumZzthfaKAGB1+Y57+Op0LG0QuLBzK8l0SKH4yDVzcEsv?=
 =?us-ascii?Q?N3as2dNkNe6l8p5E3qL8jtiKNT65VaZVLdPGG2EqubruY019v2/mxYFtg8D0?=
 =?us-ascii?Q?d5qlbjTlyF+Z68aEGrsE5icWc1QivBEEH+7H3l+QH1JMOrR3NxvcBOrftK57?=
 =?us-ascii?Q?kiCTqXtOBgZk7MT9Vln2FmQuWC+yZVeWOUMEWq6j+Kf+LU+kSataGwH/eTyF?=
 =?us-ascii?Q?+lL7GYvErKcm1GXOcIqOW22Ib/MJYfcZnv6Fm3patamNiBSU0N5IETkn52cS?=
 =?us-ascii?Q?uAj2e78EIpcKX2Zm7Fu0DYPN86yHSFwb+x7Wv7QsTTxVxIqcZDzo6p0QGhSX?=
 =?us-ascii?Q?bSuJGHrOAf7qDEYaByXinkR2WazU9860GoEsu9U227vohZMbWbKnlwbzNOF2?=
 =?us-ascii?Q?mU4hID8L7Rft671f1Y4RWhdr4D2af2/awGXYG6JXBkVHu7pF5U2UGjUe642G?=
 =?us-ascii?Q?CZNQo/vzzQfJCsCivvoEAt6/emthnM1Y7bDyKMMyNwv4VlHXjuQv4qp8RXqB?=
 =?us-ascii?Q?+nSWsHJbTIpP746eVn8Yr/FgVAbNvzX4EC660E4le7mJDkfst18BjTU3NSZU?=
 =?us-ascii?Q?ZBWgYDfZpzpCIQn+z/lLVYlUqOUGGNrthqigl4oLTd/lK0zW1zvUiODwlI19?=
 =?us-ascii?Q?9uJIJTLy3mvLjU9KHsnP0lHHuyQiaGyXoIKqdotYe1W+uj4LplsEju5paQ89?=
 =?us-ascii?Q?yyQPd2vvnqOkzenrtTIIeElJQVmMxi5Z9Jfl+7ShladlFVQ6UGtR8WmrwiYZ?=
 =?us-ascii?Q?hcofHAwStAlljhaPBBn4h+ErS2xyoKtFr3O2X+LTk8EFGItYyvuhk6NIy3cu?=
 =?us-ascii?Q?AzVHp5Nl2rrT2DRUiLDnpsuE+3EKIxMfutndEt8sjsTRYraa2HTaUieyfUvK?=
 =?us-ascii?Q?cfnGId7lJRzXlRDZar5frRmbruuUN/7HU1l1e3uZOxuGLLDl5ht3ctfDnbqy?=
 =?us-ascii?Q?jaccRAKV8pmRa2i1dx8sde06SqMz71ojUuOe6IFJEKQec/2V4uBc4uNVEpe8?=
 =?us-ascii?Q?3RwjuSJQ4zJ6A5r9axB6U35Y0PDKmcu7vJfn7PsHuFgpbXvkBZVda9gIwAlQ?=
 =?us-ascii?Q?BHRMJKL3ww2sHMlh+pMrbi9Vtgxw/mn4xGA//Y44OcwJlmBVCd1gWirx31gy?=
 =?us-ascii?Q?PwWgEomv4Y0q7+VZAyL1rDTaTQ2v5MLH2J3xIjemoytd4I7Yy48FvG4brmvi?=
 =?us-ascii?Q?JpTtQ6yR7A+0jPDzv59pvVecQp8+0vMt2VH6t4jqHNL65RqSCP/oFGoPebjZ?=
 =?us-ascii?Q?XvgzS8GxGXHy2nhO/g+nSQGxRoQlSH6P97D+wwvOPXn8O+6H5F/oi+CxrAHo?=
 =?us-ascii?Q?YGAeqy9fsAIwhqAd08VnidMjHOd1ZzscDYHKtcQ+dDlT/EmGXtJoOiVhjY8T?=
 =?us-ascii?Q?SzPPzftCEewKlfwP4DdMI0IIYEOdgD2U0CHA5B/RSV05in+M/pMChaQr3DwT?=
 =?us-ascii?Q?eIxJr0WGxZiTADx+/RWZ0yErE9GcTt0Gs9d6KBN9WxVc1Ra1R5ZVYO0pWp5H?=
 =?us-ascii?Q?X7GDzWFWESLVNZsmRkBGUBEh45tUpBLMlkDKevZrgu/BfZfVd302maxbgxiT?=
 =?us-ascii?Q?Q8FQ+RlvmF2BSPJw7gj3yurX6jrUb29VRfYx1IRqnWT1eqABkd0jcdfBcCNL?=
 =?us-ascii?Q?JbuyHV0cnw1hPk/7c5efZYe/65GyVPxmlIFFLYgstbTliTTYgdEa3MJHFvP0?=
 =?us-ascii?Q?D7tz0JLOnAaJ3hPMKErU0yvpHWBjTrXAhiET1B/cWOHz9rcYQb8P6wpoEK74?=
 =?us-ascii?Q?H60o2kvW2Q=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac2d303-d1ff-4db9-ec37-08decbd14c41
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 18:01:32.3267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21fJy2LJvKUiK7KwwUPaXZwEZVUxu7Kt4onSSfuNMFLuIJUyitH+BDjlQ5IDGhOQ//obFH/e5QhWGytRQ48nARMWXzv7puBXH9vvd29w9M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR08MB6181

VFIO PCI devices support PMD-sized page table entries for BAR mappings
via their huge_fault handler (vfio_pci_mmap_huge_fault).  However, the
VFIO device file_operations never provided a get_unmapped_area callback
to request PMD-aligned virtual address placement from the mmap address
allocator.

Before commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
get_unmapped_area"), this was masked by a bug introduced in commit
ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") which
inadvertently applied THP alignment to all file-backed mappings,
regardless of whether they provided a get_unmapped_area callback.

When commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
get_unmapped_area") correctly restricted THP alignment to anonymous
mappings and files that explicitly opt in via get_unmapped_area, VFIO BAR
mappings lost their PMD-aligned placement.  Since the huge_fault handler
requires both the VMA start address and the physical PFN to be
PMD-aligned, unaligned VMAs force a fallback to 4KB page faults.

For example, a 2GiB BAR results in 524,288 individual page faults
instead of 1,024 PMD-sized faults, increasing the VFIO_IOMMU_MAP_DMA
pinning time by orders of magnitude -- a regression directly visible to
KVM guests during PCI device initialization.

Fix this by providing a get_unmapped_area callback in vfio_device_fops,
following the same pattern used by ext4, xfs, btrfs, fuse, and other
subsystems that benefit from THP-aligned placement.

Fixes: 34d7cf637c43 ("mm: don't try THP alignment for FS without get_unmapped_area")
Cc: stable@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/vfio/vfio_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab..2dbb1a84dbac 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -40,6 +40,7 @@
 #include <linux/interval_tree.h>
 #include <linux/iova_bitmap.h>
 #include <linux/iommufd.h>
+#include <linux/huge_mm.h>
 #include "vfio.h"
 
 #define DRIVER_VERSION	"0.3"
@@ -1461,6 +1462,7 @@ const struct file_operations vfio_device_fops = {
 	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.mmap		= vfio_device_fops_mmap,
+	.get_unmapped_area = thp_get_unmapped_area,
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= vfio_device_show_fdinfo,
 #endif
-- 
2.43.0

