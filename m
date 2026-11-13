Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794574697;
	b=0kW45/YfCYlyMHY2ZYQpWeTWv4UXU4v/2Mg0okrpbUljsUt8LfdT1HMu9w8wErrpBspG
	 IbU/chpIy0g1/H6EJZIrSriv9h7mg1Thz3YVLj3jY7zuqCOmCTY9YXnGMasvi0T++3baY
	 aPWMNjkqKptMwrYL+c0Pv9kJY3FfkrcMJ4GpVYf1ZxDtBu14Gq8hMil/geTXfTr4MIXhu
	 bDBsjukgnTzTbvqOU+UGSv7DqUG1rCEWT6LcYPI2hjPCRomzDPuXT1bC5fxqyv6H7xdh4
	 iz7n3o/BJFSxAUafwgKN5WHT70tbyVIwuYoBzpLCo3fJ2fiIXM0WEqvXPN3lQvhplVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574697;
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
	bh=SYPsHxXUR2K1Bi3CrHhuWFTntd0roZMVuRy8YKYAi8g=;
	b=YulsgCe1qn4mTzfMDZKCIi1KFV/XaLbvyMpLFZ+kLLn7/P+5GY+Ks9bYT3+wpmaLoBRM
	 iSI7mswmP46BE4w/yuJFOTZnFIYjjmFG15jpGRyA/Ms0AB3G/RqtYtTKNe2mlo0LnkHxh
	 ggG5+WMr7kyMrXtm4iriN5LRst8GwvLH9iFhAqwSebEjqEl/8QCEOATPr9Le+06jF5W0H
	 6/ysCOGa+gjZG3kcxSictaCVxV970Zs6t0Hkr7LGrBfPRDW8Qw1JptZLC/TbAWiLORTrt
	 5ufuy7IzAW1FpzWPQZz67pfg/p8xjlZF1lbW4O+WD2j4FVxsq97Zs5CLaEArzQl6Xog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hydroquebec.com;
	spf=pass smtp.mailfrom=hydroquebec.com;
	dkim=pass header.d=hydroquebec.com header.i=@hydroquebec.com header.a=rsa-sha256 header.s=selector2 header.b=wXptaZy6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.189.3
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11010003.outbound.protection.outlook.com [52.101.189.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C623A606A323;
	Fri, 13 Nov 2026 12:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C623A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hydroquebec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hydroquebec.com header.i=@hydroquebec.com header.a=rsa-sha256 header.s=selector2 header.b=wXptaZy6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+xuy6sQ0873orQVd/ZdzfCrdGi6tO6aIoUxQ+fTuCqCDZvnb3cYt1kDGDDVQuQVJDyA1l2dpSNttfY+t6n2NOe47Ck4DYv+xZz/gKI+tdEe6wFr1RQR+4eFAqLb/+XlkqmOYxpIOim+9WIBLcq6HXAMT1kCNC15X6KZnr4cLj4I162sox5R5Q3q6dkOEKznQlfI5uuZuy19o89EyKNA/y5RhHZX/93tU13RgOnIIDrxIPM8z2YYNoyyTYE+Cdkyy9uGppXAi901YLhxbdIZqtDfyzimNsHM3Iix0oBgVpvgiovQxAK5/Za+a2jO2P1gcR0MyKHklgibIsgXZhYLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYPsHxXUR2K1Bi3CrHhuWFTntd0roZMVuRy8YKYAi8g=;
 b=x9Hnmf68KeadEq98CtwwoXpE28LyKMNp7BMvCslZR3evFthWB0XmXXrPWOYndd5PfNtLtIGgjkO8BoR3Lp6UbED95wXzHV/rJRsXBC6fRcqzSsSUkAaXzf/QZ5ldfu6za1B9zDOipsxeqb+MY4AcPoCjQLeiIle3ueS3Iy0u8c/unD+jo35mTTQqz4Ny5l/ugOHv+tmSyyGicXKA0DxPL0xb/s1wP+DpcBol78UtI1gfXBYflzEc2suiFultENYtqF3otp7JTt07KOYFKatgRgFJhlAFaWsY+2ge6I4YMueCfEQoqKaOBCkkTtwsOHaTjuqrOaJ7kKKvnBCmWZ8KiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hydroquebec.com; dmarc=pass action=none
 header.from=hydroquebec.com; dkim=pass header.d=hydroquebec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hydroquebec.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYPsHxXUR2K1Bi3CrHhuWFTntd0roZMVuRy8YKYAi8g=;
 b=wXptaZy6x6Y80uv6p0VIw74EHIrMoMfbdYiAr6l83zJc6hMeI5uNS3hxHGyvFNJg5pUrdhoUv18H85LXgB5s1fENgVcxaeTMAqS8baxOXkRHRFRKQMmbbJgh59wuIAzUYxFq+3H797bVDuQOulQ0bwP/7uXqQGMSifZ/+d1sSZOAHZ6YlSBm7M891GY3VbtXj4s5Z+VG8bqps1/OEz2ZbxpWFrH97ME2VTzLB/Zlv8dDkvLo+qSL8aFvk3ylkyABRfohPG/D1nmfnV2gMmINRneQcQePAf6uFzJdVO09/63q1SdCFQerGMscbjE3Gyh1WcTVDyrVkw4ZadL6M52paQ==
Received: from YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:18d::8) by YT4PR01MB815215.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:18e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 12:58:11 +0000
Received: from YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aae3:5d66:3923:ae40]) by YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::aae3:5d66:3923:ae40%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 12:58:11 +0000
From: =?iso-8859-1?Q?Choini=E8re=2C_Vincent?=
	<choiniere.vincent@hydroquebec.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"wojciech.drewek@intel.com" <wojciech.drewek@intel.com>,
	"pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH net v3] ice: fix Tx hang dump using stale tx_buf[0].skb
