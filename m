Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA71314D06;
	Thu,  4 Jun 2026 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780598994; cv=fail; b=Ob+IWYb8/FFRENTEo4ptO0+IuUk50OOV7rokppD2zNemgUy9kioZvuZKFfhjv6oF4HUTd9tueSyvEi5w/Q+K7G4fqmqjqEN0U3K3eJj7tyuMi3/kaaPqeD/GN+jDo4PF1CW/N3yD90Yw2LoZDxjhoAKNxEh/c9nn4O4vtodbA00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780598994; c=relaxed/simple;
	bh=00drOwvojZ5q1QPetRP5edo8k7rlpA4vCZVqQd3xgNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NzKDT1+J6cSRm2MWyhNpcT0V9dDhIRWWBobeAeo7sFxPQDOzDKRHHQBPS8mtYmBUBodnvK9jZWTQGQEj+TTuft4vU5Eu0Cz6I+C2u9wgUn8t1em1SM6J3KVXfI9KSlnMvxq525+E7D1FME1YzJggam+MhmQtKly8SBYelyhh4V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvCzaIRU; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvCzaIRU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxa/Idsda/JojUMZu51a7c9eeTX0+eQCW8kQQDEJbNnBGe7QwMgWjuwNlw3hRMqXMVA+MsVYFMHhlPlqGWVmC1ilDNt50FN2WCBfi6hINA/hKBuO9tc5GbJdpE8aitbY6HMeZuhbbGQsfcGMDOc7aq0vZHdkyPX1eCoXNV+4wDit3vgmLovmncCluJwZta4t5k5VooagCTJIF80nPZjNkvK7CW63qFpstSCaRogVD6aYb7Kl8tka1SHUTlJPsnPz5RaQEtwfgTGuQqGIq06istPXCn/P3PpTCkvpEJ3csagnwTSpq8c3Zn31HhoBy1xxOB2Qn/H4Ouo6bDPWBkx27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYfhCAN8BtURDykXQWKjqqdOajaqp5Rbbrsek1MEc4Y=;
 b=fwiEqTQk08i4nji555vuCj7u+bZMecblAmNLL42WEZ9eV3VrBXQdwjyJbI20PHr/g/AfDPMe6kA+e0c8YT46Hwi5LWEfHl/fKVpRk71ay+IyLyyK72wN998gqkiKMDT6j6reizmWv7ZVXU3afW+g49nWSoyfhq8puKiWK4RjZ2nDOKhgxA8gbtl0W9peMqk4xKhOo3STdKI5DK5YvvMgHHuxGfqCRfdjV6+rkTLV3R2qlqWNO5/Tvo8aBgo2e5tPKcVNHQoJdafpZVGYrRUUNRSbNO0nmdje4nOwnRQKUGEEFmwN401X2JuPikZNaEFwP8CaHP4PzDIm7Aqn6z72NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYfhCAN8BtURDykXQWKjqqdOajaqp5Rbbrsek1MEc4Y=;
 b=JvCzaIRU67sMWPKWG9mRNbpZs3FWIvDiz/hGw56ISaKRtY+MJu7MobzPQ7cApZ/4jdu1rx/LA2eiNH6DWzV5DrGSCOJ8R54XWn4m8Y3kpEk3U34I0f+Xx6M44ouKuogCrDgpakHAWb+zKday/s4iJXoX6b89mNjV+PsCLXtN2EfXfeZgOQ+ZrTNRagtArkbWyn+RzepiQieyOvzViIow0uR89AkD4WA1meCA/pRioFMAVtrD/2WzHJz1EAgeqLhEZ6s2FCvymp63rh3Z4TxUKl0aBGI0yKtE3Ztwv1w3ooUzwnfRrG/hb3NYij/cWQZSDYi+42bUWzjB3STxelA6Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12055.eurprd04.prod.outlook.com (2603:10a6:800:325::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 18:49:48 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 18:49:48 +0000
Date: Thu, 4 Jun 2026 14:49:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>,
	alexandre.belloni@bootlin.com
Cc: wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com, p.zabel@pengutronix.de,
	claudiu.beznea@tuxon.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 06/17] i3c: renesas: Perform Dynamic Address
 Assignment on resume
Message-ID: <aiHIKEKIT_V4RdfP@lizhi-Precision-Tower-5810>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
 <20260602132824.3541151-7-claudiu.beznea@kernel.org>
 <ah85RaUXmaBVFkYk@lizhi-Precision-Tower-5810>
 <8687d3cb-628a-477b-9dfd-2db8c412b277@kernel.org>
 <aiB_3kneo2Scy5bB@lizhi-Precision-Tower-5810>
 <19754889-0aa9-4a4a-b015-8ddb0a61b678@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19754889-0aa9-4a4a-b015-8ddb0a61b678@kernel.org>
