Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013001.outbound.protection.outlook.com [52.101.72.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DB375ABE;
	Wed, 12 Aug 2026 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500789; cv=fail; b=qzspvCuF7I+HEnWVNHnPr083Nkz4wCJI8108CIgXY2yoiw5q/M9DpnIv/MEU3dTwE8SUH9W7RHHYyPkaQzUatKQo4ClMqb5KG7ZCHEe1mMD9bLXykMx+L0fsvqon80EqiJxwc3VwoCviOEr/NxPRDT//H3b8Ct6yxeO7cQ91L+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500789; c=relaxed/simple;
	bh=TJ+NDfzLoiVcPsSB6cGiLgMv+Q+AuuwDQrVsC+A6fbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OtKzV826BPXACDFgC8iZeF7rEfXUrdQAdJvYnnRG38TJYXiaAF81XWvWQESWxmh+HYK6ZxdeWCCcfSt5xZvWVXcRp9miyhwxqyKgoT9Vz1F5IrZz0KPw7WNX4X3ZdYUe5xsecfMRe4rqR99rf9QCmTLiPs3eAb30apTK5S8UeoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cP2gYikZ; arc=fail smtp.client-ip=52.101.72.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cP2gYikZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVY7NHr5XXEmi3DWSPf6NfKKNKvobNbCuDdp3OMwHqM1k4CtnQPkGq3qHcY9Micjit4BUCl89+orXODKElRQEvf34FWkzSqvpJdrJTxqQ/iUYOJq/GTRmb5CKXQyqF32oVpMiLvn+P4oMzHyP3FxkNbUaBy8xX4Csyz3pwFqt0RjjKqlB1kQC9RYzh4CUiFJZy8NiUSL4Nji+y6TQnRAi2iJNg5qZ1dALR8mWOw7ivbkgkB0Rb8odFt48VCzu1GoQGcI5NJxZurBBfh2G45tMHslaPlR62ouCYQnftFMEXEaSfobuAd5oGUjad1dBJr4ZpYi6XweUNa04++uj0vnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU+JCKjNs4tU+i2xY1sm4+eiRWgOowjuURX2fCZEufE=;
 b=NdeWg3O9IvYW9XnyxK+y4xIvSHSIf7nAXn4vzZ7m96TSo6fgbKDQz67Th2Xm64Kp5iL7L8sbscyzprd9i7crb3HUwm0LfAMaA5WT3Ri/DdwVyDIU7uiuHZB6gcY+y/4JuGP2/bvHa3u2/rMCfLxbMqCtWqKfrvY4RgsDIKGzpZKSHipKzwbPneYpY3dtMEweGaTjlSLWJkE6Mmo9xUsvh2tEDGIF3WCBTnQmnoEPSUOycrKKzNUFLWfsxqSzgpUhzcVF1Qdx47Q+XC3F5X5eJDGqiQ7Yeo6mgPWjoEA7syM4T3EcCjoZrxDM79mpoLe/hiwFCL0dk0nz5CGYhDBGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU+JCKjNs4tU+i2xY1sm4+eiRWgOowjuURX2fCZEufE=;
 b=cP2gYikZdZq13SigFOra+VCl+Avk9hXLjODo9rWpSFTmh8QQ0jQZGwyWaJskcH11y+tuZekeI+H1B6M6MPAzfoZG7m8RWosfHteiqZDYsGGd0WedZhboHgrNW5pcSVvviOwL/D7UWXrK8ip+37d5ZWpnqbiwVc9fh/jYU+tNzpDUU8Uw1D7mMS0XFyoUhDaNdnHIfEUFgKj7/6/X5w4Saktk/y0trg58YmT09de8cnVR3EcFcquqqlhceNE4FL35c3z7R8GS8IEkimlxGILkh/6IzqzmFe73kHDgFwY4wtBepdFxWTPQ5/FyQZZ0yQ2KkY3m0FQK/jeV80uGmiNz2A==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by VI2PR04MB10114.eurprd04.prod.outlook.com
 (2603:10a6:800:22d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 02:13:02 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 02:13:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Mehmet Fide <mehmet.fide@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer
 allocation fails
Thread-Topic: [PATCH 6.18.y] net: fec: do not release NULL pages when RX
 buffer allocation fails
Thread-Index: AQHdKMU9bLq6RZsLi0Gmgbb4XYGJdbaZrlqw
Date: Wed, 12 Aug 2026 02:13:01 +0000
Message-ID:
 <GV2PR04MB11739411731A5E8ABED22A4C988DC2@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260810123902.2611897-1-mehmet.fide@gmail.com>
In-Reply-To: <20260810123902.2611897-1-mehmet.fide@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|VI2PR04MB10114:EE_
x-ms-office365-filtering-correlation-id: ff8a5ac6-0333-4801-ed2f-08def8173cb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 5gg0vxs9Dp3gqz5Mdoe/lZkCHtCpPQ+9Q+eDsitL6dqTnE7MMBldmPmE6EM2nTHfMp2CjwiTn6wyBT+6cBVPCGLpYEnPs9VQEUkTIKdUEh4awfSUrTTTryy3eICRNXPhpQQqjLXGniaVhDHF36eCAjneh56sbYxtCCDwfCliv2sc7nIzHhHfB/C00OX3/fyACA8qeIlt+PspVjMQ8CNZJ8yXqZQGP7meX64JjVYIvmPWv/k/oJZBAm2x2ogEdI3+6fk/PFrQ5cN703X/ubto3mvpxSTe9/1F+0T6Jx7whm9m1WeLIywRYes7kwUdgpXRviJD7DSmqC67WOvoxy2TPXt2+NVr65ziLMpGZYdgPXv94wK7CtLbhG5LVIhFS8xIlxEldu7TthhjQmrgMkCLBKQKZobXH/JS72LCNRsebBZiQOfYu111DAhavK8MWofU/a4S9wkqf4jF0FvZ4ZySWIvzREgTTCiCdD+ZzgYcJTtjj8u7Hg1c8kind4ly8o1O9xJvt+BlX6EsHFNfQplW2YV9r95SXVm/mRsim1N3siR2lQU85gnV1sHA1lFS6gaO6cJSPcNxCm+WRsEvJ0mdnWSxdJyiTjsnpYfRQJ0Ovq4kygNyy92mUsNziCk2mQbcwWDtU0Z+EGZyXVBW6MzfBguwrIeRSirTwv48Y1SdMhk00TaAS8I7NHxHHIvfPELeEJUhatGkxP9c3mZitKeSmWen3IsMojfVjYqyhp19HIo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4ude5pk489jlke/A3Ff53BoYJ3C3EJLwxhpzwpxuElqyyJMsXLlonfJ/wFPb?=
 =?us-ascii?Q?pP9j1ZnM5gWiawmZ29bB8sut+S/HwbXeaRZ+cmibxpWeZtQ+mP9Ph3iJ5/uO?=
 =?us-ascii?Q?VwjePqznf9XugLZ4RlxHJcwTZ89gD8ZAzr7ZaHsdud7HYyYUzaJxMmoU6/g8?=
 =?us-ascii?Q?uEdeWIO1KNaQPYgu3wfQmUjVrLD2lKqh+hxXK9U6Nx7/ieWf5+BrogrQsTVb?=
 =?us-ascii?Q?7BcDnWzTEGmLpfzOvvtP/oT55+5lv7MsWRGdn7/j5QUdz36MJ/kda0C2udgc?=
 =?us-ascii?Q?FX8goNvDd8AY1sv7MgNs28X/alaBYpzFIFwUM4wHAi0ER1oEtuy9zNsIqVss?=
 =?us-ascii?Q?RHGJ9ZLm3/rXH/SRj9T+WSO0LrcbW+aizwZ1pp/bNsUvwexGU2SqiYu1/3UH?=
 =?us-ascii?Q?tlkntNrZ+/UuxmgOyVbX+posYRA22uGWRaF9cOdluvfJrAXid7IGCAWeBZKl?=
 =?us-ascii?Q?tmlZD2RtEHy0TNsTFyuU3iamoRNKHrLsEgYS78NXDYGp9wXGrf+Ql1KpD+c0?=
 =?us-ascii?Q?5pCrfogSDjeP9wmD9TBOiGEcEVapzHq81TmfdFFsoCg7RX0QpZGAeTlYli+p?=
 =?us-ascii?Q?lNel/jjAkNCEPGtcwsMOGJmp/1mSaaXVObCYeGwZ05TYgP5iXwhIXidMjjoc?=
 =?us-ascii?Q?VqXDCq+bWMoFwpNW1sb+dIilWKMtF6GAn8uFaWh51u0qyyPCowFqKSl9TfZ5?=
 =?us-ascii?Q?CzwR/IXP9urGBUvPzBG6b1c8bgDHnbk1El4Mk8pN0tn17YlPyU4UPxMV+V8q?=
 =?us-ascii?Q?1rN19lIFtSrwiETTODBJMQ+bJ2Gwxs4PRdVK64m/KvBDAppZdQPUNjldX6IQ?=
 =?us-ascii?Q?ViyAu2vV1KG/GUj7R8Dw8u1NcgXqzR3aoFhvJdvbPUWrwC+Ptt2YHUa5f6hT?=
 =?us-ascii?Q?MgZzz20V59nvbKj5UglgOZEuZ23/zJoirCuxai7BL8tUDe3056c4P8I2JMOX?=
 =?us-ascii?Q?AFt2FbLK7i32G0H1MFzrruZr3gmoECpdb1jUQHatbFnhA17WXsj2x0c2BBj2?=
 =?us-ascii?Q?UCKv4h313fbjXj+67bkWs5ITqlwkXKk/2xlB7ZgYs68HPK4sYuaMf+vnKCRU?=
 =?us-ascii?Q?C0QMPLYjEtw87MwVKv5CgFbqm4W6mqHR0mG5Tzpr244AcEAenIfk0oDPJwuQ?=
 =?us-ascii?Q?Ymj2SIT9MmFp0+FBC4ThVtkmvTL0R1vwjkdQM8IpDeo3ckSb9yP87Pvjynto?=
 =?us-ascii?Q?DwIRUprA+/qDHi8GTmOlcKbV46bVAG4GodjM5uqRpGRkEg53otn2+TfD6pYk?=
 =?us-ascii?Q?cijcl4ZgMGjnKVpb+Gt82QbPtmTBF/bExZpFBPEAs4oXLQ8CNN2yNRNjFA3Z?=
 =?us-ascii?Q?GCc5QecePl/8O2Ip4thN9JTLNw4Wa5KKQCdUxNlGdFj3/khNEXMLsIrwFvKm?=
 =?us-ascii?Q?CmxWYJwEKySJDr6sWa0E0OOk47r+rijeNDV0o2+l+lkJxoiJCGk4smneaguh?=
 =?us-ascii?Q?TT4qTY1593g5SNt5jjvVs/QqzS2xgK2kSoENqKVwKq0x9BtevyTxQEmcXfSz?=
 =?us-ascii?Q?EWkj9BU1iIKtNBdMzm0Bq6s529i7B4KnHi3usy63TQUAwx8GCm1FO2V0d5b/?=
 =?us-ascii?Q?MDkmCPnu6zRx2tN2j39SS8YllM1MDH7ibsi+n3jg5jg4rmVHv2EGZUwoCX4t?=
 =?us-ascii?Q?r+O5apDHv+sFPg8etQLhjw5lkx4u2ifpgNjdaSq5XyKDGQW1VfecfsWyGMBA?=
 =?us-ascii?Q?Y3FFPLrjO/3pkTMYWOpOgJJUgDqhOmA4R1tZhnuDuqJzDmcG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8a5ac6-0333-4801-ed2f-08def8173cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 02:13:01.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enw7fRpS1WhExGjSNYcw7kiftIRjTg5y/YcytQ3EbZL4HlsOqyTEFylwGWClHxQ9YKxhrrq9oKnFN6gqfbhjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10114

> fec_enet_alloc_rxq_buffers() leaves the loop as soon as
> page_pool_dev_alloc_pages() returns NULL and jumps to err_alloc, which
> calls fec_enet_free_buffers(). That helper walks the whole ring and
> hands every rx_skb_info[i].page to page_pool_put_full_page(), including
> the entries the allocation loop never reached. Those are still NULL,
> because the queue was allocated with kzalloc(), and
> page_pool_put_full_page() dereferences the page, so an open that runs
> out of memory oopses instead of returning -ENOMEM:
>=20
>   Unable to handle kernel NULL pointer dereference at virtual address
> 00000014 when read
>   Internal error: Oops: 5 [#1] SMP ARM
>   CPU: 0 PID: 384 Comm: connmand Not tainted 6.18.43 #1
>   Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
>   PC is at fec_enet_free_buffers+0xb0/0x2a8
>   Call trace:
>    fec_enet_free_buffers from fec_enet_open+0x1e0/0x504
>    fec_enet_open from __dev_open+0x114/0x238
>    __dev_open from __dev_change_flags+0x190/0x208
>    __dev_change_flags from netif_change_flags+0x1c/0x58
>    netif_change_flags from dev_change_flags+0x44/0x74
>    dev_change_flags from devinet_ioctl+0x3a4/0x768
>=20
> Seen on a Colibri VF50, 128 MiB of RAM, on the first ifup after boot.
>=20
> Skip the entries that hold no page, and clear the ones that do after
> releasing them, so that a later failed open cannot release the same page
> a second time.
>=20
> Mainline is not affected. Commit a2ae70c0efe4 ("net: fec: add
> fec_alloc_rxq_buffers_pp() to allocate buffers from page pool") replaced
> this loop with fec_free_rxq_buffers(), which skips and clears the empty
> entries. That commit is part of the XDP zero copy series and is not a
> stable candidate, so this is the equivalent minimal fix for 6.18.y.
>=20
> Fixes: 95698ff6177b ("net: fec: using page pool to manage RX buffers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3341,8 +3341,15 @@
>=20
>         for (q =3D 0; q < fep->num_rx_queues; q++) {
>                 rxq =3D fep->rx_queue[q];
> -               for (i =3D 0; i < rxq->bd.ring_size; i++)
> -                       page_pool_put_full_page(rxq->page_pool,
> rxq->rx_skb_info[i].page, false);
> +               for (i =3D 0; i < rxq->bd.ring_size; i++) {
> +                       struct page *page =3D rxq->rx_skb_info[i].page;
> +
> +                       if (!page)
> +                               continue;
> +
> +                       page_pool_put_full_page(rxq->page_pool, page,
> false);
> +                       rxq->rx_skb_info[i].page =3D NULL;
> +               }
>=20
>                 for (i =3D 0; i < XDP_STATS_TOTAL; i++)
>                         rxq->stats[i] =3D 0;
> --
> 2.43.0

It looks good to me, thanks.

Reviewed-by: Wei Fang <wei.fang@nxp.com>

