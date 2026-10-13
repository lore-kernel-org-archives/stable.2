Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415551CF74;
	Tue, 13 Oct 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909797; cv=fail; b=hwMwDppIKGgeG7HOmZ75QKHb/4ssHSrdwLCbxHE6wFRWyORniv7oYyTz1/E3jlm03nAhHEPow263usEHrgmWG3VQR96gK5J81ktzgbC079c+LUkrVswjnPfk/q/W2gqoYgWP0RoZifpSdO8yrBTDCTgq+q83/dLpmijxcbQyVuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909797; c=relaxed/simple;
	bh=wwIqjBnL8KxaEN9DZswRblUlYXrnERe0ZXqh0L6WPgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPrd3x/7Q47eAJ6/Y3Bc4f8eSx2AQvjtQhi+ShXmOaC+14oY6JIS6KvNJw3w/Is1Kf+hHMmPiFaOSIAHD1RYfEus8hUs5xWLh0RkWlbB1wjG1I9EMQezY977TzLEIu/Gg++BDLu6I/zCaJp47tsncD3MoH/yWVDm2x800OVRys4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs; spf=pass smtp.mailfrom=phil.gs; dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b=FvNgf9AE; arc=fail smtp.client-ip=52.101.62.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phil.gs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phil.gs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT5377951.onmicrosoft.com header.i=@NETORGFT5377951.onmicrosoft.com header.b="FvNgf9AE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2if6eiFmK15fYDDfk404Mz6r5MDOUT+Z6rGYqMiYfuPtEtHMHa6/+RabtdcZnrJHbJ+TbhAT5FZFvYI/cLhoZMCd+HakW4eIL0wnkxFDfZwT5r3TgTflxs7VtKkTQhtF3/l2fQd71JV1KFJLtywz9Af1ibuAecIEdF/rV9/E5ZTvDeWE88KVhQnH6v3H5ASWy15Ofi6PyfFRjMoq2MXiyWkuJquAzTECI4NKIWnlO1vPJP7BBjWGUJlc/Sf7Pv0+P0NT3FSqe1ltaSShj6MmmEU1kdbrJY1ctPkSfjcWngpIaQlAxibqxh2FsJAD4i5um1Ds0+IvA3S46JTQ04yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyQiHzqAPKGbIuV31r8QFFCSf8zl9GBm270eKRJaX/0=;
 b=qPOKCyh7ndDWOtKiiASiRLytKp+VOvAmiE3zuDYaPETX5xvI8kvFfCLs8FPq4c5z50twTeZkYLYRTCy+XUGoRsCdMRn6r008/YHU93QowoSLpmQ6PGt4fuBIUEChuD91OQ80Vh1vRp5dRcTWPMXlStbJDXJCOFpwccoMyUKpAfqy9bdBRgyCPKBBrelN/d+eoCIRsVtn1NK4MK0Y8ANNPHdGLmvGxqNyXBJnRI8AwCTIcQIM9fAqbsNYRQNz8ESdk8Iwxl2+Es8eei06eG1wdHTmHNlxQQRq9yUzVfxCSxSD2ssIl5twfKo3IxALwO1TSos5GNfY9nb0XYNWpyc6YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phil.gs; dmarc=pass action=none header.from=phil.gs; dkim=pass
 header.d=phil.gs; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT5377951.onmicrosoft.com;
 s=selector1-NETORGFT5377951-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyQiHzqAPKGbIuV31r8QFFCSf8zl9GBm270eKRJaX/0=;
 b=FvNgf9AE67UtjO7P1xUxcpfQR/U5fSvjzzu4z/aCb0EpNXHCbxup+XXEil2+VsxX01KblvzeJMHTEpWfEKXm3NXEeGOxHO6+As2IAlcAYna5sHltM0X1aXqC4K4Oasku5civzdsegVFF79R1EoESATlxK1lvaYkDf8zpVi9RBgU=
Received: from BY5PR04MB6472.namprd04.prod.outlook.com (2603:10b6:a03:1eb::10)
 by MN2PR04MB6480.namprd04.prod.outlook.com (2603:10b6:208:1ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 16:42:47 +0000
Received: from BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827]) by BY5PR04MB6472.namprd04.prod.outlook.com
 ([fe80::3a9:9dbc:2aeb:8827%6]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 16:42:47 +0000
From: Phil Rosenthal <phil@phil.gs>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Johan Hovold <johan@kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] serial: core: Shut down a running console port before
 removing it
Thread-Topic: [PATCH v2] serial: core: Shut down a running console port before
 removing it
Thread-Index: AQHdWxwrPqD4KhmrxEqZJAva4oT6Srb7pSwAgAAIToA=
Date: Tue, 13 Oct 2026 16:42:47 +0000
Message-ID: <61E0B380-1646-4770-BF37-E1E4329FEE86@phil.gs>
References: <20261013-serial-console-remove-v2-1-2eca1a92c10d@phil.gs>
 <2026101326-outmatch-regular-f8ae@gregkh>
