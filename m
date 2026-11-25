Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.161
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795587483;
	b=GfQLC1eOkIE3poAIWkBDYC82TAx8zNtPtcS10+g5WOC6M5NJclceu4HcLLrHTb6e4Xbv
	 Kc6+uHfE+gjGpVzdxeD7pryRp7A7eaxFXJX8fuSdsb4yowypzMxirdVj7NYPTlcZJztiK
	 hxzxZlWRqT/757oJeNG4tnYZJ8NmLuQF1vJ6/T0W49aLgG1mA0A06GSDaKFgX8MdRn0WU
	 iAB/6q9zvraUXmlQXU8J5DyIEvCIv0JvT9mufy6drWxpDNScmzyooV+NWMVdBAXf4IMYu
	 zUZUR737Rbs4EJSYQtBG/LZb05uVDf2MnqmpUhJivn5G2iIMBmeU/0spaLHL1tSc2Tw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587483;
	h=DMARC-Filter:Received:X-TM-MAIL-RECEIVED-TIME:X-TM-MAIL-UUID:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
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
	bh=mPrIsOc+gFcEnDri/MDwIDfZHoZXiC74y2N7+kfioM4=;
	b=5VPXirjKySN2y18CN62KT8/+byoYdbWFjvyATU8tR4RK7eAMGVA4Sso71yKDmeDbEPXN
	 KUsVhX4kp1mYBPL4m51XcgnaosdrqT8f7RTsby3ewNenZfeohEesLjWBz9pgrdBEtJIIx
	 UUj3y3PxR9pYLQTnLC5+P4Os9JNovJb1is1/QbJIl5SH3gUd93jOEXhPMWvEjPyjs/yJ8
	 CY6EshPUxzGj97woIygSP/Lv8rVjMbzbfKwsj3pBXPViRW3EH2INCcPJaqeeQeW/PMCJl
	 YtSDTqUEr0j2oEa3Pxe+wV6GnshpI2aMffThKxYyQmT4c1Pg/ugqjN9wyG1U+wDNjfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=electrifex.com;
	spf=pass smtp.mailfrom=electrifex.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=3.110.59.161
Received: from repost.tmes-in.trendmicro.com (repost.tmes-in.trendmicro.com [3.110.59.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2B606A686
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A2B606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electrifex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electrifex.com
Received: from 52.101.225.101_.trendmicro.com (unknown [172.26.46.176])
	by repost.tmes-in.trendmicro.com (Postfix) with SMTP id 8FC8FC0524C8;
	Wed, 25 Nov 2026 06:17:53 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1795587465.439000
X-TM-MAIL-UUID: 40a6d174-c2d3-4388-aa68-22de808a05d8
Received: from PNYPR01CU001.outbound.protection.outlook.com (unknown [52.101.225.101])
	by repre.tmes-in.trendmicro.com (Trend Micro Email Security) with ESMTPS id 6B793C00042C;
	Wed, 25 Nov 2026 06:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdHrEJD/oyAaSwBGrMu9WXcVk0TdjmtHbY1uvffsgjO/aAWxW6jaSTKsau7O5TWW5NauzXoG7+FMx2Cokvh+5rcsh7qb6/rlY6ZtK79LHezqDrM7HkGMS9upidlsHKo9Et9WPuUgNDMsh511I00XQ3EkEw0aOZ13iQ8uNiCjr0F8su9uxrXS+qE3JjagiU4iGRTE1U8rX+rHKbQ2jsO2ug/aVV+2+QG4z8VLYJYn7PVJqwX60XTZQRiH3cj6A0JiqpTMh8GnfrKoOmmm5IAezHipi+bP2WIQEtvnMlJTP7408dOvNLiHVQOs/ftqu0OoT+6sftJMdljNGQOuvOADzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPrIsOc+gFcEnDri/MDwIDfZHoZXiC74y2N7+kfioM4=;
 b=O0K9t6xQwD1mCSLBuwHnB5Q4dl6kgAA8kVqAWeGrkgMEo76BAACLPg9goMTqIR8hXONoxX5joOcy91f23whVrLMZII5l8CqOTYlrhppSarYR9voA6QeTkCQ2eOOC32b/x9bCar/zn7Ym9oGoobCvIMuA7LLhix7JcKKl8z9oRH+LL38NNH22i+OLSuSGHKZ17sJs5QJZ5pC2wd7GotOmJ3W7kbSO9P+56gXtQ9LOLOtAPUKUfMuH2HND0AIwF2jKtjp+k+haNELLaPhcyoD6K/ae/7xzPS5hFPZV87FAURGQiZ+uapHluTwxYjBVuI7DqlINUT2AF7WXFee6obsk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=electrifex.com; dmarc=pass action=none
 header.from=electrifex.com; dkim=pass header.d=electrifex.com; arc=none
Received: from MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:cc::6)
 by MA5PR01MB13288.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 06:17:43 +0000
Received: from MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c284:c893:95b6:d2a3]) by MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c284:c893:95b6:d2a3%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 06:17:43 +0000
From: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
To: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Sam Edwards
	<cfsworks@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>, David Wu
	<david.wu@rock-chips.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH net v2] net: stmmac: retry a failed RX refill from a timer
