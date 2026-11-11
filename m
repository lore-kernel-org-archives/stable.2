Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379582;
	b=Jk5QwquMBtA8vEmXX+vRsBJmcnnhDCyzCishwbxrnjMM5Qj57YJfv9K1+go+BlCIa6WQ
	 oU37yr/r9kq/vTvi98q8LJz/Fcvi4uIQXkAOkILhC6EBDc7atLN/IzreKEKmK+AcOf/sr
	 /EM+fYd/NIhpBHG9qq4LRmFjEkIQ+OogQFd8B+KJW3mu5mVkQxt5OpaPRN6lYZMwgCuA3
	 Cz+gqfNgiLItuCpa0gA/oStJSRR38KWDaTt46L/gK3BLd7pZxTo/DNSQ41xWQqsu1TXjU
	 l6WXZxt1DN4Eh6qs9Q4KKu4b4CVaF/Mb9WDQ/m9uJ2DDGCVi2NaVOuN/LdZk4AQeZAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379582;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TzCUO3QhJa5k2QYl0Awnjro4woaaBs1luSOgWtMINqA=;
	b=0z+cNGosiDtn4fF6Mmxj7xLGroQeAfRpX9ORv87fmrAvuKMAp3CawlX1vc8B2t0P96fE
	 thz3a7C3rRZmFQQ5qqM8jT3T1+T8Wy/e/h78aTNFEkPrSmCxohrCuX+nbOX6O/FcsKz50
	 o0HFKQ8nqaYtTjbKRIjGbjNja4tP3pO469bdXHhJQiL3Ssj3OYeeFM1Lzco09uekOcjFc
	 CEQu2ZdZxh9CguF5QANrcgYjxxk2n9dDWtKE/GaAJ+bFAoo+ddsqpZyvnNrkHzcgZ9j+g
	 wCDJh+Z+t6KD/BH+uYLkCGtAJlnLuu5hmBGpZ/htDFyS6nJboHgpHgN4/ItU7sILTiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=rIu740Vo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.136
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020136.outbound.protection.outlook.com [52.101.84.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E9606A33E;
	Wed, 11 Nov 2026 06:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB9E9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=rIu740Vo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXW7vtJXZarwxpXWKJ9KHMc7bWR9zPIUz4QBNZARz+uVT3artx77mypcwdB5+ZOu0FFBqBOwNIzkissupNIXksTeofNf9VykkkWK5QSaThS2Fzxlyn+S1lubHZ1Jv9EZTFAGntXMZtfr/LBs0mbFFWzgViqP1pthdifIIbRBZefJdI6zeAe54BFSa826BzNUSyELsqLOn0iSE7/qz+UuCjYLa5YdtxF/DdTEHkaJpuNBZwBYupV7GrAFoDsvxJt6qqvHuiGdX/ltYuifRS0UplcnLeoGz7qxbAMu9TkQHfOvPxuURMW2cYvXiGMA0oCMytbvc4xr3ZzV1McsAZL2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzCUO3QhJa5k2QYl0Awnjro4woaaBs1luSOgWtMINqA=;
 b=gwqs3GNFUrrlPAnM/LrRZb7sb9tRsNWks4ikBhmCR0Nz7dPMUoqBaJLrdV0dw+Ns2PVhGXGUynQ615OnZG/Viy/4fnBA0c7a7vbzDXSH6iaxQ9RDpVROZ43xPrfRl3sEMGFNWOQm6Bja81EMBFGaMYwoM105BnPMpeQ9VTDcvOIMTW+rpOuVT10g9l3CsWuIK/0gzAnJUNMMmHaVq2GkcIaBwvJbUg9zvNr4R21PBFUbWpZfxRGuHEmZaB4NLzmrjG0n9DELXxGZL8wtxLeKzxYX3wOxFllBqVo8xDvko8ByAxzSX6KhMY0ydrfSQ7n3Zffh6Qd4jexIeEIQNMwkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzCUO3QhJa5k2QYl0Awnjro4woaaBs1luSOgWtMINqA=;
 b=rIu740VoaprT7EYbZIQyM575h9RtqM4oAb9VTRjn/OmRxCwxkd8WyaFU6cvdA73+kNObJwKIRjfhCr5b0mzooFTcARQiHcPRrQV1+TRTd8BKxxQrXe2Jjui9L7R8pLg80Zh++hV/9GxWyTHFcZKwxBAwo58ByFvkbX3v/E3Ab8qIiYI0eaJHPMdBnIwrvLJtp+1X6LLuH0jbhPFBukCxjS6QdW8Ct1qOahRgLwbi9RWJ4I//MsfmIDa57qvbq/h6xM3ZpujZhNqwyKLZ/1fw5cjxsOScEEJDR2ZVzFiHIw8HwyRx0102exAGaljwo+lrAwyz8ez6AYUJvghoh3a8zA==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PAXPR05MB8112.eurprd05.prod.outlook.com
 (2603:10a6:102:de::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:46:18 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:46:18 +0000
From: Tjerk Kusters <tkusters@aweta.nl>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Sven Auhagen
	<sven.auhagen@voleatech.de>, Richard Cochran <richardcochran@gmail.com>, Kurt
 Kanzenbach <kurt@linutronix.de>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Paul Moses <p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
Thread-Topic: [PATCH net v5 3/4] igb: do not split AF_XDP zero-copy frames
 over several Rx buffers
Thread-Index: AQHdbCdbBr9X87aFXEWAKMGPxXsLOrci1FyAgAWj4FA=
Date: Wed, 11 Nov 2026 06:46:18 +0000
Message-ID:
 <AS5PR05MB11020F41D1D54BA0D4AB080DEB9712@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
 <20261104-igb-rx-ts-fix-v5-3-bf4b4367129a@aweta.nl> <au9T4Y1rpxvuEuFv@boxer>
In-Reply-To: <au9T4Y1rpxvuEuFv@boxer>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PAXPR05MB8112:EE_
x-ms-office365-filtering-correlation-id: ad6609a6-1c1e-4cff-494c-08df3fbf7d9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|38070700021|10067099003|4143699003|5023799004|261021135927099003|56012099006|261021121427099003|261102123227099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 bUKsNcNPgygbp9AEJ5oYUmFftW7BR8F/Wn2a/dv199C9507GC5l3nHibeDO8ivIAP+FgtKWn8A7th9z5q129bc0Jrnv5b6r7ugngnQsPB5vYQ4Xh1U/an+1qY4Q9T7mnLH5rau3P+usYZ1QpeYFTAunA9JycHVp/kAAq9jCAGWwinnnZ/6NYLCl9OUNxvktoHyLOJNRDeSVKxqk735Zek3OFoqQRifIw5O5rPhVeS59gUrsa/C8a3LQzbIf6Qwx+wwzyx9qPYMpBINItnoxxXwL3334KlPP6TGLQstLL5IdolLmEJHsn1iDX46AdNOaFo1JeDV7NIn/BqORoNaN5lF2yXs5ZTPy0H6Z74HcZ211krZPDvveDkFkiEiuU1w/e/XeiagfjDtl8HNKksC5pO16SR4oi/kDkFEz0LVNPacvM8Sf1N8NVRtSTMhq4EXQ8HMMG0NkbXYun/4UkztShzMWQwIqwGjiwQsS3C2P/FWt53p8LgiPEMAa2umr6ry3BPwzkfCLfVgpuVI4L+DnPQW5Hp2/QTPyPfx5TLOTloPWVgX3iKAM6tev5qMpUr4dFNhiErMxMk6HzKiHSeXhAGxO9SIrV7Io6CKJuJJUCteK3jhPLzUhTi6nOtfo+Ef4Onmbs8vFsvmvfgKVu0EhO5VaYTArGjfsJv+/7JGM6wep6deicOQSzdpAE5SGhrptB3w2+ZEU9N93YYJQtkR5qGiO6qYqIz0ggYsplUm1SGZo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(38070700021)(10067099003)(4143699003)(5023799004)(261021135927099003)(56012099006)(261021121427099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DHzVVm7gnYlVP60u76evDML++9z/3uqpf96pX8+WRlKVy48Mq6mXxknfuFGP?=
 =?us-ascii?Q?t+eBjubg9yj4dYw72Sz75LA1lxiEcSdpnbStDeMw/uEgb1qLnpD+B+ktx7UK?=
 =?us-ascii?Q?BZxnD4CEopz3/WI/ZqnskCsTC+vlzt/I0joQCyAngu3k1b8OvUYD/Gzef//R?=
 =?us-ascii?Q?h5p4+DgJlOf61LDBkO8R8bUb6P684sYrHif6RkKduH3T8/1fMNTDynwoxste?=
 =?us-ascii?Q?tWbl49+blD1ESLSDv3+djRkzHL7/9K+FBv+gCjdTtIM4/RM0pdOxK3FcyUdl?=
 =?us-ascii?Q?zh6eIWDDZnc2XWivn+xbud/VX14lv6BtQLbEJI7GMlWa0ISax/ByoaHQ54Rb?=
 =?us-ascii?Q?2y0dwsUjTOyj0Z3W9gWcEu5yr5LlVHHnwJ1sEIheLSB0B/oJls3W1kNlqOTa?=
 =?us-ascii?Q?iBYHWYAdBd684ohrrAdry00Vo61dwhjTxSA8oIN0F9I249MmivpLqvhm6qQH?=
 =?us-ascii?Q?kjW2Vkbq4+SNv9I3i2vbXVZr4yDI8rQIbLoOf+sCx9Ml2jLgJszj6Lo+Sq07?=
 =?us-ascii?Q?TUzVhrJ7nV43Vxp6/0ttLkQ70h/QZsMN8l4tIU1k+7zVf0d7cJl1Z0xoOUwW?=
 =?us-ascii?Q?KStZejgzjclmxfkmLruGZr+oRrQ0Z9udIKVdfDBxgSx6M1fTHLOiV/eob7x+?=
 =?us-ascii?Q?pLFXNgPM2wHETfFvm3Kkkg9ULetP5FwWqIkNEDx7BZ1t6+3IEKbEy/7kElbP?=
 =?us-ascii?Q?th9RHRywLlJD0K1N06wYfUGvNoI+ifzrlDH1j++IqTlUyBpxe8CwhVNeaOK1?=
 =?us-ascii?Q?ZkjMXMqEcc9f54bnRo4IXSZF3NAzerjJ7D1fD5nzWvzg6AdnUc0a6tCrKhLn?=
 =?us-ascii?Q?4JeyzRcE7UNzlo/NttD3WLhDyUrQYXEYZzjrVKHnwh2cMwESrGq2zth5Bbtx?=
 =?us-ascii?Q?rp8G7pImAdOSB+FDmoWuv3tvtjzYMWb9FOD+OaSz5u53A84i+SsbAde6L1Cr?=
 =?us-ascii?Q?dFjbasCrQ0J6ajXdYotjlLT1E779BwXDWocdXs98hZWZVsuYIcxchEKDKMg1?=
 =?us-ascii?Q?7HmHMIr9sm/l91yILxFQXCROAf8x1mLewbHoNrYO3umPv483Z23yE9bSbR89?=
 =?us-ascii?Q?6Km0Yp+2ixWJmIkILzo9/lIFDU8l4k4jjrCna7mVJug4XZVh4df6/NaUos42?=
 =?us-ascii?Q?hLOp+ScZlnqEmoBJTQXCp22fh7YF67m4QiAlnTRJUrVzDlwH1MGVfqW/6wrt?=
 =?us-ascii?Q?AooHP9lSzhEguzCWlBgBtF/nJKwyIi5QX0TtyOSwJE2RqsO9CE2Dbp5JAt46?=
 =?us-ascii?Q?gQGDrGMEzy+y3TJ3SE4Fp1/kPkm+VC7EVkL+ykZjGNqPGWSmS/phZUstcqzl?=
 =?us-ascii?Q?4yLO33/4b2CMtxm1sGwRzPHcSUb/0mBFTVwnkblCVZsp3KhiJ/N/YSYXxbTV?=
 =?us-ascii?Q?actEPJ4OMtNfCr/P+HQ1kZSBg5pkzN69YGwqedKwr/B6a0bgRcFMZfp/noBV?=
 =?us-ascii?Q?abCjycpglkzS28kQUR7lngEiUV0umhl9iUYTfQXU27SwMldhkLyyNWFXjH42?=
 =?us-ascii?Q?ACRG84OSYXdQK9bjJQ91BZ1T/rDNhqnLt1TqExezTnqe/WW3jLQM8qkun+R+?=
 =?us-ascii?Q?ZgxmdaHXipEfoORVlBOd2MzV2mlyLq/aNk+wX333wURRFWTPThzr2V7/A8pS?=
 =?us-ascii?Q?T9gIVpHOQN99LOXrtD9/wzwIkj8a5qYMZ3tfXNgZktaimFTcail4Cu+rdJGq?=
 =?us-ascii?Q?Sx6ZOHCNN3mSpDb1DLu9PCFosaouwkeabing5FZpu0vzG53E?=
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
X-OriginatorOrg: aweta.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR05MB11020.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6609a6-1c1e-4cff-494c-08df3fbf7d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 06:46:18.8314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCduwrgkSw8RYGcUbLxtf17iRd2mnw1o2TrF1DYMdhyZYT+lZr+j8/ua2TMOS0gq5mJXfKA5luSTdR6Flc7SFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR05MB8112

> I would rather return -EBUSY when enabling VFs on queues with active
> xsk_pool. Seems igb sort of steal queues from PF?

Yes. With VFs allocated, the PF keeps a single Tx queue, and one Rx
queue on i350 or two on 82576, so a pool bound to a higher queue loses
its queue. In v6 the VF enable returns -EBUSY while an XSK pool is bound
to a queue the PF would lose, as the core refuses ethtool -L in the same
case. igb_xsk_pool() keeps its frame size check only for a queue that is
hidden in another way, such as after a fallback from MSI-X to MSI, so the
NIC cannot write past the XSK frame when that queue comes back.
