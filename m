Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAE2DA759;
	Wed, 19 Aug 2026 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135540; cv=fail; b=dOoe8oUr+HTHsshLhyYgqfHaHq0QG19m2DtFrROTs6H7cGKPw8T3zqalzYAebGkttjag4jEOgC4V4J+zBQZyjZo2GlXcf6tPADzTANT7ARK8SpjzKLy2Hj/+c7SbFPqzc4+/bhpcz2bBMTVlPI0rNbatdQjzNvtsrp50xJg1zao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135540; c=relaxed/simple;
	bh=5DZbeeJE2wRbcfujEb8HHry+1+M0ZtSu8csvGtJkHEg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMQ/eh+ILqk2eC+sHruCaoQqv7vqukrtloGIPBvkrJYsVo3VLDlqBswUoE50MNHPdP+yw7OjgMFt9DzCbUGjfN/avS35NXCRMbmRQ5kTlVimW1I3+Byqephn93RdzO90/hSJ46iNbLJZMlRTJVbqnHko6WL5DSkXSF5aXGrGY0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gpdlhspb; arc=fail smtp.client-ip=52.101.53.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gpdlhspb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj3YPRnOuBWW/3+yIBocBsfI0mRFpeqT2eomxd2jKKlj2qktvVjRi6Q63CI5KbJxgq0JUOeb5UgWGeHd41RLjoQnNEhZH1tlMOoM8ERTu0Fm6Jg8XocmRV3AOnZ7ieMnP6swy0aM7S0QBg7PE60Wppo6Z4MGV9XniHZQ/wQlEo3RkrgFj8HYaB17veS7QoLkJkTRZ5lWZOjN7ezN1F6g6WzL5HfFRfTpIKwSXxs/lWPyVXbYyKj+zl+/l25Ej93k9QJDqepw1YXQRy5eCokxzoxlzsBm6TEnJ66AfrKEVErEz/9vnRGBTHKvh3A/S9jYNEP+uaB7gQgzjSymGOylbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPgA7wOvgIpkxGtWEVx1yVdPKnWoeqDH7j/ejtfKObY=;
 b=I6V1yMZFdemZ56Q9do27rZsJom9Z+nJhY8PVFlddGFKsu3IJ6Kg/5c/rhy+XdX4xvwTwXjhGxUWRotnFGz0FQnLYut0oujWG5CsMKlsdYsTch2ywlByAap7SBGz4yW40ibOS3KnVzv4Hkvp+Cm1SENC0dIupK2JF7BC5n17Pjt/nsGWCQA86wHMKZB2e8DmKj8Rh9UK04/gQzyS3qzSqQKHLiV+x7TfyyLZdmKHk3gtD02x97vZJIljBfKLgn3Tc+gnjXdNqB5Ww09wS8cOpx3SQ2k0umjDOFAIonHI4SVWa/t/0Zsfgsm0ffEUger/Tdx3JX2uymKs7zyQfDKwVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPgA7wOvgIpkxGtWEVx1yVdPKnWoeqDH7j/ejtfKObY=;
 b=gpdlhspbRz0eVe2ppEjCSW4k1YZ3fgFo6xAxbVo9bxeazgTtTEwn9S3xk/HnSLjmP3LhHsLG1S0d8Q+6juZtJCFvCe66vtYEYqY12CVfDmllq8JsjyFSAuPl7Tpl4SLvshHmY5lKgcQDlCV2OhTXERNyu5mTRf9WA6N6RVTvuNw=
