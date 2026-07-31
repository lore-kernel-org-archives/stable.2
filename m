Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011033.outbound.protection.outlook.com [52.101.125.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927B63B0AF5;
	Fri, 31 Jul 2026 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509791; cv=fail; b=gd5avkWRdXOS0kvt+wG+pWRJFFsx94RmggFF1HD27K4HIv1zg4rsrll4d/IVvTJwRkDX1Eb+QvM56d5uuFO2ERWknXP9eUKXmhq6p6ImsWDnF8aCCfKFAHsRjhkA2IvCu/UHqNFaX6L8/OrqXebhYF7frUG7nCuN5rKcZRTC+A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509791; c=relaxed/simple;
	bh=ZPgkkPAztx2+bjFADd3vlXNnXIz+W16xjuu4LFlUS9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eA9I42zTuERlFrBlCWi0IEvFOHFRIWS7EQVIwXaL6/O/FOZK0MOqU3W+oRfgrQ1fpR8Cs/06K+zDL63MuTlI921eMHATo3gvh+DYNhH/2gGDr8s9YOszzOmgRwn7eMVzVF6ruU0msLHITaYBxI8yxSfm2luNijQ8+BMi680jvs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=p+Y9EAGO; arc=fail smtp.client-ip=52.101.125.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="p+Y9EAGO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sm1SfIwcEBn721Txw5ZA/UpUzBntBo7AiXqypgIZ7X7dmhRKGxCcOR70GoQ25pj3UHjXN3endxrWUmcyWW+X6/kgGpIPNPqlXiH4v1iwQJC/KS3688CEi2iC2NxRyf9Xom76XatmcDTpRXFHO+KxmEfYro4tposuR58qzytuCRz/byX2jSwVAjGUt+MCuO3O5/zD8JrLaTyZOxpKJp9POGEiURlKskbEN71fW7l938cGR66yIg7xqNhmyOvSjFmfkpbgRdnSxL+Qk+fX/uoLFST3oTuP4B37m21a4FrK9e9RVxJ1vhRUK6eb7cW3rlbmx+yUWFyrMLNgRz6ENoafFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dS1z9xm+43K9LHZvUcD4+Uhue0f4v4+aAhUTLb8aDdc=;
 b=Yv4iab575oebJ5gsVrjWi6duefykLHmk8BucVXechnKDHKtA444Lb57cj8uV0VP4WcPTQnmV2vl26ZKrUEA0JUc73WrFXTF4kH152C/lCXnDbBZOfQ1QF9kblX/vJmFqlQjEdK3TJNTlNssRg2EHco2SWktrPEQnGh8AkrCYaSnyaidkCUl5SybMraatsRqqfiiG/pwAp+vwJFZpcdqSjuL6l0kFyzj9y+IdJ/wYrVXcAbPtaZQVgZ9ud8DsY+hwcy6Ssd8dcXlu/wJz8A5DVXHtXVnghlpnfGhNeeLlymwSzM3L3vICxcItjOkh3kCcoAvJMR+fESuQCw9sFo2d+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dS1z9xm+43K9LHZvUcD4+Uhue0f4v4+aAhUTLb8aDdc=;
 b=p+Y9EAGOAizzaD7+zlxvs6m9ilZ/x9Mirj4/7Qugnv0jqm9kqakKfUf4ifpiwLIub29LJAiyZIy9y/N7hoHDNxQPbTcBOUz39iTApSy7n+JS/8jmMwUdV3HSWo0cj4v4MwHjqvastknuifOO9Ow1tIhvYuG3xn9eUyBs5PiFgUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS7PR01MB13601.jpnprd01.prod.outlook.com
 (2603:1096:604:35d::12) by TYWPR01MB8364.jpnprd01.prod.outlook.com
 (2603:1096:400:177::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 14:56:19 +0000
Received: from OS7PR01MB13601.jpnprd01.prod.outlook.com
 ([fe80::35e3:29ad:b9cf:a3d8]) by OS7PR01MB13601.jpnprd01.prod.outlook.com
 ([fe80::35e3:29ad:b9cf:a3d8%7]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 14:56:18 +0000
Date: Fri, 31 Jul 2026 16:55:57 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Daniel Scally <dan.scally+renesas@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 1/5] media: rzg2l-cru: Align bytesperline to hardware
 DMA stride requirement
Message-ID: <amy3ffsibZKDv9QC@tom-desktop>
References: <20260729105603.1160966-1-tommaso.merciai.xr@bp.renesas.com>
 <20260729105603.1160966-2-tommaso.merciai.xr@bp.renesas.com>
 <amun-AzHShKFnA7W@zed>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amun-AzHShKFnA7W@zed>
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To OS7PR01MB13601.jpnprd01.prod.outlook.com
 (2603:1096:604:35d::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS7PR01MB13601:EE_|TYWPR01MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 88115634-bfe4-4b44-36bc-08deef13e0a5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|10067099003|5023799004|4143699003|11063799006|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 c3/qXP6ykDpuJOXeHCiwJWNOgbhnJnasXDQkh5qvfNZHfeIdVgfPfymVDAf2S9cvpUVfVhn3e4OtejCP363ecGhgdnr3f3V3rg6fiMMzG4wl0Xbdg6YBmR9oBTu+7jXiSei2Zd1DcHGCdegONGWhGs67EL2k4FcOoRimJjnhrGBv3MAeSFva5EIhSLFvMd6k2kwgNkoGNyUzjxXCAZf+58flcZ/zqV+ojMxpe18iPXDXOo2UTaDn3Xr97ON1gwjCpE8ARBexxQDQT5aXivuypD7gnvzDHJodHa2L6bfqX73UxsweGkZdKSZs4I7oKIoGHS5JWegjDfSzEF7PAMyix/0WiMuN7hIrZ0LH33Hh7ZaMtRdgViflg4/M4hfifGM3OIxKTrep56S31LeTY+syCWi6cgjPHSdyUWURF8G83snaFqMJT8FxAS8V/DOoRiDD/xYjQHuCF20dnJgxhNHLHMEXMvylySi3ynGo8n3vNcyydjJnAgKj0KrckvRgMA8Whq5ur90Gkyb9CQW985arOhol8EzybsnBGNLWWttll6JWGWDswf2676lzbNUHjWZVqaoGedpl5/GTHrlQHvZ411kwfPJ39f1B4fEM0tyGXClQW3Z5Jl+2QzgDm0d5wSYNw+BUPyJM02JrmpFX5u0ZJlo6fw6JA99vd3EjPBbQRiE7hdevlA532ijTgMmrseUz63oEIfZkI7ek7AnpL8JxyVzIRubQoqaZdDH84cyBg5k=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB13601.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Gvd7aj0Opru03ucZbTRS1/mDGEOgX5B7v5cpXRZLRm+U+Uluqt4I/hgIML8M?=
 =?us-ascii?Q?Je9+yev8ljJfuuSiQBc4MON04OwCYd25wq4dCzvDHTQtQkDw/dtysMP8mIhA?=
 =?us-ascii?Q?3Ov/hCZbaN7s1TV5TvacTpS5delxDT3krV//96rn8Jdeb0IQp9NNYkncGLvJ?=
 =?us-ascii?Q?nJnqo0b73Rzw/1ibUAn5MVw3mdmBqM/n7nHuUdZ/pdPA4QleVplBmat5vdni?=
 =?us-ascii?Q?InyEOD2zCjU3rRfyZv5IwPf0036T/Bs2O65Kw73LLWPeJNs03wTTs1BMXuoe?=
 =?us-ascii?Q?FtY3mLcmr7YxsYAOYpwouOg2j8IncHacQM+X+Qc4oc3kVk3mYgaxxVR7ckjb?=
 =?us-ascii?Q?2kMnKQ3H2IFvyUSvfdVeYXj0XjRxFjjU4DjK/CjzabfRpjfC4/Ah0+OgPt93?=
 =?us-ascii?Q?5zHuyB4ZH90zWjJBZ+4xxRytD4oRjk8DeHrGpmJt8HV2c9rLWd5JQnE1mzS9?=
 =?us-ascii?Q?GDRZqegJjycpjwcHPeoYG+Kxv5VbUodkYV2k+pL6EBwx4W8Vkp0i7lnOLbZ9?=
 =?us-ascii?Q?mo+OETB9nAtprdVdrp5BUEJo985LLRpxWMl9TVeXMG+9z5k76y66DdSunk74?=
 =?us-ascii?Q?IsoXG3ykfzW9rRLLbmtxllfi60sr0NnJ8GrX5MbRLH/p2Q67pku8pb+mHrq3?=
 =?us-ascii?Q?nEW5M7BX1yQQ9K2uEKX3JpEeUAue8aQ0EPE3xFR0T9ayxYP+3zMZBBL1hJsV?=
 =?us-ascii?Q?qL39QMvXzOxi3wz8b2TUm50zd28B7K3A66J2JFwlQO0OGp7ZEwNs/o7fnHI3?=
 =?us-ascii?Q?+dVDTMqo0ZuFxuXJXIhlCUNAcN5jwDBCeS9ae6k/0VZDbrPEjtik2wr2gshN?=
 =?us-ascii?Q?l+1PO2+IVGpsOswI6fPxVjsRokSktC3R+fRlBb7oQUgfHjC8RSAdBiL6zNJ9?=
 =?us-ascii?Q?5c7OBJO5qZJKnq3rgHyQBR8TtL+nw/cjE7Uc1b5cQ//GpU3rrygvsdZShj7g?=
 =?us-ascii?Q?+UVLU9OSsj2oqxJsoKWxCEcxDW7UyRAl12/+6l71aih+1frdes4iaXG34USh?=
 =?us-ascii?Q?hRtnPBvjUd+RoJfS5BzUArTLGLzg2XCBuPBjNOGQRjgpgurmu/7K4Bn29aXo?=
 =?us-ascii?Q?h/gJmUz7yyquJU8a/oa1f9kVCuSZM1zUgrgE8tnytBS8Rqo7u5FUgeV63ogc?=
 =?us-ascii?Q?3Rlre/plDucsq6iPlx9EN0aLpU34cyuGVWzaf8Zj36QbAITcjLcQxfdiaZVT?=
 =?us-ascii?Q?5bzGE80gGHQ8OC9cmE0kZb/N6YDTzIsH5N37x/N+YsSzcHCzAEw3yH2FEe/l?=
 =?us-ascii?Q?OtGhoJflDniWs0jbhKm345zAnIAydy0Xwh4E6VBFv+xyxJ8SCQHeow0bnpa1?=
 =?us-ascii?Q?8wdYkZPJ+dpHIHi7C82Eswy97mSVDPNpAiqAkqhrvkCL4h05aFDX2ynUxe/5?=
 =?us-ascii?Q?3jKUMGEMWVtYj6G2zIVMhVkdldMoIaA2tmkx9lQOZoiyV/FYI/Yh1h2qCLyT?=
 =?us-ascii?Q?3eDZsAaofrX5TJgaJNT1+WlnTCDzS1DAJTeFncV87Sb97ENSIVOcjZmQoAEQ?=
 =?us-ascii?Q?hmzy1ND27UdG5IB3FVGSwaxaeHI2i+RlW00E26MBr+36WVaXWlljogviNvVi?=
 =?us-ascii?Q?U2Yy85e4pMfh5W8a0A9pPRiydh/814OHMG7mp9+KTxn18Wv2uwaxucPR/9FI?=
 =?us-ascii?Q?VrGcxShgO/xbXpQu8JL3j3tG8PG2RA82FqIRuW7zogPumSi2NAdag7pm4yTr?=
 =?us-ascii?Q?iRFKg/CdUF3cxL4L0KouV1jQJ+oGLUXWaPcj1z0dLqi0TymgWrdLH8BCqgLC?=
 =?us-ascii?Q?xX5ccKL/Yv8uxyoi7EerKCTDBa9ufyfesqyAXObW/HjV/wqwWAjH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88115634-bfe4-4b44-36bc-08deef13e0a5
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB13601.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 14:56:18.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iNEyR/MAXjICNK1IFFnmcf6Txoirpj2f+4F5ZO+5jQ6892LdsmNOJOHJZhiBsz0+c6tnZ/iJp3vOop40tADLydgP/ACCDXDO+Hc1iy+P/eiDFwFm9ugg0Ceq1Wbfx4P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8364

Hi Jacopo,
Thanks for your review.

On Thu, Jul 30, 2026 at 09:50:35PM +0200, Jacopo Mondi wrote:
> Hi Tommaso
> 
> On Wed, Jul 29, 2026 at 12:55:46PM +0200, Tommaso Merciai wrote:
> > The RZ/G3E CRU programs the line stride via the AMnIS register, whose
> > IS field encodes the value in units of 128 bytes. If bytesperline is
> > not a multiple of 128, the division truncates and the hardware uses a
> > wrong stride, causing horizontal banding.
> >
> > Commit ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> > replaced the open-coded aligned calculation with v4l2_fill_pixfmt(),
> > which sets no alignment, reintroducing the issue.
> >
> > Round bytesperline up to RZG2L_CRU_STRIDE_ALIGN and recompute
> > sizeimage when info->has_stride is set. RZ/G2L has no AMnIS register
> > and keeps the values from v4l2_fill_pixfmt() unchanged.
> >
> > Fixes: ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v4->v5:
> >  - New patch.
> >
> >  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > index 5185a547461d..91eda5034248 100644
> > --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > @@ -851,6 +851,11 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
> >
> >  	v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);
> >
> > +	if (info->has_stride) {
> > +		pix->bytesperline = ALIGN(pix->bytesperline, RZG2L_CRU_STRIDE_ALIGN);
> > +		pix->sizeimage = pix->bytesperline * pix->height;
> > +	}
> > +
> 
> Ack! I think this does what is expected for the single planar formats
> the CRU supports!
> 
> I think after this cycle you could send a patch to replace the above
> back-portable change with the usage of v4l2_fill_pixfmt_aligned().

Ack but this is already done on PATCH 5/5 of this series ([1])
Please correct me if I'm wrong.

> 
> When you do so, could you consider, replacing "has_stride" with a per
> struct rzg2l_cru_info .stride field ?
> 
> I think it would look nicer as you could here unconditionally align
> (assuming the new .stride will be set to 1 for G2L which currently has
> .has_stride = 0).
> 
> Also, RZG2L_CRU_STRIDE_ALIGN is a bit of a mis-nomer, as only G3E and
> V2H has a AMnIS register and alignments constraints as far as I see.
> 
> The only other user of 'has_stride' I see is:
> 
>  rzg2l_cru_initialize_axi()
> 
> 	if (info->has_stride) {
> 		u32 stride = cru->format.bytesperline;
> 		u32 amnis;
> 
> 		stride /= RZG2L_CRU_STRIDE_ALIGN;
> 		amnis = rzg2l_cru_read(cru, AMnIS) & ~AMnIS_IS_MASK;
> 		rzg2l_cru_write(cru, AMnIS, amnis | AMnIS_IS(stride));
> 	}
> 
> the G2L has no register AMnIS, so we can't write it unconditionally
> but rather replace the check with:
> 
>         if (info->stride > 1)
> 
> As a bonus, if any other variant will get a different stride, it will
> be automatically supported.
> 
> What do you think ?

Fully agree!
I will post patches for this after this cycle, thanks.

> 
> In the meantime for this patch
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20260729105603.1160966-6-tommaso.merciai.xr@bp.renesas.com/

Kind Regards,
Tommaso

> 
> Thanks
>   j
> 
> 
> >  	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
> >  		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
> >  }
> > --
> > 2.54.0
> >
> >
