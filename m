Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097B2C11EE;
	Sat,  8 Aug 2026 06:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786169880; cv=fail; b=F2jfFArwoPJ4pOeZgrBAHP6uBq3H///hcrDM/AKaBbMyi9rE+tsZ4HbQe7xNh09eywPkkE92sryCwCmsul2lvqhKu+Fw370LSil/rBs+xYNCEmw67CS7ds8/qbhv4O3UV2sQc3Q+5jap0FpWNdCp3TZ469rG5AhdMiRLVArzNgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786169880; c=relaxed/simple;
	bh=2y8F37PE8NVddwLdb/XY86ylsnygbKNSEkuhPugvEKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ADndkqIwh92MtjYd8Kz1eL8nfet7b9ruPPVes2egZjNMS274QmHanqtGguZfadRwoxt26kbEm2W2wxQA1INo3sGR/eExM3FSBl8bWCIULt0M7901UQp1warf/TmhcoRfaxcu9SPcAhWoMVKgnwVHt7NQVre+6r44XGF3ayQTfoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tX3alxnK; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tX3alxnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyvCCfbFG3uXe+Fhb+YvCDu8drVkg9IokhB3pFH5j6EzFfeGfFbTlXS7sUnqwxbHTMdb8Q8wfBYqyalVnW9vBc+Xas8ZikZZlHk2HparG5xsuBFd8l0O4uui4JlpJxd8tW/dnYbC0x61p16Jc71bGNPVw+0NcWxW0sJFHT4n7sCZ0YbpMNQXwKIzVWOAVTcF7Fcq0WCvTB5/Hlpzgq3SHR7VCnotRMyX1YV9GTFOQ1L6MX6KyvgBVrh0l/Zi3mQAWLSH2FH+zDRsOyhP4HRZWV2/+8k1W/rbaz79WiiOshRPF9j1THns+BXs42YJoIX/T9ZVb0DyRckrUK8JSwHgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KP4jSooxYm0Hd8L0Jz8vIQt++ISM8CAgYAYFITzE8vs=;
 b=CTwyIiLdKEMgBOnhyWJg1UMZFxVxMAvUihLKz8ZfxY7pQqJ83BG8Fa7Ltelj4tkBYvFl4s7XCYdyrVtH7YBtCsmS2GgzrQhQevM0lG3rN745C0PQDOPDUp6O3wIsZEZjknVtSdvI/5gST/ZpwBJ7znOwyHves/QCBXqj7MGUSsX6gznXY7MEb1kbkgECxFAdtisnPYghUakvuE+O3dpB0oWVLa8Ne27heLDqeP2/x18mAxPEgfr2NfnAhfPdcLt1N9W//ab2A/v/LBmoOpYrB+KQett0wYfVAnOrSlj3okCHDVZuJsvqmkExIqTI3uuKXwuOzX3XV37R7/AR9hhYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP4jSooxYm0Hd8L0Jz8vIQt++ISM8CAgYAYFITzE8vs=;
 b=tX3alxnKS6/v9GKmQTJjjyqfA3jqH8II67Ecqx6MMvlzkI5yz/h/T5OFkImKxYbaocbOqXUFROUxom0H/hIQfPDvv6Mly9bJDRJmSyfBYxUkP8XDOspWQfJx8SP56ehGs/lbEBKEB138Gbv4d9HPgsGIXjYeQJsOdWlPb9l8FU++UAkYeexzdHeCeLVWjUYZiZjFDdY5Fi4SfuMYk4pUL6J7DYsU1mUjocqgaKxMEcNW3em9n3Yq96BBhsvDSN0VYNv9kwSfF8ZY8qZfc5n+NO6Ul7WPAIZ/VR+LU+eMQmlvXK26IofY6s5v9Fp8o8Q/uvIAF37uHr8G6d2aqhuftQ==
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com (2603:10c6:220:17e::8)
 by ME5PR01MB9992.ausprd01.prod.outlook.com (2603:10c6:220:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sat, 8 Aug
 2026 06:17:53 +0000
Received: from MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d]) by MEYPR01MB7886.ausprd01.prod.outlook.com
 ([fe80::19df:3891:d8aa:692d%4]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 06:17:53 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Antonio Quartulli <antonio@openvpn.net>
CC: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net 2/2] ovpn: don't re-hash a removed peer on float
Thread-Topic: [PATCH net 2/2] ovpn: don't re-hash a removed peer on float
Thread-Index: AQHdJN6I3AHBDEO6h0+yBVxTlV5QTLaQyHeAgALo4YA=
Date: Sat, 8 Aug 2026 06:17:53 +0000
Message-ID: <40AD540C-F118-4CED-99DF-5E3BBC27C620@outlook.com>
References: <20260805-ovpn-fixes-v1-0-763f8c237fb9@outlook.com>
 <20260805-ovpn-fixes-v1-2-763f8c237fb9@outlook.com>
 <96c13143-ada5-4a38-bf31-eb36e5828b43@openvpn.net>
