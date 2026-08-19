Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB544D035;
	Wed, 19 Aug 2026 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154628; cv=fail; b=i7UstKLJRQSwyaHjGkhA0c8xFN3z09r/7GUuI6ekND10TyzrM2qG/96Aiw9Lz3sI0BFG+mJVkTCHAgt9qq2c8pJvMpq5xOiE6A7Sl+2UTcgpMk7fAGBnU/qnWWC6wVcsK1jhp6fvh0ETLgKsGjOkZKaq2Rmcl5OhNvwIP7SJN00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154628; c=relaxed/simple;
	bh=grXJDZn/cNTk07b5kVQEz6GGF1i3K2rkHASJlS3kx3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FL8CvbW3UCAWkms42jFfQt9mZXyqp5itwZqMcim03alVAd3p1e9zIqcw/uLxuF/YUJ4qV6KnDfiCOVy7wAA6Xf08UHXgrM5dMJKvJhXZoEYarn/iOkNVg0rUn/dGUhqNYTxGu7mNvNK4yJlLQpk3qP5F8lWXfBdG0Ou3gfhTWlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iprzSKMw; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iprzSKMw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6rr+f0AmJs4bxbZEgO66s3xX+u9P3kXYvqaPb17iZFlqNskPExSyUugpbkbsH/XQ3TRCmPCAy4Lhn+Rr0PmvEHEflCj/hHrSol0fatrsxsO2l0ZyX+Xs5Rbs85BUn31EmPuV3LHByohxk7TvyinMg1bcjmOJt5ME8EBjNBVaoZmBB1bib4+mkOpLgH9KPHLex8BcvNtjpryALItPCq3jLmm4J+asm4Q5k0Q7ZjQf80oVP+LMAgd7dv8yGpzqD6j5pSsuk5jBaSrlvdJk/hvpbArAYfaNa82mSwA1tuLKdxGt5nUL1IaFel82/JA4zKwCLTvblG46vFdZfPasRy+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AihWn5rmXKc1VvtN5VmfQVlM3dPjwXN/kU3JiXv0N7s=;
 b=oCljhVGjIs7Oxv4+X0/jTnT0sk2Ws0VW+gT8hEkbSJotE6HSjrPdTvwU9iBYdXZmSK1UGFSEmdx2c6LFBFEGND4UGlbStpTjV8dpiIdfa0QVnxzZHvIHRPZRnAg87P99Yi6+CeEoDS5ryx6VdaQb/qLnhhwjNLKSTbaa2DRdy853KwwiOmpyayuGzdjah32+Hj0lnQLDnYz4kF2qSISiZpVmoXiIvBYX/3QGUumA0/W2oADasrR8We3XpXP/aO/cI6SFet9PEoZWaN6Q/MIoqgRSWVSfN8if4r3FNtLFWvu7EdDWF+ovwt421EFttEM5yTenRWldYzznVMwgp9u3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AihWn5rmXKc1VvtN5VmfQVlM3dPjwXN/kU3JiXv0N7s=;
 b=iprzSKMwYfyN0k3anQTvMAvfbmyZqy+N0QggZO3nnDBrlTUXZ8YUEDTTnyOVt8JxU6AkX/v0pbtRo/v2BipQx4iIBjQgf5reMEGjE6gEbX63zM7Od5se97JzAzugJMcqOm0NQ16yn8OIo53C8IyPy+4wFKMQnYRz9Tx08O8zUmE3zEfpBdK0j6yFvLg4y2J3a/h30Ra8bWkIueZbRjVJydcjTUlKYEt7UjetFijQ1dBx0cxFdOPuiBnX64u5RrhBZd6HUEiAwoIcWQVxgGHMRURsqkAgJX9QnDSUCRX6j1KQlC+bOVffxRfoKg28KSfsTi+hDWiTZ0tBCE2zOMN0jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7513.eurprd04.prod.outlook.com (2603:10a6:10:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:50:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:50:23 +0000
Date: Wed, 19 Aug 2026 10:50:16 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Frank.Li@nxp.com" <Frank.Li@nxp.com>,
	"logang@deltatee.com" <logang@deltatee.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/4] dmaengine: add dma_device_get() helper
Message-ID: <aoXQuJNjdULaIj8r@SMW015318>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
 <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
 <aoSEe2FujhG6J0iD@SMW015318>
 <8f748d2a4773cf526647f20d60e665a1680ce8eb.camel@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f748d2a4773cf526647f20d60e665a1680ce8eb.camel@amd.com>
