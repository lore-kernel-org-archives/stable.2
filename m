Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.162
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795415092;
	b=D9VC+7ufxt2y3a+oMbjnuOvI2SKTGWLEiQVmx9AIX3bgoqzw+ICEloyUeJDMwUuZayyp
	 Cr3DEtqwnsEW87Q2YUYsKPmocRypax4otvtA+NCsKlNdQ/VdfvBET9rEsy2hs8NdqG40m
	 IO6tj8wh3JxLkf4mAIzy2pSE1O/MF1CoXYAW5+iuYxvx2IFJBo2cLcOb4C+3LxPrqi/10
	 79OBDCkil52Q2tSqQauAk8UwY0sxVRvFv7bU4T/J8hFg1JmZsPFAdKJrs2hykmg8Ha+Pg
	 WJuGXrV1XA9FcCc+EsC8/mAGDyPrjlIymGt+GMjw1XmSvjYXiS1sE9tyjNz9dStTRyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415092;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-TM-AS-ERS:
	 X-TMASE-Version:X-TMASE-Result:X-TMASE-MatchedRID:X-TMASE-XGENCLOUD:
	 X-TM-Addin-Auth:X-TM-Addin-ProductCode:X-TM-Deliver-Signature;
	bh=BZ6oliUixV0SAsCwBG6XEJcJGeY3VQwl4WJAollmmtg=;
	b=e9nujj1y0zf/NaheBTNwpZQamrhztOxcmrDjbachjj7VrUicXbQQ6kGF+Es87QzH733b
	 A0ih4SOld49UAXhUAGANj9BDpI3mSQr4/2I6LNQ6hErih915PWRtkHqghjzRrCCSWUP7q
	 ievDdgoAYTxkYxIYuXjXVti487RlqtCSwMKhv5e5d6/B0jqEmTa6/YtIQdQGdtRt/kJor
	 lMpM5RMWlNI5TKDE6xfQEEc9EAUC4X9pLr9hXig6yXb/2Dj3QXPVLE5hgVR1QmVvIjVsm
	 0hEUQf2njwqpTg5j6lrJSB+eNHAjc9ww6u+s1HE1fbqLxshzvYgNB2jTN/zjOM5njPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=electrifex.com;
	spf=pass smtp.mailfrom=electrifex.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.162
Received: from repost.tmes-in.trendmicro.com (repost.tmes-in.trendmicro.com [3.110.59.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC597606A330
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC597606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electrifex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrifex.com
Received: from 52.101.227.111_.trendmicro.com (unknown [172.26.46.176])
	by repost.tmes-in.trendmicro.com (Postfix) with SMTP id 21D74C000903;
	Mon, 23 Nov 2026 06:24:44 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1795415077.288000
X-TM-MAIL-UUID: e8e7237e-0005-4ac1-8c50-79e43d9575db
Received: from MA0PR01CU009.outbound.protection.outlook.com (unknown [52.101.227.111])
	by repre.tmes-in.trendmicro.com (Trend Micro Email Security) with ESMTPS id 46758C00043A;
	Mon, 23 Nov 2026 06:24:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYR07eSNDg9kEf/Qv2YHc7Qq5+DgFY0OAcUlJmcik5tErtgFhZrdRqi6OVuiQ/murLMqLvVwPkR0Eg5/pmlTsiH3Phn+8HaZcuFPWuaN4uHijmzu4IEVUkAZGpQYWs9/VoIIsIz1AXt5Vl20hPXYVD2sPo8Om1LvTEk+clBXFFJKsUlYLFwSFToDtesNe9O7b03KkeynW7nWyEe7vdPTR52t5qF97103VtFSpBizIv68jxmW4KPehnCyHNRCuobQg3jIv2+WhJdioqEpZVaYtTGXiH1uSRBTegimK3B9PZvlR3zqbkUPFjYVbFhhUawuDldlUte+tOY8/O3LGy8M/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ6oliUixV0SAsCwBG6XEJcJGeY3VQwl4WJAollmmtg=;
 b=kPFOTxf4sPUoHQinuAYDs7Lo3rJaOaHYBHQ+sUtmCzOXxonp/7aKH8BJXxIlWzohicSg+JhzZtQ5hWT9Owa8p/mFisi0Q15mR9ylzE273CDNk17fthMKpisLMxXNDOCWwOQJsTc2BWFNjMuB9ml6WS1DVz5V89Fx1E1epM4e5K9MJI74/6ElLXNFE4iikznCVeVQblPSJjEwlAbn4cA8zslk2el00hDmsXKU6E6dE/Kfgx7HS7OvjpVoj3AfSY0Y01J6G8Dp383KUjWZE5rl+CMIhn5hfEkHD2NUSh64rJCV9+00jRZBsXiz3a6uBqkiidT1xDRLMx0CSOhSZMvq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrifex.com; dmarc=pass action=none
 header.from=electrifex.com; dkim=pass header.d=electrifex.com; arc=none
Received: from MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:cc::6)
 by MA5PR01MB11543.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:191::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 06:24:34 +0000
Received: from MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c284:c893:95b6:d2a3]) by MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c284:c893:95b6:d2a3%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 06:24:34 +0000
From: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
To: Nicolai Buchwitz <nb@tipi-net.de>, Sam Edwards <cfsworks@gmail.com>
CC: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
Thread-Topic: [PATCH net] net: stmmac: retry a failed RX refill from a timer
Thread-Index:
 AQHdeMHkOZtbzcYqfk6xISx5T/okILc6ZWWAgAAmzYCAAAvdgIAAAgAAgAAG9oCAAAsJgIAAhUB6