X-ClientProxiedBy: SA9PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:21::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12055:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c41b465-b818-4826-5013-08dec26a0d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|4143699003|22082099003|18002099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	DOOyEpfM4bumSQgvnSHjGu6FYUEhvfegaJvO7nEB8jLW7ddBwF5hSLcyFh7iQmmdN1wM2l1fBLeap/VTScEqoNd2rs9keyfcXEUf1tKz372G9ip+ZKaYhAwrbLm6+NnaKUMUmuAiQ2BIQGn8IsfsVmmKOiDNv+58PQzsShukviMqG2qCp2sVgiUj48irZ8YMzGk4ZV/rWO6LQOFUQ8q2drgiVlCOb0KOZYFTVAA92c23SQmES8hxQlCQf4mRb6hB8tauNtBaMBbzhwwPV3CZ6jWLyWa3F+irNsgj0bc91IQnGkSJOzV3Rk+r/gH+fHUbWRWZlwJ2MveLa0amxa+5hSLay7vEWCVwDxFAuSQbKvaH5YY6g2MR32oi71gfnC21/m8WJ7kvGOBILdGZDAY9QyMy8RtOljGGueGfvjdrz03Zk6+05cTBk+JkTxDHZeBtsv8FcnGSALLHiQLJY9pg0xUxHgG5HfLDheIsJ8VkYVM9xlzEgZPbreDD8mVEFk5naCrFJKd1kwm5ZLmChdDBU4Fz4LCiLcDIxAeNirI2JkHlUTjXmayLtwi7bNUzgNiKShqmMMBavfA+AXZFTJ0AYJtmwZTuNGH8z0YlFmQPig9v0+d/Md2aIwOT7A0IZniXZa+lnMcWOHI2Obu5vmIJKBHG/hz9byvI+VZFPFQc/+9+s0NsM/c+4DE3f/UoVkN1oHX6P/e2YsVNCPtLKuMmMw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nf9hOu/rM+0QS8rznR1npkmSmWi0jdWhNo4xUX8sp17SYxHssLIX/0iW/1+o?=
 =?us-ascii?Q?ZGeyQrE/b7F3mT/P2L84/OGC6FXG+mdqg9dAo3/iRMtDfBMM+GRXCecS0JGb?=
 =?us-ascii?Q?K3B8Jq3pcxzoT3XcSAevC56Kqkd6k2iFWYm8imYdMjp26JIYect7FXm5zxkM?=
 =?us-ascii?Q?SGRsAoc3diZX080CECv4l1Kb3CjfAu7dUA+L/+VFDBihGjDaT1B01xP8fqoC?=
 =?us-ascii?Q?Ue3/k8kRox6EOVcbwmZTkfwhgf5ai3zFCvGhNJu5hRRV559jtbRtM0n3FGMm?=
 =?us-ascii?Q?piw65P8Gwgx1zPIz5+3L1OiHAgXBhsaAOZWzBn+wz7tlHXEUGeUacU/0oUEN?=
 =?us-ascii?Q?gzCbxrxr6BEuAP289OvF8VOM1+aqgLnGleNzmGPaB/0YvnMhVafx0XetpYXv?=
 =?us-ascii?Q?gos4VIc/ucCZVZsxMzo+cDz8K6D2gOHhBdl/zQX2vBS+twHHzWldH7OvQurP?=
 =?us-ascii?Q?Y/Ws+hi22begYhBnKX9apOKn5fJ4ZANvZr2G9EP2e+J1gXHHnu4TRKBGWrht?=
 =?us-ascii?Q?9xyy2XSqjeQc6wZaC9GPnUgkGYCpDvhnHs9eT1odwt/QborIJT4Fd9AZFliu?=
 =?us-ascii?Q?aydT37iLUfaDROk3DHpthzenIE0HAgrV8YX33Zhr507S4FMtQmljaLQOvLNw?=
 =?us-ascii?Q?07DOglqVpEOTaVNQ1KbOwt9cGe6T+15qTkJlwe+Xuvgx8fLRDCsa8c7i7wVm?=
 =?us-ascii?Q?7Vlk4WbvSoZ/+ykEyj/vn+geycU/WJQuDpw3ZcG0clf3tZM8gSoDVaWuihPJ?=
 =?us-ascii?Q?+oxX6Maa8LK1nkjUwZJPknChhCFvL1TYrCqMWAV28zkH7FV8mryVvX8NKeBb?=
 =?us-ascii?Q?AogNBsSmHA+h4JrZe6JauC2B/gkAq/QDzxAW3CR6iv1/bkg0UdS2Y0KhDtEq?=
 =?us-ascii?Q?+aCkBYx3uDbjGIQOqQIEOXoU6AaDZLkeozPTcePq1NnOjkgkYk0TFEKMdWgE?=
 =?us-ascii?Q?8rrW8hMxZy9WssA4jhK/HMzImMS1UCW96FA+9VpBLQgVWkgXHUW8MljhxhrS?=
 =?us-ascii?Q?320QT7mh3gxt4Wc2qEGcTeTT56Sd54tLdrW2XYklCfTrZqfi+PFPleg3Ahql?=
 =?us-ascii?Q?zoTAJrmWs+wXAn+/kQXprbyp9snsCaW7RROdLz1OBotRzaSOCvwAu8gTO4KP?=
 =?us-ascii?Q?T5W2iMHdmMFowNW5o3MPn9uqF4wk7WBkYDFUwD8C0tqdFHUY/ruvsEnLjxQB?=
 =?us-ascii?Q?4NdXrlNYblfKs3PR7N6pK/CZu5WXGz0VlyQ1n7d7Oy48AeOsX+Tkr1HP4QKn?=
 =?us-ascii?Q?OV2z8HVmOMUpPFcl8Lw3cA1sTN7JK/I+wAatwB8Z+iN0vNvT93hKRTVP7Ais?=
 =?us-ascii?Q?Q0TfEWYHnpyFA4womL9HsH0RzeQ/1PZc0Pzuum1y6zp2/xmn3M3NPflvRoCc?=
 =?us-ascii?Q?bkBVls4szGQoVR5ahyofcdlMh9j1u4soKVleAAyjdKpanehbwNvDljweQ37v?=
 =?us-ascii?Q?SHEAufk7pKQ8518iIT6VJoWudy7qjvjUfXD7gAvzJ0xoAqitj/1KjQ6vp+Li?=
 =?us-ascii?Q?KCkqLJ4JHCjfInn1MwE7IX2lmT/9y9geKgSj5teKD9b/EE9Do5llUCnCBpim?=
 =?us-ascii?Q?0U8m1EapBjNSGO371mtVRR9LQnc4z8ggIxHS1U2YoaHCWCcQxF4mwVH9ABxG?=
 =?us-ascii?Q?Zz38bzy91oDbQol5zA1uqSoMCgWFOv34FCEyd0aeKlcL3Krkhd3pjIwA6GIG?=
 =?us-ascii?Q?X7dUoOfq9lvhhDpX3SxWACu+xsIcd+3c3S22Cuzg2sMms5FH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41b465-b818-4826-5013-08dec26a0d65
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 18:49:48.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtqKO17vnnWzVgfOqxmTE1d3qGcvPhU8MAvnFeJ0of2GRXgDcW1m66W8K9ljzznvc4QKsuPAqEhZspgGLVjqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12055

