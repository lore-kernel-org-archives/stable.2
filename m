Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793464477;
	b=KpKRRzd/YY9avsXiMINM9vZUHrdaR3Uzj4rrWyKo6BBeMqEsZYuG9skWNZgvwoFornM/
	 TtWuYbvgkTIhpiRZcKyEttFuLUtm+82NEs+gRK0xXljjKR6xhU0qZhedCJXNS8JTVCHu3
	 lsUbuuQQOqUYCTMl5k1TdzqugfjqqtzgSnQgpbnH6JHlp2QOIRYS/ezSS4Ia2VZRe7YJW
	 ta1zz5kxLUCwmBrEZXqwjmoqfj8fhK2UaVS18rdw34Sc9lRPrxWtidLEshsSawgKL+GEf
	 REnVr9sqgt/ZKuIUa5cTBkA2S73fHw52FOgL+xTAbOomfZE3IAQ0vyzG7AHBfbibbAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793464477;
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
	bh=zbvr4+h/uDP3p2rEUNFgDQq3HSLr/cFMqPajhO5UUmE=;
	b=sPw0dE8RGXdOiIHCrKDdvbP+jwYpZWN0GldhDIOh1YkddguOkeFiwMyndD8Hs/WkY6kI
	 h2cqpuKkbVljZgGCwr2zEYnVhf6u5FORI926R0etWCLFjAAJEKdWiiDGcjmd6bB+yKtT8
	 iIC58H+/lkKqesxe2fAZDa/q6O5OhiZr0D112aqoeX5NPSf5HH/dQePW70G3uW8V12j+U
	 TwXylzno/PTye/3saV2pH4Q0Lz0b+dQULiknQHh+TZzCTOKJG9F85EQ+EUegCA34dHPES
	 UphZexVhj2ahV1igN0nX57E0KWCVwhtx0S4vr7EYJtz+jfwzu8Ih2Q7Qpq6DbefFwuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bp.renesas.com;
	spf=pass smtp.mailfrom=bp.renesas.com;
	dkim=pass header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=XnB9POXM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.65
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010065.outbound.protection.outlook.com [52.101.229.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A07606A31A;
	Sat, 31 Oct 2026 16:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.a=rsa-sha256 header.s=selector1 header.b=XnB9POXM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIIMtLlFCXGpp71od5oaBVSn4L+VHTex5j46NOipj0GniVxnFW52FNSZvORp6ZrZU/laspyLHwhbUoZ/lko1zH4byV6K1VmlVi7LspWjqNHzLzZ4zLzwLc2OwfSiaYcxJAg+/rWvbUxRyTgpHKM5OK9tkgf1TFeuPj7If4p34EAORi27tDCTdOBIZYZYyy89FfA3T+a/YQ57ccd6/JBqQN1OejIm67+yafEtO28jXXYk3WOfaALJqt0RIVtualzSQgYkU+P5GolA/psWBc7SM9BZ0HYYMA8SGA59o1f1njoo8KFKIoP4XCR1l6lFdauxcX2EwgkEyIIloahjZAJhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbvr4+h/uDP3p2rEUNFgDQq3HSLr/cFMqPajhO5UUmE=;
 b=he5HEhJ0Gy5CSz9a85T4/c9rtFtyeIuee4jCHwKBh93qd0AgC73bTEYDIggi1oXimynps0W/RRYSyy5Iill3cvCZgw32wsZKcYfGuT5vDqEQ6TwcvigatXj3cAIcqqgDObl2iyJZwm0lncVYWxhogEXq3To3zARAfy7EHCQRZsVO042AGZNzr2SRxmVsPoL7IypLmpqf7TELdgOepHSAMIpRI/23SMSJOvV65rX45ieeqgUzPMoSD4rcFrLhbtGUkx4/FysKJ4IrZ0g6Eo3ldX76qQbgkOM+OK3uSPXyPxiHZ9BxRI7X94Or7rHcKj/auAWkCd5rwxkKxd4rHhrcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbvr4+h/uDP3p2rEUNFgDQq3HSLr/cFMqPajhO5UUmE=;
 b=XnB9POXMJfEej7WfpguHs1zffIHG5Jcozh7UnB3+eQ1575NkVUWbfKivC/lM8/uKh+HAAPQB8cISQvPP2YgxckXpYo61pBpsJDuwLkIEJMVPC6pPgr+fEDllS8+JqDf9crx2s3hPDRguuv1IMpKk4wWRitLzESNctwxoowrczNo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB15806.jpnprd01.prod.outlook.com (2603:1096:405:2bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 16:34:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::87d1:4928:d55:97de%6]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 16:34:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: William Breathitt Gray <wbg@kernel.org>, Li Youhong <dayou5941@163.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin-Gabriel
 Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, Li Youhong
	<liyouhong@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter
 init fails
Thread-Topic: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if counter
 init fails
Thread-Index: AQHdaUQVMKdks6J/dkie/1eCJR5kdLcX10iAgAAAe4A=
Date: Sat, 31 Oct 2026 16:34:32 +0000
Message-ID:
 <TY3PR01MB1134606C5DE0411FDACBF0001866C2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20261031142813.2522444-1-dayou5941@163.com>
 <20261031162853.3635249-1-wbg@kernel.org>
In-Reply-To: <20261031162853.3635249-1-wbg@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB15806:EE_
x-ms-office365-filtering-correlation-id: 0e072939-f5ff-4bb8-c37a-08df376cd7a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|22082099003|18002099003|38070700021|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261022075727099003|261009223027099003|261028144727099003;
x-microsoft-antispam-message-info:
 KD3Iv3dnuSZHTcmwWqkJw+v3OORS7HYfcxr4f7FddVFFnhS8ajYt+uLtWS8kJFE3JslBfyg0zuUnl8zhXw/pWZYiYpG0Mo648CdHsILI/sTDiK9U2TkA2a64nWDsdrf9KQqd9dZagc7D6XlxLa/mOc5QdbgWiWA+bs1gtdB5h3LR8xjRUfxgs4v5QE6VDWTq6507iGSjSsru059Q+4vRxrdhYWduKDS/l5r/gzs5XyyQhAC1qFY2U04rV5bBSVsZ1dFTgy87CbUr9Vdic9CBLRCD/CjrskPiK/7v1PzLuWP0ryST0KK5TyfZcJoQmut4cQAx5R6jTRChmonKoNWT5ejns9PTS2geRjHCO4lXonuKcpQXXPzwTgIpxIX5aSc/2N7EjbopeObY+Ot+T2QFT2muKOGEdP/e6ff5VMTNuTBeoWlfas3dokHgATVGG8DSmIh5OIOG6eD/LBvBk7A1f9GW1PgVeDuqJ/ks+y6lJm3DtPgkHRJSbpL/uGheymYCH1ORdTfYsviY50AKLGD1pDY095dD/jP7uEu/zBfi/oWlHL1LjTdwH99Vh1wJcofxZeUtkUk3MRclUfZI65gMFNg3B+QqS9NvyYDa6l73+/5TQI0gpQLyy/QrpxU1iOtvZXqrUZJ5gY6FU+a41JREd4BmCLCbkdPODotu066HXZk3zablAkiEGQfEgyAAsJ2a
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s1LYLoODcUTboTSiLaf4ndkVcuL9GsrkS9Jb2Lh92UrW2Nu1g4vAFtgZ16wo?=
 =?us-ascii?Q?71Zl1/nujnJtCQNV8nWkcuaMUg8CT4Ya0eSJAkqaLLxJV4/wOBVJ7WAKGOxR?=
 =?us-ascii?Q?UM1q86eUkKjGWL2mHxYyg6P+RE54h+jTJrzJqzx+ny+1CKnEvp3gSBKM3sTO?=
 =?us-ascii?Q?97+yg9tAbrUqBYu5lba5BMkIiHdtaj+89gYPlwkgiG4G/auznIwezeXWIbcA?=
 =?us-ascii?Q?9Kv4zPLdKsSvksA74v2pxpJwD7ZHfVmoeumT6zeM9tBR3L2FRRmZGXO7p6n5?=
 =?us-ascii?Q?g+5TAM2hMribIblpQcdQPJiJQGViNI1UqVkCHZG8hgL1TDBKVghRobhZB2W3?=
 =?us-ascii?Q?55N1yA1kAZRUUdk/O82iR7VORguUrX7zHpcahrGstDSrXiaRo87jm3lRFRO7?=
 =?us-ascii?Q?z40NRE4/DrZBK1HHjLN6hztQKF9RVrOIqnlcjb/eTGszYFa6m4KSSe9W3IO1?=
 =?us-ascii?Q?ViYFOpsNsurtevUA4z0Nz4deOfKWc3a67VVMgZkAVnaFDTQlpBRSa9rlhvUg?=
 =?us-ascii?Q?3T/PVcEhMVq/4FPwX6K78QLvbYSrUUos5H0ykbMVwnH2Q1VkIe+AR7xs4YFE?=
 =?us-ascii?Q?wpriOtVQlukfjLU6r+aRBKzhbIv44FwR4VTAfHIslkF5MVFc+hf3Tr7K1S44?=
 =?us-ascii?Q?qeGq04mkbRiZN1r8CCk05MxZtK6F1558wK7OqGjaraxdOZQeJX1M8m6dyhrK?=
 =?us-ascii?Q?ViSU3ZVVyas0iwbSF51gjvuyXQwwFPAmVhB8xRtXwhi0QrTIx5bjWTQzdmUp?=
 =?us-ascii?Q?iX68gzCYrE9yUBgp7VBHhP6P1e/ZeUxo3+FaL4T0hu4IGe/YbBnj2Y//zt6H?=
 =?us-ascii?Q?bJL1Bqnm5BfjVkHWk3IqWuCBLYoviMFt4UZvqPPNWhVVmPM1Mi/MOPZ0mhBW?=
 =?us-ascii?Q?d4hRjt2yeBkbcFEP2/oD+twwju9rzm+E8++oh85HgswYEed+VWQUPQi/Kc1W?=
 =?us-ascii?Q?A88MKEHOQoArdS6zK69kxXUYWLGX8WniQbS5WLje4dTH4zvRG08WEfcUFmdA?=
 =?us-ascii?Q?UnM2PAmXGsBnZRy2LQRzAwT+JtsByWf1Q5baQa/fFq9l2SKjaOneHFoQXXeJ?=
 =?us-ascii?Q?Evz6ubLt1jlNkth3cwyXqTgGPzr/+Sf5RolpRrCtSJle4HGSMtX8fdRh7EpC?=
 =?us-ascii?Q?GUYAlV8ywXbgqlAyTmt6z79OTsSXxMjtdREcFARLDu7kZ344bt7Z1aACmzH9?=
 =?us-ascii?Q?NfCqqOofcK6i1a2RJGBJRLIhhpx/aQaIrJ6RxqgSZot04vO0p59a8fREwXyK?=
 =?us-ascii?Q?Udn81PxJlt6i8IYn+TUFW0p6oSHhddaX6iCJc5GyB+0t6l8nO7cGEo8PL+w3?=
 =?us-ascii?Q?oJbRgg6V8mc0W1K9rDm7k1OgBDuwSZko461iikODpWiqbZwy4Wq68mLY36GB?=
 =?us-ascii?Q?EO6cqPp4Qm7GFVFNbNOkK/Lji8DLTvF2sbGPRHPFbSbydoitSfVjR55YW37J?=
 =?us-ascii?Q?YebclQ1irSOsY33S28H4MQ0xGDKXIctvjZMNHWu5MnvO56561GZrgfB5yRLO?=
 =?us-ascii?Q?1NF3mwJYLqBy+vf6fVprSBPipWCw+FGUpgrgBdUk6Ym5iPHgLJ9MzUD8zsO2?=
 =?us-ascii?Q?KWunzMPmbRf7NChx6BZG472bEDpom6a2+QVwjU/vj3eA4An1apxyKpJAECKI?=
 =?us-ascii?Q?CFqZt14Zm4zFv1QiHG/wmZChMA+Y1/82ylt72GqD1R7paPALKDT/GKkjbGso?=
 =?us-ascii?Q?1WSYrobFdBfe/+XpTLAKIXADBLiQiijeNSldgWyduyYzxYv28qZH2ZR7kTeD?=
 =?us-ascii?Q?Td6rfojmmQ=3D=3D?=
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
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e072939-f5ff-4bb8-c37a-08df376cd7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2026 16:34:32.3077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dd+eCKgWkKHFfZBKgsHKpGn7jjL+6Rzu2k3qLAoSrmxRIIVpJqY4lYYuFn/xSmQz1Gc72henkNDFsohQ+sZI7BnU9+RokNQu7YUOQqgb5oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15806

Hi William Breathitt Gray,

Thanks for the feedback.

> -----Original Message-----
> From: William Breathitt Gray <wbg@kernel.org>
> Sent: 31 October 2026 16:29
> Subject: Re: [PATCH v2] counter: rz-mtu3-cnt: put runtime PM ref if count=
er init fails
>=20
> On Sat, Oct 31, 2026 at 10:28:13PM +0800, Li Youhong wrote:
> > From: Li Youhong <liyouhong@kylinos.cn>
> >
> > Counter enable takes a runtime PM reference before initialization but
> > only puts it on disable. Drop the reference if initialization fails.
> >
> > Fixes: 0be8907359df ("counter: Add Renesas RZ/G2L MTU3a counter
> > driver")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> > Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> > ---
> > v2:
> > - Add Cc: stable@vger.kernel.org.
> > - v1:
> > https://lore.kernel.org/all/20261008020506.211566-1-dayou5941@163.com/
> >
> >  drivers/counter/rz-mtu3-cnt.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/counter/rz-mtu3-cnt.c
> > b/drivers/counter/rz-mtu3-cnt.c index 7bfb6979193c..61fbeb122851
> > 100644
> > --- a/drivers/counter/rz-mtu3-cnt.c
> > +++ b/drivers/counter/rz-mtu3-cnt.c
> > @@ -506,8 +506,11 @@ static int rz_mtu3_count_enable_write(struct count=
er_device *counter,
> >  	if (enable) {
> >  		pm_runtime_get_sync(counter->parent);
> >  		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> > -		if (ret =3D=3D 0)
> > -			priv->count_is_enabled[count->id] =3D true;
> > +		if (ret < 0) {
> > +			pm_runtime_put(counter->parent);
> > +			goto exit;
> > +		}
> > +		priv->count_is_enabled[count->id] =3D true;
> >  	} else {
> >  		rz_mtu3_terminate_counter(counter, count->id);
> >  		priv->count_is_enabled[count->id] =3D false;
> > --
> > 2.25.1
> >
>=20
> This patch seems similar to another we're considering for ti-eqep.[^1] In=
 that patch, runtime PM is
> managed via devm which allows us to remove the explicit PM unwind on fail=
ures and have them implicitly
> handled when the device resource is released. Should we use the same appr=
oach for rz-mtu-cnt?

Here we save power, clock is turned on/off during counter enable/disable.
On TI case, they enable it during the probe which unnecessarily waste power=
.
Even disable case, the clock is on.

Cheers,
Biju
