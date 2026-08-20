Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE73803E1;
	Thu, 20 Aug 2026 05:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787204958; cv=fail; b=G5Ap8ZTEr66vNCx3LlLcqOJpN/Lg3Ly+XAJuLpzgf4qQMVTMo+WYVvKkti3kL690wjMGaRvIUrpFqaNoYfbIu45FvWiYtrcixaACml4n/YWsScqSHGZHRcj5ANuCrUwVbPy1UiuiqPWGdc0oVAqUly89d/fHkx44aJhVdpWcp4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787204958; c=relaxed/simple;
	bh=IEVi4NTm+GnFk+jFbGCey049+nEnji8TcjklkO57fdk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2A/2zj2DTFqLEsbK+sVuW7171rs4PyHRX6fPyQTD+9rQWDYxFrjm+4pFLnRoyjMmI/0vae2qKbH/6sRJPZUyHYIe8jU/JcwPShdSoqf1pm6b4LvEs+30BsqfnD5ybTKuE+ju5cpgu/s2ETAOFEKrgEiOTnWuAIdPqjSJDS5xJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4JQjSFYW; arc=fail smtp.client-ip=52.101.53.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4JQjSFYW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWkniQbuelPGsuJJQAnnmIiiFV7BslD9dPHnWTyGfNEFJnPZ7NvIu2WiNuKrdXR4NDmFIr4KTcCmtw/sS43MJbnLRujBam6Sh9ZnrSjPnWlhBqkI57IALOlnhYwK4NH322fh3lRbP4R7uPKEC8yb3B3IgN0auc84ow8F/08dI5tR2fL0DFIGI3Lb8jcJyOcmHkXBzvabE/eDmn8KU5k7C+sJUt11p/9n35U6Bk6cw1oKCXhN7CtXewnaD7YbkpysGGzeSuQPHDAxTOoqdmjUpQB/HeWlQXB2lY7p5NLusrdQNY03otkiDBNmI3J+o7WRHD0VKTXYkng3MGDBiN8tPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfCPAFZ8SSnbEJSQvvFyLacH5EfAin/mhLyXqhnmhx8=;
 b=cCUl6pjV5GL2IcnztqW4O3jcPnGf7qg5Ht55uO+dkpPGCT+JC0AYQ4JLPrg6vDtZBax1xzY6Ugcc0Xd3EjLLCDcCvfwl+sNYkdN6vtFpeh0a0KM2vaa2Oxfxxj/Tp6d2AhUkTef9zemvisihqW7yzX113cEkhAOzVUELDBve+8oBO8kMUfwqiX5D7ypjAfbHLpR8vM5f8XsnadXtFaynEaXmktxDzMrUy3F8Wo+HHzOFrk7dnRvPowisLm+lQi2Ts0p6A5kTNI+ch7Ys/yukjnlujkT+XTtqVO72Vd0Ppuq3E/cKjUmntTCVrTHSkiOHjM9uQXI7sC8OhZ4D4xCrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfCPAFZ8SSnbEJSQvvFyLacH5EfAin/mhLyXqhnmhx8=;
 b=4JQjSFYWa++2MClSwU0fDfx4WDX1nM6adCguS+X0HshhUzc7Ph2xh8sP8l6bcsTH7eWSoJSPm3H4dkvWVakJXx4CxhSgJhQI3wpuQDeUtNzWTIjz9XQCJyJ7rCOkFqks5zBgZ6XBI9KlXqWnrxfyqlsafN95NcEbvIr64CzboAk=
Received: from MN2PR11CA0001.namprd11.prod.outlook.com (2603:10b6:208:23b::6)
 by DSVPR12MB999259.namprd12.prod.outlook.com (2603:10b6:8:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 05:49:11 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:23b:cafe::9b) by MN2PR11CA0001.outlook.office365.com
 (2603:10b6:208:23b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 05:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Thu, 20 Aug 2026 05:49:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 00:49:09 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 00:49:07 -0500
Date: Thu, 20 Aug 2026 05:48:59 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Rong Zhang <i@rong.moe>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<jroedel@suse.de>, Huang Rui <ray.huang@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 0/2] iommu/amd: Do not request ACS when IOMMU is not
 going to be initialized
