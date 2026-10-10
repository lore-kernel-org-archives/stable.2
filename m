Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EF22F851;
	Sat, 10 Oct 2026 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609997; cv=fail; b=DO3dVIcsYExUd5CnA1ZGF3UcSetsGwIItBV+CCbcOIPFkGuWrcCYFoLViOPEoSQusH2hqlu7Tve1A6CfyLBo8kHEcb2ElpSjLLkVE89gDsnTPNSAz5orPKdZ4GC4qPxLVLk62WLWetFdW0UpnupZ86G/LdIz823qaHJRWds1N6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609997; c=relaxed/simple;
	bh=59u5uZwY1u9B6n+kK0Rad+9gby4mGqUbp6Dr2FKrR2c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTsdGg4W67IKHt18MFwD0RZBIdktHeTY2R6CEwogymz4xTxzSnyeP1hxrwn2T2z0owqr40naYptUjto2cSWLYGuHD+/sMAtcFoWXf/a2cA10kQyGmMVojOTZPdya+LLib9iDNj5RHDEYW6GQYK77s50b7u0dOelvXlqv2zgIfDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1RdKOpDI; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1RdKOpDI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKUQSWcS2NtW59H5DrxaLRz1OTub1KjKyqMvhFNccoOWWyCYRw3RTztIrjgwEdwDS9NiABRZ55CxvDUSC8K7NwediiyHs5pwTAs7bqTsQvJleysdi5Mtz7NoNS0CLgOqI4eZ/w2LxhPwROQvIzi1EqdgThgwlfqPjBagZgDdYZaMaG6t0DXAnYcM/KikU3OgyP6ANu22wT7WQQqhZesfZv6DMln7IxWfEGQQ5kSDup8VxYVWx6cxrSWhLY0LAlvbWLcAkoPrcuzok16w7Yi/fFHSrmNb+mDjdL6bfI4JMbbDB4DPjwgGaTqkrAfRPNR+weiUFQ3hDgtQR1+qMGiTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzR4LGR/2DFyjmp/R2SdUuvCgFZGXgKVsyYeA252xSU=;
 b=YJghUJDIIWLTb4SxocNHHwf89MXJakLmhE6d3scpkizLtaCJfL9HNch619uKldZ08JG49aCnRwmly4958p7YY3d8vd5jmrAYnCeSl+8Vibwnrb9hEou6v3zUEOAeahVg2D496PKlU9dx3ez6ao/2Jic12+ZVN3hTrGzV+fEE7UOOfyiw7MiYt0zdLtURqTY6w7s89Cuf4td0Xx19Fn31YujICAGVwkmFwnsa7vU0fz1ze2hLqFPF+sOd4oKFxsQgNYjazKb1gk7ex83laYLhOc5xBv/FzxFTRYnHJZ5erxp5Npva6tUCwecrM/tX02vPucmPxyqKS1cF8KoN/Znr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=readmodwrite.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzR4LGR/2DFyjmp/R2SdUuvCgFZGXgKVsyYeA252xSU=;
 b=1RdKOpDIVxc75+f9xg1F7jGC/IIiOBrOe+ep1qmL0SXba9ugZnAh4B+UTmeqJz7WDyTsb7iT4ETGutbdKGeLS7aHxnD+bT69i0T7QWQihyA3r+rKsqWPL4Qfpu9r5bZnL0he3HNzxPlJgQsGD7U9p81OhgUf2c/DGbyBz2YkT7k=