Thread-Topic: [PATCH net v3] ice: fix Tx hang dump using stale tx_buf[0].skb
Thread-Index: AQHdbsU0WKK0X92ek0mtB6hZZY0TXrckPzeAgAe+9rk=
Date: Fri, 13 Nov 2026 12:58:11 +0000
Message-ID:
 <YT4PR01MB647290B9E40B791D7EC2A7501EE37F2@YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM>
References: <20261107-ice-tx-hang-dump-v3-1-8f22109d1aad@hydroquebec.com>
 <179414851949.994134.15149868204650152541@kernel.org>
In-Reply-To: <179414851949.994134.15149868204650152541@kernel.org>
Accept-Language: fr-CA, en-US
Content-Language: fr-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hydroquebec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT4PR01MB647290:EE_|YT4PR01MB815215:EE_
x-ms-office365-filtering-correlation-id: 73ac1de8-1a11-431b-57ad-08df4185c5d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|38070700021|10067099003|11063799006|4143699003|56012099006|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261102130727099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info:
 GZdIQ1lriZ20qYILUAYlUwCq/Biivnlr6Ow8QolNVnO+JvLaGWWjwOYwV4aBS93IE0fQ5C2eb8WW37A5DS3ryP5cFM5CQkmUVCsL9K2TM72R2m/Uxb5uMYx2bRLQ3lTyAAAQGMYLQJZjHJK7tR1tcnp6L5/ncTYZYdJ7Ek5rW8L21D9w8h1w96BO3oVKS2l9yHgD478F3Iu9TT4nYClpn5Nk0HAkXum9KFWCsX5sibKMKNbfvz/sIJmUc5QMM5ZjZMOGqAVmRnnqZtyZ+1UCNAe/3bkHO0ZQ5S6pL7v0K8Wvlk43jayJmQztUalAftiOfVgyu9nwfOGDEt2e/KMh/BRltG4kRBJZYuhZ23K5YgT0P44rNUuHPEPsYroqZGnrEtJVWmiQRsohCPQyZap2COqLjjY8m0U2AghiFORucnNMVA1+OqTNhkZPTaB2vLqvG7gDxhwtWur3nnMvc1wQx5sAOdoqbHrmdmuuJmqwSjq70M10Nss7pxaNrT9hPsUfRwEKrqAoXW8fO68JRwbmEj17EPvPpC+9QjdCcC3Hv/pfyoNnvCNEJTvIKoTVrktpfTnOyYMOlXFna//znGPRGoYjahEDwo6Mgc/6sUfF12q/InItHbrQ6rCHFFJUyxW+1r7Cdo2+djYDQl+wYpKRzRoPXO1Vo/Lu4uiiUOMNXkw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB647290.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261102130727099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bIaZKpAIFTGXUXrK1Y3OC/KgZ2naypscCta4k0YoP40olPFU6oUSAdTDGu?=
 =?iso-8859-1?Q?gGVNQcbmSSNznOuzH22qmsxO9NP0BtQP7x4mWWwSa1oEUY3lfH6duNkw4U?=
 =?iso-8859-1?Q?Mg1TnT5+EFKa2RR2z3rEhKTW9+ikv6h8cS9hSK/EsatwVntDlqeV0JwPdY?=
 =?iso-8859-1?Q?1s9c5fDpt5vHjM1MYuJgHaDWelqjR5G06ALLfr+BOWckvLiU2twVg6iuhf?=
 =?iso-8859-1?Q?kcFR4GrJzd6RMsm7EmahJ1IXtyPaaOpV6Ht1TGnJGPDd1gHfLNEOKDm3Ic?=
 =?iso-8859-1?Q?HJ7994/eAq54RB5Mo0oMELceouDE8f7NtzuenwygktbBFbpcl2AKNjbB46?=
 =?iso-8859-1?Q?IQCZItF5TiYSyoNEoFsJ1LaZe0RBQmpL3tRzsjvdo2jpgRqFhrSIuoCwvU?=
 =?iso-8859-1?Q?Jq/vF+5Pd52bDSMdpu525KkXQ7OyWox1IbAygNu+Mod2LsenPl0lPECXs2?=
 =?iso-8859-1?Q?ys9/2VtzAwZQ03jzBeoQ4X4Eem13icFfHihcQaltNg8N5bQmVVsMXHx5kA?=
 =?iso-8859-1?Q?gX9XIIB6KM2qi02JQsLOMyB8IhJ0xVP3PCqSLCxTb7mGX14HpNEexZnBWc?=
 =?iso-8859-1?Q?m7jTLL66i1A68yO5tyjUn77F2k4weOY0H2uiQ0dWtDjMV2FGlPR3mKBXjL?=
 =?iso-8859-1?Q?paJIwnD9ohb1KV6UED+suYnPJx/YMvZxj5kJabLWWXADWUAyPKI9sSTlgg?=
 =?iso-8859-1?Q?+PBYfZCP5MHy6zJlEdpguLSjkb70ggJ7kXHBxFG5W8XVbh9U/Z38BvWejm?=
 =?iso-8859-1?Q?r4ZWncveqEDJr5NB7WzQHYoo+j7Ysxoi/Tieg8rOJaqoN9Ct1eVxRu+MOG?=
 =?iso-8859-1?Q?7oLL6ki+qotOkSQevAH7SS4INofvToitJYqGiGBlUJY1WA52UlCnV+kp6H?=
 =?iso-8859-1?Q?xfHX1f8ijsmP+G+Nw174tuHQcBHmywc4q3xE40E79eQ2c0lsxNCqjP9QJh?=
 =?iso-8859-1?Q?RP7ijdV7feMbvJ0YM0CCgSmEsOAtizArZCQ81dRW5BaNIYG18Hp2Z2rHfH?=
 =?iso-8859-1?Q?pHRYbZn19Gs1Wpkw4Yoxk8cLBJe1EX4o3rGPvFiEF9lIbGWEIWihMsGl7L?=
 =?iso-8859-1?Q?J5jE2TTvC6GXs2nwouGxVa8CcwwzPKW8Nf9ExZsCCwG49NhhIp0Ftxp+ck?=
 =?iso-8859-1?Q?EftStfhv77LVRAS7gcUtO0VpZ/whCcrWj4CBZGqTpa6r+l14WxsQjerxfr?=
 =?iso-8859-1?Q?h+44tHX+UAaN5mNulyKNFe2teT+xQkqjPtTXRWbQCI6ZPL6NTk7UtVAf2z?=
 =?iso-8859-1?Q?sqRQ5oVyhvJoorNAiI3zk9sJ6fHKPfrXO7etAsCn42neMdFhWstBjae+cK?=
 =?iso-8859-1?Q?RQYFZehqwNTIWgzJaaQA0uVO38JWbG78ByLkNqFi7X3/AoBMjs3GcfB2/i?=
 =?iso-8859-1?Q?2kk6kQs5AM/GM4V6YAWNwHYl9eyskR12zbFUMyP7UZXKCvAJS9J31nCRix?=
 =?iso-8859-1?Q?PjuQ3vwSieJ9Z+HIefhrz/ZX4hgVm/HEtne/kGoR3smtOJSUPcT+Isobmr?=
 =?iso-8859-1?Q?73x2D9huiVioqJEP8wiT9Ai52Dvhu64RbQOe4dwDFkhCwaLmXi/wX//XYF?=
 =?iso-8859-1?Q?vFGXxbmCaZgezqhVOFDEY7Q5wh3+zeNxPqe2VvGnQjnoyzuoxaaKVThyac?=
 =?iso-8859-1?Q?Ia7YK5hRa0WvtK45Zp0d/UpQnP1Wvkk6vTxqxGETVvPA9yVfG9RadOZh9B?=
 =?iso-8859-1?Q?UIj8NJoU/RrZszo/1wXcWWy7qd/J+iaxb1ZfDLeeSAOX0skwFVi31i4Usa?=
 =?iso-8859-1?Q?OFjmhYlkJePsNB01omq562q9ir0DywFg6FXhDLPQ1taTZqK94SZnWCQrXv?=
 =?iso-8859-1?Q?CpKcwf9K4jLkdw6tp4hiuoEmlcuCGtY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ac1de8-1a11-431b-57ad-08df4185c5d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:58:11.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f40a10f0-50ee-4880-9a37-6e1dd4ac2ff3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 00rL0V23iVJiQbTrGZjXd48EyQ/nCtPa6AQeieoJ3tmYw44zReLuyz7u3yXYLTMmjJtwJO3u94Hht4SWumXqTbiu+/gqZ1R3gx8S5z4536dY4lUGRwEHRLs7+IP50G1o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB815215

