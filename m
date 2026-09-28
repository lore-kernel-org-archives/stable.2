Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A361A6823;
	Mon, 28 Sep 2026 02:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790564258; cv=fail; b=qtM+TsilSJKaMJ+fPkHaGXxMwHFS0NM/uNdYV2YbtKEzSbdowvwfFqWgk7MSYTYwbtuqOA3fFrsvRQAb+Mn4xGw8mhwb8WIlemWApZX1C30VzLNzpF+SKPGCfGxtmSH14tQi75IzMEIcPfebqHkz1lUSE30UxBeD11iWTvRN/dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790564258; c=relaxed/simple;
	bh=LIrbvkCOclnz442tubyeDPHoepObt/PBD1WJOKvxhV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmqIOj4TiMLjgk59TQRgYtnaQI1kWeXzIMfV368bxGVvPkTYFcx3CRphkdL8iQOZgP3QSuvBkEmqlQr1yKHhe/8SqOOEC/3XxjxMkiu3+vZP/EU5QoQW2FModLBgUeYVHRUVwwyqFuEQBb+u1eQY99oxVPEIC8B1/43J/MJaVCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fxO+YhP3; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fxO+YhP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJZ9kVx/LImE6rBMhx1zjIn2mU71lO5G92NFAv0sLTqgaJFddK7OfiUnnIMMLcvVSQdrQxlqHl8BTljpwUJgVe4dCxSFGxjN/lpi+I/7EpshKa6MryzauV4w59xusvCzoTtHoDcw+HAe5Ux0JSGrtDF7RgbbQHOTkbKF4KqvU28nBvbfG/h0ilqrdnkVHnU8Aqd/YpoV+8EN6NqF7rZzHz8Ngw4dwbLcbsKbSNBWmZiYuf+TnQ6ba6BKg3RYHIM5xgVpndcN95H4BZ3eb7fprmq3nz0SZUXvhNErYEePXdoHxgQFcddx4VTxX18pq5foZuLRbxzVplWiVQEf5w9I7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrbAJopO+FRE8xxHNQAairr9TpAveIw+D06s25fOpaY=;
 b=Xn6UM6PSzcMWDVrbhYGw5quY92/94a3I1yidHoh9KlXTmuttI+55IOK8Izt1KrDCq9EQY6vmXCnjO4xbZZQX067qO+aRoytWcA7oenHEMYjIk675G+Uk6IjzJ+sXTvCtcsdFcq5LWLkS86y886dnBTh9che98uyosQsc1d6/MYgbNvG86GpSDGrH5Bi0vJhuOfO6pGHsuA+nCm06JOOWlAW7fvB3YCHKix7YA+IJmOlo5ilM5bb7jJ/9SqrU26usLxuENqfATvEJeZly2ye08XTpen9ofARCvGMFFOlih81ebBUM4BzsY6l83Ois92rmKyTHgrre6rXovps5uabj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrbAJopO+FRE8xxHNQAairr9TpAveIw+D06s25fOpaY=;
 b=fxO+YhP3UY1Sjv5n2/Z/EaT/X+/jLjGntRAh5QLprPyG6Re0ErY5la6wLIPFDZLVJSGY36ZyyS1tRyrkpzxfltBKrsuJL4aOyT1/dOToVha8HUS92Sl6vQ2U9gi8wY0I5brcXYbWU4l71yRuw8cioiqk9//lVZPCxNC7JGroOQpfk8iky5jvbz0OR9+3joNKszXnrORis3wvVNL4gBHYhqxI3sbOhrWkajQ3KPgGPHQIQc3HtMpZpfPv/UA29IfiHJe75AHmxeT4ll16zOnisXw6BRkg/KlRqJC3TUgcIZ399rAQsQRiSTXfs3AwG4UYnEfIlAdq5EYjEr9eJDinkw==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI0PR04MB11024.eurprd04.prod.outlook.com (2603:10a6:800:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 02:57:31 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 02:57:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jiale Yao <yaojiale02@163.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Frank Li
	<frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Fabio Estevam <fabio.estevam@freescale.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/7] net: fec: manage the netdev lifetime with devres
Thread-Topic: [PATCH v2 2/7] net: fec: manage the netdev lifetime with devres
Thread-Index: AQHdTo9o+trnCymU5EaubEECaOY+dLbjRSlw
Date: Mon, 28 Sep 2026 02:57:31 +0000
Message-ID:
 <AS4PR04MB9338CC981815D950C0813AB3888D2@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260927144741.1320558-1-yaojiale02@163.com>
 <20260927144741.1320558-3-yaojiale02@163.com>