Thread-Topic: [PATCH net v2] net: stmmac: retry a failed RX refill from a
 timer
Thread-Index: AQHdfKJ+7OmjwsPFEU+KVxDP/L4YsQ==
Date: Wed, 25 Nov 2026 06:17:43 +0000
Message-ID:
 <MA0PR01MB92174ED1110DC61766D591C4FD432@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=electrifex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB9217:EE_|MA5PR01MB13288:EE_
x-ms-office365-filtering-correlation-id: 94edb447-d1a7-46c9-c544-08df4abbd0c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|10067099003|5023799004|261028144727099003|56012099006|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261021135927099003|261026121527099003|261102123227099003|261026140227099003|261009223027099003|6133799003|18002099003;
x-microsoft-antispam-message-info:
 l5wEusiX4F7m7VHnLOFagR/IUZbWOwO+LBF0ZZH9DjoHVCrKEN7+KU5O+iG3SKIvmyHRNXY41cb7PMTbTSa1muff4mzzNVaJEbjRVIiiQ+u0nMb8h7hmpQMxyl3ojHyx8F1vxMDOwjCCR0pbDKz0F9x+3M2XW7eHGfGqSE/+HP3Pf22Xef6GQJqJV9euU8N268dHPsKSDJ46ywNThzAIkj0yTaIpe3Gyp9S6gzzyxIvZz12FwCOx2UASz7EBGXwt69gBC0OltjB6OVk/fMzMp0PfF1EQoYKSjCgiQN9/1ZfA0APQxYcfejsoyZIKkUEkhN/2W9nx+lxZcNWZNwVstyQTfCvmZgMFVH28SHg/hT1mz5RXt7pzMnI86GrW3NfKdlS/nVaXMo4Zgu6j8R8GTWAQ56kgL8gDqTia20UTRTIsICFpZVm9Kk6GsYB192vcbNnciBbLfSTec3spZ4UyzCoowRviEDMJDjP4bpp+D/hwnE8J+II2TrlRdS5ff6ysH/KSkI8bBGPOd0hEwLc2/OAcpjE1ldIvibuootEatCkZ7rsl+7zpkGP3UhAo2YB6AAuSQQfaFpDCoIBbJVXPU5/PFF1eRGbBBvTcMn/Xfck58CITSY3j8KUKmqqgueoaS0t8O93u8wvJkd3o9noPIm0ESs4prhLxAtpz8+zfT/k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(10067099003)(5023799004)(261028144727099003)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021135927099003)(261026121527099003)(261102123227099003)(261026140227099003)(261009223027099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rbIwLmprVZte0o1QuIi3Z0rC4PUN52e4/8RPDLay+uFzJTq3iMzf3ptLtS?=
 =?iso-8859-1?Q?syEcEivdki2HyMVzG/zIok8l6M+jo9csHqENzKXL6eglvSe4nmc2+Btm9Q?=
 =?iso-8859-1?Q?xp+Xk0Eye20x/qVKxjpS2FaZBIw2txCySm6xjsTlnhGu7DibJLsL/++4eE?=
 =?iso-8859-1?Q?Th9M+ALldRR/QGW1AszJ+Ii5v0V53t13R9yDkAS9Dsy9/PpXiojgsBTqUT?=
 =?iso-8859-1?Q?s/s2FQ5VYTFuYsH8NeT4jUMybZgfoUtL77Qx6XOYCSyBiBie4AE6vJuv4W?=
 =?iso-8859-1?Q?XINaYYIw4Bnb/5DXvvl/WifSXtiTiPLS1+M0yteUbzn8I050lQH7DGGV93?=
 =?iso-8859-1?Q?ud0HbV6Cygpl0uRSIBpdzd+OdDI1ojT8OTEzXiRuMy33GKkcbR0/eWTYA4?=
 =?iso-8859-1?Q?xu76MpM+97zHcHi4MKD6uPv6YoOhE02Yw4i2eQ8TlaitvwBIkedAzm4Zyu?=
 =?iso-8859-1?Q?Vaa3szJC5rhNnauQXajX1jRMpZRFtkMHsvscLYG/MLMNGJ/fN+j95JNHHu?=
 =?iso-8859-1?Q?svlr1T/L2PLlQOnxZHOe1Ft2xdsOSTQuQ9pApxH/6OLaAwSMIClJjPWoTn?=
 =?iso-8859-1?Q?twYufWeZbKPFqSd7ZGcjQdY+lW6LdXYea3U+OVXR10Ye0r9RnafSPSCBLd?=
 =?iso-8859-1?Q?gJUcjSCj7rZ9BG+MU7hs2NdmocMHKY3T3FVxkmWPDZLnfzUG4nY6sCN0if?=
 =?iso-8859-1?Q?sEP6iL3RMY8ESHSwSQBhJ9Qa47KtXbnCQAGzCK4aEGG150K4g1c6IbPjJQ?=
 =?iso-8859-1?Q?0xC3wseK83dj/PYUzN+zuKSylhN4r09qPnelNHYAqVuhO17FUYN7sX7upj?=
 =?iso-8859-1?Q?Mn3mn0cz5L43VXqxRb8L6jOBFY2nBDEU+Y7SOsQHuhjsXftlA2aGos6x20?=
 =?iso-8859-1?Q?5hnqZ5iW+2qXaOGGmaHbY7FTOCnKXBOk+BbWLYuDpzqCMkb3xyPExutxTE?=
 =?iso-8859-1?Q?uCPeILQcVNxfLgxln55kFMi/KrX1JAxt542l63EV9irsTP6FBnWX1sOb6R?=
 =?iso-8859-1?Q?F2oaep3KpZRbf+oa9/4v51ljblTgmIwrKEAMDSoPYXGt5wl909Ly/YrQrc?=
 =?iso-8859-1?Q?OhN8NmceG3jluterXh5G3UJaeqn7zPR3zDDBRFbLf9cVyrbtk7H+GS+a1v?=
 =?iso-8859-1?Q?6WSZtlts3FYlOFPRioDdqlcc9fQiiCnt8ZGBD5QwN9GyjpkPDo5zXnuv/l?=
 =?iso-8859-1?Q?bIX5+LTxpuAAuORTNNq+N6tjk6OWlflJvit7Mx63i7+pBe7gugAY+yIjLW?=
 =?iso-8859-1?Q?a3FZI11OvQiRvu6W12cBvyFnDtgopotO0RVgBNW+ydpa6/FbPLQOi1vQa6?=
 =?iso-8859-1?Q?feE9NE1+qAXYLI85QR+tU2cWGGpEEGIlMCSamLENVrNpGYK58kYvLrcBxM?=
 =?iso-8859-1?Q?BTRMnkC3EqjImKraKcxKd5IvPs4uhA9QWNejgBmeEunbN7hI9WJiZk7NYF?=
 =?iso-8859-1?Q?qbeqk6j0fRmgU2u2fA/6iTsQLWxH1lgIcPlXSZUaJRSCwH1yJynp9TIATL?=
 =?iso-8859-1?Q?Dlk84RMQNFKDgroEj6ZKliyJPosMxpPLhxhapMwHJSw1UsfM9Br57vd4l1?=
 =?iso-8859-1?Q?0X2gnV2cUtCRpUX3xvhDFPeyBwemwnmLLcPNvpllUFkZ20+OEAksMZbrfI?=
 =?iso-8859-1?Q?cIw4EEYak0hpPE/pTG1FOfurAqjIpP/DqqOxvmHCc11Qjv+/p6UlQPVFR8?=
 =?iso-8859-1?Q?lMG1shcBAxdhtdtbtkBeJwUUz5xEqsIyBajiWxli/G4KjV9R/IVSgKv0qG?=
 =?iso-8859-1?Q?BBmcw1g4hjYsUWTIh3YB1yc58GdOzl3Fh3Sb+RdzBziQgnJbX2jpr1ZHZn?=
 =?iso-8859-1?Q?3oZDDIths1FF4JZWc++Ni0pXsXIwvO4=3D?=
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
	Yv5IDGsa1nw/eqcx0uvndBUGK7A8cCZkJx7vLF++5DXEhItzSxHRfGacQUQ69AvWA0ueLnOr5ZIb0dC093vfMdWxGijuFOstiWHP3cvmu+TIGd6aV5UKBx2ZptqjrSiD9c6X81qB9WUfie0NZNAvT8CTgusr1+uegCBDE23uQq7hEH1hf+GfmavnB58nu6OmPHyNBgDqbuQX4o1O8AuaZ1B7F1vFzT+mMQaLCcXNqwgl/V5MGox5oZdEC7e5OxTb+Cor2uaqTw773vbzarMHx5q4HbqziQKpe85O2F+Qvdn4J0wS5gJpPlhktv9hEXp3YiUNN3x7Wcu6RqYGycnVRQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vWDQdVtA8pOdazqsKEkTw3RKvnfd8zawjIpEW0b2vp5qbNFiHnnnVokG8rEPzTVBZ4bO6GsEA3JJ1bvyPv9TasYN0ITSRqyi/5TVZUqy6T3Ir0085TKCxAec7CaWnBWWVSZ26vj3zcJpRyFMfIkM/svBZrZuPwTWmz2+4SoZ8CpDot4PqPTZ3s2XT8TXAQnLSMrmL1QWYn9EmsUIPkNXvK927R73cDkSfSqbKNchSgEegDj9HrzWR3cvOOmILNmPVjWc6ETz9uzMYmeJ6IZ+LGXa84cI8+T2PFLybC4qtu5GWWfzNPypp0F83JVS8LYw/XtbSoueG5svKV4dD/PqJC5EH3j9ZsrkOYt7ue3kCA1ayMoBSbvMJm+Q2bOeGNixxk3r/gU669Uhg25KkK2rN2XmkKZfnDhoYoz4+tmrkROUKYx4Tz+iU8lUpPSLCMwYt5VvDIuAWHTAiQD6slICjkDatvwRuTkS4Lwaz5X+KXxEpxCqxMd2rOZVSZoQYhHfrCTeMUv+w7dElOiyAx/wjz0EnhWeJFdpQpqzMJmGC056aXiezgzs2Fe97Lr99xUR0R3YV9YSLG7tT1l+IPTg2pa5J3zn0FLsFKbShmzfrAA=
X-OriginatorOrg: electrifex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94edb447-d1a7-46c9-c544-08df4abbd0c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 06:17:43.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f2626450-e675-4872-bae6-db17376f7643
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3sAreNt9Y1YcjepuJhjv+6DHId75EMQiNYZjd7ByAkwZ/U2noHPfmpO0xs4/ibZA4qbveMP2SHUd32N5pQbk6BaFE2fhOGA0FuhNCcbboXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB13288
X-TM-AS-ERS: 52.101.225.101-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30342.005
X-TMASE-Result: 10--18.162300-7.000000
X-TMASE-MatchedRID: xSYXmpJMo8ucSGy4JgO+Ta39Nxr6In/3OteHVGUMZ+CAPedCSeScsjas
	lHciyNgLP+a17NVAlr/hlAobdbKjfSQQMtD1IXx1O3Y9BE9+f5Fi/Vat3E2go1SAWjKAu3w74Dg
	iKWJARSSFuFRWapqaEtyvdUTaWVvuEWPbvrK/8x30k0bHb1p9aEGoVfTbC+0P510322JqPPF09D
	YlOJop4ov2Qg8/NBVwpkn+Y5XQlk6DLSJhT1lBn8m2jIZUTQ3wigI0Jr+Avdt0597mFZruiCGFm
	jICAp5pCSm+iGJlQOsS3QSiiPGPhO5pF8IH54mMprktoeU+bT5vDkVqf46rCtUCHy/carEB5hu8
	JitLLWbSwYxu9Jr2ammCgxcolOMaZlSh/5nPzWM5z9yWarHTmgf8yw0JGfKVIUsEgk1V7Rtxjp8
	wj+99DDLDZHNdmm5OshOq4hBLO7KesxAbmcIyy6wODSO9Fuc1aAci2ueFmzWdKFoQ4rSoy6p9sZ
	zOBcjQQpP6/vBOuJPaQba/UYeeYMeYpzz6yNBUUlO0zoIcpU7n0oaU6WM+++WiyEpibEMl9fq6i
	Aepnjz/Ixc91Je9nEzVylMQOY519uurgqQLhKg2eDSq/07MxysZXvcCxTRnEUDfQl1A2lwImtbJ
	i8lrwwnQpwEhCL22mPkHSADh7KWeZkyheEy2raniWcyxO9yFUjOqjUXzJBJiWXoT/A/ILzZRzQo
	zH1aRJiVstKzyEg1eUf88e6zaYOi1lkUvOtVfawJUqbmGPB2fxxR9IcjAIBIIN3MAx5f9m0KxFD
	y1pQ7fOKrVli6MFdhiRHs224+Holi4ZoiOHT8g4pZYxslhbbNkeEYGbJYuA/3R8k/14e0=
X-TMASE-XGENCLOUD: 5fd55ab7-0123-4317-bd9c-4e9a7af0eaad-0-0-200-0
X-TM-Addin-Auth: hATZ+/xLwNo57S77WgU3j65SF2aWtlq9EQjlzINZ5r7m+CCSR3nbreI5mcN
	a6TWt4mioo58UnDCBEflkOB6efRMzr2Xcl1c1UH+JACP5DfmnsY7PhmjwduvuKsgZv8+Z1XZdV3
	jBGU5rjnazdEAgT6glBN3I2yIEziY8ZLS5bHtnpVaaRomcnfSOk2Xlii8nP6ST44DtlN3FZpOfe
	uiOpjmhZIJuN/aeaaYDjYKtjc8c8iGxP6ZjflX8DgFJfTtF8HaJJb93DgIRf3hbVhhgMo8X+4q6
	dcE+b33Z5qry2aw1Sn6mIHZlnkvYqeVcJeX/6nbS7vM2PQHjjQSDfwcw7g==.mM8Xn0tVuQ9C8z
	jglywElabRxtRuTAGHxKzBzjXo66fYrSL841tCpgAHTV3jhIHW0PlTjrkN+LPj6HDUDS2oVhMoH
	VRD4DRQRsYjzOBkXZ4xVr/CWyTA0Iem0a6EGeitpbYdDlOFdR9UwkeV1X2uez58qC+RzI7a4FQP
	DHfgTYo2XFFBlDzbkViMwKpGb1Xslx0a8RFevfhZhhUvYaUvKkFm6pxWXwDnNynFZNR3IkK5AW+
	Uyz0+nvuP+QZtyaaMUX5fwI2tF+RZH78dgRW6/UcscnQRALiALK2/DhIl751atERYBa3mT7u6pV
	oqw/dkpt1fS04WyfOx7OfQYCIVZQ==
X-TM-Addin-ProductCode: EMS
X-TM-Deliver-Signature: 8D66D041EF1AF522E670C321CA938E85

stmmac_rx_refill() stops at the first page_pool allocation failure. The=0A=
refill is retried only from the next RX NAPI poll, and only an RX=0A=
interrupt schedules that poll. Once the DMA has used the buffers it=0A=
still had, it suspends, no RX interrupt comes, and receive can stay dead=0A=
even after memory is available again, until the interface is reopened.=0A=
Commit 0bb05e6adfa9 ("net: stmmac: Prevent NULL deref when RX memory=0A=
exhausted") describes this stall and leaves it for a later change.=0A=
=0A=
When at most STMMAC_RX_REFILL_THRESH (16) slots are left with the DMA=0A=
after a poll, arm a per-channel timer that schedules the RX NAPI about=0A=
10 ms later. The poll retries the refill and re-arms the timer while=0A=
allocations keep failing, so NAPI does not keep polling while memory is=0A=
short. This follows the review of an earlier attempt (see Links). The=0A=
retry does not rely on the Receive Buffer Unavailable (RBU) interrupt,=0A=
which is not enabled on every core and kernel version.=0A=
=0A=
The timer lives in struct stmmac_channel, because __stmmac_open()=0A=
replaces priv->dma_conf. It is cancelled after rx_napi is disabled, and=0A=
stmmac_enable_all_queues() re-arms it, because=0A=
stmmac_setup_tc_block_cb() disables and re-enables the queues without=0A=
re-initialising the rings.=0A=
=0A=
Since commit b6cb4541853c ("net: stmmac: avoid rx queue overrun"),=0A=
stmmac_rx() leaves the descriptor before dirty_rx to a later poll, and=0A=
the NULL deref fix named above keeps that rule. When a poll stops there=0A=
and its refill then gives the DMA enough buffers again, return the full=0A=
budget, so that NAPI polls again and receives a frame waiting in that=0A=
descriptor instead of waiting for an RX interrupt that already fired. A=0A=
poll can also stop there without an allocation failure, when it uses up=0A=
a small ring. Check for that descriptor before reading its status, so=0A=
that the retries do not count the same status again.=0A=
=0A=
Found while debugging a separate AF_XDP zero-copy RX stall, with the=0A=
help of an AI code review agent. Reproduced on an ADI ADSP-SC598=0A=
(dwmac 5.20) with a kernel based on ADI's 6.18.31, using error=0A=
injection: page_pool_alloc_netmems() was made to return NULL on every=0A=
call through fail_function (retval 0, probability 100, times -1) for 3 s=0A=
while receiving about 4000 frames/s. With the RBU interrupt disabled=0A=
(the dwmac4 default in 6.18), receive stayed dead in 6 of 6 runs until=0A=
ethtool -G.=0A=
=0A=
Tested on the same board with the fix backported: receive came back by=0A=
itself in every run of the reproducer, with the RBU interrupt off and=0A=
on. When exactly one ring's worth of frames arrived while every=0A=
allocation failed, and then no more, the last frame was received in 20=0A=
of 20 runs (23-63 ms after the failures stopped, where timed). Without=0A=
the full-budget return, it waited in the ring for the next frame in 20=0A=
of 20. Only build-tested on mainline. Other DMA cores were not tested.=0A=
Kernel selftests were not run.=0A=
=0A=
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet cont=
rollers.")=0A=
Cc: stable@vger.kernel.org=0A=
Link: https://lore.kernel.org/netdev/20260331195927.3353cc6d@kernel.org/=0A=
Link: https://lore.kernel.org/netdev/20260402174049.0ac088cc@kernel.org/=0A=
Signed-off-by: Anandu Padinhare <Anandu.Padinhare@electrifex.com>=0A=
---=0A=
Changes in v2:=0A=
- Return the full budget from stmmac_rx() when it stopped at dirty_rx=0A=
  and the refill then gave the DMA enough buffers again, so the waiting=0A=
  frame is received without another interrupt (Nicolai, Sam).=0A=
- Check dirty_rx before reading the descriptor status, so retries do=0A=
  not count it again (Sashiko). 0bb05e6adfa9's condition and break are=0A=
  kept.=0A=
- Reword the comment above stmmac_rx_refill_needed(): dwmac4 does raise=0A=
  RBU but only counts it, so no interrupt schedules RX NAPI when the DMA=0A=
  suspends (Sashiko).=0A=
- Link to v1: https://lore.kernel.org/netdev/MA0PR01MB921746F36D90C7080287A=
CC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM/=0A=
=0A=
Testing (6.18 backport, debug kernel): TCP throughput with 64 and 512=0A=
entry rings shows no difference from v1 beyond the run-to-run=0A=
variation, and ethtool -t gives the same result as v1 for every test.=0A=
Ring 64, 10 s of TCP RX: v1 returned 63, the most a poll can take from=0A=
a 64-entry ring, in 400 of 848 polls. v2 returned the full budget in=0A=
400 of 851 polls instead. The changelog's 23-63 ms is the time from the=0A=
end of the failures until the frame left in the ring was received.=0A=
v1's test suite (see the v1 notes) was rerun with v2, with no new=0A=
failures.=0A=
=0A=
Not changed: Sashiko's two pre-existing items on v1, resume after a=0A=
failed refill, and stmmac_setup_tc_block_cb() leaving the RX interrupt=0A=
masked when it disables NAPI right after a full-budget poll. The=0A=
full-budget return makes the latter reachable in more cases, for=0A=
example with rings of 64 entries or fewer. A separate fix will follow=0A=
(schedule rx_napi after napi_enable() there).=0A=
=0A=
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +=0A=
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 72 +++++++++++++++++--=0A=
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.c  |  1 +=0A=
 3 files changed, 68 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/eth=
ernet/stmicro/stmmac/stmmac.h=0A=
index b76acfe0d958..88b83dc3cf0f 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h=0A=
@@ -142,6 +142,7 @@ struct stmmac_channel {=0A=
 	struct napi_struct rx_napi ____cacheline_aligned_in_smp;=0A=
 	struct napi_struct tx_napi ____cacheline_aligned_in_smp;=0A=
 	struct napi_struct rxtx_napi ____cacheline_aligned_in_smp;=0A=
+	struct timer_list rx_refill_timer;=0A=
 	struct stmmac_priv *priv_data;=0A=
 	spinlock_t lock;=0A=
 	u32 index;=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c=0A=
index a685ce4638f6..bd0badb90bc8 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c=0A=
@@ -86,6 +86,8 @@ MODULE_PARM_DESC(phyaddr, "Physical device address");=0A=
 #define STMMAC_XSK_TX_BUDGET_MAX	256=0A=
 #define STMMAC_TX_XSK_AVAIL		16=0A=
 #define STMMAC_RX_FILL_BATCH		16=0A=
+#define STMMAC_RX_REFILL_THRESH		16=0A=
+#define STMMAC_RX_REFILL_RETRY_MS	10=0A=
 =0A=
 #define STMMAC_XDP_PASS		0=0A=
 #define STMMAC_XDP_CONSUMED	BIT(0)=0A=
@@ -263,6 +265,33 @@ static void stmmac_verify_args(void)=0A=
 		pr_warn("stmmac: module parameter 'flow_ctrl' is obsolete - please remov=
e from your module configuration\n");=0A=
 }=0A=
 =0A=
+/* The RX DMA suspends once it has used all its buffers, and no interrupt=
=0A=
+ * schedules RX NAPI when that happens, so a refill that failed for lack o=
f=0A=
+ * memory would never be retried. Retry it from a timer when few slots are=
 left=0A=
+ * with the DMA.=0A=
+ */=0A=
+static bool stmmac_rx_refill_needed(struct stmmac_priv *priv, u32 queue)=
=0A=
+{=0A=
+	struct stmmac_rx_queue *rx_q =3D &priv->dma_conf.rx_queue[queue];=0A=
+=0A=
+	return CIRC_SPACE(rx_q->cur_rx, rx_q->dirty_rx,=0A=
+			  priv->dma_conf.dma_rx_size) < STMMAC_RX_REFILL_THRESH;=0A=
+}=0A=
+=0A=
+static void stmmac_rx_refill_timer_arm(struct stmmac_channel *ch)=0A=
+{=0A=
+	if (!timer_pending(&ch->rx_refill_timer))=0A=
+		mod_timer(&ch->rx_refill_timer,=0A=
+			  jiffies + msecs_to_jiffies(STMMAC_RX_REFILL_RETRY_MS));=0A=
+}=0A=
+=0A=
+static void stmmac_rx_refill_timer(struct timer_list *t)=0A=
+{=0A=
+	struct stmmac_channel *ch =3D timer_container_of(ch, t, rx_refill_timer);=
=0A=
+=0A=
+	napi_schedule(&ch->rx_napi);=0A=
+}=0A=
+=0A=
 static void __stmmac_disable_all_queues(struct stmmac_priv *priv)=0A=
 {=0A=
 	u8 rx_queues_cnt =3D priv->plat->rx_queues_to_use;=0A=
@@ -284,6 +313,10 @@ static void __stmmac_disable_all_queues(struct stmmac_=
priv *priv)=0A=
 		if (queue < tx_queues_cnt)=0A=
 			napi_disable(&ch->tx_napi);=0A=
 	}=0A=
+=0A=
+	/* With NAPI disabled no poll can re-arm the refill timers */=0A=
+	for (queue =3D 0; queue < rx_queues_cnt; queue++)=0A=
+		timer_delete_sync(&priv->channel[queue].rx_refill_timer);=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -328,8 +361,17 @@ static void stmmac_enable_all_queues(struct stmmac_pri=
v *priv)=0A=
 			continue;=0A=
 		}=0A=
 =0A=
-		if (queue < rx_queues_cnt)=0A=
+		if (queue < rx_queues_cnt) {=0A=
+			/* Disabling the queues cancelled any pending refill=0A=
+			 * retry, but the ring may have been kept as it was.=0A=
+			 * Check it while no poll can run.=0A=
+			 */=0A=
+			bool refill =3D stmmac_rx_refill_needed(priv, queue);=0A=
+=0A=
 			napi_enable(&ch->rx_napi);=0A=
+			if (refill)=0A=
+				stmmac_rx_refill_timer_arm(ch);=0A=
+		}=0A=
 		if (queue < tx_queues_cnt)=0A=
 			napi_enable(&ch->tx_napi);=0A=
 	}=0A=
@@ -5877,6 +5919,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int li=
mit, u32 queue)=0A=
 	struct sk_buff *skb =3D NULL;=0A=
 	struct stmmac_xdp_buff ctx;=0A=
 	bool fcs_stripped =3D false;=0A=