Message-ID: <sv2id4b3qz34q2tueg4mswgagoh2xr7tsk2eafxcxsqz2z4lkd@qs2hxx5cjcyl>
References: <20260811-amd-iommu-fix-acs-v1-0-d64e2172408d@rong.moe>
 <zm24u35jq6ruz5teu6sevoe447esrqim3gn24s4bdb7kvncz6z@rmhomnfqzwht>
 <c5dc4cae4f4f33c98ee96d4d15da446b9fbf1f59.camel@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c5dc4cae4f4f33c98ee96d4d15da446b9fbf1f59.camel@rong.moe>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DSVPR12MB999259:EE_
X-MS-Office365-Filtering-Correlation-Id: e26fd843-edf8-44c0-60a0-08defe7ec230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RfstU6CLnI5kxwBJI2rfCFIrS2FaVGaj0vGI+5PNPdNO61UfEvL3YZMdxi8C/CohBx8mToFCqircJX+yma+E8WCRl+4B+DGCr7DV0K15BK7lviq2PvOf+ktmKv6ifhfJUNn26VBWOOCvd+waj1GfiPtg9QR2YthH5L3e56mKFLjSef17nCpE1Q6OBEWHbSgv+ilcezyGviTVAGR6qO8ze+Q2OOXEWMXtcl6dVJlfwZ9YxCUJjOf8NPWDFm+lTF2GmFXTaZfbg78FrtgqA+8N94Jh6a+A3h2QFQRVMnNsEy5NipHarZYm/UgolPiw/pme5RZL+QEaJpCshVI7o5IG74KN1BdbIKwgogQ2VSLa1NUzt6P/mVFzhAI1oUOUpOenvfH3pQBBI4eauhOw3i+7SCrjyyDOmAv4PQVmbhg5/PPoitkeHqgUcK3+YKfxLmELk/j0fhGN2hUX2MznF5/3syUav7XA743ZQ7fO7OZZtI3CalDurS282EZlKhf6wE3yVcPEE+xFgbEQaJOh16JYHhPO+8e9FWi+8X/Fz3isi1ERi+rLE7P6y+gEF+zicfqPwvEnY2vatpkps+NZNzgk/BXFT0POJx885pi5lJFhUikChGbwLd+QaTfbtI6d0BPm+1fHz7E5fN6dPXxyL6sPv2DfVnZpNt4dNE4gB/la2M5R0vnNOfTzlWLjzCURHgEARfeySJzdxQP5VYsK/GMBxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PU2t9q1D/Ekj16Ee8WpE17biMuoSk7nWVit2Vvmm34GI9SMKtDRGkZjGTBAeKinxSkcEzJA5qVodPGpaGJv+/NGseyIjj2yBDm5fJ6pMe2mrGhEkd4m7XafL5Z5MLK9AnLYnKEnzfa+A64kC7uOv1iaVi3nKjwVpSZLaU/z8pPWtjKtf5pbQHuMQsXK5LPvumU6Q843jQXgWhiCBmDguRna2IEXD9z5Xrmr1rdM5Dw6Bajk/qaigFqDRXA1QK3lMHB9yEW0sWHph3nyon/Q/1d7z21elhUWqhXix3507zgfoCVMJb99Rk73CkYmOQHkxksSZn2miEKcjh7RwaqMQ8PN/kchDNlgM6dcFow68OXWw9B2Vp5hs+kNbwUUez7sYlBH3KgGFVzdnx276qY9jz4PYNlQJQjDU/KkiTLGUX7RonuRK9nKvw7/z/y4ilHhX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 05:49:11.0033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e26fd843-edf8-44c0-60a0-08defe7ec230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999259

