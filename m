Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793783968;
	b=uK7oyOlRcfeWqQpzyDwvWesDn5dBB3/aCnW2E/ISn4/RobHfyS+ahoLtqedxvzSFKZ7u
	 cFZiYlqdfbt8xsYgk5M1m7ydbjuRQ7U4o6rY9aVpLcEOsJlKpn9owGfXqyowglV4SEONR
	 i6eWZimvxGIDppDM3gzMp6vUaBG49bVJztLD9PEqlsPVSk+CK/g72Ghp+m4ZL097+0S/W
	 U27jUmYjWa7f2O0IJkymezbBXwDtdIAUMmbYdwXSoVYlIYu4BSj4vgd7UFyCcObviqv2j
	 9MZ4+wvdJimFeiycC/WDaOLX8JzScemMVKIUHopfOk0quClc5H5bXlruxXUd3nHMQwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783968;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=KFK8sfPu5IfbxWRLeJKnhEpOsoplb7UDNltwwWL42qo=;
	b=Tdh0icb4/1muHVdYXjs9oDoet1GbjkPkOmcoYPDVvr29+A/TMUCC2u5ZEuUfOtHAPlOY
	 XJl/lSAr2SaGs7BBdJzlPI8rMtylSWLyRpkxXfwMnj/diWa8jB/lxbtd+uQ5d1MU67mZP
	 XGEnA8KoQ2vwtRD+O2SXzdtOusRnu6kTVFFY2070jCfvwZHcZgOgSOuOkBmrRiCq0Ro2z
	 tnjsuwuhtmghHAgPG/PQYBYHMtVfTshYD009jSydUJkFMx3I32dHdyzS//xcbw2lSy+h2
	 eMd0m4kCdiXO4qSF/xYpXhW7AOe1hrbtp/dZHu8K16tbc2EpVEUvXvPwWsqTL0X2j5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=trPZ9TmE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.20
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00293606A326;
	Wed,  4 Nov 2026 09:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00293606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=trPZ9TmE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is/RY/dw1B6r5UoO1OPJ79+oYfxhlPEePfT1LcSfZqGmwqtDKSu2R/ipGj7PwqWckddKhVIXkHBS3mxVV08aM9SxmM+PJSRxKjNl/+JkLDjw6AH/CCxvO2/1LPL7ZyRMFm5zq6LwTuzg5U8ixagzRuapsS+vq7CUef5ZdwjgL+N0zzHpDNGOiV2AjbjiqhrA4lEpXw3hpmGIbJ/kBcISGbjAcJ+Le080yM4gT+s44aPnQbQ3KblnC5FDHD1Mz7jzRxY6/cTatYnTtfHrMztIatpRW//f0Rxp4EGtWrSuagCywoq5HW9nrPwPe5z+TI+Sb4NAwREqkxolyTLK6JwHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFK8sfPu5IfbxWRLeJKnhEpOsoplb7UDNltwwWL42qo=;
 b=mc/u8Yan/ywRRLdD1DsMjyXuzNMdkvK7uKKwdiP2aWxCKkBdhfGLunYCyxwITSvNkOOyMd2YPDAealhDx288rD3VCWB3sJRNvwTL7QD4wgjShKp+7auHAyb7OVP3kNGC61Evj642/HoxZo2KT2+He2wC9OXwTYb3l0DEMEvPP54k9ywtAUXXSNSnV3cuNJb7J8e2CAO7i1wG7i2dENRfng2tBH92oKtge5l/NCP9pAF0/RwC8TwqiBDBemTmGE2IYbWkyKDgFvf/DlDbh5N5IiZBfn52LjJcEanZLC/ZNcunsK+33cT28g+preP6eC/ap93HMPVG9rhbXqZ2sjbSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFK8sfPu5IfbxWRLeJKnhEpOsoplb7UDNltwwWL42qo=;
 b=trPZ9TmEdU4k+IaZAlzd7A+7keUw9srt7M6nweWW2XFsypnT8k15gHRWU62OuSgTGcLoJdrvtn6NyFGAQqkXkjV2WYGOaO5yShwfEIItbp+CoupxkPpdH8DpuRoSAN34804SWTB1oThDYNkUgxUl0Xhr2Eav5Wve09qsLyEJUEk=
