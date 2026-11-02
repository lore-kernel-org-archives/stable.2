Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793631343;
	b=f+yzW3wP9GuAJgq9VrI1vkMQSSkgbX+IiP/Cj52zOQC3socPUZ16AOtH9iYiA+a8hS8O
	 ZuAHekP4OJzgTL4GPyzvJtjhMuzKQ44L0TpMJTTYngMlFB2dd1VCNulS+5FC2eJfiJHZv
	 CxKMS+9ApKe3VhlvrAN05mcyNlH6o1pdO+cxK4ONqWdw7sAb+gktShhr5k5fXiSRh00W5
	 uJ1X4WnNfedHtspWupPKTDjT+ZKk+fgwJDgRpgwEOuIXsKJJiOIoc21bYiXKOkWD3xn6t
	 swTL5iPbXDBmabHfnzWjWRURwvAfnzS4O6jSJT2HRro4kU89jVkEkFpDriafV2qLX6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631343;
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
	bh=6cYbllMUUgcOteK9sBqEuzu1jAECqJY26reSHUnh4ks=;
	b=aw3+8gOxuZ5FwMpEzgnt6ioyCqof6h8JS4lHvpB8xfjAHLd1A24k+RnmjgaDwXdqZnfi
	 BFr4l660JCyiXTMrku+Q7CImnBjUf4PuN/ShC8KJL40KKKFAvShu5882upbBLsKt7BXCQ
	 EaQddnlNbA+hjey0i4jHgGiFZZCifiINqM2qDuXHzIZxWrEThAtI4kX6mjoDMk+N9K/eO
	 8KbPianD9VV5jYJkqCFBf9Rzs61lUgnlmvivNLFfxdqNWRongc/qWB5kNu18BPsunlWZH
	 5Jv1P/USLgYBTTtXpPyXsMuek1yG7M1MesPu70Yf+6Ktj0yXmW0aSB3zNZTDA12d3lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aweta.nl;
	spf=pass smtp.mailfrom=aweta.nl;
	dkim=pass header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=FVkQcku1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.75
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023075.outbound.protection.outlook.com [52.101.83.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3787607BDC7;
	Mon,  2 Nov 2026 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3787607BDC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aweta.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aweta.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aweta.nl header.i=@aweta.nl header.a=rsa-sha256 header.s=selector1 header.b=FVkQcku1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7VwS+tcxVum3r5zvqLMWp9Ydh9qyXTzCl3gLb2Thq3lHW/cW+FoL0lQVhzMy9wq4pxM6zoaL5ec60WtxfK1Tb39ZacjOIv6nGdNlVzF+/xDAOLrQo8OaejQMEm1YWgr1gwm9eP+p1u+RtChhpyXFTHIuCSMyDVxvuOcEY4tnI25OBEHiEYyFVmkX44/lTxoqiYXomCnGPIzc02xsdMQ7J61evJpiruLfenTXX6gYRXUUE7BPSZlLGC270tQRaEP9FPwxx6mVHetJkDoYLiVLH8h0X2U806w64js09gMqdoHJFlfoDK5zpqLK0/VoK6jA8ddhzMboiiGGoJmkH0ZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cYbllMUUgcOteK9sBqEuzu1jAECqJY26reSHUnh4ks=;
 b=j0BtxbJPsPOoORAdOW/4f4gaZJEkzGr1QDuM1zvOhUf2HdXSk2b5L5jKiKp9qtsen2Zpz+1uM9hVdMKzqijfM4i/2lsUyPtTdPWCp94U78R1RQyJ4nz9x2+tU2c+B9JcIUqscKlLR9q/KitEQJauKacC9EqRuQDNOBeslicV9qD+fAkjpjaLcSs8yF4mG5Gp/p2jUR0PGycbuufjXpqiL5BL89Qii/iFV4NZE9gLfEBbQSARncrgYoWCPf1aD9NblxZU/ONjfwxvNijVak8MAZ0xpMUiD75iVuq3swzQLh+iPSr1cp0kyRqXBywH9KMVy1FWjZGcZZO2AHfuq3+Yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aweta.nl; dmarc=pass action=none header.from=aweta.nl;
 dkim=pass header.d=aweta.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aweta.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cYbllMUUgcOteK9sBqEuzu1jAECqJY26reSHUnh4ks=;
 b=FVkQcku1ZiaOCM00sVyyT69ptKbijcanJ0/ohnwKZJBn0p8Muu263bfcOmCLwlUxgN2Lvs5nercZiRGkaaJ/JO94dkDycNwZEZBD7JXvIiHtzQqXTiZ02wgCKumWE2naj+omEP6U4GESKl5C4cZLQ+lLAB5isAet+Q4OqTMWxeFDVETsE60cAQagTinR+RyJ1jyZ60YKzYgEHlt+PoX5WA7T9k6Gi88P/1IUtc5ePWpfrrV+HeTc99O+fhuRT7gk3sQqw7g7sNtt1Zlsn2NaPGF8DCSX4oTZMQNYstRL2qTrnRaaF4WUQR0i29nyC1zZMrDaQlM4PTUvsSzTD/o+Mw==
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 (2603:10a6:20b:67d::13) by PA6PR05MB12150.eurprd05.prod.outlook.com
 (2603:10a6:102:51c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:55:36 +0000
Received: from AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492]) by AS5PR05MB11020.eurprd05.prod.outlook.com
 ([fe80::2dc4:6bec:d87e:3492%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:55:35 +0000
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
 Kanzenbach <kurt@linutronix.de>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Paul Moses <p@1g4.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Alexander Nowlin
	<alexander.nowlin@intel.com>
Subject: RE: [PATCH net v4 0/2] igb: only strip the Rx timestamp header from
 the first buffer of a frame
Thread-Topic: [PATCH net v4 0/2] igb: only strip the Rx timestamp header from
 the first buffer of a frame
Thread-Index: AQHdaren9ySRdxgK9kWBZLyUEZubm7caxseAgAAXPZA=
Date: Mon, 2 Nov 2026 14:55:35 +0000
Message-ID:
 <AS5PR05MB11020E486E4254724CA5F99ADB96A2@AS5PR05MB11020.eurprd05.prod.outlook.com>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
 <auiQF5ZxaBDza8xq@boxer>
In-Reply-To: <auiQF5ZxaBDza8xq@boxer>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aweta.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR05MB11020:EE_|PA6PR05MB12150:EE_
x-ms-office365-filtering-correlation-id: 12ca948d-08e0-4789-9bfd-08df38f15a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|10067099003|56012099006|261102123227099002|261009223027099003|261022105027099003|261021121427099003|5023799004|4143699003|38070700021|261028144727099003|261026140227099003|261026121527099003;
x-microsoft-antispam-message-info:
 BjDYsey88Cwdu7emq7/wVdwC0yNyt32ayvrnrAAlNhVuEFTqyRZVUKfjkrzfgwi5X4FAnBCtPR1e2gBeMI8jaPWmYrE/ZhSLEbdyTrrjY51r87tIvKsN85do54QXtG+MXl+A8GWt2XvlNEMK5cnLCRZvd5rDgfjzmfb/8Oc3Efo74nWO+9tLcnYMzzfwkisF2aJYuzYOWhhThGOudPXmUSmH7+OXgIc8tOZNY6QTlQytz5BY3KNdUjbjFKuXKbiH7Cu8M/2llHX7mINl74v/rFPzveYOSboPTLsRpLl7PRhFVT78iV+zkiJddm3htQYCg3y6esi4+WjDV1QQlZbsBE4+X0nizzup+BmbXgmgWRQoofmHPrXDe+O+8Dgco0OwBAz0N0V/jn/tVEMuc4jpWIXFx28MjScCct4R7Sgxad9d4S/ERj//LlMzaGeUp3i41nqF4OqXcThpUFTbkeMPSg6uPRP10b+6mNg8V6fT2nSls8uiecUldEW6MMlL4E6ptxafhoA9PoNk74qv9RLNyVImRGFHvAUqFyPurCMEyxpLL6fQ1XzrB4nqZteGn9hfg/KF7VA0BcN8OeqqXMqYHkL3B9M1pb6mxr9Hi6rt0N6Q3hxljK7MYS4audYPqlVewRDwCC4VP8TjORzWeL3Qwy7X+XPad4IVjMum7ntgZJDfsQWyMpcZW1SDpjnvhNraxXwwnJfsZTQv6ty0s/RWpgOkUpbHTnn7GwmBT3YaJTw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR05MB11020.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099002)(261009223027099003)(261022105027099003)(261021121427099003)(5023799004)(4143699003)(38070700021)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?e4Ea6zxmt4XnWPn/ZczTmfv3muLcL1EcRptVQPX3HlSNnCPiPyLtdbjJEQ8b?=
 =?us-ascii?Q?sIlVc+l/WDUbxpAVxZAnJuX+k6OQ4GG2gXP0VEyznf8c1K+mUcJW5f8rJaK2?=
 =?us-ascii?Q?kqEEZV7N5UP2aSZaqvULn2idVjI0gyIOZiwg0NhDvLGF7Wr7Wi/qbTV3JLzE?=
 =?us-ascii?Q?qlR6TRis0sK8Yz0hMQzAnKr3rfMJKIaLuws3v49ofR/lu9Y8bNwZh4Wnrb5U?=
 =?us-ascii?Q?rXIrTYEK0nfFJMjKucCK8SE2QYHdbdWLw0tYTR4d//TTHPUNKfZiVTzK6+74?=
 =?us-ascii?Q?2Mr8BbKYsemgHwNewDdou93kRRBil4xiu+OWI+g3q16USZvqKJB9lF4+VrIj?=
 =?us-ascii?Q?mc35Azrk9/9KBCcj341wUZrccJWGhHc8St+KXDJPpzmFPQMDRC7bmvf58Ykn?=
 =?us-ascii?Q?eXDcLtZkrpkOZql9WgneZy+8NgV9NBvmfNF4aiDZ7iGcA4//WsWy4uAJYGDa?=
 =?us-ascii?Q?t+pJezv2iNv2Sg91DsNXwJm+mp4fcgPpLsUk4ESlMeHM1AQL0fq6P21BSC63?=
 =?us-ascii?Q?cISImD+gn+Z1kbgx9KsqVWNiuEGRCjTHG9lq4suW5tKvvBrEUbPgnDm+u+4l?=
 =?us-ascii?Q?4Kc32HNXSNqR/Ng/p3wh2LHmwZdNE1R8VUOKV7Y2wxQPHU27NMRm9pTxe1Ja?=
 =?us-ascii?Q?nccnOrQOn36qXYz7/+gJIgkKvs+K5cNlfJM4IQ5pM2Y+77V0D24G3sVjcARs?=
 =?us-ascii?Q?vGyynL7JdG77Kww3Eo019jsrr4yiv9ZgPhzUleoV+Dwbt/MtzAcpe5290K3K?=
 =?us-ascii?Q?GELRlVeN3uMmJWqYwEDZtjl9rX5CWJBBWyMCXFNT5eXyd3oc9598hd+UvhF8?=
 =?us-ascii?Q?ZiYX/QUNwtZmQupsoaq1s4YJLGI+a8hXBPC/6yRLPGBFPgyIxqh5ddmP5kfw?=
 =?us-ascii?Q?3rwt9jovP1vOI3h/tc5e3Zwe6w1cHL7gM88MKfhaiY9K4Bb97wkOByak1rOl?=
 =?us-ascii?Q?nAnBu6PG/mSDTC10idTQN9pC9EGvAffpa7zc7sWI1ncESXij4mpsky38aKZN?=
 =?us-ascii?Q?KvGwSxugM4XJJZPBUMLStpycfq3T8mCQxxo5hvRzs7JF5DCGVothPwUON3/I?=
 =?us-ascii?Q?3GHUrp+PMDksDElbFKXpkC08az2q4PJH4EJc3Ru/EzHmwtZXkRMtrcfVuWiz?=
 =?us-ascii?Q?zEGcYVmBCJzHAl6peXixM1VomYCAwDm9uUZP2LQbflKHnBbcnBrggNfcABTB?=
 =?us-ascii?Q?xrUFiSMXz1a+Ek1Iipr19uqhTL3bMlOZ0QzFftXYh37z+cBNnmlFzw5Dl+Lp?=
 =?us-ascii?Q?ANAAHQmDMzoW+Th06UDfBIXQ3CnlcJC+sFRQ+UxtgrH7ePW/zfWway5ydEzj?=
 =?us-ascii?Q?80YnSvQWclSiezFWfzSAynYo/KKki7q8Db/st7w+EaRSCI1leVq9uJjIcdbv?=
 =?us-ascii?Q?kf3gVhlpQHAZcClHyk0oFFE0RjMFKl6+3CzE1AOSy7Gt8YLXj9k48PeFfpfF?=
 =?us-ascii?Q?P+TBUAd7HEnY6IxDhm1gE/NrvtlFlp8Y2pdNzShueEqy5CzP5owTXARAYbYh?=
 =?us-ascii?Q?D9kqrYpkjfXe/2XD+t0piWEl4O5jBGGfA3dqNASElaXsHyVAZ2nDIUakKpPh?=
 =?us-ascii?Q?FiXZcS7I5OTQGYKLUdzV8rV8GYYmmyCY1Dy/DC333GM5y3JK3b6GNm8giPpr?=
 =?us-ascii?Q?GTKePg9gW1zUfcU14XU/hmefraRYy/KtDadCUy/EqTuooOn7IJflUTvZ8fdY?=
 =?us-ascii?Q?RvgDXRJzerU+ocjFftY0f9SOdu+jKml2DwBQXJHS0jqW+ZFM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ca948d-08e0-4789-9bfd-08df38f15a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 14:55:35.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6546512a-ba20-41bf-9d8d-c076dcbf6fd9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S3JIPMqcoqE15nDFc2r+IWCJEs+a2pzLi2nxgcrj1Y+GxupxtpkDra+0nWPrdu2Sx02De6pgMKomyNigjzA8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR05MB12150

> Not addressed here: the AF_XDP zero-copy Rx path.
> igb_clean_rx_irq_zc() has the same unguarded strip, and with 2 KiB
> UMEM chunks the hardware buffer is rounded down to 1 KiB, so frames
> span descriptors there. The igc counterpart is Maciej's buffer-size
> patch in [2]. I do not use AF_XDP and cannot test it, so I would
> prefer to leave that to someone who can.

> I assume review bots will give you a hard time if you don't address
> this within your series. Seems you have HW handy plus you do use LLM
> so I don't see why you couldn't ask it to address AF_XDP zc rx ?
>
> FWIW blessed user space tool has always been xdpsock:
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
>
> so you can ask llm to run this in rxdrop mode on receiver side and
> feed it with some traffic from peer side and then see that frames
> were not fragmented.


OK, fair point. I will look into it, and I will hold v5 until that is done =
and tested.

Thanks,
Tjerk