On Thu, Aug 20, 2026 at 01:38:35AM +0800, Rong Zhang wrote:
> Hi Ankit,
> 
> Thanks for your review.
> 
> On Wed, 2026-08-19 at 10:32 +0000, Ankit Soni wrote:
> > On Tue, Aug 11, 2026 at 04:36:17AM +0800, Rong Zhang wrote:
> > > The AMD IOMMU Initialization State Machine has the following state
> > > transition diagram (only the very first states are showed, and the
> > > `IOMMU_' prefix is omitted):
> > > 
> > >    START_STATE
> > >         |
> > >         v
> > > [0] detect_ivrs() --> NOT_FOUND
> > >         | ok
> > >         v
> > >   IVRS_DETECTED
> > >         |
> > >         v
> > > [1] amd_iommu_disabled? (amd_iommu=off) --> IOMMU_CMDLINE_DISABLED
> > >         | no
> > >         v
> > > [2] early_amd_iommu_init()
> > >         |
> > >         +-- [3] amd_iommu_detected? (!iommu=off && ...) -+
> > >         | yes                                            |   
> > >         +-- ... --> IOMMU_INIT_ERROR <-------------------+
> > >         | ok
> > >         v
> > > IOMMU_ACPI_FINISHED
> > >         |
> > >         v
> > >        ...
> > > 

../..

> > > ---
> > > Rong Zhang (2):
> > >       iommu/amd: Do not request ACS when IOMMU is not going to be initialized
> > >       iommu/amd: Remove ad-hoc checks that are never true
> > 
> > Hi,
> > 
> > Thanks for the cleanup, and the analysis of the ACS call paths matches what I see.
> > Two things worth a look before this goes in.
> > 
> > 1. Patch 2: I don't think the !amd_iommu_detected check in
> >    early_amd_iommu_init() is unreachable. pci_iommu_alloc() returns early for
> >    xen_pv_domain() before calling amd_iommu_detect(), but Xen PV still sets
> > 
> > 	x86_init.irqs.intr_mode_init = x86_64_probe_apic;
> > 
> >    so x86_64_probe_apic() -> enable_IR_x2apic() -> irq_remapping_prepare() ->
> >    amd_iommu_prepare() enters the state machine anyway, and none of the new
> >    IOMMU_START_STATE conditions are true. That check looks like
> >    the only thing currently stopping early_amd_iommu_init() from running
> >    there. Could you double-check that case before dropping it?
> 
> This has been resolved by PATCH 1, where the checks have been embedded
> into the state machine.

Agreed on patch 1 - the state machine is the right place for those checks and
I have no objection to it. My concern is only patch 2 dropping the
"amd_iommu_detected" check.

> 
> I did some quick tests by commenting out the call to amd_iommu_detect()
> in pci_iommu_alloc(), and adding a debug WARN() to iommu_go_to_state().
> When I booted a VM with emulated IOMMU (-device amd-iommu) and with
> either `amd_iommu=off' or `iommu=off':
> 
> [    0.081948] APIC: Switch to symmetric I/O mode setup
> [    0.082553] ------------[ cut here ]------------
> [    0.083144] init_state: 0 => 9, ret: -22
> [    0.083617] WARNING: drivers/iommu/amd/init.c:3506 at iommu_go_to_state+0xf18/0x1c00, CPU#0: swapper/0/0
> [    0.084809] Modules linked in:
> [    0.085122] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-02579-ge0f12714fa53-dirty #38 PREEMPT(lazy)
> [    0.086124] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> [    0.087076] RIP: 0010:iommu_go_to_state+0xf23/0x1c00
> [    0.087629] Code: 1b e7 2c 00 eb 12 c7 05 0f e7 2c 00 06 00 00 00 eb 03 90 0f 0b 45 31 f6 48 8d 3d e8 90 b6 ff 8b 15 fa e6 2c 00 44 89 f1 89 de <67> 48 0f b9 3a 45 85 f6 0f 84 f4 f0 ff ff e8 8a c0 73 fe 48 8b 05
> [    0.089556] RSP: 0000:ffffffff93a03e40 EFLAGS: 00010202
> [    0.090039] RAX: 00000000fffffff9 RBX: 0000000000000000 RCX: 00000000ffffffea
> [    0.090677] RDX: 0000000000000009 RSI: 0000000000000000 RDI: ffffffff93d17440
> [    0.091338] RBP: ffff8fbd47fd5c80 R08: 3fffffffffffdfff R09: ffffffff93b20aa8
> [    0.092025] R10: 0000000000000002 R11: 0000000000000002 R12: 000000000000001b
> [    0.092662] R13: 0000000000000000 R14: 00000000ffffffea R15: 0000000000014770
> [    0.093319] FS:  0000000000000000(0000) GS:ffff8fbdb3634000(0000) knlGS:0000000000000000
> [    0.094055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.094572] CR2: ffff8fbd4728f000 CR3: 0000000006844000 CR4: 00000000000100b0
> [    0.095214] Call Trace:
> [    0.095437]  <TASK>
> [    0.095628]  amd_iommu_prepare+0x15/0x40
> [    0.096025]  irq_remapping_prepare+0x43/0x60
> [    0.096406]  enable_IR_x2apic+0x22/0x190
> [    0.096759]  x86_64_probe_apic+0xa/0x50
> [    0.097130]  apic_intr_mode_init+0x70/0xd0
> [    0.097495]  x86_late_time_init+0x28/0x40
> [    0.097858]  start_kernel+0x6f9/0x7a0
> [    0.098209]  x86_64_start_reservations+0x24/0x30
> [    0.098629]  x86_64_start_kernel+0xd1/0xe0
> [    0.099016]  common_startup_64+0x13e/0x158
> [    0.099393]  </TASK>
> [    0.099595] ---[ end trace 0000000000000000 ]---
> [    0.100266] x2apic enabled
> [    0.100758] APIC: Switched APIC routing to: physical x2apic
> 
> ...where 0 is IOMMU_START_STATE and 9 is IOMMU_CMDLINE_DISABLED.

Commenting out amd_iommu_detect() is right way to emulate this, and the trace 
confirms the entry path. But the boot options are what make it
come out clean: amd_iommu=off / iommu=off set amd_iommu_disabled / no_iommu,
so IOMMU_START_STATE bails on its first if - that's the 0 => 9., which
is clearly visible above.

But,
Xen's own iommu= sits on the hypervisor command line and goes to Xen's parser,
not to Linux's iommu_setup(), and there no one sets no_iommu or amd_iommu_disabled.

The wider point is that amd_iommu_detect() never running is the platform mean
Linux does not own this IOMMU - Xen opts out of pci_iommu_alloc() and installs
xen_swiotlb_dma_ops instead. 'amd_iommu_detected' was the only thing making the
irq-remapping entry path honour that, so without it (i.e. patch 2 removes it) 
early_amd_iommu_init() proceeds on hardware the hypervisor owns.

-Ankit

> 
> Therefore, embedding the checks into the state machine ensures the checks
> are done in all initialization paths and makes replicating the same
> checks in state transition methods unnecessary.
> 
> > 
> > 2. Patch 1 Fixes: 9f81ca8d1fd6 doesn't look right - it only moved the
> >    amd_iommu_disabled check ahead of early_amd_iommu_init() and left
> >    IOMMU_START_STATE and detect_ivrs() alone, so ACS was requested with
> >    amd_iommu=off both before and after it. The commit that actually put
> >    pci_request_acs() on the detect path is 1adb7d31b051 ("iommu/amd: Fix
> >    pci_request_acs() call-place"). I'd drop Fixes: and Cc: stable and post
> >    this as a cleanup.
> 
> Makes sense. Will drop them when resubmitting. I will defer to your
> opinion on my explanation to the first question before resubmitting :)
> 
> Thanks,
> Rong
> 
> > 
> > -Ankit
> > 
> > > 
> > >  drivers/iommu/amd/init.c | 36 ++++++++++++++----------------------
> > >  1 file changed, 14 insertions(+), 22 deletions(-)
> > > ---
> > > base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
> > > change-id: d58d0f31-amd-iommu-fix-acs-8f3d4aba8183
> > > 
> > > Thanks,
> > > Rong
> > > 