+	bool at_dirty =3D false;=0A=
 	int xdp_status =3D 0;=0A=
 	int bufsz;=0A=
 =0A=
@@ -5925,17 +5968,23 @@ static int stmmac_rx(struct stmmac_priv *priv, int =
limit, u32 queue)=0A=
 =0A=
 		p =3D stmmac_get_rx_desc(priv, rx_q, entry);=0A=
 =0A=
+		/* The descriptor before dirty_rx is only processed once the=0A=
+		 * refill has moved dirty_rx on. Check this before reading the=0A=
+		 * status, so that a retry does not count the frame again.=0A=
+		 */=0A=
+		next_entry =3D STMMAC_NEXT_ENTRY(rx_q->cur_rx,=0A=
+					       priv->dma_conf.dma_rx_size);=0A=
+		if (unlikely(next_entry =3D=3D rx_q->dirty_rx)) {=0A=
+			at_dirty =3D true;=0A=
+			break;=0A=
+		}=0A=
+=0A=
 		/* read the status of the incoming frame */=0A=
 		status =3D stmmac_rx_status(priv, &priv->xstats, p);=0A=
 		/* check if managed by the DMA otherwise go ahead */=0A=
 		if (unlikely(status & dma_own))=0A=
 			break;=0A=
 =0A=
