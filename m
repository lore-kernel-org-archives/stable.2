Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022076.outbound.protection.outlook.com [40.107.75.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B82F7F07;
	Mon, 24 Aug 2026 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787541739; cv=fail; b=HhCwbpGoRpdylOu1fPx2UFtrB0dR0K6NBjG20yqZASfnD3ELwPKCHLSVcNH2p4uiNP4RIStHPgx560Ji7gMsdZw4Isa4C0AxWd4UMJnrK/np89SscVq7BxSzheBKuZL+4YUCR9cicqYilsRx4ZW6a1yTgw/h86wYo5J33jPm15w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787541739; c=relaxed/simple;
	bh=1GPLaxklm3apFqpaNBVq1P4ACIbKvlq71HkPLgCzATA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUNKE/R4+R4rwIU2ErKTZP6/eSlwxE8AXOCJHPvfQURe8EXMQkaz0B29hfxS9x3aEAVAh7a7Pq3828HsUyO/Vk2fPabFuLrq/21cIJ5VkrqdZtBLE1EIZW3Exsh+qzhFfe4P6qdRpoaVMH1+GrLqDDdXejFVZr8RM3JFLwYKYh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hroE4wtpRcmG0/dA9OSwJUFhyd9wj5nr7l2NBo7bPZjaLZsr6RA3n2gRjAnT9Lh/TXXa9JCwlMF/sB8O23u7+wnvodGwExFmAUh9BL8g+zCspxSLS7It9izEpslmnRFZTB9nTWNnrjS6eUKqBQ2jzcRXPukKiVDpn94LPSc9o3JhrUEN4aqXqX+vbQ/9oeKDlytvlwQU+eOnxXkg18Rd2PO7LmqUCpcwOiGPsK7QWREnkYXcPrMO26AyOVuZbfGwLms4x7qzVJPJTPPk+lo3Gg8D5SIcUfGQVTTvdwbF5RBSIAW703rxXCNk8yKne08ZWqrxzPqLr607ilQW0mxtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyKT42pdYhBdWdyFT54bF4Ry3OFxK8N5wY72bbiRlTQ=;
 b=n8vY/Ou7/8Im2dxie8rnWcQOWlPYH8JMv+Nl3WxzCCgR1KB0BGPt71hFNJ/zANwCVvAkbVKN1X5ZSpCKaCGUjODEsu8T98q/OHnH82OX5e/WZgnUqZNpM3lXZNATeYQVsRG3vWBRhumt80aBLalAFf5zAj7O56RwAY6XtMGnU3mfcgCQe2SfDw1B2HpUpjXv3uvKUEEkMlGObsijmf4LZ3LHJyYWnu4Qb87hrC3zuR+sNIhz30f7xVB+wOfJj+MrGj2/kYR0fIg1xs1NmKzGhLyA48k1WuxQsuwrUXyWdtM5RRFXQiGuOY8guFIQ8tApgCf70TDzDd1e1WI8rpkxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0073.apcprd02.prod.outlook.com (2603:1096:300:5c::13)
 by KL1PR06MB6554.apcprd06.prod.outlook.com (2603:1096:820:f1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 03:22:08 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:5c:cafe::66) by PS2PR02CA0073.outlook.office365.com
 (2603:1096:300:5c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 03:22:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 03:22:07 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 73D56427CEE1;
	Mon, 24 Aug 2026 11:22:06 +0800 (CST)
Date: Mon, 24 Aug 2026 11:22:05 +0800
From: Gary Yang <gary.yang@cixtech.com>
To: pawell@cadence.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: cdnsp: fix wakeup from S3 after controller
 context loss
Message-ID: <aou43bEt96I07cE6@gary-System-Product-Name>
References: <20260820-suspend_resume_fix-v3-1-5a713098b977@cadence.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260820-suspend_resume_fix-v3-1-5a713098b977@cadence.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|KL1PR06MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb68e98-64e4-4731-198a-08df018ee0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rrM0i7HfVzvyPBzRaXsoH6eWeG7sxlMQIYuqpCoR32VY8lUyD5EMN/pMGCT9rvdbnHk0DuY9pzeSU1MSNoPsYiioJLYoMCj1M+uuoquBDDneh9Sxp3zE0wFO33+ECDRJ474NSRTOhSMZ8fJwTDdkQZMvnjTcVsEqckhfNZetol6XfCcq6s0MFYgHBTRIkj97urTK6LQ/PQ9z+y7psIhFddnGwaL03i4q5CA17eJXShULMD5mKtAw6FcB4R7HMdqdn3mgN2IQlvorgYBg3G6wT2AGtR5zUaBCSRwucHB5qLvLCp3Riulue2QskcePqPYt9qpTgv54uMae9tq3FRLCy/7MPyEz0jL4tpTR9tLoWYH9LQYwwx0LVyNYP9avmSuAHvNTOXRJYWzvqFIHpvg7oxKPFpJev+uvJiuDVpxOOAt7p2opnCglMYzbJpySbjAnz86gI8L85R6PgfB2KQJf0QpRq2gY08HKzcqlSq47CoCMwYgomVJzVk2zK/3jRNISSKxdFTRjWbi0vgpBDGtUsrUfiVvmZW6yd2531XX9v62v+xtypj8L9D0qHzkj+AgoXNSRfhmQE3E9SByA/l7SThDfn6HlqMdhq2C2KnIaFLHPxXkKuuDp+1fJrrNmvJFE6VfHE6qxuBg7zxXfpNL+rWKS5iVtxgivJ/M7N6EKrZ7g4tENCsYaitWn8zF2T7etjN+3TJnXOIxKt+MGJkVY4w==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2q78yA5A8Oop+JE9JwbFX9RfYrgIrySSTJvuUfE3WlWiUfXfhyOPrgG6u1/mFalcH1ByajrJDGQ0J5XHyXTfmj/J30DinzQOPLGt5FIyi1SX1jRwI3TKoAE28fJ3qwd4L6OTYkSfBW3JCVhiqFpLYHiP1YdINQS6/fdRK/AboLfkUFbchj63vzWs5ZB09+hfTMb6tBJlZl0Kpm6aoNACBMY2wE3ZLvQCdVZZ+pl6Ha68ToHGtd0+vWbq2bB90CRgxm3BP3FH9vRl+rhAT+iAF0zuyil7TpZrVvSqd38YNf4iIYTIFhWoF0SjHK2Yp0A+4vZMdR0ybZ+FQVsu+/5sy1g033KeWEtQYMOx0irPomeveIxrWwBT+tsmzJW5FbAdpFTlgT1FPkUL/HafmuRHdAeAfS1zgGImjHy33pAVypqzh+tcm7mAjPUx1r/ES1kx
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 03:22:07.5855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb68e98-64e4-4731-198a-08df018ee0c5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6554

On 2026-08-20 12:45, Pawel Laszczak via B4 Relay wrote:

> [You don't often get email from devnull+pawell.cadence.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL
> 
> From: Pawel Laszczak <pawell@cadence.com>
> 
> CDNSP controller may lose its runtime register programming across S3
> suspend/resume, depending on SoC power domain configuration. After
> resume the operational and interrupter registers may contain reset
> values, which prevents the gadget side from recovering correctly and
> breaks wakeup from S3.
> 
> Fix this by detecting whether the controller lost its register context
> after resume and handling both cases:
> - If context was lost (CFG_3XPORT_U1_PIPE_CLK_GATE_EN set or power
>   lost): reset the controller and reprogram the state required for
>   normal operation, including the command ring, DCBAA pointer, doorbell
>   base, event ring, ERST base/size and event ring dequeue pointer.
> - If context was retained: restart the controller directly without
>   reprogramming registers. Issue a wakeup if the link was in U3 before
>   suspend.
> 
> Move the basic controller register programming out of the one-time memory
> initialization path and make it reusable from the resume path. Also
> separate ring allocation from ring initialization so that rings can be
> reinitialized without reallocating DMA memory.
> 
> Always perform the full suspend sequence regardless of the current link
> state. Previously, if the device was already in U3, the suspend callback
> returned early without stopping the controller, which could lead to
> commands being issued on a disabled slot during resume.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

hi Peter:

We have performed validation. After STR stree testing on CIX P1
platform, the usb gadget functionality works as expected.

Best Regards,
Gary

> ---
> Changes in v3:
> - Remove CSS/CRS sequences: not applicable to the device controller.
> - Remove cdnsp_save_registers(), cdnsp_restore_registers() and
>   struct cdnsp_s3_save, now unused.
> - Remove STS_CNR polling from the power-retained resume path: it was
>   not present before this fix and is not required.
> - Move __cdnsp_gadget_wakeup() call to the power-retained path only,
>   where the link state is meaningful.
> 
> Changes in v2:
> - Clarify commit message to reflect SoC-dependent context loss behavior
> - Removed in_lpm from cdnsp_irq_handler - the code is unnecessary
> - Fix suspend: always perform full suspend sequence regardless of link state
> ---
>  drivers/usb/cdns3/cdnsp-gadget.c | 111 +++++++++++++++++++++++++++++++++++++--
>  drivers/usb/cdns3/cdnsp-gadget.h |   1 +
>  drivers/usb/cdns3/cdnsp-mem.c    |  98 ++++++++++++----------------------
>  3 files changed, 142 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
> index a5275c2fb43b..63f605de068b 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> @@ -1338,7 +1338,6 @@ static int cdnsp_run(struct cdnsp_device *pdev,
> 
>         cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
> 
> -
>         ret = cdnsp_start(pdev);
>         if (ret) {
>                 ret = -ENODEV;
> @@ -1837,6 +1836,82 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
>                  readl(&pdev->rev_cap->tx_buff_size));
>  }
> 
> +static void cdnsp_set_event_deq(struct cdnsp_device *pdev)
> +{
> +       dma_addr_t deq;
> +       u64 temp;
> +
> +       deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +                                   pdev->event_ring->dequeue);
> +
> +       /* Update controller event ring dequeue pointer */
> +       temp = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> +       temp &= ERST_PTR_MASK;
> +
> +       /*
> +        * Don't clear the EHB bit (which is RW1C) because
> +        * there might be more events to service.
> +        */
> +       temp &= ~ERST_EHB;
> +
> +       cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
> +                      &pdev->ir_set->erst_dequeue);
> +}
> +
> +static void cdnsp_add_interrupter(struct cdnsp_device *pdev)
> +{
> +       u64 erst_base;
> +       u32 erst_size;
> +
> +       /* Set ERST count with the number of entries in the segment table. */
> +       erst_size = readl(&pdev->ir_set->erst_size);
> +       erst_size &= ERST_SIZE_MASK;
> +       erst_size |= ERST_NUM_SEGS;
> +       writel(erst_size, &pdev->ir_set->erst_size);
> +
> +       /* Set the segment table base address. */
> +       erst_base = cdnsp_read_64(&pdev->ir_set->erst_base);
> +       erst_base &= ERST_PTR_MASK;
> +       erst_base |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
> +       cdnsp_write_64(erst_base, &pdev->ir_set->erst_base);
> +
> +       /* Set the event ring dequeue address. */
> +       cdnsp_set_event_deq(pdev);
> +}
> +
> +/* Set up basic CDNSP registers */
> +static void cdnsp_init(struct cdnsp_device *pdev)
> +{
> +       unsigned int val;
> +       u64 val_64;
> +
> +       val = readl(&pdev->op_regs->config_reg);
> +       val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
> +       writel(val, &pdev->op_regs->config_reg);
> +
> +       /* Initialize the Command ring */
> +       cdnsp_ring_init(pdev, pdev->cmd_ring);
> +
> +       /* Set the address in the Command Ring Control register */
> +       val_64 = cdnsp_read_64(&pdev->op_regs->cmd_ring);
> +       val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
> +                (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
> +                pdev->cmd_ring->cycle_state;
> +       cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
> +
> +       /* Set Device Context Base Address Array pointer */
> +       cdnsp_write_64(pdev->dcbaa->dma, &pdev->op_regs->dcbaa_ptr);
> +
> +       /* Set Doorbell array pointer */
> +       val = readl(&pdev->cap_regs->db_off);
> +       val &= DBOFF_MASK;
> +       pdev->dba = (void __iomem *)pdev->cap_regs + val;
> +
> +       /* Initialize the Primary interrupter */
> +       cdnsp_ring_init(pdev, pdev->event_ring);
> +       cdnsp_add_interrupter(pdev);
> +}
> +
>  static int cdnsp_gen_setup(struct cdnsp_device *pdev)
>  {
>         int ret;
> @@ -1902,6 +1977,8 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev)
>         if (ret)
>                 return ret;
> 
> +       cdnsp_init(pdev);
> +
>         /*
>          * Software workaround for U1: after transition
>          * to U1 the controller starts gating clock, and in some cases,
> @@ -2031,9 +2108,6 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
>         struct cdnsp_device *pdev = cdns->gadget_dev;
>         unsigned long flags;
> 
> -       if (pdev->link_state == XDEV_U3)
> -               return 0;
> -
>         spin_lock_irqsave(&pdev->lock, flags);
>         cdnsp_disconnect_gadget(pdev);
>         cdnsp_stop(pdev);
> @@ -2047,12 +2121,38 @@ static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
>         struct cdnsp_device *pdev = cdns->gadget_dev;
>         enum usb_device_speed max_speed;
>         unsigned long flags;
> +       bool context_lost;
> +       u32 val;
>         int ret;
> 
>         if (!pdev->gadget_driver)
>                 return 0;
> 
>         spin_lock_irqsave(&pdev->lock, flags);
> +       val = readl(&pdev->port3x_regs->mode_2);
> +       context_lost = !!(val & CFG_3XPORT_U1_PIPE_CLK_GATE_EN) || lost_power;
> +
> +       if (context_lost) {
> +               cdnsp_halt(pdev);
> +               cdnsp_set_apb_timeout_value(pdev);
> +
> +               /* Reset the internal controller memory state and registers. */
> +               ret = cdnsp_reset(pdev);
> +               if (ret)
> +                       goto unlock;
> +
> +               val = readl(&pdev->port3x_regs->mode_2);
> +               val &= ~CFG_3XPORT_U1_PIPE_CLK_GATE_EN;
> +               writel(val, &pdev->port3x_regs->mode_2);
> +
> +               cdnsp_clear_cmd_ring(pdev);
> +
> +               memset(pdev->event_ring->first_seg->trbs, 0,
> +                      sizeof(union cdnsp_trb) * (TRBS_PER_SEGMENT));
> +
> +               cdnsp_init(pdev);
> +       }
> +
>         max_speed = pdev->gadget_driver->max_speed;
> 
>         /* Limit speed if necessary. */
> @@ -2060,9 +2160,10 @@ static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
> 
>         ret = cdnsp_run(pdev, max_speed);
> 
> -       if (pdev->link_state == XDEV_U3)
> +       if (!context_lost && pdev->link_state == XDEV_U3)
>                 __cdnsp_gadget_wakeup(pdev);
> 
> +unlock:
>         spin_unlock_irqrestore(&pdev->lock, flags);
> 
>         return ret;
> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
> index c44bca348a41..c3ae5040f9cc 100644
> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> @@ -1510,6 +1510,7 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
>  int cdnsp_ring_expansion(struct cdnsp_device *pdev,
>                          struct cdnsp_ring *ring,
>                          unsigned int num_trbs, gfp_t flags);
> +void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring *ring);
>  struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *ep, u64 address);
>  int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
>                             struct cdnsp_ep *pep,
> diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
> index 5d8cdc91927d..0be917f52bbb 100644
> --- a/drivers/usb/cdns3/cdnsp-mem.c
> +++ b/drivers/usb/cdns3/cdnsp-mem.c
> @@ -394,13 +394,6 @@ static struct cdnsp_ring *cdnsp_ring_alloc(struct cdnsp_device *pdev,
>         if (ret)
>                 goto fail;
> 
> -       /* Only event ring does not use link TRB. */
> -       if (type != TYPE_EVENT)
> -               ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> -                       cpu_to_le32(LINK_TOGGLE);
> -
> -       cdnsp_initialize_ring_info(ring);
> -       trace_cdnsp_ring_alloc(ring);
>         return ring;
>  fail:
>         kfree(ring);
> @@ -603,6 +596,7 @@ int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
>                 if (!cur_ring)
>                         goto cleanup_rings;
> 
> +               cdnsp_ring_init(pdev, cur_ring);
>                 cur_ring->stream_id = cur_stream;
>                 cur_ring->trb_address_map = &stream_info->trb_address_map;
> 
> @@ -696,6 +690,8 @@ static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev)
>         if (!pdev->eps[0].ring)
>                 goto fail;
> 
> +       cdnsp_ring_init(pdev, pdev->eps[0].ring);
> +
>         /* Point to output device context in dcbaa. */
>         pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
>         pdev->cmd.in_ctx = &pdev->in_ctx;
> @@ -989,6 +985,8 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
>         if (!pep->ring)
>                 return -ENOMEM;
> 
> +       cdnsp_ring_init(pdev, pep->ring);
> +
>         pep->skip = false;
> 
>         /* Fill the endpoint context */
> @@ -1094,28 +1092,6 @@ void cdnsp_mem_cleanup(struct cdnsp_device *pdev)
>         pdev->active_port = NULL;
>  }
> 
> -static void cdnsp_set_event_deq(struct cdnsp_device *pdev)
> -{
> -       dma_addr_t deq;
> -       u64 temp;
> -
> -       deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> -                                   pdev->event_ring->dequeue);
> -
> -       /* Update controller event ring dequeue pointer */
> -       temp = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> -       temp &= ERST_PTR_MASK;
> -
> -       /*
> -        * Don't clear the EHB bit (which is RW1C) because
> -        * there might be more events to service.
> -        */
> -       temp &= ~ERST_EHB;
> -
> -       cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
> -                      &pdev->ir_set->erst_dequeue);
> -}
> -
>  static void cdnsp_add_in_port(struct cdnsp_device *pdev,
>                               struct cdnsp_port *port,
>                               __le32 __iomem *addr)
> @@ -1224,6 +1200,36 @@ static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev)
>         return 0;
>  }
> 
> +static void cdnsp_initialize_ring_segments(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
> +{
> +       struct cdnsp_segment *seg;
> +
> +       /* Only event ring does not use link TRB. */
> +       if (ring->type == TYPE_EVENT)
> +               return;
> +
> +       seg = ring->first_seg;
> +
> +       while (seg) {
> +               struct cdnsp_segment *next = seg->next;
> +
> +               cdnsp_link_segments(pdev, seg, next, ring->type);
> +               if (next == ring->first_seg)
> +                       break;
> +
> +               seg = next;
> +       }
> +
> +       ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |= cpu_to_le32(LINK_TOGGLE);
> +}
> +
> +void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
> +{
> +       cdnsp_initialize_ring_segments(pdev, ring);
> +       cdnsp_initialize_ring_info(ring);
> +       trace_cdnsp_ring_alloc(ring);
> +}
> +
>  /*
>   * Initialize memory for CDNSP (one-time init).
>   *
> @@ -1235,10 +1241,8 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>  {
>         struct device *dev = pdev->dev;
>         int ret = -ENOMEM;
> -       unsigned int val;
>         dma_addr_t dma;
>         u32 page_size;
> -       u64 val_64;
> 
>         /*
>          * Use 4K pages, since that's common and the minimum the
> @@ -1246,10 +1250,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>          */
>         page_size = 1 << 12;
> 
> -       val = readl(&pdev->op_regs->config_reg);
> -       val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
> -       writel(val, &pdev->op_regs->config_reg);
> -
>         /*
>          * Doorbell array must be physically contiguous
>          * and 64-byte (cache line) aligned.
> @@ -1261,8 +1261,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> 
>         pdev->dcbaa->dma = dma;
> 
> -       cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
> -
>         /*
>          * Initialize the ring segment pool.  The ring must be a contiguous
>          * structure comprised of TRBs. The TRBs must be 16 byte aligned,
> @@ -1288,17 +1286,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>         if (!pdev->cmd_ring)
>                 goto destroy_device_pool;
> 
> -       /* Set the address in the Command Ring Control register */
> -       val_64 = cdnsp_read_64(&pdev->op_regs->cmd_ring);
> -       val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
> -                (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
> -                pdev->cmd_ring->cycle_state;
> -       cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
> -
> -       val = readl(&pdev->cap_regs->db_off);
> -       val &= DBOFF_MASK;
> -       pdev->dba = (void __iomem *)pdev->cap_regs + val;
> -
>         /* Set ir_set to interrupt register set 0 */
>         pdev->ir_set = &pdev->run_regs->ir_set[0];
> 
> @@ -1315,21 +1302,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
>         if (ret)
>                 goto free_event_ring;
> 
> -       /* Set ERST count with the number of entries in the segment table. */
> -       val = readl(&pdev->ir_set->erst_size);
> -       val &= ERST_SIZE_MASK;
> -       val |= ERST_NUM_SEGS;
> -       writel(val, &pdev->ir_set->erst_size);
> -
> -       /* Set the segment table base address. */
> -       val_64 = cdnsp_read_64(&pdev->ir_set->erst_base);
> -       val_64 &= ERST_PTR_MASK;
> -       val_64 |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
> -       cdnsp_write_64(val_64, &pdev->ir_set->erst_base);
> -
> -       /* Set the event ring dequeue address. */
> -       cdnsp_set_event_deq(pdev);
> -
>         ret = cdnsp_setup_port_arrays(pdev);
>         if (ret)
>                 goto free_erst;
> 
> ---
> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> change-id: 20260723-suspend_resume_fix-bfd5327d52aa
> 
> Best regards,
> --
> Pawel Laszczak <pawell@cadence.com>
> 
> 