On Thu, Jun 04, 2026 at 04:04:52PM +0300, Claudiu Beznea wrote:
> Hi, Frank,
>
> On 6/3/26 22:26, Frank Li wrote:
> > On Wed, Jun 03, 2026 at 05:23:06PM +0300, Claudiu Beznea wrote:
> > > Hi, Frank, I3C maintainers,
> > >
...
> > >
> > > As I don't have a real setup to test this, would it be OK to restore the
> > > approach in this patch as proposed in v1?
> > This case is quite complex, and many people try to resolve simialar
> > problems, you may want to reattach device because controller lost state.
> >
> > hub have similar requirement, which need reattach devices.
> >
> > https://lore.kernel.org/linux-i3c/20260525064209.2263045-1-
> > lakshay.piplani@nxp.com/T/#ma99fa92cb3aac770995350e0fc22c144b974a038
> >
> > controller lost state, but may i3c devices still alive and they dynamtic
> > address during suspend. Does reattach to the old address help your case?
> Yes, re-attaching works and I also need to update the subsystem data
> structures. Something like the following works for me:
>
...
> +                               old_dyn_addr = dev->info.dyn_addr;
> +                               dev->info.dyn_addr = i3c->addrs[pos].addr;
> +
> +                               i3c_master_reattach_i3c_dev_locked(dev,
> old_dyn_addr);
...
>
> To me, this looks OK but I don't think it is yet completed. If I'm not
> wrong, even with this adjustment the problem may still persist when running
> DAA on a full ocupied bus at runtime (e.g. after devices are
> removed/inserted). This driver don't support hotplug but I noticed the ones
> that supports it do DAA on hotplug events.
>
> Could you please let me know what's the procedure to go forward with this
> series? The approach proposed in the above diff depends on the series
> exporting i3c_master_reattach_i3c_dev_locked(), which is in progress.

Two patch already was acked by me. I supposed alex will pick my acked before
your patch, you can send out update and cover later said depend on first two
patches of hubs.

Recently there are more people involve i3c work and create some cross
dependency.

Alex:
	Do you expect me to temp land these patches to one branch in
git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git? so you can double
check before send pull-request to linus?

Frank

>
> If all good with the rest of the patches in this series, as I don't have a
> real setup to test this, would it be OK to switch this patch as it was in v1
> and return with the adjustments in the above diff once the
> i3c_master_reattach_i3c_dev_locked() is integrated?
>
> --
> Thank you,
> Claudiu
