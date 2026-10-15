Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021083.outbound.protection.outlook.com [40.107.74.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D73EEAC1;
	Thu, 15 Oct 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036240; cv=fail; b=t6b0drRWwBDM9TsqtYUVuOOpBTkknLRpYPXoQtoc7By9BTfDvbZgn9ofF1LcgugABTYQ8PYgMZP/k1eQSa5TUXjyeRBuM2jErOvACDcVdM5DPy1ppE+W5h4EEXzFtr4QOtc63Ns8pU2MdDAT5rh+8HbWOICG3DfxgJnkrlIZ7tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036240; c=relaxed/simple;
	bh=EC+slqOBoTp2OAW8ReoOCjbRM8d34Qno6BF8/yxM+xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=usVOUj55mn23TfvwDyRyGx7r8r1ll+s/TF0dwD75AfCo30g7qzSMNZI8MVCPeFxitpI7juwgWZEEYlC1KX4YR1I1lIiCiRZ4uyTB5p5grAppT+Ws6rJ4R1YptHTyAtFK6N/ndoIt6nRfH5w7x1uAUx5r8TwZrwetAu4PTqSy76c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=K+XHvg8m; arc=fail smtp.client-ip=40.107.74.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="K+XHvg8m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjM4y/4DFoT21M7zgbkC1dEBdrFlF5SIj/sKoz8Hsk4dGPB+3WGwdt8tdTgIuliHO0aO/K0xeDlqaAHRNpx8M1rvGF4ko7lYjZ/sXinucLxK7MCfe0tuMapnFwTUZ6PrvDVTZCINAKG1uCFAI31eoTqG1QKrBl0ZCBn8dlm4rXMXPcLJPYSIyNsZ15n/VVaKVHnTAYtHNDVVAu+8HnnSMGP3WPAQ15IUPjmnWBqzcuIFkg2745WXIk4Hvv6xNY2kpzVPzg5oTrEkDCwIrbqZySecYoMkzu5fdGVkGZravE40KH2RJOG55GtWSx1EBKzh7pcXsgvCUj5M2I/rRAMLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXJ9uXtwFkirb/88zvAl7Thi0BW4JyB+iRWH79wjbTQ=;
 b=UNr745mpJYgRgOkTfAlYaorp5B9q98Dwtdke2zQoawAO3FkaHuPKfuAb+pnvsJiGLD/zDyXGtr1BpJX0FU42YiLLE6XnR0qoJwoUERUNa7nHHotojE4CWVULTFPbxo0ZM11MtdXhn49o2Al+Z83loRAmMgnHdeI9SW4EwsxwCAr18g0we0ZavDXWYORL8qejKCulUD7lPmdZTXM4meYeKzKbxAEAACBolKa4kr7XyoBXPbVo6MXn+FtYeuiBLZW8mJtLkdQz+WxwK8cpwd71JSHKRMCtn3NJ2iLqJcPjFjUDRBYceOCYHbWmeQaTb6aTk5Heoyoq169eTanXbxRu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXJ9uXtwFkirb/88zvAl7Thi0BW4JyB+iRWH79wjbTQ=;
 b=K+XHvg8mZwZ5E/OPM+C+g5F3QvAqIaLQ2X8Wn2ak883muoTX+rsd1VQrpI9r8arqJbjj/bp+LPhKW24dcN7+3L8yThNygcD9WSyWc07+Nkd7SmGIiqFQ3Lotu4rMPIheGZx3Q+ZBgEV2UW//ung6x/dz0/IpNwXAwJv3SG+RmYE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7895.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 03:50:29 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 03:50:29 +0000
Date: Thu, 15 Oct 2026 12:50:28 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 06/15] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <c6zrmhs3d77424lgxbeul4237ovdrkskoapqutuaokjvuve4zz@6gh75sbdtt3b>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-7-den@valinux.co.jp>
 <cf51aeee-d951-472a-acd1-183028da966e@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf51aeee-d951-472a-acd1-183028da966e@intel.com>