X-ClientProxiedBy: PH8P221CA0050.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b884486-f55b-45cc-d5ed-08defe0994ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|1800799024|366016|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nMXbtGHnr7TLsvTr15eP0w1MB1h6FqFhUhHoeM0m4Ed4dq5mQfcPMM28OcDK4daqCluo+BCQ+xF2Rql9xOeEWPllTU8HC0NtbhHwNAZVbCX1zIdAqTr4TLXdpWAfy8eW97DZwE+Flm+s5scWA1L56sT1GkbCaab605U86l4XAaQNRiwETCgf+0UOmcGZgSruzuNB95TkB6MS9UKsnPYHaFbZmbaA1pXiT4QAqIC+9ojfiMeCz1Q+9Hn1dh9i4WT/W5wNRXnNypS4pjUY4NYIcMnDyiaBhs7yXBR0ywjd1PGVzVCQpqi7NegRsG/ugHiKK2hSNekcPcHratVu2QxXuLX4yy/76pAHZf+ivrKt/YiyHhAU+w87bHrPHetFcVF7HowbS+PB/HhqI7qc2Foti4d/kxYZZChi5+mt0R4G3Zn6+heTsnf5E0/4KlSGtRV5nbCZCb5QtaC0U7I0dGmglUwsvX69BWyC0L4cbTry/LATC4U92L7z0X7CsR0xCiogOzenV2DeyOy29FckzYuTRtHuCm0bGyuVRqJmD1dIAaUh+LIRcHW3YsIwd+P72PQOdQ2b0MRIR6HD0yib/OVG/dyLf8d6u+zBmboEsUus4aQ8j9Ghy24jYL5EPEzessFHyY9idYbwqp6WT+oncHnEkPhD1VP7sDxbDmUgS6RHeD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1U0EvRktT0tAk7P4MleTXOHRNN1Yyj5HbtTYmDaaa9cbSquy5pUVf26WCIh1?=
 =?us-ascii?Q?fwBgA1xTxKe6C9GElwahmwdVQJ66Ji0fdhr43VsrnQjZhVK/9zcu/Zk8m9FZ?=
 =?us-ascii?Q?DXFv9atwWj5znbeLTZmi0inJKv1/juJ6LGn0EZljogOznqsD1Eoh+jmxHCuv?=
 =?us-ascii?Q?FqAACJI6r3NspiTQSJENwaq73O/uRQ1QeJpQJrHZibA7aZSv84LnQSZq3dL/?=
 =?us-ascii?Q?hdy+mIYL6omOHu8OBM9k9/IC5U49cAvd3LSXsRceyDnG+E1uyXe+vjoAkisW?=
 =?us-ascii?Q?XxLXdJE90LZq5GFleryc+5Wh5Em6P+vBt4Ijfpa6Z2e3+ugoniC5lTHwwFJn?=
 =?us-ascii?Q?xXD3o0XPtYFauOEKDGH7c+WK3EZhzY+ImOY1r/VT8Vc9WwCTAs1v91pMoB7b?=
 =?us-ascii?Q?R2Wyll3ANQsZwl7oyVi2fehtRgNpyL5lrHFwX2my8O3t+sUz6FDprVU4hEV9?=
 =?us-ascii?Q?jOQFKSRTUf8du9TmgvfOq4NYewK/b9fjpPiK4OGIPt8GMyHi4zPI13p7dR0w?=
 =?us-ascii?Q?4Ylq8ilmJf2S3h7Q1Kv17oilRsgGF6BziiMYAH0UX8+H0mW7h/vVsZ+im7uP?=
 =?us-ascii?Q?cvyon5gvSMBuJya3m/H0odJT+TbNLxqaT0AWH490yoG5eDsavWTqE0LFGuTR?=
 =?us-ascii?Q?NG2I5aGJXqOnbM8mNEMJZ8+mbRroEpT+B1X5E+q6X44CjTecbReR8/rHYj+p?=
 =?us-ascii?Q?DN4m71p2APrLjgjdz4zHA2sVul/mQ7TRb21SJ4iQjefyOBjASGnIqk0FMZ+N?=
 =?us-ascii?Q?A3bnbpdgFLtRPqhCI8YpfEUajTOETthp1+0eUN51d+VlxYzyn3rSM7avafW9?=
 =?us-ascii?Q?gj6Ln1KovuDdVR+fBjiLbnH//9qJmEIPlsqg1Yvkn//zu91EIncfeL2squgf?=
 =?us-ascii?Q?sfNjtY/yh9Go6A91/xxIdpZVfuCDb878GVCthHMDVWNLGLKZgLWlTzEV/cXw?=
 =?us-ascii?Q?rguSYd23v/UCe8UKGpJ392WixZcdpYqgsCahBnBslCQaI3PsUcq1XsUJOv3f?=
 =?us-ascii?Q?VCaYSbxqdPxDD18h1y0j5tbK/pg5KuxTYNDwf0zNQluokzABtr1W31ZJt3hf?=
 =?us-ascii?Q?HQosuPE0J0PKc0dx9V7XDsxlyzWhtaW4MRMZvC6GLG8J+22cNZC42DgnxgsK?=
 =?us-ascii?Q?vQGVBZeg4b1lNuzq7XUouvRQLauufJKxLAxzVY9zhRbl3CrmxtPKckd+64+O?=
 =?us-ascii?Q?HAD9KZZIJllaKyj/GvKhuGfMt1cIn7vqaKXPRYFRqfostlZ/wsED9QyHyLfH?=
 =?us-ascii?Q?gXvJT7t80K7gYlwfc3vlvofUllUHEX3UyzSrLJLRXRNhpsaQzZGDeVTRLBfs?=
 =?us-ascii?Q?/ptATwvtmBLjvU5B29CDGITwmceHB6JptBBJCYyZynSA51haw8YhxhP7LRT0?=
 =?us-ascii?Q?5i/ylptvcnMtbk3XcTatNKl1POR7RSkHyYqePayjIkH9kyeeAm0vdJdDSmme?=
 =?us-ascii?Q?gaTfOpE1f1MaYaCFwO1tNDEmLL9dMHaNkzbd0r1bxT8xUPX7ym2JSLfKZvE/?=
 =?us-ascii?Q?40Ua+YohC22P6tpvJ7O85G7xmaAhGroxliU2wvYj/yFb9DRSYBfNpt2XT+gW?=
 =?us-ascii?Q?dTjpMdd//cIQskDzPg2ZEG8AdiZV3se52Jm1RHUrfo4nEppHLeiVRhseZpCy?=
 =?us-ascii?Q?Q54Vin62vXwR+PaB2aJZTTrr6zCBRVUxx27CFayZ4NybnsFwTBcuF/R5s2U6?=
 =?us-ascii?Q?mMoRHqmwuHYdAy8KLLOLgcUhICkXNBJTuieSxJNkeaw93aoPFmCZIJBeLTJ1?=
 =?us-ascii?Q?Ls+wT4YqG3PyWkQ8lPrX0SNr+59vzI4dZNF6s5PSbCgwUbWpl2y1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b884486-f55b-45cc-d5ed-08defe0994ae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:50:23.8681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jELjNNNhUat7ZBEfupVLpnUHu0EdMq6XBfQQN2ywq8GgbHdzN3hssA9ujcaMSxL3VXntiVaf/RxW3ea82yjEPDDQfNLOuFxdiUyeFlViTJfJiI33REDZ4XMgZnfznM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7513