Received: from MW4PR03CA0274.namprd03.prod.outlook.com (2603:10b6:303:b5::9)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:32:12 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::2f) by MW4PR03CA0274.outlook.office365.com
 (2603:10b6:303:b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 10:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:32:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:32:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:32:10 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 05:32:07 -0500
Date: Wed, 19 Aug 2026 10:32:00 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Rong Zhang <i@rong.moe>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<jroedel@suse.de>, Huang Rui <ray.huang@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/2] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Message-ID: <zm24u35jq6ruz5teu6sevoe447esrqim3gn24s4bdb7kvncz6z@rmhomnfqzwht>
References: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdd26e8-1644-425c-bb72-08defddd20cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|56012099006|6133799003|5023799004|11063799006|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	YNQpqIaiSTaPc2iDtMpTdet8CKkZbt4ZGVixNf//0WhqWN4OeACgGmZ8L6rAdWi32sgSGYg3GUdlYNr2Y/k1UzKEbisttFoLGXIAwOjNFnCK+cxbCZM/Arst1NwC5Vh5RJtVx/1GtNHb7ZoVNkEsv7jCMMyurchkNw34pJSCexHn6IBL9yN5oAKayvnOT+Pa4gSl3MAYZ17aRk8tICM3AskgzOtWm13dXfEiJQYE697g80T4n7kxUR9+GK9w6S51Spg61yJBjZT9qmcodwX/Sh2MPPFqkCN1LFoP/zENd7J+Wa5ToiiI75sUczY5H7bymTb97ha1p0Xphp9CFtP0kI5HliTorV1gU3tzYls1ZpaYTkpZ3tGybF47oGmMncXPnkf24dNFP0KaZ4oUvGCLeu9c2yQ64bYoEhLHjZ5Qfa41LhuVgVZwOL5IfJ7veWKzzAc8hvvVjRhiO87q6SU8pGLA5oiT4lLnFNXMxJ/dFz0HS4ufrFpJgKSt/66/sTiAJ83dtnELYIe0Kom0hLBT3eiHwFRs+Q+ArHG0hDVMcAWIoSTszUF3GbL4MY2+UdFBTDNOF5HC0Wyf0t/VTrW4eZKL3RiDG7Kazab0PcuyVDJaHqno1k9YqP5s776NjS+yoiB+RkHde7KGsdOwYGxyyA0nAYQs/jJvaTa4SVaJwN+mw7qhuzAqpkA4s/WZ2pFAlfQkD1HSwE5pOLI7W64l5lQWmfM65ZDwVABeYHeP8ai59JVd0m5mlbUDL+Brih+6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(56012099006)(6133799003)(5023799004)(11063799006)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n5dXDx2nsPFr01FTanzvlNmarSObxxYkhnTrPH4mQCjKkKN8VoZ1C0gSQgtAuJ1d50epEJm2wh74CfYjVILr6uemO0fPzdNuVCI04g3spfPkJn27FcSm//o0Iw/GNNKrMUsvKwT2ZLLT6qN7djg/ymUBgoYE16k7xekukklTUt3xOQuUFDjT+LwAFfSqp88JEBJxOToMUQGM34NhPaPRndBlxD7xLMsLdD6PpEsCxkMsAAbBUl7p6NmWJ9S9ymaosvJsIN9qw2L1qmUA4sTeIyPCb7KCEPs3lH7ifp1WnvgAvhJ8Mo364t7f7xc+fFeQuMruGeEg4Zzt4s4KhT70dL1y74mJkC0Dbi8nFjKXX+L6ryHVeHwiZjpIG2DiR2W22fVMncLZnDhOKfRpJeZSka/fd0USyl+jJLiLsX22gvtDfzE1aNXgzULm8z5q6B4F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:32:11.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdd26e8-1644-425c-bb72-08defddd20cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