Received: from PH7P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::33)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Sat, 10 Oct
 2026 05:26:29 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::68) by PH7P220CA0033.outlook.office365.com
 (2603:10b6:510:32b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Sat, 10
 Oct 2026 05:26:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 05:26:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 10 Oct
 2026 00:26:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sat, 10 Oct
 2026 00:26:21 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sat, 10 Oct 2026 00:26:17 -0500
Date: Sat, 10 Oct 2026 05:26:17 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Matt Fleming <matt@readmodwrite.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, "Vasant
 Hegde" <vasant.hegde@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, Baoquan He
	<bhe@redhat.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <kernel-team@cloudflare.com>, Matt Fleming
	<mfleming@cloudflare.com>
Subject: Re: [PATCH 2/2] iommu/amd: Don't allocate kdump device table from
 DMA32
Message-ID: <4cxbso3j66cxafday3dffmmapikath2cd4gvstji4tr4agjl2q@unox7kfyl5m3>
References: <20261002133143.3628181-1-matt@readmodwrite.com>
 <20261002133143.3628181-3-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261002133143.3628181-3-matt@readmodwrite.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1e63ce-d356-4e65-a930-08df268f0910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lBzz+kcLwXnU731LRr/tqkJMCpNUYctVZmGk1SnqUS+MWDNdi8SEXZLRXkamjU7fzVcdg7UKMKzDDXAOGwtn147731PtrfEafHIBhkmbSvZCE003Bn0P849cYF0/nTsEghDdHDvI+P9OBFm8cstlFoxS2t1O2kzG0nBLd09VN0GIbgTy1FveOWYDLEY3m+rCrgEZ5EAUF7Toc0ROW7Ih7hAlKt2QA84FqNMu23LZz0RiL0sG9hgbXqGLqhJatKCPgAiNH2ZdM6G6FHEvHVTKQ93XFsrE5652dOZOizvQnNOpoc0MADtCoa8Jey5566uxeq8+pW1qmHsF2g7ZHVKSQHgjWKNt03ab7GVnIEcoAixon3lIokLKmbyWx3maJuBFJNH4b/nG67eOk9Pp7WoYySuLEU6N3fgud7CtzTuE6ijPcIsuCer/YM5Cc6BQTUsY//RH/Oe+7j8YQTQY697yT3oxaXjznSSmtG9mKB9eb1fv2sDVy99XeDt/0nUzynnID0CLpOryv1DmZ9USOWULPM86jT3vS8Ugs23j85ou0mskxwyFRiIXY7BpjxQEvF1paraJI2RN1gtA6qk0BYuuUALPvwssuOirUuOqbGSVDGTgtiUDBAHqUTGykHY0meBrGhrfaT5Ir6nyFdrIoJK0kjXDuumtRoQgea+X0xrWlUPFp+9s+w3JufdF1J1QaWSzgzN6J2VCaBx+RnP2VTFqSw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X2etN/3xm8+01iS01pyS0m3j7J/QgjtDA+WzC1R0Z/5V+gQnFcrOxP1s/xdsLWU8c2UlUbnAt8Uh9XtMeAlG78pSUYbvhofkdFqYNGJvHcCJU5H5abl1pZPL8PjRonjUdc1I2HR81MTszaQjW8ayqbKodky8SvM7GD9MW6e9bqeaniSnSJb6ohd9Vyxh3O+4J/RC3wfuM3Qcpj27imNhhb2ypS83Mu4swmjHreMp+jocIq3VhiFMxjxI0TQKB0fDArTA+iYOpNZX75LXg9xRN57cQugETUiKilPVxW+WcSg28k8SFkhawase1q0Zby0XgSnn6aaCHB52HT5nVeJIxMYtnzVg3l/zV6+5ZyJsRgVMjHHRs1dv24JfrPA6lLSHOMKiixexqRd6D2ZaMWY2Pdkwb6kb+HHoKmlCVMueY10+LnTY9cH0DOz3XgtqvnU2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 05:26:28.2912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1e63ce-d356-4e65-a930-08df268f0910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

On Fri, Oct 02, 2026 at 02:31:43PM +0100, Matt Fleming wrote:
> From: Matt Fleming <mfleming@cloudflare.com>
> 
> Booting a kdump kernel with crashkernel=X,high crashkernel=0,low on an
> AMD system fails the per-segment device table allocation because there
> is no memory below 4G:
> 
>   swapper/0: page allocation failure: order:9, mode:0x40104(GFP_DMA32|__GFP_ZERO|__GFP_COMP)
>   iommu_alloc_pages_node_sz+0x7f/0x150
>   alloc_pci_segment+0x4bd/0x650
>   iommu_go_to_state+0x213d/0x34e0
>   amd_iommu_prepare+0x39/0xa0
>   irq_remapping_prepare+0x83/0xd0
>   enable_IR_x2apic+0x61/0x370
> 
> On our E810 systems, the kdump kernel booted but ice MSI-X interrupts
> never fired and the TX queues timed out.
> 
> Commit b336781b82cc ("iommu/amd: Allocate memory below 4G for dev table
> if translation pre-enabled") allocated device tables below 4G. At the
> time, the kdump kernel programmed a copy of the old table into the base
> register with the IOMMU still enabled. Keeping the table below 4G means
> it doesn't matter that the hardware splits that write into two 32-bit
> halves.
> 
> Since commit 38e5f33ee359 ("iommu/amd: Reuse device table for kdump")
> the kdump kernel reuses the previous kernel's table without writing the
> base register, so its newly allocated table is discarded when reuse
> succeeds. If reuse fails, the previous patch programs the new table only
> after disabling the IOMMU. Either way, the kdump kernel's table doesn't
> need to be below 4G.
> 
> The previous kernel still allocates its table from DMA32, so the kdump
> kernel's check that the old table is below 4G still works. Drop
> GFP_DMA32 for kdump kernels only.
> 

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>  drivers/iommu/amd/init.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 0572e1a674f0..16c26d75f46f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -648,8 +648,19 @@ static int __init find_last_devid_acpi(struct acpi_table_header *table, u16 pci_
>  /* Allocate per PCI segment device table */
>  static inline int __init alloc_dev_table(struct amd_iommu_pci_seg *pci_seg)
>  {
> -	pci_seg->dev_table = iommu_alloc_pages_sz(GFP_KERNEL | GFP_DMA32,
> -						  pci_seg->dev_table_size);
> +	gfp_t gfp = GFP_KERNEL;
> +
> +	/*
> +	 * Keep normal kernel device tables below 4G because a later kdump
> +	 * kernel only trusts and reuses old tables below that limit. A kdump
> +	 * kernel's new table is either discarded when reuse succeeds or
> +	 * programmed after the IOMMU is disabled, so the table does not
> +	 * need DMA32 memory (which the crashkernel may not have).
> +	 */
> +	if (!is_kdump_kernel())
> +		gfp |= GFP_DMA32;
> +
> +	pci_seg->dev_table = iommu_alloc_pages_sz(gfp, pci_seg->dev_table_size);
>  	if (!pci_seg->dev_table)
>  		return -ENOMEM;
>  
> -- 
> 2.43.0
> 