On Tue, Aug 18, 2026 at 04:27:51PM +0000, Garg, Shivank wrote:
> On Tue, 2026-08-18 at 11:12 -0500, Frank Li wrote:
> > On Tue, Aug 18, 2026 at 03:43:45AM +0000, Shivank Garg wrote:
> > > Add dma_device_get() helper to match dma_device_put() to make code
> > > symmetric. It wraps open-coded kref_get_unless_zero() and asserts that
> > > dma_list_mutex is held, matching its put counterpart.
> > >
> > > No functional change intended.
> > >
> > > Suggested-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Shivank Garg <shivankg@amd.com>
> > > ---
> > >  drivers/dma/dmaengine.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> > > index 6ffd8bd82154..77638dc16e71 100644
> > > --- a/drivers/dma/dmaengine.c
> > > +++ b/drivers/dma/dmaengine.c
> > > @@ -433,6 +433,12 @@ static void dma_device_release(struct kref *ref)
> > >  		device->device_release(device);
> > >  }
> > >
> > > +static bool dma_device_get(struct dma_device *device)
> >
> > Please the same return type of kref_get_unless_zero(),
> >
> > it should be int.
> >
>
> Thanks, refcount_inc_not_zero() (and callees) returns bool to
> kref_get_unless_zero(). I used bool because of boolean result value,
> but I have no strong opinion here. I'll change dma_device_get() to
> return int to match kref_get_unless_zero().
>
>
> I think I should also add __must_check attribute, since kref_get_unless_zero()
> has it.

Yes,

Frank

>
> Thanks,
> Shivank