=0A=
Hi,=0A=
=0A=
I posted v4 here:=0A=
=0A=
https://lore.kernel.org/all/20261112-ice-tx-hang-dump-v4-1-9125f687669b@hyd=
roquebec.com/=0A=
=0A=
> Is pointer equality enough to show that this is still the hung ring?=0A=
=0A=
Pointer equality alone is not sufficient. In v4, the saved ring is used=0A=
only if the timeout was on the PF VSI, that VSI is up, and=0A=
vsi->tx_rings[queue] is the saved ring, with the queue recorded at timeout=
=0A=
time. PF VSI rings have q_index =3D=3D i, so a freed ring reused for anothe=
r=0A=
queue after ethtool -L is rejected and the dump falls back to the=0A=
timeout-time values.=0A=
=0A=
A reset of the same queue in place is still not detected: ethtool -G=0A=
replaces the ring contents, and ice_down() on an MTU change clears the=0A=
descriptors and indices without changing desc. Comparing desc would=0A=
miss the second case and is subject to address reuse. As before this=0A=
patch, a successful snapshot shows the queue's ring when the report is=0A=
generated. The v4 commit message and kernel-doc say so and no longer=0A=
imply that ring replacement is detected.=0A=
=0A=
> Could the success path of ice_tx_hang_snapshot() at least set=0A=
> ev->queue =3D tx_ring->q_index, the same way it updates next_to_clean=0A=
> and next_to_use?=0A=
=0A=
With the check above, a successful snapshot comes from=0A=
vsi->tx_rings[ev->queue], so there is no need to update ev->queue on the=0A=
success path.=0A=
=0A=
In v4, I also read the saved ring pointer before taking RTNL,=0A=
alongside queue, head and intr. This avoids reading the ring pointer=0A=
after waiting for RTNL while using event values read before the wait.=0A=
It does not make the event snapshot atomic; the handoff remains=0A=
unsynchronized.=0A=
=0A=
> Could the commit message say whether removing the unused export is=0A=
> planned as a net-next follow-up?=0A=
=0A=
Yes. The v4 commit message says so. I plan to send the removal of=0A=
devlink_fmsg_dump_skb() to net-next once this fix is applied.=0A=
=0A=
> [High] This problem wasn't introduced by this patch, but the service=0A=
> task can still run ice_report_tx_hang() during driver removal=0A=
=0A=
> [High] This problem wasn't introduced by this patch, but devlink reload=
=0A=
> with DRIVER_REINIT can deadlock=0A=
=0A=
Both issues predate this patch and are documented under Limitations=0A=
in the v4 notes. =0A=
I suggest addressing them in separate fixes to keep this patch focused. If =
=0A=
someone more familiar with these lifecycle and locking paths would like =0A=
to take them on, that would be welcome.=0A=
=0A=
Thanks,=0A=
Vincent=0A=
=0A=
pw-bot: cr=0A=
