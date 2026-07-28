Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011035.outbound.protection.outlook.com [40.107.74.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7847A860;
	Tue, 28 Jul 2026 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250393; cv=fail; b=g5beoM0GIxgAG54A7F8SmxiMSRxbIRWmrHCYTHScYbUAlv28x7bIez2AirxLVXxNvI7CTyYF/zWPxzA4ZLlcjCUNXZEwlOkbpbUx2gjpWnpRET2VBfwB1BopofwinxU0V+PpV43m3gJU/5BF9pTT1xUkbCB7Ftuje5HX4RUyPjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250393; c=relaxed/simple;
	bh=kvlBth2gqrCGfftC8+EDgdLErNmXtK/giiOxAJNQ45k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+uVE/X3dbq7RJqO2RWncrR3hc/ybtWgtUnFPltMhBO5M9IgF3ByEaxrxPpg8bHEUIalw0xBNqrhCmwIy2Lw2YDSqIi/f0IBWUXxopoKT9Jd70zmqhARMJmrMnAKZpX+nF+vtI6mLRnBGZz+OsuHXwTAkM7Q9bwlObi4YcHIP/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=L9rL3Oqz; arc=fail smtp.client-ip=40.107.74.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="L9rL3Oqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOTXuT8HppmAQNAQNhE6tDrrcvpKsoaGs/2caRptvmrLF47exH7EAUNMZqA1CYOih0G4SanycBjNjY1YETFSwLtC8onvu1EnAwO7Qbs+dFmzs8sBzmvjjwlnAm+FtMHLnkwrLhXbmd8n4u2ma0d8PzWXTeYpZrwkhDnhQKl5lgiX3nQ2CYqbaCKx6ng1GdpdSOxgUZsvIYPKKgxaV/xXdHd6KQaYlv4mYEP84UqdQiRkMEJYMPIclF4W8WzwVbuRL1+HcMt0aSs3nuhBFq8r2AuP1YxHRVv8r97uhbtqzRTR31jBpJWdbWID+rkBR/8mGxBu+ne9pVjGTfyrNaGLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+HJ9rjItoX+OFKhjknSpYmfQWB8Xj+7gWqgfiNHt6Q=;
 b=SEOp851f2nsvcXEJjKjpSw0AuiMCWjFRhN87nRBaUug+pSNm0HYb/lBha0CXc3md0eHriTo/lexlXaRCri6OOV023tq5VxuhXV8/wMZQF4qpwKbFVmb6BIV3m8q8rUF2Ie3UnUGBwQ0Hhg2y+z9ToCa78a9nkgF7Ds5vXjqJPmA/rwfM+7JUJ/tstTrv8wZOAQ6Z/ZtEshqwBZCPx0zf8cdYWQAwEDdG8XzDPEb0GcXc/eg/boFX79NGJdqT80dPD1Rt/BIhbiBAFoH2K+WyWYlMmdPMtC7j2mrxIE00fWwLCcbYqoHpLI/vETaOAqamYSemIbmKbvPmSzV08jKA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+HJ9rjItoX+OFKhjknSpYmfQWB8Xj+7gWqgfiNHt6Q=;
 b=L9rL3OqzBRiqB652kphO4DGM40usGh2Oz2t7FJzwMvNzDOAabCtsWOcQxYOx+uPfDm9RLF7P/ogPGNyUb1kZz784mtiMrJRcREVeC3VV1WdozKVqyHctJggTd7tpZ03OJWa6VC2ZXIeUuaEtqmaqqmJL/2S+xUUob1iKHrX7hhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by OS9PR01MB16187.jpnprd01.prod.outlook.com (2603:1096:604:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 14:53:07 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:53:07 +0000
Date: Tue, 28 Jul 2026 16:52:49 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	Isaac Scott <isaac.scott@ideasonboard.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Daniel Scally <dan.scally+renesas@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] media: rzg2l-cru: Align bytesperline to hardware
 DMA stride requirement
Message-ID: <amjCQbuolBw9M_U3@tom-desktop>
References: <20260701165003.1495035-1-tommaso.merciai.xr@bp.renesas.com>
 <20260701165003.1495035-5-tommaso.merciai.xr@bp.renesas.com>
 <amipz7WkKUsjxot_@kekkonen.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amipz7WkKUsjxot_@kekkonen.localdomain>
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|OS9PR01MB16187:EE_
X-MS-Office365-Filtering-Correlation-Id: a202c84b-166c-40ee-172a-08deecb7ef6f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|23010399003|1800799024|38350700014|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 43yBQqdwiGp8nLyRdHK5o/qTBw06VPhR789aUxtmmwrzEH3ueP8wm6F9OHYM77VWgReh6JK/IP8g8cA1oQKk7x88UfjEKj5cwhm8tAtCw/sPhag4G+9Lm/YqH714H742if6ky3Trsy5jizhH8n6GwF+LZ3cQJaAclqrd8PpGqgVQ4k9AQuqFkYl1iN6JNk7qtvRcGppBbKH5CIOQQb1Zn5nyqs0cuFDFpmZAxY7x13XD2up0wQBrQmIyUqZTA/MZ5bM6QoLsTmvZ7QVnn7BYpAlMGrw2Hjvx5qpF9681lbtbe9HKa9wUPR+PS971WtGAza34gdoUXTVGpSEhwFnwMKLC5tq3laZBKuHbQ9eBrajXa8hypIhofxNe7SsZM0WqJRiTjwA45YTI8tgUC/9s13jCHPvMXr9Fm7m4BXi0nFhYPuFOP6Cjn01eigJV1R143mS6qSugXgQPccpVjdufP3A+xzmGimD7qliRPU2x6vr/U28cpAePs0gb4/JZ3keILJtrHUMfmm2+bkDsRPSeu0zxnc8NoDXF/Kxxm3AhjTAZ3n83NGxsOmV5nF/KYtJYVNVJR1SlwNsVO8m2ET7ySBm6E0Ty8IjFA5WlBCP/YXKhP6EIcoqofiNzhCWlrmVlA/oTdaZzPWfoN++xTcjAsPlwav6LIfEDJi5qalsvUfUzeAgUcgk3cUBpM62QRDPGfLXReK0NVEL/cnf/ojR3BflY/9DBqYwmqreknuY8cKM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?421XapKkDDDBSDROeqQSlxpRwhh+HStNuorXIvWKFxjfGjTRZQdSRIiGymha?=
 =?us-ascii?Q?bnG+PElVu0EV+X9uppkbL7HofeqDwX88kR5uIJJkL9nqJyrtO0nD3+mc2VEU?=
 =?us-ascii?Q?K7/2K7pAXu2hSgynZFQqkPh9NL7cLyKSMBjDe3B4o2lO0FBhYmVPUQJ55wIg?=
 =?us-ascii?Q?aFtiIXZqbPSFzG3+j60our3gHMC6pBURFXiTIJJiwc8ezQtZQWC0E954ptl8?=
 =?us-ascii?Q?gszrjbOrwA4j2AavdXzd6BTnWUcRt2N8/41V2NRsnJu+p97XycIO+2Tj4vPu?=
 =?us-ascii?Q?eA+Q0X5Zh9h4ieVvDClbCgRv63ItzDiBBfERegW+TwM88QIEotCi4wJt1UHZ?=
 =?us-ascii?Q?A1bjTdSgV+cvcBl7kODvcIxursV9aSd8fIA+AmSGK5KXcD+uPO672PMThf4H?=
 =?us-ascii?Q?J2fi8ExgokTV42/G0kBv2qzveiXGXRGW3R+7ciKEdykdJLJJYljNfcWYUbor?=
 =?us-ascii?Q?mu0gixlYdB1jUcsM8DOzN6nn3vrfSJCFI4doP8Vdl92LGJj1Jnk6hKEjYj8+?=
 =?us-ascii?Q?+UQwB3WvUJjaLg5YTzx2K1MWq3DxrFzYjKSc2S01RLzy3tUBVOZqbXY80nqs?=
 =?us-ascii?Q?P0JDfnYTh680CaStXgiXnvTere2ybt11rGxfDhJHQuhKcXxWUy/c0UuG9nKZ?=
 =?us-ascii?Q?mj+V1ZkgphOmig/B5ljW/Rch+AM5yo8ED3cQiV/Virb5wcTQWlyFWFbPp0o0?=
 =?us-ascii?Q?86jgr2LCatZohZ8UfzlBDS9NMTJsUH/RjiNvxbk+yrRCZgcN96Ka9t6N9P78?=
 =?us-ascii?Q?8jmIOOQR2L8UKEx8UgBymgbNAhJDpOfjBK0duEeLhTXMmYo8Y9wnSigPDXAU?=
 =?us-ascii?Q?fmV00cNPM+H4+0UCoVluHOUbgGUSczdgtdUiF+BRZHufM1rK1ChdR+7qw9qo?=
 =?us-ascii?Q?HD8W8iFDwxW4uePQ1E5B4gJEMqFy8+8zMVgo+DJpuyYQRK9h+M2M08qkBIS9?=
 =?us-ascii?Q?6oaJuy20ioK6o3348cqVeMzToVKjb6xgj3wowpfWli4/2KTTh79zQJU9rn6j?=
 =?us-ascii?Q?byO8nAI+2z1dEPsYWmCLLBHfWLh+qZ7G44/Fgggk+V+ziQYejJp+1GBl/s+Y?=
 =?us-ascii?Q?KfOWA3hpXd7AKbudBfLX32Kyvtoc7+WIIiAYP6IpkyNhsN1iuW8lD8ZlZ+DP?=
 =?us-ascii?Q?yjWUPYVkeV1hQdJfNFJWuaQrTTss12h6zQb6mj09tsUNjUpR+WamwtpB8DsE?=
 =?us-ascii?Q?csf/mkKoNsIwd/alUgIX1fVnVGhHnzWhwLdQnfcwXhullGsT+59Pf485TfuT?=
 =?us-ascii?Q?ewQp5jUp1g6VJQK5Kkf9LvL9twzKEfAQfLeDmxy1/Dq84zj7V66WVubXa9gQ?=
 =?us-ascii?Q?CfiMLbszC2H6m8LcU9N5UuocyGGuxmZ92TtdF0xFNiuho8IYn3CYC5KNlq35?=
 =?us-ascii?Q?w9oXokxJRlIMa97h8pdIO9DOUFTtE83QCvITHXowLEnSIGuP7pvRhYlXPBFt?=
 =?us-ascii?Q?KINmruPh0CtKuVplfAPXrr5xWaFylvROPf1D/HA9s4SI6KRQ9XtgiB0wNPg5?=
 =?us-ascii?Q?5MyJsxqk10Sz5sqxoDbdp5woYLrwUnyAKHa944e8/r1YeHsRkvrKvB77vdNI?=
 =?us-ascii?Q?YNaPXPoMGyl6waB+sX84R8+uAnu/N6KvwSnVxcNZ51/nPW715JVIhzIXjX/T?=
 =?us-ascii?Q?XwzUMEpblxdH55kbcbf/jVaMtqUgSKqt9MFM6stxiwGEuP1YkmG+Fb9Jas6A?=
 =?us-ascii?Q?1ppO16TuBo4FtxPyJPDaeKYk/mMPpfKhEhH0HNDesh1u4WfBAUv4Z5yvMpyb?=
 =?us-ascii?Q?zWDE8cmJ8yZC3ODwwXNTXkA5aVmm8la/PXQAXgH7EKPtu/djHQvA?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202c84b-166c-40ee-172a-08deecb7ef6f
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:53:07.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b+A2KohPnKL+bq7dlChlxNabzKiCIxmDG7TffFmaxs9R1PK7D+mFzGcv8uhlDt5MzGsMC9Voae+phm08R8IMqqI2r5EM+SEG4ddrxQuZ5dH2mCxKkn5beENCaK5ShJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16187

Hi Sakari,
Thanks for your review.

On Tue, Jul 28, 2026 at 04:08:31PM +0300, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Wed, Jul 01, 2026 at 06:50:01PM +0200, Tommaso Merciai wrote:
> > The RZ/G3E CRU programs the line stride via the AMnIS register, whose
> > IS field encodes the value in units of 128 bytes. If bytesperline is
> > not a multiple of 128, the division truncates and the hardware uses a
> > wrong stride, causing horizontal banding.
> > 
> > Commit ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> > replaced the open-coded aligned calculation with v4l2_fill_pixfmt(),
> > which sets no alignment, reintroducing the issue.
> > 
> > Switch to v4l2_fill_pixfmt_aligned() with RZG2L_CRU_STRIDE_ALIGN when
> > info->has_stride is set. RZ/G2L has no AMnIS register and keeps using
> > v4l2_fill_pixfmt() unchanged.
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: stable@vger.kernel.org
> > Fixes: ace92ccef0c9 ("media: platform: rzg2l-cru: Use v4l2_fill_pixfmt()")
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > ---
> > v1->v2:
> >  - Collected tag
> >  - Add missing Cc stable
> 
> The problem with this is that it requires v4l2_fill_pixfmt_aligned() that's
> not Cc'd to stable. Can this be fixed first without introducing the use of
> v4l2_fill_pixfmt_aligned() (cc'd to stable, i.e. in this patch), followed
> by another one switching to v4l2_fill_pixfmt_aligned()?

Ok.

I will send add to v5 series before [1] a patch that fixes this
without introducing the use of v4l2_fill_pixfmt_aligned() this I think
can be done using:

        v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);

+       if (info->has_stride) {
+               pix->bytesperline = ALIGN(pix->bytesperline, RZG2L_CRU_STRIDE_ALIGN);
+               pix->sizeimage = pix->bytesperline * pix->height;
+       }
+

Then I rework this patch into:

media: rzg2l-cru: Use v4l2_fill_pixfmt_aligned() for stride alignment

That just use the newly added v4l2_fill_pixfmt_aligned() as you suggest.


[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20260713080259.21835-5-tommaso.merciai.xr@bp.renesas.com/


Kind Regards,
Tommaso

> 
> >  - Fix s/commit/Commit/ into commit body
> > 
> >  drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > index 69346a585f9f..478264f26466 100644
> > --- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > +++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
> > @@ -860,7 +860,8 @@ static void rzg2l_cru_format_align(struct rzg2l_cru_dev *cru,
> >  	v4l_bound_align_image(&pix->width, 320, info->max_width, 1,
> >  			      &pix->height, 240, info->max_height, 0, 0);
> >  
> > -	v4l2_fill_pixfmt(pix, pix->pixelformat, pix->width, pix->height);
> > +	v4l2_fill_pixfmt_aligned(pix, pix->pixelformat, pix->width, pix->height,
> > +				 info->has_stride ? RZG2L_CRU_STRIDE_ALIGN : 1);
> >  
> >  	dev_dbg(cru->dev, "Format %ux%u bpl: %u size: %u\n",
> >  		pix->width, pix->height, pix->bytesperline, pix->sizeimage);
> 
> -- 
> Regards,
> 
> Sakari Ailus