In-Reply-To: <2026101326-outmatch-regular-f8ae@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phil.gs;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6472:EE_|MN2PR04MB6480:EE_
x-ms-office365-filtering-correlation-id: 04ef6b07-9045-4d13-59f0-08df29490341
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|23010399003|10067099003|22082099003|18002099003|38070700021|261009223027099003|7055299009|4143699003|56012099006;
x-microsoft-antispam-message-info:
 o5SpXfAFeXumZ9EDlwi/5g184fi8Zt9u2pS/POIWOpvsNoV/hKpmZ+LO0/KHebQaT3qvYeGUP/ivtbgITJiFkEMjdKT3Cxz0K/BSSdleszacHFaIrv2EoZQA6PMyOtgXABl/Fv8LaAz7xVLyyMd3lvbFP9/7TLTxzNigrIi2mNsBxmr6vs28ToTDuTrIOGu+WAy3TJH9QKocYFvWT9XyNIchiZUaEvaJa5o39QtPoAili7pg6EIV8jlBu1PRF2pWw7p8M62Vt53SXabebm/tvtYO87coHOdCjJS7WgoTofvRKhKCtH+b8TfMM9SMUHF1yYhGGKPec2jbCSrdcF0YEwlc4n3Q1+qi7vt4t4su6rw4EmRVCFjTI2mgAPsUvp/HFYgxHY3whOPcstAvkcLN6Ivlmv2PQ7U+zyCFDKM4EtzFzbdwL0Z1yq5+oKBDi2DlkviyLbAAl0Ye/aJmRIOgHby39OHecD09JzlZ0KImCunX1R/jTqva3adSFqXIeQ13IOVxB+JMRqvFOS2PaXOuXgxCHJWNHOUt5WhoFZm9eFqQvDre1uggIWXeB+HaLEFjV/NOYiEg7qtzSl2F64N6D/y/wFgZwl7cnWqI6dxI5lNA4sYlyuUF3bvlpDB1V5RV00qYhHIebw9rCmqqMO2WI1bX3bIb4Dd7b7f+xrnBt01rSvbv16LjwvWqWv8/u5oHK1uf9G9Rnzly8FkzMZz42A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6472.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(23010399003)(10067099003)(22082099003)(18002099003)(38070700021)(261009223027099003)(7055299009)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n5A2qrd0DILEW/3nBS9jTMxq5ej9nkJJRWtTrF/l8WZoVkUPbb1rsK6cZzgP?=
 =?us-ascii?Q?lGREyjDPXAYums08ddTEYzEIi0gOggz2KUWKpInZJjrLXYhRa5frLqNWneAM?=
 =?us-ascii?Q?oeiEjYhckDAfjpANcBl5h4BQwQey0cKn1IvUKivRDrfJ4c0pAS6T4DB1no1Q?=
 =?us-ascii?Q?ycedM/g/q3RTsMqBiuUhaTgFGN64lMcWJbxYGeit3BDrURxi+de7GUavyfFC?=
 =?us-ascii?Q?lZWDHk1wRJYp6qRyWxEM76dnQZJSH9jwQ0XrupqlgGy4J956Cpju1qv3xVSd?=
 =?us-ascii?Q?u/bHHndboI5ule4fCp53KNoYjjq7v7Uz27Dqjndjx5yPTvkzWgqz++AZxPtz?=
 =?us-ascii?Q?NrrV6yfUtbfYfqse/aZq+OHuLhm0Uej8JTriNrbOR8WyPuclZJFX898zniNG?=
 =?us-ascii?Q?F8Nh96lhhpS0mCjFQJa3I0cFWl2y7/x1YNVs3YgmvP38BTC1G29Fc1wWqErV?=
 =?us-ascii?Q?Q2HUmDmnxecjnIMndeW8APlGGygGJPa2GrlyZMvYX0EITi8TDl2jw9O9EOd1?=
 =?us-ascii?Q?QuiV+zRzSfbzr0UNKYWnNMNZ6WlLm4VFFAWpxrAyxEC+gTifFK5NaUfAjC6L?=
 =?us-ascii?Q?qIL37mjLzGvo0p2BZILuLcxzcs2Jwu2hv8MuUs6mru75jWMv5nmF1VYUIOdQ?=
 =?us-ascii?Q?ZuPrjA0zyr204exh13ZyD3piRH0B7uBzf192U6q+fGoFbV3eLN8nlEBw7NMo?=
 =?us-ascii?Q?7KwPXl9Il0ht7c4ErDQ3Fic0Gesm8lwBMXFN0umOTwg+4xp6LYbYPiqqBOKV?=
 =?us-ascii?Q?48NKpDuyA/r2BLOQNB2Vh0jZ4vnNOqUyIos7XSLu6poMa9y/v82wTrchpLco?=
 =?us-ascii?Q?ravv0IcW82/rIlHaE9Z1LknxndHh09tz2V6miHSQ5fxwJ3uEWgpd4aZzsEe7?=
 =?us-ascii?Q?cQUDtmzqjuCoUcV1hndCTsWih+4UvfEW6fVHgAWUedQMwAkQP9MPah+OGUMy?=
 =?us-ascii?Q?8pdxx5jjIYpdk6ks79H1uPkhtjPMhU9GYnPbzFYMat+3oAmgd6pvGBPVN7T3?=
 =?us-ascii?Q?FW3z+OqNlITLVfF2Q3O//To2qDE7HI8c8wKgp8PVP3eipIWi2c4fmd6ZvZgU?=
 =?us-ascii?Q?2o57Phad4nSJLa8PmKXTWyb/srYPvV8cTHidSVzqr+kHpKEMkM3nxWZg4gBi?=
 =?us-ascii?Q?mMJZPb0uV3RweIsesE6W+fBwKGjuBP3pO3xezjefMA+PT1GlhjOlRdDVYw6s?=
 =?us-ascii?Q?utrEIkYEd0KdOLQEHCzoMf4cDHZ51xV5E4nmXbRaZ8Ssy0IYK2RYe7n2sw4z?=
 =?us-ascii?Q?40p7TvZgkjNlW6VK7vnT3Iot8R6BncS5UJzLcFu5CPjJ5UZl1ysAos0oULjo?=
 =?us-ascii?Q?qnBrRwnyaSfYydBWaCUanGmuB/3MxMQiREl1CNELFxkbV9ubrGgfGlaZPoDZ?=
 =?us-ascii?Q?ChbcVHpFnaQ9R/cBmcnQ9bklu3/A6AXSyUY9WHVGJo1ofjhimu5uJav8f7Rq?=
 =?us-ascii?Q?8hDBIiy4tBEMSjZnTwXwlXDTC8GHx3osLgs79C7h//0zi8IDqHuOdQs3uDsH?=
 =?us-ascii?Q?bVAsfY4AcwxijdOPHUbA2MOfmiijSW+CvKcsEwxH7MzR8EH1usOefA8AcTQF?=
 =?us-ascii?Q?qUuutjUlSFGwQjAw/Nv8YCKIRhzdb33tFrhno3YPCX2MjH/70IQU9zz3Xjzh?=
 =?us-ascii?Q?SYwDaExV8wM7tLEiUsj5LHt34KUDjxUfoMzlSsQ8BA6a9PjaYsl/ixw4Feoj?=
 =?us-ascii?Q?/uKh+Akb99T7JLF6e7hFk24nqd+lTpbLcjYhSN/8AB8lgFC4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72AA720810B06C4E97C6B86562907FB5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: phil.gs
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6472.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ef6b07-9045-4d13-59f0-08df29490341
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 16:42:47.3570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 47d4f979-ea6f-4fcb-aea9-39371d64bc6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ca9kmkzJbNTc5nLuwgFLZiLRv5lI72YSlOM3aRuImh7cd5Z2ZfIlV0BPIk0UgxTU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6480