On Tue, Aug 11, 2026 at 04:36:17AM +0800, Rong Zhang wrote:
> The AMD IOMMU Initialization State Machine has the following state
> transition diagram (only the very first states are showed, and the
> `IOMMU_' prefix is omitted):
> 
>    START_STATE
>         |
>         v
> [0] detect_ivrs() --> NOT_FOUND
>         | ok
>         v
>   IVRS_DETECTED
>         |
>         v
> [1] amd_iommu_disabled? (amd_iommu=off) --> IOMMU_CMDLINE_DISABLED
>         | no
>         v
> [2] early_amd_iommu_init()
>         |
>         +-- [3] amd_iommu_detected? (!iommu=off && ...) -+
>         | yes                                            |   
>         +-- ... --> IOMMU_INIT_ERROR <-------------------+
>         | ok
>         v
> IOMMU_ACPI_FINISHED
>         |
>         v
>        ...
> 
> [0] always calls pci_request_acs() as long as there's a valid IVRS table
> and no Stoney Ridge graphics. This is not optimal as ACS is not required
> in an [amd_]iommu=off boot.
> 
> In a normal boot, ACS is requested due to amd_iommu_detect() requesting
> IVRS_DETECTED.
> 
>     pci_request_acs+0x9/0x18
>     iommu_go_to_state+0x106/0x1a20
>     amd_iommu_detect+0x1c/0x50
>     pci_iommu_alloc+0x26/0x40
>     mm_core_init+0xa/0x120
>     start_kernel+0x527/0x7a0
>     x86_64_start_reservations+0x24/0x30
>     x86_64_start_kernel+0xd1/0xe0
>     common_startup_64+0x13e/0x158
> 
> This is intended to ensure ACS is requested before the PCI core
> initialization, or else a !CONFIG_IRQ_REMAP, nointremap or intremap=off
> boot would be broken.
> 
> However, in an amd_iommu=off boot, the state machine still requests ACS
> at the exact same time, as amd_iommu_detect() has nothing to do with
> amd_iommu_disabled.
> 
> Even worse, in an iommu=off boot, though amd_iommu_detect() bails out
> early, ACS is still requested due to amd_iommu_prepare() requesting
> IOMMU_ACPI_FINISHED, which is called by irq_remapping_prepare() thanks
> to CONFIG_X86_LOCAL_APIC (always set on X86_64) and CONFIG_IRQ_REMAP
> (enabled by defconfig), unless nointremap or intremap=off is also passed
> to cmdline.
> 
>     pci_request_acs+0x9/0x18
>     iommu_go_to_state+0x106/0x1a20
>     amd_iommu_prepare+0x15/0x40
>     irq_remapping_prepare+0x43/0x60
>     enable_IR_x2apic+0x22/0x190
>     x86_64_probe_apic+0xa/0x50
>     apic_intr_mode_init+0x70/0xd0
>     x86_late_time_init+0x28/0x40
>     start_kernel+0x6f9/0x7a0
>     ...
> 
> In both cases, [2] is still gated due to the [1] or [3] check, so that
> IOMMU can be disabled per cmdline.
> 
> Technically, it makes no sense to detect IVRS at all in an
> [amd_]iommu=off boot or if IOMMU is not supported due to platform
> settings. This is probably why amd_iommu_detect() bails out before
> requesting IVRS_DETECTED. Apparently only bailing out there is not
> sufficient, and the bailing-out paths should really have been parts of
> the state machine.
> 
> Fix it by moving the bailing-out paths and [1] to the right place in the
> state machine (i.e., before [0]), and always requesting IVRS_DETECTED in
> amd_iommu_detect() to initialize the state machine early and properly.
> This doesn't change the IOMMU initialization/failure sequence since
> commit 9f81ca8d1fd6 ("iommu/amd: Don't call early_amd_iommu_init() when
> AMD IOMMU is disabled").
> 
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Rong Zhang (2):
>       iommu/amd: Do not request ACS when IOMMU is not going to be initialized
>       iommu/amd: Remove ad-hoc checks that are never true

Hi,

Thanks for the cleanup, and the analysis of the ACS call paths matches what I see.
Two things worth a look before this goes in.

1. Patch 2: I don't think the !amd_iommu_detected check in
   early_amd_iommu_init() is unreachable. pci_iommu_alloc() returns early for
   xen_pv_domain() before calling amd_iommu_detect(), but Xen PV still sets

	x86_init.irqs.intr_mode_init = x86_64_probe_apic;

   so x86_64_probe_apic() -> enable_IR_x2apic() -> irq_remapping_prepare() ->
   amd_iommu_prepare() enters the state machine anyway, and none of the new
   IOMMU_START_STATE conditions are true. That check looks like
   the only thing currently stopping early_amd_iommu_init() from running
   there. Could you double-check that case before dropping it?

2. Patch 1 Fixes: 9f81ca8d1fd6 doesn't look right - it only moved the
   amd_iommu_disabled check ahead of early_amd_iommu_init() and left
   IOMMU_START_STATE and detect_ivrs() alone, so ACS was requested with
   amd_iommu=off both before and after it. The commit that actually put
   pci_request_acs() on the detect path is 1adb7d31b051 ("iommu/amd: Fix
   pci_request_acs() call-place"). I'd drop Fixes: and Cc: stable and post
   this as a cleanup.

-Ankit

> 
>  drivers/iommu/amd/init.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> ---
> base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
> 
> Thanks,
> Rong
> 
