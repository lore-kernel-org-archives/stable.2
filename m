Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113412;
	b=4kzlZ9I4qPw8QWOfmilb2mqLbO3/rtpANVf/mtYttaS/RFfWMCVyiXd0jMqe1vrovSEg
	 A4BqGUxA4SKYe7qUixInX5CHiQMUoTIqLYN1HXwHJTDexmEZu18bsDQfhxZcM+9FHaad6
	 tvsnuv1d1YgjP62bnDt9mnXIMbZ/Jq7UH3Wb1dg66anBX6BL3uly+WTWApMOWTnqhtiIT
	 KR+s5+uyeEefPihQ0HSMAD+6hzlyGAAwQmu9vomN5oLTiN4bsCCtTV4q8W7vW+Ffre41x
	 tgb3YhlwHmILhpGjHuX8ilmpaY+VSnm7Ibi6mBo1pILHQ6tlNoQMNy33FNEZrIy9y/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113412;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=z/bY6mNNd1WbmXffc7k//7+xSr/csoTXPgxvIibZr7k=;
	b=JJPiyPbdFSFB5iXz7B8lxjIgpaCdSLcITe8xzdFC/9vCU0AMW4JrBXK3iLc4cT8dFIP4
	 zEHhYZF79gfJ2nJU+vUtxo0/k18AIdi9d0TfhGxCnJtV/KXSoj/XEib+fWnd8GtPMnU7c
	 WSLpFKizmVgkHHtYtlLrfmjauiCjyD6VTpfqKIsqZEXcO1lqQk79dss4iBnXMCnI9a3Bc
	 u9ZxLvs+RXkq6Mo+xgP4kCycyl5TIT4DcswJPvQyqRYqLqp6In1YaHjE0d68BStMQ4Ush
	 ddxr8dOUj0p8NdPYzFpzIVQOiNKtRbH3DHPBQ06SfyQjdWDRPxWG4PchZ0ZAoy/2SCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=uZUIcngG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.87
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021087.outbound.protection.outlook.com [40.107.74.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172F606A321;
	Tue, 27 Oct 2026 15:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1172F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=uZUIcngG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR91OMg/bF8suMRvLWEOzYC8i3OtqEqe1927nm9VdKeCOe/iHeVKLWzOv3VcsH6tv7+9Mq+tpW6HfICbRNfMDaVuZpRABOBLoUmqKCTi87DlGRRj+Mud5BXmnIPfiaYemiRhnvzJf6b56YCGir8bxXmRZFQBJEUZkOqVvKoBOPcqaqQqVdX1FPQBUaXr3wCV4o+DAE8Z9VbRQIFQIb1p4dJUOR3FoEn5J5X+ZtJMZH1k3wVWJIGReIM+fCN6UVO8zq3xAaHOwxn1gjU6ZbzcfkUca+hWPIgZrDkba7XJvOQRoqSTPsXDageaR7AruE6g3JIwWvdvP5rGeLoEEbUzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/bY6mNNd1WbmXffc7k//7+xSr/csoTXPgxvIibZr7k=;
 b=v7uHsalp+dG6/oYTrxv3xcSwFfEQfEB+CLWYF8e63Zx5lsLyo+NCFeXolFLF1dBm1RNJ20HKgl3RKZ1DOrtmwbs8JwrTVMJs7fOoy4DyId13RfgrCFcQqcyzql++kLTC+1jblfq72KVovbHrLmJKXuNLWEZ/oVMM9mwkkW9qJXQvnlaQwAPNsy4OSuGEVVIueMdsbfTlzWF/znpA6aEEI4k/DnyQxX9JZgkijGvTJys08FzFit48klaACUEfI3jzdrFmLVOZI67V7XiBxq4YsA8z3cPaEPXzgUma0Sk6ynYKOnngcKJQUWVqcz86OHpR7hoG5Dt3mwTkc1Xkc8FFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/bY6mNNd1WbmXffc7k//7+xSr/csoTXPgxvIibZr7k=;
 b=uZUIcngGawWicgwwx4oQdXQbLGSQLhi/IYp5ffluP2H2S+Nn5eH6ZYiYsbx+n8Kq3pcOjcXAoK16XwlrLp/qYKmtNynyx0AvHIhKCtxOgom9y1CjWYm9QM4Jn8eKSTSglCB6WyOLGmjc0N5OmKZNkOeMUHHvSCemlefPecvi8DI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB3056.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:03:27 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:03:27 +0000
Date: Wed, 28 Oct 2026 00:03:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 06/15] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <kme4tjfqeyuzwyzxwbohhmbawsr5gupuy6xqcrb4in5bc4shg2@44xw6lotdfv4>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-7-den@valinux.co.jp>
 <cf51aeee-d951-472a-acd1-183028da966e@intel.com>
 <c6zrmhs3d77424lgxbeul4237ovdrkskoapqutuaokjvuve4zz@6gh75sbdtt3b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6zrmhs3d77424lgxbeul4237ovdrkskoapqutuaokjvuve4zz@6gh75sbdtt3b>
