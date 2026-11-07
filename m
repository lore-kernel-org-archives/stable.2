Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794026873;
	b=SPB9UZ4dN1hFL03DXCjEIrjXTYcBXBZ3bN2eJZ1r+7G61K/9+xfy1HWAP8qivqQZNOmr
	 WO6Jitv8GNoAt0Wcydxu80gtMIAVcRqtn4EWme5p2EhlnB60XELxsPdoizW3Q7PpqtUT/
	 vdWJI4sccZH8b4x9IOJGGIJmGL51W8GjB+4PiZMG5aY8kOMaCjm+jqkMwLo6Fvi8kdf+j
	 nGUS9ObQTRk5v2HhDLC5owBgsoXjtdfURpScM6P2+NGX1gpUWsONl3ea24Per50PN7hqB
	 Gb7XzQrozwJZ6gigoT0DBJWZZthc5Upji6x2/EH8NRoEQWezyZuW+XfbbOBWQByj5kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026873;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+S7yGYEvpkFj7qB3Q3AGXqxNOt0vcgf77jxwsWwlGD0=;
	b=ykR446674cuh8ayOyXAA/8aFBVNzob3rODZYN3rYWx/v2lr4LT9RkpV1CU5iG5AZZtcY
	 BVzTlICVBtaZ2IPAKNBBTYMlTM0GWc/FqdYlM6oeyRaZxMyXPf/uFw9spGnMiyavN06Pa
	 voafvvhOu08cxrl1uNJvgAany8dNBfIN0qQLFKmsJhi7/9fA6eysVyLXO8B7nlV1ctj+h
	 9RGJ1ENKnPFA0i3rcWZZmDWXx8uxa/6rA1+lffVOa9ZCVx+ZW97dQ9HDiPTJl6vGIFzvp
	 w/lMEuefOO3umY7dK197wF2Py4XoU1Z/6tmaHWyJ+kaOiIr8+qmcSlc9E3T9BcQPpFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ZiHS0ZyX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.20.4
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazolkn19010004.outbound.protection.outlook.com [52.103.20.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7C6606A326;
	Sat,  7 Nov 2026 04:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=ZiHS0ZyX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUYEaQ8XQ6soVjE2mg/j3qB20pC9LVOj7gaDMnAkRkmJ/uBA5qKGgYzPEBwxsxhakJ2j7H4DpJZz776ay9voSHVJsTRLY5+AWvEbN/nW/WfdgllaVE6MCXvFX9rIUAlUdtbjZR7SVao+HMwuG5Bveltly8osmFZC6nZ0QPLc0ZZo91Engw52nk4i8arT2zYmwIOC0z0/4tQxdQpNMnZxeOVH8uK4fOWVu+vvVzOoc8UYug2pzqWDf0Cx/E/iny02lkxjedXT0d1rDGiYjSXRINFZZYGGLyY8iw5pF3GaL9SVNa8JtVMzNtkVdYOqRVmO8friNrRPHM8YRWjrJcFSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S7yGYEvpkFj7qB3Q3AGXqxNOt0vcgf77jxwsWwlGD0=;
 b=yoQZII1Isog+TQ9zONs7Aaz8sTB0e+VbwDShuokTEWH1ux8eaaOYYoftyt/yeREq2ioSPtqkms75Vex5zzz8om/rf14mzaBLklQqaPmM2x4i+6rEL+zEekTsAd1Mpq8owG9V85U/MrF0txHSag7tbLxYiiRm3dpWI8H9proVnCP8DEzOutQJwtrX6eU3DJPeWaJT6RrOE292G63GMLcrSCvfKn6YN5tcxIxFkep4zOda0NPDcJ8ZYmeeclfRBzGzEPpxiVG7AFGtool9AhHPLaPp6qM5gcTzwN4W0IJxO8hYLxhGdmD7buBwgSwJukmjMiPbTBdfl3Mw3OuW1ZuZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S7yGYEvpkFj7qB3Q3AGXqxNOt0vcgf77jxwsWwlGD0=;
 b=ZiHS0ZyXeGyihRMW78UgDZ8Tw+M/1BDZ9vO0cUM0XosaIRGUnXfTdHjLRZb1AFimJPHVA5nEkknxsv44zqvVKIXsn+0MJoymXwZx0+fB4hp9uY6lsB2H0mlpZZ49aBGXf6r7laCFTJxXFq6RJh72rDCPuf0fuWKOikm8dVgiuPgd07kk4no7O9HQlnF2oqhjV/Nq/ohjqzMSS308VWp5rsurzlWYm3Qod1/O9kFXn7ooRAQTqS9IzFX8KOF/GhaXHxYOrsf5LItSyAqeAih6fZgSevPk/uQ1npUSaNbQbgoQkaeE6fnQRAhcZTVquoBYUFHeHxmOcgq33RzavGSB1w==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by IA1PR02MB11006.namprd02.prod.outlook.com (2603:10b6:208:5b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:47:50 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 04:47:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: RE: Patch "Documentation: hyperv: Update documentation for sending
 VMBus packets" has been added to the 6.12-stable tree
Thread-Topic: Patch "Documentation: hyperv: Update documentation for sending
 VMBus packets" has been added to the 6.12-stable tree
Thread-Index: AQHdbl+yEQL700PH7U6kpgmzSvL/ZbciCPDw
Date: Sat, 7 Nov 2026 04:47:49 +0000
Message-ID:
 <MN2PR02MB68631EFBCD22A9962272DD7FD4752@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261107022833.2698985-1-sashal@kernel.org>
In-Reply-To: <20261107022833.2698985-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|IA1PR02MB11006:EE_
x-ms-office365-filtering-correlation-id: 7722cb35-6a5a-4c0f-bd06-08df3c8a46e5
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|15080799012|51005399006|31061999003|21061999006|13091999003|12121999013|19110799012|8062599012|8060799015|25010399006|4140399003|24021099003|55001999006|102099032|440099028|4302099013|3412199025|1602099012|10035399007|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Lbgn/UVCkjyW/3W34P2sXeZ7A6Q4Xgmd+86FuvOMaZDXzGF95Z1IpNWvIvGU?=
 =?us-ascii?Q?BvUrO/bscqBtiYgBu7e+LWtuCIV5Uy95HAn2XJUo4OX4CTB11+B1DhDdYOEP?=
 =?us-ascii?Q?L7FFmRy7lKcvWwtVb3hZ0oRBtI6WTc1+bqlDFPAXuiJZm5FcVO4DhhBJ3NwK?=
 =?us-ascii?Q?0wWk8mzn8TORES4tKO0Z9EV+o+wO0upYKJJ9Bnaga3kcKb3d1ybEW2E0Hf5d?=
 =?us-ascii?Q?N+uGzsMXdDgb4D4Uv38AvwnzBtsVXd8IWuK85xj2Ar8u2Q0T6zd8GlInsjMy?=
 =?us-ascii?Q?9UFY4mQY9oFNaoow7Z2QEkh/QwD7YcYHvpL4aQ0zPBo7yHUQArWUwuVd5rbH?=
 =?us-ascii?Q?5Ygw5Oz4s6LTWnoBNTC31ySQEDSG+/m81OqDnzcZCxRk7AqNh9EflL/KSEP9?=
 =?us-ascii?Q?yW3ec4ousrpOO2h7fZ6rKPoPoWBH7WonpgoTNqBrcaXuDoc0foVE8tcHuU5J?=
 =?us-ascii?Q?SUMbTUEGUGEQuQIDzZejpY3FeCtEqX+Pty00fXRRazGHviIYVK9qSTH8nHJb?=
 =?us-ascii?Q?nc9KR+EC9g+LgfdV1ibOHiBSjjldQWv+LgJ8SlfXo4ri6tuAhnh5938+aIXD?=
 =?us-ascii?Q?T804y8o+U7vg0tTBdkIgSYU9qsaDxKYnkYxbRziGnkAeUc9RgREsv0b8GOtP?=
 =?us-ascii?Q?bCT1wzkP+4jdyRR8EzUmYyy+JOgUtFBIcIa2oSW1y4U/rbs06rgmBrRnP/eG?=
 =?us-ascii?Q?A6AbGw1vXMnuFy3btosqIYMthavVT1qhrl2fgIpNch0cjt3cay37XFXZmqw5?=
 =?us-ascii?Q?1ij3Av/3oox40hI/6LyCVt5nk1Vgyp84oFnnRbfnzntm/z4uGNzByMkNUYGj?=
 =?us-ascii?Q?zP8Um5oqze0afqVbH3Pqb0LYMinTfdtmWKpUT1w1FJMf+cFK25eI/f4BGGDj?=
 =?us-ascii?Q?HhbP6OLb+78gUziwr1WtplPiAyI6Dur6QbauHy57gTsEzA7i9jgIGuPPPs0N?=
 =?us-ascii?Q?cLOraDuRMCbGo6VQDfSXzUGj90G91jZtfpygiQbsU4FxHvFqdj7lUBbDVhUp?=
 =?us-ascii?Q?55F3udufEewJD3s7+VQn8pPdgerj8xG9BWrNPTNb/xcUgAkWxlR1ziz/Ja/r?=
 =?us-ascii?Q?Bl94TdG0lHCz9+GjJ8lMBhybFvlZ8M4wDj+8rory4zSI54WN7lzBNSkJ26hB?=
 =?us-ascii?Q?/672wLxtKHjm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9wfeZhUHs6eLXFeHv9kzuGXqzYFu+LAUdleKtWlU3IPU1NKR21avAEgK/zem?=
 =?us-ascii?Q?+H2NpHPB1CwO0dwxcRSW4kq4HLxbj8i8o/luUQ4UdG+bictn3r1GgbdW8fKV?=
 =?us-ascii?Q?VhIw+N6bIWESXU9aPQVlE/h1b9UtF1mWu+uk8eBmXICqB87r+jzrSWxjqcFU?=
 =?us-ascii?Q?rqT3tv/nfqOYIGMDeRzDPeWhkr9jT2cClLIp4BLkamp4MAkapNuDrIt4WMLF?=
 =?us-ascii?Q?eSQ/IuuBEX9axBXU26Ll34Zrwy5YNGWoXUPTcv6IsS5BwnR8jdnivK+xqmK2?=
 =?us-ascii?Q?78zJTbSrFq/+QxKkaLAPXFSw4tgNuWWZCtWV9N5ERwo2BKCsiNK+3aznKlXr?=
 =?us-ascii?Q?M2zxGbVoLidtamZJrFGK6f4oE6NjxYdEt1sKjWGk/AvXC5aw92DbaLU9WDX6?=
 =?us-ascii?Q?CmBh6C6Jpv3qN+Rb1I4C4hCDYpdbETilz6kF4Rcz9/tAklA+sOWXXTlocmt0?=
 =?us-ascii?Q?iH7gGbDn8FT7lV0LLGdu93hHSMsErSG0XUPbag9gsL3F67Bk4c9JFozzD9ub?=
 =?us-ascii?Q?aIaR7wyo970877sU8+iRBV910UvdebjIDeYGlZwIvGMfMyLi8fP8ifKlONPg?=
 =?us-ascii?Q?ocibtlzW0XvTfrfGl0jfopd5Xa0ulCWXJ+WJ2huWM5eaUexenl2E+VstRqGj?=
 =?us-ascii?Q?KDnSf8+6YpmtGXsxglymvXOl9icSYe7LQ8V8ttmcImu6ofAfrIJkLArfyUKs?=
 =?us-ascii?Q?yOhbHaGV9N8Bkq4QPvmk9bD3ofUHGc5ayTXiMJbnU0jJuRRwyobYhA6ItZrD?=
 =?us-ascii?Q?rcytPwvj/PLN0qzYK3iYj8ZnYa3Q80qieazCkfAjvlX5zozM1gWYnfM7HKIb?=
 =?us-ascii?Q?FG+7bVtT4nFKcL5pUTtf1/T6fJeJ3LvQ0FyxvB/pE2Y0iDh+uL7P3o7cOEOg?=
 =?us-ascii?Q?kXsDGVw59XzJcsct6sJOFeQQ9LfhM1z75VkKEOONLmMf8z2Xp/GVpF0eUovw?=
 =?us-ascii?Q?FjX885Je1mt1r5BK4IhdO4MBRed3tI6vthHKujQQrZUrudyWnAm5om1Jd1we?=
 =?us-ascii?Q?FYp+eNZqHX0LBymv7UYj0V2Y8uBdZq/ba+jhQDeoSvgQ6hky3ByGZ2Q7gMZA?=
 =?us-ascii?Q?k11PBMTJ8+YxbauF7jdgv1c2fbLtYQdoseCaSd4DJNOiAZIzb4Wr6dPNVmed?=
 =?us-ascii?Q?nm5atDBH8j0Fa43YCqL3jDM/ZRXPrlhnIkXuCNVpm1rsW0c7/yzPxt/QbX9N?=
 =?us-ascii?Q?zmTuEYZk52gogpjEoYZq2TKWdtsJZMx55YCD1Ahqu+RjkFkY5nU3NK3qqolU?=
 =?us-ascii?Q?AeVSOjSXbBq+lF25FiUNVPzN7Szcf34sVZDEI1ArK0KOLDvhcXPkW0tfJNX2?=
 =?us-ascii?Q?F+bMVL/B2Jwt2Yfp7UYWJLYyNo2CSnqbM9+hTCDWWzGf3UTODDVFSYQYH9IG?=
 =?us-ascii?Q?6qPboCc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7722cb35-6a5a-4c0f-bd06-08df3c8a46e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:47:50.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11006

From: Sasha Levin <sashal@kernel.org> Sent: Friday, November 6, 2026 6:29 P=
M
> To: stable-commits@vger.kernel.org; mhkelley58@gmail.com
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu <wei.liu@kernel.org>;=
 Dexuan
> Cui <decui@microsoft.com>; Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; Randy Dunlap <rdunlap@infradead.org>
> Subject: Patch "Documentation: hyperv: Update documentation for sending V=
MBus
> packets" has been added to the 6.12-stable tree
>
> This is a note to let you know that I've just added the patch titled
>
>     Documentation: hyperv: Update documentation for sending VMBus packets
>
> to the 6.12-stable tree which can be found at:
>
> http://www.kernel.org/
> %2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstable-
> queue.git%3Ba%3Dsummary&data=3D05%7C02%7C%7C63b6148b45d244e7595b08df
> 3c76d448%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C63929615319498
> 0658%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMD
> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> ata=3DJAjkSZKxRGOy7x1gtCMHiJQ7gPQl6NwynwtEJTqr1Oo%3D&reserved=3D0
>
> The filename of the patch is:
>      documentation-hyperv-update-documentation-for-sendin.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch should not be backported to earlier than 6.15, as
vmbus_sendpacket_pagebuffer() was removed in 6.15.

Michael

>
>
>
> commit 0f601aa7a87ab29b179f735be1e31b6833222a7e
> Author: Michael Kelley <mhkelley58@gmail.com>
> Date:   Mon Oct 12 18:43:54 2026 -0700
>
>     Documentation: hyperv: Update documentation for sending VMBus packets
>
>     [ Upstream commit 6a3d77a0a8cf69cf3d234305e6711729eb5d10c4 ]
>
>     The functions for sending VMBus packets have changed.
>     vmbus_sendpacket_mpb_desc() can target multiple ranges, and
>     vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_geti=
d()
>     has been added. Update the documentation accordingly.
>
>     Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove
> vmbus_sendpacket_pagebuffer()")
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>     Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
>     Signed-off-by: Wei Liu <wei.liu@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/Documentation/virt/hyperv/vmbus.rst
> b/Documentation/virt/hyperv/vmbus.rst
> index 1dcef6a7fda3f..7ee27faf5e5bd 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -141,14 +141,15 @@ Three functions exist to send VMBus channel message=
s:
>
>  1. vmbus_sendpacket():  Control-only messages and messages with
>     embedded data -- no GPAs
> -2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
> -   identifying data to transfer.  An offset and length is
> -   associated with each GPA so that multiple discontinuous areas
> -   of guest memory can be targeted.
> -3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
> -   identifying data to transfer.  A single offset and length is
> -   associated with a list of GPAs.  The GPAs must describe a
> -   single logical area of guest memory to be targeted.
> +2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
> +   a transaction ID that is matched against a reply from the Hyper-V
> +   host. Useful when the struct completion (or other rendezvous data)
> +   must reside on the caller's stack. By invalidating the transaction
> +   ID before exiting the function due to a timeout or other error, a
> +   late arriving interrupt is assured to not trash the stack.
> +3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
> +   to target. Each range consists of a single offset and length plus
> +   a list of GPAs that describe a logical area of guest memory.
>
>  Historically, Linux guests have trusted Hyper-V to send well-formed
>  and valid messages, and Linux drivers for synthetic devices did not