In-Reply-To: <96c13143-ada5-4a38-bf31-eb36e5828b43@openvpn.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYPR01MB7886:EE_|ME5PR01MB9992:EE_
x-ms-office365-filtering-correlation-id: dfd9fedd-bce4-491d-02f2-08def514c7a8
x-microsoft-antispam:
 BCL:0;ARA:14566002|20031999006|19110799012|8060799015|8062599012|31061999003|12121999013|39105399006|15080799012|24021099003|24121999003|22091999003|24071999003|4140399003|25010399006|40105399003|41105399003|2607281247196008|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vgIFU4M+xS/TpMdO/9/MAI3zP78h28ej9Cjj1/ahxAQaI2N5fzC95N6iSTwC?=
 =?us-ascii?Q?Nv26Qv2Lo2lqUYsCXjrtKY5mIogJXeiPxUbXwWsM++BhaeUEaLBjQvAgKO7A?=
 =?us-ascii?Q?PQqNC/b8tQmIt+PJswf7Se5cJbg9ANWv7RVfvhMTSdnt3aJ4E8C21ncKGRnj?=
 =?us-ascii?Q?+m5EadRpHQSmcCSP0e+MdqIMOJr2L581Twg5KWm8wv8MZP/1AXYgGskPeY7K?=
 =?us-ascii?Q?gsf26Pelr3tBqVDvUbFkhfrgUKnhrlC4OhMu/8D5ckVEkSdgfYogW1gm+hNS?=
 =?us-ascii?Q?6FsxEQKDvLVUuIrv0LJdiE7FC0Ft3W0zejGd5mkrql7Qeu+2BnCZDVxLwG4R?=
 =?us-ascii?Q?+/MPDwI6qMhJQ6aNMRVzSt5PkqY/9Uzpm++e3pLnulr+QxG+kAA2/aa0NEdd?=
 =?us-ascii?Q?vqN4CzXg4VHZdS8VAnpFz5ggjK3A3AiOy5D1bppD9eyBGo+JQhnPHIowthnH?=
 =?us-ascii?Q?/GnOaE8pQgRpXBZcjczgC5O2HJx7jBwDl9/0zqbKaVza4kDnYhrrKU1XVR/F?=
 =?us-ascii?Q?5yOixDunXT4yYJAgLr9aBJnQPLxVO2Ix8Rn6euIVB3V80sAO6AMMzaAUiR/z?=
 =?us-ascii?Q?hh56UD3NDXZuYNvgIayQSoPf1lQ1od/xQQflHr7e+o7JLqYxA2xw/U2IRvVd?=
 =?us-ascii?Q?IIiYmmyrng7jd+mUYKu3AR6wkpUw6+b5PCAlH6j+niU1MzkgQAuuqrSi4tAl?=
 =?us-ascii?Q?YUWGWobA96geYkeVuu+ZGEuz7bZAXt1Z0wzAObc77XAjlcv9iXANZwM78+6r?=
 =?us-ascii?Q?Br0VVTXnzHVvh5lVJHX7hwcNA92AQEqOJhwuTrJjhqCx3oYHzSb/XIPhALbg?=
 =?us-ascii?Q?hVlJL0t4IaM7tRf766Qwy80CbIBnDwABhjJ+QDgZtx9UJtQDhuQbDZoYJY/+?=
 =?us-ascii?Q?iYSprSLu7bnDV+u8Cs2JdiV88//Oz2WMZb2KZ22fb+uUc5y+72VhCmj+gecT?=
 =?us-ascii?Q?vRoKmhvNQ5Cox3LlLLDpVd3Fk00KV0nF58d7nTf064LicP8QNMxSdI6yilEm?=
 =?us-ascii?Q?9Gk8tX3bVybvK7dyrrKJlx2R04V3K+zNHjy1C7ZkJLuUHQVTx4zTibhCC1uV?=
 =?us-ascii?Q?2dd5cRx0l8wegoq66rcDvK4o9nXEm2IpzfBPf4TU1ZmClnTmpSql3yvNjgU3?=
 =?us-ascii?Q?FHJC/FV9xTRP?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iND5RX30CYxWullG56cXB0AlkUgpRVp+CN0g+dzlj1Fn8g9ggjAGD+/YCUev?=
 =?us-ascii?Q?dISS8JHStLgpBGyOyKaCI0cD8Pbi6lX6xqPe3jI47JXasj8jpwNgwpRUx8z4?=
 =?us-ascii?Q?JtKFePkF4mdG0Nv5ZdWonQ68ufbWWzB5d76cKgSni9Wt2NNyM8qwEiK1/VTl?=
 =?us-ascii?Q?kUyxhB3jn3tPAG2qwz4wF+NEA5pm14jqMlCdMvRQWqOi5nyCk0+fFOvLcvdX?=
 =?us-ascii?Q?nLI5KZpoCXuvAWHB+TAsC9aX0z28VRAvw6Ry+666O57Cncy4db+YXnEYONE3?=
 =?us-ascii?Q?3ySwllJ8V6xYJxVvKsAPaoRvTrJuyfqi9qBIqDCjywALo9XV91mVutHxNUzk?=
 =?us-ascii?Q?HHCnrt9CCeBFTgBrkse6ag+34HSV75FG6cZRwRQTJRWGPviT/unBk+Fojkmh?=
 =?us-ascii?Q?HPYoXgubkCis7eCY9N60P1Hql+lyI1zUF8Z/FqkTU/+VR06EvO/pa9xHfBfj?=
 =?us-ascii?Q?dGRKI0+lbUMI3MBup5t/+H83xjOB4THLXHwtrJPAcfsVchDAX+1Q8QzaNT3u?=
 =?us-ascii?Q?DypMaM21gGCjh/bbqQv77Wu7KpSlx3WKi5m9aagYsOSV0H3Zq3WubIjwXD56?=
 =?us-ascii?Q?ld/pk2eVX4LwUpfX2nT3dXQZNGrE11gxwNk9RVjtQB5kerdAW7fa6AxKELwn?=
 =?us-ascii?Q?P7XFfmE//XXprNpzBZMRlGjUO8lXgCry9yFrZqGDVVBcqIWEC2KgnNbgkLj6?=
 =?us-ascii?Q?JVWaPRkX6opzn2jERkpmTSslbgV7W2pGTpYygnpPMpCx8UQgHeheL1AjJ2gy?=
 =?us-ascii?Q?DWLBdWweoubB9Yt4+aQ4NPqPsfx+fxNJQgs9tCqgFKoLihhFA/tHMuAWonGX?=
 =?us-ascii?Q?xJnzyvxEC8Sgzl/weNRfqKJSyMIiVP9zZ3V+xBWhJW/HTTLnIlfVEGMeytFf?=
 =?us-ascii?Q?T92dTu+Pl54Q23M0bS7CuPKzYWBVXf2tJV93+GItcMjMV8Mz/nPWDYEiWPS9?=
 =?us-ascii?Q?xGBncWn+1OYfqLp+ujcLgwGNtq/XJPotOwHMqEvvOx1wwJm8Oh6me+QWgPs1?=
 =?us-ascii?Q?eve/Iz+XFetilUxmxCRARhEN3Sq++5UzfbGpKZ4g++V9JtFPmxoCNbwwbSjI?=
 =?us-ascii?Q?aRvogyXezzuTvUuGuAAFmWGvO7W6I8G2ZIxbLS6oYt7EmVcfQMv+SDqdKDaf?=
 =?us-ascii?Q?0XfO6u2ns89yzIHNbiLMeAP70NO2w3GuKh5DOSYXgDmx/orJQ2u5B+akLZ63?=
 =?us-ascii?Q?YiR8bOQ+C6O1uPLB7s7y6CePyxUXurs/4h9VX5xt35Fb270zk8viBaSvyqbi?=
 =?us-ascii?Q?9e0yb5ANmA6wqrqtcYhVHRLVcDaGwa85eKIXdkIY3oheWZiGFtaBhj/04WkI?=
 =?us-ascii?Q?WEEF9/2hdD4q+7zDWilhpubDIA7ERjSuU0+AxPvPRqv7fQPe+W+35Qv3KDDy?=
 =?us-ascii?Q?cr+Zc73eN7aRDUE+7YrZI0ivKrIuVQVaLkpIZok9TCWvsmj8pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4413A075B14EC344A52799C60F59F4EE@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB7886.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd9fedd-bce4-491d-02f2-08def514c7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2026 06:17:53.0493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME5PR01MB9992

On Thu, Aug 06, 2026 at 11:51:07AM +0200, Antonio Quartulli wrote:
> A fix for this issue was recently merged to net:
>=20
> commit 33ec10567fe14456063daf549fdf1a4f53448e4c
> Author: Antonio Quartulli <antonio@openvpn.net>
> Date:   Tue Jul 28 13:48:47 2026 +0200
>=20
>     ovpn: skip rehash for peers already removed from by_id
>=20
> Probably you came up with this fix on an older codebase.

Hi Antonio,

Thanks for the review and pointers, and sorry for the duplicates, same for
1/2. I based the series on mainline 7.2-rc6, so I missed both.

> I suggest two things:
> 1) always check the openvpn-devel mailing list and our patchwork instance
> for already submitted patches that are waiting review (or that are queued
> for sending to net/net-next)
> 2) make sure to always pull the latest tree patches are based on (net or
> net-next) before sending them over.

Suggestions taken, I'll check them before sending. :)

Thanks,
Junrui Luo