X-ClientProxiedBy: TY4P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB3056:EE_
X-MS-Office365-Filtering-Correlation-Id: 51db6da9-cc12-4586-001a-08df343b7482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|7416014|376014|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|261026135527099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	I6WvAFFztL2twclv1eEV6wBpBU9nN6sOxBcgscRFbxBa2nxq/ur2zPc/BQdxY8bT/cWjYJatF/IkcfN3t1m3Y9BSjbvU6XttIMnGddF1q0S4FKyCEx4zndS4IETupbXFVw5sOqNKLjJNWoKIUii/P+Rzla1+TQIPJnuSIThwthCCJP6tC+RDdHs0VGcHnnZCgCsZxUVL65YS16PRFlUB7s5M5moQ4IXceH9K+s7oyjopA6cr5ukfyEA/bysu1EC1xIAT0Zz9hyzv58ueAKIqCzyGrIeIL2jSpG17TwPVm6oeSNOGz0KxY7RAtZ5j+d2mVQxjukBr/cNth+83ne9ndspyFRyBIfP1TiCpYSqw2xVlzTfie2VlIcFcqsnYsgNQ1x+owzhweiMfdTW8vjI9F2DA5DQ48iEseDqypXZr1Sc3JFp3ZU3W4yfoujGoHvhc9IeZgwsQ7vuSAt1El4z2fH7s/okJpOkjdDbyrFNZ/HMpjlUiu5VCKfQ9zwuFij6IkXS7tU3vR3d+RmVF0mxFdbtYJgip1cta0kDHgU6XCKA7+TSJbZ0hBNja+QeKjX6ASgQAB1lrBq6honNN9h3lq0Zk0JXK6uikdpSmWooCZpM+R0CgFZX5n07/XknnAOkb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(7416014)(376014)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(261026135527099003)(4143699003)(261026140227099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zA+2KbbQYg+bWAlTo6nk0suLWPMRCGWqddinx6a4VxIv+Jd7nN7QRTaK5dHA?=
 =?us-ascii?Q?+Xfk4VMUs5tX0DI6n2V13rkILZ27z9sRVI04cSKqcg3UN+BF6mph1YAC97QZ?=
 =?us-ascii?Q?upDbFkCDCQ+0IISjzvvZT2AiSHW0mJiVGYV8IK0XkVolnTiEbe6FYeszEskF?=
 =?us-ascii?Q?VNK8tRS/crs4/Uy2RD8UnrgBdoeDPT+L4kKJ5az9kPwQc+hgzvmQrvoMrlYV?=
 =?us-ascii?Q?eOJR+EhHmCc0WoloR3Sr6KocrrTcy+eCe8NtoWbWc091Q32kwD0JI8vXAriQ?=
 =?us-ascii?Q?pe40XmLSZHwH9KGw7otVyzK+QFojwO1hdqhbYoCRsaKKC+vcX1ze+BAI44oC?=
 =?us-ascii?Q?ZHqlKUITwywI79qXrAu6nkCt4RYU+E+Ozf8FRVkrXFHbEbRTh71I8DHsiGKz?=
 =?us-ascii?Q?+CKQDj2XMAfu5ajb0aTdNjEzyUq6sORQHjibJa19QZyGyxvO6/nx4rZgaabJ?=
 =?us-ascii?Q?1/ZCiNSloyHN0VBNC8qfIc/xhaLaEmURIu6/b2fTvpbUWw5vL+BwBX3Qhn8I?=
 =?us-ascii?Q?SPJ//K2USOVKhSqrtzskJ43YRVPNTtFqyvmPpwnY4iUbpN77gPxTG+yiCuKk?=
 =?us-ascii?Q?4F6mfYcQGFMoLeSFCsebRx/baUjPTuIS56d8u+BX6f1FqZD+vprwWmNUf/j4?=
 =?us-ascii?Q?SsOFzvTvSZeGJkzDe760Ix1HNm32xHg7u9kVjtoNoQQv66KP5836gISYaQqG?=
 =?us-ascii?Q?H5pjgPMzOBmICXa8tsp+GyvEQkWLgjnJkKv03MPK5r4R1fumlvXiZUXHCWrH?=
 =?us-ascii?Q?KPVs2/W7LGeiDsW13VNVMajr6JhuiwHGz5XfHV9vx4ts0tTk42sbAwBxLzZN?=
 =?us-ascii?Q?xO2gDwL1vB7v3qPdjjW2eJjx1v1N3YD6IirIAmJOMZsVU2iVlpJY4VL7rG+n?=
 =?us-ascii?Q?BQpq40l0qz1KtFz+mCve2YVJkrdb/hYH19gAEm97frc0iZH+59GvGIs/wd4L?=
 =?us-ascii?Q?BvGM/anPMuqZ0IExSh4IfsBXFuDfS9piHvEy1U20pw0pzULuY6mkTMOBSxyP?=
 =?us-ascii?Q?aLaNO32AJOt4hb/pEHE0CtnLkAjZVt1BIFfX/N1DAFaOzWB454r1ZLPJlN6P?=
 =?us-ascii?Q?UEVw4Bj+6NIM9UAzb4a9OtJeakDY6scg8Ce53Gb2Hyhn53rfXc2bKGn9lyEf?=
 =?us-ascii?Q?OEgQlRz+N98KyIHjqF088JaKVixgazD43ni0ZXi576HG+ZjsqI8VUBWIwNg6?=
 =?us-ascii?Q?L8XrBzls6CLKLUYicRNtyNu2T0GXBazrvS006WYMd83fC2W8iHefuZ/dgzEa?=
 =?us-ascii?Q?3QPnF53aJCjfLSqNbVRxvOkgQoPekg2Iq9G6NCrmi7cBjNwL2Z3pbrQftU2L?=
 =?us-ascii?Q?Upu3Q0LBgIifemd1k6ovsOyxkStCV12A7NkusUVLOa/icMrTIGH2aDxgwEqj?=
 =?us-ascii?Q?oNAWqlnmLdIRtIL+xz5/cr3I2hYX1D6V2+jliadn42GPJmbAOdL40gAwGivV?=
 =?us-ascii?Q?t2SMsy/SPp6SRMJuQRaIOACz77A7qbNbXZ7ZKN3bArcn+ixahBTZhzqkLNIq?=
 =?us-ascii?Q?M6KOl0uhdPEHVC3wbJPSmiEAtxt/ikFlbeZY6SCe30kFaSk7AWIuIuwdSHlR?=
 =?us-ascii?Q?K0ObuINq/w85X5HN56P/BPVirGwaC9vYqmOj5d3sOTvy1P0mgBS0bpevLOEY?=
 =?us-ascii?Q?SHWpyN5Yw6dwecenAWTpH5lYZNmIZh7lv9SSuSHZZdGz5dX5X49RF5qqMawZ?=
 =?us-ascii?Q?YKa2PNzqoEmSs/jXY0Otd6PLyCCgHjFEjYXrVMoOL+zsO+Rxpos/QLlBObbZ?=
 =?us-ascii?Q?7Qaz+qrovQtDyikOWSkP5CY2i5prztppxGerhfKfKDnBV6zaOf9l?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 51db6da9-cc12-4586-001a-08df343b7482
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:03:27.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0yJ5TEaLWHhNNWGtwzAKOuPxL1yk85X5c/lZGpeKuU46gTJhLjaZgTUYflZVlYLS6HNJGZiun++2PMX02+XEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3056

On Thu, Oct 15, 2026 at 12:50:29PM +0900, Koichiro Den wrote:
> On Fri, Oct 09, 2026 at 04:11:14PM -0700, Dave Jiang wrote:
> > 
> > 
> > On 9/28/26 8:25 AM, Koichiro Den wrote:
> > > ntb_netdev_open() can call ntb_transport_link_up() while the transport
> > > worker is completing setup on another CPU. Concurrent transport setup
> > > and a client link-up request can both read the other's flag as false and
> > > leave QP link work unqueued. The QP then stays down until another link
> > > event or client link-up request.
> > > 
> > > This is the store-buffering pattern described in
> > > tools/memory-model/Documentation/recipes.txt ("Store buffering").
> > > 
> > > Add a full barrier between the store and load on each side.
> > > 
> > > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > 
> > With Logan's comment addressed,
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > Maybe Jon can amend it on apply.
> 
> Dave, thank you as always for your review.
> 
> Jon, please let me know if you'd prefer me to resend the series with that
> amendment.

Hi Jon, Dave,

Just a gentle ping on this series.
Please let me know if you have any concerns about applying this series.

Best regards,
Koichiro Den

> 
> Best regards,
> Koichiro Den
> 
> > 
> > 
> > > ---
> > > Changes in v3:
> > >   - Drop the *_ONCE changes. client_ready is now atomic_t.
> > > 
> > > v2: https://lore.kernel.org/r/20260910040836.3792333-6-den@valinux.co.jp/
> > > 
> > >  drivers/ntb/ntb_transport.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > > index 51d9e9969065..d290e5869c21 100644
> > > --- a/drivers/ntb/ntb_transport.c
> > > +++ b/drivers/ntb/ntb_transport.c
> > > @@ -1101,6 +1101,12 @@ static void ntb_transport_link_work(struct work_struct *work)
> > >  	/* Publish the link only after every QP has been set up. */
> > >  	atomic_set_release(&nt->link_is_up, true);
> > >  
> > > +	/*
> > > +	 * Prevent both sides from missing each other's flag. Pairs with
> > > +	 * the barrier in ntb_transport_link_up().
> > > +	 */
> > > +	smp_mb();
> > > +
> > >  	for (i = 0; i < nt->qp_count; i++) {
> > >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > >  
> > > @@ -2400,6 +2406,9 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> > >  
> > >  	atomic_set(&qp->client_ready, true);
> > >  
> > > +	/* Pairs with the barrier in ntb_transport_link_work(). */
> > > +	smp_mb();
> > > +
> > >  	ntb_transport_schedule_qp_link(qp, 0);
> > >  }
> > >  EXPORT_SYMBOL_GPL(ntb_transport_link_up);
> > 
