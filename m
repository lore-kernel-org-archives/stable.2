Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011025.outbound.protection.outlook.com [40.107.74.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E2039DBD4;
	Thu, 17 Sep 2026 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627013; cv=fail; b=nB6l40fbe3rMRB1mx6V/buoSG6yrZYpFSOX89g+xW2y7RLb92NTx3aeFtS5mt0X5UvtQVKt//Iypz0o338qNntBDx6XzeNHqNwn2uzOKJuxcE22MwRvLBYQrrEfA97iOkzcrM1yJEZ6Dm/9ADq0yfHgmkaav3hrPIT9KnuEQGzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627013; c=relaxed/simple;
	bh=SDkbxYOXLAd8oXuR1eEkUeEFdMVYj2zBtFhDc0SQmNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o3+npXa6g+3G5ayG8FjVUmfw26UgP28MoJM7ad6Lam6sKV0Pti0TaFXrdm3MrZWsPBDuwej713eXAt2vN2CrUbSzJ6IH5bGnfGMPP1lkniPO02uyde++6ypHJvVNfsEg1B2yrFafqywBuy01oD+J1IFFVzuqncNVEo4yRoEokJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=lwFTNY+p; arc=fail smtp.client-ip=40.107.74.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="lwFTNY+p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3NVQAcDoSSvqVPsSb1nFTdllHCTJjGfxA/HKdzaB1SgOh9zgUjKjjWMUUeiRu0cdnxwuk21O7XXMZvpYnO9Hj2fsKBDE2gVm5/Wi+Sk5SxBfDFCXrZVYnOi3CLMAoPgy3/OPHFkjdHHMZ1ema80LXqMDW10GbRYPqjJuJ7PTsXg/QujyhhQIuoFzUi2ZuQn0JydEpOKq/C7mULPSjnpd/o14FLNeuzqxACxqzoXfsU4TPnL8UihB5JKmb2uaFjKQ5wwWeJZPT1SfZL4Hy1qrUuWF6KY8szOEnaH91lvrDT8zz3nBrEZaXsGck6ZvdhWxTJqM6pbCXcbtXNpR0MYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbAKi+qNE16BFENtbFxO+y2UrhJLqwxjHFCXCR03G1o=;
 b=moHl1L8Hl6HDCcdPaZfheyqFN33/tvuJ0gW/b5z4g14QQ9Q1pGevU8WLkungczzFZq933W5K5pATV7aGmpMFR9HIFHwflSjEwEsQwqLqLvoYjDMv/0gzA1goDgbS5aafVqMuTxWhPNH5DTk1EK4Ov0HuM05kEUvQr9FdwJWt0+NjBU7B1MLDQFkq2WMhEIE55sCNhBt9Nk+BFlv1R24nHJT6kZCP41VskysoKXX61c2tfYI/4m34gB22YNVJ95qDv4UhQWk95wCi2utRUQQOzzXrDs46BQclr1JKq0GzsCf1qTG4LuECNwTBaPV/5FnqrxklD68Jibg/a03bip1Wug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbAKi+qNE16BFENtbFxO+y2UrhJLqwxjHFCXCR03G1o=;
 b=lwFTNY+pBWoz254LHT+Z+Q2rtXKfFdFXTwGPcG5AfxCzhU5ngrrxquk4BzMHR8Hzpzsekg4fBj+Ej4Y4skcVZ3TM62Zu8/xpvu8zZ29v9oIYMPMWc0M4FVhurBh8jWQ1elIxRips1jxLSEq3a9lkyqvN//OnN3cUlYk64H9vMhM=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYCPR01MB9765.jpnprd01.prod.outlook.com
 (2603:1096:400:20b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 06:36:46 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%3]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 06:36:45 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray
	<wbg@kernel.org>, Lee Jones <lee@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 01/15] counter: rz-mtu3-cnt: put runtime PM on
 initialization error path
Thread-Topic: [PATCH 01/15] counter: rz-mtu3-cnt: put runtime PM on
 initialization error path
Thread-Index: AQHdRIjU7IpSq2vAwEeH3XqYKQftL7bR8tIAgABgjNA=
Date: Thu, 17 Sep 2026 06:36:45 +0000
Message-ID:
 <TYRPR01MB156190DDA845D556BF192BC0E85B82@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260914203614.2035277-1-cosmin-gabriel.tanislav.xa@renesas.com>
	<20260914203614.2035277-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260917014616.17b5f0f2@jic23-hlaptop>
