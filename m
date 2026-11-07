Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794064407;
	b=SVZqAjgOzgher0gOwsIHbY7iLEQYyRAWoQ6J4CEA7C0reItdH/rOdliU7SYdIxGgvelQ
	 CFqhgAgZ5kLHRumlEQ+hOqsYYzr3Bo2Ff5miXVGOkvYb/s7iXmAZ7BenJtnv3V45OxShI
	 7hWfVSLTQYQ8VoWBFSgKI18Tn2bQXYz/O59g87R6azLnzBuCcW/MGconlcDwlJNhRDmlS
	 ehf7ko4HFbHmdkUSzeD6eLNyQMP5PJdPDNdE17vVFHuUZPy71bbC0cE+7LvKIiHq7EMwp
	 qmi6LNvbYkKj3/xn+E9hYrS1w26TAW/aziMcehGEX5FajrmGaH+WRwno3nuiTAGZZ/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064407;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=cfImJqHL+dzKHx/Mltts3JcvtV8m8GeGHYFDzuh95ik=;
	b=G5nkTdsatJQ24rEH0ai+tQpfD3bFGTZ6+lwQ8W39FshN3maeEsjgnVNLa9E2657Z6LrL
	 pLEU3wt7hb0mN4ytCpnsicA2y5aGnbXvgshDNc5/N+jUJMxSYJy453ag3PrcNeVqc5lfW
	 nhTBnGOYb8h0uXFczxDZj7XkswkW/O+4AxM7et8RFz5tvuRbfm06h36EMb2BXw+cSaYAD
	 aZQ64Gm2eg97jd6gOGERZ8DPraADEn+gaHIpws9m65t2kmiP/I0HBXUZPrKO13tBG17vB
	 /357Lo5WJeAYtqCTW/YAHZDfv7Tq/kdZeexRaWUK0XqXfaM0b4Qav7QMgc/qgC/Cczw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hydroquebec.com;
	spf=pass smtp.mailfrom=hydroquebec.com;
	dkim=pass header.d=hydroquebec.com header.i=@hydroquebec.com header.a=rsa-sha256 header.s=selector2 header.b=BzWMl3II;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.192.2
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11011002.outbound.protection.outlook.com [40.107.192.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8B606E8DE;
	Sat,  7 Nov 2026 15:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26C8B606E8DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hydroquebec.com header.i=@hydroquebec.com header.a=rsa-sha256 header.s=selector2 header.b=BzWMl3II
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ4EWPPmT6Vo+JZnU9529iVnVyDHvLjRtN1pLfRPpwAlQCZ8ijT0Pvk9Ca6x7OZ8xSTxuMjKTghVVN4n1kuqmpnW0rnozJI03r7Vv/13/dbR3rrefpy0WYPFvszyMYn1JdQLzqUG5mntZ7WryH4mUYQoCNjaFISzg9NuCUdJlfaEqHlNhPobmoFKl1uB5bRRP2D5j/kBb99H1sGsQ2kTc6VAoWGWWS8gOBWHYq+f1ep6mU1cEYxP37c+MG8C1HKnln29Me/TKEay3lyP5Q2lNd7IV4cVxRcfnrb4e7yE6qwK+F4kP45YWKw+NckDMEWbremtWTeZW7ao55x5acd8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfImJqHL+dzKHx/Mltts3JcvtV8m8GeGHYFDzuh95ik=;
 b=ZkMR5Vkow966ouE+yA8bU15qLsGeB7RGkc+13sX8KoAY3EiPn8XacYSAy4diEZr8senu/xsG6S1hiO7xkd0erkM2ykaC63Qow3Yw+9tBXWlqq96timhUjvdAI7cIJ6KkKkeFq4AWFFydQtyQf+T1Rb3WypQ+LFb9Ea5BSZXrRMOFVFF+1PMy/voz1Ki4hBw8mZlQFkz88OKhwDpNRwHsK8KoTrZYLXMF3UYQMSF3WFLw9S8GHULizdldfmI6/b4tJAoH6C3NxRgYKBG1YcaVdQiPLxPiBKPczjFo8kuHubSjDSmiKEajx0GLnd+mLn9GQysnUtH4sZMEU/1MBGPLoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hydroquebec.com; dmarc=pass action=none
 header.from=hydroquebec.com; dkim=pass header.d=hydroquebec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hydroquebec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfImJqHL+dzKHx/Mltts3JcvtV8m8GeGHYFDzuh95ik=;
 b=BzWMl3IIpZeJ3TLCORKfFLfp/jx8dzzxRYFLmV6Akc3ycNy0NPfg/z0Hgu6khP5fb3+uNjFoEqKDWCy7HDOPHFbVZs4KZ/Zu/RvnobwJNgWV0s5z3aVpSrXA29JIQMjv5b5mJ/ZwOA/ZM/ZE1+WeljitX6zAI6VhnuKlwXXQQDeWcMOKRjCDFDs1ASwReik6zhojp6+puzgdr3EhUgZFDuas6FcDUOFxyVSx71ZuJ4EALsFQv4KmzDLShduvtZCBU8+9nSo/7V1bUZCVFnC2nzu1RwBLVIEeMpB3lYgQ0pEmSVwcQ7tWh2wPqwwJNcGR8C8QzD+2s8vWt4dvYt2vvA==
Received: from YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:18d::8) by YT8PR01MB553497.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 15:13:20 +0000
Received: from YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aae3:5d66:3923:ae40]) by YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aae3:5d66:3923:ae40%6]) with mapi id 15.21.0592.010; Sat, 7 Nov 2026
 15:13:19 +0000