X-ClientProxiedBy: TY4P301CA0114.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f249f8-1f5a-4e86-9f20-08df2a6f7441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|10070799003|366016|6133799003|10067099003|22082099003|18002099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SsEOyS1MXixe3OfJeES8OqR82Tx5ljGwQEPpzR2UnwxUENFG6ZMj2XssK44aiSdVjbRtga3Ygz1zqhdWQJGGtm4IIkVeQ/j28549YMWmTLUn5VETfdNOx844d9SYyn3S7jLMAB1bCrR6PsT/xYgrTS6FXoBUp9W6OYTPcqEz2PlJGvyorkB713rJchqSQq1JWY1jlI7wcFcHSPmOMe0dvOSdSXXUfkuQ9PBXrV+P0ck3LorHUpwv0cVxoiRx0TT4NkNvCWaoXtiwpjHmA1fyIQdc6nLRAiTSDElukJxxbvnyJWdR8mxMP0aA81uGZgeoGdwFsO0UHnFqdEU5FRpiPuCvLdpS+TOsk24s5M45KYUjNf8um/HThDLRIZY4cXTeCcg0wQ2mKEi3JRbpSRbJ046Pt60W17/r2dYziKZ43l4oDKSizrNLgNfPBtbM+/J6VzAeBbGJXHmREmv6ghxN2w9cxoAENNs8/WtnkF7KgkQi7Xc5nUi3pcPsj7+SNWcsc1PPKZnwXi4b/WerINlSjGjpS98KKKhjb2na4lT31kFNY1yt72T8m4q3kqSWSUQnxaDDxDqFHWDpZ7g9qsYDlwxwwj/A05bJ0zme2+4L9nR69L3RsUZedhey5l4ZFOKb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(10070799003)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?72Ni8ae0x9XOuOwREer9hLHY5xTUKBV46gZvDT33bLLgpl5Ce4D2jZcEh8/h?=
 =?us-ascii?Q?TsJvCxZXwAbVRd2uVZ88AoMuDZaI+4YgyD/X857tog95b1EIF9G5DvXCn6Ji?=
 =?us-ascii?Q?4jKcKiY+2gzq7e5j66Gc4mX22VIWuudCkZGTJ1JJZr1OgpJrOsyRpzLcwyjk?=
 =?us-ascii?Q?H+SPGhnh5nSvflQgZjg790LLeFwg5Ysm/FFLH3RcKZcdNekN2RoC0rwcMGdW?=
 =?us-ascii?Q?4+5+Uj26z7XK9OuAyV39bWVM+UfH7cfDZRgaV/pRMuJnOgZZbr/yqYrKqpOP?=
 =?us-ascii?Q?lEqITeMlqJAtffvosyo4RvZHj3sXf6ogO7pVwafCaoPJR0ra4mRBO0j1g68a?=
 =?us-ascii?Q?JgmNRrApt/+xGSzg+EQHexuQ2KXmS22iA+e/CnSupHZ/pCAnjZ58vRytaXLy?=
 =?us-ascii?Q?+dcMtHw6hafiLYH99u2HhlFWuvgmSnMsxaIm7FTs16LTUy9/wCZUcb91eZy+?=
 =?us-ascii?Q?hVVifzQPsqblBSiKClzhYAoL2UrQVerjzjRuDmt0vusbM7n4NAAGsFtJMFaP?=
 =?us-ascii?Q?7TVpx2tFQR9couZFwOptTr16Myk2BhE+2ZxVOr1tqBxMImpnD4R3JyLB6iH9?=
 =?us-ascii?Q?Y5wsuQqzlYL0/pLEfDeTLzT5GdjGzRu3LmI85YjhQxmxonGQaqLB9AfXSg/b?=
 =?us-ascii?Q?c5QzMI90AI2K48gxc3kLAQZcTZAtBkJLNOl8lABaksTutHsvgdI1csejQZOu?=
 =?us-ascii?Q?mrOVSVrJsM4FRaPbP/pRgBOOODfF1o2vXiFUPP5qH6sjhhSkhgQq0+RNXD0C?=
 =?us-ascii?Q?26BH0tRehU/kFEBrPRTfX3eSImKGIFk8n3ATHFvIId3+Kdvuvm0ZAk29IYQK?=
 =?us-ascii?Q?dKdUJjv4s0tsYYX5Uf9mXfsQk4Dk1NB9jRiJu2uWG96TTCpc06xkfBDaN4/z?=
 =?us-ascii?Q?dN1YcltVC3fYW7dcMy97Sor+ehpQtryuYzYo76Wx7D7TaRsb1uLONFA0QrST?=
 =?us-ascii?Q?QOydxMSfOcnSm/QkNdxyLAuK7tr4abdXi054WOzRwf+43i1G6uR81ntMHalZ?=
 =?us-ascii?Q?SU4eXi/ppi+fBF4LdrX2Or+SUNr6I3tYiPFndjrI0RzRDyUMRgPqI+WDk95W?=
 =?us-ascii?Q?zVyPvJkGrPJSv/BMCNY7tMYdu8ze8nDr5Z0VTMUo1m8Z00fuyQcf51ZOtc+c?=
 =?us-ascii?Q?SdIEDoOPnRLAMw7plyPh4vxlyDIXJggZqomtbN6aN4V4JJYyrZuRdrPy5sPC?=
 =?us-ascii?Q?7Jn4Pke0qAUJPXqErFzJuJblc07HHZvJx1r7i7LFwf5UgBRewQTJHWe7iKyB?=
 =?us-ascii?Q?7+s+JVCneIxd8w/pK1P2GoRKJCsRFjgR4PWpVwW6Wabjg3afkpUMbF1mhMo8?=
 =?us-ascii?Q?HaOFaaF7M/i/qqkeqsoFd9OGmcc/tU58uuzxqCxaUi/H/kfQ885EQ0LkdaNU?=
 =?us-ascii?Q?iJGAIsWRKmKaOp1YOrKefLGOmsAJ8PtYB0VpRWFVXqOOXYqOSWVmp53//rom?=
 =?us-ascii?Q?SQdonksJ8NuvmWAnjWkGvStdOuEuVw9nv99kv7S6zNFIOBuyMsAw/a1L2rnT?=
 =?us-ascii?Q?zb7L7yPQ+pNvwLn5bNcy001vqTonSyDalBAloM3i0DlgTxGWyX7YgfwO0Pht?=
 =?us-ascii?Q?3oYoBLcawg2/sA+8OyXxMCMMNUUZayQjn3B9hibiUevkWcBVaKGObAnP1/QR?=
 =?us-ascii?Q?K4GTQ58KTthnqxTJmOuZVfwyNx+lWWfx0VDN4fndiccHja3kBqjRQhBtd5fR?=
 =?us-ascii?Q?l4DXQsb4mXXYc41PxHUYox9dEn6L5WDhY75gOshR0QNTBvg4QYM2wL04B5fk?=
 =?us-ascii?Q?nn2pdmUXfSbQDFTQ8P7JAgmAf7nQmvyXyXGWnt5ZwO84SfYqOXgd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f249f8-1f5a-4e86-9f20-08df2a6f7441
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 03:50:29.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA1HgqGnQjvHFRlwIonaGzyiOiznFJPoBO6MIV8vUD/YBuk4AXHJAB7X2QkekrILcqo8tnQHJ6k5XKsZR1JmUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7895

