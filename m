Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021823;
	b=Tg2f3VUYK1mLs18puNwXpJgA0ryr56oT94ALztNu0eIkNdMgINuWqtrxWelDlF7HKG9O
	 YTYt9y9oDjGkSthQywcCH9tGJqwmKZlFm/kODkGs7sfuZS9WcvHzNe+tvDoMbC/juU3V4
	 7sbmWkhSndCHpiPfSMDEKFEQkEda70h/86+DnJNRZEa8jIwQhruaK1cdYFwBUtzvpau/G
	 VaqYSQ+zH0tNfpbrt9fKGK20OwcNX9o7GWRFIs6EVVVG+lGyLVCmXVq8n9cXYIuIiGe2K
	 6h1m1fTJbKksDxfbc7mlmkfpIlTvihKAeIF3ECDHBbqTbNnPZWNYGA/gC2DMASDHkZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021823;
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
	bh=wTex4qtLJfSBy+cRVcioMUvD+CtwCsVOH/AECnl4lZQ=;
	b=TLx0yK44N1OSu/+2ERFrfPcRhH48jiAaSz5ucVdmYHlpnf9+zfytFUfuV4DCcvIGEArj
	 k/2+/42X4O9WghYVpasQx8Igbt49lND7+j3wTR+ejoFzwDyAWlEXjfyydo0137Z7W0Bdb
	 hwBqlQOsUWTjgmMd5FhocxFa90vv6NPFeg4V+Gdx1hDaqdnRqbw4eCanpA1x51M5B+EXC
	 qS/hZnurIQeQJYDnqeUyhESjCkGQgBRxI6BEUY0T14MnahUD4saS7d6VWtZlkJaenTHwi
	 s9YbahFm3kjxK+OdiVtILxoxNKGRY8VyK+Xc+mB4dDBZuaTm2cX2x4IfsDr8xhbCweg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hydroquebec.com;
	spf=pass smtp.mailfrom=hydroquebec.com;
	dkim=pass header.d=hydroquebec.com header.i=@hydroquebec.com header.a=rsa-sha256 header.s=selector2 header.b=XBQoGBi3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.31
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11010031.outbound.protection.outlook.com [52.101.189.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA48606A31A;
	Mon, 26 Oct 2026 13:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hydroquebec.com header.i=@hydroquebec.com header.a=rsa-sha256 header.s=selector2 header.b=XBQoGBi3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJBUhuDvGiQAJ8uq8BhB33xrrpC9qPTOrHnpwr71B7YuxAYJDB61nn6D7gi+bo8sdNYhybGoA35VQ2QeaoPowLNNR4h2mKXEsdrg04vsP3zic7psKjbTqUkwnHz4Iks8InCyF7tAfW84nbXXjHen20+5uQxnuM+VFhpEeZMOUau12PYVSEJo1Qa8eeOiniFgKwvYXVjiKaYMIBaVDiVDX77Yvbncx8a76u3rEa1P5MJv6kZ0S4Vaauh9ZbCnsvS4BLEmqs8pII2cGOTJHgkpTRw/hKA5V/unBlOlAs1/4VYUEba4ba2zo84lnFJnhyRl5RbIdJGCbpQed/ZUidGTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTex4qtLJfSBy+cRVcioMUvD+CtwCsVOH/AECnl4lZQ=;
 b=Jg0yuAFNTJ9d9UYbnyflWcB4nTyIARC4R0opwZtvYtsOdDC6OzF5iFSZ7N6QK7Xcy2v7sU6WxNvGTSf4sUpaOwOhcJ+NnE5cpJGMt+be0NSt12jr7qUIuV5E0pj5LL9sh9tOLjKcqT1cB0UZ6+BEQFrD8AZy6DRKpPCNnzoUQdQ8HLNBOhQOwuhSQkbYn5HZwLRdz/Z4XpeJjPsjMbpckzUVDXxO3OkLMWNX/wfUwJLZw2r7j46PcHZ8XsDOzT5d4YGnbcEPkKEOSi+30jWfdgCwO1RPstxoPvuVV4uTrHsLAArJJdaE2+UNJBV2bC/m1ETHvI+mTnlnM5nGdmlezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hydroquebec.com; dmarc=pass action=none
 header.from=hydroquebec.com; dkim=pass header.d=hydroquebec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hydroquebec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTex4qtLJfSBy+cRVcioMUvD+CtwCsVOH/AECnl4lZQ=;
 b=XBQoGBi3yi4upQiwmu9Lwy1TRrO2Fyjof9eGU5HAKeEzyIxKagTgUZzV0xxTTM5o26PyCeN7yWwu5Ik0JBtpI0NN6kepKF+VyfwY+VqzqjmJbwSsiA+3FfdbFwFePFzlY2njf7IzjQpEcERAD1aLw8ex4YnNHCA+gq5akukyDRHuPDvTHt48MgO2xPS9a96znK0e9wH/wZGimxLAIc6YeNbb5aBdo4YvW628UROm6Om8qBtwPP8udvf7XuggI+YiwIwC9eek/btiX5G6FbJYXu9R8RgYz7FMb10ZzdNjN9oNGNM3FNYDsiAic07VYcps1q3LfbMwETJYHyoBv3IpeQ==
Received: from YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:18d::8) by YQ1PR01MB785934.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:36:58 +0000
Received: from YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aae3:5d66:3923:ae40]) by YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aae3:5d66:3923:ae40%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 13:36:57 +0000
From: =?iso-8859-1?Q?Choini=E8re=2C_Vincent?=
	<choiniere.vincent@hydroquebec.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"michal.kubiak@intel.com" <michal.kubiak@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