From: =?iso-8859-1?Q?Choini=E8re=2C_Vincent?=
	<choiniere.vincent@hydroquebec.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"michal.kubiak@intel.com" <michal.kubiak@intel.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"mateusz.polchlopek@intel.com" <mateusz.polchlopek@intel.com>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] ice: fix Tx hang dump using stale tx_buf[0].skb
Thread-Topic: [PATCH net v2] ice: fix Tx hang dump using stale tx_buf[0].skb
Thread-Index: AQHdZU4ihKdjzNAMJk2Vt0Tl0Q7xS7cT0jmAgA73rbw=
Date: Sat, 7 Nov 2026 15:13:19 +0000
Message-ID:
 <YT4PR01MB64729023ADDEA05B9BDF7F064BE3752@YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM>
References: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
 <179324143967.3134.13716472134019576369@kernel.org>
In-Reply-To: <179324143967.3134.13716472134019576369@kernel.org>
Accept-Language: fr-CA, en-US
Content-Language: fr-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_Enabled=True;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_SiteId=f40a10f0-50ee-4880-9a37-6e1dd4ac2ff3;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_SetDate=2026-11-07T15:12:53.896Z;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_Name=Diffusion
 restreinte;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_ContentBits=1;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hydroquebec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT4PR01MB647290:EE_|YT8PR01MB553497:EE_