Date: Mon, 23 Nov 2026 06:24:34 +0000
Message-ID:
 <MA0PR01MB9217DD52BC2BBA76A2850C07FD452@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
References:
 <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
 <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
 <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com>
 <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
 <CAH5Ym4ijMNSAWZ8k3GmwOoLDBVTy32B1uhS_fE-dGhsPkgozeQ@mail.gmail.com>
 <8e7b5bd372934d85ff890a6da7ca93b8@tipi-net.de>
In-Reply-To: <8e7b5bd372934d85ff890a6da7ca93b8@tipi-net.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrifex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB9217:EE_|MA5PR01MB11543:EE_
x-ms-office365-filtering-correlation-id: e47d7a90-4b97-4948-2c5b-08df492a713d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|4143699003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|261021135927099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 l6J5mWOI60PtEdR7mMcHCLXE1/oQqYl1AYovoLtOCpyTNYqPZOWZq+yRhOfZKwoWlTsLSMhDeMYoKXg0JPHko49l8rPkUXBUd6D20hbYcuSRhwdfr3SV4QfqYgbsamt39LrwUIwVx0TVPLgZOegJh+7vI3HirE0XPCdRAOuJPGQnjnvfzuVDj5SZrXj4BBdiOOw3bxOoDBnPmUmkK4gTiPc6xJuxLlQ0r5mvW6tCYjskRnMrGX97p0EGu0fZMfbig2WwHK7MZw1ObkPInosHP7D7Lqy/SRTb0/vsYxLnGuS3oJCtOchB/wi4wNeliQU8znlgByPde7htWYtCihA32YuwltQa5+SonCSQdpLA2CW3gXlgeGg7YmLCWVG6iLvz8AIbKPc+nK9K4drnwB0kADtfPttIax7rUgfbTyG77LdU4kRZD77tFUV+IEi11zACtosjIEwL//KMlN578EMx7v1cVWygt84wr0Q4kkBdpyNw0l3njOGOHnS7Ym9eIu0ljX0sfIXR7v3KcQipjkTMy26JWNVQrHkKEPL6ETI8r/q0TGistSzxYSyd0M2WSj5R3aO7IHHe+SFIhB+Of+7WoCsVqX5sL/+gYxK2m6/Ym+WNC6HwVAdidxpQN1s995+ia+/OiFDjf56164TcknYnOC3xiB7NQVcLhgBvETldsc+s8yDiZ9wBwVmSj3jM9MsWU6CVx19jfDj2oDZ5/60EXoJFEbyZpkYqyRFqivDC/XQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261021135927099003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Rw0jeK/SV5KMYQbLPPi6Blk9WjXwZ2a9/I0rm6TKEUOGDnKbkpXjMZG1xF?=
 =?iso-8859-1?Q?6nn+PIXmaLYeAYx6Z+lAe/nT45LZuwgmLnj3Xxk3KElphqeasubALguj1X?=
 =?iso-8859-1?Q?6Akv0zO/Q3p0WKcJVihcTBjxhPMKquuMft9nscJoFcTepV3Lg+KdYlYrGH?=
 =?iso-8859-1?Q?mmBVXWs7MW1qd39Onm98h0HMf00MYQdOE9ErrXh45gaDEsd3ayYQmHMnM/?=
 =?iso-8859-1?Q?ftWIAHNeb5spYyajjZ+nXQWoCG58/6vnnouQZjpsXz5EOdVh/6XFTBmcai?=
 =?iso-8859-1?Q?TWwwp5W360cPPznsnqJcKpjoaFMxJXyx33m5CiP4INkjWtfYAKh2c/D2ST?=
 =?iso-8859-1?Q?9Q2P5/37qQTkfQZjWS1Q4FzLQ5J2eN/FbxF+FjkyDTOjbWgv9xqPRkda+8?=
 =?iso-8859-1?Q?gNgPNoZ3jJ1GNhchDVGcimXuk1m1rwgzjyAGtPGnTM/cO/gDHTQryna8lB?=
 =?iso-8859-1?Q?qyNH6HE8Y3onfzBf+/RyozX1jLGrqSRJfhs5eaaaZkKpzNDdK1xUt13dJE?=
 =?iso-8859-1?Q?AbZ1aIQ+7P4Wl1WBKQeBCVN8NCjYt0mz2jmgGf/eRzbY1sHPMsicoh59qo?=
 =?iso-8859-1?Q?6/JwgntimPBP1nFiRHMY8jo4rcHXMvJ/F65cWQlA9990wZve+0+EdS7IK2?=
 =?iso-8859-1?Q?HNz6ndr6JnYlUo/0YfvvViqSfP2VLaOjzFAHqBVtccVXUWSEBXFmGqjP4K?=
 =?iso-8859-1?Q?FHJ1LpetTX5nnsy1Pp+ESHXVcwvyqTWLhLqIp+6HHTpOxNBpCX7ZhbLCfQ?=
 =?iso-8859-1?Q?z4OBiXS11AMBYAmquiQ05oDIkQoc9gLsck/nazbBCaKM0S5A+JA3Ns4S2O?=
 =?iso-8859-1?Q?oZFQr7wgpSPs4XYl8cWtQjsyjsEo89hsiXA1VoNytpGhp379pmdWAzDL16?=
 =?iso-8859-1?Q?t2+wJygxwkfUkoZlxtznDp+f0Xa+qwpUac9yUiCKzrBniVD8Fby9Nv/03a?=
 =?iso-8859-1?Q?y/ppxzPK6S8jioVjgfOCqSUHaZ8sLSCvrDzhPC/EzrR/2OlZEGbAkzIcOo?=
 =?iso-8859-1?Q?m5aK6x8bQQEqc9Jj88P6/bmfvXPIshRDZQsjNMK9Lh8/t+DXuL78tv/S/+?=
 =?iso-8859-1?Q?XUXWPjl3q646MxhJ6yBHRpZvLjHvjj1xnWtnFUO5mfSvqn8sIBL3WONoKD?=
 =?iso-8859-1?Q?fafRLXMcwH5k6blmp3arUcuDq+VKaW8mDf0nq/uytm+CKOL+Z/DEUCBuyS?=
 =?iso-8859-1?Q?ztAb/GTUFqT37QFSLPAyTXof6cRomKXVBGdSeKfjs8YC4ai/wD3JmfX5el?=
 =?iso-8859-1?Q?r8OiQ6dmkA1Pmy8jc5dlqYgmaYQDEM63PkWv14NumMeI0g8IzU+RtQ6lUk?=
 =?iso-8859-1?Q?B8KiI0rAHCuTdrujuURaGibcB5NTJ6QQKOEsroUn61OjUWP5Iai6InIEQx?=
 =?iso-8859-1?Q?9OxuiTjGdXOU/paW4NzC4l3AlAfw6EvTpkd2w4n8bDL3rhTo1+JDjztKgA?=
 =?iso-8859-1?Q?tN1AhC5ls1adLV+mai3OI/3xdoxLqMf1iRIqU2vIzOlK1AuRkq3HKnW4dF?=
 =?iso-8859-1?Q?gE3tU6jRnbakb9wLT1HT73Zqnsl8/k40n+bxejmd6pAV2N2WuRkgP0/nWe?=
 =?iso-8859-1?Q?8Y1S8LsHd46URCWr7bQf6XurDlAw5RlLR1d1inSU6yMuasUoTHa2qN9pCk?=
 =?iso-8859-1?Q?jvrG5fQMkLGSf1N1Jf+XCPffm3prZdZtXdzbYIw5eSLMzXZTK4rhaLdo4S?=
 =?iso-8859-1?Q?bpnlouSfttU7VYQjEz6FsCJlNGqVrz7Js95eOWXIpiMKJkA7Qm21k8YOZt?=
 =?iso-8859-1?Q?RiRcey2dGydk+I9jRkorK2N4BastQ5ixBbID2EQkLmDe7/rtLoDjuZpovX?=
 =?iso-8859-1?Q?54w9nB5g6FuLOBPG/dOLMOvTZbtuVWE=3D?=
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
X-Exchange-RoutingPolicyChecked:
	GnQhXOy69Iq0iGVcHXoC9oUXwHruYqepTsJZyBF7WoSFZE+cPsJ5+aKxByQTAn5TzqNmfjr/Oppb2iJVQpRVXcUJaetxbgClmgeMXB6pdW/Gdpe7XdXU5uo68/0mwcrqvZPSGBvKVhhmzbgu+qe4hmGuXHp71YZi1taYRFeSgvLomKKcHlPDOt6Z8AIyV/IKNb6x//t6K9P99Wlvj84RjNZQnAgoDNGSibLM5NGgWkffRnwg+PXMw59yyEmxalqZvmwJWk/dOGI3Ai3+j4+Z1gsq2cmnBJVqZC0ZInA4Mr5+xzO7RvpAuy1EgYVBDFhn5tli27CdiKQ3GkdVK6rdcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mIEnJdbh/4qnQfAyqP8fDiVvbts+YEaTh1HZcPPutDG4YZCUxj26iSlEFMvfeKgiPbg5UknafHrrSLRZ8G0YWnQhNW887URBlKfCjlWRQMhpGIRUIBverpBtaPQjvK6icUQsLltru7yer1MV48Bsp4edQ8MzWOrX2DvQltFlyypxpKuFqGAhfoAFIzmbx9PKB512XSsP+9T4GCHcl13Uk3k7VsJYJ9xEE4gNzHFN0HyUTQ1Grud7WmVmt9pZD6R3er4taBDoVk9K7oVif1tME1VNc43UbQ3WQBKk+U407BpW+NRSiiCQeAw8o+NHREJ+bIGPNsE03JfnP6wy/NQSt9ynBTLdLKvm8oGhl9EK+WzflKfIWLsNZj4dYepVH35/ERNvc2jLD8cPaItEb3cdwmO7O6PM6jV8zou0V0R+zIZoTF5lwbr40VDX1UUlQxDitc9Y5kk2+iuYSg/M0mcm33Dlldm/BzixYKltSkLbp2UPKcUTDKX0cqsjnUVqD4KHcfcqFzD75ZHBge9hkqF3UBwUZbVFCqha2BCzqAbQ94o2ELC0U1GuCGir8Mb8jCTEBpamcSfzWSNng9JRbLi9Mw9nBijOYIjE33AUOnPMDIM=