On Tue, Oct 13, 2026 at 06:12:52PM +0200, Greg Kroah-Hartman wrote:
> Is this the same as:
> 	https://patch.msgid.link/20261003163337.45577-1-igorpetindev@gmail.com
> ?

Yes, it's the same bug and the same fix. I hadn't seen Igor's patch when I
sent mine, sorry for the noise. His is in tty-testing already, so
please drop mine.

> Why does that commit set a field and this change does not?  Which is
> correct?

Both work. Clearing port->console isn't needed for the fix, and it does
no harm. uart_shutdown() doesn't look at that flag. It is only read in
tty_port_shutdown_locked() and tty_port_close(), on the last close of a
tty, and by this point any open tty has been hung up, so
tty_port_close_start() returns before either is reached.
serial_core_add_one_port() sets the flag again when the line is reused.

The other difference is that Igor's patch calls uart_shutdown() only if
tty_port_initialized(), as my v1 did. Sashiko's review of my v1 pointed
out that a console port removed while suspended is not initialized but
still has its suspended flag set and its transmit buffer allocated, and
uart_shutdown() would clear both. That needs the device to go away
between system suspend and resume, and I haven't found a way to test
it. If you want it covered I can send a patch on top of Igor's commit
that drops the tty_port_initialized() check.

I ran my reproducers on tty-next 36844ea19656 plus 810d467c11f0, in a
QEMU guest with KASAN. Both cases that fail without it are fixed: the
8250_pci port with INTx (IRQ freed on unbind, reading /proc/interrupts
is clean, rebinding restores the console), and the polled MMIO port,
where serial8250_timeout() no longer runs after removal. A port held
open across removal and a console that was never opened still work.
I'll send a Tested-by on Igor's thread.

Thanks,
Phil