-		next_entry =3D STMMAC_NEXT_ENTRY(rx_q->cur_rx,=0A=
-					       priv->dma_conf.dma_rx_size);=0A=
-		if (unlikely(next_entry =3D=3D rx_q->dirty_rx))=0A=
-			break;=0A=
-=0A=
 		rx_q->cur_rx =3D next_entry;=0A=
 =0A=
 		np =3D stmmac_get_rx_desc(priv, rx_q, next_entry);=0A=
@@ -6146,6 +6195,13 @@ static int stmmac_rx(struct stmmac_priv *priv, int l=
imit, u32 queue)=0A=
 	priv->xstats.rx_dropped +=3D rx_dropped;=0A=
 	priv->xstats.rx_errors +=3D rx_errors;=0A=
 =0A=
+	/* A frame may be waiting in the descriptor we stopped at. If the=0A=
+	 * refill freed it, poll again rather than wait for an interrupt=0A=
+	 * that already fired. If not, the refill timer polls again.=0A=
+	 */=0A=
+	if (unlikely(at_dirty) && !stmmac_rx_refill_needed(priv, queue))=0A=
+		return limit;=0A=
+=0A=
 	return count;=0A=
 }=0A=
 =0A=
@@ -6164,6 +6220,8 @@ static int stmmac_napi_poll_rx(struct napi_struct *na=
pi, int budget)=0A=
 	u64_stats_update_end(&rxq_stats->napi_syncp);=0A=
 =0A=
 	work_done =3D stmmac_rx(priv, budget, chan);=0A=