X-OriginatorOrg: electrifex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e47d7a90-4b97-4948-2c5b-08df492a713d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 06:24:34.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2626450-e675-4872-bae6-db17376f7643
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8C/axUdz7tzbm6jY+7lqFzf7YgSDYyhrS0u/yaj9e1InbrZCjt267QlgQdAz+7sPQviAbImK9g8LmO0VBkM+uIqiVKNRYw60YdICp5Ap3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB11543
X-TM-AS-ERS: 52.101.227.111-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30338.003
X-TMASE-Result: 10--7.165500-7.000000
X-TMASE-MatchedRID: cgbqQT5W8hexGL7HytXJtJebF50LnN6WYPTa6WeNloiSvJr1J2FitJa3
	RKW0AVDL1NL2fo4hoTGfeQ44jpO9vxSltfX1BoYIm2eUW/oDuiG7F1YQUoOzLFmKcDXoeq/i0VW
	gir8zmNvkms33+H4RdUjuUiscERhBD5teccobfJXjPrMepVb6gtrYBNRNCgeBiZHHs5XulrMd4v
	j2W4IDxTnxJqun3snz5niL7fqNiFsh4WWPHpPFytPOTKJG8yx2S4qOMNAc8KUCi/NeT7+amsr0d
	wCNwj0xftwZ3X11IV0=