In-Reply-To: <20260917014616.17b5f0f2@jic23-hlaptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYCPR01MB9765:EE_
x-ms-office365-filtering-correlation-id: 59c0ef7d-b51e-4ad1-7bce-08df14860b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 KZyfYKFwkjepB8dsKcbuyCjswnSQBQcPBjbkZ7g4AJvesinwppcRHeuynd0MQZPEFvWIg9WWxZbuZ5tY3ZkXvOFNmK9OLH0PFelmw2PUAtB237B0CuXaeZMfQeEfS+IuwwN4F6TkIctnhpwAb4N7zHJxbuwUzyLOOYq/2p+/mXKlypnPdAUipnDzEh/tT+FsHxa+LeRaixLc+k9aNsh5OINxOPgOLQDn3dK9KEx2up5CbAM1hkzQixfthqHGo0PoavOgorVqdJysClIexYYCOWodMI4sXZG4bSKYbcGGCbTO1SmgW/5n37Bm9GcQqIN+CXnKy0v2GnW0RTbtbGuIWJofciGv91i/TYOt/ev+z+A4PPZxWKVGgqhYveVQk9ZfZGWrMFGHXgKdu+MkM+0SRVmH57NSr2PjDbxsNaICMmRms3LIu4GdCHRHaGV7FtWtWhSwQlASI93bCPIhYVdlRimtfMhuuRIo3AoZAGrq38i9UigNIEBvpDQ4J14Mj6XBxxisgrX/q2Ogvfb3R9eYc0tCW/sHTRtr83PUup0+/tylGEjI345wJdX/HudCOurkqd1DilnFDjEjf0ymN4aE1Q5pr73Q/7K2RHLFNpQ4J6+91qzC2vskafE3k9jbU2fJGEKc9NmCEabuKdkhJXoJvIyz+71sr6OGZB3ox3vjoqB5vE7WasnVTng3pKhqaO4UgLN0X9vEBgREYVtjHcDirIpjcEZMmyryHUCrT3Pf9Iw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YD7BofgZTAZGLpPVGn73pYid7xWN4lkCsOQYV5W4fmyXFCPTe5aaDRSJaAy1?=
 =?us-ascii?Q?PRIoBYU4Bo6I6mAXza7MB8rCkeA88MvcmGpiNOTkkf4efltrRBsF0aNw0aaD?=
 =?us-ascii?Q?yqKm918kHTKB0TbkY60pVnrne7MgyI1wPS21y4YNVCUpOhXy4G68l6ZaOKHE?=
 =?us-ascii?Q?5r5BxO83cu0HjK4TmG4xFry1XGRfuNFLufKwsptr+KNXw9K70IQiNCiyPLsz?=
 =?us-ascii?Q?EWYBnq8STy6tGZWdB4SKVSa7hzits6WpYMlzd2ak6nS8xWLlYKKwFavVOBSl?=
 =?us-ascii?Q?Ui9vd1X7yYwa7qE3ssCTZBxgADNwgfXeCeVpr1174wjYzNs9myTvrObOd9XR?=
 =?us-ascii?Q?v0AXrE/b/ogF5dACMQ6edcNqhNVDH7pNOrqOKXpxk6mPlV9MVPRR+2ClTExD?=
 =?us-ascii?Q?i0q2kC3tzAl09lPACXXoiF0wUxHG0OgK6wgCoXHmbVLUnJt5fJWJESYGJf9E?=
 =?us-ascii?Q?C7w83DnXOrPMq+TPnF1+Lx593gMzbd+paNTL4/Pw8sPWznr+/AFb5ndUFvKH?=
 =?us-ascii?Q?B+5KCFe3MM9Tw54KhKDuyl2vudQhDuLNJ1YIT8fy0XdRtsW3RmWKENxpNj1b?=
 =?us-ascii?Q?7eAvtvKyvkJNaZwO5kfN16ebFMz+cTv6h+IdJ1G5Ci83HmNLp7JCfjJdm+m2?=
 =?us-ascii?Q?5TPZwFn/sRKbAlbwwo07SgY8qM1bcTSEDPSoBEfmeq6sIYZFbUTgZvL0zbZi?=
 =?us-ascii?Q?/bGPkrcUUjHTRCfpp6XUWF/ZSZc5mDvnhu2zSvvEqeiPqAdwDjzUrHWqZiq/?=
 =?us-ascii?Q?9RRJEFQ3khAZgWBDNESv2Mk1PmLqEaWdVI0gyCLGjgJWcwZ0oMtiWpO9Eqjp?=
 =?us-ascii?Q?ApKcdjbUi4HCOgKie863P4hSaaraX/ittc2f3iLgYIRnk9ZBcWOhkQ2LV79+?=
 =?us-ascii?Q?L4nB8BcjoaKV0qyKFvxyXDvZjaKz/jQTzCcbpjwd+1nuQn4YaXwlvNyb8x7X?=
 =?us-ascii?Q?MaICC9UEcee14T8xgcGxAF3g9ksDJEPCeiY8jFIZ1N20AILtvMUvo2Is5UCY?=
 =?us-ascii?Q?X+z0Q0WdUk5E9FbWe+K2EU56nlWpzZzXiKr15jo1l55epsoV4gyMQx8ltw24?=
 =?us-ascii?Q?tvhUJJa34LwpbWOTVd0U3EMqZ2xP5VHdjuaCoBmr5z5YRFrUhcoLewd48GWf?=
 =?us-ascii?Q?MTpYIhuYu8RM+Arqvw5l60IOL2VEE6iO8+BYgs2FfYCnm/ISxfiVFwBFsJjf?=
 =?us-ascii?Q?03/z5mO4NpgjGuxUgtNo7LVTOT++aAe1KNttFzVImtIAvdOL9x+Wm/twPlmj?=
 =?us-ascii?Q?CsW1sZ+kNptaFugcmyHwIZ2rUd2Yd/+zIlhHFkVsc0ubo99xQY2SS7mGNBfP?=
 =?us-ascii?Q?0CLl7zDQCnRbdKm0GkaRY2cB6oSSamkFn/rM9G/MaVR+mvsyCEv2piwYzInJ?=
 =?us-ascii?Q?Pa5qYpWg+GGmlOQqNjjOMdhSG0lS/MWzfwJlu87Fz5G60/NZEQ3QNTASUvcl?=
 =?us-ascii?Q?txh4+Q0bYwUwLi3wuod/9Y43TduYHfMg7A38qVRdikbPrTmXst7aD5cATm+U?=
 =?us-ascii?Q?7+NJkRWIXL0kFvHXOk8JmtX+DfTj5evQ2zaSO3rwqRBZM//+k9I7TOOOhTCS?=
 =?us-ascii?Q?RTogPGOL9OoQuOIKpOSjVzDGzLm2Qwixk/C64rtgGyKVHW/PjEJOwELUU2nO?=
 =?us-ascii?Q?eACsH2lkE9OkLR1++PN9TivgwpeJsImyo/85tUHHecJiYIcVkgidLhEKr2yM?=
 =?us-ascii?Q?LMlE0qtdKBf6y7z1KP3VMwP7cOtiKs6Pr2RQAVDCUNY/owzO9WhRIYwEld3g?=
 =?us-ascii?Q?XJRELV2Lq/19LeCEtLQ+leAFQ4Dw3ezusNcAn+0I+Zrm0m2oVGLY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c0ef7d-b51e-4ad1-7bce-08df14860b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 06:36:45.4532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfLsjJq0WlZKpOaKmOVuGyO0YWzkjBcNawQOjPrMUxIBrsPHc03fOaVUwUVp/Xv5XwwxuPR44vpnIW0gdFfYynNqgZF8grlZ8OUF1s0dQZwmnbodaje1UaobVJwDh1uY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9765

> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, September 17, 2026 3:46 AM
>=20
> On Mon, 14 Sep 2026 23:36:00 +0300
> Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com> wrote:
>=20
> > If rz_mtu3_initialize_counter() fails, the runtime PM usage count is no=
t
> > decremented.
> >
> > rz_mtu3_initialize_counter() will fail if the requested channel is busy=
.
> >
> > Call pm_runtime_put() in the error path to decrement the usage count,
> > and flip the check to keep the success path straightforward.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter driver"=
)
> > Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > ---
> >  drivers/counter/rz-mtu3-cnt.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cn=
t.c
> > index 7bfb6979193c..48f183f0b54f 100644
> > --- a/drivers/counter/rz-mtu3-cnt.c
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -506,8 +506,12 @@ static int rz_mtu3_count_enable_write(struct count=
er_device *counter,
> >  	if (enable) {
> >  		pm_runtime_get_sync(counter->parent);
> >  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> > -		if (ret =3D=3D 0)
> > -			priv->count_is_enabled[count->id] =3D true;
> > +		if (ret) {
> > +			pm_runtime_put(counter->parent);
> > +			goto exit;
>=20
> I'd use a guard() for the mutex and return here and one more case
> above. Not quite the minimal fix, but will give a more readable result.
>=20

Hi Jonathan. I did the minimal fix here so it can be backported easily.
Patch 14/15 does the guard() conversion for the mutexes. Is that okay?