Received: from BN9PR03CA0892.namprd03.prod.outlook.com (2603:10b6:408:13c::27)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:19:23 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::8d) by BN9PR03CA0892.outlook.office365.com
 (2603:10b6:408:13c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 09:19:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 09:19:23 +0000
Received: from [10.85.43.226] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 03:19:19 -0600
Message-ID: <b426d646-5dd7-40b3-812b-e9377ecce4e9@amd.com>
Date: Wed, 4 Nov 2026 14:49:17 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/amd: Prevent spurious IRQ disable on high-rate
 GALog MSIs
To: Mina Almasry <almasrymina@google.com>, Joerg Roedel <jroedel@suse.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>, Jerry Snitselaar <jsnitsel@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, <stable@vger.kernel.org>
References: <20261101062102.1000477-1-almasrymina@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <20261101062102.1000477-1-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4d858d-774e-4bf3-1105-08df3a54b700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|261102123227099003|261009223027099003|261026121527099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	sR62aAJufT2L9Wq1sOiz648BG4sPxnLmBQGXy0bmHwfzWPJlOrhBXG0rQQ/hxOpYdm/pQxyuqwHSdnmYaxlLE89PDNQTEF+GzJYuCXoVIwu5bY3zmjiwg3uk7q1bVvEdjPWbjenf4KDWfB10kgyuQZNE/o7dZw9GD8mor9q205zWGR4ZOte4cOWj3bY+X8rROyJ11d7lU//Unll5lxDi0l1tDd2Y3hkeg1kcQpWh3U2Ax//tYO5WcQ3+e5Y7yGnOMCHkiufPplff7OK37h4boJDw/xH4aqpWe3WjdOAmdAZr5TkDz3Vez2YciJdw8Ess+M5O7Kva0+nPn5CtgHiIAibdzOPrZYoTjsNiT81Al+alkch3pOn9jsXHutULXCttIfN1Y6QYCCDACaeUxwgoZUtIWRlif4lZHKfeSUMl71iYIgbkol0afm4woYKZzwsz/X8yMA/uSNV4o5r7/syjfT87pY4MVueg6stSPCh7C1gYxTJvD0/7MiMypTMyOx4hpXkwz2CjjHooo4f57CIESWTKz9yfJyss8J0p3v4leRPMsZr+dEKQJzYxkB+Cahfa8GCFeaQwbv60wzOCDZLW0qKAXZYSx+5gWfu1dCeqC9zEb517hSd44YSZioUtOXwjVuBBvQGJYU749EdMLnKBu7yyyJl2QlxE5ZB4w0Xrv5KTLJsj+qoKnNxt+Dqkrbe753/irm8BSPreZ934CeUDEg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/CwGNg+lA1nUEXg+1Ap5Hh9Q2u+cmpzDxYR0zr1/2JBNXbKLhTq0/K1FZImZCyR2a0HIx23UhueqGJfQaE/4CtuELhJp4gSAh3ZZyRjV+6b5oXsoOKUi4i/OlJ1u961IpW87e+c+1VH8o1QDsPO1x9tJpQJAncTRqoCaiCzLkUYbuos1owUsvqct3ozBu1f7j9BEyhl9EglSrugIAhUpk2PgIUPzo+l82S8lCD7OosJKB/rfwNFmMrDraiC1HKn0kMjknyt5LTgBzJbL6SgmT1zcLMDTTdJV4/iSQCruq+7sfg+UkAyW6juY8KStu/t4WfIcjwUPkaRjm71EwmIYN3pIzlijmy5g8To1GNpbqBeRvbxeGJgv1rjdtw0MqaVL5vUTr64nPSjnWeJ8Qm2XF3Af+6hGQjxM9zZ58YLPHGpmKft2fKizA4hxY75gI3KB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:19:23.1374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4d858d-774e-4bf3-1105-08df3a54b700
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352

On 11/1/2026 11:51 AM, Mina Almasry wrote:
> On AMD EPYC (Turin) hosts with AVIC enabled, passed-through SR-IOV VFs
> in KVM guests log interrupts targeting non-running vCPUs into the IOMMU
> Guest Virtual APIC Log (GALog) ring buffer and signal the host via an
> edge-triggered IntCapXT MSI (AMD-Vi*-GA).
> 
> Both __iommu_setup_intcapxt() and iommu_setup_msi() register their
> handlers via request_threaded_irq(..., NULL, thread_fn, IRQF_ONESHOT,
> ...), using irq_default_primary_handler() (which returns
> IRQ_WAKE_THREAD), while intcapxt_irqdomain_alloc() sets handle_edge_irq
> which does not mask edge-triggered MSIs during oneshot thread execution.
> 
> Previously, amd_iommu_handle_irq() cleared MMIO_STATUS_OFFSET at the top
> of the while (status & mask) loop before calling int_handler(iommu)
> (iommu_poll_ga_log()). Under overcommitted multi-VM TCP_RR workloads
> (1,000 to 10,000 flows across 4-8 VMs with vCPU overcommit), new VF
> interrupts for non-running vCPUs arrive while iommu_poll_ga_log() is
> draining the ring buffer, causing GALogInt to transition 0 -> 1 and fire
> additional hardware edge MSIs while the IRQ thread is still inside
> amd_iommu_handle_irq(). Because desc->threads_handled only increments in
> irq_thread_fn() after action->thread_fn() returns, note_interrupt()
> (kernel/irq/spurious.c) accounts every intermediate edge MSI as IRQ_NONE
> (desc->irqs_unhandled++). Once desc->irqs_unhandled exceeds 99,900 out
> of 100,000 interrupts, __report_bad_irq() logs "irq <N>: nobody cared"
> and permanently disables the IOMMU GALog IRQ, breaking guest VF MSI-X
> wakeups.
> 
> Fix this in two ways:
> 1. Drain the log ring buffer via int_handler(iommu) before writing
>    status & mask to MMIO_STATUS_OFFSET (clearing only the status bits
>    observed set so a concurrent overflow bit is never cleared without
>    running overflow_handler()), followed by a post-clear poll pass so
>    entries written before the status clear took effect are processed
>    without generating redundant edge MSIs or leaving entries stranded.
> 2. Set IRQ_IS_POLLED on the AMD-Vi MSI and IntCapXT IRQs (clearing it on
>    request_threaded_irq() failure paths) so note_interrupt() never
>    spuriously disables the dedicated IOMMU event/PPR/GALog IRQ lines
>    under sustained high-rate edge MSI bursts.
> 
> Discovered in production testing on AMD EPYC (Turin) hosts running
> multi-VM KVM guests with passed-through SR-IOV VFs where the host
> permanently disabled AMD-Vi-GA under heavy TCP_RR traffic, and verified
> on the same AMD EPYC (Turin) hardware across 4-VM and 8-VM SR-IOV VF
> test suites.
> 
> Fixes: 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  drivers/iommu/amd/init.c  |  4 ++++
>  drivers/iommu/amd/iommu.c | 13 ++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index de6db5621194..5eea9204f209 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2404,9 +2404,11 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
>  	if (r)
>  		return r;
>  
> +	irq_set_status_flags(iommu->dev->irq, IRQ_IS_POLLED);
>  	r = request_threaded_irq(iommu->dev->irq, NULL, amd_iommu_int_thread,
>  				 IRQF_ONESHOT, "AMD-Vi", iommu);
>  	if (r) {
> +		irq_clear_status_flags(iommu->dev->irq, IRQ_IS_POLLED);
>  		pci_disable_msi(iommu->dev);
>  		return r;
>  	}
> @@ -2579,9 +2581,11 @@ static int __iommu_setup_intcapxt(struct amd_iommu *iommu, const char *devname,
>  		return irq;
>  	}
>  
> +	irq_set_status_flags(irq, IRQ_IS_POLLED);
>  	ret = request_threaded_irq(irq, NULL, thread_fn, IRQF_ONESHOT, devname,
>  				   iommu);
>  	if (ret) {
> +		irq_clear_status_flags(irq, IRQ_IS_POLLED);
>  		irq_domain_free_irqs(irq, 1);
>  		irq_domain_remove(domain);
>  		return ret;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 960e1dc05ec6..ec392da008f9 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1112,9 +1112,6 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
>  	u32 mask = int_mask | overflow_mask;
>  
>  	while (status & mask) {
> -		/* Enable interrupt sources again */
> -		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> -
>  		if (int_handler) {
>  			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
>  				 iommu->index, evt_type);
> @@ -1124,6 +1121,16 @@ static void amd_iommu_handle_irq(void *data, const char *evt_type,
>  		if ((status & overflow_mask) && overflow_handler)
>  			overflow_handler(iommu);
>  
> +		/*
> +		 * Clear only the status bits observed above, then poll once
> +		 * more so entries written before the clear took effect are not
> +		 * left unprocessed with the interrupt status bit cleared.
> +		 */
> +		writel(status & mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
> +
> +		if (int_handler)
> +			int_handler(iommu);
> +
>  		/*
>  		 * Hardware bug: ERBT1312
>  		 * When re-enabling interrupt (by writing 1
> 
> base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d


Hi Mina,

I think marking IRQ_IS_POLLED seems like a bad work around,
IRQ_IS_POLLED is used for fake/software irqs and I dont think it is
right way to use it for the hardware IRQ.

Additionally, code movement in the iommu.c seems redundant and does not
provide any real benefit. we will encounter following condition again,
this time while calling int_handler() for second time

> interrupts for non-running vCPUs arrive while iommu_poll_ga_log() is
> draining the ring buffer, causing GALogInt to transition 0 -> 1 and fire
> additional hardware edge MSIs while the IRQ thread is still inside
> amd_iommu_handle_irq()

The read from status bit will cause handler to keep running without
incrementing threads_handled.


We also encountered same issue recently, I think right way to fix is to
address the underlying root cause -->
1. GALOG is a circular buffer and any new entries created by the IOMMU
can be handled in a single interrupt.
2. In an high interrupt rate environment The ga-log handler keeps
looping without incrementing threads_handled.
3. This causes note_interrupt to disable irq since it thinks that
handler is stuck.

The solution that I had in mind (not sure if its a right way) is to
break the while loop inside amd_iommu_handle_irq() after certain number
of iterations.

This works because.
1. We enable the interrupts before processing the entries
2. Any new interrupts that arrive during the entry processing will set
IRQTF_RUNTHREAD.
3. If we break the loop after that, the irq_thread_fn() will increment
threads_handled.
4. And irq_wait_for_interrupt() will return true because it sees
IRQTF_RUNTHREAD and irq_thread() will call the handler again.

Although I am not sure what should be a right value for number of
iterations, the initial tests with 10000 iterations resolves this issue
but increases the interrupt latency.


Thanks
Sairaj
