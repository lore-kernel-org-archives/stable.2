Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023114.outbound.protection.outlook.com [40.107.44.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9833D1AB3;
	Wed, 19 Aug 2026 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123378; cv=fail; b=rr83L80QnYePfwS954bl6uxHZM0m4uou7m5azPa+pe3mk5ncXMY7di1BxDUE2r6tvq6+e6KL3roVqR4Q1wzbp5WjXV+/boRTpw16dbEKSOhqiHQYnugnWW6iM57k+3jz8lEEy2f2L8gUo8XyFTStXTcJ+G/I8G7W4RLAG8hcixY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123378; c=relaxed/simple;
	bh=lki4tkX5vKH0l0qyR/qTxcpB1w9Fd0aHeidD+5JDRj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv+l0wZITvqsKeD062K6dM2ddR4vwa1y+OjVovkMpTS32bT06sTTcjUJ/IgfBaXv5R6MFOIEh3ZPNSsDkLw1cVRTjXVYtS6I6PHOMg117UnN4fhoDShy+sRiHInR9EdbKHliYZAC4BTBAK0zBjCfzYlgnKUMqvT3RbBpctckGSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4KAd5d1W8SibQ6u12QND67OyN9eVD7xTYexcuqBxyG6NMQ2gQCWj6pK/M5KhpNcRp1K4nOIiKFk3TIdh2tpkEOJzGWIOG2xbgt4ag63UbxVb17CD9QbS95yjItJrIcAoaFZI6bjOGC1Y1I2/1BE/C6hvLaDgODpkg870NJhJSXHqTeHARuyJxz+0ii6xmYl03DNitLzpFxnTxeuV+MQKlmvb8qhd/Qf0oFLHVJf3mdvBds8b2Xfy/p4e8CmpLp6MaKOTvMQJVHAi9XiG5+0hV2sVSF01D2TXoLlFtIq4CYUKqn6k7KlQY/nNvM2cyDfL4DtCh0aSaZ5i/RU+gtfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O+I8ZYrFoEmTzoN8Nq4ccyW1LGizQcZXqSvNOwMLJ4=;
 b=le18uSatDPXrNh32XXY1h5uK5IEPFfucQmXWOa1QubSW66k8bX0Xqrmk6TUl677VwcTfHqOIu8mfNJQbVWznwCXIDjq+sRZ4by4cVnkpFGQwVeyn3QdzC1KjjFbrY7BS1oxib+6525PNTAUpzMhJQen0nP4igsolk+Ucb9kEdwf36aYvt4dg03uLFe7aHNwhbKUMee5f8B/SlexAEs8NcjpKz/MiyvjM+gXdThzYh1G98U336KxA95XPv158uHi2xg5rff3OHSiHKdTCQt1nU+q5MB7VVqxjYkSEyRj5dF7QhFTTAwNLifZqNW9GPBSfxLQmKV4/bEgwZQ0LcneNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TY4P286CA0093.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:369::9)
 by SEYPR06MB8124.apcprd06.prod.outlook.com (2603:1096:101:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 07:09:31 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:405:369:cafe::42) by TY4P286CA0093.outlook.office365.com
 (2603:1096:405:369::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 07:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 07:09:30 +0000
Received: from gary-System-Product-Name (unknown [172.16.64.196])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 28826427CEE3;
	Wed, 19 Aug 2026 15:09:29 +0800 (CST)
Date: Wed, 19 Aug 2026 15:09:28 +0800
From: "gary.yang@cixtech.com" <gary.yang@cixtech.com>
To: Pawel Laszczak <pawell@cadence.com>
Cc: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: RE: [PATCH v2] usb: cdnsp: fix wakeup from S3 after controller
 context loss
Message-ID: <aoVWqOM3cAfg5QRz@gary-System-Product-Name>
References: <20260818-suspend_resume_fix-v2-1-4750091943df@cadence.com>
 <aoUef79PQPB0CfiC@hu-petche-lv.qualcomm.com>
 <LV5PR07MB11354FFD5A02F4B2A6ED05060DDA52@LV5PR07MB11354.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV5PR07MB11354FFD5A02F4B2A6ED05060DDA52@LV5PR07MB11354.namprd07.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|SEYPR06MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f0e995-3cf4-43bf-a1f3-08defdc0d07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|56012099006|3023799007|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nWYiLwlEv2PtkFfKZkVK8ULZzGEW4Rg6EBUdpnfSv+hti7f5VRDSV5ieXzZW2OsfjZ4OIX+H5FNdORs9jAERQGRcPk4lG+VPWSkIxsGbz1YcGS/uiTJAWTcFpg5VJTN4ifGu1aEv/bsTtqUVo3lQ28SqKbhd/BvhFmzsjBTdRLs5YsE/8tzV1ZSj4tkOuNEy+KdvL576ro6Up+IY0ME5I5Mb9eVYd/GTjYn7c5fQO3wl5KS9mJtxaX5VdgqSeQuYnmcThWkQN93XKuNFnim2iYmm1Ab6wxkdHU9FMFXBIuSl6KceZG3+cahf+oxCAFXEqJ9TcNTqiO6bPs2btc2x99Gy+w/waeYyqMAlDC7WN44cq9fiV5i9LA4OevLRdtzU1WYi9tJqPCa7+z74wCOS1N4L5FsS7Ik5MtNuyhqdLoqOqam5XVFdVJRU5KEytrfXm5uBmDyYU49hE4UdlMtDMVpsuRKimi0gaBlh2kgLqja9MqP5ZmFsuvpGJXEXuO9xx4DU4pdC/pYh1k/GEUZNPELSJ0/s9ucXhWpFLm9RiYZc63mkVhdFoAA8L9/5K1V9OKgR8jhjYJZVaH28chCsrPmDuIWJdUA+YIDwep5/CWVzZjGMiCWH4ZFjRMIKtGXfgVdoJW0P3K9rrmmuASaP04ObL1miZhEWazRE8dDjOD6qQ46QeNgm0AhEAfpYzxjxSHQ28gT/fV75n/FWFQoYnA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	54CVumwJ00eP0+1E+Ue++LzmaKIuh4vg/JzH/cHpJoAOKXqcF15Fmk4K5Sh7mzq0fGRZ77nvSElNX7zitBu0DOlXtwsjUW9lKedwoM3Ecuy0K8yoOSWbh2iInT3WOAYw1wo5RWSFW/hKwUMjx9yiSzPipYtnFwcBI2JLKgyxmorRiMdQVpqCJz6M/2aJcgF824iB2qeRqvQVBePqpAAStzKdmTUU9zghsgtSnD1kjbLiPQMPFE66V0P+fXqwZ1cICjkiNgJInILn979BXQWAC6E7+JTJQJ7LCqbq0HihqW9pYLNgRXpWJorlJ6yT+J7cr8I86l8vPt+h1VZcpJu2Ax53L+ETjIsOj1D1/JhsD9IO8SuFed6YoK43zJJUtQQiyLKwQOYDRXD+wDf+sLuBbJpDwP9EyIqwZR21w+7MsoBVo9mhRM7weiv0pllXxVh5
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 07:09:30.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f0e995-3cf4-43bf-a1f3-08defdc0d07b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8124

On 2026-08-19 05:46, Pawel Laszczak wrote:

> EXTERNAL EMAIL
> 
> >
> >On 26-08-18 12:29:29, Pawel Laszczak via B4 Relay wrote:
> >> From: Pawel Laszczak <pawell@cadence.com>
> >>
> >> CDNSP controller may lose its runtime register programming across S3
> >> suspend/resume, depending on SoC power domain configuration. After
> >> resume the operational and interrupter registers may contain reset
> >> values, which prevents the gadget side from recovering correctly and
> >> breaks wakeup from S3.
> >>
> >> On SoCs where the controller retains power during S3, the registers
> >> are preserved and a Controller Restore State (CRS) sequence is used
> >> instead of full reinitialization.
> >>
> >> Fix this by detecting whether the controller lost its register context
> >> after resume and handling both cases:
> >> - If context was lost (CFG_3XPORT_U1_PIPE_CLK_GATE_EN set or power
> >>   lost): reprogram the controller state required for normal operation,
> >>   including the command ring, DCBAA pointer, doorbell base, event ring,
> >>   ERST base/size and event ring dequeue pointer.
> >> - If context was retained: restore saved registers and initiate
> >>   Controller Restore State (CRS).
> >>
> >> Move the basic controller register programming out of the one-time
> >> memory initialization path and make it reusable from the resume path.
> >> Also separate ring allocation from ring initialization so that rings
> >> can be reinitialized without reallocating DMA memory.
> >>
> >> Always perform the full suspend sequence regardless of the current
> >> link state. Previously, if the device was already in U3, the suspend
> >> callback returned early without saving registers or stopping the
> >> controller, which could lead to commands being issued on a disabled slot
> >during resume.
> >>
> >> This fixes S3 resume on systems where the controller register context
> >> is lost, while keeping the existing DMA allocations intact.
> >>
> >> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
> >> USBSSP DRD Driver")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >
> >
> >The changes in this patch are big, do we really need to apply it from the cdns
> >USB SSP introduced? How about just apply it from #v7.2?
> >
> >After Gary Yang tests this patch, I am okay with it.
> 
> Hi Peter,
> 
> Regarding the stable backport question: I would argue that keeping
> Cc: stable@vger.kernel.org is appropriate here, because this is a real
> bug - not an enhancement. Without this fix, the driver hangs after S3
> resume on SoCs where the controller loses power during suspend.
> The stable maintainers will make the final call on whether to accept
> it into stable trees, but we should not prevent them from considering it.
> 
> The analogous context save/restore pattern already exists on the host
> side for the same reason - context loss after S3 is a
> class of bugs that the USB subsystem explicitly handles. This is
> consistent with that approach.
> 
> I agree the change is large. The size is a consequence of separating
> ring allocation from ring initialization (required to reinitialize
> rings without reallocating DMA memory on resume) and extracting the
> one-time register programming into a reusable cdnsp_init(). Without
> this restructuring, the resume path would have duplicated a significant
> amount of initialization code.
> 
> Thanks,
> Pawel
> 

I understand Peter's concern. For USB controllers on Xinchi P1, wakeup support is required, so the USB controller must remain powered during STR.

Given that USB controllers stays powered throughout STR, is the save/restore operation still necessary? If not, should we add corresponding condition checks?

Besides, we are working on patch validation. However, the changes are big and there are merge‑conflicts, so it will take some time.

Best Regards,
Gary

> >
> >Peter
> >
> >> ---
> >> Changes in v2:
> >> - Clarify commit message to reflect SoC-dependent context loss
> >> behavior
> >> - Fix cdnsp_irq_handler: return IRQ_HANDLED instead of IRQ_NONE when
> >> in_lpm is set
> >> - Fix suspend: always perform full suspend sequence regardless of link
> >> state
> >> ---
> >> Changes in v2:
> >> - Clarify commit message to reflect SoC-dependent context loss
> >> behavior
> >> - Removed in_lpm from cdnsp_irq_handler - the code is unnecessary
> >> - Fix suspend: always perform full suspend sequence regardless of link
> >> state
> >> ---
> >>  drivers/usb/cdns3/cdnsp-gadget.c | 183
> >> +++++++++++++++++++++++++++++++++++++--
> >>  drivers/usb/cdns3/cdnsp-gadget.h |  31 +++++++
> >>  drivers/usb/cdns3/cdnsp-mem.c    |  98 ++++++++-------------
> >>  3 files changed, 243 insertions(+), 69 deletions(-)
> >>
> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
> >> b/drivers/usb/cdns3/cdnsp-gadget.c
> >> index a5275c2fb43b..67b265b456a9 100644
> >> --- a/drivers/usb/cdns3/cdnsp-gadget.c
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
> >> @@ -1338,7 +1338,6 @@ static int cdnsp_run(struct cdnsp_device *pdev,
> >>
> >>      cdnsp_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
> >>
> >> -
> >>      ret = cdnsp_start(pdev);
> >>      if (ret) {
> >>              ret = -ENODEV;
> >> @@ -1837,6 +1836,82 @@ static void cdnsp_get_rev_cap(struct cdnsp_device
> >*pdev)
> >>               readl(&pdev->rev_cap->tx_buff_size));
> >>  }
> >>
> >> +static void cdnsp_set_event_deq(struct cdnsp_device *pdev) {
> >> +    dma_addr_t deq;
> >> +    u64 temp;
> >> +
> >> +    deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> >> +                                pdev->event_ring->dequeue);
> >> +
> >> +    /* Update controller event ring dequeue pointer */
> >> +    temp = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> >> +    temp &= ERST_PTR_MASK;
> >> +
> >> +    /*
> >> +     * Don't clear the EHB bit (which is RW1C) because
> >> +     * there might be more events to service.
> >> +     */
> >> +    temp &= ~ERST_EHB;
> >> +
> >> +    cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
> >> +                   &pdev->ir_set->erst_dequeue); }
> >> +
> >> +static void cdnsp_add_interrupter(struct cdnsp_device *pdev) {
> >> +    u64 erst_base;
> >> +    u32 erst_size;
> >> +
> >> +    /* Set ERST count with the number of entries in the segment table. */
> >> +    erst_size = readl(&pdev->ir_set->erst_size);
> >> +    erst_size &= ERST_SIZE_MASK;
> >> +    erst_size |= ERST_NUM_SEGS;
> >> +    writel(erst_size, &pdev->ir_set->erst_size);
> >> +
> >> +    /* Set the segment table base address. */
> >> +    erst_base = cdnsp_read_64(&pdev->ir_set->erst_base);
> >> +    erst_base &= ERST_PTR_MASK;
> >> +    erst_base |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
> >> +    cdnsp_write_64(erst_base, &pdev->ir_set->erst_base);
> >> +
> >> +    /* Set the event ring dequeue address. */
> >> +    cdnsp_set_event_deq(pdev);
> >> +}
> >> +
> >> +/* Set up basic CDNSP registers */
> >> +static void cdnsp_init(struct cdnsp_device *pdev) {
> >> +    unsigned int val;
> >> +    u64 val_64;
> >> +
> >> +    val = readl(&pdev->op_regs->config_reg);
> >> +    val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
> >> +    writel(val, &pdev->op_regs->config_reg);
> >> +
> >> +    /* Initialize the Command ring */
> >> +    cdnsp_ring_init(pdev, pdev->cmd_ring);
> >> +
> >> +    /* Set the address in the Command Ring Control register */
> >> +    val_64 = cdnsp_read_64(&pdev->op_regs->cmd_ring);
> >> +    val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
> >> +             (pdev->cmd_ring->first_seg->dma &
> >(u64)~CMD_RING_RSVD_BITS) |
> >> +             pdev->cmd_ring->cycle_state;
> >> +    cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
> >> +
> >> +    /* Set Device Context Base Address Array pointer */
> >> +    cdnsp_write_64(pdev->dcbaa->dma, &pdev->op_regs->dcbaa_ptr);
> >> +
> >> +    /* Set Doorbell array pointer */
> >> +    val = readl(&pdev->cap_regs->db_off);
> >> +    val &= DBOFF_MASK;
> >> +    pdev->dba = (void __iomem *)pdev->cap_regs + val;
> >> +
> >> +    /* Initialize the Primary interrupter */
> >> +    cdnsp_ring_init(pdev, pdev->event_ring);
> >> +    cdnsp_add_interrupter(pdev);
> >> +}
> >> +
> >>  static int cdnsp_gen_setup(struct cdnsp_device *pdev)  {
> >>      int ret;
> >> @@ -1902,6 +1977,8 @@ static int cdnsp_gen_setup(struct cdnsp_device
> >*pdev)
> >>      if (ret)
> >>              return ret;
> >>
> >> +    cdnsp_init(pdev);
> >> +
> >>      /*
> >>       * Software workaround for U1: after transition
> >>       * to U1 the controller starts gating clock, and in some cases, @@
> >> -2026,20 +2103,62 @@ static void cdnsp_gadget_exit(struct cdns *cdns)
> >>      cdns_drd_gadget_off(cdns);
> >>  }
> >>
> >> +static void cdnsp_save_registers(struct cdnsp_device *pdev) {
> >> +    struct cdnsp_s3_save *s3 = &pdev->s3;
> >> +
> >> +    s3->command = readl(&pdev->op_regs->command);
> >> +    s3->dnctrl = readl(&pdev->op_regs->dnctrl);
> >> +    s3->dcbaa_ptr = cdnsp_read_64(&pdev->op_regs->dcbaa_ptr);
> >> +    s3->config_reg = readl(&pdev->op_regs->config_reg);
> >> +    s3->s3_erst_size = readl(&pdev->ir_set->erst_size);
> >> +    s3->s3_erst_base = cdnsp_read_64(&pdev->ir_set->erst_base);
> >> +    s3->s3_erst_dequeue = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> >> +    s3->s3_irq_pending = readl(&pdev->ir_set->irq_pending);
> >> +    s3->s3_irq_control = readl(&pdev->ir_set->irq_control);
> >> +}
> >> +
> >> +static void cdnsp_restore_registers(struct cdnsp_device *pdev) {
> >> +    struct cdnsp_s3_save *s3 = &pdev->s3;
> >> +
> >> +    writel(s3->command, &pdev->op_regs->command);
> >> +    writel(s3->dnctrl, &pdev->op_regs->dnctrl);
> >> +    cdnsp_write_64(s3->dcbaa_ptr, &pdev->op_regs->dcbaa_ptr);
> >> +    writel(s3->config_reg, &pdev->op_regs->config_reg);
> >> +    writel(s3->s3_erst_size, &pdev->ir_set->erst_size);
> >> +    cdnsp_write_64(s3->s3_erst_base, &pdev->ir_set->erst_base);
> >> +    cdnsp_write_64(s3->s3_erst_dequeue, &pdev->ir_set->erst_dequeue);
> >> +    writel(s3->s3_irq_pending, &pdev->ir_set->irq_pending);
> >> +    writel(s3->s3_irq_control, &pdev->ir_set->irq_control); }
> >> +
> >>  static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)  {
> >>      struct cdnsp_device *pdev = cdns->gadget_dev;
> >>      unsigned long flags;
> >> -
> >> -    if (pdev->link_state == XDEV_U3)
> >> -            return 0;
> >> +    u32 val;
> >> +    int ret;
> >>
> >>      spin_lock_irqsave(&pdev->lock, flags);
> >>      cdnsp_disconnect_gadget(pdev);
> >>      cdnsp_stop(pdev);
> >> +
> >> +    cdnsp_save_registers(pdev);
> >> +
> >> +    val = readl(&pdev->op_regs->command);
> >> +    val |= CMD_CSS;
> >> +    writel(val, &pdev->op_regs->command);
> >> +
> >> +    ret = readl_poll_timeout_atomic(&pdev->op_regs->status, val,
> >> +                                    !(val & STS_SSS), 1,
> >> +                                    20 * 1000);
> >> +    if (ret)
> >> +            ret = -EIO;
> >> +
> >>      spin_unlock_irqrestore(&pdev->lock, flags);
> >>
> >> -    return 0;
> >> +    return ret;
> >>  }
> >>
> >>  static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power) @@
> >> -2047,12 +2166,63 @@ static int cdnsp_gadget_resume(struct cdns *cdns,
> >bool lost_power)
> >>      struct cdnsp_device *pdev = cdns->gadget_dev;
> >>      enum usb_device_speed max_speed;
> >>      unsigned long flags;
> >> +    bool wakeup = false;
> >> +    u32 val;
> >>      int ret;
> >>
> >>      if (!pdev->gadget_driver)
> >>              return 0;
> >>
> >>      spin_lock_irqsave(&pdev->lock, flags);
> >> +    val = readl(&pdev->port3x_regs->mode_2);
> >> +
> >> +    if (val & CFG_3XPORT_U1_PIPE_CLK_GATE_EN || lost_power) {
> >> +            cdnsp_halt(pdev);
> >> +            cdnsp_set_apb_timeout_value(pdev);
> >> +
> >> +            /* Reset the internal controller memory state and registers. */
> >> +            ret = cdnsp_reset(pdev);
> >> +            if (ret)
> >> +                    goto unlock;
> >> +
> >> +            val = readl(&pdev->port3x_regs->mode_2);
> >> +            val &= ~CFG_3XPORT_U1_PIPE_CLK_GATE_EN;
> >> +            writel(val, &pdev->port3x_regs->mode_2);
> >> +
> >> +            cdnsp_clear_cmd_ring(pdev);
> >> +
> >> +            memset(pdev->event_ring->first_seg->trbs, 0,
> >> +                   sizeof(union cdnsp_trb) * (TRBS_PER_SEGMENT));
> >> +
> >> +            cdnsp_init(pdev);
> >> +    } else {
> >> +            ret = readl_poll_timeout_atomic(&pdev->op_regs->status, val,
> >> +                                            !(val & STS_CNR), 1,
> >> +                                            10 * 1000 * 1000);
> >> +            if (ret) {
> >> +                    dev_err(pdev->dev, "ERROR: Controller not ready to
> >work\n");
> >> +                    spin_unlock_irqrestore(&pdev->lock, flags);
> >> +                    return ret;
> >> +            }
> >> +
> >> +            cdnsp_restore_registers(pdev);
> >> +
> >> +            /* Initiate Controller Restore State (CRS) */
> >> +            val = readl(&pdev->op_regs->command);
> >> +            val |= CMD_CRS;
> >> +            writel(val, &pdev->op_regs->command);
> >> +
> >> +            ret = readl_poll_timeout_atomic(&pdev->op_regs->status, val,
> >> +                                            !(val & STS_RSS), 1, 100000);
> >> +            if (ret) {
> >> +                    dev_err(pdev->dev, "Restore state did not complete
> >(timeout)\n");
> >> +                    ret = -ETIMEDOUT;
> >> +                    goto unlock;
> >> +            }
> >> +
> >> +            wakeup = true;
> >> +    }
> >> +
> >>      max_speed = pdev->gadget_driver->max_speed;
> >>
> >>      /* Limit speed if necessary. */
> >> @@ -2060,9 +2230,10 @@ static int cdnsp_gadget_resume(struct cdns
> >> *cdns, bool lost_power)
> >>
> >>      ret = cdnsp_run(pdev, max_speed);
> >>
> >> -    if (pdev->link_state == XDEV_U3)
> >> +    if (pdev->link_state == XDEV_U3 && wakeup)
> >>              __cdnsp_gadget_wakeup(pdev);
> >>
> >> +unlock:
> >>      spin_unlock_irqrestore(&pdev->lock, flags);
> >>
> >>      return ret;
> >> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
> >> b/drivers/usb/cdns3/cdnsp-gadget.h
> >> index c44bca348a41..6c45fd3e4a9d 100644
> >> --- a/drivers/usb/cdns3/cdnsp-gadget.h
> >> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
> >> @@ -1353,6 +1353,34 @@ struct cdnsp_port {
> >>  #define CDNSP_EXT_PORT_OFF(x)               ((x) & 0xff)
> >>  #define CDNSP_EXT_PORT_COUNT(x)             (((x) >> 8) & 0xff)
> >>
> >> +/**
> >> + * struct cdnsp_s3_save - register context saved before S3 suspend.
> >> + * @command: Saved USB command register value.
> >> + * @dnctrl: Saved device notification control register value.
> >> + * @dcbaa_ptr: Saved Device Context Base Address Array pointer.
> >> + * @config_reg: Saved configuration register value.
> >> + * @s3_irq_pending: Saved interrupter pending register value.
> >> + * @s3_irq_control: Saved interrupter control register value.
> >> + * @s3_erst_size: Saved Event Ring Segment Table size.
> >> + * @s3_erst_base: Saved Event Ring Segment Table base address.
> >> + * @s3_erst_dequeue: Saved Event Ring Dequeue Pointer.
> >> + *
> >> + * Stores the controller register state that may be lost across S3
> >> + * suspend/resume. The saved values are used to restore the CDNSP
> >> + * operational and interrupter register programming after resume.
> >> + */
> >> +struct cdnsp_s3_save {
> >> +    u32     command;
> >> +    u32     dnctrl;
> >> +    u64     dcbaa_ptr;
> >> +    u32     config_reg;
> >> +    u32     s3_irq_pending;
> >> +    u32     s3_irq_control;
> >> +    u32     s3_erst_size;
> >> +    u64     s3_erst_base;
> >> +    u64     s3_erst_dequeue;
> >> +};
> >> +
> >>  /**
> >>   * struct cdnsp_device - represent USB device.
> >>   * @dev: Pointer to device structure associated whit this controller.
> >> @@ -1388,6 +1416,7 @@ struct cdnsp_port {
> >>   * @cmd: Represent all what is needed to issue command on Command
> >Ring.
> >>   * @event_ring: Event ring.
> >>   * @erst: Event Ring Segment table
> >> + * @s3:  Register values saved before entering S3.
> >>   * @slot_id: Current Slot ID. Should be 0 or 1.
> >>   * @out_ctx: Output context.
> >>   * @in_ctx: Input context.
> >> @@ -1447,6 +1476,7 @@ struct cdnsp_device {
> >>      struct cdnsp_command cmd;
> >>      struct cdnsp_ring *event_ring;
> >>      struct cdnsp_erst erst;
> >> +    struct cdnsp_s3_save s3;
> >>      int slot_id;
> >>
> >>      /*
> >> @@ -1510,6 +1540,7 @@ int cdnsp_endpoint_init(struct cdnsp_device
> >> *pdev,  int cdnsp_ring_expansion(struct cdnsp_device *pdev,
> >>                       struct cdnsp_ring *ring,
> >>                       unsigned int num_trbs, gfp_t flags);
> >> +void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring
> >> +*ring);
> >>  struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *ep,
> >> u64 address);  int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
> >>                          struct cdnsp_ep *pep,
> >> diff --git a/drivers/usb/cdns3/cdnsp-mem.c
> >> b/drivers/usb/cdns3/cdnsp-mem.c index 5d8cdc91927d..0be917f52bbb
> >> 100644
> >> --- a/drivers/usb/cdns3/cdnsp-mem.c
> >> +++ b/drivers/usb/cdns3/cdnsp-mem.c
> >> @@ -394,13 +394,6 @@ static struct cdnsp_ring *cdnsp_ring_alloc(struct
> >cdnsp_device *pdev,
> >>      if (ret)
> >>              goto fail;
> >>
> >> -    /* Only event ring does not use link TRB. */
> >> -    if (type != TYPE_EVENT)
> >> -            ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> >> -                    cpu_to_le32(LINK_TOGGLE);
> >> -
> >> -    cdnsp_initialize_ring_info(ring);
> >> -    trace_cdnsp_ring_alloc(ring);
> >>      return ring;
> >>  fail:
> >>      kfree(ring);
> >> @@ -603,6 +596,7 @@ int cdnsp_alloc_stream_info(struct cdnsp_device
> >*pdev,
> >>              if (!cur_ring)
> >>                      goto cleanup_rings;
> >>
> >> +            cdnsp_ring_init(pdev, cur_ring);
> >>              cur_ring->stream_id = cur_stream;
> >>              cur_ring->trb_address_map = &stream_info-
> >>trb_address_map;
> >>
> >> @@ -696,6 +690,8 @@ static int cdnsp_alloc_priv_device(struct cdnsp_device
> >*pdev)
> >>      if (!pdev->eps[0].ring)
> >>              goto fail;
> >>
> >> +    cdnsp_ring_init(pdev, pdev->eps[0].ring);
> >> +
> >>      /* Point to output device context in dcbaa. */
> >>      pdev->dcbaa->dev_context_ptrs[1] = cpu_to_le64(pdev->out_ctx.dma);
> >>      pdev->cmd.in_ctx = &pdev->in_ctx;
> >> @@ -989,6 +985,8 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
> >>      if (!pep->ring)
> >>              return -ENOMEM;
> >>
> >> +    cdnsp_ring_init(pdev, pep->ring);
> >> +
> >>      pep->skip = false;
> >>
> >>      /* Fill the endpoint context */
> >> @@ -1094,28 +1092,6 @@ void cdnsp_mem_cleanup(struct cdnsp_device
> >*pdev)
> >>      pdev->active_port = NULL;
> >>  }
> >>
> >> -static void cdnsp_set_event_deq(struct cdnsp_device *pdev) -{
> >> -    dma_addr_t deq;
> >> -    u64 temp;
> >> -
> >> -    deq = cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> >> -                                pdev->event_ring->dequeue);
> >> -
> >> -    /* Update controller event ring dequeue pointer */
> >> -    temp = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
> >> -    temp &= ERST_PTR_MASK;
> >> -
> >> -    /*
> >> -     * Don't clear the EHB bit (which is RW1C) because
> >> -     * there might be more events to service.
> >> -     */
> >> -    temp &= ~ERST_EHB;
> >> -
> >> -    cdnsp_write_64(((u64)deq & (u64)~ERST_PTR_MASK) | temp,
> >> -                   &pdev->ir_set->erst_dequeue);
> >> -}
> >> -
> >>  static void cdnsp_add_in_port(struct cdnsp_device *pdev,
> >>                            struct cdnsp_port *port,
> >>                            __le32 __iomem *addr)
> >> @@ -1224,6 +1200,36 @@ static int cdnsp_setup_port_arrays(struct
> >cdnsp_device *pdev)
> >>      return 0;
> >>  }
> >>
> >> +static void cdnsp_initialize_ring_segments(struct cdnsp_device *pdev,
> >> +struct cdnsp_ring *ring) {
> >> +    struct cdnsp_segment *seg;
> >> +
> >> +    /* Only event ring does not use link TRB. */
> >> +    if (ring->type == TYPE_EVENT)
> >> +            return;
> >> +
> >> +    seg = ring->first_seg;
> >> +
> >> +    while (seg) {
> >> +            struct cdnsp_segment *next = seg->next;
> >> +
> >> +            cdnsp_link_segments(pdev, seg, next, ring->type);
> >> +            if (next == ring->first_seg)
> >> +                    break;
> >> +
> >> +            seg = next;
> >> +    }
> >> +
> >> +    ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
> >> +cpu_to_le32(LINK_TOGGLE); }
> >> +
> >> +void cdnsp_ring_init(struct cdnsp_device *pdev, struct cdnsp_ring
> >> +*ring) {
> >> +    cdnsp_initialize_ring_segments(pdev, ring);
> >> +    cdnsp_initialize_ring_info(ring);
> >> +    trace_cdnsp_ring_alloc(ring);
> >> +}
> >> +
> >>  /*
> >>   * Initialize memory for CDNSP (one-time init).
> >>   *
> >> @@ -1235,10 +1241,8 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> >> {
> >>      struct device *dev = pdev->dev;
> >>      int ret = -ENOMEM;
> >> -    unsigned int val;
> >>      dma_addr_t dma;
> >>      u32 page_size;
> >> -    u64 val_64;
> >>
> >>      /*
> >>       * Use 4K pages, since that's common and the minimum the @@ -
> >1246,10
> >> +1250,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> >>       */
> >>      page_size = 1 << 12;
> >>
> >> -    val = readl(&pdev->op_regs->config_reg);
> >> -    val |= ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
> >> -    writel(val, &pdev->op_regs->config_reg);
> >> -
> >>      /*
> >>       * Doorbell array must be physically contiguous
> >>       * and 64-byte (cache line) aligned.
> >> @@ -1261,8 +1261,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> >>
> >>      pdev->dcbaa->dma = dma;
> >>
> >> -    cdnsp_write_64(dma, &pdev->op_regs->dcbaa_ptr);
> >> -
> >>      /*
> >>       * Initialize the ring segment pool.  The ring must be a contiguous
> >>       * structure comprised of TRBs. The TRBs must be 16 byte aligned, @@
> >> -1288,17 +1286,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> >>      if (!pdev->cmd_ring)
> >>              goto destroy_device_pool;
> >>
> >> -    /* Set the address in the Command Ring Control register */
> >> -    val_64 = cdnsp_read_64(&pdev->op_regs->cmd_ring);
> >> -    val_64 = (val_64 & (u64)CMD_RING_RSVD_BITS) |
> >> -             (pdev->cmd_ring->first_seg->dma &
> >(u64)~CMD_RING_RSVD_BITS) |
> >> -             pdev->cmd_ring->cycle_state;
> >> -    cdnsp_write_64(val_64, &pdev->op_regs->cmd_ring);
> >> -
> >> -    val = readl(&pdev->cap_regs->db_off);
> >> -    val &= DBOFF_MASK;
> >> -    pdev->dba = (void __iomem *)pdev->cap_regs + val;
> >> -
> >>      /* Set ir_set to interrupt register set 0 */
> >>      pdev->ir_set = &pdev->run_regs->ir_set[0];
> >>
> >> @@ -1315,21 +1302,6 @@ int cdnsp_mem_init(struct cdnsp_device *pdev)
> >>      if (ret)
> >>              goto free_event_ring;
> >>
> >> -    /* Set ERST count with the number of entries in the segment table. */
> >> -    val = readl(&pdev->ir_set->erst_size);
> >> -    val &= ERST_SIZE_MASK;
> >> -    val |= ERST_NUM_SEGS;
> >> -    writel(val, &pdev->ir_set->erst_size);
> >> -
> >> -    /* Set the segment table base address. */
> >> -    val_64 = cdnsp_read_64(&pdev->ir_set->erst_base);
> >> -    val_64 &= ERST_PTR_MASK;
> >> -    val_64 |= (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
> >> -    cdnsp_write_64(val_64, &pdev->ir_set->erst_base);
> >> -
> >> -    /* Set the event ring dequeue address. */
> >> -    cdnsp_set_event_deq(pdev);
> >> -
> >>      ret = cdnsp_setup_port_arrays(pdev);
> >>      if (ret)
> >>              goto free_erst;
> >>
> >> ---
> >> base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
> >> change-id: 20260723-suspend_resume_fix-bfd5327d52aa
> >>
> >> Best regards,
> >> --
> >> Pawel Laszczak <pawell@cadence.com>
> >>
> >>
> >
> >--
> >
> >Thanks,
> >Peter Chen