X-TMASE-XGENCLOUD: 1a2921f7-783d-4297-bc6b-e204dbad4fdc-0-0-200-0
X-TM-Addin-Auth: IGrwdVGCLaPx4YVtbsJGFo9BXJya8SZ0mIF0oEFrDchk+p4bdl4ehkiM6DW
	cI9oqohuXog1XWJI4YSpo+sJ374XbO89YvuB7lyxD1CZr1SkBw0TsY+6EOQCVm0eMHf+Ljb5buH
	i+S1pVH3RJ6BX+aukGYpeR+bLWCelRHxS+5raoV/k8nE/uxfeCbhrGNgyTvvWSVr+0fMn9/auBC
	sRfrA7A/1pWP2rP/RrxgNyJ1ydN1gYLpNS3cDgV0rxhEBYPJRfFoK9z3WV/rv4/BL4cUnZQ3oy+
	ixCdWMoUhHELkHH97LnW9Vkx+F/5sbJhX2OTROF5pzYiJ7pvt/ebcimcFg==.EM9sULhDfvmngQ
	q62xBSjlssOVKX8sUu/+ZZMVmCiSPnIVs/QH4DVhZLR6vtN1io2B/JqeDMdXgOx5Cga2oeK5O3/
	OG+i/2n5dybHTB3w/ohEE8s/gvo2rhXhY4OvyAmxo5kw9mw3e56OcrhJ0KNS6D5aktoGlbTOng/
	cIA1TOPmF92wPuVEcPWr8VAJYKa8oHGQQJMJzz7INyKh3huBBSeKQFHcfrBUnFkD4PWQO/gvM9G
	yWY/UOCZjvCxHm4R9anbLEw4Z5wyXexLI7Pru8yuYQYEh1znBUNQfTOVYwa0bSP5cdGnEFqHKiv
	psNVteguFzXa4JNMrdzKBBGoShCA==
X-TM-Addin-ProductCode: EMS
X-TM-Deliver-Signature: 5F266C8804A083D498A8021A42DBAFFF

On 22.11.2026 23:14, Nicolai Buchwitz wrote:=0A=
> Agreed, simpler than refill in the loop. If stmmac_rx() stopped at=0A=
> dirty_rx and the refill worked, return the full budget so NAPI polls=0A=
> again.=0A=
>=0A=
> Anandu, could you fold that into v2?=0A=
=0A=
Yes, thanks Nicolai and Sam. v2 will do that, and will also check=0A=
dirty_rx before reading the descriptor status, so a retry does not=0A=
count that frame again (the Medium item from Sashiko). Refill inside=0A=
the loop I'll leave out of this fix.=0A=
=0A=
I'll test it on the SC598 and then post v2.=0A=
=0A=
Regards,=0A=
Anandu=0A=
=0A=
pw-bot: cr=
