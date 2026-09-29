Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021120.outbound.protection.outlook.com [40.107.74.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0216831E844;
	Tue, 29 Sep 2026 01:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646201; cv=fail; b=P8B8lE0DW2zvvcl9OtCAuTsQmo8vc/BTP6JhERd5tFPZ+FkpSTaNpxlNmDoWRIZ9VpY9uMdL9ADI6x6vmENNmvb5Xa1iHUsqouJnwAdcN9nKdBiXR2rX6eUH8IuKR1QEKI2wEKy/tW9+MwIzEqqC6bVC4Mv2TFhyFpNs1iPznZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646201; c=relaxed/simple;
	bh=2f5eEEa13aPtmAEwJtWPcDfXRDtsBZ48FH9SDYPALtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZTS0HL+90zderohdmXhIGey7vMQXT28oAjlkErmCSGk+BYfY/eSNlOs7B2dVfDBxEHEewquJ3lpx3rt3+Row30j+R3PUex85Z/CC9FmcpL3cTbCF7yE3EqbXXX/3nbdQmNJ+XkGRFqoratRPxJB0H1cSzT2fli0YxAR8uJjkVmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SivLL40L; arc=fail smtp.client-ip=40.107.74.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SivLL40L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOYVVMOs+I7XWuGQixmULea94CiXD0bHlzHUCbprgzu/C1ykOSdfsIyWNgAAwC1Qtfit2hn3BiGQW13ugGudCuEgQcN5IVP6qwJgOK+wltqUcH7vZjaKwiEhmCW1ihJg9+NVcLiqwU6fmOQ0g/qkodj3hUIZEt4N4jELPNkro0p1dwp/YYcN8zBoCXKAj+MjCxqokydmsJsAmLPff0ae6DftGiFW0nour1eabrXMaYM4lkdtFyMte7gMlrXMx3gnhQsemDHuXe/VvlNJvtd70B8wJdGmmCM+yd2sKAH0ppU5K//MBWkSXzPIn9IWOGS8GAI++g9+w3+Q0LPmLyGAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hbGk2jSQ8e77bB25dKlOlED3DlQA1UxFXI3t8dzcTI=;
 b=TS3svjKdeqidQG1c0PWtx6vw1XRcaAGm8nduCMCqWhonHPEUsF9YmUfP9jBQfcEgzOTAs8PckomMCeBwqFJZ0VZzVhwgCPsOX0ya+StX7uJhpR58y0nwyd/pmMjQfKkYR7wodSBxh/jPcEkZmIxalUL9XzhXjwQyJSSB/RzQvCJf+yVhhY4/YVLeaeSyApLMnRu/oCidD0vwdorYQLDTW3AK13C4hahd/mDOCn4Qzu84d743lXuGTWEZ/+cjfVhToSX9m5aV3iyNwWKX/fgh0KB+kaIBjq/ekpqhZMI3B4RVffsGH0iHfQA2pPLRlSWHYF7eHiiDXKhycGyW+yIl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hbGk2jSQ8e77bB25dKlOlED3DlQA1UxFXI3t8dzcTI=;
 b=SivLL40L7578+e8QdeBGZ8ptR6Fw8ei+kv5xMONrISZchFjPstXxEtn0MMc+59ijYbCTnaEfk6b0fZU4zYWm7rSkOp18j7U2VxB30Hzix05QrYHjOd9kBrkE3KymxdthdwksZugzoNhl0SJznFQUX80ELfO+6xzbaS9CybZ1Kds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB2243.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Tue, 29 Sep
 2026 01:43:14 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:43:14 +0000
Date: Tue, 29 Sep 2026 10:43:12 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	fuyuanli <fuyuanli0722@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 06/15] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <gw2vwqm3eyhnourifbkaq7t6zl55wq7int34pnprwjr4vi452s@yxuxrirpu76p>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-7-den@valinux.co.jp>
 <49bb5e64-4428-4133-b201-e7475fd07f1d@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bb5e64-4428-4133-b201-e7475fd07f1d@deltatee.com>
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB2243:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fc991f-5751-4b10-9d05-08df1dcb06f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|23010399003|6133799003|56012099006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IDYGU47LOeFtXWYs5xKmttpA9Ifiv5HsKgmNBASmdlzFmt2NN7SJ9qrJnfYymYTfgxNLD3KFjs5awXS+Fiq/IM7gnRNF9Df0BFiTyiPP6/ShBk4vbgoW2iYFb8Hz0J7q3kx9yNUgK8yQAPlewOgSFi1Ps/KFvDCkGGupkUHLpbZZoYHzSWdYa2wpqP1T2rBbRd+LfwtLAVvRqdWD4QP6m5o1pWZ06qQ3uONACOKIZFz50Cd/kXETcSa2zD/Rd2FYyawhdwgsTgYnhTZcQAZ2+vclXYU6LFr07VNw/ZXBaUALWJu7fbqz1zm1+iIy/Ll5U1hsSTodOuyCi+vBTqRIp3IO3/OljcxlOt+sxClcQedpul5Kss21F7Xai1h/SUliOxozSg/SAWZ6PTFnOSozkaWshfE0ZysYXnZZLqjsLfUjNp+1ptM40NP8dAeg/HPNEAw5yWbSUwfL4X6CHWiEm1RvissC6+KTjSgAIQTHU9K7hiIxuQlSIfZkL4F9CQ0Zqgf0MRfMlgtyrwIOO4EWAZLH0A9AWXcx4PSktDrhO5kHn+Gg1/tql9rxntzOHmy5u+Oa3v/kVm9Ea17RIyeawXKP76NloWycoqUZMQoHpDKErZUsr9bUq0RrQjKCu173
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(23010399003)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KFKABSF++RoZzGHqgjXhyMJSdz2bfSc3y/I7BAOK1/lVEmZpCzeia8T8EBzZ?=
 =?us-ascii?Q?yNKVmrQ1kYpkoqMHtysXjy9tOVunn2IuDrLPYKG4qaeNLCJxhA735AWKg0jF?=
 =?us-ascii?Q?Q2XTWRmmfoBr+FyfNiiLkFwbC5ncD+rkxIO3vd5/rM+OMK8wMAVSchqOIikE?=
 =?us-ascii?Q?UBRdSuYFxR6OSJyk3jKMr6lSZYhaGjJaHEygiT6lGZ04Ogb3fuVrF1otowAz?=
 =?us-ascii?Q?fnDdc/x341+E4ZISvALu23L2d0nTqtk48064S1o4/oGIXO10Ev3GdceUk3kP?=
 =?us-ascii?Q?757v0AAv6Ax8uxv3SGUxLilgO9hj85IDq90Dj4ORfnJJJIYPF/0XYxeFQXmU?=
 =?us-ascii?Q?69aNBMLQOjdFsFg+zMuFA69OTbkV0V7rHdNRJbpOu0IQjYvstOzQ+uq9nKng?=
 =?us-ascii?Q?uPUhxp4WmH5xzfd/IfNSfshZcrYP7YE/AoHhLqW3oOGV4MNyz+IGNGJ8Yjac?=
 =?us-ascii?Q?0D/MfXmdmrymjMap6Xy31NNOjhlX3h3uSBpMgdQzMZLsNL6sjAXea25v+pYD?=
 =?us-ascii?Q?XSAYxsca0iTq/fP6ksJK7j8MkOPRttl6/7mKktcSr9YK6I/Lv3Z7rlQlwaA6?=
 =?us-ascii?Q?SSIieIyMQztgfZISGa+Wm1Tol+Cs7HZ0FHuDaSYDUMGn4hXaVMv4X6KMx5Os?=
 =?us-ascii?Q?ZKsKUhMT8eBrAZfdeZ9LHffSKMFN8Y8C8+8WIguyvHq8IQxJljWHw6B/bSlQ?=
 =?us-ascii?Q?3M/de3u9qd3gIuD4W6mbNMtbbMxCzCgHKVkKwA2cdMENLd09pEDnjRt4RpxQ?=
 =?us-ascii?Q?414/WtBJgpuyT6DE1w7Eq4JRrTqiW7iDwyjGUZ5sH0bhe6W9jU0wSQjxhGnF?=
 =?us-ascii?Q?aHNJ+EgoueiqyVE8VkhklMquxiRlf1Zrq58rxE7ESiu1IBW6BzyhiaREZfHl?=
 =?us-ascii?Q?hn3I2dcMvdZpJDicvoIXvzUKuPwiKqtn3BDBbEGIkXE/RXPmF/OFJCimK7W2?=
 =?us-ascii?Q?jUB6cgrB5smRUaXY1mromUmz5/W3/DXiAOMposmcwpNHGkOKfZZXkOUv4U9M?=
 =?us-ascii?Q?eR9Kd/CRHHtt/eI55JjWO1cpmjdIjz2b9r5nK1ofX0+7z8ILWynmLAQo2tnZ?=
 =?us-ascii?Q?IwDIQYvqGedqANSIfwu5UMnRk/smq6nMjNzD1C8sBIlVwX+5TBYlTMEXVag5?=
 =?us-ascii?Q?+0e2pYftVaw2xYKAmVVAH4Zeoyy7fEVsI3IiMLC909E1yXjlHjh0VqJmpyNX?=
 =?us-ascii?Q?rmOQn7RyHHGXg/ogG72ofFs/OX5uS/1hnqXFnI1xnKlRgvnocbOUFX8oD2RB?=
 =?us-ascii?Q?nyUxAm4iP+jRosv/C2FPITRh31yYo6mqr+6DoTeQ8lK7lcKnf32kOuslZ+1g?=
 =?us-ascii?Q?Yy9QkKM8x3SeRSu/+r7yokaQWYutGksfNa4c/Q2FZO8Bm2e4SatH+qKApM5/?=
 =?us-ascii?Q?W/8Bu62YbDvq/3SQhQ2EfCrfpdtedcAsa9wWZzNF3BWwhrub8KCeVmltwFJT?=
 =?us-ascii?Q?e9Y1NmvCTmwrIhvmSbTerROt7dsq83Ez3bpZpPy7RDlW+6Xf5V6hM0m84a/9?=
 =?us-ascii?Q?fB+92ZN01YCNhiVXJ/NHpcsmrvR1kmda5BqnPUhfYRDq0qfDHk/ILaASNnhz?=
 =?us-ascii?Q?lvZEbmzZElM+SS+o1TZbGGzBlCRP3udBdYU6cbWdcd5JXz1scrnyPn4+41+B?=
 =?us-ascii?Q?Poh66OwEi9t+kANW0vWAPLxPTH8TVYWE99oJEYqZINRf+0MygGZd3x/Pfqv4?=
 =?us-ascii?Q?acGnIfZt5Zu9+SRdD0MfmBxkvQUgjU3MNrxCBgbwq2VKW2lpYwMXS38Aq5Gl?=
 =?us-ascii?Q?rsUM2hIl7PqYWRuERsN0iNpsejwPxKHwdbWAa/R0ak4WE1jYixkg?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fc991f-5751-4b10-9d05-08df1dcb06f3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:43:14.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99uChwWFpNbzMXE2ZMQ22Tk5WcD9Oh4wkUGqPWmglyn3ns4ARoP4THaTpX6yNRK+veNIPNmAnxPbGzRRWHDxIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2243

On Mon, Sep 28, 2026 at 10:57:12AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2026-09-28 09:25, Koichiro Den wrote:
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
> Thanks, I find smp_mb calls difficult to understand, but I think these
> are correct. I expect I ran into this problem a few times back when I
> was working on this code and had no idea the cause or how to fix it.
> 
> I have one minor suggestion below for the comment, other than that:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Hi Logan, thanks for the review.

> 
> 
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
> 
> I don't find this comment all that easy to understand. Can we expand it
> a little? Maybe something like:
> 
>  Order the link_is_up store before the client_ready loads below, so
>  that this path or ntb_transport_link_up() is guaranteed to see the
>  other's flag. Pairs with smp_mb() in ntb_transport_link_up().

That's great. I think we can use it as-is.

I've gone through Sashiko's feedback on v3, and I don't think another respin is
needed for those points.

Jon, Dave, if v3 looks good to you, could you apply it with the comment updated
as Logan suggested? Of course, I'm happy to send v4 with that change if you'd
prefer.

Best regards,
Koichiro

> 
> 
> Thanks,
> 
> Logan
> 