On Fri, Oct 09, 2026 at 04:11:14PM -0700, Dave Jiang wrote:
> 
> 
> On 9/28/26 8:25 AM, Koichiro Den wrote:
> > ntb_netdev_open() can call ntb_transport_link_up() while the transport
> > worker is completing setup on another CPU. Concurrent transport setup
> > and a client link-up request can both read the other's flag as false and
> > leave QP link work unqueued. The QP then stays down until another link
> > event or client link-up request.
> > 
> > This is the store-buffering pattern described in
> > tools/memory-model/Documentation/recipes.txt ("Store buffering").
> > 
> > Add a full barrier between the store and load on each side.
> > 
> > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> With Logan's comment addressed,
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Maybe Jon can amend it on apply.

Dave, thank you as always for your review.

Jon, please let me know if you'd prefer me to resend the series with that
amendment.

Best regards,
Koichiro Den

> 
> 
> > ---
> > Changes in v3:
> >   - Drop the *_ONCE changes. client_ready is now atomic_t.
> > 
> > v2: https://lore.kernel.org/r/20260910040836.3792333-6-den@valinux.co.jp/
> > 
> >  drivers/ntb/ntb_transport.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 51d9e9969065..d290e5869c21 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1101,6 +1101,12 @@ static void ntb_transport_link_work(struct work_struct *work)
> >  	/* Publish the link only after every QP has been set up. */
> >  	atomic_set_release(&nt->link_is_up, true);
> >  
> > +	/*
> > +	 * Prevent both sides from missing each other's flag. Pairs with
> > +	 * the barrier in ntb_transport_link_up().
> > +	 */
> > +	smp_mb();
> > +
> >  	for (i = 0; i < nt->qp_count; i++) {
> >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> >  
> > @@ -2400,6 +2406,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> >  
> >  	atomic_set(&qp->client_ready, true);
> >  
> > +	/* Pairs with the barrier in ntb_transport_link_work(). */
> > +	smp_mb();
> > +
> >  	ntb_transport_schedule_qp_link(qp, 0);
> >  }
> >  EXPORT_SYMBOL_GPL(ntb_transport_link_up);
> 