Thread-Topic: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
Thread-Index: AQHdXW+bM3SfOdfqFke6mUP0vWk/Q7cGbgUAgAlv6yo=
Date: Mon, 26 Oct 2026 13:36:57 +0000
Message-ID:
 <YT4PR01MB647290C874F1270D6B581668FEE3612@YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM>
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
 <179250185873.3135.10101707471960530546@kernel.org>
In-Reply-To: <179250185873.3135.10101707471960530546@kernel.org>
Accept-Language: fr-CA, en-US
Content-Language: fr-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_Enabled=True;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_SiteId=f40a10f0-50ee-4880-9a37-6e1dd4ac2ff3;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_SetDate=2026-10-26T13:36:33.132Z;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_Name=Diffusion
 restreinte;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_ContentBits=1;MSIP_Label_5af313ef-8edb-402d-b576-47820579b2e0_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hydroquebec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT4PR01MB647290:EE_|YQ1PR01MB785934:EE_
x-ms-office365-filtering-correlation-id: 4e56a3e3-5993-43fe-ebfc-08df3366350c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|4143699003|11063799006|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 M3H+hdmWccA+7j6CvW5zeg7gbyKcj+/uDgzaKeB/SpGsAhD5E1Zw/qthATLOm9g7Ll5xN9rzzptTlGj+/3ixEWCorVIlCmFBz6LYdNJKVWuuRqYJI8VWWZ4YshS8m2WSQXp/AEL0XwOXPr+oJi4lmoPweDCWvqzRwhaPSHeu4M8hTEtxqae2F9eCY9AUt/BPTp49BJmeXv7zjfOA6BOQ4IhFnBGqWx3D2D/6ba7xWIdRlDnBY4jq6bXLnV5RE8K2Tk/nMvv1ChGysmqC8FXTntECz5cjEzY+1Vwiu2SznJYYp7q9hRfBwumXAmV5aZ+yCy1/6/p3xN1pN8mdGyuxTCLgxqYUSDKvnFfyhNSv6uuw8RfW4pvjYkcDnjwVoymP7QV4ikLTxUWA/OopaBfY2qi1LqcDwlZHbxseOfoC6p0tV4sMwmf7l/vZOnDScGYPrWnEl20Vp5XLvPkKoFk0gTwRN4PxZON2Jhc51M4dFTqfYBpy6xAkEreXFV7C2VhWd9Eqjw7JLhgtg5yXpLoBUfP69y62K7KVT3yUN3BtYNRSQXrq+XIAFLiV4bFprPI2dHYlS5RuC2GJTD8hliuzgHuUCG/9dN1c6gdR43cFN3iG3OBwOgqN3CAmeg9eiq4S4BpwR53sEhcPGhN/13WT+A80e5lmEgnEx6KXpH3Yhn4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(4143699003)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tc1qFNqLmko49kNJXQWYgUft+tfcwPCue/7He3Evu+BxdCkymH+KwGIX1x?=
 =?iso-8859-1?Q?8jd1PIRrYA3Iibg9wKkHPrf623m8HSEJNA35AJTU9ADzuKt86pNknw7Gp7?=
 =?iso-8859-1?Q?XvSUNOVav6XkGzCHJAwXMrsnTvQFCESsVyFeI7ZitdCxS5++9uqS/+ULSL?=
 =?iso-8859-1?Q?1zaqdkVoGiZ//Tfvw3U5BqVieLDKerUIdpO8FV+C7QqasguV6E850aVa/B?=
 =?iso-8859-1?Q?TFlZOt/lVPS70xTcf1DrJENP7YEaTuSS+m4wJ3DtyoI1/wQNAZiR3ij5ch?=
 =?iso-8859-1?Q?CIIdWtSWViZAIhPX3oaeoAZ+vUhbLQ6xlbgU7CKvvxNVPXceW1Bnlfr8si?=
 =?iso-8859-1?Q?AZq8f0W7fHW9g9373CST5n0Xaj0878MUU+9qB/nctMHV6O1eO9kWiICc9r?=
 =?iso-8859-1?Q?AVTWks3eV5lZHOFKAA1b1Wqrt3ZJMN5XnGh2jCxaA08keZaD0JM8cBvHP0?=
 =?iso-8859-1?Q?h44e/p8CF16U41L5kwYr5vY0islIHPMhFqAVpzNZfYBXIqCetLReJiYWBO?=
 =?iso-8859-1?Q?ELSdaOvMZBQelIyKvrivq8SPmkIcf7nVPKsOSdZoLquWzZyn5uBzrPzhJx?=
 =?iso-8859-1?Q?t0rSOIjhmjLS0kaZcCzet3cj7Ebi+m5jB9s0z1N7ifDptA517s9KGA2biw?=
 =?iso-8859-1?Q?BQMfeFpFoS0mancG5tsbDPCPGO67gvAkXUxo7d8qTZxN6kGi54y3YIPDFl?=
 =?iso-8859-1?Q?vcRDUrLQg8bxHv//oNQPuS7P/r0v4CTMmyVZdQRDQx2LQwA4qzhT5BgoUD?=
 =?iso-8859-1?Q?FkuWiw5Xc1JwSqiwAxg+aTLcFkBuKNyBYIrzRisuSUYH1YHzPhSM1uJl3n?=
 =?iso-8859-1?Q?d/sOFffy3s+zcgyzPdxn3kZNbZiZ4GK6+isi0tLAg5PFMc1U+fNLavEkoQ?=
 =?iso-8859-1?Q?BQh/i5zY2fUGaRmRUpnPiCxFVNBebhesHxPcTq3AxWMLS1rOh7cyz6R/RF?=
 =?iso-8859-1?Q?fw+iIWDqFDQ+zSV2UM+K26+2LKiKj7JnQbpkScNpFZsMGWfqXsGGesE3Y8?=
 =?iso-8859-1?Q?OD2t/TEHS1PN5F4n8Zz0jHv7RI5pXrPOmM0poJ06AWndwl10nLHmbYh3MI?=
 =?iso-8859-1?Q?mSmr2Qcxjlqmb4BuvnreIJ7GRJHHc/M1+ieZCTWY3yMsJgazlgqhm3vd54?=
 =?iso-8859-1?Q?2jo8QIqo5sE9TMVcbYHJzNrHfddZs91KncFQr0bTUM3j70VBfcn2B4+KnV?=
 =?iso-8859-1?Q?m+B43nqkiHmMNQyan0gJQa00Xi9L8sDSEeWqevXwtFZu5pg6sviKHF3/8W?=
 =?iso-8859-1?Q?TL8wh+j910jhozgAf6yW+J+OsntHJ1ov3N3mwza0JkWGf2I5IQtwfbuGoh?=
 =?iso-8859-1?Q?zFyRHLxe9SSEcxuf6Do0mj1fH1L3KLVgLiLz3kzTZCpkYVcAgkcmiVzaZr?=
 =?iso-8859-1?Q?Epw8IwifFvORFxSoofeH0P4u9EQVsxSqcHeNL7xQKvVjetGOv81xL1VJvm?=
 =?iso-8859-1?Q?IynihVUvZ9FR/9VDfpxqNcnuIApzj3/4Xky0O0z3qmEU/JJdFhwlJEEf3r?=
 =?iso-8859-1?Q?C5cpfsMcbs1gHZNTdLz1/T2vwe/SYpCpUiNhNe0tDp/WldN+zMWNprcypJ?=
 =?iso-8859-1?Q?7xMWJ+7RCQzZ5lQ9IiEQNbhDVjr6qR/EJKQGYEEtel7kZ3UuQXTTeDuOGN?=
 =?iso-8859-1?Q?5NXzUgaK0xXJK4+K+/Xa1khVhkySf7F5LNe0qNbZa4Y59BtK8cNI+u3IuT?=
 =?iso-8859-1?Q?CfXbvYSTeXOmzub8npqUGR1RuF9kNwU9Ug1kO6hjxJRhN2ZTzhcitBu3uE?=
 =?iso-8859-1?Q?TebXFzH28T6JMhs7qYHgtlbe+GRABMgJT79xO6bsQC6kvy17kz6IWL7mE3?=
 =?iso-8859-1?Q?6Aal+YzG/5SftYEKST/mbWmKUIwXgjg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e56a3e3-5993-43fe-ebfc-08df3366350c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 13:36:57.9278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f40a10f0-50ee-4880-9a37-6e1dd4ac2ff3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SYRRckFoemoz526Bzx7Yc7WqfA1M8CkC2MTJ4lxuMrDY4DG5TgCrQDlZgtjhQpqbC1TXj995QVLIrVtTgI/b6RUDqhLxUirOiNig9SZMiHegqM7AfzRmQwy+yrBDNoPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQ1PR01MB785934

=0A=
Thanks everyone for the review. I posted v2 here:=0A=
=0A=
https://lore.kernel.org/netdev/20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@=
hydroquebec.com/=0A=
=0A=
Following Sashiko's feedback, v2 no longer dereferences the skb:=0A=
only its pointer value is reported. It also validates the saved ring=0A=
under RTNL before copying the descriptors and IRQ name, then releases=0A=
RTNL before calling devlink_health_report().=0A=
=0A=
Przemek: thanks for the conditional Acked-by. Since the implementation=0A=
changed substantially beyond the additional NULL checks, I have not=0A=
carried it over. Could you take another look?=0A=
=0A=
Paul: the skb contents are no longer included, but the descriptor=0A=
dump remains available when a ring snapshot can be taken. I dropped=0A=
your Reviewed-by because the implementation changed substantially.=0A=
=0A=
Synchronization of tx_hang_buf between ice_tx_timeout() and the=0A=
service task remains outside this patch and is documented under=0A=
Limitations.=0A=