x-ms-office365-filtering-correlation-id: a9ed6718-bd71-4db0-963c-08df3ce1a83b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|38070700021|261026140227099003|11063799006|4143699003|261022075727099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261102123227099003|261026121527099003|261028144727099003|18002099003|22082099003|6133799003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 p+/iB3/5+iuaUSz4Q14Aqj3e8yPM1zadF/Y4J0/xDsDckKMKJ3yp+7g4OH6eS+5xeFGDgp8spn5/vQrcutcO7gNKLBGuR4E6f+/N9oplyIYHUlypV3H4kbGaug5wt/XmYEkowYa7itkRV0NkDBQzQSPFlHRW1oCxhQ/bQg9ZgvgAunEtf2w7nWmDZ2DxsX4AQD0Y2c2ah/I/EViy2UTuWEuIFG1gTiiaHvhycn1FJpzGb6NjpsQy2pJ7plyJfzwyIb6DwcG/9TP66NcVfzLo8xcDF5VKH8ksqyM20Bj8MGwh8M5Aqh+E3KuSBqZqXxGnQjHf26P957UVPA9bSPlFQa4congL/QMsN1vI6ct78kkmRI89l4Kl0PMeNrVbJPaArE2cdDYNGqGmlGTNaFHbz63PkPj/Tua2r+jtY+ziDAfOg820Bj/ohigv/lvRhT8NB9JqQtZ7wNMtUJHwbYoVIYuUbj6/ufmOnHgnfJQvaFRdQy6aGhA603LrXiGVUOlpUejGvRz6wpgLzw4RgciuTKZNnk15mdJTWfyGLmYC4SsDtkuTSLcBWegYPVnC8DorHWoaKZf9ZsjuxFVkcG6hVUIyxrKIbQ0i1bEfGpACv+hqV2/9OqipjCtY93RCi7NTqRqJmNghp2yaqogxIIQL8Wmf+2g/QKlRjzySSN9Gxfw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(38070700021)(261026140227099003)(11063799006)(4143699003)(261022075727099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tYy6vgNdsv1TtQS4BHnn/SVfvmHEBB4M6igir/bSsQSGmjBuMhfTg/uVjE?=
 =?iso-8859-1?Q?aAYKcNANFIqMAB3+3PlFcXFquSLsw+6qj7u+vBJxkkeGs112cTMteNoOGQ?=
 =?iso-8859-1?Q?caZMhd/a4k7iBSpXaLffysa8hxOExhLBmTrWIhuuje1T2EFT2hd0Q80tWi?=
 =?iso-8859-1?Q?81VIank8WRMqExgwnzly3VveN05QI+xpwYBKHG7eT4oVBF9SXuPMTmIEX7?=
 =?iso-8859-1?Q?9/M4OJXS9CXdVSGuRD2hRaXbIXycFM19u/HgEci5n2NtVqkZz8iI4EO+zt?=
 =?iso-8859-1?Q?jthl1lM3ePmUnshwMJjYidbDtATAV2H40MlV4B70wmp/CiTHRLxDQENkdJ?=
 =?iso-8859-1?Q?mreZJsgh/gIvY2XBCBMyixIb68ljNuTNv1tWI2HPMC3Y0e+y+akSrr3L8N?=
 =?iso-8859-1?Q?aScsNMNLR0u3CEenGpDHqMxd5USiOYll0sjl9toD/NnyDvjXvPH6Q8fk/k?=
 =?iso-8859-1?Q?stdS+IWwgffiUqsWzbJlQcNOKtH1MyX1LUvoiHBaV1eU19/Zi9RL66FLLs?=
 =?iso-8859-1?Q?OJmQZHR8DzBlwGopytM5kKDOqnf2elmVpoQ7vH3YYjMQoF0bSGnYgaVNN0?=
 =?iso-8859-1?Q?7QAxEDF3clyJNFUEJtejyA0c05BcTjyPPX8TVYCx5EBkkHxb68jJPecYUs?=
 =?iso-8859-1?Q?QLBlaXLZl0S3aUZ3xDkzVNC3sB2HJmuvbhmUdj9gtUArpSLpg30XYy3qF8?=
 =?iso-8859-1?Q?3CHJYfxhHO6dDO5s7BC4uwXt3IIwELs32w28bZnbcP9EGV+ZCw5oW2200s?=
 =?iso-8859-1?Q?uH1I7JshBLZL96QgwgGQq3bWGLQq7PFMj0syn8MP+Z2vl0jrvpQsJKfB6m?=
 =?iso-8859-1?Q?JmXrXiAkRSTSN1THF93tHmDNM5zgIRadDX1KW8746U2hslluy1BQaz5viH?=
 =?iso-8859-1?Q?aIo8V/pJTpJsB2aZNhZOQw3XscfCnd4JB0WcE4qAbYe69Ppjb+8Y0OCB7x?=
 =?iso-8859-1?Q?nQf9y4DpE1w2ZiIpj8dGwSM4dYoU38CgIi5gTQkjWprMnGfDcWZe1Fmh5k?=
 =?iso-8859-1?Q?EnQc8XQXCQlMrdHWAz7BaZFHZxZvC0HG+74RRn38uTHx/3POY+fsTtnyZx?=
 =?iso-8859-1?Q?JnyMnFYWK6vpqnuy+tj4v8L/rYPEEhs3L9yM3/uvP7u2ewNZMoLeMOsE3l?=
 =?iso-8859-1?Q?L7l8vmn+rQ6EGxNdQ906KyRkbMskAye2Vp6ZIzOTfRGirgSdz+L1buhw5h?=
 =?iso-8859-1?Q?xPO3eIMDonfVZzCghaqC9LinAmPR7Zex/N6oQkYn65w8xNzt3PuCFecySu?=
 =?iso-8859-1?Q?wHIMP6aoNDNAfJ+Hb7GQfF4GBZoDaY/VYPI7RpkWtK/K1d2TltpDzc/gOf?=
 =?iso-8859-1?Q?wNuHv+IwlitkdB8drVYRXSfmtSzdiPM0h8PiMeJ/uQMF72B99J86CEH8cU?=
 =?iso-8859-1?Q?0C1gFEw3j/rtL3FUwVHoxeH22B0UFOU99S9cav05CzZtWuXt4D6kvfwRa4?=
 =?iso-8859-1?Q?Ma74GxNUH+VwO0SuJXEJWOztbF0qDSPdiZca0tDeX73ulI4v5IUd93Gq5S?=
 =?iso-8859-1?Q?Z56Wf+yRNZbUq36R4IXsckQlpzM1y/gKJsHRw+O5YNtD/KM6IFtIUR9a4B?=
 =?iso-8859-1?Q?fB8Ts6EYjFAFu1RkzbssIdn7PM7T0OQYe9L6j9aLSxJkTyOBXfUTLYejz+?=
 =?iso-8859-1?Q?O82QZ+veRvEK0UO7MCfh/8e0uyScDjpmYa0SOnlQm+oBHwnO8yK4fPQu5l?=
 =?iso-8859-1?Q?xTQFn88V3H/8TvWaQhlEzFKxysSPq4MFiE4VgjCoFtFkKVMFa4BWA6wOOh?=
 =?iso-8859-1?Q?vKu3a3cOquHkwA6pbh611EUR3kJyCQOLQgD4D/poi0KDlShi/tIJOt2tYq?=
 =?iso-8859-1?Q?CqI2dqPCeDXoA1HBUOSQrxeqj+y5hQY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: hydroquebec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed6718-bd71-4db0-963c-08df3ce1a83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 15:13:19.7453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f40a10f0-50ee-4880-9a37-6e1dd4ac2ff3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czT16vcoaVE9peCabd/uma6astxbbVyPy+eOOSunTxYSJMFaN2B4+zHDveC5HF3Ycx8C3jDS6miqNoff83TMmO2zlXCBMOx5VKMpxX8Hy4GstxtX8Av1SPJG+lWXedUS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT8PR01MB553497

Thanks for the review. I posted v3 here:=0A=
=0A=
https://lore.kernel.org/netdev/20261107-ice-tx-hang-dump-v3-1-8f22109d1aad@=
hydroquebec.com/=0A=
=0A=
I checked the sequences against current net.=0A=
=0A=
[High] VSI and ring lifetime in ice_remove():=0A=
=0A=
You are right that the kernel-doc claim was too strong. In ice_remove(),=0A=
ice_unload() drops RTNL, ice_deinit() sets ICE_SERVICE_DIS and frees the=0A=
VSIs, and the service task is only cancelled later in ice_deinit_dev().=0A=
ice_service_task() also runs the Tx hang report before it looks at=0A=
ICE_SERVICE_DIS, so the rings are not only replaced or freed under RTNL=0A=
or from the service task.=0A=
=0A=
The underlying lifetime issue predates this patch: before it, the service=
=0A=
task dereferences the same saved ring with no protection at all. v3=0A=
removes the incorrect claim about RTNL protection and documents the=0A=
remaining limitations in the kernel-doc (ethtool -G/-L and the reset paths=
=0A=
are covered; driver removal and devlink reload are not).=0A=
=0A=
[High, pre-existing] reporter freed in ice_remove():=0A=
=0A=
Correct. ice_health_deinit() destroys the reporter without clearing=0A=
pf->health_reporters.tx_hang, and the service task can still reach it.=0A=
Same cause as above: the service task is stopped after the teardown.=0A=
=0A=
[High, pre-existing] DRIVER_REINIT reload vs. the service task:=0A=
=0A=
I read the same sequence: ice_devlink_reinit_down() reaches=0A=
ice_deinit_dev() and cancel_work_sync() on the service task with the=0A=
devlink instance lock held, while devlink_health_report() takes that lock=
=0A=
when auto_dump is set. That is a lock-ordering problem rather than a=0A=
teardown-ordering one, so this patch does not address it. I have not=0A=
reproduced it, and dropping RTNL before reporting does not change it.=0A=
=0A=
[Low] tx_hang_buf:=0A=
=0A=
Yes, listed under Limitations and left out of this patch.=0A=
=0A=
Przemek, Tony: I think these pre-existing teardown and lock-ordering=0A=
issues would be better addressed separately from this fix. I am willing=0A=
to investigate and test follow-up fixes (I can force Tx timeouts on an=0A=
E810 with KASAN and lockdep), but I am not an ice expert. Please let me=0A=
know whether you would like me to prepare a separate series, and I would=0A=
appreciate guidance on the preferred approach.=0A=