+	if (unlikely(stmmac_rx_refill_needed(priv, chan)))=0A=
+		stmmac_rx_refill_timer_arm(ch);=0A=
 	if (work_done < budget && napi_complete_done(napi, work_done)) {=0A=
 		unsigned long flags;=0A=
 =0A=
@@ -7779,6 +7837,8 @@ static void stmmac_napi_add(struct net_device *dev)=
=0A=
 =0A=
 		if (queue < priv->plat->rx_queues_to_use) {=0A=
 			netif_napi_add(dev, &ch->rx_napi, stmmac_napi_poll_rx);=0A=
+			timer_setup(&ch->rx_refill_timer,=0A=
+				    stmmac_rx_refill_timer, 0);=0A=
 		}=0A=
 		if (queue < priv->plat->tx_queues_to_use) {=0A=
 			netif_napi_add_tx(dev, &ch->tx_napi,=0A=
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net=
/ethernet/stmicro/stmmac/stmmac_xdp.c=0A=
index 9af9e0cb366c..c3e85ee1067c 100644=0A=
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c=0A=
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c=0A=
@@ -35,6 +35,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *pri=
v,=0A=
 =0A=
 	if (need_update) {=0A=
 		napi_disable(&ch->rx_napi);=0A=
+		timer_delete_sync(&ch->rx_refill_timer);=0A=
 		napi_disable(&ch->tx_napi);=0A=
 		stmmac_disable_rx_queue(priv, queue);=0A=
 		stmmac_disable_tx_queue(priv, queue);=0A=
=0A=
base-commit: cc7fe6e741730fef549e484379281736d32746f0=