In-Reply-To: <20260927144741.1320558-3-yaojiale02@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI0PR04MB11024:EE_
x-ms-office365-filtering-correlation-id: 748a3d8c-8b57-4101-a1f2-08df1d0c3d48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 X43u8PzSRbnulvMWc5d80P0y5HqBmYWlcxKMsX7Zd7sOdOvvhRyj6C50dYF7UuyrcSNPNuspomst66/u6xVrSCrMxfqWvkp5mY7UUn/SCNniQ+Mzl1n9/izHliy4mq/EQ7kTnuA9bRX/EF5DH7tnBXiXoT/NDpBmviNiUl8gkmC1j1WPJEDaevbzPF824TIEHtKt6QtVtoIWMIEQh0tufJQdx458CWQ52GN7ye4y3R2k7re07cmXjzinjhmMAp+w3RoffoeXvNZuZXrt9KCplG5fxJR9a/sZEDG2tV0ZvECLgphVmtpC67Cf54L5uyJNmuCkWWLIRMGG1vzmILGKbxol/AQL9JJ5MN/jcjNvnjNcNZDHaJvtgd9hSGOaEFP0ytH0xBXQl38hEFCJlfOft0OyEDCi7It16Yem9ibn2Q/dkfLQujRKqSbhvASCYJP/8q+o9A0uDF0IbjW2MNaMuYhqS+6gIH6VsqGua+fCIEwb99okTcFMRo3Ltj//gw0Lioq1mGUsNSY5Lvx0zjmzPEYaGLt9bkcq+r0FcFc1bmo0oofwi2L021FI2JRsa5Be/PMnHSwobwDI5h0eukX9g3a5sPK18Z+QulMNLJxnjBNxgBtaeZl+u2qSJ4EiE72nbbxCefKrvEIFERCZw0Ta9u18EXJVqUSytGLT7fAtt3g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cXTBSAClx5KxrNzg43VOwUqi6Sc+WoXBGx+JztCXHmMHWR8cM+VGxTz4hiXu?=
 =?us-ascii?Q?u07MBYwUjV/6TKxG8btqh21SOqBosIdXHjkG+Y+n9ffyR0Qbku5+kXjog1aL?=
 =?us-ascii?Q?ENl368wYz75vtXDS+LtI5OmbdX1MxBIfISqfgcIwhTzowail3S2arAvMcfF1?=
 =?us-ascii?Q?vXgFmFnVxp3Y8i0ZIjrFWo8/9p0ugCsg3zP3O69DGivcH5azL8HFjglgal63?=
 =?us-ascii?Q?rM1O6fpPpvemCeUZkXrPgUA3yXAbXjaIuANz5BxqL4UST5aFSGD8CffeinRj?=
 =?us-ascii?Q?x9wYfxEMV4btiHCT55BPGhffojhs9DkAVYad+QEGvyF+LAme76vWckIct5u7?=
 =?us-ascii?Q?oeGwmHehDHsY6MTL3NGBcG0ltLMk98qvsUQCx14Y20fmTSXh4M3dem2xe6ci?=
 =?us-ascii?Q?x9HA6tvLD/5zwwuDDrOolw34BZfAh9+Viq6sEJe7+2A3vfwB0x8/2iXBkq4o?=
 =?us-ascii?Q?jYpgRfqtkQjUh8M4B/9f3lwYJy2qbGXdLGYGSZ6E0zDPM4nAEUcgVUi0YNX/?=
 =?us-ascii?Q?muG/PLu3DZ0GU0ahyZ5Pe2foJy/5pQJl1LLJqjYjUFVc/6q6gKr6DK8yBY/D?=
 =?us-ascii?Q?6SGa5UJDIvjZpeI2jENQzB2UNi/J6ECbCnRuI3JyI7eIWVFzJNtdrcW7wdup?=
 =?us-ascii?Q?qQITdhGhoO+uloO+xwbvVgH5rvlPaBHWKoY3DGb56O/wSYFBOg9p/T9DNUN4?=
 =?us-ascii?Q?tfzVgdk1e/LiaYZc/UTwvmBzi+nhMMKpYAGuvk7Nl3YbptPW9UDujdjwF5//?=
 =?us-ascii?Q?Z5Pmxk43StWGnaYKUjEeZJg9L9li/Ak2mKuX0r8GwY+9wMKa2BTgmAnN2RNy?=
 =?us-ascii?Q?NtOEw4HQLldrxAgxuF+GdzyowN1oSzODQg4O7lq7hZCdNiD7av2ysLqtvdz4?=
 =?us-ascii?Q?tevdrOlvOYM8oEM+cWIrnN0xXzyHjA8hEXIDkublXaTVIOPaMDeVodA/U+4a?=
 =?us-ascii?Q?rVjlqhcj5xA9U7UFG/5nCC0S4ZWKWMEfyyWhjVzpRA23/ZB4V/JEQoZJN/jV?=
 =?us-ascii?Q?A8A2y4Kqb1ExRIkwjt4HZGPOni340qWIeSF86QA0Sbohxrd+kR7NFlTBaU84?=
 =?us-ascii?Q?5FUvXI9+2+ndS/7Lm+rOXzNnGDW/aZKQecLh07wrffLB/G3jCpsQaoDrgQ7T?=
 =?us-ascii?Q?lvi9PGu8084CG8G5ShpqvffDwyRpaecU2ky7NOeI++6LYXD5hXkFhSkSota+?=
 =?us-ascii?Q?11vafFMJf5bwzmGZH3OMmpbN+2g86DeOL4OJkTAdhwWQpis/9GOt3HIUHSqc?=
 =?us-ascii?Q?Doiklh0S7WYeVPmY9VO32zOMrM8OoSU5kUUIWfNU5vssBfdhXKjxRdPD6dSu?=
 =?us-ascii?Q?K/wgOeohptYIejlURsXva0wfk1zLhjK2xwRLjc4oI7ZiqdoB+4vCSWsmLBaT?=
 =?us-ascii?Q?SmgnzqPnB4dSJZu716chmX3yIEBclXvgF4a87NOUt4zQtzVj0JrfoSjm4R00?=
 =?us-ascii?Q?xlgQU+A6r84o9Erqg1RSVY/afjmz11HVxuHAXP/Vvv46hfkkCwyONX21SpKP?=
 =?us-ascii?Q?KXHqAKlkx1ci+u6zhFc8vej6K+kNta5yA3/cLase6wRq2Qm2Rvee+5Ytaf8x?=
 =?us-ascii?Q?sqBU9mH33Og5zy8RyWHgX6w+u1/7X1O22WyMCDP12TAn9laMqnfvmWvKaEvM?=
 =?us-ascii?Q?GyAAQFq/M0e2RyQBQC3qrYPEbRy8AW+mkRfgYPPZKoVOOBCB9V7l87Fq06Pe?=
 =?us-ascii?Q?lwFH8fDD1ny242D8eC49eQw0KCfRtbIXCmrDygZK7DWYj9o7?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748a3d8c-8b57-4101-a1f2-08df1d0c3d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 02:57:31.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6PGoyhcctny7GIi38xr+XlXhjAw6E5cKXF7lpWj8Fc/HASRw+pL/sK3AyIoQ9Za1CoySUY696sehtRPSFXmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11024

> Subject: [PATCH v2 2/7] net: fec: manage the netdev lifetime with devres

Please add target tree to the subject. Since this is a fix, the target tree=
 should be net.

>=20
> fec_drv_remove() frees the netdev before devres releases the managed
> IRQs whose handlers use it as their data pointer. A late interrupt can
> therefore access the freed netdev.
>=20
> Allocate the netdev with devres so that the later IRQ registrations are
> released first during teardown.
>=20
> Fixes: 0d9b2ab1c376 ("fec: Use devm_request_irq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 794ec427b0ee..23e794a31ce8 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -5219,8 +5219,9 @@ fec_probe(struct platform_device *pdev)
>  	fec_enet_get_queue_num(pdev, &num_tx_qs, &num_rx_qs);
>=20
>  	/* Init network device */
> -	ndev =3D alloc_etherdev_mqs(sizeof(struct fec_enet_private) +
> -				  FEC_STATS_SIZE, num_tx_qs, num_rx_qs);
> +	ndev =3D devm_alloc_etherdev_mqs(&pdev->dev,
> +				       sizeof(struct fec_enet_private) +
> +				       FEC_STATS_SIZE, num_tx_qs, num_rx_qs);
>  	if (!ndev)
>  		return -ENOMEM;
>=20
> @@ -5480,8 +5481,6 @@ fec_probe(struct platform_device *pdev)
>  failed_phy:
>  	dev_id--;
>  failed_ioremap:

failed_ioremap is no longer needed, please remove it.

> -	free_netdev(ndev);
> -
>  	return ret;
>  }
>=20
> @@ -5522,7 +5521,6 @@ fec_drv_remove(struct platform_device *pdev)
>  	pm_runtime_disable(&pdev->dev);
>=20
>  	fec_enet_deinit(ndev);
> -	free_netdev(ndev);
>  }
>=20
>  static int fec_suspend(struct device *dev)
> --
> 2.34.1

This patch just prevents the netdev from being freed in fec_drv_remove(),
but fec_enet_interrupt() could still be called after the removal, and
fec_enet_collect_events() will be called to access the registers, however,
the ipg clk has been disabled, the registers are not accessible at that poi=
nt,
that is a problem.

I think the hardware interrupts should be disabled on the removal path
and disable_irq() should be called to disable the irqs.

BTW, do not repost a new version within 24 hours.
https://elixir.bootlin.com/linux/v7.3-rc4/source/Documentation/process/main=
tainer-netdev.rst#L15

There are other upstream rules in maintainer-netdev.rst, please
refer to them.

